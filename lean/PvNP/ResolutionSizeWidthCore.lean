import PvNP.ResolutionSizeWidth
import PvNP.ResolutionCompleteness
import Mathlib.Data.Nat.Log
import Mathlib.Tactic.Linarith

/-!
# A genuine, local proof of the tree-resolution Ben-Sasson-Wigderson size-width
core `RestrictionNarrowsCore`.

## Honest scope

This module PROVES the formula-independent tree-resolution size-width tradeoff
that `ResolutionSizeWidth.lean` previously isolated as an explicit hypothesis
`RestrictionNarrowsCore`:

> Any tree-resolution refutation of `F` of size `S` can be converted into a
> refutation of `F` of width `≤ w0width F + Nat.log 2 S`.

It is proved by the classical Ben-Sasson-Wigderson tree argument (BW 1999,
"Short proofs are narrow", STOC 1999): strong induction on a halving parameter
`k` with `size ≤ 2^k`, using RESTRICTION of the derivation tree by a variable,
and recombining the two restricted refutations by reintroducing the pivot (a
`+1` per halving level, giving the `log2 S` total).

We REUSE the restriction / lift machinery of `ResolutionCompleteness.lean`
(`restrict`, `restrictClause`, `restrictClause_no_x`, `mem_of_mem_restrictClause`,
`mem_removePivotSign_iff`, `resolveOn_all_pos_all_neg`).

Scope: this is a lower-bound enabling lemma for the tree-RESOLUTION proof system.
It is **NOT** P ≠ NP, **NOT** an NP/circuit lower bound.  No `sorry`, no `admit`,
no new `axiom`, no smuggled / circular hypothesis.
-/

namespace PvNP
namespace CNFResolution
namespace ResolutionSizeWidth

open CNFModel
open PvNP.CNFResolution
open PvNP.CNFResolution.Completeness

/-! ## 1. Restriction of a derivation TREE by a variable assignment `x := b`

Given a `Valid F` tree `T`, we produce a `Valid (restrict x b F)` tree `T'` of
size `≤ size T`, whose conclusion mentions no `x` and is contained in
`T.conclusion`.

This mirrors the existing `Completeness.lift` lemma (which goes the OTHER way,
restricted → original) and uses the same robust *membership-invariant* technique
to cope with the rigid `resolveOn` semantics:
* A `hyp c` leaf restricts to a `hyp` of the restricted clause if `c` survives;
  if `c` is satisfied by `x := b` (so it would be dropped) we cannot keep it as a
  `hyp`, but in that case **every** literal of the filtered clause is irrelevant
  — actually the clause is satisfied, so it should vanish.  We handle this by
  observing the conclusion membership invariant: a dropped clause contributes the
  literal `litOf x b ∈ c`; we therefore expose, for the leaf case, that either
  `c` survives (then `hyp` of restricted clause works) **or** `c` is satisfied and
  we report it by returning a `hyp` of the surviving clause that is still a member
  of `restrict x b F` whenever it is nonempty.  See the proof.
* A `resolve x L R` node (pivot = x): the resolution is vacuous under `x := b`;
  we recurse into ONE side and the membership invariant absorbs the dropped
  pivot literal exactly as `lift` does.
* A `resolve p L R` node with `p ≠ x`: recurse into both; if both restricted
  pivot literals survive, resolve on `p`; otherwise weaken to the side whose
  pivot literal vanished (mirrors `lift`).
-/

/-! ### `derivWidth` interface lemmas -/

private theorem foldl_max_le_iff_aux {bound : Nat} :
    ∀ (l : List Nat) (acc : Nat),
      l.foldl max acc ≤ bound ↔ acc ≤ bound ∧ ∀ x ∈ l, x ≤ bound := by
  intro l
  induction l with
  | nil => intro acc; simp
  | cons hd tl ih =>
      intro acc
      rw [List.foldl_cons, ih (max acc hd)]
      constructor
      · rintro ⟨hm, htl⟩
        rw [max_le_iff] at hm
        exact ⟨hm.1, by
          intro x hx
          rcases List.mem_cons.mp hx with rfl | hx
          · exact hm.2
          · exact htl x hx⟩
      · rintro ⟨hacc, hall⟩
        refine ⟨by rw [max_le_iff]; exact ⟨hacc, hall hd (List.mem_cons_self _ _)⟩, ?_⟩
        intro x hx; exact hall x (List.mem_cons_of_mem _ hx)

/-- `derivWidth t ≤ B` iff every source-line clause of `t` has width `≤ B`. -/
theorem derivWidth_le_iff {n : Nat} (t : ResolutionDerivTree n) (B : Nat) :
    derivWidth t ≤ B ↔ ∀ c ∈ t.sourceLineClauses, clauseWidth c ≤ B := by
  unfold derivWidth
  rw [foldl_max_le_iff_aux]
  constructor
  · rintro ⟨_, hall⟩ c hc
    exact hall (clauseWidth c) (List.mem_map_of_mem clauseWidth hc)
  · intro hall
    refine ⟨Nat.zero_le _, ?_⟩
    intro w hw
    rw [List.mem_map] at hw
    obtain ⟨c, hc, rfl⟩ := hw
    exact hall c hc

/-- The source-line clauses of a `resolve` node. -/
theorem sourceLineClauses_resolve {n : Nat} (p : Fin n)
    (L R : ResolutionDerivTree n) :
    (ResolutionDerivTree.resolve p L R).sourceLineClauses
      = L.sourceLineClauses ++ R.sourceLineClauses
        ++ [resolveOn p L.conclusion R.conclusion] := rfl

/-- `clauseWidth` as a `Finset` cardinality of the variable set. -/
theorem clauseWidth_eq_card {n : Nat} (c : Clause n) :
    clauseWidth c = (c.map (·.var)).toFinset.card := by
  unfold clauseWidth
  rw [List.card_toFinset]


/-- The variable `Finset` of a clause. -/
private def varFinset {n : Nat} (c : Clause n) : Finset (Fin n) :=
  (c.map (·.var)).toFinset

private theorem mem_varFinset {n : Nat} {c : Clause n} {v : Fin n} :
    v ∈ varFinset c ↔ ∃ l ∈ c, l.var = v := by
  unfold varFinset
  rw [List.mem_toFinset, List.mem_map]

