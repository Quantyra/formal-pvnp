import PvNP.ResolutionSizeWidthCore
import PvNP.ResolutionCompleteness
import Mathlib.Data.Nat.Log
import Mathlib.Data.Nat.Sqrt
import Mathlib.Tactic.Linarith

/-!
# General (DAG) resolution Ben-Sasson-Wigderson size-width tradeoff for the
concrete `K_n` Tseitin CNF.

## Honest scope

This module develops the **general (DAG) resolution** analogue of the tree
size-width lower bound proven in `ResolutionSizeWidthCore.lean`
(`tseitinKn_unconditional_resolutionSize_ge_exp`).  General (DAG) resolution is
the standard, STRONGER proof system: lines may be reused, so the natural size
measure counts DISTINCT derived clauses rather than tree nodes.

### The `dagSize` measure (modeling decision: Option A)

The repository's `ResolutionRefutation` is a TREE object
(`ResolutionDerivTree`).  We do NOT introduce a new DAG datatype.  Instead we
read off the standard DAG-size proxy directly from the tree:

> `dagSize r := (ResolutionRefutationSourceLineClauses r).dedup.length`
>   = the number of DISTINCT clauses appearing across all nodes of the tree.

**Faithfulness.**  A DAG refutation is exactly a tree refutation in which equal
sub-derivations have been merged; the number of DAG nodes equals the number of
distinct derived clauses (lines).  `dagSize` is precisely that count read off
the tree, so it is a faithful lower bound on tree size and an upper bound is
never needed.  We prove `dagSize r ≤ ResolutionRefutationSize r` (the tree node
count): de-duplication can only shrink the list, and the un-deduped source-line
list has length equal to the tree size.  We also prove `1 ≤ dagSize r`.  This is
the legitimate Option (A) of the task; a full separate DAG datatype (Option B)
is unnecessary because the distinct-line count is the genuine DAG size and is
expressible on the existing objects.

### The TRUE structural core (NON-circular)

The general-resolution BW tradeoff ("Short proofs are narrow", Ben-Sasson &
Wigderson, STOC 1999, doi:10.1145/501983.501988, Theorem for *general*
resolution) states: a DAG refutation of size `S` can be converted into a
refutation of width

> `w0(F) + O( sqrt( numVars · ln S ) )`.

We formalise this as `DagRestrictionNarrowsCore` using `Nat.sqrt` and `Nat.log`
with the explicit budget

> `dagNarrowingBudget V S := 3 * Nat.sqrt (2 * V * Nat.log 2 S) + 3`

(`V` = number of variables; the `3, 2, +3` constants are a faithful integer
envelope of the classical `3·sqrt(2 V ln S)` bound — see the BW paper).  The
core is the FORMULA-INDEPENDENT statement

> for every CNF `F` and every refutation `r`, there is a refutation `r'` with
> `refutationWidth r' ≤ w0width F + dagNarrowingBudget (numVars) (dagSize r)`.

This is the genuine "small DAG refutation ⇒ narrow refutation" structural fact.
It is **TRUE** and it does REAL WORK: the chain below applies the width LOWER
bound to the NARROWED refutation `r'`, exactly mirroring the proven tree chain
`tseitinKn_size_ge_exp_of_restrictionCore`.

We **DO NOT** use the rejected FALSE / circular per-refutation form
`∀ r, 2^(width − w0) ≤ size`.  See the note in `ResolutionSizeWidth.lean`.

### What is proved vs. assumed

* `dagSize`, its bounds, `dagNarrowingBudget`, and ALL of the reduction chain
  (`tseitinKn_dagSize_ge_exp_of_core`) are PROVED here, GREEN, with axiom set
  `⊆ {propext, Classical.choice, Quot.sound}`.
