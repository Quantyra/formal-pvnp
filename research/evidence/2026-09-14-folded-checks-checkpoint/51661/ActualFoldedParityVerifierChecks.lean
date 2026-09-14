import PvNP.RealizableHardness.ActualFoldedParityVerifier

namespace PvNP.RealizableHardness.ActualFoldedParityVerifierChecks
open ActualFoldedParityVerifier
set_option autoImplicit false
noncomputable section

-- Repeated literal positions remain real positions; both selected sets coincide.
def repeatedPhi : CNF := [((0,false),((0,false),(0,false)))]
def repeatedQuestion : Question repeatedPhi 1 := fun _ => (⟨0, by decide⟩,0)

example : smallView repeatedQuestion = [0] := by
  simp [smallView, wideView, repeatedQuestion, repeatedPhi, clauseAt, clauseLabels, literalAt, List.ofFn_succ]
example : wideView repeatedQuestion = [0] := by
  simp [smallView, wideView, repeatedQuestion, repeatedPhi, clauseAt, clauseLabels, literalAt, List.ofFn_succ]
example : smallView repeatedQuestion = wideView repeatedQuestion := by
  simp [smallView, wideView, repeatedQuestion, repeatedPhi, clauseAt, clauseLabels, literalAt, List.ofFn_succ]
example : (assignments 0).length = 1 := by decide
example : (assignments 3).length = 8 := by decide
example : wordNat [false,true,false] = 10 := by decide
example (bs : List Bool) :
    And (2^bs.length <= wordNat bs) (wordNat bs < 2^(bs.length+1)) := wordNat_bounds bs

-- Actual canonical addresses, not just equality of independently assumed queries.
example : foldQuery [0] (fun _ => true) (fun _ => true) =
    some (([0],[false,false]),true) := by decide
example : foldQuery [0] (fun _ => true) (fun _ => false) =
    some (([0],[false,false]),false) := by decide
example : foldQuery [0] (fun _ => false) (fun _ => false) = none := by decide
example : queries repeatedQuestion (fun _ => false) (fun _ => false) (fun _ => false) =
    some ((([0],[false,false]),false),
      ((([0],[false,false]),false),(([0],[false,false]),false))) := by
  dsimp only [queries, foldQuery, firstSat, assignments, mkAddress, canonical, condition, selectedSat, clauseValue, literalValue, noisyThird, restrictLocal, localValue, smallView, wideView, repeatedQuestion, repeatedPhi, clauseAt, clauseLabels, literalAt, List.ofFn_succ]
  simp [queries, foldQuery, firstSat, assignments, mkAddress, canonical, condition, selectedSat, clauseValue, literalValue, noisyThird, restrictLocal, localValue, smallView, wideView, repeatedQuestion, repeatedPhi, clauseAt, clauseLabels, literalAt, List.ofFn_succ]
example : queries repeatedQuestion (fun _ => true) (fun _ => false) (fun _ => true) =
    some ((([0],[false,false]),true),
      ((([0],[false,false]),false),(([0],[false,false]),false))) := by
  dsimp only [queries, foldQuery, firstSat, assignments, mkAddress, canonical, condition, selectedSat, clauseValue, literalValue, noisyThird, restrictLocal, localValue, smallView, wideView, repeatedQuestion, repeatedPhi, clauseAt, clauseLabels, literalAt, List.ofFn_succ]
  simp [queries, foldQuery, firstSat, assignments, mkAddress, canonical, condition, selectedSat, clauseValue, literalValue, noisyThird, restrictLocal, localValue, smallView, wideView, repeatedQuestion, repeatedPhi, clauseAt, clauseLabels, literalAt, List.ofFn_succ]

-- A genuinely empty selected conditioning domain.
def contradictoryPhi : CNF :=
  [((0,false),((0,false),(0,false))), ((0,true),((0,true),(0,true)))]
