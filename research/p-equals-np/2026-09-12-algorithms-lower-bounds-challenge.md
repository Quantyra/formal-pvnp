# Algorithms-to-lower-bounds: independent source and mechanism challenge

2026-09-12; S3121 / E004 / S008. Selection review under
[integrity](../../INTEGRITY-CLAIMS.md), not an achieved algorithm or lower bound.
Read the planning story/literature trigger, frontier protocol, and persistent
research graph, including the exact S3120 completion failure. No general
completion obstruction or automatic successor is inferred from that result.
No destination AGENTS.md was present at the preceding destination check.

## Independently checked primary contracts

Search date: 2026-09-12. Focused searches covered Williams SAT/useful-property
transfers, 2024 formula-depth transfers, and 2025/2026 circuit-analysis updates.
Primary PDF statements were checked; search-engine recency labels were not
treated as publication dates. This is a bounded comparison, not a claim to
have exhausted all current algorithms or established novelty.

**General circuit-SAT route.** [Williams, Non-Uniform ACC Circuit Lower
Bounds, Theorem 1.3](https://people.csail.mit.edu/rrw/acc-lbs-journal-final.pdf)
states a saved-polynomial-factor SAT implication for a circuit class containing
AC0 and closed under composition. There is a required constant k such that
SAT for n-input, n^c-size circuits in time O(2^n/n^k), for every c, implies
NTIME[2^n] lacks polynomial-size circuits in the class. An algorithm working
for just one circuit-size exponent does not supply that premise. The more
precise Theorem 3.2 charges extra input bits, larger circuit size and depth.
Finding a good circuit-specific representation nonuniformly is not a uniform
SAT algorithm. Applying the general conclusion to unrestricted circuits would
give NEXP not contained in P/poly; that is not itself P!=NP. Applying it to
ACC merely redelivers an established endpoint unless the algorithmic guarantee
or scope changes.

**Useful-property route.** [Williams, Natural Proofs Versus Derandomization,
Theorems 1.1--1.2](https://arxiv.org/pdf/1212.1891) distinguish a truth-table
property with logarithmic advice from an advice-free algorithm defined on
arbitrary-length strings with the paper's padding convention. Usefulness
requires, for every polynomial circuit bound, infinitely many lengths with
some accepted function and no accepted easy function. Running time is
polynomial in the explicit table/string length, not in its logarithm. A
counting argument that hard functions exist supplies neither this recognizer
nor its rejection guarantee. A recognizer for a different easier class cannot
silently discharge usefulness against P/poly. The no-largeness formulation
still requires its exact soundness and nonemptiness quantifiers.

**Current threshold frontier.** [Chen--Tal--Wang, TR26-039, March 14 2026,
Theorems 1.1--1.2 and Lemma 3.8](https://eccc.weizmann.ac.il/report/2026/039/download)
already gives deterministic o(1)-additive CAPP for XOR of two
n^(2.5-epsilon)-size THR-of-THR circuits in 2^(n-n^Omega(epsilon)) time.
The consequence is an E^NP lower bound against that size regime, also for
SYM-of-THR. Thus an older subquadratic-only baseline is stale. This is
approximation of acceptance probability, not exact SAT or exact counting;
the paper explicitly distinguishes it from earlier #SAT results. Its
fixed-size-exponent endpoint is not a superpolynomial lower bound for all
TC0. No threshold algorithm was proposed in this selection; this comparison
prevents an unearned fallback claim.

**The proposer's chosen formula bridge.** [Bathie--Williams, ITCS 2024,
Theorem 3.7](https://drops.dagstuhl.de/storage/00lipics/lipics-vol287-itcs2024/LIPIcs.ITCS.2024.10/LIPIcs.ITCS.2024.10.pdf)
requires, for every constant beta>0, a 2^n/n^omega(1)-time algorithm
distinguishing unsatisfiable O(n^(3+epsilon))-leaf De Morgan formulas from
formulas satisfying at least a beta fraction of assignments. Its conclusion
is E^NP not contained in O(n^(3+epsilon))-size De Morgan formulas.
Zero-error randomization is allowed by the accompanying proof discussion;
ordinary bounded-error sampling is not that premise. Formula size counts
leaves, and the basis allows free negations. The paper separately reduces
this Gap-SAT task to a specified faster #SAT guarantee for smaller formulas;
its polynomial construction and counting costs are charged. The formula
lower bound is a meaningful restricted-model endpoint, not an unrestricted
NP circuit lower bound or P-versus-NP result. Its separate uniform-NAND SAT
depth theorem must not be identified with this nonuniform E^NP conclusion.

**Newest approximation comparison.** [Wang, TR26-127, July 24 2026,
main theorem and Section 1.3](https://eccc.weizmann.ac.il/report/2026/127/download)
gives pointwise constant-error approximants for formulas with s leaves of
degree O(sqrt(s)) and coefficient L1 norm 2^O(sqrt(s)); the basis is standard
0/1 monomials. The coefficient-weight bound is tight in the stated worst-case
sense. Its span-program construction is substantive known machinery, not a
new operation proposed here. It does not state the needed formula Gap-SAT
runtime. At s=n^(3+epsilon), its degree/weight guarantees alone are not a
sub-exhaustive bound on coefficient generation, storage, or averaging.

## Provisional operation and independent challenge

The proposer communicated one candidate: recursively form approximating
polynomials at formula gates, convolve supports at AND, prune coefficients
of small magnitude with a coefficient-L1 error ledger, and estimate acceptance
from the resulting polynomial. The supplied description currently consists
of standard sparse-polynomial operations and truncation. No changed operation
for finding significant coefficients without full intermediate generation has
yet been specified. This is a distinction between absence of an operation
and an unproved quantitative conjecture; a concrete speculative change with
an unproved invariant would remain eligible.

The following exact obligations were sent directly to the proposer:

1. Declare the basis. In 0/1 monomials, uniform expectation is
   sum_S a_S*2^(-|S|), not only the constant coefficient. In the Fourier
   character basis it is the constant coefficient, but an imported 0/1
   coefficient bound needs an explicit translation. Repeated variable
   occurrences must reduce correctly; subformula outputs are correlated.
2. Provide a deterministic threshold/selection rule and error allocation.
   A certified local discarded L1 mass controls that local perturbation,
   but gate composition can amplify errors. A final error smaller than
   beta/2 must be proved for every required beta; a 1/3 approximant alone
   does not handle all those gaps. Rational arithmetic or certified rounding
   must count coefficient bit lengths, not assume unit-cost arbitrary reals.
3. Charge coefficient discovery before pruning. At a multiplication gate,
   generating all pairs of child supports and then combining duplicate
   monomials may dominate the entire computation even if few terms survive.
   Sum those costs over every gate, together with sorting, cancellation,
   rounding and the final expectation computation. A bound only on root
   support or final coefficient L1 weight does not bound that total.
4. Identify a substantive operation beyond full convolution plus pruning
   and state a local structural invariant it might satisfy. A request that
   fewer terms survive is a desired result, not that operation. Conversely,
   lack of an existing theorem proving the saving is not by itself a veto.

These are source/interface and mechanism checks, not a new proof construction
or a general impossibility theorem for polynomial approximations. No toy
instance, counterexample suite, or benchmark was run. If the actual final
proposal remains the standard baseline with the discovery step unspecified,
the appropriate bounded selection is NONE; this does not assert that every
future approximation-based algorithm fails.

## Authorized cancellation-before-convolution pass

The proposer next considered linear hashing of monomial indices, quotient-bin
aggregation, signed cancellation and peeling/recovery before explicitly forming
the full convolution. This changes the operation relative to ordinary
multiply-then-prune, so it received a separate primary comparison rather than
being dismissed under the first screen.

[Cheraghchi--Indyk, arXiv:1504.07648v1, Theorem 1](https://arxiv.org/pdf/1504.07648)
already provides deterministic nonadaptive sparse Walsh-Hadamard recovery in
k^(1+alpha)*n^O(1) time for N=2^n, fixed alpha>0, and polynomial-bit
query values. Its L1 error is bounded by a constant times the best-k L1
tail. Walsh self-inversion permits recovery of spectral coefficients from
function-value queries. Thus one cannot claim that deterministic hashing or
avoiding explicit full convolution is itself the changed contribution. The
paper's probability versus unitary normalization must be tracked when using
the recovered constant coefficient as an acceptance estimate.

This comparison is not a statement that the formula target is already solved.
The recovery bound depends on the actual tail and chosen k. For formulas,
queries can be answered by evaluating the supplied formula, with that cost
charged. Multiple gate-level recoveries additionally charge every query,
reconstruction, coefficient precision and propagation step. Fixed alpha
cannot be set to a vanishing function of n for free; its overhead constants
depend on alpha. A putative useful total-cost bound must cover all those
calls and any fallback as well as bound the final approximation error.

No per-instance tail certificate is inherently required if a class-wide
structural theorem would establish the needed tail bound. Conversely, if
the operation relies on a certificate to decide whether to stop or refine,
its construction and verification must be specified. The proposer reports
that neither a distinct tail/cancellation-certificate rule nor a new structural
mechanism emerged beyond applying known recovery and hoping its tail is small.
That is the current reason for NONE, not the absence of a proof of a concrete
new invariant. A favorable unexplained sparsity assumption is the missing
guarantee, not an algorithmic operation supplying it.

## NP-level transfer does not remove the quantifier barrier

Independently checked [Murray--Williams, TR17-188, Theorem 1.1](https://eccc.weizmann.ac.il/report/2017/188/download/).
For a typical class and fixed epsilon, its premise is nondeterministic
O(2^((1-epsilon)n))-time Gap-UNSAT on 2^(epsilon*n)-size circuits.
Its nondeterministic promise convention allows yes/no/don't-know branches,
requires the promised answer on some branch, and prohibits contradictory
yes/no branches for every input. The conclusion has the form
exists c, for all k, NTIME[n^(c*k^4/epsilon)] not contained in size-n^k
circuits of the class. The language and its NP time exponent may depend on k.
This is not a single NP language outside all polynomial circuit sizes and
does not establish NP not contained in P/poly. Thus selecting an NP-labeled
bridge cannot justify a P!=NP implication without its additional quantifier
argument. No such algorithmic premise or argument is supplied here.

## Actual final artifact and independent verdict

Read the complete proposer
[selection](2026-09-12-algorithms-lower-bounds-selection.md) at initial
SHA256 `0DC0DF50A48B2BC63693E91CC1681234D50D9E1429345A710BB533E6527CB9F5`,
then checked its normalization/fixed-alpha and final-status additions at
final SHA256
`9A0C934FF41EBFE59501B6036DE343F65EAE30A840172769A46235A25E8E40F7`.
Also opened the cited Williams 2010 primary Theorem 1.1 and confirmed its
all-k and superpolynomial-saving formulation. No source-contract correction
remains outstanding. The final file properly normalizes
hat(f)(S)=2^(-n)*sum_x f(x)(-1)^(S dot x), charges rescaling/precision,
and fixes alpha independently of n.

**Independent selection: NONE. GO for the bounded assessment, not for a
new derivation or achieved source premise.** The two actual operations have
been compared against applicable known procedures. The second genuinely
differs from the first, but its distinguishing step is itself already part of
deterministic sparse-transform recovery. No new omission, refinement,
tail-control or discovery operation was supplied after that comparison.
The requested fast worst-case formula estimator remains an important
unproved guarantee; renaming that guarantee is insufficient as a changed
mechanism. This does not impose a proof-before-research requirement or rule
out an explicitly proposed structural conjecture for a new operation.

This review contributed source comparisons and interface corrections, not
an algorithm or a proof of failure. It does not establish a lower bound on
truncation, sparse recovery, arbitrary formula SAT, or general algorithms.
No input experiment, benchmark, proof authoring, public action, commit,
push, or spend was performed. Lean build is N/A for this selection record.
The full objective remains unresolved; no automatic successor is selected.
This actual-file review is frozen for the separate scope/integration lens.
