# ActualOccurrencePrefix independent proof review

Status: GO-WITH-NOTES for bounded exact occurrence prefix; independent pair compilation passed. Final source freeze 1155754d8b0d4aed831dcbebb6b19d9a6a9bd799.

Reviewer: lookup_independent_proof, top-level proof-adversarial reviewer; not author of this pair or Ordinals. Prior dependency acceptance is reused with original artifact verification, not represented as a new audit of every dependency.

## Source audit

rank uses row*3+label, with label : Fin 3. decode uses quotient and remainder of q : Fin (m*3). Their two inverse laws and injectivity use the actual Fin bounds. No extra enumeration law is assumed.

map_rank_slotList proves equality to List.range (m*3) by unfolding the actual slotList product and proving the range multiplication decomposition. Thus slotList_eq_decode preserves order, with label fastest and row slowest. Injectivity transports idxOf; takeWhile before the target equals take at its actual index. Generic helper lemmas have LawfulBEq, preventing a custom inconsistent Boolean equality from entering the argument. The specialized Bool equality normalization changes only the presentation of the actual slot equality.

The numeric prefix is List.finRange(rank o), mapped through the real quotient/remainder decode with bounds transported into Fin (m*3). prefix_eq_actual is exact list equality, not a cardinality, permutation, or membership surrogate. prefix_length and prefix_nodup follow without deduplication. CountP tests the actual owner values; its equality to scanOrdinal uses the previously accepted exact-prefix theorem, then the canonical ordinal theorem for this same Instance. It does not accept the desired ordinal equality as a premise.

The first slot has empty prefix, and the concrete second-row example checks order through ranks [0,1,2,3]. There is no Slot 0 to make an invalid query; the full enumeration lemma remains valid at m=0. Fourteen axiom queries, four examples and three signatures are present. No sorry, admit, new axiom or native_decide occurs.

## Boundaries and preparation

This pair proves the mathematical ordered-prefix bridge only. It has no FP statement, serialized-source producer, compact-label normalization, whole-constructor runtime or NP-hardness theorem. The encoded lookup remains a separate result; composing it with a countOver machine requires further proof.

Fresh root actual-occurrence-prefix-independent-review-20260913 contains 309 original accepted dependency artifacts, rehashed originals and copies, six explicitly current mathlib exports, and no author Prefix output. Six identical receipts are hashed once each with an explicit cache. Sources were checked byte-for-byte against the final Git freeze. The prepared runner checks source hashes, fresh target absence, manifest and all eleven package HEADs before its scoped build. The pregrant preparation withheld compiler authorization and remains preserved. The subsequent orchestrator grant and actual terminal evidence are recorded below. No source edits or Git action for Prefix has occurred.

## Actual independent build closeout

Session 42910 terminated with actual exit 0. Main and Checks each exited 0 on the first independent attempt, with unchanged source, no warnings and no memory-guard stop. Fourteen profiles are subsets of propext, Classical.choice and Quot.sound; four examples and three signatures elaborated. Both modules used Lean 4.34.0-rc2 commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, LEAN_NUM_THREADS=1, the pinned eleven-package manifest, and fresh scoped exports. No source repair or author Prefix output reuse occurred.

Runner SHA256: `7109d87b0632e82c9a4642650ce953656e54b760be892b61d703bcefc94f1403`. Preserved pregrant preparation: `e2b6b00f97f0670f5712b5c18a05b0e7500a196af6b230a6de912e7af7e3990f`. Authorized preparation: `b83ee3a54ddc2d97e454d6a4eb33e04610143024e2fac75f4c0fd41fa912f30a`. Portable JSON SHA256: `a85e0c3066f816a32366584a9f4c926912454fa7bd8722b3260d2cc5956f2989`. JSON embeds exact raw logs, metadata, source snapshots, runner and preparation, and records every original/copy hash. This review is one proof-adversarial lens, not full theorem certification. Compiler released. Final review MD/JSON use explicit UTF-8 LF bytes; embedded raw source and compiler records preserve their own original newlines.
