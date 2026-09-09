# Localized transported bit in the completed velocity: controlled PDE attempt

Date: 2026-09-08. S3040 / E004 / S008. Starting satellite HEAD: `2637cbb`.
Harness-only research; no OpenCode, Lean theorem, commit, or public claim.
This is an informal conditional derivation requiring independent review.

## Result and its scope

For any fixed smooth incompressible velocity on a finite interval before the
singularity, a compact transported scalar packet admits reliable repeated
writes under the explicitly budgeted feedback below. It uses the actual
velocity and the full three-dimensional advection-diffusion operator. It does
not substitute the infinite-energy affine swirl for the completed velocity.
The feedback senses one weighted integral **inside the packet** and redistributes
that scalar value inside the packet. This is an added distributed sensor and
actuator primitive, not a local constitutive law supplied by Navier-Stokes.
There is no independent controller register carrying a duplicate target bit.

The construction does not furnish external output: its exact controlled mode
is zero outside its material support. Releasing the scalar gives a specific
mass-budget obstruction to fixed-volume, fixed-tolerance passive readout.
Neither statement is an impossibility theorem for alternative active devices.
SAT commands remain externally specified, and no standard polynomial-time
simulation or SAT algorithm follows.

Dependencies read: `2026-09-08-finite-bit-coupling-attempt.md`,
`2026-09-08-completed-carrier-attempt.md`, and their three continuation reviews.
The completed-carrier note supplies a conditional point trajectory in the
source construction; here only finite-horizon smoothness, incompressibility,
and specified derivative bounds are used. This note does not independently
audit the external Navier-Stokes proof. S3040's existing constructive-route
literature decision applies; the work is its localized-memory dependency.

## Finite material packet and geometric costs

Fix t0 < tf < T and a C3-in-space velocity u on this interval, with bounded
spatial derivatives through order three and enough temporal regularity for the
displayed equations inside write slots. Assume div u=0, globally defined flow
and its inverse, and bounded classical/mild scalar solutions. These hypotheses
hold qualitatively for a smooth spatially localized completed field on a compact
pre-singular interval; **effective bounds for that field are separate inputs**.

Let F_t(y) be the material flow starting at t0, L_t=F_t^{-1}, and let xc(t)
be its point trajectory from y0. Choose nonnegative smooth reference functions
phi and z with

    0 <= phi,z <= 1;
    phi=1 on |y|<=1/2; supp phi subset {|y|<=1};
    z=1 on a neighborhood of supp phi; supp z subset {|y|<=2}.

Put p(x,t)=phi((L_t(x)-y0)/ell) and zeta(x,t)=z((L_t(x)-y0)/ell),
with ell>0. Then D_t p=D_t zeta=0 and p(xc(t),t)=1. The support of p,
including the support of Delta p, is inside the region zeta=1. Both supports
are compact at every finite time. Incompressibility gives exactly

    integral p dx = ell^3 I1,   integral p^2 dx = ell^3 I2,
    Q := I1/I2 >= 1,
    volume(supp zeta) = ell^3 volume(supp z).

I1 and I2 are fixed positive reference integrals. A packet is therefore not
a shrinking material ball: its volume is conserved while its shape deforms.
A fixed positive-volume packet cannot stay inside balls whose radii tend to
zero. The conditional point carrier does not defeat this volume fact.

For quantitative estimates use norms induced by Euclidean tensor norms and set

    K_j(t) = sup_x ||D^j u(x,t)||, j=1,2,3;
    E(t) = exp(integral_t0^t K_1(s) ds);
    J_j(t) = integral_t0^t K_j(s) ds, j=2,3.

Differentiating D_t L=0 along a parcel gives bounds

    ||DL|| <= E,
    ||D^2 L|| <= H2 := E^2 J2,
    ||D^3 L|| <= H3 := E^3 (3 J2^2 + J3).

