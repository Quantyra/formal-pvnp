# Isolated Allocation repeated-owner generalization draft

2026-09-13. S3132/S3137. SOURCE ONLY; not compiled or accepted.
Read the compact-source-normalization audit and its proposed minimal patch.
Live Allocation and Checks remain unchanged. The old accepted Allocation main
hash is b818b97e0fd08c97a720cdc2034ba3cb59aae836b392ec46add8e91ffda4aa38.

Overlay: certifications/realizable-hardness/.lake/build/actual-allocation-generalization-author-20260913/lean/PvNP/RealizableHardness/ActualOccurrenceAllocation.lean
with corresponding ActualOccurrenceAllocationChecks.lean. The tracked sibling
.patch preserves the exact proposed change relative to accepted sources.

The Instance.distinct input field is removed only in this isolated overlay.
The concrete row function, owner allocation, slot ordinal, anchors, RHS, row
order and cardinality statements are unchanged. cloud_support_port_unique
unpacks actual gadget support and excludes local indices2..6 because their
embeddings are internals; local_terminal_unique then equates the two remaining
terminal indices. It assumes actual membership, not a desired uniqueness law.

gadget_recoverable_unique lifts this through the owner tag: unpack each mapped
support member and case-split its cloud sum value. Any internal makes recover
return none. Two ports are equal by the concrete cloud helper. Thus for original
row intersections, recover_anchor supplies non-none for each member and proves
x=y directly. No equality of owners is used to infer equality of source positions.
Repeated owners in one source row are therefore permitted; the three distinct
occurrence anchors remain three output variables.

The isolated Checks preserves all existing Checks and adds two helper profiles
and an explicit Instance1 1 whose three positions all use owner0. Examples
assert repeated source labels, output row injectivity, support cardinality3,
and the original/gadget intersection bound. Requested total:27 profiles,
13 examples,4 signatures. No repeated-label parity has been deduplicated.

Runner preparation uses307 original accepted exports below Allocation and six
current direct package artifacts. It excludes the old Allocation output and
runs with cwd and source paths in the isolated overlay. Canonical package
manifest/pins remain in the companion; one thread,768MiB preflight and640MiB
owned-child guard, raw snapshots/logs/metadata. Authorization gate is false.
No compiler, Git, package modification or broader rebuild has occurred.

This does not change or recertify live downstream interfaces. The audit's
20-module consumer closure must be rescanned and rebuilt/reviewed in dependency
order before any replacement of accepted Allocation. Existing binaries prove
only the old restricted interface. Full multiplicity/parity, constants, wire
semantics and downstream compatibility still require that revalidation.
Compact normalization and Scan work are untouched. Encoded constructor FP,
upstream hardness and final proof/paper consolidation remain open.

Overlay main SHA256: b8e813395f689f0b4cb24ce306d1e8d99655ff35fd8e2bd261c16ed95a967972.

Overlay Checks SHA256: ab7302cf72b4c544df46e3cc6642c5d78b30599ca7886f6904cf3dcf121ee171.

Patch SHA256: 9d83cca6b0b87a21edd93c2b12737715d4519bf01e1a97af9696085305b4f993.

Runner SHA256: 9f779eacd390b0c30d07ab1f2b7188fb38bc160c5bdb96a6d6b6703e7bf76339.

Copies SHA256: 2ba752ba542df981ef22f64960337490b4dfdfced4d7be134466cec4eb0ef86d.

Preparation SHA256: a6f5afb6c3de6d801dc82faae388b4e4816a20b80c6b7f29235f5e8f3e00836d.
