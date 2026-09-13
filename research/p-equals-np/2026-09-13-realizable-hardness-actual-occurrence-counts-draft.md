# Actual occurrence enumeration and counts

2026-09-13. S3132/S3137 under S3126. Source-only, uncompiled and unaccepted.

This closes the explicitly recorded count/multiplicity gap after
ActualOccurrenceAllocation. It follows the preserved source-construction and
actual-cloud-assembly notes. No novelty, source-hardness, degree, majority-gap,
or runtime claim is made.

## Exact ordered occurrences

`cloudIndices` is the actual cloud edgeList product with finRange 4. Its map to
the concrete local equations equals the generated cloud row list. The global
gadget index list is the variable-ordered dependent Sigma list of these actual
cloud indices. Original indices are listed first, then gadget indices, with
distinct Sum tags. The source proves this explicit row-index list is nodup,
contains every actual RowId, and maps exactly to Allocation.rows as an ordered
list. This goes beyond the previous membership-only correspondence.

The proved support cardinality three and pair-intersection bound make the
global row-pair function injective. Consequently the generated row list itself
has no duplicate row values. This is proved from the occurrence construction;
the implementation does not deduplicate either source occurrences or parallel
edge copies. Distinct repeated source equations use distinct allocated ports,
and parallel graph edges retain their own internal variables.

## Exact size

Writing E = sum_v card(Edge(size v)), the actual list length is T=m+4E.
The representative-orbit bound gives 2E<=9Dm after the proved slot partition
sum_v size v=3m, hence m<=T<=(1+18D)m. D is the fixed base-family degree; the
actual replacement graph's degree remains three. Empty m is covered, and
strict positivity of T is asserted only when m>0. No ratio division is used.

## Actual violation counts

`violations` applies countP to the actual generated list and the explicit
three-value ZMod 2 parity test with its stored right-hand side. Its filter
length and RowId indicator-sum equalities are proved from the explicit nodup
enumeration. A global assignment restricts to a cloud through its actual Sigma
tag. The total bad-row count splits into the actual original-row count plus
the sum of actual Cloud.rowsViolations for these restrictions. No output
equality, counting law, or idealized row collection is supplied as a premise.
An unused variable's zero-size cloud contributes zero violations.

## Verification and remaining boundary

No compiler, Git, package or public actions. Checks requests 21 profiles,
four signatures and eight examples. The instance extension methods are in the
existing ActualOccurrenceAllocation.Instance namespace, preserving the dotted
API; helper enumeration lemmas live in ActualOccurrenceCounts. This pair
imports Allocation and accepted cloud/edge dependencies, not the separately
owned uncompiled ActualEqualityCloudDegree module.

Compilation and independent three-lens review remain required. Global
incidence degree, compatible entire-instance YES extension, minority charging,
majority soundness and the final fixed-gap inequality still need their own
actual-row joins. No source Håstad hardness, encoded allocation/serialization
FP, P-versus-NP result or final paper certification follows from this draft.
