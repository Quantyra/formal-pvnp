# Actual drop-count exponential tail: source draft

2026-09-12. S3133, child of S3126. **UNCOMPILED; no kernel verification,
axiom report, independent review, acceptance or publication claim.**

This source-only task owns exactly the two new companion modules
`DropCountTail.lean`, `DropCountTailChecks.lean` under
`certifications/realizable-hardness/lean/PvNP/RealizableHardness/` and this
receipt. No compiler, dependency download, Git command, source-map change,
aggregate import, existing source modification or publication was performed.
The three files are deliberately left for the orchestrator's exact-scope
preservation and later compiler routing.

## Inputs and route

Read the full full-goal dependency assessment in this directory, S3133,
planning protocol and literature-trigger protocol, and the source-directed
frontier review dated 2026-09-12. This implements the selected manuscript
posterior-tail dependency, not a new research direction or novelty claim.
There is no applicable AGENTS.md in this satellite source ancestry; the
only AGENTS.md files found under certifications belong to vendored
complexitylib/cslib packages and neither package was modified.

Inspected actual companion GrassmannIncidence, TripleRestrictionDimension,
TripleRestrictionRank, FiniteSampling, FiniteConcentration and BernoulliMGF
source. The accepted centered Bernoulli/Hoeffding bound is not substituted
for the rare-drop Chernoff exponent: the source derives the uncentered exact
moment anew using the concrete product mass and finite exponential-sum
identity. Inspected pinned mathlib's Real.log_nonneg and exponential API.
No external dependency or binomial distribution theorem is assumed.

## Actual definitions and intended conclusions

`dropped b` is one for a singleton block choice and zero for none.
`dropCount_eq_sum` and its real-cast form identify the existing actual
`TripleRestrictionDimension.dropCount` with the sum of these block indicators.
`tail beta J T` is the real cast of the existing rational
`TripleRestrictionRank.probability beta (fun d => T < dropCount d)`.
`tail_sum` identifies this with the sum of the actual GrassmannIncidence
prior atoms, restricted by the strict integer event. It is not a newly
postulated distribution.

The draft theorem scripts derive:

1. `block_moment`: sum over none and three singleton outcomes is exactly
   `1 - beta + beta * exp(t)`, including all rational-to-real casts.
2. `moment_identity`: `sum_d prior(beta,d) * exp(t*D(d)) =
   (1-beta+beta*exp(t))^J` for every rational beta, natural J and real t.
   Finite product expansion proves this directly; no independence premise
   or supplied `D ~ Binomial` fact appears.
3. `moment_bound`, under `0 <= beta <= 1`, bounds that moment by
   `exp(J*beta*(exp(t)-1))`. It applies for all real t and uses
   `1+x <= exp(x)` and nonnegative powers.
4. `exponential_tail`, under the same beta constraints and `t >= 0`, gives
   `Pr[D>T] <= exp(J*beta*(exp(t)-1)-t*T)` for all natural J,T.
   The strict event implies the weaker threshold D>=T; t=0 is allowed.
5. `optimized_tail`, adding `0 < mu=J*beta <= T`, substitutes
   `t=log(T/mu)` and gives `exp(T-mu-T*log(T/mu))`.
6. `chernoff_tail`, with those same hypotheses, discards the favorable
   `exp(-mu)` factor and derives exactly `(exp(1)*J*beta/T)^T`.
7. `chernoff_tail_allow_zero` permits `mu=0` as well, assuming only
   `0<=beta<=1` and `J*beta<=T`. At T=0 this is Lean's explicit natural
   exponent convention `0^0=1`; the actual tail is zero when mu=0.

Zero/support boundaries are separate exact scripts: tail is nonnegative
and at most one for valid beta; tail is zero for J<=T without any beta
constraint; an empty draw has zero tail; beta=0 has zero tail for all J,T;
mu=0 has zero tail. The beta=0 proof locates an actually dropped block and
uses its zero atom in the product, rather than taking a limiting bound.
The upper endpoint beta=1 is permitted throughout.

## Intended checks and source integrity

The Checks module contains **17 intended axiom queries and 10 examples**.
Examples cover the none/singleton indicator values, empty draw, beta=0,
full and beyond-support cutoffs, t=0 moment normalization, mu<T, mu=T,
and the zero-mean extension. These are proof scripts only; no outputs
exist and none is counted as passed. No native_decide is used.

