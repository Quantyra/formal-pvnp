import PvNP.ResolutionSoundness
import PvNP.ResolutionCompleteness
import PvNP.ResolutionWidthExpansion
import PvNP.ResolutionSizeWidthCore
import Mathlib.Data.List.Dedup
import Mathlib.Data.List.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Tactic.Linarith

/-!
# A faithful DAG resolution refutation model + restriction-size monotonicity.

## Honest scope (READ FIRST)

This module is **step 1 of a DAG re-architecture** of the resolution size bound.
It is **NOT** a proof of `P ≠ NP` and does **NOT** finish the DAG size bound.  It
delivers:

* a **faithful** DAG resolution model `DagProof`/`DagRefutation`: a proof is a
  *list of lines in derivation order* (head = most recently derived), each line
  **genuinely justified** as a hypothesis (member of the CNF), a resolvent
  `resolveOn p A B` of two **strictly earlier** lines with the pivot literals
  present, or a **weakening** of an earlier line (a sound super-clause).  This is
  the genuine DAG object: a line can be **reused** by several later lines, unlike
  the tree model `ResolutionDerivTree`.
* **soundness / non-vacuity**: `DagRefutation F → ¬ ∃ a, cnfSat a F`
  (`dagRefutation_unsat`).  Every rule (`hyp`, `res`, `weaken`) is sound against
  the repository `cnfSat`, so the model is real, not self-justifying or vacuous.
* the **foundational lemma the tree model lacks**: restricting a `DagRefutation F`
  by `x := s` yields a `DagRefutation (restrict x s F)` (`dagRefutation_restrict`)
  with `dagSize r' ≤ dagSize r` (`dagSize_restrict_le`), where `dagSize` is the
  count of **distinct** lines.  The crux: on a list/DAG model the restricted lines
  ARE the `ρₓ`-IMAGES of the originals (`restrictClauses` is a
  `filterMap (restrictClause x s)` of the original line-clauses), so the distinct
  count cannot increase — exactly the *exact-image* property that fails on trees
  (`ResolutionDagOneStep.ClauseSetRestrictExact`).
* **per-line width non-increase** under restriction
  (`dagRefutation_restrict_width_le`): every restricted line is a literal-subset
  of its source line, so `clauseWidth` does not increase, and restricted lines are
  `x`-free.

### Faithfulness, precisely
Every line of a `Valid` proof is genuinely justified, the side conditions are
real, and "earlier-only" references make the proof acyclic (a real DAG).  The
weakening rule (`weaken`) derives a super-clause of an earlier line, which is
sound (a larger clause is implied) — this is the standard structural rule used to
re-justify a restricted resolvent when the pivot equals `x` and one parent is
satisfied/removed.  We never fabricate a resolution with a false side condition.

### Integrity
No `sorry`, no `admit`, no new `axiom`, no `native_decide`, no false/circular
hypothesis.  `#print axioms` of the headline results is a subset of
`[propext, Classical.choice, Quot.sound]`.

### What remains to port (named honestly, NOT done here)
* the **width upper bound** (a `derivWidth`-style max bound on the restricted DAG);
  only the *non-increase* direction is proved here;
* the **bottleneck/`BW` width argument** turning restriction monotonicity into an
  unconditional `dagSize` lower bound on hard families;
* connecting `dagSize` on this model to the existing tree-`ResolutionRefutation`
  size measures used downstream.
-/

namespace PvNP
namespace CNFResolution
namespace DagResolutionModel

open CNFModel
open PvNP.CNFResolution
open PvNP.CNFResolution.Completeness

/-! ## 1. The faithful DAG model. -/

/-- A justification for a DAG line. -/
inductive Just (n : Nat) where
  /-- Hypothesis: the clause is a member of the CNF `F`. -/
  | hyp
  /-- Resolvent on pivot `p` of two earlier lines whose clauses are `A`, `B`. -/
  | res (p : Fin n) (A B : Clause n)
  /-- Weakening: the clause is a (sound) super-clause of an earlier line `A`
  (every literal of `A` occurs in this line).  A copy is the equality case. -/
  | weaken (A : Clause n)
deriving Repr, DecidableEq

/-- A DAG line: a clause together with its justification. -/
structure Line (n : Nat) where
  clause : Clause n
  just   : Just n
deriving Repr, DecidableEq

/-- A DAG proof: a list of lines, head = **most recently derived**; the tail holds
the strictly-earlier lines. -/
abbrev DagProof (n : Nat) := List (Line n)

