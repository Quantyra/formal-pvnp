import PvNP.RealizableHardness.ActualStarQuestionSupport

namespace PvNP.RealizableHardness.ActualStarQuestionSupportChecks
open PvNP.RealizableHardness.ActualStarQuestionSupport
open scoped BigOperators

def oneRows : Bool → Finset (Fin 4)
  | false => {0, 1, 2}
  | true => {2, 3}

def disjointRows : Bool → Finset (Fin 4)
  | false => {0, 1}
  | true => {2, 3}

def badRows (e : Fin 3) : Finset (Fin 3) :=
  if e = 0 then {0} else if e = 1 then {1} else {0, 1}

example (row : Bool → Finset (Fin 4)) :
    questionSupport row ∅ = ∅ ∧ GoodQuestion row ∅ ∧
    ∀ e, ((row e) ∩ questionSupport row ∅).card = 0 := by
  simp [questionSupport, GoodQuestion]

example :
    (∀ e f, e ≠ f → ((oneRows e) ∩ (oneRows f)).card ≤ 1) ∧
    GoodQuestion oneRows {false} ∧
    true ∉ ({false} : Finset Bool) ∧
    oneRows true ∩ questionSupport oneRows {false} = {2} ∧
    (oneRows true ∩ questionSupport oneRows {false}).card = 1 := by
  unfold GoodQuestion questionSupport oneRows Set.Pairwise
  decide

example :
    (∀ e f, e ≠ f → ((disjointRows e) ∩ (disjointRows f)).card ≤ 1) ∧
    GoodQuestion disjointRows {false} ∧
    true ∉ ({false} : Finset Bool) ∧
    disjointRows true ∩ questionSupport disjointRows {false} = ∅ ∧
    (disjointRows true ∩ questionSupport disjointRows {false}).card = 0 := by
  unfold GoodQuestion questionSupport disjointRows Set.Pairwise
  decide

example :
    (∀ e f, e ≠ f → ((badRows e) ∩ (badRows f)).card ≤ 1) ∧
    (({0, 1} : Finset (Fin 3)) : Set (Fin 3)).Pairwise
      (fun e f => Disjoint (badRows e) (badRows f)) ∧
    (2 : Fin 3) ∉ ({0, 1} : Finset (Fin 3)) ∧
    ¬ GoodQuestion badRows {0, 1} ∧
    (badRows 2 ∩ questionSupport badRows {0, 1}).card = 2 := by
  unfold GoodQuestion questionSupport badRows Set.Pairwise
  decide

#print axioms PvNP.RealizableHardness.ActualStarQuestionSupport.excluded_row_points_eq
#print axioms PvNP.RealizableHardness.ActualStarQuestionSupport.excluded_row_overlap_le_one
#check PvNP.RealizableHardness.ActualStarQuestionSupport.excluded_row_points_eq
#check PvNP.RealizableHardness.ActualStarQuestionSupport.excluded_row_overlap_le_one

end PvNP.RealizableHardness.ActualStarQuestionSupportChecks
