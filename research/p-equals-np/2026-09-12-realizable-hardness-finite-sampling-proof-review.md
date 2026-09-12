ï»¿# Finite sampling: independent proof-adversarial review

2026-09-12. Reviewer: `sampling_proof_review`, independently assigned by the root orchestrator. S3130 under full S3126. Verdict: **GO** for the bounded cumulative-rounding/product-law/list-indexing increment. No actionable proof-adversarial findings.

## Frozen scope and verification

Reviewed candidate `62064d9e9699c0337563a31ea205f6e5195fcbc2`, including the actual definitions and proofs in both modules and `research/p-equals-np/2026-09-12-realizable-hardness-finite-sampling-formalization.md`. Read the planning formal-three-lens protocol and destination `INTEGRITY-CLAIMS.md`; no destination AGENTS.md exists. Compared the complete relevant argument at `../realizable-cmmsa-hardness/MANUSCRIPT.md`, lines 647-693, whose observed SHA256 is `ff00997c8c243e88982c41b0b0e24faaaafe36cec6f1903824599dc242538686`.

The working hashes matched the author handoff, and `git diff` against the frozen commit on these two paths was empty. The main file has working CRLF hash `817347b74cd9f0ad17b5249fcbd03444e9927c492c7e54b5b8e127cf1112b7a6` and committed LF hash `7b1cf53b512e705d08d4eb20a1db69b4015d5fb561f5495e11316c0cfc49ab57`; root independently verified CRLF-to-LF normalized equality. This is newline normalization, not a proof difference. Checks has identical Git and working hash. Independently observed working hashes:

- `lean/PvNP/RealizableHardness/FiniteSampling.lean`: `817347b74cd9f0ad17b5249fcbd03444e9927c492c7e54b5b8e127cf1112b7a6`.
- `lean/PvNP/RealizableHardness/FiniteSamplingChecks.lean`: `9281576cae367164b01ec09649245ab7e3d91b17e51c531e5be591661a56461b`.

Independently reran, sequentially, the actual scoped exports without dependency rebuilding:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/FiniteSampling.olean lean/PvNP/RealizableHardness/FiniteSampling.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/FiniteSamplingChecks.olean lean/PvNP/RealizableHardness/FiniteSamplingChecks.lean
```

Main session 26329 exited 0 without warnings or output. Checks session 46545 exited 0 without warnings and printed all 19 requested axiom profiles. Every profile was exactly `[propext, Classical.choice, Quot.sound]`; no `sorryAx`, native-evaluation dependency or additional axiom occurred. This was actual new kernel elaboration, not a source scan or reliance on the author's build report.

Audited names in namespace `PvNP.RealizableHardness.FiniteSampling`: `cumulative_error`, `mass_nonneg`, `mass_error`, `mass_sum`, `event_error`, `event_error_of_precision`, `trialMass_nonneg`, `trialMass_sum`, `trial_event_factorization`, `assignment_count`, `listSampler_exact`, `thirds_nonneg`, `thirds_normalized`, `fractional_cut_example`, `fractional_mass_example`, `rounded_distribution_example`, `uniform_event_example`, `independent_two_trial_example`, `one_bit_sampler_example`.

## Adversarial statement checks

- The original nonnegative rational weights and support endpoint normalization are explicit. Floor error is proved using a genuinely positive denominator. Ordered cumulative cuts give nonnegative atom masses; telescoping gives exact normalization on the finite support. No positivity of every rounded atom is required or falsely asserted. The mass function need not vanish past S because the probability law here is restricted to the S atoms.
- Every Boolean event, rather than a selected event or an assumed distance bound, has error at most S/D. The dyadic precision condition correctly implies epsilon/8. Positivity/normalization can be combined with this inequality; the event theorem does not silently assert normalization without its separate premises.
- The product law is the actual product of coordinate masses. Its sum and every coordinate cylinder factorization are proved by finite sum/product interchange. Independence is not an assumed field. Zero trials correctly produce the empty-product unit law; no empty-type premise hides the intended nonempty applications.
- Assignment counting refers to the actual type `Fin N -> Bool`, with cardinality exactly 2^N, including the correct N=0 case. It does not itself prove a concentration/union-bound statement.
- The list sampler uses the actual equivalence from binary vectors to `Fin (2^b)`. Inspected the pinned mathlib definition in `Mathlib/Algebra/BigOperators/Fin.lean`: forward positional sum and inverse division/modulo are explicit. Reindexing proves equality of averages for every event; repeated entries retain their indexed multiplicity. This remains meaningful at b=0.
- Concrete fractional thirds, normalized rounded masses, a two-trial event of mass 1/9 and a one-bit event of mass 1/2 provide nondegenerate checks. No unproved concentration, hardness or sampler-realization contract appears among the theorem assumptions.

## Mandatory remaining boundary

GO applies only to these proved local statements. As the author receipt explicitly states, the concrete inverse-CDF realization of the rounded distribution is missing; the list-index sampler is a separate later step. Bernoulli concentration, the union bound over all assignments, the least-power-of-two sample-size threshold, the final success probability and YES/NO composition with repair/rounding remain open in this increment. So do actual encodings, bounded-coin generation and polynomial runtime. Neither S3130 nor the full proof-and-paper goal is complete, and no full PCP, NP-hardness or learning-transfer certificate follows from this review.

Reviewer changed only this review receipt; no Lean source, shared ledger, toolchain or other agent's work was edited. No push or release was performed.
