# First-occurrence search: independent proof-adversarial review

2026-09-13. S3132/S3137. GO-WITH-NOTES for ActualSourceFirstOccurrence and Checks at d6eeaea9b7df88d71fbf6e58fda8083e47e082e0. Independent session 38816 ended actual exit 0 for both modules, with unchanged sources and no memory guard stop. Root acceptance remains separate.

## Disclosure and scope

I authored imported ActualSourceNormalization and ActualCompactSourceLookup, but not FirstOccurrence. Their original independently accepted exports and recorded lower dependency closure are used here; this is not independent re-review of my own imported work. I also authored the separate, uncompiled finite-carrier bridge draft. That draft remained paused and byte-unchanged throughout this dependency review and is not imported by FirstOccurrence. This is an agent proof/build review, not human peer review.

I read the entire final main and Checks plus the actual Materialize findFirst definition, FP theorem and least-hit theorem. The exact same raw firstFn function is the subject of firstFn_mem_FP and firstFn_correct. There is no substituted machine, assumed producer FP, assumed equality oracle, or caller-supplied first-correctness/runtime certificate.

## Mathematical findings

The clock is marks (mulC 3 (posCount T)): on the actual encoded source table it contains exactly 3m true marks. It does not count the numeric magnitude of a binary source label. The query payload keeps the full serialized binary label extracted by ownerLookup. Each candidate is an occurrence ordinal in unary. hit compares the actual ownerLookup bitstring with that full query bitstring using the imported equalityMark, which produces [true] on equality and [] otherwise. Thus equal-length distinct binary labels are not conflated, and the findFirst nonempty-hit convention is respected.

flatten_get_row establishes row-major address correspondence directly for the Source list, with no Allocation restriction. decodeRow/decodeCol and rank_decode recover the actual row and one of its three positions. ownerLookup_flatten bridges exact table extraction to the corresponding flattened Nat value. Repeated labels and repeated positions remain ordinary occurrences; no deduplication of rows or parity terms occurs.

no_earlier_label derives minimality from the concrete idxOf/findIdx semantics using Nat's lawful Boolean equality. hit_first uses the existing concrete first-occurrence value lemma, while hit_before_first excludes every smaller candidate. search_correct discharges all three hypotheses of Materialize.length_findFirst_eq: a first occurrence strictly below the actual 3m clock, nonempty hit there, and empty hits before it. findFirst_eq_replicate then identifies the full output bitstring, not merely its length. That lower helper is itself the concrete nested countOver function, not an abstract assumed search procedure.

firstFn_correct applies this to the actual queried row/column and therefore needs no Source.Valid RHS-length premise: this operation examines source rows only. It also proves output length <3m and an explicit input bound 2*table.length+2+3m. search_wire_length retains the actual binary query-label length. For an empty row list, valid Fin row/column queries do not exist; the raw function remains total. The separately exposed search_correct requires label membership and makes no claim for absent labels. Unused names are not silently added to the source.

No proof defect or statement weakening was found. The two existing main warnings concern deprecated if_true/if_neg names; Checks has no warnings. No source edits or elaboration repairs were performed in this independent build.

## Build and provenance

Fresh root: certifications/realizable-hardness/.lake/build/actual-source-first-occurrence-independent-review-20260913. Runner SHA e24333528a055609b8f994efcd197b040a1dfcac1f19194bd9201301fe3912a3; preserved pregrant plan SHA 51db59d92bbd5f2ac92d534b7fa1cf9da05da0d1b5c3849595decdb53db68416. The runner launched only after generalized session 5164 terminated and released compiler ownership. It used one thread, the unchanged 768 MiB pre-child and 640 MiB running memory guards, and the pinned Lean version. Actual session 38816 produced main and Checks exit 0.

The fresh root received 2624 original lower dependency artifacts tied to eight accepted receipt identities, including original independent CompactLookup/Normalization exports. Neither author FirstOccurrence output was reused. Six mathlib exports have explicit current-package provenance; 180 current source pins, including the 178 Materialize source closure with original source identities, remain distinct from historical build provenance. All original files, copies, receipts, source pins, six current exports, eleven package revisions and the pinned manifest were rehashed after compilation. Direct mathlib source bytes normalized to LF were also compared against their pinned Git blobs. Ninety-six package/toolchain fallback paths for this target pair were checked absent, and neither target occurred among imported copies.

The portable JSON preserves actual terminal metadata, raw logs, snapshots, output hashes, runner and plans. It parses all 16 reported axiom profiles and checks only propext, Classical.choice and Quot.sound. Checks contains five examples and three signatures. Both source files are verified byte-identical to the final d6eeaea9 Git freeze. The inherited plan's raw_equals_frozen=false field refers to the older draft freeze; the result records explicitly verify raw_equals_final_frozen=true against the final freeze. No old draft identity is used to accept the sources.

## Boundary

This pair establishes one concrete bounded first-occurrence query in FP on the existing binary source encoding. It does not by itself materialize the whole normalized row table, prove a finite Allocation bridge, establish an upstream source-hardness theorem, or close the full reduction. The separate NormalizedTable and finite-carrier bridge obligations remain subject to their own compilation and reviews. No novelty, publishability, quantum speedup, or P versus NP conclusion follows from this review.
