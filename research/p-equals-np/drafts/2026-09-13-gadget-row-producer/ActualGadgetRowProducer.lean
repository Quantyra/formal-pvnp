import PvNP.RealizableHardness.ActualOccurrenceCode
import PvNP.RealizableHardness.ActualOccurrenceCountFP
import PvNP.RealizableHardness.ExecutablePortRotation
import PvNP.RealizableHardness.ActualSourceNormalizedTable

/-! ARCHIVAL SOURCE CANDIDATE, UNCOMPILED. Per-owner cloud producer only.
The loop emits four encoded rows or no bits at each actual dart. No global
owner flattening, compact-source join, hardness or novelty claim. -/
namespace PvNP.RealizableHardness.ActualGadgetRowProducer
open Complexity ActualGraphEdges ActualOccurrenceCode
set_option autoImplicit false
noncomputable section

abbrev D : Nat := FixedPortCycleFamily.degree
abbrev u := ActualOccurrenceCode.unary
abbrev dp := ActualSourceNormalizedTable.dataPair

/-- Machine context: owner identity followed by the actual occurrence count. -/
def context (owner n : Nat) : List Bool := pair (u owner) (u n)
def ownerWord (w : List Bool) := pairFst (pairFst w)
def sizeWord (w : List Bool) := pairSnd (pairFst w)
def kWord (w : List Bool) := divC D (divC 3 (pairSnd w))
def jWord (w : List Bool) := modC D (divC 3 (pairSnd w))
def iWord (w : List Bool) := modC 3 (pairSnd w)
def reverseWord (w : List Bool) := ExecutablePortRotation.rotationFn
  (pair (sizeWord w) (pair (pair (kWord w) (jWord w)) (iWord w)))
def reverseK (w : List Bool) := pairFst (pairFst (reverseWord w))
def reverseJ (w : List Bool) := pairSnd (pairFst (reverseWord w))
def sourceRank (w : List Bool) := marks (mulC D (kWord w) ++ jWord w)
def targetRank (w : List Bool) := marks (mulC D (reverseK w) ++ reverseJ w)

/-- DATA products, never machine argument pairing. All six fields are retained. -/
def packVar (owner : List Bool) (tag : Bool) (k j i h : List Bool) : List Bool :=
  dp (encUnary owner) (dp (DataEncode.bitstringEncode tag)
    (dp (encUnary k) (dp (encUnary j) (dp (encUnary i) (encUnary h)))))

theorem packVar_eq (owner : List Bool) (tag : Bool) (k j i h : List Bool) :
    packVar owner tag k j i h =
      DataEncode.bitstringEncode ((owner,(tag,(k,(j,(i,h))))) : VarCode) := by
  simp only [packVar, bitstringEncode_prod_eq, encUnary_eq, dp,
    ActualSourceNormalizedTable.dataPair]

def portFn (target : Bool) (w : List Bool) : List Bool :=
  packVar (ownerWord w) false (if target then reverseK w else kWord w)
    (if target then reverseJ w else jWord w) [] []
def internalFn (h : Nat) (w : List Bool) : List Bool :=
  packVar (ownerWord w) true (kWord w) (jWord w) (iWord w) (u h)
def gadgetVarFn (t : EqualityGadget.Var) : List Bool → List Bool :=
  ![portFn false, portFn true, internalFn 0, internalFn 1,
    internalFn 2, internalFn 3, internalFn 4] t
def packRow (a b c : List Bool) : List Bool :=
  dp (dp a (dp b c)) (DataEncode.bitstringEncode false)
def gadgetRowFn (r : EqualityGadget.Row) (w : List Bool) : List Bool :=
  packRow (gadgetVarFn (EqualityGadget.row r 0) w)
    (gadgetVarFn (EqualityGadget.row r 1) w) (gadgetVarFn (EqualityGadget.row r 2) w)
def fourEntries (w : List Bool) : List Bool :=
  gadgetRowFn 0 w ++ gadgetRowFn 1 w ++ gadgetRowFn 2 w ++ gadgetRowFn 3 w
