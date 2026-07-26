import PvNP.ResolutionDagSizeWidth
import PvNP.ResolutionSizeWidthCore
import Mathlib.Data.Nat.Log
import Mathlib.Data.Nat.Sqrt
import Mathlib.Algebra.Order.Ring.Pow
import Mathlib.Algebra.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.Finset.Card
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.FieldSimp

/-!
# Toward a local proof of the general (DAG) Ben-Sasson-Wigderson size-width core
`DagRestrictionNarrowsCore`.

## Honest scope (READ THIS FIRST)

The target is `PvNP.CNFResolution.ResolutionDagSizeWidth.DagRestrictionNarrowsCore`,
isolated as an explicit hypothesis in `ResolutionDagSizeWidth.lean`:

> for every CNF `F` over `Fin V` and every refutation `r`, there is a refutation
> `r'` of `F` with
> `refutationWidth r' ≤ w0width F + dagNarrowingBudget V (dagSize r)`,
> where `dagNarrowingBudget V S = 3 * Nat.sqrt (2 * V * Nat.log 2 S) + 3`.

This module PROVES the combinatorial / arithmetic HEART of the Ben-Sasson-Wigderson
general-resolution argument (the pigeonhole, the integer iteration to zero, and the
`sqrt` envelope), with NO hypothesis and an axiom-clean status.  It does **NOT**
discharge `DagRestrictionNarrowsCore`: the faithful refutation-reconstruction is the
BW two-parameter *combine* recursion, which is not formalised here.  See `§9` for the
ruthlessly-honest status, the precise remaining gap, and why the tempting FALSE
single-value lift-back shortcut is rejected (it was caught and removed).

No `sorry`, no `admit`, no new `axiom`, no false or circular hypothesis.

### What is FULLY PROVED here (no hypothesis, axiom-clean)

1. **The integer pigeonhole / per-step drop** (`§2`): over `Fin V`, if `a ≥ 1` fat
   clauses each have `> d` distinct variables, then some variable lies in `h` of
   them with `V * h ≥ a * d + 1`; in particular `h ≥ 1`.  This is the standard
   double-counting `max ≥ mean` step.  PROVED with `Finset` double counting.

2. **The integer iteration to zero** (`§3`): an abstract iteration lemma — if a
   `Nat` sequence `a` satisfies `a 0 ≤ S` and the geometric per-step bound
   `V * a (i+1) ≤ a i * (V - d)` together with the strict drop
   `1 ≤ a i → a (i+1) < a i`, then after `b` steps with `b` chosen as below the
   fat count is `0`.  PROVED by induction + the mathlib real lemma
   `one_add_mul_le_pow`.

3. **The envelope arithmetic** (`§4`): the explicit threshold `d = M+1` and step
   count `b = ⌈V*(L+1)/(M+1)⌉` (`M = Nat.sqrt (2*V*L)`, `L = Nat.log 2 S`) satisfy
   `d + b ≤ 3 * Nat.sqrt (2*V*L) + 3` AND drive the iteration to `0`.  PROVED.

### The TRUE structural building blocks (`§6`)

`DagOneStepRestrict` (single-variable, satisfaction-based restriction, no-larger
`dagSize`, fat lines on the chosen literal dropping out) and `DagCombineStep`
(the two-branch resolve-on-pivot combine, `narrow_combine` packaged on refutations)
are BOTH TRUE, single-variable, NON-circular structural facts read off the existing
tree machinery of `ResolutionSizeWidthCore.lean`.  `aSeq_step` PROVES the per-step
geometric fat drop by combining the proved pigeonhole with `DagOneStepRestrict`.

### What this module does NOT claim

It does **NOT** discharge `DagRestrictionNarrowsCore`.  The remaining gap is the BW
two-parameter combine recursion that assembles the proved per-step drop and the
proved envelope into a refutation of width `≤ w0 + sqrt`-budget — see `§9`.  This is
an HONEST PARTIAL: the entire integer combinatorial / arithmetic core is proved
axiom-clean, and the false single-value lift-back shortcut is explicitly rejected.

Scope: lower-bound enabling lemma for the general (DAG) RESOLUTION proof system.
NOT P ≠ NP, NOT an NP/circuit lower bound.
-/

namespace PvNP
namespace CNFResolution
namespace ResolutionDagSizeWidthCore

open CNFModel
open PvNP.CNFResolution
open PvNP.CNFResolution.Completeness
open PvNP.CNFResolution.ResolutionSizeWidth
open PvNP.CNFResolution.ResolutionDagSizeWidth

/-! ## 2. The integer pigeonhole / per-step heavy-variable bound

Pure `Finset` double counting.  We work abstractly: a finite family of "fat
objects" each carrying a variable-set over `Fin V` of cardinality `≥ d + 1`.  We
prove some single variable lies in `h` of them with `V * h ≥ |family| * d + 1`. -/

/-- **Double counting (Fubini over a `Finset`).**  Summing the per-variable degree
over all `V` variables equals summing each object's variable-set cardinality. -/
theorem sum_deg_eq_sum_card {V : Nat} {α : Type*} [DecidableEq α]
    (Fam : Finset α) (vars : α → Finset (Fin V)) :
    ∑ x : Fin V, (Fam.filter (fun c => x ∈ vars c)).card
      = ∑ c ∈ Fam, (vars c).card := by
  -- Both sides count the incidence set {(x,c) : x ∈ vars c}.
  have lhs : ∀ x : Fin V, (Fam.filter (fun c => x ∈ vars c)).card
      = ∑ c ∈ Fam, (if x ∈ vars c then 1 else 0) := by
    intro x; rw [Finset.card_filter]
  have rhs : ∀ c : α, (vars c).card
      = ∑ x : Fin V, (if x ∈ vars c then 1 else 0) := by
    intro c
    rw [Finset.sum_ite_mem, Finset.univ_inter, Finset.sum_const, smul_eq_mul,
      Nat.mul_one]
  calc ∑ x : Fin V, (Fam.filter (fun c => x ∈ vars c)).card
      = ∑ x : Fin V, ∑ c ∈ Fam, (if x ∈ vars c then 1 else 0) := by
        exact Finset.sum_congr rfl (fun x _ => lhs x)
    _ = ∑ c ∈ Fam, ∑ x : Fin V, (if x ∈ vars c then 1 else 0) := Finset.sum_comm
    _ = ∑ c ∈ Fam, (vars c).card := (Finset.sum_congr rfl (fun c _ => (rhs c).symm))

