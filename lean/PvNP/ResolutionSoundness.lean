import PvNP.CNFResolution

/-!
# Resolution soundness for the tree-resolution model

This file proves *soundness* of the existing tree-resolution derivation model in
`PvNP.CNFResolution`: any assignment satisfying all clauses of a CNF `phi` also
satisfies the `conclusion` of any `Valid phi` derivation tree.  The genuine,
reusable payoff is the corollary that a `ResolutionRefutation phi` (a valid tree
deriving the empty clause) witnesses unsatisfiability of `phi`.

Satisfaction predicates used (from `PvNP.CNFModel`):
* `litEval a l = if l.sign then a l.var else !a l.var`
* `clauseSat a c = ∃ l, l ∈ c ∧ litEval a l = true`
* `cnfSat a f = ∀ c, c ∈ f → clauseSat a c`

Resolution operations used (from `PvNP.CNFResolution`):
* `removePivotSign pivot sign c = c.filter (fun l => !(decide (l.var = pivot) && decide (l.sign = sign)))`
* `resolveOn pivot left right = removePivotSign pivot true left ++ removePivotSign pivot false right`
-/

namespace PvNP
namespace CNFResolution

open CNFModel

/-- A literal survives `removePivotSign pivot s` exactly when it is not the
`(var = pivot, sign = s)` literal. -/
theorem mem_removePivotSign_iff {n : Nat} (pivot : Fin n) (s : Bool)
    (c : Clause n) (l : Literal n) :
    l ∈ removePivotSign pivot s c ↔
      l ∈ c ∧ ¬ (l.var = pivot ∧ l.sign = s) := by
  unfold removePivotSign
  rw [List.mem_filter]
  constructor
  · rintro ⟨hmem, hkeep⟩
    refine ⟨hmem, ?_⟩
    intro hcontra
    rcases hcontra with ⟨hvar, hsign⟩
    -- the filter predicate evaluated to true, but with var=pivot ∧ sign=s it is false
    simp [hvar, hsign] at hkeep
  · rintro ⟨hmem, hne⟩
    refine ⟨hmem, ?_⟩
    -- need: !(decide (l.var = pivot) && decide (l.sign = s)) = true
    by_cases hvar : l.var = pivot
    · by_cases hsign : l.sign = s
      · exact absurd ⟨hvar, hsign⟩ hne
      · simp [hvar, hsign]
    · simp [hvar]

/-- A literal whose `litEval` is `true` cannot be the literal removed by
`removePivotSign` on the *opposite* truth value of the pivot.  Concretely, if
`a pivot = true` then no satisfied literal has `(var = pivot, sign = false)`, and
if `a pivot = false` then no satisfied literal has `(var = pivot, sign = true)`. -/
theorem satisfied_lit_survives_removePivotSign {n : Nat} (a : Assignment n)
    (pivot : Fin n) (s : Bool) (l : Literal n)
    (heval : litEval a l = true)
    (hpiv : a pivot = !s) :
    ¬ (l.var = pivot ∧ l.sign = s) := by
  rintro ⟨hvar, hsign⟩
  -- l.var = pivot, l.sign = s ; compute litEval and contradict hpiv
  subst hvar
  subst hsign
  unfold litEval at heval
  -- heval : (if l.sign then a l.var else !a l.var) = true ; hpiv : a l.var = !l.sign
  cases hs : l.sign with
  | false =>
      -- s = false: hpiv : a l.var = !false = true ; heval : !(a l.var) = true
      rw [hs] at heval hpiv
      simp only [if_false, Bool.not_false] at heval hpiv
      rw [hpiv] at heval
      simp at heval
  | true =>
      -- s = true: hpiv : a l.var = !true = false ; heval : a l.var = true
      rw [hs] at heval hpiv
      simp only [if_true, Bool.not_true] at heval hpiv
      rw [hpiv] at heval
      simp at heval