def contradictoryQuestion : Question contradictoryPhi 2 := fun j => (j,0)
example : queries contradictoryQuestion (fun _ => false) (fun _ => false)
    (fun _ => false) = none := by
  dsimp only [emitRow, contradictoryQuestion, contradictoryPhi, queries, foldQuery, firstSat, assignments, mkAddress, canonical, condition, selectedSat, clauseValue, literalValue, noisyThird, restrictLocal, localValue, smallView, wideView, repeatedQuestion, repeatedPhi, clauseAt, clauseLabels, literalAt, List.ofFn_succ]
  simp [emitRow, contradictoryQuestion, contradictoryPhi, queries, foldQuery, firstSat, assignments, mkAddress, canonical, condition, selectedSat, clauseValue, literalValue, noisyThird, restrictLocal, localValue, smallView, wideView, repeatedQuestion, repeatedPhi, clauseAt, clauseLabels, literalAt, List.ofFn_succ]
example : emitRow contradictoryQuestion (fun _ => false) (fun _ => false)
    (fun _ => false) = none := by
  dsimp only [emitRow, contradictoryQuestion, contradictoryPhi, queries, foldQuery, firstSat, assignments, mkAddress, canonical, condition, selectedSat, clauseValue, literalValue, noisyThird, restrictLocal, localValue, smallView, wideView, repeatedQuestion, repeatedPhi, clauseAt, clauseLabels, literalAt, List.ofFn_succ]
  simp [emitRow, contradictoryQuestion, contradictoryPhi, queries, foldQuery, firstSat, assignments, mkAddress, canonical, condition, selectedSat, clauseValue, literalValue, noisyThird, restrictLocal, localValue, smallView, wideView, repeatedQuestion, repeatedPhi, clauseAt, clauseLabels, literalAt, List.ofFn_succ]

-- The actual ordered emitted row permits three identical addresses and either RHS.
example (a : Address) : rowOfQueries ((a,false),((a,false),(a,false))) =
    ((addressCode a,(addressCode a,addressCode a)),false) := rfl
example (a : Address) : rowOfQueries ((a,true),((a,false),(a,false))) =
    ((addressCode a,(addressCode a,addressCode a)),true) := rfl
example (P : Nat -> Bool) : boolAssignment (bitAssignment P) = P :=
  boolAssignment_bitAssignment P
example (a : Nat -> ZMod 2) : bitAssignment (boolAssignment a) = a :=
  bitAssignment_boolAssignment a
example (r : Row) : ActualSourceNormalization.Valid (rowSource r) := rowSource_valid r

#print axioms wordNat_positive
#print axioms wordNat_injective
#print axioms wordNat_bounds
#print axioms addressCode_injective
#print axioms assignments_complete
#print axioms assignments_length
#print axioms assignments_nodup
#print axioms mkAddress_injective
#print axioms firstSat_sound
#print axioms firstSat_none_iff
#print axioms canonical_pair
#print axioms canonical_complement
#print axioms foldQuery_none_iff
#print axioms foldEval_complement
#print axioms foldQuery_restriction
#print axioms localValue_restrictGlobal
#print axioms honestAddress_mk
#print axioms honestProof_code
#print axioms foldEval_honest
#print axioms literal_label_mem
#print axioms clause_label_mem_wide
#print axioms small_subset_wide
#print axioms smallView_nodup
#print axioms wideView_nodup
#print axioms restrictLocal_honest
#print axioms selectedSat_honest
#print axioms bitAssignment_boolAssignment
#print axioms boolAssignment_bitAssignment
#print axioms rowOfQueries_correct
#print axioms rowOfQueries_correct_GF2
#print axioms emitted_row_correct
#print axioms emitRow_none_iff
#print axioms verifierBit_eq_foldEval
#print axioms verifierBit_honest
#print axioms verifier_accept_iff
#print axioms verifier_accept_iff_GF2
#print axioms rowSource_valid
#check queries
#check emitRow
#check verifierBit_honest
#check verifier_accept_iff_GF2
#check rowWire
end
end PvNP.RealizableHardness.ActualFoldedParityVerifierChecks
