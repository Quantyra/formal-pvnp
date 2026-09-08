# Source verification and method transfer for the P=NP attempt

Date accessed: 2026-09-08. Planning route: S3040 under E004/S008 in Quantyra-Planning.
Status: primary-source identification and exploratory methodology only. The analytical proof and Lean dependency closure have not been independently audited or built in this task. This note proves neither P=NP nor P!=NP and makes no claim that Navier-Stokes results imply either conclusion.

## Verified source and exact scope

OpenAI published its announcement on September 8, 2026, linking an analytical manuscript and Lean repository. It describes coordinated agent groups, exploration of alternative formulations, exchange of intermediate insights, and subsequent formalization. These are reported process facts, not an assurance that the available research setup can reproduce the result.

- Announcement: https://openai.com/index/navier-stokes-solution/
- Manuscript, *Finite time blowup for Navier-Stokes*: https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf
- Formal source: https://github.com/openai/NavierStokesAndEuler

The manuscript's Theorem 1.1 asserts, for every viscosity greater than zero, smooth compactly supported forcing, zero initial velocity, and a smooth incompressible flow on R^3 through times below 1, with bounded kinetic energy but unbounded velocity approaching time 1. Velocity and pressure have uniformly compact spatial support. It concludes that no global smooth bounded-energy solution exists with those data. Corollary 10.6 covers the periodic torus. Its construction uses a concentrating vortex, oscillatory pulses cancelling singular residual stress, and successive corrections leaving smoothly extendible forcing (sections 2-3). This is the original viscous equation with forcing, not an averaged equation; it does not establish unforced Navier-Stokes blowup.

Clay's alternatives C/D explicitly allow smooth forcing, whereas A/B assume zero forcing. The distinction is part of the official target, not an invented relaxation. The repository also contains a separate unforced Euler claim.

- Clay/Fefferman official formulation: https://www.claymath.org/wp-content/uploads/2022/06/navierstokes.pdf

## Formal verification evidence and limits

The repository specifies Lean 4.34.0-rc2 and Mathlib, with `lake exe cache get` and `lake build`. Comparator instructions use `landrun`, `lean4export`, and `nanoda_bin`, then `lake exe comparator ComparatorChallenges/NavierStokes.json`; reference statements are adapted from Google DeepMind Formal Conjectures.

- Comparator instructions: https://github.com/openai/NavierStokesAndEuler/blob/main/ComparatorChallenges/README.md

Published source and instructions establish auditability, not an independently reproduced audit here. A stronger verification statement requires a pinned commit, actual build/check outputs, dependency and axiom inspection, and comparison of formal definitions with the analytical and Clay statements. None was performed in this source-identification task.

## Classical P=NP target

Cook defines the problem using deterministic versus nondeterministic polynomial-time computation, with worst-case runtime bounded by one fixed polynomial in input length. SAT and 3-SAT are NP-complete. Accordingly, a constructive route can target one uniform deterministic SAT decider with a correctness proof for all instances and a polynomial runtime proof in the standard discrete model.

- Cook official formulation, sections 1-3: https://www.claymath.org/wp-content/uploads/2022/06/pvsnp.pdf

## Proposed transfer obligations

These are research proposals inferred from the source mechanism, not theorems transferred from fluid dynamics.

1. Start with an explicit SAT algorithm and invariant. Identify exactly which residual prevents correctness or the polynomial bound: representation growth, precision, convergence, branching, or recovery.
2. Try corrections that remove that residual while preserving the invariant; account for the entire correction cost. An existence argument for corrections is insufficient if finding them already requires solving SAT.
3. If using a continuous flow, prove uniform finite encodings, polynomial precision and simulation cost, and reliable discrete output recovery. Finite physical time, bounded energy, or asymptotic convergence alone does not establish polynomial bit-time.
4. Include unsatisfiable inputs and adversarial families. Finite experiments can refute a universal candidate but cannot establish the universal runtime theorem.
5. Preserve explicit stop-loss criteria: reject circular oracles, hidden exponential state, unbounded precision, and iteration counts without polynomial bounds. Record the failed obligation before continuing a new mechanism.
6. Formalize substantive corrected steps only when their definitions faithfully express the discrete target; then obtain independent proof, complexity, and claims reviews. Green wrappers around an assumed missing lemma do not discharge it.

