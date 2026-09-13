# Spectral foundation: exact finite-character calculation

2026-09-13. S3134/S3137. Bounded audit by occurrence_gadget_author. No compiler, Lean/source module expansion, manuscript edits, Git or public action. Prior lower Lean authorship is disclosed; this is an informal derivation, not kernel acceptance or a novelty claim.

**Conclusion:** for the actual printed T/G/Phi distributions, MZ v1 Lemma4.7 follows from an exact nonnegative eigenvalue formula. Averaging over the unrestricted matrix B first gives a stronger bound with no ambient-n residual. The adjoint relation requires basis invariance; it is not an identity for arbitrary F. The exact formula and all conditioning are derived below. This checks this spectral foundation only, not global hypercontractivity or the full paper theorem.

## Evidence and versions

Preserved primary MZ arXiv:2510.23991v1 text `C:/Users/Dan/AppData/Local/Temp/s3123-mz2510.23991.pdf.txt`, SHA256e8cb21fb8279f7881a5cf5c53b87b09b215f0bb3c8466b8fbdfcd4517ee5fbce. Section4.2 defines the extension operator; Lemma4.7 p.16 states the squared-norm bound and cites MZ24 A.10-A.13. Its next orthogonality calculation is equation(7) in4.8 p.17.

Preserved MZ24 `s3123-mz24.pdf.txt`, SHA2567457efd82898b827e2bb88a8d1a10d5a37b7888ebf31106813f44a8a805647c4; PDF SHA25692ee5ae3d9ccdca2ec365f92693c068a9af08dde09800859d01c81fdb06e9485. Its header identifies arXiv:2404.07441v1. A.8-A.10 pp.60-61 give character transport and basis invariance of rank levels. A.11 p.62 is the restricted adjoint identity; A.12 pp.62-63 gives GTF=PhiF; A.13 pp.63-64 gives the published loose bound. LF-delimited source-text locations:3351-3425,3427-3481,3483-3538,3540-3622. This note uses the actual distributions at those locations, rather than silently substituting a newer version.

Visual PDF verification was also performed, using the PDF read-only workflow: MZ24 printed pages62-63 and MZv1 printed page16 explicitly display B uniform in all n-by-s matrices, with the sole rank condition on C. The pages also explicitly restrict the G/T adjoint identity to basis-invariant F. Rendered inspection images (temporary evidence, not manuscript artifacts):

- C:\Users\Dan\AppData\Local\Temp\s3134-spectral-primary-62.png, SHA2568e5432157c11778365e09d1bbc20fcde8a03fecac98de0ff7c0ca50939e33bce.
- C:\Users\Dan\AppData\Local\Temp\s3134-spectral-primary-63.png, SHA2568aa75960dfccd7eda923673afa409579b05909a84c1846a0e4d7f0f3261e281f.
- C:\Users\Dan\AppData\Local\Temp\s3134-spectral-mz16.png, SHA256c51f38f7e9f3e8cd1f964cb1a765de68840348c2a9dce060ce143ece62401aff.

Prior inverse repair7cf271d and matrix lift8e69918 were read. Paper integration at ced4dd8 remains read-only. The scalar r and agreement thresholds in those derivations are not changed here. No assumption from downstream occurrence construction is used.

## Finite spaces and exact operators

Work over F_2. Let n,d,s be natural numbers with0<=s<=d, and put c=d-s. Matrices M have shape n-by-d and X have shape n-by-c. All unqualified averages are uniform over the full indicated finite matrix/vector space, including rank-deficient matrices. Functions may be complex valued; use the uniform inner product <F,H>=E[F*conjugate(H)].

    (TF)(X) = E_(B in Mat(n,s)) F([X,B]).
    (GH)(M) = E_(R in Mat(d,c), rank R=c) H(MR).
    (Phi F)(M) = E_(B in Mat(n,s), C in Mat(s,d), rank C=s) F(M+BC).

B and C are independent. In particular B is NOT conditioned to have full column rank. C is sampled uniformly among full-row-rank matrices, not among arbitrary matrices and not by independently sampling its rows without conditioning. These are the actual source definitions with d=2h and s=2rho*h. No assumption rank M=d occurs in these operator definitions.

The finite full-rank sets are nonempty even at c=0 or s=0, with the usual unique empty matrix convention. No ambient lower bound is needed for these definitions; in the paper n>=d. The eventual rank index i satisfies0<=i<=min(n,d).

## Restricted adjoint and basis invariance

Call F basis invariant if F(MA)=F(M) for every A in GL(d,2), for all M, including deficient matrices. Let J be the coordinate inclusion of the first c columns. Then

    <TF,H> = E_M[F(M)*conjugate(H(MJ))].

For each A in GL(d,2), change variables N=MA. The uniform law of M is preserved, and basis invariance gives F(M)=F(N). Averaging over A yields

    <TF,H> = E_(N,A)[F(N)*conjugate(H(NA^(-1)J))] = <F,GH>.

The last step uses that A^(-1)J is uniform among full-column-rank d-by-c matrices. Each such injection has the same number of completions to an invertible d-by-d matrix. Thus G acts as the adjoint only against a basis-invariant first argument. No basis-invariance assumption on H is needed. On the full function spaces the ordinary adjoint of T is instead fixed-coordinate pullback H(MJ); confusing it with G would invalidate the proof.

For the composition, sample R uniformly full column rank and complete it uniformly to A in GL(d,2), so A=[R,A2]. Conditional on A, a uniform n-by-s matrix B has the same law as MA2+W for an independent uniform W. Hence

    (GTF)(M) = E_(A,W) F(MA+[0,W])
             = E_(A,W) F(M+[0,W]A^(-1))
             = E_(W,C) F(M+WC) = (Phi F)(M).

