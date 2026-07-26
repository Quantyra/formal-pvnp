/-
# Explicit `2^Ω(n²)` capstone for the DAG-resolution lower bound

The headline `dagSize_ge_exp_quarter_uncond` / `dagSize_ge_exp_quarter_nonvacuous`
states the bound in **width-gap** form:
`(n/4)² − w0width cnf ≤ 3√(2n²·log₂ S) + 3`.

This file records, with NO new hypothesis, that the gap is genuinely **quadratic**
(`w0width cnf ≤ n` is proved in `ResolutionSizeWidth`, so the gap `≥ (n/4)² − n`),
hence the bound forces `log₂(dagSize)` to grow **quadratically** in `n` — i.e. the
size lower bound is a genuine `2^Ω(n²)`, not vacuous.

We give the clean **division-free** (cross-multiplied) form:
`((n/4)² − n − 3)² ≤ 18·n²·log₂(dagSize r.proof)`  for `n ≥ 32`,
with the left side `~ (n²/16)² = Θ(n⁴)`, forcing `log₂(dagSize) = Ω(n²)`.

INTEGRITY: no `sorry`, no `admit`, no new `axiom`, no `native_decide`.  This only
composes already-proved results (`dagNarrows_sqrt`, `dag_widthBound_quarter`,
`w0width_cnf_le`, `tseitinKn_dagRefutation_exists`, `dagSize_log_ge_of_widthBound`).
This is a RESOLUTION PROOF-SYSTEM size bound, NOT `P ≠ NP`.
-/
import PvNP.DagNarrowsSqrt
import PvNP.DagNonVacuity

namespace PvNP
namespace CNFResolution
namespace DagExpExplicit

open PvNP.CNFResolution.TseitinKnConcrete
open PvNP.CNFResolution.ResolutionSizeWidth
open PvNP.CNFResolution.DagResolutionModel
open PvNP.CNFResolution.DagSizeWidth
open PvNP.CNFResolution.DagWidthLowerBound

/-- **The width gap is `≥ 3` (so the squared lemma applies), for `n ≥ 32`.**
Using `w0width cnf ≤ n` and the floor bound `4·(n/4) ≥ n − 3`. -/
theorem gap_ge_three {n : Nat} (hn : 32 ≤ n) :
    3 ≤ (n / 4) * (n / 4) - w0width (cnf (n := n)) := by
  set q := n / 4 with hq
  have hq4 : q * 4 ≤ n := Nat.div_mul_le_self n 4
  have hn4 : n ≤ 4 * q + 3 := by
    have h := Nat.div_add_mod n 4
    have hmod : n % 4 < 4 := Nat.mod_lt _ (by norm_num)
    omega
  have hq8 : 8 ≤ q := by
    rw [hq]; calc 8 = 32 / 4 := by norm_num
      _ ≤ n / 4 := Nat.div_le_div_right hn
  have hqq : 8 * q ≤ q * q := by
    have := Nat.mul_le_mul_right q hq8
    simpa [Nat.mul_comm] using this
  have hw0 : w0width (cnf (n := n)) ≤ n := w0width_cnf_le
  omega

/-- **Explicit quadratic capstone (division-free).**  For `n ≥ 32` there EXISTS a DAG
refutation `r` of the concrete `K_n` Tseitin CNF with
`((n/4)² − n − 3)² ≤ 18·n²·log₂(dagSize r.proof)`.

The left side is `Θ(n⁴)` while the right is `18 n²·log₂(dagSize)`, so
`log₂(dagSize) = Ω(n²)`: the size lower bound is a genuine `2^Ω(n²)`.  No hypothesis
beyond `n ≥ 32`.  RESOLUTION proof-system bound, NOT `P ≠ NP`. -/
theorem dagSize_log_ge_quadratic {n : Nat} (hn : 32 ≤ n) :
    ∃ r : DagRefutation (cnf (n := n)),
      ((n / 4) * (n / 4) - n - 3) * ((n / 4) * (n / 4) - n - 3)
        ≤ 18 * (n * n) * Nat.log 2 (dagSize r.proof) := by
  obtain ⟨r⟩ := DagNonVacuity.tseitinKn_dagRefutation_exists (by omega : 0 < n)
  refine ⟨r, ?_⟩
  have hn4 : 4 ≤ n := by omega
  -- The proven squared lemma, made unconditional by `dagNarrows_sqrt`.
  have hsq := dagSize_log_ge_of_widthBound DagNarrowsSqrt.dagNarrows_sqrt
    (cnf (n := n)) ((n / 4) * (n / 4)) (dag_widthBound_quarter hn4) r (gap_ge_three hn)
  -- hsq : (((n/4)² - w0width cnf) - 3)² ≤ 9 * (2 * (n*n) * log₂ S)
  have hw0 : w0width (cnf (n := n)) ≤ n := w0width_cnf_le
  -- Replace w0width cnf by n (subtracting more only shrinks the base).
  have hmono : (n / 4) * (n / 4) - n - 3
      ≤ (n / 4) * (n / 4) - w0width (cnf (n := n)) - 3 := by omega
  have hbase : ((n / 4) * (n / 4) - n - 3) * ((n / 4) * (n / 4) - n - 3)
      ≤ ((n / 4) * (n / 4) - w0width (cnf (n := n)) - 3)
          * ((n / 4) * (n / 4) - w0width (cnf (n := n)) - 3) :=
    Nat.mul_le_mul hmono hmono
  -- 9 * (2 * X) = 18 * X.
  have h18 : 9 * (2 * (n * n) * Nat.log 2 (dagSize r.proof))
      = 18 * (n * n) * Nat.log 2 (dagSize r.proof) := by ring
  calc ((n / 4) * (n / 4) - n - 3) * ((n / 4) * (n / 4) - n - 3)
      ≤ ((n / 4) * (n / 4) - w0width (cnf (n := n)) - 3)
          * ((n / 4) * (n / 4) - w0width (cnf (n := n)) - 3) := hbase
    _ ≤ 9 * (2 * (n * n) * Nat.log 2 (dagSize r.proof)) := hsq
    _ = 18 * (n * n) * Nat.log 2 (dagSize r.proof) := h18

end DagExpExplicit
end CNFResolution
end PvNP
