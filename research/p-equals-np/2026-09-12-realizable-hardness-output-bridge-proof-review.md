# SamplingFormulaPromises independent proof-adversarial review

2026-09-12. Reviewer `guarantee_proof_review`, not the author of this bridge.
Frozen candidate `66672972b6577eb7058d1da574bf718b115320d3`; S3130 under open S3126.

**Verdict: GO-WITH-NOTES.** Both scoped exports independently passed with all 15 standard-only axiom profiles. No blocking proof defect was found. The imported count increment retains its own outstanding Checks and independent-review debt.

## Scope and identity

Read destination `INTEGRITY-CLAIMS.md`, the planning three-lens protocol and owning S3130 context, actual bridge main/Checks and author receipt, and the imported SamplingGuarantee, FiniteRepairRoundingPipeline and ComputableSampleCount source interfaces. Read the bridge complexity receipt only after independent source inspection. The imported count author is not used as an independent count verifier by this lens.

Both bridge files are raw byte-identical to their candidate blobs, including the explicit CRLF-to-LF comparison; both have zero CRLF sequences:

- `lean/PvNP/RealizableHardness/SamplingFormulaPromises.lean`: SHA256 `5b3be5d6cc5b66c9907855153b7e11c11c43e28fca5feff952ea649de278e941`.
- `lean/PvNP/RealizableHardness/SamplingFormulaPromisesChecks.lean`: SHA256 `ef50b659f0275a622c0a918c543b0ae6e58fbf47d4da9f6b9edacc225512af06`.

Imported `ComputableSampleCount.lean` has working SHA256 `cd100cb750324c1d3591f8bc8b6d2546c39614c6ae9fa516e5f53d0d11249a1a` with 82 CRLF sequences; its candidate Git blob SHA256 is `d611b5fe4b3770b27aeb05deb690fcc160948b96e6268fea681288cf6c26fac9` with LF only. They agree after CRLF-to-LF normalization. This is newline variance, not a count theorem change.

## Proof-adversarial findings

1. `sampled` retains every Fin M trial position, including duplicate atoms; there is no deduplication or YES/NO branch. `output` applies the actual pipeline repair constructor to precisely that list. Actual rounded weights and clipped budget come from the same pipeline parameters and trial type; they do not depend on the supplied YES witness. `fromSeeds` is definitionally the same sampler-based list. Each final formula has exactly one additional leaf.
2. `empirical_eq_average` unfolds the actual real indicator sum and rational acceptance average, casts the finite sum, division and Boolean conditional, and proves their equality. The zero-trial identity is legitimate as an algebraic identity. The output-preservation theorems separately require positive M and construct Nonempty (Fin M); computed probabilities discharge this through `count_pos`. Thus the zero-division convention is not used to bypass a positive-trial premise.
3. Under Good, the YES lower empirical deviation and original mean at least 1-eps/4 give empirical acceptance greater than 1-eps/2 and hence at least the conservative 1-eps repair requirement for nonnegative eps. The NO upper deviation and original mean at most gam/2 give acceptance below gam because `parameter_margin` derives eps/4 < gam/2 from sig >= 8, eps >= 0, eps*sig <= gam/2 and gam > 0. Exact rational/real casts preserve these inequalities.
4. YES supplies one original assignment of weight at most s and obtains an existential output assignment satisfying every repaired formula under the rounded budget. NO independently assumes the original-law mean condition for every assignment of weight at most sig*s and concludes a universal statement about every assignment on Fin N + Fin M below the actual nested-floor gap times the output budget. No statement assumes YES and NO together. Good is already simultaneous over all source assignments before probability is transported; no interchange of probability and universal quantification occurs.
5. The specialized theorems do not assume Good or an output probability. The generic helper's event-inclusion premise is explicitly discharged by the corresponding deterministic YES/NO theorem. `seedProbability_mono` is proved by pointwise comparison of uniform finite seed indicators and division by a nonnegative denominator. Its use transports the actual Good event from the same sampleArray, precision, trial count and original law to the actual output event.
6. The count is exactly `2^(Nat.clog 2 (32*(N+11)*P^2))`. The helper casts the positive rational epsilon and reciprocal bound 1/eps <= P to Real, applies the imported learning-threshold domination theorem, and uses the proved precision grid inequality. The count is always positive; positive epsilon and the reciprocal premise also imply P > 0. Original-law normalization implies S > 0. The result is at least 5/6 for the respective output event, with the at-least-2/3 conjunct obtained by numerical weakening of the same probability, not by changing counts or events.
7. Parameter validity implies a nonempty original variable domain: positive weights summing to one cannot exist on Fin 0. This differs appropriately from the generic SamplingGuarantee, which allows N = 0. Neither source nor output NO budget is empty: all-false has weight zero, positive s and positive output budget, and gap >= 1. The universal NO assertion therefore cannot pass solely because no budget-qualified assignment exists.
8. Positive-error hypotheses are consistent. As a hand-checked witness (not an additional Lean export), take N = S = 1, unit atom mass and unit original weight, formula var 0, gam = 1/4, sig = 8, eps = 1/128 and P = 128. Then eps*sig = 1/16 <= gam/2. For YES choose s = 1 and the true source assignment. For the separate NO case choose s = 1/32: the only source assignment under sig*s = 1/4 is false and its acceptance is zero. Thus neither specialized theorem is restricted to contradictory numerical premises. Existing bridge Checks exercise duplicate positions and zero-trial casts, rather than these positive-error witness instantiations.

