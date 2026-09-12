# S3100 public-candidate proof and extraction review

2026-09-12; independent mathematical/extraction reviewer `conditional_fresh_adversary`. [Integrity boundary](../../INTEGRITY-CLAIMS.md).

**PASS for the actual public mathematical artifact identified below.** I read the entire public FULL-NOTE.md, compared it with the exact frozen underlying source, and checked that its standalone source contract and proof suffice without private development files. No mathematical construction, repair, or new hypothesis was supplied. This is a new extraction audit, not an automatic carry-forward of the underlying theorem's PASS.

The target is repository `weak-rank-positivity-window`, branch `candidate/v2-full-mixed-positivity`. The underlying derivation is `formal-pvnp` commit `90868e5d032db6dba4cdf61d8a3fe07bfacdbfd7`, file `research/p-equals-np/2026-09-12-shared-row-conditioning.md`; I read that committed file with `git show`, not merely its working-tree counterpart.

## Exact reviewed content

| File | SHA256 |
|---|---|
| FULL-NOTE.md | `44AE45216BFD880EC1135383C93D121667A580E2B10CEC95186678AA3A237F1C` |
| README.md | `0EAE7DC91FB1D02C4DC2F9A63EDE5E90F37192F7FE6E38A458724D0F4EC85C2A` |
| CITATION.cff | `2D8C5464B9288D2DA68136C7129E8CBE082BD3FB6A376FB6652B5B8DC4DB06FA` |
| SOURCES.md | `2FF65205A1F78561A57F66614EB0171D363BCFA67946D513B00F62AD1C046D04` |

The reviewed FULL-NOTE.md is 18,176 bytes. During concurrent curation an intermediate write left that file empty. This was detected independently, reported, and excluded from any PASS. After restoration I reread the whole restored file, including every equation and its explanatory text, and recorded the restored bytes above. Thus the verdict does not refer to the pre-restoration draft or presume restoration correctness.

NOTE.md is unchanged relative to the existing repository HEAD `6d09b0966df5ab3847a6283aab677507b7e9cf5c`: both its working-file Git object and `HEAD:NOTE.md` are `d66725171fe42f78541382d7b31902230e90a9bf`. The local checkout does not have a `v1.0.0` tag, so this review verifies preservation against that existing baseline commit rather than independently certifying a remote tag or publication record.

## Standalone contract and degree model

The public note specifies the field, fixed all-ones vector, distinct typed X/Y labels, uniform augmented-full-rank source law, odd-vector constraints, and every prescribed cross product. The even-n boundary corner is explicit. It gives actual U prefix evaluation, including boundary auxiliaries and Boolean complements. It states that U remains an ordinary-degree-one source variable. It does not replace U by its high-degree X/Y expression when measuring degree.

Nonemptiness and deletion consistency are explicitly credited imports from Definitions 6.5--6.6, equation (36), and Lemma 6.7 of the named primary source. This is the same contract checked directly against the primary cached paper in my underlying review; the public restatement has no changed restriction. No source theorem of square positivity is falsely imported.

R is defined monomialwise through local expectations and extended linearly over the row-degree domain. The note expressly distinguishes this from requiring a single small row support for an entire polynomial. Its at-most-two-typed-labels-per-variable count gives 2D labels per monomial and 4D per original monomial pair. Boolean reduction of the square and the degree of p, rather than p squared, are explicit. These declarations make the theorem unambiguous without a private definition of V_D or R.

The probability-normalized kernel convention, actual marginal L2 norms, supported-only conditioning, and zero-dimensional centered-space convention are present before the operator argument. The local source definition and consistency determine the exact conditional marginals used later. No unspecified global probability law or auxiliary positive functional is required.

## Proof extraction checks

Public equations (1)--(24) preserve the mathematical content of source equations (7)--(30), with references consistently renumbered. The removed initial projected-reference route is not used by the surviving direct proof. Removing that development history creates no missing premise.

| Public steps | Checked mathematical content |
|---|---|
| (1)--(4) | Residual affine pairing rank `h=n-u-v+t`, phase invariance, probability normalization, exact rank-deletion fractions, singleton regularity and positive density normalization. |
| (5)--(10) | Sequential affine rank-failure bounds; rank-k character norm `2^(-hk/2)`; factorization overcount `2^(k(a+b))`; summed channel bound; both retained-probability factors; exact conditional source marginals; `gamma/(1-gamma)` rather than an unnormalized density estimate. |
| (11)--(12) | Combined same-side rank failure under independently admissible marginals, conditioning denominator, constant row and column failure means from source consistency, Schur bound `e`, and centered bound `e/(1-e)`. |
| (13)--(15) | Total covariance and conditional-variance Cauchy--Schwarz, supported enlarged separators, all four pure conditional terms, unchanged total support, empty-block cases, and the uniform constant `epsilon_D=2^(-n/2+4D+5)`. |
| (16)--(20) | Finite-dimensional proper-subset complements, isometric lifts and decomposition existence, high-degree row functions paired in genuine union laws, original monomial-pair substitution before regrouping, nested-support orthogonality and incomparable-support conditional centering. |
| (21)--(24) | All-support count rather than local basis dimension, diagonal dominance for arbitrary coefficient sums, explicit n/m/D quantifiers, domain and smallness conditions, and `L epsilon_D < 1/2`. |

In particular, there is no loss of the source's rank restrictions or output constraints in the pure-block estimates; marginal consistency remains explicit where the operator norms require it. The four-term reduction does not assert independence of mixed blocks. High ordinary-degree local components are not incorrectly placed in V_D: the note explains equality of their pairings to the original square through each original pair's union source law. The final count covers all typed contexts, so this is not merely one-context positivity.

All numeric constants needed by the theorem are stated. For even n at least 1024 and `D=floor(n/(32 log_2 n))`, the bounds `4D<=n/8<=n-2`, `t0,d0<=1/16`, `d0<=t0`, and `log_2 L<=1+3n/16` imply the displayed strict margin. No hidden sufficiently-large-n qualification remains in the final theorem.

## Scope consistency and verdict limits

README.md and CITATION.cff state the same full-variable square-positivity window, with degree applying to p. SOURCES.md describes the same odd, augmented-rank-restricted, prescribed-product law, prefix U semantics, and monomialwise source domain. Its perfect-matching/SoS discussion is a boundary statement rather than an imported proof step. The public comparisons are explicitly methodological and bounded; the direct proof does not depend on an unverified comparison theorem. This extraction review checks that consistency, not a fresh exhaustive audit of every literature comparison or priority claim.

The exact source commit is now present in FULL-NOTE.md and REVIEW.md. References to development files in REVIEW.md serve provenance, not missing mathematical definitions. The proof and its sole source-contract imports are available from the public note and its named primary citation. After the curator's final metadata update I reread README.md, CITATION.cff, SOURCES.md and REVIEW.md in full and rechecked their mathematical scope. They now consistently identify prepared v2.0.0, dated 2026-09-12, with explicit not-yet-published status; the citation's date field is prepared release metadata, not evidence of publication. Recording final review results or subsequently changing release-status metadata is separate closeout work and must not be represented as part of these hashed bytes.

No required mathematical edits remain. This PASS is for the displayed informal proof and mathematical extraction of the stated theorem: the unchanged source is PSD on all actual degree-D X/Y/U squares in the explicit window. It is not publication authorization, Lean verification, human peer review, novelty certification, a SoS degree/size lower-bound audit, an efficient-evaluation claim, or a P-versus-NP result. No candidate file was edited by this reviewer; only this new review record was written. No commit, push, tag, release, publication, expenditure, or outreach was performed.
