import PvNP.RealizableHardness.ActualDecodeInputFP
import PvNP.RealizableHardness.CMMSACodec

/-!
Interface checks for the packed decodeInput FP tag. `gcdBits_mem_FP`,
`gcdBits_odd_pair`, `readRatTag_mem_FP`, `readRatTag_of_tree`,
`readSignedTag_mem_FP`, `readSignedTag_of_tree`, `readListTag_mem_FP`, and
`readListTag_of_tree` are on the Cobham/semantic surface.
`readFormulaTag`, `readFormulaTag_mem_FP`, and `readFormulaTag_of_pair`
are on the Cobham/semantic surface. `readRowTag`, `readRowTag_mem_FP`, and
`readRowTag_of_pair` pack signed-plus-formula rows. `readRowListTag`,
`readRowListTag_mem_FP`, and `readRowListTag_of_pair` pack
`readList (readRow n)` on `pair n.bits (encode t)`. `decodeInputTag_mem_FP`
remains. This file does not inhabit `hSrcCmmsa` and does not assert
unconditional Theorem 1, Corollary 2, or P vs NP.
-/
namespace PvNP.RealizableHardness.ActualDecodeInputFPChecks
open Complexity
open PvNP.RealizableHardness.ActualDecodeInputFP
open PvNP.RealizableHardness.ExecutablePipelineInput

#check decodeInputTag
#check decodeInputTag_empty
#check decodeInputTag_none
#check decodeInputTag_some
#check gcdBits
#check gcdBits_mem_FP
#check gcdBits_odd_pair
#check readRatTag
#check readRatTag_mem_FP
#check readRatTag_of_tree
#check readSignedTag
#check readSignedTag_mem_FP
#check readSignedTag_of_tree
#check readListTag
#check readListTag_mem_FP
#check readListTag_of_tree
#check readFormulaTag
#check readFormulaTag_mem_FP
#check readFormulaTag_of_pair
#check readRowTag
#check readRowTag_mem_FP
#check readRowTag_of_pair
#check readRowListTag
#check readRowListTag_mem_FP
#check readRowListTag_of_pair

#print axioms decodeInputTag_empty
#print axioms decodeInputTag_none
#print axioms decodeInputTag_some
#print axioms gcdBits_mem_FP
#print axioms gcdBits_odd_pair
#print axioms readRatTag_mem_FP
#print axioms readRatTag_of_tree
#print axioms readSignedTag_mem_FP
#print axioms readSignedTag_of_tree
#print axioms readListTag_mem_FP
#print axioms readListTag_of_tree
#print axioms readFormulaTag_mem_FP
#print axioms readFormulaTag_of_pair
#print axioms readRowTag_mem_FP
#print axioms readRowTag_of_pair
#print axioms readRowListTag_mem_FP
#print axioms readRowListTag_of_pair

example : gcdBits ∈ Complexity.FP := gcdBits_mem_FP

example : readRatTag ∈ Complexity.FP := readRatTag_mem_FP

example : readSignedTag ∈ Complexity.FP := readSignedTag_mem_FP

example : readListTag ∈ Complexity.FP := readListTag_mem_FP

example : readFormulaTag ∈ Complexity.FP := readFormulaTag_mem_FP

example : readRowTag ∈ Complexity.FP := readRowTag_mem_FP

example : readRowListTag ∈ Complexity.FP := readRowListTag_mem_FP

example (n : Nat) :
    readFormulaTag (pair n.bits (CMMSACodec.Tree.encode CMMSACodec.Tree.leaf)) =
      [] := by
  simp [readFormulaTag_of_pair, CMMSACodec.readFormula]

example (n : Nat) :
    readRowTag (pair n.bits (CMMSACodec.Tree.encode CMMSACodec.Tree.leaf)) =
      [] := by
  simp [readRowTag_of_pair, ExecutablePipelineInput.readRow]

example : readRatTag (CMMSACodec.Tree.encode CMMSACodec.Tree.leaf) = [] := by
  simp [readRatTag_of_tree, CMMSACodec.readRat]

example : readSignedTag (CMMSACodec.Tree.encode CMMSACodec.Tree.leaf) = [] := by
  simp [readSignedTag_of_tree, ExecutablePipelineInput.readSigned]

example : readListTag (CMMSACodec.Tree.encode CMMSACodec.Tree.leaf) =
    true :: CMMSACodec.Tree.encode (CMMSACodec.listTree []) := by
  simp [readListTag_of_tree, CMMSACodec.readList, CMMSACodec.listTree]

example (n : Nat) :
    readRowListTag (pair n.bits (CMMSACodec.Tree.encode CMMSACodec.Tree.leaf)) =
      true :: CMMSACodec.Tree.encode (CMMSACodec.listTree []) := by
  simp [readRowListTag_of_pair, CMMSACodec.readList, CMMSACodec.listTree]

example : decodeInputTag [] = [] := decodeInputTag_empty

example : decodeInputTag [true] = [] := by
  have h : decodeInput [true] = none := by
    simp [decodeInput, CMMSACodec.Tree.parse]
  exact decodeInputTag_none [true] h

end PvNP.RealizableHardness.ActualDecodeInputFPChecks
