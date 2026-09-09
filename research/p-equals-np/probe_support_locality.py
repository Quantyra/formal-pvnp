"""Read-only supports around unchanged saved hybrid runs."""
import argparse
from collections import Counter
import json
from pathlib import Path
import probe_fallback_stress as stress
from probe_factored_cofactors import Dag


class Diagnostic:
    def __init__(self, d):
        self.d, self.cache, self.count = d, {}, Counter()

    def support(self, node):
        self.count['support_requests'] += 1
        if node in self.cache:
            self.count['support_cache_hits'] += 1
            return self.cache[node]
        self.count['support_node_computations'] += 1
        tag, value = self.d.nodes[node]
        if tag == 'const':
            result = frozenset()
        elif tag == 'lit':
            result = frozenset((abs(value),))
        else:
            result = set()
            for child in value:
                self.count['support_edge_traversals'] += 1
                child_support = self.support(child)
                self.count['support_union_input_entries'] += len(child_support)
                result.update(child_support)
            result = frozenset(result)
        self.cache[node] = result
        self.count['stored_support_entries'] += len(result)
        return result

    def clause(self, node):
        self.count['shape_node_reads'] += 1
        tag, value = self.d.nodes[node]
        if tag == 'const':
            return ()  # Constants have no variable dependence.
        if tag == 'lit':
            return (value,)
        if tag != 'or':
            return None
        row = []
        for child in value:
            self.count['shape_edge_reads'] += 1
            kind, literal = self.d.nodes[child]
            if kind != 'lit':
                return None
            row.append(literal)
        return tuple(row)

    def local_check(self, factors, var, pair_cap, work_cap):
        dependent = [f for f in factors if var in f['support']]
        self.count['candidate_factor_membership_tests'] += len(factors)
        if any(f['clause'] is None for f in dependent):
            return {'shape_eligible': False}
        positive, negative = [], []
        # Normalized dependent root is true if empty, a factor if singleton,
        # otherwise an AND. Recognition of the empty true root costs two.
        scan = 2 if not dependent else 1
        for factor in dependent:
            row = factor['clause']
            scan += 1 + 2*len(row)
            self.count['candidate_clause_entries'] += len(row)
            if var in row:
                positive.append(tuple(l for l in row if l != var))
            else:
                assert -var in row
                negative.append(tuple(l for l in row if l != -var))
        pairs = len(positive)*len(negative)
        report = {'shape_eligible': True, 'positive_clauses': len(positive),
                  'negative_clauses': len(negative), 'raw_pairs': pairs,
                  'recognition_entry_cost': scan, 'pair_cap_pass': pairs <= pair_cap,
                  'precommit_check_pass': False}
        if scan > work_cap:
            report['failed_check'] = 'recognition_entries'
            return report
        if pairs > pair_cap:
            report['failed_check'] = 'raw_pairs'
            return report
        cost = scan
        for a in positive:
            for b in negative:
                self.count['candidate_pairs_inspected'] += 1
                self.count['candidate_union_input_entries'] += len(a)+len(b)
                cost += 1+len(a)+len(b)+len(set(a)|set(b))
                if cost > work_cap:
                    report['failed_check'] = 'candidate_entries'
                    report['required_entries_through_failed_pair'] = cost
                    return report
        report['precommit_entry_cost'] = cost
        report['precommit_check_pass'] = True
        return report

    def observe(self, root, var, pair_cap, work_cap):
        tag, value = self.d.nodes[root]
        roots = value if tag == 'and' else (root,)
        factors = []
        for node in roots:
            self.count['top_factor_visits'] += 1
            factors.append({'node': node, 'shape': self.d.nodes[node][0],
                            'support': sorted(self.support(node)), 'clause': self.clause(node)})
        active = self.support(root)
        bad_union = set()
        for f in factors:
            if f['clause'] is None:
                bad_union.update(f['support'])
                self.count['bad_union_input_entries'] += len(f['support'])
        eligible = sorted(active - bad_union)
        current = self.local_check(factors, var, pair_cap, work_cap)
        candidates = {v: self.local_check(factors, v, pair_cap, work_cap) for v in eligible}
        dependent_bad = [f for f in factors if f['clause'] is None and var in f['support']]
        independent_bad = [f for f in factors if f['clause'] is None and var not in f['support']]
        return {'variable': var, 'root': root, 'active_support': sorted(active),
                'nonclausal_support_union': sorted(bad_union),
                'shape_eligible_active_variables': eligible, 'active_candidate_checks': candidates,
                'current_local_check': current, 'top_factors': factors,
                'dependent_nonclausal_count': len(dependent_bad),
                'independent_nonclausal_count': len(independent_bad),
                'independent_clause_count': sum(f['clause'] is not None and var not in f['support'] for f in factors)}

    def verify(self):
        # Independent uncached literal-leaf traversal, without support unions.
        for root, expected in self.cache.items():
            seen, stack, variables = set(), [root], set()
            while stack:
                node = stack.pop()
                if node in seen:
                    continue
                seen.add(node)
                self.count['verification_node_visits'] += 1
                tag, value = self.d.nodes[node]
                if tag == 'lit':
                    variables.add(abs(value))
                elif tag in ('and', 'or'):
                    self.count['verification_edge_visits'] += len(value)
                    stack.extend(value)
            assert variables == expected
        return len(self.cache)


