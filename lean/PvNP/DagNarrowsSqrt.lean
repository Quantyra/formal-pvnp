import PvNP.DagCombineAsym
import PvNP.DagNarrowsProof
import PvNP.DagWidthLowerBound
import Mathlib.Data.Nat.Log
import Mathlib.Tactic.Linarith

/-!
# The UNCONDITIONAL Ben-Sasson–Wigderson DAG size-width narrowing.

This module assembles the verified asymmetric combine `DagNarrowing.combineAsym`
(the keystone: the KILLED branch pays `+1`, the SIBLING branch pays `+0`) with the
already-proven geometric machinery of `ResolutionDagSizeWidthCore` /
`DagSizeWidth` / `DagNarrowsProof` into the final, UNCONDITIONAL narrowing port
`DagSizeWidth.DagNarrows`.

## What is PROVED here (no hypothesis, no `sorry`, no new `axiom`)

`dagNarrows_sqrt : DagSizeWidth.DagNarrows` — every `DagRefutation F` narrows to a
refutation of `F` ITSELF of width `≤ w0width F + dagNarrowingBudget V (dagSize r.proof)`,
where `dagNarrowingBudget V S = 3·⌊√(2V·log₂ S)⌋ + 3`.

The proof is the genuine BW two-branch recursion: at each level we restrict on a heavy
literal `(x,s)`, form BOTH branches, supply each from the SAME induction hypothesis
(NO assumed sibling), and recombine via the ASYMMETRIC `combineAsym`.  The recursion
runs over the envelope sequence `A` (the proved geometric fat-count decay reaching `0`
after the `sqrt`-bounded `N := (L+1)*m` steps) on the FIRST axis and the live-variable
count on the SECOND axis, packaged into a single well-founded `Nat` measure.

Combining with the UNCONDITIONAL DAG width lower bound
`DagWidthLowerBound.dag_widthBound_quarter` yields the now-UNCONDITIONAL exponential
`dagSize` lower bound `dagSize_ge_exp_quarter_uncond`.

### Integrity
No `sorry`, no `admit`, no new `axiom`, no `native_decide`, no false/circular
hypothesis, NO assumed sibling, NO weakening of `DagNarrows`.  `#print axioms
dagNarrows_sqrt` ⊆ `[propext, Classical.choice, Quot.sound]`.

Scope: a lower-bound enabling lemma for the general (DAG) RESOLUTION proof system.
NOT P ≠ NP, NOT an NP / circuit lower bound.
-/

namespace PvNP
namespace CNFResolution
namespace DagNarrowsSqrt

open CNFModel
open PvNP.CNFResolution
open PvNP.CNFResolution.Completeness
open PvNP.CNFResolution.ResolutionSizeWidth
open PvNP.CNFResolution.DagResolutionModel
open PvNP.CNFResolution.DagSizeWidth
open PvNP.CNFResolution.DagNarrowing
open PvNP.CNFResolution.DagNarrowsProof
open PvNP.CNFResolution.ResolutionDagSizeWidthCore
open PvNP.CNFResolution.DagWidthLowerBound
open PvNP.CNFResolution.TseitinKnConcrete

/-! ## The main-regime recursion.

Throughout, `V`, the threshold `d`, the envelope sequence `A`, and the step bound `N`
are FIXED constants computed from the ORIGINAL refutation `r₀`.  Only the CNF `F` and
the refutation `r` vary along the recursion (fat counts only decrease and stay `≤ A i`). -/

/-- **The core recursion (main regime).**  With `A` the geometric envelope sequence
(`A` nonincreasing, `A N = 0`, per-step decay `2V·A(i+1) ≤ A i·(2V−d)`) and threshold
`d`, every `DagRefutation F` whose fat count is `≤ A i` narrows to a refutation of `F`
itself of width `≤ w0width F + d + (N − i)`.

