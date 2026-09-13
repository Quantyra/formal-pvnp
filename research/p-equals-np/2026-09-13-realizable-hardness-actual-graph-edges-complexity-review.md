# Independent complexity review: actual graph edge representatives

2026-09-13. S3132/S3137 under S3126. Reviewer specialization_complexity_review, independent of source authorship. **GO-WITH-NOTES for actual nonloop edge representatives, ordered-list correspondence and the multiplicity-preserving cut/expansion bridge.** Independent build acceptance is separate; session 95016 was live at assignment and is not treated as a pass by this review.

## Evidence

Read complete ActualGraphEdges main and Checks, dated draft and author update, and the preserved source-construction route context. Applied the planning three-lens protocol previously read in this review sequence. Current raw main/Checks equal freeze `f6977d1c87a814ebfb63437259423d3afef3f987`: main SHA256 `9149f49f5ad6eae2064e886b1c633165c9474e792852ba33c4d788e8a51f91f7`, Checks `902712a55c364e09d2f274174b643c3074fca015b2c2be2ead6da65aa37687e2`.

The dated update records author session 15902 pair success and preserves failed proof-script attempts. This review does not substitute that for an independent build. Source Checks requests 25 profiles, three signatures and eight examples; those counts are not claimed as independently run here. No compiler, Git, source, package or public changes were made. Only this new review file was written, untracked for root freezing.

## Actual orbit selection

Vertex n is the actual Fin n times Fin D port-vertex type of the accepted fixed replacement graph, and a Dart adds its three-valued label. reverse is that graph's actual rotation, with involution proved from the accepted base rotation. rank is the injective numeric value of finProdFinEquiv, not a quotient that identifies vertices or edge endpoints. IsRep selects a dart exactly when its source rank is smaller than its destination rank.

For a nonloop dart, endpoint ranks differ. Involution gives exactly one selected orientation and excludes the other. Loops here mean equal endpoint vertices, including a possible two-dart orbit at the same vertex; all such darts are excluded by strict rank comparison. A nonloop orbit always has two distinct darts. canonical_reverse and rep_orbit_unique show selection respects reversal-orbit identity, not just unordered endpoint identity.

Consequently distinct parallel edges survive as distinct representative darts. The implementation never inserts endpoint pairs into a Finset and never performs a simple-graph quotient. Even when two orbits have identical vertex endpoints, their different darts remain distinct keys. That retained multiplicity is essential for later gap accounting.

The ordered dartList enumerates all valid typed darts without duplicates and is proved equal, as a list, to the source-dart projection of the actual FixedPortCycleFamily.table. representativeList is its actual stable filter by IsRep. Membership, nodup, toFinset and length lemmas connect this ordered representation with the representative Finset. Order is not a caller premise or merely a set-level assertion.

## Cardinality, crossing and expansion

The representative set and its reverse image are disjoint; reverse is injective, so both have E elements. Their union lies in the 3nD typed darts, giving 2E<=3nD. This is an inequality: omitted loops may leave unused darts, so claiming equality would exceed the theorem. No loop-free assumption is needed.

For arbitrary Boolean S, crossing filters actual representatives whose endpoint membership differs. orient sends a crossing representative to its unique true-to-false dart. canonical recovers the rank-oriented representative from any outgoing dart. The source proves these maps land in the required finite sets and are inverse in both directions, then uses card_bij. This proves crossing cardinality equals outgoing cardinality without losing parallel multiplicity or introducing a factor-two error. Each crossing nonloop orbit contributes one outgoing dart; the total directed boundary counting both orientations would be a different count.

outgoing_eq_actual_darts identifies that finite set with the accepted graph's dartsBetween(S, complement S). crossing_card_eq_cut then uses the existing boundary normalization and fixed-family cut identity. crossing_expansion invokes the actual accepted cut_expansion for the actual graph, yielding kappa*smallSide S <= crossing count. There is no assumed expansion-to-representative correspondence, arbitrary expander premise or desired counting bound hidden in the final theorem. The fixed positive kappa and actual graph are imported established objects, not supplied by a source instance.

A loop's endpoints have equal S membership, so omitting loops loses no cut edges. edge_terminals_distinct exports exactly the unequal global vertex names required before applying EqualityGadget's embedding of two distinct local terminal variables. This does not by itself allocate its five internal names. At n=0 Vertex/Dart are empty, and the source explicitly proves both representative structures empty. The universal cut/expansion statements remain valid without fabricating a vertex or excluding this boundary case.

## Complexity and global assembly limits

The construction has fixed-family constants chosen before n and a typed list with at most 3nD/2 entries. These are useful numerical size bounds in numeric n. The file is not an encoded FP filtering implementation. It proves neither that a Bits executor computes this exact representativeList nor the runtime of comparing/ranking rows, enumerating retained edges, allocating variable names and serializing the cloud. It also does not prove n is polynomially bounded by the original source-input length. Reusing the accepted serialized table's FP theorem does not automatically prove the subsequent filter/cloud program FP.

The next constructor must choose each retained nonloop orbit once, assign distinct fresh internal names per edge occurrence, embed all seven local gadget variables, and construct a global attaining assignment for fixed terminals. Parallel copies may share terminal names but must not reuse internal names. It must prove cross-gadget and original-row pair intersections, actual terminal incidence sums and internal degree two. The draft's intended degree at most four comes from at most three graph incidences plus one original constraint; it remains an assembly target, not a theorem of this module.

Likewise, crossing_expansion is not yet a global violation lower bound. The majority decoding must relate cloud disagreements to original constraint violations, sum the gadget minimum bounds without double-counting, and divide by the actual total number of rows. The draft's proposed constant soundness gap remains pending that construction and accounting. Local completeness requires a compatible global extension, not only independent existential gadget witnesses. Original source near-perfect completeness and absolute NO hardness must also be supplied by the specialized source proof.

This closes a real representation bridge: the actual graph's expansion now counts the exact retained nonloop edge occurrences suitable for the local gadget. It is not a new expansion theorem, full bounded-occurrence reduction, FP certificate, hardness result or novelty claim. No unavailable source construction is attributed to the literature by this review.

Remaining to-do list: S3137 verifies the actual independent terminal result and other lenses; S3132 implements the globally fresh occurrence-cloud/gadget constructor, degree/intersection and gap proofs, encoded filtering/allocation and original-source size/FP/hardness; S3131 completes the sampling policy's machine/runtime bridge; S3134/S3135 completes decoder and remaining parameters; S3136 completes learning; S3128 reconciles and consolidates finalized paper/proof evidence. Full S3126 remains open.

Build-status update: root subsequently reported independent session 95016 terminal pair EXIT 0, 25 standard-only profiles, eight examples and three signatures, with clean logs and no repairs. The final independent packet was still being written at that report; this review records the report without claiming an independent packet rehash or its own compilation. Root evidence verification remains required.
