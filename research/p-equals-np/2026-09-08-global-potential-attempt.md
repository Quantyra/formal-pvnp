# A compensated global potential and the missing residual coercivity

2026-09-08. S3040 / S008 / E004. Harness-only informal research.
Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-global-potential-2026-09-08.md`.
Read with `INTEGRITY-CLAIMS.md`, the normalized-analog-SAT attempt, and the
asymmetric-seed attempt. No P=NP result or approved general SAT capability.

## The one potential and the actual retained system

Retain the asymmetric seed s_i=i/[2(n+1)], a_m=1, b_m=1/M, rho=1/M and
the round-robin corrected normalized flow. Write

    H_m=K_m+q_m,       barH=sum_m b_m H_m,
    E=sum_m b_m K_m^2,
    s_i'=G_i,         b_m'=rho b_m(H_m-barH),
    rho'=-rho^2 barH.                                    (1)

Primes denote normalized time xi. The schedule has exactly one active
q_m=1 in each unit slot; the other q_m vanish. The exact positivity, cube
invariance and inverse-scale bounds proved previously remain in force.
In particular 0<=K_m<=1, b_m>0, sum b_m=1, a_m>=1 and b_m>=rho.
At switches, identities below hold almost everywhere along the continuous
state path, which suffices for their integral versions.

The primary [Ercsey-Ravasz--Toroczkai source](https://arxiv.org/html/1208.0526)
and prior source audit supply the original model and its limited convergence
scope. This calculation concerns our specified corrected flow; it imports
no all-input timing theorem from that paper.

Choose the compensated scalar potential

    P=E+log rho.                                         (2)

This uses the reciprocal auxiliary scale already present in the exact
normalization. It adds no new control or initialization rule.

## Exact derivative and nonnegative dissipation

Since G=-gradient_s E at fixed b, direct differentiation gives

    E'=-sum_i G_i^2 +rho Cov_b(K^2,H),
    (log rho)'=-rho barH.

Define

    D=barH-Cov_b(K^2,H)
     =sum_m b_m(1-K_m^2)H_m + E barH >=0.                (3)

All summands are nonnegative. Consequently the EXACT compensated identity is

    P'=-||G||_2^2-rho D.                                (4)

The logarithm's sign matters: adding log(1/rho) instead would reinforce
the increasing scale term. Also D>=E barH>=E^2, because barH>=barK>=E.
Equation (4) is a valid global dissipation identity for this controlled
candidate; unlike the failed coordinate-gap invariant it does not require
disjoint or identically signed clauses.

Integrating (4), with 0<=E<=1 and rho>=1/(M+2xi), yields for every T>=0

    integral_0^T [||G||_2^2+rho D] dxi
      =E(0)-E(T)+log(rho(0)/rho(T))
      <=1+log(1+2T/M).                                  (5)

Thus the potential's unbounded lower range still gives useful information:
squared spin-force dissipation has only a logarithmically growing budget.
The same is true of the nonnegative extra term. This does not itself give
a residual-hit horizon.

For example, if a separate theorem proved ||G||_2^2+rho D>=c(L)>0 whenever
a satisfiable input had not yet reached a certified witness, then
c(L)T<=1+log(1+2T/M) would bound its first hit. An inverse-polynomial
c(L) would give a polynomial horizon. Such a coercivity statement is an
additional substantive theorem, not a consequence of decreasing P.

## A bounded transform does not repair the decision gap

Consider the increasing transform of the SAME potential

    W=exp(P)=rho exp(E),
    W'=-W[||G||_2^2+rho D]<=0,
    0<W<=e/M.                                          (6)

This is bounded below. It gives the finite integral budget
integral_0^T W[||G||_2^2+rho D]<=W(0). The disappearing weight W is
essential; this is not an unweighted force budget.

In fact this bounded potential tends to zero regardless of satisfiability
if the corrected flow is allowed to continue. In every slot, the active
clause has b_active>=rho, so barH>=barq>=rho. Therefore

    rho'<=-rho^3,
    rho(xi)<=1/sqrt(M^2+2xi),
    0<W(xi)<=e/sqrt(M^2+2xi) ->0.                        (7)

This holds alongside the previous lower bound rho>=1/(M+2xi); neither
bound asserts a finite-time singularity. Any decision rule that treats a
small W value alone as evidence of SAT would also accept UNSAT inputs.
Even on an already satisfying state, perpetual auxiliary boosts continue
to drive this scale effect. A stopping policy may stop once a witness is
verified, but that does not make W a witness certificate.

## Actual UNSAT trajectories and failure of uniform force coercivity

Use the explicit formula consisting of all eight possible signed clauses
on x1,x2,x3. It is UNSAT: every Boolean assignment falsifies the clause
with all three opposite literals. In the continuous cube the strict sign-
rounding argument from the previous note implies

    R(s):=max_m K_m(s)>=1/8                              (8)

at EVERY state. Run the actual specified asymmetric seed (1/8,1/4,3/8),
initial b_m=1/8,rho=1/8, and the eight-slot cyclic boost. No trajectory
solution needs to be guessed: the earlier global existence/invariance
argument applies, and (5)--(8) hold along this particular run.

Equation (5) implies

    (1/T) integral_0^T [||G||_2^2+rho D] dxi
          <=[1+log(1+T/4)]/T ->0.                       (9)

For arbitrarily large times there are states with arbitrarily small total
dissipation, and hence arbitrarily small spin force, while R>=1/8 always.
If the nonnegative dissipation had been bounded below by any fixed positive
constant eventually, (9) would be impossible. This is an implication about
an actual retained-flow trajectory, not merely an arbitrary state with a
small gradient. By (7) the same run has W->0 without ever becoming SAT.

Thus residual-only positive coercivity valid for ALL formulas is false,
even at this fixed input size. This does not refute a theorem explicitly
restricted to satisfiable formulas; such a theorem remains a possible,
unproved route to a SAT success deadline and a justified NO at that deadline.

Vanishing-scale estimates are compatible with the failure. Indeed E>=rho R^2
and D>=E^2 imply only rho D>=rho^3 R^4. But (7) gives

    integral_0^infinity rho^3 dxi<=1/M.

A fixed positive residual can therefore coexist with finite lower-order
weighted dissipation; that weaker bound cannot force a residual hit.

## A satisfiable input defeats spin-force coercivity at the actual seed

The UNSAT argument must not be misreported as a satisfiable-input failure.
There is nevertheless an exact SAT example showing why the spin-force term
alone cannot have a positive pointwise residual lower bound even at our seed.
This example uses duplicate clauses, which our specified syntax preprocessing
does not remove. It is a finite formula defined by explicit integer
multiplicities; no large formula needs to be materialized to check the identity.

Take the four sign patterns

    c1=(-,-,-), c2=(-,+,+), c3=(+,-,+), c4=(+,+,-).

At s=(1/8,1/4,3/8), their residuals are k_j/2048 with
k=(495,135,175,231). Set w=(7,2,3,4), and include

    N_j=w_j product_{l!=j} k_l^2

copies of clause j. Thus every original auxiliary weight still starts at1;
their aggregate weighted residual squares are proportional to w_j. With
p_j=w_j/16, direct addition gives

    sum_j p_j c_j=(-1/8,-1/4,-3/8)=-s.

The polynomial gradient identity

    c_ji/(1-c_ji s_i)=(c_ji+s_i)/(1-s_i^2)

holds at this interior seed. Since N_j K_j^2 has the common factor
product_l k_l^2/2048^2 times w_j, it follows that every G_i is EXACTLY0
at the initial point. Yet the first residual is495/2048>1/8, and the
initial all-true rounding fails the all-negative clause. The assignment
(true,true,false) satisfies every one of the four clause types, hence the
entire duplicated formula.

The first boost may immediately destroy this cancellation; this is not an
infinite trapping proof. It disproves a uniform strictly positive lower
bound on ||G||^2 from unsatisfied residual alone for satisfiable inputs at
this actual seed. It does not disprove a lower bound on the FULL
||G||^2+rho D, which is positive here, or an integrated SAT-restricted
progress inequality. Removing duplicate clauses or changing initialization
defines a different case and requires its own argument.

## What the identity proves, and the outstanding decision theorem

The potential provides a correct global covariance compensation and useful
integral estimates. Its bounded transform was explicitly tested and still
cannot serve as a SAT certificate. Neither small force, small weighted energy,
small inverse scale nor small W replaces direct Boolean verification or the
strict all-clause residual threshold.

A universal satisfiable-input polynomial hit bound remains missing. If proved
with a robust detector, the preceding bounded-degree simulation argument
could be applied to its polynomial normalized-time horizon; then failure
to find a witness would justify UNSAT at the deadline. At present (5) lacks
the required SAT-restricted coercivity or progress dichotomy, and (8)--(9)
exclude the unqualified version. No arbitrary timeout is justified.

The corrected global identity is genuine progress toward that obligation,
but it proves neither general convergence from the chosen seed nor polynomial
standard-model SAT computation. The full P=NP objective remains unresolved.
