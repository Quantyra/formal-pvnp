# A local heat-bath implementation and its exact worst-start obstruction

2026-09-08. S3040 / S008 / E004. Harness-only informal research.
Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-local-gibbs-2026-09-08.md`.
Read with `INTEGRITY-CLAIMS.md` and the spin-distribution attempt.
This is a specific implementation candidate for the lifted distribution,
not a modification or analysis of the earlier analog ODE. No simulation,
general inference-hardness claim, SAT lower bound or P=NP result is supplied.

## Exact random-scan update and its counted cost

Handle n=0 by direct evaluation, and empty clauses or an empty conjunction
as in the predecessor. For the remaining explicit CNF F on n>=1 occurring
variables, retain

    q=2^(-2n), w(x)=q^(V_F(x)), pi(x)=w(x)/Z,

where V_F counts violated clauses. Given the current Boolean state x,
choose i uniformly from {1,...,n}. Let x^(i,b) set its ith bit to b.
Resample that bit with

    Pr[new bit=1 | x outside i]
       =w(x^(i,1))/(w(x^(i,0))+w(x^(i,1))).          (1)

This conditional is on all the other bits, not the prefix-only marginal
required by the preceding deterministic readout. The latter averages over
the unassigned bits and is not obtained by merely evaluating (1).

Weights are positive, so every one-bit transition has positive probability,
and staying put also has positive probability. For distinct x,y differing
in bit i,

    pi(x)P(x,y)=w(x)w(y)/[n Z(w(x)+w(y))]
              =pi(y)P(y,x).                         (2)

Summing detailed balance gives stationarity. The hypercube is connected;
the chain is irreducible with self-loops, and its stationary law is unique.
There is no finite-time obstruction to convergence: a finite block can
update every coordinate to any specified target with positive probability.
At each fixed n the minimum of such block probabilities over the finite
state space is positive, giving a contraction by successive blocks. This
argument promises neither a useful nor a polynomial rate.

To implement (1), cancel the clauses unaffected by i. If the incident
violation counts under bit0 and bit1 differ in absolute value by d<=M,
the Bernoulli probability is either 1/(1+2^(2nd)), its complement, or1/2.
These are exact rationals with O(nM) bits. A direct scan of F computes the
two counts in O(L) literal work. An exact rational Bernoulli A/D can be
sampled by drawing ceil(log2 D) fair bits, rejecting integers >=D, and
comparing an accepted integer with A. Each attempt succeeds with probability
greater than1/2, so expected random-bit and arithmetic work is polynomial
in L. Uniformly choosing i has the same elementary rejection implementation.
The rejection loops have no fixed deterministic worst-case bound; this is
an expected-cost randomized transition, not the earlier deterministic oracle.
Even granting unit cost per transition would not remove the obstruction below.

## An explicit growing equality-path family

For n>=2 take the 2(n-1)-clause formula

    F_n = AND_(i=1)^(n-1)
          [(not x_i OR x_(i+1)) AND (x_i OR not x_(i+1))].

For each edge, equal endpoint bits violate neither clause and different
bits violate exactly one. Therefore

    V_Fn(x)=sum_(i=1)^(n-1) indicator[x_i != x_(i+1)]. (3)

The first bit together with the n-1 edge-disagreement bits is a bijective
encoding of assignments. Consequently the exact partition function is

    Z_n=2(1+q)^(n-1),
    pi(0^n)=1/[2(1+q)^(n-1)]<=1/2.                 (4)

Complementation preserves (3), so every stationary single-bit marginal is
exactly1/2. The formula is satisfiable: both constant assignments satisfy it.

Start the actual chain at 0^n. An endpoint flip introduces one disagreement,
while an interior flip introduces two. Its exact one-step departure
probability, including n=2 where there are no interior sites, is

    r_n=(2/n) q/(1+q)+((n-2)/n) q^2/(1+q^2)
       <=q,
    r_n<=2q/n+q^2<=3q/n.                            (5)

The last inequality uses n q=n/4^n<=1 for n>=2. As long as the chain has
not departed, the state stays exactly 0^n and the departure probability
remains r_n. Thus after k integer steps,

    Pr[no departure through k]=(1-r_n)^k>=1-k r_n,
    Pr[X_k=0^n]>=1-k r_n.                           (6)

Returns after a departure can only increase the second probability.
With total variation defined as sup_A |mu(A)-pi(A)|, choose A={0^n}:

    ||law(X_k)-pi||_TV
      >=(1-r_n)^k-1/[2(1+q)^(n-1)]
      >=1/2-k r_n.                                 (7)

In particular, for every integer k<=n/(24q), the TV distance is at least
3/8. The worst-initial-state mixing time to error1/4 is therefore greater
than floor(n/(24q)), an Omega(n 4^n) obstruction to uniform polynomial
mixing for this particular chain. The explicit CNF has encoded length
O(n log n) with binary variable names. The bound is exponential in n and
superpolynomial in that encoded input length, without claiming exponential
growth in every possible encoding convention.

## The same obstruction directly affects marginal estimation

For any site i, reaching X_(k,i)=1 requires a departure. Hence

    Pr[X_(k,i)=1]<=k r_n,
    |Pr[X_(k,i)=1]-1/2|>=1/2-k r_n                 (8)

whenever the right side is positive. At the preceding horizons the bias
is at least3/8, which is larger than the required additive1/8. This is a
statement about the endpoint sampling distribution, not merely a TV bound
whose worst event might be irrelevant to the requested marginal.

For a raw empirical frequency using the same chain history through k,
the event of no departure makes every recorded bit zero. At k<=n/(24q)
that event has probability at least7/8, so the raw estimate then has
error1/2 with probability at least7/8. This is a probability statement
about this estimator, not a claim that every postprocessing scheme fails.
The same argument applies to any polynomial-length burn-in and following
raw sampling window whose combined number of updates is in this range.

The initialization restriction matters. A complement-symmetric initial
distribution retains exact single-bit marginals1/2 by symmetry of the
transition kernel; the argument does not exclude that different start.
Nor does it exclude nonlocal updates, analytic inference, or a method
using special knowledge of this formula. Indeed 0^n is already a directly
verifiable SAT witness. Failure of this chain to estimate its stationary
marginals from that start is not failure to solve this SAT instance.

## Exact polynomial path inference, including prefix restrictions

This family does not furnish a hard inference problem. Its weights have
nearest-neighbor factors q^(indicator[a!=b]). Let h_i(a) be1 for an allowed
bit and0 for a bit excluded by a consistent prefix. Define

    f_1(a)=h_1(a),
    f_(i+1)(b)=h_(i+1)(b)[f_i(b)+q f_i(1-b)],
    Z(prefix)=f_n(0)+f_n(1).                        (9)

This sums exactly over every allowed assignment. For a marginal at j,
use backward messages

    g_n(a)=1,
    g_i(a)=sum_(b=0,1) q^(indicator[a!=b])h_(i+1)(b)g_(i+1)(b),
    Pr[x_j=a | prefix]=f_j(a)g_j(a)/Z(prefix).      (10)

The denominator is positive for every consistent prefix because q>0.
Keep q tied to the original n. No oracle or initial witness is used in
(9)--(10). Each pass has O(n) rational arithmetic operations. For a forward
pass multiply f_i by D_i=2^(2n(i-1)); the integer recurrence becomes

    F_(i+1)(b)=h_(i+1)(b)[2^(2n)F_i(b)+F_i(1-b)].

Its intermediate integers have O(n^2) bits, as do the corresponding
backward messages, products and marginal numerator/denominator. Standard
integer shifts, addition, multiplication and division therefore give
polynomial bit work. The n successive marginal queries in the earlier
majority readout remain polynomial for this path family. Exact rationals
can be rounded with the earlier explicit1/8 error budget if desired.
Compact factors are useful here because eliminating an endpoint retains
a one-bit boundary; arbitrary CNF need not retain that property.

## Actual implementation obligation left open

The heat-bath step is cheap because it conditions on every other variable.
Turning a trajectory of such steps into a prefix marginal requires a
justified initialization, convergence and sampling-error analysis. The
explicit worst-start polynomial mixing claim fails by (7), and the raw
estimator fails the stated marginal tolerance by (8). Randomized samples
also do not by themselves meet a deterministic, always-correct marginal
contract even in a family where rapid mixing can be proved.

A remaining implementation would need a uniformly efficient inference
method for arbitrary CNF and every queried prefix, with the deterministic
error and runtime guarantees used in the previous reduction. A different
initialization or sampler would require its own guarantee; this example
does not refute those possibilities. The exact path recurrence separates
failure of one sampling implementation from hardness of the distribution
or of SAT. No general decision theorem or P=NP conclusion follows here.
