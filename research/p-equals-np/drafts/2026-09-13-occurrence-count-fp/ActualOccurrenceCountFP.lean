import PvNP.RealizableHardness.ActualOccurrenceLookup
import PvNP.RealizableHardness.ActualOccurrencePrefix

/-! Isolated uncompiled source. Full-table owner count on the existing unary
wire, conditional on generalized Allocation acceptance. No whole constructor. -/
namespace PvNP.RealizableHardness.ActualOccurrenceCountFP
open Complexity ActualOccurrenceAllocation ActualOccurrenceLookup ActualOccurrencePrefix
open scoped BigOperators
set_option autoImplicit false
noncomputable section

/-- Context is the existing pair(table, ownerUnary); w also carries a slot clock. -/
def countMark (w : List Bool) : List Bool :=
  ifEqLen (ownerLookup (pair (pairFst (pairFst w)) (pairSnd w)))
    (pairSnd (pairFst w)) [true] []

/-- The actual table, not a supplied bound, determines all three positions per row. -/
def tableClock (T : List Bool) : List Bool := marks (mulC 3 (posCount T))

def occurrenceCountFn (z : List Bool) : List Bool :=
  countOver countMark (pair (tableClock (pairFst z)) z)

theorem countMark_mem_FP : Membership.mem FP countMark := by
  unfold countMark
  have hff : Membership.mem FP (fun w : List Bool => pairFst (pairFst w)) := by
    simpa only [Function.comp_def] using
      mem_FP_comp Cobham.fstBlock_mem_FP Cobham.fstBlock_mem_FP
  have hsf : Membership.mem FP (fun w : List Bool => pairSnd (pairFst w)) := by
    simpa only [Function.comp_def] using
      mem_FP_comp Cobham.fstBlock_mem_FP Cobham.sndBlock_mem_FP
  have ha := Cobham.pairFn_mem_FP hff Cobham.sndBlock_mem_FP
  have ho : Membership.mem FP (fun w : List Bool =>
      ownerLookup (pair (pairFst (pairFst w)) (pairSnd w))) := by
    simpa only [Function.comp_def] using mem_FP_comp ha ownerLookup_mem_FP
  exact ifEqLen_mem_FP ho hsf (constFn_mem_FP [true]) (constFn_mem_FP [])

theorem tableClock_mem_FP : Membership.mem FP tableClock :=
  marks_mem_FP (mulC_mem_FP (posCount_mem_FP id_mem_FP) 3)

theorem occurrenceCountFn_mem_FP : Membership.mem FP occurrenceCountFn := by
  unfold occurrenceCountFn
  have hc : Membership.mem FP (fun z : List Bool => tableClock (pairFst z)) := by
    simpa only [Function.comp_def] using
      mem_FP_comp Cobham.fstBlock_mem_FP tableClock_mem_FP
  have ha := Cobham.pairFn_mem_FP hc id_mem_FP
  simpa only [Function.comp_def, id_eq] using
    mem_FP_comp ha (countOver_mem_FP countMark_mem_FP)

theorem tableClock_correct {N m : Nat} (I : Instance N m) :
    tableClock (serializedSource I) = List.replicate (m*3) true := by
  simp [tableClock, serializedSource, posCount_eq, sourceTriples_length, marks_eq, mulC]

theorem countMark_correct {N m : Nat} (I : Instance N m) (v : Fin N) (o : Slot m) :
    countMark (pair (lookupInput (serializedSource I) v.val)
      (List.replicate (rank o) true)) =
        if I.owner o = v then [true] else [] := by
  simp only [countMark, lookupInput, pairFst_pair, pairSnd_pair]
  change ifEqLen (ownerLookup (lookupInput (serializedSource I) (rank o)))
    (List.replicate v.val true) [true] [] = _
  have ho : ownerLookup (lookupInput (serializedSource I) (rank o)) =
      List.replicate (I.owner o).val true := by
    simpa [rank, Nat.mul_comm] using ownerLookup_correct I o
  rw [ho]
  by_cases h : I.owner o = v
  · rw [ite_eq_left h]
    apply ifEqLen_pos
    simp [h]
  · rw [ite_eq_right h]
    apply ifEqLen_neg
    simp only [List.length_replicate]
    intro he
    exact h (Fin.ext he)

