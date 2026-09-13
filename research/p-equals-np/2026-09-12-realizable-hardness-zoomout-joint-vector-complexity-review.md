# Joint posterior success and vector advice: independent complexity review

2026-09-12. S3134/S3137 under S3126. Independent top-level reviewer `/root/cmmsa_encoding_complexity_review`, routed by the orchestrator under the formal three-lens and bounded-claims protocols. I did not author these modules. Review was source-only: no compiler, source/configuration edits, Git mutations, public actions or nested agents.

**Verdict: GO-WITH-NOTES for the actual-law joint-success bound and explicit vector-dependence correction.** Independent kernel compilation is a separate gate. This review does not certify the full decoder, two-prover strategy, reduction, hardness theorem or paper.

## Inspected evidence and identity

Read all four main/Checks sources, both complete draft narratives and final author appendices, the successful full-name binder output, the actual accepted Transfer conclusion/proof interface, GoodAdvice properties and fixed-W rank bound, CoveringSpan frame-fibre and failure estimates, and manuscript lines 412-459 on conditioning, the same joint law, and shared-vector advice. These are formalization checks against preserved local sources, not a novelty survey or independent reproof of all upstream dependencies.

Freeze: `f7e3a5d2c6303dbade00039fce095d73d8767269`. All four actual source files are raw-byte identical to their frozen Git blobs, and therefore also LF-equivalent; no line-ending exception was required.

| Module | Current and frozen SHA256 |
|---|---|
| ZoomOutJoint | `6ea17417713d1b87efaa1542bf3e9b753a3acaa333217915151222e0ea311424` |
| ZoomOutJointChecks | `17a5a43b3c8f7a5c672104e39a70181077b06202e279d22c8a388783dd04913d` |
| VectorAdvice | `1f2e5736d32582df1da8808547dd3719e5c5a886be7f27c61d6be7ffdfd20a5e` |
| VectorAdviceChecks | `14a631da7aede6b5716492543f6c40f770748a1458cb94b09fa3518227b8b753` |

- zoomout-joint draft and final author appendix: `da580aa5e2ffc9f7c4ab10d61839fd52012b2fe960aa45e4484ca4a50bad8325`.
- vector-advice draft and final author appendix: `7f4ec37cd2028a5da9cd0e0e807a3edf0e15c155e646d2a9f2ce205425fc6a06`.

The initial UNCOMPILED comments are historical; the appendices supersede author-build status. They do not supersede independent review requirements. Author successful records cover four targets, eight Joint and fifteen VectorAdvice axiom queries, and eight plus seven examples. This reviewer inspected those records without claiming to have run them.

## Actual posterior and joint probability

`agreement Q W f s` is the conditional retained-L mean on L contained in W; f depends on Q and L, and W depends on Q, but neither is selected as a function of the subsequent deletion draw s. Already fixed external decoder/table data may parameterize those functions. This matches the manuscript's fixed-U, fixed-table and fixed-decoded-function order. It does not license arbitrary s-dependent scores in the ambient-to-posterior Transfer step.

The accepted Transfer error is strictly below qdecay(10,h). Under the explicit margin 2*qdecay(10,h) <= C, ambient agreement at least C implies posterior mean at least C/2. The proved bounded-score inequality gives mass at least C/4 above threshold C/4. Subtracting the actual same-Q, same-W rank-failure mass <= 2*zeta and using 16*zeta <= C gives C/8. Null conditional fibres have agreement zero and cannot succeed because C is positive. No normalization of null fibres is asserted. The upper hypothesis C <= 1 is harmless, although the posterior proof does not explicitly use it; feasibility also constrains C through the bounded ambient agreement premise.

The favorable marginal bound removes the actual GoodAdvice.bad set from F and subtracts the actual ambient-to-advice total variation once. Bayes disintegration uses positivity only on favorable Q, obtained from GoodAdvice. It computes the sum of actual marginal mass times actual posterior success, keeping the same deletion/advice joint distribution. It neither treats Q as independent of V nor converts conditional success for a fixed Q into an unconditional V guarantee. No reciprocal of the posterior density bound is charged as a success loss.

