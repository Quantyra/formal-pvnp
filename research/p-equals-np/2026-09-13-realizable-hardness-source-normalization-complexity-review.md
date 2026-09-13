# Compact source normalization: complexity lens

GO WITH NOTES for finite first-occurrence normalization semantics.

2026-09-13. S3131/S3132/S3137. Reviewer occurrence_gadget_author.
The reviewer did not author this normalization pair or its imported source
components. The reviewer is concurrently authoring a separate isolated Allocation
generalization, which Normalization does not import. These complexity/nonclaims
lenses share one reviewer; they are not two independent people or a proof-build lens.
No compiler or source edit was performed for these reviews.

Full Normalization main/Checks and dated author receipt were read. Current raw
source bytes equal source freeze02e5a57e6ab4c677bb285280c50e374c28fe3bba:
main c0c967e5fcaadf0f8388969da96285f4a22caa56a5461c8949bcc9a56cfca7a4;
Checks6d053cfc75b16d4363db1370bcb91e345438f04889c8116ec6717999482f727e.
Author packet85e7432ac4b4a3f23b30f008983aa462c2ece6e867c6a1aa476adbf6d84258ec
records actual session91242 pair exit0, no warnings, unchanged sources,
12 profiles,4 examples,3 signatures. Source/frozen hashes and author raw log/output
hashes were independently rechecked for this review. This is evidence inspection,
not a replacement for the separate independent compiler/proof review.

Source is exactly a list of Nat triples paired with a Bool RHS list. flatten
uses the three positions in row order. first is actual idxOf, so membership
supplies the strict <3m bound and get_first recovers the original label at the
new name. first_eq_iff_on_used has necessary membership hypotheses: absent
labels can share the fallback index. New names are first positions and may
leave holes; no dense renaming or bound on original numeric label magnitude
is assumed. Repetitions map to repetitions rather than distinct fresh owners.

Assignments in this module remain Nat -> ZMod2. liftAssignment reads the old
label at the new index, with getD0 on out-of-range indices. decodeAssignment
maps a used original name through first and sends unused names to zero. Only
used labels enter rowValue, so these total defaults do not alter any row.
The two rowValue identities feed exact ordered violationFlags equalities;
violations follows by countP. No permutations, support deduplication or loss
of duplicate row occurrences occurs. Three repeated GF2 positions are summed
as three positions, so algebraic cancellation is preserved.

Valid requires row/RHS length equality. Even without Valid, the same zip
truncation occurs on both sides, explaining the unconditional flag identities;
this does not certify invalid wires as well-formed instances. normalize preserves
both row length and RHS list and therefore preserves Valid. Empty rows have
no used-label bound obligation and normalize empty is explicit.

This is not yet the Fin(3m) interface required by Allocation. A subsequent bridge
must construct each bounded finite label and transport these Nat assignments
and ordered per-position parity statements into the same finite Instance, with
an explicit valid RHS indexing proof. Repeated labels additionally require the
separate generalized Allocation interface and complete consumer revalidation.
Those joins are not assumptions hidden in these theorems; they are absent work.

wire names the compact DataEncode serialization, but no function on raw input
bitstrings is defined/proved FP here. normalize on mathematical lists and a
<3m output-label bound do not prove a binary-to-unary producer, polynomial
runtime, wire-size bound or the full reduction. A same-function FP construction
with exact serialized output remains necessary. No blocking defect found in
the finite semantic normalization claimed here.