/-- The line-clauses of a DAG proof, in order. -/
def lineClauses {n : Nat} (P : DagProof n) : List (Clause n) :=
  P.map Line.clause

@[simp] theorem lineClauses_nil {n : Nat} : lineClauses ([] : DagProof n) = [] := rfl

@[simp] theorem lineClauses_cons {n : Nat} (ln : Line n) (P : DagProof n) :
    lineClauses (ln :: P) = ln.clause :: lineClauses P := rfl

/-- A single line is **justified** against the strictly-earlier lines `earlier`. -/
def LineJustified {n : Nat} (F : CNF n) (earlier : DagProof n) (ln : Line n) : Prop :=
  match ln.just with
  | .hyp => ln.clause ∈ F
  | .res p A B =>
      A ∈ lineClauses earlier ∧ B ∈ lineClauses earlier ∧
        posLit p ∈ A ∧ negLit p ∈ B ∧
        (∀ l, l ∈ ln.clause ↔ l ∈ resolveOn p A B)
  | .weaken A =>
      A ∈ lineClauses earlier ∧ (∀ l ∈ A, l ∈ ln.clause)

/-- A DAG proof is **valid** w.r.t. `F`: every line is justified by its tail. -/
def Valid {n : Nat} (F : CNF n) : DagProof n → Prop
  | [] => True
  | ln :: earlier => Valid F earlier ∧ LineJustified F earlier ln

@[simp] theorem Valid_nil {n : Nat} (F : CNF n) : Valid F ([] : DagProof n) := trivial

theorem Valid_cons {n : Nat} {F : CNF n} {ln : Line n} {earlier : DagProof n} :
    Valid F (ln :: earlier) ↔ Valid F earlier ∧ LineJustified F earlier ln := Iff.rfl

/-- A DAG refutation of `F`: a non-empty valid DAG proof whose head is `[]`. -/
structure DagRefutation {n : Nat} (F : CNF n) where
  head : Line n
  rest : DagProof n
  valid : Valid F (head :: rest)
  head_empty : head.clause = []

/-- The underlying proof list. -/
def DagRefutation.proof {n : Nat} {F : CNF n} (r : DagRefutation F) : DagProof n :=
  r.head :: r.rest

/-- The **DAG size**: the number of DISTINCT line-clauses (reused lines coincide
as the same clause and de-dup collapses them — the genuine DAG size). -/
def dagSize {n : Nat} (P : DagProof n) : Nat :=
  (lineClauses P).dedup.length

/-- DAG size of a refutation. -/
def refutationSize {n : Nat} {F : CNF n} (r : DagRefutation F) : Nat :=
  dagSize r.proof

/-! ## 2. Soundness / non-vacuity. -/

/-- **Every line-clause of a valid DAG proof is satisfied** by any model of `F`. -/
theorem lineClause_sat {n : Nat} {F : CNF n} (a : Assignment n)
    (hsat : cnfSat a F) :
    ∀ (P : DagProof n), Valid F P → ∀ c ∈ lineClauses P, clauseSat a c := by
  intro P
  induction P with
  | nil => intro _ c hc; simp [lineClauses] at hc
  | cons ln earlier ih =>
      intro hv c hc
      rcases hv with ⟨hvE, hjust⟩
      rw [lineClauses_cons, List.mem_cons] at hc
      rcases hc with hhead | htail
      · subst hhead
        unfold LineJustified at hjust
        cases hj : ln.just with
        | hyp => rw [hj] at hjust; exact hsat _ hjust
        | res p A B =>
            rw [hj] at hjust
            obtain ⟨hA, hB, _, _, hequiv⟩ := hjust
            have hsatA : clauseSat a A := ih hvE A hA
            have hsatB : clauseSat a B := ih hvE B hB
            obtain ⟨l, hl, hle⟩ := clauseSat_resolveOn a p A B hsatA hsatB
            exact ⟨l, (hequiv l).mpr hl, hle⟩
        | weaken A =>
            rw [hj] at hjust
            obtain ⟨hA, hsub⟩ := hjust
            obtain ⟨l, hlA, hleval⟩ := ih hvE A hA
            exact ⟨l, hsub l hlA, hleval⟩
      · exact ih hvE c htail

