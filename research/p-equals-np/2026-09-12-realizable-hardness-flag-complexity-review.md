# Flag posterior: independent complexity review

2026-09-12. S3133/S3126, top-level complexity-theory lens.
Verdict: **GO-WITH-NOTES** for the exact finite flag count and posterior
identification. No blocking quantifier or distribution defect was found.

## Scope and evidence

Orchestrator-frozen candidate: `f1a11736a962a0096f42bc6997407c0b35bac57a`.
Read both current companion source files, the dated flag-posterior author
receipt including superseding compilation update, and the actual manuscript
posterior section in `realizable-cmmsa-hardness/paper/submission-manuscript.md`,
particularly its uniform-L containment formula and joint-sampler explanation.
The S3133/S3126, three-lens protocol and full dependency assessment read for
this reviewer's preceding review remain the applicable full-goal boundary.

Independently computed current byte hashes (paths under
`certifications/realizable-hardness/lean/PvNP/RealizableHardness/`):

| File | SHA256 |
|---|---|
| GrassmannFlagPosterior.lean | c3b1078700b461b5d22b261947d2dacfca68cb5ffe21ca892897d0304bbc8456 |
| GrassmannFlagPosteriorChecks.lean | 64ef701bd4c01fdabcc4007b65333d981a05106b9ab7a842bbe777d9baf2bde0 |

The receipt reports author session 47191 EXIT0 for both files after the
missing quotient-finiteness instance was repaired, with 16 selected standard
axiom profiles and four examples. This reviewer ran no compiler; independent
kernel export, transitive output provenance and frozen Git equality belong
to the separate proof/build lens. Historical UNCOMPILED banners are superseded
by the receipt only as to author status, not independent acceptance.

## Count and probability audit

`upperQuotientEquiv` constructs the dimension-filtered quotient correspondence
for each actual Q. Restricted quotient-map rank-nullity gives the dimension
shift. Map/comap inverse identities supply the inverse functions. The local
Finite instance for the quotient is obtained from actual surjectivity of
Q.mkQ; it introduces no counting oracle. `card_upper` consequently counts
the upper fibre as gaussian(dim V-a,d-a). The assumption a<=d prevents
natural subtraction from disguising an invalid negative dimension. An
actual Q also witnesses a<=dim V. If d exceeds ambient dimension, the
empty Grassmann cardinality is represented by the existing Gaussian count;
the ratio theorem separately requires nonzero denominator counts.

`lowerCount` counts a-subspaces of a fixed d-space. The aggregate double
count is then combined with the already proved per-Q upper count, rather
than used as a substitute for fibre regularity. `upperCount_ratio` explicitly
requires both Gaussian denominators to be nonzero before cross multiplication.

`relativeUpperEquiv` gives actual maps between ambient flags Q<=L<=W and
upper flags in the vector space W, using subtype map/comap and the original
containment witness. This supplies the exact internal numerator, preserving
the identity of Q instead of replacing it by an unspecified isomorphic space.

`containmentProbability` is the finite sum of the actual GrassmannIncidence
uniform d-space kernel over L containing fixed Q. Expanding that sum gives
the relative flag cardinality divided by incidenceCount(s,d). For a<=d<=J,
the retained space always has enough dimension for both a and d; the proof
obtains denominator positivity from actual incidenceCount_pos. Thus it proves

`Pr[Q<=L | s] = gaussian(d,a) * kernel(s,Q)`

without assuming regularity, an event-law identity, or the desired ratio.
If Q is not contained in retained(s), every possible L contributes zero.
The definition is total even for unsupported dimensions, but those general
zero-division values are not claimed to be normalized sampler probabilities.

`eventMarginal` sums the product prior times this actual containment
probability. Factoring the draw-independent gaussian(d,a) gives the actual
advice marginal times that constant. `eventPosterior_eq_conditional` uses
positive event marginal to derive nonzero factors before cancellation, and
holds pointwise for every draw s. A null event has an explicitly zero-valued
posterior function, not a normalized conditional law on an impossible event.
Zero prior atoms need not be excluded. The algebra holds for arbitrary
rational beta; a stochastic interpretation requires 0<=beta<=1. The existing
prior/kernel normalization and nonnegativity supply that interpretation in
the stated dimension range. No posterior independence is inferred.

## Match to the manuscript and remaining boundaries

The manuscript experiment is: sample the triple restriction V, sample
uniform d-dimensional L inside V, and condition on fixed Q<=L. The code
implements that experiment at the more detailed draw-s level, with
V=retained(s), and obtains the same draw posterior as sampling uniform
a-dimensional Q inside retained(s). Summing the pointwise equality over
draws with any given retained space therefore gives the required equality
of V posteriors. That pushforward statement is a mathematical consequence,
not a separately named exported theorem in this pair. Likewise this pair
does not assert equality of the complete joint (V,L) laws or discharge a
covering-distance theorem. Its direct exported result is exactly the
posterior identification needed before applying such estimates.

The condition d<=J is a sufficient uniform support condition, consistent
with the manuscript's eventual d=2h and enormous J. This pair has not proved
the eventual parameter inequality or substituted those parameters. The
positive conditioning-event hypothesis is legitimate, not a hardness oracle;
later use must provide it for the chosen good advice. The theorem does not
silently assert that every advice has positive event probability at endpoints
such as beta=1.

The four examples check Gaussian boundary counts, d=a reduction to the
existing kernel, and null-event behavior. They do not themselves instantiate
the complete manuscript parameter regime. This component advances the actual
sampler identification rather than only a symbolic aggregate count, but it
provides no quantitative KMS covering, advice TV proximity, zoom-out near-one
ratio, positive mixture bound, or final exceptional-set estimate. Noncomputable
finite equivalences and sums provide no polynomial-time encoding or sampler.

Full specialized PCP/decoder dependencies, encoded randomized runtime and
coin bounds, fixed-L hardness assembly, HN learning transfer, and paper-to-Lean
reconciliation remain required. No full CMMSA hardness certification, P-vs-NP
conclusion, quantum algorithm, novelty or publication readiness follows.
Proof/build and non-claims lenses remain separately required for closeout.

Only this report was written. No compiler, source changes, Git operations,
dependency modifications, publication, or planning edits were performed.
