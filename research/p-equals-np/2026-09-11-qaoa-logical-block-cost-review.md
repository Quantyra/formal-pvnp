# Independent logical block-cost review

2026-09-11. S3048 / E014 / E004. One independent reviewer applies three lenses under `INTEGRITY-CLAIMS.md`; this is not formal theorem closeout.

## Pre-count review

GO for one frozen wide clean-ancilla construction on the seven S3047 SAT formulas. Remove tautologies and repeated same-sign literals within a clause, preserving every non-tautological clause occurrence and its phase weight. Compute clause falsity with reversible AND ladders. Charge all retained clause intermediates, the final AND, and their complete inverses for SAT marking. Charge the zero reflection, initial preparation, and the same full verification/reset convention to both algorithms.

The initial proposed scalar was T count. Before any comparison, review identified a degeneracy under the subsequently chosen classical final verification: H_T=V_T=0, so j=0 uniform sampling and all its repetitions cost zero T gates. The correct optimum must retain this outcome, not exclude j=0.

The pre-count refinement uses elementary logical gate count as the primary metric: H/X/CNOT/T or inverse gates cost one; an exact Toffoli is decomposed into six CNOT, two H and seven T/T-dagger gates; each arbitrary rotation's full elementary length is a parameter. Uniform preparation now costs 16 gates. Classical final verification is separately charged in its own work vector, as are measurement/reset and ancillas. This scalar still does not represent physical time, and arbitrary-rotation sensitivity is not a concrete synthesized circuit until its accuracy and length are jointly supported. Preserve the exact T-only degeneracy as a secondary result. These choices were made before count comparisons, not to select a favorable observed outcome.

Recompute uniform and QAOA restart optima with actual symbolic block ratios, rather than substituting the earlier H/R=V/R=0.1 scenario. Exact overlaps and optimal iteration choices remain offline diagnostics. Bound finite-trial operator error using the number of rotation occurrences, and state the resulting success-probability/cost correction. This is not a uniform error guarantee for an unlimited sequence of trials.

## Final checks

The [frozen contract](2026-09-11-qaoa-logical-cost-preregistration.md) and [freeze record](2026-09-11-qaoa-logical-cost-freeze.json) bind the implementation and prior data before counts. Reviewer verified freeze SHA256-LF `72326f3d643ad321d7f2b53707e1e2a7bb80d6633ebc956f18662337f123b4c8` and every listed input pin.

Independent operation lists, built from the original clauses rather than the author's count formulas, reproduce all seven phase-layer, SAT-mark and peak-ancilla counts. Preserving duplicate clause occurrences and removing only tautologies/repeated same-sign literals gives 1,107 to 1,207 retained clauses and 7,730 to 8,401 clean ancillas for the fixed wide predicate. Ancillas are reused across serial blocks, not summed over depth. A separate three-bit signed-clause example with repetitions and a tautology checks all eight computational basis inputs: SAT marking applies exactly the correct sign, preserves input bits, and returns all ancillas to zero. The clause Rz(-gamma/2) convention agrees with the original energy phase up to a global phase.

Independent exhaustive scalar grids reproduce all 210 uniform/QAOA optima (seven formulas, two verification policies, five rotation lengths, three preparations). Rotation-occurrence counts, required per-rotation error and conservative fixed-iteration costs also match. These checks use the actual block counts and retain j=0; they do not reuse the former hypothetical central threshold ratios. The exact logical primitive decomposition is source-checked separately by the source author; this review independently checks its use in the arithmetic, not a newly synthesized gate library.

Under the primary measured-classical-verification policy, uniform j=0 is optimal for all seven formulas. Even with rotation length rho=0, depth 14 requires **8.8005 to 69.2944 times** the expected elementary unitary gates of that comparator, and depth 60 requires **15.8852 to 230.1085 times**. These values match the [saved results](2026-09-11-qaoa-logical-cost-results.json). Every fixed-j QAOA cost is nondecreasing in rho, so minimizing over j cannot turn this loss into a win at any rho>=0. The numerical approximation correction increases, rather than improves, the stated conservative QAOA costs. Actual synthesis feasibility is therefore unnecessary to rule out a primary-gate-count advantage for this frozen construction; it would still be required for a concrete compiled resource estimate.

Classical verification work, measurement/reset counts and compilation are separate resources. Uniform j=0 repeats their costs many times, so the unitary-gate comparison must not be promoted to a full-runtime or mixed classical/quantum resource conclusion. Secondary reversible verification is a separately specified policy, not a reason to burden the primary uniform baseline with unnecessary coherent work. T-only accounting has the zero-cost j=0 degeneracy already identified above.

The [final report](2026-09-11-qaoa-logical-cost-report.md) also gives a stronger, simpler certificate that was independently checked: one depth-14 preparation at rho=0 already costs 2.7941 to 14.4168 times the entire expected uniform unitary cost. Every QAOA trial includes at least that preparation and success cannot exceed one. Thus even arbitrary perfect success cannot rescue the frozen construction under this metric; the negative result does not require trusting the approximate overlap values. The report's classical-work expression and secondary-policy win counts were checked, and its wording preserves the resulting resource tradeoff.

## Three-lens verdict

| Lens | Verdict | Scope |
|---|---|---|
| Source/proof | GO for accounting | Frozen input pins, independent operation counts and small exhaustive reversible semantics pass. The ladder preserves energy multiplicities and cleans its workspace. No general SAT theorem or source-formula recovery. |
| Complexity/resources | GO for conditional comparison; STOP advantage claim for this construction | All optimizer/error arithmetic checked in common unitary-gate units. The fixed construction loses even at free rotation cost; classical work, actual synthesis, routing and fault correction remain separate. |
| Non-claims | GO | This is a fixed-seven-case, known-overlap logical-kernel diagnostic. It does not show quantum algorithms generally fail, or establish physical time, an unknown-overlap solver, a complete SAT/UNSAT comparison, classical runtime advantage, scaling, or P versus NP. |

Stop this frozen cost audit. No new decomposition, seed, angle search or experiment is needed to validate its negative primary-metric result. A subsequent design question must be separately scoped; the observed loss is not an impossibility theorem for every implementation.