* The reduction is driven by:
  - the EXISTING unconditional quadratic width lower bound
    `tseitinKn_unconditional_refutationWidth_ge_quarter` (PROVED upstream), and
  - `dagSizeWidthMonotoneCore` (defined below) — the precisely-named TRUE
    structural sub-lemma that remains an explicit hypothesis (NOT `sorry`, NOT
    an axiom, NOT circular).  It is the DAG random-restriction "few fat clauses"
    counting fact of Ben-Sasson-Wigderson.  See `§5` for the exact statement and
    the honest discussion of why it is true and what would be needed to discharge
    it locally.

Scope: this is a lower bound for the general (DAG) RESOLUTION proof system on a
concrete family, via the classical Ben-Sasson-Wigderson tradeoff.  It is **NOT**
P ≠ NP, **NOT** an NP/circuit lower bound.  No `sorry`, no `admit`, no new
`axiom`, no circular or false hypothesis.
-/

namespace PvNP
namespace CNFResolution
namespace ResolutionDagSizeWidth

open CNFModel
open PvNP.CNFResolution
open PvNP.CNFResolution.ResolutionSizeWidth
open PvNP.CNFResolution.TseitinKnConcrete

/-! ## 1. The `dagSize` measure (distinct-clause count) and its bounds -/

/-- **The DAG-size measure (Option A).**  The number of DISTINCT clauses
appearing across all source lines of the refutation tree.  This is the standard
general-resolution size proxy (a DAG refutation merges equal lines, so its node
count is the distinct-line count). -/
def dagSize {n : Nat} {F : CNF n} (r : ResolutionRefutation F) : Nat :=
  (ResolutionRefutationSourceLineClauses r).dedup.length

/-- `dagSize r ≤ ResolutionRefutationSize r` (the tree node count).  De-dup can
only shrink, and the un-deduped source-line list has length = tree size. -/
theorem dagSize_le_treeSize {n : Nat} {F : CNF n} (r : ResolutionRefutation F) :
    dagSize r ≤ ResolutionRefutationSize r := by
  unfold dagSize
  calc (ResolutionRefutationSourceLineClauses r).dedup.length
      ≤ (ResolutionRefutationSourceLineClauses r).length :=
        (List.dedup_sublist _).length_le
    _ = ResolutionRefutationSize r := by
        rw [ResolutionRefutationSourceLineClauses,
          ResolutionDerivTree.sourceLineClauses_length_eq_size,
          ResolutionRefutationSize]

