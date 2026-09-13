# Independent finite-spectral manuscript integration review

2026-09-13. S3128/S3134/S3137. Bounded GO-WITH-NOTES for the exact candidate below. This is source integration and finite mathematical correspondence review, not complete analytic, Lean, PDF, theorem, or publication acceptance.

Paper repository: C:/Users/Dan/Desktop/Projects/realizable-cmmsa-hardness. Baseline HEAD ad5bfc5973bfa335bcf6b67bb91d2163b5cbb69e. Reference derivation: spectral finite-character audit SHA71236ea09afd39085f59032938610a1193fc59210e60662f79dc7bbfce2b174b and independent spectral review SHAcb1df6d2564fbe1506b4d33280170df34984e07d9a3b83ccbad9c446e61a8443. I authored that independent review and contributed to the preceding dependency challenge, but did not author this insertion or renderer. No paper edits, compiler, Git mutations or public actions were performed here.

| File | Raw SHA256 |
|---|---|
| paper/submission-manuscript.md | b34e466e110ffe2d6b46cc802130cef7e07c0f588df1f0b2c4c444ce3696cc48 |
| paper/body.tex | 6b159e36aa554bc7442ebb0b75e00f7c58e330ebecef2612bd167f19fd2b04e4 |
| paper/correspondence.json | ce4eb22739fe2500f6bf8b0424c7d01e257727ceb4a37ffaa63771cdba87b55b |
| paper/README.md | c64d396f3f7643c16e69202fcf72f86cb26bd420a9b9bc0fdee7af5156160a6f |

I read the complete new finite-spectral lemma/proof and scoped canonical/README diff. Independently rehashed all four files, verified all 129 correspondence span hashes and all three canonical fenced LaTeX blocks occur verbatim once in body.tex. The renderer is unchanged; 30 numbered displays remain. Source has 1338 lines. Exact complement and matrix-lift proofs are unchanged, and inverse arithmetic from its Require h>=r sentence through the entire remaining manuscript is byte-equal as normalized text to baseline. Exact four-path diff and whitespace check pass. README retains its corrected plain ASCII header and marks the 17-page PDF stale.

## Mathematical fidelity

The statement explicitly defines T by appending unrestricted columns, G by uniformly averaging full-column-rank injections, and Phi using independent B,C with B unrestricted and only C conditioned on full row rank. It assumes right-GL basis invariance on all matrices, including deficient ones. These are the source laws checked in the reference spectral review; no different noise sampler is introduced.

The restricted adjoint proof uses invariance of the first argument and constant GL completion fibers. It explicitly distinguishes G from the ordinary adjoint on arbitrary functions, and imposes no unnecessary invariance on the second argument. The GTF=PhiF proof retains the uniform-completion argument and independence of translated W from the selected C. Empty s=0 and c=0 cases are included with their finite-matrix conventions.

The character argument averages B first, obtaining lambda_S=Pr_C[SC^T=0]. Thus positivity is established directly. The rank-i kernel count is the exact ordered-independent-tuple ratio, zero when s>d-i and otherwise the product of (2^(d-i)-2^j)/(2^d-2^j). Its factors give lambda_i<=2^(-is). The proof does not assume individual characters are basis invariant: it transports their indices under the GL action to obtain invariance of rank projections of an invariant F.

The inner-product calculation <TF_i,TF_j>=<F_i,PhiF_j>=lambda_j<F_i,F_j> correctly yields cross-level orthogonality and the squared-norm identity. Lambda is real and nonnegative, so the manuscript's complex-inner-product convention causes no conjugation error. The unsquared contraction is explicitly the square root, preventing confusion between T and Phi eigenvalues.

The stronger exact calculation is used only to imply the EXISTING weaker bound 2^(-i(s-1))+3*2^(i-n). The inverse still retains its prior conservative rank/spectral ambient conditions, high-degree estimate, Markov cutoff, moment constants and gluing/error budgets; no reoptimization occurs. This matches the requested scope.

## Dependency boundary and disposition

The inverse now invokes the finite-spectral lemma for the former MZ4.7 bound and cross-level orthogonality. Together with the preceding finite matrix-lift lemma, those two finite bridges are proved locally in the manuscript. Global hypercontractivity/Theorem4.6 and its ancestry remain explicitly imported. No statement upgrades the outer PCP, learning, or all other foundations to local proof status.

No blocking mathematical/transcription discrepancy was found. The README accurately describes the added finite proof and remaining import. A new PDF build and all-page visual inspection remain necessary after source freeze; the old PDF does not display this insertion. Full Lean formalization and final publication decisions remain separate. This review is not a novelty claim or a certification of the full hardness theorem.
