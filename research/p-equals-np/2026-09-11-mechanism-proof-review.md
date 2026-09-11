# S3055 proof-adversarial review

2026-09-11. Independent proof-adversarial lens for the [mechanism derivation](2026-09-11-mechanism-discovery.md), [exact checker](2026-09-11-mechanism-discovery.py), and [saved results](2026-09-11-mechanism-discovery.json), under [INTEGRITY-CLAIMS.md](../../INTEGRITY-CLAIMS.md). This is one mathematical review; the separately assigned complexity and nonclaims lenses are not represented as performed here. No Lean formalization or human peer review is claimed.

**Mathematical disposition: the recurrence is exact; the proposed polynomial dictionary-growth claim is false.** The positive quotient example also holds. This is a substantive counterexample to the selected operation's conjecture, not a lower bound on SAT, counting SAT, or arbitrary affine representations.

## Extraction and recurrence

For each bounded-support bucket, let T be its satisfying relation. The checker constructs all affine equations constant on T. Their solution set contains T and is exactly its affine hull. If T is nonempty, comparing its cardinality with `2^(support size - rank)` therefore certifies equality, not merely containment. Replacing the bucket by those equations is sound only on equality; the code retains non-affine buckets. Empty relations correctly produce inconsistency. This extraction recognizes visible bounded-support relations and is not an algorithm for discovering every hidden affine consequence.

For a consistent extracted system, the particular solution and free-variable basis give a bijection `x=a+Bz` from the d-dimensional quotient to the original affine solution set. No multiplicity is lost in the implemented full parametrization. A clause is false precisely when every substituted literal-falsity equation holds; this event H is an affine subspace or empty. A tautological event is empty, whereas an empty clause has the entire quotient as its falsifying event.

Suppose the current dictionary represents the surviving indicator as `f(z)=sum_S c_S 1_S(z)`. Adding one clause multiplies this by `1-1_H(z)`. Since `1_S 1_H=1_(S intersect H)`, copying `(S,c_S)` and adding `(S intersect H,-c_S)` proves the update exactly. Inconsistent intersections contribute zero. Combining identical canonical augmented RREF systems and deleting zero coefficients preserves this identity. The final model count is consequently `sum_S c_S 2^(d-rank(S))`. Neither floating point nor a probabilistic cancellation assumption enters this proof.

## Exponential family and its precise limit

For `F_m=AND_(i=1..m)(x_0 OR x_i)`, every nonempty clause subset J creates the affine space fixing x_0 and exactly the leaves in J to zero. Distinct subsets give distinct spaces: set a leaf in their symmetric difference to one and all constrained leaves of the other subset to zero. Each space has coefficient `(-1)^|J|`; there are no duplicate keys to cancel. Together with the ambient key, the dictionary has exactly `2^m` entries, in every clause order.

This family has width two, a common hub, primal treewidth one, and binary-index encoding length `O(m log(m+1))`. Thus this is superpolynomial output growth in the encoded input, not an artifact of treating variable names as free. The hub has unbounded occurrence: it is not a bounded-occurrence counterexample.

No stronger sound affine-consequence extraction repairs this example. Its satisfying set contains the entire affine hyperplane x_0=1 and one point outside it, so its affine hull is the whole ambient space. Yet that same set is the disjoint union of just **two affine pieces**, namely x_0=1 and the point x_0=0 with every leaf one. Its model count is `2^m+1`. The exponential result is therefore limited to expanding clause-violation intersections and merging equal keys; it is not a lower bound against all signed or unsigned affine dictionaries, factoring, conditioning, or decision algorithms.

Conversely, adding leaf equations `x_i=z` identifies every residual falsifying event with the same two-coordinate point H. After the first clause the dictionary is ambient minus H; another copy gives the same result by cancellation. It retains two stage-end keys and has three models. Shared variables alone do not cause collisions; actual equality after quotienting does.

## Charged work and independent checks

After i clauses, each coefficient is a signed sum of at most `2^i` subset contributions, so `O(i+1)` bits suffice. Keys require polynomially many bits in d; Gaussian elimination, equality comparisons and dictionary operations must be charged for all intermediate terms. Exact final summation needs `O(m+d+1)` bits per accumulator. A small final dictionary does not alone imply small cumulative work. Fixed bounded-support enumeration also remains a charged preprocessing step.

The reviewer independently represented affine sets by truth-table bitsets: all 470 presentations using up to three distinct nonzero equations over GF(2)^3 produced exactly 52 semantic spaces including empty, with canonical keys agreeing with semantic equality. All 2,601 intersections of nonempty spaces agreed with bitset intersection. A separate truth-set dictionary, without RREF, reproduced the star counts and complete size histories for m=1 through 7. The author's eight controls were rerun successfully; the inspected saved result initially matched its script hash. These finite checks support implementation fidelity; the preceding derivations establish the all-m family statements.

Review identified that the original metrics sampled only completed clause stages and missed temporary coefficient -2 in the coincidence update. The author corrected this: `stage_peak_keys` and `transient_new_keys` are separate, and coefficient sizes are sampled during updates. The reviewer inspected the changed loop, reran all eight controls, and verified the saved coincidence cases with m>=2 now record two coefficient bits. The final script's SHA256-LF is `4798aa683ad412e421f470ffa9c09fc225b12c914af433e511f70360df0b817e` and matches the saved 22-case result. The recurrence itself did not change.

Novelty is not established by this review. The [primary-source comparison](2026-09-11-mechanism-source-comparison.md) identifies existing affine elimination and intersection-poset inclusion-exclusion precedents. The strongest supported outcome is an exact selected mechanism with a real compression case and a proved failure of its proposed general growth principle.

**Final proof-lens verdict: GO for this scoped mathematical result.** A second review correction now distinguishes actual residual clause width from the fixed affine-extraction cutoff in the intersection cost bound; wide residual buckets are not assumed absent. Both corrections were verified in the final artifacts. No further proof claim or follow-up experiment is authorized by this review.
