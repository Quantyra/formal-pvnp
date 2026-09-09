# Heat aggregation: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Harness-only review of
`2026-09-08-heat-aggregation-attempt.md`. One independent reviewer covers
the two separate lenses below; this is not two independent reviews.
Source/complexity review is assigned separately. No formal module, build,
numerical experiment, implementation change or commit is involved.

## Proof-adversarial lens — GO

The mathematical derivation passes. A minor location reference was raised:
the efficient-evaluation primitive is stated following equation (4), not
preceding it. The author corrected this reference and the saved change
was verified. No outstanding corrections remain.

The generator is the sum of commuting operators T_i-I with T_i^2=I.
Exponentiation therefore gives the claimed one-bit coefficients
a=(1+exp(-2t))/2 and p=(1-exp(-2t))/2, and their tensor product yields
equation (2). The factor2 in the exponential is correct for unit-rate flips
in each direction. Nonnegative coefficients and a+p=1 prove positivity,
preservation of the unit interval, and sup-norm contraction. The finite
constant linear system has a unique solution for all nonnegative times.

For E=2^(-n) sum u_x^2, with no one-half factor in its definition,
differentiation gives 2^(1-n) sum_x u_x sum_i(u_flip-u_x).
Each unordered edge contributes minus its squared difference inside this
last sum. Thus equation (3), -2^(1-n) times the unordered-edge sum, is
correct. The directed-edge form has twice as many summands and coefficient
-2^(-n). Applying the same identity to differences proves the stated
normalized L2 contraction. The normalization does not bound an actual
device's total energy.

At time1, p>1/4 and a>1/2. Each of the n factors in every kernel entry
is at least1/4, so a satisfying assignment contributes at least4^(-n).
UNSAT has identically zero initial data and output. The additive tolerance
g_n/4 and threshold g_n/2 have disjoint acceptance ranges g_n/4 and
3g_n/4. Direct evaluation handles n=0 without a timing division by zero.
The reduction constructs a succinct input description in polynomial time;
it does not initialize a truth table as a purported polynomial operation.

The precision and stability statements are sufficient bounds, not optimal
ones. Sup-norm initial perturbations remain bounded by their initial size.
The normalized L2-to-coordinate inequality has the correct 2^(n/2)
factor. Exact solution values in [0,1] imply |u_x'|<=n, so the proposed
nonnegative-time displacement bound contributes at most g_n/16. For scalar
kernel approximation, replacing independent bit distributions one at a
time bounds expectation error for f in [0,1] by n|p_hat-p|. This assumes
a_hat=1-p_hat, as in the stated product probability kernel, rather than
independently perturbed, unnormalized coefficients.

The alternating series for exp(-2) has decreasing terms beyond the initial
terms. For K>=2 its truncation remainder is bounded by
2^(K+1)/(K+1)!. A sufficiently large linear choice K=O(b) gives b-bit
accuracy; factorial denominators and intermediate rational sums have
polynomial bit length. Rounding to a nearby rational and clipping p_hat
to [0,1] can preserve the required accuracy with a constant guard budget.
This only computes a scalar parameter, not the sum over assignments.

At t_star=(log2)/2, the coefficients are exactly3/4 and1/4. Equation (5)
has numerator sum 3^(n-|y|) over satisfying assignments; the sum over
all assignments is4^n. Hence numerator and denominator have O(n) bits,
and a nonzero numerator supplies the same gap. The note correctly labels
t_star irrational and also allows the dyadic propagator as a direct
matrix operation without requiring an exact irrational physical clock.

The elimination recurrence averages the next bit of the previously
averaged function, so induction gives the product expectation at vertex0.
With dyadic coefficients, after i eliminations every table value has a
denominator dividing4^i and magnitude at most1. Explicit truth-table
construction and contraction consequently give a finite exponential-work
algorithm with polynomial bit length per entry. Repeated circuit
restriction does not provide a proved polynomial bound on intermediate
representation or construction costs. Finally, the overlapping-clause
counterexample is exact: x(1-x)=0 pointwise but the product of its two
clause expectations is p(1-p)>0 at positive time.

## Nonclaims lens — GO-WITH-NOTES

The result is a finite-dimensional mathematical aggregation construction
and a conditional reduction to a precise coordinate-evaluation task.
It establishes neither an efficient evaluator nor a lower bound against
all succinct evaluators. All exponential costs identified are costs of
the explicit implementations or state representations described.

Constant modeled time and dissipating normalized energy do not pay for
exponentially many state coordinates, preparation, coupling or readout.
Conversely, exponentially small absolute tolerances have only O(n)
precision bits here; the draft does not confuse resolution magnitude
with bit length. Its separate timing, initial-error and norm qualifications
retain this distinction.

The initial SAT predicate is efficiently evaluated at one assignment.
That fact does not efficiently evaluate its heat average over all
assignments. A short kernel formula, an O(n)-bit rational answer and
independent kernel bits do not remove this obligation or imply independent
clauses. The specified deterministic polynomial coordinate primitive,
if supplied for all succinct CNF inputs, would imply polynomial SAT
decision by the proved gap. It is not supplied in this increment.

The construction is not derived from Navier--Stokes and establishes no
physical fluid computer, global physical lower bound, counting-class
theorem, converse equivalence or unconditional P=NP conclusion. The
bounded informal result passes; the evaluator and full research objective
remain unresolved. No formal or full-goal closeout is approved.
