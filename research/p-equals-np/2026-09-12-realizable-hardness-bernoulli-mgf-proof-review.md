# Centered Bernoulli MGF: independent proof-adversarial review

2026-09-12. Fresh reviewer `sampling_proof_review`, not the module author. Candidate `6750bbcf858414cb1b04084dc8b2dff40dc43a8e`; S3130 under S3126. Verdict: **GO** for the exact standalone Bernoulli MGF theorem. No actionable proof-adversarial findings.

## Scope and source identity

Read both actual Lean modules and the author's formalization receipt. Applied the previously read planning formal-three-lens protocol and destination integrity ledger. No destination AGENTS.md is present.

Independently obtained each frozen Git blob through binary `git show` and each working file through binary reads, and compared both raw and CRLF-normalized bytes. Both files are **exactly byte-identical** to the candidate; normalization does not conceal any difference:

- `lean/PvNP/RealizableHardness/BernoulliMGF.lean`, Git and working SHA256 `d923ad4b96435ba3e7d4c9e1c4f0b040d7747317a5de865b6f31bded97abbe32`.
- `lean/PvNP/RealizableHardness/BernoulliMGFChecks.lean`, Git and working SHA256 `f370c56951ed923db58da67d1cdbc93e3a4cadf8b994c62abbc588e604be450f`.

## Mathematical adversarial checks

The final theorem `PvNP.RealizableHardness.BernoulliMGF.centered_mgf_le` has precisely the intended two-term expression, with arbitrary real t and only `0 <= p` and `p <= 1` as hypotheses. There is no assumed concentration, MGF, independence or hardness contract.

The partition `1-p+p*exp(t)` is strictly positive, including p=0 (value one) and p=1 (positive exponential). All divisions and the log derivative therefore have justified nonzero denominators. Both derivative formulas are proved, not posited. With a=1-p and b=p*exp(t), the curvature inequality is exactly `4ab <= (a+b)^2`, established by the square `(a-b)^2`. The bound is consequently 1/4 on the log-partition curvature and gives the desired coefficient 1/8 after integration.

The proof of the nonnegative gap covers both signs of t explicitly. The increasing gap slope vanishes at zero. On the nonnegative half-line the gap is monotone; on the nonpositive half-line it is antitone as t increases toward zero. Comparing to gap(0)=0 consequently gives the correct inequality in both cases, including t=0. There is no sign reversal or restriction to one tail.

Exponentiation uses positive partition to rewrite exp(log Z)=Z. Multiplication by the positive exp(-tp) preserves the inequality, gives exactly the centered Bernoulli expression, and cancels pt in the exponent. The final coefficient is t^2/8, not a weaker surrogate constant. Endpoint identities and the positive/negative nondegenerate checks are relevant and do not replace the general proof.

## Scope boundary

This is a one-trial analytic inequality. It does not yet connect an actual indicator's law to the expression, factor a many-trial MGF, apply exponential Markov, optimize tail parameters, prove a simultaneous union bound or the manuscript's sample-size threshold. It does not certify sampler implementation, encoded runtime, full reduction, PCP, hardness or learning transfer. The author's receipt states these outstanding requirements accurately. Full S3130 and S3126 remain open.

Reviewer owns only this receipt; no Lean code, shared records, other agents' work or toolchain changed, and no push or release occurred.


## Independent scoped kernel verification

Independently executed sequentially with the unchanged pinned toolchain and existing dependency exports:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/BernoulliMGF.olean lean/PvNP/RealizableHardness/BernoulliMGF.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/BernoulliMGFChecks.olean lean/PvNP/RealizableHardness/BernoulliMGFChecks.lean
```

Main session **69459** exited **0**, emitting only the informational `Try this: ring_nf` suggestion. Checks session **8196** exited **0**, without warnings, and printed all 13 requested profiles. Every profile is exactly `[propext, Classical.choice, Quot.sound]`, without sorryAx, native evaluation or additional axioms. This independently elaborated both scoped files; no dependency or umbrella rebuild was requested.

Audited names under `PvNP.RealizableHardness.BernoulliMGF`: `partition_pos`, `partition_deriv`, `gap_deriv`, `gapSlope_deriv`, `gapCurvature_nonneg`, `gapSlope_monotone`, `gap_nonneg`, `centered_mgf_le`, `probability_zero_example`, `probability_one_example`, `parameter_zero_example`, `nondegenerate_example`, `negative_parameter_example`.
