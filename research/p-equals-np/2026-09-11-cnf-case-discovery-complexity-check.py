"""Independent S3059 small-case and clause-weakening checks; writes no artifacts."""
import importlib.util
import itertools
import json
import math
from pathlib import Path

path = Path(__file__).with_name('2026-09-11-cnf-case-discovery.py')
spec = importlib.util.spec_from_file_location('reviewed_cnf_discovery', path)
t = importlib.util.module_from_spec(spec)
spec.loader.exec_module(t)


def holds(c, x):
    return any(((x >> (abs(v) - 1)) & 1) == int(v > 0) for v in c)


def simple_up(clauses, values):
    values = dict(values)
    while True:
        changed = False
        for c in clauses:
            if any(abs(v) in values and values[abs(v)] == int(v > 0) for v in c):
                continue
            remaining = [v for v in c if abs(v) not in values]
            if not remaining:
                return True, values
            if len(remaining) == 1:
                v = remaining[0]
                values[abs(v)] = int(v > 0)
                changed = True
        if not changed:
            return False, values


def main():
    # Each variable can be absent, negative or positive; includes the empty clause.
    universe = [tuple((i + 1) * value for i, value in enumerate(signs) if value)
                for signs in itertools.product([-1, 0, 1], repeat=2)]
    checks = 0
    unsat_inputs = 0
    for code in range(1 << len(universe)):
        cnf = [c for i, c in enumerate(universe) if (code >> i) & 1]
        models = [x for x in range(4) if all(holds(c, x) for c in cnf)]
        unsat_inputs += not models
        for budget in range(3):
            result = t.discover(cnf, 2, budget)
            assert result['status'] != 'UNSAT' or not models
            for item in result['learned']:
                a, b = item['row']
                assert all((a & x).bit_count() % 2 == b for x in models)
            for item in result['nogoods']:
                assert all(holds(item['clause'], x) for x in models)
            if budget == 2:
                assert (result['status'] == 'UNSAT') == (not models)
            total_patterns = sum(math.comb(2, j) * (1 << j) for j in range(budget + 1))
            assert len(result['history']) <= 2 + total_patterns + budget + 1
            assert all(s['cases_attempted'] <= s['case_bound_per_sweep']
                       for s in result['history'])
            checks += 1

    # A learned width-three weakening of an original at-most-one clause cannot
    # change its unit closure under any partial assignment on these coordinates.
    weakening_cases = 0
    for values in itertools.product([None, 0, 1], repeat=3):
        assignment = {i + 1: v for i, v in enumerate(values) if v is not None}
        original = simple_up([(-1, -2)], assignment)
        weakened = simple_up([(-1, -2), (-1, -2, 3)], assignment)
        assert original[0] == weakened[0]
        if not original[0]:
            assert original[1] == weakened[1]
        weakening_cases += 1

    print(json.dumps({'cnfs': 1 << len(universe), 'unsat_cnfs': unsat_inputs,
                      'budgeted_runs': checks, 'weakening_partial_assignments': weakening_cases}))


if __name__ == '__main__':
    main()