/-- **Soundness of the DAG model.** A `DagRefutation F` witnesses unsatisfiability. -/
theorem dagRefutation_unsat {n : Nat} {F : CNF n} (r : DagRefutation F) :
    ¬ ∃ a : Assignment n, cnfSat a F := by
  rintro ⟨a, hsat⟩
  have hmem : r.head.clause ∈ lineClauses r.proof := by
    unfold DagRefutation.proof; rw [lineClauses_cons]; exact List.mem_cons_self _ _
  have hcsat : clauseSat a r.head.clause :=
    lineClause_sat a hsat r.proof r.valid r.head.clause hmem
  rw [r.head_empty] at hcsat
  exact not_clauseSat_nil a hcsat

/-! ## 3. Restriction on clauses. -/

/-- The literal `x`-projection of a clause: drop every `x`-literal.  Equals
`restrictClause x s c` when `c` is not satisfied by `x := s`. -/
def rhoClause {n : Nat} (x : Fin n) (c : Clause n) : Clause n :=
  c.filter (fun l => !decide (l.var = x))

theorem mem_rhoClause {n : Nat} {x : Fin n} {c : Clause n} {l : Literal n} :
    l ∈ rhoClause x c ↔ l ∈ c ∧ l.var ≠ x := by
  unfold rhoClause; rw [List.mem_filter]
  constructor
  · rintro ⟨hm, hk⟩; exact ⟨hm, by intro h; simp [h] at hk⟩
  · rintro ⟨hm, hne⟩; exact ⟨hm, by simp [hne]⟩

theorem mem_rhoClause_of_mem {n : Nat} {x : Fin n} {c : Clause n} {l : Literal n}
    (hl : l ∈ c) (hne : l.var ≠ x) : l ∈ rhoClause x c :=
  mem_rhoClause.mpr ⟨hl, hne⟩

/-- Whether a clause is satisfied by `x := s` (contains `litOf x s`). -/
def satByLit {n : Nat} (x : Fin n) (s : Bool) (c : Clause n) : Bool :=
  c.any (fun l => decide (l.var = x) && decide (l.sign = s))

theorem satByLit_iff {n : Nat} {x : Fin n} {s : Bool} {c : Clause n} :
    satByLit x s c = true ↔ litOf x s ∈ c := by
  unfold satByLit
  rw [List.any_eq_true]
  constructor
  · rintro ⟨l, hl, h⟩
    rw [Bool.and_eq_true, decide_eq_true_eq, decide_eq_true_eq] at h
    have : l = litOf x s := by cases l with | mk lv ls => simp [litOf] at *; exact ⟨h.1, h.2⟩
    rw [← this]; exact hl
  · intro h; exact ⟨litOf x s, h, by simp [litOf]⟩

/-- `restrictClause x s c = none` iff satisfied, else `some (rhoClause x c)`. -/
theorem restrictClause_eq {n : Nat} (x : Fin n) (s : Bool) (c : Clause n) :
    restrictClause x s c =
      (if satByLit x s c then none else some (rhoClause x c)) := by
  unfold restrictClause satByLit rhoClause; rfl

theorem restrictClause_some {n : Nat} {x : Fin n} {s : Bool} {c : Clause n}
    (h : satByLit x s c = false) :
    restrictClause x s c = some (rhoClause x c) := by
  rw [restrictClause_eq, if_neg (by simpa using h)]

/-! ## 4. The size bound: the IMAGE property the tree model lacks. -/

/-- `filterMap` cannot increase the de-dup'd length: each output is a `some`-image
of an input, so distinct outputs are bounded by distinct inputs.  This is the
genuine **exact-image** property — on the list/DAG model restricted lines ARE
images, so the distinct-count bound is unconditional. -/
theorem dedup_length_filterMap_le {α β : Type _} [DecidableEq α] [DecidableEq β]
    (f : α → Option β) (L : List α) :
    (L.filterMap f).dedup.length ≤ L.dedup.length := by
  classical
  have hsub : (L.filterMap f).dedup.toFinset ⊆
      L.dedup.toFinset.biUnion (fun a => (f a).toFinset) := by
    intro b hb
    rw [List.mem_toFinset, List.mem_dedup, List.mem_filterMap] at hb
    obtain ⟨a, ha, hfa⟩ := hb
    rw [Finset.mem_biUnion]
    refine ⟨a, by rw [List.mem_toFinset, List.mem_dedup]; exact ha, ?_⟩
    rw [hfa]; simp [Option.toFinset]
  have hb1 : ∀ a ∈ L.dedup.toFinset, (f a).toFinset.card ≤ 1 := by
    intro a _
    cases f a with
    | none => simp [Option.toFinset]
    | some b => simp [Option.toFinset]
  calc (L.filterMap f).dedup.length
      = (L.filterMap f).dedup.toFinset.card :=
        (List.toFinset_card_of_nodup (List.nodup_dedup _)).symm
    _ ≤ (L.dedup.toFinset.biUnion (fun a => (f a).toFinset)).card :=
        Finset.card_le_card hsub
    _ ≤ L.dedup.toFinset.card * 1 :=
        Finset.card_biUnion_le_card_mul _ _ 1 hb1
    _ = L.dedup.toFinset.card := by rw [Nat.mul_one]
    _ = L.dedup.length := List.toFinset_card_of_nodup (List.nodup_dedup _)

