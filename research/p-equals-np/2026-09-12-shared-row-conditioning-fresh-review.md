# Fresh independent adversarial review of shared-row conditioning

2026-09-12; S3099 / E004 / S008. Scope: the mathematical full-source-PSD assertion in [the actual proof file](2026-09-12-shared-row-conditioning.md), equations (7)--(30). Integrity boundary: [INTEGRITY-CLAIMS.md](../../INTEGRITY-CLAIMS.md).

**Decision: PASS for the stated analytic PSD theorem.** I found no fatal mathematical defect in the reviewed argument. This is an independent human-readable mathematical audit, not machine verification, a novelty determination, an encoding/SoS lower-bound audit, or a P-versus-NP verdict. Publication and other required review gates remain separate.

Reviewed proof-file SHA256: `0F922F1CFF25156CEEC15BEA4107307CC4F125C998940A7D2403ED0A420C0276`.

The verified conclusion is: for even `n >= 1024`, `m = n^2`, `A = I_m`, and `D = floor(n/(32 log_2 n))`, the unchanged restricted bamboo source has `R(p^2) >= 0` for every actual Boolean-reduced ordinary-degree-at-most-D polynomial in the source X/Y/U variables. I did not inspect or rely on other reviewers' reports. I read the cached primary paper directly, including (35), Definitions 6.5--6.6, (36), Lemma 6.7 and its proof, and the definition of R following it. I supplied no repair, replacement construction, or additional hypothesis.

## Primary source and conditioning

Definition 6.5 uses the uniform distribution on augmented full-rank matrix pairs with prescribed product, including the fixed all-ones row and column. Equation (35) gives oddness of each unfixed row/column and the correct fixed corner for even n. Definition 6.6 evaluates U as actual prefix products. Lemma 6.7 counts admissible one-row extensions by a number depending only on the prescribed label/product data, not on the current matrix realization. Iteration therefore provides full complete-row marginal consistency, not merely consistency for selected low-degree observables. Complete-row point indicators are terms, so the paper's formulation using terms also suffices directly.

For a fixed supported separator realization, conditioning a uniform matrix-pair law leaves a uniform finite fiber. Its pure-X marginal is exactly the uniform affine X tuple law restricted to augmented full rank, because the relevant smaller source fiber has precisely those conditions. This marginal statement remains true after adding Y labels by source consistency. The symmetric statement holds for Y. This is essential: without these exact marginals, an operator bound with product-law norms would not imply the claimed maximal-correlation bound. Here the source supplies the needed equality.

## Adversarial checks of (7)--(18)

The supported separator has `dim U=r+1` and `dim V=s+1`. The annihilator of `U^perp` in `V^perp` is `U intersect V^perp`, of dimension `u-t`. Consequently the residual pairing rank is exactly `h=n-u-v+t`. The lower bound `h >= n-r-s-2` is uniform, including separators with deficient cross-pairing rank. Full rank of each augmented frame, rather than full rank of its cross-pairing matrix, is what is needed here.

Affine translations multiply rows and columns of the character kernel by unit-modulus signs. They do not remove the radical, change singular values, or require those signs to be constant on a radical coset. Computing the normalized Gram matrix gives signed rank-one blocks of size `2^(u-t)` inside a space of size `2^(n-v)`, hence nonzero eigenvalue `2^(-h)` and norm `2^(-h/2)`. This verifies (8), including its probability normalization.

An affine fiber intersects U either trivially or in a translate of `U intersect V^perp`; thus the deletion fraction in (9) is zero or exactly `2^(-h)`. Restricting both sides of an operator and renormalizing uniform measures costs the inverse square root of the two retained probabilities, bounded here by `1/(1-2^(-h))`. For the singleton coupling, deletion of Y vectors in V subtracts the same prescribed-dot count for every admissible X, since X's products with V were already fixed. This independently confirms regularity in the delicate singleton case.

For tuple channels, the direction pairing is the tensor product of the coefficient matrix C with the residual pairing. Its rank is `rank(C) h`, including rectangular C and all affine right-hand sides. Factoring a rank-k matrix through a k-dimensional space gives the valid overcount `2^(k(a+b))`; uniqueness of factorization is unnecessary. Summing these norm bounds yields (13), with no hidden `2^(ab)` normalization penalty: Fourier expansion already factors out `2^(-ab)` from the prescribed-output indicator.

The rank-deletion estimate works even after some earlier affine draws are dependent. Their span has dimension at most `u+i` and contains U, so its pairing with V has rank at least t. This bounds an affine intersection by `2^(u+i-t)` and gives (11) by the union bound. Independent rank conditioning on each operator side then has exactly the cost in (14). The restricted error kernel has norm at most gamma; its average has magnitude at most gamma; consequently `Z >= 1-gamma`. Exact source marginals established above justify centering with the claimed norms in (15).