For example D_t(DL)=-(DL)Du; the Hessian equation has two Du terms
and the forcing -(DL)D^2u. The third-derivative equation has three Du
terms, three contractions of D^2L with D^2u, and one of DL with D^3u.
Gronwall with E>=1 yields the displayed conservative bounds. These estimates
may substantially overestimate stretching in a rapidly rotating field; they
are sufficient bounds, not necessary costs or lower bounds.

Let Cj=sup ||D^j phi||. Define

    P1 = C1 E/ell,
    H_p = C2 E^2/ell^2 + C1 H2/ell,
    P2 = 3 H_p,
    P3 = 3 (C3 E^3/ell^3 + 3 C2 E H2/ell^2 + C1 H3/ell).

Then ||grad p||<=P1, ||Delta p||<=P2 and ||grad Delta p||<=P3.
The factor 3 is a conservative contraction bound in three dimensions.
Replacing Cj by the corresponding constants for z gives mask bounds.
Thus the localization and diffusion costs have been evaluated in terms of
ell and explicit velocity derivative integrals; Delta p is not an unbudgeted
formal residual.

The forward-flow separation bound is |F_t(y)-xc(t)|<=E(t)|y-y0|.
For a desired open tube with pointwise clearance d(t)>0 around xc(t), the
sufficient condition 2 ell E(t)<d(t) for all t in [t0,tf] keeps the whole
mask in that tube. A finite interval with positive minimum clearance permits
some ell>0. It does not provide a uniform ell as tf approaches T. At least
the volume bound ell^3 volume(supp phi)<=4 pi R_f^3/3 is necessary if the
whole support must fit in a ball of radius R_f at tf. Finite-cutoff families
must budget ell as part of their initialization.

## A packet-local sensor removes the duplicate controller state

Define the scalar sensor functional

    A_t[c] = (integral c(x,t) p(x,t) dx)/(ell^3 I2).

It samples only the packet and satisfies A_t[a p]=a and
|A_t[e]|<=Q ||e||_infinity. It is mathematically a bounded rank-one
feedback primitive. Implementing it requires sensing, aggregation and control
communication across the distorted packet. No instantaneous physical sensor
is asserted. In particular, evaluating this integral in software cannot be
counted as a free real-number operation.

For prescribed commands b_j in {-1,+1}, held on clock slots with
integral_slot omega(t)dt=1, choose diffusivity chi>0 and

    gamma(t) = 4 omega(t) + 2 chi Q P2(t).

Consider the scalar equation on all of R^3

    D_t c = chi Delta c + f[c] + eta,
    f[c] = gamma (b_j p - zeta c) - chi A_t[c] Delta p.       (1)

All deterministic injection and damping in f is confined to supp zeta.
There is no material wall, artificial boundary condition or neglected radial
or axial diffusion. The last term compensates diffusion using the *measured
current scalar*, rather than a separately precomputed amplitude a(t).
At fixed finite cutoff the coefficients and this linear feedback are bounded;
standard finite-time parabolic solution construction with a bounded operator
perturbation applies. Alternatively the calculation below is explicitly
conditional on the stated bounded-solution class.

For initial c=a0 p with |a0|<=1 and eta=0, substitution in the **full**
equation gives an exact solution c=a(t)p, where

    a'=gamma(b_j-a),   |a(t)|<=1.                            (2)

Indeed D_t(ap)=a'p, A_t[ap]=a, zeta p=p, and the two chi a Delta p
terms cancel. Equation (2) is a derived amplitude law, not a controller state
that must be supplied separately. It still receives the commands b_j; no
gate computes them in this note.

## Uniform write error with local disturbances and sensor error

Let a solve (2) from a0. Let e=c-a p and assume ||e(t0)||inf<=epsilon.
With an exact sensor, allow |eta(x,t)|<=gamma(t) zeta(x,t) epsilon/2.
Then (1) gives

    D_t e = chi Delta e - gamma zeta e
             - chi A_t[e] Delta p + eta.                    (3)

