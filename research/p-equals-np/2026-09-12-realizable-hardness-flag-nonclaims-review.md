# Flag-posterior independent non-claims review

Date: 2026-09-12. Route: S3133 / S3126. Reviewer: top-level independent `flag_nonclaims_review`. Verdict: **GO-WITH-NOTES**, limited to the statements below. This is a source/wording review, not an independent compiler verdict or full-goal acceptance.

Frozen candidate: `f1a11736a962a0096f42bc6997407c0b35bac57a`.

| Reviewed file | SHA256 |
|---|---|
| GrassmannFlagPosterior.lean | c3b1078700b461b5d22b261947d2dacfca68cb5ffe21ca892897d0304bbc8456 |
| GrassmannFlagPosteriorChecks.lean | 64ef701bd4c01fdabcc4007b65333d981a05106b9ab7a842bbe777d9baf2bde0 |
| 2026-09-12-realizable-hardness-flag-posterior-draft.md | 7bc23b2cb2a4d7d4dd84d33df1f8a0c030d2cc47bdffebc24b694420e72fb441 |

The working bytes of all three files match the frozen Git blobs. The full new source, checks and author receipt were read, together with GrassmannIncidence definitions and the formal three-lens protocol. No compiler, source edit, Git mutation, or publication was performed by this reviewer.

## Supported scope

The quotient equivalence is an actual map/comap correspondence restricted by dimension, with the dimension shift derived from rank-nullity. Per-Q upper counts therefore have an explicit geometric derivation; the aggregate double count is not being substituted for per-Q regularity. The relative equivalence transfers ambient flags Q <= L <= W to flags internal to W.

`containmentProbability` is the finite sum of the existing uniform incidence kernel over d-dimensional L containing a fixed actual a-dimensional Q. `containmentProbability_formula`, under a <= d <= J, identifies that sum with gaussian(d,a) times the existing Q kernel, for each draw s. The dimension support supplies actual nonzero fibre cardinalities. Noncontainment is handled explicitly by a zero-event lemma.

`eventMarginal_formula` factors the Gaussian scalar out of the finite prior-weighted sum. `eventPosterior_eq_conditional` proves equality on each draw atom between the defined event posterior and the earlier advice conditional, assuming a <= d <= J and a positive actual event marginal. The positive-event hypothesis is used to justify cancellation, not to assume the posterior identity itself.

## Required limits on reporting

1. The posterior formulas are algebraic for arbitrary rational beta. A positive event marginal alone does not make an arbitrary signed prior into a probability law. Probabilistic wording requires 0 <= beta <= 1 in addition to the dimension and conditioning assumptions. The author receipt states this correctly.
2. Null event mass returns algebraic zero by rational division. It is not a normalized conditional distribution, an arbitrary regular conditional law, or an existence theorem for positive conditioning mass at every Q.
3. The exported posterior equality is pointwise on `Draw J`. It identifies the draw marginal after summing over L and conditioning on fixed-Q containment. The receipt's phrase “conditioning the actual draw/L law ... on every draw atom” is acceptable in that restricted marginal sense. It must not be shortened to equality of the complete joint law of draw and L, nor presented as a separately exported pushforward/measure theorem on retained subspaces. Any such derived transport needs its own stated map and argument.
4. The author receipt reports two successful exports, 16 standard-axiom profiles and four examples; this review inspected that report but did not rerun or independently authenticate compilation. The separate proof/build review controls compiler acceptance. Standard-axiom profiles alone do not certify broader mathematical claims or unformalized dependencies.
5. Historical UNCOMPILED banners and initial draft paragraphs are explicitly superseded by the appended author-verification section. They are conservative stale status, not evidence of a failed final build; independent acceptance must cite the independent receipt rather than silently treating draft comments as current status.

There is no exported total-variation proximity estimate, KMS covering theorem, zoom-out mixture estimate, near-one approximation, posterior independence claim, executable sampler/runtime bound, specialized PCP theorem, full realizable-hardness/learning theorem, or P-versus-NP resolution in this pair. The receipt expressly leaves those obligations open. No novelty or publication-readiness claim is justified by this review. The scope is a useful exact counting and draw-posterior identification component; final theorem assembly and manuscript reconciliation remain separate requirements.

No blocking non-claims discrepancy was found within this scope. Full route closeout still requires the other two independent lenses and root reconciliation of their evidence.
