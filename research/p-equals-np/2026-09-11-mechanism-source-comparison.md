# S3055 selected mechanism: source comparison

2026-09-11. E004/S008. The selected operation is **affine quotient followed by signed inclusion–exclusion with canonical intersection merging**. This note compares that operation with primary work and checks the author's proposed positive and negative families. It is not a publication recommendation or a general SAT bound.

## Exact operation and changed representation

Input is an explicitly encoded CNF, optionally with affine equations over GF(2). For a fixed support bound b, a supplied group of clauses on at most b variables can be evaluated on all 2^b assignments and tested for being exactly an affine relation. Replace only an exactly recognized affine factor by its equations; keep every other factor. An affine hull alone is an overapproximation and cannot replace a non-affine factor. Empty relations certify inconsistency. Exhaustively choosing support sets instead of supplied groups costs an additional n^O(b) search and must be specified; arbitrary hidden-parity discovery is not free.

Gaussian elimination yields either inconsistency or an affine parametrization `x=a+Bz`. Coordinates invisible to the residual CNF may be projected away, retaining a lift and, for counting, the uniform fiber multiplicity. Every residual clause's falsifying event is an affine subspace in the retained coordinates: impose the corresponding literal-falsity equations after substitution. Inconsistent events are empty.

Start with coefficient 1 on the full retained space. When processing forbidden event H, every old pair `(S,c)` contributes `(S,c)` and `(S intersect H,-c)`. Compute intersections by GF(2) elimination; identify spaces by canonical augmented RREF with fixed column order; merge integer coefficients and remove zeros. Empty intersections contribute nothing. Summing `c*2^dim(S)` gives the complement count; multiply by the retained fiber factor if original assignments are counted. Construction, all intermediate keys, intersections, comparisons and integer arithmetic must be charged, not only the final dictionary.

This changes the earlier ordinary-Horn cover requirement: signed overlaps need not be disjoint and affine parity relations remain compact. It does not establish that the new dictionary stays small.

## Closest primary work

| Component | Checked source and exact location | Comparison |
|---|---|---|
| Extract visible XOR structure from CNF | Mate Soos, [*Enhanced Gaussian Elimination in DPLL-based SAT Solvers*](https://www.msoos.org/wordpress/wp-content/uploads/2010/08/PoS10-Soos.pdf), Section 2.2 | Groups clauses by variable support and recognizes complete parity patterns; attribution there points to Heule. Our bounded truth-table test can recognize a general affine factor, but this is not a new claim that parity can be recovered from CNF. |
| Retain affine reasoning alongside CNF; eliminate affine-only variables | Laitinen, Junttila and Niemelä, [*Extending Clause Learning SAT Solvers with Complete Parity Reasoning*, v2](https://arxiv.org/pdf/1207.0988v2), Section V, pp. 7–8; Appendix Lemma 5, p. 9 | The source already eliminates XOR-internal variables by substitution, discusses decomposition costs, and characterizes affine consequences by linear combinations. Projecting the affine solution set onto residual variables is the same elementary elimination capability. Our downstream dictionary differs from its DPLL(XOR) search, not from its linear algebra. |
| Signed counts grouped by equal intersections | Björner and Ekedahl, [*Subspace Arrangements over Finite Fields: Cohomological and Enumerative Aspects*](https://arxiv.org/pdf/math/9612217), Section 2 definitions; Proposition 3.1 and proof, p. 4 | Proposition 3.1 groups inclusion–exclusion using the intersection semilattice and its Möbius function. This is the mathematical meaning of merging equal RREF intersections. Canonical row reduction supplies an implementation of equality, not a new counting identity. |
| Evaluate affine-arrangement complement size | Same source, Proposition 3.2 and proof, p. 5 | For every prime power q, complement size is the characteristic polynomial evaluated at q, with terms `mu* q^dimension`. Thus q=2 is directly covered; no transfer from sufficiently large primes is needed. |

The preceding source statements were read in accessible full PDFs on this date. The Björner–Ekedahl author-hosted PDF URL returned 404; its arXiv full text was available. Athanasiadis's related characteristic-polynomial work appeared in the targeted search, but its reduction-from-integer-arrangements hypotheses are unnecessary here. A separate affine-approximation paper failed to load and is not relied on. This is a nearest-work check, not an exhaustive priority search or a certification of novel algorithmic performance.

## The selected conjecture and mathematical checks

The author's conjecture under test is that constant clause width and a common shared variable force sufficiently many identical intersections to leave only polynomially many nonzero dictionary keys. The connected family

`F_m = AND_(i=1..m) (x_0 OR x_i)`

falsifies that conjecture for this exact update rule. With no affine restrictions, `H_i={x_0=0,x_i=0}`. Every nonempty subset J yields

`S_J={x_0=0 and x_i=0 for i in J}`.

If J and K differ, a leaf in their symmetric difference witnesses different spaces. Consequently each subset has its own key, coefficient `(-1)^|J|`; the empty subset gives the ambient key. After m clauses there are exactly 2^m nonzero keys. This holds despite width two and connectedness through a common hub. It does not meet a fixed bound on the hub's occurrence degree, and must not be described as a bounded-degree counterexample.

The positive contrast is also exact. Add affine equations `x_i=z` for all leaves. Quotienting makes every falsifying event the same `H={x_0=0,z=0}`. The update leaves only ambient coefficient +1 and H coefficient -1: subsequent copies cancel at H. The quotient has three satisfying points out of four. This checks that the chosen merge operation can exploit actual equality of affine events, rather than merely their shared variables.

The failure is not a SAT or counting lower bound. The star is monotone and visibly satisfiable. In Boolean form its entire relation is

`x_0 OR (AND_i x_i)`,

and its number of models is `2^m+1`: choose x_0=1 with arbitrary leaves, or x_0=0 with all leaves one. Hence ordinary factoring, or conditioning on the hub, solves it compactly. No external compilation theorem is needed for this identity. The example separates exact-key merging from symbolic factorization; it does not separate the problem from every compact representation. Equal dimensions alone cannot generally be merged, because subsequent intersections depend on positions as well as dimensions.

## Novelty and scope disposition

The quotient algebra and merged inclusion–exclusion semantics have direct established precedents. The star stress test is an elementary application of a Boolean intersection lattice, and its exact priority was not established; treat it as likely rediscovery rather than a new lower-bound theorem. Nevertheless, it performs the requested mathematical test: a specified operational change has a genuine compression example and a proved failure of its proposed growth principle.

A repair would have to change the representation or update rule—for example, retain the shared Boolean factor instead of expanding it—then bound the **charged intermediate work** under that new rule. It cannot claim the star result rules out such repairs, nor claim that adding factoring automatically controls arbitrary residuals. The parity/Tseitin success is likewise the established benefit of GF(2) reasoning, not evidence that non-affine residuals become easy. No general polynomial SAT algorithm, P-versus-NP resolution, publishability claim, experiment, or proof campaign follows from this comparison.
