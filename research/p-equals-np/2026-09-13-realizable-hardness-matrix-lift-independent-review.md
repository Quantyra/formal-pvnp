# Independent matrix-lift finite-bridge review

2026-09-13. S3132/S3134/S3137. Bounded GO for the informal finite-counting bridge in occurrence's exact audit `2026-09-13-realizable-hardness-matrix-lift-pseudorandomness-audit.md`, raw SHA256 `394f778eb358d9dbbec0172de34c38872b9ecafe484855e29cf268a014c45474`. I read the full note and independently checked the affine sampling and counting. I did not author that note. Prior authorship of inverse reviews and lower Lean modules is disclosed; it supplies no kernel acceptance. No paper/Lean/compiler/Git/public actions occurred.

## Actual source budget

I read preserved MZv1 Definitions2.2-2.4, Lemma4.5, and preserved MZ24 A.17/A.18. The v1 Definition2.4 passage explicitly defines restriction codimension as the NUMBER of columns of U plus the NUMBER of rows of X, denoting those numbers dim(U) and codim(X). It is not affine-space codimension, nor does that notation silently assert independent constraints. Thus the audited nominal budget a0+b0=r exactly covers the source definition. Reducing redundant consistent equations gives ranks a<=a0 and b<=b0, with a+b<=r; it does not require replacing the source definition by a rank-based one.

Primary preserved text identities are MZv1 `s3123-mz2510.23991.pdf.txt`, SHA256 e8cb21fb8279f7881a5cf5c53b87b09b215f0bb3c8466b8fbdfcd4517ee5fbce, Definitions2.2-2.4 printed pp.6-7, and MZ24 `s3123-mz24.pdf.txt`, SHA256 7457efd82898b827e2bb88a8d1a10d5a37b7888ebf31106813f44a8a805647c4, A.17/A.18 pp.66-69. The latter is the preserved arXiv v1 file, not a silently relabeled later revision. Occurrence's separate revision cross-read is disclosed in its note; this review's direct source check uses these two files.

## Independent checks

1. Redundant equations are discarded only after consistency is checked. If independent constrained domain vectors have dependent images, every solution matrix has deficient rank and the zero-on-deficiency lift is identically zero. In the other branch an invertible domain coordinate change fixes a independent columns V, leaving k=d-a free columns N with XN=B. This bijection preserves uniform finite conditional distributions and basis-invariant lift values. Row operations are applied to both X and B; they need not retain a literal subset of original rows.

2. After reducing B to c independent rows and zero rows, X1 restricted to H0=ker X0 is surjective because the combined X rows are independent. Therefore each c-by-k target has equal fiber size, and the induced target is uniform. Right multiplication by GL(k,2) is transitive on full-row-rank targets, preserves X0N=0, and fixes G([V,N]) by diag(I_a,A0). This establishes equality of the affine-target expectation and the expectation conditioned on full row rank of X1N. No invariance of g under ambient transformations is assumed; only im(MA)=im(M) is used.

3. The sole loss is reciprocal pi(c,k), where pi(c,k)=product_(i<c)(1-2^(i-k)). Because c<=b<k from a+b<=r<d, pi(c,k)>=1-(2^c-1)/2^k>1/2. The case c=0 has pi=1. This probability concerns the small row-target matrix and has no ambient-n dependence.

4. In the homogeneous experiment put Q=span V, H=ker X0, W=Q+H and z=dim(Q intersect H). Ordinary subspace sum is essential; there is no reason Q and H must be disjoint. For each d-space L between Q and W, L intersect H maps onto L/Q with kernel Q intersect H. Every ordered basis of the k-dimensional quotient has exactly 2^(zk) choices of lifts in H. Thus the number of free-column tuples yielding that L is exactly |GL(k,2)|2^(zk), independent of L. Uniformity of the full-rank span law follows without any arbitrary ambient orbit assumption.

5. The lift is zero off full column rank. Consequently its homogeneous expectation is the full-rank probability TIMES the uniform zoom density, not the zoom density divided by that probability. There is no second factor two or large-n conditioning error. If full rank is impossible the expectation is zero; tiny positive full-rank probability causes no problem.

6. The produced zoom has dim Q+codim W<=r. Set w=codim W and a'=r-w. Then dim Q<=a'<d, and a'<=dim W because the zoom contains a d-space. The finite incidence experiment Q' uniform among a'-spaces between Q and W, followed by L uniform among d-spaces between Q' and W, has uniform L marginal: both relevant flag fiber counts are constant. Exact-r pseudorandomness applies to each Q',W and averages to the required smaller-budget bound. This is a proof of the needed monotonicity rather than an assumed extension of Definition2.1.

Together these facts give E[G|MU=V,XM=Y]<=2e for every nonempty source restriction with nominal budget r. Booleanity identifies this expectation with the squared restricted L2 norm. Basis invariance follows directly from the definition of G. Empty restrictions may be omitted or assigned zero by an explicit total convention; no nonexistent conditional probability is used.

## Standalone lemma and limits

This supports replacing the imported MZ4.5 bridge in the manuscript's inverse derivation with a standalone finite lemma and the complete argument above. State n>=d, 0<=r<d, indicator-valued g with actual exact-r Grassmann density bounds, and its actual zero-on-rank-deficiency matrix lift. The conclusion is basis invariance and matrix (r,2e)-pseudorandomness under the actual affine restrictions. No caller-supplied lift certificate, homogeneous-input promise, rank assumption on sampled matrices, or ambient threshold is needed.

The strict r<d condition is explicit in A.17 and must not disappear through the A.18 citation. The current inverse application has r>0, h>=r and d=2h, so it satisfies r<d. At r>=d this particular row-rank probability argument cannot justify the same factor two; no statement of theorem falsity at that boundary is inferred.

No defect was found in the exact audited bridge. This is an informal finite-linear-algebra proof review, not a Lean build or kernel theorem. Global hypercontractivity (4.6), the remaining spectral/operator foundation (4.7), the other paper imports, full hardness, and publication readiness remain outside this acceptance. Any manuscript insertion should retain these boundaries and receive its own transcription review.
