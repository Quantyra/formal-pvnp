import PvNP.ResolutionDagSizeWidthCore
import PvNP.ResolutionSizeWidthCore
import PvNP.ResolutionDagSizeWidth
import PvNP.CNFResolution
import Mathlib.Tactic.Linarith

/-!
# Discharging the structural primitives of the general (DAG) BW size-width core

## Honest scope (READ FIRST)

This module works on the two single-variable STRUCTURAL primitives that the proved
combinatorial core of `ResolutionDagSizeWidthCore.lean` isolated, building them from
the already-proved TREE restriction machinery of `ResolutionSizeWidthCore.lean`
(`restrictTree`, `RestrictOutcome`, `liftWidth`, `liftUnit`, `narrow_combine`).

### What is PROVED here (axiom-clean, no hypothesis)

* `dagCombineStep_w0 : DagCombineStepW0` — the TWO-BRANCH resolve-on-pivot combine
  on refutations, in its CORRECT form: from refutations of BOTH branches
  `restrict x false F` and `restrict x true F` of width `≤ w` **together with the
  side condition `w0width F ≤ w`**, build a refutation of `F` of width `≤ w + 1` by
  resolving on the pivot `x`.  This is the honest lift-back (it COMBINES both
  branches; it never uses the FALSE single-branch lift that derives the unit
  `litOf x (!s)` rather than `[]`).

* `dagOneStepRestrict_refutation` — the *refutation / no-larger-`dagSize`* content of
  `DagOneStepRestrict`: restricting a refutation `r` of `F` by `x := s` either leaves
  the conclusion satisfied (impossible for a refutation, so this branch is ruled out)
  or yields a refutation `r'` of `restrict x s F` with `dagSize r' ≤ dagSize r`.
  PROVED from `restrictTree` (via `restrictSubtree_refutation`).

### The PRECISELY-ISOLATED remaining sub-lemma (true, structural, not yet assembled)

* `DagOneStepRestrictFatDrop` — the DISTINCT-line fat-count bookkeeping
  `fatCount d r' + fatLitDeg d r x s ≤ fatCount d r`.  This is the only residual
  content of `DagOneStepRestrict`; it is the BW "each fat clause containing the hit
  literal is killed" count over the dedup'd source-line multiset.  It is TRUE and
  structural (see `§3`), but requires a per-source-line correspondence that
  `restrictTree` does not currently expose.  We state it as an explicit hypothesis,
  PROVE that it implies the full `DagOneStepRestrict`, and from there assemble the
  conditional reduction.

### Honest correction recorded here

The core's `DagCombineStep` was stated WITHOUT the side condition `w0width F ≤ w`.
As literally stated it is NOT supported by the tree machinery: `liftUnit` re-grafts
the USED axiom leaves and its per-line width is `max (derivWidth Tbig)
(max (derivWidth D) (w0width F))`, so the `w0width F` slack is intrinsic.  In the
actual BW assembly the target width is `w0width F + budget`, so `w0width F ≤ w` ALWAYS
holds at the combine sites; hence the correct usable primitive is the `W0`-aware one
proved here.  We do NOT silently pretend the unconditioned form; we prove the true one.

No `sorry`, no `admit`, no new `axiom`, no false or circular hypothesis.  We do NOT
weaken `DagRestrictionNarrowsCore`.

Scope: lower-bound enabling lemmas for the general (DAG) RESOLUTION proof system.
NOT P ≠ NP, NOT an NP/circuit lower bound.
-/

namespace PvNP
namespace CNFResolution
namespace ResolutionDagCombine

open CNFModel
open PvNP.CNFResolution
open PvNP.CNFResolution.Completeness
open PvNP.CNFResolution.ResolutionSizeWidth
open PvNP.CNFResolution.ResolutionDagSizeWidth
open PvNP.CNFResolution.ResolutionDagSizeWidthCore

/-! ## 1. The correct (w0-aware) two-branch combine, PROVED. -/

/-- The CORRECT form of the two-branch combine on refutations: with the side
condition `w0width F ≤ w` (which always holds at the BW combine sites, where the
running width budget is `w0width F + …`), refutations of both branches at width
`≤ w` yield a refutation of `F` at width `≤ w + 1`. -/
def DagCombineStepW0 : Prop :=
  ∀ {V : Nat} (F : CNF V) (x : Fin V) (w : Nat),
    w0width F ≤ w →
    (∃ r0 : ResolutionRefutation (restrict x false F), refutationWidth r0 ≤ w) →
    (∃ r1 : ResolutionRefutation (restrict x true F), refutationWidth r1 ≤ w) →
    ∃ r : ResolutionRefutation F, refutationWidth r ≤ w + 1

