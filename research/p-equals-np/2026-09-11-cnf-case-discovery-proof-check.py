"""Independent read-only replay of the five saved S3059 fixtures; stdlib only."""
import hashlib
import itertools
import json
from pathlib import Path


def propagate(cnf, assignment):
    fixed = dict(assignment)
    while True:
        before = len(fixed)
        for clause in cnf:
            if any(abs(v) - 1 in fixed and fixed[abs(v) - 1] == int(v > 0) for v in clause):
                continue
            remaining = {v for v in clause if abs(v) - 1 not in fixed}
            if any(-v in remaining for v in remaining):
                continue
            if not remaining:
                return None
            if len(remaining) == 1:
                v = next(iter(remaining))
                fixed[abs(v) - 1] = int(v > 0)
        if len(fixed) == before:
            return fixed


def xor(values):
    result = 0
    for value in values:
        result ^= value
    return result


def main():
    root = Path(__file__).parent
    data = json.loads((root / '2026-09-11-cnf-case-discovery.json').read_text())
    pins = dict(data['dependency_sha256_lf'])
    pins['2026-09-11-cnf-case-discovery.py'] = data['script_sha256_lf']
    for name, expected in pins.items():
        assert hashlib.sha256((root / name).read_bytes().replace(b'\r\n', b'\n')).hexdigest() == expected
    counts = {'cases': 0, 'conflicts': 0, 'common_equations': 0, 'batch_contradictions': 0,
              'php_summary_witness_checks': 0, 'input_pins': 0}
    for record in data['cases']:
        n, cnf, result = record['nvars'], record['cnf'], record['result']
        raw = json.dumps({'nvars': n, 'cnf': cnf}, sort_keys=True, separators=(',', ':')).encode()
        assert hashlib.sha256(raw).hexdigest() == record['input_sha256']
        counts['input_pins'] += 1
        # These saved runs have no committed nogoods or affine feedback before
        # their final sweep. Thus case Gaussian systems contain just UP units.
        assert not result['nogoods']
        assert all(item['initial_rank'] == 0 for item in result['history'])
        summaries = {}
        for stats in result['history']:
            attempted = failed = scopes = 0
            for size in range(stats['budget'] + 1):
                for scope in itertools.combinations(range(n), size):
                    scopes += 1
                    local = {}
                    for pattern in range(1 << size):
                        assignment = [(v, pattern >> j & 1) for j, v in enumerate(scope)]
                        fixed = propagate(cnf, assignment)
                        local[pattern] = fixed
                        attempted += 1
                        failed += fixed is None
                    summaries[scope] = local
                    if record['family'].startswith('functional_PHP'):
                        for point in [0] + [1 << j for j in range(n)]:
                            pattern = sum((point >> v & 1) << j for j, v in enumerate(scope))
                            fixed = local[pattern]
                            assert fixed is not None and all((point >> v & 1) == b for v, b in fixed.items())
                            counts['php_summary_witness_checks'] += 1
            assert attempted == stats['cases_attempted'] == stats['case_bound_per_sweep']
            assert failed == stats['failed_cases'] and scopes == stats['scopes_attempted']
            counts['cases'] += attempted
            counts['conflicts'] += failed
        for item in result['learned']:
            mask, rhs = item['row']
            local = summaries[tuple(item['scope'])]
            assert any(fixed is not None for fixed in local.values())
            for fixed in local.values():
                if fixed is None:
                    continue
                available = sum(1 << v for v in fixed)
                assert mask & ~available == 0
                assert xor(b for v, b in fixed.items() if mask >> v & 1) == rhs
            counts['common_equations'] += 1
        if 'final_gaussian_certificate' in result:
            cert = result['final_gaussian_certificate']
            assert cert['inputs'] == [[*item['row'], ['new', j]] for j, item in enumerate(result['learned'])]
            for mask, rhs, proof in cert['rows']:
                assert proof >> len(cert['inputs']) == 0
                assert xor(row[0] for j, row in enumerate(cert['inputs']) if proof >> j & 1) == mask
                assert xor(row[1] for j, row in enumerate(cert['inputs']) if proof >> j & 1) == rhs
            proof = cert['contradiction']
            assert proof is not None and proof >> len(cert['inputs']) == 0
            assert xor(row[0] for j, row in enumerate(cert['inputs']) if proof >> j & 1) == 0
            assert xor(row[1] for j, row in enumerate(cert['inputs']) if proof >> j & 1) == 1
            counts['batch_contradictions'] += 1
    print(json.dumps(counts, sort_keys=True))


if __name__ == '__main__':
    main()
