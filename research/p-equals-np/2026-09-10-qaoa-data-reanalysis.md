# Published QAOA data reanalysis

2026-09-10. S3044 / E014 / E004. Satellite diagnostic under `INTEGRITY-CLAIMS.md`, following the S3043 cost contract. No quantum circuit, statevector, hardware or SAT-solver experiment.

## Finding and decision

The archived p=60 data reject the predeclared adequacy criterion for replacing mean inverse-root overlap with inverse root of mean overlap: **Jensen ratio 2.6923, formula-bootstrap 95% interval [2.3970, 3.0362]**, wholly above 2. At p=14 the ratio is 1.7237 [1.6281, 1.8378], below that cutoff. These are results for the frozen finite dataset, not a claim about asymptotic scaling, unseen tails or the published crossover. Failure to cross the cutoff at p=14 is not proof of an accurate runtime model.

The deeper circuit gives substantially better typical satisfying overlap. Nevertheless, larger initial success and improved median are insufficient for an end-to-end cost conclusion: preparation is repeated inside amplification, and per-instance tails materially change the averaging. This is a positive quantum mechanism signal with a concrete cost-accounting limitation.

**STOP using inverse-root mean success as the mean amplification-work proxy for this p=60 configuration. GO for one source-angle/circuit replay preflight before logical-cost comparison; do not launch a new paired-ensemble campaign now.** Use the lexicographically first frozen source formula ID `101678_3_1653518225511123992`, at its two recorded depths 14 and 60, without choosing a favorable overlap. Recover its original formula and evaluation driver, validate the archive-angle sign/half-angle mapping against both archived probabilities, and then specify a clean compiled operation-cost model. This replay is the proposed next action, not executed in S3044. A matching replay checks those references only; it does not retroactively prove all null-angle rows used identical arrays.

## Frozen population and data checks

