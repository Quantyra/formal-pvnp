# Companion author build evidence

Status: partial author verification only; independent port reviews pending.
The full hardness theorem and learning corollary are absent. This file records
actual compiler outcomes and their verification boundaries.

## Environment and dependency preparation

Lean 4.34.0-rc2, compiler commit
6a10ac8c22beadecabdbb0919c2b50214762f91d; dependencies pinned by the committed
manifest. Root Lean 4.13 sources and artifacts were not used as companion
compiled dependencies. All proof exports use LEAN_NUM_THREADS=1 and scoped
`lake --no-cache env` invocation; no broad native build or cache download.

Artifact preparation session 64203 returned exit 0: 19,545 regular files,
2,929,292,104 bytes, with each destination SHA256 compared to its source.
The source was the matching pinned isolated foundation build. Included facets
were .olean, .olean.private, .olean.server, .ir and .ir.sig only. Pre-copy free
space was 4,918,505,472 bytes; terminal free space was 2,187,649,024 bytes.

The two missing dependency exports were handled separately. Deriv session
60542 returned exit 0 and produced all five module/runtime facets. Archimedean
36492 returned exit 1 because its output directory did not exist; after creating
that directory, 96936 returned exit 0. No dependency proof source was changed.

## Module results and diagnostic history

| Session | Scope | Actual result |
| --- | --- | --- |
| 30341 | Initial BernoulliMGF export | Exit 1; derivative simplification and residual tactic errors |
| 63597 | Explicit simp-only/residual-tactic repair | Exit 1; Real instance mismatch remained |
| 3715 | Three local backward transparency options | Exit 1; same mismatch; options subsequently removed |
| 83985 | Targeted convert! alignment | Exit 0; main exported, nonfatal tactic/linter messages retained |
| 93663 | BernoulliMGFChecks then ExceptionRepair | Checks child exit 0, all 13 profiles standard-only; runner later exit 1 printing Unicode from ExceptionRepair, whose child exit was not captured |
| 30840 | UTF-8-safe ExceptionRepair export | Exit 1; missing imported sum_div and renamed order APIs; rejected sorryAx profile |
| 18035 | ExceptionRepair import/API fixes | Exit 1; Boolean generalize failure remained; whole module rejected despite two standard-only headline profiles |
| 75063 | ExceptionRepair explicit Boolean predicate split | Exit 0; two standard-only headline profiles; downstream Formula/Checks and independent review pending |

The BernoulliMGF successful checks cover partition positivity and derivative,
gap derivative, slope derivative, curvature nonnegativity, slope monotonicity,
gap nonnegativity, centered MGF bound, and five boundary/nondegenerate examples.
Every printed profile was exactly [propext, Classical.choice, Quot.sound].
These are actual author exports, not independent reviewer acceptance.

Per-attempt ExceptionRepair output is preserved before printing in the ignored
local build diagnostics tree: `.lake/build/diagnostics/ExceptionRepair.log`
(30840), `ExceptionRepair-repair.log` (18035), and the separately named next
attempt log. No unsuccessful source or sorryAx-containing result is accepted.

The earlier Bernoulli attempt diagnostics were returned by the tool before
per-attempt file capture was introduced. Their distinguishing text is preserved
below; private absolute path prefixes have been reduced to module-relative names.

30341:
```text
BernoulliMGF.lean:25:2: error: Type mismatch: After simplification, term
  HasDerivAt.const_add (1 - p) (HasDerivAt.const_mul p (Real.hasDerivAt_exp t))
 has type
  HasDerivAt (fun x => p * Real.exp x) (p * Real.exp t) t
but is expected to have type
  HasDerivAt (partition p) (p * Real.exp t) t
BernoulliMGF.lean:32:2: error: `simp` made no progress
BernoulliMGF.lean:42:2: error: `dsimp` made no progress
```

63597 and 3715 exposed the same instance mismatch (line numbers shifted after
the local options were inserted):
```text
 has type
  @HasDerivAt ℝ DenselyNormedField.toNontriviallyNormedField ℝ Real.normedAddCommGroup.toAddCommGroup
    NormedField.toNormedSpace.toModule PseudoMetricSpace.toUniformSpace.toTopologicalSpace ⋯
    (fun x => 1 - p + p * Real.exp x) (p * Real.exp t) t
but is expected to have type
  @HasDerivAt ℝ DenselyNormedField.toNontriviallyNormedField ℝ Real.instAddCommGroup Semiring.toModule
    PseudoMetricSpace.toUniformSpace.toTopologicalSpace ⋯ (partition p) (p * Real.exp t) t
error: `ring_nf` made no progress on the goal
error: `field_simp` made no progress on the goal
```

The successful 83985 output included an unused `gap` simp-argument warning
and a ring-normalization suggestion. Neither was suppressed by a linter option.
The final proof uses convert! at the three derivative alignments; ineffective
local transparency options were removed. Every byte edit and removal is
recorded in source-map.json, with unchanged theorem statements and root sources.

Further successful module exports, actual axiom profiles and independent
reviews are required before any complete-companion verification claim.

## Frozen proof hashes and current results

- BernoulliMGF: `bba0f91c80fb8c3162965a9c6132fb9ae397763446534c795dea8196c3ba818c`.
- BernoulliMGFChecks: `f370c56951ed923db58da67d1cdbc93e3a4cadf8b994c62abbc588e604be450f`.
- ExceptionRepair: `e5306b32322afb5ec012d8a44ee81ea70b4b4f7bb2b12e5837290a867b3c5405`.

ExceptionRepair attempt 75063 returned actual exit 0 before this checkpoint; its source uses
`by_cases h : e i = true` followed by `simp [h]` for the remaining conditional
identity. Both printed headline profiles contain only propext, Classical.choice
and Quot.sound. Downstream Formula/Checks and independent port review remain pending.

### Exact saved output: 30840

SHA256 `d8e8f60c920db59929f2d665b5f8f807bd021831676cb616038036ee64d76276`.

```text
lean\PvNP\RealizableHardness\ExceptionRepair.lean:81:6: error(lean.unknownIdentifier): Unknown constant `Finset.sum_div`
lean\PvNP\RealizableHardness\ExceptionRepair.lean:79:52: error: unsolved goals
V : Type u_1
inst✝ : Fintype V
w : V → ℚ
x : V → Bool
d : ℚ
⊢ (∑ v, if x v = true then (fun v => w v / d) v else 0) = (∑ v, if x v = true then w v else 0) / d
lean\PvNP\RealizableHardness\ExceptionRepair.lean:98:39: error(lean.unknownIdentifier): Unknown constant `Finset.sum_div`
lean\PvNP\RealizableHardness\ExceptionRepair.lean:89:80: error: unsolved goals
case e_a.e_a
V : Type u_1
I : Type u_2
inst✝¹ : Fintype V
inst✝ : Fintype I
w : V → ℚ
lam : ℚ
x : V → Bool
e : I → Bool
⊢ (∑ a₂, if e a₂ = true then lam / ↑(Fintype.card I) else 0) =
    (∑ i, lam * if e i = true then 1 else 0) / ↑(Fintype.card I)
lean\PvNP\RealizableHardness\ExceptionRepair.lean:181:11: error(lean.unknownIdentifier): Unknown identifier `div_le_div_right`
lean\PvNP\RealizableHardness\ExceptionRepair.lean:192:33: error(lean.invalidField): Invalid field `mp`: The environment does not contain `Function.mp`, so it is not possible to project the field `mp` from an expression
  mul_le_mul_left ?m.631
of type
  ∀ (a : ?m.625), ?m.626 * a ≤ ?m.627 * a
lean\PvNP\RealizableHardness\ExceptionRepair.lean:192:27: error: Application type mismatch: The argument
  hlam
has type
  0 < lam
but is expected to have type
  ?m.626 ≤ ?m.627
in the application
  mul_le_mul_left hlam
'PvNP.RealizableHardness.exception_completeness' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.exception_soundness' depends on axioms: [propext, sorryAx, Classical.choice, Quot.sound]

EXIT 1
```

### Exact saved output: 18035

SHA256 `94831c5b52071752d9f2db1f5eb85c983cebd0ef5798f712e4c3881c9ead7fdb`.

```text
lean/PvNP/RealizableHardness/ExceptionRepair.lean:102:2: error: Tactic `generalize` failed: result is not type correct
  ∀ (x_1 : Bool),
    (if x_1 = true then lam / ↑(Fintype.card I) else 0) = (lam * if x_1 = true then 1 else 0) / ↑(Fintype.card I)

case e_a.e_a
V : Type u_1
I : Type u_2
inst✝¹ : Fintype V
inst✝ : Fintype I
w : V → ℚ
lam : ℚ
x : V → Bool
e : I → Bool
i : I
a✝ : i ∈ Finset.univ
⊢ (if e i = true then lam / ↑(Fintype.card I) else 0) = (lam * if e i = true then 1 else 0) / ↑(Fintype.card I)
'PvNP.RealizableHardness.exception_completeness' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.exception_soundness' depends on axioms: [propext, Classical.choice, Quot.sound]

EXIT 1
```