def positive_check():
    d = Dag('factor')
    nonclause = d.op('or', [d.op('and',[d.lit(2),d.lit(3)]),
                             d.op('and',[d.lit(-2),d.lit(4)])])
    root = d.op('and',[nonclause,d.op('or',[d.lit(1),d.lit(5)]),
                       d.op('or',[d.lit(-1),d.lit(6)])])
    diag = Diagnostic(d)
    event = diag.observe(root, 1, 16, 1000)
    assert event['independent_nonclausal_count'] == 1
    assert event['dependent_nonclausal_count'] == 0
    assert event['current_local_check']['raw_pairs'] == 1
    assert event['current_local_check']['precommit_check_pass']
    before = (len(d.nodes), dict(d.count))
    assert stress.bucket(d,root,1,16,1000,Counter()) is None
    assert (len(d.nodes), dict(d.count)) == before
    checked = diag.verify()
    return {'status': 'PASS', 'event': event, 'checked_support_nodes': checked,
            'diagnostic_counts': dict(diag.count)}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', required=True)
    args = parser.parse_args()
    baseline_path = Path(__file__).with_name('2026-09-08-fallback-stress-output.json')
    baseline = json.loads(baseline_path.read_text(encoding='utf-8'))
    assert baseline['caps'] == stress.CAPS
    original_bucket = stress.bucket
    runs = []
    for case in baseline['cases']:
        for old in case['runs']:
            events, holder = [], []
            def wrapper(d, root, var, pair_cap, work_cap, stats):
                if not holder:
                    holder.append(Diagnostic(d))
                assert holder[0].d is d
                event = holder[0].observe(root,var,pair_cap,work_cap)
                before = dict(stats)
                result = original_bucket(d,root,var,pair_cap,work_cap,stats)
                event['baseline_outcome'] = 'success' if result is not None else next(
                    reason for reason in ('abort_not_clausal','abort_pair_cap','abort_work_cap')
                    if stats[reason] > before.get(reason,0))
                events.append(event)
                return result
            try:
                stress.bucket = wrapper
                replay = stress.solve(case['clauses'],old['order'],case['n'] <= 8)
            finally:
                stress.bucket = original_bucket
            replay['order_name'] = old['order_name']
            assert json.loads(json.dumps(replay)) == old
            diag = holder[0]
            checked = diag.verify()
            runs.append({'n': case['n'], 'seed': case['seed'], 'order_name': old['order_name'],
                         'baseline_identical': True, 'events': events,
                         'checked_support_nodes': checked, 'diagnostic_counts': dict(diag.count)})
            print(case['n'],case['seed'],old['order_name'],'IDENTICAL',flush=True)
    output = {'status': 'PASS', 'positive_hand_case': positive_check(), 'runs': runs}
    Path(args.output).write_text(json.dumps(output,indent=2,sort_keys=True)+'\n',encoding='utf-8',newline='\n')


if __name__ == '__main__':
    main()
