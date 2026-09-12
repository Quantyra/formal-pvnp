# Non-killed rooted returns: the missing eligibility and mass bridge

2026-09-11, S3070. Informal investigation under [integrity](../../INTEGRITY-CLAIMS.md). Main derivation reviewed by three independent agent lenses; no implementation, experiment, new complexity claim or novelty conclusion. The [S3069 normalization obstruction](2026-09-11-interference-extraction.md) is not rerun. Removing killing is a valid escape, but this note does not establish an improved finder.

## The attempted bridge and its outcome

The concrete attempt is to start the actual retained-degree walk in a preparable stationary distribution and transfer known short even-cover abundance into useful return mass. The transfer fails at an earlier, exact structural condition: every walk-output tuple must be balanced by root as well as by original variable. An arbitrary even cover need not meet this condition. For a fixed degree-two cover, random rooting meets it with probability at most 3^(-e/2), where e is the number of clauses. This calculation does not bound the total available family; exponentially many candidates can compensate.

Actual retained cycles can carry nonzero clause parity, including parallel-channel cycles. Therefore the route is unresolved, not geometrically impossible. No lower bound on aggregate nonempty return mass or useful clause coverage has been obtained. The next mass proof must count root-balanced, realizable labeled cycles with their transition weights, rather than ordinary even covers or all returns.

## Exact process and charged start

Keep the S3069 iid model m=ceil(C n^(7/5)), ell=ceil(A n^(1/5)), independent uniform clause roots, and the source's exact-two retention rule at both channel endpoints. A channel is labeled by two original clause IDs a,b with the same root and disjoint residual pairs. Its state change is C_a symmetric-difference C_b. Parallel channels remain distinct.

