import PvNP.SwitchingEncodeConstruct

/-!
# The inductive (Razborov/Beame) route to the term-canonical switching lemma

This file proves the term-canonical switching lemma for *simple* DNFs,
`SwitchingLemmaTermSimple n`, by **strong induction on the number of terms**
`D.length`, the Razborov/Beame inductive route, rather than via the explicit
Razborov encode/decode injection (which is isolated as `TouchedRecoverable`/
`BlockDecodeStep` in `SwitchingEncodeConstruct` and stuck on a hard mutual
induction).

INTEGRITY: no `sorry`, no `admit`, no new `axiom`, no `native_decide`.  Anything
not fully closed is isolated as a `def : Prop` (NOT an axiom) and everything
around it is proved green.  NOT a lower bound, NOT P≠NP.

## Structure of the induction
Target: `(badSetTerm D s ℓ).card ≤ |R^{ℓ-s}| · (8w)^s`.

* **Base `D = []`** and **`D = [] :: _`** (head term constant-true): the
  term-canonical tree is a leaf, depth `0`, so the bad set is `restrictionsWithStars
  n ℓ` when `s = 0` (bound holds with `(8w)^0 = 1` and `ℓ - 0 = ℓ`) and `∅` when
  `s ≥ 1`.

* **Step `D = C :: D'`, `C ≠ []`:** partition `badSetTerm (C :: D') s ℓ` by whether
  the restriction `ρ` *falsifies* `C` (`termRestrict ρ C = none`):
  - **falsify part:** `dnfRestrict ρ (C :: D') = dnfRestrict ρ D'`, so the
    term-canonical tree (hence its depth) is governed by `D'`.  This part is
    *exactly* `badSetTerm D' s ℓ` intersected with the falsify predicate, hence
    `≤ (badSetTerm D' s ℓ).card`, bounded by the IH on `D'` (`length` strictly
    smaller).
  - **non-falsify part:** the first block of the tree queries `C`'s `≤ w` free
    variables; the standard Håstad/Razborov first-block count gives the `(8w)`
    factor against the residual `(s-1, ℓ-1)` bad set, again bounded by the IH on
    `D'`.

The falsify reduction, the partition, and the base case are proved here outright.
The first-block `(8w)` count — the genuine combinatorial heart, the same content
the encode/decode is stuck on — is isolated as the single `def : Prop`
`FirstBlockBound` and the whole induction is proved to reduce to it.
-/

namespace PvNP
namespace SwitchingInductive

open CNFModel
open BoundedDepthDecisionTree
open BoundedDepthCanonicalDT
open BoundedDepthRestriction
open SwitchingLemmaStatement
open SwitchingTermCanonicalDT
open SwitchingEncodeConstruct
open Classical

/-! ## 1. Head-term structural unfolding of `dnfRestrict` -/

