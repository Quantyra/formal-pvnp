# Fixed-formula source recovery

2026-09-11. S3045 / E014 / E004, following [the frozen S3044 inventory](2026-09-10-qaoa-data-inventory.md). This is source recovery only; no selected-formula simulation or parameter search is performed.

## Fixed identity and recovered arrays

The target remains the lexicographically first frozen formula ID, `101678_3_1653518225511123992`. Its benchmark references are exactly `instance_description_101678_3_1653518225511123992.json` and `instance_enumeration_101678_3_1653518225511123992`. These are source references, not proof that the files are in the published archive. No replacement formula is permitted by this checkpoint.

The complete published beta/gamma arrays at dictionary key `(8,176.54)`, depths 14 and 60, are recovered in [the angle artifact](2026-09-11-qaoa-recovered-angles.json). Extraction used Python AST literal interpretation of the dictionary and `np.array` literals; it did not execute the source module, train angles or evaluate a quantum circuit. Both arrays have exactly the declared depth. Stored order, floating-point values and signs are preserved.

Source: Phasecraft Ltd., [optimal_angles.py at commit 5c7ee19db385e8a2bad075206e6483cbab43eadb](https://github.com/PhaseCraft/qaoa_ksat_paper_data/blob/5c7ee19db385e8a2bad075206e6483cbab43eadb/lib/optimal_angles.py), lines 164–233. File SHA256 `a25049edf7c11dd3a69ee1e36a01bde851fbd86cdf8cf5394cdc8d4fde123821`. The source comment specifies optimization on 100 averaged size-12 instances. Copyright 2023 Phasecraft Ltd., Apache License 2.0; [license](https://github.com/PhaseCraft/qaoa_ksat_paper_data/blob/5c7ee19db385e8a2bad075206e6483cbab43eadb/LICENSE). The artifact is a selected, reformatted subset with provenance metadata added.

The canonical array hash is `7d49c1c721937c876896f067cddb6803e1c793df43fe55d52aba868d5616e8f8`: SHA256 of UTF-8 `json.dumps(arrays, sort_keys=True, separators=(',', ':'))`, without newline. This semantic pin is independent of checkout line endings.

## Driver and convention evidence

The [complete GitHub tree at the pinned commit](https://api.github.com/repos/PhaseCraft/qaoa_ksat_paper_data/git/trees/5c7ee19db385e8a2bad075206e6483cbab43eadb?recursive=1) contains README/license, figures, the plotting notebook and four library modules: `analysis_helpers.py`, `exact_ksat.py`, `generalized_binomial_sum.py`, `optimal_angles.py`. It contains no original instance-generation or state-vector evaluation driver.

`exact_ksat.py` is a multinomial-sum helper, not a solver or literal encoder (SHA256 `4ef0c3df3bed92c2ccdf67386565fdf6fd5c1a0f123693318dbb15ba81e14f90`). `generalized_binomial_sum.py` evaluates analytic average-probability expressions (SHA256 `cb24e3684a7adc87146ff1851cd19a07820804d67f3de55b00399bc95ae69db6`). In its lines 73–77, the coefficient vector starts with `exp(+0.5j*gammas)-1`; its beta factors use half angles. The [S3043 audit](2026-09-10-qaoa-full-source-audit.md) compares this expression with the journal convention and infers a gamma sign change. That comparison does **not** establish the missing empirical driver's cost sign, layer order, bit-to-literal mapping, or use of exactly these arrays for the selected row. The row angle fields remain null.

An overlap match must not be used to select a sign, ordering or alternate angle schedule. Formula multiplicities and tautologies must be retained in any later reconstructed cost; absent the actual clause list, they cannot be recovered from n, k, r, solution count or a benchmark ID.

## Scope

The public archive is [Boulebnane and Montanaro, Zenodo 7764484](https://doi.org/10.5281/zenodo.7764484), under CC BY 4.0. Archive SHA256 `ca74650be3a67446b2d017e8d4eae5f6e2bb06a8a494f3c371872b9df61e1859`; it is reused from the external cache, not downloaded again. Filename recovery streams archive members without bulk extraction or executing archive content.

## Completed lookup and decision

**STOP the exact selected-formula replay: the clause-list dependency was not recovered.** The [lookup evidence](2026-09-11-qaoa-source-lookup.json) records the complete 2,033,188-member filename scan, with no member containing the fixed formula ID. All regular files fall into benchmark categories (1,887,082 QAOA, 67,723 WalkSAT, 35,098 Schoning, 35,098 PySAT) plus one `summary.json`. No description/enumeration-named files exist in that listing. The previously complete parsed 8-SAT QAOA inventory has 457,785 rows with the same metrics/reference-only schema, including the selected pair, without inline clauses.

A final consolidated pass checked the sole summary and representative schemas of the other benchmark categories. Those samples contain assignments, trial counts, statistics or instance-file references rather than clauses. This is a sample of those categories, **not** an exhaustive content search for an arbitrarily renamed or hidden formula encoding in every classical record.

The summary is `data/data_save_analytic_compare/summary.json`, raw SHA256 `13b015573881c10fcbba2e48a197074987ab31f12ea2c35f4aa49bcb6b4a63da`. It contains aggregate plot/fit records and arrays, without the fixed formula ID or clause data. Its single `(k=8,r=176.54,p=14)` record and single corresponding p=60 record have arrays exactly equal to the recovered published table. This strengthens the link between the summary dataset and angle table, but does not recover the formula or certify an unavailable original evaluation driver. No new outcome-statistic analysis was performed.

The [Zenodo record API](https://zenodo.org/api/records/7764484) advertises only `data_23032023.tar.gz`; its explicit `sami-b95/qaoa_ksat_paper_data` link resolves to the same PhaseCraft repository. No separate formula download is advertised by these checked source references. The remaining actionable dependency is the exact referenced clause list (and, for original-driver equivalence, its encoding/evaluation conventions). Do not invent or regenerate a replacement from the instance ID.

Lookup canonical evidence SHA256: `671b5ba5ab1352df497480c8a7989cea12af370e0ae113cfb2edbeabd9659652`. Its JSON defines hashing of the `evidence` object with sorted keys, compact separators, ASCII escaping and no newline. This pin and the array semantic pin survive line-ending conversion. No background scan remains running. S3045 remains blocked for the actual formula replay; source recovery and synthetic preflight can be reviewed as completed evidence.

No simulation, favorable-instance replacement, practical-speedup claim or general SAT/P-vs-NP claim follows from recovering published arrays. A missing source dependency is a provenance boundary, not a negative result about the quantum algorithm.