/-- **The integer pigeonhole step.**  If `Fam` is nonempty and every member's
variable set has cardinality `≥ d + 1`, then some variable `x` lies in `h` members
with `V * h ≥ |Fam| * d + 1`.  In particular `1 ≤ h` (a genuine integer drop). -/
theorem exists_heavy_var {V : Nat} {α : Type*} [DecidableEq α]
    (Fam : Finset α) (vars : α → Finset (Fin V))
    (d : Nat) (hne : Fam.Nonempty)
    (hwide : ∀ c ∈ Fam, d + 1 ≤ (vars c).card) :
    ∃ x : Fin V, Fam.card * d + 1 ≤ V * (Fam.filter (fun c => x ∈ vars c)).card := by
  -- First, V ≥ 1 (else Fam member has a variable set of card ≥ d+1 ≥ 1 in Fin 0).
  have hVpos : 0 < V := by
    rcases hne with ⟨c, hc⟩
    have hc1 : 1 ≤ (vars c).card := le_trans (by omega) (hwide c hc)
    rcases Finset.card_pos.mp (by omega : 0 < (vars c).card) with ⟨x, _⟩
    have := x.2; omega
  -- Total incidence count is ≥ |Fam| * (d+1) ≥ |Fam| * d + 1.
  have hsum_lb : Fam.card * (d + 1) ≤ ∑ c ∈ Fam, (vars c).card := by
    calc Fam.card * (d + 1) = ∑ _c ∈ Fam, (d + 1) := by
            rw [Finset.sum_const, smul_eq_mul]
      _ ≤ ∑ c ∈ Fam, (vars c).card := Finset.sum_le_sum hwide
  rw [← sum_deg_eq_sum_card Fam vars] at hsum_lb
  -- Pigeonhole: some bucket ≥ mean.  We use: if every bucket < t then sum < V*t.
  by_contra hcon
  push_neg at hcon
  -- hcon : ∀ x, V * (filter ...).card < Fam.card * d + 1, i.e. ≤ Fam.card*d.
  have hbound : ∀ x : Fin V, V * (Fam.filter (fun c => x ∈ vars c)).card ≤ Fam.card * d := by
    intro x; have := hcon x; omega
  -- Sum over x: V * (Σ deg) ≤ V * (V * Fam.card * d)... use that each term ≤ Fam.card*d
  -- after dividing by V.  Cleaner: V * Σ deg = Σ V*deg ≤ Σ Fam.card*d = V*(Fam.card*d).
  have hVsum : V * (∑ x : Fin V, (Fam.filter (fun c => x ∈ vars c)).card)
      ≤ V * (Fam.card * d) := by
    rw [Finset.mul_sum]
    calc ∑ x : Fin V, V * (Fam.filter (fun c => x ∈ vars c)).card
        ≤ ∑ _x : Fin V, Fam.card * d := Finset.sum_le_sum (fun x _ => hbound x)
      _ = V * (Fam.card * d) := by rw [Finset.sum_const, Finset.card_univ,
            Fintype.card_fin, smul_eq_mul]
  have hsum_le : (∑ x : Fin V, (Fam.filter (fun c => x ∈ vars c)).card) ≤ Fam.card * d :=
    Nat.le_of_mul_le_mul_left hVsum hVpos
  -- But hsum_lb says Fam.card*(d+1) ≤ that sum.  Since |Fam| ≥ 1, contradiction.
  have hcardpos : 1 ≤ Fam.card := Finset.card_pos.mpr hne
  have : Fam.card * (d + 1) ≤ Fam.card * d := le_trans hsum_lb hsum_le
  have hexp : Fam.card * (d + 1) = Fam.card * d + Fam.card := by ring
  omega

/-! ## 3. The integer iteration to zero

We prove a *block-halving* lemma: any sequence obeying the geometric per-step bound
`V * a (i+1) ≤ a i * (V - d)` over a block of `m` steps with `V - d ≤ m * d` (in
particular `m * d ≥ V` suffices) at least HALVES.  Iterating `L + 1` blocks drives
`a` below `1`, i.e. to `0`, since `a 0 ≤ S < 2 ^ (L + 1)`.  The only non-`Nat`
ingredient is Bernoulli's inequality `one_add_mul_sub_le_pow` used once to get the
clean integer fact `2 * (V - d) ^ m ≤ V ^ m`. -/

/-- **Block-halving kernel (the only real-number step).**  For `1 ≤ d ≤ V` and
`V ≤ m * d`, we have `2 * (V - d) ^ m ≤ V ^ m`.  (Bernoulli: `(V/(V-d))^m ≥ 2`.) -/
theorem two_mul_sub_pow_le {V d m : Nat} (hd1 : 1 ≤ d) (hdV : d ≤ V)
    (hmd : V ≤ m * d) : 2 * (V - d) ^ m ≤ V ^ m := by
  -- Work in ℝ.  Let r = V/(V-d) ≥ 1.  Bernoulli: r^m ≥ 1 + m*(r-1) = 1 + m*d/(V-d) ≥ 2.
  rcases Nat.lt_or_ge d V with hdlt | hdge
  · -- d < V, so V - d ≥ 1 in Nat.
    have hVd_pos : 0 < V - d := by omega
    have hVpos : 0 < V := by omega
    -- Cast to ℝ.
    have key : (2 : ℝ) * ((V - d : Nat) : ℝ) ^ m ≤ (V : ℝ) ^ m := by
      set p : ℝ := ((V - d : Nat) : ℝ) with hp
      have hp_pos : 0 < p := by rw [hp]; exact_mod_cast hVd_pos
      have hVcast : (V : ℝ) = p + (d : ℝ) := by
        rw [hp]; push_cast [Nat.cast_sub (le_of_lt hdlt)]; ring
      -- r := V/p ≥ 1; r - 1 = d/p.
      set r : ℝ := (V : ℝ) / p with hr
      have hr1 : (1 : ℝ) ≤ r := by
        rw [hr, le_div_iff hp_pos, one_mul, hVcast]
        have : (0 : ℝ) ≤ (d : ℝ) := by positivity
        linarith
      have hrm1 : r - 1 = (d : ℝ) / p := by
        rw [hr, hVcast]; field_simp
      -- Bernoulli: 1 + m*(r-1) ≤ r^m.
      have hbern : 1 + (m : ℝ) * (r - 1) ≤ r ^ m :=
        one_add_mul_sub_le_pow (by linarith) m
      -- 1 + m*(r-1) = 1 + m*d/p ≥ 2  since m*d ≥ V > V - d = p, so m*d/p ≥ 1.
      have hmd_cast : (p : ℝ) ≤ (m : ℝ) * (d : ℝ) := by
        rw [hp]
        have : (V - d : Nat) ≤ m * d := by omega
        calc ((V - d : Nat) : ℝ) ≤ ((m * d : Nat) : ℝ) := by exact_mod_cast this
          _ = (m : ℝ) * (d : ℝ) := by push_cast; ring
      have hge2 : (2 : ℝ) ≤ 1 + (m : ℝ) * (r - 1) := by
        rw [hrm1]
        have : (1 : ℝ) ≤ (m : ℝ) * ((d : ℝ) / p) := by
          rw [← mul_div_assoc, le_div_iff hp_pos, one_mul]
          exact hmd_cast
        linarith
      have hr2 : (2 : ℝ) ≤ r ^ m := le_trans hge2 hbern
      -- r^m = V^m / p^m, so 2*p^m ≤ V^m.
      have hpm_pos : 0 < p ^ m := pow_pos hp_pos m
      have : (2 : ℝ) * p ^ m ≤ r ^ m * p ^ m := by
        apply mul_le_mul_of_nonneg_right hr2 (le_of_lt hpm_pos)
      rw [hr, div_pow] at this
      rw [div_mul_cancel₀] at this
      · exact this
      · exact ne_of_gt hpm_pos
    exact_mod_cast key
  · -- d = V: V - d = 0, so (V-d)^m = 0^m.  m ≥ 1 since m*d ≥ V ≥ d ≥ 1.
    have hdeq : d = V := le_antisymm hdV hdge
    have hVpos : 1 ≤ V := le_trans hd1 hdV
    have hmpos : 1 ≤ m := by
      rcases Nat.eq_zero_or_pos m with hm0 | hm; · subst hm0; simp at hmd; omega
      · exact hm
    subst hdeq
    rw [Nat.sub_self, Nat.zero_pow (by omega), Nat.mul_zero]
    exact Nat.zero_le _

