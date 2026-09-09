# Normalized analog SAT with a deterministic clause-cycling correction

2026-09-08. S3040 / S008 / E004. Harness-only informal research.
No approved general SAT capability, physical implementation or P=NP result.
Planning gate in the Quantyra-Planning repository:
`docs/research/pvnp/literature-review-normalized-analog-sat-2026-09-08.md`.
Read with `INTEGRITY-CLAIMS.md` and the prior clock-trajectory bridge attempt.

## Primary source scope before proposing a correction

[Ercsey-Ravasz and Toroczkai, arXiv:1208.0526](https://arxiv.org/html/1208.0526)
is the original Nature Physics 2011 article with supplementary material.
Equations (1)--(2) define the auxiliary-weight SAT flow used below.
Its random-instance timing evidence and conditional scaling discussion do
not provide an all-input deterministic polynomial-time bound or a finite
UNSAT stopping rule. Its spin-projection geometry omits growing auxiliary
coordinates. Exceptional basin-boundary trajectories are relevant to a
deterministic initialization; statements about attractors or almost-all starts
do not discharge that requirement.

The proposed correction is one explicit local mechanism: cycle which clause
receives an extra auxiliary-growth boost, intended to break equal-weight
cancellations at the standard zero-spin initialization. We analyze that
corrected mechanism rather than only the unmodified stationary origin.

## Input, residual and exact normalization

Normalize a CNF by removing repeated literals and tautological clauses;
handle an empty clause as UNSAT and an empty conjunction as SAT directly.
These are polynomial syntax operations. For each remaining clause m with
k_m>=1 literals, let c_mi be its signed incidence and define

    K_m(s)=2^(-k_m) product_{i in clause m}(1-c_mi s_i),
    K_mi(s)=2^(-k_m) product_{j in clause m, j!=i}(1-c_mj s_j).

The latter is a polynomial, including where a quotient notation would have
zero denominator. For s in [-1,1]^n, 0<=K_m<=1 and 0<=K_mi<=1/2.
Set K_mi=0 for absent variables in sums. The source flow (with the natural
clause-width normalization just written) is

    ds_i/dt = sum_m 2 a_m c_mi K_m K_mi,
    da_m/dt = a_m K_m,                a_m(0)>0.            (1)

Here "physical time" t means the original analog model's time parameter,
not time measured in an implemented physical device.
Let A=sum_m a_m, b_m=a_m/A, rho=1/A and
barK=sum_m b_m K_m. Then the EXACT physical-time equations are

    ds_i/dt = G_i/rho,
    db_m/dt = b_m(K_m-barK),
    d rho/dt = -rho barK,
    G_i=sum_m 2b_m c_mi K_m K_mi.                         (2)

Introduce the new clock xi by dxi/dt=A=1/rho, so dt/dxi=rho.
The equivalent normalized-time system is

    ds_i/dxi=G_i,
    db_m/dxi=rho b_m(K_m-barK),
    d rho/dxi=-rho^2 barK.                               (3)

Dropping rho from the last two equations changes trajectories and is not
normalization. For finite times rho>0, so (2)--(3) are equivalent to (1),
with a_m=b_m/rho. Using t=integral rho dxi explicitly recovers physical
time. Bounded normalized variables do not erase the cost of inverse scaling
or the reparameterization.

## The single proposed deterministic correction

Initialize s_i=0, a_m=1, hence b_m=1/M and rho=1/M. Let q_m(xi) be 1
when floor(xi) modulo M equals m-1, and 0 otherwise. This is a deterministic
round-robin schedule of unit normalized-time slots. Define the corrected
physical model by retaining the spin equation and replacing auxiliary growth by

    da_m/dt=a_m[K_m+q_m(xi)],          dxi/dt=A.           (4)

The schedule is formula-syntax-dependent through its ordered clause list,
not answer-dependent. The corrected normalized equations are

    ds_i/dxi=G_i,
    db_m/dxi=rho b_m(K_m+q_m-barH),
    d rho/dxi=-rho^2 barH,
    barH=sum_m b_m(K_m+q_m).                             (5)

This is a NEW controlled candidate; the original paper's dynamical conclusions
are not automatically inherited. The switch times are prescribed and locally
finite, so the smooth slot solutions concatenate uniquely with continuous
states. Positivity and sum b_m=1 persist. At a cube face s_i=1, positive
literal terms vanish and negative literal terms point inward; the argument
at -1 is reversed. Thus the spin cube is invariant even under the correction.

Since 0<=barH<=2,

    1/(M+2xi)<=rho(xi)<=1/M,
    |G_i|<=1.

In particular rho never reaches zero in finite xi. Also
t(xi)>=log(1+2xi/M)/2, so an infinite xi horizon is not made into a
finite physical-time deadline by this particular normalization. The corrected
physical weights remain finite on finite physical intervals, bounded above
by exp(2t) from the chosen unit initialization.

The state dimension is n+M+1 apart from the schedule representation. A
finite run's phase/count controller, switching accuracy, and elapsed xi
must be counted. Prescribing this piecewise schedule is not a fixed autonomous
rational polynomial ODE representation. A later smooth clock/controller
implementation needs its own uniform bounds and cannot be omitted from a
BGP full-state trajectory argument.

## The intended progress criterion and an exact corrected counterexample

The intended uniform progress statement was that the cyclic boosts force a
satisfiable instance from this initialization to a state with all K_m<2^-k_m,
within a bound polynomial in total input length L. Such a state supplies a
rounding certificate as shown below. The statement fails for the corrected
mechanism, even without a time bound.

Take the explicit satisfiable 3-CNF

    F=(x1 OR x2 OR x3) AND (NOT x1 OR NOT x2 OR NOT x3).     (6)

Any mixed-sign Boolean assignment satisfies it. Along the diagonal
s1=s2=s3=z, each clause has equal partial derivatives with respect to the
three variables. Therefore their weighted sum gives equal spin velocities,
for arbitrary positive, time-dependent clause weights. Uniqueness preserves
the diagonal, including across every scheduled switch. In normalized time,

    K_+=(1-z)^3/8,       K_-=(1+z)^3/8,
    dz/dxi=[b_+(1-z)^5-b_-(1+z)^5]/32.                   (7)

This is the ACTUAL corrected path's invariant subspace, not a claim that
the original stationary center remains fixed. In fact the first slot has
q_+=1,q_-=0. At the initial point z=0,b_+=b_-=rho=1/2,

    dz/dxi=0,
    db_+/dxi=1/8,       db_-/dxi=-1/8,
    d^2z/dxi^2=1/128>0.                                 (8)

The correction succeeds at leaving the origin; nevertheless it only moves
along the invariant diagonal. For every z in [-1,1],

    max(K_+,K_-)=(1+|z|)^3/8 >=1/8.                      (9)

Thus it NEVER reaches the strict residual certificate for (6), however many
boost cycles are performed. Rounding all coordinates by the same sign rule
(ties to true) always gives all-true or all-false and fails one clause.
The failure holds more generally for any clause-weight-only control that
retains this permutation-symmetric spin vector field and this equal-coordinate
initialization. It is not a lower bound for variable-specific perturbations,
other initialization algorithms, formula preprocessing beyond the specified
syntax operations, or SAT algorithms in general.

The example has fixed small size; no simulation or fitted trajectory is needed
to disprove this universal convergence invariant. Duplicating experiments or
merely making the clause cycle asymmetric cannot break the equal-coordinate
invariance. A successor that breaks variable symmetry requires a new rule and
analysis; it cannot cite origin escape as its universal convergence proof.

## Exact SAT certificate and the missing UNSAT decision

For any s in the cube, round each coordinate by its sign, with a fixed common
tie convention. If clause m were false under that Boolean assignment, every
one of its literal factors 1-c_mi s_i would be at least1. Consequently

    clause m false after rounding implies K_m(s)>=2^-k_m.

The strict inequalities K_m(s)<2^-k_m for ALL clauses therefore certify SAT
after a polynomial-time direct verification of the rounded assignment.
For 3-CNF the threshold is the constant1/8. For varying widths, its binary
description has O(k_m) bits, but the tolerance and evaluation costs must still
be accounted for.

For numerical values, |partial_i K_m|<=1/2 on the cube. A spin enclosure of
sup error delta and residual evaluation error epsilon_m permits the safe
upper bound K_m(s)<=Ktilde_m+(k_m/2)delta+epsilon_m, with the approximating
point also in the cube. Requiring this bound strictly below2^-k_m is a
certified stopping test. Alternatively directly verify any rounded approximate
assignment; its Boolean verification is definitive regardless of the dynamical
residual. Neither method guarantees that this trajectory finds such an assignment.

On UNSAT inputs the strict all-clause residual test is impossible, since it
would produce a satisfying assignment. Its perpetual failure is not a finite
NO certificate. A definite UNSAT result requires an independent finite
refutation or a proved exhaustive decision bound; neither (3) nor (5) supplies
one. A timeout justified only by residual nonconvergence would already
misclassify the satisfiable instance (6).

## Why normalized energy is not the missing invariant

Let E_b=sum_m b_m K_m^2. Along (5), direct differentiation within each
slot (and almost everywhere across the continuous-state switched path) yields

    dE_b/dxi = -sum_i G_i^2
       +rho Cov_b(K_m^2,K_m+q_m).                        (10)

Here covariance means sum b_m u_m v_m minus the product of the weighted
means. The correction term has no fixed negative sign. Even without boosts,
Cov_b(K^2,K) is nonnegative: it equals
(1/2) sum_{m,l} b_m b_l (K_m-K_l)^2 (K_m+K_l). Thus a descent proof
cannot discard it. Moreover
small E_b alone is not the strict residual certificate unless lower bounds on
every b_m are retained. For example, at z=1 in (7), E_b=b_- can be arbitrarily
small with positive b_- although K_-=1. This is a statement about the proposed
energy criterion, not an assertion that this particular trajectory attains
every such weighted state.

Normalization preserves bounded b and spins, but reconstructing a requires
division by rho. Its derivative sensitivity includes1/rho and b/rho^2.
These quantities need not have exponential binary description length, and
their growth alone is not a bit-time lower bound. The existing BGP audit
requires a separate effective whole-system translation, stable decision on
both outcomes and polynomial full computational length; no such proof follows
from compact coordinates, deterministic dynamics or a short control schedule.

## Outcome of this attempt

The exact normalized equations and inverse clock retain the original auxiliary
scale. The proposed cyclic correction preserves positivity and leaves the
balanced origin, but (6)--(9) prove it does not deliver the universal progress
needed even for satisfiable inputs. This closes that specific correction's
claimed route before numerical implementation. It establishes neither a
general analog-computation barrier nor P!=NP. The full P=NP goal remains
unresolved, including both a successful all-input mechanism and a polynomial
standard-model work bound.
