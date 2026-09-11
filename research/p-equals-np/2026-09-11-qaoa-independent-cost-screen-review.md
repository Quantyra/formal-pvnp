# Independent single-instance cost-screen review

2026-09-11. S3046 / E014 / E004; related S3044/S3045. Under `INTEGRITY-CLAIMS.md`. One independent reviewer applies three lenses; this is not formal theorem closeout.

## Pre-outcome criteria

Freeze the independent generator, seed, clause law, n, angle arrays, numerical limits and logical cost convention before observing overlaps. Retain the one instance regardless of satisfiability. This does not reproduce or replace the missing S3045 formula.

Use common units for initial preparation, every forward/inverse preparation, marking, reflection, verification and reset. Give uniform amplification the same optimization opportunity and a sufficient iteration range; the earlier j<=32 prefix is not an optimized full comparator. Known-overlap schedule optimization and exact solution enumeration are offline diagnostics, not free solver knowledge. Preserve zero-overlap and UNSAT limitations.

## Verification and disposition

The analyst's proposed preflight was reviewed before outcomes: n=16, k=8, Poisson clause count with mean 176.54*n, PCG64 seed 20260911, replacement variable draws and independent signs. No satisfiability rejection. Published p=14/p=60 arrays retain the previously documented beta and gamma convention. Existing 120-second/512-MiB numerical limits apply.

The proposed screen fixes hypothetical (H/R,V/R) pairs (0.01,0.01), (0.1,0.1) and (1,1), where R includes marking and reflection, and compares symbolic per-layer cost L. This is a threshold analysis, not a compiled gate-count measurement. Known-a uniform restart cost includes j=0 and has a rigorous finite bound: once the unconditioned trial cost exceeds an incumbent expected cost, no later j can improve it since success is at most one. QAOA positive layer-cost thresholds can likewise exclude every j whose zero-layer trial cost is already at least the uniform incumbent.

## Observed result and independent checks

The [manifest](2026-09-11-qaoa-independent-cost-screen-manifest.json) froze at **2026-09-11 18:09:57.179534 UTC**, SHA256-LF `7b6dc11ea22b020e859bfe9172437438d58ec620a8594ec0af2b69b53263093f`. The reviewer independently regenerated the exact seeded draw, confirmed all 2,850 clauses match the stored formula, and parsed the saved DIMACS to verify identical literals and clause ordering. No overlap or satisfiability was used in that generation check.

The author found **K=0: UNSAT**. The reviewer independently validated this with a different direct-literal algorithm: begin with all 65,536 assignments, evaluate each clause by OR of its signed literal truth values, then retain satisfying assignments. The surviving set becomes empty after clause 2,606, so the full formula is unsatisfiable. This check used neither the author's energy-vector predicate nor quantum evolution. It took about 0.44 seconds.

The [results](2026-09-11-qaoa-independent-cost-screen-results.json) correctly contain no QAOA replays and no cost-screen entries. The frozen UNSAT stop rule was followed without reselection. Recorded runtime was about 0.714 seconds and peak working set 34,336,768 bytes. Both remain below the prospective budget.

The reviewer inspected the cost optimizer and independently ran its synthetic tests: zero/unit overlap, exhaustive 10,000-j comparison on a positive-overlap example, and both sides of the layer-cost threshold passed. These verify cost arithmetic only; they are not performance observations on this UNSAT draw. No target amplitude-amplification optimizer can produce a satisfying assignment when the satisfying subspace is empty.

## Three-lens verdict

**GO for the valid one-draw UNSAT result and protocol adherence. The preparation-cost research question is INCONCLUSIVE.**

| Lens | Verdict | Limit |
|---|---|---|
| Source/proof | GO | Seeded formula/DIMACS agreement and independent exhaustive literal evaluation confirm K=0. This does not recover the missing S3045 formula. |
| Complexity | INCONCLUSIVE for cost advantage | No QAOA evolution or positive-overlap cost comparison ran; synthetic optimizer checks do not supply such evidence. |
| Non-claims | GO | No QAOA failure, typical SAT rate, preparation-cost saving, practical advantage or scaling conclusion follows from this single UNSAT draw. |

Stop this checkpoint as frozen. A future diagnostic would need a separately preregistered fixed batch with explicit treatment of UNSAT outcomes if the objective requires positive-overlap comparisons. Do not redraw until SAT or reinterpret this unselected UNSAT result as evidence against the quantum mechanism.
