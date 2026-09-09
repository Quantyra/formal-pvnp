"""Fixed, outward-rounded interval Taylor certificate for ONE nine-state IVP.

No search/restarts/tolerance sweep. Decimal operations use directed contexts.
Order16, h=1/32, xi=16. Intended to certify only this example's orthant entry.
"""
import json
from decimal import Decimal, Context, ROUND_FLOOR, ROUND_CEILING

DOWN = Context(prec=70, rounding=ROUND_FLOOR)
UP = Context(prec=70, rounding=ROUND_CEILING)
ORDER, STEPS = 16, 512
CLAUSES = ((-1, -1, -1), (-1, 1, 1), (1, -1, 1),
           (1, 1, -1), (1, 1, 1))


def point(n):
    d = Decimal(n)
    return d, d


ZERO, ONE = point(0), point(1)


def add(a, b):
    return DOWN.add(a[0], b[0]), UP.add(a[1], b[1])


def neg(a):
    return a[1].copy_negate(), a[0].copy_negate()


def mul(a, b):
    # Choose the exact extremizing endpoint pairs by their signs.
    al, ah = a
    bl, bh = b
    if al >= 0:
        pairs = ((al, bl), (ah, bh)) if bl >= 0 else (
            ((ah, bl), (al, bh)) if bh <= 0 else ((ah, bl), (ah, bh)))
    elif ah <= 0:
        pairs = ((al, bh), (ah, bl)) if bl >= 0 else (
            ((ah, bh), (al, bl)) if bh <= 0 else ((al, bh), (al, bl)))
    elif bl >= 0:
        pairs = ((al, bh), (ah, bh))
    elif bh <= 0:
        pairs = ((ah, bl), (al, bl))
    else:
        lows = (DOWN.multiply(al, bh), DOWN.multiply(ah, bl))
        highs = (UP.multiply(al, bl), UP.multiply(ah, bh))
        return min(lows), max(highs)
    return DOWN.multiply(*pairs[0]), UP.multiply(*pairs[1])


def div_int(a, n):
    assert n > 0
    return DOWN.divide(a[0], Decimal(n)), UP.divide(a[1], Decimal(n))


def psum(*polys):
    return [sum_i([p[k] for p in polys]) for k in range(len(polys[0]))]


def sum_i(vals):
    r = ZERO
    for v in vals:
        r = add(r, v)
    return r


def pneg(p):
    return [neg(v) for v in p]


def prod(a, b):
    return [sum_i(mul(a[j], b[k-j]) for j in range(k+1)) for k in range(len(a))]


def scale(p, n, denominator=1):
    return [div_int(mul(v, point(n)), denominator) for v in p]


def rhs(jets, active):
    degree = len(jets[0])
    one = [ONE]+[ZERO]*(degree-1)
    zero = [ZERO]*degree
    s, b, rho = jets[:3], jets[3:8], jets[8]
    factors = {(i,c): psum(one, scale(s[i], -c))
               for i in range(3) for c in (-1,1)}
    ks, kis = [], []
    for c in CLAUSES:
        f = [factors[i,c[i]] for i in range(3)]
        ki = [scale(prod(f[(i+1)%3], f[(i+2)%3]), 1, 8) for i in range(3)]
        kis.append(ki)
        ks.append(prod(f[0], ki[0]))
    g = [zero[:] for _ in range(3)]
    hs = []
    for m,c in enumerate(CLAUSES):
        bk = prod(b[m], ks[m])
        for i in range(3):
            g[i] = psum(g[i], scale(prod(bk, kis[m][i]), 2*c[i]))
        hs.append(psum(ks[m], one) if m == active else ks[m])
    mean = psum(*(prod(b[m], hs[m]) for m in range(5)))
    db = [prod(prod(rho,b[m]), psum(hs[m],pneg(mean))) for m in range(5)]
    drho = pneg(prod(prod(rho,rho),mean))
    return g+db+[drho]


def taylor(initial, active, order):
    jets = [[v] for v in initial]
    for k in range(order):
        deriv = rhs(jets, active)
        for i in range(9):
            jets[i].append(div_int(deriv[i][k], k+1))
    return jets


def evaluate(jets, step):
    out = []
    for p in jets:
        v = p[-1]
        for a in reversed(p[:-1]):
            v = add(mul(v,step),a)
        out.append(v)
    return out


def main():
    h = div_int(ONE,32)
    y = [div_int(ONE,8),div_int(ONE,4),div_int(point(3),8)]+[div_int(ONE,5)]*6
    # True-path derivative bounds from cube/simplex invariance:
    # |s'|<=1, |b'|<=2/5, |rho'|<=2/25, rho nonincreasing.
    speeds = [ONE]*3+[div_int(point(2),5)]*5+[div_int(point(2),25)]
    limits = [(Decimal(-1),Decimal(1))]*3+[(Decimal(0),Decimal(1))]*5+[(Decimal(0),Decimal('0.2'))]
    hp = ONE
    for _ in range(ORDER):
        hp = mul(hp,h)
    milestones = []
    for j in range(STEPS):
        active = (j//32)%5
        tube = []
        for i in range(9):
            reach = mul(h,speeds[i])[1]
            lo = max(limits[i][0],DOWN.subtract(y[i][0],reach))
            hi = min(limits[i][1],UP.add(y[i][1],reach))
            if i == 8:
                hi = min(hi,y[i][1])
            assert lo <= hi
            tube.append((lo,hi))
        center_jets = taylor(y,active,ORDER-1)
        remainder_jets = taylor(tube,active,ORDER)
        center = evaluate(center_jets,h)
        y = [add(center[i],mul(hp,remainder_jets[i][ORDER])) for i in range(9)]
        y = [(max(v[0],limits[i][0]),min(v[1],limits[i][1])) for i,v in enumerate(y)]
        assert all(lo<=hi for lo,hi in y)
        if (j+1)%32 == 0:
            mark={"xi":(j+1)//32,"spins":[[str(a),str(b)] for a,b in y[:3]]}
            milestones.append(mark)
            print(json.dumps(mark),flush=True)
    signs = tuple(-1 if hi<0 else 1 if lo>0 else 0 for lo,hi in y[:3])
    verified = 0 not in signs and all(any(c[i]*signs[i]==1 for i in range(3)) for c in CLAUSES)
    print(json.dumps({"validated_endpoint":verified,"signs":signs,
                      "order":ORDER,"steps":STEPS,"precision":70,
                      "endpoint":[[str(a),str(b)] for a,b in y]},indent=2),flush=True)
    if not verified:
        raise SystemExit(2)


if __name__ == '__main__':
    main()
