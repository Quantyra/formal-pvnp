# ActualSourceNormalizedTable source draft

2026-09-13. S3131/S3132/S3137. SOURCE ONLY, UNCOMPILED. No compiler or source Git grant used. This task follows the existing compact-source normalization audit's concrete materialization route, not a new literature or novelty claim.

Main: `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualSourceNormalizedTable.lean`, SHA256 `9228552f34c02b7b3d15ab2d780ff3df2dbc617bc8eba9e26618d0fec99b5624`.
Checks: same directory, `ActualSourceNormalizedTableChecks.lean`, SHA256 `45af1a7d67110ed969622f3cb27fe8c4f66f4dae1cb381242630e72e1f2e85f6`.

## Dependency and protocol boundary

Direct dependency ActualSourceFirstOccurrence draft freeze `b6cfbe67589efc169f6145e0551b2a64104e8b58`, initially inspected main SHA256 `989829874c9b1d72fce5d1ca50b1e6913097e9316e1039fa79fcd085f5d1b014`. It is not accepted build evidence. Root reported author session45842 failed on elaboration and a proof-only repair is underway, with public contracts unchanged. This source draft is explicitly conditional on that dependency's eventual successful build and review. No dependency file was edited here.

Read companion/root README, the compact-source-normalization audit, actual SourceNormalization and FirstOccurrence source, and pinned Materialize/UnaryList/DataEncode APIs. The planning three-lens and literature-trigger protocols apply. This implements the already identified same-function producer obligation, with no new force or public-claim expansion. The Lean4.34 companion is the only prospective build surface; no root4.13 or broad build is appropriate.

## Actual construction

The input remains compact `Source = List (Nat * (Nat * Nat)) * List Bool`, using binary Nat DataEncode. Output type is `List (List Bool * (List Bool * List Bool)) * List Bool`. `unaryRows` is exactly `(normalize S).1.map unaryTriple`; each renamed Nat is written as replicate(first index) true. This is not the binary wire of normalize S and does not silently interchange two encodings.

`slotArg i` builds the machine pair of the supplied table and marks(mulC3(row unary) ++ replicate i true). Explicit marks is necessary because mulC carries length using false bits, while correctness is specified on all-true lookup counters. `renamedField i` is the actual firstFn on that argument. `rowRule` applies encTriple to positions zero, one and two in order. The row theorem equates its entire output with DataEncode of the actual renamed unary triple.

`tableFn T = listEncFn rowRule (pair (posCount T) T)` uses the actual library loop with an internally derived row clock. Materialize.materialize_eq is instantiated on the concrete ordered unaryRows list, with rowRule correctness at every valid list index. This proves full list encoding equality and length, not membership only; row order, repeated owners and repeated rows are retained.

`sourceFn` extracts the input table, materializes it, and wraps it with the untouched encoded RHS using DATA-pair brackets `false :: (a ++ b) ++ [true]`. Those brackets differ from Complexity.pair used for machine arguments. `sourceFn_correct` identifies the complete output with DataEncode(unarySource S); explicit table and RHS projection theorems are included. Source validity is not required for structural extraction or preservation: even unequal row/RHS lengths are carried unchanged. No malformed-input validation claim is added.

## FP and size targets

All FP statements are for the same functions used in correctness. Fixed-counter arithmetic, marks, firstFn composition, encTriple and materialize_mem_FP build the producer; there is no assumed time field or separate existential substitute function. `sourceFn_output_polynomial` invokes the actual Cobham.output_length_poly_of_mem_FP theorem on sourceFn_mem_FP, giving a polynomial in the raw input word's length for the exact total raw producer. It is not a runtime exponent guessed from output size.

A separate explicit valid-wire size proof bounds the table by `2 + m*(36*m+10)`, using the three first indices each below3m and the library's exact encTriple length. The complete output is bounded by `4 + m*(36*m+10) + length(DataEncode RHS)`. This formula alone is parameterized by m; the raw-word polynomial theorem is the distinct library-derived bound above. No numeric original label is expanded to unary. Empty rows and repeated labels are covered explicitly in Checks.

Planned Checks: 21 axiom profiles, eight examples, four signatures. Raw UTF8 transport has no literal question marks or replacement characters in either new file; LF and scoped whitespace checked. No sorry, admit, native_decide or new axiom declaration was introduced. These are planned checks, not compiler results.

## Remaining obligations

