# Independent Grassmann flag posterior proof review

2026-09-12. S3133 under the full S3126 realizable-hardness goal. Frozen candidate
`f1a11736a962a0096f42bc6997407c0b35bac57a`. Scope: companion
`GrassmannFlagPosterior` and `GrassmannFlagPosteriorChecks`, unchanged.

## Mathematical review

The restricted quotient map is an actual linear map from L to V/Q. Its kernel
is Q pulled back through the inclusion of L. Rank-nullity and the containment
Q<=L give dim(image)+dim(Q)=dim(L). This establishes the dimension shift used
by the quotient correspondence; it is not a dimension formula supplied as a
hypothesis.

`upperQuotientEquiv` maps actual containing d-subspaces to (d-a)-subspaces of
the quotient and back by preimage. Both inverse identities and both dimension
properties are proved. The premise a<=d controls natural subtraction. An
actual Q of dimension a already excludes a>dim(V); if d>dim(V), both sides of
the correspondence are empty, so omitting a separate d<=dim(V) premise is
sound. `card_upper` uses the quotient dimension identity and the previously
accepted actual Gaussian cardinality theorem. Thus the count is established
for each fixed Q, not inferred solely from an aggregate average.

The lower count is the accepted actual contained-subspace count. Finite double
counting establishes the Gaussian flag-product identity. The division lemma
explicitly requires its two Gaussian denominators to be nonzero. Its use in
the probability theorem discharges these from actual incidence-fibre
nonemptiness and a<=d<=J, rather than retaining nonzero counts as an oracle.

`insideAdvice` and `relativeUpperEquiv` transport flags inside an actual W
through the inclusion of W. The maps preserve containment, dimensions and
both inverses. Hence the relative count is an actual per-Q fibre count.

`containmentProbability` sums the existing uniform-d-subspace kernel over
ambient L satisfying Q<=L. Its count formula intersects this event with
L<=retained(s), the actual support of the kernel. Noncontainment of Q in the
retained space forces all summands to zero. Under a<=d<=J, the exact result is
Gaussian(d,a) times the existing a-subspace incidence kernel. This applies to
every draw; no assumption about a typical draw or independent posterior
coordinates is introduced.

`eventMarginal` is the actual prior-weighted event probability, and
`eventPosterior` divides the joint atom by it. The marginal factors by the
constant Gaussian(d,a). Positive event mass proves both factors nonzero before
cancellation in `eventPosterior_eq_conditional`. The result identifies this
particular fixed-Q containment-conditioned sampler with the existing
incidence posterior, atom by atom. The definition at a null event is zero and
the separate null theorem says exactly that; it does not assert a normalized
conditional probability for an impossible event.

No desired count or posterior identity is a premise, opaque theorem field or
new axiom. The source has no sorry, admit or native_decide. There is no false
uniqueness claim. The assumptions are jointly satisfiable: for beta=0 all
blocks are retained, and actual Q with a<=d<=J has positive containment mass.
The d=a example additionally checks that containment reduces to the original
kernel.

## Nonblocking boundaries

- The algebraic identities allow arbitrary rational beta. Their probability
  interpretation uses beta in [0,1], as required by the existing prior's
  nonnegativity theorem. This extra interpretation is not asserted for signed
  beta values.
- The sampler is specified by noncomputable finite sums and subspace types.
  No encoded, efficient algorithm or polynomial runtime is established here.
- This identifies a conditioning operation. It proves no KMS covering,
  total-variation proximity estimate, near-one relative Gaussian error,
  decoder correctness, full hardness reduction or learning corollary.
- The source's historical UNCOMPILED banners are conservative stale status.
  The exact candidate and independent evidence below determine this review.
- Four examples test elementary Gaussian endpoints, d=a and null events.
  They do not by themselves validate any quantitative asymptotic statement.

## Verification method

The new independent output root contains 47 copied ordinary prior outputs,
each verified against the original companion, geometry, density or
tail-exception independent receipt. The two new modules are exported into
that same namespace root. LEAN_PATH includes only that root plus pinned
dependency and core paths; author outputs and earlier review roots are absent.
All 11 package HEADs and manifest hash are checked, as is exact Lean version.
Each source is byte-compared with the frozen commit immediately before use.

The runner uses one Lean thread and measures actual available physical memory
before each module (at least 768 MiB), stopping only its owned process tree
below 640 MiB; disk space is checked separately. Raw compiler bytes and actual
exit codes are saved before decoding. Commands, environment, runner source,
source/output/log hashes, copied dependency hashes, profile order and examples
are retained in `2026-09-12-realizable-hardness-flag-proof-verification.json`.

No blocking statement, hypothesis, vacuity or axiom-leak issue was found.
The full S3126 proof and manuscript reconciliation remain incomplete.

## Result

**GO-WITH-NOTES.** Both independent Lean exports and runner session 28388
exited zero, with 16 ordered standard-only axiom reports and four successfully
elaborated examples. No failure or source repair occurred. Compiler released.
Receipt SHA256: `77ef3a76c4b39580885851cd5ff042e819ace4b9451540e4f4797c7c526e3470`.
