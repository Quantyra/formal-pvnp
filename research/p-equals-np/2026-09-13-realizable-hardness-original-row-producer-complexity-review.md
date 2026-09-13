# OriginalRows complexity-theory source review

Verdict: GO-WITH-NOTES for the bounded original-row producer. Independent proof
acceptance and full-constructor composition remain separate.

2026-09-13. S3131/S3132/S3137. Reviewer incidence_complexity_review.
The reviewer did not author or repair OriginalRows. It authored imported Code,
FirstOccurrence and Scan predecessors (and related Degree/CountFP/Gadget work).
Their prior separate independent acceptance is relied on, not supplied again by
this review. The same reviewer writes the two separately labeled source lenses;
this is not two independent people. Independent OriginalRows compilation is a
separate gate. No compiler, source edit, Git mutation or public action was taken
for this review; concurrent Gadget AUTHOR work is separate evidence.

Reviewed full final main/Checks and author receipt at frozen
7597c119c6c4b948963c2bdcdea6d5e3ca08c115. Raw main SHA256
11e0ccedcb1e68e801493571f650c19a55fbc3843d1547f3d2f75d0ee100388a,
Checks427eda8c9c3c34e5cd345dde190eb7d2eb395917abb3012a6113957631f033c6,
author receipt6335e817cc7ad82efb80bdf2a4997554f7e7023783851187418fe4a38848b58e.
These raw files contain CRLF and do NOT equal Git LF bytes. Explicit CRLF-to-LF
comparison matches frozen maina1fb0f51fbcc80340abe21da3c311c280d38bd1c973bdee4b7e6a4419df19010,
Checks5e490eb96b756f3d956ff23c228b3b5b9571830c5f6f064d61cba36f880398d0,
receipt2a695611b7ce117f7b248f05708b85ce122ea59b5b4681ca3c4e0a6f55765bab.
Source paths: drafts/2026-09-13-original-row-producer/ActualOriginalRowProducer{,Checks}.lean.

The author packet at certifications/realizable-hardness/.lake/build/actual-original-row-producer-author-20260913/author-verification.json
rehashes to6b846ff6a3ccd07edc1915d217ead5047a732cbcb472174046539caa4cbffac1
(16619623bytes). All three author raw log hashes were independently rechecked:
39936 main1,3590 main0/Checks0, one successful-main unnecessarySimpa warning,
no Checks warning. Author evidence reports19 standard-subset profiles,5examples,
3signatures. This source lens does not certify its full dependency rebuild or
claim an independent compiler result. The immutable packet is prefreeze/null;
the separately checked final commit above identifies the repaired source.

The concrete new function originalRowsFn is the SAME total bitstring function
in originalRowsFn_mem_FP and originalRowsFn_correct. Its input is the existing
DATA pair of sourceTriples I and the canonical RHS Bool list, not an assumed
oracle providing row answers. rowClock derives its loop count from posCount of
the table projection; no externally supplied runtime/count law is a premise.
materialize_mem_FP supplies a polynomial state bound from rowRule's FP proof,
and the output polynomial is derived from that exact raw FP membership.

anchorCodeFn combines existing ownerLookup and canonical ordinalScan at the
actual slot rank, then emits the full Code port representation: owner, false
tag, ordinal, zero port coordinate and empty unused dart/internal fields. It
uses DATA products for encoded subtrees; machine pairs are used only as function
arguments. The exact anchor theorem identifies codeVar I (I.anchor o), preserving
separate occurrence anchors for repeated labels. No source-owner distinctness
assumption is introduced.

rhsList is List.ofFn over the same Fin m row order, encoding rhsBool(I.rhs r).
posAt reads that encoded Bool at the actual row index. The three row fields are
formed from slots3r+i without deduplicating them. rowRule_correct identifies the
full ordered RowCode including RHS, and the whole loop emits the DATA encoding
of I.originalRows.map(codeRow I), not just an equal-size list or a permutation.
Here materialize_eq's one-entry-per-step premise is appropriate: each source row
emits exactly one row. It would not by itself justify variable cloud emission.

The theorem quantifies over arbitrary generalized Instance N m and charges time
against its supplied unary-instance wire. It does not imply polynomial time in
a compact original Nat-label source by bounding N or merely counting3m names.
The separate compact WireBridge must connect the actual normalized producer and
full RHS wire to this input. Empty Instance0 0 and repeated owner/two-RHS sample
are included in Checks; the sample's explicit example checks length, while the
universal output theorem supplies the stronger arbitrary-instance contract.

No mathematical source blocker found. The remaining gaps are global owner/cloud
emission and concatenation with one outer list bracket, compact-input/full-wire
composition, exact whole-output agreement, complete constructor FP, upstream
source hardness and final reduction/learning theorem. Concurrent Gadget is still
author work and is not evidence closing those gaps. No novelty or P-vs-NP claim.
