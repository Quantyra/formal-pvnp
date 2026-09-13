# Finite rank-incidence step for the fourth moment

2026-09-13. S3137. Source-only derivation by incidence_complexity_review; not a Lean proof, independent review verdict, or whole analytic-foundation acceptance. The paper at e6ed023 remains unchanged. No compiler, Git or public action. No destination or research-subdirectory AGENTS.md was found; the satellite README and existing hypercontractivity audit were read.

## Primary version and conditional input

Ellis, Kindler and Lifshitz, arXiv:2209.04243v1, https://arxiv.org/abs/2209.04243v1. Preserved primary PDF `C:/Users/Dan/AppData/Local/Temp/s3134-ellis2209.04243v1.pdf`, SHA256 `4455f4a757b2abc1b7a3dd41f3495b68bf2e2b9aa4d05a5b0953fe4e751a991f`; layout text at the same stem `.txt`, SHA256 `9259246e882f05e02fb8585400fed15b6a1d9e68106cbcd813c8851ecfdc468a`. Relevant locations: Definitions 28-29, printed p.20 (text lines1206-1226); Theorem58, p.35 (2274 onward); Definition62, Proposition63 and Lemma64, p.37 (2353 onward); Corollary65, p.38 (2417-2460). These are the Ellis paper, not the different Evra/Kindler/Lifshitz paper arXiv:2404.00641v2.

Let q be a prime power, V,W finite-dimensional over F_q, and f:Hom(V,W)->C. All expectations and norms use uniform probability, not counting measure. Write f=sum_X fhat(X) chi_X, X:W->V, using the nondegenerate trace-character pairing. Degree means maximum Fourier rank with nonzero coefficient. Theorem58's exact conditional input for degree at most d is

    ||f||_4^4 <= q^(100d^2) sum_{A<=V,B<=W} E_T ||D_{A,B,T}f||_2^4.

Its sum equals the sum over dim A+codim B<=d. T is uniform in Hom(V,W). Here ||D||_2^4 means (E_R |D(R)|^2)^2, not E_R |D(R)|^4. The extracted subscript in the restricted sum loses subspace indices; the order is dim A+codim B as in Definitions28-29. Theorem58 itself remains UNRESOLVED locally; this note neither proves its degree-reduction induction nor substitutes an assumed generic derivative certificate for it.

## Actual derivative normalization and energy

Define L_{A,B} as the Fourier projection retaining exactly X with A contained in im X and X^{-1}(A) contained in B. For R uniform in Hom(V/A,B), let iota(R):V->W be its natural embedding. Then

    D_{A,B,T}f(R) = (L_{A,B}f)(T+iota(R)).

This is the interface coordinated with occurrence_gadget_author. For each fixed R, translation T->T+iota(R) is a bijection of Hom(V,W). Finite Fubini therefore proves, without a fiber-size normalization loss,

    E_T ||D_{A,B,T}f||_2^2 = ||L_{A,B}f||_2^2
      = sum_{X retained by (A,B)} |fhat(X)|^2.

The last equality is normalized character orthogonality/Parseval. It uses absolute squares for complex functions, even where extracted typography writes fhat(X)^2. Zero-dimensional restriction spaces contain one map, so the same identity applies.

## Exact incidence multiplicity

Fix X of rank j. For a retained pair set a=dim A, b=codim B. Since X surjects onto im X,

    dim X^{-1}(A) = dim W-j+a.

Thus W/X^{-1}(A) has dimension j-a. There are exactly [j choose a]_q choices of A in im X. For each A, B containing X^{-1}(A) corresponds bijectively to a codimension-b subspace of this quotient, hence has exactly [j-a choose b]_q choices. Consequently the order-a+b count is

    [j choose a]_q [j-a choose b]_q,
    0<=a<=j, 0<=b<=j-a.

In particular every retained pair automatically has order at most j. This also proves directly that order>d Laplacians vanish for degree<=d functions; no separate degree-lowering hypothesis is needed for truncating this sum.

For any order budget d the exact count is

    C_{j,d} = sum_{a=0}^j sum_{b=0}^{min(j-a,d-a)}
                         [j choose a]_q [j-a choose b]_q,

with empty inner sums when d<a. If j<=d this becomes C_j with a+b<=j, and is independent of dim V and dim W. Equivalently it counts nested subspaces A<=X(B)<=im X, retaining the full pair through the quotient bijection above. No replacement of actual hybrid incidence by independently chosen image/kernel conditions is required.

