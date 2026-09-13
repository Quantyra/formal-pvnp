# S3133 geometry companion: independent complexity review

2026-09-12. Reviewer: geometry_complexity_review, independent AI complexity lens. Verdict: **GO-WITH-NOTES for the exact finite geometry increment only**. No blocking semantic issue found in the reviewed six sources. This is a source review, not an independent build certificate, human peer review, novelty review, or full-hardness certification.

## Candidate and inspected evidence

Frozen candidate: `046703c2a1e7ab150c0bd3d7f80fc3a12b0d1eda` in `C:/Users/Dan/Desktop/Projects/formal-pvnp`.
Separate map: `certifications/realizable-hardness/geometry-draft-source-map.json`, frozen Git-byte SHA256 `4271e2b6257c57d75173a0969a4b6dc9736e9276b3d0d94995e943b1c38d7301`, independently recomputed.

All six full sources were read under `certifications/realizable-hardness/lean/PvNP/RealizableHardness/`; their working bytes after CRLF normalization matched the frozen candidate. Frozen source SHA256 values:

| Module | SHA256 |
|---|---|
| GrassmannIncidence | 274ba972115642cc39f94ff6456a2260f4656c9092fcb70d72612a454430d60b |
| GrassmannIncidenceChecks | 04cd971c23b8340916f3206b8818e149b1d65362d6b114134cafd5de9c656d73 |
| GrassmannCounting | 84d730695a3f4fc2de11f6683f6aef4fe4efc8eaea7cd23c3135d84ee944b887 |
| GrassmannCountingChecks | ff505d1a5f0ee537441231418ecdddae70bb2374ae7493c112c99ef2aa391f11 |
| TripleRestrictionDimension | 18dcb7a132df2dc5b8e84dbc1cdbfad230394fc4d7602e29ea7016bd57945925 |
| TripleRestrictionDimensionChecks | 5344221c38378beab52aa17f477694609ed12ab4e66221016f1892b95d2808ff |

Read the full dated geometry-companion-draft receipt, including failed attempts and final author logs; the full Lean dependency assessment; planning protocol, formal-three-lens protocol and S3133; and the manuscript's posterior/zoom-out calculation (submission-manuscript.md, lines 304 onward, in the separate realizable-cmmsa-hardness repository). Inspected actual imported TripleRestrictionRank block law and PosteriorReweighting definitions/normalization/ratio/cutoff interface. The inbox's latest governance routing does not change this proof boundary. No satellite AGENTS.md exists at the repository root.

The author receipt records six EXIT0 exports and 53 selected standard-subset axiom profiles (17 incidence, 21 counting, 15 dimension, including one axiom-free report). Those are author evidence inspected in the receipt; this reviewer ran no Lean/compiler or independent axiom audit. Independent build/proof review is a separate mandatory gate. The newer GaussianRatio draft and RandomizedReduction are excluded, as is the original accepted 33-module aggregate.

## Actual laws, quantifiers and domains

`Advice J a` is the subtype of actual submodules of the coordinate vector space over GF(2), with dimension exactly a. It is not an abstract advice label with supplied cardinality. The fibre is exactly those submodules contained in `retained d`. Its reciprocal-cardinality kernel therefore represents uniform choice in that actual fibre.

Nonemptiness is derived for every draw under a<=J: the construction chooses one always-retained coordinate in each block and embeds the first a coordinates injectively. The proof does not assume the desired fibre exists. The same embedding proves finrank(retained d)>=J. This is a sufficient uniform domain for all draws, not a claim that all a<=3J admit every fibre. The manuscript must eventually discharge a<=r<=J. No normalization claim is made for arbitrary a outside this domain.

The prior is the actual product law on Option(Fin 3): none has mass 1-beta and each singleton beta/3. It agrees with the manuscript's independent full-triple versus uniform-singleton experiment. Joint, marginal and conditional are actual finite sums and quotients using this kernel, not supplied probability contracts. Theorems about total mass hold algebraically even outside beta in [0,1]; interpreting them as probabilities additionally requires the explicitly available nonnegativity hypotheses 0<=beta<=1. This separation is mathematically legitimate and must remain visible in any assembly.

Conditional normalization and Bayes mass require a positive advice marginal. At zero marginal the rational division convention gives the zero function, not a normalized conditional probability. The exact conditional-ratio identity only requires positive prior mass; its zero-marginal algebra does not license probabilistic conditioning there. The posterior is generally not the original product law; no conditional independence is asserted. Fixing Q and a dependent W(Q) is compatible with later applying an unconditional fixed-W theorem followed by a proved density comparison, but this six-module increment does not yet perform that transfer.

