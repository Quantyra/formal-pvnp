import PvNP.RealizableHardness.ExecutableRounding

/-! UNCOMPILED checks. No kernel or executable-result evidence is yet claimed. -/
open PvNP.RealizableHardness
open ExecutableRounding

#print axioms numerators_length
#print axioms outputWeights_length
#print axioms lambda_eq
#print axioms budget_eq
#print axioms repairedAt_eq
#print axioms scale_eq
#print axioms numerators_eq
#print axioms denominator_eq
#print axioms clippedNumerator_eq
#print axioms outputWeights_eq
#print axioms outputBudget_eq
#print axioms outputData_fields
#print axioms original_repairedAt
#print axioms exception_repairedAt
#print axioms denominator_bound
#print axioms positive_integer_data
#print axioms read_fractionTree
#print axioms fractionTree_length
#print axioms read_weightTree
#print axioms read_budgetTree
#print axioms listTree_length_bound
#print axioms arithmetic_wire_bound
#print axioms inverse_le_denominator
#print axioms input_denominator_bound
#print axioms input_arithmetic_wire_bound
#print axioms read_semantic_fields

namespace PvNP.RealizableHardness.ExecutableRoundingChecks

def sample : InputParameters := ⟨1, 0, 1/4, 8⟩
def clipping : InputParameters := ⟨1, 1, 1, 1⟩

example : roundingScale [1] 1 sample = 1024 := by decide
example : numerators [1] 1 sample = [32, 993] := by decide
example : commonDenominator [1] 1 sample = 1025 := by decide
example : outputWeights [1] 1 sample = [32/1025, 993/1025] := by decide
example : outputBudget [1] 1 sample = 34/1025 := by decide

-- This raw input intentionally lies outside the pipeline validity domain.
-- The total arithmetic still clips to the computed denominator.
example : clippedNumerator [1] 1 clipping = 32 := by decide
example : outputBudget [1] 1 clipping = 1 := by decide

-- Empty raw lists are total, but are not advertised as valid CMMSA inputs.
example : outputWeights [] 0 sample = [] := by decide
example : outputBudget [] 0 sample = 0 := by decide

example (ws : List Rat) (M : Nat) (q : InputParameters) (i : Fin M) :
    flatRepairedAt ws M q (finSumFinEquiv (Sum.inr i)) =
      (repairLambda q / (M : Rat)) / (1 + repairLambda q) :=
  exception_repairedAt ws M q i

#eval numerators [1] 1 sample
#eval outputBudget [1] 1 sample
#eval clippedNumerator [1] 1 clipping

end PvNP.RealizableHardness.ExecutableRoundingChecks
