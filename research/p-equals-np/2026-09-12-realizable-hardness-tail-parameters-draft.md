# Numerical deletion-tail parameter specialization

2026-09-12; S3133/S3137, parent S3126. Source-only satellite increment.
Status: **UNCOMPILED**. No successful export, axiom report, example, independent
review, full parameter assembly or publication is claimed.

## Exact source and intended result

Owned files under `certifications/realizable-hardness/lean/PvNP/RealizableHardness/`:

- `DropTailParameters.lean`, SHA256
  `9fc28c616488e2ff2cc167ac018695dd4612358a5360e40ba351dacb01e97793`.
- `DropTailParametersChecks.lean`, SHA256
  `37af3e9fc1cc809b059d9156509bded4f0b8149c7550bb561050b011453f0df9`.

The checks file contains 15 intended axiom queries and seven examples, all unrun.
No compiler, Git operation, dependency update, aggregate edit, or publication was
performed. Files were written using UTF8 apply_patch.

`decay k h` is `(1/2 : Real)^(k*h^2)`, with an exact reciprocal identity
`1 / 2^(k*h^2)`. This avoids ambiguity between natural and real exponents in
the manuscript's notation `2^(-k h^2)`.

For every fixed real A, `eventually_ready` constructs a natural N such that
every natural h >= N satisfies both `100 <= h^2` and
`2*exp(1)*A <= h^2`. The proof chooses N by the Archimedean property above
`max 100 (2*exp(1)*A)`, then uses h <= h^2. Thus no desired asymptotic
inequality is supplied as a hypothesis.

At this explicit sufficient threshold, for A >= 0:

1. A*h^2 <= h^4.
2. exp(1)*A/h^2 <= 1/2.
3. h^4 >= 100*h^2.
4. `(exp(1)*A/h^2)^(h^4) <= decay 100 h` by monotonicity in the base and
   antitonicity in the exponent for bases in [0,1].

The actual-tail theorem composes the accepted
`DropCountTail.chernoff_tail_allow_zero` with this bound for the real cast of
the actual rational deletion-event mass. It retains explicit beta in [0,1]
and the exact mean identity `J*beta = A*h^2`. It introduces no alternative
distribution or assumed tail estimate. `eventual_actual_tail` fixes A > 0
before choosing N, quantifies over all later h, and then over J and rational
beta. It exports the mean/cutoff inequality, numerical Chernoff bound, actual
tail bound, and tail divided by zeta bound.

The exact identity `decay 100 h / decay 30 h = decay 70 h` follows from
power addition. The denominator is strictly positive for every natural h,
including h=0. The eventual threshold excludes h=0 explicitly. Separate
examples cover decay at h=0 and the actual beta=0 tail at h=10; no division
by a zero cutoff is silently canceled.

## Local sources inspected

- Planning S3137 and protocol/inheritance/boundary sources; dependency assessment
  `2026-09-12-realizable-hardness-lean-dependency-assessment.md`.
- Actual `DropCountTail.lean`, especially `chernoff_tail_allow_zero`.
- Current paper `realizable-cmmsa-hardness/paper/submission-manuscript.md`,
  posterior section around lines 326-346.
- Companion manifest pins mathlib
  `e06eff5f95374108acfaf19f1ff7473aa7771df2`.
- Local pinned mathlib `Algebra/Order/GroupWithZero/Basic.lean`:
  `pow_le_pow_of_le_one` and `div_le_div_of_nonneg_right`;
  `Algebra/GroupWithZero/Defs.lean`: `mul_div_cancel_right₀`;
  `Algebra/Order/Archimedean/Defs.lean`: `exists_nat_gt`.

## Remaining exact work

Scoped compilation must resolve any elaboration/API errors without weakening
these statements, followed by independent proof, complexity and nonclaims
reviews. This draft does not construct the double-exponential J, prove the
range of beta=A*h^2/J, prove the other covering/likelihood/zoom bounds,
assemble fixed-L admissibility/integrality, or certify the complete hardness
and learning results. It proves no claim about P versus NP. Paper reconciliation
and announcement readiness remain separate, unfinished work.
