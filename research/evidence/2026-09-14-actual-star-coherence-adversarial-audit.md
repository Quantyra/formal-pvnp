# Actual emitted star coherence: adversarial audit

S3126/S3137; 2026-09-14. Read-only mathematical review with this evidence note as the only requested write. No Lean execution, source repair, manuscript edit, publication or push.

**Verdict: GO-WITH-NOTES for the manuscript-level accepting-label bridge under its expressly imported transport lemmas.** The actual-star repeated-leaf issue has a precise resolution. This is not a kernel certification of the imported geometry or an actual-star Lean constructor.

## Exact evidence and source boundary

- Canonical manuscript: `C:/Users/Dan/Desktop/Projects/realizable-cmmsa-hardness/paper/submission-manuscript.md`, SHA256 `dc749b0ef184e5d0792c3d366b2461c4478add9facbd4d653627731adc4db240`, independently rehashed. Relevant lines 171-187 and 221-237.
- Prior semantic review: `research/evidence/2026-09-14-star-formula-partial-semantic-review.md`; its warning about arbitrary repeated conflicting projections remains correct.
- Primary source inspected: [MZ, arXiv:2510.23991v1, Section 3.3](https://arxiv.org/html/2510.23991v1#S3.SS3). Section 3.3.1 and footnote 3 identify leaf vertices with the summed subspace, collapsing different complements with the same sum. Section 3.3.2 specifies the affine side-condition alphabets. Lemma 3.3 supplies equivalence, and Lemma 3.4 supplies unique compatible label transport. Section 3.3.3 samples all original leaves using the same U and K before choosing representatives.

The following argument is my deduction from those definitions and imports; I do not silently replace the imports with Lean results.

The imported construction's admissibility hypotheses are retained: the outer instance has bounded variable occurrence and no pair of variables in more than one equation; each retained U consists of J distinct pairwise variable-disjoint equations, with no pair drawn from different equations of U occurring together in any outer equation. Each leaf uses an admissible U, a 2h-dimensional L inside its coordinate space with L intersect H_U=0; the center has the prescribed 2(1-rho)h dimension, is transverse to H_U, and is contained in each original L_i. Representatives are actual vertices in the corresponding equivalence class. Lemma 3.4 is applied only to equivalent admissible vertices and a linear input label respecting its U's side conditions. The finite-dimensional extension step needs only the disjointness and transversality subset of these assumptions; it does not discharge the stronger admissibility needed by the imported equivalence and transport lemmas.

## Precise bridge

Fix one emitted query. Write H=H_U, D_i=L_i+H, and E_i for the sampled representative of D_i. All spaces are embedded in the original variable space. Let A(D) denote the permitted linear labels on a leaf domain D. The center alphabet is K*, with K intersect H=0. For equivalent D,E write T_(D,E):A(D)->A(E) for the unique compatible transport of Lemma 3.4.

**Inverse law.** If a'=T_(D,E)(a), the extension witnessing compatibility of a and a' also witnesses compatibility in the reverse direction: its domain D+H_E equals E+H_D by the defining equivalence equation. Reverse uniqueness therefore gives T_(E,D)(a')=a. This uses existence and uniqueness of compatible extensions, not a bare assertion of surjectivity. Self-transport is identity by the same argument.

**Repeated representatives.** Suppose E_i=E_j as vertices. Since D_i~E_i and E_j~D_j, symmetry and transitivity yield D_i~D_j. Both original leaves use the same U, so the defining equation reduces to

    L_i+H+H = L_j+H+H, hence D_i=D_j.

The original side condition is the same psi_U on the same H. Thus their alphabets, transport endpoints and restrictions to the fixed K coincide. Consequently, for every label a at their common representative,

    pi_i(a) = (T_(E_i,D_i)(a))|K
            = (T_(E_j,D_j)(a))|K = pi_j(a).

This is the missing cross-occurrence equality. It follows from same-U domain collapse and unique transport; no transport composition law around three distinct domains is needed. Distinct complements L_i and L_j do not obstruct it, since the vertex is D_i, not a chosen complement basis.

**Compatible labels exist, for every center label.** Let b:K->F_2 be arbitrary. The disjoint nonzero equation indicators form a basis of H, so prescribing their right-hand sides defines a linear psi_U:H->F_2. Since K intersect H=0, the rule f_0(k+h)=b(k)+psi_U(h) is well-defined and linear on K+H. Extend a basis of K+H to a basis of the finite-dimensional U and assign arbitrary values to added basis vectors. This produces f:U->F_2 extending both b and psi_U.

Set a_i=f|D_i and c_i=T_(D_i,E_i)(a_i). Then c_i is a permitted representative label; inverse transport shows pi_i(c_i)=a_i|K=b. If E_i=E_j, the domain equality just proved gives a_i=a_j and uniqueness gives c_i=c_j. Assign each distinct queried leaf its c_i and the center its b. Center and leaf are separate CSP vertex sorts. Fill unused vertices with any permitted label, which exists by extension from their own side-condition spaces (and the zero functional for centers). This is one global vertex labeling accepting the fixed query.

The quantifiers are: for every emitted query e and every center label b, there exists a global vertex labeling g_(e,b) accepting e with center b. It is not one labeling accepting every query. No satisfaction of the entire outer 3-Lin instance is used or implied.

## Consequences and remaining boundary

Every distinct-leaf fibre P_(e,x,b) in the manuscript is nonempty for every center label b. In particular no actual emitted query is identically false, including those with repeated representatives. Once represented by the actual Star API, `compile_eq_none_iff` therefore yields a `some` formula for each emitted query. No positive-mass edge is dropped, no conditioning is performed, and all occurrence weights remain unchanged.

The generic identity/negation counterexample cannot arise here: repetitions have equal projections, not merely individually surjective projections. The proof does not assume an outer satisfying assignment, simultaneous side-condition consistency for all sampled U'_i on one ambient extension, or a global clique-consistent assignment. Separate compatible transports suffice because only equal queried vertices must share labels.

The prior review's actual-source concern is resolved at the paper-mathematics level by this explicit same-U collapse. The certification tree still needs the actual quotient/side-condition/transport definitions, their proved identities, the query constructor and the theorem applying this argument; abstract coherence or surjectivity hypotheses alone would leave those joins open. Imported Lemmas 3.3-3.4 are not discharged by this audit. Leaf count, weighted support normalization, encoded runtime/FP and full hardness are separate obligations.

Coordination: `incidence_complexity_review` independently identified the same collapse and transport route; no mathematical disagreement was found. Worktree before this write had one pre-existing untracked JSON review under `research/p-equals-np/`; it was preserved. This new evidence note is intentionally left for parent-controlled exact-scope archival, with no Git mutation by this reviewer. Remaining to-do: actual-source kernel bridge and the separate compilation/assembly obligations remain owned by S3126/S3137.

## Independent review of the locked next finite-incidence contract

Reviewed `research/evidence/2026-09-14-actual-star-joint-labeling-next-contract.md`, independently rehashed SHA256 `36fae8a6b1f037b0680a38d4a0c1360b1d4310d1e41103253e0eb81060651c0d`. **GO for the bounded implementation specification; execution remains unverified.** No contract or implementation edit and no compiler was used for this review.

The two locked conclusions follow from their exact hypotheses. Expand the support union to get selected witnesses f,g for x,y. If f=g, excluded e differs from f, and the two points belong to a row intersection of cardinality at most one. If f differs from g, the GoodQuestion cross-pair clause applied to the excluded row gives a contradiction. Applying the finite subsingleton/cardinality equivalence yields the second theorem. There is no accepting-label or transport premise. The full equation-universe quantifier in GoodQuestion is necessary and correctly present. Its disjointness clause is the actual source filter, although not needed for these two particular conclusions. Omitting the unused row-size-three hypothesis is a valid strengthening of this local lemma, with that hypothesis explicitly restored for later private-coordinate work.

All four locked Checks are mathematically true: empty U has empty support; oneRows has exactly the shared variable 2; disjointRows has empty overlap; badRows has pairwise row intersections at most one and disjoint selected singleton rows, but excluded row 2 contains both 0 and 1, violating GoodQuestion and giving overlap cardinality two. The last example specifically demonstrates necessity of the no-cross condition, not necessity of hlinear separately. The packet's earlier informal phrase about dropping hlinear/no-cross must be read with that precise scope; the exact fourth proposition is correct. Its small non-triple rows validly test the stronger general two-theorem API and are not claimed to be full outer-instance examples.

Direct inspection confirmed ActualOccurrenceAllocation.support_card and pair_intersection have the indicated signatures, and the pinned Finset.card_le_one and mem_biUnion helpers have the stated explicit binders. The source-instantiation acceptance/build boundary remains as disclosed in the packet.

The downstream dependency is substantive: three variables and overlap at most one give a coordinate outside support U; disjointness within U' makes it private against all other rows of U'. Evaluating finite linear combinations there eliminates every new-row coefficient and proves the stated span-intersection identity. That identity supplies side-condition agreement, then unique gluing and inverse transport. It also justifies same-U cancellation without assumed global equivalence. Presentation descent is correctly required before final vertex labels; it is not already proved by the two finite lemmas. These steps remain future kernel obligations, not fields asserting their desired conclusions.

The Finset U is explicitly limited to deterministic support reasoning on a distinct tuple. The packet retains occurrence IDs, orders and weights in the future sampler and explicitly prohibits replacing its law by uniform subsets. No distributional collapse or implicit global outer satisfiability was found.
