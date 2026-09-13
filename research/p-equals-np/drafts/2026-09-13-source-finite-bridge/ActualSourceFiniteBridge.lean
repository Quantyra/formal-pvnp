import PvNP.RealizableHardness.ActualSourceNormalization
import PvNP.RealizableHardness.ActualOccurrenceCompleteness
import PvNP.RealizableHardness.ActualOccurrenceLookup
import PvNP.RealizableHardness.ActualSourceNormalizedTable

/-! UNCOMPILED isolated bridge draft. Requires the generalized Allocation
Instance with only vars/rhs fields; live restricted Allocation is incompatible.
No new input distinctness or assumed transport/runtime law. -/
namespace PvNP.RealizableHardness.ActualSourceFiniteBridge
open ActualSourceNormalization
set_option autoImplicit false
noncomputable section

def label (t : BinaryTriple) (i : Fin 3) : Nat :=
  if i.val = 0 then t.1 else if i.val = 1 then t.2.1 else t.2.2

theorem normalized_label_lt (S : Source) (r : Fin S.1.length) (i : Fin 3) :
    label (renameTriple S S.1[r.val]) i < 3*S.1.length := by
  have h := normalized_label_bound (S := S) (List.getElem_mem r.isLt)
  fin_cases i <;> simp_all [label]

def «variable» (S : Source) (r : Fin S.1.length) (i : Fin 3) : Fin (3*S.1.length) :=
  Fin.mk (label (renameTriple S S.1[r.val]) i) (normalized_label_lt S r i)

theorem rhsIndex_lt (S : Source) (h : Valid S) (r : Fin S.1.length) : r.val < S.2.length := by
  change S.1.length = S.2.length at h
  rw [<- h]
  exact r.isLt

