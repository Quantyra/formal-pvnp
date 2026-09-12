# General-degree moment correction: construction and quantitative limits

2026-09-12; S3095 / E004 / S008; [integrity](../../INTEGRITY-CLAIMS.md). Analytic author record. **The requested growing-degree full X/Y/U positivity theorem remains unresolved.** This audit gives a noncircular output-character inverse with quantitative eigencontrol, an explicit full-feature signed extension of the existing source functional, and general quantitative obstructions to two proposed positivity criteria. Neither construction proves full positivity. The signed extension is a representation of the already-defined source functional, not a new feasible pseudoexpectation or a new positivity mechanism. Publication HOLD.

## Source, variables, and degree

Use Garlik--Gryaznov--Ren--Tzameret, [TR26-133](https://eccc.weizmann.ac.il/report/2026/133/), Definitions 6.5--6.6, equation (36), and Lemma 6.7. The cached primary source text and the previous [kernel audit](2026-09-12-rank-kernel-quotient.md), [full-positivity audit](2026-09-12-weak-rank-full-positivity.md), and [X-only extension](2026-09-12-weak-rank-extension.md) were read. This is the restricted bamboo rank encoding, not the source's separate perfect-matching SoS result.

Take even n, m=n^2, A=I_m, e=(1,...,1), and N=2^(n-2). Distribution mu samples all m X rows and m Y columns independently, uniformly from odd vectors of F_2^n, and assigns actual U variables their true prefix dot products. Write V_D for the Boolean-reduced full ordinary-degree-at-most-D polynomial space. Each variable touches at most two sampled rows, so 4D<=n-2 suffices for every square in V_D to lie in the source functional R's domain.

For an interior edge a=(i,j), let epsilon_a=(-1)^A_ij (-1)^(X_i dot Y_j) and z_a=(1-epsilon_a)/2. In the actual variables epsilon_a=(-1)^A_ij(1-2u_ijn), so these are degree-one polynomials. Source output constraints set every epsilon_a to one. Gate relations hold pointwise under mu; the prescribed interior outputs generally do not.

## An explicit inverse at all admissible output orders

Let E=[m]x[m], B_r=sum_{j=0}^r binom(m^2,j), and index a matrix by subsets S of E with |S|<=r, including the empty set. Put epsilon_S=product_{a in S}epsilon_a and

    G_r(S,T)=E_mu[epsilon_(S symmetric-difference T)].

For every nonempty simple edge set H,

    |E_mu epsilon_H| <= 1/N.                              (1)

Here is a direct graph proof which does not treat cycles as independent. Translating one odd vector by e preserves its distribution, because n is even, and flips every incident dot-product sign, because every neighboring vector is odd. Thus the expectation is zero unless every nonisolated vertex has even degree. In the remaining case choose one vertex. It has an even positive number of distinct neighbors. Averaging its odd vector gives zero unless the sum of those neighbor vectors is 0 or e; the average then has magnitude one. The sum of an even positive number of independent uniform odd vectors is uniform on the even hyperplane, of size 2^(n-1)=2N. The exceptional event therefore has probability 1/N. All other factors have magnitude one, proving (1), including when H has multiple or overlapping cycles.

Since G_r has diagonal one, the absolute row-sum bound gives

    ||G_r-I||_op <= eta_r := (B_r-1)/N.

If eta_r<1, its eigenvalues lie in [1-eta_r,1+eta_r], and the following convergent formula is explicit:

    c = sum_{k=0}^infinity (I-G_r)^k 1,
    W_out,r = sum_{|S|<=r} c_S epsilon_S,
    F_out,r(p)=E_mu[W_out,r p].                           (2)

This is an actual invertibility proof, not a presumed solution of an unspecified feasibility problem. Truncating the series after k=K has Euclidean coefficient error at most sqrt(B_r) eta_r^(K+1)/(1-eta_r). The exact formula gives

    F_out,r(epsilon_T)=1 for every |T|<=r,
    E_mu W_out,r=1,
    B_r/(1+eta_r) <= ||W_out,r||_2^2 <= B_r/(1-eta_r).     (3)

The norm equality used here is ||W_out,r||_2^2=1^T G_r^(-1)1. It is a signed density; no pointwise nonnegativity is asserted.

For example, for even n>=16 set

    D=floor((n-5)/(8 log_2 n)),  r=2D.

When D>=1, B_r<=2(m^2)^r=2 n^(8D)<=2^(n-4)=N/4, so eta_r<1/4. Also 4D<=n-2. Thus the inverse exists on a growing D=Omega(n/log n) window, at m=n^2. This count is exponentially large in n; the formula is not a polynomial-time construction.

Taking r=2D calibrates every output-only moment needed for V_D squares, and gives a PSD output-only Gram. It does **not** establish output annihilation against arbitrary mixed X/Y/U multipliers. In particular, conditioned on two X vectors, integrating a shared Y vector produces

    E_y[(-1)^(x dot y)(-1)^(x' dot y)]
      = 1_{x'=x} - 1_{x'=x+e}.                           (4)

This is a same-side collision function, not a scalar cycle correlation or an edge character on the conditioned X-only rows. The scalar inverse equations in (2) do not supply its full-feature cancellation identities. Equation (4) identifies an additional obligation; it is not a proof that (2) fails every such identity. No further finite-order patch is pursued here.

## Full-feature signed construction from the actual local laws

There is a direct finite construction that does satisfy all the full-feature moment identities, using the source's existing consistent local laws. Let B be the set of 2m row labels, with X and Y labels distinct, and set t=4D<=n-2. For S subset B with |S|<=t, let rho_S be the actual source law on those complete vectors. Relative to the full-support product law mu_S, define

    d_S = rho_S/mu_S,  d_empty=1,
    h_S = sum_{T subset S} (-1)^(|S|-|T|) d_T,
    W_t = sum_{S subset B, |S|<=t} h_S.                  (5)

Every density d_T is lifted to the variables in S when used in h_S. More concretely, the source rho_S is uniform on the finite set of odd-vector assignments satisfying the required full-rank and prescribed cross-dot-product conditions. Hence d_S is the indicator of that set divided by its mu_S probability. Lemma 6.7 proves this set nonempty throughout the declared domain and proves consistency; no unknown feasibility parameter is being assumed.

If b belongs to S, integrating h_S over row b gives zero: pair each summand indexed by T not containing b with its partner T union {b}, and use source consistency to integrate d_(T union {b}) to d_T. Consequently, conditional expectation on any row set R0 of size at most t kills every h_S with S not contained in R0. Finite Mobius inversion then proves

    E_mu[W_t | rows R0] = sum_{S subset R0}h_S = d_R0.    (6)

It follows that E_mu W_t=1 and F_t(p):=E_mu[W_t p] equals the unchanged source R(p) for every full-variable polynomial of ordinary degree at most 2D, monomial by monomial. U is evaluated by its true prefix function on its endpoints. Thus all Boolean/Hankel identities and all source gate/output identities with common row support at most t hold exactly. This includes R(kp)=0 for k in the earlier truncated relation span K_D and p in V_D.

The construction conditions only on possible local sets, never on an impossible global satisfying assignment. It is a source-specific Mobius/Hoeffding realization of the general signed-extension phenomenon, not a new consistency theorem. The source reviewer supplied this construction; the proof reviewer independently checked it. In particular,

    F_t(p^2)=R(p^2) for all p in V_D.                    (7)

Thus its full PSD problem is exactly the original unresolved problem. Equation (5) does not resolve it by changing representations.

## General quantitative obstruction to raw iid perturbation

The following obstruction holds for **every** candidate functional F that assigns all output products of degree at most 2D the value one, including both constructions above. Fix the m pairwise disjoint diagonal output edges. Their epsilon signs are independent and balanced under mu. Let

    h_d=sum_{j=0}^d binom(m,j),
    chi_S=product_{i in S}epsilon_(i,i), |S|<=D.

The comparison Gram on these h_D genuine degree-at-most-D polynomials is exactly I. Boolean cancellation and output calibration give

    E_mu[chi_S chi_T]=1_{S=T},
    F(chi_S chi_T)=1 for all S,T.                         (8)

Therefore the corrected Gram on this whole matching subspace is exactly 11^T: one eigenvalue h_D and h_D-1 zero eigenvalues. Its operator distance from the iid Gram is h_D-1 (for D>=1). Taking p=h_D^(-1) sum_{|S|<=D}chi_S gives E_mu p^2=1/h_D but F(p^2)=1. Consequently a raw estimate

    |F(p^2)-E_mu p^2| <= eta E_mu p^2 for all p in V_D

requires eta>=h_D-1. For a scaled reference a E_mu with a>0, the best possible relative error on this block is at least one, because the corrected form has nonzero null vectors of positive iid norm. Hence the criterion eta<1 needed for a small-relative-error PSD transfer cannot hold even after scalar rescaling.

There is also a density-level obstruction. If F(p)=E_mu Wp for a square-integrable signed W with these moments, Bessel's inequality applied to the orthonormal matching characters of size at most 2D yields

    ||W||_2^2 >= h_(2D),    ||W-1||_2^2 >= h_(2D)-1.    (9)

At m=n^2 and D asymptotic to c n/log_2 n for any fixed c>0, these costs are exponential in n. Indeed h_D>=binom(m,D)>=(m/D)^D, and D log_2(m/D)=Omega(n). The source-degree condition 4D<=n-2 and matching condition 2D<=m both hold eventually. This is a general degree-dependent obstruction to small global iid-density perturbations, not another fixed-density order counterexample. Formula (3) already exhibits the same large-norm behavior for the explicit inverse.

These calculations do not negate PSD: the exact matrix 11^T is PSD. A comparison that already incorporates the output kernel, potentially with large weights in its nonzero directions, is not ruled out. The obstruction is to the stated raw iid norm criterion; it does not falsify the sought full hierarchy.

## No globally nonnegative true-prefix density

There is a separate all-order quantitative fact. For a true-prefix assignment let V=sum_{a in E} z_a, the number of incorrect interior outputs. In F_2, the error matrix is I_m+XY. Its rank is at least m-rank(XY)>=m-n; its rank is at most its number V of nonzero entries, since it is the sum of V rank-one elementary matrices. Thus, pointwise,

    m-n <= V <= m^2.                                    (10)

Any normalized representing density W that matches the output moments obeys E_mu[WV]=0. Writing b=E_mu W_- and E_mu W_+=1+b, equations (10) give

    0 >= (m-n)(1+b)-m^2 b,
    b >= (m-n)/(m^2-m+n) > 0.                           (11)

No such global density is nonnegative, regardless of its degree. This is compatible with a positive truncated moment functional: low-degree PSD does not require a nonnegative global density on the inconsistent true-prefix assignment space. It does not decide PSD of either candidate.

## Disposition and verification boundary

The all-D scalar output inverse is constructively invertible with controlled eigenvalues on the declared growing-degree window. The separate Mobius construction solves exact full-feature signed moment representation. The full PSD conclusion for growing D at m=n^2 is still missing. The general matching spectrum and density lower bounds explain why applying a raw iid small-perturbation estimate to either construction cannot fill that gap. No general obstruction to a kernel-compatible PSD construction has been proved.

The author supplied the output inverse and its graph bound, the matching-space quantitative norm obstructions, and the rank-based negative-mass bound. The source reviewer supplied the Mobius construction and the conditional collision diagnostic. Separate actual-file reviews record their own checks and contributions; no independent decision is presumed here. No Lean implementation, numerical experiment, proof of a SoS lower bound, complexity separation, commit, push, publication, outreach, or paid computation forms part of this author task. Do not publish this signed interpolation as a positivity advance, and do not mark the full target complete.

## Actual-file three-lens closeout

| Lens | Actual saved review | Decision and scope |
|---|---|---|
| Independent proof | [Proof review](2026-09-12-rank-hierarchy-proof-review.md) | PASS for the displayed constructions, parameter window, and quantitative bounds; full mixed PSD INCOMPLETE. |
| Source/complexity | [Source and model review](2026-09-12-rank-hierarchy-source-review.md) | GO for accurate source mapping, signed-extension provenance, degree/resource accounting, and bounded criteria obstructions. |
| Independent non-claims | [Non-claims review](2026-09-12-rank-hierarchy-nonclaims-review.md) | GO for local preservation; publication HOLD, no general hierarchy no-go or complexity consequence. |

All three reviews read the actual saved author record. The source reviewer contributed the classical ANOVA/Mobius signed completion and conditional collision diagnostic; the separate proof reviewer independently checked the adopted mathematics and supplied no construction or repair. These are AI-agent reviews, not Lean verification, human peer review, or novelty certification. The [S3095 graph entry](2026-09-11-research-meta-graph.md) preserves these limited conclusions. Full polynomial-row growing-degree positivity remains unresolved and the broader objective ACTIVE; this is not route-final completion. Integration performs a scoped five-file local documentation commit only. Both existing public notes remain unchanged; no push, publication, outreach, or spend is authorized by this closeout.