/-- The restricted line-clause list: `filterMap (restrictClause x s)` of the
original line-clauses (project survivors, drop satisfied lines). -/
def restrictClauses {n : Nat} (x : Fin n) (s : Bool) (P : DagProof n) :
    List (Clause n) :=
  (lineClauses P).filterMap (restrictClause x s)

/-- **DAG-size monotonicity of the restricted clause list (the key lemma trees
lack).** -/
theorem dagSize_restrictClauses_le {n : Nat} (x : Fin n) (s : Bool)
    (P : DagProof n) :
    (restrictClauses x s P).dedup.length ≤ dagSize P := by
  unfold restrictClauses dagSize
  exact dedup_length_filterMap_le (restrictClause x s) (lineClauses P)

/-! ## 5. The restricted proof, faithfully re-justified. -/

/-- `ρₓ (resolveOn p A B) = resolveOn p (ρₓ A) (ρₓ B)` (literal-membership).  (The
`p ≠ x` hypothesis is recorded for callers; the membership iff holds regardless.) -/
theorem mem_rhoClause_resolveOn {n : Nat} {x p : Fin n} (_hpx : p ≠ x)
    (A B : Clause n) (l : Literal n) :
    l ∈ rhoClause x (resolveOn p A B) ↔
      l ∈ resolveOn p (rhoClause x A) (rhoClause x B) := by
  rw [mem_rhoClause]
  unfold resolveOn
  rw [List.mem_append, List.mem_append, mem_removePivotSign_iff,
    mem_removePivotSign_iff, mem_removePivotSign_iff, mem_removePivotSign_iff,
    mem_rhoClause, mem_rhoClause]
  constructor
  · rintro ⟨h, hne⟩
    rcases h with hL | hR
    · exact Or.inl ⟨⟨hL.1, hne⟩, hL.2⟩
    · exact Or.inr ⟨⟨hR.1, hne⟩, hR.2⟩
  · rintro (⟨⟨hL, hne⟩, hk⟩ | ⟨⟨hR, hne⟩, hk⟩)
    · exact ⟨Or.inl ⟨hL, hk⟩, hne⟩
    · exact ⟨Or.inr ⟨hR, hk⟩, hne⟩

/-- The restricted-line justification chooser.  Produces a `Just` for the
restricted clause `ρₓ ln.clause`, given the restricted earlier lines `rE`. -/
def restrictJust {n : Nat} (x : Fin n) (s : Bool) (ln : Line n) : Just n :=
  match ln.just with
  | .hyp => .hyp
  | .weaken A => .weaken (rhoClause x A)
  | .res p A B =>
      if p = x then
        -- pivot collapses: weaken from the surviving parent (s=true ⇒ B, s=false ⇒ A).
        if s then .weaken (rhoClause x B) else .weaken (rhoClause x A)
      else
        .res p (rhoClause x A) (rhoClause x B)

/-- The restricted proof: project each surviving line, re-justify via
`restrictJust`. -/
def restrictProof {n : Nat} (x : Fin n) (s : Bool) : DagProof n → DagProof n
  | [] => []
  | ln :: earlier =>
      let rE := restrictProof x s earlier
      if satByLit x s ln.clause then rE
      else { clause := rhoClause x ln.clause, just := restrictJust x s ln } :: rE

/-- The restricted proof realizes the restricted clause list. -/
theorem lineClauses_restrictProof {n : Nat} (x : Fin n) (s : Bool)
    (P : DagProof n) :
    lineClauses (restrictProof x s P) = restrictClauses x s P := by
  induction P with
  | nil => rfl
  | cons ln earlier ih =>
      unfold restrictProof restrictClauses
      rw [lineClauses_cons, List.filterMap_cons]
      by_cases hsat : satByLit x s ln.clause
      · rw [if_pos hsat, restrictClause_eq, if_pos hsat]
        simpa [restrictClauses] using ih
      · rw [if_neg hsat, restrictClause_some (by simpa using hsat)]
        rw [lineClauses_cons]
        simpa [restrictClauses] using congrArg (rhoClause x ln.clause :: ·) ih