def dartRule (w : List Bool) : List Bool :=
  ifLtLen (sourceRank w) (targetRank w) (fourEntries w) []
def dartClock (z : List Bool) : List Bool := marks (mulC (3*D) (pairSnd z))
def cloudFn (z : List Bool) : List Bool := listEncFn dartRule (pair (dartClock z) z)

private theorem compose {f g : List Bool → List Bool}
    (hf : f ∈ FP) (hg : g ∈ FP) : (fun w => g (f w)) ∈ FP := by
  simpa only [Function.comp_def] using mem_FP_comp hf hg

theorem ownerWord_mem_FP : ownerWord ∈ FP :=
  compose Cobham.fstBlock_mem_FP Cobham.fstBlock_mem_FP
theorem sizeWord_mem_FP : sizeWord ∈ FP :=
  compose Cobham.fstBlock_mem_FP Cobham.sndBlock_mem_FP
theorem kWord_mem_FP : kWord ∈ FP :=
  divC_mem_FP (divC_mem_FP Cobham.sndBlock_mem_FP 3) D
theorem jWord_mem_FP : jWord ∈ FP :=
  modC_mem_FP (divC_mem_FP Cobham.sndBlock_mem_FP 3) D
theorem iWord_mem_FP : iWord ∈ FP := modC_mem_FP Cobham.sndBlock_mem_FP 3
theorem reverseWord_mem_FP : reverseWord ∈ FP :=
  compose (Cobham.pairFn_mem_FP sizeWord_mem_FP
    (Cobham.pairFn_mem_FP (Cobham.pairFn_mem_FP kWord_mem_FP jWord_mem_FP) iWord_mem_FP))
    ExecutablePortRotation.rotationFn_mem_FP
theorem reverseK_mem_FP : reverseK ∈ FP :=
  compose (compose reverseWord_mem_FP Cobham.fstBlock_mem_FP) Cobham.fstBlock_mem_FP
theorem reverseJ_mem_FP : reverseJ ∈ FP :=
  compose (compose reverseWord_mem_FP Cobham.fstBlock_mem_FP) Cobham.sndBlock_mem_FP
theorem sourceRank_mem_FP : sourceRank ∈ FP :=
  marks_mem_FP (Cobham.appendFn_mem_FP (mulC_mem_FP kWord_mem_FP D) jWord_mem_FP)
theorem targetRank_mem_FP : targetRank ∈ FP :=
  marks_mem_FP (Cobham.appendFn_mem_FP (mulC_mem_FP reverseK_mem_FP D) reverseJ_mem_FP)

theorem packVar_mem_FP {a k j i h : List Bool → List Bool} (tag : Bool)
    (ha : a ∈ FP) (hk : k ∈ FP) (hj : j ∈ FP) (hi : i ∈ FP) (hh : h ∈ FP) :
    (fun w => packVar (a w) tag (k w) (j w) (i w) (h w)) ∈ FP := by
  unfold packVar
  apply ActualSourceNormalizedTable.dataPair_mem_FP (encUnary_mem_FP ha)
  apply ActualSourceNormalizedTable.dataPair_mem_FP (constFn_mem_FP _)
  apply ActualSourceNormalizedTable.dataPair_mem_FP (encUnary_mem_FP hk)
  apply ActualSourceNormalizedTable.dataPair_mem_FP (encUnary_mem_FP hj)
  exact ActualSourceNormalizedTable.dataPair_mem_FP (encUnary_mem_FP hi) (encUnary_mem_FP hh)

theorem portFn_mem_FP (target : Bool) : portFn target ∈ FP := by
  cases target
  · exact packVar_mem_FP false ownerWord_mem_FP kWord_mem_FP jWord_mem_FP
      (constFn_mem_FP []) (constFn_mem_FP [])
  · exact packVar_mem_FP false ownerWord_mem_FP reverseK_mem_FP reverseJ_mem_FP
      (constFn_mem_FP []) (constFn_mem_FP [])