Build FirstOccurrence, compile this exact pair and repair elaboration without weakening targets; then obtain independent proof, complexity and nonclaims reviews. Join this exact unary table to the generalized finite Allocation instance and its serializedSource interface. Complete the rest of the actual occurrence/gadget constructor FP and upstream encoded source reduction. Upstream near-perfect3Lin hardness, final randomized hardness and learning/paper theorem remain open. No full source hardness, PvsNP, quantum, novelty, publication or final consolidation claim follows from this uncompiled draft.

## Author verification update

The source-only and conditional status above is historical. Root accepted the independent FirstOccurrence session38816 pair and its three lenses at final source d6eeaea9b7df88d71fbf6e58fda8083e47e082e0 before this pair was compiled. Its original independent main export, SHA256 `2da0cfc44c34a0e9d58394fad5cf94d366c47b3550576b49241e09855b288d26`, and original independent receipt `0643fad1472c3c2ea9d2cb90b708802e11ce85e10e7ca85a4d40c081f2c3bfe4` supplied the missing dependency. No FirstOccurrence author target was substituted. Original missing-dependency inventory, plan and preparation remain preserved separately from the accepted dependency plan.

Draft source freeze: `b4be4744dd823f28e09613a6560d3baf3483d00f`. Session45888 returned actual main exit1, source unchanged and no memory stop. The preserved errors were elaboration issues: unqualified normalize in simp, FP function unfolding, and Nat/Fin rewrite matching in rowRule. Proof-only repair qualified ActualSourceNormalization.normalize, explicitly unfolded the same two FP functions, and supplied three concretely typed field equalities at Fin.mk0/1/2. No function definition, theorem statement or assumption changed; no unchecked indexing, new axiom, heartbeat escalation or weakened target was introduced.

Session45646 then returned main0 and Checks0, each source unchanged. Actual outcomes [1,0,0], all raw logs, terminal metadata and all three attempt source snapshots are preserved. Final main SHA256 `a4a112c753e7f917663dc1287e7889986bc1d086ab21dfe34cbfa39da8c4e809`; Checks unchanged `45af1a7d67110ed969622f3cb27fe8c4f66f4dae1cb381242630e72e1f2e85f6`. Twenty-one axiom profiles passed: unaryRows_length uses propext alone, two rfl theorems have no axioms, and the remaining18 use the standard three. Eight examples and four signatures elaborated. Main emitted one unnecessarySeqFocus linter warning; Checks was clean. This harmless style warning was retained to avoid rerunning a green module without a substantive change.

Fresh scoped author root: `certifications/realizable-hardness/.lake/build/actual-source-normalized-table-author-20260913`. The full portable `author-verification.json` there has SHA256 `2edad1084b21478d306bd87f09ca0bf3e520a5a096d7557dace476d7b0c1fa3b` (100137498 bytes). It embeds raw UTF8 runner, plans, logs, metadata, snapshots, dependency receipts and repair diff. Its final_source_freeze is null pending final repair freeze, while the original draft freeze remains separately recorded. Raw bytes, not read_text newline normalization, determine hashes.

Postflight rechecked all2625 original exports and fresh copies, nine unique receipt files, six current-only package exports, all180 current source records and178 available original Materialize source records, normalized source equality to pinned Git blobs, all11 package HEADs and manifest, final sources, logs, metadata, snapshots, outputs and180 excluded fallback paths. Direct current package artifacts retain their historical-provenance limits. No target source was certified by its own previous output. Initial and accepted dependency inventories remain separate.

Runner SHA256 `6dd749b95bb7f43f6028bcbac867daa4947602b3b5aa85e279fee62d668ee8e9`; accepted inventory `41ba5cb017e726d09462b4ce5bf40dfc44081af84c1e84783f70a5711c3ea216`; accepted pregrant plan `ea329ae367f29f44b7d7415288c6a94c1f02aa9bba9f78d2ffa20fcbc7d5c2cd`; accepted preparation `ed5ed3f1e3232cd22eeff86dc78b503ec9fb7dbb0a9fff535643eb062c311b49`. One Lean thread,768MiB preflight and640MiB owned-process stop. No guard fired. Minimum available memory across attempts1790488576 bytes; successful main/Checks minima1863610368/2004111360 bytes. Compiler was explicitly released after actual session45646 terminal.

The bounded table/whole-source producer is author green, not independently accepted. Three-lens review, final source freeze, finite-carrier/serializedSource bridge, remaining occurrence/gadget constructor FP, upstream source hardness and final paper theorem remain separate. No full proof, novelty, public publication or final consolidation claim is made.
