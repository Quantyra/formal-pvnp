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


## Author compilation update (2026-09-12)

This appendix supersedes draft UNCOMPILED status for the exact source hashes below.
Both modules are now author-build green; all 19 selected standard-only axiom profiles
and all 10 examples passed. Independent three-lens review remains INCOMPLETE.
Historical source banners are retained to avoid cosmetic source changes after export.

The actual posterior expectation, Markov inequality, sharp half-L1 event transfer,
low-marginal bound, coefficient-three union and Chernoff substitution compiled.
No supplied desired-bound premise or conditional-independence assumption was added.
The actual quantitative TV proximity and manuscript parameter specialization remain open,
as do the full hardness/learning theorem and final paper reconciliation.

Repairs: explicitly bind the intended natural J,a (the uncompiled Chernoff signature
had inferred real J); annotate intermediate Advice J a mass functions; split a mixed
open command in Checks; annotate the empty-event example's second mass type.
These restore intended types and syntax without changing substantive conclusions.
Every Unicode edit used apply_patch and its diff/hash was inspected before retry.

Guarded direct exports used pinned Lean 4.34.0-rc2, author outputs first, pinned
existing dependencies, LEAN_NUM_THREADS=1/Python UTF8, 768 MiB start / 640 MiB
owned-child stop thresholds. No dependency rebuild/download, aggregate/map/config
modification or publication occurred. Tail dependencies were reused, not rebuilt.
Actual sessions:55728 EXIT1;22399 EXIT1 (main EXIT0, Checks EXIT1);25111
Checks-only EXIT0. All four raw logs and metadata are embedded below. No successful
main was rerun for Checks-only changes. Exact3 exception checkpoint awaits grant.

### Durable raw build evidence

