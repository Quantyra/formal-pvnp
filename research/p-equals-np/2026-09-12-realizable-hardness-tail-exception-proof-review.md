# Tail and exceptional-advice independent proof review

2026-09-12. S3133 under S3126. Frozen candidate
`5401443679c5f35178e4dcbdca170d9523e13360`.

Review scope is exactly the companion `DropCountTail`, `DropCountTailChecks`,
`AdviceExceptions`, and `AdviceExceptionsChecks`. This is a bounded proof
component; it does not certify full realizable CMMSA hardness or the learning
corollary. Sources were not edited. Final build evidence and verdict are in
the accompanying `2026-09-12-realizable-hardness-tail-exception-proof-verification.json`.

## Statement and dependency review

The drop count is the existing number of singleton choices in the actual
finite triple product draw. Its tail is the real cast of the actual rational
mass of `T < dropCount`. The exact exponential moment is derived by finite
product expansion from `blockMass`, whose three singleton atoms sum to beta.
No binomial-distribution assertion or moment bound is an input hypothesis.
The exponential envelope requires beta in [0,1]; the tail bound additionally
requires nonnegative tilt. Optimization requires 0 < J beta <= T, which
justifies the logarithm and every denominator. The zero-mean extension proves
the actual tail is zero when either J or beta is zero. T=0 uses natural-power
0^0=1. Beyond-support and empty-draw cases are also actual zero-mass proofs.
The strict integer event is weakened to D>=T only in the upper bound; there
is no reversed strictness or missing endpoint.

The TV definition is exactly half L1. The event inequality is derived from
equal normalized masses, and even remains algebraically valid for signed
weights. Consequently the absence of beta-range hypotheses in the standalone
event-transfer and low-marginal lemmas is intentional, not a probability
normalization omission. Their probability interpretation still requires the
usual beta range. The combined Markov/union theorems do require that range.

The posterior-tail expectation invokes actual finite total probability with
the actual prior and incidence kernel. The imported proof handles zero
marginals by proving their joint atoms zero; it does not cancel a possibly
zero denominator. The new module also proves null conditional tails zero.
The condition a<=J ensures a nonempty incidence fibre for every draw, hence
normalization. Positive zeta justifies Markov division. No posterior
independence or all-subspace union assumption is used.

The final bound is for the union of precisely two defined events:
P'(Q)<P(Q)/2 and conditionalTail(Q)>zeta. Their uniform mass is at most
priorTail/zeta + 3 TV(P,P'). The good-advice conclusion follows from actual
nonmembership, with equality included in the good set. The Chernoff version
substitutes the derived actual tail. Neither desired event bound nor a
small-TV assertion appears as a hidden theorem premise.

## Nonblocking limitations

- The actual TV proximity estimate and the specialization J beta=A h^2,
  T=h^4 giving the required tiny tail are still open obligations. The result
  can be numerically larger than one; no small exceptional set is established
  merely by compiling this symbolic inequality.
- The two-event union excludes any separate KMS/zoom exceptional event.
  Module wording about a complete union must be read in this exact scope.
- Checks cover endpoints, normalization, strict equality and theorem
  instantiation. The displayed positive-mean numerical Chernoff examples are
  loose and are not evidence of the manuscript asymptotic decay. There is no
  unsatisfiable global premise hiding the theorem: the probability range,
  a<=J, zeta>0 and mean<=T are jointly satisfiable, and actual finite mass is
  defined independently of the conclusion.
- Noncomputable finite enumeration and classical choice provide mathematical
  statements, not a polynomial-time sampler or encoded reduction.
- Historical UNCOMPILED comments are conservative stale status banners;
  the exact candidate and accompanying independent receipt govern this review.

## Independent verification method

Copied 43 ordinary outputs from the accepted density-review directory, checking
each SHA256 against the original companion, geometry or density receipt.
Exported the four new modules into the same new namespace root; neither author
outputs nor prior independent roots occur in LEAN_PATH. Checked all 11 package
HEADs against the pinned manifest and the exact Lean version. Working source
bytes were compared with the frozen commit before each export.

The new runner checks actual available physical memory via
GlobalMemoryStatusEx (768 MiB before a module, owned-process stop below
640 MiB), as well as free disk space. The earlier density runner used a disk
space guard only; this review does not retroactively certify its memory guard.
Raw compiler bytes and actual exits were saved before decoding. One Python
post-export validation assertion compared qualified query names to basenames
and failed after two successful Lean exports. The corrected validator accepted
the existing exact logs/artifacts and resumed only the two remaining modules.
Both runner sources and this harness failure are retained in the receipt.

No blocking proof, vacuity, hypothesis, uniqueness or axiom-leak issue was found
in the reviewed mathematical statements. Full S3126 remains incomplete.

## Result

**GO-WITH-NOTES.** All four independent Lean exports exited zero; all 36
ordered axiom reports use only subsets of propext, Classical.choice and
Quot.sound; all 20 examples elaborated. Session 21717 finished EXIT0 after
the preserved session 72502 validator-only failure. No Lean sources changed.
Compiler released. Receipt SHA256: `abb50b0223f29c892d7a7cbb4b142305d8d343f98f9f720587edf7191f58b15f`.
