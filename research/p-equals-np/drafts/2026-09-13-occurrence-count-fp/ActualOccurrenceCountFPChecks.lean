import PvNP.RealizableHardness.ActualOccurrenceCountFP
namespace PvNP.RealizableHardness.ActualOccurrenceCountFPChecks
open Complexity ActualOccurrenceAllocation ActualOccurrenceLookup ActualOccurrenceCountFP
#print axioms countMark_mem_FP
#print axioms tableClock_mem_FP
#print axioms occurrenceCountFn_mem_FP
#print axioms tableClock_correct
#print axioms countMark_correct
#print axioms countMark_length
#print axioms occurrenceCountFn_length_eq_slots
#print axioms occurrenceCountFn_length
#print axioms occurrenceCountFn_correct
#print axioms occurrenceCountFn_length_le
#print axioms occurrenceCountFn_unused
#print axioms occurrenceCountFn_empty
#print axioms count_wire_length
#print axioms count_internal_wire_length
example : Membership.mem FP occurrenceCountFn := occurrenceCountFn_mem_FP
example {N m : Nat} (I : Instance N m) (v : Fin N) :
    occurrenceCountFn (lookupInput (serializedSource I) v.val) =
      List.replicate (I.size v) true := occurrenceCountFn_correct I v
example {N : Nat} (I : Instance N 0) (v : Fin N) :
    occurrenceCountFn (lookupInput (serializedSource I) v.val) = [] := occurrenceCountFn_empty I v
/-- Requires the generalized interface; three positions keep one repeated owner. -/
def repeatedSource : Instance 2 1 where
  vars := fun _ _ => 0
  rhs := fun _ => 0
example : repeatedSource.size 0 = 3 := by decide
example : repeatedSource.size 1 = 0 := by decide
example : occurrenceCountFn (lookupInput (serializedSource repeatedSource) 0) =
    [true,true,true] := by
  rw [occurrenceCountFn_correct repeatedSource (0 : Fin 2)]
  decide
example : occurrenceCountFn (lookupInput (serializedSource repeatedSource) 1) = [] := by
  apply occurrenceCountFn_unused repeatedSource (1 : Fin 2)
  decide
#check occurrenceCountFn
#check occurrenceCountFn_correct
#check occurrenceCountFn_length_eq_slots
end PvNP.RealizableHardness.ActualOccurrenceCountFPChecks