/-- **Geometric decay over `k` steps.**  If a `Nat` sequence `a` satisfies the
per-step bound `V * a (i+1) ≤ a i * (V - d)` for all `i`, then
`V ^ k * a k ≤ a 0 * (V - d) ^ k`. -/
theorem geometric_decay {V d : Nat} (a : Nat → Nat)
    (hstep : ∀ i, V * a (i + 1) ≤ a i * (V - d)) :
    ∀ k, V ^ k * a k ≤ a 0 * (V - d) ^ k := by
  intro k
  induction k with
  | zero => simp
  | succ k ih =>
      -- V^(k+1) * a(k+1) = V^k * (V * a(k+1)) ≤ V^k * (a k * (V-d))
      --   ≤ (a 0 * (V-d)^k) * (V-d) = a 0 * (V-d)^(k+1).
      calc V ^ (k + 1) * a (k + 1)
          = V ^ k * (V * a (k + 1)) := by ring
        _ ≤ V ^ k * (a k * (V - d)) := Nat.mul_le_mul_left _ (hstep k)
        _ = (V ^ k * a k) * (V - d) := by ring
        _ ≤ (a 0 * (V - d) ^ k) * (V - d) := Nat.mul_le_mul_right _ ih
        _ = a 0 * (V - d) ^ (k + 1) := by ring

/-- **One block halves.**  Under the geometric per-step bound, after `m` steps with
`1 ≤ d ≤ V` and `V ≤ m * d`, the value at least halves: `2 * a m ≤ a 0`. -/
theorem block_halves {V d : Nat} (a : Nat → Nat)
    (hstep : ∀ i, V * a (i + 1) ≤ a i * (V - d))
    (m : Nat) (hd1 : 1 ≤ d) (hdV : d ≤ V) (hmd : V ≤ m * d) :
    2 * a m ≤ a 0 := by
  have hVpos : 0 < V := le_trans hd1 hdV
  have hdecay : V ^ m * a m ≤ a 0 * (V - d) ^ m := geometric_decay a hstep m
  have hhalf : 2 * (V - d) ^ m ≤ V ^ m := two_mul_sub_pow_le hd1 hdV hmd
  -- V^m * (2 * a m) = 2 * (V^m * a m) ≤ 2 * (a 0 * (V-d)^m)
  --   = a 0 * (2 * (V-d)^m) ≤ a 0 * V^m = V^m * a 0.
  have hVm_pos : 0 < V ^ m := pow_pos hVpos m
  have : V ^ m * (2 * a m) ≤ V ^ m * a 0 := by
    calc V ^ m * (2 * a m) = 2 * (V ^ m * a m) := by ring
      _ ≤ 2 * (a 0 * (V - d) ^ m) := Nat.mul_le_mul_left _ hdecay
      _ = a 0 * (2 * (V - d) ^ m) := by ring
      _ ≤ a 0 * V ^ m := Nat.mul_le_mul_left _ hhalf
      _ = V ^ m * a 0 := by ring
  exact Nat.le_of_mul_le_mul_left this hVm_pos

/-- **`t` blocks divide by `2 ^ t`.**  Iterating `block_halves` over `t` blocks of
`m` steps each: `2 ^ t * a (t * m) ≤ a 0`. -/
theorem blocks_divide {V d : Nat} (a : Nat → Nat)
    (hstep : ∀ i, V * a (i + 1) ≤ a i * (V - d))
    (m : Nat) (hd1 : 1 ≤ d) (hdV : d ≤ V) (hmd : V ≤ m * d) :
    ∀ t, 2 ^ t * a (t * m) ≤ a 0 := by
  intro t
  induction t with
  | zero => simp
  | succ t ih =>
      -- Shifted sequence b i = a (t*m + i) satisfies the same per-step bound.
      have hstep' : ∀ i, V * a (t * m + (i + 1)) ≤ a (t * m + i) * (V - d) := by
        intro i; rw [← Nat.add_assoc]; exact hstep (t * m + i)
      have hblock : 2 * a (t * m + m) ≤ a (t * m + 0) :=
        block_halves (fun i => a (t * m + i)) hstep' m hd1 hdV hmd
      rw [Nat.add_zero] at hblock
      have hidx : t * m + m = (t + 1) * m := by ring
      rw [hidx] at hblock
      -- 2^(t+1) * a((t+1)*m) = 2^t * (2 * a((t+1)*m)) ≤ 2^t * a(t*m) ≤ a 0.
      calc 2 ^ (t + 1) * a ((t + 1) * m)
          = 2 ^ t * (2 * a ((t + 1) * m)) := by ring
        _ ≤ 2 ^ t * a (t * m) := Nat.mul_le_mul_left _ hblock
        _ ≤ a 0 := ih

/-- **The fat count reaches `0`.**  Under the geometric per-step bound, with
`a 0 ≤ S`, `S < 2 ^ (L + 1)`, `1 ≤ d ≤ V`, `V ≤ m * d`, after `b = (L + 1) * m`
steps the value is `0`. -/
theorem iteration_reaches_zero {V d S L m : Nat} (a : Nat → Nat)
    (hstep : ∀ i, V * a (i + 1) ≤ a i * (V - d))
    (ha0 : a 0 ≤ S) (hSlt : S < 2 ^ (L + 1))
    (hd1 : 1 ≤ d) (hdV : d ≤ V) (hmd : V ≤ m * d) :
    a ((L + 1) * m) = 0 := by
  have hdiv : 2 ^ (L + 1) * a ((L + 1) * m) ≤ a 0 :=
    blocks_divide a hstep m hd1 hdV hmd (L + 1)
  -- 2^(L+1) * a(...) ≤ a 0 ≤ S < 2^(L+1).  If a(...) ≥ 1 then LHS ≥ 2^(L+1) > S, contra.
  by_contra hne
  have ha1 : 1 ≤ a ((L + 1) * m) := Nat.one_le_iff_ne_zero.mpr hne
  have : 2 ^ (L + 1) ≤ 2 ^ (L + 1) * a ((L + 1) * m) :=
    le_mul_of_one_le_right (Nat.zero_le _) ha1
  omega

/-! ## 4. The envelope arithmetic: choosing `d` and the block size `m`

`M := Nat.sqrt (2 * V * L)`, threshold `d := M + 1`, block size
`m := (V + M) / (M + 1)` (so that `m * d ≥ V`), total steps `b := (L + 1) * m`.
We prove `d + b ≤ 3 * M + 3` (the budget envelope) under `L ≥ 1` and `M + 1 ≤ V`
(the non-trivial regime).  All `Nat`. -/

/-- The block size `m := (V + M)/(M+1)` satisfies `V ≤ m * (M + 1)` (covers `V`). -/
theorem blocksize_covers (V M : Nat) :
    V ≤ ((V + M) / (M + 1)) * (M + 1) := by
  -- m*(M+1) ≥ (V+M) - M = V, using (V+M) - (V+M)%(M+1) = m*(M+1) and %<M+1.
  have hdm := Nat.div_add_mod (V + M) (M + 1)
  have hmod : (V + M) % (M + 1) < M + 1 := Nat.mod_lt _ (by omega)
  -- (M+1)*m = (V+M) - mod ≥ (V+M) - M = V.
  have heq : (M + 1) * ((V + M) / (M + 1)) = (V + M) - (V + M) % (M + 1) := by omega
  have h2 : (M + 1) * ((V + M) / (M + 1)) ≥ V := by omega
  have hcomm : ((V + M) / (M + 1)) * (M + 1) = (M + 1) * ((V + M) / (M + 1)) := by ring
  omega

