# S3045 numerical preflight contract

Recorded 2026-09-11 17:46:33 UTC, S3045 / E014 / E004. Destination research satellite under `INTEGRITY-CLAIMS.md`. One fixed-formula comparison only. This contract is recorded before target execution; **Target execution is BLOCKED on exact source-formula recovery.** The prospective numerical contract is frozen, but no executable target manifest or target result exists.

## Evidence label and frozen target

**Paper-defined convention check**, not a faithful reproduction of an independently recovered original simulation driver. The pinned public repository has analytic/plotting code and angle arrays; the original per-instance statevector driver has not been recovered. The evidence label is fixed before execution. A match would validate this particular published-angle/convention hypothesis against two archived probabilities, not establish all source circuit identities.

Use only formula ID `101678_3_1653518225511123992`, the first lexicographic ID in S3044's frozen metadata-selected set, at n=20, depths 14 and 60. Recover the actual formula from the source; never substitute a generated instance or infer it from its ID. Preserve the original formula alongside a documented DIMACS normalization.

Use complete arrays from [recovered angle evidence](2026-09-11-qaoa-recovered-angles.json), pinned repository commit `5c7ee19db385e8a2bad075206e6483cbab43eadb`; original angle file SHA256 `a25049edf7c11dd3a69ee1e36a01bde851fbd86cdf8cf5394cdc8d4fde123821`. Canonical stored-array hash is `7d49c1c721937c876896f067cddb6803e1c793df43fe55d52aba868d5616e8f8`. Preserve array order. A final execution manifest must bind the exact formula bytes, arrays and source probabilities before target execution; its SHA256 is a required command argument.

## Operators and representation

Internal DIMACS literal +i means x_i, -i means NOT x_i; variable i is basis-index bit i-1. E(x) counts unsatisfied original clauses, including repeated clauses with their original multiplicity. Repeated identical literals within a clause do not change its truth value; opposite literals make that clause tautological with zero violation. Empty clauses violate every assignment.

The journal circuit starts in |+>^20. At each layer in stored array order, apply exp(-i gamma_journal E/2), then exp(-i beta X_i/2) for every qubit i. The independently source-grounded coefficient mapping is beta_journal=beta_stored, gamma_journal=-gamma_stored. This mapping is a documented analytic-coefficient inference; absence of the original driver remains an evidence limitation. Do not choose signs or angles by whichever output matches the target.

Energy is computed exactly with uint32 assignment indices and int32 counts. Grouped bitmask predicates preserve the truth function and original clause multiplicity; no approximate Hamiltonian or Pauli-expansion truncation occurs. Complex128 statevectors evolve without normalization corrections. Phase values are computed by an energy-level lookup; this computes the same diagonal operator, not a fitted phase approximation.

## Numerical and resource bounds

- Source probability comparison: absolute difference <= 1e-8 + 1e-6*abs(source probability). This is a pragmatic archival numerical tolerance, not a rigorous error theorem.
- Every layer must have norm-squared drift <=1e-10; stop on violation, never renormalize.
- Independent dense small-circuit check tolerance is 1e-12 maximum amplitude difference.
- One local process; numerical library threads forced to one. The paired target calculation has a 120-second wall-clock cap and 512-MiB peak-working-set cap. Process memory and elapsed time are checked during energy construction and after each mixer bit.
- n20 statevector is 16 MiB; indices and energy use 4 MiB each. Mixer scratch and temporaries plus phase lookup keep anticipated numerical arrays comfortably below the cap. Budget monitoring, rather than an assumed workstation speed, determines whether the pair can finish. A cap failure is an incomplete run, not permission to silently increase it.
- Only this paired target run is allowed. No sign search, angle retraining, alternative formula, additional size/depth or noise/hardware model after a discrepancy.

## Outcome-independent implementation checks

[Replay script](2026-09-11-qaoa-source-replay.py) preflight SHA256-LF `f6dc1da104221fc6ccfc41a5a55e439ac91d087c716ab56fa2aaeeab948d0805`. SHA256-LF means SHA256 of file bytes after CRLF-to-LF replacement; no other byte transformation. This semantic line-ending pin remains stable across Git checkout normalization. Formula and execution-manifest hashes, if those inputs become available, remain exact raw-byte hashes recorded at that later freeze.

Synthetic tests passed without the actual formula; recovery remains unresolved: signed/repeated/tautological/empty clauses against literal evaluation; each bit's mixer action against an independent basis permutation; a three-qubit multi-layer circuit against a dense Kronecker reference; zero-beta/zero-gamma uniform probabilities; one-qubit analytic sign examples; norm preservation; Windows process-memory monitoring. These synthetic checks test the implementation, not the research hypothesis.

After formula recovery but before target evolution, independently evaluate 66 fixed assignment indices directly against original literals and compare integer energy. Recompute K exactly from the energy vector and require agreement with the archived count. This enumeration is validation overhead in the local classical replay; it is not an operation supplied free to the proposed quantum solver.

## Disposition gate

Proceed only after the recovered source formula, normalization and arrays are independently reviewable and the final manifest is frozen. On match, propose a scoped clean logical-cost comparison of these specified circuits, charging preparation/inverse, oracle, reflection, verification and full fallback. On mismatch, report the fixed convention/provenance discrepancy without tuning it away. If the formula cannot be recovered, record the exact source-data gap and do not execute a substitute target.

This preflight makes no general SAT, P=NP, ensemble replication, physical-resource or quantum-advantage claim.


