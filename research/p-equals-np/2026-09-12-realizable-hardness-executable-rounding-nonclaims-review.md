# Executable rounding: independent non-claims review

Date: 2026-09-12. Reviewer: `/root/rounding_nonclaims_review`, not the target author. Destination: `C:/Users/Dan/Desktop/Projects/formal-pvnp`; S3131/S3137 under S3126.

**Verdict: GO-WITH-NOTES for the bounded arithmetic increment.** This is an independent source and evidence review, not an independent compiler run or acceptance of the full hardness theorem. The separate proof reviewer owns compilation. No source, Git, compiler, public metadata, or unrelated work was changed by this review.

## Exact reviewed state

Freeze: `6ec557d61ccfc0603aff59c9dbcf2e8672c531ad`. Current bytes equal frozen bytes exactly for all three targets:

| Path | SHA256 |
| --- | --- |
| certifications/realizable-hardness/lean/PvNP/RealizableHardness/ExecutableRounding.lean | 306c0c17d14e706e98e1b0cec9b5bdc54d59c2649bd0abe0b09de523210fb28e |
| certifications/realizable-hardness/lean/PvNP/RealizableHardness/ExecutableRoundingChecks.lean | e81b713dfa09aa5733c69dc9924bca417d19fd92faac59f8326842692a2abcf7 |
| research/p-equals-np/2026-09-12-realizable-hardness-executable-rounding-draft.md | ec21a89b31e185770e8f41d47ea12cebeb7de11ba4a2b45954e14a70f3a2be29 |

Read the complete source pair, receipt narrative and structured evidence, plus the actual upstream Parameters, rounded coordinate/scale, flatWeights/outputData, readRat and natTree definitions and relevant bounds. Applied Quantyra planning `docs/protocol.md`, `docs/formal-three-lens-closeout-protocol.md` and `docs/claim-boundary-expansion-protocol.md`. Existing sampler modifications, port-cycle drafts and another review were preserved.

## Statement and binder audit

InputParameters contains exactly s, eps and gam as rationals and sig as a natural. The executable functions take an explicit List Rat and M, derive repaired coordinates, scale, numerator list, denominator and clipped budget; they do not take a target function, correctness oracle, output identity or runtime certificate. The final map binder is explicitly `(n : Nat)`, so the intended numerator list is mapped directly into rational division.

The semantic equality theorems quantify over `p : FiniteRepairRoundingPipeline.Parameters ws.get`. Inspecting that structure shows positive original weights summing to one; 0 < s <= 1; eps >= 0; 0 < gam < 1/2; sig >= 8; and eps*sig <= gam/2. These are substantive input restrictions, not a stored conclusion. The free list ws is the same list whose get function is indexed by p. M and the coordinate domains are explicit. Positivity and bound results require hM : 0 < M; no valid empty formula family follows. No unexplained free output or ambient-law binder was found in the source statements. This source audit does not substitute for the separate elaborated proof audit.

`numerators_eq`, `denominator_eq`, `clippedNumerator_eq`, `outputWeights_eq`, `outputBudget_eq` and `outputData_fields` are general identities. They are not inferred from the examples. `outputData_fields` covers only weights and budget for arbitrary F; it does not construct the formulas, assert equality of entire serialized instances, or discharge a formula-leaf constraint. The original/exception coordinate lemmas retain list order through finSumFinEquiv.

`denominator_bound` and `arithmetic_wire_bound` explicitly accept reciprocal bounds P,Q. The stronger `input_denominator_bound` and `input_arithmetic_wire_bound` discharge these using the stored rational denominators, obtaining

    B = 16*(ws.length + M + 1)*(s.den + sig*gam.den) + ws.length + M.

Calling this input-derived is justified. Calling B the input bitlength is not. The stated wire bounds use B.size: weight fragment <= (ws.length+M)*(8*B.size+4)+1 and budget fragment <= 8*B.size+3. Neither is a time bound or a complete input/output encoding theorem.

`fractionTree` writes the actual nonnegative numerator/common-denominator pair, with no reduction to canonical form. `readRat` accepts unreduced fractions when the denominator is nonzero. `read_weightTree`, `read_budgetTree`, and `read_semantic_fields` establish exact decoding of these fragments. They do not prove byte equality to the canonical `ratTree` or to `CMMSAPipelineEncoding.outputBits`. Future full-wire assembly must preserve this distinction: equal decoded rationals need not have identical encodings.

Raw arithmetic is total on invalid scalar inputs, zero denominators and empty lists because the underlying Lean operations are total. Raw totality is not successful validation. In particular, the empty raw case yields weights [] and budget 0, while decoder lemmas still require a positive common denominator. The clipping example intentionally violates Parameters and is labeled accordingly. It demonstrates that the min branch is exercised, not that an invalid input is a realizable instance.

## Author evidence inspected

Parsed the receipt JSON and verified all 19 embedded raw UTF-8 artifacts against their SHA256 and current disk bytes. Verified both final source/output/log hash triples. Actual accepted records are EXIT0, source unchanged, no guard stop; the six historical exits remain [1,0,1,1,1,0]. The main log contains two style warnings only. The final Checks log contains 26 profiles, each limited to propext, Classical.choice and Quot.sound, and outputs `[32, 993]`, `34 / 1025`, `32`. The source contains the ten retained examples; the recorded passing Checks run is author evidence for them. No sorry/admit/native_decide or new axiom declaration is introduced by the reviewed pair.

The staged logarithm and numerator lemmas preserve the examples rather than dropping expensive checks. Private helper proofs are not separately counted among the 26 exported theorem profiles; a compiler run checks them as part of the Checks module. This is a standard-axiom result, not literally axiom-free mathematics. The compiler metadata and dependency provenance in the receipt remain author evidence; I did not run a new compiler or claim a fresh transitive dependency build.

## Wording notes and remaining obligations

1. The source headers still say UNCOMPILED. The receipt's explicitly superseding author-verification appendix makes the chronology intelligible, but the final paper/package must update those stale headers when preparing a new verified freeze. This is conservative stale wording, not a theorem defect; do not alter frozen bytes during this independent review.
2. Permissible bounded wording: concrete finite-list arithmetic computes the repair/rounding weights and clipped budget, agrees with the semantic pipeline, and has input-derived binary length bounds for its arithmetic fragments, under the stated valid-input hypotheses. Independent acceptance awaits the separate proof run and the full three-lens closeout.
3. A computable definition, successful evaluation and small output do not establish FP. Input decoding/validation, full formula and sampler construction, arithmetic and traversal runtime, full serialization, bounded random tapes and semantic probability transport must still be connected to an actual encoded polynomial-time reduction.
4. This module neither proves the specialized source-hardness theorem nor closes fixed-L hardness, learning, or the manuscript's full dependency chain. It supports no P=NP/P!=NP result, novelty assertion, publication-readiness statement, or claim that the paper has been fully certified.
5. The final requested consolidation into the paper repository must include dependencies and audits and pass a fresh-checkout build. Nothing in this component review establishes that final delivery.

No blocking non-claims defect was found for this bounded increment. S3126 remains incomplete; retain the full theorem and submission-quality paper objective rather than relabeling this arithmetic bridge as completion.