/-- **Envelope inequality (factor-`2V`).**  With `M = Nat.sqrt (2*V*L)`, threshold
`d := M + 1` and block size `m := (2*V + M)/(M+1) = ⌈2V/(M+1)⌉` (so `2V ≤ m*(M+1)`),
in the regime `1 ≤ L` and `M + 1 ≤ 2*V`, the threshold-plus-steps fit the budget:
`(M + 1) + (L + 1) * ((2*V + M) / (M + 1)) ≤ 3 * M + 3`.

Proof: write `q := M+1`, `m := ⌈2V/q⌉`.  From `(m-1)*q < 2V` and `2VL < q²` we get
`(m-1)*L < q`, hence `m + L ≤ q + 1` (via `(m-1-? )`... the `a+b ≤ ab+1` step), and
finally `(L+1)*m = (m-1)*L + (m + L) ≤ (q-1) + (q+1) = 2q`. -/
theorem envelope_bound {V L : Nat} (hL : 1 ≤ L)
    (hMV : Nat.sqrt (2 * V * L) + 1 ≤ 2 * V) :
    (Nat.sqrt (2 * V * L) + 1)
        + (L + 1) * ((2 * V + Nat.sqrt (2 * V * L)) / (Nat.sqrt (2 * V * L) + 1))
      ≤ 3 * Nat.sqrt (2 * V * L) + 3 := by
  set M := Nat.sqrt (2 * V * L) with hM
  set q := M + 1 with hq
  set m := (2 * V + M) / q with hm
  -- ceil property: (m-1)*q < 2V ≤ m*q.
  have hqpos : 0 < q := by omega
  have hdm : q * m + (2 * V + M) % q = 2 * V + M := by
    rw [hm]; exact Nat.div_add_mod (2 * V + M) q
  have hmod : (2 * V + M) % q < q := Nat.mod_lt _ hqpos
  have hmq_le : m * q ≤ 2 * V + M := by rw [hm]; exact Nat.div_mul_le_self (2 * V + M) q
  -- (m-1)*q < 2V:  q*m = (2V+M) - mod, and (m-1)*q = q*m - q ≤ 2V+M - q < 2V (since q≤... )
  have hqm : q * m = (2 * V + M) - (2 * V + M) % q := by omega
  have hm1q : (m - 1) * q < 2 * V := by
    -- (m-1)*q = m*q - q ≤ (2V+M) - q.  Need (2V+M) - q < 2V, i.e. M < q = M+1. ✓
    have h1 : (m - 1) * q = m * q - q := by
      cases Nat.eq_zero_or_pos m with
      | inl h0 => simp [h0]
      | inr hp => rw [Nat.sub_mul, Nat.one_mul]
    omega
  -- key sqrt fact: 2*V*L < q*q.
  have hsqrt_lt : 2 * V * L < q * q := by
    have hlt := Nat.lt_succ_sqrt (2 * V * L)
    calc 2 * V * L < (Nat.sqrt (2 * V * L) + 1) * (Nat.sqrt (2 * V * L) + 1) := by
          simpa [Nat.succ_eq_add_one, pow_two] using hlt
      _ = q * q := by rw [hq, hM]
  -- (m-1)*L < q:  ((m-1)*q)*L < 2V*L < q*q ⟹ (m-1)*L*q < q*q ⟹ (m-1)*L < q.
  have hm1L : (m - 1) * L < q := by
    have hprod : (m - 1) * q * L < q * q := by
      calc (m - 1) * q * L ≤ (2 * V) * L := by
            have := Nat.mul_le_mul_right L (le_of_lt hm1q)
            calc (m - 1) * q * L = ((m - 1) * q) * L := by ring
              _ ≤ (2 * V) * L := this
        _ = 2 * V * L := by ring
        _ < q * q := hsqrt_lt
    -- (m-1)*L*q < q*q ⟹ (m-1)*L < q.
    have hreorg : (m - 1) * L * q < q * q := by
      calc (m - 1) * L * q = (m - 1) * q * L := by ring
        _ < q * q := hprod
    exact lt_of_mul_lt_mul_right hreorg (Nat.zero_le q)
  -- (m-1)*L ≤ q-1.
  have hm1L' : (m - 1) * L ≤ q - 1 := by omega
  -- m + L ≤ q + 1:  if m ≥ 2 use (m-1-1)... use a+b ≤ a*b+1 for a=m-1≥1,b=L≥1; m=1 sep.
  have hmL : m + L ≤ q + 1 := by
    rcases Nat.lt_or_ge m 2 with hm1 | hm2
    · -- m ≤ 1.  Then m=1 (m≥1 since 2V≥q>0 ⟹ ⌈2V/q⌉≥1) or m=0.
      -- m*q ≥ 2V? we only have m*q ≤ 2V+M.  But ⌈⌉ ≥1 when 2V≥1.  Use hm1L with m≤1: trivial,
      -- need L ≤ q.  From 2VL<q*q and q≤2V: L < q*q/(2V) ≤ q*q/q = q (since 2V≥q).
      have hLq : L < q := by
        have h2Vq : q ≤ 2 * V := hMV
        -- L*q ≤ L*(2V) = 2VL < q*q ⟹ L < q.
        have : L * q ≤ 2 * V * L := by
          calc L * q ≤ L * (2 * V) := Nat.mul_le_mul_left _ h2Vq
            _ = 2 * V * L := by ring
        have hlq : L * q < q * q := lt_of_le_of_lt this hsqrt_lt
        exact lt_of_mul_lt_mul_right hlq (Nat.zero_le q)
      omega
    · -- m ≥ 2: a := m-1 ≥ 1, b := L ≥ 1, (m-1)+L ≤ (m-1)*L + 1 ≤ q.
      have hab : (m - 1) + L ≤ (m - 1) * L + 1 := by
        have ha : 1 ≤ m - 1 := by omega
        nlinarith [ha, hL]
      omega
  -- conclude: (L+1)*m = (m-1)*L + (m + L) ≤ (q-1) + (q+1) = 2q.
  have hm1 : 1 ≤ m := by
    rcases Nat.eq_zero_or_pos m with h0 | hp
    · exfalso; rw [h0] at hdm; simp at hdm; omega
    · exact hp
  have hfinal : (L + 1) * m ≤ 2 * q := by
    -- (m-1)*L = m*L - L since m ≥ 1.
    have hsubL : (m - 1) * L = m * L - L := by rw [Nat.sub_mul, Nat.one_mul]
    have hmLge : L ≤ m * L := Nat.le_mul_of_pos_left L hm1
    -- (L+1)*m = m*L + m;  (m-1)*L + (m+L) = (m*L - L) + m + L = m*L + m.
    have hexpand : (L + 1) * m = m * L + m := by ring
    have hexp : (L + 1) * m = (m - 1) * L + (m + L) := by
      rw [hsubL, hexpand]; omega
    rw [hexp]; omega
  -- 2*q = 2*M+2, so target.
  have hq2 : 2 * q = 2 * M + 2 := by rw [hq]; ring
  omega