/-- `dnfRestrict` on a cons, exposing the head term's fate. -/
theorem dnfRestrict_cons {n : Nat} (ρ : Restriction n) (C : Term n) (D' : DNF n) :
    dnfRestrict ρ (C :: D')
      = (match termRestrict ρ C with
          | some C' => C' :: dnfRestrict ρ D'
          | none => dnfRestrict ρ D') := by
  simp only [dnfRestrict, List.filterMap_cons]
  cases termRestrict ρ C <;> rfl

/-- When `ρ` falsifies the head term `C`, restricting `C :: D'` equals restricting
`D'` alone. -/
theorem dnfRestrict_cons_falsify {n : Nat} (ρ : Restriction n) (C : Term n)
    (D' : DNF n) (h : termRestrict ρ C = none) :
    dnfRestrict ρ (C :: D') = dnfRestrict ρ D' := by
  rw [dnfRestrict_cons, h]

/-! ## 2. The falsify / non-falsify partition of the head-cons bad set

We split `badSetTerm (C :: D') s ℓ` by the decidable predicate
`termRestrict ρ C = none` ("`ρ` falsifies `C`").  On the falsify part the
restricted DNF coincides with `dnfRestrict ρ D'`, so the part is literally a
subset of `badSetTerm D' s ℓ` (depth-preserving reduction). -/

/-- The falsify part: bad restrictions for `C :: D'` that falsify the head `C`. -/
noncomputable def badFalsify {n : Nat} (C : Term n) (D' : DNF n) (s ℓ : Nat) :
    Finset (Restriction n) :=
  (badSetTerm (C :: D') s ℓ).filter (fun ρ => termRestrict ρ C = none)

/-- The non-falsify part: bad restrictions for `C :: D'` that keep the head `C`. -/
noncomputable def badKeep {n : Nat} (C : Term n) (D' : DNF n) (s ℓ : Nat) :
    Finset (Restriction n) :=
  (badSetTerm (C :: D') s ℓ).filter (fun ρ => termRestrict ρ C ≠ none)

/-- The bad set splits as falsify ∪ non-falsify, disjointly. -/
theorem card_badSetTerm_cons_split {n : Nat} (C : Term n) (D' : DNF n) (s ℓ : Nat) :
    (badSetTerm (C :: D') s ℓ).card
      = (badFalsify C D' s ℓ).card + (badKeep C D' s ℓ).card := by
  unfold badFalsify badKeep
  rw [Finset.filter_card_add_filter_neg_card_eq_card]

/-- **Falsify-part reduction (depth-preserving).**  Every bad restriction for
`C :: D'` that falsifies `C` is a bad restriction for `D'` at the *same* `s`, `ℓ`:
falsifying `C` makes `dnfRestrict ρ (C :: D') = dnfRestrict ρ D'`. -/
theorem badFalsify_subset_badSetTerm {n : Nat} (C : Term n) (D' : DNF n) (s ℓ : Nat) :
    badFalsify C D' s ℓ ⊆ badSetTerm D' s ℓ := by
  intro ρ hρ
  unfold badFalsify at hρ
  rw [Finset.mem_filter] at hρ
  obtain ⟨hbad, hfals⟩ := hρ
  rw [mem_badSetTerm] at hbad ⊢
  obtain ⟨hstars, hdepth⟩ := hbad
  refine ⟨hstars, ?_⟩
  rwa [dnfRestrict_cons_falsify ρ C D' hfals] at hdepth

theorem card_badFalsify_le {n : Nat} (C : Term n) (D' : DNF n) (s ℓ : Nat) :
    (badFalsify C D' s ℓ).card ≤ (badSetTerm D' s ℓ).card :=
  Finset.card_le_card (badFalsify_subset_badSetTerm C D' s ℓ)

/-! ### Refinement of the non-falsify part (groundwork for the first block)

For `s ≥ 1`, a non-falsify bad `ρ` cannot *fully satisfy* `C`: if
`termRestrict ρ C = some []` the head term collapses to the constant-true term,
the tree is the constant-true leaf (depth `0 < s`), contradicting badness.  Hence
on `badKeep` (with `s ≥ 1`) the head term restricts to a *nonempty* surviving term
`C'` — exactly the case whose first block the `(8w)` count addresses.  This is a
fully-proved structural narrowing of the residue that the first-block count must
handle. -/

/-- If `ρ` keeps `C` but the surviving term is empty, the restricted tree is the
constant-true leaf (depth `0`). -/
theorem dtDepth_zero_of_termRestrict_nil {n : Nat} (ρ : Restriction n) (C : Term n)
    (D' : DNF n) (h : termRestrict ρ C = some []) :
    dtDepth (termCanonicalDT (dnfRestrict ρ (C :: D'))) = 0 := by
  rw [dnfRestrict_cons, h]
  simp [termCanonicalDT]

/-- **`badKeep` with `s ≥ 1` keeps `C` as a NONEMPTY surviving term.**  Every
non-falsify bad restriction (for `s ≥ 1`) restricts the head term to some
`C' = m :: rest`, never to the empty term and never to `none`. -/
theorem badKeep_termRestrict_nonempty {n : Nat} {C : Term n} {D' : DNF n}
    {s ℓ : Nat} (hs : 1 ≤ s) {ρ : Restriction n} (hρ : ρ ∈ badKeep C D' s ℓ) :
    ∃ (m : Literal n) (rest : Term n), termRestrict ρ C = some (m :: rest) := by
  unfold badKeep at hρ
  rw [Finset.mem_filter, mem_badSetTerm] at hρ
  obtain ⟨⟨_, hdepth⟩, hkeep⟩ := hρ
  cases hC' : termRestrict ρ C with
  | none => exact absurd hC' hkeep
  | some C' =>
      cases C' with
      | nil =>
          rw [dtDepth_zero_of_termRestrict_nil ρ C D' hC'] at hdepth
          omega
      | cons m rest => exact ⟨m, rest, rfl⟩

/-! ## 3. The base case: depth-`0` DNFs

When the restricted term-canonical tree always has depth `0` (the constant DNFs
`[]` and `[] :: _`), the bad set is `restrictionsWithStars n ℓ` for `s = 0` and
`∅` for `s ≥ 1`, and in both cases the switching bound holds. -/

/-- **Generic depth-`0` base bound.**  If `termCanonicalDT (dnfRestrict ρ D)` has
depth `0` for every `ρ`, then the switching bound holds for `D` (for any `w`). -/
theorem switching_bound_of_depth_zero {n : Nat} (D : DNF n) (w s ℓ : Nat)
    (hdepth0 : ∀ ρ : Restriction n,
      dtDepth (termCanonicalDT (dnfRestrict ρ D)) = 0) :
    (badSetTerm D s ℓ).card
      ≤ (restrictionsWithStars n (ℓ - s)).card * (8 * w) ^ s := by
  cases s with
  | zero =>
      -- s = 0: badSet = restrictionsWithStars n ℓ, bound is equality-ish.
      simp only [Nat.sub_zero, pow_zero, Nat.mul_one]
      have hbad : badSetTerm D 0 ℓ = restrictionsWithStars n ℓ := by
        apply Finset.Subset.antisymm (badSetTerm_subset D 0 ℓ)
        intro ρ hρ
        rw [mem_badSetTerm]
        exact ⟨(mem_restrictionsWithStars ρ).mp hρ, Nat.zero_le _⟩
      rw [hbad]
  | succ s' =>
      -- s ≥ 1: badSet empty (depth 0 < s).
      have hempty : badSetTerm D (s' + 1) ℓ = ∅ := by
        rw [Finset.eq_empty_iff_forall_not_mem]
        intro ρ hρ
        have := ((mem_badSetTerm ρ).mp hρ).2
        rw [hdepth0 ρ] at this
        omega
      rw [hempty]; simp

/-- `dnfRestrict ρ [] = []`. -/
@[simp] theorem dnfRestrict_nil {n : Nat} (ρ : Restriction n) :
    dnfRestrict ρ ([] : DNF n) = [] := rfl

/-- Base bound for the empty DNF. -/
theorem switching_bound_nil {n : Nat} (w s ℓ : Nat) :
    (badSetTerm ([] : DNF n) s ℓ).card
      ≤ (restrictionsWithStars n (ℓ - s)).card * (8 * w) ^ s := by
  apply switching_bound_of_depth_zero
  intro _ρ
  simp [termCanonicalDT]

/-- `dnfRestrict ρ ([] :: D')` has the head term restrict to `some []` (the empty
term is never falsified), so the tree is the constant-true leaf, depth `0`. -/
theorem switching_bound_nil_cons {n : Nat} (D' : DNF n) (w s ℓ : Nat) :
    (badSetTerm (([] : Term n) :: D') s ℓ).card
      ≤ (restrictionsWithStars n (ℓ - s)).card * (8 * w) ^ s := by
  apply switching_bound_of_depth_zero
  intro ρ
  rw [dnfRestrict_cons]
  simp only [termRestrict]
  simp [termCanonicalDT]

/-! ## 4. Width monotonicity across the head cons

`widthDNF D' ≤ widthDNF (C :: D')`, so a width budget `w` for `C :: D'` is also a
width budget for the tail `D'` — letting the IH apply at the same `w`. -/

theorem widthDNF_tail_le {n : Nat} (C : Term n) (D' : DNF n) :
    widthDNF D' ≤ widthDNF (C :: D') := widthDNF_le_of_cons C D'

/-! ## 5. The isolated inductive step and the strong-induction reduction

The genuine combinatorial heart of the Razborov/Beame inductive proof — the
first-block `(8w)` count for the non-falsify part TOGETHER with the constant
accounting that bounds `falsify + keep` by the single budget `|R^{ℓ-s}|·(8w)^s`
— is isolated as the single `def : Prop` `InductiveStep`.  It takes the inductive
hypothesis for the strictly shorter tail `D'` (at *all* parameters `s' ℓ'`) and
must deliver the bound for the head-cons `C :: D'`.

Everything around it — the strong induction on `D.length`, the two leaf base
cases, the falsify/keep partition and the depth-preserving falsify reduction
(`badFalsify_subset_badSetTerm`), and the width monotonicity that feeds the IH —
is proved outright below.  This is the honest residue: the SINGLE place the
first-block counting lives. -/

/-- **The isolated inductive step (a `def : Prop`, NOT an axiom).**  Given the IH
for the strictly shorter tail `D'` at *all* parameters and a width budget `w` for
the head-cons (with the head term `C` nonempty and `C :: D'` simple), the term
switching bound holds for `C :: D'`.  This bundles the first-block count and the
`falsify + keep` constant accounting — the genuine Håstad/Razborov heart. -/
def InductiveStep (n : Nat) : Prop :=
  ∀ (C : Term n) (D' : DNF n) (w s ℓ : Nat),
    SimpleDNF (C :: D') → widthDNF (C :: D') ≤ w → C ≠ [] →
    (∀ (s' ℓ' : Nat),
      (badSetTerm D' s' ℓ').card
        ≤ (restrictionsWithStars n (ℓ' - s')).card * (8 * w) ^ s') →
    (badSetTerm (C :: D') s ℓ).card
      ≤ (restrictionsWithStars n (ℓ - s)).card * (8 * w) ^ s

/-- Auxiliary: the switching bound for one fixed `D`, all `w s ℓ`, under a width
budget hypothesis is most cleanly phrased per-`D`.  We prove the universally
quantified bound by strong induction on `D.length`. -/
theorem switchingLemmaTermSimple_inductive_aux {n : Nat} (hstep : InductiveStep n) :
    ∀ (k : Nat) (D : DNF n), D.length = k → SimpleDNF D →
      ∀ (w s ℓ : Nat), widthDNF D ≤ w →
        (badSetTerm D s ℓ).card
          ≤ (restrictionsWithStars n (ℓ - s)).card * (8 * w) ^ s := by
  intro k
  induction k using Nat.strong_induction_on with
  | _ k ih =>
    intro D hlen hsimp w s ℓ hw
    match D with
    | [] => exact switching_bound_nil w s ℓ
    | [] :: D' => exact switching_bound_nil_cons D' w s ℓ
    | (c :: cs) :: D' =>
        -- Head term C = c :: cs is nonempty; apply the inductive step with the IH
        -- for the strictly shorter tail D'.
        set C : Term n := c :: cs with hC
        have hClen : (C :: D').length = k := hlen
        have hD'len : D'.length < k := by
          simp only [List.length_cons] at hClen ⊢; omega
        have hwD' : widthDNF D' ≤ w :=
          le_trans (widthDNF_tail_le C D') hw
        have hsimpD' : SimpleDNF D' := fun t ht => hsimp t (List.mem_cons_of_mem C ht)
        have hIH : ∀ (s' ℓ' : Nat),
            (badSetTerm D' s' ℓ').card
              ≤ (restrictionsWithStars n (ℓ' - s')).card * (8 * w) ^ s' := by
          intro s' ℓ'
          exact ih D'.length hD'len D' rfl hsimpD' w s' ℓ' hwD'
        have hCne : C ≠ [] := by simp [hC]
        exact hstep C D' w s ℓ hsimp hw hCne hIH

/-- **The term switching lemma for simple DNFs, via the inductive route — reduced
to the single isolated `InductiveStep`.**  The strong induction on the number of
terms, the leaf base cases, the falsify/keep partition with its depth-preserving
falsify reduction, and the width bookkeeping are all proved; the sole residue is
`InductiveStep` (the first-block count + constant accounting). -/
theorem switchingLemmaTermSimple_inductive {n : Nat} (hstep : InductiveStep n) :
    SwitchingLemmaTermSimple n := by
  intro D w s ℓ hsimp hw
  exact switchingLemmaTermSimple_inductive_aux hstep D.length D rfl hsimp w s ℓ hw

end SwitchingInductive
end PvNP
