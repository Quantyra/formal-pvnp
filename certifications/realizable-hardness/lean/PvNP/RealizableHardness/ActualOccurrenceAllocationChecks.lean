import PvNP.RealizableHardness.ActualOccurrenceAllocation

namespace PvNP.RealizableHardness.ActualOccurrenceAllocationChecks
open ActualOccurrenceAllocation
open ActualOccurrenceAllocation.Instance
open scoped BigOperators

#print axioms slotList_nodup
#print axioms mem_occurrenceList
#print axioms occurrenceList_nodup
#print axioms ordinal_get
#print axioms occurrence_card
#print axioms sum_sizes
#print axioms recover_anchor
#print axioms anchor_injective
#print axioms anchor_owner
#print axioms originalRow_injective
#print axioms original_disjoint
#print axioms gadget_member_owner
#print axioms gadget_support_card
#print axioms gadgetSupport_eq
#print axioms original_support_card
#print axioms different_clouds_disjoint
#print axioms original_gadget_intersection
#print axioms gadget_pair_intersection
#print axioms support_eq
#print axioms support_card
#print axioms pair_intersection
#print axioms row_mem_rows
#print axioms rows_mem_iff
#print axioms zero_size
#print axioms zero_rows

#check ordinal
#check anchor_injective
#check original_gadget_intersection
#check rows_mem_iff

example {N m : Nat} (I : Instance N m) : (∑ v : Fin N, I.size v) = 3 * m := I.sum_sizes
example {N m : Nat} (I : Instance N m) (a b : Slot m) (h : I.anchor a = I.anchor b) : a = b :=
  I.anchor_injective h
example {N m : Nat} (I : Instance N m) (r s : Fin m) (h : r ≠ s) :
    Disjoint (I.originalSupport r) (I.originalSupport s) := I.original_disjoint r s h
example {N m : Nat} (I : Instance N m) (r : Fin m) (q : I.GadgetId) :
    (I.originalSupport r ∩ I.gadgetSupport q).card ≤ 1 := I.original_gadget_intersection r q
example {N m : Nat} (I : Instance N m) (q : I.RowId) :
    (I.row q, I.rowRhs q) ∈ I.rows := I.row_mem_rows q
example {N m : Nat} (I : Instance N m) (q : I.RowId) : (I.support q).card = 3 := I.support_card q
example {N : Nat} (I : Instance N 0) (v : Fin N) : I.size v = 0 := zero_size I v
example {N : Nat} (I : Instance N 0) : I.rows = [] := zero_rows I

end PvNP.RealizableHardness.ActualOccurrenceAllocationChecks
