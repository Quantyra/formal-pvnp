"""Independent S3058 finite soundness checks. Writes no result artifacts."""
import importlib.util
import itertools
import json
import random
from pathlib import Path

target = Path(__file__).with_name('2026-09-11-global-parity-learning.py')
spec = importlib.util.spec_from_file_location('review_target', target)
t = importlib.util.module_from_spec(spec)
spec.loader.exec_module(t)


def clause(c, x):
    return any(((x >> (abs(v) - 1)) & 1) == int(v > 0) for v in c)


def models(base, cnf, guarded, n):
    return [x for x in range(1 << n)
            if all(t.parity(a & x) == b for a, b in base)
            and all(clause(c, x) for c in cnf)
            and all(not all(((x >> (abs(v) - 1)) & 1) == int(v > 0) for v in g)
                    or t.parity(a & x) == b for g, a, b in guarded)]


def check(args):
    base, cnf, guarded, n = args
    ms = models(*args)
    result = t.learn(*args)
    assert result['status'] != 'UNSAT' or not ms
    for ps in result['passes']:
        for item in ps['learned_equations']:
            a, b = item['row']
            assert all(t.parity(a & x) == b for x in ms)
        for c in ps['new_nogoods']:
            assert all(clause(c, x) for x in ms)
    supports = {tuple(sorted(abs(v) - 1 for v in guard)) for guard, a, b in guarded}
    assert len(result['passes']) <= n + sum(1 << len(g) for g in supports) + 2
    return result['status']


def span(basis):
    return {t.xor_sum(v for i, v in enumerate(basis) if (code >> i) & 1)
            for code in range(1 << len(basis))}


def main():
    rng = random.Random(3058)
    statuses = {}
    for _ in range(1200):
        n = 3
        base = [(rng.randrange(8), rng.randrange(2)) for j in range(rng.randrange(3))]
        cnf = []
        for j in range(rng.randrange(6)):
            vs = rng.sample(range(n), rng.randrange(1, n + 1))
            cnf.append(tuple((v + 1) * rng.choice([-1, 1]) for v in vs))
        guarded = []
        for j in range(rng.randrange(5)):
            vs = rng.sample(range(n), rng.randrange(3))
            g = tuple((v + 1) * rng.choice([-1, 1]) for v in vs)
            guarded.append((g, rng.randrange(8), rng.randrange(2)))
        status = check((base, cnf, guarded, n))
        statuses[status] = statuses.get(status, 0) + 1

    bases = {tuple(a for a, b in t.rref([(v, 0) for v in vs], 3))
             for k in range(4) for vs in itertools.combinations(range(1, 8), k)}
    for a, b in itertools.product(bases, repeat=2):
        assert span(t.intersect_spaces(list(a), list(b), 3)) == span(a) & span(b)

    clauses = [(1, 2), (1, -2), (-1, 2), (-1, -2)]
    assert not models([], clauses, [], 2)
    assert t.learn([], clauses, [], 2)['status'] == 'OPEN'

    base, cnf, guarded, n, targets = t.ring(3, 4)
    assert t.learn(base, cnf, guarded, n, False)['status'] == 'OPEN'
    assert t.learn(base, cnf, guarded, n)['status'] == 'UNSAT'
    print(json.dumps({'seed': 3058, 'small_instance_soundness_cases': 1200,
                      'statuses': statuses, 'subspace_pairs': len(bases) ** 2,
                      'new_ring': {'m': 3, 'length': 4, 'n': n},
                      'explicit_incomplete_2SAT': 'OPEN'}))


if __name__ == '__main__':
    main()
