import PvNP.ResolutionSoundness
import PvNP.ResolutionWidthExpansion
import PvNP.TseitinKnConcrete
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Card
import Mathlib.Data.Fintype.Card

/-!
# Resolution refutation-completeness for the tree-resolution model

This file proves **completeness** of the tree-resolution derivation model in
`PvNP.CNFResolution`: every unsatisfiable CNF over `Fin n` has a
`ResolutionRefutation`.  Combined with the soundness corollary
(`resolutionRefutation_unsat`), this makes the K_n Tseitin width lower bound
`tseitinKn_unconditional_refutationWidth_ge` provably **non-vacuous**: the
universally quantified type `ResolutionRefutation (cnf)` is `Nonempty`.

## Proof strategy

The standard textbook proof is by induction on the number of variables, using
restriction.  The model fixes the variable type to `Fin n`, so we induct instead
on a `Finset (Fin n)` of **live variables** `V` that contains every variable
appearing in `F`.  Restriction by a literal `x` (deleting `x`-clauses and the
opposite-polarity `x`-literal elsewhere) drops one variable from the live set,
and a careful combine step resolves the two recursively-obtained refutations on
`x`.

The combine step in this concrete model has a real subtlety: `Valid`/`resolveOn`
require the pivot literal to be *present* in the conclusion.  We handle it by a
clean structural device (`weaken`): a refutation of a restricted formula is
turned into a refutation of the original formula by re-attaching the deleted
`x`-literal at the leaves and tracking how it propagates to the root.

INTEGRITY: no `sorry`/`admit`/new axiom.  Every refutation produced genuinely
satisfies `Valid phi tree ∧ conclusion = []`.
-/

namespace PvNP
namespace CNFResolution
namespace Completeness

open CNFModel
open PvNP.CNFResolution

/-! ## 1. Variables of a clause / CNF, and "live variable set" -/

/-- The set of variables occurring in a clause. -/
def clauseVarSet {n : Nat} (c : Clause n) : Finset (Fin n) :=
  (c.map (·.var)).toFinset

/-- The set of variables occurring anywhere in a CNF. -/
def cnfVarSet {n : Nat} (F : CNF n) : Finset (Fin n) :=
  (F.map clauseVarSet).foldr (· ∪ ·) ∅

theorem mem_cnfVarSet {n : Nat} (F : CNF n) (x : Fin n) :
    x ∈ cnfVarSet F ↔ ∃ c ∈ F, x ∈ clauseVarSet c := by
  unfold cnfVarSet
  induction F with
  | nil => simp
  | cons c cs ih =>
      simp only [List.map_cons, List.foldr_cons, Finset.mem_union, ih]
      constructor
      · rintro (h | ⟨d, hd, hx⟩)
        · exact ⟨c, List.mem_cons_self _ _, h⟩
        · exact ⟨d, List.mem_cons_of_mem _ hd, hx⟩
      · rintro ⟨d, hd, hx⟩
        rcases List.mem_cons.mp hd with rfl | hd'
        · exact Or.inl hx
        · exact Or.inr ⟨d, hd', hx⟩

theorem mem_clauseVarSet {n : Nat} (c : Clause n) (x : Fin n) :
    x ∈ clauseVarSet c ↔ ∃ l ∈ c, l.var = x := by
  unfold clauseVarSet
  rw [List.mem_toFinset, List.mem_map]

/-! ## 2. Restriction by setting a variable -/

/-- The literal on variable `x` with sign `b`. -/
def litOf {n : Nat} (x : Fin n) (b : Bool) : Literal n := { var := x, sign := b }

/-- Restrict a single clause by assigning `x := b`.
* If the clause contains the literal made `true` (sign `b` on `x`), it is
  satisfied: we return `none` (drop it).
* Otherwise we delete every occurrence of the opposite literal (sign `!b`) and
  keep the rest. -/
def restrictClause {n : Nat} (x : Fin n) (b : Bool) (c : Clause n) :
    Option (Clause n) :=
  if c.any (fun l => decide (l.var = x) && decide (l.sign = b)) then none
  else some (c.filter (fun l => !decide (l.var = x)))

