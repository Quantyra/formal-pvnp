# Independent weighted fourth-power challenge and sufficient repair

2026-09-13. S3137. compact_source_encoding_audit. Exact finite mathematical calculation; no experiments, compiler, new Lean, paper edits, Git or public action. The source is Ellis/Kindler/Lifshitz arXiv:2209.04243v1, preserved `C:/Users/Dan/AppData/Local/Temp/s3134-ellis2209.04243v1.txt`, SHA256 9259246e882f05e02fb8585400fed15b6a1d9e68106cbcd813c8851ecfdc468a. I directly read Definition33, Corollary55 and the complete Lemma57 proof through its final Corollary55 application and Theorem58. Prior independent core/collision reviews establish finite operator bookkeeping only, not the fourth-moment foundation.

**Contribution disclosure:** I supplied the all-invertible-character counterexample and independently derived its exact weighted contribution. Occurrence proposed the weight-6 repair; I checked its finite counting and the exact downstream slack, contributing the sharper 67/63 coefficient. This is an independent derivation/challenge with substantive contributions, not certification by a noncontributing reviewer. A separate noncontributing review remains required.

**Result:** the original weight-4 Corollary55 is false for its actual fixed-shift derivatives, already on binary 4x4 matrices. A weight-6 substitute follows by finite counting, and the actual slack in Lemma57 absorbs that change while retaining the conditional Theorem58 exponent100. This is not a proof or refutation of Theorem58 itself.

## Counterexample to the actual weighted statement

Let V=W=F_2^d and take the degree-d function

    f=sum_(Y in GL_d(F_2)) chi_Y.

Write G_d=|GL_d(F_2)| and E=||f||_2^2=G_d. All nonzero Fourier coefficients equal1 and have rank d. For a fixed rank-one X, compatible bases put X=diag(1,0). Its residual Fourier labels are invertible (d-1)x(d-1) maps Z. The exact rank-poset fiber calculation gives 2^(2(d-1)) selected Y above each such Z. Conversely these fibers comprise precisely the invertible Y>=X. At fixed base T=0 all phases are1. Hence

    D_X f = 2^(2(d-1)) sum_(Z in GL_(d-1)) chi_Z,
    ||D_X f||_2^2 = 2^(4(d-1)) G_(d-1).

This computation is valid for every rank-one X: independent changes of domain/codomain bases preserve ranks, the uniform measures and the sum of all invertible characters. The number of rank-one dxd binary matrices is (2^d-1)^2. The elementary general-linear recurrence is

    G_d=(2^d-1)2^(d-1)G_(d-1).

Therefore the rank-one part of the claimed weighted fourth-power sum, divided by ||f||_2^4=E^2, is exactly

    (2^d-1)^2 2^(-4d)
      [2^(4(d-1))G_(d-1)/G_d]^2
      =2^(2d-6).

Take d=4. Rank-one terms alone contribute 4E^2, exceeding Corollary55's claimed total upper bound 2E^2. Moreover X=0 contributes E^2, since D_0 is the identity. Thus the full left side is at least 5E^2. All dimensions, shifts, degree hypotheses and normalizations are the source's actual ones. This disproves that precise statement, not merely its false intermediate contraction. It is distinct from the earlier four-character 2x2 example, which refuted only the pointwise proof step.

## A sufficient weight-6 substitute

For arbitrary finite binary V,W, let f have rank degree at most d and set

    E=||f||_2^2,
    a_X=sum_(Y>=X)|fhat(Y)|^2,
    E_X=||D_X f||_2^2,
    k=rank X.

The actual residual fiber count gives E_X<=2^(2k(d-k))a_X for k<=d, and E_X=0 for k>d. Since 0<=a_X<=E,

    E_X^2<=2^(4k(d-k)) E a_X.

For a rank-j Y, the rank-k predecessors are exactly [j choose k]_2 2^(k(j-k)), bounded for k>=1 by 4*2^(2k(j-k)); at k=0 there is exactly one. Exchanging finite sums with the stronger weight gives, since j<=d,

    sum_X 2^(-6d rank X) E_X^2
      <= E^2 [1+4 sum_(k>=1)2^(-6k^2)]
      <= (67/63)E^2 <2E^2.

The exponent calculation is -6dk+4k(d-k)+2k(j-k)=2k(j-d)-6k^2<=-6k^2. The last bound uses k^2>=k and the geometric sum sum_(k>=1)2^(-6k)=1/63. The same argument works at every fixed affine shift, since phases have modulus1; only T=0 is needed downstream. No false pointwise contraction is used.

For d=0, only X=0 can contribute and the bound is immediate. Zero ambient dimensions give the same singleton case. If the stated d exceeds possible Fourier rank, the degree-at-most-d fiber and coefficient estimates remain valid. If E=0 the function and every derivative vanish. Thus no nonvacuous restriction or positive-degree assumption is concealed in the substitute.

## Exact downstream use and retained constants

Immediately before removing D_Y in Lemma57, the source has, for k=rank Y,

    2^(100d^2) 2^(-31d(k+1)) 2^(-4dk)
       E_T ||D_Y D_(A,B,T) f||_2^4.

For d>=1 the combined weight equals

    2^(-6dk) 2^(-29dk-31d) <=2^(-31d)2^(-6dk).

For each fixed A,B,T the function g=D_(A,B,T)f has degree at most d, including the zero case. Apply the proved substitute with parameter d on its actual quotient space, rather than assuming that space has the original dimensions. Dropping the source's positive-order restriction only adds nonnegative terms. Retaining the safe coefficient2 yields the corrected end-of-Lemma57 estimate

    (1/162)||f||_4^4
      <=2^(6d^2)||f||_2^4
        +2*2^(100d^2-31d) S_der,

where S_der=sum_(A,B) E_T ||D_(A,B,T)f||_2^4. The printed final removal line does not display the factor2; this review retains it explicitly. The zero-order derivative gives S_der>=||f||_2^4. Consequently the desired coefficient100 follows if

    162[2^(-94d^2)+2^(1-31d)]<=1.

For d>=1, the left side is at most 162(2^-94+2^-30)<1. Degree0 is handled separately as in the original induction. Thus the stronger weight and the retained factor2 fit the existing slack: there is no need on this account to enlarge exponent100 or the subsequent counting exponent103.

This is a conditional transfer through the exact displayed pre-removal line. It does not independently verify the earlier Lemma52/56 inputs, Lemma57's preceding incidence estimates or Lemma46's substantive L4 inequality. Those remain necessary to establish that line in a complete proof. The arithmetic here must not be reported as whole-Theorem58 acceptance.

## Scope and artifact status

The original weight-4 statement has the explicit counterexample above. The weight-6 replacement is a finite deduction from the independently checked rank-poset fiber/predecessor counts and normalized Fourier orthogonality. It suffices for the stated downstream use with current exponents, conditional on the remaining induction inputs. No claim about later versions of the primary paper, novelty, the full hypercontractive theorem, Lean acceptance, hardness or publication readiness is made.

## Exact collaborating artifact binding

I read the complete stable occurrence derivation `2026-09-13-realizable-hardness-weighted-fourth-power-derivation.md`, freshly verified SHA256 591d30061dfac1031d5990683aea1e7a88c6c0508e0d03691a724d5c53fd1120. Its actual-operator W6 proof, GL_d counterexample and exact (57-pre) absorption agree with the calculations above. Its later 200/500 implications are expressly conditional on the prior unresolved conversions. The candidate 6d^2 degree-reduction route mentioned there is not accepted by this note. This binding is by a mathematical contributor, not the separate noncontributing certification; that review remains separately routed.