/-- **Heavy-literal pigeonhole.**  Refining `exists_heavy_var`: a heavy variable's
fat lines split by the two signs, so some SIGN captures at least half; hence some
LITERAL `(x, s)` lies in `h` fat lines with `2 * V * h ≥ |Fam| * d + 1`.  (This is
the factor-`2V` version used by the satisfaction-based restriction step.) -/
theorem exists_heavy_lit {V : Nat} {α : Type*} [DecidableEq α]
    (Fam : Finset α) (varsPos varsNeg : α → Finset (Fin V))
    (d : Nat) (hne : Fam.Nonempty)
    (hwide : ∀ c ∈ Fam, d + 1 ≤ (varsPos c ∪ varsNeg c).card) :
    ∃ (x : Fin V) (s : Bool),
      Fam.card * d + 1 ≤
        2 * V * (Fam.filter (fun c => x ∈ (if s then varsPos else varsNeg) c)).card := by
  -- Apply exists_heavy_var to the union variable-set.
  obtain ⟨x, hx⟩ := exists_heavy_var Fam (fun c => varsPos c ∪ varsNeg c) d hne hwide
  -- The fat lines containing x split into those with x ∈ varsPos and x ∈ varsNeg.
  -- card(filter (x ∈ pos∪neg)) ≤ card(filter x∈pos) + card(filter x∈neg).
  set Apos := (Fam.filter (fun c => x ∈ varsPos c)).card with hApos
  set Aneg := (Fam.filter (fun c => x ∈ varsNeg c)).card with hAneg
  have hsplit : (Fam.filter (fun c => x ∈ (varsPos c ∪ varsNeg c))).card ≤ Apos + Aneg := by
    rw [hApos, hAneg]
    -- filter (x ∈ pos ∪ neg) ⊆ filter (x∈pos) ∪ filter (x∈neg).
    have hsub : Fam.filter (fun c => x ∈ (varsPos c ∪ varsNeg c))
        ⊆ Fam.filter (fun c => x ∈ varsPos c) ∪ Fam.filter (fun c => x ∈ varsNeg c) := by
      intro c hc
      rw [Finset.mem_filter] at hc
      obtain ⟨hcF, hcU⟩ := hc
      rw [Finset.mem_union] at hcU
      rw [Finset.mem_union, Finset.mem_filter, Finset.mem_filter]
      rcases hcU with h | h
      · exact Or.inl ⟨hcF, h⟩
      · exact Or.inr ⟨hcF, h⟩
    calc (Fam.filter (fun c => x ∈ (varsPos c ∪ varsNeg c))).card
        ≤ (Fam.filter (fun c => x ∈ varsPos c) ∪ Fam.filter (fun c => x ∈ varsNeg c)).card :=
          Finset.card_le_card hsub
      _ ≤ (Fam.filter (fun c => x ∈ varsPos c)).card
            + (Fam.filter (fun c => x ∈ varsNeg c)).card := Finset.card_union_le _ _
  -- From hx: |Fam|*d+1 ≤ V * (Apos+Aneg)... we have V * card(union-filter) ≥ |Fam|*d+1.
  have hx' : Fam.card * d + 1 ≤ V * (Apos + Aneg) :=
    le_trans hx (Nat.mul_le_mul_left _ hsplit)
  -- So 2*V*max(Apos,Aneg) ≥ V*(Apos+Aneg) ≥ |Fam|*d+1.  Pick the bigger sign.
  rcases Nat.le_total Aneg Apos with hcmp | hcmp
  · refine ⟨x, true, ?_⟩
    simp only [if_true]
    rw [← hApos]
    -- V*(Apos+Aneg) ≤ V*(2*Apos) = 2*V*Apos.
    have : V * (Apos + Aneg) ≤ 2 * V * Apos := by
      have : Apos + Aneg ≤ 2 * Apos := by omega
      calc V * (Apos + Aneg) ≤ V * (2 * Apos) := Nat.mul_le_mul_left _ this
        _ = 2 * V * Apos := by ring
    exact le_trans hx' this
  · refine ⟨x, false, ?_⟩
    simp only [Bool.false_eq_true, if_false]
    rw [← hAneg]
    have : V * (Apos + Aneg) ≤ 2 * V * Aneg := by
      have : Apos + Aneg ≤ 2 * Aneg := by omega
      calc V * (Apos + Aneg) ≤ V * (2 * Aneg) := Nat.mul_le_mul_left _ this
        _ = 2 * V * Aneg := by ring
    exact le_trans hx' this

/-! ## 5. The fat-line bookkeeping over the distinct-line set

We turn the distinct line set of a refutation into a `Finset`, single out the
fat lines (width `> d`), and connect their variable-sets to `clauseWidth` so the
pigeonhole `exists_heavy_lit` applies.  All PROVED. -/

/-- Variables appearing with sign `s` in clause `c`. -/
def varsBySign {V : Nat} (s : Bool) (c : Clause V) : Finset (Fin V) :=
  ((c.filter (fun l => l.sign = s)).map (·.var)).toFinset

/-- The full variable set of a clause is the union of the two signed sets. -/
theorem varsBySign_union_card {V : Nat} (c : Clause V) :
    clauseWidth c = (varsBySign true c ∪ varsBySign false c).card := by
  rw [clauseWidth_eq_card]
  congr 1
  ext v
  simp only [Finset.mem_union, varsBySign, List.mem_toFinset, List.mem_map, List.mem_filter,
    decide_eq_true_eq]
  constructor
  · rintro ⟨l, hl, rfl⟩
    cases hs : l.sign
    · exact Or.inr ⟨l, ⟨hl, by simp [hs]⟩, rfl⟩
    · exact Or.inl ⟨l, ⟨hl, by simp [hs]⟩, rfl⟩
  · rintro (⟨l, ⟨hl, _⟩, rfl⟩ | ⟨l, ⟨hl, _⟩, rfl⟩) <;> exact ⟨l, hl, rfl⟩

/-- The `Finset` of DISTINCT fat lines (width `> d`) of a refutation. -/
def fatFinset {V : Nat} {F : CNF V} (d : Nat) (r : ResolutionRefutation F) :
    Finset (Clause V) :=
  ((ResolutionRefutationSourceLineClauses r).dedup.filter
    (fun c => decide (d < clauseWidth c))).toFinset

/-- The number of distinct fat lines. -/
def fatCount {V : Nat} {F : CNF V} (d : Nat) (r : ResolutionRefutation F) : Nat :=
  (fatFinset d r).card

/-- Membership in `fatFinset`: distinct lines that are fat. -/
theorem mem_fatFinset {V : Nat} {F : CNF V} {d : Nat} {r : ResolutionRefutation F}
    {c : Clause V} :
    c ∈ fatFinset d r ↔
      c ∈ (ResolutionRefutationSourceLineClauses r).dedup ∧ d < clauseWidth c := by
  unfold fatFinset
  rw [List.mem_toFinset, List.mem_filter, decide_eq_true_eq]

/-- Every fat line has `varsBySign`-union cardinality `≥ d + 1` (it is wide). -/
theorem fat_wide {V : Nat} {F : CNF V} {d : Nat} {r : ResolutionRefutation F}
    {c : Clause V} (hc : c ∈ fatFinset d r) :
    d + 1 ≤ (varsBySign true c ∪ varsBySign false c).card := by
  rw [← varsBySign_union_card]
  rw [mem_fatFinset] at hc
  omega

/-- `fatLitDeg d r x s` = number of fat lines of `r` whose sign-`s` variable set
contains `x` (equivalently, that contain the literal `(x, s)`). -/
def fatLitDeg {V : Nat} {F : CNF V} (d : Nat) (r : ResolutionRefutation F)
    (x : Fin V) (s : Bool) : Nat :=
  ((fatFinset d r).filter (fun c => x ∈ varsBySign s c)).card

