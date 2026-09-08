# Material-carrier analysis for the vortex-clock proposal

Date: 2026-09-08. Route: S3040 / E004 / S008. Status: exploratory derivation from published profile formulas; no formal verification or P=NP claim. This is a mathematical analysis of a candidate carrier, not an audit of the Navier-Stokes manuscript.

## Source and definitions

Source: OpenAI, *Finite time blowup for Navier-Stokes*, https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf (accessed 2026-09-08). Relevant locations: Lemma 4.1 and equations (4.1)-(4.8), printed pp.24-26; Appendix B.1, equation (B.1), p.144; Lemma 5.1, p.47; Proposition 9.9, pp.114-116.

Let tau=1-t, A=1/2+h, D=1/2-h, d=1-eta^2, L=1-2h*eta^2, with fixed 0<h<1/100. Similarity coordinates satisfy

    tau = q*d,    z = q^D*eta,    X = r^2/(2*q).

Write M=A_X(U) for the radial average of U. The leading axisymmetric flow has

    u_z = q^(-A)*U(X,eta),    r*u_r = V0(X,eta),
    u_theta = q^(-A)*E(X,eta),    F = E/sqrt(2*X),
    L*V0 = X*[2*eta*U - 2*D*eta*M - d*partial_eta M].

The source prescribes U(0,eta)=4*eta+j0, 0<j0<=0.05. Positive-order background coefficients have zero axial trace at X=0 (Lemma 5.1); annular corrections are absent near the axis. These facts motivate checking the completed field, but the system derived below is explicitly the leading system.

## Derived material equations

Apply the chain rule along a parcel, with dr/dt=u_r and dz/dt=u_z. Lemma 4.1 gives

    dq/dt = (-1 + 2*eta*U)/L,
    deta/dt = [D*eta + d*U]/(q*L),
    dX/dt = [X*(1-2*eta*U) + L*V0]/(q*L).

Define increasing rescaled time s by ds/dt=1/(q*L). Substitute the radial identity above. Then

    dq/ds = q*(-1 + 2*eta*U),
    deta/ds = Hc(X,eta) := D*eta + d*U,
    dX/ds = X*W(X,eta),
    W := 1 - 2*D*eta*M - d*partial_eta M.

For r>0, angular motion obeys

    dtheta/dt = q^(-1-h)*F(X,eta),
    dtheta/ds = L*q^(-h)*F(X,eta).

This last expression does not identify rotation of an on-axis parcel: cylindrical angle is undefined there. It can apply to a positive-radius path approaching the axis.

## Axis equilibrium and linear stability of the leading system

At X=0, set U*=4*eta+j0. The equation Hc(0,eta)=0 has one root eta0 in (-1,0): Hc/d = D*eta/(1-eta^2)+4*eta+j0 is strictly increasing on (-1,1). Its expansion for small j0 is

    eta0 = -j0/(4+D) + O(j0^3).

Thus -j0/4.5 is an approximation that also drops h. At this root U*=-D*eta0/d0, and

    dq/ds = -(L0/d0)*q,
    W0 = -3 + 8*h*eta0^2 - (1-2*h)*j0*eta0,
    partial_eta Hc(0,eta0) = 4+D -12*eta0^2 -2*j0*eta0.

The source bounds W*<-2.8 over the axis parameter interval. The axial derivative above is positive: eta0 lies in (-j0/4,0), so j0<=0.05 and D>0.49 make this immediate. The (X,eta) linearization is triangular, with diagonal entries W0<0 and partial_eta Hc>0. The leading equilibrium is therefore a saddle: radial similarity displacement contracts, axial displacement has an unstable mode. Coupling partial_X Hc need not vanish; the stable direction need not be exactly constant eta.

On the exact leading on-axis equilibrium, q decays exponentially in s and dt/ds=q*L0, so the remaining physical time is finite. The corresponding on-axis parcel has no angular clock. A candidate rotating carrier instead needs X>0 approaching the equilibrium along its stable direction.

## What the stable direction does and does not supply

The leading (X,eta) system is smooth at the axis. A local stable-manifold argument for its hyperbolic saddle is the appropriate next mathematical tool: the stable eigenvector has a nonzero X component, so the relevant branch can enter X>0. This is a proposed proof step, not a completed stable-manifold theorem for the corrected flow. It would require checking the domain extension or one-sided formulation, forward invariance of a small neighborhood, and positivity of radius for finite time.

Along a suitable leading stable branch, eta tends to eta0 and X tends to zero. Since F has a positive smooth axis value, the angular equation suggests retaining rapid accumulated phase on such a branch. This is more specific than following the z=0 sampling circle, whose material conditions fail near the axis. The limiting rates and quantitative error terms still need to be proved, especially after all background and annular corrections and localization.

Axial instability does not establish impossibility of retaining information. It does mean that a stable-manifold existence proof alone does not give a robust finite bit: one needs an explicit initialization tolerance, perturbation evolution, and an observation margin. A single exact trajectory can require parameter tuning without supplying an effective way to construct it. Exponentially small tolerances need not cost exponentially many bits, but their computation and propagation must be analyzed.

## Next explicit theorem target

For the completed local field, prove or refute the following carrier statement before claiming a clock suitable for computation:

1. There is a positive-radius material trajectory on a late interval [t0,1), specified by effective initial data, that stays in the inner region and approaches the axis similarity equilibrium (or a precisely specified corrected substitute).
2. Along it, two-sided positive bounds hold for q/(1-t) and q^(1+h)*dtheta/dt. Then accumulated turns have order (1-t)^(-h), by integration.
3. For each desired finite horizon, construct two distinguishable initialized states representing one bit, with explicit allowed perturbations and a specified readout. Prove the error and separation bounds through that horizon.
4. Bound the bit complexity of initialization and readout, including any stable-manifold tuning. Separate these costs from the cost of simulating intervening turns.

Items 1-2 are a rotating-carrier existence and clock estimate; items 3-4 are additional requirements for an effective retained bit. Even all four would not yet implement SAT evaluation, provide uniform random access to assignments, or establish a polynomial-time SAT decider. Those remain the original research objective's further obligations.
