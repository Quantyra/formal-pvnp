# Independent transfer-assembly accounting review

2026-09-13. S3137. compact_source_encoding_audit. Reviewed complete candidate `2026-09-13-realizable-hardness-transfer-assembly-accounting.md`, freshly verified SHA256 a7be5fb4442fbd8c947f98cef0d7cb1d44105a544e66f06c727a7f4811a74cef. I did not author this accounting note. I contributed to the separate rank-poset collision/W6 work and checked the earlier ordinary-transfer construction; those activities do not certify the pending T2 identity. No compiler, Lean/paper edit, Git or public action.

Primary comparison: Ellis/Kindler/Lifshitz arXiv:2209.04243v1, preserved `C:/Users/Dan/AppData/Local/Temp/s3134-ellis2209.04243v1.txt`, SHA256 9259246e882f05e02fb8585400fed15b6a1d9e68106cbcd813c8851ecfdc468a, Propositions39-40 and Lemmas51-57. Their actual statements and summations were directly read.

**Bounded GO for conditional accounting.** The candidate's finite multiplicities, corrected order cutoff, base averaging and exponent sums prove the specified 57-pre consequence from actual T1/T2 character identities and strict lower-degree induction. This verdict does not prove those identities by treating their names as assumptions, nor accept the full theorem before the pending identity review.

## First transfer and zero-order discipline

The exact T1 count is sum_k [i choose k]_2[j choose k]_2|GL_k|=2^(ij), the rank decomposition of all linear maps between i- and j-dimensional spaces. The associated fourth-moment Holder factor is 2^(3ij). At a nonzero ordinary filter i,j<=d; using 3ij<=5d(i+j) with the DR6 weight gives at most 2^(12d(i+j)). For t=dim A0+codim B0+rank X, i+j=t+rank X<=2t, giving the advertised coefficient24.

The reconstruction A1=preimage(im X), B1=ker X is unique, so this reindexing introduces no extra factor. The excluded ordinary zero pair is exactly t=0. For t>d, genuine rank lowering makes the mixed derivative zero; for 1<=t<=d it has degree<=d-t<d. Induction on all finite spaces simultaneously is therefore legitimate when the lower-degree theorem is actually available. No truncated subtraction or same-aspect-ratio premise is needed.

## Correct later dimensions and normalized shift

Let a0=dim A0, b0=codim B0, k=rank X, t=a0+b0+k. A later hybrid order is u+v on Hom(V/A1,B1). Surviving terms require u+v<=d-t. Thus

    dim A4+codim B4 = t+k+u+v <=d+k,

not generally <=d. The candidate explicitly corrects this source shortcut. The spaces governing complement counts have dimensions k+u and k+v, each <=d, so the correction does not spoil their estimates.

For a fixed later pair, the complement counts are exactly 2^(ku) and 2^(kv). The fourth-moment Holder cost is 2^(3k(u+v))<=2^(3dk)<=2^(6dk). Moreover the resulting A3,B3 uniquely recover A4=A3+A1 and B4=B3 intersect B1. In fact dim A3=a0+u and codim B3=b0+v, so the final mixed order is t+u+v<=d. This is the cutoff needed later for the final multiplicity, distinct from the d+k cutoff for A4,B4.

The T2 formula must include the canonical ambient embedding of S. Conditional on that exact formula, averaging uniform original T is invariant under T->T+embedded(S) for each fixed S. Finite Fubini then removes the S average without a cardinality ratio. This is a translation identity on the original probability space, not a claim that a coherent fixed-base derivative preserves Fourier energy.

## Final multiplicity is exact

Fix final A of dimension a, B of codimension b and Y:B->V/A of rank k. For fixed i=dim A0 and j=codim B0 there are [a choose i]_2[b choose j]_2 initial subspace choices. An admissible image of X projects isomorphically onto im Y and is a graph into A/A0, giving 2^(k(a-i)) possibilities.

The kernel of X meets B in ker Y. In B0/ker Y it must complement the k-dimensional B/ker Y, with complementary dimension b-j. Such complements number 2^(k(b-j)). Given this kernel and the lifted image, X is uniquely determined by its restriction Y: project along the kernel to B/ker Y, use Y's induced isomorphism, and lift to the chosen image. Therefore the candidate's formula M is exact and needs no extra |GL_k| factor. Conversely every such construction obeys the required intersection and span constraints, so there is no uncounted admissibility filter or multiplicity.

At k=0 both graph factors are1 and X=Y=0; all initial pairs are still counted exactly once. For nonzero final terms a+b+k<=d. The simple Gaussian estimate gives the exponent

    ai+bj+k(a+b-i-j)<=d(i+j+k).

Hence M<=2^(d(i+j+k)), which is stronger than the retained source bound2^(3d(i+j+k)). This estimate depends only on final orders, not ambient dimensions.

## Exponent and endpoint checks

Using the conservative multiplicity and t=i+j+k, the exponent is 100(d-t)^2+27dt+6dk. Since t<=d,

    100(d-t)^2+27dt+6dk
       <=100d^2-73dt+6dk
       <=100d^2-63dt-4dk.

The last comparison uses exactly k<=t. For d>=1 set r=2^(-63d). For k>=1, summing i,j gives r^k/(1-r)^2<=2r^k. The desired comparison to 2^(-31d(k+1)) reduces to 1<=d(32k-31), valid even at d=k=1. For k=0, the positive-order restriction excludes i=j=0; the sum is (1-r)^(-2)-1<=4r<=2^(-31d). Thus no spurious zero-order term receives the induction weight.

These are exactly the stated 57-pre coefficients. Extending finite sums or dropping later support restrictions only adds nonnegative squared-norm terms. Each fourth power in this final expression is the square of a normalized L2 energy, not a fourth-moment norm on the residual domain.

Degree0 is handled directly, without taking a geometric series at r=1. Zero-dimensional spaces are singleton cases. A supplied degree larger than possible rank still permits the argument: discard t>d as zero, use nonnegative degree d-t for induction and the actual support cutoff for later derivatives. Empty subspace collections contribute zero. No fixed-base contraction or original false weight-4 Corollary55 is used.

## Remaining acceptance boundary

The finite accounting passes, conditional on actual T1/T2 identities with the correct domains and shifts, DR6, and the lower-degree induction hypothesis. The separately proved W6 replacement can remove the final rank-poset derivatives after 57-pre is established. This does not allow the current-degree theorem to be assumed to prove itself. In particular T2's unique character-level complement selection is still a substantive missing proof until separately reconstructed and reviewed. No full analytic, Lean, hardness, novelty or publication certification is given here.