theorem internalFn_mem_FP (h : Nat) : internalFn h ∈ FP :=
  packVar_mem_FP true ownerWord_mem_FP kWord_mem_FP jWord_mem_FP iWord_mem_FP (constFn_mem_FP _)
theorem gadgetVarFn_mem_FP (t : EqualityGadget.Var) : gadgetVarFn t ∈ FP := by
  fin_cases t
  · exact portFn_mem_FP false
  · exact portFn_mem_FP true
  · exact internalFn_mem_FP 0
  · exact internalFn_mem_FP 1
  · exact internalFn_mem_FP 2
  · exact internalFn_mem_FP 3
  · exact internalFn_mem_FP 4
theorem gadgetRowFn_mem_FP (r : EqualityGadget.Row) : gadgetRowFn r ∈ FP := by
  unfold gadgetRowFn packRow
  exact ActualSourceNormalizedTable.dataPair_mem_FP
    (ActualSourceNormalizedTable.dataPair_mem_FP (gadgetVarFn_mem_FP _)
      (ActualSourceNormalizedTable.dataPair_mem_FP (gadgetVarFn_mem_FP _) (gadgetVarFn_mem_FP _)))
    (constFn_mem_FP _)
theorem fourEntries_mem_FP : fourEntries ∈ FP :=
  Cobham.appendFn_mem_FP (Cobham.appendFn_mem_FP
    (Cobham.appendFn_mem_FP (gadgetRowFn_mem_FP 0) (gadgetRowFn_mem_FP 1))
    (gadgetRowFn_mem_FP 2)) (gadgetRowFn_mem_FP 3)
theorem dartRule_mem_FP : dartRule ∈ FP :=
  ifLtLen_mem_FP sourceRank_mem_FP targetRank_mem_FP fourEntries_mem_FP (constFn_mem_FP [])
theorem dartClock_mem_FP : dartClock ∈ FP :=
  marks_mem_FP (mulC_mem_FP Cobham.sndBlock_mem_FP (3*D))
/-- FP of the exact total raw producer, with a derived loop-state polynomial. -/
theorem cloudFn_mem_FP : cloudFn ∈ FP :=
  compose (Cobham.pairFn_mem_FP dartClock_mem_FP id_mem_FP)
    (materialize_mem_FP dartRule_mem_FP)
theorem cloudFn_output_polynomial : ∃ p : Polynomial Nat, ∀ z : List Bool,
    (cloudFn z).length ≤ p.eval z.length :=
  Cobham.output_length_poly_of_mem_FP cloudFn_mem_FP

/-- i fastest, then j, then k; this is also the actual source-vertex rank. -/
def dartIndex {n : Nat} (d : Dart n) : Nat := (d.1.1.val*D+d.1.2.val)*3+d.2.val
theorem rank_value {n : Nat} (v : Vertex n) : rank v = v.1.val*D+v.2.val := by
  simp [rank, finProdFinEquiv, ← FixedPortCycleFamily.degree_eq, Nat.mul_comm, Nat.add_comm]

private theorem finRange_map_value {A : Type} (n : Nat) (f : Nat → A) :
    (List.finRange n).map (fun v => f v.val) = (List.range n).map f := by
  apply List.ext_getElem (by simp)
  intro i hi hj
  simp
private theorem finRange_flatMap_value {A : Type} (n : Nat) (f : Nat → List A) :
    (List.finRange n).flatMap (fun v => f v.val) = (List.range n).flatMap f :=
  congrArg List.flatten (finRange_map_value n f)
private theorem range_mul_map {A : Type} (n k : Nat) (f : Nat → A) :
    (List.range (n*k)).map f = (List.range n).flatMap fun v =>
      (List.range k).map fun j => f (v*k+j) := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Nat.succ_mul, List.range_add, List.map_append, ih, List.range_succ,
      List.flatMap_append]
    simp [List.map_map]

