# Finite transfer multiplicities and the exact 57-pre budget

2026-09-13. S3137. Source-only derivation by incidence_complexity_review. Candidate for separate independent review. No compiler, Lean module, paper edit, Git or public action. This proves finite counting and exponent accounting conditional on the explicitly identified Fourier transfer identities and a lower-degree induction hypothesis; it does not accept Theorem58 or assume its conclusion at the current degree.

Primary: Ellis/Kindler/Lifshitz arXiv:2209.04243v1, Definitions28-33, Propositions39-40 and Lemmas51-57, printed pp.24-35. Preserved `C:/Users/Dan/AppData/Local/Temp/s3134-ellis2209.04243v1.pdf` SHA256 `4455f4a757b2abc1b7a3dd41f3495b68bf2e2b9aa4d05a5b0953fe4e751a991f`; same-stem text SHA256 `9259246e882f05e02fb8585400fed15b6a1d9e68106cbcd813c8851ecfdc468a`. Exact source text for Lemmas51-57 and its final summation was read. Prior inputs are core0e5e5d0 and reviewed DR6/W6 archivec7aaf610. No local AGENTS file was found; the satellite README and root S3137 boundaries apply.

## Operators and the two pending transfer inputs

Work over F2, with arbitrary finite V,W. All averages are uniform probabilities. P_{A,B} is the ordinary filter selecting A<=im Z and ker Z<=B. D_{A,B,T} is the actual hybrid derivative selecting A<=im Z and Z^{-1}(A)<=B, then restricting to T+Hom(V/A,B). D_X is the rank-poset derivative at zero, on its actual quotient/subspace space. These distinct selectors must not be conflated.

T1 is the source Proposition39 character identity: restrict P_{A1,B1}f at T, and decompose it as the sum of D_X D_{A0,B0,T}f over A0<=A1, B0>=B1 and isomorphisms B0/B1 -> A1/A0, with X their induced map B0->V/A0. Every summand lives on the same Hom(V/A1,B1).

T2 is the source Proposition40 character identity commuting a later hybrid derivative through D_X. With initial pair (A0,B0), let A1/A0=im X and B1=ker X. For a later pair A4>=A1,B4<=B1, the sum is over A3,B3 with

    (A3/A0) directplus (A1/A0)=A4/A0,
    (B3/B4) directplus (B1/B4)=B0/B4.

Its summands are D_Y D_{A3,B3,T+embedded(S)}f, with Y=X|B3 modulo A3, after the canonical identifications. T2 includes the actual base-shift/composition identity on each input character, not an assumed inequality between target moments. These two Fourier identities are assigned to occurrence's separate reconstruction; the following supplies their finite multiplicities and subsequent inequalities. No generic transfer certificate is postulated to replace their proof.

## T1 counting and the coefficient24

Fix outer i=dim A1 and j=codim B1. For k=dim(A1/A0)=dim(B0/B1), the number of triples in T1 is exactly

    [i choose k]_2 [j choose k]_2 |GL_k(F2)|.

The sum over k equals2^(ij): these are precisely the rank-by-rank counts of maps between spaces of dimensions j and i (choose kernel, image, then the induced isomorphism). This includes k=0 and zero-dimensional spaces. Thus triangle inequality and finite Holder give the fourth-moment cost N^3=2^(3ij), not an ambient-dependent number.

Only i,j<=d need occur because P_{A1,B1}f=0 otherwise. Therefore 3ij<=5d(i+j). Combining T1, translation/Fubini and DR6 gives each original overlap term a weight at most2^(12d(i+j)). Reindexing introduces no further multiplicity: (A0,B0,X) uniquely determines A1 as the inverse image of im X in V and B1=ker X. If t=dim A0+codim B0+rank X, then i+j=t+rank X<=2t. This proves the exact source52 upper bound

    ||f||_4^4/162 <=2^(6d^2)||f||_2^4
       +sum_{A0,B0,X:t>0}2^(24dt) E_T||D_X D_{A0,B0,T}f||_4^4.    (52)

Terms with t>d vanish by genuine rank lowering. The source's stronger printed3d^2 is not used.

## Correct mixed orders and the coefficient6dk

Assume the desired conditional fourth-moment theorem has been proved for every degree e<d on ALL finite binary spaces. For 1<=t<=d, mixed derivative D_X D_{A0,B0,T}f has degree<=d-t on Hom(V/A1,B1); induction applies there without any fixed-dimension hypothesis.

Put a0=dim A0,b0=codim B0,k=rank X. A later hybrid derivative on this space has order u+v, where u=dim(A4/A1) and v=codim_{B1} B4. Only u+v<=d-t can contribute. In particular

    dim A4+codim_W B4 = a0+b0+2k+u+v <= d+k.

The source's statement that this is <=d omits k. The correct cutoff nevertheless suffices: dim(A4/A0)=k+u<=d and dim(B0/B4)=k+v<=d.

For fixed A4,B4, the T2 complement choices number exactly2^(ku) and2^(kv): complements to a fixed k-dimensional subspace in dimension k+u are graphs of maps from one u-dimensional complement to it, and dually on the B side. The total Holder cost is2^(3k(u+v))<=2^(3dk)<=2^(6dk). Using the conservative last bound reproduces source56. Each A3,B3 determines A4=A3+A1 and B4=B3 intersect B1, so these later choices are not counted again when reindexing.

