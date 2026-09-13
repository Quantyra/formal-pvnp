# Actual flag sampler identification: source draft

S3133 / S3126, 2026-09-12. **UNCOMPILED; not accepted formal evidence.**

Owned new sources are `certifications/realizable-hardness/lean/PvNP/RealizableHardness/GrassmannFlagPosterior.lean` and its Checks module. No compiler, dependency download, Git operation, aggregate/configuration edit, publication, or existing proof edit was performed.

The full requested target is scripted, rather than replaced by the aggregate count: for a <= d <= J, the actual probability that a uniform d-dimensional L inside retained(s) contains fixed actual a-dimensional Q is gaussian(d,a) times GrassmannIncidence.kernel(s,Q). Conditioning the actual draw/L law on containment yields GrassmannIncidence.conditional on every draw atom when the event marginal is positive.

## Concrete derivation

1. `quotient_map_dimension` applies rank-nullity to Q.mkQ restricted to a containing subspace L. Its kernel is Q pulled back along L.subtype, linearly equivalent to Q by `Submodule.comapSubtypeEquivOfLe`.
2. `upperQuotientEquiv` restricts the actual quotient correspondence to dimension d, producing a bijection from d-subspaces containing Q to (d-a)-subspaces of V/Q. It uses map/comap inverses and the proved dimension shift. No count regularity premise is supplied.
3. `card_upper` and `upperCount_eq` derive the upper fibre count. `lowerCount` reuses the already established contained-subspace bijection. Swapping finite sums gives `sum_upperCount`; substituting actual quotient fibre counts gives `flag_product` and the per-Q rational `upperCount_ratio`.
4. `relativeUpperEquiv` identifies actual ambient flags Q <= L <= W with internal upper flags in W. `containmentProbability_count` expands the actual uniform sampler into its exact finite flag count. Uniform dimension support a <= d <= J supplies nonzero denominators through existing incidenceCount_pos, so `containmentProbability_formula` has no assumed count or desired-law oracle.
5. `eventMarginal_formula` factors out the V-independent Gaussian numerator. `eventPosterior_eq_conditional` cancels it using positivity of the actual event marginal. `containmentProbability_noncontainment` and `eventPosterior_null` explicitly treat unsupported Q and null conditioning mass.

The posterior identity is algebraic for arbitrary rational beta; interpreting the prior as a probability law still requires 0 <= beta <= 1, as established by the existing sampler module. The null-event result is zero division, not a normalized conditional distribution.

## Source inspection and pending validation

Pinned mathlib APIs inspected directly: Quotient/Basic.lean `le_comap_mkQ`, `comap_map_mkQ`, `comapMkQRelIso`; FiniteDimensional/Lemmas.lean `LinearMap.finrank_range_add_finrank_ker`; Dimension/RankNullity.lean quotient dimension; Submodule/Map.lean map/comap inverse lemmas; Fintype/Card.lean `Fintype.card_subtype`. Existing GrassmannCounting and GrassmannIncidence source and the manuscript posterior section were inspected. S3133 and the source-directed literature note retain the full formal goal boundary.

An initial PowerShell stdin write corrupted Unicode characters. Both owned sources were fully replaced through direct apply_patch; the corrupt draft is not evidence. Final source inspection must precede any build. No missing target was hidden as an axiom, sorry, or hypothesis. All scripts are prospective and may require compiler-driven elaboration/API repairs.

Checks request 16 axiom profiles, Gaussian zero/self boundary examples, d=a event-kernel identity, and null-event behavior. None has run. Required next action is the authorized sequential main/Checks build, actual axiom audit, and independent three-lens review. This does not establish KMS covering, statistical-distance closeness, zoom-out mixture estimates, runtime, full hardness/learning, or final manuscript reconciliation.

Root source review identified one forward reference: containmentProbability_formula used containmentProbability_noncontainment before declaration. The latter was moved before the former with its statement and proof unchanged. A lexical dependency scan across all 21 local declarations now reports no references to later local declarations; this is source inspection, not elaboration verification. Main SHA256: `9c1b9a1356fe826978f92b23c05ef559ca85900efb3be62bbd0c13a740b653c0`; Checks SHA256: `64ef701bd4c01fdabcc4007b65333d981a05106b9ab7a842bbe777d9baf2bde0`.