private theorem range_mul_flatMap {A : Type} (n k : Nat) (f : Nat → List A) :
    (List.range (n*k)).flatMap f = (List.range n).flatMap fun v =>
      (List.range k).flatMap fun j => f (v*k+j) := by
  have h := congrArg List.flatten (range_mul_map n k f)
  simpa only [List.flatMap_def, List.map_flatten, List.map_map,
    List.flatten_flatten, Function.comp_def] using h

/-- Ordered equality, not a cardinality or permutation assertion. -/
theorem dartList_index (n : Nat) :
    (dartList n).map dartIndex = List.range (n*D*3) := by
  simp only [dartList, List.product, List.map_flatMap, List.map_map,
    List.flatMap_map, List.flatMap_assoc, Function.comp_def, dartIndex]
  simp_rw [finRange_map_value]
  simp_rw [← FixedPortCycleFamily.degree_eq]
  simp_rw [finRange_flatMap_value]
  have h := range_mul_map (n*D) 3 id
  rw [range_mul_flatMap] at h
  simpa only [List.map_id, id_eq] using h.symm

theorem words_at_dart {n : Nat} (owner : Nat) (d : Dart n) :
    let w := pair (context owner n) (u (dartIndex d))
    ownerWord w = u owner ∧ sizeWord w = u n ∧
      kWord w = u d.1.1.val ∧ jWord w = u d.1.2.val ∧ iWord w = u d.2.val := by
  have hj : d.1.2.val < D := by
    simpa only [FixedPortCycleFamily.degree_eq] using d.1.2.isLt
  have hi := d.2.isLt
  have h3 : dartIndex d / 3 = d.1.1.val*D+d.1.2.val := by
    unfold dartIndex
    omega
  have hD : (d.1.1.val*D+d.1.2.val)/D = d.1.1.val := by
    rw [Nat.add_comm, Nat.add_mul_div_right _ _ FixedPortCycleFamily.degree_pos,
      Nat.div_eq_of_lt hj, Nat.zero_add]
  have hm : (d.1.1.val*D+d.1.2.val)%D = d.1.2.val := by
    rw [Nat.add_comm, Nat.add_mul_mod_self_right, Nat.mod_eq_of_lt hj]
  have hmod : dartIndex d % 3 = d.2.val := by unfold dartIndex; omega
  simp [ownerWord, sizeWord, kWord, jWord, iWord, context, u, unary,
    divC_eq FixedPortCycleFamily.degree_pos, divC_eq (by decide : 0<3),
    modC_eq FixedPortCycleFamily.degree_pos, modC_eq (by decide : 0<3), h3, hD, hm, hmod]

theorem reverse_at_dart {n : Nat} (owner : Nat) (d : Dart n) :
    reverseWord (pair (context owner n) (u (dartIndex d))) =
      ExecutablePortRotation.output (reverse d).1.1.val (reverse d).1.2.val (reverse d).2.val := by
  obtain ⟨ho,hn,hk,hj,hi⟩ := words_at_dart owner d
  unfold reverseWord
  rw [hn,hk,hj,hi]
  exact ExecutablePortRotation.rotationFn_agrees n d.1.1 d.1.2 d.2

theorem ranks_at_dart {n : Nat} (owner : Nat) (d : Dart n) :
    let w := pair (context owner n) (u (dartIndex d))
    sourceRank w = u (rank d.1) ∧ targetRank w = u (rank (reverse d).1) := by
  obtain ⟨ho,hn,hk,hj,hi⟩ := words_at_dart owner d
  simp [sourceRank, targetRank, reverseK, reverseJ, reverse_at_dart,
    ExecutablePortRotation.output, hk, hj, marks_eq, mulC, rank_value, u, unary]

/-- A semantic code on a single cloud, with the same owner tag as codeVar. -/
def localCode {n : Nat} (owner : Nat) : ActualEqualityCloud.GlobalVar n → VarCode
  | Sum.inl p => (u owner,(false,(u p.1.val,(u p.2.val,([],[])))))
  | Sum.inr (e,h) => (u owner,(true,(u e.val.1.1.val,
      (u e.val.1.2.val,(u e.val.2.val,u h.val)))))
