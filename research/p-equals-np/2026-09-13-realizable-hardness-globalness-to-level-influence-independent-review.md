# Review of binary globalness-to-level-influence conversion

2026-09-13. S3137. Reviewer: incidence_complexity_review. Verdict: GO for the finite conversion and explicitly scoped full-function corollary. This is not hypercontractivity, a dyadic join, Lean verification or full paper acceptance.

Reviewed the complete author note `2026-09-13-realizable-hardness-globalness-to-level-influence-derivation.md`, SHA256 `c905e6ae82fcc0369161f20b007a02339ecb01a4e4e94bfeea32d4d2ba98f111`, including final section8. I did not author this proof. I authored the opposite influence-to-globalness conversion and shared its rank-one averaging/operator context with the author; that overlap is disclosed, rather than claiming wholly isolated derivation. The adjacent-level interpolation, witness and forward all-order argument are separately checked here. Prior reviewed derivative-core composition/rank identities remain explicit dependencies.

Primary scope: Ellis/Kindler/Lifshitz arXiv:2209.04243v1, Definition41/Lemmas43-44,59-64/Proposition63, preserved text SHA256 `9259246e882f05e02fb8585400fed15b6a1d9e68106cbcd813c8851ecfdc468a`, PDF `4455f4a757b2abc1b7a3dd41f3495b68bf2e2b9aa4d05a5b0953fe4e751a991f`. Later exact-order convention: Evra/Kindler/Lifshitz arXiv:2404.00641v2 text `7fb002153b3ac62a3238c61574b65b3a2a28de3ce253fe6272d697a63247ab1a`. These source conventions were read during the paired conversion work; no later version is silently substituted.

## Actual averaging and adjacent ranks

For the domain-line operator, averaging the character over uniform w first imposes phi composed with Y=0. With phi(u)=1, this has probability zero when u belongs to im Y, otherwise exactly2^-rankY. For the codomain-hyperplane operator, averaging phi first imposes Yw=0; uniform w with psi(w)=1 then yields probability zero when ker Y is contained in ker psi, otherwise2^-rankY. Both are actual translation mixtures and preserve every affine-base globalness hypothesis. No false fixed-base derivative contraction is invoked.

The explicit polynomial P_d=(I-2^d E)(I-2^(d-1) E) equals the hybrid selector on each of original ranks d and d-1. Under an order-one raw restriction rank drops by either zero or one, and drops precisely on the selected frequencies. Consequently only those two original ranks can enter output rank d-1; the unselected contributions are killed, and the selected rank-(d-1) contributions drop below it. This verifies (R P_d f)^{=d-1}=D(f^{=d}) for arbitrary f, including phases at arbitrary T. At d=1 the rank-zero selected component is zero, so no truncated natural subtraction is misused.

The coefficient norm bound is adequate: K_d=(1+2^d)(1+2^(d-1))<=2^(2d+1) for d>=1. Jensen/triangle on actual translation mixtures gives the squared globalness loss at most4*2^(4d). This forward estimate needs no conditional-density factor: the restriction remains fixed and all translation bases are available in the hypothesis.

## Concrete witness and all derivative orders

The witness f'=R_order1,T P_d f is an actual function, not an existential assumed equality. Its later restrictions embed canonically into parent restrictions of one higher total order; the bases are T plus the indicated embedded shift. Thus it is up-to-(d-1) global with the stated parameter at every base.

For an order-k target, a nonzero domain constraint supplies a line; otherwise a proper codomain constraint supplies a containing hyperplane. Nested hybrid composition with zero subsequent bases preserves the original arbitrary T. Repeating k times reduces the target level and globalness budget in parallel. Parseval at the final order-zero step gives the exact sufficient loss

    product_{r=d-k+1}^d 2^(4r+2)
        =2^(4kd-2k^2+4k).

The exponent is increasing for integer0<=k<=d and at k=d is2d^2+4d<=10d^2 for d>=1. k=0 is just the initial L2 projection bound, and d=0 is immediate. Thus the proof covers all orders k<=d rather than relying on the source's displayed exact-order choice.

## Exact-order convention and full function

For d<=dim V+dim W, a lower-order affine variation space is a disjoint union of cosets of a chosen finer order-d variation space. Normalized averaging of their squared norms proves exact-order globalness implies up-to-order globalness with the same parameter. When d exceeds total dimension, the exact-order premise is empty; only the rank-d level conclusion is then rescued by f^{=d}=0. The author explicitly refuses to use that rescue for a general bounded-degree f, since a nonzero constant can survive. This distinction is necessary and correct.

Section8 uses fixed-base orthogonality of DISTINCT reduced ranks, not of coalescing individual frequencies. For derivative order k, the rank-i parts for i>=k land in distinct ranks i-k. Hence I(f)=sum_{i=k}^d I(f^{=i}) exactly. Applying the proved forward level theorem to original f at each i gives the bound (d+1)2^(10d^2)epsilon<=2^(11d^2)epsilon. No squared triangle loss is needed. The up-to-order premise and the additional dimension condition for an exact-order reformulation are correctly retained.

Zero spaces, epsilon=0, unavailable levels and oversize orders are handled without dividing by a norm or invoking nonexistent restrictions. No Boolean or bounded-degree hypothesis was added to the main rank-level theorem for arbitrary f.

## Boundary

No blocking defect was found. This establishes the finite forward conversion with10d^2 and the bounded-degree full-function11d^2 corollary under their stated actual restriction hypotheses. It does not prove the opposite conversion by circular reference, the square-globalness/dyadic recurrence, the MZ import as a whole, or any kernel theorem. No compiler, experiment, source/paper edit, Git or public action occurred. No novelty claim is attached to this reconstruction.
