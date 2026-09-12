"""Independent checks of the ten saved S3060 fixtures; no author imports."""
import hashlib
import itertools
import json
from pathlib import Path


def span(vectors):
    result = {0}
    for vector in vectors:
        result |= {v ^ vector for v in list(result)}
    return result


def affine_seeds(cnf, n):
    buckets = {}
    for clause in cnf:
        support = tuple(sorted({abs(v) for v in clause}))
        buckets.setdefault(support, []).append(clause)
    equations = []
    for support, clauses in buckets.items():
        if len(support) > 3:
            continue
        allowed = []
        for x in range(1 << len(support)):
            values = {v: x >> j & 1 for j, v in enumerate(support)}
            if all(any(values[abs(v)] == int(v > 0) for v in c) for c in clauses):
                allowed.append(x)
        assert allowed
        hull = {allowed[0] ^ d for d in span(x ^ allowed[0] for x in allowed)}
        if set(allowed) != hull:
            continue
        for mask in range(1, 1 << len(support)):
            rhs = (mask & allowed[0]).bit_count() % 2
            if all((mask & x).bit_count() % 2 == rhs for x in allowed):
                original = sum(1 << (v - 1) for j, v in enumerate(support) if mask >> j & 1)
                equations.append(original | rhs << n)
    return span(equations)


def clique(group, cnf):
    negative = {frozenset(-v for v in c) for c in cnf if len(c) == 2 and all(v < 0 for v in c)}
    assert all(frozenset(pair) in negative for pair in itertools.combinations(group, 2))


def main():
    root = Path(__file__).parent
    data = json.loads((root / '2026-09-11-counting-parity.json').read_text())
    for filename, expected in [('2026-09-11-counting-parity.py', data['script_sha256_lf']),
                               ('2026-09-11-mechanism-discovery.py', data['helper_sha256_lf'])]:
        assert hashlib.sha256((root / filename).read_bytes().replace(b'\r\n', b'\n')).hexdigest() == expected
    counts = {'fixtures': 0, 'fractional_clause_checks': 0, 'fractional_AMO_checks': 0,
              'even_AMO_deductions': 0, 'unit_reasons': 0, 'counting_certificates': 0,
              'odd_control_witnesses': 0, 'NAE_components': 0}
    for case in data['cases']:
        cnf, n = case['cnf'], case['n']
        seeds = affine_seeds(cnf, n)
        outcomes = case.get('results', {'hybrid': case.get('result')})
        for mode, outcome in outcomes.items():
            actual = span(mask | rhs << n for mask, rhs in outcome['rows'])
            assert actual == ({0} if mode == 'counting' else seeds)
        if case['family'] == 'interaction':
            halves = case['half_units']
            for clause in cnf:
                assert sum(halves[abs(v)-1] if v > 0 else 2-halves[abs(v)-1] for v in clause) >= 2
                counts['fractional_clause_checks'] += 1
            for group in case['groups']:
                clique(group, cnf)
                assert sum(halves[v-1] for v in group) <= 2
                counts['fractional_AMO_checks'] += 1
            fixed = {}
            outcome = outcomes['hybrid']
            for step in outcome['log']:
                if 'even_AMO_zero' in step:
                    group = step['even_AMO_zero']
                    clique(group, cnf)
                    assert sum(1 << (v-1) for v in group) in seeds
                    for v in group:
                        assert fixed.get(v, 0) == 0
                        fixed[v] = 0
                    counts['even_AMO_deductions'] += 1
                else:
                    literal, clause = step['unit'], step['clause']
                    assert frozenset(clause) in {frozenset(c) for c in cnf}
                    assert not any(abs(v) in fixed and fixed[abs(v)] == int(v > 0) for v in clause)
                    assert [v for v in clause if abs(v) not in fixed] == [literal]
                    fixed[abs(literal)] = int(literal > 0)
                    counts['unit_reasons'] += 1
            assert frozenset(outcome['reason']['empty_clause']) in {frozenset(c) for c in cnf}
            assert all(abs(v) in fixed and fixed[abs(v)] != int(v > 0) for v in outcome['reason']['empty_clause'])
            assert fixed == {int(v): b for v, b in outcome['fixed'].items()}
            assert all(len(c) >= 2 for c in cnf)
            assert all((1 << j) not in seeds and ((1 << j) | (1 << n)) not in seeds for j in range(n))
            assert outcomes['counting']['status'] == outcomes['parity']['status'] == 'OPEN'
        elif case['family'] == 'PHP_known_control':
            reason = outcomes['hybrid']['reason']
            groups, cert = reason['groups'], reason['aggregate']
            for group in groups:
                clique(group, cnf)
            positive = [c for c in cnf if all(v > 0 for v in c)]
            lower = [sum(i in c for c in positive) for i in range(1, n+1)]
            upper = [sum(i in g for g in groups) for i in range(1, n+1)]
            assert cert['L'] == lower and cert['U'] == upper
            assert cert['alpha'] > 0 and cert['beta'] > 0
            assert all(cert['alpha'] * l == cert['beta'] * u for l, u in zip(lower, upper))
            assert cert['lower'] == cert['alpha'] * len(positive)
            assert cert['upper'] == cert['beta'] * len(groups) < cert['lower']
            counts['counting_certificates'] += 1
        elif case['family'] == 'odd_SAT_control':
            k = case['k']
            true_vars = {1, k+2} | set(range(k+3, n+1))
            assert all(any((abs(v) in true_vars) == (v > 0) for v in c) for c in cnf)
            counts['odd_control_witnesses'] += 1
        else:
            assert case['family'] == 'NAE_obstruction' and seeds == {0}
            expected = []
            for block in range(case['copies']):
                for triple in itertools.combinations(range(5*block+1, 5*block+6), 3):
                    expected += [list(triple), [-v for v in triple]]
            assert cnf == expected and all(len(c) == 3 for c in cnf)
            # Exhaust just each five-variable component, never the product.
            for block in range(case['copies']):
                local = [c for c in cnf if 5*block < abs(c[0]) <= 5*block+5]
                assert not any(all(any(((x >> (abs(v)-1-5*block)) & 1) == int(v > 0) for v in c) for c in local) for x in range(32))
                counts['NAE_components'] += 1
        counts['fixtures'] += 1
    print(json.dumps(counts, sort_keys=True))


if __name__ == '__main__':
    main()
