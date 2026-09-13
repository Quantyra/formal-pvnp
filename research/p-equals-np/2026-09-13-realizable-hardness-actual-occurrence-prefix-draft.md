# Actual mixed-radix occurrence prefix

2026-09-13. S3131/S3132/S3137. Source-only, uncompiled, unaccepted.
No compiler, Git, package, public action or existing Ordinals/Lookup edit.

This pair uses the same explicit vars and Slot m as accepted Ordinals.
rank(r,i)=r.val*3+i.val, equal to the Lookup query convention 3*r+i.
decode(q) is the actual bounded pair (q/3,q%3). Rank/decode inverse laws and
injectivity are proved by arithmetic on Fin bounds, with no enumeration oracle.
The full existing slotList maps by rank exactly to range(m*3), using the
actual product list and a range-product identity. Injectivity then proves
slotList itself equals the ordered finRange(m*3).map decode.

The target slot has idxOf equal to its mixed-radix rank. Generic stop-before
prefix equals take idxOf; the concrete specialization yields exactly take rank.
prefix is explicitly finRange(rank o).map decode with derived bounds, so it
enumerates q=0,...,3*r+i-1 in order. prefix_eq_actual claims exact list equality
with slotList.takeWhile before o, not only membership, a permutation, a size
bound or deduplicated owner values. prefix_count_eq_scanOrdinal and
prefix_count_eq_ordinal transport the same-owner predicate along that equality
to the already accepted canonical ordinal. Prefix length/nodup are exposed.
When m=0 there is no queried Slot; the first actual slot has an empty prefix.

Coordinated with matrix's ActualOccurrenceLookup author: the serialized source
is DataEncode.bitstringEncode of List.ofFn right-associated triples of unary
owner words; query input pair(table, unary(3*r+i)). The present pair deliberately
imports only Ordinals, not the concurrently authored Lookup candidate. The next
encoded scanner can use exactly Lookup.ownerLookup and Materialize.countOver.
For every q in this prefix, ownerLookup valid-slot agreement must be instantiated
at decode(q); an equality indicator emits one mark for matching query owner.
Then length_countOver's sum must equal this actual prefix countP, and
countOver_eq_replicate identifies the same output word with unary canonical
ordinal. countOver_mem_FP supplies a genuine FP computation only after proving
the concrete indicator FP and joining its exact input encoding and clock.
Those encoded scanner statements are not claimed by this pair.

Unary owner words and query clocks are consistent with the existing wire
convention. Size/runtime relative to a binary succinct source is NOT established
by a numeric 3*m bound; the explicit serialized triple table and all delimiters
must be included in any later input-size analysis. Fixed D is unchanged and is
not input data. No caller-supplied prefix, ordinal, FP or output-equality premise.

Checks request fourteen profiles, three signatures, four examples. All source
transport was ASCII except branch bullets inserted by Unicode code point;
raw files contain no literal question marks or replacement characters. Proof
elaboration has not been tested and generic/specialized BEq and list dependent
index normalization remain possible elaboration issues. No sorry, admit,
native_decide or new axiom is present. Full encoded constructor FP, upstream
source hardness and final proof/paper consolidation remain separate obligations.

## Author verification update

Draft freeze: 6f0d28d7f6939b24402db1add2bc3a409a2cf997. Original session16870
was polled until actual exit1, not restarted because a process observation
was absent. Session89393 exited1. Session77621 completed actual main/Checks
pair exit0. Raw logs, metadata and exact source snapshots preserve all four
attempts [1,1,0,0]. No memory guard fired or source changed during an attempt.

Repairs made projection arithmetic explicit, supplied flatMap helper arguments,
and let private generic list helpers use the target lawful BEq instances.
The reserved identifier prefix is now escaped in Lean source; the declaration
name and definition are unchanged. Checks received only that spelling repair.
An extra implicit Nodup.take argument and linter suggestions were corrected.
All exact ordered-list/count statements are unchanged, not weakened to
membership or a numeric cardinality claim. Final main/Checks logs are clean:
fourteen profiles, four examples, three signatures. Axioms are subsets of
propext, Classical.choice and Quot.sound; no nonstandard proof primitive.

309 original accepted artifacts, copies and acceptance-receipt hashes were
rechecked after execution; duplicate receipts were hashed once while every
artifact was verified. Six current direct package artifacts, eleven pins and
manifest were also rechecked. This does not certify historical package bytes.
One thread, 768MiB preflight and 640MiB owned-child stop; minimum available RAM
1695035392 bytes. Compiler released.

Portable raw packet: certifications/realizable-hardness/.lake/build/actual-occurrence-prefix-author-20260913/author-verification.json
SHA256 6504816556165fa6e88748bdf30a7c2d6d5accc6210db40bc78e8c2ddd48229f. All embedded text is raw bytes decoded UTF-8, no
newline normalization. Pregrant preparation is preserved separately. This is
author verification only; independent acceptance and final repair freeze are
pending. The same-function encoded scanner FP and wire accounting, full
constructor, upstream hardness and final paper proof remain separate joins.