Here is an elementary explicit bound that avoids any ambient constants. The number [u choose v]_q is at most q^(uv): every v-dimensional subspace has an ordered basis, and all ordered v-tuples form a set of size q^(uv). This includes v=0. Each summand in C_j is therefore at most

    q^(ja+(j-a)b) <= q^(j(a+b)) <= q^(j^2).

There are (j+1)(j+2)/2 summands. For j>=1 this is at most (j+1)^2<=2^(2j)<=q^(2j), since j+1<=2^j. Hence

    C_j <= ((j+1)(j+2)/2) q^(j^2)
        <= q^(j^2+2j) <= q^(3j^2).

Also C_0=1 exactly. For j<=d, C_j<=q^(3d^2), including d=0. This is deliberately conservative; it suffices for the printed coefficient without any dimension-dependent factor.

## Derivation of Corollary65

Assume the actual pointwise influence hypothesis: for every A,B of order<=d and every T,

    I_{A,B,T}(f) := ||D_{A,B,T}f||_2^2 <= epsilon,

where epsilon>=0. Each I is nonnegative, so I^2<=epsilon I. Starting from the conditional Theorem58, use the exact energy identity and exchange finite sums:

    ||f||_4^4
      <= q^(100d^2) epsilon sum_{A,B:order<=d} ||L_{A,B}f||_2^2
      = q^(100d^2) epsilon sum_{rank X<=d} |fhat(X)|^2 C_{rank X}
      <= q^(103d^2) epsilon ||f||_2^2.

The exact unrounded incidence coefficient in the middle equality can be retained if wanted. For q=2 this is precisely 2^(103d^2), not a coefficient depending on rectangular matrix aspect ratio. No globalness-to-influence assertion was used in this step.

## Proposition63's separate role and boundary cases

Proposition63 states that (d,epsilon)-restriction global f has (d,q^(10d^2)epsilon)-small generalized influences for f^{=d}. It is a different bridge from actual affine-restriction norms to the input above; it is not the finite incidence lemma. Conditional on that proposition, applying Corollary65 to f^{=d} yields the valid fourth-moment bound q^(113d^2)epsilon ||f^{=d}||_2^2. The present note does not prove Proposition63 or its Lemma64.

The displayed Proposition63 induction chooses a derivative of order exactly d, although its statement covers every order k<=d. If Lemma64 and arbitrary-shift derivative composition hold as stated, the induction can instead choose the first order-one factor of any k>=1: the remaining order k-1 is <=d-1, so the induction hypothesis on degree d-1 applies. The loss is 4q^(4d)q^(10(d-1)^2)<=q^(10d^2) for d>=1, q>=2; indeed 4<=q^2 and 10(d-1)^2+4d+2<=10d^2. Order k=0 follows from Parseval and the global mean-square bound. The all-codomain case needs the dual order-one factor. This explains how the statement could cover all orders; verifying Lemma64's translation, level-selection and composition is assigned to the separate derivative-core work, and remains a dependency here.

For d=0, degree-zero f is constant, C_0=1 and the only relevant pair is A=0,B=W. The influence hypothesis says |f|^2<=epsilon, directly giving |f|^4<=epsilon|f|^2. If epsilon=0, this same order-zero influence (for general d) forces ||f||_2=0 and f=0, so the conclusion is immediate. Negative epsilon is not allowed.

If d>min(dim V,dim W), all Fourier ranks still satisfy j<=min(dim V,dim W)<d. The incidence proof is unchanged. One can apply Theorem58 at the smaller effective degree and the corresponding subset of the influence hypotheses; weakening to q^(103d^2) is valid. If either space is zero, Hom(V,W) is a singleton and only rank zero occurs; only A=0,B=W retains that frequency, so no vacuous influence condition is used. In the exact-level Proposition63 application, f^{=d}=0 when d exceeds possible rank.

## Remaining work and handoff

This supplies a complete finite counting and averaging derivation conditional on the precise Theorem58 and normalized Fourier orthogonality. It does not discharge Theorem58, generalized-derivative composition/order lowering, Lemma64/Proposition63, later dyadic/globalness bookkeeping, or the paper's full analytic and Lean foundations. Next independent review should check the quotient bijection and all normalization factors; after that the count can be attached to a proved derivative-core theorem without changing the current manuscript or invoking a new axiom. The calculation reconstructs a known published step and makes no novelty claim.
