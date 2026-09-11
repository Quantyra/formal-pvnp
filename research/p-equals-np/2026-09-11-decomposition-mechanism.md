# S3056: decision decomposition through affine syndromes

2026-09-11. S3056 / S008 / E004. **Result:** a syndrome split repairs the earlier star without building its exponential intersection dictionary. But a fixed ascending syndrome search takes exponentially many attempts on two simple path blocks even though only two syndromes survive. Combining clauses across equality links instead exposes a small affine system. This is one completed speculative mechanism attempt with exact derivations and finite checks, not a general SAT complexity result or novelty claim. [Integrity boundary](../../INTEGRITY-CLAIMS.md).

## Selected operation and attempted extension

Three concrete operations were considered: (1) literal separator conditioning followed by ordinary component splitting; (2) **selected**, conditioning plus a computed affine-syndrome interface between residual blocks; (3) substitution and local clause regrouping before choosing that interface. The third is derived only as the explicit paired-path repair below, not implemented as a general partition optimizer.

S3040 already developed [conditional assignment interfaces](2026-09-08-conditional-interface-attempt.md) and found [generic DNNF projection obstructions](2026-09-08-decomposition-preservation-attempt.md). This attempt does not claim a new Shannon identity or a polynomial DNNF compiler. The changed state is a set of affine syndromes, computed from a matrix, rather than assignments to every syntactically shared variable. The [S3055 star](2026-09-11-mechanism-discovery.md) is a required regression, not the sole mathematical target.

The established linear-algebra core is identified below. The additional falsifiable conjecture attempted here is: **for this fixed streamed interface rule, a polynomial number of jointly feasible syndromes and polynomial-time leaf checks suffice to bound decision work polynomially in the input length.** This conjecture fails: computing or reaching those feasible syndromes is not free. We give a family with exactly two survivors, polynomial leaf checks, and exactly floor(2^k/3)+1 attempted syndromes under the specified order. A simpler counterexample also shows that absence of cross-block CNF clauses does not bound affine interface dimension.

## Exact input and decision rule

Input is an explicit mixed system `Ax=b AND G`, over GF(2) and Boolean CNF, with a supplied variable separator S and a supplied partition X,Y of the remaining variables. Equations may come from the exact bounded-support extractor of S3055, but the present implementation accepts explicit equations and makes no claim to find hidden parity. Variable identities, equation rows and clauses are stored explicitly.

Enumerate assignments to S, simplify clauses syntactically and substitute their bits into the equations. Verify that every remaining clause lies entirely within X or entirely within Y. An empty clause rejects the branch. If the proposed cut fails this support test, reject the proposed decomposition rather than ignoring a crossing clause. Finding a useful separator or partition is not an oracle supplied by the rule.

For a fixed separator assignment, write the remaining system

`A_X x + A_Y y = b'`, with local CNFs `G_X(x)` and `G_Y(y)`.

