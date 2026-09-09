# Sensor-controlled packet gates and a finite-speed output channel: conditional attempt

2026-09-08. S3040 / E004 / S008. Starting satellite HEAD `8a4ed10`.
Harness-only mathematical research; no OpenCode, Lean claim, commit or release.

## Result and dependencies

This note replaces externally prescribed *truth-valued* write commands by
sensor-computed NAND gates and regenerative holds. It proves a finite network
invariant with nonzero sensor and injection tolerances, including repeated
updates. A short input compiler and repeated gate schedule can enumerate SAT
assignments; its operation count is still exponential. The accelerated clock
does not change that count or supply an efficient Turing simulation.

The construction assumes the finite-horizon velocity, transported masks and
bounded-solution class of `2026-09-08-localized-bit-attempt.md`. That note and
`2026-09-08-effective-proof-review.md` were read. The effective source-field
certificate is still missing. The assumed packet-wide integral sensor and
distributed actuator are still added hardware, not Navier-Stokes dynamics.
This is a derivation within that controlled model, not a built fluid computer.
No new claim about the external blowup manuscript is needed in this note.

## Explicit model and error budgets

Let there be R labeled scalar species c_i, each transported by the same fixed
smooth incompressible u on a compact interval ending before T. Each species
has a transported profile p_i and mask zeta_i as in the dependency, and

    A_i[c_i] = integral(c_i p_i) / integral(p_i^2),
    A_i[a p_i] = a,    |A_i[e]| <= Q_i ||e||inf,    Q_i >= 1.

Different species may have overlapping supports; species isolation is an
assumption. Crosstalk must fit the errors below. Separate spatial packets are
also permitted, but gate wiring then entails interpacket communication.
Let P2_i bound |Delta p_i|. Set

    eps_i = 1/(64 Q_i),      sigma_i = 1/64,
    s_i = A_i[c_i] + xi_i,   |xi_i| <= sigma_i,
    gamma_i = 4 omega + 8 chi_i Q_i P2_i,    chi_i > 0.

Here omega >= 0 is an externally supplied clock with integral one per gate
slot. A finite, truth-independent gate schedule specifies target functions
B_i(s) in [-1,1]. The scalar system is

    D_t c_i = chi_i Delta c_i
      + gamma_i (B_i(s) p_i - zeta_i c_i)
      - chi_i s_i Delta p_i + eta_i,
    |eta_i(x,t)| <= gamma_i zeta_i eps_i / 2.             (1)

The sensor and command coupling across species are finite rank and Lipschitz
for the functions below. For bounded finite-time coefficients this gives the
usual bounded mild-solution formulation of a parabolic system with bounded
Lipschitz perturbation. Piecewise schedule changes are finite switches; a
smooth finite-bandwidth implementation is not proved. Bounded time-dependent
sensor errors can be treated as prescribed disturbances, or the argument is
conditional on any bounded solution satisfying their bounds.

For analysis only, define amplitudes using the *actual measured inputs*:

    a_i' = gamma_i (B_i(s)-a_i),    |a_i(t0)| <= 1.

These a_i are comparison variables, not extra physical controller registers.
Their convex scalar evolution gives |a_i| <= 1. Writing e_i=c_i-a_i p_i,
exact substitution in (1), including all diffusion, gives

    D_t e_i = chi_i Delta e_i - gamma_i zeta_i e_i
              - chi_i (A_i[e_i]+xi_i) Delta p_i + eta_i.  (2)

If initially ||e_i||inf <= eps_i, this bound holds for the entire finite
schedule, without an error factor proportional to the slot count. At a first
sup-norm contact, |A_i[e_i]+xi_i| <= 1/32. Where Delta p_i is nonzero,
zeta_i=1 and

    chi_i P2_i / 32 <= gamma_i eps_i / 4.

Together with the injection bound, at most 3/4 of local damping is consumed.
Where Delta p_i=0, the source consumes at most half. Upper/lower bounded
barriers and a strict-barrier limit on the whole space prove the claim;
positivity of the nonlocal operator is not assumed. The same first-exit time
can be used for all R species. The invariance proof needs only |B_i|<=1,
so gate coupling does not introduce a hidden amplification term into (2).

In particular

    |s_i-a_i| <= Q_i eps_i + sigma_i = 1/32.             (3)

The eta budget may include target injection error: a command perturbation
rho_i with |rho_i|<=eps_i/4 contributes gamma_i rho_i p_i, leaving
gamma_i zeta_i eps_i/4 for all other additive sources. Placement, bandwidth,
latency and cross-species errors are covered only if independently shown to
fit this bound. An absolute unnormalized integral error at most
sigma_i integral(p_i^2) is required for the stated sensor accuracy.

## Robust gates, latch, and sequential induction