/-- **Resolvent satisfaction (the crux).** If an assignment `a` satisfies the
left clause and the right clause, and `posLit pivot ∈ left`, `negLit pivot ∈
right`, then `a` satisfies `resolveOn pivot left right`. -/
theorem clauseSat_resolveOn {n : Nat} (a : Assignment n) (pivot : Fin n)
    (left right : Clause n)
    (hleft : clauseSat a left) (hright : clauseSat a right) :
    clauseSat a (resolveOn pivot left right) := by
  unfold resolveOn
  -- clauseSat over an append: a satisfied literal in either side works.
  rcases hleft with ⟨lL, hlLmem, hlLeval⟩
  rcases hright with ⟨lR, hlRmem, hlReval⟩
  cases hp : a pivot with
  | true =>
      -- pivot true: the right witness lR is not negLit pivot ((var=pivot, sign=false)),
      -- so it survives removePivotSign pivot false.
      have hsurv : lR.var = pivot ∧ lR.sign = false → False := by
        have := satisfied_lit_survives_removePivotSign a pivot false lR hlReval
          (by rw [hp]; rfl)
        exact this
      refine ⟨lR, ?_, hlReval⟩
      rw [List.mem_append]
      refine Or.inr ?_
      rw [mem_removePivotSign_iff]
      exact ⟨hlRmem, hsurv⟩
  | false =>
      -- pivot false: the left witness lL is not posLit pivot ((var=pivot, sign=true)),
      -- so it survives removePivotSign pivot true.
      have hsurv : lL.var = pivot ∧ lL.sign = true → False := by
        have := satisfied_lit_survives_removePivotSign a pivot true lL hlLeval
          (by rw [hp]; rfl)
        exact this
      refine ⟨lL, ?_, hlLeval⟩
      rw [List.mem_append]
      refine Or.inl ?_
      rw [mem_removePivotSign_iff]
      exact ⟨hlLmem, hsurv⟩

namespace ResolutionDerivTree

/-- **Soundness of tree resolution.** If `a` satisfies every clause of `phi` and
`t` is a `Valid phi` derivation tree, then `a` satisfies `t.conclusion`. -/
theorem resolution_sound {n : Nat} {phi : CNF n} (a : Assignment n)
    (t : ResolutionDerivTree n) (hv : Valid phi t) (hsat : cnfSat a phi) :
    clauseSat a t.conclusion := by
  induction t with
  | hyp c =>
      -- Valid: c ∈ phi ; conclusion = c ; hsat gives clauseSat a c.
      exact hsat c hv
  | resolve pivot left right ihLeft ihRight =>
      rcases hv with ⟨hvl, hvr, _hpos, _hneg⟩
      have hsatL : clauseSat a (conclusion left) := ihLeft hvl
      have hsatR : clauseSat a (conclusion right) := ihRight hvr
      -- conclusion (resolve ...) = resolveOn pivot (conclusion left) (conclusion right)
      show clauseSat a (resolveOn pivot (conclusion left) (conclusion right))
      exact clauseSat_resolveOn a pivot (conclusion left) (conclusion right)
        hsatL hsatR

end ResolutionDerivTree

/-- The empty clause is unsatisfiable in this model: no literal is a member of
`[]`, so `clauseSat a []` is false for every assignment.  This is what makes the
refutation corollary meaningful. -/
theorem not_clauseSat_nil {n : Nat} (a : Assignment n) :
    ¬ clauseSat a ([] : Clause n) := by
  rintro ⟨l, hmem, _⟩
  exact (List.not_mem_nil l) hmem

/-- **Refutation soundness.** A `ResolutionRefutation phi` (a `Valid` tree
deriving the empty clause) witnesses unsatisfiability: there is no assignment
satisfying `phi`. -/
theorem resolutionRefutation_unsat {n : Nat} {phi : CNF n}
    (r : ResolutionRefutation phi) :
    ¬ ∃ a : Assignment n, cnfSat a phi := by
  rintro ⟨a, hsat⟩
  have hconcl : clauseSat a r.tree.conclusion :=
    ResolutionDerivTree.resolution_sound a r.tree r.valid hsat
  rw [r.derives_empty] at hconcl
  exact not_clauseSat_nil a hconcl

/-- Contrapositive packaging: if `phi` is satisfiable then it has no resolution
refutation. -/
theorem not_nonempty_resolutionRefutation_of_sat {n : Nat} {phi : CNF n}
    (hsat : ∃ a : Assignment n, cnfSat a phi) :
    ¬ Nonempty (ResolutionRefutation phi) := by
  rintro ⟨r⟩
  exact resolutionRefutation_unsat r hsat

end CNFResolution
end PvNP
