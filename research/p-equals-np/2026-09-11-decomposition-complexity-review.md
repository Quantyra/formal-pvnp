# S3056 independent complexity review

2026-09-11. E004/S008. Independent agent complexity lens under [INTEGRITY-CLAIMS.md](../../INTEGRITY-CLAIMS.md); not human peer review, a Lean proof, or a novelty certification.

**Verdict: GO for closing this bounded informal mathematical attempt. NO-GO for interpreting the local identities or fixed-order counterexample as a polynomial general SAT method, a general decision lower bound, or a novelty certification.**

Reviewed the final [author derivation](2026-09-11-decomposition-mechanism.md), [source comparison](2026-09-11-decomposition-mechanism-sources.md), script and saved JSON. No Lean source was changed; the executable verification is appropriate to this informal/Python increment.

## Charged construction and decision work

For explicitly represented matrices and a supplied separator/partition, Gaussian elimination constructs a particular affine solution and a basis of the homogeneous kernel in polynomial bit work. Mapping that basis through A_X and eliminating dependent images constructs the feasible-syndrome coset without enumerating either image space. The dimension t equals rank(A_X)+rank(A_Y)-rank([A_X A_Y]) when the affine system is consistent. An inconsistent system produces no coset, not a nonempty set of size 2^t.

The executable implements that construction with dimension-dependent integer masks. Polynomial here refers to explicitly represented variable/equation dimensions, not their logarithms in a hypothetical succinct input. It does not discover an optimal separator. Conditioning and verifying that residual clauses belong to their supplied blocks is charged input work. A valid supplied separator of size s can require 2^s assignments; each consistent branch may require 2^t syndrome attempts. Neither parameter is bounded for general inputs.

At a syndrome, the two local decisions are still computational tasks. The script performs syntactic unit propagation, Gaussian elimination, and then enumerates the affine solution fiber until a witness appears or the fiber is exhausted. Its fallback may require exponentially many assignments even when t=0. The reported assignment/attempt counters are diagnostics, not a substitute for bit-operation costs of matrix construction, elimination, clause scanning and witness reconstruction. Early exit improves particular inputs but gives no uniform bound. This is a decision mechanism: it returns and verifies a witness without demanding an exact model count.

A complete complexity bound must sum preprocessing and both local costs over all visited separator assignments and syndromes. A proposed recursive implementation must additionally charge every repeated context, cache-key construction, cache storage, and decomposition-discovery work. No bounded global decomposition, polynomial leaf solver, or free filtering oracle has been supplied here. Streaming syndromes does not require storing all 2^t states, so exponential iteration count must not automatically be described as exponential memory.

## Fixed-cut representation claims

For the pure affine relation, the 2^t exact fiber rectangles are nonempty, and any nonempty sound Cartesian rectangle is confined to one syndrome. Thus 2^t is an exact cover-size lower bound at this fixed X/Y partition. It is not a SAT-time lower bound: Gaussian elimination solves the pure affine system directly. Residual CNF can remove syndrome blocks, reducing the number of rectangles needed for the filtered relation. Equation-row changes and invertible coordinate changes within the blocks preserve this interface dimension; arbitrary mixing across blocks changes the partition and is outside that invariance claim.

A single spanning parity has t=1 even with large support. Row-mixed equations can have t=0 despite visually spanning rows. Independent matched equalities have t=k at the chosen separated-block cut, even though regrouping pairs and direct elimination solve the system easily. These are tests of the interface definition, not evidence for an unrestricted hardness conjecture.

## Paired-path decision example

The new family has matched equalities x_i=y_i, clauses x_i OR x_(i+1) within X, and clauses NOT y_i OR NOT y_(i+1) within Y. The equalities give the full k-dimensional syndrome space at the supplied X/Y cut. Both local affine fibers are singletons, so each local check is polynomial; no exponentially hard leaf is hidden in this example.

The two CNF sides together force every adjacent pair of syndrome bits to differ. Exactly two alternating bit strings survive. With the explicitly checked standard basis, zero offset, and ascending binary enumeration, the smaller surviving integer is floor(2^k/3). Consequently this precise witness-first enumeration makes floor(2^k/3)+1 syndrome attempts. This proves exponential iteration count in k despite only two surviving syndromes. It is a statement about this order and this unfiltered enumeration policy, not all syndrome algorithms or all decision algorithms. The indexed input has O(k log k) bits, so the count is superpolynomial in that encoding without claiming 2^Omega(input bit length).

Sparse substitution of the matched equalities puts both adjacent clauses on the same pair. Each pair becomes the affine condition x_i+x_(i+1)=1. Direct propagation along the path leaves one free bit and solves the family with linear sparse work (and indexed-bit costs). This is a valid repair of this explicit example. It establishes neither a general extraction rule of polynomial cost nor a uniform growth bound for arbitrary joint CNF/affine systems. The filtered relation needs only two fixed-cut rectangles; large unfiltered t alone does not predict the difficulty of finding its survivors.

## Independent exact checks

PASS: an exact temporary copy of the author script passed its five controls and 35 family cases. Its semantic JSON matched the saved author JSON after excluding elapsed wall time; no author output was overwritten. The executable SHA256 with CRLF normalized to LF is `0812936a4eee35b8680a20dbc5e2168e279c2b09b1d53f39e0ddb637aac14ef1`.

To specifically test nonzero affine offsets and inconsistent systems, independently enumerated all 256 subsets of the eight possible affine equations on two variables. Across all four cuts, 1024 generated syndrome sets matched directly evaluated assignment images. Across five local CNF patterns per system, 1280 decision answers matched direct truth tables. These are exhaustive finite correctness controls, not a random experiment campaign, scaling study, or asymptotic proof. The general identities and ordered paired-path count are supported by their algebraic derivations.

## Final disposition

The final narrative explicitly charges interface construction, separator assignments, syndrome iterations and actual local solver costs; distinguishes streaming memory from iteration count; restricts the paired-path bound to the checked fixed order; and gives the sparse equality-substitution repair without a general recognition or decomposition claim. Its cost and input-encoding statements agree with this review. The source comparison attributes the code-state interface to established work. No unresolved complexity blocker remains for the scoped conclusion.

The mathematical result is an exact failure of one conjectured efficiency criterion and an explicit repair on its counterexample. Establishing a useful joint decomposition/compatibility theorem for a specified broader input class remains research, with no guaranteed polynomial bound supplied by this increment.
