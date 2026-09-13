# FiniteBridge independent proof-adversarial review

Verdict: GO-WITH-NOTES for this bounded finite bridge. Independent main and
Checks both passed unchanged. The earlier source-phase INCOMPLETE verdict is
superseded by the actual independent build recorded below.

2026-09-13. S3131/S3132/S3137. Reviewer: incidence_complexity_review.
This agent did not author or repair FiniteBridge. It authored imported lower
FirstOccurrence and related Degree/Scan components, plus subsequent Code,
CountFP and GadgetRowProducer work. Prior independent acceptance of lower
components is explicitly relied on; this is not self-review of those components.
The same reviewer provides all three separately labeled lenses. These are not
three independent people. The finite source author prepared the fresh build
closure only; that preparation does not substitute for this review or for a
later independently run compiler pair.

Reviewed frozen a716bf1750f3ca51dfbf873cd5a003ee8b341240, raw bytes equal frozen
bytes for main08a248f3081cca00a94521a94e7b13e2f84cba2c18689386cadaaf962dd94a3f,
Checks8c9584966321f323ab42e1821c86fae29869d862d4e5477b48a33ce32f562833,
and author receipt9b69d973117a5376b2d7f178a4794197e4f222bfbae191305a6369ee2fcd2551.
Source paths: drafts/2026-09-13-source-finite-bridge/ActualSourceFiniteBridge{,Checks}.lean.
Full main, Checks, author receipt and relevant Normalization/Completeness/Lookup
and NormalizedTable definitions/statements were read. Author packet
certifications/realizable-hardness/.lake/build/actual-source-finite-bridge-author-20260913/author-verification.json
rehashes to c1b3d0a23fcabdad280a13fed7a91813bbc3529fd1e09056aacd64855cd212b0
(118777761 bytes). Its final_source_freeze=null is historic prefreeze metadata;
the independently checked actual final commit above supplies final identity.

The constructor fields are derived, not assumed: normalized_label_lt uses actual
row membership and first-index bounds; instanceOf supplies only vars/rhs to the
generalized Allocation structure. Valid is exactly equality of row/RHS lengths,
which justifies the same indexed RHS. No distinct-label, source-size-by-maximum-
label, decoder-law or transport-law premise appears.

instance_flags_restrict compares complete lists by length and each index. Valid
prevents zip truncation from losing a source row. All three positions remain
three ZMod2 summands, even when owner labels coincide. Counting is obtained from
these flag equalities, not from an existential witness or an assumed optimum.
Lift uses the already proved normalization lift; decode extends each finite
assignment to Nat by zero outside the finite carrier, then uses normalization's
actual decoder. restrict_extend is enough: there is no false claim that arbitrary
assignments on unused names are mutual inverses. Empty input has Fin0 functions
without manufacturing a Fin0 element.

YES transfer retains its supplied witness/count premise. NO transfer quantifies
over every Nat assignment and specializes it to the actual decoded finite
assignment for every finite b. No positivity restriction on delta is needed for
this exact count transfer; later fractional soundness has additional positivity
and nonempty-input requirements. The table join is exact row order and DATA
right-associated unary triples, not a permutation or equal cardinality.

Author actual outcomes [1,0,0] were read from its packet; all three raw log hashes
were rechecked. Successful main is silent, Checks reports16 standard axiom
profiles,5 examples,4 signatures. Failed parser recovery is retained and is not
accepted proof evidence. Repairs only quote variable and disambiguate normalize.
No source sorry/admit/new axiom is present. These observations remain AUTHOR
evidence, not this reviewer's independent execution.

Fresh independent preparation was supplied by the finite author. Reviewer read
the full runner: explicit authorization gate, source pins, original receipt/copy
rehashes, current exceptions,11 package pins/manifest,1380 fallback exclusions,
thread1 and768/640MiB guards. No compiler was launched in this source phase.
The subsequently authorized independent execution is recorded below; the
source-only phase and its conditional pregrant record remain preserved.

No whole RHS wire roundtrip, executable regularized constructor, upstream source
hardness or full paper theorem is certified here.

## Independent execution and portable closure

Original session33913 returned actual terminal exit0. MainPID7780 exited0 and
ChecksPID456 exited0, with no source changes, errors, warnings or guard stop.
One thread,768MiB preflight and640MiB owned stop guard remained unchanged.
Physical-memory minima were1336479744 and1299279872 bytes. Checks produced16
profiles, each exactly propext/Classical.choice/Quot.sound,5 examples and4
signatures. Main output SHA256 f6199233c3efc087fbdc74bfddbcce175e051a82835ba2fedde13ea4af49fdf5;
Checks8c054fce23cc2e1f358eeb4943445d1277f9ea0db313f8425e68f00df3d5f441.
The successful main log is empty; Checks log SHA256
e68b49046a41291f9551905bc4af772aae4d030e0a364a8f496d195f2b6ba4a0.
Compiler was explicitly released after the same33913 terminal was obtained.

Fresh original2632 exports/copies,13 original receipts,15 explicitly current-only
package exceptions,180 current/original source records and11 package pins plus
manifest were rehashed by this reviewer before and after compilation. Pinned
Git source comparisons explicitly normalize CRLF to LF; raw source/receipt/log
hashes never do. The two target sources equal final frozen raw bytes. All1380
fallback paths remained absent, and no author FiniteBridge target output was
used. Source-author closure preparation is disclosed above; the independently
executed runner and reviewer preflight/postflight are distinct evidence.

Portable JSON sibling SHA256 b25c2db1f86d58f6e0e994fa5d9b5e566222c1689d654f45c254f0edf36e8474,
114926727 bytes, retains raw runner/plans/authorization/release conditions,
source snapshots, logs/metadata, originals/copies/receipts, current exceptions,
pins and exact final commit. Runnerc31174ae62dd7d3f0fbb745455e56553ff65de3197e8ad72fb258ed3a79dec0c;
preserved pregrantc4ffdeff7406d283f9b1dc166064949bd3c81c85fc9559df3b34521e9d2ddc7c;
authorized plan421d1189626db521166d00686234e861b25f28ba64ee1285942729c82ec1ad38.
The CountFP owner release and fresh capacity3459788800 preceded authorization.
Finalizer noncompiler55486 exited0 after all postflight checks.

| Lens | Verdict | Evidence limit |
|---|---|---|
| Independent proof/build | GO-WITH-NOTES | Actual33913 pair0, bounded finite/table bridge only. |
| Complexity | GO-WITH-NOTES | Separate source review; no full constructor FP or hardness. |
| Non-claims | GO-WITH-NOTES | Separate source review; no complete wire/paper conclusion. |

All three lenses are by this one disclosed reviewer; root closeout remains a
separate decision. No Git mutation, live insertion or public action was performed
for these review artifacts.
