# Independent proof-adversarial review: completed carrier and scalar bit

Date: 2026-09-08. Route: S3040 / E004 / S008. Harness-only reviewer; no OpenCode. Reviewed the completed-carrier and finite-bit-coupling drafts, prior material-carrier and source notes, and the cited primary manuscript. No Lean implementation was changed or certified.

**Verdict: GO-WITH-NOTES for the two bounded mathematical derivations.** The completed-flow carrier existence implication is justified conditional on the manuscript's construction and estimates. The affine scalar PDE theorem is an independent exact controlled surrogate. Neither supplies effective initialization of the completed carrier, a localized writable fluid bit, external export, or a uniform polynomial-time SAT algorithm. These remain open; this verdict does not close the research objective.

## Primary-source audit actually performed

Primary source: [Finite time blowup for Navier-Stokes](https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf), accessed 2026-09-08. The following are checked dependencies, not an independent audit of the full manuscript:

- Lemma 5.1, printed p.47: positive-order axial and normalized angular axis data are zero; the common inner interval is independent of order.
- Equations (5.1)-(5.2): smooth angular factorization and the order-dependent radial term.
- Lemma 5.4/(5.35), pp.57-58: Cartesian derivative tail bounds with exponent loss independent of truncation; locally finite cutoff summation includes curl derivatives.
- Proposition 5.5 proof, pp.60-61: summation applies on compact profile ranges including the axis. Its displayed annular estimate (5.42) alone would be insufficient.
- Section 8.2/(8.4), pp.89-90, and Definition 9.4: supported corrections and radial primitives preserve the fixed inner exclusion.
- Proposition 10.1, pp.117-118: eventual equality with the local field on a fixed spatial neighborhood.

## Completed carrier: independent implication check

The normalization must be applied to the completed velocity, not just a leading profile. Independently differentiating S=q^(1-A) X Mhat with q and eta varying at fixed physical radius reproduces the draft's term -2 eta q partial_q Mhat. This term cannot be omitted on the cutoff transition bands. Substituting the resulting radial velocity into the chain-rule X equation cancels its 2 eta Uhat terms, giving exactly the displayed What. The q, eta and theta equations have the consistent time conversion ds/dt=1/(qL).

The claimed near-axis extension does not require an unjustified division by a pointwise small radius. For a smooth odd transverse component, f(y)/y is an integral of f'; the same operation on derivatives of an even component converts derivatives in X=y^2/2 to finitely many y derivatives. These integral formulas stay in the fixed compact profile rectangle. Repeated q partial_q and eta derivatives of the coordinate pullback incur only fixed powers of q for a fixed requested derivative count. Choose that count first, then choose a sufficiently high truncation J in (5.35). Since its decay exponent grows with J while the loss is fixed, the normalized tail and required derivatives are O(q^(2h)). The finitely many retained positive-order terms obey that estimate individually. This order of quantifiers is essential and is respected in the draft.

The completed axial trace is unchanged because transverse differentiation does not differentiate q-dependent summation cutoffs. The angular coefficient is summed directly and has the same zero positive-order trace. Radial averaging, its eta derivative and q derivative therefore yield the claimed exact axis value of What. Multiplication by the q cutoffs does not create inner support for any annular potential. Thus the O(X) axis departure is uniform in small q, rather than merely pointwise smoothness at each time.

For rho=q^h, a correction H=O(q^(2h)) has partial_rho H=(q partial_q H)/(h rho)=O(rho). Mixed X and eta derivatives have the same limiting continuity. This is sufficient for a C1 extension at rho=0, including What, since the estimate is available for the additional q derivative it contains. A C1 extension across X=0 is also available from these uniform one-sided derivatives. No nonexistent differentiability of q itself at rho=0 is needed: the compactified equation uses rho'=h rho(-1+2 eta Uhat).

The equilibrium linearization is triangular in the stable versus unstable decomposition, with eigenvalues -hk, w, a of signs negative, negative, positive. The stable eigenspace projects invertibly onto (rho,X). The ordinary local C1 stable manifold is therefore a graph. The exact axis line is forward stable, so local uniqueness puts that line in the graph, giving g(rho,0)=0 and hence g=O(X). Positivity follows from the multiplicative rho and X equations. Choosing a sufficiently small forward stable neighborhood keeps these trajectories inside the inner region.

