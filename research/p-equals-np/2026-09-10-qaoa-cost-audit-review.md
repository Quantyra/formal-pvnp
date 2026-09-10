# Independent QAOA cost-audit review

2026-09-10. S3043 / E014 / E004; related S3042 / S3040 / S008. Under `INTEGRITY-CLAIMS.md`.

One independent reviewer applied the proof/source, complexity, and non-claims lenses. This is not three separately staffed formal reviewers or a Lean theorem closeout. No implementation, hardware, commit or publication was performed.

## Review scope

Review targets are [full-source audit](2026-09-10-qaoa-full-source-audit.md) and [success-cost audit](2026-09-10-qaoa-success-cost-audit.md). Primary full PDFs were inspected independently, including relevant theorem statements, statistics, methods and resource limitations. No independent reconstruction of every fault-tolerance circuit or supplemental saddle-point proof is claimed.

## Independently checked source boundaries

[Boulebnane–Montanaro (2024)](https://journals.aps.org/prxquantum/pdf/10.1103/PRXQuantum.5.030348): Definition 1 uses a Poisson clause count and literals sampled with replacement. Proposition 1's analytic guarantee requires sufficiently small cost angles. Sections III A–C distinguish ensemble-average success from median runtime and discuss empirical divergence. Numerical success validation retains satisfiable instances. A fixed-depth, large-instance limit and a depth extrapolation are different obligations. Published angle conventions must be converted explicitly before use.

[Omanakuttan et al. (2025)](https://arxiv.org/pdf/2504.01897): Sections II A and IV F explicitly study incomplete solvers with satisfiable-instance filtering and fixed clause count. Equation 1 is a median classical fit in nanoseconds. Discussion acknowledges depth extrapolation and omitted routing. Methods IV A's exact unknown-overlap constant requires repair: the interval assertion beneath Eq. 13 fails the check below. This finding concerns its displayed argument, not all amplitude-amplification algorithms. No quoted crossover is independently validated here.

## Exact interval counterexample

The displayed rule sets m=ceil(pi/(8*theta)-1/2) and asserts success at least 1/2 throughout theta_a in [theta/2,theta]. Set theta=pi/4 and theta_a=pi/8. Then m=0 and

    sin^2((2*m+1)*theta_a) = sin^2(pi/8)
                             = (2-sqrt(2))/4
                             = 0.14644660940672624 < 1/2.

Four independent repetitions of this stage fail with probability approximately 0.53079004, not at most 1/16. This is a counterexample to the stage assertion, not an analysis of the whole multistage success distribution. It does not by itself disprove the theorem's existence statement. The original printed PDF page 9 was rendered and visually checked; the ceiling and denominator are not text-extraction artifacts. The contract author independently found the same issue.

## Review obligations

Any selected simulation must measure individual overlaps and their distribution, not infer inverse-cost statistics from a mean. Report conditional SAT statistics alongside unconditional SAT/UNSAT counts. A sample without witnesses is UNKNOWN unless an independently justified complete fallback is charged. This extends the task beyond the source's honest incomplete-solver scope; absence of UNSAT handling alone does not refute that source.

Cost comparisons require matching units. Logical gate ratios can compare two quantum circuits; comparing to classical seconds needs an explicit timing model. Forward and inverse preparation, reflections, repetitions, tuning, failures and verification all count. The Sparrow central fit at n=179 evaluates to approximately 2,062,049 seconds serial before any parallel model; it is not a gate count or measured runtime at that size.

Finite ideal statevectors can discriminate a bounded overlap/tail hypothesis. They cannot validate the resource forecast at hundreds of variables or establish physical advantage. The toy phase convention must not silently replace the source's half-angle convention. Clause tautologies and multiplicities must preserve the selected ensemble and Hamiltonian semantics.

## Final artifact verification and disposition

Both final artifacts were read. **GO for S3044 source-data inventory and bounded reanalysis preparation; STOP adoption of a validated crossover or a runnable simulation claim.** The source author reports a successful archive checksum and member listing; inspect usable schema/provenance and verify locally recovered assets, then freeze one available configuration before evaluating outcome distributions. Exact row availability, pairing and angle conventions remain verification dependencies. Do not silently substitute another ensemble or depth when records are absent.

| Lens | Verdict | Scope |
|---|---|---|
| Proof/source adversarial | GO for data audit | The Eq. 13 issue is reported narrowly; the general AA mechanism survives. Neither full physical compilation nor saddle-point proof has been independently reconstructed. |
| Complexity | GO for per-instance diagnostic | Exact oscillatory thresholds, finite-schedule costs, covariance and fallback accounting are sound. Unknown positive overlap and empirical means supply no universal stopping guarantee. |
| Non-claims | GO for restricted follow-up | Promised-SAT search is distinguished from a complete decision extension; no physical advantage or polynomial SAT claim is licensed. |

The scalar Python and JSON were read, and key results independently recalculated: one-round success at a=0.1 is 0.676; the synthetic mean inverse-square-root cost is 10009.9; the imported parallel factor is 35.4420; the representative iterate costs 2,772,099.4477 logical cycles. The orchestrator also reran the script and its assertions. Representative coloring/synthesis inputs are labeled correctly: this is equation substitution, not reproduction of the 14.99-hour forecast.

The cost artifact's exact restart and finite-prefix formulas check algebraically. Its conservative randomized-AA repair checks: averaging uniformly over j=0,...,M-1 gives the stated trigonometric expression; for its overlap promise the amplified branch has a 1/4 floor, and the mixed branch a 1/8 floor. This does not certify the source's different factor-four accounting. Compilation and hardware error remain separately budgeted.

Both authors now identify the recovered angle density 176.54 separately from the 2025 density 176. Changes in clause-count law and density are separate transfers. The author's code-level gamma-sign inference and reported asset hashes were not independently reproduced by this reviewer; S3044 must pin assets and validate conventions before using them to regenerate overlaps. Reanalysis of existing probability records can proceed only after identifying what those records represent.

Final correction verified: the cost author removed conflicting contingent simulation details and now routes only S3044 inventory/reanalysis; the source author's remaining multi-arm sketch is explicitly conceptual. If new simulation later becomes necessary, reconcile one design, frozen inputs, budget, angle conversion and success criterion first. No simulation is runnable on the strength of this closeout alone. No blocking issue remains for the bounded S3044 data task.
