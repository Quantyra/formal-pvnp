import PvNP.RealizableHardness.ActualRegularizedSourceProducer
namespace PvNP.RealizableHardness.ActualRegularizedSourceProducerChecks
open Complexity ActualOccurrenceCode ActualRegularizedSourceProducer
open ActualSourceNormalization (Source Valid)
#print axioms wrap_mem_FP
#print axioms encode_list
#print axioms inner_encode
#print axioms joinLists_mem_FP
#print axioms joinLists_encode
#print axioms ownerRule_mem_FP
#print axioms ownerRule_correct
#print axioms owner_entries
#print axioms ownerClock_mem_FP
#print axioms ownerClock_correct
#print axioms cloudsFn_mem_FP
#print axioms cloudsFn_correct
#print axioms normalizedTableFn_mem_FP
#print axioms normalizedTableFn_correct
#print axioms cloudsFromSourceFn_mem_FP
#print axioms cloudsFromSourceFn_correct
#print axioms rows_code_split
#print axioms constructorFn_mem_FP
#print axioms constructorFn_correct
#print axioms constructorFn_output_polynomial
#print axioms constructorFn_codeRows
#print axioms emitted_violations_restrict
#print axioms emitted_violations_extend
#print axioms emitted_degree_le_four
#print axioms constructorFn_empty
example : Membership.mem FP constructorFn := constructorFn_mem_FP
example (S : Source) (h : Valid S) : constructorFn (ActualSourceNormalization.wire S) =
    DataEncode.bitstringEncode (codeRows (ActualSourceFiniteBridge.instanceOf S h)) :=
  constructorFn_codeRows S h
example : constructorFn (ActualSourceNormalization.wire ([],[])) =
    DataEncode.bitstringEncode ([] : List RowCode) := constructorFn_empty
def repeatedMixed : Source := ([(7,(7,7)),(7,(2,7))],[true,false])
example : Valid repeatedMixed := rfl
example : constructorFn (ActualSourceNormalization.wire repeatedMixed) =
    DataEncode.bitstringEncode ((ActualSourceFiniteBridge.instanceOf repeatedMixed (by rfl)).rows.map
      (codeRow (ActualSourceFiniteBridge.instanceOf repeatedMixed (by rfl)))) :=
  constructorFn_correct repeatedMixed (by rfl)
example : ActualOriginalRowProducer.rhsList
    (ActualSourceFiniteBridge.instanceOf repeatedMixed (by rfl)) = [true,false] :=
  ActualSourceWireBridge.rhsList_instanceOf repeatedMixed (by rfl)
example (S : Source) (h : Valid S) (v : VarCode) :
    ActualOccurrenceCode.degree (ActualSourceFiniteBridge.instanceOf S h) v <= 4 :=
  emitted_degree_le_four S h v
#check constructorFn
#check constructorFn_correct
#check constructorFn_output_polynomial
#check emitted_violations_extend
end PvNP.RealizableHardness.ActualRegularizedSourceProducerChecks
