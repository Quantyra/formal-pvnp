# Complete source wire bridge draft

2026-09-13. S3131/S3132/S3137. SOURCE ONLY / UNCOMPILED. This archival directory contains ActualSourceWireBridge.lean and Checks. No paused FiniteBridge, Code or OriginalRowProducer module was edited; no compiler, Git freeze, live insertion or public action was performed for this draft.

Main raw SHA256: 9001a61ea5e779099e86b527f1d7641d4c5d9e7bf85ace4d4f7c1799672510e6.
Checks raw SHA256: 3668b7a4d645a3c469c56aeb5ea2bdfe49520c76fdc2ea47b6c9a7aa22727f1d.

Read interfaces: finite bridge archive6f78f85c, Code archive331d3a0c and OriginalRowProducer archive0068ec52, plus the separately accepted NormalizedTable producer. The finite and original-row modules remain uncompiled dependencies, and Code's status must be established separately; this draft does not confer acceptance on any imported source. The author of this bridge also authored finite/original-row drafts and Normalization/CompactLookup; independent reviews must disclose that shared authorship. Code and NormalizedTable were authored separately.

The missing equality is the WHOLE DATA product, not only its table projection. FiniteBridge.instance_rhs returns SourceNormalization.rhsValue at the actual RHS list index. The two existing rhsValue functions (Normalization and Code) are definitionally equal. Code.rhsBool_rhsValue supplies the actual Bool -> ZMod 2 -> Bool roundtrip; no assumed conversion law is added. instance_rhs_roundtrip then recovers the exact source Bool at every valid row index.

rhsList_instanceOf uses Valid S to equate row and RHS list lengths and List.ext_getElem to prove that OriginalRowProducer.rhsList(instanceOf S h) is exactly S.2, in the same order. It does not compare only counts, discard unmatched entries, or assume a caller-provided RHS serializer. Valid is required; malformed typed Sources do not receive an instance or this equality. Empty valid Sources are included without a Fin-zero inhabitant. Checks preserves mixed true/false RHS values and a source with repeated names/positions.

finite_wire_eq combines the actual finite sourceTriples_eq_unaryRows with that RHS list equality under the existing DataEncode product. sourceFn_eq_finite_wire consequently identifies the full NormalizedTable.sourceFn(SourceNormalization.wire S) output with OriginalRowProducer.wire(instanceOf S h).

The new total raw originalRowsFromSourceFn is exactly originalRowsFn composed with sourceFn. Its FP assertion uses actual mem_FP_comp on the two same-function FP results. Its correctness statement gives the complete DataEncode of the finite instance's ordered originalRows mapped through actual Code.codeRow. The raw output polynomial follows from the same FP theorem, rather than being used as an assumed runtime bound. No output format, parity summand, repeated row or RHS is changed to make the join fit.

Checks requests nine axiom profiles, six examples and three signatures. These are source requests only, not observed Lean output. Dependent List.ofFn indexing and rewrite elaboration remain untested; there is no sorry/admit/new axiom or assumed join. A future isolated build must first supply accepted exports for the imported draft modules and then run independent review. This source closes no gadget enumeration, graph representative ordering, cloud-row materialization, full constructor or upstream source-hardness obligation by itself. No novelty, publication or P versus NP claim is made.