No source sorry/admit, custom axiom declaration, unsafe/native_decide escape or option weakening was found in the two bridge modules. No HIGH vacuity, hidden-promise, quantifier or event mismatch was found.

## Verification and dependency boundary

Root granted an exclusive compiler batch after the preceding count diagnostic/evaluation batch reached actual terminal results. With cached Lean 4.13.0 and `LEAN_NUM_THREADS=1`, fresh no-competing-Lean and 512 MiB capacity checks preceded each command:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/SamplingFormulaPromises.olean lean/PvNP/RealizableHardness/SamplingFormulaPromises.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/SamplingFormulaPromisesChecks.olean lean/PvNP/RealizableHardness/SamplingFormulaPromisesChecks.lean
```

Main session **71485 exited 0**, with only the expected cosmetic `unnecessarySeqFocus` warning at line 26. No linter suppression or source fix was made. Prelaunch free capacity was 4,174,307,328 bytes. Checks session **37525 exited 0**, with no warnings; prelaunch capacity was 4,135,084,032 bytes. In-flight capacity was observed above 4.11 GB. No download, dependency rebuild or historical failed-handle restart occurred.

All **15 profiles** were independently observed. `SamplingFormulaPromises.output_leaves` and `SamplingFormulaPromisesChecks.duplicate_positions` use only `propext`. The remaining 13 use exactly `propext`, `Classical.choice`, `Quot.sound`: `empirical_eq_average`, `good_yes_average`, `good_no_average`, `parameter_margin`, `good_yes_output`, `good_no_output`, `fromSeeds_eval`, `seedProbability_mono`, `computed_event_probability`, `computed_yes_probability`, `computed_no_probability`, and Checks `duplicate_empirical`, `empty_trials`. Namespace prefix is `PvNP.RealizableHardness`. None contains sorryAx or a custom axiom. Post-export source hashes and raw candidate equality were rechecked unchanged.

The imported ComputableSampleCount main has kernel proof/export evidence, and this review inspected how its exact threshold theorem is used. Its own Checks and independent three-lens acceptance remain separate and pending at review assignment. A successful bridge profile can establish that the used dependency proof introduces no extra axiom; it cannot close that dependency's outstanding validation workflow or certify unrelated examples. SamplingGuarantee and the finite repair/rounding pipeline are separately reviewed bounded increments.

## Acceptance limits

This is finite semantic composition using the actual sampler and repair/rounding definitions. It does not prove polynomial support enumeration, an efficient representation of the Nat-indexed formula family, an upstream source distribution or weight promise, a polynomial inverse-error bound, encoded arithmetic/machine runtime, PCP or NP-hardness, asymptotic composition, or HN learning transfer. The validity and common-denominator results of the imported pipeline are not bundled into these bridge probability conclusions. The conservative computable count requires the stated manuscript reconciliation. Full S3130/S3126 remains open.

Only this review receipt was written during the independent bridge lens. The orchestrator subsequently authorized exact four-path evidence integration and a three-lens table in the formalization receipt. No source, dependency, publication or remote state was changed.
