# Finite bit coupling: an exact scalar carrier and its control cost

Date: 2026-09-08. Route: S3040 / E004 / S008. Harness-only research subtask.
Starting satellite HEAD: 028770f. No Lean theorem or fluid computer is claimed.

## What is established

An explicitly specified incompressible affine swirl/strain flow carries an
exact information-bearing passive-scalar mode. Diffusion destroys that mode's
fixed-margin bit contrast on sufficiently long accelerating runs. An explicit
reaction source restores arbitrarily many finite writes with a uniform error
bound, but its coefficient must pay for shrinking spatial wavelength in addition
to increasing clock frequency. The construction is a controlled mathematical
surrogate, not an embedding in the completed Navier-Stokes blowup solution.
It supplies no autonomous gate, external export mechanism, or polynomial SAT
algorithm. The precise control law below identifies what an embedding must realize.

Sources/context: local `2026-09-08-vortex-clock-attempt.md` and
`2026-09-08-material-carrier-analysis.md`. The source manuscript is
[Finite time blowup for Navier-Stokes](https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf).
All scalar-coupling results below are independent derivations under displayed
assumptions, not claims made by that manuscript.

## Exact advection-diffusion model

Let tau=T-t>0, fix tau0=T-t0, and take constants a, kappa, h, chi > 0.
Here chi is scalar diffusivity, distinct from the manuscript's D=1/2-h.
Let omega(t)=kappa*tau^(-1-h), rho(t)=(tau/tau0)^a, and
Phi(t)=integral_(t0)^t omega(v) dv. In Cartesian coordinates define

    u_perp(x,t) = -(a/tau)*x_perp + omega(t)*J*x_perp,
    u_z(x,t)    = (2*a/tau)*z,
    J(x,y)     = (-y,x).

This velocity is divergence-free. Its exact parcel map is

    x_perp(t) = rho(t)*Rot(Phi(t))*x_perp(t0),
    z(t)      = rho(t)^(-2)*z(t0).

A positive-radius parcel with z(t0)=0 rotates and contracts. A nonzero axial
position expands; this surrogate therefore also exposes axial positioning
sensitivity. On any finite truncated interval these formulas are smooth.
The velocity grows linearly at spatial infinity and has infinite global kinetic
energy. It is NOT the bounded-energy published field, nor a justified local
restriction of it. A global affine forced NS solution can be specified by
defining its force from the residual, but that does not fix the energy or
localization gap and is not used here.

Fix a nonzero planar vector k0 and define

    k(t)=rho(t)^(-1)*Rot(Phi(t))*k0,
    psi(x,t)=k(t) dot x_perp,
    lambda(t)=chi*|k(t)|^2 = chi*|k0|^2*(tau0/tau)^(2a).

Direct differentiation gives k'=-B^T k for B=-(a/tau)I+omega J;
therefore (partial_t+u dot grad)psi=0. Also Delta cos(psi)=-|k|^2 cos(psi).
For the passive scalar equation

    partial_t c + u dot grad c = chi*Delta c,

the exact bounded scalar solution c(x,t)=A(t)*cos(psi(x,t)) satisfies

    A'(t)=-lambda(t)*A(t).

The scalar is a concentration deviation about a reference level, not a
compressible material density. No shrinking-ring mass normalization is hidden.
The scalar is spatially extended; a localized bit requires further analysis.
In particular, evaluating a 3D scalar on a material circle does NOT generally
produce a 1D ring heat equation: radial and axial diffusion cannot be dropped.
The full-space mode above avoids that unjustified reduction.

## Passive bit theorem and exact finite horizon

Encode b in {-1,+1} by A(t0)=b. A registered parcel with psi=0 initially
continues to have psi=0; its exact read value is A(t). If a>1/2, set

    Lambda(t) = chi*|k0|^2*tau0^(2a)/(2a-1)
                *[tau^(1-2a)-tau0^(1-2a)].

