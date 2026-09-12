# Retained-cycle scout: root balance and nontrivial parallel cycles

2026-09-11; S3070 independent structural scout under [integrity](../../INTEGRITY-CLAIMS.md). Uses the exact mutual-exact-two operator in [S3067](2026-09-11-global-fko.md) and [S3069](2026-09-11-interference-extraction.md). These are direct algebraic observations for review, not a random-input success theorem or final three-lens approval. No experiment, code implementation, or commit was performed.

## An additional output invariant

Let B be the original unsigned variable-by-clause incidence matrix. For the fixed rooting define R_{u,a}=1 when clause a is rooted at u, zero otherwise. A retained channel labeled by clauses a,b adds selector e_a+e_b. Because a,b share a root,

    R(e_a+e_b)=0.

Its B-boundary is the symmetric difference of the endpoint states. Therefore every closed channel history, after canceling repeated clause IDs, produces q satisfying

    Bq=0 and Rq=0.

Consequently the labeled walk does not search all FKO even tuples: its outputs lie in ker([B;R]). This is necessary, not sufficient. Exact-two retention, state-level compatibility and availability of a realizing closed trajectory can further restrict outputs. The existence of a bounded-load family in ker B alone does not establish an equally useful realizable family for this fixed rooted operator.

This invariant is a direct consequence of the existing operator, not a proposed new algebraic method. It does not prove that rooted-compatible tuples are absent or difficult to find at the random FKO density.

## Root gauge and balanced signs

Write clause signs y_a=(-1)^(b_a). If b belongs to the row space of [B;R], say b=B^T x+R^T t, then the sign of a channel a,b is

    (-1)^((B(e_a+e_b)) dot x),

because the root contribution cancels. Since B(e_a+e_b)=S symmetric-difference T, this equals f(S)f(T) for f(S)=(-1)^(x dot S). All signed channel cycles are then positive. Thus a rooted gauge can make the retained graph balanced even when b is not in the row space of B alone.

The converse is not established: the retained graph may fail to realize some augmented-kernel relations. Componentwise graph balance is a condition on its actual cycle space, which need not recover the whole clause-selector kernel. This is why generic claims that inconsistent input signs force a useful retained negative cycle need additional proof.

## Exact retained example: cycles need not cancel

Use six variables x12,x13,x14,x23,x24,x34 and four clauses with unsigned supports

    F1={x12,x13,x14}, F2={x12,x23,x24},
    F3={x13,x23,x34}, F4={x14,x24,x34}.

Root F1,F2 at x12 and F3,F4 at x34. At level two choose

    S={x13,x24}, T={x14,x23}.

For root x12, residual pairs are {x13,x14} and {x23,x24}; each meets S and T once and the pairs are disjoint. Its cells at both endpoints contain exactly clauses 1,2. For root x34, the residual pairs are {x13,x23} and {x14,x24}, also disjoint and legal at both endpoints, with cells exactly clauses 3,4. Thus the actual retention rule gives two distinct parallel channels between S and T.

Traversing one channel forward and the other backward yields q=(1,1,1,1), not the empty selector. Every variable occurs twice, and each root has two selected clauses. Setting exactly one clause sign negative makes this closed two-step channel history negative. This is a genuine retained odd tuple, not a claim that the OR formula is unsatisfiable.

The example disproves universal cycle-cancellation or gauge-triviality assertions about the retained construction. It also shows why channels cannot be replaced by only their aggregated matrix entry for witness extraction: opposite channel signs can cancel that entry while each channel remains a valid labeled transition. The example concerns a specified finite instance, not frequency or density-scale success on random inputs.

## Fixed degree-two tuples and random roots

Suppose a fixed even tuple of e clauses has every used variable appearing exactly twice within it. Build a multigraph whose vertices are clause IDs and whose edges are those variables. It is a loopless cubic multigraph, possibly with parallel edges. Choosing a root for each clause chooses one incident edge at every vertex. Root balance Rq=0 holds precisely when each chosen edge is chosen by both its endpoints. Such choices are exactly perfect matchings, with multiplicities distinguished by variable labels.

With independent uniform roots for those fixed clauses,

    Pr[Rq=0] = number_of_perfect_matchings / 3^e
              <= 3^(-e/2).

For the elementary upper bound, recursively choose the smallest unmatched vertex and one of its at most three incident edges; a complete matching uses e/2 choices. For the four-clause example the graph is K4 with three perfect matchings, so the probability is 3/81=1/27.

This is a restricted fixed-tuple observation. It does not imply that a root-adaptively discovered tuple has this probability, that generic FKO tuples are degree-two, or that the aggregate mass of all root-balanced tuples is small. An exponentially large family can offset a small per-tuple survival probability. Root-balancedness also remains weaker than realizability by retained channels.

## Relation to the current frontier

A non-killed walk eliminates S3069's survival penalty but inherits the same-root selector invariant. The required mass estimate must therefore concern nonempty realizable relations in ker([B;R]), including parallel channel labels, rather than merely unsigned graph returns or ordinary ker B weight counts. A useful positive estimate must still track duplicate outputs and clause capacities.

The strongest checked source remains the existing rooted operator definition [Schmidhuber-Hastings v1, equations 9.3-9.5](https://arxiv.org/pdf/2607.29672v1). Its same-root pairing and exact-two cells directly support these checks; its spectral theorem is not a theorem about non-killed labeled return yield. No independent priority claim is made for root-balance, graph gauges or perfect-matching counting. These observations specify the right object and rule out one overly strong cancellation hypothesis; they do not solve its discovery problem.
