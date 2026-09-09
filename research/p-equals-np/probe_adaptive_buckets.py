"""One adaptive whole-CNF variable rule on the fixed saved corpus."""
import argparse
import json
from pathlib import Path
import probe_fallback_stress as base
from probe_factored_cofactors import assignments, cnf_value


class SelectorAbort(Exception):
    pass


def select(d, root, remaining, local_cap, selector_cap, counts):
    used = 0
    def charge(name, amount=1):
        nonlocal used
        if used + amount > selector_cap:
            raise SelectorAbort('entry_cap')
        used += amount
        counts[name] += amount
    try:
        charge('root_reads')
        tag, value = d.nodes[root]
        nodes = value if tag == 'and' else (root,)
        clauses, recognition = [], 1
        for node in nodes:
            charge('factor_reads')
            recognition += 1
            tag, value = d.nodes[node]
            if node == 1:
                continue
            if node == 0:
                row = ()
            elif tag == 'lit':
                charge('literal_reads')
                row = (value,)
            elif tag == 'or':
                row = []
                for child in value:
                    charge('literal_reads')
                    kind, literal = d.nodes[child]
                    if kind != 'lit':
                        raise SelectorAbort('not_clausal')
                    row.append(literal)
                row = tuple(row)
            else:
                raise SelectorAbort('not_clausal')
            recognition += 2*len(row)
            clauses.append(row)
        best, candidates = None, []
        for var in remaining:  # Maintained in ascending order, no hidden sort.
            charge('candidate_variables')
            positive, negative = [], []
            for row in clauses:
                charge('candidate_row_reads')
                charge('candidate_literal_entries', len(row))
                polarity = 0
                remainder = []
                for literal in row:
                    if literal == var:
                        polarity = 1
                    elif literal == -var:
                        polarity = -1
                    else:
                        remainder.append(literal)
                if polarity:
                    charge('remainder_entries', len(remainder))
                    (positive if polarity == 1 else negative).append(tuple(remainder))
            pairs = len(positive)*len(negative)
            feasible, cost = pairs <= 16 and recognition <= local_cap, recognition
            if feasible:
                for a in positive:
                    for b in negative:
                        charge('feasibility_pairs')
                        charge('feasibility_union_inputs', len(a)+len(b))
                        union = set(a) | set(b)
                        charge('feasibility_union_entries', len(union))
                        cost += 1+len(a)+len(b)+len(union)
                        if cost > local_cap:
                            feasible = False
                            break
                    if not feasible:
                        break
            candidates.append({'variable': var, 'raw_pairs': pairs,
                               'precommit_entries': cost, 'feasible': feasible})
            charge('score_comparisons')
            if feasible and (best is None or (pairs,var) < best):
                best = (pairs,var)
        return (None if best is None else best[1]), {
            'reason': 'no_feasible' if best is None else 'selected',
            'selector_entries': used, 'candidates': candidates,
            'recognition_entries': recognition}
    except SelectorAbort as error:
        return None, {'reason': str(error), 'selector_entries': used}


