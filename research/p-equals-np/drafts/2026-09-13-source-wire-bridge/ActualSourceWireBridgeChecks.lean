import PvNP.RealizableHardness.ActualSourceWireBridge
namespace PvNP.RealizableHardness.ActualSourceWireBridgeChecks
open Complexity ActualSourceNormalization ActualSourceWireBridge
#print axioms rhsValue_agrees
#print axioms rhsBool_sourceValue
#print axioms instance_rhs_roundtrip
#print axioms rhsList_instanceOf
#print axioms finite_wire_eq
#print axioms sourceFn_eq_finite_wire
#print axioms originalRowsFromSourceFn_mem_FP
#print axioms originalRowsFromSourceFn_correct
#print axioms originalRowsFromSourceFn_output_polynomial
example : Membership.mem FP originalRowsFromSourceFn := originalRowsFromSourceFn_mem_FP
example (S : Source) (h : Valid S) :
    ActualOriginalRowProducer.rhsList (ActualSourceFiniteBridge.instanceOf S h) = S.2 :=
  rhsList_instanceOf S h
example : ActualOccurrenceCode.rhsBool (rhsValue false) = false := rhsBool_sourceValue false
example : ActualOccurrenceCode.rhsBool (rhsValue true) = true := rhsBool_sourceValue true
example : ActualOriginalRowProducer.rhsList
    (ActualSourceFiniteBridge.instanceOf ([],[]) (by rfl)) = [] :=
  rhsList_instanceOf ([],[]) (by rfl)
example : ActualOriginalRowProducer.rhsList
    (ActualSourceFiniteBridge.instanceOf ([(7,(7,7)),(7,(2,7))],[true,false]) (by rfl)) =
      [true,false] := rhsList_instanceOf _ (by rfl)
#check sourceFn_eq_finite_wire
#check originalRowsFromSourceFn_correct
#check originalRowsFromSourceFn_output_polynomial
end PvNP.RealizableHardness.ActualSourceWireBridgeChecks
