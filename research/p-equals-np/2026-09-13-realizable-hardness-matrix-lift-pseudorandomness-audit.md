# Matrix-lift pseudorandomness: exact finite counting audit

2026-09-13. S3134/S3137. Author: occurrence_gadget_author. Bounded foundational dependency audit for the repaired inverse derivation frozen7cf271d. No Lean/compiler, paper edit, source module expansion, Git, or public action. Prior lower Lean authorship is disclosed and supplies no acceptance of this analytic argument.

**Conclusion:** for n>=d=2h and 0<=r<d, the actual zero-on-rank-deficiency lift of a Grassmann (r,e)-pseudorandom indicator is basis invariant and matrix (r,2e)-pseudorandom. The factor is uniform in n; no additional large-n rank-error estimate is needed. The strict budget condition r<2h is explicitly present in source A.17 and must be carried into A.18/4.5 rather than silently omitted. The repaired inverse regime h>=r (with r>0) satisfies it. Exact counting below proves the required bridge, subject only to elementary finite linear algebra, and clarifies source notation shortcuts.

## Exact evidence

- Preserved MZ arXiv:2510.23991v1, `C:/Users/Dan/AppData/Local/Temp/s3123-mz2510.23991.pdf.txt`, SHA256 e8cb21fb8279f7881a5cf5c53b87b09b215f0bb3c8466b8fbdfcd4517ee5fbce. Definitions2.1-2.4 (Grassmann and matrix restrictions, pp.6-7), the rank-deficient lift in section4.2, Lemma4.5 p.16, citing MZ24 A.18.
- Preserved MZ24 `s3123-mz24.pdf.txt`, SHA2567457efd82898b827e2bb88a8d1a10d5a37b7888ebf31106813f44a8a805647c4 (361873 bytes); PDF `s3123-mz24.pdf`, SHA25692ee5ae3d9ccdca2ec365f92693c068a9af08dde09800859d01c81fdb06e9485. Its own header identifies arXiv:2404.07441v1, 11 Apr2024. This audit does not relabel that preserved file as v4. A.17 pp.66-68 and A.18 pp.68-69 contain the relevant reduction and counting. LF-delimited extracted text locations are3741-3755 (lift),3761-3774 (A.17 statement),3779-3873 (proof),3877-3933 (A.18).
- Cross-read the corresponding A.17/A.18 in preserved ECCC Revision1 of Report27(2024), `s3124-mz24-r1.txt`, SHA256d7dff096e13c2b3c46a0a708d4fb4b6c1481ce0bfe0c323733241094f3fc33d7; PDF SHA25613b8eb55f86cfe28ac8b283fe83612889b335e14b7a87d64d479451693c7dff4. That revision uses a set L and its lift F instead of the earlier F/F-prime notation; the needed argument is the same. No version-mixed stronger result is invoked.
- Prior repaired inverse audit/review: formal-pvnp freeze7cf271d0241b774640417e285363b6bcb34014f9. This note audits only its use of the4.5 bridge, not4.6 hypercontractivity,4.7 spectral identities, or the complete inverse/paper theorem.

## Definitions and orientation

Let E=F_2^n, D=F_2^d, n>=d, and let g:Grass(E,d)->{0,1}. For every Q<=W<=E with dim Q+codim_E W=r, assume the uniform density of g in the nonempty set {L:dim L=d,Q<=L<=W} is at most e. This is actual MZ Definition2.1, with dimension of the zoom-in Q and codimension of the containing W.

Define the matrix lift G(M)=g(im M) when rank M=d, and G(M)=0 otherwise, for M:D->E. For A in GL(D), im(MA)=im M and rank(MA)=rank M, hence G(MA)=G(M) exactly.

A matrix restriction is the uniform distribution on

    Z(U,V,X,Y)={M : MU=V and XM=Y},

where U has a0 columns and X has b0 rows, with nominal budget a0+b0=r. This budget counts vector equations, not the ordinary affine-space codimension a0*n+b0*d minus overlap. This is Definitions2.2-2.4. The squared restricted L2 norm of the Boolean G is its expectation. Only nonempty restrictions require a conditional distribution; one may equivalently assign empty restrictions expectation zero in a total finite formulation.

We will show E[G | Z]<=2e for every such nonempty restriction. No independent row/column-rank assumptions are silently added to the input.

## 1. Reduce redundant constraints and zero cases

Use invertible column operations on the U,V pair to isolate a basis of the columns of U. Consistency forces every discarded column relation to hold identically for V; otherwise Z is empty. Let a=rank U<=a0 after deletion. If the corresponding prescribed columns V are linearly dependent, any satisfying M has a nonzero vector in its kernel, hence G is identically zero. Thus the only nontrivial case has a independent domain vectors mapped to a independent vectors v1,...,va of E.

Similarly row-reduce X,Y together, discard redundant zero equations, or take the empty branch if a zero left side has nonzero right side. Let b=rank X<=b0. Choose domain coordinates with the constrained U vectors first. Basis invariance of G preserves its value under that change of coordinates. The first a columns of M are fixed to V; their row equations must agree with XV. All remaining constraints have the form

    M=[V,N],  N in E^k,  XN=B,  k=d-a,

where X has b independent rows and B is b-by-k. We retain a+b<=r<d, in particular b<k. All these operations are bijections or deletions of redundant equations and therefore preserve the actual uniform conditional laws.

## 2. Homogenize the remaining affine row target

Row-reduce X,B together so B has c=rank B independent rows B1 followed by zero rows. Write X=(X1;X0), where X1 has c rows and X0 has b-c rows; all b rows jointly remain independent. Put H0=ker X0.

