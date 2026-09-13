import PvNP.RealizableHardness.ActualGadgetRowProducer
import PvNP.RealizableHardness.ActualSourceWireBridge

/-! Archival source-only compact constructor composition. All imported draft
proofs require their own acceptance. This emits the existing finite rows in
order; it does not establish upstream source hardness or a learning theorem. -/
namespace PvNP.RealizableHardness.ActualRegularizedSourceProducer
open Complexity ActualOccurrenceAllocation ActualOccurrenceLookup ActualOccurrenceCode
open ActualSourceNormalization (Source Valid)
open ActualSourceFiniteBridge (instanceOf)
set_option autoImplicit false
noncomputable section

/-- One outer DATA list wrapper, never a machine argument pair. -/
def wrap (entries : List Bool) : List Bool := false :: entries ++ [true]

theorem wrap_mem_FP {f : List Bool -> List Bool} (hf : Membership.mem FP f) :
    Membership.mem FP (fun z => wrap (f z)) := by
  exact Cobham.appendFn_mem_FP (mem_FP_comp hf (Cobham.cons_mem_FP false))
    (constFn_mem_FP [true])

theorem encode_list {A : Type} [DataEncode A] (l : List A) :
    DataEncode.bitstringEncode l = wrap (l.flatMap DataEncode.bitstringEncode) := by
  rw [DataEncode.bitstringEncode_def,
    show DataEncode.encode l = Data.l (l.map DataEncode.encode) from rfl, Data.toBits_l]
  simp only [wrap, List.flatMap_def, List.map_map,
    DataEncode.bitstringEncode_def, Function.comp_def]

theorem inner_encode {A : Type} [DataEncode A] (l : List A) :
    posInner (DataEncode.bitstringEncode l) = l.flatMap DataEncode.bitstringEncode := by
  rw [posInner_bitstringEncode]
  simp only [List.flatMap_def, List.map_map, DataEncode.bitstringEncode_def, Function.comp_def]

def joinLists (a b : List Bool) : List Bool := wrap (posInner a ++ posInner b)

theorem joinLists_mem_FP {a b : List Bool -> List Bool}
    (ha : Membership.mem FP a) (hb : Membership.mem FP b) :
    Membership.mem FP (fun z => joinLists (a z) (b z)) :=
  wrap_mem_FP (Cobham.appendFn_mem_FP (posInner_mem_FP ha) (posInner_mem_FP hb))

theorem joinLists_encode {A : Type} [DataEncode A] (a b : List A) :
    joinLists (DataEncode.bitstringEncode a) (DataEncode.bitstringEncode b) =
      DataEncode.bitstringEncode (a ++ b) := by
  rw [joinLists, inner_encode, inner_encode, encode_list, List.flatMap_append]

/-- Variable-output rule: strip each cloud's outer list brackets. -/
def ownerRule (z : List Bool) : List Bool :=
  posInner (ActualGadgetRowProducer.ownerCloudFn z)

theorem ownerRule_mem_FP : Membership.mem FP ownerRule :=
  posInner_mem_FP ActualGadgetRowProducer.ownerCloudFn_mem_FP

def cloudCodes {N m : Nat} (I : Instance N m) : List RowCode :=
  (List.finRange N).flatMap (fun v =>
    (ActualEqualityCloud.rows (I.size v)).map (fun q => codeRow I (I.tagRow v q)))

theorem ownerRule_correct {N m : Nat} (I : Instance N m) (v : Fin N) :
    ownerRule (lookupInput (serializedSource I) v.val) =
      ((ActualEqualityCloud.rows (I.size v)).map
        (fun q => codeRow I (I.tagRow v q))).flatMap DataEncode.bitstringEncode := by
  rw [ownerRule, ActualGadgetRowProducer.ownerCloudFn_correct, inner_encode]

private theorem finRange_map_value {A : Type} (n : Nat) (f : Nat -> A) :
    (List.finRange n).map (fun v => f v.val) = (List.range n).map f := by
  apply List.ext_getElem (by simp)
  intro i hi hj
  simp

/-- The loop order is increasing finite owner value, including unused owners. -/
theorem owner_entries {N m : Nat} (I : Instance N m) :
    entryCat ownerRule (serializedSource I) N =
      (cloudCodes I).flatMap DataEncode.bitstringEncode := by
  have he := congrArg List.flatten (finRange_map_value N
    (fun v => ownerRule (pair (serializedSource I) (List.replicate v true))))
  rw [entryCat, <- he]
  change (List.finRange N).flatMap (fun v =>
    ownerRule (lookupInput (serializedSource I) v.val)) = _
  simp_rw [ownerRule_correct]
  simp only [cloudCodes, List.flatMap_assoc]

/-- Compact normalization uses carrier Fin(3m); derive that clock from the table. -/
def ownerClock (T : List Bool) : List Bool := marks (mulC 3 (posCount T))

theorem ownerClock_mem_FP : Membership.mem FP ownerClock :=
  marks_mem_FP (mulC_mem_FP (posCount_mem_FP id_mem_FP) 3)

theorem ownerClock_correct {m : Nat} (I : Instance (3*m) m) :
    ownerClock (serializedSource I) = List.replicate (3*m) true := by
  simp [ownerClock, serializedSource, posCount_eq, sourceTriples_length, marks_eq,
    mulC, Nat.mul_comm]

/-- listEncFn accepts variable-size entries; it adds exactly one list wrapper. -/
def cloudsFn (T : List Bool) : List Bool :=
  listEncFn ownerRule (pair (ownerClock T) T)

