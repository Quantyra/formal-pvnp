# Vortex clock to computational trajectory: conditional length tradeoff

2026-09-08. S3040 / S008 / E004. Harness-only informal research.
Read with `INTEGRITY-CLAIMS.md`, `2026-09-08-packet-gate-attempt.md`,
`2026-09-08-localized-bit-attempt.md`, and `2026-09-08-source-and-method.md`.
No formal theorem, physical implementation or P=NP result is claimed.

## Chosen bridge and exact scope

The existing program checks all assignments with a binary counter. This note
asks whether its actual separated counter states can lie on a polynomial-length
computational trajectory under a uniformly robust, effective encoding. It does
not count HOLD slots as transitions, or equate gate count with geometric length.

The relevant primary source is [Bournez, Graca and Pouly,
arXiv:1609.08059v3](https://arxiv.org/html/1609.08059v3), Definition 2.1 and
Theorem 2.2. Their rational-coefficient language characterization uses one fixed
finite-dimensional polynomial ODE, prescribed polynomial initialization from
a word encoding, full-state infinity-norm trajectory length, and a stable signed
output after polynomial length. It also requires a global solution and length
at least elapsed time. This is not a theorem about arbitrary controlled PDEs.

The elementary lemmas below apply independently of that source. They identify
a missing bridge obligation, and a precise sufficient target for pursuing it.

## Alternation lemma, with its norm and state declared

Let X:[a,b] -> E be a continuous bounded-variation path in a fixed normed
space. Its length is

    Len(X) = sup_partitions sum_j ||X(t_j)-X(t_{j-1})||.

For absolutely continuous paths in finite-dimensional space, or the Hilbert
spaces used below with the usual derivative hypotheses, this equals the
integral of ||X'||. Fix sampled times t_0<...<t_J. Suppose a real decoder
d on a domain containing those states satisfies

    |d(u)-d(v)| <= K ||u-v||,
    (-1)^j d(X(t_j)) >= g > 0,

where reversing all signs is allowed. Then

    K Len(X) >= 2 g J.                                     (1)

Proof: consecutive decoded values have opposite signs and distance at least
2g. Lipschitz continuity bounds each distance by K times the corresponding
state displacement. Sum those inequalities and use the length definition.
Only these sampled pairs need the Lipschitz inequality; a globally smooth
decoder is not needed. A discontinuous sign function itself is not K-Lipschitz:
use the underlying signed measurement, with its nonzero margin.

There is also a metric-robust version. If one deterministic decoder must
give the correct opposite labels on open norm balls of radius rho about each
consecutive sampled state, these balls must be disjoint. Their centers have
distance at least 2rho, so Len(X)>=2rho J. This requires robustness to the
whole declared norm ball, not merely specially structured physical errors.

Here a COMPLETE state must include every evolving variable used to execute
or interpret the computation: data, controller/phase, registration and decoder
parameters, and any dynamical forcing generator. An input held fixed throughout
a run may parameterize the decoder, but K and g must have uniform bounds in
input length. Merely choosing a data projection does not prove that it is the
complete computational state or that its norm matches a simulation theorem.

## A decoder that moves with the clock

For d(t,u), assume a common comparison domain U containing the whole state
path. Let its spatial Lipschitz constant on U be K, uniformly in time, and set

    V_time = sup_partitions sum_j sup_{u in U}
                    |d(t_j,u)-d(t_{j-1},u)|.

This quantity may be infinite. In particular U must allow evaluating both
times' decoders at X(t_{j-1}); restricting each decoder to only its own
instantaneous singleton state would not suffice. Insert and subtract
d(t_j,X(t_{j-1})) at each difference to obtain

    2gJ <= K Len(X) + V_time.                              (2)

If d(t,u)=D(u,z(t)) and D has Lipschitz constants K_X,K_z on a common
product domain, the stronger explicit-state bound is

    2gJ <= K_X Len(X) + K_z Len(z).                        (3)

Thus a time-varying interpretation can move the accounting to its controller;
the formula does not assert that this controller necessarily has large physical
energy or large bit description. When it is included in an autonomous finite
ODE, its coordinates participate in full-state length. If z is a prescribed
external clock, its effective generation and evaluation remain external costs.

For any increasing continuous bijective reparameterization of a finite
interval, the partition definition gives exactly the same path length. Hence
a faster vortex clock changes no length in a fixed state representation.
This assertion does not identify that representation with the Eulerian fluid
state, nor extend an undefined path beyond its singularity.

## Application to the existing binary enumerator

Take n>=1 and sample the main assignment register just before evaluation of
assignments 0,1,...,2^n-1, after its staged updates have completed. Its least
significant binary bit alternates at every successive sample. There are

    J=2^n-1

actual separated transitions of that register. Intermediate invalid writes,
formula-gate values and HOLD updates are irrelevant to this count. The program
as specified does not terminate early on finding a satisfying assignment.
Its final SAT flag need not alternate at all; using that flag for (1) would
be invalid. A Gray-code or different program needs its own transition argument.

Consequently any faithful complete-state realization of THIS trace satisfying
the hypotheses of (1), with K polynomial in total input length L and g at least
inverse-polynomial in L, has length at least 2^n/poly(L). Uniform norm-ball
robustness rho>=1/poly(L) gives the same conclusion without a Lipschitz decoder.
This contradicts a universal polynomial-length bound on inputs with
L=O(n log n), of which explicit n-variable CNFs exist. No claim is made that
2^n is superpolynomial in L on every very large redundant formula.

The packet note uses valid amplitudes |a-b|<=1/16 and
|A[c]-a|<=Q eps=1/64. Thus its noise-free sensor has signed margin at least
59/64 at these samples; g=7/8 is a conservative choice. The extra measured
sensor disturbance need not be treated as a free varying decoder. The amplitude
a is a comparison quantity, not automatically a physical state coordinate.
To apply (1) to physical fields, the measurement's norm dependence is required.

## Packet norm, initial volume and moving registration

For a single species write p for its nonnegative transported profile and

    D = integral p^2 = ell^3 I2 > 0,      A(c,p)=<c,p>/D.

For each finite run, incompressibility makes D constant even though the support
moves and deforms. The initial ell can depend on n or on the operation budget;
that is a family of differently initialized packets, not shrinking material
volume along one trajectory.

First assume c,p are in L2 and consider the product norm
||(c,p)||=(||c||2^2+||p||2^2)^(1/2). On states with ||p||2=sqrt(D) and
||c||2<=C sqrt(D), a direct two-state calculation gives

    |A(c,p)-A(c',p')|
      <= [||c-c'||2 + C||p-p'||2]/sqrt(D)
      <= sqrt(1+C^2) ||(c,p)-(c',p')|| / sqrt(D).           (4)

The calculation inserts <c',p> between the numerators; equal denominators
and Cauchy--Schwarz suffice. It does not assume the segment between p and p'
stays on the constant-norm sphere. Equation (1) applied to (4) yields

    Len(c,p) >= 2gJ sqrt(D)/sqrt(1+C^2).                  (5)

If p is prescribed externally rather than included in this state, the term
with its motion belongs in (2) or (3). Dropping it would mistake a moving
sensor for a fixed decoder. The full model must also account for the inverse
flow/registration calculation, not just store the formula defining p.

The packet note's whole-space sup-norm error invariant does NOT alone prove
an L2 bound on its error: a bounded error on an infinite-volume domain need
not have finite L2 norm. Thus (4)--(5) apply to exact modes or to an explicitly
L2-controlled subclass, not automatically to every allowed perturbed solution.

For the EXACT controlled mode c(t)=a(t)p(t), there is a stronger direct check
requiring no decoder enlargement. On smooth portions of the finite trajectory,
<p,p'>=0 because D is constant. Therefore

    ||c'||2^2 = D |a'|^2 + a^2 ||p'||2^2,
    Len(c) >= sqrt(D) Var(a)
           >= 2(15/16) sqrt(D) J.                        (6)

This assumes Eulerian p(t) is absolutely continuous in L2 on the truncated
interval; piecewise smooth gate changes preserve the argument when the path
is absolutely continuous. The gate model with exact initial modes and zero
disturbances has that conditional form. Moving support cannot cancel the
amplitude contribution in (6). This is a scalar-field L2 length statement.
It lower-bounds a proposed complete-state length only if that state's fixed
norm dominates this L2 component with a stated constant. It is not an actual
bound on the source velocity's kinetic-energy trajectory or a BGP theorem.

In contrast, the sensor for fixed p has L-infinity operator norm
||p||1/D=I1/I2=Q, independent of ell. Sup-norm amplitude robustness and L2
geometry therefore measure different things. Neither may silently substitute
for the other in a bridge argument.

## Shrinking amplitude and the quantified remaining cost

For an ordinary signed scalar encoding +/-alpha_n, the raw path can traverse
J alternations in length proportional to alpha_n J. The normalized decoder
c/alpha_n has Lipschitz constant 1/alpha_n; constant normalized error tolerance
requires raw errors of order alpha_n. Thus (1) remains consistent when
alpha_n is exponentially small. In the packet L2 example the analogous scale
is sqrt(D)=ell^(3/2)sqrt(I2). Achieving only polynomial raw length for the
exact trace in (6) requires

    sqrt(D) <= poly(L)/2^n,

as a necessary condition, not a sufficient construction. The normalized
sensor's L2 sensitivity then grows at least 2^n/poly(L). An equivalent
norm rescaling by 1/sqrt(D) restores the large length and incurs this same
norm-conversion factor. A claim about a fixed norm must track such weights.

These bounds do NOT prove exponential numerical bit precision: an error of
order 2^{-poly(n)} can require only polynomially many fractional bits.
Nor is a large Lipschitz constant alone an exponential bit-time lower bound.
The missing positive analysis is uniform effective evaluation, conditioning,
control and output recovery for the actual full system at that precision.
The existing sensor additionally requires unnormalized integral error of order
D for its constant normalized error. Quadrature and actuator costs are not
supplied by this length estimate. The previous packet exporter/deadline
obligations also remain.

## An explicit polynomial lift of the ideal clock

The earlier idealized clock, with fixed integer q>=101 and h=1/q, has
omega=tau^(-1-1/q), tau=1-t and cumulative ticks
s=q(tau^(-1/q)-1). It has the rational polynomial lift

    tau'=-1,       y'=y^(q+1)/q,       s'=y^(q+1),
    (tau,y,s)(0)=(1,1,0).

For 0<=t<1 its solution is y=tau^(-1/q) and s=q(y-1).
At s=M the previously derived cutoff is exactly

    tau_M=(q/(q+M))^q,      y_M=1+M/q.

In the full three-coordinate infinity norm the speed is y^(q+1), since
y>=1 and q>=1. Thus the length to that cutoff is EXACTLY M, although
the external elapsed time is less than one. If the redundant s coordinate
is omitted, variation of y alone still gives length at least M/q; integrating
the sum of the two coordinate speeds bounds length above by 1+M/q.
This is a concrete polynomial ODE clock whose own length is already linear
in its tick count. Its fixed degree and the short rational description of
tau_M do not change that calculation.

This is the chosen ideal clock lift, not the completed Navier--Stokes carrier
or a lower bound on every clock embedding. Compactifying y changes coordinate
conditioning and the vector field and requires a new cost analysis. Moreover
this solution blows up at finite time, so it fails the BGP global-solution
condition. A smooth cutoff, halt or restart extension must be constructed and
costed before claiming that model's hypotheses; it is not supplied here.

## A positive standard-model target, and the current missing proof

One sufficient target is a uniform translation of the input word into the
fixed rational polynomial-ODE language model of the cited Definition 2.1,
including its word encoding and polynomial initializer, global full state,
stable signed answer for both outcomes, length-growth condition, and one
polynomial bound on length to correct decision. A proved translation with
polynomial overhead would make the cited characterization applicable. A
different route is an explicit polynomial-bit-time algorithm that evaluates
the final SAT answer without traversing this enumerator's intermediate states.

Neither target is established by merely embedding the finite packet gates.
The present PDE has moving integral sensors, infinitely many spatial degrees
of freedom, an external sharp switching schedule and unfinished effective
source-field data. No fixed-dimensional polynomial ODE translation and its
uniform cost proof has been given. Even a family of polynomial-dimensional
ODEs requires an additional uniform bridge; fixed-dimensional norm equivalence
does not establish it. In dimension d, ||v||infinity<=||v||2<=sqrt(d)||v||infinity;
input-dependent anisotropic coordinate scales need separate bounds.

The explicit robust-trace lemma rules out one optimistic proof: polynomial
length of all the existing counter transitions with uniform polynomial
decoder sensitivity and inverse-polynomial signed margin. It does not rule
out a faster endpoint algorithm, another physical encoding, or P=NP.
The positive remaining task is computational compression that changes the
required trace, or a fully costed alternative effective encoding and simulator;
short external time and bounded kinetic energy supply neither by themselves.