/-- If a surviving line resolves on `p ≠ x`, both its parents survive (their
restricted clauses occur earlier).  Key structural fact behind faithful
re-justification. -/
theorem parents_survive_of_res_ne {n : Nat} {x p : Fin n} {s : Bool}
    (hpx : p ≠ x) {A B : Clause n}
    (hns : satByLit x s (resolveOn p A B) = false) :
    satByLit x s A = false ∧ satByLit x s B = false := by
  -- If A were satisfied, litOf x s ∈ A; since its var x ≠ p it survives into the
  -- left part of resolveOn, hence into the resolvent — contradiction.
  refine ⟨?_, ?_⟩
  · by_contra hA
    rw [Bool.not_eq_false] at hA
    have hin : litOf x s ∈ A := satByLit_iff.mp hA
    have hmem : litOf x s ∈ resolveOn p A B := by
      unfold resolveOn; rw [List.mem_append]; left
      rw [mem_removePivotSign_iff]
      refine ⟨hin, ?_⟩
      rintro ⟨hv, _⟩
      have : x = p := by simpa [litOf] using hv
      exact hpx this.symm
    rw [satByLit_iff.mpr hmem] at hns; exact absurd hns (by simp)
  · by_contra hB
    rw [Bool.not_eq_false] at hB
    have hin : litOf x s ∈ B := satByLit_iff.mp hB
    have hmem : litOf x s ∈ resolveOn p A B := by
      unfold resolveOn; rw [List.mem_append]; right
      rw [mem_removePivotSign_iff]
      refine ⟨hin, ?_⟩
      rintro ⟨hv, _⟩
      have hxp : x = p := by simpa [litOf] using hv
      exact hpx hxp.symm
    rw [satByLit_iff.mpr hmem] at hns; exact absurd hns (by simp)

/-- For `p = x`, `ρₓ (resolveOn x A B)` contains `ρₓ A` and `ρₓ B`
(literal-membership), so it weakens either restricted parent. -/
theorem rhoClause_parent_sub_resolveOn_x {n : Nat} {x : Fin n}
    (A B : Clause n) :
    (∀ l ∈ rhoClause x A, l ∈ rhoClause x (resolveOn x A B)) ∧
    (∀ l ∈ rhoClause x B, l ∈ rhoClause x (resolveOn x A B)) := by
  constructor
  · intro l hl
    rw [mem_rhoClause] at hl ⊢
    refine ⟨?_, hl.2⟩
    unfold resolveOn; rw [List.mem_append]; left
    rw [mem_removePivotSign_iff]
    exact ⟨hl.1, by rintro ⟨hv, _⟩; exact hl.2 hv⟩
  · intro l hl
    rw [mem_rhoClause] at hl ⊢
    refine ⟨?_, hl.2⟩
    unfold resolveOn; rw [List.mem_append]; right
    rw [mem_removePivotSign_iff]
    exact ⟨hl.1, by rintro ⟨hv, _⟩; exact hl.2 hv⟩

/-- For `p = x` and `s = true`, if `resolveOn x A B` survives then `B` survives.
(The satisfying literal `posLit x` would otherwise re-enter the resolvent.) -/
theorem rightParent_survives_x_true {n : Nat} {x : Fin n} {A B : Clause n}
    (_hnegB : negLit x ∈ B)
    (hns : satByLit x true (resolveOn x A B) = false) :
    satByLit x true B = false := by
  by_contra hBsat
  rw [Bool.not_eq_false] at hBsat
  have hlx : litOf x true ∈ B := satByLit_iff.mp hBsat
  have : litOf x true ∈ resolveOn x A B := by
    unfold resolveOn; rw [List.mem_append]; right
    rw [mem_removePivotSign_iff]
    exact ⟨hlx, by rintro ⟨_, hsgn⟩; simp [litOf] at hsgn⟩
  rw [satByLit_iff.mpr this] at hns; exact absurd hns (by simp)

