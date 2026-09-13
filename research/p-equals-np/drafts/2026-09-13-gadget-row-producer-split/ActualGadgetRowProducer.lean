import PvNP.RealizableHardness.ActualGadgetRowProducerRows
import PvNP.RealizableHardness.ActualOccurrenceCountFP

/-! SOURCE-ONLY packaging split of frozen e9c5c6aa; not compiled or accepted. -/
namespace PvNP.RealizableHardness.ActualGadgetRowProducer
open Complexity ActualGraphEdges ActualOccurrenceCode
set_option autoImplicit false
noncomputable section

private theorem compose {f g : List Bool → List Bool}
    (hf : f ∈ FP) (hg : g ∈ FP) : (fun w => g (f w)) ∈ FP := by
  simpa only [Function.comp_def] using mem_FP_comp hf hg

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
