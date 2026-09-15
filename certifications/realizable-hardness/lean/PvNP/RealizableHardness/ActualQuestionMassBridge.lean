import PvNP.RealizableHardness.ActualOccurrenceCounts
import PvNP.RealizableHardness.ActualOccurrenceDegree
import Mathlib.Algebra.Order.BigOperators.Group.Finset

/-! The occurrence-sensitive degree input for the ordered-question mass bridge. -/
namespace PvNP.RealizableHardness.ActualQuestionMassBridge
open ActualOccurrenceAllocation
open ActualOccurrenceDegree
open scoped BigOperators
set_option autoImplicit false
noncomputable section
attribute [local instance] Classical.propDecidable
variable {X E : Type*} [Fintype X] [Fintype E]
  [DecidableEq X] [DecidableEq E]

theorem rowId_incidence_card_eq_degree
    {N m : Nat} (I : Instance N m) (x : I.GlobalVar) :
    ((Finset.univ : Finset I.RowId).filter (fun q => x ∈ I.support q)).card =
      ActualOccurrenceDegree.degree I x := by
  calc
    ((Finset.univ : Finset I.RowId).filter (fun q => x ∈ I.support q)).card =
        ((I.rowIndices.toFinset).filter (fun q => x ∈ I.support q)).card := by
      rw [I.rowIndices_toFinset]
    _ = I.rowIndices.countP (fun q => decide (x ∈ I.support q)) := by
      convert
        (List.Nodup.card_eq_countP (l := I.rowIndices)
          (P := fun q : I.RowId => x ∈ I.support q) I.rowIndices_nodup) using 1
      apply congrArg (fun p => I.rowIndices.countP p)
      funext q
      by_cases h : x ∈ I.support q <;> simp [h]
    _ = ActualOccurrenceDegree.degree I x := by
      unfold ActualOccurrenceDegree.degree
      rw [I.rows_eq_map, List.countP_map]
      apply congrArg (fun p => I.rowIndices.countP p)
      funext q
      simp [ActualOccurrenceDegree.containsVar, I.support_eq]

theorem rowId_incidence_card_le_four
    {N m : Nat} (I : ActualOccurrenceAllocation.Instance N m)
    (x : I.GlobalVar) :
    ((Finset.univ : Finset I.RowId).filter (fun q => x ∈ I.support q)).card ≤ 4 := by
  rw [rowId_incidence_card_eq_degree]
  exact ActualOccurrenceDegree.degree_le_four I x

def rowConflict
    (row : E → Finset X) (e f : E) : Prop :=
  e = f ∨
  ¬ Disjoint (row e) (row f) ∨
  ∃ g : E, ∃ x ∈ row e, ∃ y ∈ row f,
    x ∈ row g ∧ y ∈ row g

def incidenceRows (row : E → Finset X) (x : X) : Finset E :=
  (Finset.univ : Finset E).filter (fun e => x ∈ row e)

def directConflictCandidates (row : E → Finset X) (e : E) : Finset E :=
  (row e).biUnion (incidenceRows row)

def crossConflictCandidates (row : E → Finset X) (e : E) : Finset E :=
  (row e).biUnion (fun x =>
    ((Finset.univ : Finset E).filter (fun g => x ∈ row g)).biUnion (fun g =>
      (row g).biUnion (incidenceRows row)))

theorem conflict_degree_le
    (row : E → Finset X) (D : Nat)
    (hthree : ∀ e, (row e).card = 3)
    (hdegree : ∀ x,
      ((Finset.univ : Finset E).filter
        (fun e => x ∈ row e)).card ≤ D)
    (e : E) :
    ((Finset.univ : Finset E).filter
      (rowConflict row e)).card ≤
      1 + 3 * D + 9 * D^2 := by
  classical
  have hdirect : (directConflictCandidates row e).card ≤ 3 * D := by
    calc
      (directConflictCandidates row e).card ≤ (row e).card * D := by
        exact Finset.card_biUnion_le_card_mul (row e) (incidenceRows row) D
          (fun x _ => hdegree x)
      _ = 3 * D := by rw [hthree e]
  have hy (g : E) : ((row g).biUnion (incidenceRows row)).card ≤ 3 * D := by
    calc
      ((row g).biUnion (incidenceRows row)).card ≤ (row g).card * D := by
        exact Finset.card_biUnion_le_card_mul (row g) (incidenceRows row) D
          (fun y _ => hdegree y)
      _ = 3 * D := by rw [hthree g]
  have hg (x : X) :
      (((Finset.univ : Finset E).filter (fun g => x ∈ row g)).biUnion
        (fun g => (row g).biUnion (incidenceRows row))).card ≤ 3 * D^2 := by
    calc
      _ ≤ ((Finset.univ : Finset E).filter (fun g => x ∈ row g)).card * (3 * D) := by
        exact Finset.card_biUnion_le_card_mul _ _ (3 * D)
          (fun g hg => hy g)
      _ ≤ D * (3 * D) := by
        exact Nat.mul_le_mul_right (3 * D) (hdegree x)
      _ = 3 * D^2 := by ring
  have hcross : (crossConflictCandidates row e).card ≤ 9 * D^2 := by
    calc
      (crossConflictCandidates row e).card ≤ (row e).card * (3 * D^2) := by
        exact Finset.card_biUnion_le_card_mul (row e) (fun x =>
          ((Finset.univ : Finset E).filter (fun g => x ∈ row g)).biUnion (fun g =>
            (row g).biUnion (incidenceRows row))) (3 * D^2)
          (fun x _ => hg x)
      _ = 9 * D^2 := by rw [hthree e]; ring
  have hsubset :
      ((Finset.univ : Finset E).filter (rowConflict row e)) ⊆
        (({e} : Finset E) ∪ directConflictCandidates row e) ∪
          crossConflictCandidates row e := by
    intro f hf
    rcases Finset.mem_filter.mp hf with ⟨_, hconflict⟩
    rcases hconflict with rfl | hdisj | ⟨g, x, hx, y, hyf, hxg, hyg⟩
    · simp
    · have hxy : f ∈ directConflictCandidates row e := by
        obtain ⟨z, hze, hzf⟩ := Finset.not_disjoint_iff.mp hdisj
        apply Finset.mem_biUnion.mpr
        exact ⟨z, hze, by simp [incidenceRows, hzf]⟩
      simp [hxy]
    · have hxy : f ∈ crossConflictCandidates row e := by
        apply Finset.mem_biUnion.mpr
        refine ⟨x, hx, ?_⟩
        apply Finset.mem_biUnion.mpr
        refine ⟨g, ?_, ?_⟩
        · simp [hxg]
        · apply Finset.mem_biUnion.mpr
          exact ⟨y, hyg, by simp [incidenceRows, hyf]⟩
      simp [hxy]
  have hcard := Finset.card_le_card hsubset
  calc
    ((Finset.univ : Finset E).filter (rowConflict row e)).card ≤
        ((({e} : Finset E) ∪ directConflictCandidates row e) ∪
          crossConflictCandidates row e).card := hcard
    _ ≤ (({e} : Finset E) ∪ directConflictCandidates row e).card +
          (crossConflictCandidates row e).card := Finset.card_union_le _ _
    _ ≤ (({e} : Finset E).card + (directConflictCandidates row e).card) +
          (crossConflictCandidates row e).card := by
      gcongr
      exact Finset.card_union_le _ _
    _ ≤ 1 + 3 * D + 9 * D^2 := by
      simp only [Finset.card_singleton]
      omega

#print axioms conflict_degree_le

end
