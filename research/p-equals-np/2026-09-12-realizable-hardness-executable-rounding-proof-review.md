# Executable rounding: independent proof-adversarial review

2026-09-12. Reviewer: `/root/rounding_independent_proof`, distinct from the target author. Scope: S3131/S3137 under S3126, exact source freeze `6ec557d61ccfc0603aff59c9dbcf2e8672c531ad`. Verdict: **GO-WITH-NOTES** for the two-module arithmetic increment. This does not certify the complete reduction or paper.

## Independent build and evidence

I read the complete main and Checks sources, the author receipt and its superseding verification appendix, the relevant input Parameters and rounding definitions, and the three-lens protocol. No local AGENTS.md exists at the satellite root or in the searched certifications/research trees. No target source, dependency, configuration, Git state or public artifact was changed by this review.

After inspecting the preparation and runner scripts, I verified and copied nineteen original accepted dependency exports into the fresh `certifications/realizable-hardness/.lake/build/executable-rounding-independent-review-20260912` root. This comprises the thirteen finite pipeline dependencies and six independently accepted CMMSA encoding modules. Both targets were then independently compiled, without using the author's target exports.

Session **66958** completed with actual **EXIT 0** for both ExecutableRounding and ExecutableRoundingChecks. The compiler slot was released on terminal confirmation. Lean was 4.34.0-rc2, commit `6a10ac8c22beadecabdbb0919c2b50214762f91d`; the pinned manifest and all eleven actual package HEADs matched. The runner enforced LEAN_NUM_THREADS=1 and actual GlobalMemoryStatusEx available memory at least 768 MiB before each child, with owned-child termination below 640 MiB. Neither guard stopped a child. Raw logs and actual exit records were persisted before display.

All **26 axiom profiles** contain only `propext`, `Classical.choice`, and `Quot.sound`. All **10 examples** compiled. The three actual evaluations were `[32, 993]`, `34 / 1025`, and `32`. Main emitted only two letI style warnings. Source scans found no sorry, admit or native_decide; inspected declarations introduce no custom axiom. The kernel profiles are stronger evidence than that token scan.

I reverified both source/output/log triples, source identity to the freeze (allowing explicitly recorded CRLF-to-LF normalization), all nineteen current dependency source/copy hashes, and all nineteen author portable artifacts against their byte counts, hashes and embedded raw UTF-8. The paired proof-verification JSON embeds six new raw artifacts: runner, copy receipt, and the two exit records and logs. It records full commands, paths, source/frozen/output hashes, pins, guards and profiles. Reusing accepted dependency exports is not a fresh rebuild of the full transitive library.

## Adversarial statement and hypothesis audit

The concrete execution inputs are `ws : List Rat`, `M : Nat`, and InputParameters with exactly `s`, `eps`, `gam`, and `sig`. They contain no desired output function, final equality, runtime certificate or promise result. `inputOf` forgets proofs from Parameters. The latter contains positive normalized input weights, `0 < s <= 1`, nonnegative eps, `0 < gam < 1/2`, sig at least eight, and eps*sig <= gam/2. Those are actual input restrictions, not a disguised final theorem. The ambient ws variable is the intended concrete input list; I found no unintended law/function parameter in these declarations.

The execution path computes the repair lambda and budget, preserves original coordinates in the first block and one exception coordinate per indexed formula in the second block, computes each upward-rounded numerator with the dyadic scale, sums those numerators, and clips the budget numerator before dividing. `numerators_eq`, `denominator_eq`, `clippedNumerator_eq`, `outputWeights_eq`, and `outputBudget_eq` establish general arithmetic identities. `outputData_fields` establishes both actual semantic record fields for every formula family, without assuming the fields equal. The equality theorem's arbitrary formula family does not claim to compute it.

The positive integer and size conclusions require M > 0 as well as valid Parameters. Normalized positive weights exclude an empty valid ws. Raw definitions nevertheless remain total for invalid scalars, zero denominators or empty lists because the underlying natural and rational operations are total. The empty and deliberately invalid clipping examples assert only raw behavior; they do not assert those inputs satisfy validity or soundness.

The stronger size theorem really derives its reciprocal estimates: for positive rational q, its integral positive numerator is at least one, giving 1/q <= q.den. Substitution yields `B = 16*(ws.length + M + 1)*(s.den + sig*gam.den) + (ws.length + M)` directly from stored scalar data. No reciprocal certificate remains in `input_denominator_bound` or `input_arithmetic_wire_bound`. The earlier P,Q-parametrized lemmas retain such hypotheses honestly and are used only through the derived estimates.

All coordinate and clipped-budget numerators lie between one and their computed positive common denominator, which is at most B. `fractionTree` uses that unreduced common fraction explicitly; `read_fractionTree` requires a positive denominator and proves the codec recovers exactly the quotient. Therefore the fragment bounds use the bit size `B.size`: the weight-list encoding is at most `(ws.length+M)*(8*B.size+4)+1`, and the budget fragment at most `8*B.size+3`. This does not mistake numeric B for input bitlength. `read_semantic_fields` connects those same emitted arithmetic fragments to the existing semantic weights and budget.

## Notes and remaining obligations

- **Scope note:** only arithmetic fields and their fragments are implemented here. Input decoding, finite source sampling, formula payload construction and full per-seed output assembly remain separate obligations.
- **Complexity note:** binary output size and computable definitions are not an FP theorem. Polynomial runtime for rational arithmetic, dyadic logarithms, traversal and serialization, together with encoded input-size accounting, remains unproved by this pair.
- **Presentation note:** source headers and the historical top of the draft still say UNCOMPILED; the author appendix and this independent receipt supersede that historical status. Update those labels during deliberate artifact consolidation, without altering the audited snapshot now.
- **Goal boundary:** specialized source hardness, final fixed-L composition, learning and full manuscript reconciliation remain incomplete. This review identifies no HIGH vacuity, circular-hypothesis or statement defect within its bounded arithmetic scope. The independent complexity and non-claims lenses remain separate reviews.

The full goal and the eventual fresh-checkout proof/paper consolidation requirement remain open.
