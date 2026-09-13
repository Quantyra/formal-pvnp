import PvNP.RealizableHardness.ActualOriginalRowProducer
namespace PvNP.RealizableHardness.ActualOriginalRowProducerChecks
open Complexity ActualOccurrenceAllocation ActualOccurrenceLookup
  ActualOccurrencePrefix ActualOccurrenceCode ActualOriginalRowProducer
#print axioms dataPair_encode
#print axioms anchorCodeFn_mem_FP
#print axioms anchorCodeFn_correct
#print axioms wire_table
#print axioms wire_rhs
#print axioms rowTableArg_mem_FP
#print axioms anchorField_mem_FP
#print axioms anchorField_correct
#print axioms rhsField_mem_FP
#print axioms rhsField_correct
#print axioms rowRule_mem_FP
#print axioms rowRule_correct
#print axioms rowClock_mem_FP
#print axioms rowClock_correct
#print axioms originalCodes_length
#print axioms originalCodes_get
#print axioms originalRowsFn_mem_FP
#print axioms originalRowsFn_correct
#print axioms originalRowsFn_output_polynomial
example : Membership.mem FP originalRowsFn := originalRowsFn_mem_FP
example {N m : Nat} (I : Instance N m) (o : Slot m) :
    anchorCodeFn (lookupInput (serializedSource I) (rank o)) =
      DataEncode.bitstringEncode (codeVar I (I.anchor o)) := anchorCodeFn_correct I o
example {N m : Nat} (I : Instance N m) :
    originalRowsFn (wire I) = DataEncode.bitstringEncode
      (I.originalRows.map (codeRow I)) := originalRowsFn_correct I
noncomputable def repeated : Instance 1 2 where
  vars := fun _ _ => 0
  rhs := fun r => if r.val = 0 then 1 else 0
example : (originalCodes repeated).length = 2 := originalCodes_length repeated
example (I : Instance 0 0) : originalRowsFn (wire I) =
    DataEncode.bitstringEncode ([] : List RowCode) := by
  simpa [Instance.originalRows] using originalRowsFn_correct I
#check anchorCodeFn_correct
#check rowRule_correct
#check originalRowsFn_correct
end PvNP.RealizableHardness.ActualOriginalRowProducerChecks