The ball ||e||inf<=epsilon is invariant. At a hypothetical first upper
contact e=epsilon, diffusion is nonpositive and transport is handled by the
material derivative. Where Delta p is nonzero, zeta=1 and the positive
feedback error is at most chi Q P2 epsilon <= gamma epsilon/2; eta
uses at most the remaining half. Elsewhere Delta p=0 and local damping
dominates eta. The lower contact is identical with signs reversed. The usual
strict-barrier limit justifies non-strict contact and the whole-space bounded
solution formulation. This is a norm first-exit argument; it does not assume
the nonlocal operator preserves pointwise order.

An imperfect sensor with estimate A_t[c]+xi(t) adds the term
-chi xi Delta p. One sufficient allocation is instead

    |eta| <= gamma zeta epsilon/4,
    |xi| <= gamma epsilon/(4 chi P2)                        (4)

when P2>0. Thus the measured integral needs absolute error at most
ell^3 I2 times the right side of (4). Integral description length, quadrature
work, geometric registration and physical collection are distinct resources.
For actuator placement errors in the nominal diffusion pattern, a sufficient
additional source-error estimate uses chi |A_t[c]| P3 |delta x|;
it must fit an explicitly reserved portion of the eta budget. This estimate
does not cover arbitrary time-lag or distortion without further analysis.

At an endpoint of any complete clock slot, (2) yields

    |a_end-b_j| <= 2 exp(-integral_slot gamma dt) <= 2 exp(-4).

With epsilon=1/16 the center value satisfies
|c(xc,t_end)-b_j|<=2 exp(-4)+1/16<1/8. Thus there is an endpoint
sign margin exceeding 7/8, independently of the number of finite slots.
A detector registered by material label anywhere in the plateau phi=1 has
the same bound. A sufficient Eulerian center displacement bound to remain
in that plateau is |delta x|<=ell/(2E), using the inverse-flow Lipschitz
bound. Registration and sensing are still inside the packet.

## Source magnitude, derivative, integrated and evaluation costs

Under the error bound, ||c||inf<=1+epsilon and
|A_t[c]|<=1+Q epsilon. Hence

    ||f[c]||inf <= gamma(2+epsilon) + chi(1+Q epsilon)P2.

The source is supported on volume Vz=ell^3 volume(supp z), so its L2
norm is at most sqrt(Vz) times that bound. In the nominal solution the
source simplifies to gamma(b_j-a)p-chi a Delta p, and

    ||grad f[a p]||inf <= 2 gamma P1 + chi P3.

For perturbed c a derivative bound additionally needs ||grad c||; a
supremum error bound alone does not bound actuator spatial gradients.
Inside smooth slots the material derivative of the diffusion pattern is

    D_t(Delta p) = -(Delta u) dot grad p
                  - 2 sum_ij (partial_i u_j)(partial_ij p).

This identity identifies temporal tracking costs involving D^2u and D^2p;
time discontinuities of b_j are ideal finite switching, not free smooth
physical control. No finite bandwidth implementation is proved.

For M complete slots, the explicit damping budget is

    integral gamma dt = 4M + 2 chi Q integral P2 dt.

These are source/control diagnostics, not automatically kinetic energy,
minimum physical energy, or Turing lower bounds. In particular localizing
the source can reduce its L2 norm by a volume factor while increasing its
pointwise capacity, gradient and sensing precision requirements.

Computing p, Delta p and their registration requires inverse-flow evaluation
and derivative evolution. A direct procedure integrates a backward parcel
and its first and second variational derivatives, evaluates the reference
bump derivatives, and contracts them. Gradient control needs third derivatives.
It requires an evaluation oracle for the completed u and its derivatives,
error propagation through E,H2,H3, and quadrature for A_t[c]. No polynomial
cost oracle for the completed cutoff construction has been supplied here.
Even an oracle for u would not by itself provide cheap scalar-field solution
or integral evaluation. A tiny integral ell^3 I2 can have a short exponent
description while still demanding stringent absolute sensing error.

The nominal amplitude endpoint recurrence is
a_next=b_j+(a_current-b_j)exp(-integral_slot gamma). A direct simulation
with arbitrary commands has M sequential updates. Writing this recurrence
or using a vortex clock does not prove a polynomial-time way to calculate
the final SAT flag when M is exponential in input size.

