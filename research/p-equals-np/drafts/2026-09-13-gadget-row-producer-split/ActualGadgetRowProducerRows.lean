import PvNP.RealizableHardness.ActualGadgetRowProducerGeometry

/-! SOURCE-ONLY packaging split of frozen e9c5c6aa; not compiled or accepted. -/
namespace PvNP.RealizableHardness.ActualGadgetRowProducer
open Complexity ActualGraphEdges ActualOccurrenceCode
set_option autoImplicit false
noncomputable section

theorem gadgetVarFn_correct {n : Nat} (owner : Nat) (d : Dart n) (t : EqualityGadget.Var) :
    gadgetVarFn t (pair (context owner n) (u (dartIndex d))) =
      DataEncode.bitstringEncode (dartVars owner d t) := by
  obtain ⟨ho,hn,hk,hj,hi⟩ := words_at_dart owner d
  fin_cases t <;>
    simp [gadgetVarFn, portFn, internalFn,
      ho, hk, hj, hi, reverseK, reverseJ, reverse_at_dart,
      ExecutablePortRotation.output, pairFst_pair, pairSnd_pair, packVar_eq, dartVars]

theorem gadgetRowFn_correct {n : Nat} (owner : Nat) (d : Dart n) (r : EqualityGadget.Row) :
    gadgetRowFn r (pair (context owner n) (u (dartIndex d))) =
      DataEncode.bitstringEncode (dartRow owner d r) := by
  simp only [gadgetRowFn, gadgetVarFn_correct, dartRow, bitstringEncode_prod_eq,
    packRow, dp, ActualSourceNormalizedTable.dataPair]
theorem fourEntries_correct {n : Nat} (owner : Nat) (d : Dart n) :
    fourEntries (pair (context owner n) (u (dartIndex d))) =
      (dartRows owner d).flatMap DataEncode.bitstringEncode := by
  simp [fourEntries, gadgetRowFn_correct, dartRows, List.ofFn_succ, List.append_assoc]
theorem dartRule_correct {n : Nat} (owner : Nat) (d : Dart n) :
    dartRule (pair (context owner n) (u (dartIndex d))) =
      if IsRep d then (dartRows owner d).flatMap DataEncode.bitstringEncode else [] := by
  obtain ⟨hs,ht⟩ := ranks_at_dart owner d
  unfold dartRule
  rw [hs,ht]
  by_cases h : IsRep d
  · rw [ifLtLen_pos (by simpa only [u, unary, List.length_replicate] using h),
      if_pos h, fourEntries_correct]
  · rw [ifLtLen_neg (by simpa only [u, unary, List.length_replicate] using h), if_neg h]

theorem dartVars_embed {n : Nat} (owner : Nat) (e : Edge n) (t : EqualityGadget.Var) :
    dartVars owner e.val t = localCode owner (ActualEqualityCloud.embedFn e t) := by
  fin_cases t <;> rfl
theorem dartRows_localRows {n : Nat} (owner : Nat) (e : Edge n) :
    dartRows owner e.val = (ActualEqualityCloud.localRows e).map (localRowCode owner) := by
  rw [dartRows, ActualEqualityCloud.localRows_eq, List.map_ofFn]
  apply congrArg List.ofFn
  funext r
  simp only [dartRow, localRowCode, ActualEqualityCloud.row,
    EqualityGadget.relabeledRow, ActualEqualityCloud.embedding, dartVars_embed]
  simp [ActualEqualityCloud.rhs, EqualityGadget.rhs, rhsBool]

private theorem filter_flatMap {A B : Type} (p : A → Bool) (f : A → List B) (l : List A) :
    (l.filter p).flatMap f = l.flatMap (fun x => if p x then f x else []) := by
  induction l with
  | nil => rfl
  | cons a l ih => cases h : p a <;> simp [h, ih]

