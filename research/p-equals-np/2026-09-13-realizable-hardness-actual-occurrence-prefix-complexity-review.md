# Actual occurrence prefix: independent complexity review

Verdict: **GO-WITH-NOTES** for exact mixed-radix enumeration and canonical
prefix-count equality. No FP or full constructor certification follows here.

Reviewer incidence_complexity_review did not author Prefix, Ordinals or
Allocation. I previously independently reviewed Ordinals and authored the
uncompiled Scan consumer of this interface, as well as unrelated Degree
components. That related work is disclosed; this pass does not independently
accept my own Scan implementation. Complexity and non-claims are by the same
reviewer; an independent Prefix build/proof review is separately assigned.

Read the entire final main/Checks, author receipt, Allocation.slotList and
canonical ordinal, accepted Ordinals prefix-count statements, and the planning
protocol/assembly boundaries. No existing review-path conflict. Verified raw
bytes equal Git freeze 1155754d8b0d4aed831dcbebb6b19d9a6a9bd799:

- Main SHA256 4254ac0916da392e425352c0a2cdb5afff4afc9b30004a17c0b56ad8bf4ee70a.
- Checks SHA256 b55d1c4c578d069b835eba9cadca5bd1b2eead29ac15720b4f0664e52ac59656.

rank is row*3+column, with column fastest. decode uses quotient/remainder
under an actual Fin(m*3) bound; rank_decode/decode_rank establish inverses
and injectivity. The bounds require no occurrence count oracle or source
hardness premise. map_rank_slotList identifies the whole ordered rank list
with range(m*3), and slotList_eq_decode proves actual LIST equality with
increasing decoded counters. This is stronger than cardinality, membership
or a permutation and is exactly the ordering needed by the scanner loop.

slotList_idxOf proves the target occurs at rank o in the actual list.
takeWhile excluding the first target equals take(idxOf), and the lawful BEq
assumptions on private general helpers ensure the comparison is actual equality.
The public concrete Slot predicates retain their intended semantics.
The escaped identifier «prefix» denotes the same intended prefix constant;
it is a syntax repair, not a new enumeration.

prefix_eq_actual is an equality of the increasing numeric prefix with the
actual stop-before-slot list. The prefix excludes its target, has length
rank o and is nodup because source slot indices are distinct. Repeated owner
values or repeated source equations are not deduplicated: they remain separate
slots and contribute separately to countP. Applying the same-owner predicate
therefore yields precisely the accepted scanOrdinal, then the existing
Allocation.ordinal value. No desired ordinal equality is supplied as a premise.

The first-slot prefix is empty, the last valid rank stays below m*3, and Slot 0
has no valid query. The example with row1/column1 produces exactly ranks
[0,1,2,3], exercising row-major ordering rather than just a length assertion.
Generic vars need not satisfy row distinctness for the scan equality; the
canonical-Instance corollary uses the real structural source type honestly.

This removes the finite mixed-radix prefix semantic gap, subject to independent
acceptance. It does not provide encoded table lookup, countOver integration,
same-function scanner FP or input/output wire bounds. The authored Scan draft
must separately connect these exact facts to its actual raw function and pass
its own checks. Compact-label normalization, table-producer FP, whole reduction
runtime, upstream source hardness and final theorem/paper remain open.

Author session77621 pair0, fourteen profiles, four examples and three signatures
are attributed author results; packet SHA256
6504816556165fa6e88748bdf30a7c2d6d5accc6210db40bc78e8c2ddd48229f
is at .lake/build/actual-occurrence-prefix-author-20260913/author-verification.json.
This source-only pass does not assert an independent build or historical
package-export certification. No blocking complexity defect found. No compiler,
Git, source, package or public action was performed.
