# S3071 strategic and source review

2026-09-11. Independent selection review under [integrity](../../INTEGRITY-CLAIMS.md). Read S3071 intake, S3068 novelty conclusions, S3070's missing aggregate mass, and the existing [complexity implication map](2026-09-11-complexity-implication-map.md). No experiment, new theorem, publication claim or implementation campaign. Final [code selection](2026-09-11-frontier-code-selection.md) and [packing selection](2026-09-11-frontier-packing-selection.md) were read. **GO for their bounded NONE selection and stated source/model limits.** This is not a finding that research is exhausted.

## Does the random-FKO target still serve the goal?

It is a legitimate average-case certificate-discovery frontier. An algorithmic advance there could be worthwhile research independently of P versus NP. However, our recent evidence has established access bounds, restricted failures and eligibility identities, not a lower total discovery cost or a mechanism with proved aggregate yield. The distinction matters: a short certificate and a polynomial preparation routine do not supply a useful family under clause capacities.

There is no established worst-case-to-this-distribution bridge in the reviewed records. Therefore even polynomial-time refutation of the specified random inputs would not by itself settle P versus NP. Continuing FKO can serve the original goal only as an explicitly indirect research project whose intermediate advance is credible on its own. Relabeling each diagnostic as a stepping stone would obscure that limitation.

**Current recommendation:** stop the sequence of local walk repairs. Retain its exact results and unresolved nonempty-mass/coverage problem. Select a new FKO derivation only if the code-search or pricing scouts provide a quantitative gain tied to an actual source-compatible mechanism. A new name for the remaining oracle, a standard collision identity, or an existence theorem alone does not justify execution. This is a research-selection judgment, not an assertion that further research is impossible or a request for permission.

## One direct class-separation comparison

The existing map's E9 is the valid direct route

    NP not contained in P/poly  ==>  P != NP.

A precise primary magnification antecedent is available: for a universal c>=1, if some epsilon>0 has the property that for every sufficiently small beta>0,

    Gap-MCSP[2^(beta n)/(c n), 2^(beta n)]
       is not in Circuit[N^(1+epsilon)],  N=2^n,

