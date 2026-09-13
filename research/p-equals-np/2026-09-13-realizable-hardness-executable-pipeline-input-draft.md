# Binary input and paired coins for the executable pipeline: source draft

2026-09-13. S3131/S3137 under full S3126. **UNCOMPILED SOURCE ONLY.** No compiler, Git, dependency/configuration or public operation performed. The accepted ExecutablePipeline constructor is reused without modification; this author cannot independently review this new module later.

## Concrete representation

ExecutablePipelineInput.Input stores a finite rational weight list, a normalized finite source table whose Formula indices use the actual weight-list length, four raw scalar parameters, precision b and trial count M. It stores no desired output, output-equality proof or polynomial-time certificate. Source validity is recovered by the parser's actual readTable decision, not supplied as a parser argument.

The deterministic input tree has fixed nested fields: signed weight list, ordered source-row list, scalar tuple, b and M. Signed rational fields use an explicit sign tag plus the existing unsigned numerator/denominator encoding; absolute numerator and canonical positive denominator serialize negative raw scalar inputs as well as zero and positive values. The parser rejects zero denominators and malformed sign/field tags. Source-row formulas use readFormula against the decoded weight-list length, so out-of-range variable indices are rejected. Source rows retain duplicates and zero masses, while readTable enforces nonempty rows, nonnegative masses and exact normalization.

The parser accepts raw weight/scalar values, including values outside the final arithmetic Parameters domain. It does not falsely certify those inputs as valid reduction instances. The existing Pipeline.checkedBits validates the computed output, returning none on rejection. Full correctness-to-bits uses the same original Parameters/M-positive/leaf-bound hypotheses already required by the accepted constructor. An invalid original scalar configuration that happens to produce a valid output is not automatically rejected by this policy; stronger input-promise validation is not claimed here.

## Machine convention and seeds

The deterministic input and randomness are separate tapes, combined using the existing Complexity.pair convention consumed by RandomizedReduction.SeededMap.apply. Input excludes random coins. coinBits flattens the typed Fin M -> Fin b -> Fin 2 array in row-major order through finProdFinEquiv. seedsOf reconstructs those exact coordinates from a flat Bool tape of length M*b, and its roundtrip script proves equality to the original seed array.

runOption decodes the deterministic tape, requires exactly M*b coins and calls the SAME accepted Pipeline.checkedBits with those reconstructed seeds. run takes the paired tape, unpairs it and maps any parse/output-validation failure to the explicit empty output tape. It is a concrete Bits -> Bits candidate executor, not a new abstract correctness interface. run_pair and run_valid script its exact output relation to checkedBits/bits for the same original inputs and seeds. No equality of canonical versus unreduced output encodings is added: run_valid reaches the actual accepted bits function.

At b=0 or M=0 the required coin tape is empty. With b=0 and positive M there are M empty seed rows, giving the same one-point selection per trial as the inherited sampler. M=0 passes seed framing but the eventual empty formula output remains subject to checkedBits validation. Wrong coin length rejects rather than truncating or padding. Noncanonical paired tapes are interpreted by the existing pairFst/pairSnd functions; this task does not claim an independent canonical pairing validator.

## Roundtrip and malformed-input statements

The source scripts cover signed rational, row, scalar and complete deterministic-input roundtrips; complete binary decode_encodeInput; malformed tree/field and trailing-bit rejection; empty input rejection; zero rational denominator and out-of-range formula index rejection; empty source-row rejection; flat seed roundtrip/length; wrong coin-length rejection; and exact parsed execution. Twenty-two axiom queries and ten examples are authored, not executed. There are no evaluation commands or observed results.

UTF-8 bytes were checked after writing with Unicode-safe apply_patch: no literal question marks remain. The source token scan finds no sorry/admit/native_decide/new axiom declaration. This is not a syntax/elaboration check. Particular pending proof risks are dependent readInput binds/record recovery, signed rational absolute-value rewrites, finite product-index simplification, pairing simp names, and the exact typed run_valid rewrite. Compile and repair without replacing full roundtrip/executor equalities by assumptions.

## Remaining runtime and full-goal obligations

Encoding b and M as binary naturals does not make arbitrary instances polynomial-time executable: M can request exponentially many formulas relative to the encoded length. This parser has deliberately not claimed FP or constructed SeededMap.run_fp/ruler_fp. The final reduction must compute b/M from an actual polynomially bounded source-size ruler, with coinCount depending only on total input length as required by the existing machine interface. Inputs of equal encoded length can currently request different M*b; a compatible uniform ruler with proved padding/consumption semantics remains necessary.

Next prove parser and rational arithmetic bit costs, intermediate magnitude bounds, bounded selection/list/repair/serialization execution and exact equality to run on the intended valid-input domain, with an explicit all-input time/failure policy. A binary output bound or successful roundtrip is insufficient. Source-produced input length, sample/precision rulers, confidence transport, specialized hardness, fixed-L quantifier choices, decoder/learning proofs, manuscript reconciliation and final consolidated fresh-checkout proof artifact all remain required under S3126.

## Current source identities

- certifications/realizable-hardness/lean/PvNP/RealizableHardness/ExecutablePipelineInput.lean: `e00fc4ec9c7d734617e83c005faaca429d8f05b4b872091d1924cd58b9acafcf`; 9963 bytes.
- certifications/realizable-hardness/lean/PvNP/RealizableHardness/ExecutablePipelineInputChecks.lean: `c363195b1e446cd109dddd273b57d208fc1bee1843f06f3ac34f10b160685778`; 2041 bytes.
