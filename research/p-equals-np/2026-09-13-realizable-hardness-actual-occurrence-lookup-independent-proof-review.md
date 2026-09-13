# ActualOccurrenceLookup independent proof review

Status: GO-WITH-NOTES for bounded actual unary occurrence lookup; fresh independent pair compilation passed. Source freeze `900720895ac7463563d68633bffd8f62b7095ff1`.

Reviewer: lookup_independent_proof, top-level proof-adversarial lens. I did not author this module or its imported Allocation and Materialize proofs. Prior accepted dependency evidence is reused, not claimed as a new independent review of every dependency. No source edits or public actions.

## Source audit

The exact total raw-bitstring function `ownerLookup` occurs in both `ownerLookup_mem_FP` and `ownerLookup_correct`. Its argument is `pair table (replicate q true)`. The source table is the DataEncode encoding of List.ofFn over the actual ordered Fin m rows, each containing the right-associated triple of unary owner labels. The first component is selected when q modulo 3 is zero, second when one, third otherwise. Constant three is explicit in divC_eq and modC_eq. For q = 3*r+i, i : Fin 3 supplies the remainder bound; quotient is r. No caller supplies the desired answer or correctness premise.

The recFst/recSnd/recThd source lemmas invoke actual serialized-list lookup correctness with the row bound derived from sourceTriples_length and row equality from sourceTriples_get. Correctness refers to Instance.owner of that actual slot; the output-length and Fin N bound follow from this equality. The FP proof composes existing total projections, constant division/remainder, bounded record lookup and length comparison for this same function. No second abstract algorithm is substituted.

The exact pair-input length is 2*table.length+2+q. The valid-slot counter is strictly less than 3*m; the resulting wire bound is deliberately weak by one and valid. The empty-row theorem only asserts sourceTriples is empty. No assertion of correctness on invalid rows or malformed tables is needed; total FP still covers raw inputs.

## Boundaries

FP is the pinned library machine-realizability predicate, not an executable Lean evaluator claim. Unary owner labels can be exponentially larger than binary source labels. This module neither proves a polynomial source-to-table producer nor compact label normalization. It does not prove occurrence ordinals, the whole regularization constructor, an upstream NP-hard source theorem, the paper headline or learning corollary. These omissions are not hidden hypotheses in the bounded lookup results.

The source-only header comments are historical and will be superseded by dated build evidence, not edited for this review. Fourteen axiom queries, six examples and three signatures are expected. No new axiom, sorry, admit, native_decide or unsafe declaration occurs in these two sources.

## Build evidence

Fresh root: certifications/realizable-hardness/.lake/build/actual-occurrence-lookup-independent-review-20260913. Dependency preparation rechecks original accepted Allocation/Table exports and receipts, 178 current pinned Materialize source modules, and six explicitly current package exports. It never takes author Lookup output. The prepared plan originally withheld compiler authorization; the subsequent orchestrator grant and actual terminal evidence are recorded below.

## Actual independent build closeout

Session 67335 terminated with actual exit 0. Main and Checks each exited 0 on the first independent attempt, with unchanged source and no warning or memory-guard stop. Fourteen profiles are subsets of propext, Classical.choice and Quot.sound; six examples and three signatures elaborated. Both modules used Lean 4.34.0-rc2 commit 6a10ac8c22beadecabdbb0919c2b50214762f91d, LEAN_NUM_THREADS=1, the pinned eleven-package manifest, and fresh scoped exports. No source repair or author Lookup output reuse occurred.

Runner SHA256: `a5d00f76aa0af42b57999538d36ff3e86d4f7fdfd88e4a8ae224e4fcca90e33b`. Preserved pregrant plan: `9f123e5f907ff6cda3462cbca7db66bb6d882465a6063ba8f8a1b1c6bce04159`. Authorized plan: `448a84fca4265c48e3d4b863ece0416f9fd15cd0dcc81c20583dc1f9b448600d`. Portable JSON SHA256: `50e7385e5cbd3bc826b6c9f4bc77e85ebb5e6585b86f00fd381772277c9cb024`. It embeds exact raw UTF-8 logs, metadata, source snapshots, runner and preparation records, and records every original/copy dependency hash. These are bounded proof-adversarial findings, not a replacement for the other two lenses or full theorem certification. Compiler released; no Git/public action performed.
