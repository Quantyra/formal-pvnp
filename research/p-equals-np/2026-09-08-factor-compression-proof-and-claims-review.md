# Factor compression: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Baseline `99dd222`.
Harness only. One independent reviewer covers the two separately reported
lenses; these are not two separately staffed reviews. No code, experiments,
formal modules/builds, commits, planning edits or publication are involved.

Reviewed stable `2026-09-08-factor-compression-attempt.md`. The review checks
its representation contract, conditioning bounds, readout implication and
one-cut approximation obstruction, not a general tensor or inference theorem.

## Proof-adversarial lens: GO for the conditional scheme and fixed-cut bound

**Representation and arithmetic.** A tensor train with polynomial dimensions,
rational entry lengths and number of cores supports the stated prefix sums
and conditional contractions by polynomially many rational operations.
A common denominator for each finite core can be formed with polynomial
bit length, and their product also has polynomial bit length. Matrix-index
summation adds polynomial bit growth. These facts assume the representation
has already been obtained; the text correctly charges its construction and
all intermediate work separately.

**Conditioning TV.** Writing normalized restrictions with denominator z gives
a conditional L1 bound [sum_E|P-Q|+|p-z|]/z. The missing mass difference is
bounded by the complementary L1 discrepancy, proving conditional TV<=e/z.
Interchanging P and Q gives e/p, hence the minimum e/max(p,z). The positive
event-mass hypotheses are explicit. The supplied equal-event-mass example
has exactly global error p/4 and conditional error 1/4.

A true selected-prefix mass at least c^k therefore gives the stated
sufficient bound e/c^k; it is not a necessary error requirement. For stagewise
conditioning of a distribution whose chosen branch has probability at least
one half, the same bound is at most 2e_k. Adding the next approximation error
by the triangle inequality proves (3) and its iterated recurrence. This is an
upper bound and does not prove actual exponential error growth.

**Relative error propagation.** Uniform lower and upper ratios survive
restriction and positive summation because each resulting ratio is a weighted
average of the entry ratios. Logarithmic oscillations obey the stated
triangle inequality. Replacing a factor inside the same nonnegative
environment preserves its multiplicative inequalities, provided every actual
replacement occurrence is counted. Zero entries remain zero under the
two-sided comparison; the target assignment weights are positive.

Each exp(plus/minus eta_j) comparison contributes oscillation at most 2eta_j.
Thus the total budget yields d<=1/32 at every counted conditional stage.
After normalization, ratios lie between exp(-d) and exp(d). The conservative
TV bound exp(d)-1<=2d<=1/16 follows, with an additional 1/16 arithmetic
budget fitting the previous 1/8 marginal contract. The rational certificate
delta=1/(128J) is valid: delta<=1/128, and both absolute logarithms are at
most 2delta=1/(64J). No exact exponential oracle is required for these
entry comparisons. The cost of finding and verifying them remains explicit.

**On-policy decision implication.** For a total deterministic procedure
with the stated SAT-input branch guarantee, the conditional chain rule gives
returned-leaf mass at least c^n>q when c>1/4. On SAT inputs a nonsatisfying
leaf has mass at most q; on UNSAT inputs direct verification always rejects.
This indeed needs only the actual chosen path, with a guarantee for every
allowed induced path if approximate outputs are nondeterministic. Polynomial
termination on all inputs remains indispensable. No supplied witness is used
as advice. This is a sufficient conditional decision theorem, not a constructed
branch procedure for arbitrary CNF.

**Exact and approximate rank.** For m independent equality pairs, the blocked
matrix is the tensor power of [[1,q],[q,1]], with q=2^(-4m). Each factor is
invertible, so its blocked-cut rank is N=2^m. Any train in that order has
matrix rank bounded by its cut dimension.

For the approximate statement, the normalized diagonal mass is (1+q)^(-m),
and TV from the uniform diagonal distribution is exactly its missing mass.
The union bound gives at most mq<=1/16 for all m>=1. An approximate B within
1/16 of pi is therefore within 1/8 of the diagonal law. The row errors e_i
sum to at most 1/4, so at most N/4 rows have error at least 1/N. On the
remaining principal submatrix, each diagonal entry is strictly greater than
the sum of absolute off-diagonal row entries. A maximal-coordinate kernel
argument proves this submatrix nonsingular. Consequently rank B>=3N/4,
with integer rounding implicit when N is small. This proof uses the stated
global-TV metric directly, not an unsupported transfer from exact rank.

The bound is order-specific. Interleaving each equality pair gives an exact
nonnegative train with bond dimension two within a pair and one between pairs.
Direct on-policy inference is also easy even with blocked queries: unpinned
x bits are fair, and each y bit favors its already selected partner. A
deterministic tie choice can return a constant satisfying assignment without
constructing the blocked joint table. These alternatives do not contradict
the rank claim; they show its precise representation limitation.

No blocking mathematical defect was found.

## Nonclaims lens: GO-WITH-NOTES for bounded exploratory use

The text separates an efficiently contractible representation from an
algorithm that constructs it, and charges verification of the relative-error
certificate. Compact clauses and convexity are not used as free inference or
compression oracles. The candidate is explicitly separate from the original
analog ODE.

The rank obstruction covers global approximation at one prescribed cut. It
does not establish an all-order lower bound, a marginal-inference lower bound,
or a SAT difficulty result. The easy interleaved representation and direct
branch computation are explicitly recorded, preventing those stronger
interpretations. The log-error budget is sufficient and stronger than the
weaker on-policy requirement; neither is said to be necessary for all methods.

Total runtime and the SAT-input branch guarantee are retained as unproved
implementation obligations. No arbitrary timeout, general inference
impossibility, P!=NP conclusion or P=NP result follows from these inequalities.

Safe summary: a relative compression contract survives conditioning and would
support the deterministic readout if implemented efficiently; matching pairs
rule out that globally accurate train representation at a blocked cut while
remaining easy under other orders and direct inference. The arbitrary-CNF
algorithmic obligation remains unresolved. No stronger claim or full-goal
closeout is approved.