At nonisolated S choose each retained channel with probability 1/d(S), where d(S) is the retained channel count. This is the non-killed operator, not H_ref. The definitions and distinction are anchored in [Schmidhuber-Hastings v1, Section 9.2](https://arxiv.org/pdf/2607.29672v1) and the [S3069 note](2026-09-11-interference-extraction.md).

An exact stationary start can be described without an uncharged global degree sum. Draw S uniformly among ell-subsets and u uniformly among n roots. Check whether root u contributes a retained channel at S; accept S if it does, otherwise retry. The accepted law is pi(S)=d(S)/sum_T d(T), because each root contributes at most one channel. The graph is symmetric with labeled multiplicity, so detailed balance pi(S)/d(S)=pi(T)/d(T) holds on every channel. State generation, root-cell construction, neighbor-cell checking and each step cost polynomial work in the explicit input size; accepted-state preparation requires expected nN/sum_T d(T) trials. A loose polynomial lower bound in the declared random model is proved below. If the graph has no channels it never accepts: a finite implementation must cap attempts and report no output, not assume termination. Uniform-state starts are immediately preparable if this stationary rejection overhead is unsuitable, but need a different return-weight expression.

This is a classical preparation contract. A coherent implementation must additionally charge reversible preparation, normalization precision, reflections, history storage and readout. Compact indexing of N=binom(n,ell) states does not remove any of these costs.

## A polynomial stationary-preparation bound

This closes preparation cost only, not useful output probability. Let M be the number of clauses rooted at the particular vertex 1. Then M is binomial(m,1/n), so with probability 1-exp(-Omega(n^(2/5))) it lies between two fixed positive multiples of n^(2/5). Conditional on the IDs rooted at 1, their residual pairs are independent uniform two-subsets of the other n-1 vertices. A union bound over pairs of such edges bounds any shared endpoint by O(M^2/n)=O(n^(-1/5)). Thus, with probability 1-o(1), root 1 alone has M>=2 pairwise vertex-disjoint residual edges and M=O(n^(2/5)). This event concerns one fixed root; no all-root matching assertion is made.

Fix any two of those edges after observing the input. Choose S to contain one endpoint of each, and choose its remaining ell-2 vertices outside all 2M endpoints. There are exactly 4 binom(n-2M,ell-2) such states. Each has precisely those two legal root-1 edges. T obtained by toggling their four endpoints has the same property, so the channel is retained at both endpoints. Consequently the stationary rejection proposal has acceptance at least

(1/n) 4 binom(n-2M,ell-2)/binom(n,ell) >= c ell^2/n^3.

For the last inequality, factor out ell(ell-1)/(n(n-1)); the remaining avoidance product is 1-o(1), since M ell/n=O(n^(-2/5)). All constants may depend on A,C, and n is sufficiently large. Expected attempts are therefore O(n^3/ell^2)=O(n^(13/5)) on this event, each with polynomial input work. This deliberately loose bound suffices for polynomial preparation. A polynomial cap larger by n^c has failure at most exp(-Omega(n^c)) on the good event; the shared input exception remains only o(1). Fixed-instance timeout reports no output. Conditioning on acceptance preserves the same stationary law.
## The extra root constraint

Let B be the n-by-m original variable-incidence matrix over GF(2), and R the root-incidence matrix with R_(u,a)=1 when clause a has root u. Cancel the original clause IDs of a closed labeled history modulo two, obtaining q in GF(2)^m. Every channel contributes two columns with the same root, so Rq=0. Closure gives Bq=0. Thus the output lies in ker([B;R]), not merely ker(B). A negative history additionally has b dot q=1 under the established clause-sign convention. This is a necessary condition; it does not prove every vector in the augmented kernel has a retained cycle realization or adequate probability.

The row space of [B;R] is consequently a sufficient balance test: if b belongs to that row space, every retained closed history is positive. Failure of this sufficient test does not itself produce a useful walk. See the [independent retained-cycle audit](2026-09-11-retained-cycle-audit.md) for the exact label invariant and the following counterexample to universal cancellation.

Take six variables x_ij indexed by edges of K4 and four clauses indexed by its vertices, clause i containing its three incident edge variables. Root clauses 1,2 at x12 and clauses 3,4 at x34. The states S={x13,x24} and T={x14,x23} have two parallel retained channels: one labeled {1,2}, the other {3,4}. Both exact-two endpoint checks hold. Traversing one channel each way leaves all four clause IDs uncanceled. Choosing odd total clause-sign parity makes this a negative return. The example establishes feasibility of nonempty retained label cycles, not their probability in the random FKO regime. Aggregating the two signed entries can hide the witness labels.

## Exact fixed-cover eligibility calculation

Suppose a fixed even tuple T of e distinct three-variable clauses has every used variable occurring in exactly two clauses. Form its dual cubic multigraph D: clauses are vertices and each variable is an edge joining its two occurrences. There are no loops because each clause uses distinct variables. Parallel edges are allowed and distinguish variable choices.

Each clause independently chooses one of its three incident variables as root. Root balance requires an edge to be chosen by either both endpoints or neither. Since every vertex chooses exactly one incident edge, this is precisely a perfect matching of D. Therefore

Pr_root[R 1_T=0 | fixed unsigned T] = PM(D)/3^e <= 3^(-e/2).

For the inequality, choose a deterministic first remaining vertex and one of at most three incident matching edges, then remove its two endpoints and recurse. There are at most 3^(e/2) perfect matchings, counting parallel edges separately. This elementary matching calculation is a fixed-cover diagnostic, not an assertion of novel matching theory.

The roots must be independent uniform choices and the tuple must be fixed before their exposure. Root-conditioned or adaptively selected tuples do not obey this probability statement without additional analysis. The condition also excludes general even tuples with variables of degree four or more. Most importantly, an upper bound for one cover is not an upper bound on all eligible covers, useful return mass, or the performance of an algorithm that selects covers after seeing roots.

## What the attempted mass argument still lacks

For a sign-independent starting law and transition selection, group length-L closed-history probabilities by their surviving original-ID vector q. Write w_q for these nonnegative weights. Useful unsigned mass is Q_L=sum_(q nonzero) w_q, and only vectors in ker([B;R]) can contribute. Backtracking contributes to q=0 and can dominate total return probability.

Known even-cover existence supplies neither root balance nor retained realizability, nor these weights. Even finding many vectors in the augmented kernel by Gaussian elimination does not bound their support, realize them as short retained histories, or produce large Q_L. Standard signed-graph cycle methods operate in the explicit graph, whose lifted dimension is N; that cost cannot be suppressed by a polynomial row oracle. The [independent global-alternatives comparison](2026-09-11-nonkilled-alternatives.md) also checks meet-in-the-middle search on original clause syndromes: it avoids a walk-realization obligation but retains n^Theta(k) list cost and no packing guarantee. Ordinary signed token-graph results also cannot simply be imported: the present channel moves two disjoint residual edges sharing a root and imposes exact-two cells, rather than an unrestricted single-token move. [On token signed graphs](https://link.springer.com/article/10.1007/s10801-025-01416-4) is a relevant comparison, not a theorem about this retained walk.

The surviving concrete obligation is an aggregate weighted estimate: for an explicitly preparable start and L=O(n^(1/5)), for a polynomial-finder target prove inverse-polynomial Q_L (or quantify a weaker mass/cost tradeoff that still beats existing subexponential search), then enough distinct tuple weight under verified clause capacities. A second-moment sign argument would only turn sufficiently diffuse unsigned mass into odd-sign mass; it would not prove coverage. No such estimate is established in this attempt. The loose polynomial preparation bound above removes that access obstacle, but supplies no useful-return or coverage estimate.

## Disposition

The calculation changes the next action from transferring ordinary even-cover abundance to analyzing the augmented root-balanced code and its actual retained realizations. It also rejects a blanket zero-cycle explanation through an explicit source-rule counterexample. These are scoped structural diagnostics, not a demonstrated frontier advance or a new finder. A genuinely different global search may target augmented dependencies directly; its sparse search and packing costs would still need justification. No next algorithm is selected or claimed by this note.

A future improvement for these random formulas would remain an average-case certificate-discovery result. The worst-case bridge to P versus NP is still missing. The [meta-graph update](2026-09-11-research-meta-graph.md) passed its final independent claims-scope inspection.



## Independent review and checks

These are informal agent reviews, not human review, Lean verification or novelty certification. Document whitespace was checked; no implementation, tests or experiments were run.

| Lens | Verdict and reviewed scope |
|---|---|
| [Proof-adversarial](2026-09-11-nonkilled-proof-review.md) | GO, including the stationary-preparation lemma, root invariant and finite retained-cycle example. |
| [Complexity](2026-09-11-nonkilled-complexity-review.md) | GO, including the O(n^(13/5)) proposal bound on the specified good event and the separate unresolved return/coverage costs. |
| [Non-claims](2026-09-11-nonkilled-nonclaims-review.md) | GO: main, companions and final updated meta-graph preserve the restricted claims boundary. |

No next algorithm is selected by this note. Aggregate weighted return mass remains open; a reassessment may consider different global mechanisms without treating another sampler adjustment as automatic progress.
