# Algorithms-to-lower-bounds: bounded mechanism selection

2026-09-12; S3121/E004/S008; [integrity](../../INTEGRITY-CLAIMS.md).
**Selection: NONE, with independent source/mechanism challenge.**
Two operational ideas were screened; neither supplies a changed
algorithmic step beyond existing polynomial truncation or sparse-transform
recovery. This is not a conclusion that the frontier is closed, or a rejection
merely because a proposed bound remains unproved.

The [persistent graph](2026-09-11-research-meta-graph.md),
[implication map](2026-09-11-complexity-implication-map.md),
[earlier target assessment](2026-09-11-pvnp-target-selection-assessment.md),
solver-frontier alternatives, and gap-first streaming records were read.
The previous canonical-interpolation, mask-compression, tensor-basis,
separator-reconstruction and pure-space-transfer failures remain unchanged.
No experiments, proof campaign, implementation, public action or commits were
performed. The broader objective remains unresolved.

## Exact algorithmic bridges

All local targets below concern uniform finite computation with all instance
reading, preprocessing, arithmetic, oracle simulation and output charged.
An arbitrary nonuniform circuit adviser is not an algorithm. A randomized
distinguisher cannot silently replace a deterministic or zero-error premise.

| Inspected primary statement | Required algorithm and exact consequence |
|---|---|
| [Williams, Improving Exhaustive Search Implies Superpolynomial Lower Bounds, Theorem 1.1](https://www.cs.cmu.edu/~ryanw/improved-algs-lbs2.pdf) | There must be a superpolynomial saving function s(n) such that, for every fixed k, Circuit-SAT on n-input n^k-gate circuits runs in 2^n*poly(n^k)/s(n), in the source's deterministic or co-nondeterministic model. Consequence: NEXP is not contained in P/poly. A single fixed polynomial saving against a fixed size exponent is not this premise. The conclusion does not itself decide P versus NP. |
| [Murray-Williams, Circuit Lower Bounds for Nondeterministic Quasi-polytime: An Easy Witness Lemma for NP and NQP, Theorem 1.1](https://eccc.weizmann.ac.il/report/2017/188/download/) | For a typical circuit class C and fixed epsilon in (0,1), GAP C UNSAT on n-input circuits of size 2^(epsilon*n) in nondeterministic O(2^((1-epsilon)*n)) time implies there is c such that, for every k, NTIME[n^(c*k^4/epsilon)] lacks n^k-size C circuits. The source gap is UNSAT versus at least a quarter of assignments satisfying, with its explicit consistent yes/no/don't-know nondeterministic convention. The language and NP time exponent can depend on k: this is not one NP language outside every polynomial circuit bound, and gives no P!=NP conclusion here. |
| [Bathie-Williams, Towards Stronger Depth Lower Bounds, ITCS 2024, Theorem 3.7](https://drops.dagstuhl.de/storage/00lipics/lipics-vol287-itcs2024/LIPIcs.ITCS.2024.10/LIPIcs.ITCS.2024.10.pdf) | For epsilon>0, for every fixed beta>0 a 2^n/n^omega(1)-time Gap-Formula-SAT algorithm on O(n^(3+epsilon))-size De Morgan formulas, distinguishing UNSAT from at least beta*2^n satisfying assignments, implies E^NP lacks O(n^(3+epsilon))-size formulas. The source proof also permits zero-error randomization. This is the precise prospective bridge for the two screens below. Variables n and formula leaves are different parameters. |
| [Chen-Tal-Wang, March 2026, TR26-039, Theorem 1.1](https://eccc.weizmann.ac.il/report/2026/039/download/) | The current primary preprint establishes, for every fixed epsilon in (0,1), an E^NP function requiring more than n^(2.5-epsilon) THR-of-THR gates; it also treats SYM-of-THR. Its algorithmic route uses deterministic acceptance-probability estimation and structured restrictions. This makes a generic claim that the threshold frontier is still subquadratic stale. No new threshold mechanism is proposed here, and no full independent verification of the preprint is claimed. |

These are source contracts and comparison results, not achievements of this
selection. In particular NEXP, E^NP and NP are not interchangeable. General
Circuit-SAT, De Morgan formula Gap-SAT, exact #SAT and CAPP have different
promises and closure requirements.

## Screen 1: prune polynomial products with an explicit error ledger

The initial concrete operation was to process a formula bottom-up, expand
child polynomial products at AND gates, combine coefficients of identical
monomials, and remove coefficients only when their total absolute mass is
within the allocated error allowance. NOT and OR use their ordinary Boolean
polynomial identities. Keep an explicit propagated pointwise-error ledger;
do not assume a local discarded mass is automatically the root error.

Use either standard multilinear monomials on {0,1}^n or Fourier characters,
but fix the choice. In the standard monomial basis,

    E[P(x)] = sum_S a_S * 2^(-|S|).

It is the constant coefficient only in the Fourier-character basis. The
independent challenger caught this basis distinction before the saved
specification. A norm guarantee for an approximant in one basis is not a
sparsity or cost guarantee for another representation or for the exact
function's spectrum.

The most relevant new approximation comparison is [Yichuan Wang, TR26-127,
Approximating Polynomials for De Morgan Formulas with Optimal Coefficient
L1-Norm Bounds](https://eccc.weizmann.ac.il/report/2026/127/download/),
Theorem 1.1/restated 5.1. The inspected preprint claims that a formula with S
leaves admits a constant-error real approximant of degree O(sqrt(S)) and
standard-monomial coefficient norm 2^O(sqrt(S)). Its construction uses span
programs and matrix-polynomial analysis, not the proposed gatewise pruning.
This is an existence/representation comparison, not a certificate that the
local truncated lists have small support or can be found quickly. At
S=n^(3+epsilon), even the stated norm exponent is larger than n; substituting
the bound does not produce a sub-2^n algorithm. Its complete proof was not
independently verified in this selection.

For lists of lengths L_u,L_v at an AND gate, ordinary multiplication incurs
L_u*L_v term-pair work before like-term cancellation. Coefficient arithmetic,
support-index unions/XORs, sorting or dictionary combination, and pruning are
all charged. With coefficient bit bound B, a safe accounting is a polynomial
factor in n and B times the sum of these products and retained-list sizes;
no bound on B or intermediate list lengths is assumed free. Representing a
coefficient by a real number at unit cost is not allowed.

The hoped-for first obligation would be a *uniform construction* for every
formula of the bridge size, for every fixed beta, whose root expected value
has additive error less than beta/2 and whose full bit cost is
2^n/n^omega(1). Thresholding at beta/2 with a strict error margin would then
solve the promised distinction. No such obligation was established. More
fundamentally, this operation is ordinary polynomial truncation: neither the
new source nor the local proposal supplies a changed algorithm for avoiding
the expensive intermediate products. It was not selected for a demonstration
or derivation campaign.

## Screen 2: aggregate cancellations before materializing products

The bounded follow-up considered a concrete replacement for multiplication:
fix linear hashes of Fourier indices into smaller quotient spaces, accumulate
signed coefficient sums in the bins, recover isolated coefficients from
several shifted hashes, and peel them before refining unresolved bins. An
alternative way to obtain those measurements evaluates the original formula
on chosen Boolean assignments and uses small Walsh transforms. Thus it does
not require a free coefficient oracle; each formula evaluation costs its
actual formula-processing time.

This is already the architecture of sparse transform recovery. The relevant
strong comparison is [Cheraghchi-Indyk, Nearly Optimal Deterministic Algorithm
for Sparse Walsh-Hadamard Transform, SODA 2016](https://epubs.siam.org/doi/10.1137/1.9781611974331.ch23),
with [primary preprint](https://arxiv.org/abs/1504.07648). For every fixed
alpha>0 it gives deterministic, nonadaptive query-access recovery in
k^(1+alpha)*polylog(N) time with an l1/l1 guarantee relative to the best
k-sparse Fourier approximation. This is a substantially stronger comparison
than naive full convolution; randomized peeling under random-support
assumptions is not the strongest available baseline. Here alpha is fixed
independently of n; taking alpha to zero with n does not preserve the stated
uniform overhead for free.

For the Boolean indicator f, use normalized Fourier coefficients

    hat(f)(S)=2^(-n)*sum_x f(x)*(-1)^(S dot x).

Then hat(f)(empty)=E[f]. A sparse-transform implementation using a different
Hadamard normalization must rescale the reconstructed vector and its tail
error to this normalization. The scaling factor, precision and resulting
absolute error thresholds are charged; the source's transform error is not
silently equated to the desired beta/2 probability margin.

Plugging a formula evaluator into those queries charges its size and finite
arithmetic precision. If q measurements are made, the formula evaluations
alone cost at least their charged q-times-evaluation budget, in addition to
measurement construction and recovery. The source's tail-relative error
guarantee is not an algorithm for certifying that an arbitrary formula has a
small enough tail. Signed cancellation of a bin cannot certify that each
individual omitted coefficient is small, and a random-support assumption
cannot replace a worst-case formula guarantee.

For example, a valid proposed advance would have to specify a genuinely new
deterministic, efficiently checkable tail/cancellation certificate and its
discovery procedure, or a structural theorem yielding the required tail bound
for all bridge inputs. It would need to include unsuccessful refinements,
all hash construction, point-query costs, arithmetic and certificate checking
within 2^n/n^omega(1). This screen supplied no changed certificate or discovery
operation beyond existing hashing/recovery. Calling the missing tail bound a
certificate would only rename the unresolved task. Consequently this second
screen also fails contribution-first selection; it is not a lower bound
against sparse-transform algorithms or arbitrary approximate counting.

## Selection decision and review status

Neither screen yielded a substantively changed operation after the strongest
relevant comparison. The first is standard truncation; the second is already
covered at the operational level by stronger deterministic sparse recovery.
The missing worst-case tail or construction guarantee is a real frontier
obligation, but no specific new method to obtain it emerged here. This is why
the selection is NONE, rather than because conjectural guarantees are
disallowed. A new conjecture for a concrete changed operation would remain
admissible under the protocol.

The [independent challenger](2026-09-12-algorithms-lower-bounds-challenge.md)
received both operations before closeout, read the complete saved selection,
and agreed with this scoped NONE. Its requested Fourier-normalization and
fixed-alpha clarifications are incorporated above. The challenger also
supplied the current threshold baseline, basis correction and exact bridge
requirements. Final hash confirmation and scope integration are handled by
the orchestrator. No
novelty claim, SAT improvement, circuit lower bound, public artifact or next
experiment is endorsed. The current-source searches were focused, not an
exhaustive frontier ranking; lack of a selected mechanism is local to this
bounded attempt.
