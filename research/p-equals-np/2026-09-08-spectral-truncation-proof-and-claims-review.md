# Spectral truncation: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Harness-only independent review of
`2026-09-08-spectral-truncation-attempt.md`. This same reviewer covers the
two separate lenses below; these are not two independent reviewers.
Source/complexity review is assigned separately. No formal module, build,
simulation, implementation change or commit is involved.

## Proof-adversarial lens — GO

The stable draft passes without mathematical corrections.

Walsh normalization is consistent throughout. The characters are an
orthonormal basis for the normalized uniform inner product, the coefficient
of the empty set is alpha, and Parseval gives sum f_hat(S)^2=alpha for a
Boolean indicator. The generator has eigenvalue -2|S|, so its multiplier
is exp(-2t|S|), with the correct rate factor2.

Cauchy--Schwarz applies directly to the pointwise Fourier tail. Because
d>=0, the omitted coefficient energy is at most alpha-alpha^2, giving
equation (2). The alternative bound follows from |f_hat(S)|<=alpha.
Neither bound substitutes normalized L2 error for coordinate error.
For d=n the tail vanishes. Additional coefficient errors sum with weights
r^|S|, so the proposed epsilon/(2D_d) individual error budget is sufficient.
Since D_d<=2^n and epsilon=2^(-2n-2), this needs O(n) precision bits per
coefficient, without bounding how many coefficients are computed.

For the unit-clause singleton at zero, all coefficients and all evaluated
characters are positive. The tail in equation (4) is exact, and for d<n
its first omitted degree contributes at least
2^(-n) exp(-2(d+1)). Comparing this lower bound with2^(-2n-2) yields
d+1 >= (n+2)log(2)/2. This is a necessary condition only. Using log(2)>1/2
gives d>n/4-1/2, which implies the stated weaker integer bound
d>=floor(n/4) in all four residue classes of n. The d=n case already
retains all modes and needs no nonexistent omitted-term argument.

Every subset of a fixed floor(n/4)-element set is retained, so
D_d>=2^floor(n/4). This is exponential in n and superpolynomial in the
unit-clause input's O(n log n) encoding length. The cost conclusion is
explicitly for listing the all-subsets cutoff representation. The closed
form a(t)^n and the identical coefficients give a compact alternative on
the same example; this prevents extending that cost conclusion to all
evaluators or representations.

At the dyadic propagator, r=1/2. The omitted degree-n term for any proper
cutoff is exactly4^(-n), exceeding the requested4^(-n)/4 error. The full
cutoff is therefore required for this approximation strategy, although
the singleton's exact coordinate is simply(3/4)^n. Even its degree-zero
approximation correctly classifies this SAT example. Failure to meet the
coordinate-approximation contract is not a demonstrated decision failure.

The final longer-time horizon is2n, rather than the preliminary proposed
n. A biased bit differs from a fair bit in TV by exp(-4n)/2. Telescoping
the product distributions therefore bounds every indicator expectation
error by n exp(-4n)/2. Since exp(2)>4, this is strictly less than
n/(2*16^n). The remaining inequality to4^(-n)/8 is exactly4n<=4^n,
true for n=1 and preserved by induction. Equation (7) consequently
provides the claimed uniform pointwise bound. No unproved L2-to-pointwise
mixing step is used.

Combining this strict half-budget tail with an alpha approximation of
error4^(-n)/8 meets the original epsilon budget. Separately, the conserved
mean alpha=#SAT(F)/2^n has its own zero-versus2^(-n) gap; its additive
2^(-n)/4 approximation permits the specified threshold decision. The two
different requested accuracies are not conflated. At time2n, every flip
factor still exceeds1/4 and every nonflip factor exceeds1/2, so the old
heat-coordinate gap also remains valid. The alternative bound from the
mean and equation (7) is independently sufficient. n=0 is handled by
direct evaluation before any of these positive-dimension arguments.

## Nonclaims lens — GO-WITH-NOTES

This increment gives exact finite spectral calculations, a restriction on
one explicitly enumerated cutoff representation, and a valid longer-time
constant-mode approximation. It neither proves an unrestricted evaluation
lower bound nor supplies a general evaluator.

The singleton example is deliberately easy and is presented as such.
Its exponentially large listed cutoff has a short shared description and
a direct product evaluator. There is no inference from that example to
general representation hardness or from approximation error to SAT
decision failure. The irrational dyadic time is also correctly separated
from the rational horizons.

Longer smoothing removes nonconstant modes from the accuracy budget, but
the constant mode is an unevaluated global average of the initial SAT
indicator. Its short output representation does not compute it. The
stated polynomial-time coefficient primitive would imply polynomial SAT
decision by a one-way reduction; it is neither implemented nor shown
impossible here, and no converse is claimed.

No Navier--Stokes consequence, physical resource lower bound, general
solver deadline, counting-class theorem or unconditional P=NP result is
established. The bounded informal findings pass. The efficient evaluator
and the full research objective remain unresolved; this review does not
approve formal or full-goal closeout.
