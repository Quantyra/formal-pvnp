"""Fixed unfiltered 3-CNF suite; capped diagnostics, never capped NO."""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import random
from probe_factored_cofactors import Dag, assignments, cnf_value
from probe_overlap_repair import bucket


CAPS = {'nodes': 100_000, 'edges': 1_000_000, 'charged_units': 5_000_000}
SEEDS = (17, 29, 43, 71)


class ResourceCap(Exception):
    pass


class Budget:
    def __init__(self):
        self.used = 0

    def charge(self, amount):
        if self.used + amount > CAPS['charged_units']:
            raise ResourceCap('charged_units')
        self.used += amount


class ChargedCounter(Counter):
    def __init__(self, budget):
        super().__init__()
        self.budget = budget

    def __setitem__(self, key, value):
        delta = value - self.get(key, 0)
        assert delta >= 0
        self.budget.charge(delta)
        super().__setitem__(key, value)


class CappedDag(Dag):
    def __init__(self, budget):
        super().__init__('factor')
        self.count = ChargedCounter(budget)
        self.arena_edges = 0

    def intern(self, key):
        self.count['intern_lookups'] += 1
        arity = len(key[1]) if key[0] in ('and', 'or') else 0
        self.count['intern_key_edges'] += arity
        if key not in self.ids:
            if len(self.nodes) + 1 > CAPS['nodes']:
                raise ResourceCap('nodes')
            if self.arena_edges + arity > CAPS['edges']:
                raise ResourceCap('edges')
            self.count['allocated_edges'] += arity
            self.ids[key] = len(self.nodes)
            self.nodes.append(key)
            self.arena_edges += arity
        return self.ids[key]


def generate(n, seed):
    rng = random.Random((n << 16) + seed)
    clauses, seen, draws = [], set(), 0
    while len(clauses) < (17*n)//4:
        variables = rng.sample(range(1, n+1), 3)
        clause = tuple(sorted(v if rng.getrandbits(1) else -v for v in variables))
        draws += 1
        if clause not in seen:
            clauses.append(clause)
            seen.add(clause)
    return clauses, draws


def solve(clauses, order, verify_prefix):
    budget = Budget()
    d, stats = CappedDag(budget), ChargedCounter(budget)
    history, stages, root = [], [], None
    checks = 0
    phase, active_var = 'initialization', None
    local_cap = 32*(1+len(order)+sum(1+len(c) for c in clauses))

    def snapshot(prefix):
        roots = ([root] if root is not None else [])
        roots += [r for kind, _, a, b in history if kind == 'cofactor' for r in (a,b)]
        return {'prefix': prefix, 'reachable': d.reachable([root]),
                'history_dag': d.reachable(roots), 'history_records': len(history),
                'allocated_nodes': len(d.nodes), 'allocated_edges': d.arena_edges,
                'charged_units': budget.used, 'dag_counts': dict(d.count),
                'hybrid_counts': dict(stats)}

    def check_prefix(stage):
        nonlocal checks
        if verify_prefix:
            for rest in assignments(order[stage:]):
                expected = any(cnf_value(clauses, rest | old)
                               for old in assignments(order[:stage]))
                assert d.evaluate(root, rest) == expected
                checks += 1

    status, algorithm_sat, witness, stop_reason = 'COMPLETE', None, None, None
    try:
        root = d.op('and', [d.op('or', [d.lit(lit) for lit in c]) for c in clauses])
        check_prefix(0)
        stages.append(snapshot(0))
        for stage, var in enumerate(order, 1):
            phase, active_var = 'elimination', var
            result = bucket(d, root, var, 16, local_cap, stats)
            if result is None:
                stats['cofactor_fallbacks'] += 1
                a = d.cofactor(root, var, False)
                b = d.cofactor(root, var, True)
                next_root = d.op('or', [a, b])
                record = ('cofactor', var, a, b)
            else:
                next_root, record = result
            root = next_root
            history.append(record)
            check_prefix(stage)
            stages.append(snapshot(stage))
        assert root in (0, 1)
        phase, active_var = 'witness', None
        if root == 1:
            witness = {}
            for kind, var, a, b in reversed(history):
                active_var = var
                if kind == 'cofactor':
                    bit = not d.evaluate(a, witness, True)
                    assert d.evaluate(b if bit else a, witness, True)
                else:
                    def value(row):
                        stats['witness_bucket_literal_visits'] += len(row)
                        return any([witness[abs(lit)] == (lit > 0) for lit in row])
                    bit = any(not value(row) for row in a)
                    assert all(bit or value(row) for row in a)
                    assert all(not bit or value(row) for row in b)
                witness[var] = bit
            assert cnf_value(clauses, witness)
        algorithm_sat = root == 1
        phase, active_var = 'finished', None
    except ResourceCap as error:
        status, stop_reason, witness = 'INCOMPLETE', str(error), None
    except RecursionError:
        status, stop_reason, witness = 'INCOMPLETE', 'python_recursion', None
    return {'status': status, 'algorithm_sat': algorithm_sat,
            'stop_reason': stop_reason, 'stop_phase': phase, 'active_variable': active_var,
            'order': order, 'witness': witness, 'semantic_prefix_checks': checks,
            'stages': stages, 'terminal_diagnostics': {
                'allocated_nodes': len(d.nodes), 'allocated_edges': d.arena_edges,
                'charged_units': budget.used, 'dag_counts': dict(d.count),
                'hybrid_counts': dict(stats), 'completed_eliminations': len(history)},
            'local_pair_cap': 16, 'local_work_cap': local_cap}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', required=True)
    args = parser.parse_args()
    cases = []
    for n in (6,8,10,12):
        for seed in SEEDS:
            clauses, draws = generate(n, seed)
            encoded = json.dumps(clauses, separators=(',', ':')).encode('utf-8')
            degree = Counter(abs(lit) for row in clauses for lit in row)
            oracle_witness = next((a for a in assignments(list(range(1,n+1)))
                                   if cnf_value(clauses, a)), None)
            runs = []
            for name, order in (('ascending', list(range(1,n+1))),
                                ('static_degree', sorted(range(1,n+1), key=lambda v: (-degree[v],v)))):
                result = solve(clauses, order, n <= 8)
                result['order_name'] = name
                if result['status'] == 'COMPLETE':
                    assert result['algorithm_sat'] == (oracle_witness is not None)
                    if result['algorithm_sat']:
                        # JSON conversion of integer keys occurs only on output.
                        assert cnf_value(clauses, result['witness'])
                runs.append(result)
                print(n, seed, name, result['status'], result['algorithm_sat'],
                      result['terminal_diagnostics']['allocated_nodes'],
                      result['terminal_diagnostics']['allocated_edges'], flush=True)
            cases.append({'n': n, 'seed': seed, 'rng_seed': (n<<16)+seed,
                          'clauses': clauses, 'generation_draws': draws,
                          'sha256_canonical_clause_json': hashlib.sha256(encoded).hexdigest(),
                          'degrees': dict(degree), 'oracle_sat': oracle_witness is not None,
                          'oracle_witness': oracle_witness, 'runs': runs})
    output = {'caps': CAPS, 'cases': cases, 'status': 'VERIFICATION_PASS'}
    Path(args.output).write_text(json.dumps(output, indent=2, sort_keys=True)+'\n',
                                 encoding='utf-8', newline='\n')


if __name__ == '__main__':
    main()