The [selection manifest](2026-09-10-qaoa-selection-manifest.json) froze n=20, k=8, r=176.54, Poisson clause count and all 1,415 source-ID pairs having one p=14 and one p=60 record. The source agent froze metadata at 2026-09-10 23:40:26.252740 UTC before extracting observations. The [selected JSONL](2026-09-10-qaoa-selected-rows.jsonl) has SHA256 `7c28c59a61126be539d7816e587f682551e0611e0673970eb10db848175ce7bc`; manifest SHA256 `129ffdac79d9c71fb4aba130dbac23b755b53cecb7470434985614fc16d1706a`. Data originate in [Boulebnane-Montanaro's public archive](https://doi.org/10.5281/zenodo.7764484); see the source inventory for license and member provenance. No outcome was used to select the subset.

There are 2,830 records, no duplicated formula-depth keys, no missing overlaps/counts, and no zero overlaps. Source-reported K ranges from 1 to 8 and matches across both depths for all pairs. Every archived uniform probability agrees with K/2^20 within relative 1e-12 plus absolute 1e-18 (largest absolute difference 2.372e-20). K is exact enumeration data as reported by the source, not newly enumerated here. Pairing is by identical source instance IDs and metadata; original formula bytes have not been independently compared. Source schema stores K as integer-valued floats; conversion to integer was exact, with fractional/nonfinite values rejected.

These are source-reported SAT-retained evaluation examples at n=20, distinct in size from the reported n=12 training set. No training-ID ledger was independently checked. All selected records have null beta/gamma fields, so the published angle file is not proven to be the actual array for every record. Unconditional UNSAT mass, fixed-clause-count behavior and density transfer to r=176 remain unknown.

## Recomputed overlap statistics

All intervals below resample formulas, not repeated trials. They describe empirical uncertainty within the selected source population, not systematic model error or unobserved rare tails. Intervals are individual 95% intervals, not simultaneous coverage guarantees.

| Statistic | p=14 | p=60 |
|---|---:|---:|
| Formulas | 1,415 | 1,415 |
| Mean a | 0.0315406 | 0.1761391 |
| Median a | 0.0236480 | 0.1120108 |
| 1% overlap quantile | 0.000336287 | 0.000198857 |
| 5% overlap quantile | 0.00154586 | 0.00292956 |
| 10% overlap quantile | 0.00349628 | 0.00749625 |
| E[a^(-1/2)] | 9.70559 | 6.41508 |
| E[a]^(-1/2) | 5.63074 | 2.38272 |
| Jensen ratio, 95% interval | 1.72368 [1.62805, 1.83784] | 2.69234 [2.39703, 3.03617] |
| 99% inverse-root quantile | 54.9008 | 71.8056 |

The p=60 overlap is higher on 92.37% of source-ID pairs. The paired mean difference is 0.144599, bootstrap interval [0.136284, 0.153280]. The deeper circuit's worse 1% overlap quantile and higher 99% inverse-root quantile are **descriptive observations**, not new significance tests or proof of population-tail deterioration. No new primary criterion was selected after seeing these values.

## Exact frozen-prefix outcomes and cost coefficients

This is the same *capped restart prefix* for each preparation, not an optimized complete Grover solver. The largest j is 32, whereas a unique-solution uniform search on 20 variables needs about 804 ideal Grover iterations for its first peak. Thus the large uniform-prefix failure below is expected and is not itself evidence of quantum runtime advantage. Full fallback remains charged.

| Expected prefix quantity | p=14 | p=60 | Uniform, source K |
|---|---:|---:|---:|
| Fresh trials EN | 8.24602 | 5.47151 | 27.88815 |
| Amplification iterations EJ | 8.97474 | 5.46943 | 248.98311 |
| Symmetric preparation/inverse calls EN+2EJ | 26.19551 | 16.41037 | 525.85437 |
| Probability full fallback is needed | 0.00135475 | 0.00181496 | 0.96244794 |

Mean fallback bootstrap intervals are [0.0003923, 0.0026384] at p=14 and [0.0005867, 0.0035066] at p=60. Their observed difference is descriptive; no additional paired significance claim is made.

Under the common-component convention defined below, the exact mean difference between the QAOA prefix-plus-fallback and uniform prefix-plus-fallback is:

    p14: -499.6589 H + 366.7371 L -240.0084 R -19.6421 V -0.961093 F
    p60: -509.4440 H + 984.6223 L -243.5137 R -22.4166 V -0.960633 F

Equivalently, a lower expected cost requires, respectively,

    L < 1.36244 H + 0.654443 R + 0.0535591 V + 0.00262066 F
    L < 0.517400 H + 0.247317 R + 0.0227667 V + 0.000975636 F.

These are symbolic inequalities in one chosen unit with fixed common component costs, including a common fallback budget. They are not numerical advantage claims. Actual per-formula fallback time and circuit cost must be multiplied by each formula's own coefficients before averaging. The larger p=60 overlap permits fewer amplified iterations but also requires more layer applications; the data alone do not select the cheaper depth.

## Reproduction and limitations

Run the [analysis script](2026-09-10-qaoa-data-reanalysis.py) with `--self-test`, the selected JSONL as `--input`, the selection manifest as `--manifest`, and the [results JSON](2026-09-10-qaoa-data-reanalysis.json) as `--output`. NumPy 2.4.4 was used. After the pre-outcome script freeze, only schema/configuration/consistency safeguards, derived cost-coefficient output and compact-manifest output changed: accept finite integer-valued source K floats exactly, verify counts/uniform fields, and clarify source-ID pairing. Selected observations, seeds, primary metrics, quantiles, materiality rule and schedule were unchanged. Independent reviewer reruns are recorded separately.

No source quantum simulation was repeated; the analysis evaluates exact amplification formulas on archived ideal overlaps. It establishes a finite-data averaging penalty, preserves positive typical overlap evidence, and quantifies a specified capped schedule. It does not establish fault-tolerant resources, practical advantage, a complete solver's runtime, p=623/n=179 behavior, SAT in BQP, or P=NP. The local tail question has an informative answer; circuit provenance and charged logical costs are now more decisive than another generic small simulation.

## Pre-outcome methods freeze

At 2026-09-10 23:36:50 UTC, before the analyst received the selected observations, the analysis script SHA256 was `51f468b559e3e02afc2d159cbad13488f3e19315f5f809abaff017a2cf90d425`. The source agent selects the configuration by metadata and records a separate frozen manifest before releasing outcomes. Later changes must be identified as bug fixes or exploratory additions, not silently changed primary methods.

- One source-selected held-out n/configuration; depths are selected by metadata, not probability outcomes.
- Fixed schedule j=0,1,2,4,8,16,32, four fresh attempts each, in that order. Every failed trial resets.
- Formula bootstrap: 2000 resamples, PCG64 seed 3044001+depth; paired resamples use seed 3044002. True formula identity plus configuration is required for pairing. Duplicate identical rows are removed; conflicting duplicate records fail validation.
- Overlap quantiles use linear interpolation. Inverse-root and bootstrap quantiles use inverse empirical CDF to preserve infinities without undefined interpolation.
- Predecessor materiality rule: reject inverse-root-mean success as an adequate proxy for this finite configuration only when the Jensen ratio's 95% formula-bootstrap interval is wholly above 2. Continuous estimates are reported regardless. Paired-depth differences are descriptive, separate from that primary criterion.
- Missing, invalid, zero and omitted data are distinguished. Zero overlap gives infinite inverse-root cost. SAT conditioning cannot reconstruct an omitted UNSAT fraction. No uniform comparator without source-supported exact K.
- Costs remain operation-count vectors or symbolic coefficients: E[attempts] times initial preparation/verification, E[iterations] times (A+A inverse+S_F+S_0), and failure probability times full fallback. No logical-gate/CPU-seconds conversion or end-to-end advantage is assumed.

The [analysis script](2026-09-10-qaoa-data-reanalysis.py) passed synthetic checks for zero and unit overlaps, nonlinear means, duplicate handling, pairing eligibility and missingness before source outcomes were examined. Outcome analysis was performed only after the source freeze and handoff.

## Parametric comparison convention (fixed before outcomes)

For a common symmetric preparation cost A, iteration-oracle/reflection cost R=S_F+S_0, verification cost V and complete-fallback cost F, the scheduled cost vector corresponds to `(EN+2EJ)A + EJ*R + EN*V + q*F`. Actual hardware may have asymmetric preparation/inverse costs; retain the unsimplified expression then. If QAOA preparation is H+pL, with H uniform preparation and L one QAOA layer, its exact mean scheduled cost relative to uniform is

    [EN_Q+2EJ_Q-EN_G-2EJ_G] H + p[EN_Q+2EJ_Q] L
      + [EJ_Q-EJ_G] R + [EN_Q-EN_G] V + [q_Q-q_G] F.

This expression uses common fixed component costs across the chosen configuration; varying per-formula costs require averaging their products with each formula's coefficients. A negative value gives a lower expected cost only for the explicitly chosen common-unit component costs and complete fallback. Without them, report the coefficients and a symbolic threshold for L; do not assert end-to-end advantage. In particular source CPU timings cannot supply F in logical gate units.
