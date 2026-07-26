import PvNP.CNFResolution

/-!
# Elementary UNCONDITIONAL resolution lower bounds (no imported premise)

Everything else in the resolution lane reduces an exponential size lower bound to an imported
combinatorial premise (`ResolutionFamilyTraceLineLowerBoundPremise`, i.e. the Ben-Sasson–Wigderson /
Urquhart expansion-width core). This file records the FIRST genuinely unconditional lower bounds in
the lane: proven directly from the `ResolutionDerivTree` model with no premise. They are elementary
(constant), NOT the exponential family bound — that remains a formalization backlog (see the M-B6
status memo). Scope: a lower bound for the *resolution proof system*, NOT an NP/circuit lower bound
and NOT P != NP.
-/

namespace PvNP
namespace CNFResolution
open CNFModel

/-- Any tree-resolution refutation of a CNF that does not already contain the empty clause must
use at least one resolution step, so its size is at least `3` (one `resolve` node over two
subtrees of size `>= 1` each). Unconditional: no imported premise. -/
theorem resolutionRefutationSize_ge_three {n : Nat} {phi : CNF n}
    (hno_empty : ¬ ([] : Clause n) ∈ phi)
    (r : ResolutionRefutation phi) :
    3 <= ResolutionRefutationSize r := by
  obtain ⟨tree, hvalid, hempty⟩ := r
  show 3 <= ResolutionDerivTree.size tree
  cases tree with
  | hyp c =>
      exfalso
      -- `conclusion (hyp c)` is definitionally `c`, so `hempty : c = []`;
      -- `Valid phi (hyp c)` is definitionally `c ∈ phi`.
      have hc : c = [] := hempty
      subst hc
      exact hno_empty hvalid
  | resolve pivot left right =>
      simp only [ResolutionDerivTree.size]
      have hl := ResolutionDerivTree.size_pos left
      have hr := ResolutionDerivTree.size_pos right
      omega

/-- A concrete unsatisfiable family with no empty clause: the one-variable contradiction
`{x, ¬x}`. -/
def oneVarContradiction : CNF 1 := [[posLit 0], [negLit 0]]

theorem oneVarContradiction_no_empty :
    ¬ ([] : Clause 1) ∈ oneVarContradiction := by
  intro h
  simp only [oneVarContradiction, List.mem_cons, List.not_mem_nil, or_false] at h
  rcases h with h | h <;> exact absurd h (by simp)

/-- Concrete unconditional lower bound: every resolution refutation of the one-variable
contradiction has size at least `3`. No imported premise. -/
theorem resolutionRefutationSize_oneVarContradiction_ge_three
    (r : ResolutionRefutation oneVarContradiction) :
    3 <= ResolutionRefutationSize r :=
  resolutionRefutationSize_ge_three oneVarContradiction_no_empty r

end CNFResolution
end PvNP
