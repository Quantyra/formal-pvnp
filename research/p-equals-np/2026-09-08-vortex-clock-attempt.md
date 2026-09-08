# Vortex-clock constructive P=NP attempt

Date: 2026-09-08. Planning route: S3040 / S008 / E004. Starting HEAD:
`93917012916fda54d07359e7e5d7881dcd621560` (initial tracked worktree clean).
Research calculation, not a P=NP theorem or a verified fluid computer.
Literature trigger recorded in the planning lane before this artifact.

## Target and inputs

Given a CNF encoding of length L, with n <= L occurring variables after
renaming, construct a uniform deterministic Turing algorithm deciding SAT in
poly(L) bit operations. The proposed physical implementation enumerates all
2^n assignments with a programmable gate clock inside a concentrating vortex.
The inspiration is the claimed forced Navier-Stokes construction described at
https://openai.com/index/navier-stokes-solution/ and its linked analytical paper.
Its proof is not independently checked here; none of its conclusions is assumed
to establish reliable programmable gates or a fast Turing simulation.

## A favorable exact clock calculation

Take tau=T-t, omega(t)=kappa tau^(-1-h), with h,kappa>0 fixed independent of F.
Absorb radians per gate into kappa, and let one ideal gate execute per clock unit.
Starting at tau0, accumulated gate phase is

    s(t) = (kappa/h) (tau^(-h) - tau0^(-h)).

This follows by differentiation, ds/dt=omega(t). For M required gates,

    tau_M = (tau0^(-h) + h M/kappa)^(-1/h).

