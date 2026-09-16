import PvNP.RealizableHardness.ActualDecodeInputFP

/-!
Interface checks for the packed decodeInput FP tag. `gcdBits_mem_FP` and
`readRatTag_mem_FP` are on the Cobham surface. `readRatTag_of_tree` and
`decodeInputTag_mem_FP` remain. This file does not inhabit `hSrcCmmsa` and
does not assert unconditional Theorem 1, Corollary 2, or P vs NP.
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
#check readRatTag
#check readRatTag_mem_FP

#print axioms decodeInputTag_empty
#print axioms decodeInputTag_none
#print axioms decodeInputTag_some
#print axioms gcdBits_mem_FP
#print axioms readRatTag_mem_FP

example : gcdBits ∈ Complexity.FP := gcdBits_mem_FP

example : readRatTag ∈ Complexity.FP := readRatTag_mem_FP

example : decodeInputTag [] = [] := decodeInputTag_empty

example : decodeInputTag [true] = [] := by
  have h : decodeInput [true] = none := by
    simp [decodeInput, CMMSACodec.Tree.parse]
  exact decodeInputTag_none [true] h

end PvNP.RealizableHardness.ActualDecodeInputFPChecks