For two same-side blocks, product conditioning on each block's admissibility contributes the denominator in (17). Combined full-rank conditioning is exactly the remaining source constraint. Consistency implies its success probability is constant for every first-block realization and also every second-block realization. Thus the nonnegative failure kernel F has row and column sums e in probability normalization; Schur's bound is `||F|| <= e`, not merely `sqrt(e)`. Removing the constant term on centered functions proves (18). No iid assertion after rank filtering is used.

## Common information and mixed grouping

I specifically tested the proposed route against shared deterministic information. The dot constraints are relations between the two blocks, not automatically common measurable functions of the individual blocks. Equations (14)--(15), with their exact marginals and positive normalization, bound all centered complete-row functions. Thus a nonconstant common function would contradict the proved norm bound whenever it is below one; no common-information subspace is discarded. Low-dimensional or exceptional supported separator frames cannot evade this argument, since h has the uniform lower bound above. Unsupported separator realizations never enter it.

The conditional covariance inequality (19) is valid for arbitrary finite laws: the covariance of conditional means is controlled by `rho(A;B)`, while conditional covariance is controlled by the supremum of conditional maximal correlations followed by variance Cauchy--Schwarz. Both terms use norms no larger than the unconditional norms. It does not require conditional independence or a product law.

To verify the exact four-term order, first split A symmetrically as `A_X,A_Y`, leaving B intact. Split B into `B_X,B_Y` in each resulting term. This gives precisely (20). In the last term, only jointly supported `(a_x,b_x)` assignments count. Marginal consistency identifies every resulting law with the appropriate pure-block law under the enlarged separator. Total label support remains unchanged. This avoids the internal-output density penalty without omitting internal outputs.

## Local complements and arbitrary polynomial sums

The decomposition in (22)--(23) needs existence, not uniqueness or mutual orthogonality of all proper-subset spaces. Finite-dimensional orthogonal projection onto the complement of their sum and induction supply existence. Each subset lift is isometric by source consistency, and components from different parent contexts may be summed in the same intrinsic space J_A.

For incomparable A,B, conditional expectation of `h_A` onto their proper intersection S is zero because J_A is orthogonal to every complete-row function on S; likewise for B. Conditional correlation therefore applies pointwise on supported S fibers, and averaging its bound uses Cauchy--Schwarz. Nested supports instead give exact zero pairing directly. This verifies every off-diagonal case in (26), including the empty context.

The high ordinary degrees of the decomposed row functions cause no source-domain substitution error. For each original pair of degree-D monomials, their union contains at most 4D typed labels. Both local evaluation identities hold almost surely in that union. Replacing them there and taking an ordinary finite expectation is valid. Marginalizing each component product to its smaller support gives (24), and finite regrouping yields (25). This never applies R outside its declared polynomial domain and never posits a global satisfying assignment. Deterministic U prefix evaluation makes the same argument apply to U-containing monomials; each source variable costs at most two typed labels.

Finally the diagonal-dominance estimate counts supports, not basis vectors or row states. Cauchy--Schwarz on the scalar component norms costs only `L-1`, regardless of local Hilbert-space dimensions or the number of monomials. Thus it handles unrestricted coefficients and arbitrary sums in the target polynomial space.

## Window and decision boundaries

With total support at most 4D, `tau <= 2^(-n/2+4D+1)` and all relevant deletion numerators are bounded by `d0=2^(-n+4D+2)`. For `t0,d0 <= 1/16`, the stated bounds `gamma <= 2t0`, `rho_opposite <= 4t0`, `e_ab <= 2d0`, and `rho_same <= 4d0` hold. Summing four terms safely gives `epsilon_D=16t0`. Empty blocks contribute zero.

For every even n at least 1024, the selected D is at least one, `4D <= n/8 <= n-2`, and the preceding smallness conditions hold. The support count satisfies `L <= 2(2n^2)^(2D)` and `log_2 L <= 1+6D log_2 n <= 1+3n/16`. Combining with `4D <= n/8` gives `L epsilon_D <= 2^(-3n/16+6) < 1/2`. Hence (27) implies (30) uniformly throughout the claimed window.

No blocking issue or necessary mathematical repair was found. The earlier unit-weight comparison (6) remains unproved and is not used in this decision. This PASS certifies only the displayed analytic argument under its exact stated source and parameters. It does not certify formal Lean implementation, novelty, efficient evaluation, proof-system encoding consequences, or any general complexity-class conclusion. No experiment, implementation change, commit, push, release, paid computation, or outreach was performed in this review.
