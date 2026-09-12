# Independent tensor-basis mechanism challenge

2026-09-12; S3119 / S008 / E004. Bounded source and candidate review under [INTEGRITY-CLAIMS](../../INTEGRITY-CLAIMS.md). No experiment, implementation, proof campaign, novelty certification or public action. The planning frontier protocol permits speculative bounds; failure to prove a final bound is not a rejection criterion.

**Disposition: selection NONE for this attempt.** The final [design](2026-09-12-tensor-basis-design.md) combines bounded block contraction, exhaustive edge conditioning and an identity/Walsh screen for rational real-affine component signatures. It is a computable approach with a defensible preservation contract, but no changed discovery rule or structural guarantee emerged beyond these established operations. This does not exclude instance-dependent bases or prove a general SAT lower bound.

## Primary sources and strongest comparisons

Sources were browsed on September 12, 2026; this is a targeted review, not an exhaustive novelty search.

| Primary source | Guarantee actually supported | Constraint on this proposal |
|---|---|---|
| [Cai–Guo–Williams, Holographic Algorithms Beyond Matchgates](https://arxiv.org/html/1307.7430), Theorems 1.1–1.2, Section 2 | Polynomial recognition and construction of common holographic transformations into affine or product-type signatures; full-table inputs and a separate succinct symmetric case. These targets support general graphs. | Applying this recognizer to signatures extracted from one formula already uses known machinery. The stated theorem does not by itself recognize arbitrary independent edge gauges. Exact computational coefficients are algebraic, not arbitrary real oracles. |
| [Cai–Lu, Holographic algorithms: From art to science](https://doi.org/10.1016/j.jcss.2010.06.005) | Polynomial simultaneous realizability and basis discovery for the stated symmetric generator/recognizer setting. | A basis-search existence gap cannot be asserted for this already algorithmic setting. No blanket nonsymmetric or instance-topology recognition guarantee is inferred. |
| [Cai–Fu, planar Boolean #CSP classification](https://arxiv.org/abs/1603.07046) | Separates general tractability, additional planar matchgate tractability, and planar #P-hardness for Boolean complex-weighted constraint languages. | Requires the stated framework and topology. It does not classify every instance-dependent tensor compiler. Hardness is not unconditional impossibility. |
| [Ganian–Ramanujan–Szeider, Discovering Archipelagos of Tractability for Constraint Satisfaction and Counting](https://arxiv.org/abs/1507.02479) | Finds small strong backdoors into scattered classes under finite conservative language assumptions; disconnected components may use different tractable languages. | Already combines conditioning and heterogeneous tractable components. This is a nearest-known strategy comparison, not a claim that its detection theorem automatically handles input-dependent algebraic tensor weights. |
| [Ganian–Ramanujan–Szeider, Combining Treewidth and Backdoors for CSP](https://arxiv.org/abs/1610.03298) | Combines structural width with tractable-language backdoors, including finding small backdoor-treewidth under its finite-language assumptions. | A proposed combination of blocking and tractability needs a sharper difference than simply combining these ideas. The cited CSP theorem is not silently promoted to weighted exact counting. |
| [Markov–Shi, Simulating quantum computation by contracting tensor networks](https://arxiv.org/abs/quant-ph/0511069) | Tensor-contraction simulation with an exponential treewidth dependence in the stated circuit model. | Small displayed networks or local arity do not alone bound contraction. This comparison supplies no universal lower bound against algebraic contraction. |

The earlier [SAT language audit](2026-09-09-holographic-literature-audit.md) already checked common-basis OR3/equality exclusions for its precise targets. Its exclusions do not extend to arbitrary blocked or edge-dependent encodings. The [holographic extraction note](2026-09-11-holographic-extraction.md), [representation costs](2026-09-11-representation-cost.md), and [meta-graph](2026-09-11-research-meta-graph.md) retain this distinction.

## Actual candidate and challenge before derivation

The initial proposal contracted bounded connected blocks, sought tractable block-boundary bases, synchronized gauges along a spanning forest and conditioned incompatible chord edges. Independent review raised four concrete defects or missing definitions:

1. No transport rule was given that propagates simultaneous tractability along the forest. Separately convenient block bases do not imply compatible contractions.
2. If every chord is conditioned, the remaining forest already admits ordinary contraction on explicit tables. Basis recognition alone adds no demonstrated improvement there.
3. Keeping compatible cyclic edges requires a whole-component tractability certificate. Mixing affine and product-type blocks does not automatically preserve tractability.
4. Pins and size must be included. A pre-transform Boolean pin can become a general unary under a gauge; it is not automatically an affine signature. A block with few vertices can have a large boundary table.

The author repaired the specification by abandoning the unspecified transport rule: enumerate connected block partitions with an incident-edge budget b, enumerate exception edge sets of size at most k, condition their assignments, and test tractable signatures separately in every remaining component and branch. The final version narrows the bases to I and H=[[1,1],[1,-1]], with H/2 inverses on opposite endpoints, and the target to rational real-affine signatures. Bases may differ between disconnected components. This final finite screen is the reviewed candidate, not a completeness claim for arbitrary basis recognition. No first-obligation derivation or experiment was launched.

## Preservation, construction and query accounting

For a count-preserving Boolean tensor encoding, contract internal block indices exactly while retaining every boundary entry. For a selected edge set S, pin both endpoint occurrences of each edge to the same bit. Then

    Z(F) = sum over a in {0,1}^S of product over components C of Z(C | a).

This is finite distributivity, not a new theorem. Deleting an edge without its correlated endpoint pins would not establish this identity. Apply recognition to the already conditioned component signatures, so pins are included rather than granted afterward. Compatible inverse basis maps cancel on internal contractions by the Holant identity; retain any known scalar normalization. Exactly counting with algebraic cancellations requires exact arithmetic and an exact final zero test. An approximate near-zero answer is not the same contract.

For a supplied successful partition and S, assemble full block boundary tables, recognize each branch/component, contract within its verified tractable class, and sum the results. An incident-edge budget b bounds internal and boundary binary indices and gives a straightforward exponential-in-b assembly bound, with polynomial coefficient bit lengths for the original bounded integer network. A bound merely on the number of block vertices would be insufficient without a degree bound. Isolated scalar components and zero signatures must be handled exactly.

The fully computable discovery fallback can enumerate partitions (at most N^N labeled assignments before filtering), edge subsets (at most (|E|+1)^k), and 2^k assignments per subset. These are charged upper bounds for exhaustive enumeration, not lower bounds against a better selector. b and k must be supplied budgets or charged search parameters. Membership tests receive explicit tables of exponential-in-b size. The final rational I/H version avoids algebraic-number discovery: support is checked for affinity, nonzero magnitudes for equality, and signs for a quadratic Boolean representation. The resulting quadratic exponential sum is exactly evaluable by elimination over GF(2). Fixed rational transformations and integer source entries give polynomial bit lengths in N+b; factor magnitudes and denominators must be retained, as the design specifies. A wider algebraic-basis variant would additionally require degrees, heights, common field representation and arithmetic costs; the final finite screen makes no such wider complexity claim.

## Invariants and limits

An invertible per-leg basis change sends a fixed bipartition flattening M to L M R with L and R invertible, preserving its rank. Local gauges also preserve graph connectivity and planarity. Thus such gauges alone cannot certify fixed-cut rank compression or remove crossings. Block contraction changes the representation and must be assessed afresh; the invariant cannot simply be carried across that different operation.

Large ranks or treewidth do not rule out all efficient contraction. Affine constraints can be solved algebraically on nonplanar graphs, and matchgate methods exploit identities beyond generic dense elimination. The rank observation excludes only the asserted rank-reduction mechanism, not every basis algorithm. A planar matchgate alternative would additionally need cyclic boundary order and a planar realization, or a separately charged nonplanar method; neither is supplied by drawing the same graph in another basis.

## Decision and falsifiable obligation

The repaired candidate is known exact decomposition plus known recognition, with exhaustive discovery. No credible new selector, transport law or input-family structural guarantee was specified. The reason for NONE is this missing proposed contribution, not the absence of a proved polynomial SAT bound. An unproved but concrete improved selector with a falsifiable mechanism could have passed selection.

For any future distinct proposal, the first relevant obligation is to specify and check a uniform compatibility/discovery rule on its stated input family, with all branch, table and coefficient costs, and explain a precise guarantee not already supplied by common-basis recognition or backdoor/width machinery. This is a return condition, not an automatically selected successor. No such obligation is authorized for execution here.

An all-input polynomial exact-counting implementation would have a stronger consequence than SAT decision: it would compute #SAT in polynomial time. A merely zero-preserving construction would require its own proof and would imply polynomial SAT decision if its complete deterministic cost were polynomial. Neither result follows from this assessment. Novelty of a possible future application also remains separate from novelty of an algorithm and from any P-versus-NP consequence.
