import PvNP.RealizableHardness.ActualQuestionMassBridge

namespace PvNP.RealizableHardness.ActualQuestionMassBridgeChecks
open ActualOccurrenceAllocation
open ActualOccurrenceAllocation.Instance
open ActualOccurrenceDegree
open ActualQuestionMassBridge
noncomputable section
attribute [local instance] Classical.propDecidable

#check rowId_incidence_card_le_four
#check rowId_incidence_card_eq_degree
#check rowConflict
#check conflict_degree_le
#print axioms rowId_incidence_card_le_four
#print axioms rowId_incidence_card_eq_degree
#print axioms conflict_degree_le

/-! A concrete allocation with two source rows and repeated ownership.  The
occurrence IDs remain distinct even though all six source slots use owner 0. -/
def repeatedOwner : Instance 1 2 where
  vars := fun _ _ => 0
  rhs := fun _ => 0

def trackedOccurrence : repeatedOwner.GlobalVar :=
  repeatedOwner.anchor (0, 0)

example : repeatedOwner.vars 0 0 = 0 := rfl
example : repeatedOwner.vars 1 2 = 0 := rfl
example : Function.Injective repeatedOwner.anchor := repeatedOwner.anchor_injective

example :
    ((Finset.univ : Finset repeatedOwner.RowId).filter
      (fun q => trackedOccurrence ∈ repeatedOwner.support q)).card =
      degree repeatedOwner trackedOccurrence := by
  exact rowId_incidence_card_eq_degree repeatedOwner trackedOccurrence

example :
    ((Finset.univ : Finset repeatedOwner.RowId).filter
      (fun q => trackedOccurrence ∈ repeatedOwner.support q)).card ≤ 4 := by
  exact rowId_incidence_card_le_four repeatedOwner trackedOccurrence

def threeRows : Bool → Finset (Fin 4)
  | false => {0, 1, 2}
  | true => {0, 2, 3}

example : rowConflict threeRows false false := by
  simp [rowConflict]

example : rowConflict threeRows false true := by
  apply Or.inr
  apply Or.inl
  exact Finset.not_disjoint_iff.mpr ⟨0, by simp [threeRows], by simp [threeRows]⟩

example :
    ((Finset.univ : Finset Bool).filter (rowConflict threeRows false)).card ≤
      1 + 3 * 2 + 9 * 2^2 := by
  apply conflict_degree_le threeRows 2
  · decide
  · decide

/-! The same cross-only geometry used by the support checks: rows 0 and 1
are disjoint, while row 2 contains one point from each. -/
def badRows (e : Fin 3) : Finset (Fin 3) :=
  if e = 0 then {0} else if e = 1 then {1} else {0, 1}

example :
    rowConflict badRows 0 1 ∧ Disjoint (badRows 0) (badRows 1) := by
  constructor
  · apply Or.inr
    apply Or.inr
    exact ⟨2, 0, by simp [badRows], 1, by simp [badRows],
      by simp [badRows], by simp [badRows]⟩
  · simp [badRows]

end
end PvNP.RealizableHardness.ActualQuestionMassBridgeChecks
