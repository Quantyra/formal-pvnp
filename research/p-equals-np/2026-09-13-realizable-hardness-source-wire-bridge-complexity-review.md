# WireBridge complexity-theory source review - 2026-09-13

Verdict: **GO-WITH-NOTES** for the bounded source composition. No source-level complexity obstruction found; independent proof/build and root acceptance remain separate.

Reviewer: incidence_complexity_review, under S3137 and the formal three-lens protocol. I did not author or repair WireBridge. I authored imported lower work including Code, FirstOccurrence, Scan and Degree, and the separate pending Gadget producer; those dependencies rely on their prior independent acceptance. I previously reviewed FiniteBridge and OriginalRows. This reviewer supplies both separately labeled source lenses; they are not two independent people. No compiler was launched in this review, no source was edited, and no independent WireBridge proof-build acceptance is asserted.

## Frozen evidence

Final archive commit: `c0c4fbde6a70345d537bdda7c5620671205016cc`.

| File under research/p-equals-np/drafts/2026-09-13-source-wire-bridge | Raw SHA-256 | Frozen LF SHA-256 |
|---|---|---|
| ActualSourceWireBridge.lean | 5cf63f6558a2f2b3e739ee482e6ec5e396b500f648c92eacc90167a423949d0b | 95e13d7eebe75371147f64e048d8d6110c8e987bbe461fc4a2368173ef205d08 |
| ActualSourceWireBridgeChecks.lean | 3668b7a4d645a3c469c56aeb5ea2bdfe49520c76fdc2ea47b6c9a7aa22727f1d | fcf3dfbbf51c3ac287dceef941b242b0dc8599d6daad57a4f182b4c9e1a2c8fc |

I reread the complete final pair, independently hashed the raw archive, and compared each normalized CRLF-to-LF byte sequence with its actual frozen Git blob. Raw and frozen hashes differ; normalized equality holds. Dated author receipt `research/p-equals-np/2026-09-13-realizable-hardness-source-wire-bridge-author-verification.md` has raw=frozen SHA-256 `83908ec288bd0a005d737b4d1f2685759916d91549f18b5b149741fdffde201c`.

Author packet `certifications/realizable-hardness/.lake/build/actual-source-wire-bridge-author-20260913/author-verification.json` was rehashed as `5c7779f6f8786173e88931a06e470d7c0a1092445baeb7075517097f78558dd2` (2,546,740 bytes). Its immutable final_source_freeze=null and initial archive records are historical; the separately verified commit above binds the final source. I read its source, repair, results, dependency acceptance and boundary records and the dated receipt. Actual raw metadata/logs were checked: initial main exit1, repaired main0 and Checks0, no guard stops or source changes during an attempt, successful pair warning-free. Nine axiom profiles use only propext, Classical.choice and Quot.sound; Checks contains six examples and three signatures. The sole normalized repair unfolds ActualSourceNormalization.Valid in the RHS-list length proof. I did not rerun the full 2,641-dependency provenance closure; this source review relies on accepted lower receipts and the separately performed root/independent provenance verification.

Raw metadata paths relative to that author root are `diagnostics/ActualSourceWireBridge-1789322890467117700.json` (SHA `edcc178e2a992629cf9d394e707643037c42cd2f5c2124d013d58358ddf148a8`), `diagnostics/ActualSourceWireBridge-1789323158409474000.json` (`bda1fc296bda6687c144360df5636c6977dd44d78a3d44152189c470549cb893`), and `diagnostics/ActualSourceWireBridgeChecks-1789323214026624200.json` (`1c68d8f588bd3495b52aa5655cdfd20e51a323e602a87b530fb3815ac5e19fb6`).

## Exact discharged obligation

The existing compact input is ActualSourceNormalization.wire S = DataEncode.bitstringEncode S, where S contains binary natural-number triples and a Bool RHS list. Valid S means only equality of the two list lengths (Normalization lines 12-16). It does not impose distinct owners, positive row count, small label magnitudes or a promised semantic answer.

WireBridge lines 14-37 prove the actual Bool/ZMod roundtrip and pointwise RHS-list equality using bounded finite indexing. The extensional list proof establishes values in order, not merely matching lengths. Lines 40-53 combine this RHS identity with FiniteBridge.sourceTriples_eq_unaryRows to prove equality of the entire existing DATA pair. This is a derived producer-consumer wire equality, not an assumed serialization or correctness field.

Lines 56-73 define originalRowsFromSourceFn z as OriginalRowProducer.originalRowsFn (NormalizedTable.sourceFn z), prove FP of that exact total raw function by composition, and identify its output on each Valid S as DATA of the ordered list (instanceOf S h).originalRows.map (codeRow (instanceOf S h)). Reviewed APIs include FiniteBridge.instanceOf/instance_rhs/sourceTriples_eq_unaryRows, Table.sourceFn/sourceFn_correct/sourceFn_mem_FP, OriginalRowProducer.wire/rhsList/originalRowsFn_correct/originalRowsFn_mem_FP and Code.rhsValue/rhsBool/codeRow. Their function directions and pair encodings agree. This closes the compact full-wire adapter for the original-row producer, including RHS; it does not rely on a finite carrier count to infer runtime.

The raw FP claim and output-polynomial theorem quantify over every bitstring z. Correctness requires Valid S, so malformed arbitrary bitstrings are not assigned a source semantics here. Runtime is charged to the actual compact encoded input through the composed FP theorem, not to the magnitude of binary source labels or an assumed unary input length. The polynomial exists by the existing Cobham output-length theorem; no explicit degree, coefficient, wall-clock efficiency or tight bound is established.

Universal correctness permits empty sources and repeated labels/rows with their multiplicities and positions. The examples check empty and repeated-owner mixed-RHS cases at the RHS-list boundary; these are not full evaluated end-to-end examples, and the universal theorem supplies the full-output claim. No new distinctness or nonempty premise is introduced.

## Remaining scope and notes

The output contains only I.originalRows. It contains no equality-cloud gadget rows, global owner flattening or completed I.rows encoding. Per-owner Gadget FP/correctness, exact ordered global concatenation and its encoded compact-input composition remain obligations. A complete reduction and its end-to-end size/gap contract are not certified here; source hardness remains independent. Prior conditional regularization/assignment results are neither assumed away nor strengthened by this module.

The module header still calls its dependencies uncompiled drafts. This is stale historical wording, explicitly identified in the author receipt; accepted dependency evidence must be used instead. It does not invalidate the stated mathematics, but must not be repeated as current status. No novelty, P=NP/P!=NP, PCP-hardness or learning-hardness conclusion follows from this bounded join.
