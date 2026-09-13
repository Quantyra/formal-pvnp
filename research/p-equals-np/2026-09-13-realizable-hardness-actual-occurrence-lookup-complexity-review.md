# Actual occurrence lookup: independent complexity review

Verdict: **GO-WITH-NOTES** for the exact total lookup function's FP membership
and correctness on the stated unary serialized input. Full encoded constructor
and source-hardness certification remain open.

Reviewer incidence_complexity_review is not this pair's author. Prior related
CloudDegree/OccurrenceDegree authorship and Ordinals independent review are
disclosed; those modules are not imported here. Allocation and Materialize
are existing dependencies, not newly authored by this reviewer. This pass and
non-claims are by the same reviewer; separate proof/build review is assigned.

Read the whole current main/Checks, author receipt and all four attempt logs/
metadata in the author packet, actual UnaryList recFst/Snd/Thd definitions,
their correctness/FP statements, divC/modC, Materialize.ifEqLen and its FP
composition, Allocation's ordered owner semantics, and the planning protocols.
No existing review-path conflict. Both files were independently verified
raw-byte identical to Git freeze 900720895ac7463563d68633bffd8f62b7095ff1:

- Main SHA256 fc5dac33f8c2eebdce77e80e202acc08e64668f093645bfbc99e301c3ff44b85.
- Checks SHA256 8edc5a0c7f91e8f45daf198a9a0b2eee08cd32f46f917233df5128df450e093b.

## Same-function FP and concrete correctness

ownerLookup is one total List Bool -> List Bool function. Its FP proof composes
actual library FP projections, constant divisor/remainder functions, concrete
serialized-record projections and length-based branching. The argument order
to rec*_mem_FP is correct: hd supplies the unary index length and ht the table.
No caller-provided FP field or substitute function appears. Noncomputable
source annotations do not negate the actual FP theorem; its claimed efficient
machine existence comes from the proved library membership, not Lean evaluation.

sourceTriples uses ordered source rows and stores each variable identifier as
replicate value true in a fixed nested triple. DataEncode.bitstringEncode is
the exact table encoding consumed by rec*_eq. The three record correctness
lemmas prove each concrete projection; dispatch proves q/3=r and q%3=i for
q=3r+i, handling every Fin 3 column. Consequently ownerLookup_correct identifies
the very function in ownerLookup_mem_FP with the actual source owner on the
actual paired table/unary-query wire. Repeated source rows keep their positions.
The inherited within-row distinctness premise is not used to falsify or hide
lookup behavior for a valid Instance.

The FP theorem is total on raw bitstrings. Correctness is intentionally limited
to serializedSource I and a valid Slot m; no malformed-table or out-of-range
semantic validation policy is asserted. An empty source has an empty triple
list and no valid Slot 0. The table contains variable triples, not the source
right-hand-side data; that is adequate for owner lookup and is not a complete
source-instance serialization claim.

## Genuine remaining encoding gaps

The input format is unary in both owner identifiers and q. lookupInput_length
counts the actual outer pair as 2*table.length+2+q; q<3m on valid slots gives
the stated bound relative to the already serialized table and m. Output length
is exactly owner.val and <N. These are honest wire identities, not a proof
that serializing abstract Instance data or binary identifiers is polynomial.

For example a large binary label can expand to exponentially many unary marks
relative to its bit length. The final source route must prove an appropriate
label normalization/bound and the actual table producer's FP correctness and
size on a chosen original encoding. Merely replacing complexity by polynomial
in the unary-expanded table would not discharge that requirement. N is not
automatically bounded by m because unused or sparsely numbered variables can
exist. This pair has no compact-to-unary source-normalization theorem.

Ordinal prefix enumeration, equality indicators, countOver semantic equality
and same-function FP composition remain to join this lookup to the canonical
ordinal scan. Global variable/row serialization, malformed input policy and
whole reduction runtime/source-hardness remain separate. A useful concrete
FP primitive is proved here; it is not the full reduction or full-paper goal.

## Evidence boundary

Author packet SHA256 adc87fbcd6513435c7d26c7c274c93749aab5f03a1d9f020d3c0e647225a64f1
at .lake/build/actual-occurrence-lookup-author-20260913/author-verification.json
contains actual module outcomes [1,0,1,0]. Main passed in 22212; Checks passed
in 56224 after example-only repairs without rebuilding main. I checked all
four referenced raw-log hashes and read their outcomes. Fourteen profiles,
six examples and three signatures are author evidence, not my independent
compiler execution. The packet's final_source_freeze is null because it
predates commit; the separate raw Git verification above supplies the freeze
link, rather than treating null as a verified pin.

Materialize's larger original closure and current package records retain the
documented cache provenance limits; this review does not claim a new whole
dependency build. No blocking complexity defect found for the bounded lookup
theorem. No compiler, Git, source, package or public action was performed.