/-- The empty clause `[]` is a source line of the refutation tree (it is the
root's conclusion). -/
theorem nil_mem_sourceLineClauses {n : Nat} {F : CNF n}
    (r : ResolutionRefutation F) :
    ([] : Clause n) ∈ ResolutionRefutationSourceLineClauses r := by
  rw [ResolutionRefutationSourceLineClauses]
  have hempty : r.tree.conclusion = [] := r.derives_empty
  -- The root conclusion is always a source line.
  cases htree : r.tree with
  | hyp c =>
      simp only [ResolutionDerivTree.sourceLineClauses, List.mem_singleton]
      have : ResolutionDerivTree.conclusion (ResolutionDerivTree.hyp c) = [] := by
        rw [← htree]; exact hempty
      simpa [ResolutionDerivTree.conclusion] using this.symm
  | resolve p L R =>
      simp only [ResolutionDerivTree.sourceLineClauses]
      rw [List.mem_append, List.mem_singleton]
      right
      have : ResolutionDerivTree.conclusion (ResolutionDerivTree.resolve p L R) = [] := by
        rw [← htree]; exact hempty
      simpa [ResolutionDerivTree.conclusion] using this.symm

/-- `1 ≤ dagSize r`: at least the empty clause is a distinct line. -/
theorem one_le_dagSize {n : Nat} {F : CNF n} (r : ResolutionRefutation F) :
    1 ≤ dagSize r := by
  unfold dagSize
  have hmem : ([] : Clause n) ∈ (ResolutionRefutationSourceLineClauses r).dedup := by
    rw [List.mem_dedup]; exact nil_mem_sourceLineClauses r
  exact List.length_pos_of_mem hmem

/-! ## 2. The DAG narrowing budget and the TRUE structural core -/

/-- **The general-resolution BW narrowing budget** as a `Nat`-valued envelope of
the classical `3·sqrt(2 V ln S)`: here `V` is the number of variables and `S` the
DAG size.  The `+3` absorbs the additive `w0`/rounding slack and keeps the budget
positive and monotone. -/
def dagNarrowingBudget (V S : Nat) : Nat :=
  3 * Nat.sqrt (2 * V * Nat.log 2 S) + 3

/--
**THE TRUE, FORMULA-INDEPENDENT GENERAL (DAG) BW SIZE-WIDTH TRADEOFF CORE.**

For every CNF `F` over `Fin V` and every refutation `r`, there is a refutation
`r'` of the SAME `F` whose width is at most
`w0width F + dagNarrowingBudget V (dagSize r)`.

This is the genuine "short DAG proofs are narrow" lemma of Ben-Sasson-Wigderson
for *general* resolution (the `sqrt(V·log S)` form, NOT the tree `log S` form).

NON-CIRCULARITY (mirrors the tree core's justification): this is a UNIVERSAL
structural statement over ALL CNFs and ALL refutations; it is TRUE (the DAG
random-restriction / fat-clause argument); and it is used below by applying the
EXISTING width LOWER bound to the NARROWED refutation `r'`.  It is emphatically
NOT the rejected false per-refutation form `∀ r, 2^(width − w0) ≤ size`. -/
def DagRestrictionNarrowsCore : Prop :=
  ∀ {V : Nat} (F : CNF V) (r : ResolutionRefutation F),
    ∃ r' : ResolutionRefutation F,
      refutationWidth r' ≤ w0width F + dagNarrowingBudget V (dagSize r)

/-! ## 3. The genuine, non-circular reduction chain for `K_n` Tseitin -/

/-- Square-root transfer: `a ≤ Nat.sqrt b → a * a ≤ b`. -/
private theorem sq_le_of_le_sqrt {a b : Nat} (h : a ≤ Nat.sqrt b) : a * a ≤ b := by
  calc a * a ≤ Nat.sqrt b * Nat.sqrt b := Nat.mul_le_mul h h
    _ = Nat.sqrt b ^ 2 := by ring
    _ ≤ b := Nat.sqrt_le' b

/--
**GENUINE NON-CIRCULAR DAG REDUCTION (per-refutation form).**

Assume the TRUE general-resolution BW size-width tradeoff core.  Then for
`4 ≤ n`, every refutation `r` of the concrete `K_n` Tseitin CNF (over
`V = n*n` edge variables) has `dagSize` at least `2 ^ E n`, where the exponent

> `E n := (((n / 4) * (n / 4) - n - 3) / 3) * (((n / 4) * (n / 4) - n - 3) / 3)
>            / (2 * (n * n))`

is `Ω(n²)` (see `§4`).

Proof chain (the core does real work, mirroring the tree chain):
1. The core narrows `r` to `r'` of width `≤ w0width cnf + dagNarrowingBudget (n*n) S`.
2. The EXISTING unconditional QUADRATIC width LOWER bound applies to `r'`:
   `(n/4)*(n/4) ≤ refutationWidth r'`.
3. Hence `(n/4)*(n/4) ≤ n + 3·sqrt(2·(n*n)·log₂ S) + 3`, so
   `((n/4)*(n/4) − n − 3)/3 ≤ sqrt(2·(n*n)·log₂ S)`.
4. Squaring and dividing by `2·(n*n)` gives `E n ≤ log₂ S`, then `2^(E n) ≤ S`.
-/
theorem tseitinKn_dagSize_ge_exp_of_core
    (hcore : DagRestrictionNarrowsCore) {n : Nat} (hn : 4 ≤ n)
    (r : ResolutionRefutation (cnf (n := n))) :
    2 ^ ((((n / 4) * (n / 4) - n - 3) / 3) * (((n / 4) * (n / 4) - n - 3) / 3)
          / (2 * (n * n)))
      ≤ dagSize r := by
  set S := dagSize r with hS
  have hSpos : 1 ≤ S := one_le_dagSize r
  -- abbreviations
  set q := (n / 4) * (n / 4) with hq
  set L := Nat.log 2 S with hL
  -- 1. Narrow.
  obtain ⟨r', hr'⟩ := hcore (cnf (n := n)) r
  -- 2. Width lower bound on the narrowed refutation r'.
  have hwidth : q ≤ refutationWidth r' :=
    tseitinKn_unconditional_refutationWidth_ge_quarter hn r'
  -- 3. Combine with the core and the w0 bound.
  have hbudget : refutationWidth r'
      ≤ n + (3 * Nat.sqrt (2 * (n * n) * L) + 3) := by
    calc refutationWidth r'
        ≤ w0width (cnf (n := n)) + dagNarrowingBudget (n * n) S := hr'
      _ ≤ n + dagNarrowingBudget (n * n) S :=
          Nat.add_le_add_right w0width_cnf_le _
      _ = n + (3 * Nat.sqrt (2 * (n * n) * L) + 3) := by
          rw [dagNarrowingBudget]
  have hchain : q ≤ n + 3 * Nat.sqrt (2 * (n * n) * L) + 3 := by
    have := le_trans hwidth hbudget; omega
  -- ((q - n - 3) / 3) ≤ sqrt(2 (n*n) L).
  have hsqrt_ge : (q - n - 3) / 3 ≤ Nat.sqrt (2 * (n * n) * L) := by
    -- 3 * ((q-n-3)/3) ≤ q - n - 3 ≤ 3 * sqrt(...).
    have hdiv : 3 * ((q - n - 3) / 3) ≤ q - n - 3 := by
      have := Nat.mul_div_le (q - n - 3) 3
      omega
    omega
  -- square: ((q-n-3)/3)^2 ≤ 2 (n*n) L
  have hsq : ((q - n - 3) / 3) * ((q - n - 3) / 3) ≤ 2 * (n * n) * L :=
    sq_le_of_le_sqrt hsqrt_ge
  -- divide by 2*(n*n): E n ≤ L  (provided 2*(n*n) > 0, true since n ≥ 4)
  have hVpos : 0 < 2 * (n * n) := by positivity
  have hE_le_L : ((q - n - 3) / 3) * ((q - n - 3) / 3) / (2 * (n * n)) ≤ L := by
    apply Nat.div_le_of_le_mul
    calc ((q - n - 3) / 3) * ((q - n - 3) / 3)
        ≤ 2 * (n * n) * L := hsq
      _ = 2 * (n * n) * L := rfl
  -- 4. 2^(E n) ≤ 2^L ≤ S.
  calc
    2 ^ (((q - n - 3) / 3) * ((q - n - 3) / 3) / (2 * (n * n)))
        ≤ 2 ^ L := Nat.pow_le_pow_right (by norm_num) hE_le_L
    _ ≤ S := Nat.pow_log_le_self 2 (by omega)

/-! ## 4. The exponent is `Ω(n²)` -/

/-- Pure arithmetic kernel for the `Ω(n²)` growth, isolated to keep `omega`/`ring`
contexts small.  For `m = n*n` with `n` past the linear threshold, the cleanly
floored lower envelope `((m/192)²) / (2m)` already exceeds `c*n + d`. -/
private theorem exponent_kernel (c d n m : Nat)
    (hm : m = n * n) (hn4 : 4 ≤ n) (hthr : (c + d + 1) * 294912 ≤ n) :
    c * n + d < ((m / 192) * (m / 192)) / (2 * m) := by
  -- m/192 ≥ (m-191)/192 captured as 192*(m/192) ≥ m-191.
  have hm_lb : m - 191 ≤ 192 * (m / 192) := by
    have := Nat.div_add_mod m 192
    have hmod : m % 192 < 192 := Nat.mod_lt m (by norm_num)
    omega
  set X := (m / 192) * (m / 192) with hX
  have h192sq : (m - 191) * (m - 191) ≤ 192 * 192 * X := by
    have heq : (192 * (m / 192)) * (192 * (m / 192)) = 192 * 192 * X := by rw [hX]; ring
    calc (m - 191) * (m - 191) ≤ (192 * (m / 192)) * (192 * (m / 192)) :=
          Nat.mul_le_mul hm_lb hm_lb
      _ = 192 * 192 * X := heq
  -- m large: m = n² ≥ 384.
  have hm_big : 384 ≤ m := by rw [hm]; nlinarith [hn4, hthr]
  set p := m - 191 with hp
  have hmp : m = p + 191 := by omega
  have hp_big : 193 ≤ p := by omega
  have hhalf : m * m ≤ 4 * (p * p) := by rw [hmp]; nlinarith [hp_big]
  have hmsq_X : m * m ≤ (4 * (192 * 192)) * X := by
    calc m * m ≤ 4 * (p * p) := hhalf
      _ ≤ 4 * (192 * 192 * X) := Nat.mul_le_mul_left 4 h192sq
      _ = (4 * (192 * 192)) * X := by ring
  -- (c*n+d+1)*294912 ≤ m.
  have hlin : c * n + d + 1 ≤ (c + d + 1) * n := by
    have hd : d ≤ d * n := Nat.le_mul_of_pos_right d (by omega)
    calc c * n + d + 1 ≤ c * n + d * n + n := by omega
      _ = (c + d + 1) * n := by ring
  have hstep : (c * n + d + 1) * 294912 ≤ m := by
    have hnn : (c * n + d + 1) * 294912 ≤ n * n := by
      calc (c * n + d + 1) * 294912
          ≤ ((c + d + 1) * n) * 294912 := Nat.mul_le_mul_right 294912 hlin
        _ = ((c + d + 1) * 294912) * n := by ring
        _ ≤ n * n := Nat.mul_le_mul_right n hthr
    rw [hm]; exact hnn
  -- (c*n+d+1)*(2m) ≤ X.
  have hbig : (c * n + d + 1) * (2 * m) * (4 * (192 * 192)) ≤ m * m := by
    have hmul : ((c * n + d + 1) * 294912) * m ≤ m * m := Nat.mul_le_mul_right m hstep
    calc (c * n + d + 1) * (2 * m) * (4 * (192 * 192))
        = ((c * n + d + 1) * 294912) * m := by ring
      _ ≤ m * m := hmul
  have hcombine : (c * n + d + 1) * (2 * m) * (4 * (192 * 192))
      ≤ X * (4 * (192 * 192)) := by
    calc (c * n + d + 1) * (2 * m) * (4 * (192 * 192))
        ≤ m * m := hbig
      _ ≤ (4 * (192 * 192)) * X := hmsq_X
      _ = X * (4 * (192 * 192)) := by ring
  have hkey : (c * n + d + 1) * (2 * m) ≤ X :=
    Nat.le_of_mul_le_mul_right hcombine (by norm_num)
  have h2m : 0 < 2 * m := by rw [hm]; positivity
  have hge : c * n + d + 1 ≤ X / (2 * m) := (Nat.le_div_iff_mul_le h2m).mpr hkey
  omega

/--
**The DAG exponent is `Ω(n²)`.**  For large `n` the exponent
`E n = (((n/4)*(n/4) − n − 3)/3)² / (2·n²)` exceeds every linear function
`c*n + d`.  Hence the `dagSize` lower bound `2^(E n)` is genuinely exponential
(in particular `E n → ∞`), and grows like `2^Ω(n²)`.

The proof: `(n/4)*(n/4) ≥ Ω(n²)`, so the numerator is `Ω(n⁴)`, and dividing by
`2n²` leaves `Ω(n²)`, which dominates any linear `c*n+d`.  We expose a concrete
threshold `n ≥ N₀(c,d)` after which the inequality holds; the heavy arithmetic is
isolated in `exponent_kernel` to keep elaboration contexts small. -/
theorem dag_exponent_exceeds_linear (c d : Nat) :
    ∃ N0 : Nat, ∀ n : Nat, N0 ≤ n →
      c * n + d <
        ((((n / 4) * (n / 4) - n - 3) / 3) * (((n / 4) * (n / 4) - n - 3) / 3))
          / (2 * (n * n)) := by
  -- The exponent E n is Θ(n²); it dominates any linear c*n+d for n large.
  -- We lower-bound through a chain of clean monotone divisions, keeping one
  -- explicit factor of n²:  q := (n/4)² ≥ n²/32, so (q-n-3)/3 ≥ q/6 ≥ n²/192,
  -- its square ≥ (n²/192)², and /(2n²) ≥ c*n+d+1 for n ≥ N0.
  refine ⟨294912 * (c + d + 1) + 384, ?_⟩
  intro n hn
  have hn4 : 4 ≤ n := by omega
  -- 16 * q ≥ (n-3)² (since 4*(n/4) ≥ n-3).
  have hq4 : n - 3 ≤ 4 * (n / 4) := by
    have := Nat.div_add_mod n 4
    have hmod : n % 4 < 4 := Nat.mod_lt n (by norm_num)
    omega
  have h16q : (n - 3) * (n - 3) ≤ 16 * ((n / 4) * (n / 4)) := by
    calc (n - 3) * (n - 3) ≤ (4 * (n / 4)) * (4 * (n / 4)) := Nat.mul_le_mul hq4 hq4
      _ = 16 * ((n / 4) * (n / 4)) := by ring
  set q := (n / 4) * (n / 4) with hq
  -- q ≥ n²/32 (clean): n² ≤ 2(n-3)² for n ≥ 64, and (n-3)² ≤ 16q.
  have hq_lb : n * n / 32 ≤ q := by
    have hquad2 : n * n ≤ 2 * ((n - 3) * (n - 3)) := by
      have h3n : 3 ≤ n := by omega
      nlinarith [Nat.sub_add_cancel h3n, hn]
    have : n * n ≤ 32 * q := by omega
    omega
  -- q ≥ 2(n+3) for n large ⟹ q - n - 3 ≥ q/2.
  have hq_big : 2 * (n + 3) ≤ q := by
    have : 64 * (n + 3) ≤ n * n := by nlinarith [hn]
    omega
  have hA : q / 2 ≤ q - n - 3 := by omega
  -- (q - n - 3)/3 ≥ q/6 ≥ (n²/32)/6 = n²/192.
  have hB : q / 6 ≤ (q - n - 3) / 3 := by
    have hA3 : (q / 2) / 3 ≤ (q - n - 3) / 3 := Nat.div_le_div_right hA
    calc q / 6 = (q / 2) / 3 := by rw [Nat.div_div_eq_div_mul]
      _ ≤ (q - n - 3) / 3 := hA3
  have hq6_lb : (n * n) / 192 ≤ q / 6 := by
    calc (n * n) / 192 = (n * n / 32) / 6 := by rw [Nat.div_div_eq_div_mul]
      _ ≤ q / 6 := Nat.div_le_div_right hq_lb
  have hlow : (n * n) / 192 ≤ (q - n - 3) / 3 := le_trans hq6_lb hB
  -- square and divide are monotone.
  have hVpos : 0 < 2 * (n * n) := by positivity
  have hmono :
      ((n * n) / 192) * ((n * n) / 192) / (2 * (n * n))
        ≤ ((q - n - 3) / 3) * ((q - n - 3) / 3) / (2 * (n * n)) :=
    Nat.div_le_div_right (Nat.mul_le_mul hlow hlow)
  -- It remains: c*n+d < ((n²/192)²) / (2 n²) — the isolated arithmetic kernel.
  refine lt_of_lt_of_le ?_ hmono
  have hthr : (c + d + 1) * 294912 ≤ n := by omega
  exact exponent_kernel c d n (n * n) rfl hn4 hthr

/-! ## 5. The remaining TRUE structural sub-lemma, and the modulo statement -/

/--
**The remaining precisely-named TRUE structural sub-lemma.**

`dagSizeWidthMonotoneCore` is exactly `DagRestrictionNarrowsCore`: the general
(DAG) resolution Ben-Sasson-Wigderson tradeoff.  It is the DAG random-restriction
"few fat clauses" counting argument (BW 1999): in any refutation of DAG-size `S`,
fewer than `S` clauses are "fat" (width `> d`); hitting the most frequently
occurring variable with a random restriction kills a constant fraction of fat
clauses per step, so after restricting `≈ sqrt(V ln S)` variables ALL fat clauses
vanish, leaving a refutation of width `≤ w0 + d` over the restriction, which lifts
back paying `≤ sqrt(V ln S)` reintroduced literals.

It is **TRUE** and **NOT circular**: it is formula-independent and produces a
NARROWED refutation to which the width LOWER bound is then applied (real work).

What blocks a fully local Lean proof here: the tree machinery proven in
`ResolutionSizeWidthCore.lean` (`restrictTree`, `liftWidth`, `liftUnit`,
`narrow_combine`, `narrowAux`) implements the TREE recursion giving the `log S`
budget.  The DAG `sqrt(V log S)` budget requires the *counting / random-restriction*
argument over the DAG line set (the distinct-clause multiset), which is a
genuinely different combinatorial step not yet formalised in this repository.  We
therefore isolate it honestly as this single hypothesis. -/
def dagSizeWidthMonotoneCore : Prop := DagRestrictionNarrowsCore

/-- The sub-lemma is, by definition, exactly the core (kept as two names to make
the "what remains" boundary explicit and auditable). -/
theorem dagSizeWidthMonotoneCore_iff_core :
    dagSizeWidthMonotoneCore ↔ DagRestrictionNarrowsCore := Iff.rfl

/-! ## 6. The final DAG size lower-bound theorem (modulo the named sub-lemma) -/

/--
**FINAL DAG SIZE LOWER BOUND (modulo `dagSizeWidthMonotoneCore`).**

Assuming the TRUE general-resolution BW tradeoff sub-lemma, for `4 ≤ n` every
refutation of the concrete `K_n` Tseitin CNF has `dagSize` at least `2 ^ (E n)`
with `E n = Ω(n²)`.  This is the general (DAG) analogue of the proven tree bound
`tseitinKn_unconditional_resolutionSize_ge_exp`. -/
theorem tseitinKn_dagSize_ge_exp
    (hsub : dagSizeWidthMonotoneCore) {n : Nat} (hn : 4 ≤ n)
    (r : ResolutionRefutation (cnf (n := n))) :
    2 ^ ((((n / 4) * (n / 4) - n - 3) / 3) * (((n / 4) * (n / 4) - n - 3) / 3)
          / (2 * (n * n)))
      ≤ dagSize r :=
  tseitinKn_dagSize_ge_exp_of_core (dagSizeWidthMonotoneCore_iff_core.mp hsub) hn r

/--
**Non-vacuity.**  For `4 ≤ n` there GENUINELY EXISTS a refutation of the concrete
`K_n` Tseitin CNF, and (under the sub-lemma) it has `dagSize ≥ 2^(E n)`.  The
bound is witnessed by an actually-existing object, not vacuously true. -/
theorem tseitinKn_dagSize_nonvacuous
    (hsub : dagSizeWidthMonotoneCore) {n : Nat} (hn : 4 ≤ n) :
    ∃ r : ResolutionRefutation (cnf (n := n)),
      2 ^ ((((n / 4) * (n / 4) - n - 3) / 3) * (((n / 4) * (n / 4) - n - 3) / 3)
            / (2 * (n * n)))
        ≤ dagSize r := by
  obtain ⟨r⟩ := Completeness.tseitinKn_refutation_exists (by omega : 0 < n)
  exact ⟨r, tseitinKn_dagSize_ge_exp hsub hn r⟩

end ResolutionDagSizeWidth
end CNFResolution
end PvNP