def localRowCode {n : Nat} (owner : Nat)
    (q : (Fin 3 → ActualEqualityCloud.GlobalVar n) × ZMod 2) : RowCode :=
  ((localCode owner (q.1 0),(localCode owner (q.1 1),localCode owner (q.1 2))),rhsBool q.2)
def dartVars {n : Nat} (owner : Nat) (d : Dart n) : EqualityGadget.Var → VarCode :=
  ![(u owner,(false,(u d.1.1.val,(u d.1.2.val,([],[]))))),
    (u owner,(false,(u (reverse d).1.1.val,(u (reverse d).1.2.val,([],[]))))),
    (u owner,(true,(u d.1.1.val,(u d.1.2.val,(u d.2.val,u 0))))),
    (u owner,(true,(u d.1.1.val,(u d.1.2.val,(u d.2.val,u 1))))),
    (u owner,(true,(u d.1.1.val,(u d.1.2.val,(u d.2.val,u 2))))),
    (u owner,(true,(u d.1.1.val,(u d.1.2.val,(u d.2.val,u 3))))),
    (u owner,(true,(u d.1.1.val,(u d.1.2.val,(u d.2.val,u 4)))))]
def dartRow {n : Nat} (owner : Nat) (d : Dart n) (r : EqualityGadget.Row) : RowCode :=
  ((dartVars owner d (EqualityGadget.row r 0),
    (dartVars owner d (EqualityGadget.row r 1),dartVars owner d (EqualityGadget.row r 2))),false)
def dartRows {n : Nat} (owner : Nat) (d : Dart n) : List RowCode :=
  List.ofFn (dartRow owner d)

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

/-- Optional exact existing-table adapter, still one specified owner at a time. -/
def ownerCloudFn (z : List Bool) : List Bool :=
  cloudFn (pair (pairSnd z) (ActualOccurrenceCountFP.occurrenceCountFn z))
theorem ownerCloudFn_mem_FP : ownerCloudFn ∈ FP :=
  compose (Cobham.pairFn_mem_FP Cobham.sndBlock_mem_FP
    ActualOccurrenceCountFP.occurrenceCountFn_mem_FP) cloudFn_mem_FP
theorem ownerCloudFn_correct {N m : Nat} (I : ActualOccurrenceAllocation.Instance N m) (v : Fin N) :
    ownerCloudFn (ActualOccurrenceLookup.lookupInput (ActualOccurrenceLookup.serializedSource I) v.val) =
      DataEncode.bitstringEncode
        ((ActualEqualityCloud.rows (I.size v)).map (fun q => codeRow I (I.tagRow v q))) := by
  unfold ownerCloudFn
  rw [ActualOccurrenceCountFP.occurrenceCountFn_correct]
  simp only [ActualOccurrenceLookup.lookupInput, pairSnd_pair]
  exact cloudFn_instance I v
theorem ownerCloudFn_output_polynomial : ∃ p : Polynomial Nat, ∀ z : List Bool,
    (ownerCloudFn z).length ≤ p.eval z.length :=
  Cobham.output_length_poly_of_mem_FP ownerCloudFn_mem_FP

theorem context_length (owner n : Nat) : (context owner n).length = 2*owner+2+n := by
  simp [context, u, unary]
theorem dartClock_length (owner n : Nat) :
    (dartClock (context owner n)).length = 3*n*D := by
  rw [dartClock_context]
  simp only [u, unary, List.length_replicate]
  ring
theorem loop_input_length (owner n : Nat) :
    (pair (dartClock (context owner n)) (context owner n)).length =
      6*n*D+2*owner+n+4 := by
  rw [pair_length, dartClock_length, context_length]
  ring
theorem dartRows_length {n : Nat} (owner : Nat) (d : Dart n) :
    (dartRows owner d).length = 4 := by simp [dartRows]

end
end PvNP.RealizableHardness.ActualGadgetRowProducer