def solve(clauses, static_order, verify_prefix, selector_cap_override=None):
    assert sorted(static_order) == list(range(1,len(static_order)+1))
    assert all(0 < abs(lit) <= len(static_order) for row in clauses for lit in row)
    budget = base.Budget()
    d = base.CappedDag(budget)
    hybrid, selector = base.ChargedCounter(budget), base.ChargedCounter(budget)
    n = len(static_order)
    l0 = 1+n+sum(1+len(c) for c in clauses)
    local_cap = 32*l0
    selector_cap = 16*n*l0 if selector_cap_override is None else selector_cap_override
    remaining = list(range(1,n+1))
    eliminated, history, stages = [], [], []
    root, checks = None, 0
    phase, active_var = 'initialization', None

    def check():
        nonlocal checks
        if verify_prefix:
            for rest in assignments(remaining):
                expected = any(cnf_value(clauses,rest|old) for old in assignments(eliminated))
                assert d.evaluate(root,rest) == expected
                checks += 1

    def snapshot(selection=None):
        roots = [root]+[r for kind,_,a,b in history if kind=='cofactor' for r in (a,b)]
        return {'eliminated': list(eliminated), 'remaining': list(remaining),
                'selection': selection, 'reachable': d.reachable([root]),
                'history_dag': d.reachable(roots), 'allocated_nodes': len(d.nodes),
                'allocated_edges': d.arena_edges, 'charged_units': budget.used,
                'dag_counts': dict(d.count), 'hybrid_counts': dict(hybrid),
                'selector_counts': dict(selector)}

    status, answer, witness, stop_reason = 'COMPLETE', None, None, None
    try:
        root = d.op('and',[d.op('or',[d.lit(l) for l in c]) for c in clauses])
        check()
        stages.append(snapshot())
        while remaining:
            phase, active_var = 'selection', None
            var, report = select(d,root,remaining,local_cap,selector_cap,selector)
            if var is None:
                for candidate in static_order:
                    selector['fallback_order_entries'] += 1
                    # Full list scan makes the entry charge explicit.
                    selector['fallback_membership_entries'] += len(remaining)
                    if any([candidate == v for v in remaining]):
                        var = candidate
                        break
            assert var in remaining
            active_var, phase = var, 'elimination'
            report['chosen_variable'] = var
            result = base.bucket(d,root,var,16,local_cap,hybrid)
            report['actual_bucket_success'] = result is not None
            if report['reason'] == 'selected':
                assert result is not None  # Predicted precommit feasibility agrees.
            if result is None:
                hybrid['cofactor_fallbacks'] += 1
                a, b = d.cofactor(root,var,False), d.cofactor(root,var,True)
                next_root, record = d.op('or',[a,b]), ('cofactor',var,a,b)
            else:
                next_root, record = result
            selector['remaining_list_entries'] += len(remaining)
            remaining = [v for v in remaining if v != var]
            eliminated.append(var)
            history.append(record)
            root = next_root
            check()
            stages.append(snapshot(report))
        assert root in (0,1)
        phase, active_var = 'witness', None
        if root == 1:
            witness = {}
            for kind,var,a,b in reversed(history):
                active_var = var
                if kind == 'cofactor':
                    bit = not d.evaluate(a,witness,True)
                    assert d.evaluate(b if bit else a,witness,True)
                else:
                    def value(row):
                        hybrid['witness_bucket_literal_visits'] += len(row)
                        return any([witness[abs(l)] == (l>0) for l in row])
                    bit = any(not value(row) for row in a)
                    assert all(bit or value(row) for row in a)
                    assert all(not bit or value(row) for row in b)
                witness[var] = bit
            assert cnf_value(clauses,witness)
        answer = root == 1
        phase, active_var = 'finished', None
    except base.ResourceCap as error:
        status, stop_reason, witness = 'INCOMPLETE', str(error), None
    except RecursionError:
        status, stop_reason, witness = 'INCOMPLETE', 'python_recursion', None
    common = sum(d.count.values())+sum(hybrid.values())
    assert budget.used == common+sum(selector.values())
    return {'status': status, 'algorithm_sat': answer, 'witness': witness,
            'stop_reason': stop_reason, 'stop_phase': phase, 'active_variable': active_var,
            'eliminated': eliminated, 'remaining': remaining, 'stages': stages,
            'semantic_prefix_checks': checks, 'selector_cap': selector_cap, 'local_cap': local_cap,
            'terminal': {'allocated_nodes': len(d.nodes), 'allocated_edges': d.arena_edges,
                         'charged_units': budget.used, 'common_base_units': common,
                         'selector_units': sum(selector.values()), 'dag_counts': dict(d.count),
                         'hybrid_counts': dict(hybrid), 'selector_counts': dict(selector)}}


def forced_checks():
    clauses, order = [(1,2),(-1,2)], [1,2]
    fallback = solve(clauses,order,True,selector_cap_override=1)
    assert fallback['status']=='COMPLETE' and fallback['algorithm_sat']
    assert any(s['selection'] and s['selection']['reason']=='entry_cap' for s in fallback['stages'])
    caps = base.CAPS
    interrupted = []
    try:
        for key, value in (('nodes',2),('edges',0),('charged_units',0)):
            base.CAPS = dict(caps, **{key:value})
            result = solve(clauses,order,False)
            assert result['status']=='INCOMPLETE' and result['algorithm_sat'] is None
            assert result['witness'] is None and result['stop_reason']==key
            interrupted.append({'forced_cap':key,'result':result})
    finally:
        base.CAPS = caps
    return {'selector_fallback': fallback, 'global_interruptions': interrupted}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output',required=True)
    args = parser.parse_args()
    saved = json.loads(Path(__file__).with_name('2026-09-08-fallback-stress-output.json').read_text())
    assert saved['caps']==base.CAPS
    forced = forced_checks()
    results = []
    for case in saved['cases']:
        old = next(r for r in case['runs'] if r['order_name']=='static_degree')
        oracle = next((a for a in assignments(list(range(1,case['n']+1)))
                       if cnf_value(case['clauses'],a)),None)
        assert (oracle is not None)==case['oracle_sat']
        result = solve(case['clauses'],old['order'],case['n']<=8)
        if result['status']=='COMPLETE':
            assert result['algorithm_sat']==(oracle is not None)
            if result['algorithm_sat']:
                assert cnf_value(case['clauses'],result['witness'])
        results.append({'n':case['n'],'seed':case['seed'],
                        'clause_sha256':case['sha256_canonical_clause_json'],
                        'original_static_order':old['order'],'oracle_sat':oracle is not None,
                        'result':result})
        print(case['n'],case['seed'],result['status'],result['algorithm_sat'],
              result['terminal']['allocated_nodes'],result['terminal']['allocated_edges'],
              result['terminal']['common_base_units'],result['terminal']['selector_units'],flush=True)
    output = {'status':'VERIFICATION_PASS','caps':base.CAPS,'forced_checks':forced,'runs':results}
    Path(args.output).write_text(json.dumps(output,indent=2,sort_keys=True)+'\n',encoding='utf-8',newline='\n')


if __name__=='__main__':
    main()