### Exact saved output: 75063

SHA256 `5d324d9c5eedfa843d089f3fd899c83dcbee21e0cbb021cea8ef03e3e462dc86`.

```text
'PvNP.RealizableHardness.exception_completeness' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.exception_soundness' depends on axioms: [propext, Classical.choice, Quot.sound]

EXIT 0
```

## Second author checkpoint: seven of 33 modules

Formula and Checks completed with actual child exit0 in16632 (3 and13
standard-only profiles respectively), with no changes to their proof sources.
SamplingThreshold26835 and SamplingThresholdChecks9712 both returned actual
exit0; the Checks output contains29 profiles, all limited to propext,
Classical.choice and Quot.sound. Independent companion port reviews remain
pending. The running batch advances to ComputableSampleCount; its outcome
is not included in this seven-module checkpoint.

SamplingThreshold preserved both mathematical and learning-threshold statements.
Its repairs replace deprecated imports, use the reversed new clog iff through
.mpr, update division-order API names, and allow field_simp to close its goal.
The two nonfatal trailing-ring linter warnings remain recorded, not suppressed.

SamplingThreshold source SHA256 `f21c368aa168b6283dfc21aca606801e376c2537888367485fe9404954b86f8d`.

### Exact saved output: Formula-1789259022829567400.log

SHA256 `5b686de96fa563867b7ce38ec1ce9281bf52e0aa09a58bfd583c2d37f9b87614`.

```text
'PvNP.RealizableHardness.Formula.repair_complete' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.Formula.leaves_repair' depends on axioms: [propext]
'PvNP.RealizableHardness.Formula.repair_sound' depends on axioms: [propext, Classical.choice, Quot.sound]

EXIT 0
```

### Exact saved output: Checks-1789259022829567400.log

SHA256 `c63842368fbf659fe06c55a61e6e99aae0a2b9fb310bdd4895d172d1b48d3bc4`.

```text
'PvNP.RealizableHardness.exception_completeness' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.exception_soundness' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.repairedWeight_eq_sum' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.repairedWeights_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.repairedWeights_sum' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.repairedBudget_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.repairedBudget_le_one' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.Formula.eval_repair' depends on axioms: [propext]
'PvNP.RealizableHardness.Formula.leaves_repair' depends on axioms: [propext]
'PvNP.RealizableHardness.Formula.repair_complete' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.Formula.repair_sound' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.no_instance_example' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.yes_instance_example' depends on axioms: [propext, Classical.choice, Quot.sound]

EXIT 0
```

### Exact saved output: SamplingThreshold-1789259022829567400.log

SHA256 `484c9769258d5e865b0d8d102ae1bace45c4039f33eac524125b07e83a074265`.

```text
lean\PvNP\RealizableHardness\SamplingThreshold.lean:3:0: warning: 
'Mathlib.Data.Real.Archimedean' has been deprecated: please replace this import by

import Mathlib.Algebra.Order.AbsoluteValue.Basic
import Mathlib.Data.Rat.Floor
lean\PvNP\RealizableHardness\SamplingThreshold.lean:48:14: error(lean.unknownIdentifier): Unknown constant `Nat.le_pow_iff_clog_le`
lean\PvNP\RealizableHardness\SamplingThreshold.lean:46:78: error: unsolved goals
N : ℕ
eps : ℝ
j : ℕ
hj : threshold N eps ≤ ↑(2 ^ j)
hc : ⌈threshold N eps⌉₊ ≤ 2 ^ j
⊢ sampleCount N eps ≤ 2 ^ j
lean\PvNP\RealizableHardness\SamplingThreshold.lean:99:9: error(lean.unknownIdentifier): Unknown identifier `div_le_div_right`
lean\PvNP\RealizableHardness\SamplingThreshold.lean:100:2: error: No goals to be solved
lean\PvNP\RealizableHardness\SamplingThreshold.lean:142:32: error: No goals to be solved
lean\PvNP\RealizableHardness\SamplingThreshold.lean:170:14: error(lean.unknownIdentifier): Unknown constant `Nat.le_pow_iff_clog_le`
lean\PvNP\RealizableHardness\SamplingThreshold.lean:168:94: error: unsolved goals
N : ℕ
eps : ℝ
j : ℕ
hj : learningThreshold N eps ≤ ↑(2 ^ j)
hc : ⌈learningThreshold N eps⌉₊ ≤ 2 ^ j
⊢ learningSampleCount N eps ≤ 2 ^ j
lean\PvNP\RealizableHardness\SamplingThreshold.lean:211:9: error(lean.unknownIdentifier): Unknown identifier `div_le_div_right`
lean\PvNP\RealizableHardness\SamplingThreshold.lean:212:2: error: No goals to be solved

EXIT 1
```

### Exact saved output: SamplingThreshold-repair-1789259442896893600.log

SHA256 `f8e50ad83ff05c015974f2dc500318331d6bb6fb8cadc65d7ba14c00e9f3b985`.

```text
lean/PvNP/RealizableHardness/SamplingThreshold.lean:143:35: warning: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`
lean/PvNP/RealizableHardness/SamplingThreshold.lean:143:35: warning: Unused tactic linter: `ring` does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`

EXIT 0
```

### Exact saved output: SamplingThresholdChecks-1789259510785678500.log

SHA256 `a74ffb42a46be7a1b3ecb7715c84fbb41def483e10b6e66e44c8e55f8dde3585`.

```text
'PvNP.RealizableHardness.SamplingThreshold.threshold_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.threshold_gt_one' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.sampleCount_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.sampleCount_lower' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.sampleCount_least' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.sampleCount_upper' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.failure_budget' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.sampleCount_failure_budget' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.threshold_numeric_upper' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.sampleCount_numeric_upper' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.sampleCount_bound_of_inverse_error' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.failure_budget_of_log_threshold' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.threshold_le_learningThreshold' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.learningSampleCount_pos' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.learningSampleCount_lower' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.learningSampleCount_least' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.learningSampleCount_upper' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.learning_failure_budget' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.learningSampleCount_failure_budget' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.learningThreshold_numeric_upper' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.learningSampleCount_numeric_upper' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.learningSampleCount_bound_of_inverse_error' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.zero_variables_positive_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.positive_variables_threshold_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.inverse_error_numeric_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.selected_count_failure_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.explicit_count_failure_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.learning_selected_count_failure_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingThreshold.learning_explicit_count_failure_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]

EXIT 0
```

## Third author checkpoint: nine of 33 modules

ComputableSampleCount main returned actual child exit0 in9712 without source
changes. Its original Checks failed in the same batch on four obsolete Nat
clog iff references; two sorryAx-containing example profiles are rejected,
even though executable evaluation already printed512/2048/1. Four uniquely
anchored replacements use the pinned new iff names and reversed .mpr direction.
Checks59199 then returned actual exit0, with17 profiles using standard axioms
only and all three evaluation results preserved. Independent port review is
pending. Remaining24modules and aggregate are outside this checkpoint.

Checks source SHA256 `10c47487135dc1538f95cec00e82d54bd4a64276dedfe08d29214f99c5636310`.

### Exact saved output: ComputableSampleCount-1789259510785678500.log

SHA256 `8e3c732ce1a8b24cb9b555ba883cf4bb55690f7de6694f4ad1fc0412508b73b2`.

```text

EXIT 0
```

### Exact saved output: ComputableSampleCountChecks-1789259510785678500.log

SHA256 `526dfd68aa23cad37d24bd9ee80d2a7fbbafe08209ae78c53ece6185c2539ddf`.

```text
lean\PvNP\RealizableHardness\ComputableSampleCountChecks.lean:6:5: error(lean.unknownIdentifier): Unknown constant `Nat.le_pow_iff_clog_le`
lean\PvNP\RealizableHardness\ComputableSampleCountChecks.lean:8:5: error(lean.unknownIdentifier): Unknown constant `Nat.pow_lt_iff_lt_clog`
lean\PvNP\RealizableHardness\ComputableSampleCountChecks.lean:17:5: error(lean.unknownIdentifier): Unknown constant `Nat.le_pow_iff_clog_le`
lean\PvNP\RealizableHardness\ComputableSampleCountChecks.lean:19:5: error(lean.unknownIdentifier): Unknown constant `Nat.pow_lt_iff_lt_clog`
512
2048
1
'PvNP.RealizableHardness.ComputableSampleCount.concrete_count_small' depends on axioms: [propext, sorryAx, Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.concrete_count_half' depends on axioms: [propext, sorryAx, Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.concrete_count_zero' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.count_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.count_power_two' depends on axioms: [propext]
'PvNP.RealizableHardness.ComputableSampleCount.target_le_count' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.target_gt_one' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.count_upper' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.learningThreshold_le_target' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.learningThreshold_le_count' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.threshold_le_count' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.inverse_bound_pos' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.count_upper_of_inverse' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.learning_budget' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.base_budget' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.concrete_half_error' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.concrete_small_error' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]

EXIT 1
```

