# Independent published-data reanalysis review

2026-09-10. S3044 / E014 / E004; predecessor S3043. Under `INTEGRITY-CLAIMS.md`.

This review uses **one independent reviewer applying three lenses**: source/proof, complexity and non-claims. It is not a three-person formal theorem closeout. No quantum simulation, hardware, publication or commit is part of this review.

## Review criteria fixed before outcomes

The single configuration must be frozen from metadata before success distributions are inspected. Record archive checksum, exact member selection, actual depth, density, size, training/evaluation provenance and formula identity. A loader's implicit depth default cannot replace missing metadata. Document pairing and repeated rows before deciding statistical sample size.

Missing probability is not zero. Probability zero remains zero, with infinite inverse-square-root cost; positive-only summaries must state excluded counts. Missing solution count disables a uniform-search comparison unless an independent source supplies it. SAT-conditioned records do not identify the population UNSAT fraction. Training samples cannot be described as held-out evidence without provenance.

Statistical resampling must use independent formulas as units, preserving paired observations and cost/probability covariance. Duplicate measurements of one formula do not enlarge the number of independent formulas. Finite-sample bootstrap intervals describe the observed distribution, not unobserved rare tails or extrapolated sizes. Report raw counts and the estimator/quantile convention.

For frozen trials with iteration counts j_i, success is s_i(a)=sin^2((2*j_i+1)*asin(sqrt(a))). The no-witness probability is product_i(1-s_i); expected resource counts weight trial i by the probability previous trials failed. A=0 must exhaust the entire schedule; a=1 must succeed immediately if the first trial has j=0. Preparation/inverse, checking, reset and reflections must be charged in named units. An incomplete finite schedule supplies UNKNOWN on failure unless its separate fallback is charged.

## Verification evidence

The reviewer inspected the metadata-only inventory and selection scripts before viewing probabilities. Selection froze at **2026-09-10 23:40:26.252740 UTC**, followed by extraction at **23:40:30.365156 UTC**. Configuration: n=20, k=8, r=176.54, source-labelled Poisson ensemble, 1,415 common source formula IDs at explicit p=14 and p=60. The rule selected the largest eligible size with at least 30 unique pairs, without outcome fields.

- Archive SHA256 independently rehashed: `ca74650be3a67446b2d017e8d4eae5f6e2bb06a8a494f3c371872b9df61e1859`.
- Frozen manifest SHA256: `129ffdac79d9c71fb4aba130dbac23b755b53cecb7470434985614fc16d1706a`.
- Selected JSONL SHA256: `7c28c59a61126be539d7816e587f682551e0611e0673970eb10db848175ce7bc`.

The complete analysis was rerun independently against the frozen input and manifest, producing JSON identical to the analyst output. A separate stdlib calculation verified means, inverse-root means and Jensen ratios. Synthetic checks passed zero/unit overlap, duplicate conflicts, missing values/counts and pairing gates. An independent cumulative-product calculation checked finite-schedule coefficients at a=0.2, and a=0.25 with one iteration gives success exactly 1.

Integer-valued float K conversion is a disclosed schema repair, not rounding or selection. All source counts are positive in the selected rows; paired counts agree. The largest absolute difference between source uniform probability and K/2^20 is 2.3717e-20. This verifies internal count consistency, not independent SAT enumeration. Source row angles are null; explicit p is present. Training separation is source-reported size-12 training versus size-20 evaluation, not an independently audited training-ID ledger.

| Depth | Mean overlap | Mean inverse square root | Jensen ratio | 95% formula-bootstrap interval |
|---|---:|---:|---:|---:|
| 14 | 0.0315406 | 9.70559 | 1.72368 | [1.62805, 1.83784] |
| 60 | 0.176139 | 6.41508 | 2.69234 | [2.39703, 3.03617] |

Both have 1,415 observations and no recorded zero or missing overlap. Depth 60 meets the frozen ratio-above-two materiality criterion; depth 14 does not. The conclusion is restricted to the observed conditional distribution and estimator. It does not establish unseen-tail bounds or a new asymptotic exponent.

