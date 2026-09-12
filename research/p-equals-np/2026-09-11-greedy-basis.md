# Random greedy bases: uniform short-circuit recovery

2026-09-11, S3072. Informal analytic draft under [integrity](../../INTEGRITY-CLAIMS.md), submitted for independent review. No implementation, experiment, novelty claim or P-versus-NP result. The algorithm is known Gaussian/matroid basis processing. The proposed contribution of this attempt is a scoped survival and aggregate-recovery analysis, not a new decoding algorithm.

## Procedure and current disposition

Give every unsigned clause column an independent continuous random priority. Process all M columns in increasing priority, retaining a column iff it is independent of previously retained columns. For every rejected column, record its unique fundamental circuit with the retained basis, preserving original IDs. Retain circuits of size at most k and check the sign parity exactly. Repeat with fresh priorities on the same input. This full-matrix procedure has no local-growth or explored-prefix cap.

A sufficient coordinate-isolation event gives a lower bound uniform over every short circuit on any fixed bounded-degree input. It avoids the planted-prefix conditioning problem. Repetition can consequently recover all short circuits, and thus all short odd circuits, with high probability. This yields a smaller displayed exponent than the exhaustive half-list baseline for the same k, but known connected-subset enumeration already achieves the same degree-based exponent deterministically. Thus it is not a frontier improvement. It remains at n^O(k), and does not by itself prove superiority over the strongest current spectral algorithm with its own constants. Only circuit-enumeration runtime is established here. Fractional-packing optimization and full refutation bit-runtime are not established or pursued.

## Deterministic input theorem and sufficient event

Let B be a binary n-by-M incidence matrix whose columns are three-element supports. Let Delta>=1 bound the number of columns incident with any row. Let T be a minimal nonempty dependent set of e columns, e<=k. Over GF(2), its unique circuit relation uses every column. Write W for its used rows. Every used row has positive even degree within T, so |W|<=3e/2.

Let D_T be the number of columns outside T that touch W; then D_T<=|W|Delta<=3eDelta/2. Set tau=1/(3Delta). Consider event E_T: every column of T has priority below tau and every outside column touching W has priority above tau. Other priorities are unrestricted. Independence of the priorities gives

Pr(E_T)=tau^e(1-tau)^(D_T).

All columns processed before the last member of T are either proper subsets of T, or have support disjoint from W. Proper subsets of T are independent; disjoint-support competitors cannot create a dependence among them. Therefore the greedy basis retains all but the last member of T. The last member is rejected with fundamental circuit exactly T, by uniqueness of coordinates in the retained independent set. Later accepted columns never remove those basis columns, so the result also holds when circuits are recovered after completing the basis.

Since tau<=1/3 and log(1-tau)>=-tau/(1-tau),

Pr(E_T) >= (3Delta)^(-e) exp(-3e/4) = q_Delta^e,
q_Delta=exp(-3/4)/(3Delta).

This is a sufficient-event lower bound, not an equality or typical-success assertion. It holds for every fixed input/circuit satisfying the stated degree bound. No random-code distribution, independent residual hypothesis, uniform distribution on bases or planted error assumption is used. In particular, circuits chosen after observing the input still obey the same priority-probability bound once that input is fixed.

## Aggregate circuit recovery

There are at most H_k=sum_(j=1)^k binom(M,j) subsets of size at most k. Take

R=ceil(q_Delta^(-k) [log H_k+log(1/delta)]).

For each actual circuit of size e<=k, one run emits it with probability at least q_Delta^k. Independent priority runs miss it with probability at most exp(-R q_Delta^k). A union bound therefore recovers all circuits of size at most k with probability at least 1-delta, conditional on any fixed input of degree at most Delta. This pays only log H_k=O(k log M), not H_k, in the repetition count. It does not enumerate H_k as part of the algorithm. Duplicate outputs can be coalesced by sorting their original-ID lists.

Every nonempty even tuple decomposes into disjoint minimal circuits: remove a minimal dependent subset and iterate on the remaining zero sum. If the tuple has odd sign parity, at least one component is odd. Replacing each odd tuple in a fractional packing by one odd component preserves its weight and cannot increase any clause load. Coalescing identical components adds their weights. Thus recovering all short odd circuits suffices to preserve the optimum fractional mass available from all short odd tuples. This reduction does not turn one odd tuple into an OR refutation; the FKO inequality and global certified data still have to hold.

## Random FKO regime and enumeration cost

For iid uniform weight-three columns with M=ceil(C n^(7/5)), each row degree is binomial(M,3/n). A Chernoff bound and union bound give max degree <=ceil(6M/n) with probability 1-n exp(-Omega(M/n)). The deterministic bound above then applies on this single shared event, uniformly over circuits and all repeated runs.

At k=Theta(n^(1/5)),

log R <= k log(M/n)+O(k)+O(log(k log M+log(1/delta)))
      = (2/5) k log n+O(k)+lower-order terms.

Gaussian basis construction, circuit provenance, support filtering, sign checks and at most M emitted candidates per run cost polynomial(n,M) bit operations per run. Storing a basis and its original-column coordinates is polynomial; storing the complete output list costs O(R M k log M) bits before deduplication. A permutation of M IDs implements the priority law exactly. The total circuit-enumeration time is R poly(n,M), including failed runs and long rejected circuits.