### Exact saved output: ComputableSampleCountChecks-repair-1789259809999135800.log

SHA256 `c6bbaa2d7676c26ad1f3bfb6af50ea6adcdebae7f4ede12c9b879d6643915131`.

```text
512
2048
1
'PvNP.RealizableHardness.ComputableSampleCount.concrete_count_small' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.concrete_count_half' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.concrete_count_zero' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.count_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.count_power_two' depends on axioms: [propext]
'PvNP.RealizableHardness.ComputableSampleCount.target_le_count' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.target_gt_one' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.count_upper' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.learningThreshold_le_target' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.learningThreshold_le_count' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.threshold_le_count' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.inverse_bound_pos' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.count_upper_of_inverse' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.learning_budget' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.base_budget' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.concrete_half_error' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.ComputableSampleCount.concrete_small_error' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]

EXIT 0
```

## Fourth author checkpoint: eleven of 33 modules

WeightRounding main89265 returned exit0 after two API renames and removal
of two trailing ring calls after field_simp had closed the goals. Deprecated
if_false and unused-simp warnings remain unsuppressed. Checks98568 failed
on two concrete examples;86337 fixed the dyadic example but the simultaneous
hypothesis/goal simplification still failed. Checks84250 uses explicit Bool
branches and returned actual exit0 with25 standard-only profiles, including
all nonvacuous examples. No theorem statement or numerical target changed.
Independent companion port reviews remain pending.

WeightRounding SHA256 `f99379cadbffe016a48b20b52d91777c09c42b900ea3f526862bee36e6cbf357`.

WeightRoundingChecks SHA256 `9e63050f4813401ff857c98188401d98bd18aec3f2c1e6a4b223a45b56f70260`.

### Exact saved output: WeightRounding-1789259862412666900.log

SHA256 `b563e0c75f82bbd92691a2f493f5fdcefd46de9c3af5b76fcdaaeea1bd46e49d`.

```text
lean\PvNP\RealizableHardness\WeightRounding.lean:47:56: warning: `if_false` has been deprecated: Use `ite_false` instead
lean\PvNP\RealizableHardness\WeightRounding.lean:47:56: warning: `if_false` has been deprecated: Use `ite_false` instead
lean\PvNP\RealizableHardness\WeightRounding.lean:47:32: warning: This simp argument is unused:
  hx

Hint: Omit it from the simp argument list.
  [apply] simp only [Bool.false_eq_true, if_false, mul_zero, ite_true]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\WeightRounding.lean:61:14: warning: This simp argument is unused:
  hx

Hint: Omit it from the simp argument list.
  [apply] simp

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\WeightRounding.lean:168:11: error(lean.unknownIdentifier): Unknown identifier `div_le_div_right`
lean\PvNP\RealizableHardness\WeightRounding.lean:212:14: error(lean.unknownIdentifier): Unknown constant `Nat.le_pow_iff_clog_le`
lean\PvNP\RealizableHardness\WeightRounding.lean:210:31: error: unsolved goals
N : ℕ
t : ℚ
j : ℕ
hj : 8 * (↑N + 1) / t ≤ ↑(2 ^ j)
hj' : ⌈8 * (↑N + 1) / t⌉₊ ≤ 2 ^ j
⊢ dyadicScale N t ≤ 2 ^ j
lean\PvNP\RealizableHardness\WeightRounding.lean:267:4: error: No goals to be solved
lean\PvNP\RealizableHardness\WeightRounding.lean:271:4: error: No goals to be solved

EXIT 1
```

### Exact saved output: WeightRounding-repair-1789260014870033100.log

SHA256 `e984105fc4f34b06f392807e544f130205d4078b1cf696cc0cb565b4c2e2b08f`.

```text
lean/PvNP/RealizableHardness/WeightRounding.lean:47:56: warning: `if_false` has been deprecated: Use `ite_false` instead
lean/PvNP/RealizableHardness/WeightRounding.lean:47:56: warning: `if_false` has been deprecated: Use `ite_false` instead
lean/PvNP/RealizableHardness/WeightRounding.lean:47:32: warning: This simp argument is unused:
  hx

Hint: Omit it from the simp argument list.
  [apply] simp only [Bool.false_eq_true, if_false, mul_zero, ite_true]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean/PvNP/RealizableHardness/WeightRounding.lean:61:14: warning: This simp argument is unused:
  hx

Hint: Omit it from the simp argument list.
  [apply] simp

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`