/-- **Per-clause width increase.**  If every literal of `c'` is a literal of `c`
or the single extra literal `litOf x s`, then `clauseWidth c' ≤ clauseWidth c + 1`. -/
theorem clauseWidth_le_succ_of_sub {n : Nat} (x : Fin n) (s : Bool)
    {c c' : Clause n}
    (h : ∀ l ∈ c', l ∈ c ∨ l = litOf x s) :
    clauseWidth c' ≤ clauseWidth c + 1 := by
  have hsub : varFinset c' ⊆ insert x (varFinset c) := by
    intro v hv
    rw [mem_varFinset] at hv
    obtain ⟨l, hl, hlv⟩ := hv
    rcases h l hl with hin | heq
    · exact Finset.mem_insert_of_mem (mem_varFinset.mpr ⟨l, hin, hlv⟩)
    · subst heq; simp only [litOf] at hlv; subst hlv; exact Finset.mem_insert_self _ _
  rw [clauseWidth_eq_card c', clauseWidth_eq_card c]
  calc (c'.map (·.var)).toFinset.card
      = (varFinset c').card := rfl
    _ ≤ (insert x (varFinset c)).card := Finset.card_le_card hsub
    _ ≤ (varFinset c).card + 1 := Finset.card_insert_le _ _
    _ = (c.map (·.var)).toFinset.card + 1 := rfl

/-- A literal of a clause survives the clause-restriction filter iff its variable
is not `x`. -/
private theorem mem_filter_no_x {n : Nat} {x : Fin n} {c : Clause n}
    {l : Literal n} :
    l ∈ c.filter (fun l => !decide (l.var = x)) ↔ l ∈ c ∧ l.var ≠ x := by
  rw [List.mem_filter]
  constructor
  · rintro ⟨hmem, hk⟩
    refine ⟨hmem, ?_⟩
    intro hx; simp [hx] at hk
  · rintro ⟨hmem, hx⟩
    exact ⟨hmem, by simp [hx]⟩

/-- The "restriction outcome" for a tree `T` whose root derives `T.conclusion`,
under `x := b`: EITHER the conclusion is already satisfied (it contains the true
literal `litOf x b`, so `T` is dead under the restriction), OR we have a genuine
`Valid (restrict x b F)` tree `T'` of no larger size whose conclusion is the
`x`-free part of `T.conclusion`. -/
def RestrictOutcome {n : Nat} (x : Fin n) (b : Bool) (F : CNF n)
    (T : ResolutionDerivTree n) : Prop :=
  litOf x b ∈ T.conclusion ∨
    ∃ T' : ResolutionDerivTree n,
      ResolutionDerivTree.Valid (restrict x b F) T' ∧
      T'.size ≤ T.size ∧
      ∀ l ∈ T'.conclusion, l ∈ T.conclusion ∧ l.var ≠ x

/-- **Tree restriction (mirrors `Completeness.lift`).**  Every `Valid F` tree has
a `RestrictOutcome`: it is either satisfied by `x := b` or restricts to a valid,
no-larger, `x`-free derivation over `restrict x b F`. -/
theorem restrictTree {n : Nat} (x : Fin n) (b : Bool) (F : CNF n) :
    ∀ (T : ResolutionDerivTree n),
      ResolutionDerivTree.Valid F T → RestrictOutcome x b F T := by
  intro T
  induction T with
  | hyp c =>
      intro hv
      have hcF : c ∈ F := hv
      by_cases hany : c.any (fun l => decide (l.var = x) && decide (l.sign = b))
      · -- c satisfied by x := b: litOf x b ∈ c = conclusion.
        left
        rw [List.any_eq_true] at hany
        obtain ⟨l, hlc, hl⟩ := hany
        rw [Bool.and_eq_true, decide_eq_true_eq, decide_eq_true_eq] at hl
        have : l = litOf x b := by
          cases l with | mk lv ls => simp [litOf]; exact ⟨hl.1, hl.2⟩
        show litOf x b ∈ c
        rw [← this]; exact hlc
      · -- c survives.
        right
        have hrc : restrictClause x b c
            = some (c.filter (fun l => !decide (l.var = x))) := by
          unfold restrictClause; rw [if_neg hany]
        have hmem : (c.filter (fun l => !decide (l.var = x))) ∈ restrict x b F := by
          rw [mem_restrict]; exact ⟨c, hcF, hrc⟩
        refine ⟨ResolutionDerivTree.hyp (c.filter (fun l => !decide (l.var = x))),
          hmem, by simp [ResolutionDerivTree.size], ?_⟩
        intro l hl
        have hl' : l ∈ c.filter (fun l => !decide (l.var = x)) := hl
        rw [mem_filter_no_x] at hl'
        exact hl'
  | resolve p left right ihL ihR =>
      intro hv
      rcases hv with ⟨hvl, hvr, hpos, hneg⟩
      have hLout := ihL hvl
      have hRout := ihR hvr
      by_cases hp : p = x
      · -- pivot = x: collapse to the side that is not the deleted polarity.
        subst hp
        cases b with
        | false =>
            -- x := false.  `negLit p` (= litOf p false) is true.  The RIGHT child
            -- contains negLit p, so right is satisfied; keep the LEFT outcome and
            -- strip the (now-removed) posLit p.
            -- Conclusion = resolveOn p left.concl right.concl removes posLit p (left)
            -- and negLit p (right).  litOf p false = negLit p is NOT in the
            -- conclusion necessarily, so we cannot be in the satisfied case; we use
            -- the LEFT child's outcome.
            rcases hLout with hLsat | ⟨L', hLvalid, hLsize, hLconcl⟩
            · -- left satisfied by x:=false ⟹ negLit p ∈ left.conclusion.  But then
              -- the resolvent's left part removes posLit p (sign true), keeping
              -- negLit p, so negLit p ∈ conclusion ⟹ this node is satisfied.
              left
              show litOf p false ∈ resolveOn p left.conclusion right.conclusion
              have : litOf p false = negLit p := by simp [litOf, negLit]
              rw [this]
              unfold resolveOn; rw [List.mem_append]; left
              rw [mem_removePivotSign_iff]
              refine ⟨by rw [← this]; exact hLsat, ?_⟩
              rintro ⟨_, hsgn⟩; simp [negLit] at hsgn
            · right
              refine ⟨L', hLvalid, by
                show L'.size ≤ ResolutionDerivTree.size (.resolve p left right)
                simp only [ResolutionDerivTree.size]; omega, ?_⟩
              intro l hl
              obtain ⟨hlin, hlx⟩ := hLconcl l hl
              refine ⟨?_, hlx⟩
              show l ∈ resolveOn p left.conclusion right.conclusion
              unfold resolveOn; rw [List.mem_append]; left
              rw [mem_removePivotSign_iff]
              exact ⟨hlin, by rintro ⟨hv1, _⟩; exact hlx hv1⟩
        | true =>
            -- x := true.  litOf p true = posLit p is true; LEFT child (posLit p) is
            -- satisfied; keep the RIGHT outcome.
            rcases hRout with hRsat | ⟨R', hRvalid, hRsize, hRconcl⟩
            · left
              show litOf p true ∈ resolveOn p left.conclusion right.conclusion
              have : litOf p true = posLit p := by simp [litOf, posLit]
              rw [this]
              unfold resolveOn; rw [List.mem_append]; right
              rw [mem_removePivotSign_iff]
              refine ⟨by rw [← this]; exact hRsat, ?_⟩
              rintro ⟨_, hsgn⟩; simp [posLit] at hsgn
            · right
              refine ⟨R', hRvalid, by
                show R'.size ≤ ResolutionDerivTree.size (.resolve p left right)
                simp only [ResolutionDerivTree.size]; omega, ?_⟩
              intro l hl
              obtain ⟨hlin, hlx⟩ := hRconcl l hl
              refine ⟨?_, hlx⟩
              show l ∈ resolveOn p left.conclusion right.conclusion
              unfold resolveOn; rw [List.mem_append]; right
              rw [mem_removePivotSign_iff]
              exact ⟨hlin, by rintro ⟨hv1, _⟩; exact hlx hv1⟩
      · -- p ≠ x.
        -- If either child is satisfied, the resolvent keeps its x-literal, so the
        -- node is satisfied.  Otherwise both restrict; resolve on p (weaken if a
        -- pivot literal vanished).
        rcases hLout with hLsat | ⟨L', hLvalid, hLsize, hLconcl⟩
        · -- left satisfied: litOf x b ∈ left.conclusion, var = x ≠ p, survives.
          left
          show litOf x b ∈ resolveOn p left.conclusion right.conclusion
          unfold resolveOn; rw [List.mem_append]; left
          rw [mem_removePivotSign_iff]
          refine ⟨hLsat, ?_⟩
          rintro ⟨hv1, _⟩; exact hp (by simpa [litOf] using hv1.symm ▸ rfl)
        · rcases hRout with hRsat | ⟨R', hRvalid, hRsize, hRconcl⟩
          · -- right satisfied: litOf x b ∈ right.conclusion, var = x ≠ p, survives.
            left
            show litOf x b ∈ resolveOn p left.conclusion right.conclusion
            unfold resolveOn; rw [List.mem_append]; right
            rw [mem_removePivotSign_iff]
            refine ⟨hRsat, ?_⟩
            rintro ⟨hv1, _⟩; exact hp (by simpa [litOf] using hv1.symm ▸ rfl)
          · -- both restrict.  Resolve on p, weakening on missing pivot literals.
            right
            rcases Classical.em (posLit p ∈ L'.conclusion) with hLmem | hLmem
            · rcases Classical.em (negLit p ∈ R'.conclusion) with hRmem | hRmem
              · refine ⟨ResolutionDerivTree.resolve p L' R',
                  ⟨hLvalid, hRvalid, hLmem, hRmem⟩, by
                    show ResolutionDerivTree.size (.resolve p L' R')
                      ≤ ResolutionDerivTree.size (.resolve p left right)
                    simp only [ResolutionDerivTree.size]; omega, ?_⟩
                intro l hl
                have hl' : l ∈ resolveOn p L'.conclusion R'.conclusion := hl
                unfold resolveOn at hl'
                rw [List.mem_append] at hl'
                refine ⟨?_, ?_⟩
                · show l ∈ resolveOn p left.conclusion right.conclusion
                  unfold resolveOn; rw [List.mem_append]
                  rcases hl' with hLf | hRf
                  · left; rw [mem_removePivotSign_iff] at hLf ⊢
                    exact ⟨(hLconcl l hLf.1).1, hLf.2⟩
                  · right; rw [mem_removePivotSign_iff] at hRf ⊢
                    exact ⟨(hRconcl l hRf.1).1, hRf.2⟩
                · rcases hl' with hLf | hRf
                  · rw [mem_removePivotSign_iff] at hLf; exact (hLconcl l hLf.1).2
                  · rw [mem_removePivotSign_iff] at hRf; exact (hRconcl l hRf.1).2
              · -- negLit p ∉ R'.conclusion: weaken to R'.
                refine ⟨R', hRvalid, by
                  show R'.size ≤ ResolutionDerivTree.size (.resolve p left right)
                  simp only [ResolutionDerivTree.size]; omega, ?_⟩
                intro l hl
                obtain ⟨hlin, hlx⟩ := hRconcl l hl
                refine ⟨?_, hlx⟩
                show l ∈ resolveOn p left.conclusion right.conclusion
                unfold resolveOn; rw [List.mem_append]; right
                rw [mem_removePivotSign_iff]
                refine ⟨hlin, ?_⟩
                rintro ⟨hv1, hv2⟩
                apply hRmem
                have : l = negLit p := by
                  cases l with | mk lv ls => simp [negLit]; exact ⟨hv1, hv2⟩
                rw [← this]; exact hl
            · -- posLit p ∉ L'.conclusion: weaken to L'.
              refine ⟨L', hLvalid, by
                show L'.size ≤ ResolutionDerivTree.size (.resolve p left right)
                simp only [ResolutionDerivTree.size]; omega, ?_⟩
              intro l hl
              obtain ⟨hlin, hlx⟩ := hLconcl l hl
              refine ⟨?_, hlx⟩
              show l ∈ resolveOn p left.conclusion right.conclusion
              unfold resolveOn; rw [List.mem_append]; left
              rw [mem_removePivotSign_iff]
              refine ⟨hlin, ?_⟩
              rintro ⟨hv1, hv2⟩
              apply hLmem
              have : l = posLit p := by
                cases l with | mk lv ls => simp [posLit]; exact ⟨hv1, hv2⟩
              rw [← this]; exact hl

/-! ## 2. Width-tracking lift: lifting a `restrict x b F` derivation back to `F`
costs at most `+1` in width (only the reintroduced literal `litOf x (!b)`). -/

/-- **Width-tracking lift.**  Mirrors `Completeness.lift`, but additionally
records a PER-NODE membership invariant: every source-line clause `c'` of the
lifted tree `T'` is contained, literal-by-literal, in some source-line clause `c`
of the original `T` together with the single reintroduced literal `litOf x (!b)`.
This yields `derivWidth T' ≤ derivWidth T + 1`. -/
theorem liftWidth {n : Nat} (x : Fin n) (b : Bool) (F : CNF n) :
    ∀ (T : ResolutionDerivTree n),
      ResolutionDerivTree.Valid (restrict x b F) T →
      ∃ T' : ResolutionDerivTree n,
        ResolutionDerivTree.Valid F T' ∧
        (∀ l ∈ T'.conclusion, l ∈ T.conclusion ∨ l = litOf x (!b)) ∧
        (∀ c' ∈ T'.sourceLineClauses,
          ∃ c ∈ T.sourceLineClauses,
            ∀ l ∈ c', l ∈ c ∨ l = litOf x (!b)) := by
  intro T
  induction T with
  | hyp c =>
      intro hv
      have hc : c ∈ restrict x b F := hv
      rw [mem_restrict] at hc
      obtain ⟨c0, hc0, hrc⟩ := hc
      -- The core membership fact: every literal of c0 is in c or is litOf x (!b).
      have hmemfact : ∀ l ∈ c0, l ∈ c ∨ l = litOf x (!b) := by
        intro l hl
        unfold restrictClause at hrc
        by_cases hany : c0.any (fun l => decide (l.var = x) && decide (l.sign = b))
        · rw [if_pos hany] at hrc; exact absurd hrc (by simp)
        · rw [if_neg hany] at hrc
          injection hrc with hc'
          by_cases hlx : l.var = x
          · right
            have hsignb : l.sign ≠ b := by
              intro hsb
              apply hany
              rw [List.any_eq_true]
              exact ⟨l, hl, by simp [hlx, hsb]⟩
            have : l.sign = !b := by cases hb : b <;> cases hs : l.sign <;> simp_all
            unfold litOf
            cases l with | mk lv ls => simp_all
          · left
            rw [← hc', List.mem_filter]
            exact ⟨hl, by simp [hlx]⟩
      refine ⟨ResolutionDerivTree.hyp c0, hc0, ?_, ?_⟩
      · -- conclusion (hyp c0) = c0
        intro l hl
        exact hmemfact l hl
      · intro c' hc'
        simp only [ResolutionDerivTree.sourceLineClauses, List.mem_singleton] at hc' ⊢
        subst hc'
        exact ⟨c, by simp [ResolutionDerivTree.sourceLineClauses], hmemfact⟩
  | resolve pivot left right ihL ihR =>
      intro hv
      rcases hv with ⟨hvl, hvr, hpos, hneg⟩
      obtain ⟨L', hL'valid, hL'concl, hL'nodes⟩ := ihL hvl
      obtain ⟨R', hR'valid, hR'concl, hR'nodes⟩ := ihR hvr
      -- A helper to embed a child's source-line node-invariant into the parent's.
      have embedL : ∀ c' ∈ L'.sourceLineClauses,
          ∃ c ∈ (ResolutionDerivTree.resolve pivot left right).sourceLineClauses,
            ∀ l ∈ c', l ∈ c ∨ l = litOf x (!b) := by
        intro c' hc'
        obtain ⟨c, hcin, hinv⟩ := hL'nodes c' hc'
        refine ⟨c, ?_, hinv⟩
        rw [sourceLineClauses_resolve]; rw [List.mem_append]; left
        rw [List.mem_append]; left; exact hcin
      have embedR : ∀ c' ∈ R'.sourceLineClauses,
          ∃ c ∈ (ResolutionDerivTree.resolve pivot left right).sourceLineClauses,
            ∀ l ∈ c', l ∈ c ∨ l = litOf x (!b) := by
        intro c' hc'
        obtain ⟨c, hcin, hinv⟩ := hR'nodes c' hc'
        refine ⟨c, ?_, hinv⟩
        rw [sourceLineClauses_resolve]; rw [List.mem_append]; left
        rw [List.mem_append]; right; exact hcin
      rcases Classical.em (posLit pivot ∈ L'.conclusion) with hLmem | hLmem
      · rcases Classical.em (negLit pivot ∈ R'.conclusion) with hRmem | hRmem
        · -- resolve on pivot.
          refine ⟨ResolutionDerivTree.resolve pivot L' R',
            ⟨hL'valid, hR'valid, hLmem, hRmem⟩, ?_, ?_⟩
          · intro l hl
            have hl' : l ∈ resolveOn pivot L'.conclusion R'.conclusion := hl
            unfold resolveOn at hl'
            rw [List.mem_append] at hl'
            show l ∈ resolveOn pivot left.conclusion right.conclusion ∨ l = litOf x (!b)
            rcases hl' with hLf | hRf
            · rw [mem_removePivotSign_iff] at hLf
              rcases hL'concl l hLf.1 with hin | heq
              · left; unfold resolveOn; rw [List.mem_append]; left
                rw [mem_removePivotSign_iff]; exact ⟨hin, hLf.2⟩
              · right; exact heq
            · rw [mem_removePivotSign_iff] at hRf
              rcases hR'concl l hRf.1 with hin | heq
              · left; unfold resolveOn; rw [List.mem_append]; right
                rw [mem_removePivotSign_iff]; exact ⟨hin, hRf.2⟩
              · right; exact heq
          · intro c' hc'
            rw [sourceLineClauses_resolve, List.mem_append, List.mem_append] at hc'
            rcases hc' with (hcL | hcR) | hcRoot
            · exact embedL c' hcL
            · exact embedR c' hcR
            · -- c' is the new root resolvent.
              rw [List.mem_singleton] at hcRoot
              subst hcRoot
              -- Map to the original root resolvent.
              refine ⟨resolveOn pivot left.conclusion right.conclusion, ?_, ?_⟩
              · rw [sourceLineClauses_resolve, List.mem_append, List.mem_append]
                right; exact List.mem_singleton.mpr rfl
              · intro l hl
                have hl' : l ∈ resolveOn pivot L'.conclusion R'.conclusion := hl
                unfold resolveOn at hl'
                rw [List.mem_append] at hl'
                show l ∈ resolveOn pivot left.conclusion right.conclusion ∨ l = litOf x (!b)
                rcases hl' with hLf | hRf
                · rw [mem_removePivotSign_iff] at hLf
                  rcases hL'concl l hLf.1 with hin | heq
                  · left; unfold resolveOn; rw [List.mem_append]; left
                    rw [mem_removePivotSign_iff]; exact ⟨hin, hLf.2⟩
                  · right; exact heq
                · rw [mem_removePivotSign_iff] at hRf
                  rcases hR'concl l hRf.1 with hin | heq
                  · left; unfold resolveOn; rw [List.mem_append]; right
                    rw [mem_removePivotSign_iff]; exact ⟨hin, hRf.2⟩
                  · right; exact heq
        · -- negLit pivot ∉ R'.conclusion: use R'.
          refine ⟨R', hR'valid, ?_, ?_⟩
          · intro l hl
            show l ∈ resolveOn pivot left.conclusion right.conclusion ∨ l = litOf x (!b)
            rcases hR'concl l hl with hin | heq
            · left; unfold resolveOn; rw [List.mem_append]; right
              rw [mem_removePivotSign_iff]
              refine ⟨hin, ?_⟩
              rintro ⟨hv1, hv2⟩
              apply hRmem
              have : l = negLit pivot := by
                cases l with | mk lv ls => simp [negLit]; exact ⟨hv1, hv2⟩
              rw [← this]; exact hl
            · right; exact heq
          · exact embedR
      · -- posLit pivot ∉ L'.conclusion: use L'.
        refine ⟨L', hL'valid, ?_, ?_⟩
        · intro l hl
          show l ∈ resolveOn pivot left.conclusion right.conclusion ∨ l = litOf x (!b)
          rcases hL'concl l hl with hin | heq
          · left; unfold resolveOn; rw [List.mem_append]; left
            rw [mem_removePivotSign_iff]
            refine ⟨hin, ?_⟩
            rintro ⟨hv1, hv2⟩
            apply hLmem
            have : l = posLit pivot := by
              cases l with | mk lv ls => simp [posLit]; exact ⟨hv1, hv2⟩
            rw [← this]; exact hl
          · right; exact heq
        · exact embedL

/-- `derivWidth` of a width-tracking lift is at most `derivWidth T + 1`. -/
theorem liftWidth_derivWidth_le {n : Nat} (x : Fin n) (b : Bool) (F : CNF n)
    (T : ResolutionDerivTree n) (hv : ResolutionDerivTree.Valid (restrict x b F) T) :
    ∃ T' : ResolutionDerivTree n,
      ResolutionDerivTree.Valid F T' ∧
      (∀ l ∈ T'.conclusion, l ∈ T.conclusion ∨ l = litOf x (!b)) ∧
      derivWidth T' ≤ derivWidth T + 1 := by
  obtain ⟨T', hvalid, hconcl, hnodes⟩ := liftWidth x b F T hv
  refine ⟨T', hvalid, hconcl, ?_⟩
  rw [derivWidth_le_iff]
  intro c' hc'
  obtain ⟨c, hcin, hinv⟩ := hnodes c' hc'
  calc clauseWidth c' ≤ clauseWidth c + 1 :=
        clauseWidth_le_succ_of_sub x (!b) hinv
    _ ≤ derivWidth T + 1 :=
        Nat.add_le_add_right (clauseWidth_le_derivWidth T hcin) 1

/-! ## 3. Asymmetric lift against a derived unit clause (the `+0` side)

To get the EXACT `+log` (not `+2log`) we lift the LARGE-side restricted refutation
back to `F` WITHOUT paying `+1`: instead of re-attaching the deleted literal
`litOf x (!b)` to every clause, we RESOLVE it away at the leaves against a supplied
derivation `D` of the opposite unit `{litOf x b}`.  The resulting refutation of `F`
has width `≤ max (derivWidth T) (max (derivWidth D) (w0width F))`. -/

/-- `clauseWidth` is monotone under sublists in the literal-membership sense: a
clause whose literals are all in `c` has width `≤ clauseWidth c`. -/
theorem clauseWidth_le_of_sub {n : Nat} {c d : Clause n}
    (h : ∀ l ∈ d, l ∈ c) : clauseWidth d ≤ clauseWidth c := by
  rw [clauseWidth_eq_card c, clauseWidth_eq_card d]
  apply Finset.card_le_card
  intro v hv
  rw [List.mem_toFinset, List.mem_map] at hv ⊢
  obtain ⟨l, hl, rfl⟩ := hv
  exact ⟨l, h l hl, rfl⟩

/-- `litOf` sign accessor facts. -/
private theorem litOf_var {n : Nat} (x : Fin n) (s : Bool) : (litOf x s).var = x := rfl
private theorem litOf_sign {n : Nat} (x : Fin n) (s : Bool) : (litOf x s).sign = s := rfl

/-- Membership in `removePivotSign x s D` when every literal of `D` equals
`litOf x s`: the result is empty. -/
private theorem removePivotSign_unit_self {n : Nat} (x : Fin n) (s : Bool)
    {D : Clause n} (hD : ∀ l ∈ D, l = litOf x s) :
    removePivotSign x s D = [] := by
  rw [List.eq_nil_iff_forall_not_mem]
  intro l hl
  rw [mem_removePivotSign_iff] at hl
  have := hD l hl.1
  exact hl.2 ⟨by rw [this, litOf_var], by rw [this, litOf_sign]⟩

/-- For a clause `c0` whose only `x`-literal (if any) is `litOf x (!b)`, resolving
it on `x` with a unit `D ⊆ {litOf x b}` yields exactly the `x`-free part of `c0`. -/
private theorem resolveOn_graft_chars {n : Nat} (x : Fin n) (b : Bool)
    {c0 D : Clause n}
    (hD : ∀ l ∈ D, l = litOf x b)
    (hc0 : ∀ l ∈ c0, l.var = x → l = litOf x (!b)) :
    ∀ l, (l ∈ resolveOn x (if b then D else c0) (if b then c0 else D) ↔
      (l ∈ c0 ∧ l.var ≠ x)) := by
  intro l
  unfold resolveOn
  cases hb : b with
  | false =>
      -- resolveOn x c0 D = removePivotSign x true c0 ++ removePivotSign x false D
      simp only [Bool.false_eq_true, if_false]
      rw [removePivotSign_unit_self x false (by simpa [hb] using hD), List.append_nil,
        mem_removePivotSign_iff]
      constructor
      · rintro ⟨hmem, hne⟩
        refine ⟨hmem, ?_⟩
        intro hx
        -- l.var = x ⟹ l = litOf x (!false) = litOf x true = posLit-ish, sign true ⟹ contradiction with hne
        have := hc0 l hmem hx
        simp only [hb, Bool.not_false] at this
        exact hne ⟨hx, by rw [this, litOf_sign]⟩
      · rintro ⟨hmem, hx⟩
        exact ⟨hmem, by rintro ⟨hv, _⟩; exact hx hv⟩
  | true =>
      -- resolveOn x D c0 = removePivotSign x true D ++ removePivotSign x false c0
      simp only [if_true]
      rw [removePivotSign_unit_self x true (by simpa [hb] using hD), List.nil_append,
        mem_removePivotSign_iff]
      constructor
      · rintro ⟨hmem, hne⟩
        refine ⟨hmem, ?_⟩
        intro hx
        have := hc0 l hmem hx
        simp only [hb, Bool.not_true] at this
        exact hne ⟨hx, by rw [this, litOf_sign]⟩
      · rintro ⟨hmem, hx⟩
        exact ⟨hmem, by rintro ⟨hv, _⟩; exact hx hv⟩

/-- Every axiom clause of `F` has width `≤ w0width F`. -/
theorem clauseWidth_le_w0width {n : Nat} {F : CNF n} {c : Clause n} (hc : c ∈ F) :
    clauseWidth c ≤ w0width F := by
  unfold w0width
  have hmem : clauseWidth c ∈ F.map clauseWidth := List.mem_map_of_mem clauseWidth hc
  -- foldl max dominates each element
  have : ∀ (l : List Nat) (acc x : Nat), x ∈ l → x ≤ l.foldl max acc := by
    intro l
    induction l with
    | nil => intro acc x hx; simp at hx
    | cons hd tl ih =>
        intro acc x hx
        rcases List.mem_cons.mp hx with rfl | hx
        · have hstep : ∀ (m : List Nat) (a : Nat), a ≤ m.foldl max a := by
            intro m
            induction m with
            | nil => intro a; simp
            | cons h t ih2 => intro a; exact le_trans (le_max_left a h) (ih2 (max a h))
          exact le_trans (le_max_right acc x) (hstep tl (max acc x))
        · exact ih (max acc hd) x hx
  exact this (F.map clauseWidth) 0 (clauseWidth c) hmem

/-- **Asymmetric unit lift.**  Let `D` be a `Valid F` derivation of the unit
`{litOf x b}` (every literal of `D.conclusion` is `litOf x b`).  Then any
`Valid (restrict x b F)` tree `T` lifts to a `Valid F` tree `T'` whose conclusion
is contained in `T.conclusion` (NO extra literal — the deleted literal is resolved
away against `D`), and every source-line clause of which has width
`≤ max (derivWidth T) (max (derivWidth D) (w0width F))`. -/
theorem liftUnit {n : Nat} (x : Fin n) (b : Bool) (F : CNF n)
    (D : ResolutionDerivTree n) (hDvalid : ResolutionDerivTree.Valid F D)
    (hDconcl : ∀ l ∈ D.conclusion, l = litOf x b)
    (hDunit : litOf x b ∈ D.conclusion) :
    ∀ (T : ResolutionDerivTree n),
      ResolutionDerivTree.Valid (restrict x b F) T →
      ∃ T' : ResolutionDerivTree n,
        ResolutionDerivTree.Valid F T' ∧
        (∀ l ∈ T'.conclusion, l ∈ T.conclusion) ∧
        (∀ c' ∈ T'.sourceLineClauses,
          clauseWidth c' ≤ max (derivWidth T) (max (derivWidth D) (w0width F))) := by
  intro T
  induction T with
  | hyp c =>
      intro hv
      have hc : c ∈ restrict x b F := hv
      rw [mem_restrict] at hc
      obtain ⟨c0, hc0, hrc⟩ := hc
      -- c0 ∈ F.  c0 survives: restrictClause x b c0 = some c, c = c0.filter (var ≠ x).
      have hany : ¬ c0.any (fun l => decide (l.var = x) && decide (l.sign = b)) := by
        intro hany
        unfold restrictClause at hrc; rw [if_pos hany] at hrc; exact absurd hrc (by simp)
      have hcfilter : c = c0.filter (fun l => !decide (l.var = x)) := by
        unfold restrictClause at hrc; rw [if_neg hany] at hrc; injection hrc with h; exact h.symm
      -- Every x-literal of c0 is litOf x (!b) (it can't be litOf x b else satisfied).
      have hc0x : ∀ l ∈ c0, l.var = x → l = litOf x (!b) := by
        intro l hl hlx
        have hsgn : l.sign ≠ b := by
          intro hsb; apply hany; rw [List.any_eq_true]
          exact ⟨l, hl, by simp [hlx, hsb]⟩
        have : l.sign = !b := by cases hb : b <;> cases hs : l.sign <;> simp_all
        cases l with | mk lv ls => simp only [litOf]; simp_all
      rcases Classical.em (litOf x (!b) ∈ c0) with hx_in | hx_in
      · -- Graft: resolve c0 with D on x.
        -- posLit x ∈ left side, negLit x ∈ right side of the resolve.
        -- left/right chosen by b: if b then (D, hyp c0) else (hyp c0, D).
        refine ⟨if b then ResolutionDerivTree.resolve x D (ResolutionDerivTree.hyp c0)
                  else ResolutionDerivTree.resolve x (ResolutionDerivTree.hyp c0) D,
          ?_, ?_, ?_⟩
        · -- Valid F
          cases hb : b with
          | false =>
              simp only [Bool.false_eq_true, if_false]
              refine ⟨hc0, hDvalid, ?_, ?_⟩
              · -- posLit x ∈ c0
                have : litOf x (!b) = posLit x := by rw [hb]; simp [litOf, posLit]
                show posLit x ∈ ResolutionDerivTree.conclusion (.hyp c0)
                simp only [ResolutionDerivTree.conclusion]; rw [← this]; exact hx_in
              · -- negLit x ∈ D.conclusion
                have : litOf x b = negLit x := by rw [hb]; simp [litOf, negLit]
                rw [← this]; exact hDunit
          | true =>
              simp only [if_true]
              refine ⟨hDvalid, hc0, ?_, ?_⟩
              · have : litOf x b = posLit x := by rw [hb]; simp [litOf, posLit]
                rw [← this]; exact hDunit
              · have : litOf x (!b) = negLit x := by rw [hb]; simp [litOf, negLit]
                show negLit x ∈ ResolutionDerivTree.conclusion (.hyp c0)
                simp only [ResolutionDerivTree.conclusion]; rw [← this]; exact hx_in
        · -- conclusion ⊆ c (= conclusion of hyp c).
          intro l hl
          show l ∈ c
          rw [hcfilter, mem_filter_no_x]
          -- conclusion of graft = resolveOn x (if b then D.concl else c0) (if b then c0 else D.concl)
          have hlres : l ∈ resolveOn x (if b then D.conclusion else c0)
              (if b then c0 else D.conclusion) := by
            cases hb : b with
            | false =>
                simp only [Bool.false_eq_true, if_false]
                simpa only [ResolutionDerivTree.conclusion, hb, Bool.false_eq_true,
                  if_false] using hl
            | true =>
                simp only [if_true]
                simpa only [ResolutionDerivTree.conclusion, hb, if_true] using hl
          rw [resolveOn_graft_chars x b hDconcl hc0x l] at hlres
          exact hlres
        · -- width of each source-line clause.
          intro c' hc'
          -- sourceLineClauses of graft: D's lines, [c0], and the resolvent.
          have hbound_c0 : clauseWidth c0 ≤ w0width F := clauseWidth_le_w0width hc0
          have hsrc : c' = c0 ∨ c' ∈ D.sourceLineClauses ∨
              c' = resolveOn x (if b then D.conclusion else c0)
                (if b then c0 else D.conclusion) := by
            cases b with
            | false =>
                simp only [Bool.false_eq_true, if_false, sourceLineClauses_resolve,
                  ResolutionDerivTree.sourceLineClauses, ResolutionDerivTree.conclusion,
                  List.mem_append, List.mem_singleton, List.mem_cons, List.nil_append,
                  List.append_assoc, List.cons_append] at hc' ⊢
                rcases hc' with hc' | hc' | hc'
                · exact Or.inl hc'
                · exact Or.inr (Or.inl hc')
                · exact Or.inr (Or.inr (by tauto))
            | true =>
                simp only [if_true, sourceLineClauses_resolve,
                  ResolutionDerivTree.sourceLineClauses, ResolutionDerivTree.conclusion,
                  List.mem_append, List.mem_singleton, List.mem_cons, List.nil_append,
                  List.append_assoc, List.cons_append] at hc' ⊢
                rcases hc' with hc' | hc' | hc'
                · exact Or.inr (Or.inl hc')
                · exact Or.inl hc'
                · exact Or.inr (Or.inr (by tauto))
          rcases hsrc with rfl | hDsrc | rfl
          · exact le_trans hbound_c0 (le_max_of_le_right (le_max_of_le_right (le_refl _)))
          · exact le_trans (clauseWidth_le_derivWidth D hDsrc)
              (le_max_of_le_right (le_max_of_le_left (le_refl _)))
          · -- resolvent ⊆ c0 (var ≠ x part)
            have hsub : ∀ l ∈ resolveOn x (if b then D.conclusion else c0)
                (if b then c0 else D.conclusion), l ∈ c0 := by
              intro l hl; exact ((resolveOn_graft_chars x b hDconcl hc0x l).mp hl).1
            exact le_trans (clauseWidth_le_of_sub hsub)
              (le_trans hbound_c0 (le_max_of_le_right (le_max_of_le_right (le_refl _))))
      · -- c0 has no x-literal at all: c = c0; use hyp c0 directly.
        have hcc0 : c = c0 := by
          rw [hcfilter, List.filter_eq_self]
          intro l hl
          simp only [decide_eq_true_eq, Bool.not_eq_eq_eq_not, Bool.not_true,
            decide_eq_false_iff_not]
          intro hlx
          -- l.var = x ⟹ l = litOf x (!b) ∈ c0, contradicting hx_in
          exact hx_in (by rw [← hc0x l hl hlx]; exact hl)
        refine ⟨ResolutionDerivTree.hyp c0, hc0, ?_, ?_⟩
        · intro l hl; show l ∈ c; rw [hcc0]; exact hl
        · intro c' hc'
          simp only [ResolutionDerivTree.sourceLineClauses, List.mem_singleton] at hc'
          subst hc'
          exact le_trans (clauseWidth_le_w0width hc0)
            (le_max_of_le_right (le_max_of_le_right (le_refl _)))
  | resolve pivot left right ihL ihR =>
      intro hv
      rcases hv with ⟨hvl, hvr, hpos, hneg⟩
      obtain ⟨L', hL'valid, hL'concl, hL'nodes⟩ := ihL hvl
      obtain ⟨R', hR'valid, hR'concl, hR'nodes⟩ := ihR hvr
      -- Width bound transfers: derivWidth left ≤ derivWidth (resolve ...), etc.
      have hBL : ∀ w, w ≤ max (derivWidth left) (max (derivWidth D) (w0width F)) →
          w ≤ max (derivWidth (ResolutionDerivTree.resolve pivot left right))
            (max (derivWidth D) (w0width F)) := by
        intro w hw
        refine le_trans hw (max_le_max ?_ (le_refl _))
        rw [derivWidth_le_iff]
        intro c hc
        exact clauseWidth_le_derivWidth _ (by
          rw [sourceLineClauses_resolve, List.mem_append, List.mem_append]
          left; left; exact hc)
      have hBR : ∀ w, w ≤ max (derivWidth right) (max (derivWidth D) (w0width F)) →
          w ≤ max (derivWidth (ResolutionDerivTree.resolve pivot left right))
            (max (derivWidth D) (w0width F)) := by
        intro w hw
        refine le_trans hw (max_le_max ?_ (le_refl _))
        rw [derivWidth_le_iff]
        intro c hc
        exact clauseWidth_le_derivWidth _ (by
          rw [sourceLineClauses_resolve, List.mem_append, List.mem_append]
          left; right; exact hc)
      rcases Classical.em (posLit pivot ∈ L'.conclusion) with hLmem | hLmem
      · rcases Classical.em (negLit pivot ∈ R'.conclusion) with hRmem | hRmem
        · refine ⟨ResolutionDerivTree.resolve pivot L' R',
            ⟨hL'valid, hR'valid, hLmem, hRmem⟩, ?_, ?_⟩
          · intro l hl
            have hl' : l ∈ resolveOn pivot L'.conclusion R'.conclusion := hl
            unfold resolveOn at hl'
            rw [List.mem_append] at hl'
            show l ∈ resolveOn pivot left.conclusion right.conclusion
            unfold resolveOn; rw [List.mem_append]
            rcases hl' with hLf | hRf
            · left; rw [mem_removePivotSign_iff] at hLf ⊢
              exact ⟨hL'concl l hLf.1, hLf.2⟩
            · right; rw [mem_removePivotSign_iff] at hRf ⊢
              exact ⟨hR'concl l hRf.1, hRf.2⟩
          · intro c' hc'
            rw [sourceLineClauses_resolve, List.mem_append, List.mem_append] at hc'
            rcases hc' with (hcL | hcR) | hcRoot
            · exact hBL _ (hL'nodes c' hcL)
            · exact hBR _ (hR'nodes c' hcR)
            · rw [List.mem_singleton] at hcRoot; subst hcRoot
              -- root resolvent ⊆ original root resolvent
              have hsub : ∀ l ∈ resolveOn pivot L'.conclusion R'.conclusion,
                  l ∈ resolveOn pivot left.conclusion right.conclusion := by
                intro l hl
                unfold resolveOn at hl ⊢
                rw [List.mem_append] at hl ⊢
                rcases hl with hLf | hRf
                · left; rw [mem_removePivotSign_iff] at hLf ⊢
                  exact ⟨hL'concl l hLf.1, hLf.2⟩
                · right; rw [mem_removePivotSign_iff] at hRf ⊢
                  exact ⟨hR'concl l hRf.1, hRf.2⟩
              refine le_trans (clauseWidth_le_of_sub hsub) ?_
              refine le_max_of_le_left ?_
              exact clauseWidth_le_derivWidth _ (by
                rw [sourceLineClauses_resolve, List.mem_append, List.mem_append]
                right; exact List.mem_singleton.mpr rfl)
        · -- weaken to R'
          refine ⟨R', hR'valid, ?_, ?_⟩
          · intro l hl
            show l ∈ resolveOn pivot left.conclusion right.conclusion
            unfold resolveOn; rw [List.mem_append]; right
            rw [mem_removePivotSign_iff]
            refine ⟨hR'concl l hl, ?_⟩
            rintro ⟨hv1, hv2⟩
            apply hRmem
            have : l = negLit pivot := by cases l with | mk lv ls => simp [negLit]; exact ⟨hv1, hv2⟩
            rw [← this]; exact hl
          · intro c' hc'; exact hBR _ (hR'nodes c' hc')
      · -- weaken to L'
        refine ⟨L', hL'valid, ?_, ?_⟩
        · intro l hl
          show l ∈ resolveOn pivot left.conclusion right.conclusion
          unfold resolveOn; rw [List.mem_append]; left
          rw [mem_removePivotSign_iff]
          refine ⟨hL'concl l hl, ?_⟩
          rintro ⟨hv1, hv2⟩
          apply hLmem
          have : l = posLit pivot := by cases l with | mk lv ls => simp [posLit]; exact ⟨hv1, hv2⟩
          rw [← this]; exact hl
        · intro c' hc'; exact hBL _ (hL'nodes c' hc')

/-! ## 4. The main BW tree induction and `RestrictionNarrowsCore` -/

/-- Restriction never increases `w0width`: every restricted clause is a sub-clause
of an original axiom. -/
theorem w0width_restrict_le {n : Nat} (x : Fin n) (b : Bool) (F : CNF n) :
    w0width (restrict x b F) ≤ w0width F := by
  apply w0width_le
  intro d hd
  rw [mem_restrict] at hd
  obtain ⟨c, hc, hrc⟩ := hd
  -- d's literals are all in c, so clauseWidth d ≤ clauseWidth c ≤ w0width F.
  have hsub : ∀ l ∈ d, l ∈ c := fun l hl => mem_of_mem_restrictClause hrc hl
  exact le_trans (clauseWidth_le_of_sub hsub) (clauseWidth_le_w0width hc)

/-- When the whole resolvent `resolveOn x C0 C1` is empty, `C0` consists only of
`posLit x` and `C1` only of `negLit x`. -/
theorem all_pos_neg_of_resolveOn_nil {n : Nat} {x : Fin n} {C0 C1 : Clause n}
    (h : resolveOn x C0 C1 = []) :
    (∀ l ∈ C0, l = posLit x) ∧ (∀ l ∈ C1, l = negLit x) := by
  unfold resolveOn at h
  rw [List.append_eq_nil] at h
  refine ⟨?_, ?_⟩
  · intro l hl
    by_contra hne
    have : l ∈ removePivotSign x true C0 := by
      rw [mem_removePivotSign_iff]
      refine ⟨hl, ?_⟩
      rintro ⟨hv, hs⟩
      apply hne; cases l with | mk lv ls => simp [posLit] at *; exact ⟨hv, hs⟩
    rw [h.1] at this; exact (List.not_mem_nil l) this
  · intro l hl
    by_contra hne
    have : l ∈ removePivotSign x false C1 := by
      rw [mem_removePivotSign_iff]
      refine ⟨hl, ?_⟩
      rintro ⟨hv, hs⟩
      apply hne; cases l with | mk lv ls => simp [negLit] at *; exact ⟨hv, hs⟩
    rw [h.2] at this; exact (List.not_mem_nil l) this

/-- Restricting a subtree whose conclusion lies entirely on the literal
`litOf x (!b)` yields a genuine refutation of `restrict x b F` of size `≤ size T`.
(The polarity hypothesis rules out the `satisfied`-by-`x:=b` outcome.) -/
theorem restrictSubtree_refutation {n : Nat} (x : Fin n) (b : Bool) (F : CNF n)
    (T : ResolutionDerivTree n) (hv : ResolutionDerivTree.Valid F T)
    (hall : ∀ l ∈ T.conclusion, l = litOf x (!b)) :
    ∃ T' : ResolutionDerivTree n,
      ResolutionDerivTree.Valid (restrict x b F) T' ∧
      T'.conclusion = [] ∧ T'.size ≤ T.size := by
  rcases restrictTree x b F T hv with hsat | ⟨T', hT'valid, hT'size, hT'concl⟩
  · -- satisfied: litOf x b ∈ T.conclusion ⟹ litOf x b = litOf x (!b), impossible.
    exfalso
    have := hall (litOf x b) hsat
    have hne : litOf x b ≠ litOf x (!b) := by
      cases b <;> simp [litOf]
    exact hne this
  · refine ⟨T', hT'valid, ?_, hT'size⟩
    rw [List.eq_nil_iff_forall_not_mem]
    intro l hl
    obtain ⟨hlin, hlx⟩ := hT'concl l hl
    have := hall l hlin
    rw [this] at hlx
    exact hlx (by rw [litOf])

/-- The "narrow refutation" predicate: a refutation of `F` of width `≤ bound`. -/
private def HasNarrowRefutation {n : Nat} (F : CNF n) (bound : Nat) : Prop :=
  ∃ T' : ResolutionDerivTree n,
    ResolutionDerivTree.Valid F T' ∧ T'.conclusion = [] ∧ derivWidth T' ≤ bound

/--
**The combine step.**  Given a target width `Bound` with `w0width F ≤ Bound`, a
narrow refutation `rbig` of `restrict x bLarge F` of width `≤ Bound` (LARGE side),
and a narrow refutation `rsmall` of `restrict x (!bLarge) F` of width `≤ Bound - 1`
(SMALL side), produce a refutation of `F` of width `≤ Bound`.

The small side is lifted (`liftWidth`, `+1`) to a derivation `D` of the unit
`{litOf x bLarge}` of width `≤ Bound`; the large side is lifted against `D`
(`liftUnit`, `+0`). -/
theorem narrow_combine {n : Nat} (x : Fin n) (bLarge : Bool) (F : CNF n)
    (Bound : Nat) (hBoundpos : 1 ≤ Bound) (hw0 : w0width F ≤ Bound)
    (rbig : HasNarrowRefutation (restrict x bLarge F) Bound)
    (rsmall : HasNarrowRefutation (restrict x (!bLarge) F) (Bound - 1)) :
    HasNarrowRefutation F Bound := by
  obtain ⟨Tbig, hTbigV, hTbigE, hTbigW⟩ := rbig
  obtain ⟨Tsmall, hTsmallV, hTsmallE, hTsmallW⟩ := rsmall
  obtain ⟨D, hDvalid, hDconcl, hDwidth⟩ :=
    liftWidth_derivWidth_le x (!bLarge) F Tsmall hTsmallV
  have hDall : ∀ l ∈ D.conclusion, l = litOf x bLarge := by
    intro l hl
    rcases hDconcl l hl with hin | heq
    · rw [hTsmallE] at hin; exact absurd hin (List.not_mem_nil l)
    · rw [heq]; cases bLarge <;> simp [litOf]
  -- derivWidth D ≤ (Bound - 1) + 1 ≤ Bound.
  have hDw : derivWidth D ≤ Bound := by
    have h1 : derivWidth D ≤ derivWidth Tsmall + 1 := hDwidth
    have : derivWidth Tsmall + 1 ≤ (Bound - 1) + 1 := Nat.add_le_add_right hTsmallW 1
    omega
  by_cases hDempty : D.conclusion = []
  · exact ⟨D, hDvalid, hDempty, hDw⟩
  · have hDunit : litOf x bLarge ∈ D.conclusion := by
      obtain ⟨l, hl⟩ := List.exists_mem_of_ne_nil _ hDempty
      have := hDall l hl
      rw [this] at hl; exact hl
    obtain ⟨T', hT'valid, hT'concl, hT'width⟩ :=
      liftUnit x bLarge F D hDvalid hDall hDunit Tbig hTbigV
    refine ⟨T', hT'valid, ?_, ?_⟩
    · rw [List.eq_nil_iff_forall_not_mem]
      intro l hl
      have := hT'concl l hl
      rw [hTbigE] at this; exact (List.not_mem_nil l) this
    · rw [derivWidth_le_iff]
      intro c' hc'
      calc clauseWidth c'
          ≤ max (derivWidth Tbig) (max (derivWidth D) (w0width F)) := hT'width c' hc'
        _ ≤ Bound := max_le hTbigW (max_le hDw hw0)

/--
**THE BEN-SASSON-WIGDERSON TREE SIZE-WIDTH INDUCTION.**

For every size bound `S`, every CNF `F`, and every `Valid F` tree `T` deriving the
empty clause with `size T ≤ S`, there is a `Valid F` refutation of width
`≤ w0width F + Nat.log 2 S`.  Strong induction on `S`. -/
theorem narrowAux : ∀ (S : Nat) {n : Nat} (F : CNF n) (T : ResolutionDerivTree n),
    ResolutionDerivTree.Valid F T → T.conclusion = [] →
    ResolutionDerivTree.size T ≤ S →
    HasNarrowRefutation F (w0width F + Nat.log 2 S) := by
  intro S
  induction S using Nat.strong_induction_on with
  | _ S ih =>
    intro n F T hv hempty hsize
    cases T with
    | hyp c =>
        refine ⟨ResolutionDerivTree.hyp c, hv, hempty, ?_⟩
        have hc : c = [] := hempty
        subst hc
        simp [derivWidth, ResolutionDerivTree.sourceLineClauses, clauseWidth]
    | resolve px T0 T1 =>
        rcases hv with ⟨hv0, hv1, hpos, hneg⟩
        have hconcl_nil : resolveOn px T0.conclusion T1.conclusion = [] := hempty
        obtain ⟨hC0, hC1⟩ := all_pos_neg_of_resolveOn_nil hconcl_nil
        have hs0 := ResolutionDerivTree.size_pos T0
        have hs1 := ResolutionDerivTree.size_pos T1
        have hSsize : ResolutionDerivTree.size T0 + ResolutionDerivTree.size T1 + 1 ≤ S := by
          simp only [ResolutionDerivTree.size] at hsize; omega
        -- S ≥ 3, so log 2 S ≥ 1.
        have hSge : 3 ≤ S := by omega
        have hlogS1 : 1 ≤ Nat.log 2 S :=
          Nat.log_pos (by norm_num) (by omega)
        set Bound := w0width F + Nat.log 2 S with hBound
        have hw0le : w0width F ≤ Bound := by rw [hBound]; exact Nat.le_add_right _ _
        -- The two restricted-subtree refutations and their narrowings.  Common code
        -- factored via a generic helper `step`.
        have step : ∀ (bLarge : Bool) (Tbig Tsmall : ResolutionDerivTree n),
            ResolutionDerivTree.Valid F Tbig →
            (∀ l ∈ Tbig.conclusion, l = litOf px (!bLarge)) →
            ResolutionDerivTree.size Tbig < S →
            ResolutionDerivTree.Valid F Tsmall →
            (∀ l ∈ Tsmall.conclusion, l = litOf px (!(!bLarge))) →
            ResolutionDerivTree.size Tsmall < S →
            2 * ResolutionDerivTree.size Tsmall ≤ S →
            HasNarrowRefutation F Bound := by
          intro bLarge Tbig Tsmall hTbigV hTbigAll hTbigLt hTsmallV hTsmallAll hTsmallLt hhalf
          -- Restrict large by bLarge, small by !bLarge.
          obtain ⟨RBig, hRBigV, hRBigE, hRBigS⟩ :=
            restrictSubtree_refutation px bLarge F Tbig hTbigV hTbigAll
          obtain ⟨RSm, hRSmV, hRSmE, hRSmS⟩ :=
            restrictSubtree_refutation px (!bLarge) F Tsmall hTsmallV hTsmallAll
          -- Narrow big at size RBig.size < S.
          have hbig0 := ih (ResolutionDerivTree.size RBig)
            (lt_of_le_of_lt hRBigS hTbigLt) (restrict px bLarge F) RBig hRBigV hRBigE
            (le_refl _)
          -- Narrow small at size RSm.size < S.
          have hsm0 := ih (ResolutionDerivTree.size RSm)
            (lt_of_le_of_lt hRSmS hTsmallLt) (restrict px (!bLarge) F) RSm hRSmV hRSmE
            (le_refl _)
          -- Bump big bound to Bound.
          have hbig : HasNarrowRefutation (restrict px bLarge F) Bound := by
            obtain ⟨t, hv, he, hw⟩ := hbig0
            refine ⟨t, hv, he, le_trans hw ?_⟩
            have h1 : w0width (restrict px bLarge F) ≤ w0width F := w0width_restrict_le _ _ _
            have h2 : Nat.log 2 (ResolutionDerivTree.size RBig) ≤ Nat.log 2 S :=
              Nat.log_mono_right (le_of_lt (lt_of_le_of_lt hRBigS hTbigLt))
            rw [hBound]; omega
          -- Bump small bound to Bound - 1.
          have hsm : HasNarrowRefutation (restrict px (!bLarge) F) (Bound - 1) := by
            obtain ⟨t, hv, he, hw⟩ := hsm0
            refine ⟨t, hv, he, le_trans hw ?_⟩
            have h1 : w0width (restrict px (!bLarge) F) ≤ w0width F :=
              w0width_restrict_le _ _ _
            -- log 2 RSm.size + 1 ≤ log 2 S  (because 2*RSm.size ≤ S, RSm.size ≥ 1).
            have hRSmpos : 1 ≤ ResolutionDerivTree.size RSm := ResolutionDerivTree.size_pos RSm
            have hmul : Nat.log 2 (ResolutionDerivTree.size RSm * 2)
                = Nat.log 2 (ResolutionDerivTree.size RSm) + 1 :=
              Nat.log_mul_base (by norm_num) (by omega)
            have hle2 : ResolutionDerivTree.size RSm * 2 ≤ S := by
              have : ResolutionDerivTree.size RSm ≤ ResolutionDerivTree.size Tsmall := hRSmS
              omega
            have hlogstep : Nat.log 2 (ResolutionDerivTree.size RSm) + 1 ≤ Nat.log 2 S := by
              rw [← hmul]; exact Nat.log_mono_right hle2
            rw [hBound]; omega
          exact narrow_combine px bLarge F Bound (by rw [hBound]; omega) hw0le hbig hsm
        -- Apply `step` to the smaller subtree.
        have hT0all : ∀ l ∈ T0.conclusion, l = litOf px (!false) := by
          intro l hl; have := hC0 l hl; rw [this]; simp [posLit, litOf]
        have hT1all : ∀ l ∈ T1.conclusion, l = litOf px (!true) := by
          intro l hl; have := hC1 l hl; rw [this]; simp [negLit, litOf]
        by_cases hsmall1 : 2 * ResolutionDerivTree.size T1 ≤ S
        · -- small = T1 (bLarge = false: large is T0 with !false = true polarity? check)
          -- bLarge = false ⟹ Tbig = T0 (conclusion all litOf px (!false)=posLit), ✓
          --                Tsmall = T1 (conclusion all litOf px (!(!false))=litOf px (!true)) ✓
          exact step false T0 T1 hv0 hT0all (by omega) hv1
            (by simpa using hT1all) (by omega) hsmall1
        · -- small = T0 (bLarge = true).
          have hsmall0 : 2 * ResolutionDerivTree.size T0 ≤ S := by omega
          exact step true T1 T0 hv1 hT1all (by omega) hv0
            (by simpa using hT0all) (by omega) hsmall0

/-! ## 5. `RestrictionNarrowsCore`, now PROVED -/

/--
**THE BEN-SASSON-WIGDERSON SIZE-WIDTH CORE, PROVED.**

This is the exact statement isolated as a hypothesis in `ResolutionSizeWidth.lean`.
We discharge it here by `narrowAux` applied to the refutation's own tree at size
`S = ResolutionRefutationSize r`. -/
theorem restrictionNarrowsCore : RestrictionNarrowsCore := by
  intro n F r
  obtain ⟨T', hT'valid, hT'empty, hT'width⟩ :=
    narrowAux (ResolutionRefutationSize r) F r.tree r.valid r.derives_empty (le_refl _)
  exact ⟨⟨T', hT'valid, hT'empty⟩, hT'width⟩

/-! ## 6. The UNCONDITIONAL exponential K_n Tseitin tree-resolution size bound

Feeding the now-PROVED core into the existing reduction
`tseitinKn_size_ge_exp_of_restrictionCore` makes the exponential size lower bound
UNCONDITIONAL (no remaining hypothesis). -/

open PvNP.CNFResolution.TseitinKnConcrete in
/--
**UNCONDITIONAL exponential tree-resolution size lower bound for `K_n` Tseitin.**
For `4 ≤ n`, EVERY tree-resolution refutation `r` of the concrete `K_n` Tseitin
CNF has size at least `2 ^ ((n/4)*(n/4) − n)`.  No hypothesis: the BW size-width
core is discharged by `restrictionNarrowsCore`. -/
theorem tseitinKn_unconditional_resolutionSize_ge_exp {n : Nat} (hn : 4 ≤ n)
    (r : ResolutionRefutation (cnf (n := n))) :
    2 ^ ((n / 4) * (n / 4) - n) ≤ ResolutionRefutationSize r :=
  tseitinKn_size_ge_exp_of_restrictionCore restrictionNarrowsCore hn r

open PvNP.CNFResolution.TseitinKnConcrete in
/--
**UNCONDITIONAL non-vacuous form.**  For `4 ≤ n` there genuinely EXISTS a
tree-resolution refutation of the concrete `K_n` Tseitin CNF, and every such
refutation has size at least `2 ^ ((n/4)*(n/4) − n)`. -/
theorem tseitinKn_unconditional_size_nonvacuous {n : Nat} (hn : 4 ≤ n) :
    ∃ r : ResolutionRefutation (cnf (n := n)),
      2 ^ ((n / 4) * (n / 4) - n) ≤ ResolutionRefutationSize r :=
  tseitinKn_size_nonvacuous restrictionNarrowsCore hn

end ResolutionSizeWidth
