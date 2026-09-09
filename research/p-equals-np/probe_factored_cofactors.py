"""Bounded exact syntactic cofactor experiment; standard library only."""
import argparse
from collections import Counter
from functools import cmp_to_key
from itertools import product
import json
from pathlib import Path


class Dag:
    def __init__(self, mode):
        self.mode = mode
        self.nodes = [('const', 0), ('const', 1)]
        self.ids = {v: i for i, v in enumerate(self.nodes)}
        self.count = Counter()

    def intern(self, key):
        self.count['intern_lookups'] += 1
        if key[0] in ('and', 'or'):
            self.count['intern_key_edges'] += len(key[1])
        if key not in self.ids:
            self.ids[key] = len(self.nodes)
            self.nodes.append(key)
            if key[0] in ('and', 'or'):
                self.count['allocated_edges'] += len(key[1])
        return self.ids[key]

    def lit(self, signed):
        return self.intern(('lit', signed))

    def sorted_ids(self, values):
        def compare(a, b):
            self.count['sort_comparisons'] += 1
            return (a > b) - (a < b)
        return sorted(values, key=cmp_to_key(compare))

    def op(self, kind, children):
        self.count['constructor_calls'] += 1
        identity, absorbing = (1, 0) if kind == 'and' else (0, 1)
        items = []
        for child in children:
            self.count['normalization_child_visits'] += 1
            if child == absorbing:
                return absorbing
            if child == identity:
                continue
            if self.mode == 'factor' and self.nodes[child][0] == kind:
                items.extend(self.nodes[child][1])
                self.count['normalization_child_visits'] += len(self.nodes[child][1])
            else:
                items.append(child)
        if self.mode == 'factor':
            self.count['dedup_entries'] += len(items)
            items = list(set(items))
            signs = set()
            for child in items:
                self.count['complement_scans'] += 1
                tag, value = self.nodes[child]
                if tag == 'lit':
                    if -value in signs:
                        return absorbing
                    signs.add(value)
            items = self.sorted_ids(items)
        if not items:
            return identity
        if len(items) == 1:
            return items[0]
        if self.mode == 'factor' and kind == 'or':
            factors = []
            for child in items:
                tag, value = self.nodes[child]
                row = set(value) if tag == 'and' else {child}
                self.count['factor_entries'] += len(row)
                factors.append(row)
            common = set(factors[0])
            for row in factors[1:]:
                self.count['intersection_entries'] += len(common) + len(row)
                common.intersection_update(row)
            if common:
                self.count['factor_rewrites'] += 1
                self.count['difference_input_entries'] += sum(len(row) + len(common) for row in factors)
                tails = [self.op('and', self.sorted_ids(row - common)) for row in factors]
                return self.op('and', self.sorted_ids(common) + [self.op('or', tails)])
        return self.intern((kind, tuple(items)))

    def cofactor(self, root, var, bit):
        cache = {}
        def visit(node):
            self.count['cofactor_calls'] += 1
            if node in cache:
                self.count['cofactor_cache_hits'] += 1
                return cache[node]
            tag, value = self.nodes[node]
            self.count['cofactor_unique_visits'] += 1
            if tag == 'const':
                result = node
            elif tag == 'lit':
                result = int(bit == (value > 0)) if abs(value) == var else node
            else:
                self.count['cofactor_edges'] += len(value)
                result = self.op(tag, [visit(child) for child in value])
            cache[node] = result
            return result
        return visit(root)

    def evaluate(self, root, assignment, count_work=False):
        cache = {}
        def visit(node):
            if count_work:
                self.count['witness_eval_calls'] += 1
            if node not in cache:
                tag, value = self.nodes[node]
                if count_work:
                    self.count['witness_eval_unique_visits'] += 1
                if tag == 'const':
                    result = bool(value)
                elif tag == 'lit':
                    result = assignment[abs(value)] == (value > 0)
                else:
                    if count_work:
                        self.count['witness_eval_edges'] += len(value)
                    values = [visit(c) for c in value]
                    result = all(values) if tag == 'and' else any(values)
                cache[node] = result
            return cache[node]
        return visit(root)

    def reachable(self, roots):
        seen, stack, edges = set(), list(roots), 0
        while stack:
            node = stack.pop()
            if node in seen:
                continue
            seen.add(node)
            tag, value = self.nodes[node]
            if tag in ('and', 'or'):
                edges += len(value)
                stack.extend(value)
        return {'nodes': len(seen), 'edges': edges}


