# Dissipative hypercube aggregation and its succinct-evaluation obligation

2026-09-08. S3040 / S008 / E004. Harness-only informal research.
Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-heat-aggregation-2026-09-08.md`.
Read with `INTEGRITY-CLAIMS.md` and the preceding inference attempts.
This is an explicitly defined finite-dimensional heat flow. It imports no
Navier--Stokes construction, physical device, analog-complexity theorem,
general SAT capability or P=NP conclusion. No simulation or code is used.

## A positive, contractive, globally defined aggregation flow

Let F be an explicit CNF of encoded length L, with n occurring variables
after relabeling, and let f(x) be its Boolean satisfaction indicator on
{0,1}^n. For n=0 evaluate directly. For n>=1 define one real coordinate
u_x for every Boolean assignment and the autonomous linear ODE

    u_x'(t)=sum_(i=1)^n [u_(x xor e_i)(t)-u_x(t)],
    u_x(0)=f(x).                                    (1)

The complete state has 2^n coordinates. Each flip operator T_i satisfies
T_i^2=I, and operators on different bits commute. On one bit,

    exp(t(T_i-I))=a(t) I+p(t) T_i,
    a(t)=(1+exp(-2t))/2, p(t)=(1-exp(-2t))/2.

Consequently the exact solution, for all t>=0, is

    u_x(t)=sum_y a(t)^(n-d(x,y)) p(t)^d(x,y) f(y),  (2)

where d is Hamming distance. This directly verifies global existence and
the differential equation; uniqueness follows for the finite linear IVP.
All coefficients are nonnegative and each row sums to1, since a+p=1.
Thus positivity is preserved, 0<=u_x(t)<=1, and for any two initial
vectors the sup-norm distance does not increase. This is a stable averaging
operation, not a singular clock or a diverging state amplitude.

With the explicitly normalized discrete energy

    E(t)=2^(-n) sum_x u_x(t)^2,

we have E(0)<=1 and, summing over unordered hypercube edges,

    E'(t)=-2^(1-n) sum_{edges {x,y}}(u_x-u_y)^2<=0. (3)

Equivalently the derivative is -2^(-n) times the sum over all directed
(x,i) edges. The same calculation proves contraction in this normalized
L2 norm for differences of solutions. The factor2^(-n) is part of the
chosen norm; it is not a proof of bounded physical preparation or hardware
energy. With unit weight per node, the unnormalized sum of squares can be
as large as2^n. Assigning each node a smaller physical volume would require
separate storage, coupling, resolution and readout accounting.

## A rigorous finite-time decision gap

At the fixed rational time t=1, exp(-2)<1/2, so p(1)>1/4 while
a(1)>1/2. Every transition coefficient from (2) is therefore at least

    g_n=4^(-n)=2^(-2n).

If F is UNSAT, f is identically0 and u_0(1)=0. If F is SAT, at least
one f(y)=1, and all terms are nonnegative, giving

    UNSAT: u_0(1)=0;     SAT: u_0(1)>=g_n.          (4)

An approximation v with guaranteed |v-u_0(1)|<=g_n/4 decides by the
rational threshold g_n/2. On UNSAT inputs v<=g_n/4; on SAT inputs
v>=3g_n/4. The requested additive accuracy is exponentially small as
a real quantity but requires only2n+O(1) precision bits. It is incorrect
to infer exponentially many description bits from this error scale.

This is a one-call polynomial reduction from SAT to the following precise
primitive: given a succinct CNF description of the initial indicator,
compute this single heat coordinate at time1 with additive error2^(-2n-2)
in uniformly polynomial bit time, for every input. The reduction constructs
only the succinct description, not the truth table. If that primitive
were implemented, (4) would give standard deterministic polynomial SAT
decision. The short modeled time and the explicit kernel do not themselves
implement it.

## Stability, precision and a dyadic propagator option

If the supplied initial vector differs from f in sup norm by at most
delta, (2) gives output error at most delta at every time. Such a bound is
not supplied merely by writing a short CNF circuit; it is a condition on
all represented initial values. Initial error at most g_n/16 plus numerical
evaluation error at most g_n/16, for example, remains safely within the
decision budget. Bounded but constant initial error would not preserve
the shrinking gap uniformly in n.

A normalized L2 initial error bound is a different statement. A conservative
pointwise consequence is |error_x(t)|<=2^(n/2)||error(0)||_(2,normalized),
using L2 contraction and the coordinate inequality. One cannot silently
treat those two norm tolerances as identical. Likewise a bounded energy
alone supplies no initial accuracy guarantee.

The exact solution has |u_x'|<=n because every coordinate lies in [0,1].
A timing displacement of magnitude h, within nonnegative times, therefore
changes the output by at most n|h|. Requiring |h|<=g_n/(16n) is a sufficient
timing budget with O(n+log n) description bits; no physical control-cost
claim follows from that description length.

The irrational constant in the kernel is not an infinite-precision oracle.
Approximating p by a rational p_hat in [0,1] changes the product-kernel
expectation of any f in [0,1] by at most n|p_hat-p|: replace the n bit
distributions one at a time and use that each conditional expected value
lies in [0,1]. Thus |p_hat-p|<=g_n/(16n) is sufficient for that error
budget. The constant exp(-2) is computable to b bits with polynomial work
by its alternating Taylor sum. For truncation degree K>=2 the remainder
is at most2^(K+1)/(K+1)!, and K=O(b) suffices; the rational intermediates
have polynomial bit length. Computing the kernel's scalar parameter is
therefore separate from evaluating its weighted sum against f.

There is also an exactly dyadic product propagator. At

    t_star=(log 2)/2,
    a(t_star)=3/4, p(t_star)=1/4,

equation (2) becomes

    u_0(t_star)=4^(-n) sum_{y:F(y)=true} 3^(n-|y|). (5)

Here t_star is explicitly an irrational time, not the rational time1 of
(4). One can instead regard (5) as applying the specified dyadic stochastic
matrix directly, with no implementation of an irrational clock claimed.
Its numerator is an integer between0 and4^n, so the exact output has
O(n) numerator and denominator bits. The same zero-versus-g_n gap holds.
Again a short rational answer format does not compute the weighted sum.

## Attempted succinct evaluation and its counted work

The initial predicate has a polynomial-size circuit: each clause is checked
and the results are conjoined. Evaluating f at one assignment costs O(L)
literal work. Explicitly materializing its entire initial vector takes
2^n such assignments and 2^n stored values in the direct representation.
An explicit right-hand-side pass in (1) uses n 2^n neighbor contributions.
That is work of this materialized implementation, not a lower bound on
every possible succinct algorithm.

A deterministic contraction attempt starts with R_0(x)=f(x) and eliminates
one bit at a time:

    R_i(x_(i+1),...,x_n)
      =a R_(i-1)(0,x_(i+1),...,x_n)
       +p R_(i-1)(1,x_(i+1),...,x_n).               (6)

Then R_n is exactly the requested coordinate. With a=3/4,p=1/4 this is
an entirely rational arithmetic construction. Direct summation or tables
give a finite exponential-work implementation with polynomial bit length
per entry. Circuit substitution can retain shared subexpressions, but
forming both restrictions repeatedly can expand the intermediate circuit;
no uniform polynomial compression/evaluation bound is proved by (6).
The work needed to find and certify such compression cannot be omitted.

The tensor product kernel makes the sampled input bits independent. It
does not make overlapping clauses independent. For the one-variable
formula F=(x) AND (not x), the correct expected satisfaction indicator is
E[x(1-x)]=0, while multiplying the separate clause expectations gives
p(1-p)>0 for t>0. Thus replacing expectation of the CNF conjunction by
the product of clause expectations is already incorrect on an UNSAT
example. Computing each small clause's average is not the missing global
aggregation algorithm.

The efficient-succinct-evaluation hypothesis following (4) supplies exactly
that missing work. The reduction proves a conditional consequence, not
its impossibility, not a counting-class claim, and not an equivalence in
the reverse direction. Bounded normalized energy, positive stable flow,
constant modeled evolution time, and O(n) output-precision bits are all
compatible with the unimplemented exponentially large aggregation.

## Outcome

The construction provides a globally stable dissipative system and a
rigorous finite-time SAT signal, with explicit precision and initial-error
bounds. It also gives an exact rational propagator and a concrete attempted
elimination recurrence. The remaining theorem is a uniformly polynomial
evaluation method for that recurrence from arbitrary succinct CNF input,
or another method computing the same required coordinate with its error
guarantee. No such method follows from this construction, and no physical
fluid implementation or full P=NP conclusion is obtained. No code,
simulations, commits or public claims are made in this increment.
