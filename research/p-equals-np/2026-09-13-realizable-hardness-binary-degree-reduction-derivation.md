# Binary degree reduction: convolution classes with explicit constants

2026-09-13. S3137. Source-only derivation by incidence_complexity_review. No Lean/compiler, paper edit, Git or public action. This is a candidate for independent review, not full Theorem58 or paper acceptance.

Primary source: Ellis, Kindler and Lifshitz, arXiv:2209.04243v1, https://arxiv.org/abs/2209.04243v1. Preserved `C:/Users/Dan/AppData/Local/Temp/s3134-ellis2209.04243v1.pdf` SHA256 `4455f4a757b2abc1b7a3dd41f3495b68bf2e2b9aa4d05a5b0953fe4e751a991f`; same-stem `.txt` SHA256 `9259246e882f05e02fb8585400fed15b6a1d9e68106cbcd813c8851ecfdc468a`. Sections5.1-5.3, Lemmas46-50, printed pp.27-31; text lines1564-1960. Definitions27 and30 supply the ordinary Laplacians and rank-additive order. Satellite README and prior core/counting context were read; no applicable local AGENTS file was found.

## Exact result proved here

Let V,W be finite binary vector spaces and f:Hom(V,W)->C have Fourier rank degree at most d. Use normalized uniform norms and the trace characters indexed by X:W->V. Define P_{A,B}=L_A composed with L^B: its Fourier filter keeps A<=im X and ker X<=B. This is the ordinary composed filter, NOT the stronger hybrid filter X^{-1}(A)<=B. With i=dim A and j=codim B, this note derives

    (1/162)||f||_4^4 <= 2^(6d^2)||f||_2^4
               + sum_{(i,j)!=(0,0)} sum_{A in V_i,B in W_j}
                                  2^(7d(i+j)) ||P_{A,B}f||_4^4.       (DR6)

The source's displayed Lemma46 has 3d^2 in its first exponent. Its Lemma48 and displayed proof yield 6d^2, and the later Lemma57/Theorem58 induction uses 6d^2. This note proves DR6, not the stronger printed 3d^2 statement. The fourth power of the L2 norm is essential. The source sometimes abbreviates or misprints it as a square in prose.

## Convolution partition, including complex coefficients

Put a_X=fhat(X), and b_X=|a_X|. Fourier orthogonality gives

    ||f||_4^4 = ||f^2||_2^2
              = sum_X |sum_{Y+Z=X} a_Y a_Z|^2.

This is valid for complex f because |f^2|^2=|f|^4. All nonzero products have rank Y,rank Z<=d and therefore rank X<=2d.

Write M=A directplus C when M=A+C and rank M=rank A+rank C. Let F1(X) comprise pairs Y+Z=X admitting Y=A directplus C, Z=B directplus C, X=A directplus B. Over F2 this is exactly the source definition using A<=Y, B<=Z, A directplus B=X: the common residual is C=Y+A=Z+B. Let F2(X) comprise pairs for which im X intersect im Y intersect im Z is nonzero, or ker X+ker Y+ker Z is not W.

Every pair belongs to F1 or F2. Here is a direct proof of the only nontrivial case. Suppose the triple image intersection is zero and the sum of the three kernels is W. Write K_M=ker M. Then

    (K_Z+K_X) intersect K_Y = K_Z intersect K_Y.

Indeed, w=u+v with u in K_X,v in K_Z,w in K_Y has Zu=Yu=Yv=Xw in the triple image intersection, hence Zu=0 and w in K_Z. Thus define B to equal Z on K_Y and zero on K_Z+K_X; this is well-defined on W. Symmetrically define A to equal Y on K_Z and zero on K_Y+K_X. Checking on these three kernels gives X=A+B. Set C=Y+A=Z+B. The images of A, B and C lie respectively in im Y intersect im X, im Z intersect im X, and im Y intersect im Z. Their pairwise intersections are zero by hypothesis. To check that the corresponding image sums are equalities, on K_Z the triple (A,B,C) is (Y,0,0); on K_Y it is (0,Z,0); and on K_X it is (0,0,Y). Since W=K_Z+K_Y+K_X, im Y=Y(K_Z)+Y(K_X)=im A+im C, im Z=im B+im C, and im X=im A+im B. Thus these are direct sums and rank additivity follows: Y=A directplus C, Z=B directplus C and X=A directplus B. This proves the cover.