/-- For `p = x` and `s = false`, if `resolveOn x A B` survives then `A` survives. -/
theorem leftParent_survives_x_false {n : Nat} {x : Fin n} {A B : Clause n}
    (_hposA : posLit x ∈ A)
    (hns : satByLit x false (resolveOn x A B) = false) :
    satByLit x false A = false := by
  by_contra hAsat
  rw [Bool.not_eq_false] at hAsat
  have hlx : litOf x false ∈ A := satByLit_iff.mp hAsat
  have : litOf x false ∈ resolveOn x A B := by
    unfold resolveOn; rw [List.mem_append]; left
    rw [mem_removePivotSign_iff]
    exact ⟨hlx, by rintro ⟨_, hsgn⟩; simp [litOf] at hsgn⟩
  rw [satByLit_iff.mpr this] at hns; exact absurd hns (by simp)

/-- **Validity of the restricted proof.** -/
theorem restrictProof_valid {n : Nat} {F : CNF n} (x : Fin n) (s : Bool) :
    ∀ (P : DagProof n), Valid F P → Valid (restrict x s F) (restrictProof x s P) := by
  intro P
  induction P with
  | nil => intro _; exact trivial
  | cons ln earlier ih =>
      intro hv
      rcases hv with ⟨hvE, hj⟩
      have hvE' : Valid (restrict x s F) (restrictProof x s earlier) := ih hvE
      unfold restrictProof
      by_cases hsat : satByLit x s ln.clause
      · rw [if_pos hsat]; exact hvE'
      · rw [if_neg hsat]
        refine ⟨hvE', ?_⟩
        -- Justify the kept line { clause := ρₓ ln.clause, just := restrictJust ... }.
        have hnsf : satByLit x s ln.clause = false := by simpa using hsat
        unfold LineJustified at hj
        cases hjj : ln.just with
        | hyp =>
            simp only [LineJustified, restrictJust, hjj]
            -- ρₓ ln.clause ∈ restrict x s F.
            rw [hjj] at hj
            show rhoClause x ln.clause ∈ restrict x s F
            rw [mem_restrict]
            exact ⟨ln.clause, hj, restrictClause_some hnsf⟩
        | weaken A =>
            simp only [LineJustified, restrictJust, hjj]
            rw [hjj] at hj
            obtain ⟨hA, hsub⟩ := hj
            -- weaken from ρₓ A (earlier, surviving via image) — but A may be satisfied.
            -- ρₓ A ⊆ ρₓ ln.clause since A ⊆ ln.clause literal-wise.
            show (rhoClause x A) ∈ lineClauses (restrictProof x s earlier) ∧
              (∀ l ∈ rhoClause x A, l ∈ rhoClause x ln.clause)
            constructor
            · -- ρₓ A appears as a restricted earlier line iff A survives; A survives
              -- because ln.clause survives and A ⊆ ln.clause keeps litOf x s out of A.
              have hAns : satByLit x s A = false := by
                by_contra hAsat
                rw [Bool.not_eq_false] at hAsat
                have : litOf x s ∈ ln.clause := hsub _ (satByLit_iff.mp hAsat)
                rw [satByLit_iff.mpr this] at hnsf; exact absurd hnsf (by simp)
              rw [lineClauses_restrictProof]
              unfold restrictClauses
              rw [List.mem_filterMap]
              exact ⟨A, hA, restrictClause_some hAns⟩
            · intro l hl
              rw [mem_rhoClause] at hl ⊢
              exact ⟨hsub _ hl.1, hl.2⟩
        | res p A B =>
            have hrj : restrictJust x s ln =
                (if p = x then
                  (if s then Just.weaken (rhoClause x B) else Just.weaken (rhoClause x A))
                else Just.res p (rhoClause x A) (rhoClause x B)) := by
              simp only [restrictJust, hjj]
            show LineJustified (restrict x s F) (restrictProof x s earlier)
              ⟨rhoClause x ln.clause, restrictJust x s ln⟩
            rw [hrj]
            rw [hjj] at hj
            obtain ⟨hA, hB, hposA, hnegB, hequiv⟩ := hj
            -- ρₓ ln.clause and ρₓ (resolveOn p A B) coincide as sets (ln.clause ≡ resolveOn).
            have hrhoeq : ∀ l, l ∈ rhoClause x ln.clause ↔ l ∈ rhoClause x (resolveOn p A B) := by
              intro l; rw [mem_rhoClause, mem_rhoClause]
              constructor
              · rintro ⟨hm, hne⟩; exact ⟨(hequiv l).mp hm, hne⟩
              · rintro ⟨hm, hne⟩; exact ⟨(hequiv l).mpr hm, hne⟩
            have hns_res : satByLit x s (resolveOn p A B) = false := by
              by_contra h; rw [Bool.not_eq_false] at h
              have : litOf x s ∈ ln.clause := (hequiv _).mpr (satByLit_iff.mp h)
              rw [satByLit_iff.mpr this] at hnsf; exact absurd hnsf (by simp)
            by_cases hpx : p = x
            · rw [if_pos hpx]
              -- rewrite the pivot to x in the relevant facts.
              rw [hpx] at hposA hnegB hns_res
              -- pivot collapses: weaken from the surviving parent, chosen by `s`.
              cases hs : s with
              | true =>
                  simp only [hs, if_true]
                  rw [hs] at hns_res
                  have hBns : satByLit x true B = false :=
                    rightParent_survives_x_true hnegB hns_res
                  show (rhoClause x B) ∈ lineClauses (restrictProof x true earlier) ∧
                    (∀ l ∈ rhoClause x B, l ∈ rhoClause x ln.clause)
                  refine ⟨?_, ?_⟩
                  · rw [lineClauses_restrictProof]; unfold restrictClauses
                    rw [List.mem_filterMap]
                    exact ⟨B, hB, restrictClause_some hBns⟩
                  · intro l hl
                    rw [hrhoeq, hpx]
                    exact (rhoClause_parent_sub_resolveOn_x A B).2 l hl
              | false =>
                  rw [hs] at hns_res
                  have hAns : satByLit x false A = false :=
                    leftParent_survives_x_false hposA hns_res
                  show (rhoClause x A) ∈ lineClauses (restrictProof x false earlier) ∧
                    (∀ l ∈ rhoClause x A, l ∈ rhoClause x ln.clause)
                  refine ⟨?_, ?_⟩
                  · rw [lineClauses_restrictProof]; unfold restrictClauses
                    rw [List.mem_filterMap]
                    exact ⟨A, hA, restrictClause_some hAns⟩
                  · intro l hl
                    rw [hrhoeq, hpx]
                    exact (rhoClause_parent_sub_resolveOn_x A B).1 l hl
            · -- genuine resolution on p ≠ x.
              rw [if_neg hpx]
              obtain ⟨hAns, hBns⟩ := parents_survive_of_res_ne hpx hns_res
              show (rhoClause x A) ∈ lineClauses (restrictProof x s earlier) ∧
                (rhoClause x B) ∈ lineClauses (restrictProof x s earlier) ∧
                posLit p ∈ rhoClause x A ∧ negLit p ∈ rhoClause x B ∧
                (∀ l, l ∈ rhoClause x ln.clause ↔
                  l ∈ resolveOn p (rhoClause x A) (rhoClause x B))
              refine ⟨?_, ?_, ?_, ?_, ?_⟩
              · rw [lineClauses_restrictProof]; unfold restrictClauses
                rw [List.mem_filterMap]; exact ⟨A, hA, restrictClause_some hAns⟩
              · rw [lineClauses_restrictProof]; unfold restrictClauses
                rw [List.mem_filterMap]; exact ⟨B, hB, restrictClause_some hBns⟩
              · exact mem_rhoClause_of_mem hposA (by simpa [posLit] using hpx)
              · exact mem_rhoClause_of_mem hnegB (by simpa [negLit] using hpx)
              · intro l
                rw [hrhoeq, mem_rhoClause_resolveOn hpx]

