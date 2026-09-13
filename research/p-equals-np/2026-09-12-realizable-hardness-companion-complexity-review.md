# Companion integration complexity review

2026-09-12. Reviewer: companion_complexity_review, independently routed AI complexity-theory reviewer. Verdict: **GO-WITH-NOTES for the frozen finite-component integration only**. This is not full hardness certification, human peer review, or novelty certification.

## Frozen evidence and method

Reviewed repository `C:/Users/Dan/Desktop/Projects/formal-pvnp`, companion `certifications/realizable-hardness`, commit `6d7718919d681f57e28559bd0ee584c450cb2446`. Initial Git status was clean. Read the planning protocol and three-lens requirements, parent full-proof/paper story S3126, assembly story S3137, dependency assessment, and foundation semantics review. Inspected all 33 mapped source diffs against their per-entry source pins, the actual probability/geometry definitions and strongest connecting signatures, boundary examples, README, source map, and author build evidence. This is a semantic port review, not an independent re-proof of every imported dependency.

Independent read-only reconstruction passed for all 33 files: original Git bytes matched source hashes; each literal replacement had exactly one occurrence; ordered normalization/BOM/remapping transforms produced the exact working bytes and mirror hashes. The aggregate contains exactly 35 imports: the pinned PCP and Cook-Levin headlines plus all 33 mapped main/Checks modules. It declares no assembly theorem. Unmapped RandomizedReduction and root geometry drafts are excluded.

Frozen working-byte SHA256 values:

| Artifact | SHA256 |
| --- | --- |
| README.md | 32b4a0f2af620148496bad5ee57ded9e2824ae59b007c42c9d182a6e869d57d3 |
| source-map.json | b60506d4a969d19e9f3d87615a1fd09274b6a07f9459381b657b9c2b8d93f297 |
| build-evidence.md | 18fdbf245e5b4c28e1835635165338657a4b77bf8d693c976be1c9e28cbcaf96 |
| lean/PvNP.lean | f6bde30681dcf7a14c1ac6adee16d18374a5c58e0090716bfb8c28a03100333b |

No compiler, Lake, cache, dependency, or code mutation was performed by this reviewer. Author evidence records all 33 exports and aggregate exit 0; independent compiler evidence belongs to the separate proof reviewer and is not replaced by this verdict.

## Findings

**No blocking semantic regression found in the port.** Changes comprise split imports, renamed ordered-field/clog APIs, explicit namespace qualification, and proof elaboration/tactic repairs. In particular, the SamplingGuarantee `change` line aligns the goal with its existing rounded law; it does not change the law, event, or bound. The `Module.Basis` spelling change preserves the annihilator construction. The new ZMod field import supplies the existing GF(2) structure; it does not introduce a new hardness hypothesis. No desired success, source hardness, or independence premise was added by these repairs.

| Component group (including mapped Checks) | Preserved mathematical meaning and limit |
| --- | --- |
| ExceptionRepair, Formula, Checks | Positive AND/OR syntax, leaf occurrences, fresh variable per indexed occurrence, rational weights, separate YES and universal strict NO implications. A satisfying assignment is used to prove existence of a repaired witness, not supplied to the output constructor. |
| WeightRounding, FiniteRepairRoundingPipeline | Positive normalized rational output weights and clipped budget; gap is natural `(sig / 4) / 2`; parameters require sig at least 8 and gam below 1/2. Common denominator and reciprocal-budget bounds remain numeric and conditional on explicit inverse bounds. |
| FiniteSampling, InverseCDFSampler, JointSamplingLaw | Cumulative floor rounding, actual first-crossing sampler, exact fibre counts, product trial distribution, and pushforward equality for arbitrary events. Repeated list entries remain distinct trial positions. The product event theorem is not limited to rectangular events. |
| BernoulliMGF, FiniteConcentration | Actual centered Bernoulli MGF bound and product-law concentration. The assignment union bound ranges over exactly all `Fin N -> Bool`, with factor `2^N`. This is probability analysis; no algorithm enumerating those assignments is asserted. |
| SamplingThreshold, ComputableSampleCount, SamplingGuarantee, SamplingFormulaPromises | Actual finite bit-array success for the original-law approximation and repaired/rounded output. YES and NO are separate implications for the same input-only constructor. The NO event universally quantifies every output assignment at the floor-gap budget. Computed count supplies 5/6 success, hence 2/3, without assuming concentration as an axiom. |
| SeedEncoding | Explicit bijection between `Fin (M*b) -> Bool` and independent blocks, exact arbitrary-event uniformity, and prefix fibre cardinality `2^k`. Padding preserves the distribution by counting fibres. This does not yet identify a polynomial-time TM constructor or bound its cost. |
| PosteriorReweighting | Actual finite rational marginal and Bayes formula; normalized mixture bound retains `4*eta + 4*zeta/p0` and normalizer at least `p0/2`. The likelihood bound, smallness and exceptional mass are explicit inputs, not discharged geometric conclusions. |
| TripleRestrictionRank, SubspaceRestriction | Actual independent triple deletion law, retained coordinate subspace, injective rows, and annihilator representation of an arbitrary fixed W. Failure is bounded by `(2^codim(W)-1)*beta` for W fixed outside the random draw. This does not prove a bound for W chosen from that draw. |

