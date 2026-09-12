# Greedy-basis scout: a coordinate-isolation sufficient event

2026-09-11; S3072. Independent derivation scout under [integrity](../../INTEGRITY-CLAIMS.md). Candidate arguments below require the other reviewers' independent checking; this is not final proof approval, novelty assessment or an improved-runtime claim. No experiment, implementation or commit was performed.

## Exact deterministic circuit criterion

Fix any binary column matrix B. Give its columns an independent continuous uniform priority and greedily accept a column exactly when it is independent of the previously accepted columns. The final set is a basis for the column span; no accepted column is later removed.

For a fixed minimal nonempty dependency T, let a be its last-priority member. If every member of T except a is accepted, then a is rejected and its unique fundamental circuit in the final basis is T. Conversely, if T is a final fundamental circuit, its sole nonbasis member must be last in T's order: rejecting that member earlier would make it a combination of earlier accepted columns, whereas its unique representation in the final basis uses all other T members. This is standard greedy linear-matroid reasoning, not new algorithmic content.

A lower bound on this event cannot simply assume a uniform random basis or treat the target as an independently planted random error. Competing columns can reject members of T. The following sufficient event directly excludes that competition without conditioning a random input on possessing T.

## Coordinate isolation under random priorities

Now B is a weight-three incidence matrix, but fix the entire matrix before randomizing priorities. For a circuit T of size e, let V(T) be its used rows and let D_T count outside columns whose supports touch V(T). For tau in (0,1), impose

    all priorities in T <=tau;
    all D_T touching outside-column priorities >tau.

This event has exact probability tau^e (1-tau)^(D_T). Before the last T column is processed, every other processed column outside T is supported outside V(T). Its span is coordinate-disjoint from the T-column span. Since every proper subset of T is independent, all first e-1 T columns are accepted. The last is rejected with fundamental circuit T. Later accepted columns cannot change its unique basis representation.

If the maximum variable degree is Delta, then D_T<=|V(T)| Delta. An even-incidence e-column set uses at most 3e/2 rows, so D_T<=3e Delta/2. For Delta>=1, choose tau=1/(Delta+1). Using log(1-tau)>=-2tau when tau<=1/2 gives the uniform lower bound

    Pr[T appears as a fundamental circuit]
      >= (Delta+1)^(-e) exp(-3e).

Thus a fixed-input degree bound Delta=O(M/n) yields exp(-e log(M/n)-O(e)). At M=Theta(n^(7/5)), this has leading exponent (2/5)e log n. The statement is uniform over circuits of that fixed input; no planted conditioning, residual independence, or uniform-information-set assumption is used.

For the original iid three-column model, the familiar maximum-degree Chernoff event supplies Delta=O(M/n) with high probability. That random-input event must remain separate from the conditional ordering probability. The lower bound also holds on deterministic residuals with the same degree bound, but does not assert that required circuits remain after deletion.

## Possible family-recovery implication to verify

For a cap k, use the uniform lower bound p_k=(Delta+1)^(-k) exp(-3k). With independent priority orders on a fixed input, a particular circuit of size <=k is missed by J trials with probability at most exp(-J p_k). There are at most sum_{e=1}^k binom(M,e) candidate circuits. A union bound therefore recovers every such circuit with high probability when

    J >= p_k^(-1) (log(sum_{e=1}^k binom(M,e)) + log(1/delta)).

Dependence between different circuits' survival in one trial is immaterial. This is a sufficient bound, not an optimality assertion. Each trial must still process the full matrix, derive nonbasis representations, filter support and signs, and charge outputs. The logarithm of the candidate count is O(k log M), not the count itself.

Every even tuple can be partitioned into disjoint minimal binary circuits: remove a contained circuit and repeat on the remaining dependency. If the tuple is sign-inconsistent, at least one component is sign-inconsistent. Replacing each weighted odd tuple by one such odd component keeps its weight, does not increase any clause load, and preserves total fractional mass even after duplicate components are coalesced. Therefore collecting all short minimal circuits is sufficient to contain a no-worse fractional packing whenever the original short-tuple packing exists. This argument does not require independent signs of adaptively chosen components; it is deterministic on the signed input.

## What this does and does not justify

The coordinate-isolation event gives an actual sparse-input circuit-survival lower bound and a candidate route from one circuit to all short circuits. Its tools and algorithm are standard, and its relationship to existing random-basis/ISD bounds must be checked before any novelty or improvement claim.

At k=Theta(n^(1/5)), the sufficient ordering count remains exp(Theta(k log n)); it does not remove the logarithmic scale. A potential leading-constant comparison with elementary MITM must retain the same k and output contract. Generic polynomial-time packing in an exponentially large emitted list can multiply the exponent and erase a claimed advantage. A concrete packing algorithm with list dependence near linear up to polynomial original-input/slack factors, or another fully charged route, is required before claiming an end-to-end gain. The strongest refuter's constants and task may differ as well.

This scout recommends checking these actual bounds rather than treating the absence of a dense-random-basis theorem as proof that the heuristic has no analyzable success probability. It supplies neither a polynomial FKO finder nor a P versus NP bridge. Independent review and prior-art comparison are outstanding.