## Why bounded pointwise feedback is not obtained by dividing by p

Replacing the sensor by c/p would formally produce the local reaction
-chi (Delta p/p)c on p>0. That coefficient is not uniformly bounded
for a nonzero nonnegative smooth compact bump. If Delta p<=C p held
everywhere for finite C>=0, p would be a nonnegative supersolution of
(Delta-C)p<=0 with an interior zero outside its support; the strong minimum
principle would force p identically zero. Therefore Delta p/p is unbounded
above somewhere approaching the support boundary. A direct compact bump
exp[-1/(1-r^2)] has the same divergence visibly.

This rules out that bounded-coefficient shortcut for exact compact support.
It does not rule out guard layers with small tails, nonlinear bistable
reaction, moving material walls, or other encodings. A local bistable
reaction c(1-c^2) would need a new subsolution and localization argument;
the affine-mode proof does not supply it. The rank-one sensing primitive in
(1) is thus an explicit remaining hardware mechanism, not hidden in notation.

## External readout attempt and a precise limitation

In the nominal controlled solution, c=a p is **exactly zero outside its
material support**, including where the scalar would otherwise diffuse.
The feedback cancels that diffusion. Any observer disjoint from this support
receives identical zero fields for the two opposite encoded bits. The local
sensor functional is not an external output channel. Exporting its result
would itself require a specified finite-speed communication mechanism.

Suppose at a finite read time tr<T the source is disabled and a nominal
stored value a(tr)p is released to passive advection-diffusion. Because
u is incompressible, mass is conserved and positivity is preserved. Thus

    ||c(t)||_1 = |a(tr)| ell^3 I1 <= ell^3 I1,  t>=tr,

as long as the smooth flow and passive equation exist. For a fixed macroscopic
detector with nonnegative normalized spatial weight w, integral w=1 and
||w||inf<=1/Vobs, its signed reading obeys

    |integral w(x)c(x,t) dx| <= ell^3 I1/Vobs.               (5)

This is independent of the transport path and diffusion rate. If the detector
has absolute error delta and ell^3 I1/Vobs<=delta, the possible readings
for opposite released nominal bits overlap. No such detector can guarantee
their signs by passive release alone. This is a fixed-volume average and
fixed-error limitation, not a point-sensor or active-amplification theorem.
It also excludes no proposed nonlinear exporter that obtains its energy and
gain from an explicitly budgeted extra mechanism.

A finite packet that must lie in a final shrinking ball has ell^3=O(R_f^3)
by volume conservation, so (5) makes the required passive detector tolerance
shrink with that volume. Keeping concentration order one locally and keeping
total fluid kinetic energy bounded do not eliminate this readout budget.
Allowing amplitude, detector resolution, or a local transducer gain to scale
could change the conclusion, but must be modeled and costed.

## What this changes and what remains

The previous affine surrogate's localization gap is narrowed to a finite-time
controlled packet **in the specified completed velocity**, conditional on its
effective derivative data. Full diffusion, compact support and a uniform
write margin have explicit formulas. Replacing residual feed-forward by
packet sensing avoids an independent controller register that already knows
the bit; it introduces an openly stated spatially nonlocal sensing actuator.
Both the volume constraint and the passive macroscopic readout limitation
are concrete new requirements for a finite-cutoff device.

The missing steps are realization of that sensing/feedback or an alternative
local reaction, actual finite-horizon geometry and computable derivative
bounds, scalar backreaction control, autonomous gates that calculate commands
from the input, and an active or otherwise quantitatively readable export
before cutoff. Throughout, c is a passive concentration deviation with no
buoyancy, viscosity change, stress, or force on u; this one-way coupling is an
assumption, not a proved physical decoupling. Finally, the full objective
requires a uniform all-input polynomial bit-time SAT algorithm. No result in
this note establishes that requirement, P=NP, P!=NP, or impossibility of
fluid computation.
