# Finite concentration: independent proof-adversarial review

2026-09-12. Reviewer: concentration_proof_review, independently routed by the orchestrator; not the implementation author. S3130 under the still-open S3126 goal.

## Verdict

**GO** for the bounded finite rational-product concentration increment. No actionable proof, hypothesis, vacuity, or statement defects found. This is not certification of the full manuscript theorem or learning corollary.

## Scope and evidence

Reviewed candidate `a72739e7b192035f9c37370189c1de1d5a811b5c`: `lean/PvNP/RealizableHardness/FiniteConcentration.lean`, `FiniteConcentrationChecks.lean`, and the finite-concentration formalization receipt. Read `INTEGRITY-CLAIMS.md`, the full Lean dependency ledger, planning S3130 and the formal three-lens closeout protocol. There is no repository-root AGENTS.md in this satellite checkout. Inspected imported `FiniteSampling.trialMass` and normalization, and the exact imported proved `BernoulliMGF.centered_mgf_le` statement. Compared the curated manuscript sampling passage at lines 647-693 and the learning confidence requirements at lines 733-736 and 772-775.

Independently read Git blob bytes and working bytes. Main committed SHA256 is `a24c08464c417d446292f3de917a7136d3ae7a7bb40032f1dd8c558238e4f338`; working SHA256 is `1f89228ca5a07da67223c674e482f7b532537850a34df22b131eb0a741bb913f`. Replacing CRLF with LF gives exact byte equality. Checks committed and working SHA256 both equal `8f260a72a5a6770e589c5380bff89368ff4c837aaa5e4f39f6d87250cc0abb8d`.

Independently executed these exact pinned commands, sequentially, using the existing cached dependencies:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/FiniteConcentration.olean lean/PvNP/RealizableHardness/FiniteConcentration.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/FiniteConcentrationChecks.olean lean/PvNP/RealizableHardness/FiniteConcentrationChecks.lean
```

Main session **66689 exited 0**, no output or warnings. Checks session **66807 exited 0**, no warnings, printing all **24** requested axiom profiles. Every profile contains exactly `[propext, Classical.choice, Quot.sound]`; no sorryAx or new theorem axiom appears. Source inspection also found no sorry/admit/native_decide or axiom declaration. These are actual elaboration and transitive axiom results, not merely a source scan. No toolchain upgrade or heavy dependency rebuild was performed.

## Adversarial statement and proof checks

- Probability is the actual finite event sum of rational products cast into real numbers. Nonnegativity and normalization are separately supplied where needed; no stipulated concentration or independence contract replaces the distribution.
- The Boolean indicator mean is in [0,1]. The one-trial finite exponential sum equals the Bernoulli expression algebraically. Real exponential factorization and finite product-of-sums establish the product MGF, rather than assuming it.
- Exponential Markov uses positive exponentials and nonnegative masses directly. Its arbitrary real parameter permits both t=4*delta and t=-4*delta; the negative-tail event inclusion has the correct direction. Both optimized exponents are exactly -2*M*delta^2.
- The two-sided event is covered by the actual union of upper and lower tail events. The empirical bridge explicitly requires M>0, avoiding division-by-zero semantics. Zero-trial algebraic statements and delta=0 bounds remain valid; zero-mass atoms are permitted.
- The simultaneous family is concretely `Fin N -> Bool`, with cardinality exactly 2^N. N=0 has one assignment, not zero; a concrete check covers it. No opaque family-size premise hides the union bound.
- The deterministic approximation premise is only the difference between specified means. The triangle inequality correctly transfers deviation at least 2*delta to empirical deviation at least delta. The epsilon/8 specialization gives epsilon/4 with the original sharp exponent. This premise is not an assumed probabilistic success claim.
- Product normalization proves the complement identity. Bounding the closed bad event gives a strict good-event deviation, which is strong enough for the manuscript's non-strict error allowance.
- The coefficient remains generic in M and hardcodes neither confidence budget. It supports both manuscript ln 6/failure 1/3 and learning ln 12/failure 1/6 threshold instantiations; those instantiations are not yet claimed by this module.
- Fair-coin examples have exact mean 1/2, centered values +1 and -1, two-draw mass 1/4, and the eight-draw bound 2*exp(-4). They supplement rather than substitute for the universally quantified proofs.

## Remaining full-goal obligations

Joint uniform bit-array pushforward, discharge of the mean-approximation premise from the concrete rounded sampler, least-power-of-two sample thresholds, YES/NO promise composition with repair and weight rounding, and encoded enumeration/arithmetic/runtime remain separate obligations. Source NP-hardness, specialized PCP/geometry dependencies, asymptotic parameter choices and learning transfer also remain open. The reviewed receipt correctly preserves these boundaries. This review certifies none of those missing assemblies and makes no novelty, publication, human-review, or complete-proof claim.

Only this review file is owned by this reviewer; no code, shared receipt, staging, commit, push, or release change was made.
