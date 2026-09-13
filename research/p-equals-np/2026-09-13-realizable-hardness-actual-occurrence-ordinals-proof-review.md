# Actual occurrence ordinals: independent proof-adversarial review

Verdict: **GO-WITH-NOTES** for executable ordinal/canonical ordinal equality
and the direct unary output-size bound. Encoded FP and the full proof remain open.

Reviewer incidence_complexity_review did not author this pair or its Allocation
ordinal definition. Prior related CloudDegree/OccurrenceDegree authorship is
disclosed; neither module is imported here. This is an independent source and
kernel-build review, not human peer review or a novelty assessment. Read the
whole main/Checks, author receipt, Allocation.slotList/occurrenceList/ordinal,
the accepted List.Nodup.getEquiv inverse convention, and applicable planning
three-lens/assembly boundaries. No existing proof review files were overwritten.

## Source identity and independent execution

Both inspected files match Git freeze d3d21e6df2d427e754b4a8194658c6da3c08c32a
byte-for-byte, independently checked before and after compilation:

- Main SHA256 c46ac18ebea1dc5a7fc94ddb30fa674321f5d387c59db699c9f3425968743f55.
- Checks SHA256 663c3a0a72f1aa80c56889af7fb6f0972da96c91c2f19c0a9f1714a29ea92d10.

Fresh .lake/build/actual-occurrence-ordinals-independent-review-20260913 copied
308 exports directly from original accepted paths, with corresponding receipt
hashes. No Ordinals author output was reused. Original/copy/receipt identities,
six direct current package records and all eleven dependency revisions were
verified. Six current package hashes are not historical per-export certification;
no fresh whole-dependency build is claimed.

Independent session 55204 completed main and Checks at actual EXIT 0, both clean,
without retries or source changes. The pinned Lean 4.34.0-rc2 commit, manifest,
single thread, 768 MiB physical-memory preflight and 640 MiB owned-child stop
were checked; no guard fired. Minimum observed physical availability was
2,178,748,416 bytes. Compiler ownership was released after the terminal result.

All eight requested profiles printed: scanBefore_eq_prefix_count and
scanBefore_eq_filtered_idxOf use propext only; the other six use precisely
propext, Classical.choice and Quot.sound. Four examples and three signatures
compiled. No sorry/admit/new theorem axiom/native_decide occurs in this pair.
The earlier corrupted transport was an uncompiled failed transmission, not
accepted source. The author's later failed elaborations [1,1] and pair [0,0]
are historical and distinct from this independent [0,0] run.

Portable JSON:
2026-09-13-realizable-hardness-actual-occurrence-ordinals-independent-proof-review.json
SHA256 0c57e3bff81abd6fb817dad776b8ef279079d2fcd1717f803ec7883d2c0818f7.
It embeds raw runner/log/metadata/source bytes as UTF-8 strings without newline
normalization, original provenance, current package records and actual terminal
results. Runner raw SHA256:
84aa0e8f6f9ab4ffb486b6463b3db4156467d6fa782d6f793e3044466d9af99a.

## Adversarial statement inspection

scanBefore stops before the first target and counts only retained predecessors.
Its prefix theorem correctly uses takeWhile; an absent target counts all kept
elements. The filtered-idxOf theorem requires keep target = true. Without that
premise filtering could remove the stopping target; with it, the equality
holds even for absent targets and repeated list entries. No unnecessary nodup
assumption hides these cases.

scanOrdinal uses exactly the existing lexicographic slotList and the queried
slot's actual owner. The target is kept by reflexivity. The filtered list is
the canonical occurrenceList used by Instance.ordinal, whose getEquiv inverse
is its idxOf. Thus the final rfl after the general scan theorem genuinely
identifies the existing ordinal; no substituted arbitrary equivalence or
desired equality premise is passed by the caller. The strict bound is the
actual Fin ordinal bound, not a looser unrelated length bound.

The function needs no source-row distinctness assumption to run. Its equality
with an Instance ordinal is quantified over the actual structural Instance;
it introduces no hardness assumption. Slot 0 is empty, so an empty source
cannot be queried with a fabricated valid slot. Generic empty-list/first-target
examples test the recursive definition; unused owners cannot own a queried
source slot. The lawful BEq/DecidableEq normalization in the proof preserves
the executable prefix predicate rather than changing it.

scanBefore_le_length and slotList length give a genuine numeric <=3*m bound.
unaryAnswer is an actual replicate list with that length, not an existential
encoding. But a typed function argument vars is not a serialized input table
with proved lookup cost. This source proves neither complexitylib FP membership
nor a polynomial bound in a binary-only encoding of m. The input table and
query representation, mixed-radix prefix enumeration, concrete owner lookup,
countOver semantics and same-function FP bridge remain essential work.

No blocking proof defect or vacuous premise was found in the bounded result.
No source, Git, package, broad-build or public mutation occurred; independent
artifacts and these two review files are the only new outputs. Required other
lenses and full encoded constructor/source-hardness/PCP/learning/paper gates
remain separate from this acceptance recommendation.