The second equality requires basis invariance. C is the last s rows of A^(-1), hence is uniform full row rank, with constant completion fibers. W remains independent of C. This proves source A.12 exactly, without generic-rank events, large-n errors, or changes in the rank conditioning.

## Exact character eigenvalue and positivity

For S in Mat(n,d), let chi_S(M)=(-1)^(sum_(a,b) S_ab*M_ab). The characters form an orthonormal basis by finite additive-character cancellation. Translation gives

    Phi chi_S = lambda_S * chi_S,
    lambda_S = E_(B,C) chi_S(BC).

Fix C and average B first. The exponent equals the entrywise pairing of B with S*C^T. If S*C^T is nonzero, summing over a B entry with coefficient1 cancels exactly; if it is zero, every term is1. Therefore

    lambda_S = Pr_(C full row rank s)[S*C^T=0].             (1)

This proves 0<=lambda_S<=1 immediately. It does not infer positivity from an absolute-value estimate, and it does not require basis invariance of the individual character. The probability in(1) is independent of n except through the possible rank of S.

View S as a map F_2^d -> F_2^n with rank i. The condition S*C^T=0 says that every row of C lies in ker S, a subspace of dimension d-i. Full row rank of C requires an ordered independent s-tuple in that kernel. Counting ordered independent tuples gives the exact formula

    lambda_i = 0,                                      if s>d-i;
    lambda_i = product_(j=0,...,s-1)
                   (2^(d-i)-2^j)/(2^d-2^j),           if s<=d-i.  (2)

Empty products equal1. Equivalently lambda_i is the ratio of the numbers of s-subspaces in dimensions d-i and d; ordered bases cancel. This makes clear that the eigenvalue depends only on i,d,s, not on the orientation of S or ambient n.

For s<=d-i each factor in(2) is nonnegative and at most2^(-i), since

    2^(d-i)-2^j <= 2^(-i)*(2^d-2^j).

Thus, including the zero case,

    0 <= lambda_i <= 2^(-i*s).                         (3)

At i=0 the eigenvalue is exactly1; if i>c=d-s it is exactly0. No factor3*2^(i-n) is required for this exact calculation. Such a residual in A.13 is a consequence of its looser route averaging a random independent representation of S; it is not an intrinsic spectral error under the printed B,C laws.

## Rank-level invariance, orthogonality and the squared norm

The identity chi_S(MA)=chi_(S*A^T)(M) follows from the matrix pairing. For basis-invariant F, changing variables in its Fourier coefficient gives Fhat(SA)=Fhat(S) for invertible A. Right multiplication preserves rank. Consequently the rank-i Fourier projection

    F_i = sum_(rank S=i) Fhat(S)*chi_S

is itself basis invariant (source A.10). Formula(2) gives Phi F_i=lambda_i F_i.

Apply the restricted adjoint identity with first argument F_i and second argument T F_j, then apply the composition identity to F_j:

    <T F_i,T F_j> = <F_i,G T F_j>
                  = <F_i,Phi F_j>
                  = lambda_j <F_i,F_j>.

Distinct rank levels are orthogonal before T by character orthogonality; hence they remain orthogonal after T. For i=j, the exact squared-norm relation is

    ||T F_i||_2^2 = lambda_i ||F_i||_2^2
                  <= 2^(-i*s)||F_i||_2^2.              (4)

The corresponding norm contraction is the square root, <=2^(-i*s/2). One must not apply the eigenvalue itself as an unsquared norm bound for T. Phi has operator norm lambda_i on its rank-i eigenspace, whereas(4) concerns T on the basis-invariant rank-i subspace. The identity <F_i,Phi F_i> avoids the squared/unsquared ambiguity in reproducing source4.7.

For the paper's s=2rho*h>=1,

    2^(-i*s) <= 2^(-i*(s-1)) + 3*2^(i-n),

so the exact requested MZv1 Lemma4.7 bound follows, with its original right side and without extra conditions. Positivity and the after-T orthogonality are also established, rather than assumed from its statement.

For a Boolean F, Parseval and(4) additionally imply

    ||sum_(i>r) T F_i||_2^2
        = sum_(i>r) lambda_i ||F_i||_2^2
        <= 2^(-(r+1)*s) ||F||_2^2 <= 2^(-(r+1)*s),

whenever the high-level sum is nonempty; otherwise it is zero. This stronger corollary would remove the spectral ambient residual budget if independently incorporated. No such manuscript change is performed or required by this audit: the existing weaker repaired bound remains valid. The inverse proof's separate Markov/moment/gluing repairs are not eliminated merely by observing the sharper spectral estimate.

## Precise scope and eventual formal interface

A useful finite formal statement quantifies n,d,s with s<=d, a function F on Mat(F_2,n,d) invariant under every right GL(d) action, the actual uniform extension T and rank-conditioned G/Phi above, and its concrete character rank projections. It concludes GTF=PhiF, exactlambda(2), positivity, <T F_i,T F_j>=0 for i!=j, and squared identity(4). There is no generic assumed spectral certificate, approximate adjacency equality, conditional rank promise on M/B, or theorem about arbitrary unstructured F disguised as basis invariance.

All dimensions and distributions are finite and explicit. No n-dependent constant is left in this spectral calculation. This is a proof reconstruction of a source dependency, not a claimed new algorithm or new spectral theorem. Global hypercontractivity, its indicator-to-level estimates, the outer PCP foundation, full Lean formalization and full paper certification remain separate obligations. Native memory diagnostics remain disabled by default; none was run for this task.
