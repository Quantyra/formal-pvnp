# Ordinary-gate quantum matching: source and feasibility selection

2026-09-11, S3075, under [integrity](../../INTEGRITY-CLAIMS.md). Bounded primary-source audit, not a new algorithm theorem, implementation or experiment. The [S3074 indexed construction](2026-09-11-half-list-quantum.md) remains the input contract: padded half encodings with many duplicate/invalid descriptions, opposite-side syndrome/price-prefix keys, polynomial ordinary-gate decoding, exact original-clause verification, and polynomially many adaptive threshold queries.

**Selection:** a genuine QRAM-free gate improvement exists in the literature, but no source-supported transfer to this exact domain was verified. The strongest concrete candidate located is the random-function golden-collision method below. Its missing promise-transfer lemma is substantive; no ordinary-gate improvement or universal obstruction is established here.

## Primary model comparison

| Primary source and inspected scope | Cost/model and relevance |
|---|---|
| [Jaques-Schrottenloher, Low-gate Quantum Golden Collision Finding, SAC 2020 / ePrint 2020/424, Sections 2-3 and Appendix B](https://eprint.iacr.org/2020/424.pdf) | Genuine ordinary-gate result: approximately N^(6/7) gates and N^(2/7) stored registers at polynomial evaluation cost, with idle memory free in the gate metric. Problem 2.1 uses a random self-map and O(1) designated golden collisions. Appendix B's random-map predecessor probabilities support the gain. Section 2 discusses reduction from claw search via random composition, with an explicit pseudorandomness assumption when the original outputs are restricted. This does not verify our transfer. |
| [Jaques-Schanck, Quantum Cryptanalysis in the RAM Model: Claw-Finding Attacks on SIKE, Sections 4-5](https://jmschanck.info/papers/20190619-quantum-cryptanalysis-sike.pdf) | Cost 6 explicitly gives O(m sqrt(XYR)+E_G sqrt(XY/R)) gates, with record bits m and evaluation cost E_G. At equal domains X=Y=N, this retains an N factor while optimizing R may improve evaluation-cost factors; it does not establish a smaller domain exponent. It is a relevant predecessor to the low-gate construction, not a universal lower bound for all claw algorithms. Historical SIKE security conclusions are not imported. |
| [Buhrman et al., Quantum Algorithms for Element Distinctness, Sections 2-3](https://arxiv.org/pdf/quant-ph/0007016v2) | The N^(3/4) polylog improvement is a comparison bound. Sorted sampled lists and coherent binary-search membership cannot be treated as ordinary classical RAM operations when their indices are quantum. No sub-N total-gate implementation for our domain is supplied by that bound alone. |
| [Beals et al., Efficient Distributed Quantum Computing, Theorem 5 and element-distinctness application](https://arxiv.org/pdf/1207.2307v2) | Reversible sorting networks implement batches of memory accesses with low parallel depth and substantial width. Their Theorem 7 gives depth T=O-tilde(N/S) with O-tilde(S) space; the ST=O-tilde(N) tradeoff is a parallel-depth contract. Counting all active gates across processors is different; the inspected construction does not supply the requested sub-N total-gate bound for this oracle. |
| [Ambainis, Section 6](https://arxiv.org/pdf/quant-ph/0311001v9), [Tani](https://arxiv.org/pdf/0708.2584), and [Akmal-Jin, Section 2.3](https://link.springer.com/article/10.1007/s00453-022-01092-x) | These underpin S3074's valid query and explicitly augmented quantum-memory-gate results. Reducing the stored subset changes the query tradeoff but does not by itself make each addressed update a polylogarithmic ordinary-gate operation. The earlier direct-scan calculation is an implementation upper bound, not a lower bound. |

The SAC paper distinguishes a gate metric that charges active operations from a depth-width metric charging maintained qubits over time. Its bound is therefore not a low-qubit or hardware-resource claim. The constant-cost oracle normalization must be replaced by the actual decoder and verification circuits; polynomial overhead is acceptable for the targeted exponent, but does not supply a missing success probability.

## Why random output composition is not an automatic repair

Write F(i) for the exact colored-claw value produced by a half encoding, before any auxiliary random map. For every postprocessing function R, equality F(i)=F(j) implies R(F(i))=R(F(j)) with probability one. For an independent random self-map on a domain of size N, two distinct indices agree with probability 1/N. Thus post-hashing preserves each deterministic equal-key fiber; it cannot turn the index-value law into independent random outputs. This elementary observation identifies a missing hypothesis, not an impossibility theorem for the golden-collision algorithm on correlated functions.

The current encoding has redundant spanning-tree descriptions, padded inactive fields, and invalid tags. The source's low-gate walk iterates a self-map and uses the number of predecessors of both endpoints of a golden collision. Exact verification of a final claw protects soundness, but does not establish those predecessor tails or the fraction of marked search states. Appendix B's random-map estimate cannot simply be applied to our hashed equivalence classes.

Nor does taking a random FKO formula make all decoded values independent: every half syndrome reuses the same original columns, and pricing keys change adaptively. A high-probability statement over original formulas is a distinct possible target, requiring its own conditioned distribution and success analysis. It is not furnished by the random-function theorem.

## Assessed repairs and their remaining obligations

**Unique invalid outputs.** Attach side and index to each invalid sentinel in a prospective golden-collision embedding. This prevents invalid fibers from dominating ordinary collisions, and preserves absence of false cross-side matches. It does not eliminate duplicate valid halves or different halves with the same syndrome/price key. The S3074 claw algorithm did not need this change; it matters only to the proposed promise transfer.

**Canonical descriptions.** A half's induced connected components and deterministic spanning forests can be inspected using polynomial work on its at-most-h original IDs. This suggests rejecting noncanonical encodings without materializing the whole list. However, a complete new decoder/count/coverage contract would need to be stated before adoption; it is not a theorem implemented here. Even if structural duplicate descriptions are removed, distinct subsets can share the same syndrome, sign or prefix key. Canonical syntax is not injectivity of the searched value map. Removing padding also does not supply uniform accessible indexing of all surviving halves for free.

**Random output prefixes or restrictions.** A prefix restriction on a key selects an entire fiber together; it does not split that fiber into independent values. An index restriction may split fibers, but can discard the unknown pair. A usable reduction must jointly bound retained useful pairs, residual multiplicities, preparation/rejection cost and the random-iteration statistics required by the chosen algorithm. An unknown solution cannot be isolated for free. Attaching an index to every valid key would instead destroy the equality that the claw query is meant to find.

**Colors and many golden pairs.** The predicate can verify opposite sides, equality and threshold, so defining the check is inexpensive. That does not imply O(1) accepted pairs, nor prove that arbitrary many accepted pairs only help the specific random-map analysis. The dyadic construction may have numerous same-side collisions and repeated cross-side witnesses. A bounded-error all-input theorem allowing these multiplicities, or a charged reduction to the source promise, is still needed.

These are possible research directions, not verified repairs. None warrants importing the N^(6/7) gate exponent into the FKO pricing or packing bound at present.

## Exact next obligation, if this candidate is pursued

The narrow candidate is to adapt the existing golden-collision method, not to build another memory table. A sufficient transfer would construct, from each fixed weighted half query (or under an explicitly weaker random-input promise), a reversibly computable self-map and golden-pair check such that:

- required claws survive with a quantified probability, with original witness indices recoverable;
- the predecessor/marked-state bound replacing the source's random-function estimate holds despite equal-key fibers and adaptive prices;
- the randomization seed, map evaluation, bounded iteration cutoff, coherent workspace, classical storage and extraction have charged ordinary-gate costs;
- all reductions and amplified repetitions leave the total below N times polynomial original-input factors, uniformly across the polynomial packing queries.

No such transfer is derived or selected as an established result here. Polynomial correctness checks alone solve only the output-soundness obligation. A source assessment of a candidate is not achievement of the ongoing research goal.

## Audit record and limits

Opened the author/ePrint SAC full text and the official SAC [preproceedings copy](https://sacworkshop.org/SAC20/files/preproceedings/04-QuantumSearch.pdf); the relevant source is SAC 2020, not the later crawl date. Inspected Problem 2.1-2.4, the Section 3 cost discussion and Appendix B predecessor statement. Independently inspected primary circuit/memory and distributed-computing sources listed above; existing S3074 query/QRAG contracts were reused. Focused searches included `quantum element distinctness without QRAM gate complexity low memory claw finding`, `quantum claw finding QRAM free time space circuit gates`, `Low-gate Quantum Golden Collision random`, and 2025/2026 claw/no-RAM terms. This is not an exhaustive bibliographic or priority audit.

A search hit for Chailloux-Naya-Plasencia-Schrottenloher's 2017 collision method concerns a different random-collision target; its full PDF fetch failed in this pass, so no new theorem from it is relied upon. Later summaries labeling the golden method simply as general element distinctness do not replace the inspected assumptions. The [independent source/feasibility review](2026-09-11-quantum-gate-review.md) is GO for the main selection and final ledger update. This independent source/model check is not proof certification or an exhaustive literature audit. No code, hardware, new proof claim, publication or meta-graph U7 resolution is recorded.
