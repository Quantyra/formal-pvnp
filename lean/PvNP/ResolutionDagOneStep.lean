import PvNP.ResolutionDagSizeWidthCore
import PvNP.ResolutionDagCombine
import PvNP.ResolutionSizeWidthCore
import Mathlib.Tactic.Linarith

/-!
# Toward `DagOneStepRestrictFatDrop` — the per-source-line restriction correspondence.

## Honest scope (READ FIRST)

This module attacks **Target 1**: discharging `DagOneStepRestrictFatDrop`
(`ResolutionDagCombine.lean`), the single-variable distinct-line fat-count drop

> `∃ r' : ResolutionRefutation (restrict x s F),
>     dagSize r' ≤ dagSize r ∧ fatCount d r' + fatLitDeg d r x s ≤ fatCount d r`.

### What is PROVED here (axiom-clean, no hypothesis)

* `restrictTreeNodes` — a STRENGTHENING of `restrictTree`: for a `Valid F` tree
  `T`, the `RestrictOutcome` is upgraded with a **per-source-line subset
  correspondence**: every source line `c'` of the restricted tree `T'` is
  contained, literal-by-literal and `x`-free, in some source line `c` of `T`
  (`∀ l ∈ c', l ∈ c ∧ l.var ≠ x`).  This is the source-line analogue of the
  conclusion invariant of `restrictTree`, proved by the same membership-invariant
  induction used by `liftWidth`.

* `restrictNodes_refutation` — packaging on refutations: every refutation `r` of
  `F` yields a refutation `r'` of `restrict x s F` (no larger TREE size) together
  with the per-source-line subset correspondence between `r'`'s and `r`'s source
  lines.

* `restrictWidth_le` — a consequence: every source line of `r'` has
  `clauseWidth ≤` the `clauseWidth` of its corresponding original source line, and
  is `x`-free.  Hence `refutationWidth r' ≤ refutationWidth r`, and any fat line of
  `r'` shrinks from a fat line of `r`.

### The PRECISE, HONESTLY-IDENTIFIED obstruction to the FULL `dagSize` conjunct

