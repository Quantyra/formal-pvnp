"""Exact pair-mask projection, certificates, and cumulative-cost attempt.

Finite tests, not an all-input polynomial bound. Standard library only.
"""
from itertools import combinations, product
from random import Random
from check_payload_summaries import normalize, holds


def mask_groups(cnf, pair, domain):
    groups = {}
    for clause in cnf:
        local = frozenset(v for v in clause if abs(v) in pair)
        rest = clause - local
        mask = sum(1 << i for i, row in enumerate(domain)
                   if not any(row[pair.index(abs(v))] == (v > 0) for v in local))
        if mask:
            groups.setdefault(mask, []).append((rest, clause))
    return groups


def covers(groups, size):
    full = (1 << size) - 1
    masks = sorted(groups)
    for k in range(1, size + 1):
        for choice in combinations(masks, k):
            union = 0
            for mask in choice:
                union |= mask
            if union != full:
                continue
            minimal = True
            for omitted in choice:
                union = 0
                for mask in choice:
                    if mask != omitted:
                        union |= mask
                if union == full:
                    minimal = False
                    break
            if minimal:
                yield choice


def certificate(clause, sources, pair, domain):
    """At most four weakenings and three resolution steps; checked structurally."""
    leaves = {}
    for row in product((False, True), repeat=2):
        forbidden = frozenset(-v if b else v for v, b in zip(pair, row))
        if row not in domain:
            # Explicit domain clause is part of the input specification.
            source = forbidden
        else:
            source = next(c for c in sources if
                          all(abs(v) not in pair or row[pair.index(abs(v))] != (v > 0)
                              for v in c))
        weakened = clause | forbidden
        assert source <= weakened
        leaves[row] = weakened
    a, b = pair
    mids = []
    for av in (False, True):
        left, right = leaves[av, False], leaves[av, True]
        assert b in left and -b in right
        mids.append((left - {b}) | (right - {-b}))
    assert a in mids[0] and -a in mids[1]
    assert (mids[0] - {a}) | (mids[1] - {-a}) == clause


def project(cnf, pair, domain=None):
    domain = tuple(product((False, True), repeat=2)) if domain is None else tuple(domain)
    if not domain:
        return frozenset({frozenset()}), 1, 0
    groups = mask_groups(cnf, pair, domain)
    output, generated, checked = [], 0, 0
    for cover in covers(groups, len(domain)):
        for chosen in product(*(groups[mask] for mask in cover)):
            generated += 1
            clause = frozenset().union(*(entry[0] for entry in chosen))
            if any(-v in clause for v in clause):
                continue
            certificate(clause, [entry[1] for entry in chosen], pair, domain)
            checked += 1
            output.append(clause)
    return normalize(output), generated, checked


def factored_value(cnf, pair, domain, assignment):
    if not domain:
        return False
    groups = mask_groups(cnf, pair, domain)
    # G_mask is AND of outside residual clauses in its group.
    values = {mask: holds([entry[0] for entry in entries], assignment)
              for mask, entries in groups.items()}
    return all(any(values[mask] for mask in cover)
               for cover in covers(groups, len(domain)))


def adaptive_endpoint(cnf, n):
    remaining = list(range(1, n + 1))
    if n % 2:
        remaining.append(n + 1)  # unused padding variable
    trace = [len(cnf)]
    generated_total = certificate_total = 0
    while remaining and cnf and frozenset() not in cnf:
        options = []
        for pair in combinations(remaining, 2):
            projected, generated, checked = project(cnf, pair)
            generated_total += generated  # charge rejected candidate pairs too
            certificate_total += checked
            options.append((len(projected), sum(map(len, projected)), pair, projected))
        _, _, pair, cnf = min(options, key=lambda x: x[:3])
        remaining = [v for v in remaining if v not in pair]
        trace.append(len(cnf))
    return frozenset() not in cnf, trace, generated_total, certificate_total


def main():
    rng = Random(304008)
    comparisons = certificates = 0
    domains = [tuple(row for i, row in enumerate(product((False, True), repeat=2))
                     if mask & (1 << i)) for mask in range(16)]
    for case in range(160):
        n = rng.randint(2, 6)
        cnf = normalize([tuple(v if rng.randrange(2) else -v
                               for v in rng.sample(range(1, n + 1), rng.randint(0, min(n, 4))))
                         for _ in range(rng.randint(0, 18))])
        pair = tuple(rng.sample(range(1, n + 1), 2))
        outside = [v for v in range(1, n + 1) if v not in pair]
        for domain in domains:
            result, _, checked = project(cnf, pair, domain)
            certificates += checked
            for row in product((False, True), repeat=len(outside)):
                assignment = dict(zip(outside, row))
                expected = any(holds(cnf, assignment | dict(zip(pair, local))) for local in domain)
                assert holds(result, assignment) == expected
                assert factored_value(cnf, pair, domain, assignment) == expected
                comparisons += 1
    yes = no = total_generated = total_certificates = 0
    for case in range(80):
        n = rng.randint(2, 7)
        cnf = normalize([tuple(v if rng.randrange(2) else -v
                               for v in rng.sample(range(1, n + 1), rng.randint(1, min(n, 3))))
                         for _ in range(rng.randint(n, 4*n))])
        expected = any(holds(cnf, dict(zip(range(1, n+1), row)))
                       for row in product((False, True), repeat=n))
        result, _, generated, checked = adaptive_endpoint(cnf, n)
        assert result == expected
        yes += result
        no += not result
        total_generated += generated
        total_certificates += checked
    # Actual pair-crossing conjunction, domains include the c=0 AND case.
    # Three singleton masks give t^3 distinct surviving projected clauses.
    for t in range(1, 6):
        pair = (1, 2)
        domain = ((False, False), (False, True), (True, False))
        cnf = normalize([(1, 2, 3+i) for i in range(t)]
                        + [(1, -2, 3+t+i) for i in range(t)]
                        + [(-1, 2, 3+2*t+i) for i in range(t)])
        projected, generated, checked = project(cnf, pair, domain)
        assert len(projected) == generated == checked == t**3
        assert len(cnf) == 3*t
        print(f"three-state crossing t={t}: {len(cnf)} input clauses -> {len(projected)} clauses; factored outer cover=1")
    print(f"local truth comparisons: {comparisons}; non-tautological certificates: {certificates}")
    print(f"adaptive endpoint: 80 instances ({yes} YES, {no} NO); charged generated clauses {total_generated}; certificates {total_certificates}")
    print("PASS: finite exactness/certificate checks; no polynomial total-work claim")


if __name__ == '__main__':
    main()