Define sat(x)=max(-1,min(1,x)). Encode false=-1 and true=+1. Use

    HOLD(s) = sat(2s),
    NOT(s) = sat(-2s),
    AND(s,t) = sat(2(s+t-1)),
    OR(s,t) = sat(2(s+t+1)),
    NAND(s,t) = sat(2(1-s-t)).                           (4)

A register is *valid for b* when |a_i-b|<=1/16 and its PDE error obeys
the invariant above. Its measured value then differs from b by at most

    d = 1/16 + 1/32 = 3/32.

For two valid inputs the ideal affine truth-table scores in AND, OR and NAND
have absolute value at least one. Perturbations change these scores by at
most 2d=3/16. Their magnitudes therefore remain at least 13/16 > 1/2,
so the saturation yields the *exact Boolean target*. NOT and HOLD similarly
saturate correctly, since a valid signed input has magnitude at least
29/32 > 1/2. These facts include the mixed truth-table rows, not only equal
inputs. Fan-in is at most two; larger fan-in is compiled as binary gates.

Each slot updates one destination from valid held inputs, while every other
register uses HOLD. A destination must be distinct from its source registers;
staging registers implement destructive assignment safely. A held valid
register has target b, so a_i approaches b and stays valid. The destination
may be invalid during its write, but its inputs are valid throughout; hence
its target is constantly the correct Boolean value b. At the slot endpoint,

    |a_i-b| <= 2 exp(-integral gamma_i dt) <= 2 exp(-4)
             < 1/16.                                   (5)

It is valid for the next slot. Initialize all registers to signed profiles
with valid errors (unused ones may start false). Induction proves correctness
of every finite scheduled gate sequence and its final signed readout, with
the same margin for every update. This is the promised gate theorem.

HOLD is a regenerative latch implemented by the packet's own sensor and
actuator. It supplies logical state retention without an independent truth
register, although its physical realization remains an assumption. A clocked
schedule is still supplied externally; autonomous here means data-dependent
logical targets are computed by (4), not that the complete clock, wiring,
sensor and actuator have been derived from an unforced fluid law.

One may also use clock-phase masks to select hold versus write with a fixed
transition guard. The theorem as stated concerns finite sharp slots; arbitrary
blends near boundaries are not licensed without recalculating the integrated
write time and requiring inputs to stay valid during the blend.

## Input compilation, SAT and counted resources

For a CNF formula of total encoding length L with n occurring variables, its
value on an assignment has a binary gate circuit of O(L) size: literals use
NOT when needed, clauses use OR trees and the formula uses an AND tree.
Constants cover empty clauses/formulas. Construct this circuit directly from
the syntax without evaluating SAT. NAND implements the other gates with a
constant overhead. Register indices and input syntax must be represented in
bits; a straightforward compiler takes polynomial time and produces at most
O(L log(L+2)) bits of circuit/wiring description.

A truth-independent microprogram performs:

1. Evaluate the formula circuit on the current n-bit assignment.
2. OR the result into a persistent flag, using a staging register then COPY
   (two NOT gates, or a duplicated NAND) to avoid overwriting a live input.
3. Increment the assignment counter by a staged ripple circuit of O(n) gates.

Begin with the all-false assignment and false flag; repeat exactly 2^n times.
The loop count has n+1 bits, and a standard finite counter can control the
loop. This produces both SAT and UNSAT answers after a known finite number
of slots. The microprogram, counter and workspace use polynomial description
and O(L+n) logical registers, but it performs

    M = O((L+n+1) 2^n)

gate slots. The controller needs an explicit clock-phase/schedule primitive
and has a corresponding sequence of phase advances; describing its loop
succinctly does not execute the loop cheaply. Interpacket inputs in (4) are
assumed available at the active actuator without delay. If they are remote,
every gate needs an explicit latency analysis; the theorem does not grant
finite-speed remote wiring for free. Co-locating species avoids a fixed
interpacket distance but still uses the packet-wide nonlocal sensor.

For each register the exact integrated damping satisfies

    integral gamma_i dt = 4M + 8 chi_i Q_i integral P2_i dt.

All R registers are continuously held or written in this construction, giving
at least 4RM summed damping. This is a diagnostic of this controller, not a
universal energy or Turing lower bound. A source sup bound is

    ||f_i||inf <= gamma_i(2+eps_i)
                 + chi_i(1+Q_i eps_i+sigma_i)P2_i.

It must be combined with packet geometry, registration, field evaluation,
sensor quadrature and actuator precision costs from the dependency. Nothing
here shows polynomial computational trajectory length or polynomial standard
bit-time simulation. The device computes SAT by explicit exhaustive search.
It supplies programmable logic within an assumed controlled PDE model, not
the complexity compression required for P=NP.

