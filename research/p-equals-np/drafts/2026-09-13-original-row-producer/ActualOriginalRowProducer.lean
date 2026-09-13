import PvNP.RealizableHardness.ActualOccurrenceCode
import PvNP.RealizableHardness.ActualOccurrenceScan
import PvNP.RealizableHardness.ActualSourceNormalizedTable

/-! Archival source-only draft. Requires the separately supplied Code and
NormalizedTable modules. Emits original rows only, not cloud/gadget rows. -/
namespace PvNP.RealizableHardness.ActualOriginalRowProducer
open Complexity ActualOccurrenceAllocation ActualOccurrenceLookup
  ActualOccurrencePrefix ActualOccurrenceScan ActualOccurrenceCode
open ActualSourceNormalizedTable (dataPair dataPair_mem_FP slotArg slotArg_mem_FP slotArg_correct)
set_option autoImplicit false
noncomputable section

/-- Data product brackets for already encoded subtrees. -/
theorem dataPair_encode {A B : Type} [DataEncode A] [DataEncode B] (a : A) (b : B) :
    dataPair (DataEncode.bitstringEncode a) (DataEncode.bitstringEncode b) =
      DataEncode.bitstringEncode (a,b) :=
  (bitstringEncode_prod_eq a b).symm

/-- A port has j=0 and empty dart/internal fields. -/
def portTail : List Bool := DataEncode.bitstringEncode (([] : U), (([] : U), ([] : U)))

/-- Input: the existing machine pair of unary owner table and unary slot. -/
def anchorCodeFn (z : List Bool) : List Bool :=
  dataPair (encUnary (ownerLookup z))
    (dataPair (DataEncode.bitstringEncode false)
      (dataPair (encUnary (ordinalScan z)) portTail))

theorem anchorCodeFn_mem_FP : Membership.mem FP anchorCodeFn := by
  exact dataPair_mem_FP (encUnary_mem_FP ownerLookup_mem_FP)
    (dataPair_mem_FP (constFn_mem_FP (DataEncode.bitstringEncode false))
      (dataPair_mem_FP (encUnary_mem_FP ordinalScan_mem_FP) (constFn_mem_FP portTail)))

theorem anchorCodeFn_correct {N m : Nat} (I : Instance N m) (o : Slot m) :
    anchorCodeFn (lookupInput (serializedSource I) (rank o)) =
      DataEncode.bitstringEncode (codeVar I (I.anchor o)) := by
  unfold anchorCodeFn
  rw [ownerLookup_rank, ordinalScan_correct, encUnary_eq, encUnary_eq]
  simp only [portTail, dataPair_encode]
  rfl

/-- Canonical RHS list, in exactly the same Fin row order as originalRows. -/
def rhsList {N m : Nat} (I : Instance N m) : List Bool :=
  List.ofFn (fun r : Fin m => rhsBool (I.rhs r))

/-- Structural DATA product; rowRule uses machine pairs only for arguments. -/
def wire {N m : Nat} (I : Instance N m) : List Bool :=
  DataEncode.bitstringEncode (sourceTriples I, rhsList I)

theorem wire_table {N m : Nat} (I : Instance N m) :
    fstEnc (wire I) = serializedSource I := fstEnc_eq _ _

theorem wire_rhs {N m : Nat} (I : Instance N m) :
    sndEnc (wire I) = DataEncode.bitstringEncode (rhsList I) := sndEnc_eq _ _

/-- rowRule argument contains the complete wire and current unary row ordinal. -/
def rowTableArg (z : List Bool) : List Bool :=
  pair (fstEnc (pairFst z)) (pairSnd z)

theorem rowTableArg_mem_FP : Membership.mem FP rowTableArg :=
  Cobham.pairFn_mem_FP (fstEnc_mem_FP Cobham.fstBlock_mem_FP) Cobham.sndBlock_mem_FP

def anchorField (i : Nat) (z : List Bool) : List Bool :=
  anchorCodeFn (slotArg i (rowTableArg z))

theorem anchorField_mem_FP (i : Nat) : Membership.mem FP (anchorField i) := by
  unfold anchorField
  simpa only [Function.comp_def, id_eq] using
    mem_FP_comp (mem_FP_comp rowTableArg_mem_FP (slotArg_mem_FP i)) anchorCodeFn_mem_FP

theorem anchorField_correct {N m : Nat} (I : Instance N m) (r : Fin m) (i : Fin 3) :
    anchorField i.val (pair (wire I) (List.replicate r.val true)) =
      DataEncode.bitstringEncode (codeVar I (I.anchor (r,i))) := by
  unfold anchorField rowTableArg
  rw [pairFst_pair, pairSnd_pair, wire_table, slotArg_correct]
  have hrank : 3*r.val+i.val = rank (r,i) := by simp [rank, Nat.mul_comm]
  rw [hrank]
  exact anchorCodeFn_correct I (r,i)

def rhsField (z : List Bool) : List Bool :=
  posAt (sndEnc (pairFst z)) (pairSnd z).length

theorem rhsField_mem_FP : Membership.mem FP rhsField :=
  posAt_mem_FP Cobham.sndBlock_mem_FP (sndEnc_mem_FP Cobham.fstBlock_mem_FP)

