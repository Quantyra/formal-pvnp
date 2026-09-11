# S3047: fixed-batch quantum SAT cost screen

2026-09-11. S3047 / E014 / E004. **Completed: 7 SAT and 9 UNSAT among all 16 frozen formulas; 14 ideal QAOA evolutions.** The quantum preparation raises success substantially on several cases, but these results establish conditional cost requirements, not an implemented quantum advantage.

All seeds 20260912 through 20260927 were frozen before exact solution counts or overlaps were inspected. Each independently generated n=16, k=8 formula uses m~Poisson(176.54n), uniformly sampled signed literals with replacement, retaining duplicate literals and tautologies. Every formula remains in the saved JSONL. The historical UNSAT seed 20260911 is excluded. Published fixed p14/p60 angles and the preregistered paper-defined convention were used without tuning; this is an independent experiment, not the blocked S3045 source-formula replay.

## Actual outcomes

In ascending seed order, exact K is `[1,0,0,0,5,1,0,0,1,0,1,0,3,0,0,1]`. Thus the retained UNSAT seeds are 20260913, 20260914, 20260915, 20260918, 20260919, 20260921, 20260923, 20260925 and 20260926. No state evolution or finite witness-finding cost is assigned to those nine cases.

The table reports every SAT case. Success is the total ideal measurement probability of satisfying assignments. The final two columns are conditional upper limits on one QAOA layer's cost, expressed relative to R, under the frozen central scenario H=V=0.1R.

| Seed | K | p14 success | p60 success | p14 maximum L/R | p60 maximum L/R |
|---|---:|---:|---:|---:|---:|
| 20260912 | 1 | 0.1329648884 | 0.7042912480 | 4.045585 | 2.479335 |
| 20260916 | 5 | 0.0929708475 | 0.3993745735 | 1.408799 | 0.624505 |
| 20260917 | 1 | 0.1103583567 | 0.4128648270 | 3.604703 | 1.452039 |
| 20260920 | 1 | 0.2607425611 | 0.7681993329 | 4.995591 | 2.704615 |
| 20260922 | 1 | 0.0099267491 | 0.0459376318 | 1.048100 | 0.539746 |
| 20260924 | 3 | 0.1967924435 | 0.6623239228 | 2.763762 | 1.342437 |
| 20260927 | 1 | 0.0085730006 | 0.0052912775 | 0.973076 | 0.175583 |

SAT-conditioned p14 success has mean 0.116047, median 0.110358 and range 0.008573 to 0.260743. For p60 these are 0.428326, 0.412865 and 0.005291 to 0.768199. The deeper preparation improves overlap on six of seven SAT cases and worsens it on one. These are descriptive results for this fixed batch, with no population or significance claim.

## What the cost limits mean

H is uniform state preparation, L is one full QAOA layer, R includes the complete satisfying-state marking and zero-state reflection with their uncomputation, and V is final verification/reset. A preparation costs A=H+pL; its inverse is charged at the same cost. At j amplification iterations, the trial costs `(1+2j)A+jR+V`, with success `sin^2((2j+1)asin(sqrt(a)))`. Expected independent-restart cost is trial cost divided by success.

The uniform comparator uses its actual g=K/65536 and minimizes the same objective globally over nonnegative integer j. An incumbent-bound stopping rule proves that later iterations cannot improve the minimum; no arbitrary 32-iteration cap is used. In the central scenario its optimal j is 149 for K=1, 85 for K=3 and 66 for K=5.

For each preparation, the threshold is the largest L/R permitting some j to beat that optimized uniform cost. For example, seed 20260927 permits p60 only if one layer costs less than approximately 0.176 times R under H=V=0.1R. A layer cost above that threshold cannot beat this comparator within this model. At the threshold the costs tie. A positive threshold does not establish that a compiled circuit meets it.

All seven SAT cases have positive thresholds in each frozen scenario (zero nonpositive cases, denominator seven each). Their min/median/max are:

| H/R = V/R | p14 L/R min / median / max | p60 L/R min / median / max |
|---:|---|---|
| 0.01 | 0.827087 / 2.348664 / 4.245599 | 0.149257 / 1.141597 / 2.299147 |
| 0.1 | 0.973076 / 2.763762 / 4.995591 | 0.175583 / 1.342437 / 2.704615 |
| 1 | 2.432942 / 6.914300 / 12.495406 | 0.439029 / 3.350632 / 6.759229 |

In every central-scenario case p14 tolerates a higher per-layer cost than p60, even though p60 usually has higher success. This illustrates why overlap alone cannot decide algorithm cost. These ratios are hypothetical scenarios, not measured gate decompositions. Preparation training and compilation are treated as offline/amortized. Exact enumeration and known-a iteration choice are diagnostics; their costs are not a claim about an executable unknown-a solver. There is no complete SAT/UNSAT decision-runtime comparison, CPU-versus-gate comparison, fault-tolerant estimate or classical advantage claim here.

## Verification and reproducibility

The complete run took 18.334 seconds, including the symbolic diagnostics, with peak working set 66,056,192 bytes. All 16 IDs completed under the frozen 600-second total, 120-second pair and 512-MiB single-thread limits. Maximum norm-squared drift was below 1.044e-14; no renormalization or missing-result replacement occurred.

The independent reviewer reproduced all seeded clauses and all exact K counts using direct-literal enumeration, all 21 uniform optima and 42 thresholds with separate exhaustive grids, and the threshold inequalities on both sides. An independent XOR-permutation mixer replay of the first SAT formula matched p14/p60 success within 2.8e-17 and 1.1e-16. See the separate review for its final disposition.

Inputs were frozen before outcomes: manifest SHA256-LF `778db8e233dda99e84276ec355e38bad74d1a1485da7500b4dcb518c403cd6f8`; formula JSONL SHA256-LF `9c6d17cd696213f800f09d827ed968a904e9225fcf12776bf04b0d85c4b66db1`. SHA256-LF normalizes CRLF to LF before hashing. The manifest pins code, canonical per-formula JSON hashes, complete angles and conventions. Full precision results, timings and cost details are in the results JSON.

Artifacts: [preregistration](2026-09-11-qaoa-fixed-batch-preregistration.md), [manifest](2026-09-11-qaoa-fixed-batch-manifest.json), [all formulas](2026-09-11-qaoa-fixed-batch-formulas.jsonl), [runner](2026-09-11-qaoa-fixed-batch.py), [results](2026-09-11-qaoa-fixed-batch-results.json), [independent review](2026-09-11-qaoa-fixed-batch-cost-screen-review.md). The runner reuses the pinned S3045 engine and S3046 cost functions unchanged.

## Disposition

**GO for a scoped logical block-cost audit on these same frozen formulas; stop the present experiment.** Specify one common reversible gate decomposition and charge preparation, inverse, both reflections and verification in the same units, then compare its actual H/R, V/R and L/R with the stored boundaries. Rotation synthesis accuracy and ancilla assumptions must be explicit. This is the remaining discriminating question; another random-data batch is not needed first. No further execution is authorized by this report, and S3045's missing-source-formula blocker remains separate. The evidence does not establish general SAT speedup, scaling, hardware advantage or P=NP.
