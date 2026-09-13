# ActualSourceFiniteBridge isolated source draft

2026-09-13. S3132/S3137. UNCOMPILED and conditional on generalized Allocation full20 acceptance and draft NormalizedTable dependency acceptance. No live source change, compiler or Git action for this bridge.

Isolated source directory: certifications/realizable-hardness/.lake/build/actual-source-finite-bridge-draft-20260913/lean/PvNP/RealizableHardness.

Constructs instanceOf S h : generalized Allocation.Instance (3*S.rows.length) S.rows.length from actual normalized first-occurrence labels. Each Fin bound derives from normalized_label_bound and actual row membership; no distinctness or transport premise. RHS is taken from the same indexed Bool list under Valid equality of lengths and converted to ZMod2. Restrict/extend assignment functions provide exact ordered violation-flag and count transport in both directions through the accepted normalization semantics. YES witness and universal NO count promises transfer via explicit lift and decoder. Empty input uses Fin0 functions only, without manufacturing an inhabitant. Checks includes a row with three equal original labels and all three normalized values zero.

The exact producer/consumer join is included: sourceTriples(instanceOf S h)=ActualSourceNormalizedTable.unaryRows S, then serializedSource(instanceOf S h)=DataEncode(unaryRows S), and tableFn(original compact table)=serializedSource(instanceOf S h). These preserve row order and the right-associated unary triple encoding; no merely equal cardinality or permutation claim substitutes. The producer remains a draft dependency, and these proof scripts have not been compiled. No full output regularization machine FP or upstream hardness theorem is asserted.

Imports generalized ActualOccurrenceCompleteness and Lookup, accepted ActualSourceNormalization, and draft ActualSourceNormalizedTable (which imports FirstOccurrence). Live Allocation is still restricted and cannot typecheck this constructor; a future isolated build must use accepted generalized exports and independently accepted producer exports. No such outputs have been copied into this draft root. The only anticipated elaboration-sensitive portions are indexed List.ext_getElem transport over normalized zip/maps and product projections; exact targets remain authoritative if repairs are needed. No mathematical/API blocker identified from source inspection.

Planned Checks16profiles,5examples,4signatures. Source transport is ASCII-only. Raw source identities follow.

ActualSourceFiniteBridge SHA256 31016722ef0e9330d42853976ed43ad2ce93adce666bcee0936d733710b32c0a.

ActualSourceFiniteBridgeChecks SHA256 8c9584966321f323ab42e1821c86fae29869d862d4e5477b48a33ce32f562833.

## Archival preservation

Unchanged source drafts are also stored durably at `research/p-equals-np/drafts/2026-09-13-source-finite-bridge/ActualSourceFiniteBridge.lean` and `ActualSourceFiniteBridgeChecks.lean`. They are byte-identical to the isolated draft root named above. This is archival preservation only: no live Lean source insertion, compiler execution, proof acceptance or change to generalized inputs. Conditional dependency and uncompiled status remain unchanged.
