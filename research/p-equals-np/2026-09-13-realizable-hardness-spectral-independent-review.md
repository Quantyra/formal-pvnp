# Independent finite spectral-character review

2026-09-13. S3134/S3137. Bounded GO for the derivation in `2026-09-13-realizable-hardness-spectral-finite-character-audit.md`, exact raw SHA256 `71236ea09afd39085f59032938610a1193fc59210e60662f79dc7bbfce2b174b`. I independently read the complete note, checked the operators and character algebra, and inspected the primary PDF images. No manuscript or Lean changes, compiler, experiments, Git actions, or public actions were performed for this challenge. This is not full-foundation, kernel, hardness, or novelty acceptance.

## Source conditioning and scope

Directly viewed the preserved MZ24 printed pages62 and63 and MZv1 printed page16, not just extracted formula text. The displayed Phi law has B uniform over ALL n-by-s matrices and C uniform subject to full ROW rank s; there is no full-rank condition on B or M. A.11 explicitly assumes basis invariance of its first function argument; A.12 again assumes it for the composition identity. This resolves the main conditioning and adjoint risks in the proposed derivation.

Inspected images in C:/Users/Dan/AppData/Local/Temp, independently rehashed:

| File | SHA256 |
|---|---|
| s3134-spectral-primary-62.png | 8e5432157c11778365e09d1bbc20fcde8a03fecac98de0ff7c0ca50939e33bce |
| s3134-spectral-primary-63.png | 8aa75960dfccd7eda923673afa409579b05909a84c1846a0e4d7f0f3261e281f |
| s3134-spectral-mz16.png | c51f38f7e9f3e8cd1f964cb1a765de68840348c2a9dce060ce143ece62401aff |

These are the exact primary-image references of the audit, derived from its pinned preserved MZ24v1 and MZv1 PDFs. No later version or different sampler is substituted. I did not author occurrence's spectral note; my prior inverse and matrix-lift review contributions remain disclosed and do not certify this step automatically.

## Restricted adjoint and completion

Put c=d-s. T appends s unrestricted columns and averages; its ordinary adjoint on the full function spaces is the fixed-coordinate pullback H(MJ). G instead averages H(MR) over uniform full-column-rank d-by-c R. They must not be identified as operators on all functions.

For basis-invariant F, average the fixed-coordinate inner product over the bijection M->MA for A uniform in GL(d,2). This preserves F and sends J to A^(-1)J. Constant numbers of GL completions make that matrix uniform among all injections. Therefore <TF,H>=<F,GH> for arbitrary H, with the needed invariance exactly where used.

For fixed M in GTF, a uniform injection R completed uniformly to A=[R,A2] makes A uniform in GL(d,2). A uniform appended B has the conditional law MA2+W with W unrestricted and independent of A. Basis invariance transforms F(MA+[0,W]) into F(M+[0,W]A^(-1)). The last s rows C of A^(-1) are uniform full-row-rank with constant completion fibers; W is still independent of C. Thus GTF=PhiF pointwise for basis-invariant F, including deficient M. No event of large probability or ambient approximation is involved.

## Exact eigenvalue and norm check

For the binary entrywise character chi_S, translation factors Phi chi_S(M)=chi_S(M)*E_B,C chi_S(BC). At fixed C, the exponent is the entrywise pairing of B with SC^T. Summation over one nonzero-coefficient B entry cancels it unless SC^T=0, in which case it equals one. Consequently lambda_S=Pr_C[SC^T=0] is nonnegative, not merely bounded in absolute value.

If rank S=i, the rows of C must be an ordered independent s-tuple in a (d-i)-dimensional kernel. Thus lambda_i=0 if s>d-i; otherwise

    lambda_i = product_(j=0,...,s-1)
                    (2^(d-i)-2^j)/(2^d-2^j).

The count is exact and depends on rank, not orientation or n. Each nonnegative factor is <=2^(-i), hence 0<=lambda_i<=2^(-is). This includes s=0 (identity), i=0 (constant character), and c=0 (only rank zero survives).

The transformation chi_S(MA)=chi_(SA^T)(M) permutes Fourier labels without changing their rank. Basis invariance of F makes each rank projection F_i invariant as well; no individual nonconstant character is incorrectly assumed basis invariant. Phi acts by the real scalar lambda_i on that projection. Applying the restricted adjoint with F_i and then the composition with F_j gives

    <TF_i,TF_j>=<F_i,PhiF_j>=lambda_j<F_i,F_j>.

Character orthogonality therefore gives cross-level orthogonality after T, and for equal indices

    ||TF_i||_2^2=lambda_i||F_i||_2^2<=2^(-is)||F_i||_2^2.

The squared norm is essential. The unsquared contraction factor for T is sqrt(lambda_i), while Phi itself has scalar lambda_i on this level. The note keeps that distinction and uses the real nonnegative eigenvalue correctly with its complex-inner-product convention.

As an independent algebraic consistency check, averaging the appended columns directly kills precisely the Fourier characters with a nonzero entry in those columns. For basis-invariant coefficients the surviving fraction within each right-GL orbit is the proportion of surjections onto a fixed rank-i image that factor through the first c coordinates. Its ordered-map ratio equals the kernel-tuple ratio above. This agrees with the completion/adjoint derivation and also forces TF_i=0 for i>c.

## Consequence and remaining boundary

With s=2rho*h, the existing MZv1 right side 2^(-i(s-1))+3*2^(i-n) dominates the exact bound 2^(-is). Thus the reviewed argument supports the original weaker squared-norm bound and the cross-level orthogonality used by the current inverse proof. It does not require changing that proof's conservative ambient bound, high-degree cutoff, error budget, or final constants. The stronger no-residual estimate is not silently substituted into the manuscript.

No counterexample or missing conditioning premise was found in the exact audited derivation. It supplies a finite-character reconstruction of the inspected spectral step, conditional only on the explicitly defined finite matrix spaces, uniform laws, and elementary Fourier/linear algebra. It does not prove global hypercontractivity, discharge its pseudorandom level estimate, formalize any statement in Lean, or certify the remaining paper/PCP/learning foundations. Any eventual manuscript insertion should state the concrete T/G/Phi laws and basis-invariance hypothesis and undergo its own source review; no such edit is authorized by this report.
