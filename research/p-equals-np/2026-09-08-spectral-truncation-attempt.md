# A spectral cutoff test for succinct heat aggregation

2026-09-08. S3040 / S008 / E004. Harness-only informal research.
Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-spectral-truncation-2026-09-08.md`.
Read with `INTEGRITY-CLAIMS.md` and the heat-aggregation attempt. The
finite Fourier and kernel arguments here are derived directly; no general
complexity lower bound or external spectral theorem is imported. No
simulation, implementation or P=NP claim is supplied.

## Exact Walsh expansion and a pointwise error budget

Let f be the Boolean SAT indicator of a CNF on n>=1 occurring variables;
handle n=0 directly. For S a subset of {1,...,n}, define

    chi_S(x)=(-1)^(sum_(i in S)x_i),
    f_hat(S)=2^(-n) sum_x f(x)chi_S(x),
    alpha=f_hat(empty)=2^(-n)sum_x f(x).

Summing chi_S chi_T over the cube gives1 after normalization if S=T,
and0 otherwise, by cancellation in any coordinate of their symmetric
difference. These 2^n orthonormal vectors form a basis, so inversion
and Parseval give

    f(x)=sum_S f_hat(S)chi_S(x),
    sum_S f_hat(S)^2=2^(-n)sum_x f(x)^2=alpha.

For the generator L=sum_i(T_i-I), flipping a coordinate in S changes
the character's sign; other flips leave it unchanged. Thus
L chi_S=-2|S|chi_S. With r=exp(-2t), the exact solution is

    u_x(t)=sum_S r^|S| f_hat(S)chi_S(x).             (1)

The degree-d truncation, 0<=d<=n, retains exactly the subsets with
|S|<=d. For d<n, Cauchy--Schwarz and Parseval give the uniform pointwise
bound

    |u_x-U_(d,x)|
      <=sqrt(sum_(|S|>d) f_hat(S)^2)
         sqrt(sum_(k=d+1)^n binom(n,k) r^(2k))
      <=sqrt(alpha-alpha^2)
         sqrt(sum_(k=d+1)^n binom(n,k) r^(2k))
      <=(1/2)sqrt(sum_(k=d+1)^n binom(n,k) r^(2k)). (2)

The variance bound applies because d>=0 excludes the constant mode.
Another valid bound, using f>=0 and |f_hat(S)|<=alpha, is

    |u_x-U_(d,x)|<=alpha sum_(k=d+1)^n binom(n,k)r^k. (3)

For d=n the tail is exactly0. Equations (2)--(3) control pointwise
readout error, not just average energy. Their scalar binomial expressions
are short descriptions; evaluating them does not compute the retained
Fourier coefficients. If those coefficients have errors eta_S, the final
error includes the additional term sum_(|S|<=d)r^|S| |eta_S|. For example,
with D_d=sum_(k=0)^d binom(n,k) retained coefficients, per-coefficient
error at most epsilon/(2D_d) and a tail bound epsilon/2 suffice.
When epsilon=2^(-2n-2), this still asks for only O(n) bits per coefficient;
the number of coefficients and the work computing them remain separate.

## The fixed-time singleton test requires a linear degree cutoff

Use the explicit unit-clause formula

    F_n=(not x_1) AND ... AND (not x_n).

Its indicator is supported only at 0^n, so every Fourier coefficient is
exactly2^(-n). At x=0 all characters equal1. Thus at rational time t=1
the omitted terms have no cancellation, and for d<n their exact sum is

    u_0(1)-U_(d,0)(1)
      =2^(-n)sum_(k=d+1)^n binom(n,k)exp(-2k)
      >=2^(-n)exp(-2(d+1)).                         (4)

The preceding heat decision budget is epsilon=4^(-n)/4=2^(-2n-2).
For the cutoff error to be at most that budget, (4) necessarily requires

    d+1 >= ((n+2)log 2)/2.                         (5)

This is only a necessary condition; it does not assert that degree (5)
is sufficient. If d=n no term is omitted, but the representation already
retains all2^n modes. Otherwise log 2>1/2 implies d>n/4-1/2, and hence
d>=floor(n/4). Therefore an explicit all-subsets degree cutoff meeting
the budget retains at least

    D_d>=2^floor(n/4).                              (6)

To see the last inequality without an asymptotic estimate, include all
subsets of a fixed set of floor(n/4) variables. Every corresponding
coefficient in this example is nonzero. Listing those coefficients and
terms takes exponential space/work for that explicit representation.
The formula has only n unit clauses and encoded length O(n log n), so
this listing cost is superpolynomial in its explicit input length.

This is not an evaluation lower bound for the singleton function. In fact

    u_0(t)=2^(-n)(1+exp(-2t))^n=a(t)^n,

which has a simple product evaluator with polynomial bit work at the
requested precision. Its many identical Fourier coefficients also have
a short shared description. Equations (5)--(6) reject only the proposed
explicit degree-cutoff enumeration as a uniform polynomial evaluator.

The dyadic propagator from the previous note supplies an even sharper
test of that same representation. At t_star=(log 2)/2, r=1/2. For every
proper cutoff d<n, the omitted degree-n term alone is4^(-n), larger
than epsilon. Thus every mode must be retained by an explicit degree
cutoff at this time. Yet the exact singleton answer is simply(3/4)^n.
The time t_star is irrational; this statement is also interpretable as
the exactly specified dyadic propagator, not a rational-clock claim.
Failure of the approximation contract is not failure to classify this
easy SAT example: even its degree0 value2^(-n) exceeds the decision
threshold4^(-n)/2 and would give the correct YES answer here.

## Polynomial extra smoothing yields a true scalar approximation

Now choose the rational time t=2n. This is a different evaluation horizon
from t=1. The product heat kernel has one-bit probabilities (1+r)/2 and
(1-r)/2, where r=exp(-4n). Each one-bit law differs from a fair bit by
TV distance r/2. Telescoping the n product measures gives total variation
at most n r/2: change one factor at a time, with the remaining probability
factors having L1 norm1. The expectation of f in [0,1] changes by at
most this TV distance. Consequently, at every cube vertex,

    |u_x(2n)-alpha|<= (n/2)exp(-4n)
       < n/(2*16^n) <= 4^(-n)/8.                  (7)

Here exp(2)>4 follows already from the first three positive terms of its
series. The last inequality is equivalent to4n<=4^n, valid for n>=1
by induction. This is a pointwise kernel bound, not a claim inferred
only from L2 energy decay.

Thus at this polynomial horizon the degree0 approximation alone has
truncation error below half the old epsilon budget. If alpha were computed
to additive4^(-n)/8, the constant approximation would meet the full
epsilon=4^(-n)/4 readout budget. This is a genuine analytical compression
of the smoothed output to one scalar. It has not computed that scalar.

In particular the mean is conserved by (1):

    alpha=#SAT(F)/2^n.

It is0 for UNSAT and at least2^(-n) for SAT. Computing alpha to additive
2^(-n)/4 alone would already decide SAT by threshold2^(-n)/2. That
accuracy uses n+O(1) bits; computing it remains the substantive primitive.
If the goal is the tighter heat-coordinate approximation just described,
the sufficient alpha accuracy instead uses2n+O(1) bits. Neither output
length proves a polynomial evaluation procedure.

The original heat gap also remains valid at2n, since its one-bit flip
probability is at least its value at1. Alternatively, (7) and the SAT
lower bound on alpha directly give
u_x(2n)>=2^(-n)-4^(-n)/8 on SAT inputs, while UNSAT still gives0.
Longer modeled time improves the spectral tail, but it does not supply
the globally aggregated initial mean for free.

## The coefficient primitive left unresolved

For general F, even the first retained coefficient is the full uniform
average of its satisfaction indicator. Other coefficients are signed
averages over satisfying assignments, not values furnished by the short
CNF description. Direct truth-table summation computes them with
exponential work; the previous coordinate-averaging recurrence at fair
bit weights computes the constant mode if its intermediate functions can
be represented and evaluated efficiently. No uniform polynomial bound
for that compression has been proved here.

The singleton example shows that special spectral structure can genuinely
be exploited without listing every retained mode. At time2n, a tail bound
also removes all nonconstant modes from the desired approximation budget.
The missing result is a uniform efficient way to compute the required
constant coefficient, or another succinct evaluation method for arbitrary
CNF, including its bit-work/error guarantee. A polynomial implementation
of that coefficient primitive at the displayed SAT gap would itself
yield a deterministic polynomial SAT decision algorithm. This is a
self-contained one-way reduction, not an impossibility or converse claim.

Accordingly, this increment supplies exact truncation bounds, a precise
failure of one explicit spectral listing scheme, and a valid longer-time
scalar approximation. It supplies no general coefficient algorithm, SAT
deadline or P=NP result. No simulations, code, commits or public claims
are made.
