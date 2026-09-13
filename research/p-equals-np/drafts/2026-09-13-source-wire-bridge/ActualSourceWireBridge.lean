import PvNP.RealizableHardness.ActualSourceFiniteBridge
import PvNP.RealizableHardness.ActualOriginalRowProducer

/-! Source-only composition draft. FiniteBridge/Code/OriginalRowProducer remain
separate uncompiled dependencies. This joins the complete source wire, including
RHS, and emits only the original-row prefix of the eventual constructor. -/
namespace PvNP.RealizableHardness.ActualSourceWireBridge
open Complexity ActualSourceNormalization
open ActualSourceFiniteBridge (instanceOf instance_rhs rhsIndex_lt sourceTriples_eq_unaryRows)
set_option autoImplicit false
noncomputable section

/-- The two existing Bool interpretations are definitionally the same map. -/
theorem rhsValue_agrees (b : Bool) :
    ActualSourceNormalization.rhsValue b = ActualOccurrenceCode.rhsValue b := rfl

theorem rhsBool_sourceValue (b : Bool) :
    ActualOccurrenceCode.rhsBool (ActualSourceNormalization.rhsValue b) = b := by
  rw [rhsValue_agrees]
  exact ActualOccurrenceCode.rhsBool_rhsValue b

theorem instance_rhs_roundtrip (S : Source) (h : Valid S) (r : Fin S.1.length) :
    ActualOccurrenceCode.rhsBool ((instanceOf S h).rhs r) =
      S.2[r.val]'(rhsIndex_lt S h r) := by
  rw [instance_rhs, rhsBool_sourceValue]

/-- Equality of the full RHS list, not a projection-length assertion. -/
theorem rhsList_instanceOf (S : Source) (h : Valid S) :
    ActualOriginalRowProducer.rhsList (instanceOf S h) = S.2 := by
  apply List.ext_getElem
  case hl => simpa [ActualOriginalRowProducer.rhsList] using h
  case h =>
    intro k hk hj
    have hk' : k < S.1.length := by
      simpa [ActualOriginalRowProducer.rhsList] using hk
    simpa [ActualOriginalRowProducer.rhsList] using
      instance_rhs_roundtrip S h (Fin.mk k hk')

/-- Full DATA pair equality: the table join and the actual RHS roundtrip. -/
theorem finite_wire_eq (S : Source) (h : Valid S) :
    ActualOriginalRowProducer.wire (instanceOf S h) =
      DataEncode.bitstringEncode (ActualSourceNormalizedTable.unarySource S) := by
  unfold ActualOriginalRowProducer.wire
  rw [sourceTriples_eq_unaryRows, rhsList_instanceOf]
  rfl

/-- Concrete compact producer output equals the original-row consumer wire. -/
theorem sourceFn_eq_finite_wire (S : Source) (h : Valid S) :
    ActualSourceNormalizedTable.sourceFn (ActualSourceNormalization.wire S) =
      ActualOriginalRowProducer.wire (instanceOf S h) := by
  rw [ActualSourceNormalizedTable.sourceFn_correct, finite_wire_eq]

/-- Same total raw function in FP and full ordered output correctness. -/
def originalRowsFromSourceFn (z : List Bool) : List Bool :=
  ActualOriginalRowProducer.originalRowsFn (ActualSourceNormalizedTable.sourceFn z)

theorem originalRowsFromSourceFn_mem_FP : Membership.mem FP originalRowsFromSourceFn := by
  unfold originalRowsFromSourceFn
  simpa only [Function.comp_def, id_eq] using
    mem_FP_comp ActualSourceNormalizedTable.sourceFn_mem_FP
      ActualOriginalRowProducer.originalRowsFn_mem_FP

theorem originalRowsFromSourceFn_correct (S : Source) (h : Valid S) :
    originalRowsFromSourceFn (ActualSourceNormalization.wire S) =
      DataEncode.bitstringEncode ((instanceOf S h).originalRows.map
        (ActualOccurrenceCode.codeRow (instanceOf S h))) := by
  unfold originalRowsFromSourceFn
  rw [sourceFn_eq_finite_wire S h]
  exact ActualOriginalRowProducer.originalRowsFn_correct (instanceOf S h)

theorem originalRowsFromSourceFn_output_polynomial :
    Exists (fun p : Polynomial Nat => forall z : List Bool,
      (originalRowsFromSourceFn z).length <= p.eval z.length) :=
  Cobham.output_length_poly_of_mem_FP originalRowsFromSourceFn_mem_FP

end
end PvNP.RealizableHardness.ActualSourceWireBridge
