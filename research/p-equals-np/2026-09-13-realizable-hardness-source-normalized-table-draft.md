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