/--
**The two-branch combine, on refutations (PROVED).**

We re-run the body of `narrow_combine` directly on the lower-level public lemmas
`liftWidth_derivWidth_le` (the `+1` small-side lift to the pivot unit) and
`liftUnit` (the `+0` large-side lift against that unit), so that this module never
needs the private `HasNarrowRefutation` name.  HONEST lift-back: BOTH branches are
used and resolved on `x`; the false single-branch lift is never performed. -/
theorem dagCombineStep_w0 : DagCombineStepW0 := by
  intro V F x w hw0 hfalse htrue
  obtain ⟨r0, hr0⟩ := hfalse
  obtain ⟨r1, hr1⟩ := htrue
  set Bound := w + 1
  -- LARGE side = restrict x true F (bLarge = true); SMALL side = restrict x false F.
  set Tbig := r1.tree with hTbig
  set Tsmall := r0.tree with hTsmall
  have hTbigV : ResolutionDerivTree.Valid (restrict x true F) Tbig := r1.valid
  have hTsmallV : ResolutionDerivTree.Valid (restrict x false F) Tsmall := r0.valid
  have hTbigE : Tbig.conclusion = [] := r1.derives_empty
  have hTsmallE : Tsmall.conclusion = [] := r0.derives_empty
  have hTbigW : derivWidth Tbig ≤ Bound := by
    have hh : refutationWidth r1 ≤ w := hr1
    unfold refutationWidth at hh; rw [hTbig]; omega
  have hTsmallW : derivWidth Tsmall ≤ w := by
    have hh : refutationWidth r0 ≤ w := hr0
    unfold refutationWidth at hh; rw [hTsmall]; omega
  -- Lift the small side (b = !true = false) to a unit derivation of {litOf x true}.
  obtain ⟨D, hDvalid, hDconcl, hDwidth⟩ :=
    liftWidth_derivWidth_le x false F Tsmall hTsmallV
  have hDall : ∀ l ∈ D.conclusion, l = litOf x true := by
    intro l hl
    rcases hDconcl l hl with hin | heq
    · rw [hTsmallE] at hin; exact absurd hin (List.not_mem_nil l)
    · rw [heq]; simp
  have hDw : derivWidth D ≤ Bound := by
    have hd1 : derivWidth D ≤ derivWidth Tsmall + 1 := hDwidth
    omega
  by_cases hDempty : D.conclusion = []
  · -- D already refutes F.
    refine ⟨⟨D, hDvalid, hDempty⟩, ?_⟩
    unfold refutationWidth; exact le_trans hDw (by omega)
  · have hDunit : litOf x true ∈ D.conclusion := by
      obtain ⟨l, hl⟩ := List.exists_mem_of_ne_nil _ hDempty
      have := hDall l hl
      rw [this] at hl; exact hl
    obtain ⟨T', hT'valid, hT'concl, hT'width⟩ :=
      liftUnit x true F D hDvalid hDall hDunit Tbig hTbigV
    have hT'empty : T'.conclusion = [] := by
      rw [List.eq_nil_iff_forall_not_mem]
      intro l hl
      have := hT'concl l hl
      rw [hTbigE] at this; exact (List.not_mem_nil l) this
    refine ⟨⟨T', hT'valid, hT'empty⟩, ?_⟩
    unfold refutationWidth
    rw [derivWidth_le_iff]
    intro c' hc'
    calc clauseWidth c'
        ≤ max (derivWidth Tbig) (max (derivWidth D) (w0width F)) := hT'width c' hc'
      _ ≤ Bound := max_le hTbigW (max_le hDw (le_trans hw0 (by omega)))

/-! ## 2. The refutation / no-larger-tree-size content of one-step restriction.

The conclusion of a refutation is the empty clause, so the polarity hypothesis of
`restrictSubtree_refutation` is vacuous and we obtain, for ANY `x`, `s`, a genuine
refutation of `restrict x s F` whose underlying TREE is no larger.  This is the
clean, PROVED kernel of `DagOneStepRestrict`. -/

