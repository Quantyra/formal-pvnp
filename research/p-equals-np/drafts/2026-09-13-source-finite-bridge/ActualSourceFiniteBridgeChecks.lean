import PvNP.RealizableHardness.ActualSourceFiniteBridge
namespace PvNP.RealizableHardness.ActualSourceFiniteBridgeChecks
open ActualSourceNormalization ActualSourceFiniteBridge
#print axioms normalized_label_lt
#print axioms instance_variable_value
#print axioms instance_rhs
#print axioms restrict_extend
#print axioms instance_flags_restrict
#print axioms instance_violations_restrict
#print axioms instance_flags_lift
#print axioms instance_violations_lift
#print axioms instance_flags_decode
#print axioms instance_violations_decode
#print axioms yes_count_transfer
#print axioms no_count_transfer
#print axioms sourceTriples_eq_unaryRows
#print axioms serializedSource_eq_unaryRows
#print axioms tableFn_eq_serializedSource
#print axioms empty_source_count
example : Valid ([(7,7,7)],[false]) := rfl
example : ((instanceOf ([(7,7,7)],[false]) (by rfl)).vars 0 0).val = 0 := by decide
example : ((instanceOf ([(7,7,7)],[false]) (by rfl)).vars 0 1).val = 0 := by decide
example : ((instanceOf ([(7,7,7)],[false]) (by rfl)).vars 0 2).val = 0 := by decide
example (b : Fin 0 -> ZMod 2) :
    (instanceOf ([],[]) (by rfl)).sourceViolations b = 0 := empty_source_count b
#check instanceOf
#check instance_flags_decode
#check no_count_transfer
#check tableFn_eq_serializedSource
end PvNP.RealizableHardness.ActualSourceFiniteBridgeChecks
