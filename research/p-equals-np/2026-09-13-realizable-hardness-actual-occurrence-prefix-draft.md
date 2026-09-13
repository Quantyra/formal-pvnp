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
