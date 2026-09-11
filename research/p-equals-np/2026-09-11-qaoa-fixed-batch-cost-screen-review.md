# Independent fixed-batch cost-screen review

2026-09-11. S3047 / E014 / E004, under `INTEGRITY-CLAIMS.md`. One independent reviewer applies three lenses; this is not formal theorem closeout.

## Preflight

GO for the prescribed 16 seeds 20260912 through 20260927, n=16, k=8, Poisson clause count of mean 176.54*n, replacement variable draws and independent signs. Freeze every input before solution counts or overlaps. Keep all outcomes, including UNSAT and budget-incomplete cases. Run the fixed published p=14/p=60 arrays only on SAT cases, with no tuning, reselection or batch extension. Limits: 600 seconds total, 120 seconds per pair, 512 MiB and one numerical thread.

Reuse the S3046 reviewed symbolic cost model, including initial preparation, every forward/inverse preparation, marking/reflection, and verification/reset. Uniform amplification receives the same globally optimized restart comparison. Exact overlap and solution counts are offline diagnostics; hypothetical cost ratios are not compiled gate measurements. SAT-conditioned summaries cannot establish population, scaling, classical or hardware advantage. This independent batch does not recover the missing S3045 source formula.

## Final verification

The [manifest](2026-09-11-qaoa-fixed-batch-manifest.json) froze at 2026-09-11 19:42:24.493208 UTC, SHA256-LF `778db8e233dda99e84276ec355e38bad74d1a1485da7500b4dcb518c403cd6f8`. The reviewer verified this pin, independently regenerated every seeded formula and confirmed exact clause ordering. A separate direct-literal survivor algorithm enumerated all 65,536 assignments per formula without calling the author's energy evaluator. Solution counts in ascending seed order are `[1,0,0,0,5,1,0,0,1,0,1,0,3,0,0,1]`: **7 SAT and 9 UNSAT**. Every count matches the [results](2026-09-11-qaoa-fixed-batch-results.json).

All 16 IDs completed with no pending cases. All nine UNSAT cases have empty replay/cost entries; all seven SAT cases have both prescribed depths. The batch recorded 18.334 seconds and peak working set 66,056,192 bytes, below its caps. These are classical diagnostic resource measurements. The maximum reported norm drift was 1.044e-14, below 1e-10.

For the first frozen seed only, the reviewer independently formed energies by signed-literal OR and simulated the circuit using full XOR-permutation mixers instead of the engine's reshape kernel. Depth 14 success was 0.13296488842089965 and depth 60 success was 0.704291247971695, differing from the author by at most 1.11e-16. Both final norms passed 1e-10. This numerical cross-check took about 3.04 seconds and did not search angles or select a favorable instance.

Independent exhaustive scalar grids verified all 21 uniform restart optima and all 42 depth/scenario layer-cost thresholds, including cost below the uniform comparator at half the threshold and above it at 1.01 times the threshold. Initial/forward/inverse preparations, marking/reflection and verification/reset are charged in the same symbolic units. The finite search exclusion follows from success probability at most one and increasing trial cost. The inherited synthetic checks also passed in the recorded run.

Depth 60 has higher success on six of seven SAT cases, but this alone does not establish a better preparation-aware cost. All 42 conditional thresholds are positive. At H/R=V/R=0.1, median admissible L/R is about 2.764 for depth 14 and 1.342 for depth 60. These are conditional break-even limits, not actual layer costs or measured speedups. In particular, different-depth layer implementations need not have identical cost; no empirical cost assignment was made.

## Three-lens verdict

**GO for this completed fixed-batch diagnostic and its conditional symbolic thresholds. No implementation advantage is established.**

| Lens | Verdict | Evidence and limit |
|---|---|---|
| Source/proof | GO | All frozen seeded clauses and solution counts verified independently; one prescribed pair cross-checked with alternative numerical evolution. This is paper-defined independent data, not recovery of S3045's missing source formula. |
| Complexity | GO for conditional arithmetic | Uniform baseline and all threshold calculations verified, with full listed kernel costs. Exact overlap/solution enumeration and known-overlap optimization are offline aids; training/compilation are assumed amortized, and no gate compilation or general SAT algorithm is supplied. |
| Non-claims | GO | All 16 outcomes retained; overlap/cost summaries explicitly condition on seven SAT cases. No population inference, scaling law, hardware/classical advantage, or P-versus-NP conclusion follows. |

Stop this prescribed batch. A subsequent implementation-cost audit would have to fix the reversible circuit and charge its actual resources before comparing with these thresholds; it is not authorized or performed by this review. Neither additional seeds nor angle tuning is needed to close this checkpoint.