`DagOneStepRestrictFatDrop` additionally demands `dagSize r' ≤ dagSize r`, where
`dagSize` is the count of *distinct* (de-dup'd) source lines.  The correspondence
proved here is a **subset** correspondence `c' ⊆ ρₓ c`, **not** an exact
clause-homomorphism `c' = ρₓ c`.  This is unavoidable on the TREE model:

* at a `resolve x L R` node whose pivot equals the restricted variable, the
  restricted tree COLLAPSES to one child, DISCARDING the `x`-free part of the
  other child's conclusion;
* consequently, at an enclosing `resolve p L R` node (`p ≠ x`), the rebuilt
  resolvent line `resolveOn p L'.concl R'.concl` is a **strict subset** of
  `ρₓ (resolveOn p left.concl right.concl)`.

With only a subset correspondence, the de-dup'd line count can GROW: a single
distinct original line `c` (reused at many tree nodes in different restriction
contexts) can map to MANY distinct subsets of `ρₓ c`, so `dagSize r'` is bounded
only by the *tree size* `size T`, not by `dagSize r`.  A faithful
`dagSize r' ≤ dagSize r` requires an EXACT clause-homomorphism restriction acting
on the distinct-line SET (the genuine DAG object), which the repository's tree
`ResolutionDerivTree` does not provide.  See `§4` for the precise residual.

We therefore **DO NOT** claim `DagOneStepRestrictFatDrop`, and we do **NOT**
weaken or re-isolate it falsely.  We expose exactly what the tree machinery
genuinely supports (the subset correspondence and the width consequences) and
name the irreducible missing ingredient (`ClauseSetRestrictExact`) with a
precise, Lean-checkable statement.

No `sorry`, no `admit`, no new `axiom`, no false or circular hypothesis.
-/

namespace PvNP
namespace CNFResolution
namespace ResolutionDagOneStep

open CNFModel
open PvNP.CNFResolution
open PvNP.CNFResolution.Completeness
open PvNP.CNFResolution.ResolutionSizeWidth
open PvNP.CNFResolution.ResolutionDagSizeWidth
open PvNP.CNFResolution.ResolutionDagSizeWidthCore

/-! ## 1. The strengthened restriction with a per-source-line subset correspondence. -/

/-- **Restriction outcome with a per-source-line subset correspondence.**

Either the conclusion of `T` is satisfied by `x := b` (it contains `litOf x b`),
or there is a `Valid (restrict x b F)` tree `T'` of no-larger size, whose
conclusion is the `x`-free part of `T.conclusion`, AND every source line of `T'`
is the literal-wise `x`-free subset of some source line of `T`. -/
def RestrictOutcomeNodes {n : Nat} (x : Fin n) (b : Bool) (F : CNF n)
    (T : ResolutionDerivTree n) : Prop :=
  litOf x b ∈ T.conclusion ∨
    ∃ T' : ResolutionDerivTree n,
      ResolutionDerivTree.Valid (restrict x b F) T' ∧
      T'.size ≤ T.size ∧
      (∀ l ∈ T'.conclusion, l ∈ T.conclusion ∧ l.var ≠ x) ∧
      (∀ c' ∈ T'.sourceLineClauses,
        ∃ c ∈ T.sourceLineClauses, ∀ l ∈ c', l ∈ c ∧ l.var ≠ x)

/-- **Tree restriction with the source-line subset correspondence (PROVED).**

This is `restrictTree` upgraded to additionally track the per-source-line
invariant.  Proof: the SAME membership-invariant induction; at each node we
exhibit, for every source line of the produced tree, a containing source line of
the original tree.  (The conclusion invariant is exactly `restrictTree`'s.) -/
theorem restrictTreeNodes {n : Nat} (x : Fin n) (b : Bool) (F : CNF n) :
    ∀ (T : ResolutionDerivTree n),
      ResolutionDerivTree.Valid F T → RestrictOutcomeNodes x b F T := by
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
        -- The surviving clause as both conclusion and the single source line.
        refine ⟨ResolutionDerivTree.hyp (c.filter (fun l => !decide (l.var = x))),
          hmem, by simp [ResolutionDerivTree.size], ?_, ?_⟩
        · intro l hl
          have hl' : l ∈ c.filter (fun l => !decide (l.var = x)) := hl
          rw [List.mem_filter] at hl'
          refine ⟨hl'.1, ?_⟩
          intro hcontra; have := hl'.2; simp [hcontra] at this
        · intro c' hc'
          simp only [ResolutionDerivTree.sourceLineClauses, List.mem_singleton] at hc'
          subst hc'
          refine ⟨c, by simp [ResolutionDerivTree.sourceLineClauses], ?_⟩
          intro l hl
          have hl' : l ∈ c.filter (fun l => !decide (l.var = x)) := hl
          rw [List.mem_filter] at hl'
          refine ⟨hl'.1, ?_⟩
          intro hcontra; have := hl'.2; simp [hcontra] at this
  | resolve p left right ihL ihR =>
      intro hv
      rcases hv with ⟨hvl, hvr, hpos, hneg⟩
      have hLout := ihL hvl
      have hRout := ihR hvr
      -- Source lines of the parent resolve node.
      have hSLsplit : ∀ c,
          c ∈ (ResolutionDerivTree.resolve p left right).sourceLineClauses ↔
            (c ∈ left.sourceLineClauses ∨ c ∈ right.sourceLineClauses ∨
              c = resolveOn p left.conclusion right.conclusion) := by
        intro c
        rw [sourceLineClauses_resolve, List.mem_append, List.mem_append, List.mem_singleton]
        tauto
      -- Embed left/right child source lines into the parent's.
      have embedL : ∀ c ∈ left.sourceLineClauses,
          c ∈ (ResolutionDerivTree.resolve p left right).sourceLineClauses := by
        intro c hc; rw [hSLsplit]; exact Or.inl hc
      have embedR : ∀ c ∈ right.sourceLineClauses,
          c ∈ (ResolutionDerivTree.resolve p left right).sourceLineClauses := by
        intro c hc; rw [hSLsplit]; exact Or.inr (Or.inl hc)
      have rootLine : resolveOn p left.conclusion right.conclusion
          ∈ (ResolutionDerivTree.resolve p left right).sourceLineClauses := by
        rw [hSLsplit]; exact Or.inr (Or.inr rfl)
      by_cases hp : p = x
      · -- pivot = x: collapse to the surviving side.
        subst hp
        cases b with
        | false =>
            -- x := false.  `negLit p` is true; the resolvent's left part keeps
            -- negLit p when left is satisfied; we keep the LEFT child's outcome.
            rcases hLout with hLsat | ⟨L', hLvalid, hLsize, hLconcl, hLnodes⟩
            · left
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
                simp only [ResolutionDerivTree.size]; omega, ?_, ?_⟩
              · intro l hl
                obtain ⟨hlin, hlx⟩ := hLconcl l hl
                refine ⟨?_, hlx⟩
                show l ∈ resolveOn p left.conclusion right.conclusion
                unfold resolveOn; rw [List.mem_append]; left
                rw [mem_removePivotSign_iff]
                exact ⟨hlin, by rintro ⟨hv1, _⟩; exact hlx hv1⟩
              · intro c' hc'
                obtain ⟨c, hcin, hcsub⟩ := hLnodes c' hc'
                exact ⟨c, embedL c hcin, hcsub⟩
        | true =>
            -- x := true.  posLit p is true; LEFT child satisfied; keep RIGHT.
            rcases hRout with hRsat | ⟨R', hRvalid, hRsize, hRconcl, hRnodes⟩
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
                simp only [ResolutionDerivTree.size]; omega, ?_, ?_⟩
              · intro l hl
                obtain ⟨hlin, hlx⟩ := hRconcl l hl
                refine ⟨?_, hlx⟩
                show l ∈ resolveOn p left.conclusion right.conclusion
                unfold resolveOn; rw [List.mem_append]; right
                rw [mem_removePivotSign_iff]
                exact ⟨hlin, by rintro ⟨hv1, _⟩; exact hlx hv1⟩
              · intro c' hc'
                obtain ⟨c, hcin, hcsub⟩ := hRnodes c' hc'
                exact ⟨c, embedR c hcin, hcsub⟩
      · -- p ≠ x.
        rcases hLout with hLsat | ⟨L', hLvalid, hLsize, hLconcl, hLnodes⟩
        · -- left satisfied: litOf x b survives into the resolvent, node satisfied.
          left
          show litOf x b ∈ resolveOn p left.conclusion right.conclusion
          unfold resolveOn; rw [List.mem_append]; left
          rw [mem_removePivotSign_iff]
          refine ⟨hLsat, ?_⟩
          rintro ⟨hv1, _⟩; exact hp (by simpa [litOf] using hv1.symm ▸ rfl)
        · rcases hRout with hRsat | ⟨R', hRvalid, hRsize, hRconcl, hRnodes⟩
          · left
            show litOf x b ∈ resolveOn p left.conclusion right.conclusion
            unfold resolveOn; rw [List.mem_append]; right
            rw [mem_removePivotSign_iff]
            refine ⟨hRsat, ?_⟩
            rintro ⟨hv1, _⟩; exact hp (by simpa [litOf] using hv1.symm ▸ rfl)
          · -- both restrict.  Resolve on p, weakening on missing pivot literals.
            right
            rcases Classical.em (posLit p ∈ L'.conclusion) with hLmem | hLmem
            · rcases Classical.em (negLit p ∈ R'.conclusion) with hRmem | hRmem
              · -- genuine resolve on p.
                refine ⟨ResolutionDerivTree.resolve p L' R',
                  ⟨hLvalid, hRvalid, hLmem, hRmem⟩, by
                    show ResolutionDerivTree.size (.resolve p L' R')
                      ≤ ResolutionDerivTree.size (.resolve p left right)
                    simp only [ResolutionDerivTree.size]; omega, ?_, ?_⟩
                · -- conclusion invariant.
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
                · -- source-line invariant for the new resolve node.
                  intro c' hc'
                  rw [show (ResolutionDerivTree.resolve p L' R').sourceLineClauses
                      = L'.sourceLineClauses ++ R'.sourceLineClauses
                        ++ [resolveOn p L'.conclusion R'.conclusion] from rfl,
                    List.mem_append, List.mem_append, List.mem_singleton] at hc'
                  rcases hc' with (hcL | hcR) | hcRoot
                  · obtain ⟨c, hcin, hcsub⟩ := hLnodes c' hcL
                    exact ⟨c, embedL c hcin, hcsub⟩
                  · obtain ⟨c, hcin, hcsub⟩ := hRnodes c' hcR
                    exact ⟨c, embedR c hcin, hcsub⟩
                  · -- the new root resolvent line ⊆ ρ x (original root resolvent).
                    subst hcRoot
                    refine ⟨resolveOn p left.conclusion right.conclusion, rootLine, ?_⟩
                    intro l hl
                    have hl' : l ∈ resolveOn p L'.conclusion R'.conclusion := hl
                    unfold resolveOn at hl'
                    rw [List.mem_append] at hl'
                    rcases hl' with hLf | hRf
                    · rw [mem_removePivotSign_iff] at hLf
                      obtain ⟨hin, hlx⟩ := hLconcl l hLf.1
                      refine ⟨?_, hlx⟩
                      unfold resolveOn; rw [List.mem_append]; left
                      rw [mem_removePivotSign_iff]; exact ⟨hin, hLf.2⟩
                    · rw [mem_removePivotSign_iff] at hRf
                      obtain ⟨hin, hlx⟩ := hRconcl l hRf.1
                      refine ⟨?_, hlx⟩
                      unfold resolveOn; rw [List.mem_append]; right
                      rw [mem_removePivotSign_iff]; exact ⟨hin, hRf.2⟩
              · -- negLit p ∉ R'.conclusion: weaken to R'.
                refine ⟨R', hRvalid, by
                  show R'.size ≤ ResolutionDerivTree.size (.resolve p left right)
                  simp only [ResolutionDerivTree.size]; omega, ?_, ?_⟩
                · intro l hl
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
                · intro c' hc'
                  obtain ⟨c, hcin, hcsub⟩ := hRnodes c' hc'
                  exact ⟨c, embedR c hcin, hcsub⟩
            · -- posLit p ∉ L'.conclusion: weaken to L'.
              refine ⟨L', hLvalid, by
                show L'.size ≤ ResolutionDerivTree.size (.resolve p left right)
                simp only [ResolutionDerivTree.size]; omega, ?_, ?_⟩
              · intro l hl
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
              · intro c' hc'
                obtain ⟨c, hcin, hcsub⟩ := hLnodes c' hc'
                exact ⟨c, embedL c hcin, hcsub⟩

/-! ## 2. Refutation-level packaging with the source-line subset correspondence. -/

/--
**Restricting a refutation, with the per-source-line subset correspondence (PROVED).**

For every refutation `r` of `F` and every `x, s`, there is a refutation `r'` of
`restrict x s F` with `ResolutionRefutationSize r' ≤ ResolutionRefutationSize r`,
such that every source line `c'` of `r'` is the literal-wise `x`-free subset of
some source line `c` of `r`.  The satisfied outcome is impossible since a
refutation's conclusion is `[]`. -/
theorem restrictNodes_refutation {V : Nat} (F : CNF V) (r : ResolutionRefutation F)
    (x : Fin V) (s : Bool) :
    ∃ r' : ResolutionRefutation (restrict x s F),
      ResolutionRefutationSize r' ≤ ResolutionRefutationSize r ∧
      (∀ c' ∈ ResolutionRefutationSourceLineClauses r',
        ∃ c ∈ ResolutionRefutationSourceLineClauses r,
          ∀ l ∈ c', l ∈ c ∧ l.var ≠ x) := by
  rcases restrictTreeNodes x s F r.tree r.valid with hsat | ⟨T', hT'valid, hT'size, hT'concl, hT'nodes⟩
  · -- satisfied is impossible: litOf x s ∈ r.tree.conclusion = [].
    exfalso
    rw [r.derives_empty] at hsat
    exact (List.not_mem_nil _) hsat
  · have hT'empty : T'.conclusion = [] := by
      rw [List.eq_nil_iff_forall_not_mem]
      intro l hl
      obtain ⟨hlin, _⟩ := hT'concl l hl
      rw [r.derives_empty] at hlin
      exact (List.not_mem_nil l) hlin
    refine ⟨⟨T', hT'valid, hT'empty⟩, ?_, ?_⟩
    · show ResolutionDerivTree.size T' ≤ ResolutionDerivTree.size r.tree
      exact hT'size
    · intro c' hc'
      exact hT'nodes c' hc'

/-! ## 3. Width consequences that DO follow from the subset correspondence. -/

/--
**The restricted refutation is no wider than the original (PROVED).**

A genuine consequence of the subset correspondence: `refutationWidth r' ≤
refutationWidth r`.  (Every source line of `r'` is a literal-subset of a source
line of `r`, hence no wider, and `derivWidth` is the max source-line width.) -/
theorem restrictNodes_width_le {V : Nat} (F : CNF V) (r : ResolutionRefutation F)
    (x : Fin V) (s : Bool) :
    ∃ r' : ResolutionRefutation (restrict x s F),
      refutationWidth r' ≤ refutationWidth r := by
  obtain ⟨r', _hsize, hnodes⟩ := restrictNodes_refutation F r x s
  refine ⟨r', ?_⟩
  unfold refutationWidth
  rw [derivWidth_le_iff]
  intro c' hc'
  obtain ⟨c, hcin, hcsub⟩ := hnodes c' hc'
  calc clauseWidth c' ≤ clauseWidth c :=
        ResolutionSizeWidth.clauseWidth_le_of_sub (fun l hl => (hcsub l hl).1)
    _ ≤ derivWidth r.tree := clauseWidth_le_derivWidth r.tree hcin

/-! ## 4. The PRECISE irreducible residual: an EXACT clause-set restriction.

`DagOneStepRestrictFatDrop` additionally needs `dagSize r' ≤ dagSize r`, the
DISTINCT-line count.  As discussed in the module header, the subset correspondence
proved above does NOT yield it: distinct subsets of `ρₓ c` can outnumber distinct
`ρₓ`-images, so `dagSize r'` is bounded only by the tree size, not by `dagSize r`.

The genuinely-missing ingredient is an EXACT clause-homomorphism restriction whose
restricted source lines are precisely the `ρₓ`-IMAGES (not arbitrary subsets) of
the original source lines.  We state it as a Lean-checkable Prop for auditing.  We
do **NOT** assert it, do **NOT** use it to fake `DagOneStepRestrictFatDrop`, and do
**NOT** re-isolate the full `DagRestrictionNarrowsCore`. -/

/-- The literal `x`-restriction (clause homomorphism) `ρₓ c := c.filter (·.var ≠ x)`. -/
def rhoLit {V : Nat} (x : Fin V) (c : Clause V) : Clause V :=
  c.filter (fun l => !decide (l.var = x))

/--
**The exact clause-set restriction (SUFFICIENT condition, NOT asserted, truth-over-trees OPEN).**

A restricted refutation `r'` of `restrict x s F` EACH of whose distinct source
lines is an EXACT `ρₓ`-image of a source line of `r`, with no `ρₓ`-image of a
satisfied (`litOf x s ∈ c`) source line surviving.  We PROVE
`ClauseSetRestrictExact → DagOneStepRestrictFatDrop`
(`dagOneStepRestrictFatDrop_of_clauseSetExact`), so this is exactly a SUFFICIENT
hypothesis for Target 1, makes no width claim, and is strictly weaker than the
size-width core.

HONESTY CAVEAT (do not overstate): we do **NOT** claim this is true on the TREE
model.  The exact-image requirement is genuinely STRONGER than the subset
correspondence proved in `restrictTreeNodes`, and the tree restriction realizes
internal resolvent lines only as SUBSETS of `ρₓ`-images (children's restricted
conclusions are weakened by the pivot-`= x` collapse).  Realizing exact `ρₓ`-image
lines requires a separate clause-SET (DAG) datatype closed under resolution — NOT
`ResolutionDerivTree`.  We record `ClauseSetRestrictExact` only as the precise,
auditable SUFFICIENT condition; whether it (or `DagOneStepRestrictFatDrop` itself)
holds for the tree-proxy `dagSize` is left as the honest open residual.  We do NOT
assert it and do NOT depend on it anywhere. -/
def ClauseSetRestrictExact : Prop :=
  ∀ {V : Nat} (F : CNF V) (r : ResolutionRefutation F) (x : Fin V) (s : Bool),
    ∃ r' : ResolutionRefutation (restrict x s F),
      (∀ c' ∈ ResolutionRefutationSourceLineClauses r',
        ∃ c ∈ ResolutionRefutationSourceLineClauses r, c' = rhoLit x c) ∧
      (∀ c ∈ ResolutionRefutationSourceLineClauses r,
        litOf x s ∈ c →
          rhoLit x c ∉ ResolutionRefutationSourceLineClauses r')

/-! ### The residual is EXACTLY the missing piece: it implies `DagOneStepRestrictFatDrop`.

We prove `ClauseSetRestrictExact → DagOneStepRestrictFatDrop`.  This certifies
that the residual is neither too weak (it suffices) nor a re-isolation of the
whole core (it is strictly a single-variable clause-homomorphism fact, makes no
width claim).  The proof is the distinct-line image-cardinality bookkeeping. -/

/-- `clauseWidth (rhoLit x c) ≤ clauseWidth c`. -/
theorem clauseWidth_rhoLit_le {V : Nat} (x : Fin V) (c : Clause V) :
    clauseWidth (rhoLit x c) ≤ clauseWidth c := by
  apply ResolutionSizeWidth.clauseWidth_le_of_sub
  intro l hl
  unfold rhoLit at hl
  rw [List.mem_filter] at hl
  exact hl.1

/-- A source line containing `litOf x s` has `x ∈ varsBySign s`. -/
theorem mem_varsBySign_of_litOf {V : Nat} {x : Fin V} {s : Bool} {c : Clause V}
    (h : litOf x s ∈ c) : x ∈ varsBySign s c := by
  unfold varsBySign
  rw [List.mem_toFinset, List.mem_map]
  refine ⟨litOf x s, ?_, rfl⟩
  rw [List.mem_filter]
  exact ⟨h, by simp [litOf]⟩

open Classical in
/--
**`ClauseSetRestrictExact ⟹ DagOneStepRestrictFatDrop` (PROVED).**

Given the exact clause-set restriction, the distinct restricted lines lie in the
`ρₓ`-image of the distinct original lines (so the de-dup'd count cannot grow), and
every fat line containing `litOf x s` is removed (its `ρₓ`-image is absent), giving
the fat drop.  Hence Target-1's `DagOneStepRestrictFatDrop` holds. -/
theorem dagOneStepRestrictFatDrop_of_clauseSetExact
    (hExact : ClauseSetRestrictExact) :
    ResolutionDagCombine.DagOneStepRestrictFatDrop := by
  intro V F r d x s
  obtain ⟨r', himg, hsat⟩ := hExact F r x s
  refine ⟨r', ?_, ?_⟩
  · -- dagSize r' ≤ dagSize r, via the rhoLit image.
    unfold dagSize
    -- Distinct lines of r' ⊆ image of (distinct lines of r) under rhoLit x.
    set Lr := (ResolutionRefutationSourceLineClauses r).dedup with hLr
    set Lr' := (ResolutionRefutationSourceLineClauses r').dedup with hLr'
    have hsub : Lr'.toFinset ⊆ Lr.toFinset.image (rhoLit x) := by
      intro c' hc'
      rw [List.mem_toFinset, List.mem_dedup] at hc'
      obtain ⟨c, hcin, hceq⟩ := himg c' hc'
      rw [Finset.mem_image]
      exact ⟨c, by rw [List.mem_toFinset, List.mem_dedup]; exact hcin, hceq.symm⟩
    calc Lr'.length = Lr'.toFinset.card := (List.toFinset_card_of_nodup (List.nodup_dedup _)).symm
      _ ≤ (Lr.toFinset.image (rhoLit x)).card := Finset.card_le_card hsub
      _ ≤ Lr.toFinset.card := Finset.card_image_le
      _ = Lr.length := List.toFinset_card_of_nodup (List.nodup_dedup _)
  · -- fatCount r' + fatLitDeg d r x s ≤ fatCount d r.
    -- Partition the fat lines of r by whether they contain litOf x s.
    set Fat := fatFinset d r with hFat
    set A := Fat.filter (fun c => x ∈ varsBySign s c) with hA
    set B := Fat.filter (fun c => x ∉ varsBySign s c) with hB
    -- |A| = fatLitDeg, and |A| + |B| = |Fat| = fatCount r.
    have hAcard : A.card = fatLitDeg d r x s := rfl
    have hpart : A.card + B.card = Fat.card := by
      rw [hA, hB]
      rw [Finset.filter_card_add_filter_neg_card_eq_card (p := fun c => x ∈ varsBySign s c)]
    -- fatCount r' ≤ |B|: every fat line of r' is rhoLit x of some line in B.
    have hfat'B : fatCount d r' ≤ B.card := by
      unfold fatCount
      have hsub : (fatFinset d r') ⊆ B.image (rhoLit x) := by
        intro c' hc'
        rw [mem_fatFinset] at hc'
        obtain ⟨hc'dedup, hc'wide⟩ := hc'
        have hc'line : c' ∈ ResolutionRefutationSourceLineClauses r' := by
          rw [← List.mem_dedup]; exact hc'dedup
        obtain ⟨c, hcin, hceq⟩ := himg c' hc'line
        -- c is fat: width c ≥ width c' > d.
        have hcdedup : c ∈ (ResolutionRefutationSourceLineClauses r).dedup := by
          rw [List.mem_dedup]; exact hcin
        have hcfatwidth : d < clauseWidth c := by
          have : clauseWidth c' ≤ clauseWidth c := by
            rw [hceq]; exact clauseWidth_rhoLit_le x c
          omega
        have hcFat : c ∈ Fat := mem_fatFinset.mpr ⟨hcdedup, hcfatwidth⟩
        -- c does not contain litOf x s (else rhoLit x c would be absent from r').
        have hcnotsat : x ∉ varsBySign s c := by
          intro hxin
          -- x ∈ varsBySign s c ⟹ litOf x s ∈ c.
          have hlit : litOf x s ∈ c := by
            unfold varsBySign at hxin
            rw [List.mem_toFinset, List.mem_map] at hxin
            obtain ⟨l, hl, hlv⟩ := hxin
            rw [List.mem_filter, decide_eq_true_eq] at hl
            have : l = litOf x s := by
              cases l with | mk lv ls => simp [litOf] at *; exact ⟨hlv, hl.2⟩
            rw [← this]; exact hl.1
          have := hsat c hcin hlit
          rw [← hceq] at this
          exact this hc'line
        -- thus c ∈ B, and c' = rhoLit x c.
        rw [Finset.mem_image]
        exact ⟨c, by rw [hB, Finset.mem_filter]; exact ⟨hcFat, hcnotsat⟩, hceq.symm⟩
      calc (fatFinset d r').card
          ≤ (B.image (rhoLit x)).card := Finset.card_le_card hsub
        _ ≤ B.card := Finset.card_image_le
    -- conclude.
    have : fatLitDeg d r x s = A.card := rfl
    rw [this]
    have hfatcount : fatCount d r = Fat.card := rfl
    rw [hfatcount]
    omega

end ResolutionDagOneStep
end CNFResolution
end PvNP