/-- Actual finite constructor: each normalized first index is a Fin(3m).
No source labels are deduplicated within rows. -/
def instanceOf (S : Source) (h : Valid S) :
    ActualOccurrenceAllocation.Instance (3*S.1.length) S.1.length where
  vars := «variable» S
  rhs := fun r => rhsValue (S.2[r.val]'(rhsIndex_lt S h r))

theorem instance_variable_value (S : Source) (h : Valid S)
    (r : Fin S.1.length) (i : Fin 3) :
    ((instanceOf S h).vars r i).val = label (renameTriple S S.1[r.val]) i := rfl

theorem instance_rhs (S : Source) (h : Valid S) (r : Fin S.1.length) :
    (instanceOf S h).rhs r = rhsValue (S.2[r.val]'(rhsIndex_lt S h r)) := rfl

def restrictAssignment (S : Source) (a : Nat -> ZMod 2) : Fin (3*S.1.length) -> ZMod 2 :=
  fun k => a k.val

def extendAssignment (S : Source) (b : Fin (3*S.1.length) -> ZMod 2) (k : Nat) : ZMod 2 :=
  if hk : k < 3*S.1.length then b (Fin.mk k hk) else 0

theorem restrict_extend (S : Source) (b : Fin (3*S.1.length) -> ZMod 2) :
    restrictAssignment S (extendAssignment S b) = b := by
  funext k
  simp [restrictAssignment, extendAssignment, k.isLt]

/-- Exact ordered flag list, including every original parity summand and RHS. -/
theorem instance_flags_restrict (S : Source) (h : Valid S) (a : Nat -> ZMod 2) :
    (List.finRange S.1.length).map
      ((instanceOf S h).sourceBadRow (restrictAssignment S a)) =
      violationFlags (ActualSourceNormalization.normalize S) a := by
  have hv : S.1.length = S.2.length := h
  apply List.ext_getElem
  case hl => simp [violationFlags, ActualSourceNormalization.normalize, hv]
  case h =>
    intro i hi hj
    have hir : i < S.1.length := by simpa using hi
    have hiy : i < S.2.length := by omega
    simp [violationFlags, ActualSourceNormalization.normalize, ActualOccurrenceAllocation.Instance.sourceBadRow,
      instanceOf, «variable», restrictAssignment, label, rowValue, renameTriple]

theorem instance_violations_restrict (S : Source) (h : Valid S) (a : Nat -> ZMod 2) :
    (instanceOf S h).sourceViolations (restrictAssignment S a) =
      violations (ActualSourceNormalization.normalize S) a := by
  have he := congrArg (fun l : List Bool => l.countP id) (instance_flags_restrict S h a)
  simpa [ActualOccurrenceAllocation.Instance.sourceViolations, violations,
    List.countP_map, Function.comp_def] using he

def liftSourceAssignment (S : Source) (a : Nat -> ZMod 2) : Fin (3*S.1.length) -> ZMod 2 :=
  restrictAssignment S (liftAssignment S a)

def decodeFiniteAssignment (S : Source) (b : Fin (3*S.1.length) -> ZMod 2) : Nat -> ZMod 2 :=
  decodeAssignment S (extendAssignment S b)

theorem instance_flags_lift (S : Source) (h : Valid S) (a : Nat -> ZMod 2) :
    (List.finRange S.1.length).map
      ((instanceOf S h).sourceBadRow (liftSourceAssignment S a)) = violationFlags S a := by
  rw [liftSourceAssignment, instance_flags_restrict, violationFlags_lift]

theorem instance_violations_lift (S : Source) (h : Valid S) (a : Nat -> ZMod 2) :
    (instanceOf S h).sourceViolations (liftSourceAssignment S a) = violations S a := by
  rw [liftSourceAssignment, instance_violations_restrict, violations_lift]

theorem instance_flags_decode (S : Source) (h : Valid S)
    (b : Fin (3*S.1.length) -> ZMod 2) :
    violationFlags S (decodeFiniteAssignment S b) =
      (List.finRange S.1.length).map ((instanceOf S h).sourceBadRow b) := by
  rw [decodeFiniteAssignment, violationFlags_decode,
    <- instance_flags_restrict S h (extendAssignment S b), restrict_extend]

theorem instance_violations_decode (S : Source) (h : Valid S)
    (b : Fin (3*S.1.length) -> ZMod 2) :
    violations S (decodeFiniteAssignment S b) = (instanceOf S h).sourceViolations b := by
  rw [decodeFiniteAssignment, violations_decode,
    <- instance_violations_restrict S h (extendAssignment S b), restrict_extend]

/-- A concrete satisfying/near-satisfying witness, not an existential bridge field. -/
theorem yes_count_transfer (S : Source) (h : Valid S) (k : Nat)
    (a : Nat -> ZMod 2) (ha : violations S a <= k) :
    (instanceOf S h).sourceViolations (liftSourceAssignment S a) <= k := by
  rw [instance_violations_lift]
  exact ha

/-- Universal source promises transfer to every finite assignment via the actual decoder. -/
theorem no_count_transfer (S : Source) (h : Valid S) (delta : Real)
    (hno : forall a : Nat -> ZMod 2,
      delta * (S.1.length : Real) <= (violations S a : Real))
    (b : Fin (3*S.1.length) -> ZMod 2) :
    delta * (S.1.length : Real) <= ((instanceOf S h).sourceViolations b : Real) := by
  rw [<- instance_violations_decode S h b]
  exact hno (decodeFiniteAssignment S b)


/-- Exact row-order equality at the consumer's pre-existing unary-table API. -/
theorem sourceTriples_eq_unaryRows (S : Source) (h : Valid S) :
    ActualOccurrenceLookup.sourceTriples (instanceOf S h) =
      ActualSourceNormalizedTable.unaryRows S := by
  apply List.ext_getElem
  case hl =>
    simp [ActualOccurrenceLookup.sourceTriples, ActualSourceNormalizedTable.unaryRows, ActualSourceNormalization.normalize]
  case h =>
    intro i hi hj
    simp [ActualOccurrenceLookup.sourceTriples, ActualSourceNormalizedTable.unaryRows,
      ActualSourceNormalizedTable.unaryTriple, ActualSourceNormalization.normalize, instanceOf, «variable», label]

theorem serializedSource_eq_unaryRows (S : Source) (h : Valid S) :
    ActualOccurrenceLookup.serializedSource (instanceOf S h) =
      Complexity.DataEncode.bitstringEncode (ActualSourceNormalizedTable.unaryRows S) := by
  unfold ActualOccurrenceLookup.serializedSource
  rw [sourceTriples_eq_unaryRows]

/-- Joins the actual producer output to the actual generalized consumer input.
The imported producer is still a draft until its independent build closes. -/
theorem tableFn_eq_serializedSource (S : Source) (h : Valid S) :
    ActualSourceNormalizedTable.tableFn (ActualCompactSourceLookup.table S) =
      ActualOccurrenceLookup.serializedSource (instanceOf S h) := by
  rw [ActualSourceNormalizedTable.tableFn_correct, serializedSource_eq_unaryRows]

/-- No Fin-zero inhabitant is introduced: the empty constructor has no rows. -/
theorem empty_source_count (b : Fin 0 -> ZMod 2) :
    (instanceOf ([],[]) (by rfl)).sourceViolations b = 0 := by
  simp [ActualOccurrenceAllocation.Instance.sourceViolations]

end
end PvNP.RealizableHardness.ActualSourceFiniteBridge
