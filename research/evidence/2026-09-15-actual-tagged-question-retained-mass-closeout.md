# Actual tagged-question retained-mass closeout

Date: 2026-09-15. Disposition: **GO-WITH-NOTES**. This increment converts the certified actual tagged-question count into normalized full-space mass and conditioning-denominator bounds. It does not construct the conditioned law or complete the randomized reduction.

## Frozen sources

| Source | SHA-256 |
|---|---|
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualTaggedQuestionRetainedMass.lean` | `22F98B1FF1F84D0BED94744A62873A933C7B531EA310DA953D01B5FBA1581E91` |
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualTaggedQuestionRetainedMassChecks.lean` | `9289DD63BEC7798158DF36D7E71D2C0E9365EB34401955C45B6FDF4C7177A2DB` |

The module defines the good and bad ordered-question finsets and their rational uniform masses. Its ten public theorems prove:

- the actual normalized bad-mass bound `J(J-1)157 / (K * I.rows.length)` for positive `K` and `m`;
- bad mass at most `1/T` for `K = actualPaddingCopies J T`;
- bad mass at most `1/4` when `4 <= T`;
- an exact good/bad cardinality partition and exact mass complement;
- positive total and good cardinalities;
- good mass at least `3/4`; and
- reciprocal good mass at most `4/3` and strictly below `2`.

Checks profiles all four definitions and ten theorems, verifies `actualPaddingCopies 0 4 = 1`, `actualPaddingCopies 1 4 = 1`, and `actualPaddingCopies 2 4 = 1257`, exercises the quarter bound at `J = 0, 1`, and exercises strict good-cardinality at `J = 2, T = 4`.

## Fresh certification

The canonical certification folder is `research/evidence/2026-09-15-actual-tagged-question-retained-mass-fresh-run`. The SHA-256 of `artifact-hashes.txt` recorded by `artifact-hashes-manifest.sha256` is `3D62FA741B1CC5AE6B8704D52444621059F06063B6812889FF2765D9A2C4E5D1`.

The isolated target was seeded from the prior certified actual-count target while excluding the current main and Checks artifacts. Both excluded objects were absent before compilation. Main was built before Checks with direct `lean.exe`, one Lean thread, no `lake build`, and no scratch or probe root in the dependency path.

| Module | Exit | Object bytes | Object SHA-256 |
|---|---:|---:|---|
| `ActualTaggedQuestionRetainedMass` | 0 | 450,152 | `4BF0B86EA74363B9F58CDB97E27D4863402D1913B209E10B30B7CCBF8AFB6AB6` |
| `ActualTaggedQuestionRetainedMassChecks` | 0 | 30,536 | `85B12CFC079580878EEBE701705B4E573A0A89B5D9E09A2FF09457A7EA31864B` |

The source hashes were stable before and after certification. The source scan found no `sorry`, `admit`, `native_decide`, or source-level `axiom`. The declarations use only the standard `[propext, Classical.choice, Quot.sound]` profile. Main emits two unused-simp-argument warnings; Checks is green.

## Three-lens review

| Lens | Verdict | Review SHA-256 |
|---|---|---|
| Proof-adversarial | GO-WITH-NOTES | `FDDAE8FAC2A7530123DE497DBF14EC8F82439253A32B76479F990442A8AA032E` |
| Complexity theory | GO-WITH-NOTES | `8D326A6BE0D2BE0E9EFED660C63A6D13BFBE83F432176B525BCD28BD3ED4D466` |
| Non-claims boundary | GO-WITH-NOTES | `8E3EB330A29F4F2FC87B89A78A40078D1130114975C3CF3FA601A166F9CBE217` |

All reviewers verified the frozen source hashes and evidence manifest. The proof review notes that the reciprocal bound is algebraic and does not construct a conditional sampler; the `J = 0, 1` fixtures exercise the general bounds rather than exact bad-mass-zero identities.

## Claim boundary and next consumer

This closes the manuscript's `1/4` retained-mass branch and establishes a nonzero conditioning denominator with cost at most `4/3 < 2`. It does not prove the separate `tau/100` branch, because the manuscript's formal `tau` carrier and copy-count choice are not yet fixed. It also does not prove a conditioned-law failure inequality, conditioned base uniformity, source-to-output distribution transport, ordered-to-subset or clique/star stationarity, the fixed-`K` encoded producer, the final randomized reduction, learning hardness, or P versus NP.

The next risk-first obligation is the exact conditioned-law and source-to-star transport contract consumed by the headline reduction. That contract must account for the generally nonuniform base projection after conditioning, whose fibre weights are the proper-colouring counts of the base conflict graph. In parallel read-only planning, fix the `tau` carrier and the polynomial copy-count/producer contract, but do not substitute either for the missing transport theorem.
