# Actual L transfer after zoom-out: source draft

2026-09-12. S3134/S3137 under S3126. **UNCOMPILED.** No author compiler,
independent review, Git action, publication or completed full theorem is claimed.

## Exact manuscript dependency

The inspected manuscript lines393-423 require transferring bounded L scores
from uniform ambient L conditioned on Q contained in L contained in W, to the
experiment that first draws V from the actual posterior V given Q and then
draws uniform L inside V conditioned on Q contained in L contained in W.
This draft implements that existing dependency, without a novelty claim.

`ambientW`, `deletedW`, and `retainedW` further condition the already defined
`ConditionedCovering.ambientConditional`, `deletedConditional`, and
`retainedConditional` on the actual event L contained in W. `posteriorMixture`
uses the actual `GrassmannIncidence.conditional beta Q` for V, not the
unconditional deletion law. At a zero event fibre, `retainedW` is zero.

## Full scripts and constants

`condition_mixture` proves exact finite disintegration with null fibres handled
by nonnegativity and their zero event mass. `deleted_event_eq_normalizer`
identifies the actual deleted L event mass with the actual V reweighting
normalizer. `exact_disintegration` then expresses deletedW as the mixture of
retainedW under the exact `ZoomOutPosterior.reweighted` law. No desired joint-law
identity or closeness estimate is supplied as a hypothesis.

`condition_tv_mul_le` instantiates the accepted fibre-TV argument with an
indicator kernel. If both event masses are positive it proves

    P(event) * TV(P|event,Q|event) <= 2*TV(P,Q).

The actual ambient lower bound P(event)>=p0/2 and GoodAdvice's actual
conditional L distance <=qdecay100 therefore give further-conditioned TV
<=4*qdecay100/p0. A finite bounded-score inequality gives a contribution
<=8*qdecay100/p0. The exact disintegration reduces the other score difference
to the posterior reweighting score bound

    4*eta + 8*zeta/p0 < qdecay12.

`total_error_small` proves their combined error is strictly below qdecay10
for h>r and c<=r. It uses the existing actual-family zeta/p0 estimate, not an
assumed final error or a replacement p0. `eventual_transfer` chooses a common
threshold after fixed natural A>0,r and instantiates all these pieces for every
later h, every a<=r, every actual Q outside GoodAdvice.bad, and every W containing
Q with actual codimension <=r. Readiness, tails, event positivity, closeness and
final-error budgets are discharged; they are not final theorem premises.

The final Conclusion includes ambient event lower bound, deleted event
positivity, explicit further-conditioned TV bound, exact disintegration and
the strict comparison for every rational score in [0,1]. `conclusion_event`
specializes to Boolean events, and `conclusion_score_real` casts exactly to
the manuscript real decay10. `conclusion_mass_defect` specializes to the
constant-one score and explicitly bounds the lost mass from null retained
fibres. The unweighted posterior mixture is not falsely declared normalized.
There is no union over W and no posterior-independence assertion.

## Dependencies and status

The sole direct import is ZoomOutPosterior, which transitively supplies
GoodAdvice, ZoomOutParameters, ZoomOutIncidence, GaussianNearOne, the actual
ConditionedCovering disintegration, and finite PosteriorReweighting. Its source
was initially inspected during its author compile; root subsequently reported
independent pair exports green, while final three-lens acceptance remains a
separate gate. This draft claims no transferred acceptance from that dependency.

Only these new files and this receipt were written:

- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ZoomOutTransfer.lean`
  SHA256 `a2252b1308cf7c1e5d039db137edcad075b9e1fb700f02eddb1042fe83cbbd27`.
- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ZoomOutTransferChecks.lean`
  SHA256 `35affa1bd54911d41004af8b3ec045f05c6fc5df2f6ab5e237c9d0e8e264646e`.

21 planned axiom reports and 9 examples are UNRUN. Examples cover zero
distributions, impossible events, normalized singleton conditioning, zero-fibre
gated mass, the conditional-TV inequality and numerical endpoint bounds. No
sorry, admit, new axiom or native_decide is introduced. Full proof scripts are
present, but elaboration/API repairs may be needed before any kernel claim.

## Remaining full-goal work

This is an L-distribution transfer, not the decoder-success theorem. It does not
prove the MZ decoder or clique-selection interfaces, agreement events supplied
by those results, PCP construction, machine encoding, randomized polynomial-time
reduction, fixed-L hardness assembly, exact learning transfer, or full manuscript
reconciliation. Those dependencies and independent review remain required
before full certification or announcement.
