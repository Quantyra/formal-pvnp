# Zoom-out incidence: complexity review

2026-09-12. S3134 under S3126. Top-level complexity-theory-reviewer.

**Verdict: GO-WITH-NOTES for the actual conditional-event/count identity.** This connects the existing probability laws to the Gaussian ratios needed downstream; it does not establish the posterior-weight bound or complete hardness theorem.

## Evidence and scope

Reviewed the complete ZoomOutIncidence main and Checks, the dated draft receipt and its superseding author appendix, and the manuscript zoom-out paragraph previously inspected in this review sequence. The planning three-lens protocol and supplied satellite boundaries apply. No compiler, source change, Git mutation, public action or nested agent was used.

There is no source diff against freeze `4b361a35e9d436ab51d75da0cedcea64cfeb2f9c`. Current CRLF source SHA256 hashes match the author appendix: main `281500bcebaf267fd388922900c531b0bad14c8695669cb3f885451dd4f6e9df`; Checks `b4eef993a58200edcece88b0abb2bb6b3a908afa8b25236020e6e982a89922de`. Git's LF-normalized blob identity is distinct from these working-file byte hashes; this report does not conflate them. The author appendix records retry 90183, both exits zero, fourteen standard axiom profiles and nine examples. The orchestrator reports independent session 58388 with both exits zero; detailed export/log validation belongs to its separate proof receipt, not this complexity lens.

## Identity and domain audit

`retainedZoomMass` directly sums the existing `ConditionedCovering.retainedConditional` over L contained in W. It does not define a new probability by declaring it equal to the desired ratio. `retainedConditional_uniform` first derives the actual uniform flag-fibre formula by cancelling the concrete containment-event mass, and `relative_indicator_sum` imports the established quotient/relative-upper-subspace count. Consequently `retainedZoomMass_ratio` identifies the event mass with

    G(dim(V intersection W)-a, d-a) / G(dim(V)-a, d-a).

Its explicit hypotheses are Q contained in V and W, a<=d, and d<=dim(V), where V is the actual retained space of the given draw. This domain permits d above J when the particular retained space permits it. `retained_event_pos` proves strict positivity of the conditioning event from valid Gaussian dimensions. Thus no division by zero is silently normalized in the positive-law identity.

The retained rank-stable specialization uses the explicit equation dim(V intersection W)+c=dim(V). This is a geometric hypothesis, not an assumption of the target Gaussian ratio or a probability bound. It rewrites the numerator to G(dim(V)-a-c,d-a), matching the manuscript when b=d-a. The theorem does not prove that this equation holds with high posterior probability, or identify c with an ambient codimension without the required rank-stability argument.

The ambient counterpart sums the existing `ambientConditional` over the same event. Its pointwise formula follows from the Gaussian flag double-count identity, then the same relative-upper count gives G(dim(W)-a,d-a)/G(3J-a,d-a). An explicit ambient equation dim(W)+c=3J gives the manuscript codimension form. The ambient interface is a<=d<=J; it does not advertise the wider mathematically possible d<=3J range.

Natural subtraction in these formulas is controlled by the explicit dimension/containment hypotheses. The codimension rewrites are derived arithmetically from equality of dimensions rather than replacing signed dimension differences by unproved natural subtraction identities.

## Boundary checks and remaining obligations

- Null containment events retain the algebraic zero convention. Separate lemmas cover Q outside V, d above dim(V), and Q outside W. A zero mass on these fibres is not a normalized conditional probability distribution.
- If the intersection has too few dimensions, the numerator is zero. The theorem does not assume numerator positivity merely to enable cancellation: the positive denominator comes from the full retained fibre. This distinction is necessary before later conditioning additionally on W.
- On a valid fibre top W has probability one. At d=a the only possible L is Q, so every W containing Q has probability one. Checks exercise both retained and ambient forms, as well as zero-codimension/b=0 arithmetic.
- Near-one and half-leading lower bounds require the separately reviewed GaussianNearOne estimates plus their spare-dimension and exponent hypotheses. These identities alone give no lower bound for conditioning on W. The manuscript's large-h arithmetic must still supply those hypotheses uniformly in the intended draws and parameters.
- The identity is pointwise in an actual deletion draw. It neither replaces the posterior draw by an unconditional draw nor estimates the mass of rank-unstable draws. The actual advice posterior, its rank-failure bound, and the normalized reweighting by this event probability must be composed explicitly. The O(zeta/p0) and O(Delta/p0) losses remain essential obligations.
- No algorithmic runtime, random-bit encoding, size/weight guarantee, PCP/decoder theorem, full randomized CMMSA hardness theorem, exact learning transfer, or fixed-L asymptotic conclusion follows from this counting identity alone. It supplies no P-versus-NP or growing-parameter uniform polynomial-time result.

The stale draft text referring to unrun checks and the formerly uncompiled GaussianNearOne dependency is historical; the author appendix governs this pair's author status. No novelty is asserted for this existing incidence calculation. Within this bounded scope, no blocking probability substitution, dimension-domain inflation, or complexity-claim defect was found.
