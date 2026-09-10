# Published QAOA data inventory and selection

2026-09-10. S3044 / E014 / E004. Internal public-source inventory, following the [S3043 source audit](2026-09-10-qaoa-full-source-audit.md). This author inspects metadata and prepares data; the separate analyst owns outcome statistics.

## Source and cache boundary

Archive: [Zenodo 7764484](https://doi.org/10.5281/zenodo.7764484), `data_23032023.tar.gz`, 177,713,853 bytes. Downloaded once for this checkpoint and retained in the explicitly named `quantyra-qaoa-source-cache` directory under the operating system temporary directory, outside git. Verified MD5 `c40fb21998acec76f92511a1e86258ed`; SHA256 `ca74650be3a67446b2d017e8d4eae5f6e2bb06a8a494f3c371872b9df61e1859`.

Attribution: Sami Boulebnane and Ashley Montanaro, *Solving boolean satisfiability problems with the quantum approximate optimization algorithm*, DOI **10.5281/zenodo.7764484**. The [record metadata](https://zenodo.org/api/records/7764484), checked 2026-09-10, explicitly lists license `cc-by-4.0` ([Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/)). The selected JSONL is a subset of that archive with fields renamed and rows sorted as documented below; it is not a new simulation. Preserve this attribution and modification notice when redistributing the subset.

The scan streams tar members without extracting archive paths. It parses only matching QAOA benchmark JSON and stores raw records separately from metadata in that cache. No success values, solution counts or outcome summaries are printed or used by this author to choose a configuration. Sorting/selecting uses only source directory, n, k, r, explicit p, source IDs and multiplicities. Hashing raw evidence is integrity checking, not outcome-based selection.

Source plotting repository: [PhaseCraft/qaoa_ksat_paper_data](https://github.com/PhaseCraft/qaoa_ksat_paper_data/tree/5c7ee19db385e8a2bad075206e6483cbab43eadb), commit `5c7ee19db385e8a2bad075206e6483cbab43eadb`. Its notebook loads QAOA records from `data/data_save_analytic_compare`. This directory defines the eligible source population; unrelated local-search, analytic-fit or combined-algorithm records are not mixed into it.

Pinned helper assets in the same external cache:

| File | SHA256 |
|---|---|
| `lib/optimal_angles.py` | `a25049edf7c11dd3a69ee1e36a01bde851fbd86cdf8cf5394cdc8d4fde123821` |
| `lib/analysis_helpers.py` | `1054446a48e99bbecc72d89df000bb1616ed36cba77ead07119851cedaf342af` |
| `notebooks/paper_graphs.ipynb` | `5866e6101278d6baaca89e5226bebb0da930d9f57e64cf6c75591916520bbd04` |
| `README.md` | `3e390fd8d23ea9362425ad9cc4463e43e6750c2e28e476a06548aa172eb8720b` |

## Schema and provenance limits

Each eligible row identifies `n`, `k`, `r`, `p`, `instance_id`, `benchmark_id`, `instance_description_file`, and `instance_enumeration_file`. Statistical fields are `eval_qaoa_success_probability`, `num_valid_assignments`, and `random_assignment_success_probability`. Sample field-type inspection found probabilities and solution count serialized as JSON floating-point numbers; the analyst must require the count to be integer-valued before interpreting it as K. There are explicit `betas` and `gammas` keys, but the inspected benchmark records contain nulls. A shared hash of those null values is not an angle fingerprint.

The source loader maps missing p to 7 and deletes beta/gamma fields. This audit does neither. Only explicit p is eligible; unknown depth is a metadata exclusion. The source-provided `num_valid_assignments` is associated with an enumeration-file reference. It may be used as a source-reported count only with integer/range validation, cross-depth agreement, and agreement of `random_assignment_success_probability` with K/2^n. The present author does not independently enumerate assignments or filter by K.

Publication provenance is Poisson(r*n) clause count, k literals drawn with replacement and random signs; the k=8 source density is 176.54. The 2024 paper describes SAT-conditioned evaluation and training on 100 size-12 formulas. Selecting n>12 separates formula size from that stated training set, but the archive has no individually validated training-ID ledger in this audit. Describe these as source-reported evaluation data at a size distinct from training, not as independently audited absence of all tuning leakage.

Null row angles also limit interpretation: the reanalysis concerns the published depth-labelled probabilities, not execution of a newly reconstructed circuit with certified identical angles. The separately pinned angle table and sign/half-angle mapping in S3043 are contextual evidence. They are not silently attached as a proved row-level provenance claim.

## Selection and handoff

The full stream completed: 2,033,188 archive members, including 457,785 parsed k=8 QAOA benchmark records. All 272 JSON parse errors were under paths labelled `instances_2_sat`; none were in the selected k=8 population. The eligible source population contains sizes 12 through 20 and explicit depths 1–10, 14, 30 and 60. This is an inventory of QAOA records; unrelated classical data were not statistically analyzed.

The metadata-only comparison of the two candidate depths was:

| n | Unique p=14 IDs | Unique p=60 IDs | Common unique IDs | Duplicate keys |
|---|---:|---:|---:|---:|
| 20 | 1,415 | 1,415 | 1,415 | 0 |
| 19 | 1,490 | 1,490 | 1,490 | 0 |
| 18 | 1,723 | 1,723 | 1,723 | 0 |
| 17 | 3,421 | 3,421 | 3,421 | 0 |
| 16 | 3,716 | 3,716 | 3,716 | 0 |
| 15 | 5,376 | 5,376 | 5,376 | 0 |
| 14 | 5,662 | 5,662 | 5,662 | 0 |
| 13 | 6,336 | 6,336 | 6,336 | 0 |

The selection rule was set before outcome access: among the source notebook population with k=8, r=176.54 and n>12, choose the largest available n having at least 30 distinct source formula IDs with exactly one p=14 and one p=60 row. Include all such common IDs, sorted lexicographically. Exclude missing IDs and ambiguous duplicated formula/depth keys; never choose a duplicate based on its outcome. No success probability, K, random baseline, or performance statistic participates in this rule.

The final selection manifest records UTC freeze time, exact selected IDs and source member paths, metadata and archive hashes, pairing scope and conditioning. The manifest is written before the selected outcome JSONL is produced. A separate receipt pins the manifest and JSONL checksums without changing the frozen rule. Outcome analysis is released only after these artifacts exist.

Frozen configuration: `published-poisson-8sat-r176.54-n20-paired-p14-p60`, with 1,415 formulas and 2,830 rows. The freeze was saved at **2026-09-10 23:40:26.252740 UTC**; extracted data were completed at **23:40:30.365156 UTC**. The analyst and reviewer received the release after both artifacts existed. No simulation is needed to analyze these existing depth-labelled probabilities.

- [Frozen manifest](2026-09-10-qaoa-selection-manifest.json), SHA256 `129ffdac79d9c71fb4aba130dbac23b755b53cecb7470434985614fc16d1706a`.
- [Selected source rows](2026-09-10-qaoa-selected-rows.jsonl), SHA256 `7c28c59a61126be539d7816e587f682551e0611e0673970eb10db848175ce7bc`.
- [Extraction receipt](2026-09-10-qaoa-selection-receipt.json). Exact IDs, metadata records and exclusions remain in the frozen manifest; later validation must be recorded separately rather than revising that manifest.

The local `.gitattributes` marks these three pinned JSON/JSONL artifacts and `2026-09-10-qaoa-data-reanalysis.json` as `-text`, preserving their exact bytes across Git staging and checkout so line-ending conversion cannot invalidate recorded checksums.

The normalized schema is `config_id`, `formula_id`, `depth`, `n`, `k`, `r`, `a`, `K`, `source_uniform`, `benchmark_id`, `source_member`, `instance_description_file`, and `instance_enumeration_file`. Here `a` passes through the source QAOA probability, `K` the source count, and `source_uniform` the source random-assignment probability. Selection is by metadata only; the inventory author has not inspected distributions of these values.

For reproducible extraction, [the replay script](2026-09-10-qaoa-replay-selection.py) reads exact frozen members from the pinned archive, checks metadata and raw-member hashes, and requires the result to match the frozen JSONL checksum before writing a new file. It does not rerun configuration selection or analyze outcomes. From this directory, substitute existing archive and new output paths:

```text
python 2026-09-10-qaoa-replay-selection.py --archive ARCHIVE --manifest 2026-09-10-qaoa-selection-manifest.json --receipt 2026-09-10-qaoa-selection-receipt.json --output NEW_JSONL
```

Replay verification completed for all 2,830 rows and reproduced SHA256 `7c28c59a61126be539d7816e587f682551e0611e0673970eb10db848175ce7bc` exactly. The script additionally pins raw-member aggregate `a73966d95f3822fc377f4ed1693bec09231e4ee362c1305c2f613d47ced381c5`, computed as SHA256 of sorted `member<TAB>raw-member-sha256<LF>` entries. This aggregate was established during replay of the already checksum-pinned archive; it was not part of the earlier frozen selection and does not establish new formula-identity evidence. Final script changes only make that recorded aggregate check unconditional. The replay output stays in the external cache, and the frozen manifest and data remain unchanged.

Pairing means identical source `instance_id`, followed by verification that the description/enumeration references and count metadata agree. It does not mean row-order pairing. Repeated benchmark IDs or source references are checked separately; no source identity is replaced with a synthetic position.

The normalized outcome JSONL passes through `a`, source-reported `K`, and `source_uniform` without recomputing or summarizing them. Zero/null values remain present. The analyst validates their domains, checks paired metadata/count agreement, and must report failures instead of silently dropping rows. On missing/invalid count evidence, uniform-baseline claims are withheld while overlap-only analysis may remain possible.

## Nonclaims

No new QAOA simulation, solver, training run, hardware execution or experiment was performed. This is an inventory and metadata-only selection; no practical speedup, depth-623 crossover, complete SAT/UNSAT solver or P=NP result follows. The remaining evidence is the separate frozen-data analysis and independent review.