Then A(t)=b*exp(-Lambda(t)). At a=1/2 replace the bracket formula by
Lambda=chi*|k0|^2*tau0*log(tau0/tau). At a<1/2 the same integral remains
bounded as tau tends to zero. These conclusions follow by direct integration.

For a>1/2 a required contrast m in (0,1) is retained precisely while

    tau >= [tau0^(1-2a) + (2a-1)*log(1/m)
             /(chi*|k0|^2*tau0^(2a))]^(-1/(2a-1)).

Thus a fixed chi, initial wavelength, and fixed absolute sensor tolerance
give a finite clock horizon for this passive encoding. Sign in exact real
arithmetic never changes: this is a contrast/noise obstruction, not loss of
the mathematical sign, a theorem against all encodings, or a Turing lower bound.
For additive detector error bounded by delta, the two intervals around
+exp(-Lambda) and -exp(-Lambda) overlap once exp(-Lambda)<=delta.

For tau0=kappa=1, h=1/q, the previous exact clock has
tau_M=(q/(q+M))^q. Therefore

    Lambda_M = chi*|k0|^2/(2a-1)
               *[((q+M)/q)^(q*(2a-1))-1].

For fixed a>1/2 and M exponential in input length, Lambda_M itself is
exponential in input length, and the surviving amplitude is exponentially
small in that already exponential value. Reading this *particular additive
signal* with an ordinary fixed-point absolute-error guarantee needs order
Lambda_M precision bits. A symbolic exponent/sign representation can remain
short; the detector model, not merely writing exp(-Lambda_M), causes this cost.
Alternatively the bound specifies how chi must shrink to retain a fixed margin.

## Explicit finite repeated-write construction

Introduce a reaction/source term in the same scalar PDE:

    partial_t c + u dot grad c = chi*Delta c - gamma(t)*c
                                 + K(t)*b_j*cos(psi) + eta(x,t),
    gamma(t)=4*omega(t),       K(t)=gamma(t)+lambda(t).

The command b_j in {-1,+1} is held on phase slot j<=Phi<j+1. Phase units are
chosen so one slot has integral omega dt=1; the slot need not be a full turn.
Alternating b_j is an input-independent repeated-write test. The forcing is
an added scalar reaction/control law; it is NOT the published velocity force.
There is no buoyancy or other scalar backreaction in this model.

With eta=0 and c(t0)=A0*cos(psi), |A0|<=1, the exact scalar solution satisfies

    A'=K*(b_j-A),       |A(t)|<=1.

At a slot endpoint, variation of constants gives

    |A_end-b_j| <= 2*exp(-integral_slot K dt) <= 2*exp(-4).

This produces repeated reliable overwrites for every finite M. An adversarial
space-dependent disturbance is also allowed. If |eta(x,t)|<=gamma(t)/16
and the initial departure from A0*cos(psi) has supremum norm <=1/16,
the parabolic comparison principle gives ||c-A*cos(psi)||_infinity<=1/16
at every time. One can verify the bound directly with constant upper/lower
barriers for the error equation e_t+u.grad e=chi Delta e-gamma e+eta.
We restrict to bounded classical solutions on the finite horizon; the affine
coordinate change also yields a uniformly parabolic equation there, so spatial
infinity introduces no boundary input. Commands are piecewise constant, giving
continuous mild solutions and classical solutions inside slots.

At the registered material probe psi=0, endpoint error is at most

    2*exp(-4)+1/16 < 1/8.

The last inequality follows from exp(4)>32, certified already by its Taylor
sum through degree four: 1+4+8+64/6+256/24 > 32. Therefore sign(c) has margin
at least 7/8 independently of M. With probe phase misregistration |delta psi|
<=1/4, the extra error is at most 1-cos(delta psi)<=1/32 because |A|<=1.
The margin is still greater than 27/32. This is an actual controlled PDE bit
theorem on this surrogate; it does not prove that the vortex supplies the source.

## Resource accounting and why the control is consequential

The deterministic ideal source magnitude is bounded by lambda+(33/4)*omega
when |c|<=17/16. Thus source capacity has to cover lambda as well as omega.
In particular

    lambda/omega = (chi*|k0|^2*tau0^(2a)/kappa)*tau^(1+h-2a).

