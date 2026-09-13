# Complete finite per-seed executable output: source draft

2026-09-13. S3131 under S3126; integration obligations tracked through S3137. **UNCOMPILED source draft.** No kernel acceptance, observed evaluations, FP, full hardness or publication claim.

The preceding exact four sampler reviews were preserved at 75a438c454cb396a8394e6fa0836f17b6ce6e943. This new implementation is independently authored from the reviewed sampler; my earlier non-claims review does not independently certify my new code. No compiler, package/configuration, public, matrix or expander action was taken.

## Actual full constructor

ExecutablePipeline combines accepted FiniteSourceSampler, ExecutableRounding and CMMSA codec/encoding machinery. Inputs are an explicit weight list ws, a concrete normalized table whose formulas use Fin ws.length, scalar arithmetic input q, and a typed M-by-b seed array. It accepts no desired output record or equality certificate.

`draws` reads actual stored table rows using selectArray, and `draws_eq` identifies this function with the inherited fromSeeds operation. `repaired` adds the exception variable indexed by the trial position, not by the sampled source index. Thus two draws of the same source formula still get separate exception coordinates. The general evaluation and leaf-count identities retain the original/exception coordinate map.

`data` computes all three output fields: rounded weight list, the ordered complete repaired formula list cast to the actual weight-list length, and clipped budget. `tree` emits the whole codec tree with computed unreduced numerator/common-denominator weight and budget fragments and the full formula payload. `bits` serializes that actual tree. It does not call the noncomputable semantic outputBits as its implementation.

The full `data_eq` proof script identifies every field, including dependent formula coordinates, with the existing semantic pipeline outputData for the same seeds. `read_tree` proves decoding the actual emitted tree recovers data whenever the computed denominator is positive. Input Parameters plus M > 0 derive this denominator condition and output validity; the only additional formula condition is a leaf bound on each stored source row. These are input validity hypotheses, not target correctness assumptions.

`decode_bits` and `decode_seeded_data` script the complete decoded-record identity with the semantic outputData/seededInstance. They claim equality of decoded records, not identity of raw bytes with the canonical semantic encoder: unreduced rational fragments can encode the same value differently.

## Full payload bound and raw policy

`formula_wire_bound` structurally counts every connective and binary variable index. It gives length + 7 <= leaves*(4*N.size+10). Combining the inherited input-derived arithmetic bound B with source leaf bound L gives total emitted length at most

    (N+M)*(8*B.size+4)+1 + M*(L*(4*(N+M).size+10)+1)+1 + (8*B.size+3)+2,

where N = ws.length and B is ExecutableRounding.inputMagnitudeBound. This includes full formula payload and both outer nodes. It is an output-size expression, not an encoded-input polynomial/time proof.

Raw scalar arithmetic remains total. `checkedBits` explicitly tests the emitted tree through the existing codec acceptance predicate, returning none on rejection and the emitted bits on acceptance. Source-table validation and malformed typed seed-length handling remain in FiniteSourceSampler. This constructor consumes an already validated table and typed seed array; it does not implement a binary input-table parser or a general raw machine-input policy. The source includes acceptance/rejection compatibility scripts. No claim is made that every invalid scalar input must be rejected if its computed output happens to be valid.

## Verification still required

Main and Checks are uncompiled. Fifteen axiom queries and four general/boundary examples are prepared; there are no #eval commands or claimed observed outputs. The source scan found no sorry, admit, native_decide or new axiom declaration. Dependent casts in data_eq, readData Option-bind simplification, formula length algebra and instance extraction require actual compiler verification. A source script is not proof acceptance.

After compiler verification, all three independent reviews must use non-authors. The remaining full goal includes an actual binary source-input representation/parser, FP and rational bit-cost bounds, randomized machine integration and confidence transport, specialized source hardness, fixed-L composition and learning, full submission-quality manuscript reconciliation, and final consolidation into the paper repository with a fresh-checkout audit. This constructor does not discharge those obligations or establish novelty.

## Source hashes

- certifications/realizable-hardness/lean/PvNP/RealizableHardness/ExecutablePipeline.lean: `256926e67b4a7398020dc48a6ca50bf51ab0d720cd11f0d7548cda0a636e89ab`; 12066 bytes.
- certifications/realizable-hardness/lean/PvNP/RealizableHardness/ExecutablePipelineChecks.lean: `7fbe396b34ddeca3a70090826df7ca348d0cb47d9c277ec16a80a81ff637b0bb`; 1971 bytes.

## Encoding corruption correction and prepared runner

