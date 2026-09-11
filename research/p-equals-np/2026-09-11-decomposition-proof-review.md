# S3056 proof-adversarial review

2026-09-11. Independent proof-adversarial lens for the [final mechanism derivation](2026-09-11-decomposition-mechanism.md), under [INTEGRITY-CLAIMS.md](../../INTEGRITY-CLAIMS.md). This review concerns the supplied separator and fixed residual variable partition, not an optimal-decomposition oracle. Complexity and nonclaims reviews are separately assigned; this is not a Lean proof or human peer review.

**Final proof-lens verdict: GO for the scoped mathematical result.** The interface lemma and fixed-cut cover bound are valid, and the paired-path family refutes the stated survivor-count conjecture for the exact implemented enumeration. The final narrative retains feasibility, residual filtering, ordering, cost and representation limits. No required mathematical correction remains.

## Independent derivation

After fixing a separator assignment, let the remaining variables partition into disjoint blocks X,Y, with every residual clause confined to one block. Write their conjunctions as G_X,G_Y and the remaining affine equations as `A_X x + A_Y y = b` over GF(2). A falsified separator-only clause rejects the branch; an inconsistent affine system does likewise.

Set `U=im(A_X)` and `V=im(A_Y)`. Feasible X syndromes form `C=U intersect (b+V)`. If C is nonempty, choosing s_0 in C proves `C=s_0+(U intersect V)`: subtracting s_0 from another feasible syndrome belongs to both images, and adding any vector in both images preserves feasibility. Hence C has exactly `2^t` elements, where

`t=rank(A_X)+rank(A_Y)-rank([A_X A_Y])`.

Feasibility is essential: if b is outside U+V, C is empty regardless of t. A particular solution of the complete system supplies s_0. Mapping its homogeneous nullspace through the X block and row reducing the resulting image supplies a basis of U intersect V, so enumerating syndromes requires no semantic intersection oracle.

For each fixed s in C, the original decision branch is exactly the conjunction of the two independent decisions

`exists x: G_X(x) and A_X x=s`,

`exists y: G_Y(y) and A_Y y=b+s`.

The forward implication uses s=A_X x. Conversely, the two witnesses have disjoint variable blocks and combine to satisfy every equation and clause. Taking OR over C, then over separator assignments, is therefore sound and complete. This identity charges both local decisions; their notation does not establish polynomial solvability.

## Exact fixed-cut cover bound

For the **pure affine relation**, every feasible syndrome s gives a nonempty Cartesian product of its X fiber and the matching Y fiber. These `2^t` products are a disjoint exact cover when the relation is feasible.

Conversely, consider any nonempty rectangle P times Q contained in the relation. Fixing y in Q forces every x in P to have syndrome b+A_Y y. Thus a sound rectangle cannot contain points of two different syndrome blocks. Each block contains a point, so any exact union-of-rectangles cover requires at least `2^t` rectangles. Overlapping rectangles do not weaken this argument. The empty relation instead has minimum cover zero.

Independent residual constraints can eliminate blocks. Then the exact minimum is the number of syndromes for which both filtered fibers are nonempty, which can be smaller than `2^t` or zero. The pure-affine lower bound must not be transferred unchanged to that filtered relation, to a decision algorithm, or to other cuts.

Invertible equation-row operations and invertible coordinate changes within each block preserve the rank formula and relation structure. Cross-block mixing changes the question: x=y becomes u=0 under u=x+y,v=y, reducing the coupling across the new u/v cut. Thus arbitrary global basis changes cannot be included in a fixed-cut invariance claim.

## Family checks and limits

Conditioning the old star on its hub leaves independent unit constraints or no constraints, with no affine bridge and t=0. A single parity equation involving at least one variable in each block has t=1, independently of how many variables it touches. Matching equations x_i=y_i across the fixed X/Y cut have t=r and require `2^r` exact rectangles there. Gaussian elimination still solves those equations in polynomial time; grouping matched variables differently also changes the cut. These examples test interface dimension, not general decision hardness.

Construction, separator assignments, syndrome enumeration and local solving all remain necessary costs. Syndrome feasibility alone certifies only the affine part. No invariant established here bounds a useful separator or all recursive interfaces for arbitrary CNFs.

## Paired-path interaction and fixed-order cost

The stronger family adds x_i=y_i, the X path clauses `(x_i OR x_(i+1))`, and the Y path clauses `(NOT y_i OR NOT y_(i+1))`. Under the equalities, every adjacent pair must be neither 00 nor 11. Exactly the two alternating strings survive. In the implemented ordering, the affine particular solution is zero and the canonical syndrome basis is exactly `[1,2,4,...,2^(k-1)]`; the enumeration counter is consequently the numerical syndrome value.

For even k, the smaller alternating integer is `1+4+...+4^(k/2-1)=(2^k-1)/3`. For odd k it is `2+8+...+2^(k-2)=(2^k-2)/3`. Both equal `floor(2^k/3)`. The routine therefore attempts exactly `floor(2^k/3)+1` syndromes before its first witness, despite streaming and early exit. This proves exponential attempts for the specified zero-offset, ascending standard-basis order. It does not constrain all ordering, preprocessing, or leaf-coupling strategies.

In particular, substituting y_i=x_i makes each pair of clauses exactly the equation `x_i+x_(i+1)=1`. The k-1 path rows are independent, leaving affine dimension one. Bounded-support affine recognition followed by elimination solves this repaired representation in polynomial work. Thus the example identifies an interaction missed by splitting the local checks; it does not establish hardness of the formula or novelty of the repair.

The equality-encoded CNF also has a width-two path decomposition: alternate bags `{x_i,y_i,x_(i+1)}` and `{x_(i+1),y_i,y_(i+1)}`. They cover both path edges and the equality rungs with connected occurrences of each variable. This reinforces that the chosen all-X/all-Y cut is costly even though a suitable joint decomposition is small.

## Independent implementation verification

The reviewer inspected [the checker](2026-09-11-decomposition-mechanism.py) and checked the following using separately evaluated truth relations:

- All 529 systems of up to two equations on two X and two Y variables, including zero rows and inconsistent systems. All 482 feasible systems had exactly the generated syndrome set; every fiber was a Cartesian product and cross-fiber pairs were invalid.
- 455 decision instances combining five affine systems with pairs of local clauses, including empty clauses and residuals eliminating otherwise feasible syndromes. All answers matched independent exhaustive truth evaluation.
- The paired-path cases k=2 through 8, including the exact enumeration order, witness, and attempts `2,3,6,11,22,43,86`. The substituted clause pairs were truth-equivalent to the XOR chain on every assignment.

The [saved 35-case result](2026-09-11-decomposition-mechanism.json) matches script SHA256-LF `0812936a4eee35b8680a20dbc5e2168e279c2b09b1d53f39e0ddb637aac14ef1`. Tests used integer arithmetic, not timing extrapolation. The all-k statements are established by the derivations above. The supplied-partition API assumes valid disjoint variable blocks; its finite fallback is not an efficient general leaf solver.

The [source comparison](2026-09-11-decomposition-mechanism-sources.md) identifies the existing code-state and matroid-interface theory behind the dimension and local minimality. This review makes no novelty claim.
