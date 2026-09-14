import PvNP.RealizableHardness.Formula
import PvNP.RealizableHardness.StarListDecoding
import Mathlib.Data.Finset.Dedup

namespace PvNP.RealizableHardness.StarFormulaInterface
open PvNP.RealizableHardness.StarListDecoding
open scoped BigOperators
noncomputable section
universe u v
variable {V : Type u} [Fintype V]
  {Sigma : V → Type v} [∀ x, Fintype (Sigma x)]
  [∀ x, Nonempty (Sigma x)] {m : ℕ}

def evalOpt {X : Type*} (Z : X → Bool) : Option (Formula X) → Bool
  | none => false
  | some f => f.eval Z

def orOpt {X : Type*} : Option (Formula X) → Option (Formula X) → Option (Formula X)
  | none, q => q | some p, none => some p | some p, some q => some (.or p q)

def andOpt {X : Type*} : Option (Formula X) → Option (Formula X) → Option (Formula X)
  | some p, some q => some (.and p q) | _, _ => none

def orMany {X : Type*} (fs : List (Option (Formula X))) : Option (Formula X) := fs.foldr orOpt none
def andMany {X : Type*} (fs : List (Option (Formula X))) (acc : Option (Formula X)) : Option (Formula X) := fs.foldl andOpt acc

def selected (Z : (Σ x, Sigma x) → Bool) (x : V) : Finset (Sigma x) := by
  classical exact Finset.univ.filter (fun a => Z ⟨x, a⟩ = true)

def leafVertices (e : Star V Sigma m) : Finset V := by
  classical exact Finset.univ.image e.leaf

def fibre (e : Star V Sigma m) (x : V) (b : Sigma e.center) : Finset (Sigma x) := by
  classical exact Finset.univ.filter (fun a => ∀ i : Fin m, ∀ h : e.leaf i = x,
    e.projection i (cast (congrArg Sigma h.symm) a) = b)

def LocalWitness (e : Star V Sigma m) (A : ∀ x, Finset (Sigma x)) : Prop :=
  ∃ b : Sigma e.center, b ∈ A e.center ∧ ∀ x ∈ leafVertices e, ∃ a : Sigma x, a ∈ A x ∧ a ∈ fibre e x b

def leafFormula (e : Star V Sigma m) (x : V) (b : Sigma e.center) : Option (Formula (Σ x, Sigma x)) :=
  orMany ((fibre e x b).toList.map (fun a => some (.var ⟨x, a⟩)))

def branch (e : Star V Sigma m) (b : Sigma e.center) : Option (Formula (Σ x, Sigma x)) :=
  andMany ((leafVertices e).toList.map (fun x => leafFormula e x b)) (some (.var ⟨e.center, b⟩))

def compile (e : Star V Sigma m) : Option (Formula (Σ x, Sigma x)) :=
  orMany ((Finset.univ : Finset (Sigma e.center)).toList.map (branch e))

theorem evalOpt_orOpt {X : Type*} (Z : X → Bool) (p q : Option (Formula X)) :
    evalOpt Z (orOpt p q) = (evalOpt Z p || evalOpt Z q) := by cases p <;> cases q <;> simp [orOpt, evalOpt, Formula.eval]
theorem evalOpt_andOpt {X : Type*} (Z : X → Bool) (p q : Option (Formula X)) :
    evalOpt Z (andOpt p q) = (evalOpt Z p && evalOpt Z q) := by cases p <;> cases q <;> simp [andOpt, evalOpt, Formula.eval]

theorem eval_orMany_iff {X : Type*} (Z : X → Bool) (fs : List (Option (Formula X))) :
    evalOpt Z (orMany fs) = true ↔ ∃ f ∈ fs, evalOpt Z f = true := by
  induction fs with
  | nil => simp [orMany]
  | cons a fs ih => simp [orMany, evalOpt_orOpt, ih, Bool.or_eq_true]

theorem eval_andMany_iff {X : Type*} (Z : X → Bool) (fs : List (Option (Formula X))) (acc : Option (Formula X)) :
    evalOpt Z (andMany fs acc) = true ↔ evalOpt Z acc = true ∧ ∀ f ∈ fs, evalOpt Z f = true := by
  induction fs generalizing acc with
  | nil => simp [andMany]
  | cons a fs ih => simp [andMany, evalOpt_andOpt, ih, Bool.and_eq_true]

theorem localWitness_iff_listWitness (e : Star V Sigma m) (A : ∀ x, Finset (Sigma x)) :
    LocalWitness e A ↔ e.listWitness A := by
  classical
  constructor
  · rintro ⟨b, hb, hx⟩
    let q : Labeling Sigma := fun x => if h : x = e.center then cast (congrArg Sigma h.symm) b else
      if h : x ∈ leafVertices e then Classical.choose (hx x h) else Classical.choice (inferInstance : Nonempty (Sigma x))
    refine ⟨q, ?_, ?_⟩
    · intro i
      have hi := (Classical.choose_spec (hx (e.leaf i) (Finset.mem_image.mpr ⟨i, Finset.mem_univ _, rfl⟩))).2
      have hmem := Finset.mem_filter.mp hi
      simpa [q, e.separated i] using hmem.2 i rfl
    · intro j
      simp [Star.slot, q, hb]
      cases j <;> simp [q, hb]
  · rintro ⟨l, hl, hA⟩
    refine ⟨l e.center, hA 0, ?_⟩
    intro x hx
    obtain ⟨i, hi, rfl⟩ := Finset.mem_image.mp hx
    refine ⟨l (e.leaf i), hA i.succ, ?_⟩
    apply Finset.mem_filter.mpr
    constructor
    · exact Finset.mem_univ _
    · intro j h
      cases h
      simpa using hl j

theorem eval_all_true {X : Type*} (f : Formula X) : f.eval (fun _ => true) = true := by
  induction f <;> simp [Formula.eval, *]

end
end PvNP.RealizableHardness.StarFormulaInterface
