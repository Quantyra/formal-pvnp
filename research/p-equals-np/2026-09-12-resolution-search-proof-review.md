# S3096 independent proof and mechanism review

2026-09-12. **PASS for the bounded representation-hypothesis rejection; full automatization target INCOMPLETE.** Actual files inspected: [mechanism](2026-09-12-resolution-search-mechanism.md) and [source audit](2026-09-12-resolution-search-source.md). This is an AI-agent mathematical review, not Lean verification, executed algorithm validation, human peer review, or novelty certification.

## Actual mathematical checks

The definition of U_B uses genuine binary-resolution DAG inference count and only final upward closure. This is essential: adding parent proof lengths computes a tree-style bound unless shared ancestors are separately accounted for. The actual draft does not make that substitution or assume an efficient bounded-proof oracle.

The chain H_L is minimally unsatisfiable. Deleting an internal implication permits the assignment false before its gap and true after it; deleting either endpoint unit permits a constant assignment. For a root-connected ancestor DAG with k binary inference nodes and a distinct axiom nodes, there are at most 2k parent edges, while connectivity requires at least k+a-1 edges. Thus a<=k+1. All L+2 chain axioms are needed for a refutation, giving k>=L+1, attained by successive unit resolution. Sharing does not invalidate this counting argument.

Without intermediate weakening, every derived clause remains within its initial component: resolution requires a common pivot, and the x/z and y alphabets are disjoint. The satisfiable K_G component cannot yield the empty clause. Hence the minimum inference count for F is L+1 and its minimum number of proof lines is Theta(m). In the source convention allowing weakening, the same asymptotic lower bound follows from essential chain-axiom dependence: unary weakening cannot increase the number of distinct leaves supported by a given number of binary nodes. No ambiguity in the source proof measure changes the claimed polynomial scale.

The positive-x restriction is exact. At budget m<L+1 a subclause witnessing membership cannot be an empty or nonempty H_L clause. For K_G, an uncovered edge supplies the countermodel described in the draft by activating only its z variable. Conversely, every inclusion-minimal cover has a private edge for each of its vertices; selecting an endpoint in the cover from each edge must therefore select every cover vertex. The m successive resolutions derive exactly that cover clause. Final upward closure gives all and only covers.

The [Bova--Slivovsky primary article, Theorem 19](https://pmc.ncbi.nlm.nih.gov/articles/PMC6979531/) was independently inspected. Its graph-CNF lower bound applies to this exact characteristic function. The ZDD conversion is also valid: add zero-requiring tests for skipped membership bits on every edge, at the root prefix, and before the accepting terminal. This uses O(q(t+1)) OBDD nodes. Fixing the non-positive-x bits then cannot enlarge the OBDD. Since bounded degree and no isolated vertices give m=Theta(|V|), the exponential lower bound contradicts the stated polynomial U_m representation hypothesis.

## Runtime, certificate and claims boundary

I independently checked the [Atserias--Muller primary paper](https://www.cs.upc.edu/~atserias/papers/automating-resolution-np-hard/automating-resolution-np-hard.pdf). The source note correctly distinguishes input-plus-shortest-proof runtime from input-polynomial runtime. Its implication uses a finite, validated simulation on the reduction's short/long gap; it does not wait for termination on arbitrary satisfiable inputs. The converse uses unary proof budgets and bounded-witness prefix search under P=NP. That conditional explanation is not a proposed unconditional mechanism.

The candidate does not provide a charged symbolic construction or certificate extraction procedure. Its semantic frontier definition cannot stand in for either operation. No width or live-clause-space assumption is used in the reviewed proof; the source note keeps those lower bounds distinct from general search.

This is a size obstruction for one exact reusable family, not a runtime lower bound for every search method. The easy chain is immediately refutable by unit propagation. The actual draft explicitly preserves preprocessing, component decomposition, partial compilation, and demand-directed search as escapes. Selection NONE and publication HOLD accurately describe the outcome; the full target remains ACTIVE and INCOMPLETE.

## Independence

The author supplied the gadget and proof. I supplied no construction or repair. Before inspecting the final draft I flagged the need to distinguish tree/DAG budgets and intermediate/final weakening; the actual definition addresses both. I independently checked the adopted counting, restriction, and conversion arguments above. No implementation, experiment, commit, push, publication, outreach, or paid computation was performed by this review.
