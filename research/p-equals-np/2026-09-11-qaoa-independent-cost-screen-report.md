# Independent QAOA cost screen: retained UNSAT outcome

2026-09-11. S3046 / E014 / E004. **The one frozen independent formula is UNSAT.** Exact diagnostic enumeration found K=0 among all 65,536 assignments. In accordance with the preregistration, the formula was retained and the run stopped: no QAOA state evolution, seed change, instance rejection or replacement occurred. This completes the bounded screen with its predefined UNSAT outcome; it supplies no preparation-cost or quantum-speedup evidence.

## What ran

The [preregistration](2026-09-11-qaoa-independent-cost-screen-preregistration.md) chose n=16, k=8, r=176.54, PCG64 seed 20260911 and Poisson clause count before examining success. The generator produced 2,850 clauses with replacement and independent literal signs. Every clause is preserved in the [DIMACS file](2026-09-11-qaoa-independent-cost-screen.cnf) and [JSON formula](2026-09-11-qaoa-independent-cost-screen-formula.json).

The [frozen manifest](2026-09-11-qaoa-independent-cost-screen-manifest.json) has SHA256-LF `7b6dc11ea22b020e859bfe9172437438d58ec620a8594ec0af2b69b53263093f`; formula JSON SHA256-LF is `4fb188a619f808d3da63a324a541d7c2cebbe9e2604c5b13b881783b1993c3a0`. SHA256-LF replaces CRLF with LF and changes no other bytes. The manifest binds the generator, full published angle arrays/mapping, engine, cost assumptions and budget before target evolution.

The [screen script](2026-09-11-qaoa-independent-cost-screen.py) ran the tested integer energy evaluator across every assignment and cross-checked 66 fixed assignments with an independent literal evaluator. It found 1,643 tautological clauses and 2,366 repeated literal occurrences; these are consequences of the frozen replacement-literal law, not discarded data. After tautologies, 1,207 distinct non-tautological clause patterns remain. Their multiplicities are preserved in the energy computation.

[Results](2026-09-11-qaoa-independent-cost-screen-results.json) record K=0, uniform overlap 0, empty QAOA/cost-result dictionaries and the explicit UNSAT stop. Measured diagnostic time was 0.714 seconds and peak working set 34,336,768 bytes, below the prospective 120-second/512-MiB cap. These CPU measurements describe the classical diagnostic only.

## Cost and interpretation boundary

The frozen cost screen would compare preparation-aware QAOA against globally optimized uniform amplitude-amplification restart cost in common symbolic units, including initial preparation, its inverse on each iteration, both reflections and verification/reset. Its global iteration search passed independent synthetic checks, but no real cost threshold was evaluated because neither preparation has a satisfying subspace on this instance. Known-overlap tuning and exhaustive K were explicitly diagnostic aids, not free solver inputs.

An empty satisfying subspace means every quantum state has zero satisfying-assignment probability. Running the QAOA pair on this formula could not provide the intended success-versus-preparation-cost comparison. The UNSAT finding is about this independently generated formula, not evidence that QAOA fails on SAT or that a quantum advantage is impossible. It is not a reproduction or substitute for the still-missing S3045 source formula.

## Decision

**STOP this one-instance checkpoint as preregistered; no cost-advantage claim is supported.** A single unconditioned draw can be uninformative for a satisfying-overlap comparison. If continuing, the efficient next design is one bounded, preregistered fixed batch, with every generated ID retained and SAT/UNSAT outcomes reported, rather than repeated individual seeds until a convenient result appears. Freeze its sample count, seeds, circuit depths and cost rule before outcomes; no batch is executed here.

Independent review verified the saved DIMACS formula against the seeded JSON clauses and separately filtered all 65,536 assignments by direct literal evaluation. No assignments survived after clause 2,606, confirming K=0 without reusing the engine's bitmask-energy computation. The [independent review](2026-09-11-qaoa-independent-cost-screen-review.md) gives GO for the valid UNSAT result and protocol adherence, with the preparation-cost question INCONCLUSIVE. No hardware, paid resource, outreach, push, publication, general SAT result or P=NP claim occurred.