/-- Restrict a whole CNF by `x := b`: drop satisfied clauses, shrink the rest. -/
def restrict {n : Nat} (x : Fin n) (b : Bool) (F : CNF n) : CNF n :=
  F.filterMap (restrictClause x b)

theorem mem_restrict {n : Nat} {x : Fin n} {b : Bool} {F : CNF n} {d : Clause n} :
    d ∈ restrict x b F ↔ ∃ c ∈ F, restrictClause x b c = some d := by
  unfold restrict
  rw [List.mem_filterMap]

/-- A restricted clause never contains the variable `x`. -/
theorem restrictClause_no_x {n : Nat} {x : Fin n} {b : Bool} {c d : Clause n}
    (h : restrictClause x b c = some d) {l : Literal n} (hl : l ∈ d) :
    l.var ≠ x := by
  unfold restrictClause at h
  by_cases hany : c.any (fun l => decide (l.var = x) && decide (l.sign = b))
  · rw [if_pos hany] at h; exact absurd h (by simp)
  · rw [if_neg hany] at h
    injection h with hd
    rw [← hd] at hl
    rw [List.mem_filter] at hl
    intro hcontra
    have := hl.2
    simp [hcontra] at this

/-- A member of a restricted clause is a member of the original clause. -/
theorem mem_of_mem_restrictClause {n : Nat} {x : Fin n} {b : Bool} {c d : Clause n}
    (h : restrictClause x b c = some d) {l : Literal n} (hl : l ∈ d) :
    l ∈ c := by
  unfold restrictClause at h
  by_cases hany : c.any (fun l => decide (l.var = x) && decide (l.sign = b))
  · rw [if_pos hany] at h; exact absurd h (by simp)
  · rw [if_neg hany] at h
    injection h with hd
    rw [← hd] at hl
    rw [List.mem_filter] at hl
    exact hl.1

/-! ## 3. Semantics of restriction -/

/-- Update an assignment to send `x` to `b`. -/
def setVar {n : Nat} (a : Assignment n) (x : Fin n) (b : Bool) : Assignment n :=
  fun y => if y = x then b else a y

theorem setVar_self {n : Nat} (a : Assignment n) (x : Fin n) (b : Bool) :
    setVar a x b x = b := by simp [setVar]

theorem setVar_of_ne {n : Nat} (a : Assignment n) (x : Fin n) (b : Bool)
    {y : Fin n} (h : y ≠ x) : setVar a x b y = a y := by simp [setVar, h]