## An explicit boundary-driven exporter, and its cutoff restriction

The controlled packet remains zero outside its material support in the exact
mode. To avoid treating its sensor value as an instantaneous external answer,
consider a separately added one-dimensional transmission line of length D>0
and propagation speed v>0. Its emitter is registered with the output packet
and uses that packet's same assumed integral transducer. Its receiver lies
outside the packet. The geometry and maintained connection are new hardware
assumptions; the fluid equations do not supply such a wire.

After the final slot at time te, keep the valid output held. Drive *only the
emitter boundary*, not the entire line, by

    z(0,t) = HOLD(s_out(t)) + e0(t),   |e0|<=delta0,
    partial_t z + v partial_x z = r(x,t),  0<x<D,
    |r|<=eta_line,    z(x,te)=0.

The zero initial line contains no precomputed answer. Characteristics give,
for t>te+D/v,

    z(D,t) = b + e0(t-D/v)
             + integral_(t-D/v)^t r(D-v(t-s),s) ds,
    |z(D,t)-b| <= delta0 + eta_line D/v.                  (6)

A receiver with additive error deltaR reads the correct sign whenever
delta0+eta_line D/v+deltaR<1. This is an actual finite-speed transport proof
in an added hyperbolic channel, not a global answer-dependent source in the
fluid. The initial boundary step admits the standard characteristic weak
solution; physical rise time adds to the deadline. No claim of an implemented
Navier-Stokes exporter, electrical line, or autonomous local transducer follows.

The earliest guaranteed external answer in this model is after te+D/v.
Readout before the singular cutoff therefore requires D/v<T-te (plus rise
and decision times). If a fixed-start clock demands residual time
T-te=O(M^(-1/h)) to finish M operations, fixed positive D and bounded v fail
this requirement for sufficiently large M. One must reserve export time,
alter the initialization/clock family, shorten the line, increase speed, or
allow the independent channel to operate after cutoff; none is silently
assumed here. The inequality is a limitation of this specified output model,
not a no-go theorem for every finite-cutoff accelerator.

## Strain replaces rotation in packet-distortion upper bounds

There is a provable geometric improvement relevant to this network. Put

    S(t)=sup_x ||(Du+Du^T)/2||op,
    E_s(t)=exp(integral_t0^t S),   Jj(t)=integral_t0^t ||D^j u||, j=2,3.

Use the Euclidean multilinear operator norm for derivative tensors. Along a
parcel the homogeneous inverse-derivative equation acts by -Du on each
covariant input index. The propagator on one input has norm at most
exp(integral S): differentiation of |w|^2 removes the skew part exactly.
The k-fold tensor input propagator therefore has norm at most
exp(k integral S). This argument works for the multilinear operator norm by
applying the one-input bound to each argument. For DL the initial norm is
one; the higher inverse derivatives initially vanish. Variation of constants
in their equations, retaining the same D2u and D3u forcing contractions as
in the dependency, gives the sufficient bounds

    ||DL|| <= E_s,
    ||D2L|| <= E_s^2 J2,
    ||D3L|| <= E_s^3(3 J2^2 + J3).

For example the Hessian bound follows from integral
exp(2 integral_s^t S) E_s(s)||D2u(s)|| ds <= E_s(t)^2 J2(t).
The third-order source is bounded by 3||D2L||||D2u||+||DL||||D3u||;
integration bounds the first contribution even by (3/2) E_s^3 J2^2,
so the displayed factor three is conservative. The forward parcel distance
has the same E_s bound by the symmetric-gradient energy estimate along the
line segment between points, assuming the global sup used in S.

Consequently all P1/P2/P3, mask-size and registration sufficient estimates in
the dependency remain valid with E_s in place of E. Large rigid rotation has
S=0, so its angular frequency by itself contributes no distortion through
this bound. Differential rotation, strain, D2u and D3u still matter. No
numerical strain certificate for the completed field is claimed, and these
upper bounds cannot be reported as necessary physical resource costs.

## Verification and unresolved bridge

`check_packet_gate_margins.py` checks the rational gate margins at all extreme
corners, the sensor/source allocation, a rational Taylor certificate for (5),
and a small exact Boolean compiler enumeration. It is not a PDE simulation,
fluid certificate, physical construction or a polynomial complexity test.
The continuum inequalities above need independent mathematical review.

The concrete advance is a robust compositional gate/latch theorem within the
previously declared controlled-scalar model. Remaining requirements include
an effectively instantiated completed velocity; realizable sensing, local
logic and communication with costs; geometric registration and backreaction;
and most centrally a uniform polynomial-time SAT computation theorem. The
current exhaustive program proves none of the last requirement. P=NP and
P!=NP are both unproved by this work.