```json
[
  {
    "command": [
      "lean",
      "-R",
      "lean",
      "-o",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.olean",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean"
    ],
    "exit_code": 1,
    "source_sha256": "aba8a565606a48ed1a02cacbf4738851e77a58f0cd49c6bc49202fd250ab8374",
    "log_sha256": "1c4fad8293724ec1b414b61ab920d5bfc2aa9bd3ab7f273068611181c4adf853",
    "output_sha256": null,
    "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
    "log_path": "certifications\\realizable-hardness\\.lake\\build\\diagnostics\\AdviceExceptions-1789265671293605100.log",
    "raw_log_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:33:17: warning: This simp argument is unused:\n  hb\n\nHint: Omit it from the simp argument list.\n  [apply] simp only [Bool.false_eq_true, ite_false, sub_self, mul_zero]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:36:17: warning: This simp argument is unused:\n  hb\n\nHint: Omit it from the simp argument list.\n  [apply] simp only [Bool.true_eq, ite_true]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:36:21: warning: This simp argument is unused:\n  Bool.true_eq\n\nHint: Omit it from the simp argument list.\n  [apply] simp only [hb, ite_true]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:103:32: warning: This simp argument is unused:\n  Bool.true_eq\n\nHint: Omit it from the simp argument list.\n  [apply] simp only [hd, decide_true, ite_true]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:136:43: warning: This simp argument is unused:\n  Bool.true_eq\n\nHint: Omit it from the simp argument list.\n  [apply] simp only [badTail, hb, decide_true, ite_true]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:159:46: error: don't know how to synthesize implicit argument `V`\n  @mass (Advice ?m.39 ?m.40) adviceFintype (adviceMarginal β) (lowMarginal β)\ncontext:\na J : ℕ\nβ : ℚ\nha : a ≤ J\n⊢ Type\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:159:71: error: don't know how to synthesize implicit argument `a`\n  @lowMarginal ?m.39 ?m.40 β\ncontext:\na J : ℕ\nβ : ℚ\nha : a ≤ J\n⊢ ℕ\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:159:71: error: don't know how to synthesize implicit argument `J`\n  @lowMarginal ?m.39 ?m.40 β\ncontext:\na J : ℕ\nβ : ℚ\nha : a ≤ J\n⊢ ℕ\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:159:52: error: don't know how to synthesize implicit argument `a`\n  @adviceMarginal ?m.39 ?m.40 β\ncontext:\na J : ℕ\nβ : ℚ\nha : a ≤ J\n⊢ ℕ\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:159:52: error: don't know how to synthesize implicit argument `J`\n  @adviceMarginal ?m.39 ?m.40 β\ncontext:\na J : ℕ\nβ : ℚ\nha : a ≤ J\n⊢ ℕ\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:159:11: error: don't know how to synthesize implicit argument `V`\n  @mass (Advice ?m.33 ?m.34) adviceFintype ambientMass (lowMarginal β)\ncontext:\na J : ℕ\nβ : ℚ\nha : a ≤ J\n⊢ Type\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:159:29: error: don't know how to synthesize implicit argument `a`\n  @lowMarginal ?m.33 ?m.34 β\ncontext:\na J : ℕ\nβ : ℚ\nha : a ≤ J\n⊢ ℕ\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:159:29: error: don't know how to synthesize implicit argument `J`\n  @lowMarginal ?m.33 ?m.34 β\ncontext:\na J : ℕ\nβ : ℚ\nha : a ≤ J\n⊢ ℕ\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:159:16: error: don't know how to synthesize implicit argument `a`\n  @ambientMass ?m.33 ?m.34\ncontext:\na J : ℕ\nβ : ℚ\nha : a ≤ J\n⊢ ℕ\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:159:16: error: don't know how to synthesize implicit argument `J`\n  @ambientMass ?m.33 ?m.34\ncontext:\na J : ℕ\nβ : ℚ\nha : a ≤ J\n⊢ ℕ\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:157:80: error: unsolved goals\na J : ℕ\nβ : ℚ\nha : a ≤ J\n⊢ mass ambientMass (lowMarginal β) ≤ 2 * adviceTV β J a\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:220:32: error: Application type mismatch: The argument\n  J\nhas type\n  ℝ\nbut is expected to have type\n  ℕ\nin the application\n  Advice J\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:222:24: error: Application type mismatch: The argument\n  J\nhas type\n  ℝ\nbut is expected to have type\n  ℕ\nin the application\n  adviceTV β J\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:226:55: error: Application type mismatch: The argument\n  J\nhas type\n  ℝ\nbut is expected to have type\n  ℕ\nin the application\n  DropCountTail.chernoff_tail_allow_zero β hβ hβ1 J\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:227:32: error: Application type mismatch: The argument\n  J\nhas type\n  ℝ\nbut is expected to have type\n  ℕ\nin the application\n  adviceTV β J\n\nEXIT 1\n"
  },
  {
    "command": [
      "lean",
      "-R",
      "lean",
      "-o",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.olean",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean"
    ],
    "exit_code": 0,
    "source_sha256": "eb0ac116e6a12a3f0ae9cc2e09b8ad75db261c7d521119688075532b276cf553",
    "log_sha256": "7bca18f4204b1b28344a405c3db81107c5f0fddf8f58d4b4da97369eefd3a572",
    "output_sha256": "4d14e3dfc80f0b9ab259efe77707f0ba9fa80bd3a6a0d4cc74e9c0c136989b55",
    "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
    "log_path": "certifications\\realizable-hardness\\.lake\\build\\diagnostics\\AdviceExceptions-1789265711760056300.log",
    "raw_log_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:34:17: warning: This simp argument is unused:\n  hb\n\nHint: Omit it from the simp argument list.\n  [apply] simp only [Bool.false_eq_true, ite_false, sub_self, mul_zero]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:37:17: warning: This simp argument is unused:\n  hb\n\nHint: Omit it from the simp argument list.\n  [apply] simp only [Bool.true_eq, ite_true]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:37:21: warning: This simp argument is unused:\n  Bool.true_eq\n\nHint: Omit it from the simp argument list.\n  [apply] simp only [hb, ite_true]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:104:32: warning: This simp argument is unused:\n  Bool.true_eq\n\nHint: Omit it from the simp argument list.\n  [apply] simp only [hd, decide_true, ite_true]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:137:43: warning: This simp argument is unused:\n  Bool.true_eq\n\nHint: Omit it from the simp argument list.\n  [apply] simp only [badTail, hb, decide_true, ite_true]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptions.lean:167:46: warning: This simp argument is unused:\n  Bool.true_eq\n\nHint: Omit it from the simp argument list.\n  [apply] simp only [lowMarginal, h, decide_true, ite_true]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\n\nEXIT 0\n"
  },
  {
    "command": [
      "lean",
      "-R",
      "lean",
      "-o",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\AdviceExceptionsChecks.olean",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptionsChecks.lean"
    ],
    "exit_code": 1,
    "source_sha256": "dee8f14fe47a456f79d2b726416ef089ef075b3fd83a4ef3e6b87437b0048230",
    "log_sha256": "3fae2661ac8aa5f2f739717c9ec3649e5819a342cc07e13003e568322db602d2",
    "output_sha256": null,
    "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
    "log_path": "certifications\\realizable-hardness\\.lake\\build\\diagnostics\\AdviceExceptionsChecks-1789265734255483200.log",
    "raw_log_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptionsChecks.lean:7:43: error: unexpected token '('; expected command\n'PvNP.RealizableHardness.AdviceExceptions.tv_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.tv_self' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.event_sub_le_tv' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.mass_union_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.priorTail_cast' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.conditional_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.conditional_zero_marginal' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.tailMass_zero_marginal' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.tailMass_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.posterior_tail_expectation' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.null_marginal_not_badTail' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.badTail_marginal_mass_le' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.ambient_event_transfer' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.lowMarginal_ambient_mass_le' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.badTail_ambient_mass_le' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.exceptional_ambient_mass_le' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.good_advice_properties' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.exceptional_ambient_mass_le_real' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.exceptional_chernoff_bound' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptionsChecks.lean:42:6: error: don't know how to synthesize implicit argument `V`\n  @mass (Advice (?m.22 β ha) (?m.23 β ha)) adviceFintype (adviceMarginal β) fun x => false\ncontext:\na J : ℕ\nβ : ℚ\nha : a ≤ J\n⊢ Type\n\nNote: Because this declaration's type has been explicitly provided, all parameter types and holes (e.g., `_`) in its header are resolved before its body is processed; information from the declaration body cannot be used to infer what these values should be\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptionsChecks.lean:42:35: error(lean.inferBinderTypeFailed): Failed to infer binder type\n\nNote: Because this declaration's type has been explicitly provided, all parameter types and holes (e.g., `_`) in its header are resolved before its body is processed; information from the declaration body cannot be used to infer what these values should be\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptionsChecks.lean:42:12: error: don't know how to synthesize implicit argument `a`\n  @adviceMarginal (?m.22 β ha) (?m.23 β ha) β\ncontext:\na J : ℕ\nβ : ℚ\nha : a ≤ J\n⊢ ℕ\n\nNote: Because this declaration's type has been explicitly provided, all parameter types and holes (e.g., `_`) in its header are resolved before its body is processed; information from the declaration body cannot be used to infer what these values should be\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptionsChecks.lean:42:12: error: don't know how to synthesize implicit argument `J`\n  @adviceMarginal (?m.22 β ha) (?m.23 β ha) β\ncontext:\na J : ℕ\nβ : ℚ\nha : a ≤ J\n⊢ ℕ\n\nNote: Because this declaration's type has been explicitly provided, all parameter types and holes (e.g., `_`) in its header are resolved before its body is processed; information from the declaration body cannot be used to infer what these values should be\n\nEXIT 1\n"
  },
  {
    "command": [
      "lean",
      "-R",
      "lean",
      "-o",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\AdviceExceptionsChecks.olean",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\AdviceExceptionsChecks.lean"
    ],
    "exit_code": 0,
    "source_sha256": "f9037941388cb479ee62e03b38c584a6dd9887a57ffc6f31571e5681e7560e11",
    "log_sha256": "38f8b7b7cf9b3ea530d0002692784147281f913dbfce96c5377f6c7b7b09a3cf",
    "output_sha256": "ca3afad552b571c1ed7a65d6b98571988a9f3256594a750181010ad4be48df5e",
    "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
    "log_path": "certifications\\realizable-hardness\\.lake\\build\\diagnostics\\AdviceExceptionsChecks-1789265767988713900.log",
    "raw_log_utf8": "'PvNP.RealizableHardness.AdviceExceptions.tv_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.tv_self' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.event_sub_le_tv' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.mass_union_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.priorTail_cast' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.conditional_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.conditional_zero_marginal' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.tailMass_zero_marginal' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.tailMass_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.posterior_tail_expectation' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.null_marginal_not_badTail' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.badTail_marginal_mass_le' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.ambient_event_transfer' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.lowMarginal_ambient_mass_le' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.badTail_ambient_mass_le' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.exceptional_ambient_mass_le' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.good_advice_properties' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.exceptional_ambient_mass_le_real' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n'PvNP.RealizableHardness.AdviceExceptions.exceptional_chernoff_bound' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\n\nEXIT 0\n"
  }
]
```
