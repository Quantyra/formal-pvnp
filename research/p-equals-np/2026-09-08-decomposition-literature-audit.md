# Decomposition-preserving forgetting: primary-literature audit

2026-09-08. S3040 / S008 / E004. Independent harness-only audit in formal-pvnp. Starting candidate inspected at commit 5d50555, especially the factor-aware continuation. No code, commits, release or planning edits.

## Source-backed transformation boundary

[Darwiche, Compiling Knowledge into Decomposable Negation Normal Form, IJCAI 1999](https://www.ijcai.org/Proceedings/99-1/Papers/042.pdf), Definition 1, Theorem 1, Definition 9 and Theorem 14: DNNF has literal/constant leaves and AND/OR gates, with variable-disjoint children at every AND. Satisfiability is linear in compiled DAG size. Forgetting variables replaces both polarities of their literals by true, again in linear DAG work. The input must already be DNNF. This does not provide free CNF compilation.

[Darwiche--Marquis, A Knowledge Compilation Map](https://arxiv.org/pdf/1106.1819), section 2, Proposition 5.1/Table 7 and its Appendix proof: determinism additionally requires mutually inconsistent OR children. DNNF supports forgetting and disjunction, but the table denies general bounded conjunction unless P=NP. Keeping output in d-DNNF under even singleton forgetting is likewise denied unless P=NP. These are conditional algorithmic transformation statements, not unconditional circuit-size lower bounds. The Appendix proves the singleton statement by a fresh selector whose projection is disjunction, and uses failure of bounded disjunction in the deterministic language. The statement does not deny forgetting into ordinary DNNF. The size measure is DAG edges; syntactic decomposability and semantic determinism are different properties. The table extraction was checked against its surrounding prose and Appendix proof; browser screenshot rendering was unavailable.

[Bova--Capelli--Mengel--Slivovsky, A Strongly Exponential Separation of DNNFs from CNF Formulas](https://arxiv.org/pdf/1411.1995), Theorems 4--5: for a fixed-degree expander graph, its monotone graph CNF H=AND_{uv in E}(u OR v) requires exponential DNNF size. Their (c,d)-expander has maximum degree d>=3 and |N(S) outside S|>=c|S| whenever |S|<=|V|/2, for constants c>0,d. Theorem 5 supplies an infinite read-three-times monotone 2-CNF family. This concerns every DNNF, without determinism or a fixed variable order. Size is circuit-edge size, linear in vertex count for this family; ordinary binary variable-name encodings add logarithmic factors and preserve superpolynomiality. This is not a lower bound for unrestricted Boolean/arithmetic DAGs, SAT decision algorithms, or all elimination schedules.

## Independent implications for this candidate

The factor-aware rule at 5d50555 is exact because an x-independent product can be moved outside existential projection. Its factors can still share many other variables. That is not full decomposability: every AND child pair would need disjoint support to obtain the literal-forgetting shortcut. The F2 XOR gate is not an NNF OR gate. Even when Boolean OR is encoded as A+B+AB, the resulting product AB can overlap in support. A translation must prove the target invariant and pay its construction cost.

The semantic reason literal erasure works in DNNF is simple. Existential quantification distributes over OR. At a decomposable AND, witness choices for its children use disjoint variables and can be combined. Erasure only removes dependencies, so it cannot break AND decomposability. Neither witness compatibility nor that conclusion holds for a general overlapping AND; erasing both literals from x AND not-x incorrectly gives true.

Determinism is unnecessary for satisfiability and ordinary existential forgetting. For a small explicit caveat, (x AND y) OR (not-x AND z) is deterministic and decomposable. Forgetting x yields y OR z, whose children overlap on y=z=1. Erasing x thus preserves DNNF but loses the deterministic-OR invariant. Assuming deterministic repair for free would add an unproved transformation.

## Proposed selector obstruction, independently checked

The execution author proposed F(x,t,V)=(not-x OR t) AND AND_{uv in E}(x OR u OR v), using an expander graph CNF H(V). Every input factor mentions x. The cofactors are F[x=0]=H and F[x=1]=t, so existential projection is exactly G(t,V)=H OR t.

If a method must emit a DNNF for this projected function, restricting that output to t=0 yields a DNNF for H. Restriction substitutes constants without increasing edges or introducing shared variables at an AND. Therefore the cited DNNF lower bound applies to the projected output itself. This defeats a universal polynomial output-size invariant for the specified x-first DNNF-output bucket transformation. It survives arbitrary syntactic sharing and omission of OR determinism. No empirical growth fit is needed.

The restriction does not establish that forgetting from an already small DNNF is expensive: the necessary compact input DNNF is absent. Indeed, the source F itself would inherit the same lower bound by conditioning x=0. The cost lies in requiring equivalent DNNF compilation of overlapping factors, whether before or after that projection.

This family is trivially satisfiable (set x=t=1). It therefore cannot establish SAT decision hardness. A different schedule can eliminate the private selector t first and then x, reaching true cheaply. Nor does the output lower bound apply if the algorithm is allowed to keep a compact unrestricted circuit for H OR t or retain a nondecomposable factor list. Exact representation requirements, rather than general SAT or the P=NP goal, are what fail.

## Verdict and next obligation

GO for using DNNF forgetting under its precise syntactic invariant and for the selector-based restricted-output obstruction. NO-GO for a universal polynomial single-bucket DNNF-output claim on arbitrary overlapping CNFs. The unrestricted circuit algorithm and P=NP endpoint remain INCOMPLETE. A successor must specify a representation and effective operations outside the defeated invariant, including total compilation/update work; citing tractable queries on a compiled object does not supply that work.

## Final author-artifact complexity review

Inspected the completed `2026-09-08-decomposition-preservation-attempt.md`. Its Shannon compiler is finite, exact, and emits decomposable decision branches because the pivot is absent from each residual. The factor-list rule permits overlaps outside compiled factors and correctly charges future conjunction/repair. It does not silently claim the initial CNF conjunction is DNNF.

The fresh existential-auxiliary extension is sound under its stated interpretation: if a DNNF D(V,t,A) projects to H(V) OR t by existentially forgetting A, literal erasure yields an equally small ordinary DNNF for that relation. Conditioning t=0 then transfers the same lower bound. Auxiliary constraints retained outside the compiled representation are explicitly excluded from this inference.

The explicit bit-length statement is valid: the bounded-degree graph gives O(N) clauses and O(N log N) encoded bits; an exponential-in-N output bound is superpolynomial in that bit length. With ordinary explicit naming and all graph vertices occurring, the stated exp(Omega(L/log L)) formulation is justified. No lower bound is transferred to arbitrary circuits, all schedules, or SAT decision. The satisfiable selector example and t-first escape are retained.

One minor cost clarification was requested: incremental construction work c_i need not exceed all reachable output wires s_i when those wires were built earlier. The accurate cumulative charge is for distinct wires ever materialized, or for explicitly required traversal. This leaves the first-bucket obstruction intact: an O(N)-wire initial input cannot already contain the exponentially many required DNNF wires. No theorem-level blocker was found.

Final complexity verdict: GO for exact construction and the named-source restricted-output obstruction; NO-GO for the universal polynomial single-DNNF bucket contract; INCOMPLETE for an arbitrary-input polynomial SAT algorithm and P=NP. No code or empirical test is needed to certify these symbolic implications; the external DNNF theorem remains an explicitly imported mathematical result, not a local Lean theorem.

Author follow-up verified: the final cost paragraph now explicitly distinguishes the optional traversal upper audit from the necessary cumulative distinct-wire creation lower charge. The first-bucket argument is spelled out. The minor clarification is resolved; there are no outstanding review fixes.
