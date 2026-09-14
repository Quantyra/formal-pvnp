# StarFormulaInterface Checks contract

S3126/S3137. Author Checks only. Import the exact green main source SHA256 `93253b01c7ef7e440807f3e2257f2456bc0fe136ffc8d2dcdfc34a16880d15fc`, original author output `abcb4f31c9b86334c0f04f2423866b14ca51b0501ca393e100e703cc60590862`, session72062. Do not rerun main or dependencies. No independent acceptance or full manuscript completion is asserted.

Create only `certifications/realizable-hardness/lean/PvNP/RealizableHardness/StarFormulaInterfaceChecks.lean`. Import `PvNP.RealizableHardness.StarFormulaInterface`. Do not import private definitions from other Checks files. No `sorry`, `admit`, new axioms, `native_decide`, or target assumptions. These are fixed semantic tests; do not replace them with tautologies or only some-label nonemptiness.

Use this setup and these exact concrete objects (proof terms of `separated` may use `by decide`):

```lean
import PvNP.RealizableHardness.StarFormulaInterface

namespace PvNP.RealizableHardness.StarFormulaInterfaceChecks
open PvNP.RealizableHardness
open PvNP.RealizableHardness.StarListDecoding
open PvNP.RealizableHardness.StarFormulaInterface
noncomputable section

def zero : Star Bool (fun _ => Bool) 0 where
  center := false
  leaf := Fin.elim0
  projection := fun i => Fin.elim0 i
  separated := fun i => Fin.elim0 i

def repeated : Star Bool (fun _ => Bool) 2 where
  center := false
  leaf := fun _ => true
  projection := fun _ a => a
  separated := fun _ => by decide

def conflicting : Star Bool (fun _ => Bool) 2 where
  center := false
  leaf := fun _ => true
  projection := fun i a => if i = 0 then a else !a
  separated := fun _ => by decide

def Mixed : Bool → Type
  | false => Bool
  | true => Unit

instance (x : Bool) : Fintype (Mixed x) := by
  cases x <;> exact inferInstance
instance (x : Bool) : Nonempty (Mixed x) := by
  cases x <;> exact inferInstance

def unitLeaf : Star Bool Mixed 1 where
  center := false
  leaf := fun _ => true
  projection := fun _ _ => false
  separated := fun _ => by decide

def chooseFalse : (Sigma fun _ : Bool => Bool) → Bool := fun z => !z.2
def mixedSelection : (Sigma Mixed) → Bool
  | ⟨false, b⟩ => !b
  | ⟨true, _⟩ => true
```

Supply proof bodies for exactly these five examples; auxiliary local facts are allowed. End both the noncomputable section and namespace afterward.

```lean
-- Zero leaves still require a selected center label, without a true constant.
example :
    (∀ Z : (Sigma fun _ : Bool => Bool) → Bool,
      evalOpt Z (compile zero) = (Z ⟨false, false⟩ || Z ⟨false, true⟩)) ∧
    evalOpt (fun _ => false) (compile zero) = false ∧
    evalOpt chooseFalse (compile zero) = true := by
  -- proof

-- Two occurrences of one leaf share the same chosen false label.
example : evalOpt chooseFalse (compile repeated) = true := by
  -- proof

-- Both alphabets and full selections are nonempty; incompatible repeated
-- occurrence equations still make the entire positive compiler absent.
example : compile conflicting = none := by
  -- proof

-- Empty true-center fibre must remove only that branch, not the entire edge.
example :
    fibre unitLeaf true true = ∅ ∧
    fibre unitLeaf true false = Finset.univ ∧
    (∃ f, compile unitLeaf = some f) ∧
    evalOpt mixedSelection (compile unitLeaf) = true := by
  -- proof

-- Syntax exists while an empty selection makes its evaluation false.
example : ∃ f, compile repeated = some f ∧ f.eval (fun _ => false) = false := by
  -- proof
```

Proof route: use the proved compiler/list-witness equivalence and none characterization, not evaluation of a noncomputable choice by `decide`. For `zero`, LocalWitness reduces to an existential Bool center label; split Bool witnesses explicitly, then use Bool.or_eq_true_iff and Bool equality extensionality/cases for the Boolean equation. The leaf domain is Fin0. For `repeated`, the constant false global labeling is an actual accepting witness selected at every slot. For `conflicting`, assuming an accepting labeling gives the equations at explicit indices `(0 : Fin 2)` and `(1 : Fin 2)`; simplifying the concrete projection yields `a=b` and `!a=b`, contradicted by cases on `a`. For `unitLeaf`, simplify the actual finite filter, constant projection, Bool and Unit domains; the actual global labeling sends false to false and true to unit. A true evaluation excludes none by Option cases. For empty selections, a list witness would select its center label from the empty selected list: specialize its slot membership to zero. Derive false by cases on the Bool result, not by assuming the desired compiler proposition. Avoid globally unfolding evalOpt when a helper theorem needs a still-visible `evalOpt` head.

Print all eleven exact main theorem axiom profiles (not an inferred aggregate), using their fully qualified names under `PvNP.RealizableHardness.StarFormulaInterface`:

1. `evalOpt_orOpt`
2. `evalOpt_andOpt`
3. `eval_orMany_iff`
4. `eval_andMany_iff`
5. `localWitness_iff_listWitness`
6. `eval_all_true`
7. `eval_leafFormula_iff`
8. `eval_branch_iff`
9. `eval_compile_iff_listWitness`
10. `compile_eq_none_iff`
11. `compile_some_eval_iff`

Use `#print axioms` for each. Allowed axioms are a subset of `propext`, `Classical.choice`, `Quot.sound`; no new axiom or sorryAx. Also issue `#check` for all four locked targets: `localWitness_iff_listWitness`, `eval_compile_iff_listWitness`, `compile_eq_none_iff`, `compile_some_eval_iff`. Expected minimum tally: eleven profiles, four signatures, five examples. Do not claim these example headers have been kernel checked until the actual Checks compile succeeds.

Report stable raw Checks source hash. Root will grant the fixed Checks-only guarded runner, importing the exact existing main output. If three attempts fail without new diagnostics, inspect the explicit goals before any further proof edits; preserve every raw attempt. Green main is never rebuilt for a Checks-only repair. Actual transported Grassmann-star coherence and the full manuscript theorem remain separate obligations.
