# Fixed QAOA replay preflight: blocked on the source formula

2026-09-11. S3045 / E014 / E004. Under `INTEGRITY-CLAIMS.md`.

**The selected-formula replay did not run.** Its numerical implementation passed independent synthetic checks, but the exact clause list for fixed source ID `101678_3_1653518225511123992` is unavailable in the recovered evidence. S3045 remains blocked on that source dependency; this is not a failed quantum algorithm or a completed target reproduction.

## Completed preflight

The [prospective numerical contract](2026-09-11-qaoa-replay-numerical-contract.md) fixes the target, p=14/p=60 arrays, paper-defined operators, numerical tolerances and local execution limits before a target computation. The [replay engine](2026-09-11-qaoa-source-replay.py) passed tests against independent literal and dense-matrix references: signed clauses, repetitions, tautologies and empty clauses; bit ordering; mixer overwrite correctness; zero-angle behavior; one-qubit analytic sign cases; norm conservation and process-memory monitoring. The independent reviewer reran those checks.

The circuit label is explicitly a **paper-defined convention check**. The original source simulation driver was not found in the pinned public repository, and row-level angles are null. The recovered published arrays and analytic-coefficient sign mapping define a reviewable hypothesis, not an independently certified original driver. No sign, order or angle was selected by comparison with the desired archived probability.

The frozen source-comparison tolerance is absolute 1e-8 plus relative 1e-6; norm-squared drift must stay below 1e-10 without renormalization. Dense synthetic agreement is checked at 1e-12. The prospective paired run is capped at 120 seconds, 512 MiB peak working set, one process and one numerical thread. These are implementation-check tolerances and budgets, not a rigorous floating-point error theorem or a physical-device model.

## Exact missing dependency

The benchmark records name `instance_description_101678_3_1653518225511123992.json` and `instance_enumeration_101678_3_1653518225511123992`, but references alone do not supply those files. The [source-recovery audit](2026-09-11-qaoa-source-recovery.md) records the full cached archive search: no filename contains the fixed ID, and no description/enumeration-named source member was recovered. The parsed QAOA benchmark schema contains metrics and references, not the literal clauses. The pinned repository supplies arrays and analysis code but no original formula generator/statevector driver.

Without the clauses, neither the selected Hamiltonian nor the exact literal/tautology semantics can be constructed. n, k, r, K and two output probabilities do not identify that formula. Generating a new formula, guessing a seed from its ID, or fitting a circuit to the archived outputs would change the task and invalidate the provenance check.

## Recorded execution status and next action

[Machine-readable status](2026-09-11-qaoa-source-replay-status.json) records zero target replays and no computed target probabilities. There is no final target-execution manifest because its required formula hash cannot be supplied. The prospective contract and script have SHA256-LF pins (CRLF-to-LF conversion only) so Git checkout line-ending changes do not invalidate those pins.

**STOP target execution until the exact source CNF/description and its literal convention are recovered.** This dependency can be satisfied by a provenance-backed copy of the named source formula or a documented original generation procedure that reproduces it; no substitute instance is acceptable. No external author contact was sent.

If that input becomes available, freeze its exact bytes with the already recovered arrays and source benchmark probabilities, review normalization, and run the single paired check under the existing numerical contract. Only after a match would a scoped logical-cost comparison be justified. No target result, resource advantage, ensemble replication, p=623 forecast, SAT-in-BQP result or P=NP conclusion follows from this preflight.
