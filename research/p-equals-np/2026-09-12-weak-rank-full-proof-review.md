# Independent proof review: full-encoding weak-rank obstruction

2026-09-12; S3093 / E004 / S008; [integrity](../../INTEGRITY-CLAIMS.md). **PASS for the exact mixed degree-two negative-square theorem and its stated limitations in the [actual author draft](2026-09-12-weak-rank-full-positivity.md). The asymptotic full-positivity target for polynomially many rows remains INCOMPLETE.** This is an AI-agent proof review, not formal verification, human peer review, or novelty certification.

The author supplied the boundary-prefix nullvector, its mixed Y cross moment, and the aggregate degree-two witness before this reviewer checked them. I supplied no construction or mathematical repair. I independently read the primary cached text of [Garlik--Gryaznov--Ren--Tzameret, TR26-133](https://eccc.weizmann.ac.il/report/2026/133/download/), Definitions 6.1--6.7 and the functional in the proof of Lemma 6.4, and the source review for this increment.

## Exact statement checked

Let n be even, n>=6, m>n, A=I_m, and N=2^(n-2). Write e for the all-ones vector and beta=e_1+e_2. In the actual restricted simple bamboo encoding, put

    f_i = 1-2u_(i,m+1,2) = (-1)^(beta dot X_i),
    h_j = 1-2y_(1,j),
    p = sum_i f_i,
    Q = sum_(j<ell) h_j h_ell,
    P = p + (m-4)/(N-1) Q.

The equality defining f_i is an equality under the canonical local assignments; it does not identify a degree-one U variable with a degree-one X polynomial. Then

    R(P^2) = m(N-m)/(N-1)
             - binom(m,2)(m-4)^2/(N-1)^2.

In particular this value is negative precisely when

    (m-1)(m-4)^2 > 2(N-m)(N-1).

The polynomial P has ordinary degree two in the source variables. Its reduced square is in R's domain: p^2 touches at most two X rows per monomial, pQ at most one X and two Y rows, and Q^2 at most four Y rows. Thus its actual maximum row degree is four, at most n-2. A generic degree-two full-variable square could require eight rows, but this explicit polynomial does not. Boolean reduction uses each variable squared equal to itself; hence h_j^2=f_i^2=1 in the Boolean quotient.

## Independent derivation of the moments

For two odd rows that form an independent frame with e, their sum v is uniform over the even vectors other than 0 and e. Each allowed v has exactly 2N ordered odd-row decompositions (x,x+v). The nontrivial character with label beta sums to zero on the full even subspace, while its values at both 0 and e are one. Therefore R(f_i f_a)=-1/(N-1) for i!=a; diagonal entries are one. Summing gives R(p^2)=m(N-m)/(N-1).

Fix distinct Y indices j,ell. By source consistency their two-row marginal is the same uniform independent odd frame. Conditional on its columns y,z, an X row is uniform on

    e dot x=1, y dot x=A_(i,j), z dot x=A_(i,ell).

These are three independent linear equations because e,y,z are independent. The X full-rank condition adds no restriction: an odd x is neither 0 nor the even vector e. The conditional expectation of (-1)^(beta dot x) vanishes unless beta belongs to span(e,y,z). Since beta is even and neither 0 nor e, this occurs precisely when y+z is beta or beta+e. Each event has probability 1/[2(N-1)]. On the first event the character value is (-1)^(A_(i,j)+A_(i,ell)); on the second it is its negative. Meanwhile h_j h_ell=(-1)^((y+z)_1) is respectively -1 and +1. Consequently

    R(f_i h_j h_ell) = -(-1)^(A_(i,j)+A_(i,ell))/(N-1).

For A=I_m, exactly the two indices i=j,ell have the negative exponent sign. Summing over i gives -(m-4)/(N-1), and summing over unordered pairs gives R(pQ)=-binom(m,2)(m-4)/(N-1).

The family {h_j h_ell : j<ell} is orthonormal for its canonical Gram moments. A diagonal product reduces to one. For different pairs, choose any Y row in their nonempty symmetric difference. Replacing that row y by y+e preserves odd parity because n is even and preserves independence with e, but reverses its first-coordinate character. This is a measure-preserving involution of the relevant local frame law. Its expectation is therefore zero. Every such product touches at most four rows, so the source marginal exists even at n=6. Hence R(Q^2)=binom(m,2). Completing the square in the scalar coefficient of Q proves the displayed formula and the strict inequality criterion.

There is no appeal to a nonexistent global frame on m rows, and no assumption that a common local distribution contains all summands of P. Each Gram entry uses its own admissible support and the source's marginal consistency.

## Parameters and what this rejects

At n=12,m=144=n^2,N=1024, direct exact-integer simplification gives R(P^2)=-728960/10571. This arithmetic verifies the displayed substitution, not the theorem by a finite experiment. At m=N, even the single-pair variant p+h_1h_2 gives (7-N)/(N-1)<0; n=8,m=64=n^2 yields -19/21. These are genuine degree-two negative squares of the unchanged full functional.

For growing n the aggregate criterion becomes effective at exponential row counts of order N^(2/3), not throughout m=n^2. The two concrete polynomial-family parameter points do not refute eventual full positivity at degree two or higher in the asymptotic polynomial-row regime. Conversely, the explicit counterexample rejects a parameter-uniform claim that this unchanged functional is full-degree-two PSD for every m>n. It rejects any PSD functional agreeing with these required moments. It does not rule out different functionals, prove a short SoS refutation, prove a SoS lower bound, or decide P versus NP. No strictly positive theorem on the entire nonzero syntactic full-variable space is possible in any case because canonical output and gate identities yield nonzero polynomial nullvectors.

## Additional source-review mathematics checked

For the one-X/one-Y odd-row law, with H the odd vectors and |H|=2N, K_(x,y)=(-1)^(x dot y), its density against independent uniform odd rows is 1+(-1)^A K. For each odd x the dot product is balanced on H because x is neither 0 nor e. Thus normalization and both uniform marginals are correct. Character summation gives KK^T_(x,x')=2N[1_(x=x')-1_(x'=x+e)]. Paired blocks have nonzero eigenvalue 4N. The normalized operator K/(2N) therefore has norm 1/sqrt(N), and it annihilates constants. This proves the source review's stated covariance bound. It is a two-row statement, not a proof of arbitrary full Gram positivity.

For a gate d=c XOR(ab), the real Boolean residual d-c-ab+2cab vanishes pointwise. Output residuals vanish as well. Localizing these identities is valid when each multiplier monomial plus the gate rows lies in the source domain. This does not supply positivity. Under the independent-odd reference law, an output residual square has mean 1/2 because the relevant dot product is unbiased. A prefix/suffix construction forced to match the output instead leaves the cut-gate residual square equal to the same disagreement indicator. The source review's claimed order-one comparison discrepancy is therefore valid, and is not itself a negative square of R.

No build, commit, push, publication, outreach, or paid computation was performed. This reviewer owns only this review file.

## Actual-draft closeout

I read the complete actual author draft after independently checking both candidates. Its equations (1)--(7), affine conditioning, orthogonality involution, generic versus actual support bounds, parameter substitutions, and asymptotic comparison match the derivation above. Its constraint and comparison-law discussion is correct in the stated support range. No mathematical repair was required. The reported midpoint-U numerical diagnostic is expressly unused; I did not reproduce it and do not certify it as a full PSD result. The title and lead correctly present a mixed obstruction and leave the requested polynomial-row asymptotic positivity window unresolved. Final mathematical disposition for the actual bounded theorem: PASS; disposition for completing that broader target: INCOMPLETE.