The restriction of X1 to H0 is onto F_2^c. For a uniform N with columns in H0, X1*N is therefore a uniform c-by-k matrix. Each target B1 has exactly the same number of preimages. Let A be the event rank(X1*N)=c. Its exact probability is

    pi(c,k)=product_(i=0,...,c-1) (1-2^(i-k)),

with pi(0,k)=1. Because c<=b<k,

    pi(c,k) >= 1-sum_(i=0,...,c-1)2^(i-k)
             =1-2^(-k)(2^c-1)>1/2.

This rank probability concerns c-by-k matrices, where c,k are controlled by r,d. It does not involve ambient n.

For any two full-row-rank targets B1 and B2, some A0 in GL(k,2) sends B1*A0=B2. The map N->N*A0 preserves the homogeneous equation X0*N=0 and sends the affine target to the other target bijectively. Also

    G([V,N*A0])=G([V,N]),

by right multiplication with diag(I_a,A0). Thus the conditional expectation of G given each full-row-rank target is identical. Since the target distribution conditioned on A is uniform among those targets,

    E[G([V,N]) | X1*N=B1, X0*N=0]
      = E[G([V,N]) | A, X0*N=0]
      <= pi(c,k)^(-1) E[G([V,N]) | X0*N=0]
      <= 2 E[G([V,N]) | X0*N=0].

This is the exact source of the factor2. If c=0 there is no factor loss. It is not a full-n-by-d rank approximation and does not conceal a threshold growing with n.

## 3. Count the homogeneous full-rank fibers

Put Q=span(v1,...,va), H=ker X0, W=Q+H, z=dim(Q intersect H), and k=d-a. The plus sign is ordinary subspace sum. Q need not be disjoint from H. Its dimension budget is

    dim Q+codim W <= a+codim H=a+b-c<=r.

If there is no d-dimensional L between Q and W, [V,N] cannot have rank d and the lift expectation is zero. Otherwise consider any L in this Grassmann zoom. Since L contains Q and lies in Q+H, the map

    L intersect H -> L/Q

is onto and has kernel Q intersect H. Both statements follow by expressing each vector of L as q+h; then h is also in L. The quotient has dimension k. The k free columns N in H yield im[V,N]=L with rank d exactly when their images in L/Q are an ordered basis. There are |GL(k,2)| ordered bases, each vector having 2^z lifts in L intersect H. Consequently the exact fiber size for every such L is

    |GL(k,2)| * 2^(z*k).

It is independent of L. Thus conditioning the homogeneous N on rank[V,N]=d induces precisely the uniform law on Zoom[Q,W]. As G vanishes outside that full-rank event,

    E_hom[G] = Pr_hom[rank[V,N]=d] * E_(L uniform Zoom[Q,W])[g(L)]
             <= E_(L uniform Zoom[Q,W])[g(L)].

There is no division by the full-rank probability and no additional rank-error factor. This remains valid when the full-rank probability is tiny; if it is zero we already took the zero branch.

## 4. Convert the smaller budget to the actual exact-r definition

Source A.18 uses dim Q+codim W<=r, whereas Definition2.1 states equality. The required monotonicity has an exact finite incidence proof here. Write w=codim W and choose a'=r-w. Since dim Q+w<=r and r<d, we have dim Q<=a'<d. Average uniformly over a'-spaces Q' with Q<=Q'<=W, then over d-spaces L with Q'<=L<=W. Every Q' has the same number of such L, and every L containing Q contains the same Gaussian-binomial number of intermediate Q'. Hence the marginal L is uniform on Zoom[Q,W]. Each finer zoom has dim Q'+codim W=r, so its density is <=e. Averaging proves density<=e on the original smaller-budget zoom.

Combining this with steps2-3 gives the exact desired restricted bound E_Z[G]<=2e. Basis invariance was already proved. Thus the claimed matrix pseudorandomness bridge holds uniformly for all n>=d and r<d, with arbitrary actual consistent affine restrictions, not just coordinate or homogeneous ones.

## Source shortcuts and sufficient assumptions

A.17 explicitly requires budget<2h. A.18 calls it without restating that hypothesis. The present large-h inverse application meets it, but an eventual Lean statement must expose it. At c=k a square binary random matrix can have full-rank probability below1/2, so this particular factor2 argument cannot be extended to r>=d merely by omitting the assumption; no claim is made here that the general conclusion at that boundary is false.

Source notation Q direct-sum H is not justified for arbitrary row restrictions and fixed columns. Ordinary Q+H, with the intersection z retained in the fiber count, proves exactly the required conclusion. Likewise row elimination may replace rows by linear combinations; one should state the reduced row space has dimension at most b, rather than require the reduced equations to be a literal subset of the original rows. The proof's affine-target/full-row-rank-event conditional displays contain notation shortcuts; the equal-target orbit argument above specifies the exact conditional distributions. None changes the desired factor2 in the valid regime.

The useful eventual finite theorem has assumptions n>=d, r<d, indicator-valued g, actual exact-r Grassmann density bounds, and arbitrary nonempty affine restriction with nominal a0+b0=r. Its conclusion is basis invariance plus restricted Boolean expectation<=2e. Empty restrictions, dependent U/V, redundant rows and impossible full-rank domains have explicit zero branches. No separate n-dependent condition, assumed matrix rank law, arbitrary desired lift certificate, or full-rank input promise is required.

This resolves the inspected4.5/A.18 import for the repaired inverse parameter regime at the finite-counting level. It is not a global hypercontractivity proof, a spectral theorem audit, a completed Lean proof, an upstream PCP-hardness proof, or certification/publication of the entire paper.
