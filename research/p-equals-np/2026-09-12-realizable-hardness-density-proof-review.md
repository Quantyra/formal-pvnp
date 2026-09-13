# Independent proof-adversarial and build review: actual Gaussian ratio and posterior density

Story S3133, full-goal parent S3126; 2026-09-12.
Frozen candidate: `ae1bc948df7e06f8c754f5e05e8bea6cddfcebd8`.

Verdict: **GO-WITH-NOTES**. Independent batch 12578 completed with actual exit code 0 for all four modules, 23 ordered standard-only axiom profiles, and all 14 examples. No blocking proof issue was found. This is a bounded component review, not full hardness or learning certification.

## Scope and proof inspection

Reviewed GaussianRatio, GaussianRatioChecks, PosteriorDensity and PosteriorDensityChecks in the Lean 4.34.0-rc2 companion. Prior accepted finite and geometry modules supply the actual finite distributions and subspace counts. The original source draft banners are conservative and stale relative to author evidence; they do not claim verification.

The normalized independent-frame product is bounded below by one half under one spare dimension using the elementary product-versus-sum inequality and a geometric sum. Its upper bound handles out-of-range dimensions by an actual zero factor, rather than treating every potentially negative factor as nonnegative. Natural subtraction in the cast frame product is justified by the dimension order. Actual frame/subspace double counting proves gaussian_mul_frame; the Gaussian denominator and diagonal frame factor are proved positive before cancellation. The ratio identity uses m <= n to discharge natural subtraction, and retained dimension identities justify n-m=2D. The derived constant 2 is conservatively weakened to the manuscript constants 4 and 8; no desired ratio bound is a premise.

Ambient advice mass is the inverse cardinality of actual a-dimensional subspaces of the 3J-dimensional coordinate space. The good-marginal assumption gives a strictly positive conditioning event. Incidence fibre positivity is justified by a <= J, which holds uniformly across all retained draws. Both contained and noncontained advice cases are handled. The density proof uses the actual Bayes kernel ratio and the proved Gaussian estimate; no count or density inequality is supplied as an assumption.

The quotient density theorem explicitly requires a positive prior atom. The mass domination theorem separately handles a zero prior atom and requires beta in [0,1] to derive nonnegativity for remaining atoms. Thus summing events does not divide by zero. The event cutoff partitions at D <= T versus T < D. It retains the actual conditional tail mass as a summand. The fixed-subspace theorem imports the unconditional codimension-failure bound and multiplies by a nonnegative density constant. W can depend on previously selected Q but is a single subspace before d is sampled; no conditional independence or union over all W is used.

The spare-dimension hypothesis a+1 <= J excludes J=0 from the density statement intentionally. Empty ambient normalization, a=0, diagonal and out-of-range Gaussian values, noncontained advice, null conditioning and zero-prior cases are covered among the 14 examples. These checks substantiate component edge behavior, not the asymptotic parameter selection or the full theorem.

## Independent verification method

The independent output root is `.lake/build/density-independent-review-20260912/lib/lean`. Exactly 39 ordinary Lean outputs from the accepted independent 33-module baseline and geometry six-module review are copied from the geometry independent root after matching each SHA256 to its prior independent receipt. No author ratio/density artifact is copied. The author `.lake/build/lib/lean` path and both previous review output roots are excluded from LEAN_PATH; the new root supplies the complete PvNP namespace, followed only by pinned dependency and core roots. All eleven dependency HEADs were rechecked against prior verified pins; the manifest and compiler version match.

The runner compares each source byte-for-byte against the frozen Git candidate, exports each of the four modules, preserves raw logs and actual exit codes before decoding, checks every selected axiom query in source order, and checks all profiles against propext/Classical.choice/Quot.sound. It also counts 14 example declarations. The one-thread runner requires 768 MiB free before each export and stops its own process tree if free space drops below 640 MiB. It performs no dependency downloads, source fixes, broad build, or publication.

## Scope limits and remaining work

This review does not discharge the good-marginal exceptional-set probability, conditional tail bound, total-variation proximity, KMS covering, relative-error estimates, specialized PCP/decoder contracts, encoded randomized machine reduction, learning transfer, fixed-L asymptotics, final assembly, or submission-paper reconciliation. These remain in S3131-S3137 and S3128. A standard-only axiom profile for these components does not prove those remaining hypotheses or goals.

## Export evidence

| Module | Exit | Selected profiles | Examples | Source SHA256 |
|---|---:|---:|---:|---|
| GaussianRatio | 0 | 0 | 0 | `64cfc97ec8af757697d3cca47ecea4c8942b966fdd1d10180e77c3385faaf0d8` |
| GaussianRatioChecks | 0 | 12 | 7 | `c81b2b5f38fe29d9e50bf6e37f599a58d18d10b4861f520c9cff943cae846252` |
| PosteriorDensity | 0 | 0 | 0 | `7f730e6185224981b8e32b98406d8678ac89912d993dd46e3045305804f94ada` |
| PosteriorDensityChecks | 0 | 11 | 7 | `b0749bbeb21d59dbfd7ada467e2b372757fd4c04c330d403b5046e1307d5976c` |

The companion JSON contains exact commands, environment, embedded raw logs, source/output/log hashes, copied dependency provenance, runner source, and compiler pins. All recorded current source, raw log and output bytes were rehashed after completion. The 23 profiles inspect transitive dependencies of the selected declarations. This is not a claim to rebuild every external dependency from source in this run.

Remaining to-do: other two independent review lenses and root acceptance for this bounded increment; the full-goal dependencies listed above remain open. No source, configuration, aggregate, map, paper or public release changed.
