# ActualCompactSourceLookup nonclaims review

Verdict: **GO-WITH-NOTES**, for the bounded claims below. No unsupported full normalizer, hardness, novelty, or publication claim found in the final theorem pair and receipt's updated scope.

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

## Permitted statement

The component proves same-function FP membership and exact valid-query semantics for extracting a full binary-encoded Nat label from the actual compact source table. It also proves a same-function FP equality marker that is [true] exactly on label equality and empty on inequality, plus actual row-count/slot-clock length and query-input length statements. Repeated labels and rows are preserved. These are concrete prerequisites for a compact normalizer, not its completed implementation.

The imported Normalization module defines first-occurrence renaming and semantic violation transport. Importing it does not make normalize an encoded FP function. This pair supplies neither a normalizer producer nor a normalized-table materializer. The final source explicitly says first-occurrence search and table materialization are not implemented. Future separately authored sources or pending builds are not certified by this review.

## Wording notes

The main header and initial receipt still say uncompiled draft; the receipt's Author build update and independent packet supersede that historical status for this exact pair. Report it as independently compiled at the frozen source, while retaining those historical draft records. The author packet's null final-freeze field is prefreeze metadata; the separate source commit and independent frozen identity establish the reviewed version.

The receipt phrase describing slotClock as 3m marks is safe only in its explicit 'in length' sense. The formal theorem states length, not all-true content. Do not describe lookup as equality of encoded lengths: only dispatch compares the unary remainder length, while equalityMark compares full label codes. Do not state malformed raw inputs are validated; only total raw function behavior and canonical-input correctness are supplied.

No whole-source polynomial-size producer, finite-carrier bridge, full reduction, upstream source gap hardness, P=NP or P!=NP result follows. No novelty, quantum algorithm, publication readiness, or completed paper proof follows. Acceptance here concerns this component under the previously accepted library dependencies, with the recorded current-only package provenance limitation. Full theorem completion and eventual consolidation remain separate actions.
