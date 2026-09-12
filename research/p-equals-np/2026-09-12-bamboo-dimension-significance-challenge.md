# Adversarial significance assessment: dimension extension

2026-09-12; S3114 / S008. Independent significance lens, not a new correctness certification. [Integrity](../../INTEGRITY-CLAIMS.md).

**Assessment: REVISE for a modest versioned addendum, not a standalone methodological advance.** A useful wider parameter guarantee is present. The incremental proof is essentially an explicit re-budgeting of the already-public v4 argument; the near-quadratic corollary is then parameter arithmetic. This is not merely changing terminology, but it should not be sold as a new generator construction, new positivity mechanism, or meaningful direct advance on P versus NP. A citable update can be worthwhile without any such claim.

## Evidence and independence

Read S3114, the planning publication-readiness and frontier-research protocols, the prior contribution audit, the dimension source review, and the actual complete dimension-budget proof. Read public v4 OUTPUT-NOTE.md, including its conditional estimate, assembly inequality and indexed corollary. Prior verdicts are background, not premises for this conclusion.

The reviewed private source is commit `3d381934744c48f7afa913ac650037a477148a19`; the working file and that commit both have Git blob `121e62bc15926696611baf8cb00dca6d4c16643d`. Initial `git status --short` was empty. Public comparison is v4 commit `09aca60184fe7b1d61856cd79ac21aa86ea4caca`. Only this assessment file is written, intentionally left uncommitted for orchestration closeout.

