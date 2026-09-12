# S3062: structure and representation method shapes

Dated 2026-09-11. Companion to the method-shape atlas, under README/INTEGRITY-CLAIMS and the frontier protocol. No solver run, new theorem, or general complexity separation. The central distinction is between **an exact representation that becomes expensive**, **a relaxation that admits spurious possibilities**, and **a missing procedure to find a useful representation**. They are different obstructions.

## Card 1: separator / tree-decomposition dynamic programming

**Object and operation.** In a primal graph, variables sharing a clause are adjacent. A tree-decomposition bag stores assignments to its boundary variables and whether they extend to a satisfying assignment in the processed region. Join compatible states; forget an internal variable by existential OR. Counting replaces OR by the appropriate sum/product with overlap handled. In an incidence decomposition, bags also contain clause vertices, so the state tracks which boundary clauses still need satisfaction.

**Preserved / discarded.** A complete table preserves precisely the boundary extension relation; it forgets internal assignments only after accounting for all their effects on the boundary. This is exact existential projection, not an approximation. A witness needs stored choices or a reconstruction pass; a feasibility bit alone is not the full witness list.

**Older fully parameterized bound (not the current best width exponent).** Samer and Szeider, [Theorem 1, PDF p.8](https://arxiv.org/pdf/cs/0610174), give #SAT time O(4^k k l N) for a supplied nice incidence tree-decomposition of width k, maximum clause size l and N decomposition nodes. The theorem's proof separately invokes fixed-parameter decomposition finding. Do not identify incidence width with primal width or omit N/l. Counts have up to n+1 bits, so implementation bit arithmetic must also be charged. The later [Slivovsky-Szeider SAT 2020 result](https://www.ac.tuwien.ac.at/files/tr/ac-tr-20-006.pdf) improves the incidence-width exponent from 4^k to 2^k with polynomial factors; the older bound here is retained for its explicit parameter contract, not advertised as best current complexity.

**Witness / escape.** The CNF AND_i (h OR x_i) has primal width one: conditioning on h disconnects all leaves. This explains why explicitly enumerating all intersections of its falsifying sets is wasteful. Conversely, a supplied separator for residual clauses need not separate retained XOR constraints. Historical S3056's fixed-cut shared-syndrome dimension t yields 2^t affine interface cases; it says nothing about finding a whole low-width decomposition.

**Limit type.** Exponential table size in k is a bound on this representation/algorithm. High width is not proof that Gaussian elimination, symmetry, preprocessing or another algorithm is slow. A decomposition-search cost is separate from the cost of evaluating a supplied decomposition.

## Card 2: OBDD and decomposable knowledge compilation

**Object and operation.** An OBDD applies Shannon branching in a fixed variable order and merges identical residual Boolean functions. d-DNNF uses AND nodes whose children have disjoint variable sets and OR nodes with disjoint model sets. These are exact Boolean representations, not average-case summaries. Build/compile first; answer supported queries on the resulting graph.

**Known guarantee.** Darwiche and Marquis, [Definitions in Section 2 and Proposition 4.1/Table 5](https://arxiv.org/pdf/1106.1819), distinguish consistency, counting and other queries: DNNF supports polynomial consistency; determinism gives d-DNNF polynomial model counting. These are polynomial in **compiled size**, not automatically in source CNF size. Their Proposition 3.1/Table 3 separates succinctness claims, including conditional entries. We do not import its historical question marks as a current open-problem list.

**Explicit order witness (elementary illustration).** For F=AND_i(x_i iff y_i), order x_1,...,x_r,y_1,...,y_r leaves 2^r distinct residual functions after the x prefix: each requires a different y string. Interleaving x_i,y_i needs only O(r) nodes. A d-DNNF can instead conjoin disjoint pair components. This is a fixed-order representation obstruction, not hardness of equality or of every ordering/compiler.

**Cost / escape.** Reordering, conditioning and component decomposition can avoid a bad shape, but their discovery and intermediate diagram sizes count. A compact final graph does not certify a fast compilation run. Full equivalence preserves all assignments; replacing the graph with bounded marginals or truncated states changes that contract and requires a separate error/soundness argument.

Primary historical operation reference: [Bryant, Graph-Based Algorithms for Boolean Function Manipulation, 1986](https://doi.org/10.1184/r1/6605990). No claim that the pair example is new.

## Card 3: tensor-network contraction

**Object and operation.** Associate local tensors with gates or constraints and sum over shared indices. The full intermediate tensor preserves all dependence on its remaining open indices. Contraction is exact algebra; tensor truncation is a different approximate method.

**Known bound and scope.** Markov and Shi, [Theorem 4.6 and its proof, PDF pp.11-12](https://arxiv.org/pdf/quant-ph/0511069), compute the probability of a specified local measurement scenario for a circuit of T gates in T^{O(1)} exp[O(tw(G_C))] time. The proof constructs the network, finds a suitable decomposition, and contracts it. Proposition 4.2 relates contraction complexity to line-graph treewidth. The graph is the circuit/network graph, not simply the SAT primal graph. The circuit model has constant gate arity and an initially unentangled computational-basis input, with local final measurements/traces. An arbitrary input state is not free: include its preparation network and resulting width before applying the bound. This is a deterministic contraction statement; no angle averaging or noise assumption supplies the speedup.

**Cost / query boundary.** The width exponent measures simultaneous open indices, with dimensions and tensor entry representation relevant. The cited headline is not a free exact-real implementation guarantee: a concrete gate set, arithmetic precision and final error target must be specified. A global SAT-acceptance projector may add substantial structure; it is not automatically the paper's product of local measurement operators. Add its verifier/projector network before asserting a width bound.

**Witness / escape.** A chain of bounded-dimension tensors contracts with bounded intermediate size. A dense intermediate can be exponentially large while retaining information exactly. Algebraic identities, stabilizer structure or a different contraction order may still simplify it. Therefore large contraction width is not a universal classical-simulation lower bound, and efficient simulation alone does not supply a SAT algorithm with useful acceptance gap.

## Card 4: symmetry and encoding changes

**Object and operation.** A verified automorphism maps satisfying assignments to satisfying assignments. Lex-leader constraints restrict search to assignments consistent with a chosen order, keeping a representative of each orbit. Satsuma uses detected graph/symmetry structures to select breaking constraints.

**Preserved / deliberately removed.** Correct symmetry breaking preserves existence of a model, but usually removes models and changes raw model counts. It is not equivalence over all assignments. A returned model still satisfies the original formula. Counting requires orbit handling, and unrelated independently chosen breaking restrictions cannot be presumed jointly safe.

**Primary scope.** [Anders, Brenner and Rattan, Satsuma, Section 2.1 and Section 4](https://drops.dagstuhl.de/storage/00lipics/lipics-vol305-sat2024/LIPIcs.SAT.2024.4/LIPIcs.SAT.2024.4.pdf) define the lex-leader contract and describe structure-driven ordering/generator selection. Its Section 5 is empirical evaluation, not a polynomial complete symmetry-search theorem. [The later certified-symmetry paper](https://arxiv.org/abs/2511.16637) reports proof-logging/checking improvements; its abstract was checked only. We infer no particular overhead bound from that abstract.

**Explicit example / cost.** Permuting interchangeable colors of a graph-coloring encoding can multiply equivalent search branches. Fixing a representative may help, but neither completeness of a chosen generator-based break nor a polynomial-size complete orbit transversal follows for free. Charge detection, added constraints, preprocessing and certification; retain exact original-to-transformed witness mapping.

**Encoding distinction.** Introducing z with its full defining relation can preserve the original model set after existential projection; one-way implications may preserve only satisfiability under the stated use. Auxiliaries can alter graph width, symmetry visibility and model multiplicity. A short XOR chain can expose local structure while leaving global parity reasoning necessary. These are representation choices, not automatic reductions in total difficulty.

## Use in the frontier atlas

The empirical S3061 panel already includes several Satsuma configurations, but it is not an exhaustive test of alternate encodings, tree decompositions, compilers or tensor methods. The named SDP instance lacks recovered native parameters; assigning it a treewidth, contraction rank or exploitable symmetry would be speculation. These cards identify what must be measured/proved before calling it a shared obstruction.

A useful comparison must name: (1) the exact input and target query; (2) what the representation preserves; (3) size of the representation and all intermediates; (4) the charged finder for order/decomposition/encoding; (5) witness/error/certificate handling. A local fixed-cut exponential bound can be correct while another global representation is easy. No card turns a method-specific shape limitation into a P-versus-NP result.

Access: theorem statements and relevant proof/definition sections of Samer-Szeider, Darwiche-Marquis, Markov-Shi and Satsuma were read as primary full-text PDFs. The CMU copy of the compilation map returned an internal error; the arXiv full text succeeded. The 2025 symmetry follow-up was checked only at abstract level. This is a bounded explanatory source selection, not an exhaustive current literature survey or novelty claim.