## Routing and non-claims

The parent orchestrator owns the planning literature-trigger decision for T2/T3 and S3040. Domain work belongs in this satellite. This note modifies no formal code, README, release metadata, or approved public claims. No implication from the Navier-Stokes construction to P=NP is currently supplied.

## Vortex-clock clarification (2026-09-08)

Source: manuscript above, section 2.1 (printed p.4), section 3.1 (p.8), Theorem 3.1(iv), equation (3.6), and Proposition 9.9 Step 5 (p.116). The fixed profile parameter satisfies 0 < h < 1/100. The completed local field obeys, at r = sqrt(2 X_in tau), z = 0,

    u_theta = tau^(-1/2-h) [e0 + O(tau^(2h))], e0 > 0.

Annular corrections vanish there. Section 3.1 explicitly distinguishes the shrinking similarity core from a transported material region. These passages establish a moving sampling locus, not a material-clock trajectory theorem.

Derived conditional clock calculation: division by r gives sampled angular velocity C tau^(-1-h)[1 + O(tau^(2h))], C = e0/sqrt(2 X_in) > 0. Integrating that sampled rate from a fixed late starting time to t = 1-tau gives accumulated angle (C/h) tau^(-h) + O(1). The integrated error is bounded because its integrand is O(tau^(-1+h)). Dividing by 2 pi gives the corresponding idealized count N = Theta(tau^(-h)). Consequently N = Theta(2^n) requires tau = Theta(2^(-n/h)) and r = Theta(2^(-n/(2h))), with h fixed and constants depending on the chosen profile and count convention.

For this integral to count turns of a fluid parcel, a separate result must provide a trajectory satisfying dr/dt = u_r, dz/dt = u_z, dtheta/dt = u_theta/r, and remaining in a region with the required sign and two-sided angular-rate bounds under the completed flow. The fixed-similarity sampling curve alone does not satisfy those equations by definition. No such trajectory estimate was established in this source review; this is an outstanding obligation, not a nonexistence assertion.

Precision distinction: an exponentially small positive scale does not by itself require exponentially many description bits. For fixed h, ordinary binary approximation at comparable absolute scale uses O(n/h) fractional bits; exponent-based symbolic descriptions may be shorter. This observation neither supplies nor rules out a polynomial-time flow simulator. Evaluation complexity, stability, initialization, tick addressing, input encoding, and readout remain separate questions; serial enumeration of 2^n ticks would itself take exponential discrete steps, whereas an unproved shortcut cannot be assumed absent or available.

### Test of the particular z=0 sampling circle

Source identities: equations (4.3), (4.7), printed pp.25-26, give r*u_r^(0) = V0 and u_z^(0) = q^(-A) U, with V0(X,0) = -X * partial_eta A_X(U)(X,0), where A_X is radial averaging. Appendix B.1, equation (B.1), p.144, specifies U(0,eta) = 4 eta + j0, 0 < j0 <= 0.05. The background corrections use increasing powers q^(2h) (section 5.1); annular corrections vanish on the inner sampling region.

Derived necessary conditions: if a material path had exactly z=0 and r=sqrt(2 X tau) for a fixed X>0, then differentiation requires r*u_r=-X and u_z=0. The leading coefficients would therefore have to satisfy V0(X,0)=-X and U(X,0)=0. However, continuity at the axis gives U(X,0) -> j0>0 and V0(X,0)/X -> -4 as X decreases to zero. Thus at sufficiently small fixed positive X both leading conditions fail. The higher-order background asymptotics cannot cancel these fixed nonzero leading discrepancies for all sufficiently late times. This excludes that particular fixed-similarity, z=0 material-circle ansatz near the axis; it does not exclude other trajectories, a moving axial coordinate, trapped structures, or other information-retention constructions. No computing possibility or impossibility follows from this bounded test.
