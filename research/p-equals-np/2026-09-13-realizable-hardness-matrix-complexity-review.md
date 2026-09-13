# Matrix/Grassmann identity: independent complexity review

2026-09-13. Reviewer `/root/rounding_nonclaims_review`, not an author of any matrix module. S3134 under full S3126; destination `C:/Users/Dan/Desktop/Projects/formal-pvnp`.

**Verdict: GO-WITH-NOTES for the eight-module finite incidence/moment increment.** No blocking complexity or quantifier defect was found within the stated scope. This source review is separate from the independent compiler review and does not certify the full paper theorem.

## Exact scope

Read the complete Incidence, Moment, Fibre and Identity main/Checks source pairs, four author receipt narratives, the independent adversarial proof report including its completed-compilation appendix, and the exact target in `2026-09-12-realizable-hardness-critical-source-obligation-audit.md` lines 33-58. Incidence/Moment are frozen at 4673d9be00eccae5adafe90139aa50c2a95cba9f; Fibre/Identity at 1e6a5bf82f3ba2fbc6454ae3a5b6d8f8dbc4f537. All eight current sources match the freezes after LF normalization. Identity and IdentityChecks have CRLF working bytes versus LF Git bytes, as explicitly recorded below; the other six are raw-identical.

| MatrixGrassmann module | Working SHA256 | Frozen SHA256 | Raw equal |
| --- | --- | --- | --- |
| Incidence | afca36bfaeacfc15f5d307eb8f2ca89f8cf435ee8618bc9353d19f7e859888fb | afca36bfaeacfc15f5d307eb8f2ca89f8cf435ee8618bc9353d19f7e859888fb | True |
| IncidenceChecks | c6b260f58c09a441945388bfa02f3500b8a6ea0ff97ad2b5bfce143777028772 | c6b260f58c09a441945388bfa02f3500b8a6ea0ff97ad2b5bfce143777028772 | True |
| Moment | 34febcefeaeb07edb8fc69a6c3165bad6641151a1d0b76fa1da9bf6610db4cb5 | 34febcefeaeb07edb8fc69a6c3165bad6641151a1d0b76fa1da9bf6610db4cb5 | True |
| MomentChecks | 541f5721a07e748138971eea99cd62d1001bad5e66a884be5b812e22f9bcbca1 | 541f5721a07e748138971eea99cd62d1001bad5e66a884be5b812e22f9bcbca1 | True |
| Fibre | ffa72442467a2c253b42eaf983d85a984a887ae6a3eaa8c76d997cd24ab6a833 | ffa72442467a2c253b42eaf983d85a984a887ae6a3eaa8c76d997cd24ab6a833 | True |
| FibreChecks | dd621ee73fb95ae7ca7c60476d5219c9d66c15a7a7371fb25a8f35e88ccccb2a | dd621ee73fb95ae7ca7c60476d5219c9d66c15a7a7371fb25a8f35e88ccccb2a | True |
| Identity | e518e87c545d5bbc79f7661e5ff7841248ae50920522c653bb2714b1b5cb7fb4 | ea286521f8d890167cfcf46f9c653104236ae02487f6aa287fbfbcbf6d001168 | False |
| IdentityChecks | 2adb28c71a9efd74ef08f79ecd25116ec44c3f11482a71d3850f8e782a03d634 | 498e2cb40d8ad647b05ea3617c90dc1a56ec65cdda888418bb5c0b558f4b5db7 | False |

The independent proof report records session69402 terminal EXIT0, eight actual exports, 77 standard-only profiles and 29 examples. Those are that reviewer's verification results, not a compiler run performed in this lens. I did not modify sources, launch a compiler, stage files, or change public artifacts.

## Actual experiment and absence of circular assumptions

The ambient object is a finite module over GF(2), of dimension n=finrank V. The main identity quantifies over base width d, extension width w, d+w<=n, arbitrary Bool sets of d- and (d+w)-subspaces, and any natural copy count t. Extension width w and copy count t are distinct. Earlier Incidence/Moment use k for width; this must not be confused with the literature's k copies when writing the crosswalk.

The foundational count is for a fixed actual independent frame. Continuation successively appends a vector outside the current span. Its list/array equivalences retain ordered vector payloads. Fibre proves the converse from full concatenation rank to sequential extension validity, so the final experiment is not silently restricted to an underspecified subset of full-rank matrices. Its internal/ambient fibre maps lift and restrict actual columns; span equality follows from containment and equal dimension. This derives the constant anchored fibre size product(i<w)(2^(d+w)-2^(d+i)); it is not a supplied coupling or uniformity certificate.