Strong induction on the single `Nat` measure `μ := (N − i)·(V+1) + (liveVarsDag r).card`.
The KILLED branch drops `(N − i)` by 1 (dominating any liveVars change, since
`liveVarsDag.card ≤ V < V+1`); the SIBLING branch keeps `(N − i)` but drops
`liveVarsDag.card` by 1.  Both branches are therefore supplied by the IH at the same
common width, and recombined by the asymmetric `combineAsym` (`+1` on the killed side,
`+0` on the sibling). -/
theorem rec_narrow {V : Nat} (d N : Nat) (A : Nat → Nat)
    (hAnoninc : ∀ i, A (i + 1) ≤ A i)
    (hAdesc : ∀ (i fc' : Nat), 2 * V * fc' ≤ A i * (2 * V - d) → fc' ≤ A (i + 1))
    (hAN : A N = 0) :
    ∀ (μ : Nat) (i : Nat) (F : CNF V) (r : DagRefutation F),
      (N - i) * (V + 1) + (liveVarsDag r).card ≤ μ →
      fatCountDag d r ≤ A i →
      HasNarrowDag F (w0width F + d + (N - i)) := by
  intro μ
  induction μ using Nat.strong_induction_on with
  | _ μ ih =>
    intro i F r hμ hfat
    by_cases hfat0 : fatCountDag d r = 0
    · -- No fat lines: r itself is narrow at width ≤ d ≤ w0width F + d + (N-i).
      have hwd : refutationWidthDag r ≤ d :=
        refutationWidthDag_le_of_fatCount_zero r hfat0
      exact ⟨r, le_trans hwd (by omega)⟩
    · -- Fat line exists: pick heavy literal, two-branch recursion.
      have hpos : 0 < fatCountDag d r := Nat.pos_of_ne_zero hfat0
      obtain ⟨x, s, hxs⟩ := exists_heavy_fat_lit_dag r hpos
      -- fatLitDegDag d r x s ≥ 1 (since fatCount*d+1 ≥ 1).
      have hdeg : 0 < fatLitDegDag d r x s := by
        rcases Nat.eq_zero_or_pos (fatLitDegDag d r x s) with h0 | hp
        · rw [h0, Nat.mul_zero] at hxs; omega
        · exact hp
      have hxlive : x ∈ liveVarsDag r := x_live_of_fatLitDeg r x s hdeg
      -- A i ≥ fatCount ≥ 1 > 0 = A N, and A nonincreasing ⟹ i < N.
      have hApos : 0 < A i := lt_of_lt_of_le hpos hfat
      have hiN : i < N := by
        by_contra hge
        push_neg at hge  -- N ≤ i
        -- A i ≤ A N = 0 by nonincreasing, contradiction.
        have hmono : ∀ a b, a ≤ b → A b ≤ A a := by
          intro a b hab
          induction hab with
          | refl => exact le_refl _
          | step _ ih2 => exact le_trans (hAnoninc _) ih2
        have : A i ≤ A N := hmono N i hge
        rw [hAN] at this; omega
      -- N - i ≥ 1, so N - (i+1) = (N - i) - 1.
      have hNi1 : 1 ≤ N - i := by omega
      have hNi_succ : N - (i + 1) = (N - i) - 1 := by omega
      -- the two branches.
      obtain ⟨_hdagk, hfatk⟩ := dagOneStep_fatDrop d r x s
      obtain ⟨_hdags, hfats⟩ := dagOneStep_fatDrop d r x (!s)
      -- KILLED branch: fatCount drops geometrically ⟹ ≤ A (i+1).
      -- 2V·fatCount(killed) ≤ 2V·(fatCount r - fatLitDeg) ≤ fatCount r·(2V-d) ≤ A i·(2V-d).
      have hkill_fat : fatCountDag d (r.restrict x s) ≤ A (i + 1) := by
        set fc := fatCountDag d r with hfc
        set fk := fatCountDag d (r.restrict x s) with hfkdef
        set h := fatLitDegDag d r x s with hhdef
        -- hfatk : fk + h ≤ fc ; hxs : fc*d + 1 ≤ 2V*h.
        -- 2V*fk + fc*d ≤ 2V*(fk+h) ≤ 2V*fc, hence 2V*fk ≤ fc*(2V-d) ≤ A i*(2V-d).
        have hstep2 : 2 * V * fk + fc * d ≤ 2 * V * fc := by
          have h1 : 2 * V * (fk + h) ≤ 2 * V * fc := Nat.mul_le_mul_left _ hfatk
          have hexp : 2 * V * (fk + h) = 2 * V * fk + 2 * V * h := by ring
          omega
        have hmsub : fc * (2 * V - d) = fc * (2 * V) - fc * d := Nat.mul_sub fc (2 * V) d
        have hfc2V : fc * (2 * V) = 2 * V * fc := by ring
        have hkle : 2 * V * fk ≤ fc * (2 * V - d) := by rw [hmsub]; omega
        have hkle2 : 2 * V * fk ≤ A i * (2 * V - d) :=
          le_trans hkle (Nat.mul_le_mul_right _ hfat)
        -- the envelope descent: 2V*fk ≤ A i*(2V-d) ⟹ fk ≤ A (i+1).
        exact hAdesc i fk hkle2
      -- SIBLING branch: fatCount ≤ fatCount r ≤ A i.
      have hsib_fat : fatCountDag d (r.restrict x (!s)) ≤ A i :=
        le_trans (by omega) hfat
      -- live-var drops on BOTH branches.
      have hklive : (liveVarsDag (r.restrict x s)).card < (liveVarsDag r).card :=
        liveVars_card_restrict_lt r x s hxlive
      have hslive : (liveVarsDag (r.restrict x (!s))).card < (liveVarsDag r).card :=
        liveVars_card_restrict_lt r x (!s) hxlive
      -- bounds on liveVars cards by V (for the measure on the killed branch).
      have hkV : (liveVarsDag (r.restrict x s)).card ≤ V := liveVarsDag_card_le _
      -- KILLED branch IH: index i+1, measure strictly smaller.
      -- μ_killed = (N-(i+1))*(V+1) + card(killed) = ((N-i)-1)*(V+1) + card(killed)
      --          ≤ (N-i)*(V+1) - (V+1) + V < (N-i)*(V+1) ≤ μ (using card(r) part).
      have hIHk : HasNarrowDag (restrict x s F)
          (w0width (restrict x s F) + d + (N - (i + 1))) := by
        apply ih ((N - (i + 1)) * (V + 1) + (liveVarsDag (r.restrict x s)).card) (by
          -- strictly < μ
          have hrcard : 1 ≤ (liveVarsDag r).card := Finset.card_pos.mpr ⟨x, hxlive⟩
          have h1 : (N - (i + 1)) * (V + 1) + (liveVarsDag (r.restrict x s)).card
              < (N - i) * (V + 1) + (liveVarsDag r).card := by
            rw [hNi_succ]
            have hmul : ((N - i) - 1) * (V + 1) + (V + 1) = (N - i) * (V + 1) := by
              obtain ⟨t, ht⟩ := Nat.exists_eq_add_of_le hNi1
              -- ht : N - i = 1 + t  ⟹ ((1+t)-1)*(V+1)+(V+1) = (1+t)*(V+1).
              rw [ht, Nat.add_sub_cancel_left]; ring
            -- ((N-i)-1)*(V+1) + card(killed) ≤ ((N-i)-1)*(V+1) + V < ((N-i)-1)*(V+1)+(V+1)
            --   = (N-i)*(V+1) ≤ (N-i)*(V+1) + card(r).
            omega
          omega) (i + 1) (restrict x s F) (r.restrict x s) (le_refl _) hkill_fat
      -- SIBLING branch IH: index i, measure strictly smaller (live drops by ≥1).
      have hIHs : HasNarrowDag (restrict x (!s) F)
          (w0width (restrict x (!s) F) + d + (N - i)) := by
        apply ih ((N - i) * (V + 1) + (liveVarsDag (r.restrict x (!s))).card) (by
          have : (liveVarsDag (r.restrict x (!s))).card < (liveVarsDag r).card := hslive
          omega) i (restrict x (!s) F) (r.restrict x (!s)) (le_refl _) hsib_fat
      -- Bump both up to use `w0width F` (restriction does not increase w0width).
      have hw0k : w0width (restrict x s F) ≤ w0width F := w0width_restrict_le _ _ _
      have hw0s : w0width (restrict x (!s) F) ≤ w0width F := w0width_restrict_le _ _ _
      have hbk : HasNarrowDag (restrict x s F) (w0width F + d + ((N - i) - 1)) :=
        HasNarrowDag_mono (by rw [hNi_succ] at hIHk; omega) hIHk
      have hbs : HasNarrowDag (restrict x (!s) F) (w0width F + d + (N - i)) :=
        HasNarrowDag_mono (by omega) hIHs
      -- Combine: killed pays +1, sibling pays +0.
      have hcomb := combineAsym F x s
        (w0width F + d + ((N - i) - 1)) (w0width F + d + (N - i)) hbk hbs
      -- output width = max ((w0width F+d+((N-i)-1))+1) (max (w0width F+d+(N-i)) (w0width F)).
      -- Since (N-i) ≥ 1: ((N-i)-1)+1 = N-i, so this = w0width F + d + (N-i).
      have hmaxeq :
          max (w0width F + d + ((N - i) - 1) + 1)
            (max (w0width F + d + (N - i)) (w0width F))
          = w0width F + d + (N - i) := by
        have e1 : w0width F + d + ((N - i) - 1) + 1 = w0width F + d + (N - i) := by omega
        rw [e1]
        -- max X (max X w0) = X  since w0 ≤ X.
        have hw0le : w0width F ≤ w0width F + d + (N - i) := by omega
        rw [max_eq_left hw0le, max_self]
      rw [hmaxeq] at hcomb
      exact hcomb

/-! ## The full theorem. -/

/-- **`dagNarrows_sqrt` — the UNCONDITIONAL BW DAG narrowing port (PROVED).**

This is exactly `DagSizeWidth.DagNarrows`: every `DagRefutation F` narrows to a
refutation of `F` itself of width `≤ w0width F + dagNarrowingBudget V (dagSize r.proof)`. -/
theorem dagNarrows_sqrt : DagSizeWidth.DagNarrows := by
  intro V F r₀
  classical
  set S := dagSize r₀.proof with hS
  set W := 2 * V with hW
  set L := Nat.log 2 S with hLdef
  set M := Nat.sqrt (W * L) with hMdef
  set d := M + 1 with hddef
  -- dagNarrowingBudget V S = 3*M + 3.
  have hbudget : dagNarrowingBudget V S = 3 * M + 3 := by
    show 3 * Nat.sqrt (2 * V * Nat.log 2 S) + 3 = 3 * M + 3
    rw [hMdef, hW, hLdef]
  -- the head clause [] is always a line, so dagSize ≥ 1.
  have hnil0 : ([] : Clause V) ∈ lineFinset r₀ := by
    apply mem_lineFinset.mpr
    have := head_mem_lineClauses r₀
    rwa [r₀.head_empty] at this
  have hSpos : 1 ≤ S := by
    rw [hS, dagSize_eq_lineFinset_card]
    exact Finset.card_pos.mpr ⟨[], hnil0⟩
  by_cases hedge : ¬ (M + 1 ≤ W)
  · -- EDGE regime: W < M+1, so dagNarrowingBudget already ≥ V; use the linear bound.
    -- M ≥ W = 2V, so 3M ≥ 3·2V = 6V ≥ V, hence V ≤ dagNarrowingBudget V S.
    have hMW : W ≤ M := by omega
    have hVbudget : V ≤ w0width F + dagNarrowingBudget V S := by
      rw [hbudget]
      -- 3M ≥ 3W = 6V ≥ V.
      have : V ≤ 3 * M := by omega
      omega
    exact HasNarrowDag_mono hVbudget (dagNarrows_V r₀)
  · -- MAIN regime: M + 1 ≤ W.
    push_neg at hedge  -- M + 1 ≤ W
    by_cases hL0 : L = 0
    · -- L = 0 ⟹ S = 1 (since 1 ≤ S < 2^1).  No fat lines beyond width 0; budget ≥ ... .
      -- dagNarrowingBudget V S = 3*sqrt(2V*0)+3 = 3.  Use linear bound only if V ≤ 3?
      -- Not necessarily; handle via the main recursion with N = 0 directly (A 0 = 0?).
      -- Cleaner: when L = 0, S < 2, so S = 1, dagSize = 1 ⟹ all lines empty ⟹ width 0 ≤ budget.
      -- We instead run the recursion: but to keep it uniform we use dagNarrows_V if V small,
      -- otherwise note fatCount d r₀ ≤ S = 1 and d = sqrt(0)+1 = 1; run recursion with N steps.
      -- Simplest: fall back to the main recursion machinery uniformly is hard at L=0 because
      -- the envelope needs L ≥ 1.  So treat L=0 directly.
      -- L = 0 ⟹ S = 1 ⟹ dagSize = 1 ⟹ every line is [] ⟹ refutationWidthDag r₀ = 0.
      have hS1 : S = 1 := by
        have : S < 2 ^ (L + 1) := by rw [hLdef]; exact Nat.lt_pow_succ_log_self (by norm_num) S
        rw [hL0] at this; simp at this; omega
      -- dagSize r₀.proof = 1 ⟹ all lines are []; refutationWidthDag r₀ = 0.
      have hsize1 : dagSize r₀.proof = 1 := by rw [← hS]; exact hS1
      have hwidth0 : refutationWidthDag r₀ ≤ 0 := by
        apply refutationWidthDag_le
        intro c hc
        -- lineFinset has card 1 and contains []; so c = [].
        have hcard : (lineFinset r₀).card = 1 := by rw [← dagSize_eq_lineFinset_card]; exact hsize1
        have hcmem : c ∈ lineFinset r₀ := mem_lineFinset.mpr hc
        rcases Finset.card_eq_one.mp hcard with ⟨a, ha⟩
        rw [ha, Finset.mem_singleton] at hnil0 hcmem
        rw [hcmem, ← hnil0]; simp [clauseWidth]
      exact ⟨r₀, le_trans hwidth0 (Nat.zero_le _)⟩
    · -- L ≥ 1 and M + 1 ≤ W: the genuine main regime.
      have hL : 1 ≤ L := Nat.pos_of_ne_zero hL0
      set m := (W + M) / (M + 1) with hmdef
      set N := (L + 1) * m with hNdef
      -- The envelope sequence A.
      set A : Nat → Nat := fun i => Nat.rec S (fun _ prev => prev * (W - d) / W) i with hAdef
      have hA0 : A 0 = S := rfl
      have hAsucc : ∀ i, A (i + 1) = A i * (W - d) / W := fun i => rfl
      -- per-step: 2V·A(i+1) ≤ A i·(2V-d), i.e. W·A(i+1) ≤ A i·(W-d).
      have hAstep : ∀ i, W * A (i + 1) ≤ A i * (W - d) := by
        intro i
        rw [hAsucc]
        -- W * (x / W) ≤ x  where x = A i * (W - d).
        calc W * (A i * (W - d) / W) = (A i * (W - d) / W) * W := by ring
          _ ≤ A i * (W - d) := Nat.div_mul_le_self _ _
      -- A nonincreasing: A(i+1) = A i*(W-d)/W ≤ A i*W/W = A i (since W-d ≤ W).
      have hAnoninc : ∀ i, A (i + 1) ≤ A i := by
        intro i
        rw [hAsucc]
        calc A i * (W - d) / W ≤ A i * W / W :=
              Nat.div_le_div_right (Nat.mul_le_mul_left _ (Nat.sub_le _ _))
          _ = A i := by
              rcases Nat.eq_zero_or_pos W with hW0 | hWpos
              · -- W = 0 ⟹ V = 0 ⟹ Fin V empty; but main regime needs M+1 ≤ W = 0, impossible.
                exfalso; omega
              · rw [Nat.mul_div_cancel _ hWpos]
      -- iteration reaches zero at N.
      have ha0le : A 0 ≤ S := le_of_eq hA0
      have hSlt : S < 2 ^ (L + 1) := by rw [hLdef]; exact Nat.lt_pow_succ_log_self (by norm_num) S
      have hd1 : 1 ≤ d := by omega
      have hdW : d ≤ W := by rw [hddef]; exact hedge
      have hmd : W ≤ m * d := by
        rw [hmdef, hddef]
        have := blocksize_covers W M
        simpa [Nat.mul_comm] using this
      have hAN : A N = 0 :=
        iteration_reaches_zero (V := W) (d := d) (S := S) (L := L) (m := m)
          A hAstep ha0le hSlt hd1 hdW hmd
      -- W > 0 in the main regime (M + 1 ≤ W).
      have hWpos : 0 < W := by omega
      -- The envelope DESCENT for the recursion (W = 2V): 2V*fc' ≤ A i*(2V-d) ⟹ fc' ≤ A(i+1).
      have hAdesc : ∀ (i fc' : Nat), 2 * V * fc' ≤ A i * (2 * V - d) → fc' ≤ A (i + 1) := by
        intro i fc' hle
        rw [hAsucc]
        -- fc' ≤ A i*(W-d)/W ↔ fc'*W ≤ A i*(W-d).
        rw [Nat.le_div_iff_mul_le hWpos]
        -- fc'*W = W*fc' = 2V*fc' ≤ A i*(2V-d) = A i*(W-d).
        rw [hW]
        calc fc' * (2 * V) = 2 * V * fc' := by ring
          _ ≤ A i * (2 * V - d) := hle
      -- fatCount d r₀ ≤ S = A 0.
      have hfat0 : fatCountDag d r₀ ≤ A 0 := by rw [hA0, hS]; exact fatCountDag_le_dagSize d r₀
      -- Apply the recursion at i = 0.
      have hmain := rec_narrow (V := V) d N A hAnoninc hAdesc hAN
        ((N - 0) * (V + 1) + (liveVarsDag r₀).card) 0 F r₀ (le_refl _) hfat0
      -- HasNarrowDag F (w0width F + d + (N - 0)) = HasNarrowDag F (w0width F + d + N).
      rw [Nat.sub_zero] at hmain
      -- d + N ≤ 3M + 3 = dagNarrowingBudget V S via envelope_bound.
      have henv : (M + 1) + (L + 1) * ((W + M) / (M + 1)) ≤ 3 * M + 3 := by
        have := envelope_bound (V := V) (L := L) hL (by rw [← hMdef, ← hW]; exact hedge)
        rw [← hW, ← hMdef] at this
        exact this
      have hdN : d + N ≤ dagNarrowingBudget V S := by
        rw [hbudget, hddef, hNdef, hmdef]
        exact henv
      -- bump to the budget.
      refine HasNarrowDag_mono ?_ hmain
      omega

/-! ## The now-UNCONDITIONAL payoff. -/

/-- **The UNCONDITIONAL exponential `dagSize` lower bound for the concrete K_n Tseitin CNF.**

Feeding the now-PROVEN narrowing port `dagNarrows_sqrt` into
`DagWidthLowerBound.dagSize_ge_exp_quarter` removes the last hypothesis: for `n ≥ 4`,
every `DagRefutation` of the concrete `K_n` Tseitin CNF satisfies
`(n/4)² − w0width cnf ≤ 3·⌊√(2·(n·n)·log₂ S)⌋ + 3`, i.e. `dagSize` is exponential in
the width gap, with NO remaining narrowing assumption. -/
theorem dagSize_ge_exp_quarter_uncond {n : Nat} (hn : 4 ≤ n)
    (r : DagRefutation (cnf (n := n))) :
    ((n / 4) * (n / 4)) - ResolutionSizeWidth.w0width (cnf (n := n)) ≤
      3 * Nat.sqrt (2 * (n * n) * Nat.log 2 (dagSize r.proof)) + 3 :=
  DagWidthLowerBound.dagSize_ge_exp_quarter dagNarrows_sqrt hn r

end DagNarrowsSqrt
end CNFResolution
end PvNP
