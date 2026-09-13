# Independent finite matrix-lift manuscript integration review

2026-09-13. S3128/S3134/S3137. Verdict: bounded GO-WITH-NOTES for the exact source candidate below after a README encoding correction. No full analytic, Lean, PDF, publication or theorem acceptance is implied.

## Identity and scope

Paper repository: C:/Users/Dan/Desktop/Projects/realizable-cmmsa-hardness. Baseline source HEAD ced4dd8e75e731131a01f4774470d2e5848ba882. I independently read the entire finite-lemma insertion and scoped canonical/README diff and compared the insertion with the matrix-lift audit SHA394f778eb358d9dbbec0172de34c38872b9ecafe484855e29cf268a014c45474 and my independent review SHA37f9035bdd581306fdb75c7d9529aa4a31aff42c091329f3311df424cc255cfc (root identified their frozen record as 8e69918). I did not author the manuscript insertion or edit its files. My earlier review authorship and mathematical contribution are disclosed; this is independent integration review, not independent discovery or human peer review.

| File | Final raw SHA256 |
|---|---|
| paper/submission-manuscript.md | 46607e514850410e76e3da7155936569719a52ff2a7b4773d9d6e840ee7c7aa4 |
| paper/body.tex | 284e44a5c1193f9e964d1396dddb0ee30a3e150dd4384c40cedb6f00ea99482b |
| paper/correspondence.json | 475687b4b3a732216b24c716589978c9a6a024cf68f269fe1e71f97b326c5fd7 |
| paper/README.md | 01554530413221c71903746fe7e399029a655157f5cd39ad5e2e2cef29acfb69 |

Independently verified all candidate hashes, 1233 canonical lines, all 129 correspondence span hashes, and all three fenced LaTeX blocks appearing verbatim once in generated body. The 30 legacy numbered displays remain. Renderer bytes equal HEAD. Inverse arithmetic starting with its Require h>=r sentence and the entire subsequent robust proof/downstream manuscript are byte-identical as normalized source text to baseline. Whitespace check passes. No renderer, PDF or Lean compiler was executed here.

## Mathematical correspondence

The finite lemma states n>=d, 0<=r<d, nonnegative e, indicator g with exact-r nonempty Grassmann zoom bounds, and the actual zero-on-rank-deficiency matrix lift. Its restricted conclusion quantifies arbitrary nonempty affine systems MU=V, XM=Y with nominal column-plus-row budget r. This matches source Definitions2.2-2.4's stated number-of-equations convention; it is not an undocumented change to ordinary affine codimension or rank-only constraints.

The proof includes all necessary branches: inconsistency, redundant equations, and independent domain vectors with dependent prescribed images. The nonzero branch has a+b<=r and k=d-a, hence b<k. Affine row reduction retains actual conditional laws. The reduced X1 map on ker X0 is surjective, so targets have equal fibers. The GL(k,2) action transports all full-row-rank targets while preserving the lift through a domain basis change. Consequently the only loss is reciprocal pi(c,k)<2, with the empty-product c=0 case explicit.

The homogeneous counting uses W=Q+H, not a falsely assumed direct sum. The map L intersect H onto L/Q has fixed kernel Q intersect H, giving exactly |GL(k,2)|2^(zk) free-column tuples per eligible image L. Full-rank conditioning therefore has a uniform image law, while zero-on-deficiency multiplies by the full-rank probability rather than dividing by it. No second rank-loss factor or ambient-n threshold is introduced.

Finally, exact-r pseudorandomness extends to the produced smaller-budget zoom by the explicit Q' incidence averaging proof. The range dim Q<=r-codim W<d ensures the refinement exists on every nonempty zoom. Constant flag fiber counts justify the uniform L marginal. The resulting expectation bound is precisely 2e; Booleanity gives the restricted squared-L2 formulation.

The inverse proof now invokes this proved finite lemma in place of imported MZ4.5. Its existing h>=r>0 and ambient bounds establish r<d=2h and n>=d. MZ4.6 and4.7 and their global-hypercontractive/spectral ancestry remain explicitly imported. The proof has narrowed one external dependency by supplying its finite argument; it has not declared the other foundations accepted. No inverse exponent, robust8S threshold, later counting factor or A-before-h parameter is altered.

Local notation is explicit: E,D denote the finite lemma's vector spaces; B is reintroduced for the residual affine target after a basis-invariance observation, and B0 is an invertible target-action matrix. Q,H,W,z,c,k are proof-local and do not change later inverse or posterior variables. This reuse creates no missing assumption or mathematical ambiguity.

## Correction and residual work

The initial candidate README SHA660367e4bb3721588820148df9240dc23ae181324f32deba877f8cc3457a0a9c had double-encoded leading BOM text. I and root independently identified it. Under root's explicit instruction, the author replaced only the first line with plain ASCII '# Submission paper build' and reported preserving the remaining bytes. I verified the final header and hash; all three mathematical/generated file hashes remain unchanged. This was metadata repair, not a proof change.

No blocking integration defect remains. The README correctly marks the existing 17-page PDF as stale. Source freeze, a newly authorized PDF build/all-page review, complete Lean formalization, remaining analytic foundations and any public release remain separate. This report itself made no paper edits, compiler/Git mutations, or public actions.