The corrected `ambientMass` binding is material. In the successful full-name output for favorable_marginal_lower, ready_joint_success and eventual_joint_success, every occurrence is `PvNP.RealizableHardness.PosteriorDensity.ambientMass`. There is no arbitrary-function parameter named ambientMass. The source opens PosteriorDensity and disables autoImplicit; the previously failed log showing a spurious law parameter is not the accepted statement.

The final component bound is

    jointSuccess >= (P(F) - P(GoodAdvice.bad) - adviceTV) * C/8.

Its right side can be nonpositive. The theorem does not supply positive favorable-set mass or claim a useful decoder in that case. `eventual_joint_success` chooses a readiness threshold after fixed A>0 and r and works uniformly for all subsequent h, a<=r, and supplied interfaces. It leaves the C margins and decoder properties as explicit premises; it does not secretly choose a threshold uniformly for arbitrarily tiny positive C.

## Vector law and dependence

The actual output maps an independent a-tuple to its span and a dependent tuple to `none`. The failure atom is exactly failureFraction, and the successful atom at Q is exactly (1-failureFraction)*uniformGrass(Q). Conditional uniformity divides by a separately proved positive success mass under a<=dim(V). When a>dim(V), every output is none; no conditional uniformity is asserted. For a=0, failure is zero.

This is different from the upstream analytical spanKernel that resamples on dependence. The new score assigns zero on failure, and its exact expression retains the missing success mass. Thus no uniformity claim silently discards dependent tuples. The bound uses the actual accepted finite frame count and geometric-sum failure bound, specialized through dim(retained(s))>=J. The error is 2^r/2^J under a<=r<=J, avoiding truncated natural subtraction in an expression intended as 2^(r-J).

`joint_score_loss` keeps s in both laws and permits any bounded g(s,Q). This is valid because the per-s vector span is compared directly to the uniform subspace kernel for that same s; it does not contradict the fixed-before-s restriction needed earlier for Transfer. Its loss is one-sided and between zero and the dependence error, with failure scored zero. `decoder_event_transfer` applies it to precisely the favorable-Q, agreement-threshold and rank-stability event in ZoomOutJoint. This charges dependence once in the same joint experiment.

The manuscript describes statistical distance between vector-advice and ideal laws. The current theorem proves the bounded success-score comparison sufficient for that paragraph's lower-bound use, with an explicit failure convention. A normalized Option-valued joint TV theorem is not stated here, and the full prover's behavior on dependent tuples is not implemented. Any later statistical-distance wording must specify the common output space/failure convention or cite a proved coupling. A success lower bound for a full strategy may instead ignore its failure branch, provided its independent branch is proved to implement this exact event.

## Remaining obligations for the paper theorem

1. Produce F, W and fixed score f from the actual local decoder, clique-selected tables and a favorable first-prover question U. Prove their containment, codimension and ambient-agreement properties, and the decoder's favorable-Q mass. These are genuine unproved interfaces, not the conclusion of these modules.
2. Instantiate the actual decoder C and prove both numerical margins, the positive marginal lower bound such as 2^(-8h^2), and dominance of the vector error over the final positive success term. Existing generic inequalities do not establish those paper constants by themselves. Keep transversality and any exceptional charges distinct to avoid subtracting the same event twice.
3. Formalize the shared stream's first-a prefix, both provers' matching guesses and correlations, the successful independent-prefix branch, total tables, transverse subspaces and maximal extension. This fixed-a tuple law does not establish simultaneous prefix distributions for all guessed lengths or their full strategy probabilities. Two independently drawn tuples are not a substitute for the same shared prefix.
4. Complete the specialized outer/PCP and decoder/list-counting chain, favorable-U averaging and guessing losses, parameter order and fixed-L hardness contradiction; then executable encoded reduction/runtime and learning transfer. No P-versus-NP resolution or new algorithmic complexity-class separation follows from these probability lemmas.
5. Finish independent build and the other review lenses, reconcile paper claims against the complete proof, and consolidate finalized Lean sources/dependencies/crosswalk with the paper followed by a fresh-checkout verification.

No blocking complexity or quantifier defect was found in the bounded component statements. S3126 remains incomplete; this verdict does not establish novelty or publication readiness.
