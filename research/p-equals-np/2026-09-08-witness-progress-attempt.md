# Witness-relative distance: conditional progress and an all-witness counterexample

2026-09-08. S3040 / S008 / E004. Harness-only informal attempt.
Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-witness-progress-2026-09-08.md`.
Read with `INTEGRITY-CLAIMS.md` and the asymmetric-seed, global-potential
and cycle-progress attempts. No general SAT capability, P=NP result or
route-final claim.

## Proof parameter and retained computation

Retain the corrected normalized spin/weight flow, its unit-slot cyclic q,
and the prescribed initialization

    s_i(0)=i/[2(n+1)],       b_m(0)=rho(0)=1/M,
    s_i'=G_i=sum_m 2b_m c_mi K_m K_mi,
    b_m'=rho b_m(K_m+q_m-barH),       rho'=-rho^2 barH.

The prior positivity and scale results remain available, including
b_m>=rho>=1/(M+2xi). Time here is normalized model time xi, not a physical
device claim. The earlier primary-source audit applies; no convergence
theorem for this corrected control is inherited from the original analog flow.

Assume the input is satisfiable and fix a satisfying Boolean vertex
v in {-1,+1}^n FOR THE PROOF ONLY. The algorithm receives neither v nor
an oracle selecting it. Define the one candidate potential

    V_v(s)=(1/2)sum_i(s_i-v_i)^2,        0<=V_v<=2n.       (1)

The proposed universal invariant was descent toward at least one satisfying
vertex from the actual seed. We derive its exact condition, its quantitative
consequence when available, and a formula where every possible witness
violates that pointwise descent at the actual initial state.

## Exact witness-relative derivative, with changing clause weights

Let t_m(v) count the literals of clause m made true by v, so t_m(v)>=1.
For interior spins put

    Gamma_m(v,s)=t_m(v)
      -sum_{i:c_mi v_i=-1}(1+c_mi s_i)/(1-c_mi s_i).

Then direct substitution gives

    V_v'=-2 sum_m b_m K_m^2 Gamma_m(v,s).                 (2)

To verify it, the contribution of literal i to V_v' is
2b_m K_m^2 c_mi(s_i-v_i)/(1-c_mi s_i). For a true witness literal
c_mi v_i=1 the quotient is exactly -1. For a false witness literal it is
(1+c_mi s_i)/(1-c_mi s_i). Summing gives (2).

This does not freeze the weights: the b_m in (2) are their ACTUAL evolving
values. There is no b_m' term because the potential (1) itself contains
no weights. A time-dependent choice of v would be a different potential
with additional changes to account for; it is not silently made here.

No division by a vanishing literal factor is required by the underlying
formula. A term K_m^2(1+c_mi s_i)/(1-c_mi s_i) equals the polynomial
2^(-2k_m)(1+c_mi s_i)(1-c_mi s_i) times the squared product of the other
literal factors. Thus (2), interpreted by these polynomial products,
extends to the closed cube. Gamma_m itself may diverge at a boundary;
one must not treat its separate quotient as a bounded field there.

Satisfaction by v only proves t_m>=1. False-witness literals can give
larger positive quotients and overwhelm that count. A nonempty satisfying
solution set alone therefore supplies no sign for (2).

## A genuine sufficient geometry condition and its quantitative limit

Let E=sum_m b_m K_m^2 as before. A sufficient descent condition along a
pre-detection interval is

    sum_m b_m K_m^2 Gamma_m(v,s) >= beta E,    beta>0.    (3)

Requiring every Gamma_m>=beta is stronger and also sufficient. This is
a condition to prove along the actual trajectory, not an available test
using hidden witness advice. For example, fix 1/3<a<1 and consider the
box v_i s_i>=a for every i. There
every false-witness quotient is at most (1-a)/(1+a). For clause width at
most three, at most two witness literals are false. Hence

    Gamma_m>=1-2(1-a)/(1+a)=(3a-1)/(1+a)>0.             (4)

This is a concrete sufficient alignment condition. The sublevel set
V_v<=(1-a)^2/2 lies within that box. By (2)--(4), it is forward invariant
under arbitrary positive evolving clause weights, including the cyclic
control. To justify invariance even at a zero derivative, choose
1/3<a'<a. The slightly larger sublevel V_v<=(1-a')^2/2 also has V_v'<=0.
Up to its first exit, integration makes V_v nonincreasing, so a path starting
in the original smaller sublevel cannot reach that larger boundary. It
therefore remains in the original sublevel. The scalar inequalities
extend by continuity where matching witness coordinates reach cube faces.

This is a local stability statement, not a search theorem: all coordinates
in the box already round to the satisfying v. Its usefulness would be to
control a proved entry mechanism; no such entry from the general seed is
established here.

There is also a quantitative hitting implication from the more general
condition (3). For 3-CNF choose a fixed residual target 0<epsilon<1/8.
Assume (3) up to the first R=max_m K_m<epsilon or an earlier directly
verified witness. While neither occurs, R>=epsilon and E>=rho epsilon^2.
Integrating (2) on that interval gives

    V_v(0)-V_v(T)>=2 beta epsilon^2 integral_0^T rho
       >=beta epsilon^2 log(1+2T/M).                    (5)

Nonnegativity of V_v thus forces a residual hit or an earlier verified
witness by the conservative horizon

    T=(M/2)[exp((V_v(0)+1)/(beta epsilon^2))-1].           (6)

The added1 avoids an equality-endpoint inference. This bound is conditional
on (3) persisting until the hit. Even if beta is constant and epsilon is
fixed, V_v(0)<=2n only turns (6) into an exponential-in-n bound. An inverse-
polynomial beta can make this available bound still larger. It is not a
lower bound on actual runtime, but it fails to establish a polynomial horizon.
Scaling (1) by1/n scales its descent coefficient by the same factor, so it
does not improve the exponent in (6). A stronger estimate could do better;
neither (3) nor that stronger estimate has been proved for arbitrary inputs.

## Exact actual-seed counterexample for EVERY satisfying witness

Consider these five distinct 3-clauses, given by their sign vectors:

    c1=(-,-,-), c2=(-,+,+), c3=(+,-,+),
    c4=(+,+,-), c5=(+,+,+).                              (7)

They contain no duplicate clause or pure variable. They exclude all-true,
all-false, and the three assignments with two false variables. Their entire
Boolean solution set is therefore

    v1=(-,+,+),       v2=(+,-,+),       v3=(+,+,-).

For n=3 the prescribed seed is s=(1/8,1/4,3/8) and every b_m=1/5.
Its initial rounded all-true assignment fails c1, so this is an actual
nonterminated starting point, not a state bypassed by successful rounding.
Direct rational evaluation of the polynomial vector field gives

    (K1,K2,K3,K4,K5)=(495,135,175,231,105)/2048,
    G=(-15677/1310720,-27593/2621440,-15151/1310720).

The potential values and derivatives are:

| satisfying witness | V_v at the seed | V_v' at the seed |
|---|---:|---:|
| (-,+,+) | 71/64 | 17441/10485760 |
| (+,-,+) | 87/64 | 47529/10485760 |
| (+,+,-) | 103/64 | 25857/10485760 |

Every derivative is strictly positive. The current cyclic boost changes
weight derivatives, not these initial spin velocities; the calculation
therefore applies to the actual corrected first slot. Exact rational
substitution was checked with Fraction arithmetic on this bounded example;
no numerical trajectory integration or test suite was used.

The uniquely closest satisfying vertex is v1. Its distance gap from the
other two is strict, and the state is continuous; it remains closest for a
short initial interval. Equation (2) and continuity within the first slot
then show that the minimum squared distance to the Boolean solution set
also INCREASES initially. More generally, all three derivatives remain
positive on a sufficiently short interval. Thus choosing a favorable
witness after inspecting this starting state does not restore monotone
descent, even as a nonconstructive proof parameter.

This disproves the proposed pointwise witness-distance invariant and (3)
with beta>0 at this input's initial point. It does not show that the
trajectory never finds a witness, that (6) is a necessary runtime, or that
a cycle-integrated witness-relative argument cannot work. The potential
may first increase and later decrease. The original algorithm and the
possibility of P=NP are not refuted by this bounded counterexample.

## Surviving obligation

A viable witness-relative route must establish an all-input SAT-restricted
progress statement that tolerates the simultaneous initial repulsion in
(7), includes actual evolving weights and controls, and accumulates enough
progress by a polynomial normalized-time horizon. The local alignment
condition (4), unproved global condition (3), and exponential conditional
bound (6) do not supply that theorem. Selecting or encoding a satisfying
witness as computational advice would be circular and is not proposed.

A polynomial satisfiable-input deadline with robust verified detection
could justify declaring the remaining inputs UNSAT, followed by the earlier
effective simulation argument. Without that deadline, nonconvergence of
this potential or expiration of an arbitrary time budget is no NO certificate.
This increment gives an exact witness-relative identity, a sufficient local
condition, a quantified but insufficient conditional hit bound, and an
all-witness actual-seed obstruction to the attempted global invariant.
The full P=NP goal remains active and unresolved.
