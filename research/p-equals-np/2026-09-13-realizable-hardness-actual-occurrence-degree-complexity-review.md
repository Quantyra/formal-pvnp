# Actual occurrence degree: complexity lens

GO WITH NOTES for the bounded whole-instance degree join.

2026-09-13. S3132/S3137 under S3126. Reviewer: occurrence_gadget_author.

Disclosure: this reviewer did not author ActualOccurrenceDegree or CloudDegree,
but did author the earlier Allocation and Counts components. Those dependencies
have separate independent acceptance; this review relies on that acceptance and
reads their actual statements rather than presenting a fresh independent audit
of their entire dependency closure. The complexity and nonclaims reports are two
lenses by the same reviewer, not two distinct independent people. The separate
proof reviewer supplied the independent compiler run; this reviewer ran no compiler.

Reviewed full Degree main/Checks, full actual CloudDegree and Allocation sources,
and Degree author receipt and independent proof evidence. Current source hashes
and raw frozen bytes at fc16c7a132a188ab508cb71788a9e18c7efbcccd match:
- Main: 18a4151cd131776efee7b1c5925daa7438eebd9d1098a644e133f0d4545ca31e.
- Checks: 40bb592c3c1928e9c7e299281d64b2318de38ed4f76cd229c50187d10d568617.
Independent proof JSON: e973b9b6c097aa8fde54cb03ce84809569af602939500ee2810c1ea430b4bc15.
Author packet: 839c4b2ba7753315b0b8f2f92754cec1aefd063e35c058eee0ada351072e136d.
Independent terminal records are pair exit 0, source unchanged, no memory guard.
This reviewer rehashed their raw logs, metadata, snapshots and output artifacts.
Recorded Checks: thirteen profiles, four examples, three signatures.

The degree is countP on Instance.rows itself. Per-row Finset membership counts
one incidence per row; this is appropriate because Allocation establishes three
distinct variables per generated row. The row list is never deduplicated.
originalDegree_eq follows the actual ofFn enumeration, and originalDegree_le_one
uses pairwise disjoint original supports derived from injective occurrence anchors.
It does not assume a bound on the source variable's original frequency.

Internals are excluded from every original support by recover: an anchor returns
some slot while a tagged internal returns none. Thus their original contribution
is exactly zero. This argument works with the concrete Sigma/sum carrier.

contains_tag_same uses injectivity of the owner tag; contains_tag_other projects
Sigma.fst. Their list-inductive count equalities retain all row occurrences.
The append/flatMap decomposition converts only the nodup owner finRange to a
Finset sum, not the row list or edge endpoints. Exactly the matching owner's
cloud remains. Parallel edge identities are therefore retained through the
accepted CloudDegree sum over actual retained Edge representatives. Omitted
loops are handled in that earlier concrete graph construction, not silently
removed by this module.

Ports contribute at most one original row and three actual cloud rows, hence
at most four. Each edge-tagged internal contributes zero original rows and
exactly two cloud rows. Exhaustive Sigma/sum cases cover every allocated global
variable, giving <=4 and its weaker <=10 consequence. Empty-source behavior is
explicitly checked using actual zero_rows; unused owners require no degree premise.

No complexity-class consequence follows from this local combinatorial bound.
The construction remains in a noncomputable section; neither an executable
encoding nor a polynomial-time implementation or source-hardness reduction is
proved. Majority charging, fixed-gap transfer and upstream hardness remain
separate joins. No blocking defect found within this precise degree scope.