theorem rhsField_correct {N m : Nat} (I : Instance N m) (r : Fin m) :
    rhsField (pair (wire I) (List.replicate r.val true)) =
      DataEncode.bitstringEncode (rhsBool (I.rhs r)) := by
  unfold rhsField
  rw [pairFst_pair, pairSnd_pair, List.length_replicate, wire_rhs]
  have hr : r.val < (rhsList I).length := by simpa [rhsList] using r.isLt
  rw [posAt_eq_of_lt hr]
  simp [rhsList]

/-- Encode each VarCode subtree structurally; encTriple would encode the wrong type. -/
def rowRule (z : List Bool) : List Bool :=
  dataPair (dataPair (anchorField 0 z)
    (dataPair (anchorField 1 z) (anchorField 2 z))) (rhsField z)

theorem rowRule_mem_FP : Membership.mem FP rowRule :=
  dataPair_mem_FP (dataPair_mem_FP (anchorField_mem_FP 0)
    (dataPair_mem_FP (anchorField_mem_FP 1) (anchorField_mem_FP 2))) rhsField_mem_FP

theorem rowRule_correct {N m : Nat} (I : Instance N m) (r : Fin m) :
    rowRule (pair (wire I) (List.replicate r.val true)) =
      DataEncode.bitstringEncode (codeRow I (I.originalRow r, I.rhs r)) := by
  unfold rowRule
  have h0 : anchorField 0 (pair (wire I) (List.replicate r.val true)) =
      DataEncode.bitstringEncode (codeVar I (I.anchor (r, (0 : Fin 3)))) :=
    anchorField_correct I r (0 : Fin 3)
  have h1 : anchorField 1 (pair (wire I) (List.replicate r.val true)) =
      DataEncode.bitstringEncode (codeVar I (I.anchor (r, (1 : Fin 3)))) :=
    anchorField_correct I r (1 : Fin 3)
  have h2 : anchorField 2 (pair (wire I) (List.replicate r.val true)) =
      DataEncode.bitstringEncode (codeVar I (I.anchor (r, (2 : Fin 3)))) :=
    anchorField_correct I r (2 : Fin 3)
  rw [h0, h1, h2, rhsField_correct I r]
  simp only [dataPair_encode]
  rfl

/-- Derived from the supplied table; no external size/runtime certificate. -/
def rowClock (z : List Bool) : List Bool := marks (posCount (fstEnc z))

theorem rowClock_mem_FP : Membership.mem FP rowClock :=
  marks_mem_FP (posCount_mem_FP (fstEnc_mem_FP id_mem_FP))

theorem rowClock_correct {N m : Nat} (I : Instance N m) :
    rowClock (wire I) = List.replicate m true := by
  simp [rowClock, wire_table, serializedSource, posCount_eq, sourceTriples, marks_eq]

def originalCodes {N m : Nat} (I : Instance N m) : List RowCode :=
  I.originalRows.map (codeRow I)

theorem originalCodes_length {N m : Nat} (I : Instance N m) :
    (originalCodes I).length = m := by simp [originalCodes, Instance.originalRows]

theorem originalCodes_get {N m : Nat} (I : Instance N m) (r : Fin m) :
    (originalCodes I)[r.val]'(by rw [originalCodes_length]; exact r.isLt) =
      codeRow I (I.originalRow r, I.rhs r) := by
  simp [originalCodes, Instance.originalRows]

/-- Exact total machine function used in both FP and complete-output identity. -/
def originalRowsFn (z : List Bool) : List Bool :=
  listEncFn rowRule (pair (rowClock z) z)

theorem originalRowsFn_mem_FP : Membership.mem FP originalRowsFn := by
  unfold originalRowsFn
  simpa only [Function.comp_def, id_eq] using
    mem_FP_comp (Cobham.pairFn_mem_FP rowClock_mem_FP id_mem_FP)
      (materialize_mem_FP rowRule_mem_FP)

theorem originalRowsFn_correct {N m : Nat} (I : Instance N m) :
    originalRowsFn (wire I) =
      DataEncode.bitstringEncode (I.originalRows.map (codeRow I)) := by
  unfold originalRowsFn
  have hc : rowClock (wire I) = List.replicate (originalCodes I).length true := by
    rw [originalCodes_length, rowClock_correct]
  rw [hc]
  change listEncFn rowRule (pair (List.replicate (originalCodes I).length true) (wire I)) =
    DataEncode.bitstringEncode (originalCodes I)
  apply materialize_eq (originalCodes I) (wire I)
  intro k hk
  have hk' : k < m := by simpa [originalCodes_length] using hk
  rw [originalCodes_get I (Fin.mk k hk')]
  exact rowRule_correct I (Fin.mk k hk')


theorem originalRowsFn_output_polynomial :
    Exists (fun p : Polynomial Nat => forall z : List Bool,
      (originalRowsFn z).length <= p.eval z.length) :=
  Cobham.output_length_poly_of_mem_FP originalRowsFn_mem_FP

end
end PvNP.RealizableHardness.ActualOriginalRowProducer
