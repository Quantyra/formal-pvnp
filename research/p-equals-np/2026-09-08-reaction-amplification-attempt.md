# Reaction amplifies the heat signal, with an explicit preparation budget

2026-09-08. S3040 / S008 / E004. Harness-only informal research.
Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-reaction-amplification-2026-09-08.md`.
Read with `INTEGRITY-CLAIMS.md` and the heat/spectral attempts. This is
a new finite-dimensional mathematical model, not a Navier--Stokes device.
No general SAT algorithm, fixed-dimensional analog theorem, or P=NP result
is asserted. No code, numerical experiment or commit is supplied.

## Global invariant flow and a constant final decision gap

For a CNF F on n>=1 occurring variables, let f be its Boolean satisfaction
indicator on {0,1}^n. Handle n=0 directly. Set

    (Lu)_x=sum_(i=1)^n(u_(x xor e_i)-u_x),
    u_x'= (Lu)_x+4n u_x(1-u_x),  u_x(0)=f(x).       (1)

There are 2^n state coordinates. At a coordinate equal to0, with the
others in [0,1], its derivative is nonnegative. At a coordinate equal
to1 its derivative is nonpositive. The cube [0,1]^(2^n) is therefore
invariant. The polynomial vector field is locally Lipschitz, and the
bounded invariant solution extends globally in time.

Let h(t)=exp(tL)f be the preceding heat solution. Variation of constants
gives

    u(t)=h(t)+integral_0^t exp((t-s)L) 4n u(s)(1-u(s)) ds.

The heat propagator is entrywise nonnegative, and the reaction is
nonnegative on the invariant cube, so u>=h coordinatewise. At time1,
the product heat kernel has flip probability(1-exp(-2))/2>1/4 and
stay probability(1+exp(-2))/2>1/2. Thus, if F is SAT,

    min_x u_x(1)>=g=4^(-n).                         (2)

Starting at time1, compare with the spatially constant logistic solution

    v'=4n v(1-v), v(1)=g,
    v(2)=[1+(4^n-1)exp(-4n)]^(-1).                 (3)

This is a valid componentwise lower solution. To justify the comparison,
the difference u-v obeys w'=Lw+c_x(t)w with
c_x=4n(1-u_x-v), bounded on the cube. Such a linear system preserves
nonnegativity: add a sufficiently large scalar multiple of I to its
diagonal, apply an integrating factor, and its integral iteration has
only nonnegative off-diagonal and diagonal coefficients. Hence initially
nonnegative w stays nonnegative. No differentiability of the spatial
minimum is assumed.

Since exp(2)>4, exp(4n)>16^n. Writing A=g exp(4n)>4^n>=4, the logistic
value is A/(1-g+A)>A/(1+A)>4/5. If F is UNSAT, f is identically0 and
uniqueness gives u(t)=0. We have proved the exact finite-time gap

    UNSAT: u_x(2)=0 for all x;
    SAT:   u_x(2)>4/5 for all x.                    (4)

In particular the designated coordinate0^n can be read against threshold
1/2. This is a mathematical amplification of the exponentially small
heat signal to a constant gap, not merely a change of output units.

## Robustness with arbitrary signed preparation and forcing errors

Small errors can leave the cube, so its invariance must not be assumed
for an arbitrarily perturbed system. Let

    u_tilde'=L u_tilde+4n u_tilde(1-u_tilde)+e(t),
    ||u_tilde(0)-f||_infinity<=delta,
    ||e(t)||_infinity<=eta on [0,2],                 (5)

with bounded piecewise-continuous forcing. Until the error w=u_tilde-u
first reaches1 in sup norm, u_tilde lies in [-1,2] coordinatewise and

    w'=Lw+c_x(t)w+e,
    c_x=4n(1-u_x-u_tilde_x), |c_x|<=8n.

Positivity and sup contraction of exp(tL), followed by the elementary
integral comparison, give on this interval

    ||w(t)||_infinity
       <=exp(8nt)(delta+t eta)
       <=exp(16n)(delta+2eta).                      (6)

A fully rational sufficient budget is

    delta+2eta<=2^(-32n-4).                         (7)

Since exp(1)<4, the last bound in (6) is strictly less than1/16. It
contradicts any first exit at error1 before time2. Thus the perturbed
solution exists through2, stays in the stated bounded neighborhood, and
has error less than1/16 throughout that interval. This is an explicit
bootstrap, not an assumption that signed forcing preserves the cube.

An additional readout error at time2 of at most1/16 then leaves

    UNSAT readout <=1/8;
    SAT readout >4/5-1/8=27/40.

Threshold1/2 still distinguishes both cases. The tolerances in (7) need
only O(n) bits to specify; achieving them simultaneously across the
2^n-coordinate preparation and dynamics is not thereby cost-free.

Exponential sensitivity of preparation is not solely an artifact of this
conservative bound. On an UNSAT formula, perturb the zero initial vector
to the spatially constant value 0<delta<1 and set e=0. Diffusion then
vanishes and the exact value at2 is

    delta exp(8n)/(1-delta+delta exp(8n)).           (8)

It reaches1/2 when delta=1/(1+exp(8n)). Hence a fixed positive initial
bias eventually creates a false high output as n grows, despite staying
within the cube. For example the family containing both unit clauses
x_i and not x_i for every i is UNSAT and retains all n occurring
variables. Equation (8) is an actual perturbed run on that family.
The constant final readout gap does not supply constant preparation
robustness uniformly in input size.

## Normalized energy and full-state trajectory length

Define E=2^(-n)sum_x u_x^2, without an extra factor1/2. Then

    E'=-2^(1-n)sum_{edges {x,y}}(u_x-u_y)^2
        +8n 2^(-n)sum_x u_x^2(1-u_x).              (9)

The second term is a positive reaction contribution. Because
max_(0<=a<=1) a^2(1-a)=4/27, its instantaneous value is at most32n/27,
and its integral through time2 is at most64n/27. These are bounds in
the defined normalized square norm, not thermodynamic work measurements.
The invariant cube still gives E<=1, but E is not generally monotone.
On a singleton SAT formula, E(0)=2^(-n)<=1/2, whereas (4) gives
E(2)>16/25. Thus this very initialization exhibits a net energy increase;
the amplification is not free dissipative averaging.

In the full sup norm, |(Lu)_x|<=n and 4n u_x(1-u_x)<=n, so

    integral_0^2 ||u'(t)||_infinity dt<=4n.         (10)

This counts every state coordinate in the selected norm. It is a genuine
polynomial trajectory-length bound for this model, together with a
constant final decision gap. However its dimension is2^n, its explicit
initial vector has2^n entries, and an explicit right-hand-side pass has
n 2^n neighbor contributions. The reaction coefficient4n has only
O(log n) bits; this does not remove those state or preparation costs.
The fixed-dimensional, uniformly encoded hypotheses needed for the
previous polynomial-ODE bridge have not been established. No transfer
from (10) to a standard polynomial-time SAT algorithm is made.

## A concrete succinct implementation attempt and exact test

The initial function f(x) has a short Boolean formula, so try storing
time-Taylor coefficient functions as shared circuits. Define
a_k(x)=u_x^(k)(0)/k! at time0. Differentiating the
polynomial ODE yields the exact recurrence

    a_0(x)=f(x),
    (k+1)a_(k+1)(x)
      =sum_i[a_k(x xor e_i)-a_k(x)]
        +4n[a_k(x)-sum_(j=0)^k a_j(x)a_(k-j)(x)].   (11)

This specifies actual circuit substitutions and arithmetic operations.
Direct arrays give exponential work per coefficient; sharing can help,
but no uniform polynomial circuit-size/evaluation bound follows from
(11). In particular the substitutions query shifted versions of the
entire prior coefficient function, not independent clause averages.

There is an exact test of a fixed-degree global Taylor readout. Take
F=(x_1) AND ... AND (x_n), with its sole satisfying assignment1^n, and
observe coordinate0^n. The recurrence proves

    a_k(x)=0 whenever k<distance(x,1^n),
    a_n(0^n)=1.                                    (12)

For the first statement, induct on k: no neighbor can transmit a nonzero
lower coefficient before its graph distance allows it, and the local
linear/quadratic terms cannot create an earlier nonzero coefficient at
x. At the first possible order d, only the d neighbors one step nearer
to1^n contribute; dividing their sum by d gives first coefficient1,
starting with a_0(1^n)=1. This proves the second statement as well.

Every global Taylor polynomial of degree<n about0 therefore evaluates
to0 at the observed coordinate even at t=2, while the exact value is
greater than4/5 by (4). Such a fixed-degree global truncation fails the
constant-error evaluator contract on this explicit example. The argument
uses only finite Taylor coefficients; it assumes no convergence of the
infinite Taylor series at2. It excludes neither repeated time stepping
nor other shared coefficient representations or nonlinear approximants.

Indeed this example admits an exact useful compression. Its initial
condition and equation are invariant under all coordinate permutations,
so uniqueness makes u_x depend only on k=|x|. The n+1 coordinates v_k
satisfy

    v_k'=k(v_(k-1)-v_k)+(n-k)(v_(k+1)-v_k)
          +4n v_k(1-v_k),
    v_n(0)=1, v_k(0)=0 for k<n,                     (13)

with zero-coefficient boundary terms omitted. This is an exact polynomial-
dimension reduction for that symmetric family. General CNF indicators
need not have this permutation symmetry. Equations (11)--(13) test one
implementation proposal without asserting a general representation or
evaluation lower bound.

## Remaining algorithmic obligation

A uniformly polynomial deterministic evaluator from succinct arbitrary
CNF initial data, computing u_0(2) to additive1/8 for the exact model,
would decide SAT by (4). The robust variant above specifies what initial,
forcing and readout errors can also be tolerated. Neither the comparison
proof, normalized energy bound, full sup-path length, nor the local RHS
circuit constructs such an evaluator or an efficient physical initialization.

The bounded positive result is a provable constant-gap amplifier with
explicit preparation sensitivity and a counted reaction contribution.
The concrete implementation test rules out only the stated fixed-degree
global Taylor approach and exhibits a valid symmetry compression on its
special test family. Uniform succinct evolution/evaluation for arbitrary
CNF remains the missing theorem. No P=NP result, physical fluid device,
simulation, code or commit is claimed.
