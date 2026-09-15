import PvNP.RealizableHardness.ActualOccurrenceCounts
import PvNP.RealizableHardness.ActualOccurrenceDegree

/-! The occurrence-sensitive degree input for the ordered-question mass bridge. -/
namespace PvNP.RealizableHardness.ActualQuestionMassBridge
open ActualOccurrenceAllocation
open ActualOccurrenceDegree
open scoped BigOperators
set_option autoImplicit false
noncomputable section
attribute [local instance] Classical.propDecidable

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

end
