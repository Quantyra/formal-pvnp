import PvNP.DagNonVacuity

/-!
# S2238 local BSW/Tseitin DAG width-size kernel

This module pins the concrete `K_n` Tseitin DAG-resolution kernel that replaces the
older imported width-expansion source for this family.  It is intentionally local:
it packages the already-proved S1749--S1758 DAG stack for the concrete CNF only.

Claims boundary: DAG resolution width/size lower-bound inequalities for the local
Tseitin `K_n` CNF.  This is not a circuit lower bound, not an NP lower bound, and
not `P ≠ NP`.
-/

namespace PvNP
namespace CNFResolution
namespace S2238BSWTseitinWidthKernel

open PvNP.CNFResolution.DagResolutionModel
open PvNP.CNFResolution.DagSizeWidth
open PvNP.CNFResolution.TseitinKnConcrete

/--
**S2238 local width kernel.** For the concrete `K_n` Tseitin CNF, every DAG
resolution refutation has quadratic width at least `(n/4)^2`.

This is the concrete-family local kernel used in place of an imported
`bsw_width_expansion_strategy_source` width-expansion premise.
-/
theorem s2238_tseitinKn_dag_width_kernel_local {n : Nat} (hn : 4 ≤ n)
    (r : DagRefutation (cnf (n := n))) :
    (n / 4) * (n / 4) ≤ refutationWidthDag r :=
  DagWidthLowerBound.dag_unconditional_refutationWidthDag_ge_quarter hn r

/--
**S2238 local width-size kernel.** For every concrete `K_n` Tseitin DAG refutation,
the local quadratic width kernel and the unconditional BSW size-from-width
inequality both hold.

The second conjunct is obtained by feeding the proved DAG narrowing theorem into the
local width lower bound; no external width-expansion source is assumed here.
-/
theorem s2238_tseitinKn_dag_size_width_kernel_local {n : Nat} (hn : 4 ≤ n)
    (r : DagRefutation (cnf (n := n))) :
    ((n / 4) * (n / 4) ≤ refutationWidthDag r) ∧
      ((n / 4) * (n / 4)) - ResolutionSizeWidth.w0width (cnf (n := n)) ≤
        3 * Nat.sqrt (2 * (n * n) * Nat.log 2 (dagSize r.proof)) + 3 := by
  exact ⟨s2238_tseitinKn_dag_width_kernel_local hn r,
    DagNarrowsSqrt.dagSize_ge_exp_quarter_uncond hn r⟩

/--
**S2238 non-vacuous local width-size kernel.** There exists a concrete `K_n`
Tseitin DAG refutation witnessing the local width kernel together with the
unconditional size-from-width inequality.
-/
theorem s2238_tseitinKn_dag_size_width_kernel_nonvacuous {n : Nat} (hn : 4 ≤ n) :
    ∃ r : DagRefutation (cnf (n := n)),
      ((n / 4) * (n / 4) ≤ refutationWidthDag r) ∧
        ((n / 4) * (n / 4)) - ResolutionSizeWidth.w0width (cnf (n := n)) ≤
          3 * Nat.sqrt (2 * (n * n) * Nat.log 2 (dagSize r.proof)) + 3 := by
  obtain ⟨r⟩ := DagNonVacuity.tseitinKn_dagRefutation_exists (by omega : 0 < n)
  exact ⟨r, s2238_tseitinKn_dag_size_width_kernel_local hn r⟩

end S2238BSWTseitinWidthKernel
end CNFResolution
end PvNP