Live browsing checked the [ECCC record](https://eccc.weizmann.ac.il/report/2026/133/), [arXiv history](https://arxiv.org/abs/2608.08760) and [v1 PDF](https://arxiv.org/pdf/2608.08760v1). Exact theorem numbering below follows the supplied cached ECCC text (cached TR26-133 primary text). The arXiv record currently lists only v1. Bounded searches for weak rank/SoS/bamboo and sum-of-squares bamboo generators located no additional primary theorem supplying this exact guarantee. Irrelevant results and secondary summaries were not mathematical evidence. This is not exhaustive citation closure or priority certification.

## What changes from v4, and how automatic is it?

V4 proves the exact simple-bamboo explicit real SoS lower bound for `m=q^2`, `N=8q+4`, and `D=floor(q/(32 log_2 q))`. Its seed/output relation is `t=Theta(s^(4/3))`, with lower-bound scale `exp(Omega(s^(1/3)/log s))`. The new note permits

    8q+4 < m <= 2^(q/32-1),
    D=floor(q/(32 log_2(2m))),
    S >= (8/7)^(D-1/2).

Its indexed choice `q=2r^3`, `m=2^r` gives `t=Theta(s^2/(log s)^6)` and `S>=exp(Omega((log s)^2))` on the exact inversion CNF. This improves attainable output length within the stated encoding/system guarantee, while weakening the seed-normalized lower-bound scale relative to the old subfamily. It is a tradeoff, not simultaneous improvement of every resource.

Here is the strongest redundancy challenge. V4 already displays the two decisive inequalities with symbolic m before specializing:

    epsilon = 2^(-q/2+4D+5),
    R_A(p^2) >= [1-(L_ctx-1)epsilon] sum_T ||h_T||^2,
    L_ctx = sum_(j<=2D) binom(2m,j).

The new budget immediately gives

    log_2 L_ctx <= 1+2D log_2(2m) <= 1+q/16,
    log_2(L_ctx epsilon) <= 6-5q/16.

All local correlations and the restriction interface were already independent of unused ambient labels. The new note checks that fact carefully, including floors, endpoints, formula construction cost and nonrange outputs. Those checks make the expanded statement legitimate; they do not constitute a new analytic mechanism. Once the general-m statement is accepted, choosing `m=2^r` and `N=Theta(r^3)` automatically yields `s=Theta(2^r r^3)` and `t=2^(2r)`.

Thus it is **not** a literal substitution into the old theorem, whose hypothesis fixes m. It is a short generalization available from the old proof. Repeating the full proof is useful for a self-contained public record but should not inflate the assessed mathematical increment. The stronger claim that this opens a previously inaccessible method or resolves the failed iteration mechanism does not survive this challenge.

The sixth logarithmic power is the selected corollary's output loss, not an optimality claim. Likewise the exponential upper endpoint is the nonzero-D range of this conservative formula, not a barrier theorem. At `m=q^2` the new D is asymptotically about half the old D; preserve the old statement instead of replacing it with a supposedly stronger universal theorem.

## Closest primary theorems and exact mismatch

The following comparisons refer to [Garlik--Gryaznov--Ren--Tzameret](https://arxiv.org/pdf/2608.08760v1):

| Source | Guarantee and mismatch |
|---|---|
| Definition 4.3 | Real SoS size is `sum ||f_i||||g_i||+sum ||h_j||`, counting explicit roots before squaring. The new measure matches; it is not circuit size. |
| Theorem 6.11 | For arbitrary Boolean A, `m>n>=20`, and `16` dividing `n-4`, simple-bamboo SA size is at least `(sqrt(8/7))^((n-4)/8-1)`. Same encoding, different proof system. |
| Theorem 5.18 | Arbitrary `m>n>0` and Boolean A have `2^Omega(n)` SoS hardness for the perfect-matching CNF. Same system, different extension encoding. |
| Theorem 5.20 | Arbitrary-output bamboo PCR over F2 has exponential size hardness. Its AND/prefix encoding and field differ from the new real simple-bamboo identity. |

Section 2.2 explicitly leaves the SoS extension unpursued. Near-quadratic rank-map geometry is already advertised in the source. These observations establish neither priority nor a general impossibility of transferring the stronger existing bounds.

The exact unsupplied guarantee is therefore a growing explicit real SoS lower bound in the *simple-bamboo* CNF for this larger-m range. SA hardness alone does not exclude all SoS certificates. Sharing the equation `XY=A` does not identify perfect-matching extensions with deterministic prefix variables. To dismiss the new guarantee as already implied by Theorem 5.18 one would need an applicable reduction with the right direction and polynomial cost in the explicit monomial measure. Neither the new proof nor the inspected source provides that bridge. Conversely, failure to locate such a bridge does not prove novelty.

The published-source comparison supports an encoding-specific addition, with a log-m loss and bounded dimension window. It does not support first weak-rank SoS lower bound, first near-quadratic proof-complexity generator, best exponent, arbitrary-m exponential SoS hardness, or a new matrix-product map.

## Significance and the broader objective

The reader benefit is concrete: a reader interested in this natural sequential parity encoding can now cite exactly when increasing ambient dimension retains superpolynomial explicit SoS hardness, rather than reconstructing the parameter dependence from v4. The condition `q/(log m)^2 -> infinity` isolates a useful subrange. The full admissible window alone only guarantees a nontrivial bound and can leave D constant.

The result does not supply a credible direct P-versus-NP implication. Membership in the generator range is exactly binary rank at most N; elimination decides it and produces rank factorizations in polynomial time. All prefix witnesses are then computed directly. For nonrange outputs the lower bound concerns one explicit certificate representation for an efficiently decidable family. It does not establish hardness of certificate discovery for all representations, polynomial-time SAT impossibility, or general circuit lower bounds. High-rank matrices such as the identity show nonvacuity, not NP-hardness. In-range outputs are vacuous refutation instances.

This matters independently as proof-complexity/encoding analysis. Such a contribution need not come with a guaranteed breakthrough to be publishable. However, it should not receive ongoing frontier priority merely because successive parameter restatements remain provable. After this addendum, another research increment should identify an actual missing mechanism or new guarantee rather than another convenient indexed specialization.

## Concrete disposition for S3114

The substantive-milestone check can pass narrowly for an update to the existing artifact: the new theorem quantifies over an explicit dimension range and records a useful stretch/hardness tradeoff absent from the previous theorem. It would be misleading to count the dimension theorem and its automatic indexed specialization as two independent research breakthroughs.

Recommend **REVISE** pending a bounded public candidate and its normal evidence/metadata review. The mathematical source already uses conservative language; the required revision is principally publication presentation and gate completion, not another proof campaign. The candidate should:

1. Call itself a dimension-budget addendum or extension of the existing argument; give the old-versus-new tradeoff explicitly.
2. Credit the prior source's near-quadratic geometry, stronger different-system/different-encoding results, and imported restriction.
3. Preserve exact certificate measure, indexed lengths, easy rank membership, nonrange/vacuous distinction, general-window versus superpolynomial-subfamily distinction, and unknown priority.
4. Preserve the stronger old fixed-parameter theorem and all historical proof/license blobs; complete the exact-candidate publication checks under S3114.

No further mathematical advance is a prerequisite for publishing this narrowly useful addendum. If publication is instead framed as a new generator mechanism or progress on P versus NP, **HOLD that framing**: the reviewed evidence does not support it. This assessment authorizes no extraction, release, DOI action, outreach or public change and does not replace the decision owner's five-check record.

Remaining work owned by S3114: exact public candidate, wording/metadata and extraction reviews, final publication decision. No further task remains in this significance lens.
