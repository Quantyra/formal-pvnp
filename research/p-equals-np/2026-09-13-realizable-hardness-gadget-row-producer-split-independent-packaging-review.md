# Independent Gadget module-split packaging review

2026-09-13. S3137. GO-WITH-NOTES for source-level packaging and disabled isolated preparation only. No compiler, source repair, Git or public action. This is not proof acceptance; the original guard-stopped compilation never completed elaboration.

I read the complete original main and Checks, examined the stable split modules, their dependency headers/private helper uses and author restructuring note, and independently compared the declarations. Original frozen e9c5c6aaf69c05856445e9a6aa1a969063b06f29 remains the comparison baseline. Original raw main SHA256 ecbeecaad69e6c086662a30cc7a1938da4a724096df3f1926c78fc1ad491d554.

## Exact difference inventory

All four original ranges are literally retained after newline normalization: lines 14-136 in Machine, 138-235 in Geometry, 237-341 in Rows, and 344-374 in final ActualGadgetRowProducer. Independently comparing complete declarations after removing comments, closing namespace commands and whitespace found all 78 public declarations exactly equal in name, statement and body, with no additions, removals or duplicates. Seven original private declarations remain; private compose is duplicated identically, giving 85 original declarations and 86 split declarations. The initial comparison helper incorrectly retained one closing namespace token at a layer boundary and reported dartRows; correcting the helper's end-command stripping resolved it. Literal source ranges independently confirmed no source discrepancy.

Checks is byte-identical, SHA256 96766935a00ceba263b70287d7f89f040d30887db033ab3b8cd24dae6ddb8eb5. All 31 axiom-profile requests, nine examples and four signatures remain in the same order. These are retained scripts, not observed successful profiles.

Only import placement, namespace/option/section wrappers and archival comments change, plus the one private helper duplicate. Each module reopens exactly PvNP.RealizableHardness.ActualGadgetRowProducer, the same open declarations, autoImplicit=false and noncomputable section. Public fully qualified names and raw functions remain unchanged. The final module retains the original import path and transitively exports the earlier layers, so the existing Checks and global constructor source imports remain compatible at source level.

## Private dependencies and import closure

Machine owns private compose and every early FP use. Geometry owns finRange_map_value, finRange_flatMap_value, range_mul_map and range_mul_flatMap; their internal calls and dartList_index are in the same layer. Rows owns filter_flatMap and encode_list; entryCat_correct and cloudFn_correct are in the same layer. The final module contains a second identical private compose for ownerCloudFn_mem_FP. No use requires accessing an imported module's private helper by its unmangled name. Their generated private identities will differ by module as expected; no public helper was introduced.

Imports are acyclic: accepted Code/ExecutablePortRotation/NormalizedTable -> Machine -> Geometry -> Rows -> final, with accepted CountFP imported directly by final. CountFP's explicit occurrenceCountFn and occurrenceCountFn_mem_FP references occur only in the final owner adapter. No earlier split declaration explicitly names CountFP. Its original imports are Lookup and Prefix, so moving it can change the available transitive simp/instance environment; source-level equality does not establish elaboration equality. The fresh build must verify that the remaining import closure provides every tactic and implicit dependency. This is an ordinary uncompiled scope risk, not a detected missing declaration. Do not add old unsplit Gadget exports as fallbacks to make a layer pass.

## Build and memory limits

The same cloudFn and ownerCloudFn still carry FP, exact ordered DATA output and raw output polynomial targets; no row order, representative filter, owner identity, six-field code or repeated-source semantics is weakened. The proposed process boundaries can release accumulated elaboration state but do not prove a lower memory peak. The imported environment and an individual declaration may still dominate. The failed original attempt supplies machine-wide available-memory guard evidence only, not a completed proof or a reliable declaration-level bottleneck measurement.

Authorize only a disabled fresh preparation runner at this stage. Subsequent compilation needs a separate root grant, four sequential fresh-process exports and the unchanged Checks, original accepted lower provenance, explicit intermediate-layer provenance and absent fallback checks. Any elaboration repair must be reviewed as an additional difference; this equality review applies only to the exact hashes below. Green layers should be preserved for exact resumption, but this is not permission to reuse author outputs for a later independent build.

I did not author the Gadget producer or this split. I authored downstream regularized constructor and Wire/OriginalRows drafts and earlier Normalization/CompactLookup/FiniteBridge components; those separate accepted dependencies are not re-proved by this packaging review. No complete reduction, upstream hardness, novelty or publication claim follows.

## Stable source identities and declaration ownership

- ActualGadgetRowProducer.lean: SHA256 bcc029a5aa1db1ace6b8c68a6e46eed9fd437354a770d3ce848f9198da2b0796.

- ActualGadgetRowProducerChecks.lean: SHA256 96766935a00ceba263b70287d7f89f040d30887db033ab3b8cd24dae6ddb8eb5.

- ActualGadgetRowProducerGeometry.lean: SHA256 2e8888a1e7dc0b3886139c4f4a3268d74b160530cd67cf1a1649119161855160.

- ActualGadgetRowProducerMachine.lean: SHA256 2d1336f45e1766ac726cc75c1776c4b70626ff8451d624df5c0b4e3ab75406d3.

- ActualGadgetRowProducerRows.lean: SHA256 c963d638b1dffb79d2091b1fdc214292bbdbccff3e7b186c8f386bc34b447820.

Independent public ownership counts: {'ActualGadgetRowProducer.lean': 8, 'ActualGadgetRowProducerGeometry.lean': 11, 'ActualGadgetRowProducerMachine.lean': 45, 'ActualGadgetRowProducerRows.lean': 14}.

The independent declaration inventory is retained locally at C:/Users/Dan/AppData/Local/Temp/s3137-gadget-split-independent-inventory.json, SHA256 87cf096f032e68e70a8b36f1f9b1fec2dffe1d6d615e614e32ab77dc97f18062. Author declaration-equivalence.json SHA256 23ed44abef956d7d6563e085b76495ecd4bf7723fc3d3cfa9b7d84a4ca5a25c4 is corroborating evidence; the comparison above was performed independently.