theorem cloudsFn_mem_FP : Membership.mem FP cloudsFn := by
  unfold cloudsFn
  simpa only [Function.comp_def, id_eq] using
    mem_FP_comp (Cobham.pairFn_mem_FP ownerClock_mem_FP id_mem_FP)
      (materialize_mem_FP ownerRule_mem_FP)

theorem cloudsFn_correct {m : Nat} (I : Instance (3*m) m) :
    cloudsFn (serializedSource I) = DataEncode.bitstringEncode (cloudCodes I) := by
  rw [cloudsFn, listEncFn_eq, pairFst_pair, pairSnd_pair, ownerClock_correct]
  simp only [List.length_replicate]
  rw [owner_entries, encode_list]
  rfl

def normalizedTableFn (z : List Bool) : List Bool :=
  fstEnc (ActualSourceNormalizedTable.sourceFn z)

theorem normalizedTableFn_mem_FP : Membership.mem FP normalizedTableFn :=
  fstEnc_mem_FP ActualSourceNormalizedTable.sourceFn_mem_FP

theorem normalizedTableFn_correct (S : Source) (h : Valid S) :
    normalizedTableFn (ActualSourceNormalization.wire S) =
      serializedSource (instanceOf S h) := by
  rw [normalizedTableFn, ActualSourceWireBridge.sourceFn_eq_finite_wire S h]
  exact ActualOriginalRowProducer.wire_table (instanceOf S h)

def cloudsFromSourceFn (z : List Bool) : List Bool := cloudsFn (normalizedTableFn z)

theorem cloudsFromSourceFn_mem_FP : Membership.mem FP cloudsFromSourceFn := by
  unfold cloudsFromSourceFn
  simpa only [Function.comp_def, id_eq] using
    mem_FP_comp normalizedTableFn_mem_FP cloudsFn_mem_FP

theorem cloudsFromSourceFn_correct (S : Source) (h : Valid S) :
    cloudsFromSourceFn (ActualSourceNormalization.wire S) =
      DataEncode.bitstringEncode (cloudCodes (instanceOf S h)) := by
  rw [cloudsFromSourceFn, normalizedTableFn_correct S h]
  exact cloudsFn_correct (instanceOf S h)

theorem rows_code_split {N m : Nat} (I : Instance N m) :
    I.rows.map (codeRow I) = I.originalRows.map (codeRow I) ++ cloudCodes I := by
  simp only [Instance.rows, List.map_append, List.map_flatMap,
    List.map_map, Function.comp_def, cloudCodes]

/-- Same concrete total raw constructor in both FP and full output identity. -/
def constructorFn (z : List Bool) : List Bool :=
  joinLists (ActualSourceWireBridge.originalRowsFromSourceFn z) (cloudsFromSourceFn z)

theorem constructorFn_mem_FP : Membership.mem FP constructorFn :=
  joinLists_mem_FP ActualSourceWireBridge.originalRowsFromSourceFn_mem_FP
    cloudsFromSourceFn_mem_FP

theorem constructorFn_correct (S : Source) (h : Valid S) :
    constructorFn (ActualSourceNormalization.wire S) =
      DataEncode.bitstringEncode ((instanceOf S h).rows.map (codeRow (instanceOf S h))) := by
  rw [constructorFn, ActualSourceWireBridge.originalRowsFromSourceFn_correct S h,
    cloudsFromSourceFn_correct S h, joinLists_encode, rows_code_split]

theorem constructorFn_output_polynomial :
    Exists (fun p : Polynomial Nat => forall z : List Bool,
      (constructorFn z).length <= p.eval z.length) :=
  Cobham.output_length_poly_of_mem_FP constructorFn_mem_FP

/-- The emitted structure is exactly the existing semantic code list. -/
theorem constructorFn_codeRows (S : Source) (h : Valid S) :
    constructorFn (ActualSourceNormalization.wire S) =
      DataEncode.bitstringEncode (codeRows (instanceOf S h)) := constructorFn_correct S h

/-- Keep the existing assignment semantics on the exact codeRows just emitted. -/
theorem emitted_violations_restrict (S : Source) (h : Valid S) (a : VarCode -> ZMod 2) :
    ActualOccurrenceCode.violations (instanceOf S h) a =
      (instanceOf S h).violations (ActualOccurrenceCode.restrictAssignment (instanceOf S h) a) :=
  ActualOccurrenceCode.violations_restrict (instanceOf S h) a

theorem emitted_violations_extend (S : Source) (h : Valid S)
    (a : (instanceOf S h).GlobalVar -> ZMod 2) :
    ActualOccurrenceCode.violations (instanceOf S h)
      (ActualOccurrenceCode.extendAssignment (instanceOf S h) a) =
        (instanceOf S h).violations a :=
  ActualOccurrenceCode.violations_extend (instanceOf S h) a

theorem emitted_degree_le_four (S : Source) (h : Valid S) (v : VarCode) :
    ActualOccurrenceCode.degree (instanceOf S h) v <= 4 :=
  ActualOccurrenceCode.degree_le_four (instanceOf S h) v

theorem constructorFn_empty :
    constructorFn (ActualSourceNormalization.wire ([],[])) =
      DataEncode.bitstringEncode ([] : List RowCode) := by
  rw [constructorFn_correct ([],[]) (by rfl)]
  simp [Instance.rows, Instance.originalRows]

end
end PvNP.RealizableHardness.ActualRegularizedSourceProducer