EXIT 0
```

### Exact saved output: WeightRoundingChecks-1789260059351340800.log

SHA256 `a47d161f9027a2eae165420124476d3a7a4c14ddbec911ec16f9370b08270af0`.

```text
lean\PvNP\RealizableHardness\WeightRoundingChecks.lean:22:63: error: unsolved goals
⊢ 2 ^ ((Nat.clog.go 256 2 256).2 + 1) = 256
lean\PvNP\RealizableHardness\WeightRoundingChecks.lean:43:48: error: unsolved goals
case true
x : Unit → Bool
hx : weight (roundedWeights (fun x => 1) 256) x ≤ ↑(5 / 2) * roundedBudget (fun x => 1) 256 (1 / 16)
h : True
⊢ False
'PvNP.RealizableHardness.WeightRounding.coordinate_lower' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.coordinate_upper' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.denominator_bounds' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.roundedWeights_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.roundedWeights_sum' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.roundedBudget_valid' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.rounding_complete' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.rounding_budget_transfer' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.rounding_sound' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.dyadicScale_lower' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.dyadicScale_least' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.dyadicScale_upper' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.common_denominator' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.integral_lengths' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.dyadic_denominator_bound' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.denominator_bound_of_inverse_budget' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.polynomial_denominator_bound' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.rounded_lower_bounds' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.formula_rounding' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.fractional_coordinate_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.fractional_denominator_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.dyadic_scale_example' depends on axioms: [propext,
 sorryAx,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.clipped_budget_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.rounded_yes_example' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.rounded_no_example' depends on axioms: [propext,
 sorryAx,
 Classical.choice,
 Quot.sound]

EXIT 1
```

### Exact saved output: WeightRoundingChecks-repair-1789260170368317600.log

SHA256 `d886ea0ad253bba1b38b9d1be7df6977f5c1aa8528ffe0411e588595fd22eb3f`.

```text
lean/PvNP/RealizableHardness/WeightRoundingChecks.lean:49:12: error: No goals to be solved
'PvNP.RealizableHardness.WeightRounding.coordinate_lower' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.coordinate_upper' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.denominator_bounds' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.roundedWeights_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.roundedWeights_sum' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.roundedBudget_valid' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.rounding_complete' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.rounding_budget_transfer' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.rounding_sound' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.dyadicScale_lower' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.dyadicScale_least' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.dyadicScale_upper' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.common_denominator' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.integral_lengths' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.dyadic_denominator_bound' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.denominator_bound_of_inverse_budget' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.polynomial_denominator_bound' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.rounded_lower_bounds' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.formula_rounding' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.fractional_coordinate_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.fractional_denominator_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.dyadic_scale_example' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.clipped_budget_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.rounded_yes_example' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.rounded_no_example' depends on axioms: [propext,
 sorryAx,
 Classical.choice,
 Quot.sound]

EXIT 1
```

### Exact saved output: WeightRoundingChecks-repair2-1789260258212870600.log

SHA256 `1fcaa2a63dab11dcf24969d8c5ff7c6a3b1b0f11771725471e40199779a587de`.

```text
'PvNP.RealizableHardness.WeightRounding.coordinate_lower' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.coordinate_upper' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.denominator_bounds' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.roundedWeights_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.roundedWeights_sum' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.roundedBudget_valid' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.rounding_complete' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.rounding_budget_transfer' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.rounding_sound' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.dyadicScale_lower' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.dyadicScale_least' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.dyadicScale_upper' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.common_denominator' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.integral_lengths' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.dyadic_denominator_bound' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.denominator_bound_of_inverse_budget' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.polynomial_denominator_bound' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.rounded_lower_bounds' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.formula_rounding' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.fractional_coordinate_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.fractional_denominator_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.dyadic_scale_example' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.clipped_budget_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.WeightRounding.rounded_yes_example' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.WeightRounding.rounded_no_example' depends on axioms: [propext, Classical.choice, Quot.sound]

EXIT 0
```

## Fifth author checkpoint: fifteen of 33 modules

FiniteSampling main and Checks21452 passed unchanged (19 standard-only
profiles). FiniteConcentration21452 failed on a renamed power-order lemma
and three redundant dsimp calls. Four exact recorded transformations preserve
all mathematical statements; main53347 and Checks25908 then returned exit0
with24 standard-only profiles. Deprecated-if and unused-simp warnings remain
unsuppressed. Independent companion port reviews remain pending.

The downstream pipeline failed after this milestone and is not included
in the fifteen-module author checkpoint.

FiniteSampling SHA256 `7b1cf53b512e705d08d4eb20a1db69b4015d5fb561f5495e11316c0cfc49ab57`.

FiniteSamplingChecks SHA256 `9281576cae367164b01ec09649245ab7e3d91b17e51c531e5be591661a56461b`.

FiniteConcentration SHA256 `368902b5aae4ff087a078922fa79fd87762c78ebf881c8ed86ed9ee716c011e2`.

FiniteConcentrationChecks SHA256 `8f260a72a5a6770e589c5380bff89368ff4c837aaa5e4f39f6d87250cc0abb8d`.

### Exact saved output: FiniteSampling-1789260293638767600.log

SHA256 `49be69e1cca80ec53825447cf80e4ccfd42383d50931ac69c6a0fecc6c45c152`.

```text
lean\PvNP\RealizableHardness\FiniteSampling.lean:94:14: warning: This simp argument is unused:
  hi

Hint: Omit it from the simp argument list.
  [apply] simp

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\FiniteSampling.lean:136:8: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead

EXIT 0
```

### Exact saved output: FiniteSamplingChecks-1789260293638767600.log

SHA256 `2638e1473c61ca634a850d1c8187d43d3a8aab8861aeeca17884e6b073dde66f`.

```text
'PvNP.RealizableHardness.FiniteSampling.cumulative_error' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteSampling.mass_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteSampling.mass_error' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteSampling.mass_sum' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteSampling.event_error' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteSampling.event_error_of_precision' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteSampling.trialMass_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteSampling.trialMass_sum' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteSampling.trial_event_factorization' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteSampling.assignment_count' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteSampling.listSampler_exact' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteSampling.thirds_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteSampling.thirds_normalized' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteSampling.fractional_cut_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteSampling.fractional_mass_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteSampling.rounded_distribution_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteSampling.uniform_event_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteSampling.independent_two_trial_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteSampling.one_bit_sampler_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]

EXIT 0
```

### Exact saved output: FiniteConcentration-1789260293638767600.log

SHA256 `5e92de7c4faae0ea7c5ddaeb373b5f7486c17bca4828533cc0f185d345ac6326`.

```text
lean\PvNP\RealizableHardness\FiniteConcentration.lean:82:38: error(lean.unknownIdentifier): Unknown identifier `pow_le_pow_left`
lean\PvNP\RealizableHardness\FiniteConcentration.lean:123:20: error: `dsimp` made no progress
lean\PvNP\RealizableHardness\FiniteConcentration.lean:136:20: error: `dsimp` made no progress
lean\PvNP\RealizableHardness\FiniteConcentration.lean:180:8: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
lean\PvNP\RealizableHardness\FiniteConcentration.lean:184:8: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
lean\PvNP\RealizableHardness\FiniteConcentration.lean:206:2: error: `dsimp` made no progress
lean\PvNP\RealizableHardness\FiniteConcentration.lean:221:22: warning: This simp argument is unused:
  Fintype.card_fun

Hint: Omit it from the simp argument list.
  [apply] simp

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`

EXIT 1
```

### Exact saved output: FiniteConcentration-repair-1789260470835994000.log

SHA256 `f310eaee9530a8ac47f5674ee0c54320e24a16e681459b61aff2fa84ed4b479b`.

```text
lean/PvNP/RealizableHardness/FiniteConcentration.lean:180:8: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
lean/PvNP/RealizableHardness/FiniteConcentration.lean:184:8: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
lean/PvNP/RealizableHardness/FiniteConcentration.lean:220:22: warning: This simp argument is unused:
  Fintype.card_fun

Hint: Omit it from the simp argument list.
  [apply] simp

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`

EXIT 0
```

### Exact saved output: FiniteConcentrationChecks-1789260487401853700.log

SHA256 `6f80c7f1d95522d7d7f8c91df222d3594db5e45ee9b88512df9faea2f483905e`.

```text
'PvNP.RealizableHardness.FiniteConcentration.mean_bounds' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.one_trial_mgf' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.exp_finite_sum' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.product_mgf_identity' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.product_mgf_bound' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.probability_mono' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.exponential_markov' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.upper_tail' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.lower_tail' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.probability_union' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.two_sided_tail' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.probability_exists' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.centered_empirical' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.empirical_tail' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.assignment_empirical_tail' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.assignment_approximation_tail' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.assignment_epsilon_tail' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.probability_complement' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.fair_mean' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.fair_all_true' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.fair_all_false' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.fair_draw_mass' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.fair_eight_tail' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.FiniteConcentration.zero_variable_assignment_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]

EXIT 0
```

## Twenty-one-module author checkpoint

Pipeline main initially failed on a no-goals continuation; removing only the already-discharged ring_nf/simp continuation preserved its statement. Retry21621 exited0. Batch92585 exported pipeline Checks, inverse CDF main/Checks and joint main/Checks successfully. Their Checks printed18,18,11 standard-only profiles respectively. All21 exports remain pending independent companion port review. PosteriorReweighting subsequently failed; it is not accepted or included in this count. Full hardness theorem remains absent.

FiniteRepairRoundingPipeline source SHA256 `6e04ac94f0e932d58bf636df9fa48ff16e1ac9bdb898edc526f77cfba5f14af3`.

FiniteRepairRoundingPipelineChecks source SHA256 `0e2e5e87f8cd79585c7acc6699e809087cb8c4ed1951b15cf91038c37e62f594`.

InverseCDFSampler source SHA256 `8350e861d27d1f8c58148bf7656a1f2f467b38403819540eefd065cc6193dad6`.

InverseCDFSamplerChecks source SHA256 `c80b702ae6b568809da803747bd3cff4aae8c22095c5582ab54d75090116a0cd`.

JointSamplingLaw source SHA256 `3ddff3f8062162526f56d8ee53b25b37936e9c75538723bc04f25e83d8023d45`.

JointSamplingLawChecks source SHA256 `c956a5f38911f71f9d285e06bd261fda072207b4261e10e1270334989d486644`.

### FiniteRepairRoundingPipeline-1789260487401853700.log

SHA256 `eded8e8f8c88de487e2068bf080252e90b57a23b1f82dc2d8cab55718b4b573f`.

```text
lean\PvNP\RealizableHardness\FiniteRepairRoundingPipeline.lean:132:45: error: No goals to be solved

EXIT 1
```

### FiniteRepairRoundingPipeline-repair-1789260635468296400.log

SHA256 `8e3c732ce1a8b24cb9b555ba883cf4bb55690f7de6694f4ad1fc0412508b73b2`.

```text

EXIT 0
```

### FiniteRepairRoundingPipelineChecks-1789260645227084300.log

SHA256 `7a151189d038fbf67e466b90b60416f1b101e63f710dbaa09290a489e957336f`.

```text
'PvNP.RealizableHardness.FiniteRepairRoundingPipeline.lam_pos' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteRepairRoundingPipeline.eps_le_one' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteRepairRoundingPipeline.budget_pos' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteRepairRoundingPipeline.budget_le_one' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteRepairRoundingPipeline.weights_pos' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteRepairRoundingPipeline.weights_sum' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteRepairRoundingPipeline.output_valid' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteRepairRoundingPipeline.yes_preserved' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteRepairRoundingPipeline.no_preserved' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteRepairRoundingPipeline.output_leaves' depends on axioms: [propext]
'PvNP.RealizableHardness.FiniteRepairRoundingPipeline.reciprocal_budget' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteRepairRoundingPipeline.denominator_bound' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteRepairRoundingPipeline.output_common_denominator' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteRepairRoundingPipeline.genuine_yes_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteRepairRoundingPipeline.genuine_no_input' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteRepairRoundingPipeline.genuine_no_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteRepairRoundingPipeline.concrete_denominator_bound' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.FiniteRepairRoundingPipeline.concrete_repaired_leaf_count' depends on axioms: [propext]

EXIT 0
```

### InverseCDFSampler-1789260645227084300.log

SHA256 `ebbd812c3b9938d04a58d83e81afb781e5862ed8b3a9ada655fdf371a0e399bd`.

```text
lean\PvNP\RealizableHardness\InverseCDFSampler.lean:119:10: warning: This simp argument is unused:
  he

Hint: Omit it from the simp argument list.
  [apply] simp

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\InverseCDFSampler.lean:120:15: warning: This simp argument is unused:
  he

Hint: Omit it from the simp argument list.
  [apply] simp only [Bool.true_eq, ↓reduceIte, mul_one]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\InverseCDFSampler.lean:120:19: warning: This simp argument is unused:
  Bool.true_eq

Hint: Omit it from the simp argument list.
  [apply] simp only [he, ↓reduceIte, mul_one]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`

EXIT 0
```

### InverseCDFSamplerChecks-1789260645227084300.log

SHA256 `4579583d90e17f8538e683c5d38ad495bd6047eb9e8b00406fcb0c8e1dc1b1eb`.