/-- If `a` does not satisfy the restriction `restrict x b F`, then the updated
assignment `setVar a x b` does not satisfy `F`.  (Contrapositive direction we
need for the inductive step: an unsatisfiable `F` yields an unsatisfiable
restriction under any value of `x`.) -/
theorem cnfSat_restrict_of_cnfSat_setVar {n : Nat} (x : Fin n) (b : Bool)
    (F : CNF n) (a : Assignment n)
    (hsat : cnfSat (setVar a x b) F) :
    cnfSat a (restrict x b F) := by
  intro d hd
  rw [mem_restrict] at hd
  obtain ⟨c, hc, hrc⟩ := hd
  have hcsat : clauseSat (setVar a x b) c := hsat c hc
  obtain ⟨l, hlc, hleval⟩ := hcsat
  -- l ∈ c with litEval (setVar a x b) l = true.
  -- The restricted clause d is c with x-literals removed (and c not satisfied by x:=b).
  unfold restrictClause at hrc
  by_cases hany : c.any (fun l => decide (l.var = x) && decide (l.sign = b))
  · -- c is satisfied by x := b, so it was dropped; contradiction with hrc = some d.
    rw [if_pos hany] at hrc; exact absurd hrc (by simp)
  · rw [if_neg hany] at hrc
    injection hrc with hd'
    -- l is not the x-literal with sign b (else hany), so:
    --   if l.var = x then l.sign = !b, but then setVar makes it false; so l.var ≠ x.
    by_cases hlx : l.var = x
    · -- l mentions x. Its eval under setVar a x b uses b. Show it can't be true unless sign b.
      exfalso
      -- if l.sign = b then `hany` would hold.
      have hsignb : l.sign ≠ b := by
        intro hsb
        apply hany
        rw [List.any_eq_true]
        exact ⟨l, hlc, by simp [hlx, hsb]⟩
      -- so l.sign = !b ; litEval (setVar) l = false, contradicting hleval.
      unfold litEval at hleval
      rw [hlx, setVar_self] at hleval
      cases hb : b <;> cases hs : l.sign <;>
        simp_all
    · -- l.var ≠ x, so l survives into d and litEval a l = litEval (setVar a x b) l.
      refine ⟨l, ?_, ?_⟩
      · rw [← hd', List.mem_filter]
        exact ⟨hlc, by simp [hlx]⟩
      · unfold litEval at hleval ⊢
        rw [setVar_of_ne a x b hlx] at hleval
        exact hleval

/-! ## 4. The lift lemma

We lift a derivation over `restrict x b F` to a derivation over `F`.  The only
new literal the lifted conclusion can contain is `litOf x (!b)` (the literal that
was deleted from clauses during restriction).  We track this purely as a
membership invariant, which is robust under the exact-list `resolveOn` semantics.
-/

/-- Every conclusion of a `Valid (restrict x b F)` derivation mentions no `x`. -/
theorem conclusion_no_x_of_valid_restrict {n : Nat} {x : Fin n} {b : Bool}
    {F : CNF n} {T : ResolutionDerivTree n}
    (hv : ResolutionDerivTree.Valid (restrict x b F) T)
    {l : Literal n} (hl : l ∈ T.conclusion) : l.var ≠ x := by
  induction T with
  | hyp c =>
      -- conclusion = c ∈ restrict x b F
      have hc : c ∈ restrict x b F := hv
      rw [mem_restrict] at hc
      obtain ⟨c0, _hc0, hrc⟩ := hc
      exact restrictClause_no_x hrc hl
  | resolve pivot left right ihL ihR =>
      rcases hv with ⟨hvl, hvr, _, _⟩
      -- conclusion = resolveOn pivot (concl left) (concl right)
      have hl' : l ∈ resolveOn pivot left.conclusion right.conclusion := hl
      unfold resolveOn at hl'
      rw [List.mem_append] at hl'
      rcases hl' with hL | hR
      · rw [mem_removePivotSign_iff] at hL
        exact ihL hvl hL.1
      · rw [mem_removePivotSign_iff] at hR
        exact ihR hvr hR.1

/-- **Lift lemma.**  A `Valid (restrict x b F)` derivation tree `T` lifts to a
`Valid F` derivation tree `T'` whose conclusion contains only literals of
`T.conclusion` together with (possibly) `litOf x (!b)`. -/
theorem lift {n : Nat} (x : Fin n) (b : Bool) (F : CNF n) :
    ∀ (T : ResolutionDerivTree n),
      ResolutionDerivTree.Valid (restrict x b F) T →
      ∃ T' : ResolutionDerivTree n,
        ResolutionDerivTree.Valid F T' ∧
        ∀ l ∈ T'.conclusion, l ∈ T.conclusion ∨ l = litOf x (!b) := by
  intro T
  induction T with
  | hyp c =>
      intro hv
      have hc : c ∈ restrict x b F := hv
      rw [mem_restrict] at hc
      obtain ⟨c0, hc0, hrc⟩ := hc
      -- Lift to the original clause c0 ∈ F.
      refine ⟨ResolutionDerivTree.hyp c0, hc0, ?_⟩
      intro l hl
      -- l ∈ c0. Either l ∈ c (= conclusion), or l was the deleted x-literal.
      show l ∈ c ∨ l = litOf x (!b)
      -- restrictClause x b c0 = some c.
      unfold restrictClause at hrc
      by_cases hany : c0.any (fun l => decide (l.var = x) && decide (l.sign = b))
      · rw [if_pos hany] at hrc; exact absurd hrc (by simp)
      · rw [if_neg hany] at hrc
        injection hrc with hc'
        -- c = c0.filter (l.var ≠ x).  l ∈ c0.
        by_cases hlx : l.var = x
        · -- l mentions x; since c0 not satisfied by x:=b, l.sign = !b, so l = litOf x (!b).
          right
          have hsignb : l.sign ≠ b := by
            intro hsb
            apply hany
            rw [List.any_eq_true]
            exact ⟨l, hl, by simp [hlx, hsb]⟩
          -- l.sign = !b
          have : l.sign = !b := by cases hb : b <;> cases hs : l.sign <;> simp_all
          unfold litOf
          cases l with
          | mk lv ls => simp_all
        · left
          rw [← hc', List.mem_filter]
          exact ⟨hl, by simp [hlx]⟩
  | resolve pivot left right ihL ihR =>
      intro hv
      rcases hv with ⟨hvl, hvr, hpos, hneg⟩
      obtain ⟨L', hL'valid, hL'concl⟩ := ihL hvl
      obtain ⟨R', hR'valid, hR'concl⟩ := ihR hvr
      -- pivot ≠ x, since pivot-literals live in restricted conclusions.
      have hpivx : pivot ≠ x := by
        have := conclusion_no_x_of_valid_restrict hvl (l := posLit pivot) hpos
        simpa [posLit] using this
      -- We want a Valid F tree.  We need posLit pivot ∈ L'.conclusion and
      -- negLit pivot ∈ R'.conclusion to resolve.  These may have been the literals
      -- we keep, but they could be absent if L' lost them... they cannot: posLit
      -- pivot ∈ left.conclusion, and L'.conclusion ⊇ ... no, L'concl is one-way.
      -- Instead: build candidate resolve and check membership; if pivot literal
      -- absent in either, fall back to that child.
      rcases Classical.em (posLit pivot ∈ L'.conclusion) with hLmem | hLmem
      · rcases Classical.em (negLit pivot ∈ R'.conclusion) with hRmem | hRmem
        · -- Both present: resolve on pivot.
          refine ⟨ResolutionDerivTree.resolve pivot L' R', ⟨hL'valid, hR'valid, hLmem, hRmem⟩, ?_⟩
          intro l hl
          -- l ∈ resolveOn pivot L'.concl R'.concl
          have hl' : l ∈ resolveOn pivot L'.conclusion R'.conclusion := hl
          unfold resolveOn at hl'
          rw [List.mem_append] at hl'
          -- conclusion of original resolve node:
          show l ∈ resolveOn pivot left.conclusion right.conclusion ∨ l = litOf x (!b)
          rcases hl' with hLf | hRf
          · -- l ∈ removePivotSign pivot true L'.conclusion
            rw [mem_removePivotSign_iff] at hLf
            rcases hL'concl l hLf.1 with hin | heq
            · -- l ∈ left.conclusion, and not (var=pivot ∧ sign=true): survives left side.
              left
              unfold resolveOn
              rw [List.mem_append]
              left
              rw [mem_removePivotSign_iff]
              exact ⟨hin, hLf.2⟩
            · right; exact heq
          · rw [mem_removePivotSign_iff] at hRf
            rcases hR'concl l hRf.1 with hin | heq
            · left
              unfold resolveOn
              rw [List.mem_append]
              right
              rw [mem_removePivotSign_iff]
              exact ⟨hin, hRf.2⟩
            · right; exact heq
        · -- negLit pivot ∉ R'.conclusion: then R' already proves a clause ⊆
          -- {litOf x (!b)} ∪ right.conclusion with the negLit pivot absent.  But
          -- the original resolvent removes negLit pivot from right; so every
          -- surviving literal of the resolvent is covered by R'.  Use R'.
          refine ⟨R', hR'valid, ?_⟩
          intro l hl
          show l ∈ resolveOn pivot left.conclusion right.conclusion ∨ l = litOf x (!b)
          rcases hR'concl l hl with hin | heq
          · -- l ∈ right.conclusion.  Is l removed by removePivotSign pivot false?
            -- It is removed iff l = negLit pivot.  But l ∈ R'.conclusion and
            -- negLit pivot ∉ R'.conclusion, so l ≠ negLit pivot.
            left
            unfold resolveOn
            rw [List.mem_append]; right
            rw [mem_removePivotSign_iff]
            refine ⟨hin, ?_⟩
            rintro ⟨hv1, hv2⟩
            apply hRmem
            have : l = negLit pivot := by
              cases l with | mk lv ls => simp [negLit]; exact ⟨hv1, hv2⟩
            rw [← this]; exact hl
          · right; exact heq
      · -- posLit pivot ∉ L'.conclusion: symmetric, use L'.
        refine ⟨L', hL'valid, ?_⟩
        intro l hl
        show l ∈ resolveOn pivot left.conclusion right.conclusion ∨ l = litOf x (!b)
        rcases hL'concl l hl with hin | heq
        · left
          unfold resolveOn
          rw [List.mem_append]; left
          rw [mem_removePivotSign_iff]
          refine ⟨hin, ?_⟩
          rintro ⟨hv1, hv2⟩
          apply hLmem
          have : l = posLit pivot := by
            cases l with | mk lv ls => simp [posLit]; exact ⟨hv1, hv2⟩
          rw [← this]; exact hl
        · right; exact heq

/-! ## 5. Combine step and the induction -/

/-- A restriction by `x := b` of an unsatisfiable `F` is unsatisfiable. -/
theorem restrict_unsat {n : Nat} (x : Fin n) (b : Bool) {F : CNF n}
    (hF : ¬ ∃ a : Assignment n, cnfSat a F) :
    ¬ ∃ a : Assignment n, cnfSat a (restrict x b F) := by
  rintro ⟨a, ha⟩
  -- If restrict is sat by a, then we want F sat. Use the converse semantics.
  -- Build assignment a' = setVar a x b and show it satisfies F.
  apply hF
  refine ⟨setVar a x b, ?_⟩
  intro c hc
  -- Either c is dropped by restriction (then it is satisfied by x := b) or it
  -- restricts to some d ∈ restrict x b F, satisfied by a.
  by_cases hany : c.any (fun l => decide (l.var = x) && decide (l.sign = b))
  · -- c contains the literal (x, b); setVar makes it true.
    rw [List.any_eq_true] at hany
    obtain ⟨l, hlc, hl⟩ := hany
    rw [Bool.and_eq_true, decide_eq_true_eq, decide_eq_true_eq] at hl
    refine ⟨l, hlc, ?_⟩
    unfold litEval
    rw [hl.1, setVar_self, hl.2]
    cases b <;> rfl
  · -- c restricts to d; d ∈ restrict; a sat d; lift literal to c (x not in d).
    have hrc : restrictClause x b c = some (c.filter (fun l => !decide (l.var = x))) := by
      unfold restrictClause; rw [if_neg hany]
    have hd : (c.filter (fun l => !decide (l.var = x))) ∈ restrict x b F := by
      rw [mem_restrict]; exact ⟨c, hc, hrc⟩
    obtain ⟨l, hld, hleval⟩ := ha _ hd
    refine ⟨l, mem_of_mem_restrictClause hrc hld, ?_⟩
    have hlx : l.var ≠ x := restrictClause_no_x hrc hld
    unfold litEval at hleval ⊢
    rw [setVar_of_ne a x b hlx]
    exact hleval

/-- If every literal of a clause `D` equals `posLit x` and `D` is nonempty, then
`D` resolves with such an all-`negLit x` clause to the empty clause. -/
theorem resolveOn_all_pos_all_neg {n : Nat} (x : Fin n)
    {L R : Clause n}
    (hL : ∀ l ∈ L, l = posLit x) (hR : ∀ l ∈ R, l = negLit x) :
    resolveOn x L R = [] := by
  unfold resolveOn
  rw [List.append_eq_nil]
  constructor
  · -- removePivotSign x true L removes every (var=x, sign=true) literal = posLit x.
    rw [List.eq_nil_iff_forall_not_mem]
    intro l hl
    rw [mem_removePivotSign_iff] at hl
    have := hL l hl.1
    apply hl.2
    rw [this]; exact ⟨rfl, rfl⟩
  · rw [List.eq_nil_iff_forall_not_mem]
    intro l hl
    rw [mem_removePivotSign_iff] at hl
    have := hR l hl.1
    apply hl.2
    rw [this]; exact ⟨rfl, rfl⟩

/-- **General resolution refutation-completeness, parametrised by a live-variable
set.**  If `F` is unsatisfiable and all its variables lie in `V`, then `F` has a
resolution refutation.  Proven by strong induction on `V`. -/
theorem complete_aux {n : Nat} :
    ∀ (V : Finset (Fin n)) (F : CNF n),
      cnfVarSet F ⊆ V →
      (¬ ∃ a : Assignment n, cnfSat a F) →
      Nonempty (ResolutionRefutation F) := by
  intro V
  induction V using Finset.strongInductionOn with
  | _ V ih =>
    intro F hsub hunsat
    by_cases hVempty : V = ∅
    · -- No live variables: every clause is empty; unsat ⟹ [] ∈ F.
      subst hVempty
      -- F must contain the empty clause.
      have hempty_mem : ([] : Clause n) ∈ F := by
        by_contra hno
        -- If F has no empty clause, every clause has a literal, whose var ∈ ∅: impossible
        -- UNLESS F = [], but [] is satisfiable.  Either way contradicts hunsat.
        apply hunsat
        -- exhibit a satisfying assignment (anything) — every clause is nonempty but
        -- then has a variable in cnfVarSet F ⊆ ∅, contradiction; so actually no clause
        -- exists that is empty, and any nonempty clause has a var → contradiction.
        refine ⟨fun _ => true, ?_⟩
        intro c hc
        -- c ≠ [] (else hno). c has a literal l; l.var ∈ cnfVarSet F ⊆ ∅: contradiction.
        cases c with
        | nil => exact absurd hc hno
        | cons l rest =>
            exfalso
            have : l.var ∈ cnfVarSet F := by
              rw [mem_cnfVarSet]
              exact ⟨l :: rest, hc, by rw [mem_clauseVarSet]; exact ⟨l, List.mem_cons_self _ _, rfl⟩⟩
            have := hsub this
            exact absurd this (Finset.not_mem_empty _)
      exact ⟨⟨ResolutionDerivTree.hyp [], hempty_mem, rfl⟩⟩
    · -- Pick a live variable x ∈ V.
      obtain ⟨x, hx⟩ := Finset.nonempty_of_ne_empty hVempty
      -- Restrict both ways.
      have hsub' : ∀ b : Bool, cnfVarSet (restrict x b F) ⊆ V.erase x := by
        intro b y hy
        rw [mem_cnfVarSet] at hy
        obtain ⟨d, hd, hyd⟩ := hy
        rw [mem_restrict] at hd
        obtain ⟨c, hc, hrc⟩ := hd
        rw [mem_clauseVarSet] at hyd
        obtain ⟨l, hld, hlvar⟩ := hyd
        rw [Finset.mem_erase]
        constructor
        · rw [← hlvar]; exact restrictClause_no_x hrc hld
        · apply hsub
          rw [mem_cnfVarSet]
          exact ⟨c, hc, by rw [mem_clauseVarSet]; exact ⟨l, mem_of_mem_restrictClause hrc hld, hlvar⟩⟩
      have herase : V.erase x ⊂ V := Finset.erase_ssubset hx
      -- Recurse on both restrictions.
      obtain ⟨r0⟩ := ih (V.erase x) herase (restrict x false F) (hsub' false)
        (restrict_unsat x false hunsat)
      obtain ⟨r1⟩ := ih (V.erase x) herase (restrict x true F) (hsub' true)
        (restrict_unsat x true hunsat)
      -- Lift each.  restrict x false → adds litOf x (!false) = litOf x true = posLit x.
      obtain ⟨T0', hT0valid, hT0concl⟩ := lift x false F r0.tree r0.valid
      obtain ⟨T1', hT1valid, hT1concl⟩ := lift x true F r1.tree r1.valid
      -- r0.tree concludes [], so every literal of T0' is litOf x true = posLit x.
      have hT0all : ∀ l ∈ T0'.conclusion, l = posLit x := by
        intro l hl
        rcases hT0concl l hl with hin | heq
        · rw [r0.derives_empty] at hin; exact absurd hin (List.not_mem_nil l)
        · simpa [litOf, posLit] using heq
      have hT1all : ∀ l ∈ T1'.conclusion, l = negLit x := by
        intro l hl
        rcases hT1concl l hl with hin | heq
        · rw [r1.derives_empty] at hin; exact absurd hin (List.not_mem_nil l)
        · simpa [litOf, negLit] using heq
      -- If either conclusion is empty, that lift is already a refutation of F.
      by_cases h0 : T0'.conclusion = []
      · exact ⟨⟨T0', hT0valid, h0⟩⟩
      · by_cases h1 : T1'.conclusion = []
        · exact ⟨⟨T1', hT1valid, h1⟩⟩
        · -- Both nonempty: posLit x ∈ T0'.conclusion, negLit x ∈ T1'.conclusion. Resolve.
          have hposmem : posLit x ∈ T0'.conclusion := by
            obtain ⟨l, hl⟩ := List.exists_mem_of_ne_nil _ h0
            have : l = posLit x := hT0all l hl
            rwa [this] at hl
          have hnegmem : negLit x ∈ T1'.conclusion := by
            obtain ⟨l, hl⟩ := List.exists_mem_of_ne_nil _ h1
            have : l = negLit x := hT1all l hl
            rwa [this] at hl
          refine ⟨⟨ResolutionDerivTree.resolve x T0' T1',
            ⟨hT0valid, hT1valid, hposmem, hnegmem⟩, ?_⟩⟩
          show resolveOn x T0'.conclusion T1'.conclusion = []
          exact resolveOn_all_pos_all_neg x hT0all hT1all

/-- **RESOLUTION REFUTATION-COMPLETENESS.**  Every unsatisfiable CNF over `Fin n`
has a resolution refutation in the tree-resolution model. -/
theorem resolution_complete {n : Nat} {F : CNF n}
    (hF : ¬ ∃ a : Assignment n, cnfSat a F) :
    Nonempty (ResolutionRefutation F) :=
  complete_aux (cnfVarSet F) F (le_refl _) hF

/-! ## 6. Non-vacuity of the K_n Tseitin width lower bound

The width lower bound `tseitinKn_unconditional_refutationWidth_ge` is universally
quantified over `ResolutionRefutation (cnf)`.  Combined with completeness and the
genuine unsatisfiability of the concrete K_n Tseitin CNF (`cnf_unsat`), the type
of refutations is `Nonempty`, so the bound is not vacuous. -/

open PvNP.CNFResolution.TseitinKnConcrete in
/-- **The concrete K_n Tseitin CNF has a resolution refutation** (for `n ≥ 1`):
the type `ResolutionRefutation (cnf)` is inhabited. -/
theorem tseitinKn_refutation_exists {n : Nat} (hn : 0 < n) :
    Nonempty (ResolutionRefutation (cnf (n := n))) :=
  resolution_complete (cnf_unsat hn)

open PvNP.CNFResolution.TseitinKnConcrete in
/-- **The K_n Tseitin resolution width lower bound is NON-VACUOUS.**
For `n ≥ 4` there genuinely EXISTS a resolution refutation `r` of the concrete
`K_n` Tseitin CNF, and every such `r` has width at least `(n/4)*(n/4)`.  Thus the
quadratic width lower bound is witnessed by an actually-existing object, not
vacuously true over an empty type. -/
theorem tseitinKn_width_nonvacuous {n : Nat} (hn : 4 ≤ n) :
    ∃ r : ResolutionRefutation (cnf (n := n)),
      (n / 4) * (n / 4) ≤ refutationWidth r := by
  obtain ⟨r⟩ := tseitinKn_refutation_exists (by omega : 0 < n)
  exact ⟨r, tseitinKn_unconditional_refutationWidth_ge_quarter hn r⟩

end Completeness
end CNFResolution
end PvNP
