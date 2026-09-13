import PvNP.RealizableHardness.ActualOccurrenceCode
namespace PvNP.RealizableHardness.ActualOccurrenceCodeChecks
open ActualOccurrenceAllocation ActualOccurrenceCode
#print axioms unary_injective
#print axioms codeVar_injective
#print axioms variableWire_injective
#print axioms rhsValue_rhsBool
#print axioms rhsBool_rhsValue
#print axioms rowVars_codeRow
#print axioms codeRow_injective
#print axioms codeRows_nodup
#print axioms codeRows_ordered
#print axioms codeRows_length
#print axioms extendAssignment_codeVar
#print axioms restrict_extend
#print axioms badRow_codeRow
#print axioms ordered_flags_restrict
#print axioms violations_restrict
#print axioms ordered_flags_extend
#print axioms violations_extend
#print axioms rowSupport_codeRow
#print axioms support_eq_map
#print axioms support_three
#print axioms pair_intersection
#print axioms containsCode_codeRow
#print axioms degree_codeVar
#print axioms degree_codeVar_le_four
#print axioms degree_outside_image
#print axioms degree_le_four
example {N m : Nat} (I : Instance N m) (x y : I.GlobalVar)
    (h : codeVar I x = codeVar I y) : x = y := codeVar_injective I h
example {N m : Nat} (I : Instance N m) (a : I.GlobalVar → ZMod 2) :
    violations I (extendAssignment I a) = I.violations a := violations_extend I a
example {N m : Nat} (I : Instance N m) (a : VarCode → ZMod 2) :
    violations I a = I.violations (restrictAssignment I a) := violations_restrict I a
example {N m : Nat} (I : Instance N m) (c : VarCode) : degree I c ≤ 4 := degree_le_four I c
example : rhsValue (rhsBool (1 : ZMod 2)) = 1 := rhsValue_rhsBool 1
example {N m : Nat} (I : Instance N m) (v : Fin N)
    (e f : ActualGraphEdges.Edge (I.size v)) (i j : Fin 5)
    (h : codeVar I ⟨v,Sum.inr (e,i)⟩ = codeVar I ⟨v,Sum.inr (f,j)⟩) :
    (⟨v,Sum.inr (e,i)⟩ : I.GlobalVar) = ⟨v,Sum.inr (f,j)⟩ := codeVar_injective I h
example {N : Nat} (I : Instance N 0) : codeRows I = [] := by
  rw [codeRows, I.zero_rows]
  rfl
#check codeVar
#check rowsWire
#check ordered_flags_extend
#check pair_intersection
end PvNP.RealizableHardness.ActualOccurrenceCodeChecks