The classes may overlap, so do not add their signed sums as an identity. Instead set

    H_X = sum_{(Y,Z) in F1(X)} b_Y b_Z,
    O_X = sum_{(Y,Z) in F2(X)} a_Y a_Z.

Partition into F2 and its complement; the latter is contained in F1. Hence the convolution has absolute value at most H_X+|O_X| and its squared norm is at most 2 sum H_X^2+2 sum |O_X|^2. Only the first class is majorized by absolute Fourier coefficients. The overlap class below retains the original signed/complex coefficients and their cancellations.

## First class: actual Boolean encoding and a proved moment bound

For rank-r M, every direct decomposition M=A directplus C is determined by A as a map W/ker M -> im M. To verify this factorization, rank additivity forces im A and im C to be disjoint and their sum to be im M; if Mw=0 then Aw=Cw=0. There are at most 2^(r^2) such maps A. In particular no ambient dimension enters the decomposition count.

Let B_d be all maps W->V of rank at most d, including zero. On the independent uniform sign coordinates (x_A,y_C) indexed by two disjoint copies of B_d define the real polynomial

    F(x,y) = sum_{A,C in B_d: A directplus C exists}
                         b_{A+C} x_A y_C.

Terms with rank(A+C)>d have zero coefficient. The two copies are disjoint even for A=C=0, so every monomial has Boolean degree exactly two; there is no mistaken identification of the zero map with a constant variable. Distinct ordered pairs give distinct monomials. Thus

    ||F||_2^2 = sum_M b_M^2 N(M) <= 2^(d^2)||f||_2^2.

For completeness the needed Boolean fourth-moment inequality follows by induction on the number of sign variables, without importing hypercontractivity. If G=g+xh is real, let alpha=||g||_4,beta=||h||_4. Expansion and Cauchy-Schwarz give

    ||G||_4^4 <= alpha^4+6alpha^2 beta^2+beta^4
              <= (alpha^2+3beta^2)^2.

Starting with constants, induction proves ||G||_4^2<=sum_S 3^|S| Ghat(S)^2. For degree at most two this yields ||F||_4^4<=81||F||_2^4.

For a direct pair A,B put

    h(A,B)=sum_C b_{A+C} b_{B+C},

where both A+C and B+C are direct and have rank at most d. Every pair counted by H_X has at least one such triple, so H_X<=sum_{A directplus B=X}h(A,B). There are at most 2^(rank(X)^2)<=2^(4d^2) ordered decompositions of X. Cauchy-Schwarz then gives

    sum_X H_X^2 <= 2^(4d^2) sum_{A,B: A directplus B} h(A,B)^2.

The last sum is at most ||F^2||_2^2. This requires care about cube monomial collisions: when A!=B, the coefficient of x_A x_B in F^2 is 2h(A,B), while the two ordered pairs contribute 2h(A,B)^2. Each unordered pair labels one character and determines X=A+B. If A=B and the sum is direct, A=B=0. The corresponding h(0,0) is bounded by the constant coefficient of F^2, which sums all squared coefficients of F. All coefficients involved are nonnegative. Thus distinct labels and the single empty-character case give the asserted inequality, rather than assuming ordered pairs index distinct cube characters.

It follows that

    sum_X H_X^2 <= 2^(4d^2)||F||_4^4
                <=81*2^(6d^2)||f||_2^4.                       (F1)

This discharges the substantive first class with actual normalization, arbitrary complex input, and a self-contained real Boolean moment argument.

## Overlap class: exact incidence inversion and weighted counting

The following also discharges the second class, preserving cancellations. For k>=1 define

    alpha_k=(-1)^(k+1) 2^(k(k-1)/2).

For any t-dimensional binary space,

    1_{t>0}=sum_{k=1}^t [t choose k]_2 alpha_k.              (I)

One elementary proof is the finite product identity

    product_{l=0}^{t-1}(1+2^l z)
      =sum_k [t choose k]_2 2^(k(k-1)/2) z^k.

