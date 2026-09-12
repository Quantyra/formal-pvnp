# Mixed interaction charge: exact contraction and threshold translation

2026-09-12. S3088 / E004 / S008. Proof, source/complexity and non-claims reviews complete for the bounded analytic record. Full improved PPSZ forcing INCOMPLETE; publication HOLD. Public v1 unchanged.

The concrete target is a depth-uniform integrated second-order error while preserving a proved positive aggregate first-order forcing contribution for the same ordering measure. The first result below controls the actual second derivative with a support-size cost. The second gives a depth-uniform comparison to the sequential first-order conditional law. It does **not** identify that law's full event probability with its affine Taylor polynomial. Thus the required aggregate gain remains unproved.

Inputs are the corrected Scheder [2022 full version](https://arxiv.org/pdf/2207.11071v1), the source boundaries and equations (1)-(10) of [S3087](2026-09-12-conditional-forcing.md), and the S3088 planning literature intake. The closest source already discusses Markov-chain orderings; no priority or novel algorithm claim follows from this analysis. The newly tested mechanism is preservation of aggregate threshold mass under a monotone translation, proposed during root-agent review of the failed support-size charge. All derivations are analytic; no experiment was used.

## Setup and exact support reduction

Use the S3087 normalized product density on a finite simple path forest H,

    D_theta(t) = product_{uv in H}(1 + theta phi(t_u)phi(t_v)),  0 <= theta <= .1,
    phi(t) = sqrt(1-2t)(1-5t) for t <= 1/2, and zero otherwise.

Write gamma(r)=r(1-2r)^(3/2) below one half and zero above; m2=3/32 and c=1/sqrt(5). Every root marginal is uniform. Cycles, including parallel-edge cycles of a source sibling multigraph, require cutting before this statement applies; removed edges receive no credit. Root x has exact placement r. The cut event f_x is a fixed monotone Boolean function of its **distinct label** threshold bits. Its support and its finite CCT are independent of r. Repeated CCT labels remain a single bit, and x is never a nonroot down-path label.

Let S_x contain the root and the distinct labels on which f_x depends. Marginalize the other labels. Prune every H leaf outside S_x, whose integral is one. Contract every maximal remaining path with L edges and endpoints a,b in S_x. Its exact kernel is

    1 + k_L(theta) phi(t_a)phi(t_b),
    k_L(theta) = theta^L m2^(L-1).                         (1)

Induction integrates an internal degree-two vertex using integral phi=0 and integral phi^2=m2. The resulting graph is again a path forest. Substitute t_x=r; no additional normalization occurs. This handles off-support bridges, tails and exact root conditioning without making independent copies of repeated labels. Let K_x be its number of edges, at most |S_x|-1 when nonempty.

Disconnected supported edge sets do not cancel merely because they are disconnected in H. The already documented realizable CCT f=AB OR CD and H={ab,cd} gives q=r^2+theta gamma(r)^2 and

    P(f | root=r) = 2q-q^2,
    P''(f | root=r) = -2 gamma(r)^4,
    integral_0^1 P'' dr = -1/36960.                      (2)

Both selected edges are canonical sibling edges of the prior example; choose one copy of cd. Its source regular/TwoCC-free status after closure is unestablished and it is not a SAT-hard family. Equation (2) tests only the proposed connected-H-only cancellation rule. The disconnected marked pair is genuinely adverse. Pruning unsupported tails is valid; discarding disconnected supported clusters is not.

## Full second-derivative bound after contraction

Orient the contracted component containing x away from x and each other component away from an arbitrary vertex. Under the actual root-conditioned density these are normalized transitions. For edge e with length L_e put W_e=phi(t_a)phi(t_b) and

    s_e = k'_L W_e/(1+k_L W_e).

In parent-before-child exposure order each s_e has conditional expectation zero: integrate its child against the transition kernel and use integral phi=0. The edge scores are therefore martingale differences, including the edges with the exact root as parent. Write S=sum s_e. Differentiating the finite density gives

    P''_x(r,theta)
      = E_r[f_x { S^2 - sum_e s_e^2
                   + sum_e k''_L W_e/(1+k_L W_e) }].    (3)

Consequently |P''_x| is at most twice the sum of the edge score second moments plus the sum of the absolute last terms. This is a bound on the full derivative; it retains all mixed pairs through E S^2 and does not assume they vanish individually with f_x inserted.

Integrate the bound over r. Uniform root marginals restore uniform parent marginals, even though a fixed-r parent marginal need not be uniform. The transition denominator is at least 1-.1c. Thus, with a=integral |phi|=2 gamma(1/5) and a^2=.03456,

    integral_0^1 |P''_x(r,theta)| dr
       <= [2 m2^2/(1-.1c)] sum_e (k'_L)^2
            + a^2 sum_e |k''_L|.                        (4)

For the first term integrate the child after bounding the denominator, then integrate the parent square to m2. For the second term the transition denominator cancels exactly and the full-root integral gives a^2. These steps also apply to root-incident edges.

For theta<=.1, k'_L=L(theta m2)^(L-1)<=1; k''_1=0 and k''_L=L(L-1)m2(theta m2)^(L-2)<=2m2 for L>=2. The successive ratios are bounded by 2*.1m2 for the first sequence, and 3*.1m2 for the second starting at L=2, both below one. Hence

    integral |P''_x| <= .025 K_x,
    |sum_x integral [P_x(r,epsilon)-P_x(r,0)
                       -epsilon P'_x(r,0)] dr|
        <= .0125 epsilon^2 sum_x K_x.                  (5)

The coefficient in (4) is below .024882. This eliminates raw quadratic pair-count charging and suppresses long off-support gaps. It does not establish the requested O(n epsilon^2): |S_x| can be exponential in CCT height and no O(n) aggregate support bound is supplied.

## Depth-uniform threshold translation to the conditional template

Fix a deterministic reveal order of all distinct nonroot labels needed for f_x, separately for each root. Under a threshold history h, define the S3087 conditional template

    p_{epsilon,r}(h) = r + epsilon gamma(r)
                         sum_{u adjacent to current v} mu_u(r,h),   (6)

where an unrevealed neighbor has mu=0, an early revealed neighbor has mu=gamma/r, a late one has mu=-gamma/(1-r), and the exact root neighbor has mu=phi(r). Above one half all corrections vanish. Let Q_{epsilon,r} be the resulting sequential law. This law can depend on the root, threshold and chosen reveal order; the family is a proof comparison, not automatically the conditionals of a common global permutation measure. No acyclicity of the reveal dependence beyond the fixed sequential construction is assumed. Every entropy charge below remains KL(D||U); no template entropy is substituted.

The relevant correction functions below one half are

    A(r)=gamma(r)^2/r = r(1-2r)^3,
    B(r)=-gamma(r)^2/(1-r)=-r^2(1-2r)^3/(1-r),
    C(r)=gamma(r)phi(r)=r(1-2r)^2(1-5r).               (7)

Each is continuous to the zero correction above one half. They have uniformly bounded derivatives: |A'|<=1, |B'|<=9/8, and |C'|<=2. For A' after u=2r the Bernstein coefficients on [0,1] are (1,-1,0,0); for C' they are (1,-2,1,0). The Bernstein basis is nonnegative and sums to one. For B=-r A/(1-r),

    |B'| <= [r/(1-r)] |A'| + A/(1-r)^2
           <= 1 + r(1-2r) <= 9/8,

using (1-2r)^2<=(1-r)^2. There are at most two path neighbors. Thus for every fixed bit history

    d p_{epsilon,r}(h)/dr >= 1-4epsilon >= 3/5.        (8)

The estimate is conservative, valid also at the endpoints by one-sided limits. Since p(0)=0 and p(1)=1, these are valid probabilities. Also p is increasing in each previously revealed bit: the early-minus-late correction is epsilon gamma^2/[r(1-r)]>=0. The exact root contribution is already included in C(r); it must move when r moves.

S3087 equation (3) states, for the **true** sequential conditional probability q_{epsilon,r}(h),

    |q_{epsilon,r}(h)-p_{epsilon,r}(h)| <= 2 epsilon^2, (9)

uniformly in the reveal history and the number of distinct labels. For r>=1/2 the error is zero. Set delta=4 epsilon^2 and s_+=min(1,r+delta), s_-=max(0,r-delta). Then for every monotone f_x,

    E_{Q_{epsilon,s_-}} f_x
       <= E_{D_epsilon}[f_x | t_x=r]
       <= E_{Q_{epsilon,s_+}} f_x.                    (10)

Proof: couple successive Bernoulli updates by the same independent uniforms. If the true history is coordinatewise below the upper-template history, monotonicity in history and (8)-(9) give q_r(h_true)<=p_{s_+}(h_upper), since (3/5)delta >= 2epsilon^2. If r+delta>1 use the all-one endpoint law. The lower comparison is symmetric, with the all-zero endpoint law when necessary. This is a comparison on shared labels, never independent CCT occurrences. All exact-root effects are included by using the template at s_+ or s_- throughout. At epsilon=0 the laws coincide.

Let F_x(s)=E_{Q_{epsilon,s}} f_x, a nondecreasing [0,1]-valued function by the same coupling argument. Extend it constantly beyond the endpoints. Integrating a translation of any such function changes its integral by at most delta. Therefore

    |integral_0^1 {P_{D_epsilon}(f_x | t_x=r)-F_x(r)} dr|
        <= 4 epsilon^2,
    |sum_x P_{D_epsilon}(f_x)-sum_x integral F_x(r)dr|
        <= 4 n epsilon^2.                            (11)

This is a depth-uniform global comparison, retaining the full conditional first-order interaction in Q. It repairs S3087's exponentially growing reveal-union bound for this comparison. It is not obtained from the support-size bound (5).

## Exact remaining obligation and resource boundary

Although every conditional template probability is affine in epsilon, the joint law Q is a product of sequential conditional factors. Its event probabilities generally have higher-order terms. D and Q have matching derivative at epsilon=0 for each fixed finite CCT, as follows from equality of the conditional first-order expansions. Equation (11) alone does not bound Q minus its own affine Taylor polynomial by O(epsilon^2) uniformly in height, nor prove a positive aggregate forcing gain under Q. Calling (11) a solution of equation (10)'s full mixed-moment charge would be incorrect.

For the identical selected graph H, the source's componentwise additive density has the same derivative at zero: differentiating either product_e(1+epsilon W_e) or product_components(1+epsilon sum_{e in component}W_e) gives sum_e W_e. Root conditioning has derivative normalization zero on these forest measures, so the first derivative of any fixed cut event agrees. This algebra does not transfer a positive coefficient from a bound against a smaller baseline. If F(epsilon)>=b+a epsilon-O(epsilon^2) and F(0)>b, subtracting F(0) and dividing by epsilon gives no lower bound a on F'(0). The actual source choices of low-label edges, TwoCC unary bias and other classifications also have to match before even the same-H equality applies. Those source hypotheses are not established here for an uncut long-path aggregate.

One sufficient remaining theorem is a direct lower bound on sum_x integral F_x(r)dr retaining the sibling contribution, paying repeated-label/root effects, finite-height baseline loss and structural terms for the actual source-admissible H. Another is a depth-uniform Taylor charge for Q combined with a proved positive aggregate first derivative. No such theorem is established here. Source distinct-label biased-node lemmas cannot simply be applied: the source requires independent distinct-label bits and its stated ancestor restrictions, while Q is sequentially dependent.

If a valid template forcing lower bound B(epsilon,h)n were supplied, (11) and the already proved path entropy bound would imply at sufficient implication strength

    sum_x P_D(Forced_w(x)) - KL_2(D||U)
      >= B(epsilon,h)n -4n epsilon^2 -.0064 epsilon^2 |E(H)|. (12)

This is an explicit conditional bridge, not a supplied B or an improved PPSZ exponent. For k=3 the cited source's sufficient CCT strength bound is w>=2^(h+1). Finite-height error, epsilon and fixed w must be chosen jointly with positive numerical slack before improvement is claimed. The resulting PPSZ operation remains uniform-order bounded implication and unbiased guessing, with polynomial n^{O(w)} cost per run at fixed w and exponential repetitions under available guarantees. H is solution-dependent proof data, not an algorithmic oracle. No polynomial witness finder, RP=NP, deterministic SAT algorithm, P=NP, lower bound, publication-ready breakthrough or priority claim is obtained.

No code, Lean source, public artifact, push, publication, paid computation or external communication was changed. Completed reviews support local preservation of this bounded analytic increment; broader goal completion is not claimed.

| Review lens | Actual review | Scoped decision |
|---|---|---|
| Proof adversarial | [Proof review](2026-09-12-mixed-charge-proof-review.md) | GO for the stated bounded results; improved forcing INCOMPLETE |
| Source / complexity | [Source/complexity review](2026-09-12-mixed-charge-complexity-review.md) | GO for the stated model and cost accounting; no favorable aggregate guarantee |
| Non-claims boundary | [Non-claims review](2026-09-12-mixed-charge-nonclaims-review.md) | GO for local preservation; publication HOLD |

These are three independent AI-agent reviews, distinct from the manuscript author, not Lean verification or external human peer review. The reviewed remainder bounds and a hypothetical positive first derivative would still need quantitative slack exceeding the applicable corrected-source bonus after all costs. No such improvement or novelty is established.
