# Triple restriction: independent non-claims review

2026-09-12; S3126/S3133. Reviewer: top-level `triple_nonclaims_review`,
acting as the non-claims-boundary-reviewer.

**Verdict: GO-WITH-NOTES for the finite unconditional lemma only.**
No blocking wording mismatch was found in the scoped sources or author receipt.
This is a source-only review, not an independent compilation or axiom audit.

## Exact scope and provenance

Candidate: `4021e7cdff5e41152c07000a3e2e0135c2e181d0`.
Working sources matched that candidate without a diff when inspected.

| Source | SHA256 of inspected bytes |
| --- | --- |
| `lean/PvNP/RealizableHardness/TripleRestrictionRank.lean` | `50d2e5689be0ec37153c1fa37bbaadfaf9d17c07c1a694f64cb35fb4302f9ba9` |
| `lean/PvNP/RealizableHardness/TripleRestrictionRankChecks.lean` | `89e3c004fb206b5f81d3679dd3a9197dfd5c2eae754c32df511814077b39adf3` |

Also inspected the dated triple-rank formalization receipt,
`INTEGRITY-CLAIMS.md`, and the planning lane's
`docs/formal-three-lens-closeout-protocol.md`. There is no destination
`AGENTS.md`. No compiler, download, source change, companion change, or
publication action was performed by this reviewer.

## Wording matched to the statement

- `Draw J` is the concrete product sample space `Fin J -> Option (Fin 3)`.
  Each block retains the whole triple with mass `1-beta`, or a specified
  singleton with mass `beta/3`. Independence comes from the defined product
  mass, and the marginal is derived. It is not an assumed posterior law.
- The probability inequalities require rational `0 <= beta <= 1` and a
  fixed injective row-combination map `R : Coeff c -> Vector J` over GF(2).
  `badRows_probability` bounds the unconditional event by `(2^c-1)*beta`.
  This upper bound may exceed one; no uniformly small failure claim follows
  without a parameter bound. The union bound does not assume independent
  row-failure events.
- `intersection_codim_failure_probability` uses the actual common-zero
  subspace `ambientKernel R` and its intersection with `retained d`,
  represented inside the retained subspace. `intersectionCodim` is the
  numeric dimension difference, not an abstract predicate standing in for
  codimension. Its good-event conclusion is derived via evaluation,
  duality, surjectivity, and rank-nullity.
- Boundary examples cover zero-mass atoms at beta zero and one, empty
  block normalization at J zero, c zero, and an explicit injective one-row
  example. J zero does not grant arbitrary positive c full-row-rank maps;
  the injectivity hypothesis still applies. At c zero the union is empty.
  No strictly positive atom assumption is advertised.

## Limits that must survive downstream use

The source fixes W through independent defining forms as `ambientKernel R`.
It does not construct such forms for an arbitrary decoder-produced W(Q).
That representation, its dimension, and the identification with the actual
decoder subspace remain obligations. Fixing Q and then choosing R is not
a justification for using the unconditional distribution after conditioning.
The actual posterior likelihood/cutoff argument must still be instantiated.
Neither posterior independence nor a union bound over all decoder subspaces
is claimed here.

No Gaussian-binomial enumeration, Grassmann incidence law, binomial tail,
posterior comparison, covering result, decoder theorem, or full geometry
theorem follows from this increment alone. There is no encoded randomized
machine, runtime bound, hardness reduction, learning theorem, full proof
certification, P-versus-NP conclusion, or publication-readiness claim.
The author receipt expressly treats the argument as a formalization of the
documented manuscript argument, with no new novelty claim.

The author receipt reports main sessions 33524 and 2377 as successful and
Checks session 39802 as successful with 22 standard-only axiom profiles.
The final Checks change is documented as a status-comment-only edit.
Those are attributed author results; this source-only lens does not
replace the independent proof review or rerun those sessions. The present
GO-WITH-NOTES verdict is one of the three required lenses and does not
close S3133, S3126, or the complete formalization goal.
