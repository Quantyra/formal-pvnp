# Triple restriction: independent complexity review

2026-09-12; S3126/S3133. Reviewer: `triple_complexity_review`, independent of the author. **GO-WITH-NOTES for the exact unconditional finite rank and numeric codimension bounds.** This is a source review, not an independent build or acceptance of full S3133.

## Frozen scope and evidence

Candidate: `4021e7cdff5e41152c07000a3e2e0135c2e181d0`.

| Inspected source | Working-byte SHA256 |
| --- | --- |
| `lean/PvNP/RealizableHardness/TripleRestrictionRank.lean` | `50d2e5689be0ec37153c1fa37bbaadfaf9d17c07c1a694f64cb35fb4302f9ba9` |
| `lean/PvNP/RealizableHardness/TripleRestrictionRankChecks.lean` | `89e3c004fb206b5f81d3679dd3a9197dfd5c2eae754c32df511814077b39adf3` |

Both files have no diff against the candidate. Inspected the complete main and Checks sources, the dated triple-rank author receipt, `INTEGRITY-CLAIMS.md`, the planning three-lens protocol and S3133 story, the finite sampling definitions, and the manuscript's unconditional-to-posterior argument. There is no destination `AGENTS.md`. The worktree was clean at initial inspection.

The author receipt reports main sessions 33524 and 2377 exit 0 and Checks 39802 exit 0 with 22 standard-only axiom profiles. These are author evidence; this reviewer launched no compiler and does not independently attest their terminal output. Independent proof review remains a separate gate. No source, companion, Git index, release, or publication was changed by this review.

## Mathematical scope checked

1. The law is concrete. A draw is `Fin J -> Option (Fin 3)`. A block keeps all coordinates with mass `1-beta`, or singleton k with mass `beta/3`. Event probability sums the actual product mass. The one-block marginal is derived using finite product factorization and normalization, not assumed as a desired hypothesis. The failure theorems require rational `0 <= beta <= 1`, which supplies nonnegative masses. Normalization identities stated for arbitrary rational beta are algebraic identities; they alone do not make signed masses a probability law.

2. R is a fixed linear map from c coefficients over GF(2) into the 3J coordinate space. `FullRowRank R` is actual injectivity. For any nonzero coefficient vector u this implies a nonzero coordinate of R(u). Vanishing on retained coordinates forces that coordinate to be removed. Removal implies the block was reduced to a singleton, an event of probability beta. The estimate deliberately uses this sufficient upper bound; it does not need the sharper probability of removal of one coordinate.

3. The finite union ranges over exactly the nonzero coefficient vectors, counted as `2^c - 1`. Its events need not be independent. The resulting bound is valid for each fixed R uniformly with respect to its entries, without a union over matrices or subspaces. The theorem does not permit choosing R adaptively as a function of the sampled draw. If `(2^c-1)*beta >= 1`, the bound is valid but gives no nontrivial failure control; a later parameter instantiation must establish the needed smallness.

4. The geometric event is genuine numeric codimension. `retained d` is the coordinate submodule of vectors supported on kept coordinates. `ambientKernel R` is the common zero subspace W of the row forms. Its comap along V's subtype represents W intersect V internally in V. The source identifies that comap with the kernel of restricted evaluation. Coordinate test vectors establish equivalence of coefficient vanishing and vanishing as a functional on V. Injectivity of the retained row-functional map, its dual, and the double-dual equivalence yield surjectivity of restricted evaluation. Rank-nullity then proves `finrank V - finrank (W intersect V) = c` on the good event. Natural subtraction is justified by that dimension equation; the proof does not silently substitute a rank predicate for codimension.

5. Degeneracies are honest. J and c are arbitrary naturals, including zero. For c=0 the coefficient space has only zero, so the failure union is empty. With J=0 and c>0 the full-row-rank assumption cannot hold; this does not create an unconditional existence assertion. The explicit single-row example has proved injectivity and a concrete singleton draw losing the row, so the scoped result is not supported solely by empty or impossible instances. Endpoint masses beta=0 and beta=1 are checked.

## Remaining interfaces and claim limits

An arbitrary decoder-provided W(Q) is not an input submodule of the final theorem. Application still requires constructing independent defining forms R for that W after Q is fixed, proving the kernel equals W and that the number of forms equals its codimension. Mathematical existence of such forms in finite dimension is not a completed Lean representation bridge in this module.

The probability in the theorem is the unconditional deletion law. Fixing Q and representing W(Q) does not make the posterior law of V equal to this law. The actual likelihood cutoff, tail exclusion, and Bayes transfer must still be instantiated to obtain the manuscript's conditional estimate. There is no independence assertion for V and W(Q) after conditioning and no uniform simultaneous-success assertion over all W. The module is suitable for the unconditional step of that later argument, not a discharge of its posterior step.

No Grassmann enumeration, Gaussian-binomial ratio, incidence-conditioned law, tail or parameter bound, covering/decoder theorem, efficient matrix representation, encoded sampler/runtime bound, NP-hardness theorem, learning corollary, or complexity-class conclusion is proved here. Noncomputable finite definitions are legitimate mathematical objects but do not certify an efficient algorithm. This formalizes the documented local argument; it does not establish novelty or publication readiness.

No blocking quantifier, event-substitution, or false complexity consequence was found within the frozen scope. Remaining to-do: independent build/proof and non-claims reviews, then the representation and posterior interfaces under S3133 and final integration under S3137. This receipt is intentionally untracked pending the orchestrator's coordinated evidence commit.
