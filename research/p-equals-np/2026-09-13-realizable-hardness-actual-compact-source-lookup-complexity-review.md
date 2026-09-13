# ActualCompactSourceLookup complexity review

Verdict: **GO-WITH-NOTES**, for the binary extraction/equality primitive only. No blocking complexity or quantifier issue found in the reviewed statements.

Date: 2026-09-13. Route: S3131 / S3132 / S3137. Reviewer: occurrence_gadget_author.

This reviewer did not author ActualCompactSourceLookup, ActualSourceNormalization, or Materialize. The reviewer previously supplied the Normalization complexity/nonclaims reviews and authored separate Allocation, Counts, Completeness, Cloud, Ordinals and Prefix components. Those separate components are not direct imports of this pair. This review relies on previously accepted imported dependency evidence. Both present source lenses are by this same reviewer; they are separate analyses, not two independent people. The proof-adversarial lens was performed by a different reviewer.

Read the complete final main and Checks, imported SourceNormalization definitions, draft/build receipt and independent proof report/packet. Followed the planning formal-three-lens-closeout protocol. No compiler, source edits, Git mutation, or publication was performed for these lenses. Raw current source, author packet, independent JSON/MD and both independent logs were hashed. The dependency rebuild/provenance verification is relied on from the separate proof lens, not claimed as a fresh rebuild here.

Frozen source commit: `6a2bf297469a4306c189c8002996e6c4fe62c2ac`.

| Evidence | SHA-256 |
|---|---|
| ActualCompactSourceLookup.lean | `f9a4ef3052e254edb8bcef06525ad86cec3174b66fa1e60521f07e57b37c4906` |
| ActualCompactSourceLookupChecks.lean | `0488e76d5650b748b87608642e249d7411287a1b62cff77d63cb591aba861420` |
| Author verification JSON | `64e9898001ea505f13b929cf7233c28cf3228d3940b9fbf4d631715ff3712f1b` |
| Independent proof JSON | `6a18a673bacc31303fc3771564a65275d771e366fbce24eb8e86b8fd6d5c4be4` |
| Independent proof MD | `cb4e8a1afa5c4d48ba1b461a2861468655cfe0890e74816b478445886c325670` |
| Draft and author update receipt | `7ccada4dcbeca3a0a0d0c921a2db335c74328f615d22f4c4931a75d9b349f1f7` |

Sources are under `certifications/realizable-hardness/lean/PvNP/RealizableHardness/`. Author packet is under `certifications/realizable-hardness/.lake/build/actual-compact-source-lookup-author-20260913/author-verification.json`. Independent evidence is `2026-09-13-realizable-hardness-actual-compact-source-lookup-independent-proof-review.{json,md}` in this directory.

The independent packet records session 14164 actual pair exits [0,0], unchanged sources, 13 standard-only axiom profiles, four examples and three signatures. Two deprecated if_pos/if_neg warnings occur in main; Checks is clean. Its 2,623 original dependencies and seven receipts are distinguished from six current-only package exports and 180 source records. Historical package provenance is not strengthened by these source reviews.

## Exact function and encoding

Source is `List (Nat * (Nat * Nat)) * List Bool`. `tableFromWire = fstEnc` extracts the exact DataEncode row list from a canonical Source wire. `ownerLookup` uses the actual machine pair of that table and a unary query. Quotient by three chooses the row through posAt; remainder zero/one/else selects the right-associated triple field through fstEnc/sndEnc. `ownerLookup_correct` identifies the whole output with the Nat label's DataEncode serialization. It does not convert the label's magnitude to unary, substitute its bit length, or require distinct labels. Large numeric labels and repeated labels remain covered.

The FP theorems concern the very functions used in correctness, through the library's posAt, tuple projections, divC/modC and ifEqLen closure rules. There is no caller-supplied runtime certificate or assumed lookup equality. The noncomputable section is not an assertion of executable Lean evaluation; Membership.mem FP supplies the formal machine-class claim for these functions. This review does not infer practical timing or a particular polynomial exponent.

`equalityMark` compares complete bitstrings using eqFlag, then selectHead emits exactly [true] on equality and [] otherwise. Nat encoding injectivity transfers this to exact numeric equality. The equal-code-length 2/3 example addresses the bit-length trap; the universal encoded theorem is stronger than that example. Converting [false] to [] is essential for a later search that detects a nonempty hit. This pair performs that conversion explicitly.

## Clock, size and domain boundaries

`rowCount_correct` gives replicate m true; `slotClock_length` gives length 3m. The latter is only a length-clock theorem, not a theorem that slotClock's bits are all true. A future consumer must use the library's length-based clock interface or prove any stronger content requirement.

The query is q=3*r+i, an occurrence position, not the source label's numeric value. `slotCounter_lt` bounds it by 3m, and `lookupInput_length` exactly gives 2*|T|+2+q. The valid-query bound is therefore linear in actual table length plus row count. The pair proves no final whole-producer wire-size bound and no correctness for invalid row indices. FP totality is for arbitrary raw words; semantic correctness is for canonical Source/table encodings and valid Fin row/column indices. RHS row-count validity is unnecessary for table lookup. An empty table has no valid Fin row query, with total raw functions still defined.

## Remaining joins

No theorem here computes the first matching occurrence, joins that search to SourceNormalization.first, materializes normalized unary triples, preserves RHS through a whole encoded producer, or transports to the finite Allocation carrier. Those joins require their actual function equalities and FP proofs. In particular, the earlier unary-table Lookup/Scan route cannot simply be declared a compact-source producer without this construction. Source NP-hardness, encoded reduction correctness, and the complete paper theorem remain outside this verdict.
