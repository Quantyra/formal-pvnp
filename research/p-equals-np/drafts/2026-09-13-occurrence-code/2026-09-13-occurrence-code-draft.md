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