/-! ## 6. The headline restriction theorem (the foundational lemma trees lack). -/

@[simp] theorem rhoClause_nil {n : Nat} (x : Fin n) : rhoClause x ([] : Clause n) = [] := rfl

@[simp] theorem satByLit_nil {n : Nat} (x : Fin n) (s : Bool) :
    satByLit x s ([] : Clause n) = false := rfl

/-- The restricted proof of a refutation keeps the empty head clause as its head. -/
theorem restrictProof_cons_empty {n : Nat} (x : Fin n) (s : Bool)
    {head : Line n} (rest : DagProof n) (hempty : head.clause = []) :
    restrictProof x s (head :: rest) =
      ⟨[], restrictJust x s head⟩ :: restrictProof x s rest := by
  show (if satByLit x s head.clause then restrictProof x s rest
      else ⟨rhoClause x head.clause, restrictJust x s head⟩ :: restrictProof x s rest)
    = ⟨[], restrictJust x s head⟩ :: restrictProof x s rest
  rw [if_neg (by rw [hempty]; simp)]
  simp only [hempty, rhoClause_nil]

/-- **Restricting a `DagRefutation`.**  For any `x, s`, a `DagRefutation F` yields
a `DagRefutation (restrict x s F)`. -/
def DagRefutation.restrict {n : Nat} {F : CNF n} (r : DagRefutation F)
    (x : Fin n) (s : Bool) : DagRefutation (CNFResolution.Completeness.restrict x s F) where
  head := ⟨[], restrictJust x s r.head⟩
  rest := restrictProof x s r.rest
  valid := by
    have hv := restrictProof_valid x s r.proof r.valid
    have heq : restrictProof x s r.proof
        = ⟨[], restrictJust x s r.head⟩ :: restrictProof x s r.rest := by
      unfold DagRefutation.proof
      exact restrictProof_cons_empty x s r.rest r.head_empty
    rw [heq] at hv; exact hv
  head_empty := rfl

