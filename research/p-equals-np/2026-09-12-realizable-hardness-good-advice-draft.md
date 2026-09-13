# Actual good-advice composition: source draft

2026-09-12. S3134/S3137 under S3126. **UNCOMPILED.** No compiler, Git,
public action or independent review was performed for this source draft.

## Exact target and evidence boundary

This composes the existing manuscript's parameter/posterior argument, paragraphs
in `realizable-cmmsa-hardness/paper/submission-manuscript.md` lines304-383.
It is the already selected realizable-hardness dependency route, not a new
scientific mechanism or novelty claim. The exact sampler is
J=2^(2^(A h^2)), beta=A h^2/J, for fixed natural A>0 and fixed natural r.

`GoodAdvice.bad` is the Boolean union of the existing actual lowMarginal and
badTail events (`AdviceExceptions.exceptional`) and the actual badZoom event
from `ConditionedCovering` at d=2h. Its mass is measured under the existing
uniform `PosteriorDensity.ambientMass` on actual a-subspaces. The rational
cutoff `zeta h=(1/2)^(30*h^2)` casts exactly to `DropTailParameters.decay 30 h`.

The script for `eventual_good_advice` chooses one common threshold from the
accepted sampler tail threshold, accepted proximity readiness threshold, and
r+1. For all later h and all a<=r it derives a<2h, d<=J, strict actual bad-union
mass <decay20, and the following properties for every actual Q outside it:

- ambientMass Q/2 is positive and bounded above by actual adviceMarginal;
- actual adviceMarginal is positive and the actual conditional deletion tail
  at T=h^4 is at most rational zeta;
- actual containment-conditioned L total variation at d=2h is at most decay100;
- the actual deletedConditional L distribution sums to one;
- every positive-prior draw with D<=T has actual posterior/prior density at
  most 8*2^(2aT);
- each fixed W containing Q with codim W<=r has actual posterior rank-failure
  probability at most 2*zeta.

No closeness, small-tail, readiness, or actual exceptional-mass premise occurs
in the final family theorem. Intermediate composition lemmas expose their
numerical premises for modular checking; the final theorem discharges them
from fixed A>0. Strictness of the union bound uses the accepted
`SamplerProximity.ready_exceptional`, not a claimed strict individual estimate.

## Actual rank-failure bridge

The necessary bridge already exists and was inspected:
`PosteriorDensity.fixed_subspace_failure_transfer` bounds the event
`SubspaceRestriction.codimInRetained W s != SubspaceRestriction.codim W`
under the actual `GrassmannIncidence.conditional beta Q`. Its proof uses the
accepted unconditional arbitrary-subspace rank bound and actual posterior
density/tail transfer. GoodAdvice composes this with `ready_density` and the
good conditional tail. Natural subtraction in 2^codim(W)-1 is explicitly cast
using 1<=2^codim(W).

There is no assumed rank-failure estimate. W can depend on the fixed Q but is
fixed before the subsequent conditional draw s. The bound is for each W;
it does not assert a union over W or posterior independence. The intermediate
rank-failure lemma actually needs only codim W<=r; the final Properties exposes
the manuscript's W containing Q interface.

## Owned files and planned checks

Only the following two new source files and this receipt were written:

- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/GoodAdvice.lean`
  SHA256 `00b3adf4bf1d72b97b01954c585bd2eccd0a990710c9e28f8353fb8dae07a27d`.
- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/GoodAdviceChecks.lean`
  SHA256 `e53d9861b0cbe41e3bb728ffe7c6dcb18187591c6c704969ec094e7fa10da967`.

12 planned axiom queries and 8 examples are **unrun**. Checks cover zeta at zero,
positivity and exact cast, the excluded zero-A sampler, the nonvacuous A=1,r=0
final eventual statement, zero-prior atoms, fixed-W actual event transfer and
extraction from the concrete union. No sorry, admit, new axiom or native_decide
was introduced. Source-only inspection is not kernel evidence; elaboration or
API repairs may still be necessary.

The new module imports accepted SamplerProximity and ConditionedCovering only.
It does not import the new GaussianNearOne or ZoomOutIncidence pair. No accepted
source, aggregate, toolchain, manifest or other configuration was changed.

## Remaining scope

Author compilation and the three independent review lenses remain required.
This composition supplies neither the subsequent zoom-out conditioning and
mixture reweighting estimate nor any specialized PCP/decoder theorem, encoded
randomized polynomial-time reduction, fixed-L assembly, exact learning
transfer, full hardness certification or final paper reconciliation. It is
not a P-vs-NP resolution or announcement-ready certification.
