# Independent complexity review: four-row equality gadget

2026-09-13. S3132/S3137 under S3126. Reviewer specialization_complexity_review, independent of gadget authorship and proof review. **GO-WITH-NOTES for the concrete local gadget and injective relabeling statements.** No local mathematical/quantifier obstruction found; global occurrence reduction and hardness remain unproved by this component.

## Evidence

Read the complete EqualityGadget main/Checks, independent proof-review narrative and frozen identities, and the preserved Gap3Lin source-construction extraction context. Applied the planning three-lens protocol read during this review sequence. No new literature attribution or novelty search is made. No compiler, Git, Lean source, package or public action was performed. Only this new review is written, untracked pending root freeze.

Both raw source files equal freeze `7ab22ab600825a1633c0a93585a31cada7b0ad41`: main SHA256 `03fa25157b758f807aed5ccfd02c35887150ededfc0d056030d0d4dc91b658ee`, Checks `dca88dac55df9e3d238c6e238b69956c827d987075da448fb021bea8740ee960`. Independent markdown and JSON equal their raw blobs at freeze `62e084a597ce3e03949e66d5d10d75a029a15669`: markdown `2efd4796cecddea91e125592d3b110234ca6d9d24c2538c32f797e58148356f8`, JSON `fbaebea44fdb996f09e82e16fddd400ab7be51b3e6909f230304176d5483e097`.

The proof packet records session 69171 pair EXIT 0, 22 standard-only profiles, ten examples and two signatures. Its explicit upstream limitation remains: current package source/export hashes and pinned sources were checked, but the older finite receipt did not record historical individual mathlib export identities, and the whole dependency closure was not rebuilt. This complexity review does not remove that evidence limitation or claim an additional compilation.

## Actual local relation and minimum

The four ordered zero-right-hand-side GF(2) equations are x+a+b=0, y+c+d=0, a+c+e=0, b+d+e=0, on seven distinct local variable names. Summing them cancels each internal variable twice, leaving x+y=0. Thus unequal terminals force at least one violation under every internal assignment. The explicit extension a=c=e=0, b=x, d=y satisfies the first three rows and leaves last-row residual x+y, attaining exactly one violation for unequal terminals and zero for equal terminals.

Accordingly exact_minimum has the correct order: for fixed terminal values, every extension is bounded below by the mismatch indicator, and there exists an attaining extension. It does not claim all extensions attain that minimum or that equal terminal values alone force every row true. Checks contains a counterexample to that stronger statement. satisfiable_iff_equal also uses existential internal values. Neither terminal equality nor the desired violation count is supplied as a premise.

The local finite verification is an ordinary Lean decide proof over all 2^7 assignments, not a random experiment, incomplete search or external native-evaluation certificate. Exhaustiveness is appropriate for this fixed finite relation; it is not a search-based proof about unbounded input formulas.

## Structural statements and relabeling

Rows are ordered occurrences and there are exactly four. Each row has three distinct variables; the four supports are distinct. Their pair intersections are explicitly: rows 0/1 disjoint; 0/2 share a; 0/3 share b; 1/2 share c; 1/3 share d; 2/3 share e. Hence different local rows intersect in at most one variable. Terminals each appear in one row, internals in two. Degree counts row incidences and is unambiguous because no variable repeats within a row.

Relabeling requires an actual embedding Fin 7 into the global variable type. This enforces distinct terminal names and five distinct internal names disjoint from them. It preserves row/support injectivity, support size and local pair intersections. Degree is one or two on the image as specified and zero outside. The relabeled violation lower bound holds for every global assignment, by restriction to the embedding; there is no favorable-assignment assumption.

Only the local attaining extension is provided. Constructing a global assignment that simultaneously realizes all gadget minima requires mutually compatible terminal values and fresh internal names across copies. That is not proved by relabeled_violations_lower. The theorem also cannot be applied to an edge whose terminal names are identical: such a map is not an embedding. A loop edge must be omitted or handled separately with justified gap accounting. Distinct terminal names are required even when the two terminal values happen to be equal; these are different conditions.

## Global composition and complexity boundary

Each local copy uses four constraints and five new internal variables. These constant counts support a later linear-size construction per graph-edge occurrence, but this file contains no binary serializer, FP theorem, occurrence enumeration, or original-source size bound. A globally injective naming scheme for the internals must be constructed and shown polynomially encodable, not merely assumed to exist through one local embedding.

Cross-copy pair intersections do not follow from the local theorem alone. With fresh internal variables, each row of this gadget contains at most one terminal, so even copies on parallel edges can preserve the intended at-most-one intersection per row pair; the actual global construction must prove that property for its own allocation and occurrence identities. Identifying opposite darts as edge occurrences, retaining nonloop multiplicities and omitting loops consistently also require explicit proofs. This local review does not accept an assumed simple-graph model in place of the actual port-cycle graph.

Similarly, global terminal degree is the sum of incidences from all attached gadget copies plus any original constraint. Local terminal degree one and internal degree two do not alone imply the desired degree<=10 bound. The actual cloud incidence bound must be proved and charged. Original row constraints and gadget rows also need cross-family intersection accounting.

The local loss is exactly an unnormalized count of one violated equation per unequal edge endpoint pair at the optimum. Translating that into a fixed global NO satisfaction gap requires the expansion/majority argument, relation to original violations, total equation count, and existence of a globally consistent YES extension. The denominator includes all four rows per inserted gadget. No normalized gap, near-perfect completeness, absolute soundness constant, or NP-hardness statement is proved here.

The preserved source extraction explicitly proposed these equations without claiming to have read the unavailable Min22 structural proof. This review verifies the local proposal's Lean scope and does not attribute this exact gadget to that source or claim novelty. It remains a known-style elementary prerequisite on the route to the specialized source theorem.

Remaining to-do list: S3137 completes the other lenses and root evidence verification; S3132 builds the actual globally fresh occurrence-cloud gadget, ordered encoding, FP/source-size bounds, degree/intersection bookkeeping and gap preservation, then the specialized source hardness proof; S3131 completes the sampling-policy machine/runtime bridge; S3134/S3135 completes decoder and parameter assembly; S3136 completes learning; S3128 reconciles and consolidates the finalized proof/paper with fresh-checkout verification. Full S3126 remains open; no P-versus-NP, full-paper certification or publication claim is supported by this local gadget alone.