theorem countMark_length {N m : Nat} (I : Instance N m) (v : Fin N) (o : Slot m) :
    (countMark (pair (lookupInput (serializedSource I) v.val)
      (List.replicate (rank o) true))).length =
        if I.owner o = v then 1 else 0 := by
  rw [countMark_correct]
  split_ifs <;> rfl

private theorem countP_as_sum {A : Type*} (p : A → Bool) (l : List A) :
    l.countP p = (l.map (fun a => if p a then 1 else 0)).sum := by
  induction l with
  | nil => rfl
  | cons a l ih => cases h : p a <;> simp [h, ih, Nat.add_comm]

/-- Exact full slot-list count, including all repeated-owner positions. -/
theorem occurrenceCountFn_length_eq_slots {N m : Nat} (I : Instance N m) (v : Fin N) :
    (occurrenceCountFn (lookupInput (serializedSource I) v.val)).length =
      (slotList m).countP (fun o => decide (I.owner o = v)) := by
  unfold occurrenceCountFn
  have ht : pairFst (lookupInput (serializedSource I) v.val) = serializedSource I := by
    simp [lookupInput]
  rw [ht, tableClock_correct, length_countOver, Finset.sum_range]
  rw [countP_as_sum, slotList_eq_decode, List.map_map, ← Fin.sum_univ_def]
  apply Finset.sum_congr rfl
  intro q _
  have h := countMark_length I v (decode q)
  rw [rank_decode] at h
  simpa only [Function.comp_def, decide_eq_true_eq] using h

theorem occurrenceCountFn_length {N m : Nat} (I : Instance N m) (v : Fin N) :
    (occurrenceCountFn (lookupInput (serializedSource I) v.val)).length = I.size v := by
  rw [occurrenceCountFn_length_eq_slots]
  exact List.countP_eq_length_filter

/-- Same raw function as its FP theorem, not an unrelated existential producer. -/
theorem occurrenceCountFn_correct {N m : Nat} (I : Instance N m) (v : Fin N) :
    occurrenceCountFn (lookupInput (serializedSource I) v.val) =
      List.replicate (I.size v) true := by
  calc
    _ = List.replicate
        (occurrenceCountFn (lookupInput (serializedSource I) v.val)).length true :=
      countOver_eq_replicate _ _
    _ = _ := by rw [occurrenceCountFn_length]

theorem occurrenceCountFn_length_le {N m : Nat} (I : Instance N m) (v : Fin N) :
    (occurrenceCountFn (lookupInput (serializedSource I) v.val)).length ≤ 3*m := by
  rw [occurrenceCountFn_length_eq_slots]
  have h := List.countP_le_length (l := slotList m) (p := fun o => decide (I.owner o = v))
  simpa [slotList, List.product, Nat.mul_comm] using h

theorem occurrenceCountFn_unused {N m : Nat} (I : Instance N m) (v : Fin N)
    (hv : I.size v = 0) :
    occurrenceCountFn (lookupInput (serializedSource I) v.val) = [] := by
  rw [occurrenceCountFn_correct, hv]
  rfl

theorem occurrenceCountFn_empty {N : Nat} (I : Instance N 0) (v : Fin N) :
    occurrenceCountFn (lookupInput (serializedSource I) v.val) = [] :=
  occurrenceCountFn_unused I v (I.zero_size v)

theorem count_wire_length (T : List Bool) (v : Nat) :
    (lookupInput T v).length = 2*T.length+2+v := lookupInput_length T v

theorem count_internal_wire_length {N m : Nat} (I : Instance N m) (v : Fin N) :
    (pair (tableClock (serializedSource I)) (lookupInput (serializedSource I) v.val)).length =
      6*m + 2*(serializedSource I).length + 4 + v.val := by
  simp [tableClock_correct, lookupInput]
  omega

end
end PvNP.RealizableHardness.ActualOccurrenceCountFP