When 2a>1+h, the diffusion compensation eventually dominates the clock-rate
reaction. Peak wavelength resolution is 1/|k_M|~tau_M^a; peak lambda is
Theta(tau_M^(-2a)). For the surrogate a=2, both are substantially more demanding
than the Eulerian r~sqrt(tau) sampling-circle scale. The parallel completed-carrier
analysis proposes a radius exponent a=(1+beta)/2, beta=-W0*d0/L0 approximately 3,
conditional on its stable-sheet proof and source estimates. That would put the
radius in this strong-compression regime, but radius matching alone does not
identify its full scalar transport/diffusion operator with this affine model.
We keep a symbolic here; a=2 is not an assertion about the completed flow.

The integrated coefficients on [t0,t_M] obey

    integral gamma dt = 4M,       integral lambda dt = Lambda_M,
    integral K dt = 4M+Lambda_M.

These are explicit controller-effort diagnostics, not automatically energy
or standard Turing cost. Logarithmic descriptions of their magnitudes remain
small. No claim that bounded fluid kinetic energy bounds them is made.

The disturbance tolerance is measured relative to gamma, not K. If the injected
pattern is misplaced by phase delta, its source error is at most K*|delta|
since cosine is 1-Lipschitz. A sufficient uniform actuator phase specification
is |delta|<=gamma/(16K). An injection amplitude error likewise must be at most
gamma/16 in absolute source units. A sufficient displacement specification is
|delta x_perp|<=gamma/(16K|k|). These tolerances become stricter when diffusion
dominates; they cannot be replaced by an assumption of fixed relative K-error.
Preparing and evaluating the co-rotating pattern and switching commands remains
a control operation. A short expression for it is not a demonstrated apparatus.
Smoothing command changes would require bounding their additional source error
or allocating guard intervals; the displayed theorem uses ideal finite switches.

## Local latching and external output boundary

At the finite endpoint t_M the probe yields a margin-separated local bit. A
separate finite register initialized with this value and evolving by

    y'=beta*y*(1-y^2)+nu,       |nu|<=beta/8,       beta>0,

retains the sign for all later times if initially 1/2<=|y|<=2. Indeed the
vector field points inward at y=1/2,2 and y=-2,-1/2; at y=1/2 its minimum
is beta/4>0. The probe margin and |c|<=17/16 put the transferred value in
these intervals even with sufficiently small additional transfer error.
This proves a robust register law, conditional on transporting and initializing
that value. It does not provide the transport or an autonomous sign-copy gate.

If the register is outside the shrinking region at distance d_M and transfer
speed is bounded by v, export before T requires d_M/v<tau_M. Even if
d_M~tau_M^a makes this inequality favorable for a>1, it does not put the
register at a fixed macroscopic observer location or prove a protected route.
For fixed positive d_M it fails at sufficiently late cutoffs for fixed v.
The global spatial extent of the scalar source must not be used to claim
instantaneous external readout: it would distribute the command b_j externally
as part of the actuator. That is not export of a computed unknown SAT result.

## Consequence for the actual proof attempt

The missing scalar-bit-to-fluid step is now more specific: construct a localized
material information mode and actuator in the completed flow, derive its
diffusion/stretch operator and realize the required reaction/source with bounded
backreaction, synchronization, and export error. Uniform passive dye rotation
does not supply the repeated-update law. The controlled construction succeeds
mathematically at each finite M but pays explicit spatial and integrated-control
costs and is driven by supplied b_j commands. It has not computed b_j from a
formula, built a gate network, or simulated M updates in polynomial bit time.

For alternating endpoint bits, even this robust construction has variation
at least (7/4)*(M-1) at its registered probe (margin 7/8). Clock acceleration
does not remove these changes. The standard complexity bridge still requires
the separate uniform SAT fast-forward theorem stated in the original attempt.
No result here establishes P=NP, P!=NP, a general fluid-computation impossibility,
or a resource bound for the published completed Navier-Stokes field.
