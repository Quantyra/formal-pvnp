# Full bamboo-tree source and constraint audit

2026-09-12; S3093 / E004 / S008. Final source/complexity audit of the [actual author record](2026-09-12-weak-rank-full-positivity.md). **GO for the exact mixed negative square and bounded source claims; INCOMPLETE for the requested asymptotic polynomial-m full positivity target.** No full SoS positivity theorem is certified here. [Integrity](../../INTEGRITY-CLAIMS.md).

## Exact imported source

I read the primary PDF text of [Garlik--Gryaznov--Ren--Tzameret, TR26-133](https://eccc.weizmann.ac.il/report/2026/133/download/), Definition 6.1, equation (35), Definitions 6.2--6.6, Lemma 6.7, and the proof of Lemma 6.4 (printed pages 68--71). The live ECCC record confirms the paper title, authors, and August 2026 date. The source here is the restricted simple bamboo encoding, with X, Y, U variables and no Z variables. The separate perfect-matching SoS results are not transferred to this encoding.

The source R already acts on full X/Y/U polynomials, monomial by monomial, with row degree at most n-2. No new lift is needed merely to define auxiliary moments. A variable u_(i,j,k) touches left row i and right row j, omitting the fixed boundary index m+1. Consequently ordinary degree r implies row degree at most 2r, and every square of an ordinary-degree-D polynomial is assured to be in the source domain when 4D <= n-2. The prior X-only condition 2D <= n-2 does not suffice for the full space.

The source samples full-rank M and N, with boundary row/column equal to the all-ones vector and MN equal to the prescribed augmented A, then sets

    u_(i,j,k) = sum_(ell=1)^k M_(i,ell) N_(ell,j) mod 2.

This is a consistent local assignment law by Lemma 6.7. The consistency statement includes the auxiliary variables, their complements, and products. It does not assert positive semidefiniteness for arbitrary polynomial squares whose summands range over more than n-2 total rows.

## Actual polynomial identities

For an interior summation gate write a=x_(i,k), b=y_(k,j), c=u_(i,j,k-1), d=u_(i,j,k). Its real multilinear gate residual is

    h = d - c - ab + 2cab.

The local assignment gives d=c XOR (ab), so h=0 pointwise and R(h^2)=0. This square has ordinary degree at most six but only the same two source rows. I exhaustively checked all eight assignments to a,b,c: the residual square is zero and all six clauses in Definition 6.1 hold, with zero failures. The base gate residual is u_(i,j,1)-x_(i,1)y_(1,j). Output residuals are u_(i,j,n)-A_(i,j). The restricted boundary gates obey the same identities after substitution of the fixed ones.

More generally, R(hq)=0 whenever each monomial of q together with the gate's rows fits inside n-2 source rows. This follows by evaluating each product in a common local assignment and using marginal consistency for its expansion. An explicit sufficient bound for q=p^2 with ordinary degree(p)<=D is 4D+2<=n-2. The identical argument gives R(F_C p^2)=0 for the falsifying-indicator polynomial F_C of each source clause. These are genuine square/localizing identities for this full encoding, not an inference from the slogan that SA differs from SoS. They settle constraint annihilation within the stated domain; they do not settle the sign of R(p^2).

In particular, a strictly positive-definite theorem for the unreduced full polynomial space is impossible: these nonzero syntactic gate and output polynomials lie in its moment kernel. A PSD argument must respect this kernel.

## Why the published X-only estimate does not transfer directly

A boundary variable u_(i,m+1,k) is the parity of the first k X entries in row i. It has ordinary degree one in the source encoding, while its real X-polynomial expansion has degree k. A full low-degree polynomial can therefore contain high-weight row characters and bilinear prefix characters. Counting each auxiliary as one low-weight X character would invalidate the earlier orthogonality and degree argument.

There is a bounded repair for the X-plus-boundary-X-prefix sector. Convert products of coordinate signs and prefix signs to row Fourier characters, identify labels that differ by full-row parity, and absorb their signs because every row is odd. After merging equal labels, distinct labels are orthogonal under independent uniform odd rows, regardless of their coordinate weights. At most D generators still touch at most D rows, so the same rank-conditioning perturbation bound applies with the enlarged generator count. I supplied this mathematical observation to the author. It is a contribution, not an independent proof certification, and it does not address mixed interior U or the full space.

For mixed X/Y moments the prescribed equations MN=A are an additional conditioning event. Even one dot-product condition has probability on the order of one half under independent rows, rather than the exponentially small rank-failure event used in the X-only theorem. Consequently the previous rare-conditioning estimate is not by itself a full-functional proof. No impossibility of a better comparison argument is asserted.

## Scope and provenance

I independently audited the source and derived the displayed real gate residual and the one-sided Fourier-label repair. A separate proof reviewer is required for mathematics adopted from those contributions. The eight-assignment gate check is exhaustive only for that local truth table; it is not a full moment-matrix experiment, Lean verification, or evidence of full positivity. The full ordinary-degree positivity target remains open unless the author's actual candidate separately resolves its mixed moment blocks.

No commit, push, public-note change, publication, outreach, or paid computation was performed by this review.

## Mixed operator candidate and its exact limit

For even n, let H be the odd vectors, |H|=2N with N=2^(n-2), and let K_(x,y)=(-1)^(x dot y) for x,y in H. The source law for one X row and one Y column has density

    1 + (-1)^A_(i,j) K_(x,y)

against the independent uniform law on H squared. Full rank of each one-row augmented side is automatic because e is even and x,y are odd. Each dot product is unbiased conditional on its odd nonzero first vector, so this density is normalized and both marginals are uniform.

Exact Fourier summation gives

    (K K^T)_(x,x') = |H| [1_(x=x') - 1_(x'=x+e)].

Indeed, summing a character over the odd affine hyperplane gives zero except at labels 0 and e, with respective signs plus and minus. Hence each paired block is 2N times [[1,-1],[-1,1]], and the operator K/|H| on the uniform L2 space has norm N^(-1/2). In particular,

    |R(f(X_i)g(Y_j)) - E(f)E(g)|
        <= N^(-1/2) ||f||_2 ||g||_2.

This holds for arbitrary real functions f,g on one odd row. I derived and sent it as a candidate mechanism to the author; it is a mathematical contribution. An exact integer check at n=6 verified the displayed K K^T matrix identity and zero row sums; the numerical singular-value check returned 0.25000000000000006 versus the exact predicted 1/4. The proof is the preceding character sum, not that finite check.

This contraction replaces the inappropriate claim that the prescribed dot-product event is rare. It does not control a full moment matrix containing arbitrary products of interior U variables, where each feature itself couples X and Y and different prefixes produce correlated bilinear forms. No full PSD conclusion follows from this two-row operator alone.

The exact linear symmetry of the source law is (M,N) -> (MT,T^(-1)N) for invertible T fixing e on both sides. Prefix observables use the coordinate projector P_k and become M T P_k T^(-1) N under this transformation. Thus the source symmetry preserves a prefix observable only for the corresponding commuting transformations; it does not immediately diagonalize all prefix features simultaneously.

A focused primary-source search for weak-rank SoS and rank-principle pseudoexpectation extensions found the original [arXiv paper](https://arxiv.org/abs/2608.08760) and no applicable completed full-positivity theorem. This is a bounded search result, not an absence or priority certificate. The primary paper's printed page 14 explicitly leaves extension of this method to SoS unpursued.

A concrete obstruction to two natural comparison laws can be stated exactly. Under independent odd X and Y rows with U equal to true prefixes, an output residual o=u_(i,j,n)-A_(i,j) obeys E_mu[o^2]=1/2, whereas R(o^2)=0. If instead U is defined by true prefixes up to an interior cut and by A plus the suffix parity after that cut, the output and all non-cut gates hold, but the cut-gate residual h above obeys E_mu[h^2]=1/2, whereas R(h^2)=0. The squared residual is precisely the indicator that the full dot product differs from A, which has probability one half for independent odd rows. Therefore these genuine reference laws are separated from R by an order-one discrepancy on a degree-one or degree-three square. They cannot yield the prior small-entry perturbation proof without a separately justified quotient-kernel treatment. This is an obstruction to those explicit proof attempts, not a negative square for R and not a proof that full positivity is false.

## Exact full-variable obstruction received during review

The author/root subsequently supplied the following construction. For even n>=6, set N=2^(n-2), m=N, A=I_m, f_i=1-2u_(i,m+1,2),

    p = sum_(i=1)^m f_i,
    q = (1-2y_(1,1))(1-2y_(1,2)).

The earlier X-frame calculation gives R(p^2)=m(N-m)/(N-1)=0, while Boolean cancellation gives R(q^2)=1. I independently checked the new mixed moment from the actual source distribution as follows.

Condition on the odd X row x. Put beta_j=A_(i,j), s=(-1)^(beta_1+beta_2), and let Y_j range over odd vectors satisfying x dot Y_j=beta_j. Each affine slice has N elements. The source's full-rank condition on e,Y_1,Y_2 removes exactly one possible Y_2 per Y_1: Y_1+(beta_1+beta_2)e. Unless x is e_1 or e+e_1, the coordinate character (-1)^(Y_j)_1 is balanced on each slice. Subtracting the single forbidden partner therefore gives E(q|x)=-s/(N-1). At the two exceptional x, the character is constant on each slice and E(q|x)=s. Both exceptional vectors have f_i=(-1)^(x_1+x_2)=-1 and together carry probability 1/N. Since E(f_i)=0,

    R(f_i q) = -s/(N-1).

For A=I, this is +1/(N-1) for i in {1,2}, and -1/(N-1) otherwise. Hence

    R(pq) = (4-m)/(N-1),
    R((p+q)^2) = (7-N)/(N-1) < 0.

This is a full-encoding ordinary-degree-two negative square. Every monomial of its square touches at most three source rows: p^2 touches at most two X rows, pq at most one X row and two Y columns, and q^2 reduces to one. Thus the source functional is defined on the complete displayed square for all declared n. Even n>=6 gives m=N>n and rank(A)>n, so this is a valid unsatisfiable source instance.

The parameter boundary is essential. The infinite family has exponential m, not m=n^2. At n=8, m=N=64 happens to equal n^2 and the value is -19/21; that isolated equality does not refute positivity for polynomial m at all sufficiently large n. The witness does exclude an unrestricted full-functional degree-two positivity claim covering all source m>n, and any such extension agreeing with these source moments fails. It does not exclude other functionals, prove a low-degree refutation, resolve the polynomial-m target, or imply any complexity-class separation. I received the construction before checking it and did not originate it.


## Final audit of the aggregate author's actual draft

I read [the actual final candidate](2026-09-12-weak-rank-full-positivity.md), including its aggregate Q over every unordered pair of Y columns. The source-law involution Y_j -> Y_j+e preserves odd parity and independence with e and flips the first-coordinate character. It therefore proves exact orthogonality of distinct pair characters and R(Q^2)=binom(m,2). Each such square product uses at most four Y rows, so even n>=6 is sufficient. Summing the verified mixed moment gives R(pQ)=-binom(m,2)(m-4)/(N-1). Consequently the author's P=p+(m-4)Q/(N-1) has

    R(P^2)=m(N-m)/(N-1)-binom(m,2)(m-4)^2/(N-1)^2.

I independently checked the exact rational arithmetic at n=12,m=144: R(p^2)=3840/31>0, R(P^2)=-728960/10571, and the negativity-criterion sides are 2802800 and 1800480. Thus this second example uses a positive X-side norm and a genuine mixed negative direction. It is not merely the earlier null-square example repeated.

The author's difference-vector proof of the mixed moment is equivalent to my conditioned-X check above: each nonzero even difference other than e has equal probability 1/[2(N-1)], and only beta or beta+e contributes. I checked its exceptional-vector condition and signs against the source's augmented parity constraints. The full rank and marginal consistency requirements are respected.

The asymptotic claim is also bounded correctly. For m tending to infinity with m/N tending to zero, the negativity ratio is asymptotic to m^3/(2N^2), producing an exponential-m transition of order N^(2/3). For each fixed polynomial m<=n^C, that ratio tends to zero. Therefore neither the aggregate nor the singleton example is an asymptotic polynomial-m refutation. The author's opening and conclusion explicitly preserve that unresolved target. The exact ordinary-degree model uses source U variables, and their parity compression is disclosed.

**Final source/complexity decision: GO for preserving the exact mixed-variable obstruction and its explicit finite examples; INCOMPLETE for the requested asymptotic polynomial-row full positivity window.** There is no source-scope error requiring correction in the actual candidate. The result is a failure of this unchanged functional's PSD property at the stated parameters, not a low-degree SoS refutation, a lower bound, a priority certification, or a general impossibility theorem. The separate proof reviewer remains the independent mathematical lens. My prior auxiliary/operator contributions and subsequent verification of the supplied witness are disclosed above.