### Notes that must remain attached to acceptance

1. **Null cases are not normalized away.** `posterior_normalized` requires positive marginal. At marginal zero, division gives zero; `joint_zero_of_marginal_zero` and total probability handle the zero contribution under nonnegativity. Algebraic normalization identities with fewer sign assumptions are not themselves probability assertions. Triple-draw bounds require `0 <= beta <= 1`. General sampler identities can include D=0 as a vacuous finite-domain identity, while actual bit sampling uses positive `2^b`. Empty-trial average identities use division by zero consistently; positive-confidence empirical theorems require or derive M>0. The normalized support condition implies S>0. The inspected zero-atom and repeated-cut examples cover a substantive boundary, rather than assuming every atom has positive mass.

2. **Numerical bounds are not encoded runtime bounds.** The computable count is `2^clog2(32*(N+11)*P^2)`, bounded by `64*(N+11)*P^2` for positive P. Applying it requires an explicit inverse-error bound. Likewise `polynomial_denominator_bound` assumes the cardinality and inverse-budget inequalities. Neither theorem proves that N, P, support enumeration, rational arithmetic or output length is polynomial in the chosen bit encoding. A `Nat -> Rat` input function is not automatically a finite encoded efficiently evaluable table. The noncomputable analytic sample counts remain mathematical comparison objects. The computable replacement and flattening are useful ingredients, not an FP proof. S3131 retains those obligations, including malformed inputs and length-only coins.

3. **Quantifier order remains essential.** The strongest computed YES probability uses one source witness outside the seed event, allowing a repaired witness for each output. The NO probability event quantifies all output assignments simultaneously. These are appropriate separate promise implications. Their source promises still need to come from the actual NP reduction. For geometry, W may later be fixed after selecting advice Q, but applying the current bound inside a Q-conditioned distribution requires the actual joint law and posterior likelihood transfer. No conditional independence, union over all W, or draw-adaptive W theorem follows from the current statement. S3133-S3134 retain incidence/counting/likelihood/tail/covering/decoder obligations.

4. **Simultaneous imports establish compatibility, not composition.** The actual library `MapReducesPoly` requires an FP bitstring map and an all-input membership equivalence; `NPHard` quantifies actual NP languages. The imported PCP theorem retains constructible randomness and constant queries. Neither this generic PCP result nor Cook-Levin supplies the specialized outer 3-Lin/repeated game, MZ decoder/list bounds, KMS covering, modified star PCP, or HN learning transfer. No mapped theorem mentions an instantiated reduction from those headlines to this CMMSA output. Those links remain S3132-S3136 requirements. The prior foundation warning about dense proof length and binary-to-unary expansion remains applicable.

5. **Fixed L and learning remain open.** The all-large-fixed-L quantifiers, eventual positive parameters and logarithmic limits are not established by this port. L must precede the choice of reduction machine and polynomial; no uniform growing-L polynomial claim is supported. The 5/6 sampling budget merely leaves failure room for a later learning transfer. It does not establish the actual universal-program/advice theorem, its 0.49 and five constants, or the HN randomness-dependent advice requirements. Final Main/Audit and manuscript crosswalk remain open.

6. **Low-severity documentation history.** The aggregate's first comment still says UNCOMPILED, and some map transform reasons retain historical verification-pending language. Current README, per-entry status and build evidence correctly identify the author build milestone. Treat these comments as stale history; updating them can be documentation-only after the review freeze. They do not strengthen a theorem, but should not be copied into the final reproducibility instructions as current status.

## Disposition

GO-WITH-NOTES permits this finite-component port to proceed through the other required lenses and become a source integration baseline once their gates pass. It does not close S3126 or the full S3137 assembly story. No P-versus-NP result, full randomized NP-hardness proof, exact learning corollary, publication readiness, or novelty conclusion is certified here.

Remaining work: independent proof/build and non-claims closeout for this frozen increment; compile and review excluded drafts separately; discharge the full dependency ledger, encoded runtime/composition and fixed-L parameters; reconcile the full submission paper and final theorem evidence. No release or public action was performed.