then NP is not contained in polynomial-size circuits. This is an existing conditional theorem, not our result. [Oliveira-Pich-Santhanam, Theory of Computing 17(11), 2021, theorem in publisher abstract](https://toc.cs.uchicago.edu/articles/v017a011/).

The unresolved operation is a lower-bound argument for that exact gap problem and circuit model across the required beta regime. A lower bound for an easier function or a weaker model does not discharge it. Nor does the phrase slightly superlinear imply that it is easy: the exponent threshold is a numerical statement about a very strong computational model.

[Chen et al., Beyond Natural Proofs: Hardness Magnification and Locality, Sections 1.3 and 5](https://arxiv.org/pdf/1911.08297) identifies why several direct adaptations fail: small-fan-in oracle extensions give efficient representations of the magnification targets, while the corresponding lower-bound methods tolerate those same oracle extensions. A proposed argument must identify exactly where it avoids the applicable localization mechanism. This is a barrier to specified proof methods, not an impossibility theorem for circuit lower bounds.

Crucially, this route was already recorded in [MagnificationFrontierMap.lean](../../lean/PvNP/MagnificationFrontierMap.lean), alongside CHOPRS locality, Pich approximation-method localization and AM2025 sparse-language distinguishers. Reintroducing it is not a new research choice. The sources checked here did not produce a concrete untested nonlocal argument or parameter improvement to execute. No magnification proof campaign is selected.

Also distinguish conclusions: NP lacking polynomial-size formulas, as in one separately recorded magnification route, is not NP lacking polynomial-size general circuits. The former alone does not imply P!=NP. Similarly, the established NEXP-versus-ACC theorem in [Williams](https://people.csail.mit.edu/rrw/acc-lbs.pdf) does not instantiate E9 for NP. A shorter implication arrow must not substitute for its missing premise.

## What evidence would change selection?

A code-search candidate needs an applicable sparse/high-rate/low-weight analysis with total construction, memory, collision and output costs. A packing candidate needs a demonstrably cheaper way to discover useful short tuples, not just optimize weights once tuples are given. A direct circuit route needs an explicit target-dependent argument beyond the already catalogued magnification implications and localized proof methods.

These are alternative evidence requirements, not demands to solve the whole problem before investigation. A concrete unproved estimate can justify a bounded attempt if its mechanism and plausible saving are specified. At present, this independent comparison supplies no such new candidate. The live uncertainty is whether either aggregate-search scout has one, not whether permission or infrastructure is missing.

## Source and repetition limits

Read the local implication and magnification records before making this comparison. Primary browsing checked the exact OPS quantifier statement, CHOPRS locality formulation, and Williams's established circuit scope. A focused query for 2025/2026 MCSP magnification/locality work surfaced related conditional-hardness work but no verified mechanism used here to close the needed lower-bound premise. This is not an exhaustive current frontier survey or a claim to have ranked every complexity-theory route. No new source-derived implication is asserted beyond the explicit theorem and logical composition above.

## Added bounded-column Even Set scope check

I opened [Parameterized Intractability of Even Set and Shortest Vector Problem, arXiv:1909.01986](https://arxiv.org/pdf/1909.01986), including the minimum-distance/dependence formulation, sparse-nearest-codeword definition and reduction-column descriptions. Its general hardness statements do not by themselves settle the restriction to incidence columns of weight three. Generator-to-parity-check conversion need not preserve that restriction. Moreover, sparse nearest codeword there penalizes the coefficient vector's weight; it does not promise a sparse input matrix. No applicable weight-three FPT or hardness theorem was verified in this bounded search.

An unsigned bounded-column finder does not automatically solve signed pricing. Appending the sign row creates columns of weight three or four, and weighted pricing adds a separate output condition. However, that is not a universal obstruction: the already reviewed sign-blind route could construct a sufficiently large disjoint or bounded-load unsigned family first, then filter signs. Such a route needs its length, mass, robustness after generated deletions and total cost proved; it need not append a sign row. No claim that general Even Set hardness excludes that route is warranted.

This comparison distinguishes a potentially useful quantitative target, such as a suitable 2^O(k) poly(input)-cost discovery procedure, from evidence for an actual mechanism achieving it. The former alone is not grounds for an algorithm campaign. A source-compatible bounded-column result or a concrete derivation would be needed to change that selection.

## Final author-selection assessment

Both scouts decline to select an unsupported mechanism, and that conclusion is justified by the evidence they record. Neither substitutes absence of a source hit for hardness or novelty. The code note distinguishes random dense codes, fixed-rate asymptotics, sublinear weight, regular error patterns and sparse columns; these are materially different promises. Its general Even Set discussion agrees with the independent restricted-model check above.

For n independently sampled weight-three columns, a specified row is untouched with probability (1-3/n)^n. Linearity of expectation gives exactly n(1-3/n)^n uncovered rows. This diagnoses a mismatch with a naive dense full-rank model. It is not a high-probability runtime bound, a result about a basis selected by pivoting, or a lower bound on ISD. The author explicitly retains those limits. I requested the wording independently sampled to avoid confusing probabilistic independence with linear independence.

The code-rate bound follows from rank(A)<=n+1 at length M; the target relative weight is Theta(n^(-6/5)). The MITM list comparison retains input/list costs, and possible 2^O(k) versus k^O(k) savings are framed as targets with additional packing obligations, not achieved bounds. Quantum list/marked-fraction estimates are not transferred into the sparse ensemble without justification. Failed access to one original sublinear-ISD source remains disclosed.

The packing note correctly treats arbitrary-price separation as one chosen route, not a necessary feature of every finder. Its cheap-clause threshold deletes at most L times total price by the elementary counting bound. At L=Theta(n^.2 log n), that bound can exceed m; therefore it provides no useful density guarantee, but does not imply actual cheap tuples are absent. The deletion-weight observation is similarly only a potentially vacuous guarantee. Existing spectral proofs do not automatically give a nonnegative short-tuple packing or cheap separator.

**Final recommendation:** do not launch another walk, ISD, LP, or magnification implementation/derivation campaign from these notes alone. Preserve the exact aggregate uncertainty: an explicit source-compatible compression, sieve, pricing or other global mechanism with a plausible quantitative gain has not yet been identified. This changes selection rather than producing another routine diagnostic. It does not require user permission, terminate the broader research goal, establish no-go for these fields, or preclude a concrete mechanism emerging later.

## Final added-question and graph check

Read the final unselected random-priority greedy-basis paragraph and S3071 meta-graph metadata. Scope GO. Processing the full unsigned matrix into a maximal independent column set and extracting nonbasis fundamental circuits is a specified known heuristic, distinct from both input-independent variable restrictions and capped local growth. Its unresolved quantity is a performance probability under sparse, competing pivots, followed by aggregate outputs and loads; no bound is supplied or implied. Fixed-circuit survival alone is correctly insufficient for packing. Random priorities are understood to induce a random total order, with ties resolved if a finite implementation is later specified.

The paragraph makes no priority claim, algorithmic gain or campaign recommendation. The graph adds no verified transformation and retains its aggregate gaps. Recording the possible analysis question does not alter the NONE selection or complete the broader goal. No correction is required for this addition.