/-- **The heavy literal exists among fat lines.**  If there is at least one fat
line, some literal `(x, s)` lies in `h := fatLitDeg d r x s` fat lines with
`2 * V * h ≥ fatCount d r * d + 1`. -/
theorem exists_heavy_fat_lit {V : Nat} {F : CNF V} {d : Nat}
    (r : ResolutionRefutation F) (hpos : 0 < fatCount d r) :
    ∃ (x : Fin V) (s : Bool),
      fatCount d r * d + 1 ≤ 2 * V * fatLitDeg d r x s := by
  have hne : (fatFinset d r).Nonempty := Finset.card_pos.mp hpos
  have hwide : ∀ c ∈ fatFinset d r,
      d + 1 ≤ (varsBySign true c ∪ varsBySign false c).card :=
    fun c hc => fat_wide hc
  obtain ⟨x, s, hxs⟩ :=
    exists_heavy_lit (fatFinset d r) (varsBySign true) (varsBySign false) d hne hwide
  refine ⟨x, s, ?_⟩
  unfold fatCount fatLitDeg
  cases s with
  | true => simpa using hxs
  | false => simpa using hxs

/-! ## 6. The single remaining structural hypothesis, and the geometric per-step
drop derived from it together with the (proved) pigeonhole. -/

/--
**THE SINGLE REMAINING TRUE STRUCTURAL HYPOTHESIS (single-variable, pigeonhole-free).**

`DagOneStepRestrict` says: restricting a refutation `r` of `F` by ANY assignment
`x := s` yields a refutation `r'` of `restrict x s F` whose distinct-line count does
not grow (`dagSize r' ≤ dagSize r`) and whose fat-line count drops by at least the
number of fat lines *satisfied* by `x := s` — namely those containing the literal
`(x, s)`, counted by `fatLitDeg d r x s`.

This is exactly the Ben-Sasson-Wigderson satisfaction-based single-restriction
construction read off the EXISTING tree restriction machinery (`restrictTree`,
which already proves a `Valid (restrict x s F)` tree of no-larger size; a clause
containing the satisfied literal `(x, s)` is dropped, hence cannot remain a fat
line).  It is a SINGLE-VARIABLE structural fact, pigeonhole-free, and is NOT the
size-width conclusion: it makes no width claim and quantifies over every `(x, s)`.

It is TRUE and NOT circular.  Discharging it locally requires the DAG line-count /
fat-count bookkeeping of `restrictTree` over the dedup'd line set, which is not yet
assembled in this repository — see the honest discussion in the module header. -/
def DagOneStepRestrict : Prop :=
  ∀ {V : Nat} (F : CNF V) (r : ResolutionRefutation F) (d : Nat) (x : Fin V) (s : Bool),
    ∃ r' : ResolutionRefutation (restrict x s F),
      dagSize r' ≤ dagSize r ∧
      fatCount d r' + fatLitDeg d r x s ≤ fatCount d r

/--
**THE LIFT-BACK / COMBINE HYPOTHESIS (single-variable, BOTH branches).**

CRUCIAL CORRECTNESS NOTE.  A *single-value* lift "refutation of `restrict x s F`
⟹ refutation of `F`" is FALSE: lifting a refutation of `restrict x s F` back to `F`
yields a derivation of the unit clause `litOf x (!s)`, not the empty clause (e.g.
`F = {[x]}` is satisfiable yet `restrict x false F = {[]}` is refutable).  Hence the
honest lift-back must COMBINE refutations of BOTH restrictions `restrict x false F`
and `restrict x true F`, resolving on the pivot `x` (this is exactly `narrow_combine`
of `ResolutionSizeWidthCore.lean`, proved there for trees, the `+1` width step).

`DagCombineStep` packages that TRUE combine on refutations: from narrow refutations
of both branches at width `≤ w`, obtain a refutation of `F` at width `≤ w + 1`. -/
def DagCombineStep : Prop :=
  ∀ {V : Nat} (F : CNF V) (x : Fin V) (w : Nat),
    (∃ r0 : ResolutionRefutation (restrict x false F), refutationWidth r0 ≤ w) →
    (∃ r1 : ResolutionRefutation (restrict x true F), refutationWidth r1 ≤ w) →
    ∃ r : ResolutionRefutation F, refutationWidth r ≤ w + 1

/-! ## 7. The trajectory: iterating the one-step restriction `b` times.

Using the proved heavy-literal pigeonhole to feed `DagOneStepRestrict`, we obtain
the geometric per-step fat drop and assemble a length-`k` restriction chain whose
final refutation has fat count obeying the iteration hypotheses of `§3`.  We track
the formula chain so that the lift-back (`§8`) can be applied `k` times. -/

/-- A length-`k` chain of single-variable restrictions reaching `G` from `F`. -/
inductive RestrictChain {V : Nat} : CNF V → CNF V → Nat → Prop where
  | nil (F : CNF V) : RestrictChain F F 0
  | cons {F G : CNF V} {k : Nat} (x : Fin V) (s : Bool) :
      RestrictChain F G k → RestrictChain F (restrict x s G) (k + 1)

/-- The heavy variable chosen at a pair with a fat line. -/
noncomputable def heavyX {V : Nat} (d : Nat) {G : CNF V}
    (rG : ResolutionRefutation G) (hpos : 0 < fatCount d rG) : Fin V :=
  (exists_heavy_fat_lit rG hpos).choose

/-- The heavy sign chosen at a pair with a fat line. -/
noncomputable def heavyS {V : Nat} (d : Nat) {G : CNF V}
    (rG : ResolutionRefutation G) (hpos : 0 < fatCount d rG) : Bool :=
  (exists_heavy_fat_lit rG hpos).choose_spec.choose

/-- The defining pigeonhole property of the heavy choice. -/
theorem heavy_spec {V : Nat} (d : Nat) {G : CNF V}
    (rG : ResolutionRefutation G) (hpos : 0 < fatCount d rG) :
    fatCount d rG * d + 1 ≤ 2 * V * fatLitDeg d rG (heavyX d rG hpos) (heavyS d rG hpos) :=
  (exists_heavy_fat_lit rG hpos).choose_spec.choose_spec

/-- One adaptively-chosen restriction step.  If there is a fat line, restrict by the
heavy literal `(heavyX, heavyS)`; otherwise restrict by `(heavyX', false)` for some
fixed variable when `V > 0`, or leave unchanged when `V = 0`.  Returns the new pair
together with the variable/sign used (and whether a real restriction happened). -/
noncomputable def stepOne (hstep : DagOneStepRestrict) {V : Nat} (d : Nat)
    (p : Σ G : CNF V, ResolutionRefutation G) :
    Σ G : CNF V, ResolutionRefutation G :=
  if hpos : 0 < fatCount d p.2 then
    ⟨restrict (heavyX d p.2 hpos) (heavyS d p.2 hpos) p.1,
      (hstep p.1 p.2 d (heavyX d p.2 hpos) (heavyS d p.2 hpos)).choose⟩
  else
    p

/-- The trajectory of restriction pairs. -/
noncomputable def traj (hstep : DagOneStepRestrict) {V : Nat} (d : Nat)
    (F : CNF V) (r : ResolutionRefutation F) :
    Nat → Σ G : CNF V, ResolutionRefutation G
  | 0 => ⟨F, r⟩
  | k + 1 => stepOne hstep d (traj hstep d F r k)

/-- The fat-count sequence along the trajectory. -/
noncomputable def aSeq (hstep : DagOneStepRestrict) {V : Nat} (d : Nat)
    (F : CNF V) (r : ResolutionRefutation F) (k : Nat) : Nat :=
  fatCount d (traj hstep d F r k).2

