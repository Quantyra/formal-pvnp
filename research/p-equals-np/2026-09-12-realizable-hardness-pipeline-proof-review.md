# Finite repair/rounding pipeline: independent proof review

2026-09-12. Reviewer: pipeline_proof_review, independent of the author. S3130/S3126. Candidate: `be83571ec0e4162f41d9d43da1fad20e29850387`.

Verdict: GO for the bounded fixed-list repair/rounding increment. No blocking proof issue found; independent exports and all 18 axiom profiles passed.

## Source provenance

The initial candidate `29d489ca86b7d1bd4c3fc964e44ef779648961c3` introduced exactly the main, Checks and formalization receipt. The final correction commit `be83571` changes only the main and receipt; Checks is inherited unchanged. Other working-tree changes belong to independent ongoing work and are outside this review.

| File | Git blob SHA256 | Working bytes SHA256 |
|---|---|---|
| FiniteRepairRoundingPipeline.lean | 434a0320f3179c67d7e0930fea3372f712a1ad91a1852eba684d8df598ac90de | d6377773387719ba05e19a590f2c19f2f6d7f7ab15cd9c10f1cbc4b54c9187d6 |
| FiniteRepairRoundingPipelineChecks.lean | 0e2e5e87f8cd79585c7acc6699e809087cb8c4ed1951b15cf91038c37e62f594 | d4bb968301839f234e3387172776b4f91167d4fb2ceca3c6110cbfe5e3278ed2 |

The differing raw hashes are solely Git LF versus working CRLF: normalized bytes were compared independently and equal. No sorry, admit, axiom declaration or native_decide occurs in the two scoped sources. Destination has no AGENTS.md; INTEGRITY-CLAIMS.md, the planning three-lens protocol and S3130 were read.

## Adversarial findings

- `Parameters` contains only validity and margins. YES and universal NO are distinct implications, not inconsistent joint premises. The Checks witnesses establish each premise set on a real Unit variable/formula instance. The NO example has s=1/32 and sigma=8; the true assignment cannot satisfy its input budget, while false does. The NO feasible-output quantifier is also nonempty: the all-false assignment has zero cost and the output budget is positive.
- Nonempty I is an explicit typeclass in the pipeline. Empty V cannot carry Parameters: its sum would be zero, contradicting normalization to one. Thus average denominators and the actual output coordinate domain are not accidentally empty. Positive finite normalized weights and the actual positive rational output budget are proved, not assumed as output promises.
- lambda=sigma*s/Gamma is positive. The margins imply epsilon<=1, t=(s+lambda*epsilon)/(1+lambda) belongs to (0,1], the final gap is at least one, and 0<2*Gamma<1. The small-error premise is explicitly epsilon*sigma<=Gamma/2.
- YES constructs exception bits only as a witness. The common output construction does not inspect the YES witness, failed indices or promise classification. `outputFormula` is the existing concrete repair AST, with precisely one fresh indexed leaf. Rounding changes its weights and budget, not its syntax.
- NO restricts arbitrary output assignments to the full V+I coordinates and composes the actual rounding soundness theorem with Formula.repair_sound. The gap is exactly `(sigma / 4) / 2` in Nat, hence floor(floor(sigma/4)/2); it does not silently use an unrounded rational gap.
- Reciprocal budget uses the inequality 1/t<=1/s+sigma/Gamma. Its proof keeps the nonnegative lambda*epsilon term and justifies the two divisions with strict positivity. It does not substitute the generally false equality when epsilon>0.
- `output_common_denominator` identifies the same actual rounded weights and clipped budget with their positive integer numerators and positive natural denominator, including numerator upper bounds. `denominator_bound` explicitly retains P>=1/s and Q>=sigma/Gamma; these inputs are not discharged by the local composition.

## Independent kernel verification

After explicit exclusive-slot grant, ran the following with `LEAN_NUM_THREADS=1`, cached pinned Lean 4.13.0, no dependency downloads/builds and fresh no-competing-Lean/512 MiB free guards:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/FiniteRepairRoundingPipeline.olean lean/PvNP/RealizableHardness/FiniteRepairRoundingPipeline.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/FiniteRepairRoundingPipelineChecks.olean lean/PvNP/RealizableHardness/FiniteRepairRoundingPipelineChecks.lean
```

Main session `77435`: terminal exit 0, no output or warnings. Checks session `32540`: terminal exit 0; two cosmetic unused-variable `v` warnings at lines 13 and 28, no errors. Free bytes at the respective launches were 5,341,245,440 and 5,303,975,936; a subsequent live Checks guard observed 5,275,885,568. Exclusive compiler slot was released on actual terminal completion.

All 18 printed profiles were inspected. `output_leaves` and `concrete_repaired_leaf_count` use only `propext`. The remaining 16 use exactly `propext`, `Classical.choice`, `Quot.sound`: `lam_pos`, `eps_le_one`, `budget_pos`, `budget_le_one`, `weights_pos`, `weights_sum`, `output_valid`, `yes_preserved`, `no_preserved`, `reciprocal_budget`, `denominator_bound`, `output_common_denominator`, `genuine_yes_example`, `genuine_no_input`, `genuine_no_example`, `concrete_denominator_bound`. Namespace prefix is `PvNP.RealizableHardness.FiniteRepairRoundingPipeline`. No sorryAx or custom theorem axiom appeared.

The source hashes and candidate normalized-byte equality were rechecked after both exports. Author exports 71982/92725 are not substituted for these independent results. No source change or publication action was performed; the reviewer wrote only this receipt.

## Limits

This review covers the fixed-list semantic repair/rounding increment only. It does not prove source promises, random-seed success, source PCP or hardness, encoded arithmetic/runtime, the upstream inverse-budget bound, or learning transfer. Those remain composition/full-goal obligations. No full S3130/S3126 completion, CMMSA hardness certification, publication readiness, or P-versus-NP claim follows.
