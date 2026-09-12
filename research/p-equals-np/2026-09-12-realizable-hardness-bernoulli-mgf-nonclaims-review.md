# Centered Bernoulli MGF: independent non-claims review

2026-09-12. Reviewer `mgf_nonclaims_review`, independent of the module and receipt author. Candidate `6750bbcf858414cb1b04084dc8b2dff40dc43a8e`; S3130 under the open S3126 goal.

**Verdict: GO.** No actionable non-claims defect found in the scoped candidate. This verdict concerns truthful scope and wording, not completion of either parent goal or an independent kernel build.

## Evidence inspected

Read the two actual Lean modules, the candidate formalization receipt, the destination `INTEGRITY-CLAIMS.md`, and the planning formal-three-lens closeout protocol. No destination AGENTS.md exists. Compared the analytic theorem with the finite-sampling paragraph of the public artifact's `MANUSCRIPT.md`, especially its sample-size choice and simultaneous probability guarantee.

Independent binary reads of each frozen Git blob and working file give identical raw bytes (and therefore identical normalized bytes):

| Source | Frozen Git and working SHA256 |
|---|---|
| `lean/PvNP/RealizableHardness/BernoulliMGF.lean` | `d923ad4b96435ba3e7d4c9e1c4f0b040d7747317a5de865b6f31bded97abbe32` |
| `lean/PvNP/RealizableHardness/BernoulliMGFChecks.lean` | `f370c56951ed923db58da67d1cdbc93e3a4cadf8b994c62abbc588e604be450f` |

The frozen commit changes only these two modules and `research/p-equals-np/2026-09-12-realizable-hardness-bernoulli-mgf-formalization.md`.

## Scope assessment

`PvNP.RealizableHardness.BernoulliMGF.centered_mgf_le` states the exact centered two-point exponential expression bounded by `Real.exp (t^2/8)`, for arbitrary real t and precisely the probability hypotheses `0 <= p` and `p <= 1`. No sign restriction or nondegeneracy hypothesis is hidden. Its helper definitions describe the partition function and real analytic gap and derivatives. The receipt accurately presents these mathematical objects and the constant, and expressly leaves concentration to subsequent work.

The phrase "including both tails" in the theorem comment is justified as availability for both signs of t; it does not assert that either probability tail theorem is already proved. The receipt removes potential ambiguity by listing the outstanding product-law, exponential Markov, optimization and simultaneous-event steps. Its 13 named audit targets match the 13 `#print axioms` directives in the checks module. The author reports actual builds separately from the independent reviews; this review does not convert that report into a fresh kernel audit.

The noncomputable real definitions are legitimate analytic mathematics. They neither provide nor claim an encoded sampler or polynomial-time machine. Endpoints and positive/negative concrete examples support statement checks without replacing the general theorem. The receipt does not claim this established analytic inequality is a novel research result.

## Required remaining boundary

The manuscript asks for M independent sampled formulas, its least-power-of-two sample-size threshold, and a probability at least 2/3 guarantee simultaneously across all assignments, including distributional approximation error. None follows from this module alone. Connecting actual indicator masses, factoring the finite-product MGF, exponential Markov, optimizing both tails, the finite union bound, choosing M, and composing distributional rounding remain separate proof obligations. Encoding and runtime bridges also remain separate.

The scoped files claim no completed finite-sampling theorem, randomized polynomial-time reduction, PCP theorem, NP-hardness result, learning transfer, P-versus-NP resolution, human certification, priority certification, submission or public release. Their explicit open S3130/S3126 labels are accurate. This GO authorizes only the non-claims lens for this analytic increment; it cannot close those larger stories.

No code, other reviews, shared records, toolchain, public metadata or remote state was changed. No heavy build was run. The only authored artifact is this review receipt.
