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
#print axioms rowId_incidence_card_le_four
#print axioms rowId_incidence_card_eq_degree

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

end
end PvNP.RealizableHardness.ActualQuestionMassBridgeChecks
