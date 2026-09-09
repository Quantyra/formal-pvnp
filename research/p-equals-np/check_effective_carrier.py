"""Exact checks of conditional initialization inequalities, not of the PDE."""
from fractions import Fraction as F


def ceil(x):
    return -(-x.numerator // x.denominator)


def clog2_int(x):
    assert x >= 1
    return (x - 1).bit_length()


def floordyadic(x):
    """A strictly positive power of two <= positive rational x."""
    assert x > 0
    k = x.numerator.bit_length() - x.denominator.bit_length()
    y = F(2**k) if k >= 0 else F(1, 2**(-k))
    return y / 2 if y > x else y


def initializer(M, h, km, fm, B, C, wm, delta, b):
    c = 0
    while 2**c < 1 + 8*h*km/fm:
        c += 1
    p = clog2_int(M+1)
    S = ceil(F(p+c)/(h*km))
    R = ceil(B*S)
    E = F(1, 2**(2*R))
    eps = delta*E/4
    x0 = floordyadic(min(b/2, delta*(B+wm)*E/(4*C)))
    # exp(BS)<=4**R and exp(h km S)>=2**(p+c).
    assert h*km*S >= p+c
    assert B*S <= R
    assert fm*(2**(p+c)-1)/(h*km) > 8*M
    assert eps/E + C*x0/((B+wm)*E) <= delta/2
    assert 0 < x0 <= b/2
    return S, R


def cutoff(j, previous_N, requirements):
    N = max(1, previous_N+1)
    while True:
        if all(F(N,2)+1 >= P/alpha and
               clog2_int(ceil(C)) + ceil(P)*clog2_int(1+N)
               - (alpha*N).__floor__() <= -j
               for C,P,alpha in requirements):
            return N
        N += 1


if __name__ == '__main__':
    # Uniform axis estimates using actual source-prescribed formulas, with
    # interval triangle bounds valid for ALL permitted h,j0,eta in the box.
    eta_max, h_max, j_max = F(1,40), F(1,100), F(1,20)
    q_deviation = 2*eta_max*(4*eta_max+j_max)
    w_deviation = 8*h_max*eta_max**2+j_max*eta_max
    a_lower = 4+F(1,2)-h_max-12*eta_max**2-2*j_max*eta_max
    a_upper = 4+F(1,2)+2*j_max*eta_max
    assert q_deviation < F(1,100)
    assert w_deviation < F(1,100)
    assert 4 < a_lower < a_upper < 5
    assert j_max/4 + F(1,100) < eta_max
    assert F(20,361) < F(1,18)
    sets = [
        (F(1,200),F(1,2),F(1,2),F(6),F(10),F(1),F(1,100),F(1,100)),
        (F(1,128),F(3,4),F(1,16),F(5),F(7,3),F(2),F(1,32),F(1,64)),
    ]
    count = 0
    for args in sets:
        for M in (1,2,3,15,16,17,255,256,257,2**50):
            initializer(M,*args)
            count += 1
    Ns=[]
    prev=0
    for j in range(1,9):
        req=[(F(2**(j+3)),F(j,2),F(j,200)),
             (F(3*j),F(j+1),F(1,3))]
        N=cutoff(j,prev,req)
        assert N >= prev+1
        # Check the rational upper bound before logarithmic relaxation.
        for C,P,alpha in req:
            assert C*(1+N)**ceil(P) <= F(2)**((alpha*N).__floor__()-j)
        Ns.append(N)
        prev=N
    print(f'PASS: {count} conditional initializers; 8 cutoff stages')
    print('PASS: actual-source uniform axis triangle bounds and leading norm conversion')
    print('Cutoff dyadic exponents:', Ns)
    print('No actual-source derivative constants or fluid trajectories certified.')
