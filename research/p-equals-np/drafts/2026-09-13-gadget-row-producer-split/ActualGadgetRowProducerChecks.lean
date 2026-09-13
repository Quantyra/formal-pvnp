import PvNP.RealizableHardness.ActualGadgetRowProducer
namespace PvNP.RealizableHardness.ActualGadgetRowProducerChecks
open Complexity ActualGadgetRowProducer ActualGraphEdges ActualOccurrenceCode
#print axioms packVar_eq
#print axioms reverseWord_mem_FP
#print axioms gadgetRowFn_mem_FP
#print axioms dartRule_mem_FP
#print axioms cloudFn_mem_FP
#print axioms cloudFn_output_polynomial
#print axioms rank_value
#print axioms dartList_index
#print axioms words_at_dart
#print axioms reverse_at_dart
#print axioms ranks_at_dart
#print axioms gadgetVarFn_correct
#print axioms gadgetRowFn_correct
#print axioms fourEntries_correct
#print axioms dartRule_correct
#print axioms dartVars_embed
#print axioms dartRows_localRows
#print axioms representative_entries
#print axioms entryCat_correct
#print axioms cloudFn_correct
#print axioms cloudFn_empty
#print axioms localCode_tag
#print axioms localRowCode_tag
#print axioms cloudFn_instance
#print axioms ownerCloudFn_mem_FP
#print axioms ownerCloudFn_correct
#print axioms ownerCloudFn_output_polynomial
#print axioms context_length
#print axioms dartClock_length
#print axioms loop_input_length
#print axioms dartRows_length
example : cloudFn ∈ FP := cloudFn_mem_FP
example : ownerCloudFn ∈ FP := ownerCloudFn_mem_FP
example (owner n : Nat) : cloudFn (context owner n) = DataEncode.bitstringEncode
    ((ActualEqualityCloud.rows n).map (localRowCode owner)) := cloudFn_correct owner n
example (owner : Nat) : cloudFn (context owner 0) =
    DataEncode.bitstringEncode ([] : List RowCode) := cloudFn_empty owner
example {n : Nat} (owner : Nat) (d : Dart n) (h : ¬ IsRep d) :
    dartRule (pair (context owner n) (u (dartIndex d))) = [] := by
  rw [dartRule_correct, if_neg h]
example {n : Nat} (owner : Nat) (d : Dart n) (h : IsRep d) :
    dartRule (pair (context owner n) (u (dartIndex d))) =
      (dartRows owner d).flatMap DataEncode.bitstringEncode := by
  rw [dartRule_correct, if_pos h]
example {n : Nat} (owner : Nat) (d : Dart n) (h : d.1 = (reverse d).1) :
    dartRule (pair (context owner n) (u (dartIndex d))) = [] := by
  have hn : ¬ IsRep d := fun hr => rep_nonloop hr h
  rw [dartRule_correct, if_neg hn]
example (n : Nat) : (dartList n).map dartIndex = List.range (n*D*3) := dartList_index n
example {N m : Nat} (I : ActualOccurrenceAllocation.Instance N m) (v : Fin N) :
    ownerCloudFn (ActualOccurrenceLookup.lookupInput (ActualOccurrenceLookup.serializedSource I) v.val) =
      DataEncode.bitstringEncode
        ((ActualEqualityCloud.rows (I.size v)).map (fun q => codeRow I (I.tagRow v q))) :=
  ownerCloudFn_correct I v
#check cloudFn
#check dartRule_correct
#check cloudFn_instance
#check ownerCloudFn_correct
end PvNP.RealizableHardness.ActualGadgetRowProducerChecks