Induct on t using the Gaussian recurrence [t k]_2=[t-1 k]_2+2^(t-k)[t-1 k-1]_2. This recurrence follows by intersecting k-subspaces with a fixed hyperplane: those inside it contribute the first term; each (k-1)-subspace inside it has 2^(t-k) extensions not inside it. Substitute z=-1, keeping the empty product at t=0. This proves (I), including the zero-space case.

Fix X and a convolution pair Y,Z. Put U=im X intersect im Y intersect im Z and K=ker X+ker Y+ker Z. Apply (I) to U and to W/K. Inclusion-exclusion for U!=0 or K!=W gives the exact coefficients

    alpha_{i,0}=alpha_i, alpha_{0,j}=alpha_j,
    alpha_{i,j}=-alpha_i alpha_j (i,j>=1), alpha_{0,0}=0.

Therefore, as a complex-number equality,

    O_X=sum_{(i,j)!=(0,0)} sum_{A<=im X,dim A=i;
                                B>=ker X,codim B=j}
                         alpha_{i,j} ((P_{A,B}f)^2)hat(X).    (O)

All terms with i>d or j>d vanish because P_{A,B}f has no surviving frequency. The square Fourier coefficient contains precisely the original pairs with A contained in both images and B containing both kernels. Thus (O) does not bound an absolute coefficient majorant by the L4 norm of a signed function.

For nonzero terms, rank X<=2d. The number of A,B at fixed i,j is at most [2d i]_2[2d j]_2<=2^(2d(i+j)), by the ordered-tuple Gaussian bound. Unlike the source Lemma50 display, this does not assume rank X<=d. Also

    |alpha_{i,j}|^2=2^(i(i-1)+j(j-1))<=2^(d(i+j)),

with the same formula on the axes. Apply weighted Cauchy-Schwarz to (O), with weight w_{i,j}=2^(7d(i+j)). The second factor is at most

    sum_{0<=i,j<=d,(i,j)!=(0,0)}
                   2^(2d(i+j)) 2^(d(i+j)) 2^(-7d(i+j))
      <= sum_{i,j>=0,(i,j)!=(0,0)} 2^(-4d(i+j)) < 1

for d>=1: at d=1 the infinite sum is (1-1/16)^(-2)-1=31/225. Thus

    |O_X|^2 <= sum_{i,j,A,B at X} 2^(7d(i+j))
                                      |((P_{A,B}f)^2)hat(X)|^2.

Summing over X, discarding the X-dependent restrictions on A,B by nonnegativity, and using Parseval gives

    sum_X |O_X|^2 <= sum_{(i,j)!=(0,0),A,B}
                               2^(7d(i+j))||P_{A,B}f||_4^4.  (F2)

## Assembly, boundaries, and remaining analytic scope

Combine the convolution partition with (F1) and (F2). This yields the slightly stronger bound with coefficients 162*2^(6d^2) for ||f||_2^4 and 2 for the displayed weighted overlap sum. Divide by162 and weaken 1/81 to1 to obtain DR6.

For d=0, f is constant and all nontrivial P_{A,B}f vanish; DR6 follows directly from ||f||_4^4=||f||_2^4. If V or W is zero, there is only one map and the same constant case applies, even if the supplied d is positive. If d exceeds min(dim V,dim W), replace it first by the effective rank bound; the coefficients increase monotonically on restoring d and nonexistent subspaces contribute no terms. The zero function poses no special division case. All dimensions and d are finite natural numbers; no negative degree or field of one element is used.

The proof does not assume the target L4 inequality or any caller-provided influence certificate. It reconstructs the finite decomposition and both classes, with the necessary repairs noted explicitly. The later transformation from ordinary composed Laplacians to generalized derivatives, the Corollary55 weighted-removal repair, and the final Theorem58 induction must still be assembled and independently checked. In particular the 6d^2 baseline here must be used in that assembly; this note does not certify the printed stronger 3d^2 or silently promote the full analytic foundation. The manuscript and its imported theorem status remain unchanged. No novelty claim is made for this reconstruction.