def cnf_value(clauses, assignment):
    return all(any(assignment[abs(lit)] == (lit > 0) for lit in clause)
               for clause in clauses)


def assignments(variables):
    for bits in product((False, True), repeat=len(variables)):
        yield dict(zip(variables, bits))


def run_case(clauses, order, mode, verify=False, boundary=None):
    d = Dag(mode)
    root = d.op('and', [d.op('or', [d.lit(lit) for lit in c]) for c in clauses])
    history, checks, snapshot = [], 0, None
    for stage in range(len(order) + 1):
        if verify:
            for remaining in assignments(order[stage:]):
                expected = any(cnf_value(clauses, remaining | old)
                               for old in assignments(order[:stage]))
                assert d.evaluate(root, remaining) == expected, (mode, stage, remaining)
                checks += 1
        if stage == boundary:
            snapshot = {'root_is_true': root == 1, 'reachable': d.reachable([root]),
                        'allocated_nodes': len(d.nodes), 'counts': dict(d.count)}
        if stage == len(order):
            break
        var = order[stage]
        zero, one = d.cofactor(root, var, False), d.cofactor(root, var, True)
        history.append((var, zero, one))
        root = d.op('or', [zero, one])
    assert root in (0, 1)
    witness = None
    if root == 1:
        witness = {}
        for var, zero, one in reversed(history):
            bit = not d.evaluate(zero, witness, count_work=True)
            assert d.evaluate(one if bit else zero, witness, count_work=True)
            witness[var] = bit
        assert cnf_value(clauses, witness)
    return {'mode': mode, 'sat': root == 1, 'semantic_checks': checks,
            'boundary': snapshot, 'allocated_nodes': len(d.nodes),
            'counts': dict(d.count), 'final_reachable': d.reachable([root]),
            'history_reachable': d.reachable([root] + [r for _, a, b in history for r in (a, b)]),
            'stored_cofactor_roots': 2 * len(history), 'witness_verified': witness is not None}


def equality(m):
    return [c for i in range(1, m + 1) for c in ((-i, m+i), (i, -m-i))]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', required=True)
    args = parser.parse_args()
    cases = [([], []), ([[]], []), ([(1,), (-1,)], [1]),
             ([(1, -1, 1), (2, 2)], [2, 1]),
             ([(1, 2, -3), (-1, 3), (-2, -3)], [3, 1, 2]),
             ([tuple(i if bit else -i for i, bit in enumerate(bits, 1))
               for bits in product((False, True), repeat=3)], [1, 3, 2])]
    cases += [(equality(m), list(range(1, 2*m+1))) for m in range(1, 4)]
    semantic = [run_case(c, order, mode, True) for c, order in cases
                for mode in ('plain', 'factor')]
    benchmarks = [{'m': m, **run_case(equality(m), list(range(1, 2*m+1)), mode,
                                     boundary=m)}
                  for m in (1, 2, 4, 6, 8, 10) for mode in ('plain', 'factor')]
    result = {'semantic_cases': len(semantic),
              'semantic_checks': sum(r['semantic_checks'] for r in semantic),
              'semantic_sat_cases': sum(r['sat'] for r in semantic),
              'semantic_status': 'PASS', 'benchmarks': benchmarks}
    Path(args.output).write_text(json.dumps(result, indent=2, sort_keys=True) + '\n',
                                 encoding='utf-8', newline='\n')
    print('PASS', result['semantic_cases'], 'cases;', result['semantic_checks'], 'prefix evaluations')
    for row in benchmarks:
        print(row['m'], row['mode'], row['boundary']['reachable'],
              row['allocated_nodes'], row['counts'].get('allocated_edges', 0))


if __name__ == '__main__':
    main()
