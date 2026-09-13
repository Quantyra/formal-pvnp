# ActualSourceFirstOccurrence complexity review

Verdict: **GO-WITH-NOTES** for this source complexity lens and this bounded search component. No blocking mathematical or complexity-contract issue found. Independent proof review remains required.

Date: 2026-09-13. Route: S3131 / S3132 / S3137. Reviewer: occurrence_gadget_author.

## Independence and evidence

This reviewer did not author FirstOccurrence or its direct CompactLookup dependency. The reviewer authored the future NormalizedTable consumer and earlier separate Cloud, Allocation, Counts, Completeness, Ordinals and Prefix modules, and previously reviewed Normalization and CompactLookup. NormalizedTable source edits were paused throughout this review. Prior accepted imported dependencies are relied on; this is not a new independent rebuild of them. Both present complexity and nonclaims reports have the same reviewer and must not be represented as two independent people. A different reviewer has been assigned the proof-adversarial lens, which remains separate and pending at this report's creation.

Read the full final main and Checks, the actual Materialize.findFirst implementation and minimum/output/FP lemmas, imported SourceNormalization and CompactLookup contracts, and the author receipt/packet. The planning three-lens and literature-trigger protocols apply. This is a bounded source lens, not a novelty investigation. No compiler, source mutation, Git mutation, or publication was performed.

Final source freeze: `d6eeaea9b7df88d71fbf6e58fda8083e47e082e0`. Current raw UTF8 source bytes were compared to this commit's raw Git blobs; both matched. No newline-normalized substitute was used.

| Evidence | SHA-256 |
|---|---|
| ActualSourceFirstOccurrence.lean | `9321feb3019303b869acdf80dbf7ef593bfc27b56565707a97a5e7ae23d2cfb0` |
| ActualSourceFirstOccurrenceChecks.lean | `4046bd80666970ca800570018a5314ba0c2e674d2b7864c9b45991d504566dcd` |
| Author verification JSON | `b016b1eac345fa6e7f444e91c26238a046681ac031dd8285435d825d027e3649` |
| Draft and author verification receipt | `164602b2b7b0871e03ac640a4ae27772eed98c10a22fe335b50bc3dbabde867f` |

Source directory: `certifications/realizable-hardness/lean/PvNP/RealizableHardness/`. Author packet: `certifications/realizable-hardness/.lake/build/actual-source-first-occurrence-author-20260913/author-verification.json`. Receipt: `2026-09-13-realizable-hardness-actual-source-first-occurrence-draft.md` in this research directory.

Rehashed the packet, receipt, all four raw logs and available terminal metadata, and matched raw log text against the embedded records. Author sessions45842/45572 failed main; session48892 returned main0 and Checks0. All four sources were unchanged within their attempts and no memory stop fired. The packet records 16 standard-only profiles (rank_decode omits Classical.choice), five examples, three signatures, two main deprecation warnings and clean Checks. The first two failed attempts are retained; final proof repairs did not change the functions or public targets.

The packet's null final_source_freeze is prefreeze metadata; the separate commit above identifies the final source. Its dependency evidence records 2624 original exports, eight receipts, six current-only package exports and180 source records with11 pins. This source review does not independently replay the entire dependency inventory or strengthen the six exports' historical provenance. Author green is evidence, not completed three-lens acceptance.

## Least occurrence is derived, not assumed

The input is the machine pair of a compact binary table and unary occurrence index. ownerLookup extracts the actual complete encoded Nat label at that query. The context keeps that bitstring intact. hit_at identifies every valid candidate's marker with equality against the row-major flattened label list, by actual quotient/remainder row/column decoding and the flatMap indexing theorem. No abstract lookup oracle or first-index correctness premise is supplied.

The searched list is the original ordered flatten list, including every repeated occurrence. no_earlier_label derives inequality from idxOf/findIdx minimality; get_first gives the hit at the actual first index for a used label. search_correct applies the library minimum theorem to those two facts, then findFirst_eq_replicate upgrades length equality to exact unary-word equality. firstFn_correct supplies membership because its queried label occurs in the selected valid row. The result is the first position of that label, not the number of distinct prior labels and not its occurrence ordinal among equal labels. This naming convention can leave holes and must not be called dense renaming.

## Exact clocks and hits

`tableClock = marks (mulC 3 (posCount T))` derives its bound from the actual row table. marks is needed because mulC writes false bits; tableClock_correct proves the complete all-true word of length3m. hit uses complete binary-label equality and converts it to [true] or []. It neither compares binary code lengths nor feeds the nonempty [false] flag into search. The first position0 returns the empty unary word as the correct numeric answer; that output must not be confused with the different role of an empty candidate hit marker.

The library findFirst counts unanswered prefixes using nested bounded counts. Its actual FP theorem justifies polynomial time for the defined function. No linear-time search, optimal exponent, practical benchmark or quantum speedup follows from the name findFirst. Labels of arbitrarily large numeric magnitude are compared as finite binary words, without unary expansion of their values.

## Domain, size and remaining joins

firstFn_mem_FP is for the same total raw function appearing in firstFn_correct. Correctness is for a canonical Source table with valid finite row and column; invalid query or malformed raw input validation is not asserted. RHS validity is unnecessary for label search. Empty tables have no valid finite row query, and the raw function remains defined. Repeated labels/rows are preserved without a distinctness assumption. The two repeated-source examples supplement the general contracts.

The output is strictly shorter than3m; input_length_bound is at most2*|table|+2+3m. search_wire_length accounts for the internally derived clock, actual table and full serialized target label. These exact parameter bounds do not by themselves certify a whole compact-source producer. The same-function FP composition supplies this primitive's computational claim separately from its size formulas.

A future table producer must enumerate the original rows, use firstFn at3r+i, encode unary triples and preserve the RHS; a finite-carrier bridge must identify that encoding with the actual generalized Allocation source. Neither task is certified by this review, including this reviewer's own uncompiled consumer. Upstream source hardness and the full encoded occurrence constructor remain open.