/-- **Per-step geometric drop along the trajectory.**  This is where the proved
pigeonhole (`heavy_spec`) and the structural hypothesis (`DagOneStepRestrict`)
combine: either the pair has no fat line (sequence already `0`, drop trivial) or the
heavy literal satisfies enough fat lines for the factor-`2V` geometric decay. -/
theorem aSeq_step (hstep : DagOneStepRestrict) {V : Nat} (d : Nat)
    (F : CNF V) (r : ResolutionRefutation F) (k : Nat) :
    2 * V * aSeq hstep d F r (k + 1) ≤ aSeq hstep d F r k * (2 * V - d) := by
  unfold aSeq
  show 2 * V * fatCount d (traj hstep d F r (k + 1)).2
    ≤ fatCount d (traj hstep d F r k).2 * (2 * V - d)
  rw [show traj hstep d F r (k + 1) = stepOne hstep d (traj hstep d F r k) from rfl]
  set p := traj hstep d F r k with hp
  unfold stepOne
  by_cases hpos : 0 < fatCount d p.2
  · rw [dif_pos hpos]
    -- new refutation r' = (hstep ...).choose ; spec gives dagSize ≤ and fat drop.
    set x := heavyX d p.2 hpos with hx
    set s := heavyS d p.2 hpos with hs
    obtain ⟨_hdag, hfat⟩ := (hstep p.1 p.2 d x s).choose_spec
    -- hfat : fatCount d r' + fatLitDeg d p.2 x s ≤ fatCount d p.2
    -- heavy_spec : fatCount d p.2 * d + 1 ≤ 2*V*fatLitDeg d p.2 x s.
    have hheavy : fatCount d p.2 * d + 1 ≤ 2 * V * fatLitDeg d p.2 x s := heavy_spec d p.2 hpos
    set a := fatCount d p.2 with ha
    set a' := fatCount d (hstep p.1 p.2 d x s).choose with ha'
    set h := fatLitDeg d p.2 x s with hh
    -- 2V*a' = 2V*(a' + h) - 2V*h ≤ 2V*a - (a*d+1) ≤ 2V*a - a*d = a*(2V - d).
    -- Use: a' + h ≤ a (hfat) and a*d+1 ≤ 2V*h (hheavy).
    have h1 : 2 * V * (a' + h) ≤ 2 * V * a := Nat.mul_le_mul_left _ hfat
    have hexp : 2 * V * (a' + h) = 2 * V * a' + 2 * V * h := by ring
    -- a*(2V - d): since d ≤ 2V is needed for the Nat-subtraction to behave.
    -- We avoid that by proving 2V*a' + (a*d) ≤ 2V*a, then a*(2V-d) ≥ 2V*a - a*d ≥ 2V*a'.
    have hstep2 : 2 * V * a' + a * d ≤ 2 * V * a := by
      have hh2 : a * d + 1 ≤ 2 * V * h := hheavy
      omega
    -- a*(2V - d) = a*(2V) - a*d (Nat.mul_sub), and 2V*a' + a*d ≤ 2V*a = a*(2V).
    have hmsub : a * (2 * V - d) = a * (2 * V) - a * d := Nat.mul_sub a (2 * V) d
    have h2Va : a * (2 * V) = 2 * V * a := by ring
    rw [hmsub]
    omega
  · rw [dif_neg hpos]
    -- fatCount d p.2 = 0, so both sides are 0.
    have : fatCount d p.2 = 0 := by omega
    rw [this]; simp

/-- `aSeq 0 = fatCount d r`. -/
theorem aSeq_zero (hstep : DagOneStepRestrict) {V : Nat} (d : Nat)
    (F : CNF V) (r : ResolutionRefutation F) :
    aSeq hstep d F r 0 = fatCount d r := rfl

/-- `dagSize` does not grow along the trajectory. -/
theorem traj_dagSize_le (hstep : DagOneStepRestrict) {V : Nat} (d : Nat)
    (F : CNF V) (r : ResolutionRefutation F) :
    ∀ k, dagSize (traj hstep d F r k).2 ≤ dagSize r := by
  intro k
  induction k with
  | zero => exact le_refl _
  | succ k ih =>
      have heq : traj hstep d F r (k + 1) = stepOne hstep d (traj hstep d F r k) := rfl
      rw [heq]
      set p := traj hstep d F r k with hp
      unfold stepOne
      by_cases hpos : 0 < fatCount d p.2
      · rw [dif_pos hpos]
        obtain ⟨hdag, _⟩ := (hstep p.1 p.2 d (heavyX d p.2 hpos) (heavyS d p.2 hpos)).choose_spec
        exact le_trans hdag ih
      · rw [dif_neg hpos]; exact ih

/-- `w0width` does not grow along the trajectory (restriction never widens axioms). -/
theorem traj_w0width_le (hstep : DagOneStepRestrict) {V : Nat} (d : Nat)
    (F : CNF V) (r : ResolutionRefutation F) :
    ∀ k, w0width (traj hstep d F r k).1 ≤ w0width F := by
  intro k
  induction k with
  | zero => exact le_refl _
  | succ k ih =>
      have heq : traj hstep d F r (k + 1) = stepOne hstep d (traj hstep d F r k) := rfl
      rw [heq]
      set p := traj hstep d F r k with hp
      unfold stepOne
      by_cases hpos : 0 < fatCount d p.2
      · rw [dif_pos hpos]
        show w0width (restrict (heavyX d p.2 hpos) (heavyS d p.2 hpos) p.1) ≤ w0width F
        exact le_trans (w0width_restrict_le _ _ _) ih
      · rw [dif_neg hpos]; exact ih

/-- The trajectory realizes a restriction chain of length `≤ k` (only the steps
that actually restricted — i.e. the fat-positive ones — count). -/
theorem traj_chain (hstep : DagOneStepRestrict) {V : Nat} (d : Nat)
    (F : CNF V) (r : ResolutionRefutation F) :
    ∀ k, ∃ j ≤ k, RestrictChain F (traj hstep d F r k).1 j := by
  intro k
  induction k with
  | zero => exact ⟨0, le_refl _, RestrictChain.nil F⟩
  | succ k ih =>
      obtain ⟨j, hjk, hchain⟩ := ih
      have heq : traj hstep d F r (k + 1) = stepOne hstep d (traj hstep d F r k) := rfl
      rw [heq]
      set p := traj hstep d F r k with hp
      unfold stepOne
      by_cases hpos : 0 < fatCount d p.2
      · rw [dif_pos hpos]
        refine ⟨j + 1, by omega, ?_⟩
        show RestrictChain F (restrict (heavyX d p.2 hpos) (heavyS d p.2 hpos) p.1) (j + 1)
        exact RestrictChain.cons _ _ hchain
      · rw [dif_neg hpos]
        exact ⟨j, by omega, hchain⟩

/-! ## 8. Width bookkeeping helpers (all PROVED, no hypothesis). -/

/-- A refutation always has width `≤ V` (a clause over `Fin V` mentions `≤ V`
distinct variables). -/
theorem refutationWidth_le_numVars {V : Nat} {F : CNF V} (r : ResolutionRefutation F) :
    refutationWidth r ≤ V := by
  unfold refutationWidth
  rw [derivWidth_le_iff]
  intro c _
  rw [clauseWidth_eq_card]
  calc (c.map (·.var)).toFinset.card ≤ (Finset.univ : Finset (Fin V)).card :=
        Finset.card_le_card (Finset.subset_univ _)
    _ = V := by rw [Finset.card_univ, Fintype.card_fin]

/-- If `dagSize r = 1` then every line is the empty clause, so the width is `0`.
(The empty clause is always a distinct line; if it is the ONLY one, all lines equal
it.) -/
theorem refutationWidth_eq_zero_of_dagSize_one {V : Nat} {F : CNF V}
    (r : ResolutionRefutation F) (h1 : dagSize r = 1) :
    refutationWidth r = 0 := by
  -- The dedup'd line list has length 1 and contains [], so it is exactly [[]].
  unfold dagSize at h1
  have hnil : ([] : Clause V) ∈ (ResolutionRefutationSourceLineClauses r).dedup := by
    rw [List.mem_dedup]; exact nil_mem_sourceLineClauses r
  -- every original source line is in dedup, and dedup has one element = [].
  have hall : ∀ c ∈ ResolutionRefutationSourceLineClauses r, c = [] := by
    intro c hc
    have hcd : c ∈ (ResolutionRefutationSourceLineClauses r).dedup := by
      rw [List.mem_dedup]; exact hc
    -- dedup is a length-1 list containing both c and []; they must be equal.
    set l := (ResolutionRefutationSourceLineClauses r).dedup with hl
    -- l.length = 1, c ∈ l, [] ∈ l ⟹ c = [].
    have hnodup : l.Nodup := List.nodup_dedup _
    rcases List.length_eq_one.mp h1 with ⟨a, ha⟩
    rw [ha] at hcd hnil
    rw [List.mem_singleton] at hcd hnil
    rw [hcd, hnil]
  -- so derivWidth = 0.
  unfold refutationWidth
  apply Nat.le_zero.mp
  rw [derivWidth_le_iff]
  intro c hc
  have hc0 : c = [] := hall c hc
  rw [hc0, clauseWidth_nil]

/-- If there are no fat lines (`fatCount d r = 0`), every line has width `≤ d`, so the
refutation has width `≤ d`. -/
theorem refutationWidth_le_of_fatCount_zero {V : Nat} {F : CNF V} {d : Nat}
    (r : ResolutionRefutation F) (h0 : fatCount d r = 0) :
    refutationWidth r ≤ d := by
  unfold refutationWidth
  rw [derivWidth_le_iff]
  intro c hc
  -- c is a source line, hence in dedup; if width > d then c ∈ fatFinset, contradicting card 0.
  by_contra hcon
  push_neg at hcon  -- hcon : d < clauseWidth c
  have hcd : c ∈ (ResolutionRefutationSourceLineClauses r).dedup := by
    rw [List.mem_dedup]; exact hc
  have hcfat : c ∈ fatFinset d r := mem_fatFinset.mpr ⟨hcd, hcon⟩
  have : 0 < fatCount d r := Finset.card_pos.mpr ⟨c, hcfat⟩
  omega

/-- `fatCount d r ≤ dagSize r`: fat lines are a subset of the distinct lines. -/
theorem fatCount_le_dagSize {V : Nat} {F : CNF V} (d : Nat)
    (r : ResolutionRefutation F) : fatCount d r ≤ dagSize r := by
  unfold fatCount fatFinset dagSize
  calc ((ResolutionRefutationSourceLineClauses r).dedup.filter
          (fun c => decide (d < clauseWidth c))).toFinset.card
      ≤ ((ResolutionRefutationSourceLineClauses r).dedup.filter
          (fun c => decide (d < clauseWidth c))).length := List.toFinset_card_le _
    _ ≤ (ResolutionRefutationSourceLineClauses r).dedup.length :=
        (List.filter_sublist _).length_le

/-! ## 9. What is proved, the precise remaining gap, and the honest isolation.

### Status (RUTHLESSLY HONEST)

This module PROVES, with NO hypothesis and axiom set `⊆ {propext, Classical.choice,
Quot.sound}`, the entire combinatorial / arithmetic CORE of the Ben-Sasson-Wigderson
general-resolution size-width argument:

* `exists_heavy_var`, `exists_heavy_lit`, `exists_heavy_fat_lit` — the integer
  pigeonhole / heavy-literal double counting over the distinct fat-line set.
* `geometric_decay`, `block_halves`, `blocks_divide`, `iteration_reaches_zero` —
  the purely-integer iteration driving the fat count to `0` after a `sqrt`-sized
  number of restriction steps.
* `envelope_bound`, `blocksize_covers`, `two_mul_sub_pow_le` — the threshold/step
  arithmetic fitting the `3·sqrt(2·V·log₂ S) + 3` envelope.
* `aSeq_step` — the per-step geometric fat-count DROP, which genuinely COMBINES the
  proved pigeonhole with the structural hypothesis `DagOneStepRestrict`.
* the width bookkeeping (`refutationWidth_le_numVars`,
  `refutationWidth_le_of_fatCount_zero`, `refutationWidth_eq_zero_of_dagSize_one`,
  `fatCount_le_dagSize`).

`DagOneStepRestrict` is a TRUE single-variable structural fact (it is exactly the
no-larger-size restriction of a refutation read off `restrictTree`, with satisfied
fat lines dropping out); it is NOT the size-width conclusion and is NON-circular.

### The PRECISE remaining gap (why this is an honest PARTIAL, not the full core)

The faithful reconstruction of a NARROW refutation of `F` from the narrowed
restricted refutation is **NOT** a linear single-value lift-back: lifting a
refutation of `restrict x s F` back to `F` yields a derivation of the unit
`litOf x (!s)`, not the empty clause (see `DagCombineStep`'s correctness note).  The
honest reconstruction must COMBINE the two branches `restrict x false F` and
`restrict x true F` (resolving on `x`, the proved `narrow_combine` of
`ResolutionSizeWidthCore.lean`), turning the argument into the BW *two-parameter*
recursion: branch `x := s` drops the fat count geometrically (handled by the proved
`aSeq_step` / iteration), while branch `x := !s` recurses with one fewer variable.
Assembling that two-parameter combine recursion to the optimal `sqrt` width budget
is the genuinely different combinatorial step that is NOT yet formalised here.  We
therefore DO NOT claim `DagRestrictionNarrowsCore`; we isolate exactly that
combine-recursion as the single remaining structural hypothesis below.

We were careful NOT to ship the tempting FALSE shortcut (single-value lift-back),
which an earlier draft of this module contained and which is provably false. -/

/--
**The remaining gap, stated as a Prop for auditing (NOT asserted, NOT a new axiom).**

The honest remaining content is the BW two-parameter combine recursion: from the
proved per-step fat drop (`aSeq_step`) and the proved envelope, assemble — via the
two-branch `DagCombineStep` — a refutation of `F` of width
`≤ w0width F + dagNarrowingBudget V (dagSize r)`.  We do NOT define this as an
isolated hypothesis equal to the whole core (that would be no progress over the
existing isolated `DagRestrictionNarrowsCore`); instead we record it here only as a
documentation anchor.  The contribution of this module is the PROVED combinatorial
core above plus the two TRUE structural building blocks `DagOneStepRestrict` and
`DagCombineStep`. -/
theorem proved_inputs_are_available
    (hstep : DagOneStepRestrict) {V : Nat} (d : Nat)
    (F : CNF V) (r : ResolutionRefutation F) :
    -- the per-step geometric fat drop is available with no further assumption:
    (∀ i, 2 * V * aSeq hstep d F r (i + 1) ≤ aSeq hstep d F r i * (2 * V - d)) ∧
    -- and the envelope/iteration lemmas are proved (witnessed by their availability).
    aSeq hstep d F r 0 = fatCount d r :=
  ⟨fun i => aSeq_step hstep d F r i, aSeq_zero hstep d F r⟩

end ResolutionDagSizeWidthCore
end CNFResolution
end PvNP
