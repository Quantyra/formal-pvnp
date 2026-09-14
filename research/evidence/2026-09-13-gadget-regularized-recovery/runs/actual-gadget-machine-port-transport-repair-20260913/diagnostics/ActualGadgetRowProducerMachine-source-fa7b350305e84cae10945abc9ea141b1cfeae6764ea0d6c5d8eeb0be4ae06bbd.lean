import PvNP.RealizableHardness.ActualOccurrenceCode
import PvNP.RealizableHardness.ExecutablePortRotation
import PvNP.RealizableHardness.ActualSourceNormalizedTable

/-! SOURCE-ONLY packaging split of frozen e9c5c6aa; not compiled or accepted. -/
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
  compose (f := pairFst) (g := pairFst)
    Cobham.fstBlock_mem_FP Cobham.fstBlock_mem_FP
theorem sizeWord_mem_FP : sizeWord ∈ FP :=
  compose (f := pairFst) (g := pairSnd)
    Cobham.fstBlock_mem_FP Cobham.sndBlock_mem_FP
theorem kWord_mem_FP : kWord ∈ FP :=
  divC_mem_FP (divC_mem_FP Cobham.sndBlock_mem_FP 3) D
theorem jWord_mem_FP : jWord ∈ FP :=
  modC_mem_FP (divC_mem_FP Cobham.sndBlock_mem_FP 3) D
theorem iWord_mem_FP : iWord ∈ FP := modC_mem_FP Cobham.sndBlock_mem_FP 3
theorem reverseWord_mem_FP : reverseWord ∈ FP :=
  compose
    (f := fun w => pair (sizeWord w) (pair (pair (kWord w) (jWord w)) (iWord w)))
    (g := ExecutablePortRotation.rotationFn)
    (Cobham.pairFn_mem_FP sizeWord_mem_FP
    (Cobham.pairFn_mem_FP (Cobham.pairFn_mem_FP kWord_mem_FP jWord_mem_FP) iWord_mem_FP))
    ExecutablePortRotation.rotationFn_mem_FP
theorem reverseK_mem_FP : reverseK ∈ FP :=
  compose (f := fun w => pairFst (reverseWord w)) (g := pairFst)
    (compose (f := reverseWord) (g := pairFst)
      reverseWord_mem_FP Cobham.fstBlock_mem_FP) Cobham.fstBlock_mem_FP
theorem reverseJ_mem_FP : reverseJ ∈ FP :=
  compose (f := fun w => pairFst (reverseWord w)) (g := pairSnd)
    (compose (f := reverseWord) (g := pairFst)
      reverseWord_mem_FP Cobham.fstBlock_mem_FP) Cobham.sndBlock_mem_FP
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
  · have h : Membership.mem FP
        (fun w => packVar (ownerWord w) false (reverseK w) (reverseJ w) [] []) :=
      packVar_mem_FP
        (a := ownerWord) (k := reverseK) (j := reverseJ)
        (i := fun _ => []) (h := fun _ => [])
        false ownerWord_mem_FP reverseK_mem_FP reverseJ_mem_FP
        (constFn_mem_FP []) (constFn_mem_FP [])
    have heq : portFn true =
        (fun w => packVar (ownerWord w) false (reverseK w) (reverseJ w) [] []) := by
      rfl
    exact heq.symm ▸ h
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
  compose (f := fun z => pair (dartClock z) z) (g := listEncFn dartRule)
    (Cobham.pairFn_mem_FP dartClock_mem_FP id_mem_FP)
    (materialize_mem_FP dartRule_mem_FP)
theorem cloudFn_output_polynomial : ∃ p : Polynomial Nat, ∀ z : List Bool,
    (cloudFn z).length ≤ p.eval z.length :=
  Cobham.output_length_poly_of_mem_FP cloudFn_mem_FP

end
end PvNP.RealizableHardness.ActualGadgetRowProducer