theorem representative_entries {n : Nat} (owner : Nat) :
    (representativeList n).flatMap (dartRows owner) =
      (ActualEqualityCloud.rows n).map (localRowCode owner) := by
  have he : (ActualEqualityCloud.edgeList n).map Subtype.val = representativeList n := by
    simp [ActualEqualityCloud.edgeList, List.map_map, Function.comp_def]
  rw [← he, List.flatMap_map]
  simp_rw [dartRows_localRows]
  rw [ActualEqualityCloud.rows, List.map_flatMap]

/-- The variable-output accumulation is exactly the actual filtered row list. -/
theorem entryCat_correct (owner n : Nat) :
    entryCat dartRule (context owner n) (n*D*3) =
      ((ActualEqualityCloud.rows n).map (localRowCode owner)).flatMap DataEncode.bitstringEncode := by
  rw [entryCat, ← dartList_index, List.flatMap_map]
  simp_rw [show ∀ d : Dart n, dartRule (pair (context owner n) (List.replicate (dartIndex d) true)) =
      if IsRep d then (dartRows owner d).flatMap DataEncode.bitstringEncode else [] from
    fun d => dartRule_correct owner d]
  rw [← representative_entries, List.flatMap_assoc]
  simpa only [representativeList, decide_eq_true_eq] using
    (filter_flatMap (fun d : Dart n => decide (IsRep d))
      (fun d => (dartRows owner d).flatMap DataEncode.bitstringEncode) (dartList n)).symm

private theorem encode_list {A : Type} [DataEncode A] (l : List A) :
    DataEncode.bitstringEncode l = false :: l.flatMap DataEncode.bitstringEncode ++ [true] := by
  rw [DataEncode.bitstringEncode_def,
    show DataEncode.encode l = Data.l (l.map DataEncode.encode) from rfl, Data.toBits_l]
  simp only [List.flatMap_def, List.map_map, DataEncode.bitstringEncode_def, Function.comp_def]

theorem dartClock_context (owner n : Nat) : dartClock (context owner n) = u (n*D*3) := by
  simp [dartClock, context, marks_eq, mulC, u, unary, Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]
/-- Same cloudFn as FP, exact full ordered DATA output with one outer bracket. -/
theorem cloudFn_correct (owner n : Nat) :
    cloudFn (context owner n) =
      DataEncode.bitstringEncode ((ActualEqualityCloud.rows n).map (localRowCode owner)) := by
  rw [cloudFn, listEncFn_eq, pairSnd_pair, pairFst_pair, dartClock_context]
  simp only [u, unary, List.length_replicate]
  rw [entryCat_correct, encode_list]
theorem cloudFn_empty (owner : Nat) : cloudFn (context owner 0) =
    DataEncode.bitstringEncode ([] : List RowCode) := by
  rw [cloudFn_correct, ActualEqualityCloud.rows_zero, List.map_nil]

theorem localCode_tag {N m : Nat} (I : ActualOccurrenceAllocation.Instance N m)
    (v : Fin N) (x : ActualEqualityCloud.GlobalVar (I.size v)) :
    localCode v.val x = codeVar I (I.tag v x) := by cases x <;> rfl
theorem localRowCode_tag {N m : Nat} (I : ActualOccurrenceAllocation.Instance N m)
    (v : Fin N) (q : (Fin 3 → ActualEqualityCloud.GlobalVar (I.size v)) × ZMod 2) :
    localRowCode v.val q = codeRow I (I.tagRow v q) := by
  simp only [localRowCode, codeRow, ActualOccurrenceAllocation.Instance.tagRow,
    Function.comp_def, localCode_tag]
/-- Direct bridge to the archived structural code; all row occurrences remain. -/
theorem cloudFn_instance {N m : Nat} (I : ActualOccurrenceAllocation.Instance N m) (v : Fin N) :
    cloudFn (context v.val (I.size v)) = DataEncode.bitstringEncode
      ((ActualEqualityCloud.rows (I.size v)).map (fun q => codeRow I (I.tagRow v q))) := by
  rw [cloudFn_correct]
  apply congrArg DataEncode.bitstringEncode
  apply List.map_congr_left
  intro q _
  exact localRowCode_tag I v q

end
end PvNP.RealizableHardness.ActualGadgetRowProducer