## Exact counts and dimension

The counted-frame decomposition is substantive: flatten maps a pair consisting of an actual a-dimensional subspace and an internal independent a-frame to an ambient frame. Span equality recovers the subspace, proving injectivity; taking the span of an ambient independent frame proves surjectivity. This derives the double count from a genuine equivalence rather than assuming the Gaussian formula.

The standard finite-field independent-frame count yields the product of (2^n-2^i). Positivity of frameProduct(a,a) is proved even at a=0 through the empty-product convention. Natural division is justified by the exact multiplicative count, so the result is not an arbitrary rounded quotient. Out-of-range a>n is handled by actual emptiness, while a=0 and a=n both count one subspace.

The map/comap equivalence identifies subspaces of W with ambient subspaces contained in W without changing their dimension. `incidenceCount_eq` connects the previously defined sampler denominator to gaussian(finrank(retained d),a), including zero and out-of-range cases. The theorem is about the same fibre used by the kernel, not a different abstract counting model.

`retainedEquiv` is restriction with inverse zero extension on precisely the retained coordinates. The coordinate-to-block dependent-pair equivalence partitions those coordinates into three for a none block and one for a singleton block. Consequently the additive identity finrank(retained d)+2*dropCount(d)=3J is exact and avoids natural-subtraction ambiguity. The subtraction form is derived from it; dropCount<=J is separately proved. No probabilistic assumption is needed for these pointwise facts.

Nonvacuity/boundary Checks cover J=0, a=0, out-of-range a, full dimension, beta endpoints, seven GF(2)^3 lines and seven planes, all-full and all-singleton draws, and a two-block mixed draw of dimension four. These examples support the intended conventions; universal proofs, not the finite examples alone, carry the general statements.

## Fit to the manuscript and remaining gap

The reviewed results give the concrete foundations for the displayed posterior identity: prior over actual draws, exact uniform containing-subspace kernel, actual marginal and Bayes ratio, exact Gaussian denominator, and dim(V)=3J-2D. They remove genuine representation/counting obligations in S3133.

They do not yet prove the Gaussian ratio bound, the uniform ambient advice probability bridge, posterior density <=8*2^(2aT), binomial law/tail for dropCount, exceptional-set Markov and statistical-distance transfer, or the resulting conditional rank bound. Gaussian here is a natural cardinality; later rational/real ratios must preserve positivity and justify casts/division. Nor do they establish the KMS experiment's equivalent posterior obtained by conditioning Q subset L: that requires the additional contained-Q d-subspace count and cancellation of its V-independent numerator, with all dimension and positive-event hypotheses. Zoom-out quotients, relative error, vector-advice coupling, covering and weighted mixtures remain required. No conditionally independent W or unconditioned replacement draw may be inserted to bypass these gaps.

The definitions use noncomputable finite enumerations, classical choice and submodule predicates. Exact finiteness/cardinality is not a polynomial-time sampler or bit encoding. There is no encoded output-size, runtime, bounded-coin or randomized reduction theorem in these six modules. Any runtime claim must be proved under S3131 and the actual fixed-L quantifier order; no growing-L uniform exponent follows.

The receipt and source comments bound the result to finite geometry. Historical UNCOMPILED banners now conflict with the later author-success receipt only as stale conservative status text; they do not inflate claims. An eventual metadata update should distinguish author success, independent acceptance and historical source status without rewriting proof evidence.

## Disposition

GO-WITH-NOTES for use as this bounded finite-geometry dependency, contingent on the separately required successful independent build/proof and non-claims gates. No source fix is requested by this complexity lens. No new source assumptions, vacuity, false force inequality, reduction-runtime claim or full-hardness claim was found.

S3133 remains active for the stated analytic/probabilistic bridges. Specialized PCP/game/decoder and compilation, encoded machine reduction, exact HN learning transfer, fixed-L parameter limits and full theorem assembly remain required under S3131-S3137. Final paper reconciliation remains required under S3128. Neither full certification nor publication readiness follows from this review.

Only this new report was written. No source, map, configuration, dependency, compiler output, existing receipt, public metadata or publication was changed. No Git mutation was performed before the orchestrator's explicit scoped grant. The pre-existing untracked nonclaims report was preserved.
