"""Bounded clausal resolution before exact shared cofactor fallback."""
import argparse
from collections import Counter
from itertools import product
import json
from pathlib import Path
from probe_factored_cofactors import Dag, assignments, cnf_value


class Abort(Exception):
    pass


def bucket(d, root, var, pair_cap, work_cap, stats):
    used = 0
    def tick(amount=1):
        nonlocal used
        if used + amount > work_cap:
            raise Abort('work_cap')
        used += amount
        stats['bucket_ticks'] += amount
    stats['bucket_attempts'] += 1
    try:
        tick()
        tag, value = d.nodes[root]
        rows = value if tag == 'and' else (root,)
        positive, negative, retained = [], [], []
        for node in rows:
            tick()
            tag, value = d.nodes[node]
            if node == 1:
                continue
            if node == 0:
                row = []
            else:
                leaves = value if tag == 'or' else (node,)
                row = []
                for leaf in leaves:
                    tick()
                    kind, literal = d.nodes[leaf]
                    if kind != 'lit':
                        raise Abort('not_clausal')
                    row.append(literal)
            # The canonical base constructor has removed duplicate literals.
            tick(len(row))
            if var in row:
                positive.append(tuple(lit for lit in row if lit != var))
            elif -var in row:
                negative.append(tuple(lit for lit in row if lit != -var))
            else:
                retained.append(node)
        stats['pair_candidates_requested'] += len(positive) * len(negative)
        if len(positive) * len(negative) > pair_cap:
            raise Abort('pair_cap')
        generated = []
        for a in positive:
            for b in negative:
                tick(1 + len(a) + len(b))
                stats['pair_candidates_examined'] += 1
                row = set(a) | set(b)
                tick(len(row))
                if any(-lit in row for lit in row):
                    stats['tautological_candidates'] += 1
                    continue
                generated.append(tuple(sorted(row)))
                stats['candidate_literal_entries'] += len(row)
        # No DAG mutation occurred before this commit of the whole bucket.
        fresh = [d.op('or', [d.lit(lit) for lit in row]) for row in generated]
        next_root = d.op('and', retained + fresh)
        stats['bucket_successes'] += 1
        stats['stored_bucket_literal_entries'] += sum(map(len, positive + negative))
        return next_root, ('bucket', var, positive, negative)
    except Abort as error:
        stats['abort_' + str(error)] += 1
        stats['abandoned_bucket_ticks'] += used
        return None


def xor_family(m, cycle=False, pins=False):
    yn = m if cycle else m+1
    clauses = []
    for i in range(m):
        variables = (i+1, m+i+1, m+((i+1) % yn)+1)
        for bits in product((False, True), repeat=3):
            if bits[0] != (bits[1] ^ bits[2]):
                clauses.append(tuple(-v if bit else v for v, bit in zip(variables, bits)))
    if pins:
        if cycle:
            clauses.extend([(1,)] + [(-i,) for i in range(2, m+1)])
        else:
            clauses.extend([(1,), (-m-1,), (-m-2,)])
    return clauses, list(range(1, m+yn+1))


def run(clauses, order, hybrid, verify=False, boundary=None, pair_cap=16, work_cap=None):
    d, stats = Dag('factor'), Counter()
    length = len(order) + sum(len(c) + 1 for c in clauses) + 1
    work_cap = 32 * length if work_cap is None else work_cap
    root = d.op('and', [d.op('or', [d.lit(lit) for lit in c]) for c in clauses])
    history, checks, snapshot = [], 0, None
    for stage in range(len(order)+1):
        if verify:
            for rest in assignments(order[stage:]):
                expected = any(cnf_value(clauses, rest | old) for old in assignments(order[:stage]))
                assert d.evaluate(root, rest) == expected
                checks += 1
        if stage == boundary:
            snapshot = {'reachable': d.reachable([root]), 'root_is_true': root == 1}
        if stage == len(order):
            break
        var = order[stage]
        result = bucket(d, root, var, pair_cap, work_cap, stats) if hybrid else None
        if result is None:
            stats['cofactor_fallbacks'] += 1
            a, b = d.cofactor(root, var, False), d.cofactor(root, var, True)
            history.append(('cofactor', var, a, b))
            root = d.op('or', [a, b])
        else:
            root, record = result
            history.append(record)
    assert root in (0, 1)
    witness = None
    if root == 1:
        witness = {}
        for kind, var, a, b in reversed(history):
            if kind == 'cofactor':
                bit = not d.evaluate(a, witness, True)
                assert d.evaluate(b if bit else a, witness, True)
            else:
                def val(row):
                    stats['witness_bucket_literal_visits'] += len(row)
                    return any([witness[abs(lit)] == (lit > 0) for lit in row])
                bit = any(not val(row) for row in a)
                assert all(bit or val(row) for row in a)
                assert all(not bit or val(row) for row in b)
            witness[var] = bit
        assert cnf_value(clauses, witness)
    roots = [root] + [r for kind, _, a, b in history if kind == 'cofactor' for r in (a, b)]
    return {'hybrid': hybrid, 'pair_cap': pair_cap, 'work_cap': work_cap,
            'sat': root == 1, 'witness_verified': witness is not None,
            'semantic_checks': checks, 'boundary': snapshot, 'stats': dict(stats),
            'dag_counts': dict(d.count), 'allocated_nodes': len(d.nodes),
            'history_dag': d.reachable(roots), 'history_records': len(history)}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', required=True)
    args = parser.parse_args()
    cases = [xor_family(2, False, pins) for pins in (False, True)]
    cases += [xor_family(3, True, pins) for pins in (False, True)]
    cases += [([], []), ([[]], []), ([(1,), (-1,)], [1])]
    results = []
    for clauses, order in cases:
        for hybrid, pairs, work in ((False, 16, None), (True, 16, None),
                                     (True, 0, None), (True, 16, 1)):
            results.append(run(clauses, order, hybrid, True, pair_cap=pairs, work_cap=work))
    benchmarks = []
    for m in (3, 4, 6, 8):
        for cycle in (False, True):
            clauses, order = xor_family(m, cycle)
            for hybrid in (False, True):
                benchmarks.append({'m': m, 'cycle': cycle,
                                   **run(clauses, order, hybrid, boundary=m)})
    output = {'semantic_status': 'PASS', 'semantic_cases': results, 'benchmarks': benchmarks}
    Path(args.output).write_text(json.dumps(output, indent=2, sort_keys=True)+'\n',
                                 encoding='utf-8', newline='\n')
    print('PASS', len(results), 'cases', sum(r['semantic_checks'] for r in results), 'prefix checks')
    for r in benchmarks:
        print(r['m'], 'cycle' if r['cycle'] else 'chain', r['hybrid'],
              r['boundary']['reachable'], r['allocated_nodes'], r['dag_counts'].get('allocated_edges',0))


if __name__ == '__main__':
    main()