/-- **DAG-size monotonicity under restriction (THE key lemma the tree model
lacks).**  `refutationSize (r.restrict x s) ≤ refutationSize r`. -/
theorem dagSize_restrict_le {n : Nat} {F : CNF n} (r : DagRefutation F)
    (x : Fin n) (s : Bool) :
    refutationSize (r.restrict x s) ≤ refutationSize r := by
  unfold refutationSize dagSize
  show (lineClauses (r.restrict x s).proof).dedup.length ≤ (lineClauses r.proof).dedup.length
  have hlc : lineClauses (r.restrict x s).proof = restrictClauses x s r.proof := by
    show lineClauses (⟨[], restrictJust x s r.head⟩ :: restrictProof x s r.rest) = _
    rw [← restrictProof_cons_empty x s r.rest r.head_empty]
    exact lineClauses_restrictProof x s r.proof
  rw [hlc]
  exact dagSize_restrictClauses_le x s r.proof

/-- Convenience restatement: the restricted refutation exists with no larger DAG
size. -/
theorem dagRefutation_restrict {n : Nat} {F : CNF n} (r : DagRefutation F)
    (x : Fin n) (s : Bool) :
    ∃ r' : DagRefutation (CNFResolution.Completeness.restrict x s F),
      refutationSize r' ≤ refutationSize r :=
  ⟨r.restrict x s, dagSize_restrict_le r x s⟩

/-! ## 7. Per-line width non-increase under restriction. -/

/-- Every restricted line-clause is a literal-subset of an original line-clause,
hence `clauseWidth` does not increase, and restricted lines are `x`-free. -/
theorem restrictClauses_sub {n : Nat} (x : Fin n) (s : Bool) (P : DagProof n) :
    ∀ c' ∈ restrictClauses x s P,
      ∃ c ∈ lineClauses P, (∀ l ∈ c', l ∈ c ∧ l.var ≠ x) := by
  intro c' hc'
  unfold restrictClauses at hc'
  rw [List.mem_filterMap] at hc'
  obtain ⟨c, hc, hrc⟩ := hc'
  refine ⟨c, hc, ?_⟩
  intro l hl
  -- c' = rhoClause x c (since restrictClause returned some).
  by_cases hsat : satByLit x s c
  · rw [restrictClause_eq, if_pos hsat] at hrc; exact absurd hrc (by simp)
  · rw [restrictClause_some (by simpa using hsat)] at hrc
    injection hrc with hrc'
    rw [← hrc', mem_rhoClause] at hl
    exact hl

/-- **Per-line width non-increase under restriction.**  Every line of the
restricted refutation has `clauseWidth ≤` the `clauseWidth` of a source line. -/
theorem dagRefutation_restrict_width_le {n : Nat} {F : CNF n} (r : DagRefutation F)
    (x : Fin n) (s : Bool) :
    ∀ c' ∈ lineClauses (r.restrict x s).proof,
      ∃ c ∈ lineClauses r.proof, clauseWidth c' ≤ clauseWidth c := by
  intro c' hc'
  have hlc : lineClauses (r.restrict x s).proof = restrictClauses x s r.proof := by
    show lineClauses (⟨[], restrictJust x s r.head⟩ :: restrictProof x s r.rest) = _
    rw [← restrictProof_cons_empty x s r.rest r.head_empty]
    exact lineClauses_restrictProof x s r.proof
  rw [hlc] at hc'
  obtain ⟨c, hc, hsub⟩ := restrictClauses_sub x s r.proof c' hc'
  refine ⟨c, hc, ?_⟩
  exact ResolutionSizeWidth.clauseWidth_le_of_sub (fun l hl => (hsub l hl).1)

end DagResolutionModel
end CNFResolution
end PvNP