```text
'PvNP.RealizableHardness.InverseCDFSampler.support_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.InverseCDFSampler.cut_endpoint' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.InverseCDFSampler.sampler_interval' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.InverseCDFSampler.sampler_eq_iff' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.InverseCDFSampler.fibre_card' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.InverseCDFSampler.fibre_probability' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.InverseCDFSampler.sampler_event_law' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.InverseCDFSampler.bitSampler_event_law' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.InverseCDFSampler.bitSampler_event_error' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.InverseCDFSampler.gapThirds_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.InverseCDFSampler.gapThirds_normalized' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.InverseCDFSampler.gapThirds_cuts' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.InverseCDFSampler.first_seed_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.InverseCDFSampler.boundary_seed_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.InverseCDFSampler.final_seed_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.InverseCDFSampler.zero_atom_example' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.InverseCDFSampler.fractional_fibre_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.InverseCDFSampler.binary_precision_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]

EXIT 0
```

### JointSamplingLaw-1789260645227084300.log

SHA256 `1e9a0ca7f7d166757ee8d34b39fa25d390d088db1f85cb39a7c148e1da7dd2f5`.

```text
lean\PvNP\RealizableHardness\JointSamplingLaw.lean:73:10: warning: This simp argument is unused:
  he

Hint: Omit it from the simp argument list.
  [apply] simp

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\JointSamplingLaw.lean:74:15: warning: This simp argument is unused:
  he

Hint: Omit it from the simp argument list.
  [apply] simp only [Bool.true_eq, ↓reduceIte, mul_one]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\JointSamplingLaw.lean:74:19: warning: This simp argument is unused:
  Bool.true_eq

Hint: Omit it from the simp argument list.
  [apply] simp only [he, ↓reduceIte, mul_one]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`

EXIT 0
```

### JointSamplingLawChecks-1789260645227084300.log

SHA256 `ecfd29ea027fe8c051ea635daefe5d058faa7a4c352f9334b848762e9c68587d`.

```text
'PvNP.RealizableHardness.JointSamplingLaw.array_fibre_card' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.JointSamplingLaw.bit_fibre_probability' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.JointSamplingLaw.array_fibre_probability' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.JointSamplingLaw.sampleArray_event_law' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.JointSamplingLaw.sampleArray_probability' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.JointSamplingLaw.half_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.JointSamplingLaw.half_normalized' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.JointSamplingLaw.half_mass' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.JointSamplingLaw.two_trial_diagonal' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.JointSamplingLaw.zero_atom_joint' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.JointSamplingLaw.concrete_real_event_bridge' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]

EXIT 0
```

## Twenty-three-module author checkpoint

PosteriorReweighting failed in92585 on unavailable sum_div, a discharged ring continuation and additive orientation. Three literal transforms add the pinned Field import, remove the redundant ring and use add_le_add le_rfl hbad. Statements are unchanged. Batch19744 main/Checks both exited0; Checks printed13 standard-only profiles. Linter warnings remain unsuppressed. Independent companion reviews remain pending; no full hardness theorem is certified. SamplingGuarantee is the next live module and is not included in this checkpoint count.

PosteriorReweighting source SHA256 `87f613673b0b0f1bd56308d14a1cba006f3fb00dfbafa5d524dcd199b057298a`.

PosteriorReweightingChecks source SHA256 `48ca57c80a389efa3d8460010acb8875b25e06d598749cbb623ee8b443b321aa`.

### PosteriorReweighting-1789260645227084300.log

SHA256 `37bd5820486905e66c8ab0d208102a2a2ef024094372b64fdc8faaa4277d1c6f`.

```text
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:24:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.PosteriorReweighting.marginal_nonneg`:
  [Fintype Q]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype Q] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:37:26: error(lean.unknownIdentifier): Unknown constant `Finset.sum_div`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:38:2: error: Type mismatch
  div_self (ne_of_gt hq)
has type
  marginal p k q / marginal p k q = 1
but is expected to have type
  ∑ v, p v * k v q / marginal p k q = 1
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:40:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.PosteriorReweighting.bayes_mass`:
  [Fintype Q]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype Q] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:45:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.PosteriorReweighting.zero_prior`:
  [Fintype Q]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype Q] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:54:4: error: No goals to be solved
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:56:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.PosteriorReweighting.joint_zero_of_marginal_zero`:
  [Fintype Q]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype Q] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:88:29: warning: This simp argument is unused:
  hb

Hint: Omit it from the simp argument list.
  [apply] simp [hg, hr]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:90:17: warning: This simp argument is unused:
  hb

Hint: Omit it from the simp argument list.
  [apply] simp only [hg, Bool.not_false, Bool.true_eq, ite_true]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:90:41: warning: This simp argument is unused:
  Bool.true_eq

Hint: Omit it from the simp argument list.
  [apply] simp only [hb, hg, Bool.not_false, ite_true]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:121:27: error: Type mismatch
  add_le_add_left hbad ?m.384
has type
  (mass r fun v => !g v) + ?m.384 ≤ zeta + ?m.384
but is expected to have type
  (p0 * eta + mass r fun v => !g v) ≤ p0 * eta + zeta
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:109:17: warning: This simp argument is unused:
  hg

Hint: Omit it from the simp argument list.
  [apply] simp only [Bool.not_false, Bool.true_eq, ite_true]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:109:37: warning: This simp argument is unused:
  Bool.true_eq

Hint: Omit it from the simp argument list.
  [apply] simp only [hg, Bool.not_false, ite_true]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:116:17: warning: This simp argument is unused:
  hg

Hint: Omit it from the simp argument list.
  [apply] simp only [Bool.not_true, Bool.false_eq_true, ite_false, add_zero]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:167:10: error(lean.unknownIdentifier): Unknown constant `Finset.sum_div`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:218:8: error(lean.unknownIdentifier): Unknown constant `Finset.sum_div`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:217:43: error: unsolved goals
V : Type u_1
inst✝ : Fintype V
r w : V → ℚ
hZ : 0 < normalizer r w
⊢ ∑ v, r v * w v / normalizer r w = 1

EXIT 1
```

### PosteriorReweighting-1789260989162401300.log

SHA256 `c31f5bfe22552d26b0b458f218bae50e557676c4ff9374645a2eace035f8dcbe`.

```text
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:25:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.PosteriorReweighting.marginal_nonneg`:
  [Fintype Q]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype Q] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:36:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.PosteriorReweighting.posterior_normalized`:
  [Fintype Q]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype Q] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:41:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.PosteriorReweighting.bayes_mass`:
  [Fintype Q]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype Q] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:46:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.PosteriorReweighting.zero_prior`:
  [Fintype Q]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype Q] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:49:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.PosteriorReweighting.bayes_ratio`:
  [Fintype Q]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype Q] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:56:0: warning: automatically included section variable(s) unused in theorem `PvNP.RealizableHardness.PosteriorReweighting.joint_zero_of_marginal_zero`:
  [Fintype Q]
consider restructuring your `variable` declarations so that the variables are not in scope or explicitly omit them:
  omit [Fintype Q] in theorem ...

Note: This linter can be disabled with `set_option linter.unusedSectionVars false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:88:29: warning: This simp argument is unused:
  hb

Hint: Omit it from the simp argument list.
  [apply] simp [hg, hr]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:90:17: warning: This simp argument is unused:
  hb

Hint: Omit it from the simp argument list.
  [apply] simp only [hg, Bool.not_false, Bool.true_eq, ite_true]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:90:41: warning: This simp argument is unused:
  Bool.true_eq

Hint: Omit it from the simp argument list.
  [apply] simp only [hb, hg, Bool.not_false, ite_true]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:100:20: warning: Variable name `hz` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _hz

Note: This linter can be disabled with `set_option linter.unusedVariables false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:109:17: warning: This simp argument is unused:
  hg

Hint: Omit it from the simp argument list.
  [apply] simp only [Bool.not_false, Bool.true_eq, ite_true]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:109:37: warning: This simp argument is unused:
  Bool.true_eq

Hint: Omit it from the simp argument list.
  [apply] simp only [hg, Bool.not_false, ite_true]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\PosteriorReweighting.lean:116:17: warning: This simp argument is unused:
  hg

Hint: Omit it from the simp argument list.
  [apply] simp only [Bool.not_true, Bool.false_eq_true, ite_false, add_zero]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`

EXIT 0
```

### PosteriorReweightingChecks-1789260989162401300.log

SHA256 `b6d911e88d334c430c16c92a595dc7922f2f8d89a2e3fd2ae1bc6f997181333f`.

```text
lean\PvNP\RealizableHardness\PosteriorReweightingChecks.lean:34:2: warning: Unused tactic linter: `all_goals intro b; cases b <;> norm_num` does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
lean\PvNP\RealizableHardness\PosteriorReweightingChecks.lean:34:12: warning: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`
lean\PvNP\RealizableHardness\PosteriorReweightingChecks.lean:34:21: warning: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`
'PvNP.RealizableHardness.PosteriorReweighting.marginal_nonneg' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.PosteriorReweighting.marginal_normalized' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.PosteriorReweighting.posterior_normalized' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.PosteriorReweighting.bayes_mass' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.PosteriorReweighting.zero_prior' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.PosteriorReweighting.bayes_ratio' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.PosteriorReweighting.joint_zero_of_marginal_zero' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.PosteriorReweighting.total_probability' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.PosteriorReweighting.posterior_event_cutoff' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.PosteriorReweighting.reweight_error' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.PosteriorReweighting.normalizer_deviation' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.PosteriorReweighting.normalized_reweighting' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.PosteriorReweighting.reweighted_normalized' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]

