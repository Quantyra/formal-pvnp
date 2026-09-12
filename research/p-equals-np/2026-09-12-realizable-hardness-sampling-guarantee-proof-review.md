# SamplingGuarantee independent proof-adversarial review

2026-09-12. Reviewer `guarantee_proof_review`, not an author of this increment.
Candidate `00ed4a43d429878f53c27dccf68813255961d36e`; S3130 under open S3126.

**Verdict: GO.** No blocking proof defect found. Both scoped exports independently passed, and all 18 axiom profiles contain exactly the standard three axioms.

## Identity and review scope

Read destination `INTEGRITY-CLAIMS.md`, owning S3130, the planning formal-three-lens protocol, both candidate modules and formalization receipt. No destination AGENTS.md was found by recursive inventory. Independently inspected the imported finite rounding, inverse-CDF, joint event-law, concentration and threshold interfaces. Other complexity/non-claims receipts were inspected but do not substitute for this lens.

Both source files are raw byte-identical to `git show` at the candidate; CRLF-to-LF equality also holds. Each source has zero CRLF sequences. SHA256:

- `lean/PvNP/RealizableHardness/SamplingGuarantee.lean`: `d051a6fdf0eaf06696838e266a340d4616bf4b37dd3594f2015bfbec1b139b76`.
- `lean/PvNP/RealizableHardness/SamplingGuaranteeChecks.lean`: `08effac99e531296d8361e56e4cadbf19b183d3a41a6a5fb77b7e9503f053b97`.

## Adversarial statement and proof audit

1. Input normalization is exactly `cumulative p S = 1` with nonnegative rational masses. It implies S > 0 (`InverseCDFSampler.support_pos`); the empty atom type cannot vacuously satisfy the input. Zero-mass atoms are allowed and the examples include one. Values beyond S are outside this finite law, even though the nonnegativity hypothesis covers all indices. These hypotheses are consistent, as the concrete 1/3, 2/3, 0 law demonstrates.
2. `Good` uses the original rational event sum cast to Real, not the rounded mean. `finiteMean_eq_eventMass` converts Fin S sums and Boolean indicators to the original rational range sum; `roundedMean_error` then imports the proved cumulative-rounding error with exact casts and the positive dyadic denominator. The deterministic error is at most eps/8, with the grid condition actually proved by `precision_bound` for the chosen rational precision.
3. The input probability is uniform on `Fin M -> (Fin b -> Fin 2)`. That seed space is nonempty even for b = 0. `sampleArray_probability` is an arbitrary-Prop joint pushforward from this actual space, proved through coordinate fibre products; the full bad event is transported, not inferred from marginal distributions. The rounded product law is nonnegative and normalized by proved lemmas.
4. The imported two-sided Hoeffding bound has coefficient `2 * exp(-2*M*delta^2)`. The assignment union multiplies by exactly 2^N. Taking delta = eps/8 and the triangle inequality yields failure at total error at least eps/4. Negating the universal strict Good event produces exactly the existential non-strict failure event. Normalized probability complement then gives strict error below eps/4 with the asserted success probability. No favorable event, independence, or tail probability is assumed.
5. General-count success theorems derive M > 0 from positive epsilon and the positive log-6 threshold. The learning threshold dominates it. Thus empirical division never relies on the zero-trial convention. N = 0 retains its one empty assignment and factor 1; the explicit zero-variable example exercises this case. No N > 0 assumption is hidden.
6. Exact thresholds are `(N*log 2 + log 6)/(2*(eps/8)^2)` and the log-12 variant. Their failure budgets are at most 1/3 and 1/6, yielding at least 2/3 and 5/6. The chosen counts are the imported `2^clog_2(ceil threshold)` definitions, with their lower bounds discharged. These are least qualifying powers of two, not least unrestricted natural counts. No eps <= 1 premise is required for these probability statements; that premise belongs to separate numerical size bounds.
7. Checks cover the original mean, assignment-dependent event, both chosen counts, explicit M = 16384 and b = 8, and N = 0. The concrete count example proves threshold domination using a numeric upper bound; it does not assert this explicit count equals the least dyadic count.

No source sorry/admit, custom axiom declaration, unsafe/native_decide escape, or option weakening was found in either scoped module. There is no HIGH vacuity, contradictory-hypothesis, quantifier, or statement mismatch found by inspection.

## Independent verification

After an explicit exclusive-slot grant, independently ran from the repository root with `LEAN_NUM_THREADS=1`, cached Lean 4.13.0, a fresh no-competing-Lean check and 512 MiB free-capacity guard before each launch:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/SamplingGuarantee.olean lean/PvNP/RealizableHardness/SamplingGuarantee.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/SamplingGuaranteeChecks.olean lean/PvNP/RealizableHardness/SamplingGuaranteeChecks.lean
```

- Main session **19510: exit 0**, no warnings or Lean output. Prelaunch free capacity 4,739,268,608 bytes.
- Checks session **93147: exit 0**, no warnings; all **18 profiles** independently observed with exactly `propext`, `Classical.choice`, `Quot.sound`. Prelaunch free capacity 4,700,082,176 bytes. Observed in-flight capacity remained above 4.65 GB.

The 18 profiles are `finiteMean_eq_eventMass`, `roundedLaw_nonneg`, `roundedLaw_sum`, `roundedMean_error`, `seed_failure_bound`, `seed_success_bound`, `good_probability_of_threshold`, `good_probability_of_learningThreshold`, `precision_bound`, `chosen_good_probability`, `chosen_learning_good_probability`, `atoms_nonneg`, `atoms_normalized`, `original_mean_example`, `chosen_base_example`, `chosen_learning_example`, `explicit_count_example`, and `zero_variable_example`, all in `PvNP.RealizableHardness.SamplingGuarantee`.

No failed historical handle was restarted; no cache download, dependency build or source change occurred. A first source-search invocation used an unsupported literal wildcard path and returned a filename error; the corrected explicit-file scan succeeded with no forbidden matches. This read-only search error is unrelated to the two successful Lean exports.

## Acceptance boundary

This is a finite semantic sampling guarantee. The real-log/ceil counts and noncomputable Good tests do not establish an executable real-comparison procedure, polynomial bit cost, support enumeration, or encoded runtime. The 5/6 result is a sampling probability only; it does not prove the learning transfer. Formula promises, repair/rounding assembly, upstream PCP/NP-hardness, asymptotic composition and full S3130/S3126 completion remain separate. In particular this review does not certify the distinct unreviewed SamplingFormulaPromises or ComputableSampleCount changes present in the worktree.

Only this review receipt was written during the independent lens. Subsequent evidence integration is separately authorized by the orchestrator; no source or publication changes are included.
