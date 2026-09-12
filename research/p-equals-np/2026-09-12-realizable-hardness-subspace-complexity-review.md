# Arbitrary-subspace restriction: independent complexity review

2026-09-12; S3126/S3133. Verdict: **GO-WITH-NOTES**, limited to the stated unconditional finite-dimensional theorem. This is a source-only complexity review, not an independent compiler or axiom audit.

## Evidence inspected

Candidate `f7dcf6730ade00f2d9187d5db7c220d88b9b0ae4`: main, Checks, and `2026-09-12-realizable-hardness-subspace-restriction-formalization.md`. Both working source files match the candidate (empty Git diff). Independently computed SHA256 values:

- `SubspaceRestriction.lean`: `f6cd2342704fe24a3b3b5f8b0ff22d3f9cc54e11d69c5f3a695cc8af08944506`.
- `SubspaceRestrictionChecks.lean`: `8061a8cbf674e63c617e204a87df22b2abeb345784bd8e44dbea1d113e38c7bf`.

Read the full imported `TripleRestrictionRank.lean`; its working source has empty diff against accepted integration `20039749e65dcb0eb719fed130aa9860bce855ea`. Also read `INTEGRITY-CLAIMS.md` and the planning lane's formal three-lens closeout protocol. Author sessions 67906 and 67608 are reported as exit 0 with 13 standard-only profiles by the author receipt; this reviewer did not run or independently reproduce them. No compiler, dependency, companion, source, Git-index, or publication mutation was performed.

## Mathematical and quantifier assessment

1. Arbitrary W is genuinely represented. `codim` is ambient finrank minus W finrank. The annihilator dimension follows from dual quotient equivalence and quotient rank-nullity, so the row count is derived rather than assumed. Natural subtraction is justified by that dimension identity; the ambient space is finite-dimensional.
2. The chosen annihilator basis spans its whole subspace. Composing its coordinate equivalence with the annihilator inclusion and inverse standard coordinate-dual equivalence produces `definingForms`. Injectivity follows from actual injective maps. The pairing identity is proved against the concrete sum used by the accepted triple module.
3. Kernel equality is substantive: the forward direction represents every annihilator functional via basis surjectivity and invokes the annihilator membership characterization; the reverse direction uses actual annihilator vanishing. Neither full rank nor kernel equality is a caller-supplied contract.
4. `codimInRetained` measures the actual codimension inside the sampled coordinate subspace, with intersection expressed by comap along its inclusion. `represented_codim` identifies it with the existing numeric event. The final theorem uses the derived full-rank representation to inherit the actual normalized product-law bound `(2^codim(W)-1)*beta` for rational beta in [0,1]. It is not merely a row-rank event presented as geometric codimension.
5. Quantifiers are honest: for every fixed W, the probability is over d. There is no adaptive W(d), simultaneous success for all W, or conditional independence statement. Fixing Q allows one to name W(Q), but transporting this result to the posterior distribution of d given Q still requires an actual likelihood comparison.

## Degenerate and numerical boundaries

The codimension-zero case has zero right-hand side. Checks prove zero failure mass for top W. Bottom W has true codimension 3J; arbitrary W at J=0 has codimension zero and a valid representation. A coordinate hyperplane is proved codimension one by surjectivity and rank-nullity, with beta=0 and beta=1/2 consequences. The universal statement includes beta=1; no dedicated beta=1 example is required for this source-level assessment. At beta=1 and positive codimension the bound can be trivial, as it can whenever `(2^codim(W)-1)*beta >= 1`. No nontriviality or asymptotic saving is inferred without a parameter inequality. The hyperplane check is a valid application, not evidence that the upper bound is tight.

## Limits and next dependency

The annihilator basis is noncomputable mathematical choice. This proof does not give an encoded basis-construction algorithm, runtime, or polynomial-size representation procedure. Its use inside an existence argument is legitimate; it must not be used as machine-runtime evidence.

The next geometric application still requires the actual advice/incidence law, posterior likelihood bound and tail cutoff, and their combination with this fixed-W event. Gaussian-binomial counts, Grassmann distribution identities, KMS covering, decoding, specialized PCP dependencies, the full realizable-hardness and learning theorems, and final paper reconciliation remain outside this increment. Nothing here proves a complexity-class separation or resolves P versus NP. No novelty or publication-readiness assessment is made.

No blocking statement, quantifier, or false-force defect was found within this scope. Independent proof and non-claims reviews remain separate gates; this verdict alone does not close S3133 or the full goal.
