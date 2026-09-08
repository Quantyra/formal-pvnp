"""Exact falsification checks for restricted payload-summary candidates.

Run from repository root: python research/p-equals-np/check_payload_summaries.py
No claim of a polynomial general SAT algorithm.
"""
from itertools import product
from random import Random


def normalize(clauses):
    cs = {frozenset(c) for c in clauses}
    cs = {c for c in cs if not any(-v in c for v in c)}
    return frozenset(c for c in cs if not any(d < c for d in cs))


def restrict(cs, assignment):
    return normalize(
        (v for v in c if abs(v) not in assignment)
        for c in cs
        if not any(abs(v) in assignment and assignment[abs(v)] == (v > 0) for v in c)
    )


def holds(cs, assignment):
    return all(any(assignment[abs(v)] == (v > 0) for v in c) for c in cs)


def eliminate(cs, v):
    """Exact existential projection by resolution, not a size guarantee."""
    pos = [c - {v} for c in cs if v in c]
    neg = [c - {-v} for c in cs if -v in c]
    return normalize([c for c in cs if v not in c and -v not in c]
                     + [a | b for a in pos for b in neg])


def bits(n):
    return product((False, True), repeat=n)


def equality(k):
    return normalize([(i, -(k+i)) for i in range(1, k+1)]
                     + [(-i, k+i) for i in range(1, k+1)])


def xor_gate(a, b, c):
    # c = a XOR b: forbid exactly the four incorrect triples.
    return [tuple(-v if bit else v for v, bit in zip((a, b, c), row))
            for row in bits(3) if row[2] != (row[0] ^ row[1])]


def even_parity_chain(k):
    # y_2=x_1 XOR x_2; y_i=y_(i-1) XOR x_i; y_k=0.
    clauses = xor_gate(1, 2, k+1)
    for i in range(3, k+1):
        clauses += xor_gate(k+i-2, i, k+i-1)
    clauses.append((-(2*k-1),))
    return normalize(clauses)


def affine_hull(points):
    if not points:
        return frozenset()
    origin = min(points)
    span = {0}
    for p in points:
        delta = p ^ origin
        span |= {s ^ delta for s in tuple(span)}
    return frozenset(s ^ origin for s in span)


def boolean_multiply(a, b):
    return tuple(tuple(any(a[i][h] and b[h][j] for h in range(4))
                       for j in range(4)) for i in range(4))


def chain_endpoint(factors):
    # Factor i constrains x_i,x_(i+1),x_(i+2). Index pairs by 2*a+b.
    matrices = []
    for factor in factors:
        matrix = [[False]*4 for _ in range(4)]
        for a, b, c in bits(3):
            matrix[2*a+b][2*b+c] = (a, b, c) in factor
        matrices.append(tuple(tuple(row) for row in matrix))
    while len(matrices) > 1:
        matrices = [boolean_multiply(matrices[i], matrices[i+1])
                    if i+1 < len(matrices) else matrices[i]
                    for i in range(0, len(matrices), 2)]
    return any(any(row) for row in matrices[0])


