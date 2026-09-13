# Independent non-claims review: executable pipeline input

2026-09-13. S3131/S3137 under S3126. Reviewer: specialization_nonclaims_review, independent of Input authorship and both other lenses. **GO-WITH-NOTES for the concrete parser and exact same-function execution bridge.** No blocking overclaim found in the reviewed component and receipts. All-input FP acceptance is expressly excluded and would contradict the unrestricted output-size behavior described below.

## Evidence

Read complete Input main and Checks, author narrative/verification appendix, completed independent proof review, current complexity review, and actual imported input Parameters, source ValidRows, binary natTree, Pipeline data/bits/checkedBits and Complexity pair/projections. The applicable planning protocol, formal-three-lens protocol and inbox were read earlier in this reviewer session. No satellite AGENTS.md was found by root/path search. No compiler, source, package, configuration or public changes were performed. Only this separate review file is authored; it is left untracked for orchestrator freezing. Six pre-existing untracked artifacts observed at task start are preserved.

Current main, Checks and author receipt are raw-identical to source freeze `3f2c0ff655d22db052110c9cd226528cdc8a27cc`:

- Main SHA256 `b0c513dd5680d6504ee94d480998dbccf691f7f132bed993755f4c202364e24c`.
- Checks SHA256 `c363195b1e446cd109dddd273b57d208fc1bee1843f06f3ac34f10b160685778`.
- Author receipt SHA256 `caf0cf69679ddfaa2caa0fc46179719cc6e3f0a63d0cdc1bdc87df23af7a83f0`.

Independent proof-review markdown and JSON are raw-identical to freeze `c8b2a4d239bfa7eda9815760750e2137e477faa3`, with respective hashes `07586cac7ac6de3d6433bf99b950632fd6f717f19eab655b5619de49a357d255` and `e1306a909dc6a8f7bd615f7fad5344f1c76056ca8d1b16256b23d1b44973422e`. Current complexity review hash is `9ca00daeed4100f75d0ecc80ca75458ab1ff4eb3b982a48dbe8ce4c57e3a1217`. That completed proof packet records session 61200, both exits zero, both source_unchanged true, 22 standard-only profiles and ten compiled examples. This non-claims lens does not claim a fresh compilation or duplicate the root's 43-dependency artifact verification.

## Permitted statement and precise limits

The component parses concrete deterministic input bytes, checks finite-table normalization/nonemptiness and formula-variable bounds, checks an exact M*b coin length, reconstructs the same seed coordinates, and invokes the existing Pipeline.checkedBits. On a canonical outer pair built from the encoded typed input and its coins, run_pair identifies the exact checked constructor. Under the genuine arithmetic Parameters promise, positive M and the stored-row repaired leaf bound, run_valid proves exact equality to Pipeline.bits. This is byte-function equality to that same constructor, including its chosen unreduced output fractions; it does not establish equality to a different canonical encoding.

The deterministic decoder rejects malformed tree syntax, trailing tree bits, bad fields, zero rational denominators, empty source rows and invalid variable indices as specified. It accepts raw negative weights/scalars and need not reject every violation of the stronger arithmetic Parameters domain. Source masses must be nonnegative and normalized; weight positivity/normalization and scalar inequalities are separate input promises. Output validation is not input-promise validation, and successful parsing or a valid computed target does not certify that the source instance meets the reduction hypotheses. Typed input contains no desired output identity or polynomial-time certificate.

The proven input roundtrip is decode(encode x)=some x. Unreduced fractions, negative zero and other accepted representations can share the same rational value; no converse canonical-byte theorem is claimed. Row order and duplicates remain intact. Zero-mass rows are allowed. The source table is explicit, so this parser alone does not prove efficient construction of the table from an original source instance.

Outer pairing must remain distinguished from deterministic tree parsing. run uses total pairFst/pairSnd projections. A malformed outer pair may retain a decodable first prefix and have an empty second projection. With zero required coins it can reach execution. Only actual deterministic parse, coin-length or checked-output failure necessarily yields the empty result. The broad phrase 'all malformed inputs reject' would be unsupported; the source and receipt qualify their policy appropriately.

Coin-coordinate roundtrip proves neither a probability law nor a confidence bound. When b=0, positive M gives M empty seed rows and an empty tape. When M=0 the tape is also empty, with output still subject to validation. Exact M*b length depends on decoded contents, and equal-length inputs can require different products. There is no uniform length-only coin ruler, SeededMap instance, padding/prefix-consumption theorem, exact arbitrary-rational sampler, or transported reduction error bound in this pair.

## Concrete cost obstruction

The complexity review's b=0 example is sound at the inspected source level: fix weights [1], one probability-one variable formula row, L=2 and valid constant s=1, eps=0, gam=1/4, sig=8. Positive binary M is unrestricted, the coin tape is empty, and run_valid reaches a constructor containing M formulas and N+M weights. Input length grows logarithmically in M while output length is at least linear in M. Consequently the unrestricted run cannot be retained unchanged on every present valid arithmetic input and simultaneously have an all-input polynomial-time output bound. This is a mathematical source-level cost assessment, not a new compiled Lean lower-bound theorem or observed experiment.

For b>=1 the supplied coin tape itself contributes at least M bits, so that particular paired-input output-size argument no longer applies. It still supplies no polynomial bound relative to original deterministic/source length, rational intermediate bit-cost proof, efficient table enumeration, or all-input time guard. Output validation after expensive construction is not an early cost guard.

The next bounded executor must enforce a polynomial policy before costly work and prove agreement on the entire actual source-produced domain. It must prove that its caps admit every intended hard instance; an arbitrary restriction that drops such instances would not satisfy the full goal. The uniform ruler and excess-coin treatment likewise need explicit correctness and source-length bounds. The author receipt already disclaims FP and unrestricted polynomial execution, so this obstruction is a required next obligation rather than a contradiction in the present bounded theorem.

## Closeout boundary

Known-prerequisite parser formalization is an accurate description. This component does not establish new mathematical novelty, quantum speedup, PCP or source NP-hardness, full CMMSA hardness, learning, P=NP/P!=NP, publication readiness or full-paper Lean certification. Historical uncompiled comments in source and initial narrative are superseded by the dated completed receipts; reconcile current-facing labels during final assembly while preserving provenance. This verdict is not publication approval.

Remaining to-do list: S3137 records all lenses and root verification before bounded acceptance; S3131 supplies bounded execution, source-size/precision/sample policies, uniform coins and probability/error transport; S3132 completes source hardness; S3134/S3135 complete decoder and compatible parameters; S3136 completes learning; S3128 reconciles and consolidates the finalized proof into the paper repository with fresh-checkout verification. Full S3126 remains open.
