# Finite rational-product concentration: formal increment

2026-09-12. S3130 under the open full S3126 goal. Author `mgf_nonclaims_review`, explicitly reassigned to implementation after its distinct MGF non-claims review. The author cannot independently review this concentration increment. Both scoped exports are green; fresh three-lens review is pending.

## Actual mathematical target

Read the destination integrity ledger, full Lean dependency ledger, and public manuscript sampling paragraph (lines 647-693). This module imports the frozen FiniteSampling product-law definitions and the proved BernoulliMGF inequality. It uses the actual rational `trialMass q M x = product_i q(x_i)`, cast into real finite sums. No PMF abstraction, assumed concentration bound or stipulated independence field substitutes for that distribution.

For nonnegative rational q summing to one and Boolean f, `mean q f` is the weighted real indicator mean. `centeredSum` sums the M indicators minus this mean. `probability q M E` is the actual finite sum of trialMass over the event. The analytic definitions are noncomputable real-valued mathematics, not an encoded implementation claim.

Proved under `PvNP.RealizableHardness.FiniteConcentration`:

| Export | Exact result |
|---|---|
| `mean_bounds`, `one_trial_mgf` | Mean lies in [0,1]; its centered finite-sum exponential moment equals the two-term Bernoulli expression. |
| `exp_finite_sum`, `product_mgf_identity` | Exponential of the actual sum factors; summing the concrete product weights gives the Mth power of the one-trial MGF. |
| `product_mgf_bound` | That moment is at most exp(M*t^2/8) for every real t, using the already proved Bernoulli analytic theorem. |
| `probability_mono` | Inclusion of actual events preserves finite probability under nonnegative weights. |
| `exponential_markov` | A direct finite-sum nonnegative-weight argument bounds P[a <= t*centeredSum] by exp(M*t^2/8-a), for arbitrary real t,a. |
| `upper_tail`, `lower_tail` | Choosing t=4*delta and t=-4*delta proves each tail is at most exp(-2*M*delta^2). |
| `probability_union`, `two_sided_tail` | Union of the two actual events proves P[M*delta <= abs(centeredSum)] <= 2*exp(-2*M*delta^2). |
| `centered_empirical`, `empirical_tail` | For M>0, the centered sum equals M times empirical average minus mean; the same exact bound holds for empirical deviation at least delta. |
| `probability_exists`, `assignment_empirical_tail` | A finite-family union bound over all `Fin N -> Bool` assignments gives exactly 2^N times the two-sided bound. |
| `assignment_approximation_tail`, `assignment_epsilon_tail` | A deterministic mean-approximation error at most delta composes with empirical error delta; specializing delta=eps/8 gives total eps/4. |
| `probability_complement` | Normalization of the actual product law gives P[not E]=1-P[E]. |

Tail inequalities allow delta=0. Empirical statements require M>0 explicitly. The exact finite sum/product statements also handle zero trials algebraically. q may have zero atoms. No fixed-L/growing-N quantifier has been exchanged; N, M and the finite support are arbitrary in these statements.

The approximation hypothesis is only a deterministic difference between two stated means. It is not a concentration or probability-success assumption: concentration is fully proved before it. The final sampler assembly must discharge that deterministic bound from cumulative rounding and also prove the actual joint bit-array pushforward.

## Actual scoped verification

Pinned Lean 4.13.0 and existing cached dependencies; no toolchain change or dependency rebuild. Final commands:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/FiniteConcentration.olean lean/PvNP/RealizableHardness/FiniteConcentration.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/FiniteConcentrationChecks.olean lean/PvNP/RealizableHardness/FiniteConcentrationChecks.lean
```

Main export session **55154 exited 0**, no output or warnings. Final Checks export session **70003 exited 0**, no warnings, with **24** actual axiom profiles, all exactly `[propext, Classical.choice, Quot.sound]`. Earlier failed local tactic/API/example elaborations were corrected before these exports; the failed runs are not accepted verification evidence. No sorry/admit, theorem axiom or native_decide is present in either source.

The 18 main audited names are the 18 exports in the table above. Checks also audit `fair_mean`, `fair_all_true`, `fair_all_false`, `fair_draw_mass`, `fair_eight_tail`, and `zero_variable_assignment_example`. Concrete checks use fair Boolean atoms: mean 1/2, positive and negative centered values for two identical draws, exact rational draw mass 1/4, and an eight-draw tail bound 2*exp(-4). The zero-variable check correctly retains the single empty assignment rather than treating its assignment class as empty.

Final compiled working SHA256:

- `lean/PvNP/RealizableHardness/FiniteConcentration.lean`: `1f89228ca5a07da67223c674e482f7b532537850a34df22b131eb0a741bb913f`.
- `lean/PvNP/RealizableHardness/FiniteConcentrationChecks.lean`: `8f260a72a5a6770e589c5380bff89368ff4c837aaa5e4f39f6d87250cc0abb8d`.

## Integration and remaining boundary

This supplies actual finite-product concentration and simultaneous empirical error. It does not yet assemble the inverse-CDF bit array's joint law, instantiate the rounded atom means, choose or analyze sample counts, or compose the formula YES/NO promises, exception repair and weight rounding. Separate threshold work must handle both the base manuscript ln6/failure1/3 choice and the learning variant ln12/failure1/6; the generic bound here supports both and hardcodes neither confidence budget.

Encoded support enumeration, arithmetic/runtime, randomized reduction semantics, source NP-hardness, specialized PCP dependencies, asymptotics and learning transfer remain open. Full S3130 and S3126 are not closed by this analytic/probabilistic increment. No novelty, human review, submission, release, or complete theorem certification is asserted.

| Lens | Status |
|---|---|
| Author actual scoped exports and 24-profile audit | GO |
| Independent proof-adversarial | Pending root routing |
| Independent complexity | Pending root routing |
| Independent non-claims | Pending root routing |

Own only these two new modules and this formalization receipt for the implementation candidate. Existing reviewed modules, other agents' CDF/threshold work and shared evidence are unchanged. Local candidate commit only; no push or public release.