On that graph, the exact axis traces improve q'/q+k and X'/X-w to O(X). An initial exponential upper bound for X makes both logarithmic errors integrable. Their convergent integrals give positive multiplicative asymptotic constants, not only exponential rates. In fact the remaining integrals are O(X), which justifies the relative O(tau^beta) angular-rate error used later. Since beta>h, integration gives the finite constant and O(tau^(beta-h)) remainder in the angle law. Shrinking initial time places the whole trajectory in the final localization neighborhood.

This is a source-dependent existence proof for a positive-radius point parcel in the completed inner flow. It does improve the earlier leading-only candidate. It is not an effective construction of its initial stable-sheet coordinate.

### Defect found and corrected during review

An earlier draft inferred possibly nondiverging total translational speed from the vanishing tangential speed r theta_dot. That inference was false for this carrier: eta0<0, so Uaxis=-D eta0/d0>0 and u_z is asymptotic to q^(-A)Uaxis, which diverges. The current draft explicitly distinguishes vanishing tangential speed from diverging axial and total speed. I re-read this correction on disk. The correction does not alter the carrier or clock theorem.

### Finite-error estimate

For e=eta-eta0-g(rho,X), define the flattened equation by the ordinary chain rule. Its e derivative differentiates the original field in eta while holding rho, X and the first derivatives of g fixed. Thus the factorization e'=b e uses C1 g only; it does not silently require second derivatives of g. At equilibrium the rho and X vector-field eta derivatives vanish through their multiplicative factors, leaving b=a. Continuity provides a-epsilon <= b <= a+epsilon locally. Variation of constants yields the displayed additive-disturbance bound and its undisturbed lower bound. These bounds are explicitly conditional on remaining in the neighborhood and on disturbances being measured in the flattened equation. They do not automatically apply to arbitrary physical forcing errors.

The M-power tolerance and O(log M) precision statement have the correct fixed-parameter scope. Computing the center, constants, thresholds, and cutoff sequence is still an additional obligation. Two opposite point tracers are a geometric separation demonstration, not a robust finite-volume memory theorem.

## Scalar coupling: independent exactness check

The affine flow has trace zero. Its planar map and inverse-transpose wavevector solve their linear ODEs exactly. Consequently the transported phase has zero material derivative and its cosine is an exact Laplacian eigenfunction with time-dependent eigenvalue -|k|^2. The amplitude equation, integrated diffusion exponent, finite-contrast threshold, and logarithmic special case a=1/2 all have the correct signs and powers.

For a>1/2 and exponential tick count, the integrated diffusion exponent is exponential for fixed nonzero diffusivity and initial wavevector. The claimed fixed-point precision cost is valid for the stated absolute-error additive detector model. It is appropriately distinguished from a short symbolic exponent/sign encoding and from a universal lower bound.

With the added source, substituting the mode yields A'=K(b-A), since K=gamma+lambda. Invariance of [-1,1] and integral K >=4 per complete slot give endpoint error <=2 exp(-4). The full-space error equation has constant barriers +/-1/16 under the displayed disturbance assumptions. The affine coordinate change on a finite horizon justifies the bounded-solution comparison argument. It does not discard radial or axial diffusion. Piecewise command endpoints are interpreted continuously, with classical equations inside each slot.

Combining comparison and endpoint estimates gives error <1/8. A phase error of at most 1/4 costs at most 1/32, since |A|<=1. The 27/32 margin is therefore conservative and valid. The deterministic source bound is lambda+(33/4)omega; this follows from |c|<=17/16 and includes both damping and injection but excludes the separately specified disturbance. Integrated coefficients and the stricter phase/displacement specification gamma/(16K) are consistent. Constant relative K-error would not meet that disturbance model in the diffusion-dominated regime.

The proposed register's intervals are forward invariant by the signs of the vector field at their four endpoints. This proves a register law after initialization, not transport of an unknown answer. The transfer deadline inequality is conditional on the stipulated path distance and speed. The text correctly refuses to treat a globally imposed actuator pattern as export of a computed result.

## Remaining proof obligations

No invalid scalar-to-completed-flow identification remains in these drafts. They are two separate results with a substantial coupling gap. Advancing the actual objective requires a localized information mode and specified actuator in the completed field, effective initialization and perturbation constants, a computable input-to-control map, gates and memory that calculate rather than receive commanded answers, both-output readout, and a uniform polynomial bit-work theorem. Exact finite-horizon solvability, small descriptions of cutoffs, and infinitely many modeled turns do not discharge these obligations. No P=NP or P!=NP conclusion is approved.