The uniform_extension_law divides by ALL extension arrays, not only successful ones. Rank-invalid arrays contribute zero and are not resampled. Normalized_extension_law derives the conditional uniform containing-subspace law and the rank factor from actual counts. Containing-space positivity follows from d+w<=n. The base-span averaging similarly uses actual ordered-frame fibre counts.

matrixExperiment is the finite average over all base matrices M and all tuples of t extension arrays. grassmannExperiment is the finite average over actual base subspaces R, followed by all functions Fin t -> Above R w. These definitions encode independent uniform draws through product finite sets and their cardinalities. The matrixMoment representation is proved equal to the explicit matrixExperiment using iid_mean_power; no external sampler independence assumption enters.

The resulting equality is matrixMoment = alpha*grassmannExperiment, with

    alpha = product(i<d)(1-2^i/2^n)
            * (product(i<w)(1-2^(d+i)/2^n))^t.

rankEventProbability_eq_alpha identifies this scalar with the actual joint event that M has rank d and every concatenation has rank d+w. It derives the event probability by specializing the proven finite identity and proving the all-subspaces Grassmann experiment equals one. This is not circular: neither matrix_grassmann_identity nor its fibre/count prerequisites assumes alpha is an event probability or assumes the target identity. Alpha is dimension/copy dependent, not a free correctness certificate.

These noncomputable real finite sums are exact mathematical laws. They do not implement an efficient matrix/subspace sampler or a machine checking arbitrary Bool sets. Enumeration of all matrices or all subspaces can be exponentially large. No FP or runtime claim follows from finite definability or a successful Lean build.

## Rank loss, factor two and edge cases

For D=d+w>0 the proven loss is

    1-alpha <= (d+t*w)*2^(D-1)/2^n.

It uses the product union bound and 1-p^t<=t(1-p), with d base columns and t*w extension-column contributions. This bound can be loose but has the correct dependence on the shared base: the base loss is counted once, not t times. The factor-two consequence explicitly assumes the right-hand side is <=1/2. It is not uniform over arbitrary t or all admissible dimensions. Increasing t at fixed n,d,w can violate the sufficient condition. No half-error condition is hidden in an informal phrase such as sufficiently large.

The dimension condition is required for actual containing spaces and positive rank factors. Abstract rankProbability outside that condition is not claimed to be a probability. The theorem is general in natural t, including zero: rawG retains the base-rank indicator, so a deficient M contributes zero despite the zero-th power. rankEvent explicitly includes base rank even when the extension conjunction is empty.

At w=0 the extension factor is one and each containing space is the base itself. At d=0 the base is the unique empty independent frame. At d=w=0 alpha=1 and a separate factor-two theorem removes the positive-D assumption. At n=0 the admissible dimensions force both widths to zero. These branches preserve the intended laws rather than dividing by an empty Grassmann set or accidentally conditioning away failed matrices.

## Relation to the targeted MZ prerequisite

Substituting w=D-d and t equal to the paper's copy count matches the exact finite MZ Lemma4.4 target extracted in the source audit. The new modules genuinely close the anchored-fibre, exact moment and rank-error identity portion of that target; they go beyond a assumed-law interface.

The paper specialization still needs D=2h, d=2(1-rho)h as natural dimensions, 0<=d<=D<=n, n=3J, and the actual copy-count/parameter choices discharging the displayed <=1/2 inequality. Real notation alone does not establish these integrality constraints or quantifier order. Those remaining hypotheses must be proved before presenting the factor-two estimate at the paper's parameters as fully formalized.

The exact finite identity is not the downstream pseudorandomness-transfer lemma, bilinear global hypercontractivity, level decay, norm estimates, maximal-pair/list amplification or local decoder theorem. The critical-source audit identifies these separately. Nor does this component discharge specialized source Gap3Lin hardness, regularization, repetition, encoded reduction runtime or learning. The suspicious complement/reciprocal line in extracted literature text is not a basis for a published-error claim; no such claim is made in this review.

## Closeout limits

Source headers and early receipt sections retain historical uncompiled/pending wording; later author and independent appendices supersede it. Reconcile those comments in the final package without inflating the mathematical claim. The 77 profiles/29 examples and eight-module acceptance scope must not be described as full-paper certification. These proofs formalize a known prerequisite; no novelty or P-versus-NP result follows.

Proceed with bounded acceptance after root's full evidence audit and all three lenses. Keep S3126 active for the remaining parameter/analytic/source/runtime/learning proofs, submission-quality manuscript reconciliation and final paper-repository consolidation with fresh-checkout verification.
