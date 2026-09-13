# Fixed-shift derivative collision: independent calculation

2026-09-13. S3137. compact_source_encoding_audit. Bounded mathematical challenge, no compiler, Lean/paper edits, Git or public action. This note checks the actual rank-poset derivative, which differs from the hybrid subspace derivative in the separate core note.

Primary read: Ellis/Kindler/Lifshitz arXiv:2209.04243v1, preserved `C:/Users/Dan/AppData/Local/Temp/s3134-ellis2209.04243v1.txt`, SHA256 9259246e882f05e02fb8585400fed15b6a1d9e68106cbcd813c8851ecfdc468a, Definitions30/33, Lemma53 and Corollary55. Definition30 says X<=Y iff rank Y=rank X+rank(Y-X). Definition33 defines L_X by the selector Y>=X and D_X,T by restricting L_X to Hom(V/im X,ker X) at affine base T; D_X means T=0. Thus fixed-zero shift is genuinely what the displayed Lemma53 proof uses.

## Exact binary 2x2 calculation

Let V=W=F_2^2, X=diag(1,0). For b,c in F_2 put

    Y_bc = [[1+bc,b],[c,1]],   f=sum_(b,c) chi_(Y_bc).

The four Y are distinct, each with determinant (1+bc)-bc=1 and rank2. Also Y-X=[[bc,b],[c,1]] is the outer product [b,1]^t[c,1], hence has rank1. Therefore Y>=X for all four terms by the actual rank order.

The domain ker X is spanned by the second coordinate, and the target V/im X is its second-coordinate quotient. Each induced label sends that coordinate to itself: all four compressed labels are scalar1. At T=0 their character phases are all1. On the two-point residual matrix space,

    D_X f(a)=4(-1)^a,
    ||D_X f||_2^2=(16+16)/2=16,
    sum_(Y>=X) |fhat(Y)|^2=4=||f||_2^2.

Thus the fixed-shift Parseval equality used in Lemma53's proof is false, as is the pointwise contraction used in Corollary55's proof. It cannot be fixed by interpreting this D as the hybrid derivative or by normalizing the two-point domain differently: both full and residual spaces already have uniform probability normalization. Averaging over a fresh uniform ambient T restores energy Parseval, but that is a different formula from the displayed fixed-T assertion.

This is not itself a counterexample to either weighted lemma statement. Lemma53's original weight suppresses this particular term. The weighted statements must be assessed separately.

## A checked finite repair for binary Lemma53

Occurrence proposed counting the collision fibers. The following independent derivation confirms that repair for Lemma53's second-energy sum, conditional only on elementary finite Fourier orthogonality and rank algebra. It does not repair Corollary55 by implication.

Fix a rank-k X. Choose compatible bases so X has block diag(I_k,0), and write a selected Y in blocks [[A,B],[C,Z]], with residual label Z of rank l. The rank-additive condition Y>=X is equivalent to

    ker Z <= ker B,   im C <= im Z,   A=I_k+B Z^- C,

where Z^- is any right inverse on im Z, extended arbitrarily. The expression is independent of that extension because B kills ker Z. To see necessity without a Schur-invertibility assumption, rank-additivity gives im Y=im X direct-sum im(Y-X). The quotient map onto V/im X is injective on im(Y-X), so that image is the graph of a map M on im[C Z]; thus A-I_k=MC and B=MZ. Subtracting M times the bottom block from the top gives rank Y=k+rank Z, whereas rank(Y-X)=rank[C Z]. Rank additivity now forces rank[C Z]=rank Z, hence im C<=im Z and the displayed formula. Conversely the factorization makes Y-X have rank l and elementary block elimination makes Y have rank k+l.

For a fixed Z, B is an arbitrary map im Z->F_2^k composed with Z, giving 2^(kl) choices, and C is an arbitrary map F_2^k->im Z, giving 2^(kl) choices. A is then determined. The exact collision fiber has size 2^(2kl). This includes k=0 or l=0. A degree-at-most-d function uses l<=d-k, so Cauchy-Schwarz on each residual Fourier coefficient yields, at any fixed affine shift,

    ||D_X,T f||_2^2
      <=2^(2k(d-k)) sum_(Y>=X) |fhat(Y)|^2.

Phases have modulus1 and do not worsen this bound. For k>d there are no selected terms.

Now fix Y of rank j. A rank-k predecessor X corresponds bijectively to a rank-k projection P on im Y, with X=PY. Rank additivity supplies the direct decomposition im Y=im X direct-sum im(Y-X); conversely any such projection gives a predecessor. There are [j choose k]_2 choices of the image and 2^(k(j-k)) complements. Thus the predecessor count is exactly

    [j choose k]_2 2^(k(j-k)) <=4*2^(2k(j-k)).

For k>=1 the Gaussian estimate follows from its product formula: numerator factors are <=1 and the finite denominator product of (1-2^-s) is >1/4. For example the s=1 factor is 1/2 and the product for s>=2 is >=1-sum_(s=2..k)2^-s>1/2. At k=0 the predecessor count is exactly1 and should be retained separately.

Exchanging finite sums and keeping j<=d, the original weight gives the coefficient

    2^(-4dk) 2^(2k(d-k)) 4*2^(2k(j-k))
      <=4*2^(-4k^2),  k>=1.

Including k=0, the total coefficient is <=1+4sum_(k>=1)2^(-4k^2)<=1+4/15<2, since k^2>=k. Therefore the published binary Lemma53 inequality with factor2 survives by this finite fiber argument despite the incorrect displayed equality. Degree0 and zero ambient dimensions reduce to the identity derivative and satisfy the same bound directly.

## Scope that remains unresolved

Corollary55 involves squared energies and invokes the false pointwise contraction ||D_X f||_2^2<=||f||_2^2. The Lemma53 repair does not supply that contraction. A new weighted fourth-power argument or modified intermediate constant must be established before carrying that step into the Theorem58 induction. No claim about the truth or falsity of Corollary55 or Theorem58 is made here.

The ordinary hybrid derivative energy averaged over ambient T, used by the separate rank-incidence deduction of Corollary65, remains valid. This finding concerns an earlier fixed-shift rank-poset derivative step inside the unresolved foundation. No complete analytic, kernel, hardness, novelty or publication claim follows from this note.

## Stable author binding

I read the full final author core `2026-09-13-realizable-hardness-generalized-derivative-core-derivation.md` and verified SHA256 aa45294da61022daa69fdf932b88b51cad0856b301596393a640e52162949328. Its sections5-6 match this independently computed collision and finite Lemma53 repair. Bounded GO for the binary weighted second-energy deduction; Corollary55's weighted fourth-power assertion itself remains unresolved, not refuted by the pointwise example. No entire analytic or kernel acceptance is implied.

The author correctly separates Lemma46, the remaining degree-reduction L4 inequality, from Lemma59, the later homogeneous-Laplacian input to globalness/influence work. This review does not prove either step or the intervening transfers to Theorem58. No further proof expansion is part of this binding.