Let U=im(A_X), V=im(A_Y), and T=U intersect (b'+V). All images live in the same equation-coordinate space. If the affine system is inconsistent, T is empty and this separator assignment is rejected. Otherwise T=s_0+W where W=U intersect V and

`t = dim W = rank(A_X)+rank(A_Y)-rank([A_X A_Y])`.

For each s in T, solve the two independent decision tasks

`A_X x=s AND G_X(x)` and `A_Y y=b'+s AND G_Y(y)`.

A successful pair gives a full witness. Stop at the first pair; do not construct a full model count, survivor list or product cover. UNSAT is returned only after every separator assignment and every generated syndrome has been soundly rejected. The bounded checker uses syntactic unit propagation, Gaussian elimination and an explicit finite free-variable fallback at leaves. That fallback is exponential in its remaining local dimension; it is not a hidden polynomial SAT subroutine.

### Polynomial construction of the interface

Do not enumerate U or V to find their intersection. Gaussian elimination computes one full solution (x_0,y_0) and a basis for the kernel of [A_X A_Y]. Set s_0=A_X x_0. Map each kernel basis vector (u,v) to A_X u, and take a basis of the resulting span by another elimination.

Every resulting vector belongs to both U and V because A_X u+A_Y v=0. Conversely, if w belongs to U intersect V, choose u,v with A_X u=A_Y v=w. Then (u,v) belongs to the kernel, so w is in the span of the mapped basis. This proves that the construction produces exactly W without enumerating exponentially large image spaces. The source-coordinate order is fixed. Syndrome enumeration streams binary combinations of this basis.

## Decision equivalence and the exact product-interface bound

For fixed S, the full satisfying relation is the disjoint union over s in T of

`{x: A_X x=s and G_X(x)} times {y: A_Y y=b'+s and G_Y(y)}`.

Any satisfying pair has unique syndrome s=A_X x, so it belongs to exactly one term. Conversely, any pair from one term satisfies the affine equation and both residual CNFs. Thus the OR of the paired decisions is exact, including infeasible and empty-block cases.

For a feasible pure affine relation, there are exactly 2^t nonempty terms. Moreover, every nonempty sound Cartesian rectangle P times Q contained in that relation has a single syndrome: fix y in Q and compare any two x in P; both have A_X x=b'+A_Y y. Therefore no rectangle can cover points from two different syndrome fibers. The displayed cover is minimal, even if overlapping rectangles are allowed. If the relation is infeasible, its minimum is zero, not 2^t.

With residual CNFs, the minimum product-cover size is instead the number h of syndromes for which both filtered fibers are nonempty, possibly anywhere from zero to 2^t. The same rectangle argument proves this. **Neither minimal cover size nor h is a required decision runtime:** a decision procedure may find one witness or exploit structure without constructing the cover. In particular, computing h or listing its members is not given by the linear-algebra interface construction.

Invertible equation-row changes and invertible coordinate changes within each fixed block preserve t. Arbitrary coordinate mixing across X and Y need not: it may eliminate an affine coupling while making previously separate CNF clauses depend on both new blocks. The fixed partition is part of the theorem, not an incidental implementation choice.

This core is established coding-theory state complexity: [Kashyap, Section 2.2, equations (1), (4)-(5)](https://arxiv.org/pdf/0711.1383) gives the corresponding minimal code-state quotient. See the [primary-source comparison](2026-09-11-decomposition-mechanism-sources.md). The derivation above is a local reconstruction for our exact SAT interface, not a claim to have discovered that theorem.

## Test family 1: the S3055 star is repaired

For `F_m=AND_i(x_0 OR x_i)`, choose S={x_0} and split the leaves into two blocks. There are no affine equations, hence t=0. Under x_0=0 the residuals are unit clauses forcing all leaves one; unit propagation solves each block and yields a witness. Under x_0=1 both residuals are true. The decision implementation takes the first branch and returns without exploring the second.

This uses O(m) sparse literal entries, or O(m log m) bits with explicit indices, rather than constructing the 2^m intersection keys of S3055. The identity is standard conditioning; it demonstrates that the selected decomposition actually changes the failed operation, not that star SAT was hard.

## Test family 2: separate syntactic structure does not determine coupling

Take k variables in each block and no cross-block CNF clauses.

- One equation XOR(X)+XOR(Y)=0 has t=1 when both blocks are nonempty, regardless of how many variables occur. A broad parity support need not mean a large syndrome interface.
- The two equations XOR(X)+XOR(Y)=0 and XOR(Y)=0 have t=0. An invertible row operation exposes independent equations on X and Y. A syntactically crossing row is not sufficient evidence of semantic coupling.
- The k equations x_i+y_i=0 have t=k. The affine graph is only a matching, and there need be no cross-block CNF edge at all, but the chosen X/Y cut has 2^k pure-affine fibers.

These examples prove that a clause-only separator or an unprocessed affine incidence graph can mismeasure the selected interface. The last example is not a lower bound over all cuts: grouping matched variables together removes those cross-cut affine links. Joint compatibility of the cut with both constraint types matters.

## Test family 3: two surviving syndromes still give exponential fixed-order search

For k>=2, use the equality equations x_i=y_i (i=0,...,k-1), with

`G_X = AND_(i=0..k-2) (x_i OR x_(i+1))`,

`G_Y = AND_(i=0..k-2) (NOT y_i OR NOT y_(i+1))`.

The separate clause graphs are paths; the affine graph is a matching. At the supplied cut X/Y, T=GF(2)^k. Equations are given in index order. In the implemented kernel-image/RREF construction, s_0=0 and the ordered interface basis is exactly e_0,...,e_(k-1). Therefore enumerating binary combinations in increasing integer order enumerates the syndrome integers 0,1,...,2^k-1. This equality of order is asserted in the finite checks; the result below is not claimed for arbitrary bases or branch policies.

Each syndrome fixes both leaf assignments uniquely, so local checking takes polynomial work. The X constraints forbid adjacent 00; the Y constraints forbid adjacent 11. Jointly, consecutive bits must differ. Exactly two alternating strings survive.

The smaller integer has its highest bit zero and alternates thereafter. Its value is the finite geometric sum of the appropriate powers of four, namely floor(2^k/3). All earlier integers fail at least one leaf. Thus the exact decision rule attempts

`floor(2^k/3)+1`

syndromes before its first successful pair. There are only two survivors, yet this rule takes Omega(2^k) outer attempts. With indexed input bit length O(k log k), this is superpolynomial, without asserting 2^Omega(input bit length). The attempted survivor-count conjecture is refuted for the specified rule; nothing here lower-bounds every decision algorithm or every affine decomposition.

### Explicit repair: expose the constraints across equality links

Substitute y_i=x_i, preserving the two clause lists. Each adjacent pair now contributes

`(x_i OR x_(i+1)) AND (NOT x_i OR NOT x_(i+1))`,

which is exactly `x_i XOR x_(i+1)=1`. A width-two truth-table check or direct Boolean calculation recognizes this affine factor. The resulting path equations have rank k-1 and one free bit. Choosing x_0 determines every other variable by alternation, and y=x restores the other block.

The transformation writes O(k) sparse clauses/equations, hence O(k log k) bits with indices. Direct path propagation uses O(k) Boolean steps once the input is read; generic Gaussian elimination also remains polynomial but is not claimed linear in dense representation. This repair combines clauses from the two prior blocks. It does not obtain the two survivors by a free SAT filter, and it does not expand an exponential formula.

The family therefore distinguishes **small semantic output**, **cost of discovering it under a fixed decomposition**, and **a concrete representation change that exposes it**. All three can be shown exactly here. Equality substitution and parity recognition are standard operations; this elementary interaction test does not establish novel algorithmic performance on arbitrary mixtures of CNF and affine constraints.

## Cost, implementation and finite evidence

Let N be the explicit input bit length, n its active variable dimension, q its affine row count, s=|S|, and t_sigma the interface dimension after separator assignment sigma. Gaussian/nullspace/image-basis construction is polynomial in n+q; a conservative dense bit bound O((n+q)^3) suffices, with polynomial storage. It does not enumerate U or V. Clause simplification and checking the supplied cut must read the relevant input. A streamed syndrome uses polynomial storage; building all 2^t members in advance is unnecessary.

Total decision work is bounded by the sum over actually visited separator assignments and syndromes of polynomial construction work plus the actual left/right solver work. There can be 2^s separator assignments and 2^(t_sigma) syndromes for each; the right solver runs only when the left succeeds. A leaf with free affine dimension d_leaf can require 2^(d_leaf) assignment checks in the provided fallback. Recursive reuse, separator discovery, conditioned-cache cardinality and finding a globally good decomposition have no free bound here. In paired paths d_leaf=0, so its exponential diagnostic is genuinely in the outer enumeration.

Run from the satellite root:

`python research/p-equals-np/2026-09-11-decomposition-mechanism.py`

The [stdlib script](2026-09-11-decomposition-mechanism.py) and [exact results](2026-09-11-decomposition-mechanism.json) passed five edge-case controls and 35 family cases. Controls include inconsistent affine systems, empty clauses, tautology and incompatible local units. Stars m=1..10 return with t=0, one syndrome attempt and two leaf assignment checks. The three matrix families use k=1..6; finite affine truth sets verify interface construction, rank formula and a nontrivial row operation. Paired paths k=2..8 verify exactly two survivors, the canonical enumeration order, the attempted-syndrome formula and the repaired dimension-one affine system. For k=2,4,6,8 the respective attempt counts are 2,6,22,86. The final local run took under one second; this is not a runtime study.

Exhaustive truth-set/survivor enumeration occurs only in the small verification routines. The decision implementation constructs the syndrome coset by linear algebra and stops at the first witness. Verification's complete finite enumeration is not an uncharged part of the proposed decision operation. All-k claims above are algebraic derivations, not extrapolations from the finite timings. The result file pins the script using SHA256 with LF normalization.

**Strongest supported conclusion:** affine state interfaces measure a fixed cut more accurately than syntactic overlap, but they do not by themselves discover residual compatibility. The paired-path family gives an exact decision-first exponential failure of one ordering and a polynomial explicit repair by regrouping constraints. The useful mathematical content is this interaction and its cost distinction, not a claim that a general efficient compatibility operation has been found. This completes one bounded discovery attempt; no new campaign, publication or general P-versus-NP claim follows automatically.

## Three-lens closeout

Three distinct top-level agent reviewers independently returned GO for this scoped increment. These are informal mathematical, code and claims reviews, not human review or Lean certification. The coding-theory core remains known; the paired-path result is an elementary, fixed-rule interaction example with no established novelty or general SAT implication.

| Lens | Result and evidence |
|---|---|
| Proof-adversarial | GO: [interface identities and paired-path derivation](2026-09-11-decomposition-proof-review.md) |
| Complexity theory | GO: [construction, leaf work and fixed-order cost](2026-09-11-decomposition-complexity-review.md) |
| Nonclaims boundary | GO: [scope, novelty and interpretation](2026-09-11-decomposition-nonclaims-review.md) |
