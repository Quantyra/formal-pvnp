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