SHA256, UTF-8 source bytes:

- Main: `7070cf6093f68e6804ba8a135d5d7c24b72a2fd3a76838aa159769233ba34eb1`
- Checks: `ad33060916b75c6ac1959fa63f514f02ad0a9c9fadac7820025f3bbe276dde59`

Targeted source scan found no sorry, admit, native_decide or axiom
declaration tokens in the two files. This is not a transitive axiom audit.
An initial rg command using a Windows literal wildcard failed; the exact
two-file scan was rerun and returned no matches. No build was attempted.

## Remaining work and claims boundary

All new scripts need the exclusive compiler slot, actual diagnostics and
statement-preserving repairs if necessary, then fresh independent proof,
complexity and nonclaims reviews. The scripts use existing accepted modules
but that does not transfer acceptance to this new source. In particular,
the real-cast finite sums and logarithmic denominator algebra are untested
elaboration sites.

The intended generic optimized Chernoff inequality is fully scripted;
the manuscript parameter specialization is still open: instantiate
`T=h^4`, `J*beta=A*h^2`, prove beta's domain and all eventual inequalities,
and derive the concrete `2^(-100*h^2)` target. This does not supply the
posterior Markov exceptional-set theorem, advice-marginal closeness,
likelihood/rank combination, KMS covering or relative-error mixture bound.
The specialized PCP/decoder, actual encoded randomized reduction,
learning transfer, fixed-L asymptotics, final Main/Audit and manuscript
reconciliation remain required by S3131-S3137/S3128. Full S3126 remains open.


## Author compilation update (2026-09-12)

This update supersedes the uncompiled status above for these exact source hashes;
the preceding draft account is historical. Both modules now author-build green.
Fresh independent three-lens review remains INCOMPLETE and must precede acceptance.
The source banners remain historical draft banners; no proof source was cosmetically
changed after its successful export.

Exclusive guarded direct compilation used pinned Lean 4.34.0-rc2 and existing author
outputs ahead of the pinned dependency path. LEAN_NUM_THREADS=1, Python UTF8;
768 MiB start / 640 MiB owned-child stop thresholds. No dependency export/download,
aggregate/map/config change, root 4.13 build, Git operation or publication occurred.

Actual terminal sessions: 54492 EXIT1, 71168 EXIT1, 8486 EXIT1 (main EXIT0,
Checks EXIT1), and Checks-only 77923 EXIT0. Every raw log, including failed attempts,
is embedded below. The successful main was not rerun for Checks-only repairs.

Proof-body repairs preserved every substantive theorem and example statement:
unfold tail for two cast bridges; use simp-only to apply block_moment before option
sum expansion; supply separate nonzero factors to field_simp; normalize the two
numeric examples with convert/norm_num. The first Unicode denominator replacement
in a PowerShell-fed Python script did not land; terminal 71168 exposed that remaining
failure. Exact apply_patch then applied the correction. No axiom, sorry, admit,
native_decide or supplied desired-tail premise was introduced.

Checks emitted all 17 standard-only axiom profiles and all 10 examples passed.
The generic exact product moment and optimized Chernoff bound are now author verified,
including zero mean. Manuscript parameter specialization, exceptional-advice theorem,
remaining full-hardness/learning dependencies and final paper reconciliation remain open.

### Durable raw build evidence

