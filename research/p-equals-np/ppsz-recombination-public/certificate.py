"""Exact fixed-input certificate; no parameter optimization or SAT experiment.

Imports coefficient inequalities from Scheder arXiv:2207.11071v1,
Sections 7.8 and 8.4, with structural factor 12/11 from Section 7.1.
This certifies their algebraic recombination, not those imported proofs.
Run with Python's standard library. Output is deterministic JSON.
"""
from fractions import Fraction as Q
import json


def point(x):
    return (Q(x), Q(x))


def add(a, b):
    return a[0] + b[0], a[1] + b[1]


def neg(a):
    return -a[1], -a[0]


def sub(a, b):
    return add(a, neg(b))


def mul(a, b):
    ends = [x * y for x in a for y in b]
    return min(ends), max(ends)


def div(a, b):
    assert b[0] > 0
    return mul(a, (1 / b[1], 1 / b[0]))


def scale(a, q):
    return mul(a, point(q))


def fkl(x, terms=100):
    """Enclose (1-x) ln(1-x)+x by an exact Taylor tail."""
    assert 0 < x < 1
    partial = sum((x ** k / k for k in range(1, terms + 1)), Q(0))
    tail = x ** (terms + 1) / ((terms + 1) * (1 - x))
    return add(scale((-partial - tail, -partial), 1 - x), point(x))


def ln2(terms=100):
    z = Q(1, 3)
    partial = 2 * sum((z ** (2*k+1) / (2*k+1) for k in range(terms)), Q(0))
    tail = 2 * z ** (2*terms+1) / ((2*terms+1) * (1-z*z))
    return partial, partial + tail


def exp_positive(a, terms=100):
    assert 0 <= a[0] <= a[1] < 1
    def endpoints(x):
        term, partial = Q(1), Q(1)
        for k in range(1, terms+1):
            term = term*x/k
            partial += term
        first_omitted = term*x/(terms+1)
        tail = first_omitted / (1-x/(terms+2))
        return partial, partial + tail
    return endpoints(a[0])[0], endpoints(a[1])[1]


def outward(a, digits=22):
    """Decimal endpoints rounded outwards; internally all math is rational."""
    power = 10 ** digits
    lo = a[0].numerator * power // a[0].denominator
    hi = -((-a[1].numerator * power) // a[1].denominator)
    def dec(k):
        sign = '-' if k < 0 else ''
        k = abs(k)
        return f'{sign}{k // power}.{k % power:0{digits}d}'
    assert Q(dec(lo)) <= a[0] <= a[1] <= Q(dec(hi))
    return [dec(lo), dec(hi)]


r, i = Q('0.1'), Q('0.073')
assert 0 < r <= Q('0.1') and 0 < i <= Q('0.1') and 5 * i < 1
assert i <= Q(4, 5) and i <= Q(256, 600)
c_l = point(Q('0.00168728') * r - Q('0.00638') * r * r)
c_t = sub(point(Q('0.009307') - Q('0.0577') * r), scale(fkl(r), '0.1503'))
A = scale(c_l, Q(11, 12))
threshold = scale(A, Q(2) / Q('0.9'))
P = scale(threshold, Q('1.0302') * r)
S = sub(c_t, scale(A, 5))
b1 = sub(point(Q('0.030966') * i - Q('0.0028') * i * i), scale(fkl(i), '0.4027'))
b0 = sub(point(Q('0.06259') * i), scale(fkl(i), '0.344'))
bT = sub(point(Q('0.009307') - Q('0.2405') * i - Q('0.03125') * i * i), scale(fkl(5 * i), '0.06183'))
lam = div(b1, A)
margin0 = sub(b0, scale(b1, 2))
marginT = add(bT, mul(lam, S))
gamma_star = div(mul(b1, sub(A, P)), add(A, b1))
gamma = Q('0.0000684193')
assert A[0] > P[1] > 0 and b1[0] > 0
assert threshold[1] <= Q(1, 4678)
assert margin0[0] > 0 and marginT[0] > 0
assert gamma_star[0] > gamma > Q(1, 15218)
log_two = ln2()
runtime_base = exp_positive(mul(sub(sub(scale(log_two, 2), point(1)), point(gamma)), log_two))
assert runtime_base[1] < Q('1.306969924')
# The i1 coefficient vanishes identically: lambda*A=b1.
values = dict(A=A, threshold=threshold, P=P, S=S, b0=b0, b1=b1,
              bT=bT, lambda_value=lam, margin_i0=margin0,
              margin_tau=marginT, gamma_star=gamma_star,
              finite_strength_slack=sub(gamma_star, point(gamma)),
              unique_runtime_base=runtime_base)
print(json.dumps({
    'status': 'PASS: exact recombination of specified imported inequalities',
    'source': 'https://arxiv.org/pdf/2207.11071v1',
    'parameters': {'epsilon_R': str(r), 'epsilon_I': str(i),
                   'gamma': str(gamma), 'log_series_terms': 100},
    'intervals': {name: outward(value) for name, value in values.items()},
    'scope': 'No independent proof of source estimates, optimality, SAT run, or P-versus-NP conclusion.'
}, indent=2))
