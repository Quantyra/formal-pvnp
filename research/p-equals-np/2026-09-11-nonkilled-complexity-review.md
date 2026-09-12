# Non-killed returns: independent mathematics and complexity check

2026-09-11; S3070. **GO for the scoped structural diagnosis and cost accounting; no demonstrated frontier advance or improved finder.** Read [retained-cycle audit](2026-09-11-retained-cycle-audit.md) and the saved [main note](2026-09-11-nonkilled-return.md). This reviewer did not author either artifact; the separate alternatives scout is this reviewer's work and is not independently certified here. This is an informal independent lens under [integrity](../../INTEGRITY-CLAIMS.md), not a formal theorem closeout or novelty review.

## Mathematical checks

For every channel q_e=e_a+e_b, same-root pairing implies Rq_e=0 and its variable boundary Bq_e is the XOR of its endpoint states. Summing a closed history therefore yields Bq=Rq=0 after cancellation. This proves necessity only; no surjectivity from the augmented kernel onto realizable retained cycles is used.

If b=B^T x+R^T t, the channel sign is (-1)^(x dot (S+T)), since the root term vanishes. Hence f(S)=(-1)^(x dot S) is a vertex gauge and every cycle is positive. The converse is correctly withheld: balance of actual graph components need not determine all augmented-code relations.

The K4 example was checked directly. At root x12 the residuals {x13,x14} and {x23,x24} each meet both S and T once; at root x34 the residuals {x13,x23} and {x14,x24} do likewise. Each endpoint cell contains exactly its stated pair and the residuals are disjoint. Two distinct parallel channels therefore survive. Their two-step traversal cancels no clause ID and gives all four clauses. Opposite channel signs can cancel the aggregated matrix entry while the labeled negative cycle remains. This rules out universal cancellation for the construction, not rarity or abundance on random inputs.

For a fixed degree-two tuple, each variable joins two distinct clause vertices, so the dual is a loopless cubic multigraph. Independent root choices correspond to selecting one incident edge per vertex. Root balance requires selections in matched pairs, exactly perfect matchings with parallel edges distinguished. Thus the probability PM(D)/3^e is correct. The deterministic first-unmatched-vertex recursion has at most three branches at each of e/2 levels, proving PM(D)<=3^(e/2). For K4, PM=3 and the probability is 1/27. No independence between different tuples, adaptive-root-selection conclusion, or bound for higher variable degrees is inferred.

## Preparation and actual computation

Sampling uniform (S,u) and accepting a retained root-channel event yields acceptance probability sum_S d(S)/(nN) and accepted law pi(S)=d(S)/sum_T d(T). Labeled-channel multiplicity is correctly included. For every channel the stationary directed weight is pi(S)/d(S)=1/sum_T d(T), proving detailed balance. The expected number of proposals nN/sum_T d(T) is charged explicitly. The final revision additionally proves a polynomial lower acceptance bound on a high-probability input event, checked below. Exceptional fixed inputs, including edgeless graphs, still require a finite abort policy; no unconditional termination assertion follows.

Uniform lifted-state sampling and polynomial row access do not pay for a traversal of N=binom(n,ell) states. Cycle-space computation in a fully constructed graph can be expensive even when each state has a short encoding. Gaussian elimination on [B;R] decides unrestricted affine questions but supplies neither short support nor retained realization, return probability or packing. The distinction from unrestricted token-graph moves is correctly maintained.

The fixed-tuple root filter cannot be multiplied into an aggregate algorithmic lower bound: many tuples may compensate, the algorithm can choose after seeing roots, and transition weights matter. Likewise total graph returns do not bound nonempty label-return mass because canceled histories can dominate. The main note leaves the actual mass and capacity estimates unproved.

The requested target-precision clarification is verified in the final main note: inverse-polynomial Q_L is the polynomial-finder target, while a weaker quantified mass/cost tradeoff may also improve the existing subexponential baseline. Total start, walk, failed-output, verification and coverage costs must be compared, not probability alone.

## Final revision: polynomial stationary preparation

The added fixed-root argument is valid in the declared joint random-support/random-root model. M at root 1 is Binomial(m,1/n) with mean Theta(n^(2/5)); Chernoff concentration gives M between fixed positive multiples of that value except with exp(-Omega(n^(2/5))) probability. Conditional on the selected occurrence IDs, their residuals are independent uniform two-subsets of the other n-1 vertices. A union bound for any endpoint collision costs O(M^2/n)=O(n^(-1/5)) on the concentration event. Thus one fixed root has at least two residual edges and all its residual edges are pairwise disjoint with probability 1-o(1). No independence across roots or simultaneous all-root matching is assumed.

For two chosen residual edges, the 4 choices of one endpoint from each and the binom(n-2M,ell-2) choices of padding give distinct states. Padding avoids EVERY root-1 residual endpoint, so every other root-1 clause has overlap zero. Both selected residuals have overlap one before and after toggling their four endpoints. Thus both endpoint cells are exactly the selected pair. Other roots cannot spoil this retention test. The padding pool correctly includes vertex 1 itself: whether the state contains the root is irrelevant to the residual-pair legality condition.

The binomial ratio factors as ell(ell-1)/(n(n-1)) times binom(n-2M,ell-2)/binom(n-2,ell-2). The latter is 1-o(1), since M*ell/n=O(n^(-2/5)). With the extra probability 1/n of choosing root 1, acceptance is at least c ell^2/n^3. This implies O(n^3/ell^2)=O(n^(13/5)) expected proposals on the good event, each with polynomial input work. Independent repeated proposals give the stated exponential cap-failure bound conditional on the event. The input exception remains o(1) and is not silently made exponentially small. Conditioning on acceptance by a fixed cap preserves the accepted stationary distribution on each fixed input.

The final GO covers this added lemma and the corrected Q_L target. It establishes polynomial classical preparation on the stated high-probability event, not coherent preparation at the same cost, rapid mixing, useful cycle mass or FKO packing. This is a real closure of the specific preparation-cost obligation, while its broader significance and novelty remain unestablished.

## Significance and disposition

The root invariant, gauge and matching calculation are direct applications of established algebraic/graph ideas to the source's exact channel rule. This check establishes their internal correctness, not priority or publication significance. They diagnose why transferring arbitrary even-cover abundance is unsupported, while preserving a valid nonempty retained-cycle example. They do not establish a negative mass theorem or a positive algorithmic saving.

No new meet-in-the-middle campaign follows from a known baseline, no new walk tweak is automatically selected, and no P versus NP or intrinsic quantum limitation follows. A positive frontier claim would require a costed aggregate realizability/mass/coverage result or a different global mechanism with a proved saving. This checkpoint supplies neither. No experiments, code, builds, commits or publication actions were performed for this review.
