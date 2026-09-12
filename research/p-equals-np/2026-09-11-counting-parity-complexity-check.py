"""Reproduce the independent S3060 complexity-review finite checks; writes no artifacts."""
import importlib.util
import itertools
import json
import random
from pathlib import Path

p = Path(__file__).with_name('2026-09-11-counting-parity.py')
spec = importlib.util.spec_from_file_location('reviewed_counting_parity', p)
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
d = json.loads(p.with_suffix('.json').read_text(encoding='utf8'))
assert d['script_sha256_lf'] == m.pin(p)
assert d['helper_sha256_lf'] == m.pin(m.H)
replayed = 0
for case in d['cases']:
    expected = case.get('results', {'hybrid': case.get('result')})
    for mode, out in expected.items():
        assert json.loads(json.dumps(m.run(case['cnf'], case['n'], mode))) == out
        replayed += 1

rng = random.Random(3060001)
clauses = [tuple(sign*v for v, sign in zip(sg, signs))
           for k in range(1, 4)
           for sg in itertools.combinations(range(1, 5), k)
           for signs in itertools.product([-1, 1], repeat=k)]
checks = 0
for _ in range(200):
    cnf = rng.sample(clauses, rng.randrange(0, 15))
    models = [x for x in range(16) if all(m.A.holds(c, x) for c in cnf)]
    for mode in ['counting', 'parity', 'hybrid']:
        out = m.run(cnf, 4, mode)
        if out['status'] == 'UNSAT':
            assert not models
        else:
            for x in models:
                assert all(((x >> (int(v)-1)) & 1) == b
                           for v, b in out['fixed'].items())
                assert all(((a & x).bit_count() & 1) == b for a, b in out['rows'])
        checks += 1

fractional = 0
for case in d['cases']:
    if case['family'] != 'interaction':
        continue
    a = case['half_units']
    assert all(sum(a[abs(v)-1] if v > 0 else 2-a[abs(v)-1] for v in c) >= 2
               for c in case['cnf'])
    assert all(sum(a[v-1] for v in g) <= 2 for g in case['groups'])
    fractional += 1

print(json.dumps({'artifact_case_mode_replays': replayed,
                  'synthetic_soundness_runs': checks, 'seed': 3060001,
                  'exact_fractional_witnesses': fractional,
                  'script_lf_sha256': m.pin(p),
                  'helper_lf_sha256': m.pin(m.H)}))
