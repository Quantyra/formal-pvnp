# Degree addendum: independent public mathematical extraction review

2026-09-12; S3102 / S3101 / E004 / S008; [integrity](../../INTEGRITY-CLAIMS.md). Reviewer: `conditional_nonclaims`, serving as the independent mathematical/extraction lens.

**PASS for the actual public COROLLARY.md and its inspected mathematical metadata.** I read the entire public addendum, compared it with the committed S3101 source, and inspected README.md, SOURCES.md, CITATION.cff and REVIEW.md after the exact source pin was inserted. No mathematical repair, new construction, or additional source assumption is required. This is an actual extraction review, not an automatic transfer of the S3101 proof verdict.

## Exact reviewed artifacts and preservation

The target is the weak-rank-positivity-window repository, branch candidate/v2.1.0-degree-corollary. The exact underlying corollary source is formal-pvnp commit `918e90fd9117b6689c068bac0148e8556149f454`, record `research/p-equals-np/2026-09-12-positivity-complexity-consequence.md`, read using git show. REVIEW.md now pins that commit correctly. The imported public positivity theorem is FULL-NOTE.md at v2.0.0 commit `95701cf018a81894a2d20b95121c2a724a17992c`.

| File | Reviewed checkout SHA256 | Git blob |
|---|---|---|
| COROLLARY.md | `794f762688e398669f3788ece92fff29c52f87fc6a711f571efe2c9da6e28f3a` | `ce7bb0842fee7035626f9d2c7792929fcfffbe91` |
| README.md | `f578f6599449d33223a9e0dfa72985289a77c4119af656456e8967ee0fad6758` | `3d600e1108eca47e56f11df40aa13c0ab4e81fe5` |
| SOURCES.md | `b276891acb30d5eaa61db7355bbfdb25b4238eed1904eebcae97fe204c2b8a4a` | `a215af4790f411ab7ee54e6f8b234e4a106e8c01` |
| CITATION.cff | `d4e16c8ca7d9450d886e472acaad0fbe9fa39fe8268e89b5197a35cb80a5eeb7` | `ff8919ee1e7c34ff61c3f76beab68649c4e248e7` |

The inspected COROLLARY.md is 11,313 checkout bytes. Git blob pins account for checkout newline normalization. FULL-NOTE.md's working-file Git blob is `6a5f09aadfd0732a6a7824b22e1aec3c350bdc45`, exactly the blob at the specified v2.0.0 commit. NOTE.md's blob is `d66725171fe42f78541382d7b31902230e90a9bf`, likewise unchanged there and from v1. Different Windows checkout SHA256 values are not treated as mathematical edits when these Git contents are identical.

I supplied no S3101 construction or repair, and supply none here. I was the S3101 independent proof reviewer and earlier performed nonclaims/integration work for the PSD publication, without authoring its mathematics. The prior PSD author is disclosed as a source-review contributor, not its independent verifier.

## Complete extraction and standalone contracts

The public statement has the exact parameters even n>=1024, m=n^2, A=I_m, and D=floor(n/(32 log_2 n)). It specifies the real Boolean clause encoding, optional twins, ordinary raw certificate convention, excluded degree at most 2D+1, and consequent integer minimum at least 2D+2. The polynomial identity and degree convention are stated locally; no private definition of certificate degree is required.

The public source-definition and proof body, from the complete axiom table through the functional, degree argument, nonvacuity, transfers and comparison limitations, is the frozen source body with only line-ending/outer-whitespace normalization. I checked this equality in addition to reading it. The changed import paragraph links the complete in-repository FULL-NOTE theorem and names its full v2 commit. It retains the boundary-prefix and arbitrary-polynomial square requirements. Removing internal review history creates no missing mathematical premise.

The table lists every output, base, and six summation falsification polynomials from source Definition 6.1, plus Boolean and optional twin equations. The summation polynomials encode the F_2 parity gate through real clauses rather than the incorrect real equation b-a-xy=0. The augmented matrix, free typed labels, fixed all-ones boundary and k mod 2 corner are explicit. The surviving boundary prefixes are retained. Nonempty one/two-label local laws eliminate any possibility of a surviving nonzero constant clause. Full-rank conditions are explicitly properties of sampling supports, not extra axioms furnished to the proof system.

The source's local nonemptiness/consistency imports are credited to Definitions 6.5--6.6, equation (36), Lemma 6.7 and the normalization in Lemma 6.4. I directly read those primary clauses and definitions in the underlying S3101 audit; the extraction makes no change to their contract. The public source definition, local satisfaction argument and full proof are sufficient with that primary reference and the preserved FULL-NOTE. Internal development and review files supply provenance, not missing proof steps.

## Degree audit and both transfers

The manuscript keeps degree additivity in the ordinary real polynomial ring before Boolean reduction. For a nonzero original clause f of positive degree r and raw product degree at most 2D+1, every multiplier monomial after complement substitution has degree at most 2D+1-r. Substitution cannot increase degree or labels; it need not preserve f's degree to retain this original bound. The whole clause uses at most two labels, so its union with one multiplier monomial has size at most 2+2(2D+1-r)<=4D+2<=n-2. The displayed n/80+2 bound verifies the last inequality uniformly. The argument handles complete clause polynomials in one law, not separately chosen inconsistent contexts for their terms.

Local satisfaction and consistency annihilate those products. Boolean multiples vanish in the quotient; twin linear equations vanish under complement substitution and twin Boolean equations become ordinary Boolean equations. The quotient interpretation of Boolean reduction preserves the identity and squares. Raw degree at most 2D+1 gives square-root degree floor((2D+1)/2)=D; their actual reduced X/Y/U squares are within the imported PSD window, with at most 4D labels per monomial. Thus every term to which R is applied is within its row-domain. R(1)=1 yields the contradiction. Both the odd-degree exclusion and minimum 2D+2 survive extraction exactly.

Nonvacuity is proved from the interior gates forcing XY=I_m over F_2, impossible because rank(XY)<=n<m. Boolean equations exclude additional non-Boolean real solutions. This is an infinite contradictory family, not a conditional claim about whether a particular instance is unsatisfiable.

The unaugmented simple family transfers by literal inclusion of all its axioms and variables in the restricted system: its certificate would remain a certificate in the larger ring. The augmented m+1 family with tilde(A) transfers by sigma restriction of its entire certificate, preserving squares and not increasing raw degree. These are the correct directions. The m+1 family retains the original parameter m=n^2 rather than asserting m+1=n^2. No z-extended or matching-extension encoding is implicitly substituted.

## Mathematical metadata and final scope

README and CFF state the same excluded raw degree 2D+1, with D explicitly defined and minimum 2D+2 in README. SOURCES distinguishes the standard positive-functional implication from a new lower-bound mechanism and does not import the source's separate SA size or PMRank size result into this encoding. Historical v1/v2 nonclaims are expressly historical; the new degree claim is confined to COROLLARY and current metadata. The preserved PSD proof's old absence of an adopted degree claim is not misrepresented as denying this later separately reviewed consequence.

REVIEW accurately pins the corollary source and its underlying reviews. At inspection it leaves the new actual-extraction review dispositions for subsequent insertion. That status-only integration is separate from these hashed files; no theorem change is approved automatically. The final source/nonclaims/publication lens remains separate.

Final mathematical/extraction decision: PASS for the exact stated ordinary-degree lower bound and both explicit simple-encoding transfers under the preserved PSD theorem. No size bound, efficient solver, general runtime or proof-system lower bound, complexity-class consequence, novelty certification, Lean verification or human peer review is certified. No public artifact was edited, and no commit, push, release, publication, experiment, outreach or paid computation was performed by this review.
