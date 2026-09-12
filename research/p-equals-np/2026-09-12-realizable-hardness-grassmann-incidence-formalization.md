# Actual advice-incidence law — source draft

Status: UNCOMPILED. No Lean or Lake invocation, downloads, cache changes,
companion edits, staging, or commits were performed for this draft.

Route: S3133 under S3126; actual posterior section of MANUSCRIPT.md,
lines 304–423, and the full Lean dependency assessment. Destination is
formal-pvnp, root Lean 4.13 and its existing pinned mathlib.

## Concrete construction

Advice J a consists of actual a-dimensional GF(2) submodules of Vector J.
It is finite by injection of submodules into the finite powerset of the
finite ambient vector space. The incidence fibre filters all advice
subspaces by Q <= retained d. Its cardinality is the denominator of the
uniform kernel; kernel normalization is derived from this finite sum.

Nonempty fibres are proved without assuming a dimension-existence oracle:
embed d a places the first a scalar coordinates on one selected retained
coordinate in each of the first a blocks. For a <= J it is injective.
Its range is an a-dimensional subspace contained in retained d. Taking
a = J and codRestrict proves finrank(retained d) >= J. This handles J=0
and a=0 without conditioning on an empty law.

The prior is exactly FiniteSampling.trialMass of TripleRestrictionRank's
blockMass. The joint is prior times the derived incidence kernel. The
marginal and posterior instantiate accepted PosteriorReweighting definitions.
Joint and marginal normalization, support, positive-marginal posterior
normalization, exact Bayes identity, and positive-prior likelihood ratio
are explicit. Nonnegativity uses the genuine beta range 0 <= beta <= 1;
the algebraic total-sum identities do not require that range.

## Source inspection and checks

Inspected actual pinned mathlib definitions finrank_range_of_inj,
finrank_le_finrank_of_injective, Module.finrank_pi, mul_inv_cancel₀.
Checks request seventeen axiom profiles and exercise zero advice dimension,
zero ambient blocks, beta endpoints, a one-block dimension bound and
nonincidence support. They remain uncompiled, with no asserted profiles.

## Remaining obligations and claims boundary

Actual compiler elaboration and independent three-lens review are pending.
This does not establish the Gaussian-binomial cardinality formula or its
ratio estimates, dropped-block tails, exceptional advice bounds, KMS
couplings, the conditioned rank bound, decoder, or any runtime theorem.
The draw variable retains the complete block-choice record; later use of
geometric V must identify or push forward that record faithfully. No
posterior independence is assumed. Noncomputable finite enumeration and
dimension reasoning are mathematical objects, not an efficient algorithm.
The full hardness and learning theorem and paper reconciliation remain open.
