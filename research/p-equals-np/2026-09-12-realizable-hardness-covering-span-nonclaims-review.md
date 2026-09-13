# CoveringSpan non-claims review

Date: 2026-09-12. Route: S3126 / S3134. Lens: top-level non-claims-boundary-reviewer.

**Verdict: GO-WITH-NOTES for the bounded unconditional advice-marginal TV component.** This verdict is a wording/statement review, not independent compiler acceptance, full-proof certification, human peer review, or authorization to announce the full theorem.

## Reviewed evidence

Reviewed the planning formal-three-lens closeout protocol, satellite README and companion scope, CoveringSpan declarations and final proof chain, all CoveringSpanChecks examples/profile requests, and the author receipt's mathematical claims and superseding verification update. No satellite AGENTS.md was present. The three reviewed files have no Git diff from frozen commit `be269836555599253d45f3bf1d5dc90c5c256941` despite the repository HEAD advancing for other work.

Working-byte SHA256 values:

| File | SHA256 |
|---|---|
| CoveringSpan.lean | `9d97d39786ecff8a3faf7c478cb82a745a0c873f86af105f2ed307cfcb75f635` |
| CoveringSpanChecks.lean | `2fa4251ff8c3b57f8d7890d672f615fd2e36e245cac5a87f36e4d70aabcd78e7` |
| 2026-09-12-realizable-hardness-covering-span-draft.md | `6f8cfc3b09001a2ceee85014d880b537e55d633e60621fe1be3d990a50ac4233` |

The receipt records main EXIT0 session19665 and Checks EXIT0 session89823, 31 selected standard-only axiom reports, and ten elaborated examples. Its earlier failures and UNCOMPILED checkpoint are retained explicitly as history. This lens ran no compiler and makes no independent-build claim; the orchestrator must reconcile the separate proof review and actual independent result.

## Exact accepted wording

For natural J and a with a <= J and rational beta with 0 <= beta <= 1, `actual_adviceTV_le_manuscript` bounds the real cast of the existing rational half-L1 quantity

`AdviceExceptions.tv ambientMass (adviceMarginal beta)`

by `beta * sqrt(J) * 2^(a+4)`.

The underlying two-term theorem retains the explicit correction

`beta * sqrt(J) * 2^a + beta * J * (2^a - 1) / 2^J`.

The theorem uses the actual finite draw prior, retained subspaces and incidence-based advice marginal. It does not assume the desired TV bound, a good-marginal promise, or the final sampler identity. The coordinate/product-mixture and randomized-span identities are derived. The common span kernel uses ambient-uniform fallback on dependent arrays; consequently its retained-array pushforward is compared to, rather than silently identified with, uniform advice inside the retained space. No deletion gives zero correction, preserving the beta factor even at beta=0. The final rational/real TV bridge matches the existing advice-exception interface.

Here “unconditional covering” means the unconditioned advice-marginal comparison on the stated finite probability/dimension domain. It does not remove beta-range or a <= J hypotheses. Empty J=a=0 and beta=0 are included. A stronger absorbed constant can be read from the proof inequalities, but neither that observation nor the absence of an additional small-beta premise establishes novelty, a correction to the literature, or a new quantum algorithm.

## Boundaries and notes

1. Advice-conditioned covering, zoom geometry, near-one conditional ratios, positive-conditioning normalization, and their manuscript error specializations remain outside this result. No posterior independence or simultaneous guarantee over all auxiliary subspaces follows from this marginal bound alone.
2. The prescribed parameter family, all required asymptotic inequalities and quantifier order, specialized PCP/decoder and star construction, exact learning transfer, encoded randomized reduction, coins/runtime/weight bounds, fixed-L assembly, and full realizable-hardness theorem are not supplied here. Finite noncomputable probability algebra is not an executable polynomial-time sampler theorem.
3. The source and Checks retain conservative UNCOMPILED banners. The receipt explicitly supersedes the initial author status; this is stale presentation, not an overclaim or a reason to rebuild unchanged source. Future publication must reconcile status text and actual accepted scope.
4. The receipt's description of rank-error accounting is treated as motivation for this formal derivation, not a verified source-error or priority claim. No novelty review was performed by this lens.
5. No claim of P=NP, P!=NP, complete Lean certification, submission readiness, peer-reviewed acceptance, or public inclusion of these files in an existing DOI is justified by this increment.

No blocking wording overclaim was found in the reviewed component and superseding receipt. Route-final closeout still requires the separate proof-adversarial and complexity reviews and actual independent build evidence; the parent full-proof and paper goal remains open.
