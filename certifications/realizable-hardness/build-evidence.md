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