The identical uniform-prefix control is capped at j=32 and fails on about 96.24% of these formulas. It is not an optimized full Grover comparison: for n=20 and K=1 the familiar ideal iteration scale is about 804. Interpret finite-prefix coefficients with their charged fallback, never as demonstrated superiority to the best complete quantum baseline. The parametric preparation/layer-cost comparison is valid in common units; no numeric hardware conversion is supplied.

Direct archive streaming independently verified both depth records for the lexicographically first frozen source ID `101678_3_1653518225511123992`. Exact source IDs, n, explicit p, overlap, K and uniform probability match the selected JSONL. Both raw rows have null angle arrays. Raw member SHA256 values:

- p=14 benchmark `9070_6_1654129464552933116`: `d6ab186c12ab293d5f211847ce1adbb7a468933432034a53ae2762ae5b75dedc`.
- p=60 benchmark `235986_6_1654280649469311247`: `835eb9e54298192b7595cb80d608ebe42b7f8d224e391a6baccc76e39ccb0488`.

The same stream did **not** find the referenced description basename in the benchmark member's own directory. The verification script's final assertion expected three members and received the two benchmark members; their individual comparisons passed. This is an unresolved formula-location reference, not a mismatch in those probability rows. Original formula bytes have therefore not been verified by this reviewer. S3045 must recover the actual formula path before attempting replay; do not synthesize a replacement formula.

Final analyst narrative was reviewed: it separates descriptive tail/fallback observations, individual bootstrap intervals, source-reported conditioning and null-angle limits, and the short uniform-prefix caveat. Derived symbolic coefficients follow the previously fixed common-unit convention. The orchestrator reran the final compact output after disclosed schema/formatting and coefficient additions, with byte-identical JSON SHA256 `a08ce52df32eed3c181207309d38fe461322d8bd21ef086c6802a8e90bacfe43`. No primary sample, statistic, seed or schedule was changed after outcomes.

Closeout addition: the reviewer inspected [selection replay script](2026-09-10-qaoa-replay-selection.py). It checks archive size/hash, manifest hash, unique selected members, metadata, raw-member hashes and exact output checksum; it never reselects observations or extracts archive paths. The source author reports successful replay of all 2,830 rows to the frozen JSONL hash. The sorted raw-member checksum aggregate is `a73966d95f3822fc377f4ed1693bec09231e4ee362c1305c2f613d47ced381c5`. This is author-run full replay evidence alongside the independent two-member check above; no redundant full scan was performed by this reviewer. Explicit CRLF serialization preserves the original pinned bytes across platforms. Repository byte-preservation/index checks are owned by the orchestrator and do not alter scientific criteria or observations.

## Disposition

**GO for the completed S3044 finite-data result. STOP the inverse-root-of-mean proxy under the frozen p=60 materiality criterion. GO only for S3045's fixed-source replay preflight; HOLD a new paired-ensemble simulation.**

| Lens | Verdict | Exact scope |
|---|---|---|
| Source/proof | GO for published-probability reanalysis | Archive pin, frozen selection, exact subset row checks and full statistic rerun support the result. Formula bytes and per-row angles remain unverified. |
| Complexity | GO for finite statistics and symbolic prefix costs | Jensen penalty is measured; neither realistic gate costs nor an optimized complete-solver comparison has been established. |
| Non-claims | GO with stated limits | No unseen-tail bound, physical advantage, crossover reproduction, all-instance quantum algorithm or P=NP result. |

The next useful uncertainty is whether the archived formula, source driver and published angle convention reproduce **both** first-ID overlaps. Freeze those recovered inputs, numeric tolerance and runtime/memory cap before that one replay. Failure to recover the formula or to reconcile conventions is a STOP for execution, with exact provenance debt recorded. Even a match would validate only that reference example, not every row or the large-depth resource extrapolation.
