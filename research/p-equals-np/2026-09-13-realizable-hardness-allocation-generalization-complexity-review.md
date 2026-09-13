# Generalized Allocation full consumer closure: complexity review

2026-09-13. S3131/S3132/S3137. Verdict: **GO-WITH-NOTES** for the proposed
broader finite construction and its unchanged conditional contracts.
This is a source audit, not an independent compiler certification or live promotion.

## Scope, identity, and independence

Read all ten overlay main modules and their ten Checks: Allocation, Counts,
Degree, Lookup, Ordinals, Completeness, Prefix, Scan, Soundness, Regularization.
Also read the proposal patch, dated draft and closure receipt, and the concrete
cloud embedding/local-terminal uniqueness dependency. All twenty overlay hashes
match the author inventory; the eighteen consumer sources equal current source
bytes exactly. The two modified sources are:

- Allocation: `b8e813395f689f0b4cb24ce306d1e8d99655ff35fd8e2bd261c16ed95a967972`.
- AllocationChecks: `ab7302cf72b4c544df46e3cc6642c5d78b30599ca7886f6904cf3dcf121ee171`.

Proposal freeze `077188bce47957a5b6c016bffc0e09e6f463b2be`; patch SHA-256
`9d83cca6b0b87a21edd93c2b12737715d4519bf01e1a97af9696085305b4f993`.
Author `closure-verification.json` SHA-256
`c5d765093cc569252118c622af1e6a6aa37a7fdfbb8ca3330ae672b62ac162da`, under
`certifications/realizable-hardness/.lake/build/actual-allocation-generalization-author-20260913`.
The closure receipt's current raw SHA-256 is
`41b46a3ba754acfe7d40228c794f4aabb4bab9208830c3b7ead4a6d2b3a965d2`.

The same reviewer wrote this and the separate non-claims report; these are two
lenses, not two independent people. The reviewer authored old Degree and Scan,
not the generalized Allocation patch. Prior independent acceptance of those
dependencies is relied on; reviewing their reuse here is not fresh independent
authorship separation for those old modules. The separately assigned fresh
generalized proof reviewer must supply independent build/proof evidence.

## Repeated-owner semantics

Removing `Instance.distinct` broadens the input domain. `Slot m` remains the
row-position pair. Filtering slots by owner does not deduplicate labels; ordinal
and recover make anchors injective even for equal owners within or across rows.
The explicit all-three-positions-same-owner example has three distinct output
anchors and support cardinality three.

The replacement intersection argument is concrete: a gadget row contains at
most one cloud port, proved by unpacking actual support and the fixed gadget's
`local_terminal_unique`. Its other vertices are tagged edge internals and have
`recover = none`. Original anchors have nonempty recovery, so two members of an
original/gadget intersection must be the same port. It never infers equal
positions from equal owners. Parallel edge copies retain their edge identities.

Counts still enumerates actual original rows followed by every tagged cloud row.
`rows_nodup` concerns generated equations with distinct anchors; it does not
deduplicate repeated source equations. The violation predicate explicitly adds
three ZMod-2 values. Repeated values cancel or persist according to that sum,
not according to a support set. Completeness equates actual violation counts
for one global extension. Soundness charges a changed row to a source slot and
injects slots into minority ports via anchor injectivity; owner collisions do
not break either injection. All-port cloud majority still includes dummy ports.

## Constants, quantifiers, and computation

With fixed D = FixedPortCycleFamily.degree and E = edgeCount, the same output
has T = m + 4E, m <= T <= (1+18D)m, 3Dm+5E variables <= 26Dm, and actual list
degree <= 4 (hence <= 10). Unused/empty clouds remain covered; fractions require
m > 0. Lambda = min(1,kappa) stays positive and fixed. For delta >= 0 the NO
fraction remains lambda*delta/(1+18D), under the explicit promise that EVERY
source assignment violates at least delta*m equations. Positive gap additionally
requires delta > 0. The YES fraction uses eta >= 0 and a source witness. No
promise is discharged by generalizing Allocation; Certificate constructs the
same output fields rather than assuming an output contract.

Ordinals/Prefix retain exact row-major ordering and prefix equality. Lookup and
Scan retain FP for their same raw functions on the supplied serialized unary
owner table and unary query. Repeated owners merely cause additional earlier
matches. Neither theorem proves efficient production of that table from compact
binary labels or an arbitrary Fin-N instance. No N <= poly(m) premise has been
introduced, and no such bound may be inferred.

The genuine discharged interface obstacle is the unnecessary distinct-owner
input condition. Remaining work includes compact normalization's finite bridge,
the full encoded table/construction producer with FP and wire bounds, upstream
source hardness and final theorem composition. Author-reported twenty-module
green is compatibility evidence only here; independent verification and root
promotion remain separate. No novelty, publication, or complexity-class result
is certified by this review.
