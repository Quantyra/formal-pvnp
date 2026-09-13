# S3133 actual exceptional-advice source draft

2026-09-12. **UNCOMPILED.** No compiler, axiom audit, independent acceptance,
Git operation, download, public release, or existing-source edit was performed.
This is a source script for the full-proof dependency, not completion of S3126.

## Route and inputs

Read the full-goal dependency assessment, S3133 current story, planning protocol,
literature-review-trigger protocol, and the existing source-directed frontier
note. This continues the authorized actual finite-law formalization of the
realizable fixed-parameter CMMSA derivation. No new force carrier, source
theorem claim, novelty claim, or widened complexity-class statement is proposed.

Actual input interfaces inspected: GrassmannIncidence `prior`, `kernel`,
`adviceMarginal`, `conditional`, normalization and nonnegativity; accepted
PosteriorReweighting `total_probability`, including its zero-marginal joint
argument; PosteriorDensity `ambientMass` and `tailMass`; DropCountTail source
draft at the root-reported `9cdf392191090248ae251acb16c43bd535854137`, including
`tail` and `chernoff_tail_allow_zero`. The accepted FiniteSampling event bound
addresses rounding, not the half-L1 theorem needed here. Consequently a small
general half-L1 event lemma is derived explicitly and instantiated on actual
advice. No supplied distribution, Markov bound, or TV event inequality is used.

## Files and hashes

Relative to formal-pvnp:

- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/AdviceExceptions.lean`
  SHA256 `aba8a565606a48ed1a02cacbf4738851e77a58f0cd49c6bc49202fd250ab8374`.
- `certifications/realizable-hardness/lean/PvNP/RealizableHardness/AdviceExceptionsChecks.lean`
  SHA256 `dee8f14fe47a456f79d2b726416ef089ef075b3fd83a4ef3e6b87437b0048230`.

These are new files only. Existing companion source maps, imports, aggregate,
configuration, evidence, and concurrently repaired sources remain untouched.

## Scripted theorem chain

`tv p q` is exactly half the sum of absolute atom differences, over a Fintype.
`event_sub_le_tv` follows from the pointwise inequality
`2 * 1_B(x) * (p(x)-q(x)) <= |p(x)-q(x)| + (p(x)-q(x))` and the equality
of the two total masses. This derives the sharp additive TV constant rather
than replacing it with the weaker L1 bound. Rational arithmetic is exact.

`priorTail beta J T` is the mass of the actual strict event `T < dropCount d`
under the existing product prior. Its real cast is proved equal to the
DropCountTail `tail`, rather than assuming a new tail-law correspondence.
`posterior_tail_expectation` sums existing finite total probability to prove
the marginal-weighted posterior-tail expectation equals `priorTail`.
Null marginals explicitly give zero conditional mass and zero posterior tail;
they are not treated as positive conditioning events.

The bad-tail set is `zeta < tailMass`; its marginal mass is bounded by
`priorTail / zeta` through a pointwise inequality and finite summation.
The low-marginal set is `P'(Q) < P(Q)/2`; its uniform mass is at most twice
TV by combining its pointwise lost-mass inequality with the derived event
bound. Transfer of the bad-tail mass to uniform advice costs one more TV.
The union bound is therefore exactly

`P(lowMarginal OR badTail) <= priorTail / zeta + 3 * TV(P,P')`.

`good_advice_properties` extracts both good marginal and tail inequalities
from nonmembership in the actual union. The real-valued form explicitly
casts rational probability, zeta and TV. `exceptional_chernoff_bound` then
substitutes the actual zero-mean-compatible Chernoff theorem, yielding
`(exp(1) * J * beta / T)^T / zeta + 3 * TV(P,P')`; this script depends on
the still-uncompiled tail draft and inherits its eventual verification gate.

## Hypotheses and boundaries

The expectation, Markov and final union theorem require `0 <= beta <= 1`,
`a <= J`, and natural `J,a,T`; Markov and the union require rational
`0 < zeta`. There is no strictly positive prior-atom or all-marginals-positive
premise. The Chernoff corollary additionally requires real `J * beta <= T`.
It allows zero mean and inherits the tail theorem's `0^0 = 1` convention.
The low-marginal and event-transfer lemmas require normalization via `a<=J`;
they are algebraically valid even without beta-range hypotheses. The final
probabilistic theorem retains beta's full valid range.

No Gaussian-density factor, tail-smallness estimate, TV-smallness estimate,
posterior independence, or desired exception inequality is among the final
union theorem's premises. TV proximity itself remains an explicit term, not
a discharged KMS/advice-variation theorem. This does not finish parameter
specialization, KMS covering/reweighting, specialized PCP/decoding, encoded
randomized runtime, learning transfer, fixed-L asymptotics, or the full
hardness theorem. It supports no P-vs-NP conclusion or publication claim.

## Intended verification

Checks contain 19 selected `#print axioms` queries and 10 examples, all UNRUN.
Examples cover the half-L1 normalization on disjoint Bool laws, equal laws,
empty events, null marginals including beta=1, positive threshold at null
advice, J=a=0, beta=0, equality at both strict bad-set boundaries, and the
coefficient-three union at beta=1. No `#eval` or computational complexity
claim is included. Compilation, actual standard-axiom verification, and the
three independent review lenses remain required before acceptance.

The author reviewed the additive transfer step for argument-order inference
and used explicit `add_le_add` with typed reflexivity for its unchanged TV
term, as requested by the parent. Source-only review cannot establish that
the Lean scripts elaborate; no result is described as kernel verified.
