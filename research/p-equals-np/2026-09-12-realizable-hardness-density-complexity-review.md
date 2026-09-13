# S3133 Gaussian ratio and posterior density: independent complexity review

Date: 2026-09-12. Verdict: **GO-WITH-NOTES** for the exact finite quantitative increment, not full hardness certification.

Frozen candidate: `ae1bc948df7e06f8c754f5e05e8bea6cddfcebd8`.
Reviewer: independent AI agent `/root/density_complexity_review`, not an author or human peer. This is source/semantic complexity review; no compiler, download, source modification, configuration change, publication or Git mutation was performed. Independent kernel rebuilding is a separate pending lens, not established by this report.

## Inspected scope and identity

Read the complete four companion sources under `certifications/realizable-hardness/lean/PvNP/RealizableHardness/`, the dated gaussian-ratio-draft and posterior-density-draft author receipts, the full realizable-hardness Lean dependency assessment, S3133 and the planning protocol/three-lens instructions, and the submission manuscript's posterior/zoom-out section. Inspected the actual GrassmannIncidence definitions and normalization/support/Bayes lemmas used by the new proofs. Working source bytes match the frozen Git candidate after CRLF normalization; SHA256 values of inspected file bytes are:

| Source | SHA256 |
|---|---|
| GaussianRatio.lean | `64cfc97ec8af757697d3cca47ecea4c8942b966fdd1d10180e77c3385faaf0d8` |
| GaussianRatioChecks.lean | `c81b2b5f38fe29d9e50bf6e37f599a58d18d10b4861f520c9cff943cae846252` |
| PosteriorDensity.lean | `7f730e6185224981b8e32b98406d8678ac89912d993dd46e3045305804f94ada` |
| PosteriorDensityChecks.lean | `b0749bbeb21d59dbfd7ada467e2b372757fd4c04c330d403b5046e1307d5976c` |

Author receipts record four EXIT 0 builds, 23 standard-axiom profiles (12 plus 11), and fourteen elaborated examples (seven per Checks file). I read those embedded outputs; this report does not substitute them for independent execution. DropCountTail and AdviceExceptions are expressly outside acceptance. The existing untracked AdviceExceptions draft was preserved.

## Mathematical and quantifier findings

1. `gaussian_ratio_eq` obtains the actual Gaussian count ratio through subspace/frame double counting, not through a supplied ratio oracle. The normalization removes `2^(n*a)` from the independent-frame product. Casts of natural subtraction require the explicit dimension inequalities. For `a <= m <= n`, the denominator Gaussian count, frame count and normalized denominator are proved nonzero. The exponent identity uses `m <= n` to discharge natural-subtraction truncation.
2. `gaussian_ratio_le` assumes the stronger `a+1 <= m`, proving the normalized denominator at least one half by an elementary product/geometric-sum bound. Together with numerator at most one this gives `2*2^(a*(n-m))`. The actual retained-space specialization uses `dim(V)=3J-2D` and `2D<=3J`, yielding the manuscript's deliberately looser constants four, then eight after the good-marginal factor and `D<=T`. The theorem does not cover every diagonal count with this bound; diagonal counting remains separately valid. This restriction is honest and sufficient once the application establishes `a+1<=J`.
3. `ambientMass` is reciprocal cardinality of the actual ambient advice type, with cardinality `[3J choose a]_2`. `kernel` is zero off containment and the reciprocal of the actual containing-fibre count on containment. `prior`, `adviceMarginal` and `conditional` are the existing actual finite draw law, its marginal and its Bayes posterior. No replacement distribution or independent-posterior surrogate enters the proof.
4. `kernel_div_marginal_le` uses `P(Q)/2 <= P'(Q)`. This forces a positive marginal since the ambient count is positive, while `a<=J` makes every retained fibre nonempty. Thus the divisions used in the probability interpretation are legitimate. `conditional_density_le` requires a positive prior atom; `conditional_mass_le` separately proves that zero prior atoms have zero posterior mass and then covers all atoms. Neither null events nor beta endpoints are silently divided away.
5. The numerical density statement permits arbitrary rational beta given its explicit positive-prior and good-marginal hypotheses. It must not be called a probability theorem outside `0<=beta<=1`. The mass/event/fixed-subspace theorems do impose both beta bounds; the upstream law is then nonnegative and normalized, and good marginal ensures normalized conditioning. No extra strict-beta assumption excludes beta=0 or beta=1.
6. The cutoff complement is exactly `T < dropCount d`, not an altered weak-tail event. `event_transfer` leaves its actual conditional finite tail mass explicit. The fixed-subspace theorem composes the established unconditional bound `(2^codim(W)-1)*beta` with that event transfer. It does not assert conditional independence or reuse an unconditional probability as though already conditioned.
7. `W` is a single arbitrary submodule quantified outside the draw function. It may depend on the fixed Q. This is pointwise uniformity over W, not a simultaneous probability bound for a union over all W, and not permission to choose W after observing the draw. The theorem even allows W not containing Q; this is a harmless strengthening of the local rank-transfer statement. The manuscript's later geometric application still separately requires Q contained in W.

No blocking false-force, circular desired-bound premise, vacuous promise replacement or hidden complexity-class claim was found in these four statements.

## Exact manuscript correspondence and remaining obligations

The pair establishes the manuscript's finite inequality

    Pr[V | Q] / Pr[V] <= 8 * 2^(2*a*T)

on positive prior atoms with D<=T and the stated good-marginal/spare-dimension conditions, together with the all-atom mass version. It also establishes

    Pr[rank failure | Q] <= 8 * 2^(2*a*T) * (2^codim(W)-1) * beta + Pr[D>T | Q].

It does not yet establish the manuscript's final `<=2*zeta`, or that almost every advice Q satisfies these hypotheses. Specifically:

- The actual prior Chernoff bound, specialization T=h^4 and beta=A*h^2/J, and its eventual `2^(-100h^2)` estimate remain outside this candidate. DropCountTail is not accepted here.
- Markov's exceptional-advice estimate, low-marginal exceptional mass and transfer from P' to P remain outside this candidate. AdviceExceptions is not accepted here. Even a generic total-variation exceptional-set lemma would still need the actual quantitative proximity bound.
- KMS advice/zoom-in covering bounds, the full exceptional-set union, and conditioning the (V,L) experiment on Q contained in L to obtain this same posterior remain separate obligations.
- The one-sided constant Gaussian ratio does not prove the near-one relative-error quotient for `p_V/p0`, with `p0=2^(-c*(d-a))`. Its uniform O(2^(-J/2)) estimate, stable/unstable weighted-mixture normalization and losses involving division by p0 remain open.
- Applying the stronger sufficient condition `a+1<=J`, beta range and all eventual small-error inequalities must be discharged from the final parameter choice; this report does not supply those asymptotics.
- These noncomputable finite counting and probability constructions are not polynomial-time algorithms. Encodings, random-bit consumption, runtime and concrete reduction composition remain S3131 obligations. The specialized PCP/decoder, learning transfer and fixed-L final assembly in the full ledger remain required. No NP-hardness conclusion or P-versus-NP resolution follows from the four-module increment alone.

## Notes and closeout recommendation

The source headers still say UNCOMPILED while dated receipts explicitly supersede that historical status with author-green results. This is conservative stale wording, not an inflated mathematical claim; update status metadata only after the independent review evidence is complete and preserve frozen proof identity.

Accept the bounded ratio/density increment after the independent proof/build and non-claims lenses also complete. Do not close S3133 or S3126, or advertise full Lean certification, on this report. The remaining proof dependencies and final submission-paper theorem-to-Lean reconciliation stay open.