EXIT 0
```

## Twenty-five-module author checkpoint

SamplingGuarantee19744 failed on higher-order roundedLaw alignment. Attempt80803 explicitly dsimp at h failed with no progress. Retry7356 removes that ineffective tactic and explicitly changes the goal to the definitionally equal roundedLaw probability before proposition simplification. Main/Checks exited0; Checks printed18 standard-only profiles. All statements are unchanged. SamplingFormulaPromises is next and excluded from this count. Independent reviews and full hardness assembly remain pending.

SamplingGuarantee source SHA256 `ed1303659b170bb560eb415623e8298344820aa4313b56b2578d0ea82aa76fe0`.

SamplingGuaranteeChecks source SHA256 `08effac99e531296d8361e56e4cadbf19b183d3a41a6a5fb77b7e9503f053b97`.

### SamplingGuarantee-1789260989162401300.log

SHA256 `af66f8bfa617fda5829c73c2f9745e714de71860723e5ec58e0d051f0d9a4055`.

```text
lean\PvNP\RealizableHardness\SamplingGuarantee.lean:57:2: error: Type mismatch: After simplification, term
  h
 has type
  @LE.le ℝ Real.instLE
    (probability (roundedLaw p S b) M fun x =>
      ∃ b, ↑eps / 4 ≤ |empirical (fun i => F b ↑i) M x - originalMean p S (F b)|)
    (2 ^ N * (2 * Real.exp (-2 * ↑M * (↑eps / 8) ^ 2)))
but is expected to have type
  @LE.le ℝ Real.instLE
    (probability (fun i => mass p (2 ^ b) ↑i) M fun draws =>
      ∃ x, ↑eps / 4 ≤ |empirical (fun i => F x ↑i) M draws - originalMean p S (F x)|)
    (2 ^ N * (2 * Real.exp (-2 * ↑M * (↑eps / 8) ^ 2)))

EXIT 1
```

### SamplingGuarantee-1789261118052183300.log

SHA256 `eb30d7583ffb62fc11fafee075212b8a72a36b21f4bbd17f2f9d0b18b5729896`.

```text
lean\PvNP\RealizableHardness\SamplingGuarantee.lean:57:2: error: `dsimp` made no progress

EXIT 1
```

### SamplingGuarantee-1789261162878172000.log

SHA256 `8e3c732ce1a8b24cb9b555ba883cf4bb55690f7de6694f4ad1fc0412508b73b2`.

```text

EXIT 0
```

### SamplingGuaranteeChecks-1789261162878172000.log

SHA256 `4ee5a3590a203a39799fe7cb99df297630becd906a958e45a5370b1a9c13de80`.

```text
'PvNP.RealizableHardness.SamplingGuarantee.finiteMean_eq_eventMass' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingGuarantee.roundedLaw_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SamplingGuarantee.roundedLaw_sum' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SamplingGuarantee.roundedMean_error' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SamplingGuarantee.seed_failure_bound' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingGuarantee.seed_success_bound' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingGuarantee.good_probability_of_threshold' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingGuarantee.good_probability_of_learningThreshold' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingGuarantee.precision_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SamplingGuarantee.chosen_good_probability' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingGuarantee.chosen_learning_good_probability' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingGuarantee.atoms_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SamplingGuarantee.atoms_normalized' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SamplingGuarantee.original_mean_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingGuarantee.chosen_base_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingGuarantee.chosen_learning_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingGuarantee.explicit_count_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingGuarantee.zero_variable_example' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]

EXIT 0
```

## Twenty-nine-module author checkpoint

SamplingFormulaPromises main/Checks and SeedEncoding main passed unchanged in7356. FormulaPromises Checks printed15 standard-subset profiles. SeedChecks7356 failed only because norm_num already closed row_major_example before its rfl; those printed profiles did not accept the failed module. Removing only the redundant rfl gave actual EXIT0 in58810,25 standard-subset profiles, and the two expected Boolean-list evaluations. All statements remain unchanged. TripleRestrictionRank is next and excluded from this count. Independent reviews/full hardness assembly remain pending.

SamplingFormulaPromises source SHA256 `5b3be5d6cc5b66c9907855153b7e11c11c43e28fca5feff952ea649de278e941`.

SamplingFormulaPromisesChecks source SHA256 `ef50b659f0275a622c0a918c543b0ae6e58fbf47d4da9f6b9edacc225512af06`.

SeedEncoding source SHA256 `286890661a574841a84754b12033f7caadf167c3bde52c5c0f55ca9d2f21482d`.

SeedEncodingChecks source SHA256 `f2692f38794aad6d955cc1b8bac946e3bf7e53d909a4a8a5c6370a018599acd4`.

### SamplingFormulaPromises-1789261162878172000.log

SHA256 `a213a6e8cec02676ea488868022a46c03efc440fa7b9038f8fa89cfc9d4df813`.

```text
lean\PvNP\RealizableHardness\SamplingFormulaPromises.lean:26:12: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
lean\PvNP\RealizableHardness\SamplingFormulaPromises.lean:77:2: warning: Try this: 
  letI̵

The goal is a proposition, so `let` is preferred over `letI`.
The difference between `let` and `letI` is that `letI` inlines the value.
But this is not relevant for proofs because of proof irrelevance.

Note: This linter can be disabled with `set_option linter.style.haveILetI false`
lean\PvNP\RealizableHardness\SamplingFormulaPromises.lean:92:2: warning: Try this: 
  letI̵

The goal is a proposition, so `let` is preferred over `letI`.
The difference between `let` and `letI` is that `letI` inlines the value.
But this is not relevant for proofs because of proof irrelevance.

Note: This linter can be disabled with `set_option linter.style.haveILetI false`
lean\PvNP\RealizableHardness\SamplingFormulaPromises.lean:125:19: warning: `if_false` has been deprecated: Use `ite_false` instead

EXIT 0
```

### SamplingFormulaPromisesChecks-1789261162878172000.log

SHA256 `9e7d46fdd9710ea793862aec6a1736fdd338d214ef704f63c594d88bc8c3c4b7`.

```text
'PvNP.RealizableHardness.SamplingFormulaPromises.empirical_eq_average' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingFormulaPromises.good_yes_average' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingFormulaPromises.good_no_average' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingFormulaPromises.parameter_margin' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingFormulaPromises.good_yes_output' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingFormulaPromises.good_no_output' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingFormulaPromises.fromSeeds_eval' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingFormulaPromises.output_leaves' depends on axioms: [propext]
'PvNP.RealizableHardness.SamplingFormulaPromises.seedProbability_mono' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingFormulaPromises.computed_event_probability' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingFormulaPromises.computed_yes_probability' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingFormulaPromises.computed_no_probability' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingFormulaPromisesChecks.duplicate_positions' depends on axioms: [propext]
'PvNP.RealizableHardness.SamplingFormulaPromisesChecks.duplicate_empirical' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SamplingFormulaPromisesChecks.empty_trials' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]

EXIT 0
```

### SeedEncoding-1789261162878172000.log

SHA256 `8e3c732ce1a8b24cb9b555ba883cf4bb55690f7de6694f4ad1fc0412508b73b2`.

```text