def run():
    residual_counts = []
    for k in range(1, 9):
        cs = equality(k)
        residuals = {restrict(cs, dict(zip(range(1, k+1), row))) for row in bits(k)}
        assert len(residuals) == 2**k
        # Interleaving paired variables leaves one live residual after each pair.
        live = set()
        for row in bits(2*min(k, 3)):
            order = [v for i in range(1, min(k, 3)+1) for v in (i, k+i)]
            r = restrict(cs, dict(zip(order, row)))
            if frozenset() not in r:
                live.add(r)
        assert len(live) == 1
        residual_counts.append((k, len(residuals)))

    parity_counts = []
    for k in range(2, 9):
        projected = even_parity_chain(k)
        for v in range(k+1, 2*k):
            projected = eliminate(projected, v)
        expected = normalize(tuple(-v if b else v for v, b in enumerate(row, 1))
                             for row in bits(k) if sum(row) % 2)
        assert projected == expected
        assert len(projected) == 2**(k-1)
        for row in bits(k):
            assert holds(projected, dict(enumerate(row, 1))) == (sum(row) % 2 == 0)
        parity_counts.append((k, len(projected)))

    rng = Random(3040)
    checked = 0
    for _ in range(300):
        n = rng.randrange(1, 7)
        cs = normalize([tuple(rng.choice((-1, 1))*rng.randrange(1, n+1)
                              for _ in range(rng.randrange(0, 5)))
                        for _ in range(rng.randrange(0, 13))])
        order = list(range(1, n+1))
        rng.shuffle(order)
        current = cs
        removed = []
        for v in order:
            current = eliminate(current, v)
            removed.append(v)
            remaining = [u for u in range(1, n+1) if u not in removed]
            for row in bits(len(remaining)):
                a = dict(zip(remaining, row))
                oracle = any(holds(cs, a | dict(zip(removed, ext)))
                             for ext in bits(len(removed)))
                assert holds(current, a) == oracle
                checked += 1

    # All affine subsets of a two-bit pair avoiding 00 have at most two points.
    for mask in range(16):
        subset = frozenset(i for i in range(4) if mask & (1 << i))
        if subset == affine_hull(subset) and 0 not in subset:
            assert len(subset) <= 2
    assert affine_hull({1, 2, 3}) == frozenset(range(4))
    # Affine-hull relaxation of the four clauses forbidding every two-bit input.
    forbidden_clauses = [frozenset(set(range(4)) - {excluded}) for excluded in range(4)]
    assert not set.intersection(*(set(c) for c in forbidden_clauses))
    assert set.intersection(*(set(affine_hull(c)) for c in forbidden_clauses)) == set(range(4))
    and_graph = frozenset((a << 2) | (b << 1) | (a & b) for a, b in bits(2))
    for mask in range(16):
        subset = frozenset(p for i, p in enumerate(sorted(and_graph)) if mask & (1 << i))
        if subset == affine_hull(subset):
            assert len(subset) <= 2
    connected_width_counts = []
    for k in range(1, 7):
        outputs = set()
        rows = 0
        for inputs in bits(2*k):
            c = tuple(inputs[2*i] & inputs[2*i+1] for i in range(k))
            d = tuple(c[i] ^ c[i+1] for i in range(k-1)) + (c[-1],)
            recovered = [False]*k
            recovered[-1] = d[-1]
            for i in range(k-2, -1, -1):
                recovered[i] = d[i] ^ recovered[i+1]
            assert tuple(recovered) == c
            outputs.add(d)
            rows += 1
        assert rows == 4**k and len(outputs) == 2**k
        connected_width_counts.append((k, rows, len(outputs), 2**k))
    # Connected overlapping triples: random exact factors, not independent clauses.
    chain_checks = 0
    chain_yes = 0
    for n in range(3, 11):
        for _ in range(40):
            factors = [frozenset(row for row in bits(3) if rng.randrange(4) != 0)
                       for _ in range(n-2)]
            if chain_checks % 5 == 0:
                # Individually nonempty but incompatible overlap, for n >= 4.
                factors[0] = frozenset(row for row in bits(3) if not row[1])
                if len(factors) > 1:
                    factors[1] = frozenset(row for row in bits(3) if row[0])
            oracle = any(all(tuple(row[i:i+3]) in factor for i, factor in enumerate(factors))
                         for row in bits(n))
            assert chain_endpoint(factors) == oracle
            chain_yes += oracle
            chain_checks += 1
    print('equality prefix residuals:', residual_counts)
    print('parity projected CNF clauses:', parity_counts)
    print('random exact existential-projection checks:', checked)
    print('affine subset/cardinality and false-positive relaxation checks: PASS')
    print('connected triple-chain matrix checks:', chain_checks,
          'YES:', chain_yes, 'NO:', chain_checks-chain_yes)
    print('connected AND-difference (k, nonzeros, rectangle min, affine-cover lower):',
          connected_width_counts)
    print('No all-input polynomial endpoint theorem established.')


if __name__ == '__main__':
    run()