```json
[
  {
    "command": [
      "lean",
      "-R",
      "lean",
      "-o",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\DropCountTail.olean",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean"
    ],
    "exit_code": 1,
    "source_sha256": "7070cf6093f68e6804ba8a135d5d7c24b72a2fd3a76838aa159769233ba34eb1",
    "log_sha256": "123f72e055fd892d0ea3681ae25fdd884a8703df0ca23d28d0cd28759905eb06",
    "output_sha256": null,
    "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
    "log_path": "certifications\\realizable-hardness\\.lake\\build\\diagnostics\\DropCountTail-1789265326533214700.log",
    "raw_log_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean:37:2: error: mod_cast has type\n  (0 : ℚ) ≤ probability β fun d => T < dropCount d\nbut is expected to have type\n  (0 : ℝ) ≤ tail β J T\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean:45:2: error: mod_cast has type\n  (probability β fun d => T < dropCount d) ≤ 1\nbut is expected to have type\n  tail β J T ≤ 1\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean:51:48: warning: This simp argument is unused:\n  Fin.sum_univ_succ\n\nHint: Omit it from the simp argument list.\n  [apply] simp [Fintype.sum_option, blockMass, dropped]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean:52:2: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice\n\nNote: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean:68:13: error: unsolved goals\nβ : ℚ\nJ : ℕ\nt : ℝ\n⊢ (↑(blockMass β none) * Real.exp (t * ↑(dropped none)) +\n        ∑ i, ↑(blockMass β (some i)) * Real.exp (t * ↑(dropped (some i)))) ^\n      J =\n    (1 - ↑β + ↑β * Real.exp t) ^ J\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean:68:22: warning: This simp argument is unused:\n  block_moment\n\nHint: Omit it from the simp argument list.\n  [apply] simp\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nTry this:\n  [apply] ring_nf\n  \n  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.\n    \n  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean:124:62: error: unsolved goals\nβ : ℚ\nhβ : 0 ≤ β\nhβ1 : β ≤ 1\nJ T : ℕ\nhμ : 0 < ↑J * ↑β\nhT : ↑J * ↑β ≤ ↑T\nhtpos : 0 < ↑T\nhr : 0 < ↑T / (↑J * ↑β)\nht : 0 ≤ Real.log (↑T / (↑J * ↑β))\nh : tail β J T ≤ Real.exp (↑J * ↑β * (↑T / (↑J * ↑β) - 1) - Real.log (↑T / (↑J * ↑β)) * ↑T)\n⊢ -(↑J * ↑β) + ↑J * ↑β * ↑T * (↑J)⁻¹ * (↑β)⁻¹ - ↑T * Real.log (↑T * (↑J)⁻¹ * (↑β)⁻¹) =\n    -(↑J * ↑β) + ↑T - ↑T * Real.log (↑T * (↑J)⁻¹ * (↑β)⁻¹)\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean:155:8: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean:167:31: warning: This simp argument is unused:\n  h\n\nHint: Omit it from the simp argument list.\n  [apply] simp [blockMass]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\n\nEXIT 1\n"
  },
  {
    "command": [
      "lean",
      "-R",
      "lean",
      "-o",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\DropCountTail.olean",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean"
    ],
    "exit_code": 1,
    "source_sha256": "d5b47e93bd02350cb00ded9c42ca62aa1978e645ca02c5bf7d61839c43357255",
    "log_sha256": "8571fff4ff000d8c8de0e7c6ad042bb5110ea9b47d137c8517266a96e28dd2fc",
    "output_sha256": null,
    "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
    "log_path": "certifications\\realizable-hardness\\.lake\\build\\diagnostics\\DropCountTail-1789265438308438100.log",
    "raw_log_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean:53:48: warning: This simp argument is unused:\n  Fin.sum_univ_succ\n\nHint: Omit it from the simp argument list.\n  [apply] simp [Fintype.sum_option, blockMass, dropped]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean:54:2: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice\n\nNote: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`\nTry this:\n  [apply] ring_nf\n  \n  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.\n    \n  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean:126:62: error: unsolved goals\nβ : ℚ\nhβ : 0 ≤ β\nhβ1 : β ≤ 1\nJ T : ℕ\nhμ : 0 < ↑J * ↑β\nhT : ↑J * ↑β ≤ ↑T\nhtpos : 0 < ↑T\nhr : 0 < ↑T / (↑J * ↑β)\nht : 0 ≤ Real.log (↑T / (↑J * ↑β))\nh : tail β J T ≤ Real.exp (↑J * ↑β * (↑T / (↑J * ↑β) - 1) - Real.log (↑T / (↑J * ↑β)) * ↑T)\n⊢ -(↑J * ↑β) + ↑J * ↑β * ↑T * (↑J)⁻¹ * (↑β)⁻¹ - ↑T * Real.log (↑T * (↑J)⁻¹ * (↑β)⁻¹) =\n    -(↑J * ↑β) + ↑T - ↑T * Real.log (↑T * (↑J)⁻¹ * (↑β)⁻¹)\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean:157:8: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean:169:31: warning: This simp argument is unused:\n  h\n\nHint: Omit it from the simp argument list.\n  [apply] simp [blockMass]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\n\nEXIT 1\n"
  },
  {
    "command": [
      "lean",
      "-R",
      "lean",
      "-o",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\DropCountTail.olean",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean"
    ],
    "exit_code": 0,
    "source_sha256": "d2994d1124c7bfc39208906725a1475fe49ec1b8e33dc97303649401ffda2dd8",
    "log_sha256": "5a65c58263bf71e255218184a135b7a80f28cda13c43fa9395ef0b96353bbbb0",
    "output_sha256": "bfdf554f03ebb60892836d8cea266b6fb36b65604cfea77f7ffd0e868073c1bf",
    "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
    "log_path": "certifications\\realizable-hardness\\.lake\\build\\diagnostics\\DropCountTail-1789265479746776900.log",
    "raw_log_utf8": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean:53:48: warning: This simp argument is unused:\n  Fin.sum_univ_succ\n\nHint: Omit it from the simp argument list.\n  [apply] simp [Fintype.sum_option, blockMass, dropped]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean:54:2: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice\n\nNote: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean:129:8: warning: Unused tactic linter: `ring` does nothing\n\nNote: This linter can be disabled with `set_option linter.unusedTactic false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean:129:8: warning: this tactic is never executed\n\nNote: This linter can be disabled with `set_option linter.unreachableTactic false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean:158:8: warning: `if_neg` has been deprecated: Use `ite_eq_right` instead\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTail.lean:170:31: warning: This simp argument is unused:\n  h\n\nHint: Omit it from the simp argument list.\n  [apply] simp [blockMass]\n\nNote: This linter can be disabled with `set_option linter.unusedSimpArgs false`\n\nEXIT 0\n"
  },
  {
    "command": [
      "lean",
      "-R",
      "lean",
      "-o",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\DropCountTailChecks.olean",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTailChecks.lean"
    ],
    "exit_code": 1,
    "source_sha256": "ad33060916b75c6ac1959fa63f514f02ad0a9c9fadac7820025f3bbe276dde59",
    "log_sha256": "805c5c00b22acb86bb0d565a4680a8a560ff59bbc83a98aa6f3b52d3dba15c4d",
    "output_sha256": null,
    "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
    "log_path": "certifications\\realizable-hardness\\.lake\\build\\diagnostics\\DropCountTailChecks-1789265506926675600.log",
    "raw_log_utf8": "'PvNP.RealizableHardness.DropCountTail.dropCount_eq_sum' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.dropCount_cast' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.tail_sum' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.tail_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.tail_le_one' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.block_moment' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.moment_identity' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.moment_bound' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.exponential_tail' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.optimized_tail' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.chernoff_tail' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.tail_zero_of_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.tail_empty' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.prior_zero_of_drop' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.tail_beta_zero' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.tail_mean_zero' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.chernoff_tail_allow_zero' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTailChecks.lean:38:2: error: Type mismatch: After simplification, term\n  chernoff_tail (1 / 2)\n    (Mathlib.Meta.NormNum.isRat_le_true\n      (Mathlib.Meta.NormNum.IsNNRat.to_isRat\n        (Mathlib.Meta.NormNum.IsNat.to_isNNRat (Mathlib.Meta.NormNum.isNat_ofNat ℚ (Eq.refl 0))))\n      (Mathlib.Meta.NormNum.IsNNRat.to_isRat\n        (Mathlib.Meta.NormNum.isNNRat_div\n          (Mathlib.Meta.NormNum.isNNRat_mul (Eq.refl HMul.hMul)\n            (Mathlib.Meta.NormNum.IsNat.to_isNNRat (Mathlib.Meta.NormNum.isNat_ofNat ℚ (Eq.refl 1)))\n            (Mathlib.Meta.NormNum.isNNRat_inv_pos\n              (Mathlib.Meta.NormNum.IsNat.to_isNNRat (Mathlib.Meta.NormNum.isNat_ofNat ℚ (Eq.refl 2))))\n            (Eq.refl (Nat.mul 1 1)) (Eq.refl 2))))\n      (Eq.refl true))\n    (Mathlib.Meta.NormNum.isRat_le_true\n      (Mathlib.Meta.NormNum.IsNNRat.to_isRat\n        (Mathlib.Meta.NormNum.isNNRat_div\n          (Mathlib.Meta.NormNum.isNNRat_mul (Eq.refl HMul.hMul)\n            (Mathlib.Meta.NormNum.IsNat.to_isNNRat (Mathlib.Meta.NormNum.isNat_ofNat ℚ (Eq.refl 1)))\n            (Mathlib.Meta.NormNum.isNNRat_inv_pos\n              (Mathlib.Meta.NormNum.IsNat.to_isNNRat (Mathlib.Meta.NormNum.isNat_ofNat ℚ (Eq.refl 2))))\n            (Eq.refl (Nat.mul 1 1)) (Eq.refl 2))))\n      (Mathlib.Meta.NormNum.IsNNRat.to_isRat\n        (Mathlib.Meta.NormNum.IsNat.to_isNNRat (Mathlib.Meta.NormNum.isNat_ofNat ℚ (Eq.refl 1))))\n      (Eq.refl true))\n    4 3\n    (Mathlib.Meta.NormNum.isNat_lt_true (Mathlib.Meta.NormNum.isNat_ofNat ℝ Nat.cast_zero)\n      (Mathlib.Meta.NormNum.IsNNRat.to_isNat\n        (Mathlib.Meta.NormNum.isNNRat_mul (Eq.refl HMul.hMul)\n          (Mathlib.Meta.NormNum.IsNat.to_isNNRat\n            (Mathlib.Meta.NormNum.isNat_natCast 4 4 (Mathlib.Meta.NormNum.isNat_ofNat ℕ (Eq.refl 4))))\n          (Mathlib.Meta.NormNum.isNNRat_ratCast\n            (Mathlib.Meta.NormNum.isNNRat_div\n              (Mathlib.Meta.NormNum.isNNRat_mul (Eq.refl HMul.hMul)\n                (Mathlib.Meta.NormNum.IsNat.to_isNNRat (Mathlib.Meta.NormNum.isNat_ofNat ℚ (Eq.refl 1)))\n                (Mathlib.Meta.NormNum.isNNRat_inv_pos\n                  (Mathlib.Meta.NormNum.IsNat.to_isNNRat (Mathlib.Meta.NormNum.isNat_ofNat ℚ (Eq.refl 2))))\n                (Eq.refl (Nat.mul 1 1)) (Eq.refl 2))))\n          (Eq.refl (Nat.mul 4 1)) (Eq.refl 2)))\n      (Eq.refl false))\n    (Mathlib.Meta.NormNum.isNat_le_true\n      (Mathlib.Meta.NormNum.IsNNRat.to_isNat\n        (Mathlib.Meta.NormNum.isNNRat_mul (Eq.refl HMul.hMul)\n          (Mathlib.Meta.NormNum.IsNat.to_isNNRat\n            (Mathlib.Meta.NormNum.isNat_natCast 4 4 (Mathlib.Meta.NormNum.isNat_ofNat ℕ (Eq.refl 4))))\n          (Mathlib.Meta.NormNum.isNNRat_ratCast\n            (Mathlib.Meta.NormNum.isNNRat_div\n              (Mathlib.Meta.NormNum.isNNRat_mul (Eq.refl HMul.hMul)\n                (Mathlib.Meta.NormNum.IsNat.to_isNNRat (Mathlib.Meta.NormNum.isNat_ofNat ℚ (Eq.refl 1)))\n                (Mathlib.Meta.NormNum.isNNRat_inv_pos\n                  (Mathlib.Meta.NormNum.IsNat.to_isNNRat (Mathlib.Meta.NormNum.isNat_ofNat ℚ (Eq.refl 2))))\n                (Eq.refl (Nat.mul 1 1)) (Eq.refl 2))))\n          (Eq.refl (Nat.mul 4 1)) (Eq.refl 2)))\n      (Mathlib.Meta.NormNum.isNat_natCast 3 3 (Mathlib.Meta.NormNum.isNat_ofNat ℕ (Eq.refl 3))) (Eq.refl true))\n has type\n  tail 2⁻¹ 4 3 ≤ (Real.exp 1 * (4 * 2⁻¹) / 3) ^ 3\nbut is expected to have type\n  tail 2⁻¹ 4 3 ≤ (Real.exp 1 * 2 / 3) ^ 3\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTailChecks.lean:42:2: error: Type mismatch: After simplification, term\n  chernoff_tail (1 / 2)\n    (Mathlib.Meta.NormNum.isRat_le_true\n      (Mathlib.Meta.NormNum.IsNNRat.to_isRat\n        (Mathlib.Meta.NormNum.IsNat.to_isNNRat (Mathlib.Meta.NormNum.isNat_ofNat ℚ (Eq.refl 0))))\n      (Mathlib.Meta.NormNum.IsNNRat.to_isRat\n        (Mathlib.Meta.NormNum.isNNRat_div\n          (Mathlib.Meta.NormNum.isNNRat_mul (Eq.refl HMul.hMul)\n            (Mathlib.Meta.NormNum.IsNat.to_isNNRat (Mathlib.Meta.NormNum.isNat_ofNat ℚ (Eq.refl 1)))\n            (Mathlib.Meta.NormNum.isNNRat_inv_pos\n              (Mathlib.Meta.NormNum.IsNat.to_isNNRat (Mathlib.Meta.NormNum.isNat_ofNat ℚ (Eq.refl 2))))\n            (Eq.refl (Nat.mul 1 1)) (Eq.refl 2))))\n      (Eq.refl true))\n    (Mathlib.Meta.NormNum.isRat_le_true\n      (Mathlib.Meta.NormNum.IsNNRat.to_isRat\n        (Mathlib.Meta.NormNum.isNNRat_div\n          (Mathlib.Meta.NormNum.isNNRat_mul (Eq.refl HMul.hMul)\n            (Mathlib.Meta.NormNum.IsNat.to_isNNRat (Mathlib.Meta.NormNum.isNat_ofNat ℚ (Eq.refl 1)))\n            (Mathlib.Meta.NormNum.isNNRat_inv_pos\n              (Mathlib.Meta.NormNum.IsNat.to_isNNRat (Mathlib.Meta.NormNum.isNat_ofNat ℚ (Eq.refl 2))))\n            (Eq.refl (Nat.mul 1 1)) (Eq.refl 2))))\n      (Mathlib.Meta.NormNum.IsNNRat.to_isRat\n        (Mathlib.Meta.NormNum.IsNat.to_isNNRat (Mathlib.Meta.NormNum.isNat_ofNat ℚ (Eq.refl 1))))\n      (Eq.refl true))\n    4 2\n    (Mathlib.Meta.NormNum.isNat_lt_true (Mathlib.Meta.NormNum.isNat_ofNat ℝ Nat.cast_zero)\n      (Mathlib.Meta.NormNum.IsNNRat.to_isNat\n        (Mathlib.Meta.NormNum.isNNRat_mul (Eq.refl HMul.hMul)\n          (Mathlib.Meta.NormNum.IsNat.to_isNNRat\n            (Mathlib.Meta.NormNum.isNat_natCast 4 4 (Mathlib.Meta.NormNum.isNat_ofNat ℕ (Eq.refl 4))))\n          (Mathlib.Meta.NormNum.isNNRat_ratCast\n            (Mathlib.Meta.NormNum.isNNRat_div\n              (Mathlib.Meta.NormNum.isNNRat_mul (Eq.refl HMul.hMul)\n                (Mathlib.Meta.NormNum.IsNat.to_isNNRat (Mathlib.Meta.NormNum.isNat_ofNat ℚ (Eq.refl 1)))\n                (Mathlib.Meta.NormNum.isNNRat_inv_pos\n                  (Mathlib.Meta.NormNum.IsNat.to_isNNRat (Mathlib.Meta.NormNum.isNat_ofNat ℚ (Eq.refl 2))))\n                (Eq.refl (Nat.mul 1 1)) (Eq.refl 2))))\n          (Eq.refl (Nat.mul 4 1)) (Eq.refl 2)))\n      (Eq.refl false))\n    (Mathlib.Meta.NormNum.isNat_le_true\n      (Mathlib.Meta.NormNum.IsNNRat.to_isNat\n        (Mathlib.Meta.NormNum.isNNRat_mul (Eq.refl HMul.hMul)\n          (Mathlib.Meta.NormNum.IsNat.to_isNNRat\n            (Mathlib.Meta.NormNum.isNat_natCast 4 4 (Mathlib.Meta.NormNum.isNat_ofNat ℕ (Eq.refl 4))))\n          (Mathlib.Meta.NormNum.isNNRat_ratCast\n            (Mathlib.Meta.NormNum.isNNRat_div\n              (Mathlib.Meta.NormNum.isNNRat_mul (Eq.refl HMul.hMul)\n                (Mathlib.Meta.NormNum.IsNat.to_isNNRat (Mathlib.Meta.NormNum.isNat_ofNat ℚ (Eq.refl 1)))\n                (Mathlib.Meta.NormNum.isNNRat_inv_pos\n                  (Mathlib.Meta.NormNum.IsNat.to_isNNRat (Mathlib.Meta.NormNum.isNat_ofNat ℚ (Eq.refl 2))))\n                (Eq.refl (Nat.mul 1 1)) (Eq.refl 2))))\n          (Eq.refl (Nat.mul 4 1)) (Eq.refl 2)))\n      (Mathlib.Meta.NormNum.isNat_natCast 2 2 (Mathlib.Meta.NormNum.isNat_ofNat ℕ (Eq.refl 2))) (Eq.refl true))\n has type\n  tail 2⁻¹ 4 2 ≤ (Real.exp 1 * (4 * 2⁻¹) / 2) ^ 2\nbut is expected to have type\n  tail 2⁻¹ 4 2 ≤ Real.exp 1 ^ 2\n\nEXIT 1\n"
  },
  {
    "command": [
      "lean",
      "-R",
      "lean",
      "-o",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean\\PvNP\\RealizableHardness\\DropCountTailChecks.olean",
      "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTailChecks.lean"
    ],
    "exit_code": 0,
    "source_sha256": "e2d2719251410fc14b746bb69a3eea88ad931550e103c1266811011fa1aa1239",
    "log_sha256": "36b52d87adda88ec576e8efd8fb2c76896c7b3e5086d9a7111d593459dbc2931",
    "output_sha256": "ae0ad0f2681b3b16d36eb76f5e25622ddc540488753aaaefa9f852017502d5a1",
    "LEAN_PATH": "C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\build\\independent-review-20260912\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Cli\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\batteries\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\Qq\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\aesop\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\proofwidgets\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\importGraph\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\LeanSearchClient\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\plausible\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\complexitylib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\mathlib\\.lake\\build\\lib\\lean;C:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\.lake\\packages\\cslib\\.lake\\build\\lib\\lean;c:\\Users\\Dan\\.elan\\toolchains\\leanprover--lean4---v4.34.0-rc2\\lib\\lean",
    "log_path": "certifications\\realizable-hardness\\.lake\\build\\diagnostics\\DropCountTailChecks-1789265556137114200.log",
    "raw_log_utf8": "'PvNP.RealizableHardness.DropCountTail.dropCount_eq_sum' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.dropCount_cast' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.tail_sum' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.tail_nonneg' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.tail_le_one' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.block_moment' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.moment_identity' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.moment_bound' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.exponential_tail' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.optimized_tail' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.chernoff_tail' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.tail_zero_of_le' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.tail_empty' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.prior_zero_of_drop' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.tail_beta_zero' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.tail_mean_zero' depends on axioms: [propext, Classical.choice, Quot.sound]\n'PvNP.RealizableHardness.DropCountTail.chernoff_tail_allow_zero' depends on axioms: [propext,\n Classical.choice,\n Quot.sound]\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTailChecks.lean:40:12: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice\n\nNote: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`\nC:\\Users\\Dan\\Desktop\\Projects\\formal-pvnp\\certifications\\realizable-hardness\\lean\\PvNP\\RealizableHardness\\DropCountTailChecks.lean:45:12: warning: Used `tac1 <;> tac2` where `(tac1; tac2)` would suffice\n\nNote: This linter can be disabled with `set_option linter.unnecessarySeqFocus false`\n\nEXIT 0\n"
  }
]
```