For tau0=T=kappa=1 and h=1/q, with q a fixed integer at least 101 (consistent
with the paper's range 0<h<1/100, but not proof that its selected h equals 1/q),

    tau_M = (q/(q+M))^q,       t_M = 1 - tau_M.

This is an EXACT rational with O(q(log q + log M)) encoding bits. If a
straightforward SAT evaluator and counter use p(L) gates per assignment,
M=p(L)2^n+poly(L), so log M=O(n+log p(L)). Thus exponentially small final
distance to blowup does NOT require exponentially many bits to describe.
For general fixed rational h=a/b the endpoint has a constant-degree algebraic
description; approximating its value is a separate numerical operation.

The duration of gate j+1 is

    Delta_j = (q/(q+j))^q - (q/(q+j+1))^q,

and the mean value theorem gives

    q^(q+1)/(q+j+1)^(q+1) <= Delta_j
      <= q^(q+1)/(q+j)^(q+1).

Hence at M gates, fixed-relative timing tolerance needs O((q+1)log M) bits.
The model's r~tau^(1/2), v~tau^(-1/2-h) and omega~tau^(-1-h) yield
r_M~M^(-q/2), v_M~M^(q/2+1), omega_M~M^(q+1).
Their magnitudes are extreme, but their logarithmic descriptions stay polynomial.
Spatial actuator count, reachable bandwidth, energy and noise are not determined
by these description lengths. They need their own constructive bounds.

The source agent verified that the completed paper samples a shrinking circle:
omega=C tau^(-1-h)(1+O(tau^(2h))). Integrating the correction near zero adds
O(1) to accumulated phase, since its integrand is O(tau^(-1+h)). This gives
asymptotic clock scaling, not the exact rational clock above. Paper section 3.1
states that its moving core is similarity-defined, not material. A physical
rotating carrier additionally needs a material trajectory or another apparatus
that samples these circles, with proven residence and sign/speed bounds. The
sampled Eulerian velocity alone is not a material rotation-count theorem.

## Conditional finite one-bit construction

Here is an actual scalar control construction to test, independent of claiming
it already embeds in the fluid. In clock phase s, encode a bit as z near b in
{-1,+1}. During each unit slot command b_j and evolve

    dz/ds = 4(b_j-z) + e(s),        |e(s)| <= 1/4.

Assume |z(0)|<=17/16. This interval is forward invariant: at +17/16 the
largest derivative is zero, and at -17/16 the smallest is zero. Variation of
constants gives at the slot endpoint

    |z(j+1)-b_j| <= exp(-4)|z(j)-b_j| + (1-exp(-4))/16
                 <= (33/16)exp(-4) + 1/16 < 1/4.

Thus sign(z) reads every overwritten bit with margin at least 3/4, uniformly
for arbitrarily many slots; errors do not accumulate in this stable model.
An alternating command sequence is an answer-independent repeated-update test.
Commands computed by AND/OR/etc. require a further reliable coupled gate theorem;
this externally commanded scalar calculation does not silently supply it.

In physical time the required law is

    dz/dt = omega(t)[4(b_j-z)+e(s(t))].

Consequently the stated error bound concerns normalized physical disturbance
|eta(t)|/omega(t)<=1/4 and not arbitrary coupling to the fluid. A device must
realize the gain, command switching, initial bound and noise bound, and must
locate the phase slots accurately. At j=M, latch the sign into a separately
stable register or hold its command fixed. Starting a transfer at slot M and
allocating another M slots ends at t_(2M)<T, with strictly positive margin
tau_(2M)=(q/(q+2M))^q. This establishes ideal timing room, not a transport law.
If an external detector is distance d away and transport speed is bounded by
v_out, receiving before T requires d/v_out<tau_M. For d comparable to r_M,
that requires v_out larger than a constant times tau_M^(-1/2). No fixed-speed
pre-singularity export bound follows from concentration alone.

There is a useful resource diagnostic even for the stable one-bit model. If
successive target bits alternate and endpoint error is <=1/4, each overwrite
changes z by at least 3/2. Therefore M such updates have total state variation
at least (3/2)(M-1), and integral |dz/dt| dt has that lower bound. This is an
exponential integrated-variation cost for exponential updates, despite the
polynomial number of clock-description bits. Whether that particular cost is
charged to the proposed physical model must be explicit; it is not by itself
a Turing lower bound or a proof that another carrier cannot work.

## Actual proposed payload and both-outcome deadline

Encode F literally in polynomially many memory cells. Use an n-bit assignment
counter, a clause evaluator, and a persistent flag initially zero. Each block:
evaluate F(a), set flag := flag OR F(a), increment a. After exactly 2^n blocks,
halt updates and export the flag. A fixed-length padded block makes M depend
only on input dimensions and the chosen evaluator, not satisfiability. Counter
overflow supplies an explicit done bit, distinguishing NO from an unfinished run.
This preparation algorithm does not solve SAT or encode its answer.

Clock slots after M must cover latching, transmission and verification. If R(L)
additional internal gates suffice, use the known finite endpoint t_(M+R)<T.
That does not itself prove that an outside-core observer receives the bit by
that time. A separately established transport bound must fit the remaining
time, or a certified export/halt mechanism must permit a later safe reading.
Specify a deadline D(F), output location, signal margin, error tolerance and
failure indicator uniformly. The same requirements apply to both flag values.

## Strongest direct simulation attempt, and its exact missing lemma

Let G_F be the polynomial-size Boolean transition circuit implementing one
payload gate, and z0(F) its polynomial-size initial state. In phase time the
machine is simply z_(j+1)=G_F(z_j). The vortex changes the schedule of these
transitions, not their discrete transition relation. If a continuous gate
embedding obeys dz/dt=omega(t) H_F(z), the chain rule gives dz/ds=H_F(z).
This identity is conditional on the assumed embedding; it is not a derivation
of such an embedding from Navier-Stokes.

The closed-form clock permits fast-forwarding the CLOCK: compute t_M from
binary M using rational arithmetic in polynomial time for fixed q. Attempt to
fast-forward the PAYLOAD by repeated squaring: G^(2m)=G^m composed with G^m.
A compact reference to two applications does not compute their value for free.
Naive evaluated composition performs M transitions. A recursively shared
description can be O(log M) nodes only when nodes are higher-order composition
instructions whose evaluation still expands M applications. Ordinary Boolean
circuits for composition connect a second copy on a generally different state;
hash-consing does not identify these evaluations merely because code is shared.

The missing theorem is therefore specific and testable in form:

    There is a uniform bit algorithm A which, for every F, computes the done
    and answer bits of G_F^M(z0(F)) in poly(L+log M) bit operations, including
    construction, precision, error certification and readout.

On this enumerator the answer bit is exactly OR_(a in {0,1}^n) F(a). Proving
that theorem would give the requested polynomial SAT algorithm. Conversely,
a polynomial SAT decider computes this final answer bit, so for this observable
the skip-ahead problem is equivalent to the missing SAT decision algorithm.
This is a precise remaining proof obligation, not an impossibility theorem.
It identifies why integrating the phase alone does not discharge the task.

No universal black-box shortcut can simply ignore arbitrary intermediate
evaluation values: an all-zero Boolean oracle and an oracle true at one
unqueried assignment have identical queried transcripts. But F is an explicit
formula with exploitable structure, not a black box. This argument only rejects
an oracle-only justification; it does not rule out a formula-aware algorithm.

## Resources that the construction must actually bound

| Resource | Favorable fact | Missing all-input guarantee |
| --- | --- | --- |
| Input preparation | Literal formula and counter have polynomial description | Uniform physical/forcing compiler with no SAT oracle |
| Logical memory | Counter, evaluator workspace, flag, done need poly(L) cells | Reliable writable cells through concentration and coupling |
| Clock encoding | For fixed q, exact t_M has O(log M) bits | Programmable synchronized reliable gates in the actual forced PDE |
| Forcing | A concise expression need not encode the SAT answer | Construction/evaluation cost, derivatives, precision and feedback bounds |
| Space | Radius has polynomial logarithmic description | Physical resolution, cell separation and control cost separately bounded |
| Time | Ideal M gates have explicit finite deadline | Tolerances and external readout deadline, including transport |
| Noise | O(log M) event-time fractional bits suffice at fixed relative gate-duration tolerance in the ideal rational clock | Payload stability, cumulative errors, fault tolerance and perturbation norm |
| Numerical simulation | Clock alone can be evaluated cheaply | Polynomial bit work for the coupled payload and certified observable |
| Output | Flag plus done distinguishes YES and NO abstractly | Margin-separated outside-core signal for both outcomes |

For independent per-gate errors, a crude union bound would require error
probability O(1/M) per gate for fixed total error; its logarithm is polynomial.
Whether physical or numerical effort achieves that accuracy polynomially is
unknown. For deterministic P the final algorithm must have certified correctness;
a bounded-error noisy machine alone would not establish P=NP.

## Next genuine proof attempt

1. Give an explicit programmable gate/memory coupling to the claimed forced
   flow and a formula-to-forcing compiler. Identify whether the clock survives
   this coupling and how a done/answer signal exits the core. Without this,
   even the conditional fluid implementation remains an abstract machine.
2. Attempt a formula-aware fast-forward invariant for the actual enumerator:
   represent the accumulated truth flag after a dyadic block of assignments;
   compose two adjacent block summaries; prove exactness and uniform polynomial
   construction/evaluation cost. This directly targets the missing SAT lemma.
   A summary containing an unevaluated OR or a procedure of exponential running
   time does not discharge it. Distinguish physical success from this standard
   bit-complexity theorem throughout.
3. Check endpoint arithmetic with exact rationals, then test any proposed block
   summary against exhaustive SAT on small formulas. Finite agreement can refute
   bad candidates, but only the all-input bound would prove P=NP.

## Existing formal semantics and reproducible checks

CNFModel.lean provides real clause semantics and existing cheap-cleanup
obstructions. DecisionTreeSearch.CNFSat and SearchCorrect include explicit True
placeholders and cannot certify this task. The earlier clause-filtering branch
was superseded by the user's vortex-clock direction; it supplies no conclusion.

Run `python research/p-equals-np/check_vortex_clock.py` from this repository.
It uses exact fractions with q in {101,1009} and n in {4,8,16,32,64}; checks
the phase endpoint using a positive rational qth-root witness, both gate-gap
bounds, strict pre-singularity margin after a doubled gate budget, and the
denominator bit-length bound. It also certifies a rational upper bound below
1/4 for the one-bit endpoint error using a finite positive Taylor lower bound
for exp(4). These checks validate the arithmetic at these parameters; the
displayed calculus and invariant arguments provide the corresponding general
derivations. They do not test Navier-Stokes gates or prove polynomial SAT.

Status: exact ideal-clock arithmetic and conditional payload semantics derived;
programmable fluid realization and polynomial discrete simulation unproved.
No P=NP conclusion, general SAT solver, or public claim expansion.
