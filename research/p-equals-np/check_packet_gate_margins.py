"""Exact margins and small Boolean checks; not a PDE or complexity test."""
from fractions import Fraction as F
from itertools import product
from math import factorial


def sat(x):
    return max(F(-1), min(F(1), x))


def nand(x, y):
    return sat(2 * (1 - x - y))


def negate(x):
    return nand(x, x)


def either(x, y):
    return nand(negate(x), negate(y))


def both(x, y):
    z = nand(x, y)
    return negate(z)


d = F(3, 32)
checked = 0
for x, y, dx, dy in product((-1, 1), (-1, 1), (-d, d), (-d, d)):
    sx, sy = x + dx, y + dy
    assert nand(sx, sy) == (-1 if x == y == 1 else 1)
    assert sat(2 * (sx + sy - 1)) == (1 if x == y == 1 else -1)
    assert sat(2 * (sx + sy + 1)) == (-1 if x == y == -1 else 1)
    assert sat(2 * sx) == x
    assert sat(-2 * sx) == -x
    checked += 1

# Taylor lower bound e^4 > 32 proves 2 e^-4 < 1/16.
assert sum(F(4**k, factorial(k)) for k in range(5)) > 32
for Q in (F(1), F(3, 2), F(4), F(100)):
    eps, sigma = 1 / (64 * Q), F(1, 64)
    assert Q * eps + sigma == F(1, 32)
    # Set chi*P2=1 and take the minimum diffusion part of gamma.
    gamma = 8 * Q
    assert Q * eps + sigma == gamma * eps / 4
    assert (Q * eps + sigma) + gamma * eps / 2 < gamma * eps


def compile_eval(clauses, bits):
    output = 1
    for clause in clauses:
        clause_bit = -1
        for var, positive in clause:
            literal = bits[var] if positive else negate(bits[var])
            clause_bit = either(clause_bit, literal)
        output = both(output, clause_bit)
    return output


# Every ordered CNF with <=2 clauses over the 9 non-tautological
# clauses on two variables (including the empty clause).
clauses = [tuple((i, s == 1) for i, s in enumerate(row) if s)
           for row in product((0, -1, 1), repeat=2)]
formulas = [()] + [(a,) for a in clauses] + list(product(clauses, repeat=2))
for formula in formulas:
    flag = -1
    truth = False
    for bits in product((-1, 1), repeat=2):
        expected = all(any((bits[v] == 1) == positive for v, positive in c)
                       for c in formula)
        result = compile_eval(formula, bits)
        assert result == (1 if expected else -1)
        flag = either(flag, result)
        truth |= expected
    assert flag == (1 if truth else -1)

print(f"PASS: {checked} gate corners; four source allocations; "
      f"Taylor write certificate; {len(formulas)} exhaustive small CNFs.")