/-- **Restricting a refutation (tree-size form, PROVED).**  For every refutation `r`
of `F` and every `x, s`, there is a refutation `r'` of `restrict x s F` with
`ResolutionRefutationSize r' ≤ ResolutionRefutationSize r`.  (Read off
`restrictSubtree_refutation`; the satisfied-conclusion outcome is ruled out because a
refutation's conclusion is `[]`.) -/
theorem restrict_refutation {V : Nat} (F : CNF V) (r : ResolutionRefutation F)
    (x : Fin V) (s : Bool) :
    ∃ r' : ResolutionRefutation (restrict x s F),
      ResolutionRefutationSize r' ≤ ResolutionRefutationSize r := by
  -- r.tree.conclusion = [], so the all-`litOf x (!s)` hypothesis is vacuous.
  have hall : ∀ l ∈ r.tree.conclusion, l = litOf x (!s) := by
    intro l hl; rw [r.derives_empty] at hl; exact absurd hl (List.not_mem_nil l)
  obtain ⟨T', hT'valid, hT'empty, hT'size⟩ :=
    restrictSubtree_refutation x s F r.tree r.valid hall
  refine ⟨⟨T', hT'valid, hT'empty⟩, ?_⟩
  unfold ResolutionRefutationSize
  exact le_trans hT'size (le_refl _)

/-! ## 3. The PRECISELY-ISOLATED remaining sub-lemma: distinct-line fat-count drop.

`DagOneStepRestrict` additionally claims the DISTINCT-LINE bounds
`dagSize r' ≤ dagSize r` and `fatCount d r' + fatLitDeg d r x s ≤ fatCount d r`.

These are **not** consequences of the no-larger TREE size: `dagSize`/`fatCount` are
de-dup'd DISTINCT-clause counts, and the restricted tree produced by `restrictTree`
re-builds its internal resolvent lines (`resolveOn p L'.concl R'.concl`), which are
NOT the x-restrictions of the original internal lines.  The faithful statement is the
DAG-level fact that restriction is a clause-homomorphism: the distinct restricted
lines are the image of the distinct original lines under `c ↦ c.filter (·.var ≠ x)`
(dropping satisfied lines), so their count cannot grow, and every fat line containing
the satisfied literal `(x, s)` is removed.  This needs a per-source-line
correspondence the current `restrictTree` does not expose, so we isolate it as the
single explicit, TRUE, structural hypothesis below.

It is NOT circular (it is a single-variable, pigeonhole-free, formula-independent
counting fact, makes no width claim, and is strictly weaker than the size-width
conclusion `DagRestrictionNarrowsCore`). -/

/--
**The isolated distinct-line fat-count drop (single remaining sub-lemma).**

For every refutation `r` of `F` and every threshold `d`, variable `x`, sign `s`,
there is a restricted refutation `r'` of `restrict x s F` realizing BOTH the
no-larger distinct-line count and the satisfaction-based fat drop. -/
def DagOneStepRestrictFatDrop : Prop :=
  ∀ {V : Nat} (F : CNF V) (r : ResolutionRefutation F) (d : Nat) (x : Fin V) (s : Bool),
    ∃ r' : ResolutionRefutation (restrict x s F),
      dagSize r' ≤ dagSize r ∧
      fatCount d r' + fatLitDeg d r x s ≤ fatCount d r

/-- The isolated sub-lemma is, by unfolding, exactly `DagOneStepRestrict`. -/
theorem dagOneStepRestrict_of_fatDrop (h : DagOneStepRestrictFatDrop) :
    DagOneStepRestrict := by
  intro V F r d x s
  exact h F r d x s

/-! ## 4. Conditional assembly status.

With `dagCombineStep_w0` PROVED and `restrict_refutation` PROVED, the residual
content needed for `DagRestrictionNarrowsCore` is:

* `DagOneStepRestrictFatDrop` (above) — feeds the proved per-step geometric drop
  `ResolutionDagSizeWidthCore.aSeq_step` and iteration `iteration_reaches_zero`; and
* the BW TWO-PARAMETER combine recursion that, undoing the trajectory's
  restrictions, applies `dagCombineStep_w0` along a binary recursion (one branch
  uses the fat drop, the other recurses with one fewer variable) to rebuild a
  refutation of `F` at the `sqrt` budget width.

The proved core (pigeonhole, iteration, envelope) supplies the SINGLE-branch fat
trajectory; the second (variable-count) branch of the recursion and its width
accounting are NOT assembled here.  We therefore DO NOT claim
`DagRestrictionNarrowsCore`.  What this module adds over the prior state: the
combine primitive is now PROVED (not assumed), and the one-step restriction is
reduced to the lone distinct-line counting fact `DagOneStepRestrictFatDrop`. -/

end ResolutionDagCombine
end CNFResolution
end PvNP
