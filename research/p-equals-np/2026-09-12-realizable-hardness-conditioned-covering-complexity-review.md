# Conditioned covering: complexity review

2026-09-12. S3134 under S3126. Reviewer: top-level complexity-theory-reviewer. **GO-WITH-NOTES for this finite conditional-distribution increment only.** This review does not certify the full realizable-hardness theorem, computational efficiency, or novelty. Independent compiler verification is a separate lens and was not run by this reviewer.

## Evidence and scope

Reviewed the complete `ConditionedCovering.lean`, complete `ConditionedCoveringChecks.lean`, and the dated author draft/build receipt at frozen commit `ec3eed3a0fb05b59e0bb5985661ac8a10147eb20`. The worktree was clean at inspection. SHA256 values:

| Artifact | SHA256 |
|---|---|
| Main | `766695b48744854b9b1e71b27a5b442fdc6ce822381d7ca3207f14d74cf1b7ef` |
| Checks | `62b45015fb69034bcef93f367c73f4fca98e7b49236530dcb618ac4deb2c15cc` |
| Author receipt | `debd20e4b2b88d30f3fbf8eb55de2aa725ccb362f7f5c8ff55f9d5de7200d497` |

Read the planning three-lens protocol and the existing source-directed frontier note. No satellite root AGENTS.md exists. Compared against the already available primary-source extraction `C:/Users/Dan/AppData/Local/Temp/s3123-kms.pdf.txt`, Definition 4.5, Lemmas 4.6–4.7, and Section 8 proof of Lemma 4.7, and against the parameter-extension section of `realizable-cmmsa-hardness/paper/submission-manuscript.md`. This is review of the existing selected dependency, not a new literature or novelty search.

The author receipt supersedes historical UNCOMPILED comments: it reports main and Checks exit 0, 26 standard axiom profiles and 10 elaborated examples, with earlier failures and repairs preserved. This review inspected that evidence but does not substitute it for the separate independent compiler run.

## Distribution and quantifier audit

The carrier is the actual finite family of binary subspaces, with ambient dimension 3J and the existing triple-retention draw. `flagKernel` samples an a-subspace uniformly inside a d-subspace. Its normalization follows from the actual lower-subspace count, rather than a normalization premise. Explicit equivalences transport finite enumerations; upper-subspace counting proves the ambient Q marginal is exactly uniform. Retained-space counting proves the retained Q marginal equals the existing retained-space kernel; summation against the actual prior then proves the deleted Q marginal equals `adviceMarginal`. The final application does not assume a desired joint-law identity.

The two conditional laws are global containment-conditioned L laws. Their denominators and indicator numerators are made explicit by `ambientConditional_formula` and `deletedConditional_formula`. They do not resample V from its prior after fixing Q. `deletedConditional_eq_eventPosterior_mixture` proves exact disintegration through the event-posterior draw and uniform L inside its retained space conditioned on Q. Zero-probability retained fibres contribute zero; no cancellation of a zero event is hidden. The subsequent advice-posterior identity uses the previously established flag posterior theorem to identify this very draw with the posterior used by density and tail estimates.

For nonnegative rational beta below one, the positive no-deletion atom proves every relevant advice marginal is positive. The source hypothesis 2^d beta <= 1/8 implies beta < 1. Thus the final theorem's conditioning events and normalization are substantive, including beta=0, rather than null-event conventions masquerading as probability laws. The d<=J bound ensures retained spaces are always sufficiently large. Internal results allow a<=d; the final source-facing theorem keeps a<d<=J, matching q<=ell-1 under a=q, d=ell, J=k. The rational-beta restriction is explicit and fits the prescribed rational sampler family; no theorem for all real beta is claimed.

The generic finite argument proves average conditional TV, weighted by the first marginal, is at most twice unconditioned TV for a shared normalized nonnegative kernel. Its weak generic hypotheses are sufficient for the displayed algebra; the concrete application supplies actual normalized distributions and strictly positive marginals. In particular, averaging is under ambient uniform Q, not the deleted Q marginal.

`actual_conditional_average_le_real` uses the accepted basic covering result at dimension d to obtain an average bound of beta sqrt(J) 2^(d+5). With e=sqrt(beta) J^(1/4), this is e^2 2^(d+5). The explicitly defined bad set consists of Q with conditional distance strictly greater than e 2^(d+5). Markov gives ambient mass at most e; outside it, distance is at most the stated threshold. The e=0 branch derives pointwise zero distance from positive ambient masses and nonnegative summands before any division. Consequently neither beta=0 nor J=0 is lost by an illicit positive-error assumption. The advertised source theorem excludes J=0 through a<d<=J, while internal boundary lemmas and checks cover it separately.

## Exact consequence and limits

This gives the KMS Lemma 4.7 finite conditional-covering conclusion, with the same square-root/fourth-root error and power-of-two constant, for the actual distributions used in the manuscript. The proof uses the same conditioning/averaging and Markov mechanism as the cited source. The more permissive internal beta/domain hypotheses are not evidence of a new complexity-theoretic mechanism or a novelty claim. No blocking false-force, circular conclusion-as-hypothesis, or quantifier issue was found in this increment.

The theorem alone does not ensure the exceptional fraction or conditional-TV bound is small: their right sides may exceed one for some admissible parameters. The manuscript's specific double-exponential J and beta=Ah^2/J still require separate eventual inequalities, d=2h and advice-dimension bounds, and discharge of 2^d beta<=1/8. The existence of an explicit finite bad set is a mathematical definition in a noncomputable section, not an efficient algorithm to enumerate or recognize good advice.

The posterior identity is an essential connection but does not finish zoom-out. Rank-stable restriction, the uniform near-one Gaussian ratio, positivity and size of the additional containment event, and TV after that additional conditioning still require their quantitative assembly. The good-advice intersection and all resulting error budgets must also be specialized to one coherent parameter regime. This review grants no independence of V after conditioning and no simultaneous union over all W(Q).

Specialized PCP and decoding theorems, maximal-pair/list counting, parameter selection and integrality, encoded randomized polynomial-time reduction with explicit coin/runtime/weight bounds, the full fixed-L nearlinear-gap theorem, and exact learning transfer remain outside this increment. No P-versus-NP conclusion follows. Final manuscript/Lean reconciliation and submission certification remain open under the full parent goal.

## Verdict

**GO-WITH-NOTES:** suitable as the bounded actual advice-conditioned covering dependency, subject to the separate independent build/proof lens. Keep the full goal and remaining obligations open. No source edits, compiler execution, Git mutation, publication, or nested delegation were performed by this reviewer.