Root's raw-byte review found that the initial PowerShell-to-Python pipe replaced Unicode syntax with ASCII question marks: 31 in main and two in Checks. The earlier source scan checked forbidden proof escape tokens only; it did not establish syntactic validity or faithful Unicode transfer. Those original hashes above identify the corrupted historical draft, not a usable source snapshot. No compiler success was claimed.

Context-specific replacements now use ASCII Lean arrows/forall/comparisons and explicit Unicode escapes for reverse rewrite, angle brackets and turnstile. Both resulting UTF-8 files were inspected for remaining question marks: zero. No legitimate tactic holes were removed. This repair corrects transport corruption, not a mathematical theorem change. The source still awaits compilation.

Prepared, not launched: `.lake/build/executable-pipeline-author-20260913/author-runner.py`, SHA256 `7b36ed815276e243bd1b11fdbb2f77b50e6025e0e4feb2944c9d7e003fa1b4d3`. Copies receipt SHA256 `005409aa6de2198d1dab043d27f94d72cca5bc25aab47633abc566f0fded7b13`. Twenty-three exports were copied after original-hash verification: thirteen original finite-chain modules, six independently accepted CMMSA modules, the independently accepted rounding pair and sampler pair. The runner rechecks original/copied hashes before launch, manifest and all package HEADs, pinned Lean identity, LEAN_NUM_THREADS=1, and physical available memory (pre >= 768 MiB, stop owned child below 640 MiB). It writes raw logs and actual exit/source/output hashes before UTF-8 display. Python syntax was parsed without running the runner. Only Pipeline and PipelineChecks are permitted targets. Compiler authorization remains with root's current owner.

## Concrete encoded-input/runtime dependency plan

Inspection confirms the target constructor currently takes typed List Rat, Table ws.length, natural b/M and a typed seed array; CMMSACodec.readData parses OUTPUT trees only. The existing RandomizedReduction.SeededMap requires actual run/ruler membership in FP. Its composition theorem can combine component FP proofs but does not supply those proofs for these operations. Searching the pinned complexity library locates natural-bit infrastructure; this inspection has not identified a ready rational-list parser/rounding FP theorem. These are actual missing connections, not already discharged by full_wire_bound.

1. Define an explicit input tree carrying signed rational weights/scalars (or reject negatives before constructing the positive-domain input), ordered probability/formula rows, and precision/trial parameters. Parse variable indices against the decoded weight count. Prove roundtrip for valid typed data and explicit rejection for malformed syntax, zero denominators, invalid table sum, dimension mismatch and bad seed framing. Existing readFormula/readNat can be reused, but the output-only readRat accepts unsigned fractions and cannot by itself represent arbitrary raw signed scalar inputs.
2. Tie b and M to the original encoded input with actual bounded computable rulers. Arbitrary binary M can request exponentially many emitted formulas; hence the current constructor is not polynomial in a naive encoding of all its arguments. The final reduction must derive polynomially bounded sample count/coin count from fixed-L source parameters and implement their rulers. Merely storing M in binary or citing the output bound would miss this issue.
3. Prove bit-cost bounds for rational validation, cumulative sums, floor cuts, multiplication/division/ceiling and dyadic scale. Bound intermediate numerators/denominators, not just final B. Implement first-crossing search by a bounded finite traversal or prove a machine simulation of the existing Nat.find computation, then establish extensional equality to select. The semantic endpoint only bounds the chosen index; it does not already measure machine operations or cumulative recomputation cost.
4. Implement bounded traversals for sampled row lookup, formula repair/rename and serialization on the encoded data. Prove equality to this exact bits constructor for every accepted input and seed; retain unreduced-fraction decoded equality rather than falsely equating canonical bytes. Account for occurrence-specific exceptions and all formula payload bits.
5. Instantiate actual FP run and coin ruler in SeededMap, then transport existing YES/NO confidence events through decode_bits. Prove source-produced tables have polynomial encoded size and the required parameter promises. The specialized outer-source hardness and fixed-L uniformity remain separate prerequisites.

The next implementation milestone is the input-tree codec and all-input failure policy for this constructor, followed by an actual bounded arithmetic/traversal machine proof. The full submission-quality paper and final proof consolidation remain dependent on these and the source-hardness work.

### Repaired current source hashes
- ExecutablePipeline: `b29085ef2cae2e0691acbc4aa66dc0703ed84b7e06062e77d963cd7d0fbeb7fa`.
- ExecutablePipelineChecks: `8faab9437e552fe74687d37f297d2483a5690781995c67eae077e3a0d45adbc7`.
