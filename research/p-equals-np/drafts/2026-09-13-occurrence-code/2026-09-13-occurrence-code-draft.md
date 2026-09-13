# ActualOccurrenceCode structural bridge draft

2026-09-13. S3131/S3132/S3137. SOURCE ONLY, UNCOMPILED. Archived outside the live
generalized consumer closure. No compiler, Git mutation or live source edit.

Main SHA-256: `dae60a33b4b4cc6a1f3a09538c95c98d6ee38f1a7af26852803d7fca7931854f`.
Checks SHA-256: `df3c3933cd9cc269d51d57c8a4a63e7e6d2d1b099bd71ca1c8556b5898a27cdc`.

This implements the explicit structural bridge prescribed by frozen constructor
audit3d661a94. It imports ActualRegularization and DataEncode, using the actual
Allocation.GlobalVar, rows and predicates. A future build must use the accepted
generalized closure; existing restricted-interface binaries are not evidence
for the broader source domain. CountFP remains separately archived/uncompiled.

## Exact representation

VarCode is the right-associated product
`U * (Bool * (U * (U * (U * U))))`, U = List Bool. All five numeric fields are
true-mark unary words. Port codes contain owner, false, ordinal k, port j,
empty, empty. Internal codes contain owner, true, the source vertex k and port j
of the actual representative dart, its dart label, and the fresh internal index.
Parallel copies retain their full dart identity. No unordered endpoint or dense
renumbering replacement is used. These are output variable names; the original
compact source representation is unchanged.

codeVar injection is proved from owner-word equality, the Bool tag, all numeric
coordinates, Fin.ext and subtype extensionality. No injection law or decoder
correctness is a premise. variableWire uses the existing composite DataEncode
instance, whose injection composes with codeVar. RowCode is exactly the ordered
right-associated triple of VarCodes paired with a Bool RHS. rhsBool is decide
(b=1), with its ZMod2 roundtrip proved by the existing concrete Bool equivalence.
codeRow injection also preserves RHS, and codeRows is the actual I.rows.map,
with explicit ordered row-index equality, length and Nodup preservation.

## Semantic transports

restrictAssignment evaluates a code assignment at codeVar. extendAssignment
chooses the unique preimage of a code when one exists and uses zero outside the
image. Its roundtrip follows from derived injection. This choice-based function
is a semantic assignment extension, not a runtime decoder or serialized producer.
The draft proves ordered bad-row flag list equality and exact countP violation
equality for arbitrary code assignments and, in the other direction, every
actual finite assignment. Three parity positions remain three summands.

The actual RowCode support is shown equal to the injective map of the finite
row support. This transports support cardinality3 and pair intersection<=1.
Degree is countP of membership in the actual codeRows list. At encoded variables
it equals actual finite degree; outside the image it is zero, yielding degree<=4
for every code. These are actual-list statements, with no supplied counting or
freshness premise and no deduplication of source positions or parallel edges.

Checks requests26 axiom profiles,7 examples,4 signatures: variable collision,
both assignment/count transports, all-code degree, RHS roundtrip, complete
internal dart identity, and empty rows. These are source requests, not compiler
observations. No sorry/admit/native_decide or new axiom declaration was added.

## Remaining boundary

No mathematical obstruction identified from the inspected APIs. Dependent
Sigma/product reduction, finite-image membership and Boolean countP coercions
still need elaboration checks; source plausibility is not kernel acceptance.
No separate reduction source-validity or hardness law is assumed here.

rowsWire names the desired DataEncode output of the actual mapped list; it is
not a polynomial-time machine that emits it. The executable anchor/original-row
producer, occurrence count and rotation joins, representative filtering and
four-row gadget emission, whole output materialization, size/runtime bridge to
the compact input, independent reviews and final theorem composition remain.
There is no full constructor FP, source-hardness, learning, PvsNP, novelty,
publication or complete-paper claim.

## Author build update, 2026-09-13

The earlier source-only status above is historical. Author85503 main1 followed
by3273 main0/Checks0 establishes an author-green isolated pair; independent
acceptance remains pending. Actual outcomes[1,0,0], all raw attempts/snapshots
preserved. Final isolated main dd20ce025431950d6d348d7744b120c70ad3bdea14502009d6313990493f18e9;
Checks df3c3933cd9cc269d51d57c8a4a63e7e6d2d1b099bd71ca1c8556b5898a27cdc unchanged.
Repairs only reverse the Bool contradiction, simplify the explicit mapped-list
length, apply propext to proposition equality, and replace a deprecated lemma
spelling. Mathematical definitions, targets, assumptions and full dart identity
are unchanged. Successful pair warning-free;26profiles(25standard3,unary injection
propext only),7examples,4signatures. No new axiom/sorry/native_decide/heartbeat
escalation. Compiler explicitly released after3273 actual terminal0.

The original331 archive and original receipt are preserved in Git and raw build
snapshots. Portable immutable author packet at
certifications/realizable-hardness/.lake/build/actual-occurrence-code-author-20260913/author-verification.json
SHA2567648d6d61f784a1b4df9da3b071bc2518e8154658697de3bbe2e0c20a593114e
(39920045bytes) retains final_source_freeze=null as prefreeze metadata. It records
2630 original/copy artifacts,9receipts,9current exceptions,178source pins,11package
pins,264fallback exclusions, all raw logs/metadata and the exact proof-only diff.
Its author-verification.md companion SHA256
cd4eca062ccd1848c60877d370cce6b59daaca72f8771249219eca2aeae9292c
states the full provenance and nonclaims boundary. Two noncompiler Unicode
console-display failures are distinguished from actual Lean outcomes.

This proposed receipt is prepared outside the archive for root review. Final
copy of the repaired main and this receipt into the archive is pending an exact
root grant; no final source commit is inferred from the old331 baseline. The
later actual final commit must be recorded separately from the immutable packet.
The current increment is structural code/semantic assignment and row transport
only, not executable producer FP. Independent lenses, full constructor and
upstream hardness/final theorem/paper remain open.

## Final archival copy completed, 2026-09-13

Under the root exact3 archival grant, final isolated main dd20ce025431950d6d348d7744b120c70ad3bdea14502009d6313990493f18e9
was copied byte-for-byte into this archive; Checks df3c3933 remained unchanged.
This paragraph supersedes the pending-copy wording above. The proposed receipt
preserved the original331 receipt as an exact byte prefix; the original source
and receipt remain available at331d3a0c and in the raw author evidence. The
immutable7648d6d6 author packet remains prefreeze with final_source_freeze=null;
the actual final archival commit is supplied separately. Root verified20 raw
packet records, successful outputs, the exact proof-only repair and26profiles;
that root check is not claimed to be a fresh full2630-dependency rehash.
Independent preparation/review remains separate. No new compilation, live
insertion, independent acceptance, executable-producer FP or public action is
claimed by this archival preservation.
