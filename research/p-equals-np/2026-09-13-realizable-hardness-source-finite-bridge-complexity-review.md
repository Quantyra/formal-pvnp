# FiniteBridge complexity review

Verdict: GO-WITH-NOTES for the bounded source semantics. Independent proof/build
is separately recorded in the sibling proof review and portable JSON.

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

The concrete gap discharged at source level is the mismatch between unbounded
compact Nat labels and the finite generalized occurrence instance. First
occurrence positions produce available names Fin(3m); the construction never
expands the original maximum binary label to unary or requires that maximum to
be polynomial in m. Repeated positions survive, including the three-equal-label
Checks example. Unused normalized names do not create source equations or affect
the assignment transport.

The exact flag lists and counts are preserved both from original Nat assignments
to finite assignments and from every finite assignment back to the original
source. Thus conditional source count promises transfer with no count loss at
this bridge. no_count_transfer explicitly assumes the universal source NO
promise. It does not derive NP-hardness or a PCP source family, and arbitrary
real delta in this count inequality is harmless. Later positive gap-ratio
statements must retain their own m>0 and coefficient assumptions.

sourceTriples_eq_unaryRows identifies the ordered concrete finite table with the
existing normalized unary table. tableFn_eq_serializedSource joins the actual
producer's TABLE output to Lookup's TABLE input. This gives a semantic join to
an existing raw FP function, but the pair declares no same-function whole
finite-instance FP theorem. A finite carrier cardinality of3m alone proves no
runtime bound. Likewise semantic assignment restriction/extension is not a
machine-level decoder certification.

The remaining full Boolean RHS wire roundtrip/sourceFn-to-full-finite-source
identity belongs to WireBridge. Global occurrence/gadget row production,
serialization-to-finite-output agreement, total encoded constructor FP,
upstream hardness and final theorem composition remain separate. Per-owner
GadgetRowProducer is only an uncompiled archival candidate, not closure of those
obligations. No quantum speedup, P-vs-NP result or novelty is inferred.

Independent-build update: actual33913 main0/Checks0, no warnings or source changes;
portable sibling JSON b25c2db1f86d58f6e0e994fa5d9b5e566222c1689d654f45c254f0edf36e8474.
This later evidence does not expand this lens beyond the finite/table bridge.