For comparison, the explicit half-list baseline has size sum_(j<=k/2) binom(M,j), whose logarithm is (k/2)log(M/k)+O(k)=(3/5)k log n+O(k). The displayed (2/5) versus (3/5) comparison concerns these two specified procedures at the same k, not an optimized literature-wide lower or upper bound. Both remain exp(Theta(k log n)). Existing FKO/spectral methods may have different support constants, output contracts and leading costs. Novelty and strongest-baseline superiority are not established by this calculation.

## Decisive stronger baseline: connected-subset enumeration

Every minimal binary circuit is connected in the clause-intersection graph: if its columns split into two nonintersecting components, their disjoint row supports force each component separately to sum to zero, contradicting minimality. That graph has M vertices and maximum degree at most 3(Delta-1); use the bound d=max(1,3(Delta-1)) to cover isolated vertices as well. Known connected-induced-subset enumeration therefore lists a superset of every short circuit, with parity and signs checked afterward. The exact primary bound is [Patel-Regts, arXiv:1707.05186v2, Lemma 2.4, printed pp. 4-5](https://arxiv.org/pdf/1707.05186v2): all connected subsets of size at most k can be enumerated in O(M k^3 (exp(1) d)^k) time. Together with polynomial parity/sign checks, this gives log time <=k log Delta+O(k)+O(log poly(n,M)). Building the clause-intersection adjacency lists also has polynomial cost from the explicit incidences.

At Delta=O(n^(2/5)), this already has the same (2/5)k log n leading scale as the recovered greedy-basis bound, without randomized survival or repeated orders. It can supply the same short-circuit packing list, so subsequent packing costs are shared. The earlier (2/5) versus (3/5) comparison is true only against naive half-list enumeration and is not evidence of a gain over available methods. The main strategic outcome is therefore no improved finder selected. The uniform survival statement may remain a useful analysis of a known heuristic, but its novelty and independent significance are unverified.

## Fractional packing: identity retained, full bit-runtime not established

The collected odd circuits define an explicit nonnegative packing LP with M unit-capacity constraints and one column per circuit; each column has at most k ones. The count of nonzeros is at most k R M before deduplication. A generic polynomial-time LP invocation is insufficient to preserve the claimed leading exponent: an unspecified power of R would matter.

The relevant primary tool is [Young, Nearly Linear-Work Algorithms for Mixed Packing/Covering](https://arxiv.org/abs/1407.3015), which states approximate explicit packing/covering algorithms with nearly linear work in the number of nonzeros and polynomial inverse-accuracy overhead. One can express a candidate total-mass lower target as an additional covering constraint and search the target, then rescale any small capacity violation. The final rational weights, every clause load, directed spectral bound and strict FKO inequality must be checked exactly. A fixed multiplicative slack in the available FKO mass suffices for a fixed-accuracy approximation; if no such margin is assumed, inverse accuracy and bit cost must be charged and success cannot be declared. A full numerical implementation and end-to-end bit-runtime theorem for this application are not established or pursued here: the matching deterministic baseline already removes the proposed frontier advantage. The exact packing-mass identity above remains valid, but does not supply the optimization or numerical slack for free.

## Prior comparison and the discarded weaker attempt

[Mayhew, Equitable Matroids, Proposition 2.3](https://www.combinatorics.org/ojs/index.php/eljc/article/download/v13i1r41/pdf) describes greedy-basis probabilities via compatible orderings; they are not uniformly distributed bases. [Peters, information-set decoding over Fq, Section 3](https://eprint.iacr.org/2009/589.pdf) already describes choosing columns successively subject to independence. Fundamental-circuit/systematic-row search is standard. The [source comparison](2026-09-11-greedy-basis-sources.md) records the accessed contracts and the matching deterministic baseline. No algorithmic novelty is asserted.

An initially considered sufficient event placed all but one target clause in a sparse prefix whose outside incidence forest avoided competing connections. That approach would require a conditional planted-circuit analysis and then a separate typical-input family transfer. It is not used in the bound above. Coordinate isolation under priorities is less demanding analytically and, crucially, holds pointwise for every bounded-degree input. It is not a modification of the actual algorithm; only a sufficient event in its analysis.

This is a reviewed positive recovery bound for a known heuristic, with no claimed full packing/refutation bit-runtime and no demonstrated advantage over connected enumeration. Even an improved random-FKO certificate finder is an average-case result, not a worst-case P-versus-NP resolution.

## Independent review status

These are informal agent checks, not human review, Lean verification, novelty certification or completion of the continuing research goal. No tests, experiments or implementation were run; document whitespace was checked.

| Lens | Current status |
|---|---|
| [Proof-adversarial](2026-09-11-greedy-basis-proof-review.md) | Scoped GO for procedure, decomposition and baseline; requested editorial corrections applied. The isolation-event contributor is not counted as its independent approver. |
| [Complexity/theory](2026-09-11-greedy-basis-complexity-review.md) | GO: independent survival and aggregate-bound check, including the fixed-input probability space and matching deterministic baseline. |
| [Non-claims](2026-09-11-greedy-basis-nonclaims-review.md) | GO for final main, companions and meta-graph claims scope. Full numerical-packing work is explicitly excluded, not promised as a successor. |