Uniform T is averaged on the original Hom(V,W). For each fixed S, T->T+embedded(S) is a bijection of that same finite group. Therefore E_{T,S}F(T+embedded(S))=E_T F(T), irrespective of the smaller S-space size. No cardinality ratio or independence assumption about a conditioned event is introduced. T2 must supply exactly this base translation; an arbitrary fixed-base contraction is not substituted.

Consequently the conditional source56 estimate is

    E_T||D_X D_{A0,B0,T}f||_4^4
      <=2^(100(d-t)^2+6dk)
          sum_{A3>=A0,B3<=B0:
               A3 intersect A1=A0, B3+B1=B0}
                 E_T||D_{X|B3 mod A3} D_{A3,B3,T}f||_2^4.       (56)

This is deduced from T2 and lower-degree induction, not assumed as an unexplained new analytic law.

## Exact multiplicity for the final triple

Fix A=A3 of dimension a, B=B3 of codimension b, and Y:B->V/A of rank k. Nonzero final derivatives require a+b+k<=d, by the actual hybrid and rank-poset lowering statements. Fix initial dimensions i=dim A0 and j=codim B0. The conditions to be counted are

    A0<=A, B0>=B, rank X=k,
    A intersect preimage(im X)=A0,
    B+ker X=B0, and X|B modulo A=Y.

Their exact number is

    [a choose i]_2 [b choose j]_2
                      2^(k(a-i)) 2^(k(b-j)),               (M)

with zero if i>a or j>b. Here is the bijection behind (M). Choose A0 and B0 first. The image of X must be a subspace of V/A0 projecting isomorphically onto im Y in V/A; such lifts are graphs into A/A0, giving2^(k(a-i)) choices. Also ker X intersects B exactly in ker Y. In B0/ker Y it is a complement to B/ker Y, giving2^(k(b-j)) choices. Given those two choices there is a UNIQUE X: project B0 to B/ker Y along the chosen kernel, apply the isomorphism induced by Y, then lift im Y to the chosen image. Thus no extra |GL_k| factor is needed. This construction verifies both constraints and recovers every X. It also proves rank X=rank Y, rather than assuming it after restriction.

Using [a i]_2<=2^(ai), [b j]_2<=2^(bj), and a+b+k<=d, (M) is at most2^(d(i+j+k)), hence certainly at most the source's conservative2^(3d(i+j+k)). All these counts depend on bounded final orders, not on dim V or dim W. At k=0 the graph factors are1 and X=Y=0; the formula still counts each initial pair once.

## Exponent and geometric-series accounting

Combine (52), (56), and the conservative multiplicity with t=i+j+k, 1<=t<=d. Each final term is bounded by the sum of weights

    2^(100(d-t)^2+27dt+6dk).

For each such t,k,

    100(d-t)^2+27dt+6dk
       <=100d^2-73dt+6dk
       <=100d^2-63dt-4dk,

using t^2<=dt and k<=t. The final comparison is precisely10dk<=10dt.

For fixed k put r=2^(-63d), with d>=1. Extending finite nonnegative sums to infinite ones:

* If k>=1, sum_{i,j>=0}r^(i+j+k)=r^k/(1-r)^2<=2r^k<=2^(-31d(k+1)), because63dk-31d(k+1)=d(32k-31)>=1.
* If k=0, omit i=j=0. The sum is (1-r)^(-2)-1<=4r<=2^(-31d), because r<=1/4 and32d>=2.

This proves exactly the requested pre-step

    ||f||_4^4/162 <=2^(6d^2)||f||_2^4
       +2^(100d^2) sum_{k=0}^d 2^(-31d(k+1))
          sum_{A,B,Y:rank Y=k, dim A+codim B+k>0}
                    2^(-4dk) E_T||D_Y D_{A,B,T}f||_2^4.       (57-pre)

Positive final order follows from t>0 since i<=a,j<=b; terms with final order>d are zero. Each fourth power here is the square of a normalized L2 energy. No false pointwise D_Y contraction or printed weight4 Corollary55 is used. The separately reviewed W6 replacement can subsequently absorb these coefficients without changing100, but that is a separate recorded deduction.

## Boundary and outstanding obligation

At d=0 the function is constant, every positive mixed order vanishes, and (57-pre) follows directly; the geometric-series argument is not applied with r=1. Zero-dimensional spaces are singleton function domains with the same case. Supplied degree d larger than available rank creates no invalid subtraction: first discard terms t>d, then invoke induction only on d-t>=0. Induction is simultaneous over all finite dimensions, so quotient/subspace spaces are permitted without asserting a uniform bound only on the original aspect ratio. Empty sets of subspaces contribute zero.

This note discharges the exact T1 summand count, complement counts, final multiplicity, uniform-base averaging and exponent summation. The pending premise is the actual character-level T1/T2 Fourier transfer, not an assumed current-degree fourth-moment conclusion. Once those identities and their identifications are independently accepted, (52), (56) and (57-pre) follow by the displayed elementary arguments and strict lower-degree induction. No full analytic theorem, Lean certification or publication claim is made at this stage.