EXIT 0
```

### SeedEncodingChecks-1789261162878172000.log

SHA256 `e42ed336d9ed7a3eeec4f046d6bfaa826f15ced7486ce30f6ac36b901db00284`.

```text
lean\PvNP\RealizableHardness\SeedEncodingChecks.lean:29:2: error: No goals to be solved
[false, true, false, true, false, true]
[false, false, true]
'PvNP.RealizableHardness.SeedEncoding.unflatten_flatten' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.flatten_unflatten' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.split_join' depends on axioms: [propext, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.join_split' depends on axioms: [propext, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.event_card_equiv' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.uniformProbability_equiv' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.uniformProbability_eq_sum' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.seedProbability_eq_uniform' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.flat_event_card' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.flat_probability' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.sampleFlat_probability' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.prefix_fibre_card' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.prefix_event_card' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.prefix_probability' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.padded_sampleFlat_probability' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.zero_trials_inverse' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.zero_width_inverse' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.zero_trials_flat_inverse' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.zero_width_flat_inverse' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.empty_seed_card' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.row_major_example' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.padding_example' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.no_padding_example' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.empty_prefix_example' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.diagonal_padded_law' depends on axioms: [propext, Classical.choice, Quot.sound]

EXIT 1
```

### SeedEncodingChecks-1789261319580476200.log

SHA256 `2a1ece0166a9d29c98ec7f8fa1b5f58200e48f3a5fed31f913ff134d0637235b`.

```text
[false, true, false, true, false, true]
[false, false, true]
'PvNP.RealizableHardness.SeedEncoding.unflatten_flatten' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.flatten_unflatten' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.split_join' depends on axioms: [propext, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.join_split' depends on axioms: [propext, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.event_card_equiv' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.uniformProbability_equiv' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.uniformProbability_eq_sum' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.seedProbability_eq_uniform' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.flat_event_card' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.flat_probability' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.sampleFlat_probability' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.prefix_fibre_card' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.prefix_event_card' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.prefix_probability' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.padded_sampleFlat_probability' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.zero_trials_inverse' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.zero_width_inverse' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.zero_trials_flat_inverse' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.zero_width_flat_inverse' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.empty_seed_card' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.row_major_example' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.padding_example' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.no_padding_example' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.empty_prefix_example' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SeedEncoding.diagonal_padded_law' depends on axioms: [propext, Classical.choice, Quot.sound]

EXIT 0
```

## Thirty-one-module author checkpoint

TripleRestrictionRank58810 failed on redundant dsimp, missing reflexivity, a timeout and rank-nullity instance alignment. Pinned Data.ZMod.Basic asserts Field is absent; the prime field instance is now in Mathlib.Algebra.Field.ZMod. Its five same4.34 artifact facets were already present. Adding that import and removing only the redundant dsimp resolved all failures under unchanged default heartbeats; no extra dependency build, option escalation or statement change. Batch15557 main/Checks exited0; Checks printed22 standard-only profiles. SubspaceRestriction is next and excluded from this count. Independent reviews and full hardness assembly remain pending.

TripleRestrictionRank source SHA256 `ca7653309402410e5050f0f6d4c03aa88a94c5c64a4b4964cb50ff82ce3896bc`.

TripleRestrictionRankChecks source SHA256 `89e3c004fb206b5f81d3679dd3a9197dfd5c2eae754c32df511814077b39adf3`.

### TripleRestrictionRank-1789261319580476200.log

SHA256 `7774691fcff8812979cf6ccae9344489b1faee5f463167989014454cb4592b03`.

```text
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:40:39: warning: This simp argument is unused:
  Fin.sum_univ_succ

Hint: Omit it from the simp argument list.
  [apply] simp [Fintype.sum_option, blockMass]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:41:2: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:48:26: warning: `if_true` has been deprecated: Use `ite_true` instead
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:68:19: warning: `if_false` has been deprecated: Use `ite_false` instead
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:90:25: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:91:25: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:91:50: warning: `if_true` has been deprecated: Use `ite_true` instead
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:104:19: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:105:19: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:91:36: warning: This simp argument is unused:
  Bool.true_eq

Hint: Omit it from the simp argument list.
  [apply] simp only [events, if_neg hi, if_true]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:111:39: warning: This simp argument is unused:
  Fin.sum_univ_succ

Hint: Omit it from the simp argument list.
  [apply] simp [Fintype.sum_option, blockMass]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:112:2: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:120:20: warning: This simp argument is unused:
  hd

Hint: Omit it from the simp argument list.
  [apply] simp

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:189:15: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [Coeff]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:223:15: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:230:8: error: `dsimp` made no progress
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:234:15: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:257:25: warning: This simp argument is unused:
  Coeff

Hint: Omit it from the simp argument list.
  [apply] simp [s, Fintype.card_fun, ZMod.card]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:257:32: warning: This simp argument is unused:
  Fintype.card_fun

Hint: Omit it from the simp argument list.
  [apply] simp [s, Coeff, ZMod.card]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:335:49: warning: This simp argument is unused:
  mul_assoc

Hint: Omit it from the simp argument list.
  [apply] simp [evaluate, Finset.mul_sum, mul_left_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:412:7: error(lean.synthInstanceFailed): failed to synthesize instance of type class
  Module.IsReflexive (ZMod 2) ↥(retained d)

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:420:5: error(lean.synthInstanceFailed): failed to synthesize instance of type class
  Module.IsReflexive (ZMod 2) ↥(retained d)

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:419:51: error: (deterministic) timeout at `whnf`, maximum number of heartbeats (200000) has been reached

Note: Use `set_option maxHeartbeats <num>` to set the limit.

Hint: Additional diagnostic information may be available using the `set_option diagnostics true` command.
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:431:15: error: Application type mismatch: The argument
  restrictedEvaluation R d
has type
  ↥(retained d) →ₛₗ[@RingHom.id (ZMod 2) (@Semiring.toNonAssocSemiring (ZMod 2) CommRing.toCommSemiring.toSemiring)]
    Module.Dual (ZMod 2) (Coeff c)
but is expected to have type
  ?m.60 →ₛₗ[@RingHom.id ?m.59 (@Semiring.toNonAssocSemiring ?m.59 DivisionRing.toDivisionSemiring.toSemiring)] ?m.64
in the application
  LinearMap.finrank_range_add_finrank_ker (restrictedEvaluation R d)

EXIT 1
```

### TripleRestrictionRank-1789261499131001800.log

SHA256 `ff89422687536a23019e086e48004500d6bd350bfd5b64a3289e99eb3040675a`.

```text
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:41:39: warning: This simp argument is unused:
  Fin.sum_univ_succ

Hint: Omit it from the simp argument list.
  [apply] simp [Fintype.sum_option, blockMass]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:42:2: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:49:26: warning: `if_true` has been deprecated: Use `ite_true` instead
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:69:19: warning: `if_false` has been deprecated: Use `ite_false` instead
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:91:25: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:92:25: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:92:50: warning: `if_true` has been deprecated: Use `ite_true` instead
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:105:19: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:106:19: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:92:36: warning: This simp argument is unused:
  Bool.true_eq

Hint: Omit it from the simp argument list.
  [apply] simp only [events, if_neg hi, if_true]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:112:39: warning: This simp argument is unused:
  Fin.sum_univ_succ

Hint: Omit it from the simp argument list.
  [apply] simp [Fintype.sum_option, blockMass]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:113:2: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice

Note: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:121:20: warning: This simp argument is unused:
  hd

Hint: Omit it from the simp argument list.
  [apply] simp

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:190:15: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [Coeff]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:224:15: warning: `if_pos` has been deprecated: Use `ite_eq_left` instead
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:234:15: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:257:25: warning: This simp argument is unused:
  Coeff

Hint: Omit it from the simp argument list.
  [apply] simp [s, Fintype.card_fun, ZMod.card]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:257:32: warning: This simp argument is unused:
  Fintype.card_fun

Hint: Omit it from the simp argument list.
  [apply] simp [s, Coeff, ZMod.card]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:335:49: warning: This simp argument is unused:
  mul_assoc

Hint: Omit it from the simp argument list.
  [apply] simp [evaluate, Finset.mul_sum, mul_left_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\TripleRestrictionRank.lean:433:69: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [Coeff]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`

EXIT 0
```

### TripleRestrictionRankChecks-1789261499131001800.log

SHA256 `c987188ad46a6c8efcef6030f25f55a9b140e65b934104c68b1d163cc8267ca0`.

```text
'PvNP.RealizableHardness.TripleRestrictionRank.blockMass_sum' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionRank.probability_univ' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionRank.block_marginal' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionRank.drop_marginal' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionRank.coordinate_removed_bound' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionRank.restrict_eq_zero_iff' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionRank.badRows_iff_not_injective' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionRank.goodRows_rank' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionRank.rowVanishes_probability' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionRank.probability_cover' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionRank.badRows_probability' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionRank.restricted_rank_failure_probability' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionRank.vanishing_on_retained_iff' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionRank.rowVanishes_on_retained' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionRank.matrix_restricted_rank_failure_probability' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionRank.intersection_eq_kernel' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionRank.rowFunctionals_injective' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionRank.restrictedEvaluation_dual' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionRank.goodRows_evaluation_surjective' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionRank.goodRows_intersectionCodim' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.TripleRestrictionRank.intersection_codim_failure_probability' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
lean\PvNP\RealizableHardness\TripleRestrictionRankChecks.lean:67:26: warning: Try `simp at he` instead of `simpa using he`

Note: This linter can be disabled with `set_option linter.unnecessarySimpa false`
'PvNP.RealizableHardness.TripleRestrictionRank.exampleRows_full' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]

EXIT 0
```

## Final scoped author checkpoint:33 mapped modules and aggregate

SubspaceRestriction15557 failed on the moved Module.Basis namespace and ambiguous Vector names. Four literal qualifications retain the intended mathematical types and targets. Batch18032 main/Checks exited0; Checks printed13 standard-only profiles. The unchanged original35-import aggregate then exited0. This establishes author compilation of the selected33 finite modules together with pinned foundation headline imports under Lean4.34rc2. Independent three-lens companion review remains pending. There is no final randomized hardness theorem or learning corollary in this aggregate. New unmapped drafts, including RandomizedReduction, and root4.13 incidence/counting/dimension sources are excluded. Compiler scope is frozen at this checkpoint.

Companion legacy non-module sources emit ordinary olean files; the five-facet requirement described for reused new-style mathlib dependency modules is not a claim about companion outputs. Downstream imports and selected executable checks were actually run.

SubspaceRestriction source SHA256 `9d94b2d8097fbc718a2ba97c6de57e5987e016e964100c0abb55981055120c41`.

SubspaceRestrictionChecks source SHA256 `8061a8cbf674e63c617e204a87df22b2abeb345784bd8e44dbea1d113e38c7bf`.

Unchanged aggregate source SHA256 `f6bde30681dcf7a14c1ac6adee16d18374a5c58e0090716bfb8c28a03100333b`;35 unique imports.

### SubspaceRestriction-1789261499131001800.log

SHA256 `ce771a3abf54f711863d008ddb0dbf1138da36aa4ac95e2d9cf28ebd22976779`.

```text
lean\PvNP\RealizableHardness\SubspaceRestriction.lean:32:8: error(lean.unknownIdentifier): Unknown identifier `Basis.toDual_apply_left`
lean\PvNP\RealizableHardness\SubspaceRestriction.lean:48:4: error: Function expected at
  Basis
but this term has type
  ?m.2

Note: Expected a function because this term is being applied to the argument
  (Fin (codim W))

Hint: The identifier `Basis` is unknown, and Lean's `autoImplicit` option causes an unknown identifier to be treated as an implicitly bound variable with an unknown type. However, the unknown type cannot be a function, and a function is what Lean expects here. This is often the result of a typo or a missing `import` or `open` statement.
lean\PvNP\RealizableHardness\SubspaceRestriction.lean:56:5: error: typeclass instance problem is stuck
  RingHomCompTriple ?m.91 (RingHom.id (ZMod 2)) ?m.93

Note: Lean will not try to resolve this typeclass instance problem because the seventh type argument to `RingHomCompTriple` is a metavariable. This argument must be fully determined before Lean will try to resolve the typeclass.

Hint: Adding type annotations and supplying implicit arguments to functions can give Lean more information for typeclass resolution. For example, if you have a variable `x` that you intend to be a `Nat`, but Lean reports it as having an unresolved type like `?m`, replacing `x` with `(x : Nat)` can get typeclass resolution un-stuck.
lean\PvNP\RealizableHardness\SubspaceRestriction.lean:58:6: warning: declaration uses `sorry`
lean\PvNP\RealizableHardness\SubspaceRestriction.lean:63:6: warning: declaration uses `sorry`
lean\PvNP\RealizableHardness\SubspaceRestriction.lean:66:2: warning: Unused tactic linter: `change
  evaluate ((coordinateDual J).symm (((annihilatorBasis W).equivFun.symm u).val)) x = _` does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
lean\PvNP\RealizableHardness\SubspaceRestriction.lean:68:2: warning: Unused tactic linter: `rw [← coordinateDual_apply, (coordinateDual J).apply_symm_apply]` does nothing

Note: This linter can be disabled with `set_option linter.unusedTactic false`
lean\PvNP\RealizableHardness\SubspaceRestriction.lean:68:2: warning: this tactic is never executed

Note: This linter can be disabled with `set_option linter.unreachableTactic false`
lean\PvNP\RealizableHardness\SubspaceRestriction.lean:81:11: error: Tactic `rcases` failed: `x✝ : ?m.55` is not an inductive datatype
lean\PvNP\RealizableHardness\SubspaceRestriction.lean:123:15: error: Ambiguous term
  Vector
Possible interpretations:
  _root_.Vector : Type ?u.19 → ℕ → Type ?u.19
  
  TripleRestrictionRank.Vector : ℕ → Type
lean\PvNP\RealizableHardness\SubspaceRestriction.lean:123:30: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [codim, Vector, Coord, Nat.mul_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\SubspaceRestriction.lean:126:15: error: Ambiguous term
  Vector
Possible interpretations:
  _root_.Vector : Type ?u.15 → ℕ → Type ?u.15
  
  TripleRestrictionRank.Vector : ℕ → Type
lean\PvNP\RealizableHardness\SubspaceRestriction.lean:126:30: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [codim, Vector, Coord]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`

EXIT 1
```

### SubspaceRestriction-1789261636692042400.log

SHA256 `91adb771c5c40225e97281174edf841ccdc16485324715ee5952cce2cd4566e7`.

```text
lean\PvNP\RealizableHardness\SubspaceRestriction.lean:123:52: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [codim, TripleRestrictionRank.Vector, Coord, Nat.mul_comm]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`
lean\PvNP\RealizableHardness\SubspaceRestriction.lean:126:52: warning: This simp argument is unused:
  Module.finrank_pi

Hint: Omit it from the simp argument list.
  [apply] simp [codim, TripleRestrictionRank.Vector, Coord]

Note: This linter can be disabled with `set_option linter.unusedSimpArgs false`

EXIT 0
```

### SubspaceRestrictionChecks-1789261636692042400.log

SHA256 `c03d2040dc9d871513daeaedb280b289fa18fb1f6f67249f3b46959a92c86f5e`.

```text
'PvNP.RealizableHardness.SubspaceRestriction.coordinateDual_apply' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SubspaceRestriction.annihilator_finrank' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SubspaceRestriction.definingForms_full' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SubspaceRestriction.definingForms_evaluate' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SubspaceRestriction.definingForms_kernel' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SubspaceRestriction.exists_independent_defining_forms' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SubspaceRestriction.represented_codim' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SubspaceRestriction.arbitrary_subspace_failure_probability' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SubspaceRestriction.codim_top' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SubspaceRestriction.codim_bot' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SubspaceRestriction.codim_empty' depends on axioms: [propext, Classical.choice, Quot.sound]
'PvNP.RealizableHardness.SubspaceRestriction.coordinateForm_surjective' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]
'PvNP.RealizableHardness.SubspaceRestriction.coordinateHyperplane_codim' depends on axioms: [propext,
 Classical.choice,
 Quot.sound]

EXIT 0
```

### AGGREGATE-1789261636692042400.log

SHA256 `8e3c732ce1a8b24cb9b555ba883cf4bb55690f7de6694f4ad1fc0412508b73b2`.

```text

EXIT 0
```

## Bounded finite integration acceptance

Frozen reviewed candidate: `6d7718919d681f57e28559bd0ee584c450cb2446`; candidate map SHA256 `b60506d4a969d19e9f3d87615a1fd09274b6a07f9459381b657b9c2b8d93f297`. Independent session36677 actually exited0 after33 mapped exports and the original aggregate (34 exits0). Its298 selected axiom profiles are subsets of propext, Classical.choice and Quot.sound. The durable verification JSON contains the34 raw logs and profiles; SHA256 `bbb5ca413cbeb1d691e8b4291aa640512a722615a8512b8de4f62b3b999f59c4`. This covers selected profile commands, not an assertion that every imported declaration was individually printed. Historical failed attempts and earlier pending-status checkpoints remain unchanged.

| Lens | Verdict | Evidence commit |
|---|---|---|
| [Proof-adversarial and independent build](../../research/p-equals-np/2026-09-12-realizable-hardness-companion-proof-review.md) | GO-WITH-NOTES | 9195c23744058350a0a7ea89271e23510a43ba15 |
| [Complexity](../../research/p-equals-np/2026-09-12-realizable-hardness-companion-complexity-review.md) | GO-WITH-NOTES | 6db6a6971150f8772a3e1ae6a482c016f5efd2cf |
| [Non-claims](../../research/p-equals-np/2026-09-12-realizable-hardness-companion-nonclaims-review.md) | GO-WITH-NOTES | 498727e2996e7090ef78b75aad52d21f57624d65 |

[Independent raw verification data](../../research/p-equals-np/2026-09-12-realizable-hardness-companion-proof-verification.json). Acceptance is restricted to the finite33 integration and original aggregate imports. Full randomized hardness and learning theorems remain absent; runtime, specialized source/decoder and outstanding geometry/covering bridges remain required. Six new geometry ports and RandomizedReduction main/Checks are UNCOMPILED and excluded. The separate geometry provenance map is unchanged. No public action or new compiler run occurred for this metadata integration.

The aggregate first comment alone was corrected from stale UNCOMPILED wording to bounded reviewed status. All35 imports and all33 proof bytes are unchanged. Original aggregate SHA256 `f6bde30681dcf7a14c1ac6adee16d18374a5c58e0090716bfb8c28a03100333b`; comment-updated aggregate SHA256 `fdf05fd19bce347adc2c7943a5f176e65ff431e151e9dd778dfff8286e2e0b7b`. No cosmetic recompilation was performed.
