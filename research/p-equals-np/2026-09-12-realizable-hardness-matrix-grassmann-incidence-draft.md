# Anchored matrix-extension fibres: source draft

2026-09-12. S3134 under full S3126. Author `/root/cmmsa_encoding_complexity_review`. **UNCOMPILED.** Source-only authorization; no compiler, Git, configuration, accepted-source or public changes. Sixteen axiom queries and eight examples are drafted, not executed.

## Source-directed target

Read the full critical-source-obligation audit (root identified commit 296de446), including its exact MZ Lemma 4.4 matrix/Grassmann moment specification and identified analytic prerequisites. Read accepted GrassmannCounting, CoveringSpan and VectorAdvice interfaces and the pinned mathlib frame-cardinality and independent-snoc proofs. This is the requested first anchored-fibre increment on that route, not a replacement theorem or a novelty claim.

The full target remains E_M G(M)*(E_B F([M,B]))^k = alpha*p, with alpha equal to the rank-success product for the base and each extension, p the actual containing-subspace experiment, and the explicit 1-alpha union bound. This source does not state that identity as proved or assume it as a hypothesis.

## Actual new construction and proof scripts

Outside f is the actual complement of the span of a fixed independent anchor f. extend appends its vector by Fin.snoc. snoc_independent_iff proves exact admissibility; oneColumnEquiv identifies the actual rank-valid one-column fibre with Outside f. card_outside and card_one_column prove its exact cardinality 2^dim(V)-2^d from the actual anchor span dimension and finite vector-space cardinality. dependent_snoc separately shows that appending cannot repair a deficient base matrix.

Continuation f k is an explicit dependent sequence of k ordered columns, each outside the preceding actual span. It is not a supplied probability law or count certificate. card_continuation proves its cardinality by dependent finite-sum induction: the first column has the exact complement count, and the rest has the induction count for that actual extended frame. extensionProduct_eq identifies the result as the product over offsets i<k of (2^dim(V)-2^(d+i)).

columns extracts the actual ordered list, with length k and injectivity. IndependentExtension is the recursive concrete rank-valid predicate on an ordinary vector list, requiring each next column to lie outside the current actual span. columns_independent and columns_surjective establish both directions; columnEquiv identifies continuations with all length-k lists satisfying that predicate. Thus card_listFibre counts actual ordered vector payloads, with no multiplicity from dependence proofs and no assumed coupling.

terminalSpan iterates the actual span after all columns. terminal_finrank proves rank d+k. When that equals the ambient dimension, terminal_eq_top proves the final span is the whole ambient space. anchorIn restricts the fixed ambient frame into a containing subspace without choosing a different anchor. anchored_list_fibre_count specializes the count to every containing D-subspace W: exactly product(i<D-d)(2^D-2^(d+i)) lists complete the anchor there. anchored_completion_spans proves the final internal span is W when d<=D. The constant depends on d,D, not on the actual containing W or on the anchor coordinates.

This is stronger than restating the number of all independent frames: the anchor remains fixed and the new fibre is represented by explicit ordered extension columns. No final incidence-moment, uniform-span or decoder conclusion is an assumption.

## Boundaries and remaining mathematical work

The zero-extension case has cardinality one, including d=D and D=0. A deficient base cannot become independent after one append. The full k=0 moment case is not tested here because k in Continuation counts extension columns, not the number of independent B copies in the future moment identity. That distinction must remain explicit. The source does not yet include a concatenated-matrix API or theorem equating every recursive rank-valid list with rank D of [M,B]; this is the next structural bridge.

Remaining for exact Lemma 4.4: identify these list fibres with actual finite column tuples/matrices; prove the span-indexed disjoint decomposition over containing D-subspaces (including the converse reconstruction from every rank-valid extension); use the constant anchored fibre count to derive conditional uniformity rather than assume it; disintegrate uniform base matrices by their d-spans; expand the k-th power as the actual k-independent extension experiment; prove the exact alpha product, the rank-failure union bound, D=0 and k=0 endpoints, and p<=2*moment under the explicit size inequality. Later instantiate d,D,n with the paper's integral dimensions and n=3J.

No H?stad/Gap3Lin reduction, regularization, smooth parallel repetition, hypercontractivity, Grassmann decoder, maximal-pair counting, full encoded FP reduction, learning theorem or publication-readiness claim follows. Those full-goal obligations remain active in the source audit and parent stories. The separate source-hardness extraction must continue alongside this decoder prerequisite.

This is uncompiled Lean source; recursive dependent instances, cardinality simplification and finite-dimensional API elaboration may need repairs. Root should inspect and preserve the exact draft, then authorize a narrowly scoped build after the current compiler owner releases. Independent three-lens review follows a successful author freeze. The author must not independently review these same files.

## Source hashes

- MatrixGrassmannIncidence.lean: `490bb37f2512ce0f4d96236dfe105f2e0e520f4c215154c55fad4d0242c2527e`.
- MatrixGrassmannIncidenceChecks.lean: `d6eba385c42b0510cde43bdcb796617f704af7a8fb200d4a731b86026a8cd21a`.
