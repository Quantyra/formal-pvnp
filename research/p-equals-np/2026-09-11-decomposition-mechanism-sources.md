# Shared-syndrome decomposition: primary-source comparison

Date: 2026-09-11. S3056, E004/S008. Independent source comparison for the selected mathematical attempt; no experiment, formal proof, novelty or publication claim. The repository README and INTEGRITY-CLAIMS boundaries apply.

## Exact operation and local check

After assigning a supplied clause separator, suppose the remaining formula is
`GX(x) AND GY(y) AND [AX x + AY y = b]`, over GF(2), with disjoint variable blocks X/Y. Set U=im AX, V=im AY and T=U intersect (b+V). Gaussian elimination decides whether T is empty and, otherwise, supplies a coset basis with dimension

`t = dim(U intersect V) = rank AX + rank AY - rank[AX AY]`.

For each s in T, the two decision subproblems are `GX AND AX x=s` and `GY AND AY y=b+s`. Their conjunction, disjoined over s, is exact. This replaces literal-coordinate conditioning with linear-syndrome conditioning, but does not make either local decision free.

The author's proposed pure-affine rectangle lower bound checks out directly. In a nonempty sound Cartesian rectangle P times Q, fix y in Q. Every x in P must have the same AX x=b+AY y. Thus the rectangle occupies one syndrome. Every feasible syndrome has nonempty fibers, whose Cartesian product is sound. The minimum cover has exactly 2^t rectangles, even if overlaps are permitted. Translating a consistent affine relation to its homogeneous kernel preserves this count. With GX/GY present, some fibers can be removed: the minimum becomes the number of surviving syndromes, which need not be 2^t. This is a representation statement at the fixed cut, not a decision-time lower bound.

## Closest primary work and overlap

| Primary source and inspected location | Exact overlap / limit |
|---|---|
| Navin Kashyap, [On Minimal Tree Realizations of Linear Codes, arXiv:0711.1383v1](https://arxiv.org/pdf/0711.1383v1), Section 2.2, printed p. 6, Eqs. (1), (4), (5); [published DOI](https://doi.org/10.1109/TIT.2009.2023718) | The minimal edge state is the quotient C/(C_X direct-sum C_Y), with dimension dim C-dim C_X-dim C_Y. Set C=ker[AX AY]: rank-nullity gives precisely our t. The source attributes this construction to Forney. Our syndrome labels provide a coordinate representation of the established interface. Neither the interface size nor its local minimality should be presented as a new discovery. |
| Kashyap, [Matroid Pathwidth and Code Trellis Complexity, arXiv:0705.1384v1](https://arxiv.org/pdf/0705.1384v1), Section 2.2, printed p. 4; Section 3 | The rank expression is the vector-matroid connectivity function, using the source's convention without an added 1. It is invariant under invertible row operations and equal for dual matroids. The paper proves NP-hardness of optimizing unrestricted trellis width. This does not make a specified cut difficult to evaluate, and does not exclude useful parameterized algorithms. |
| Jisu Jeong, Eun Jung Kim, Sang-il Oum, [The art of trellis decoding is fixed-parameter tractable, arXiv:1507.02184v4](https://arxiv.org/pdf/1507.02184v4), abstract and introduction; [published DOI](https://doi.org/10.1109/TIT.2017.2740283) | Constructing a layout with bounded intersection dimension for represented subspaces over a fixed finite field already has an FPT algorithm. Therefore “find small affine interfaces” alone is also an established algorithmic target. This source does not by itself provide a bound for the combined arbitrary CNF and affine constraints in our operation. No dependence on the parameter is promoted here to polynomial dependence on input length. |

These are targeted full-text checks of the cited portions, not a claim to have reverified every proof in all three papers. The first source's arXiv history lists only v1; the third lists v4 as current. The third PDF has an internal November 2018 date despite the March 2017 arXiv version stamp; citations above pin the actual v4 rather than infer a later revision. Journal DOIs establish publication provenance; the audited equation numbering is from the accessible arXiv PDFs. No exhaustive novelty search or correction audit is claimed.

## What changes relative to earlier attempts

[S3040's decomposition-preservation attempt](2026-09-08-decomposition-preservation-attempt.md) already used Shannon cofactoring, independent-component conjunction and DNNF compilation. Its [Bova et al. source](https://arxiv.org/html/1411.1995v3), Theorems 4–5, supplied an exponential DNNF family for the materialized-bucket contract. That is not automatically a lower bound for an affine-state representation. Conversely, replacing a literal separator with a syndrome does not evade a lower bound for a representation into which the resulting object can efficiently be compiled without additional assumptions. No such general compilation or evasion is proved here.

[S3055's source comparison](2026-09-11-mechanism-source-comparison.md) showed why merging equal intersections leaves exponentially many keys for the connected star. Conditioning its hub repairs that particular failure immediately: the two branches are constant truth or a conjunction of independent leaves. This is ordinary branching/component decomposition, not evidence of a new general compression theorem.

The selected further tests discriminate the new interface parameter: one nontrivial parity spanning both blocks has t=1 irrespective of support size; r independent paired equations x_i+y_i=b_i have t=r despite no residual CNF edges. The latter does not establish a hard instance: Gaussian elimination solves it, and regrouping each pair changes the cut. It refutes only a proposed bound of t by residual clause-separator size at an arbitrary fixed partition. Pure-affine leaves should be discharged directly.

## Missing global extension

The local lemma is valid, useful for accounting, and already contained in code-state theory. The unproved extension is a **joint** decomposition rule: from explicitly supplied affine constraints plus residual CNF, construct compatible separators/cuts so that all retained syndrome states, local residual decision work, repeated contexts, and separator discovery have a proved total bound. A small rank at one cut, or small CNF separators considered separately, does not establish that bound.

A concrete further conjecture must name an input family and a structural condition controlling this joint quantity, then test incompatibility between the CNF-friendly and affine-friendly partitions. Merely adding a supplied small-width tree with dynamic programming risks repackaging standard bounded-width inference. No general positive extension is asserted, and the current local result alone does not support a new paper or a P-versus-NP conclusion. It does give the author a precise operation and an exact failure parameter to use in the present mathematical attempt.

## Paired-path interaction observed in this attempt

The [mechanism derivation](2026-09-11-decomposition-mechanism.md) additionally treats equality links x_i=y_i between a positive-OR path on X and a negative-OR path on Y. Only two alternating syndromes survive, but the specified standard-basis ascending decision rule tries floor(2^k/3)+1 syndromes. Substituting y=x and combining each pair of clauses exposes an adjacent XOR equation and repairs that family in polynomial work. This is an elementary local derivation and bounded exact test, not a newly sourced theorem or established novelty. It illustrates the cost of finding compatible states and the dependence on the chosen cut; it supplies no general efficient compatibility filter.
