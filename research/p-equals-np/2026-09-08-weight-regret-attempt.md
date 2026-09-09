# Exact clause-weight regret and the remaining spin-progress obligation

2026-09-08. S3040 / S008 / E004. Harness-only informal research.
Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-weight-regret-2026-09-08.md`.
Read with `INTEGRITY-CLAIMS.md`, the global-potential and cycle-progress
attempts, and the existing original analog-SAT source audit. No new
convergence theorem is imported. No general SAT or P=NP claim is made.

## Retained flow and the correct comparison clock

Keep the prescribed asymmetric seed, initial a_m=1, b_m=rho=1/M, M>=1,
and cyclic unit normalized-time boosts. Write normalized time as xi and
an endpoint as T. The original analog-model clock is

    t(T)=integral_0^T rho(xi) dxi,
    H_m=K_m+q_m, barH=sum b_m H_m, barK=sum b_m K_m,
    b_m'=rho b_m(H_m-barH), rho'=-rho^2 barH,
    s'=G, A=1/rho, a_m=b_m/rho.

Thus da_m/dt=a_m H_m and d(log A)/dt=barH. The schedule in this clock
is q_m(xi(t)); its slots do not have equal t duration. Identities hold
almost everywhere and integrate across the known continuous-state switches.
Previous invariance gives b_m>=rho, rho<=1/M, |rho'|<=2rho^2,
sum|b_m'|<=2rho and rho>=1/(M+2xi). In particular t(T) tends to infinity.
The cycle-derived budget B2(T)=integral_0^T rho^2 is at most 10.

Define cumulative residuals and control gains

    C_m(T)=integral_0^T rho K_m,
    Q_m(T)=integral_0^T rho q_m,
    J(T)=integral_0^T rho barK,
    B(T)=integral_0^T rho barq,  barq=sum b_m q_m.

Direct integration, with no generic regret theorem, gives

    a_m=exp(C_m+Q_m),
    b_m=exp(C_m+Q_m)/sum_l exp(C_l+Q_l),
    C_m-J=log(M b_m)+B-Q_m.                         (1)

The comparison in (1) is to one fixed clause over the whole interval.
The clause is a proof comparator, not an oracle supplied to the solver.

## Uniformly bounded cyclic-control discrepancies

Let U_m(xi)=integral_0^xi(q_m-1/M). It is periodic with period M,
zero at cycle boundaries, |U_m|<=1, and its entire range has width at
most 1. Integration by parts against the decreasing rho gives

    |Q_m(T)-t(T)/M|<=rho(0)=1/M.                    (2)

More generally, on any interval [a,b], use U_m(xi)-U_m(a), whose
absolute value is at most 1, to obtain

    |integral_a^b rho(q_m-1/M)|<=rho(a).             (3)

This includes partial cycles and arbitrary interval starting phases.
The finite variation calculation is
rho(b)|U_m(b)-U_m(a)|+integral_a^b(-rho')|U_m-U_m(a)|
<=rho(b)+rho(a)-rho(b). For an earlier-slot clause m and later-slot
clause l, the primitive of q_m-q_l lies in [0,1]. Hence also

    0<=Q_m(T)-Q_l(T)<=1/M.                          (4)

Equation (4) quantifies the small actual schedule bias; it is not exact
cancellation in the original model clock. In particular
log(b_m/b_l)=C_m-C_l+Q_m-Q_l compares cumulative residuals up to 1/M.

The weighted control payoff B requires a separate argument: equal slot
durations do not make it exactly t/M. Set g_m=rho b_m. Then

    sum_m |g_m'|<=|rho'|+rho sum_m|b_m'|<=4rho^2,
    B-t/M=sum_m integral_0^T (q_m-1/M)g_m.

Integration by parts with the same U_m gives

    |B-t/M|<=rho(T)+4 B2(T)<=41.                    (5)

Indeed the boundary term has size at most sum g_m(T)=rho(T), while
the integral term is bounded by integral sum|g_m'|. At complete cycle
endpoints the boundary term vanishes and the bound is 40. These estimates
explicitly count all M slots and any final partial cycle.

Combining (1)--(5), with c(T)=4B2(T)+rho(T)+1/M<=42, yields

    C_m(T)-J(T)<=log M+c(T)<=log M+42.               (6)

Equivalently, the actual weight dynamics achieves fixed-clause cumulative
gain within this additive constant in model time. A two-sided useful form is

    |J-log[(1/M)sum_m exp C_m]|<=c(T),
    max_m C_m-log M-c(T)<=J<=max_m C_m+c(T).         (7)

These are all-formula statements about cumulative clause weighting. They
do not say any K_m is currently small or that the spin dynamics solves SAT.

## Moving comparators have an explicit switching cost

For a piecewise constant comparator j_r on intervals
[u_r,u_(r+1)], let u_0=0, u_(S+1)=T, with S switches. Applying the
logarithmic weight identity separately to each segment and telescoping gives

    integral_0^T rho(K_j(xi)-barK)
      =log b_jS(T)-log b_j0(0)
       +sum_(r=1)^S log[b_j(r-1)(u_r)/b_jr(u_r)]
       +B-integral_0^T rho q_j(xi).                 (8)

The comparator is only an analysis path, not a change to control. By (3)
its control discrepancy from t/M has magnitude at most sum_r rho(u_r).
Since b_m>=rho and b_m<=1, (8) implies

    integral rho(K_j-barK)
      <=log M+sum_(r=1)^S log[1/rho(u_r)]
        +4B2(T)+rho(T)+sum_(r=0)^S rho(u_r)
      <=log M+S log(M+2T)+40+(S+2)/M.               (9)

There is no free replacement of max_m C_m by integral rho max_m K_m.
If a residual-maximizing comparator has at most S switches, (9) does
control it, with the displayed price. No uniform useful switch bound for
the prescribed SAT trajectories has been proved here. Arbitrary measurable
comparators are not covered by the finite-S claim without a limiting bound.

## A valid residual implication, and why it does not force a hit

Let R=max_m K_m. If R>=epsilon>0 throughout [0,T], then
sum_m C_m=integral rho sum K_m>=epsilon t(T). Therefore the fixed-clause
result alone, without assuming a slowly switching maximizer, implies

    J(T)>=epsilon t(T)/M-log M-42.                  (10)

This 1/M loss is explicit. It proves sustained residuals eventually
produce cumulative weighted residual payoff. It does not imply that any
one clause remains maximally violated, or that all clauses become small
at a common time. A hypothetical finitely switching maximizer instead
gives J>=epsilon t minus the full right side of (9).

Now combine with the actual cycle potential. With E=sum b_m K_m^2,

    D_K=barK-Cov_b(K^2,K),
    integral_0^T [(1/2)||G||_2^2+rho D_K]<=241+J(T) (11)

at full cycle endpoints. Because x and x^2 are increasing on [0,1],

    Cov_b(K^2,K)
      =(1/2)sum_(m,l)b_m b_l(K_m^2-K_l^2)(K_m-K_l)>=0.

Thus 0<=D_K<=barK. Even unbounded J in (10) is compatible with
(11): the residual-related term on its left can be no larger than the
same J on its right. A lower bound on J alone supplies no lower bound
on spin-force work strong enough to contradict this budget. The other
global bound is still only 1+log(1+2T/M).

The scaling reinforces this issue. On T=NM, N>=1, the earlier cycle
bound gives

    (1/2)log(1+2T/M)<=t(T)
      <=1+9M log(1+T/(9M^2)).                       (12)

The upper bound follows by summing M/(M+ell/9) and comparing the
decreasing sum after its first term with an integral. Thus the lower
gain forced by (10) need only grow logarithmically in normalized time,
which is compatible with the logarithmic potential budget. A polynomial
bound in the original clock t alone also need not give polynomial T:
from the upper estimate in (12), reaching large t can require exponential
normalized time. No free time reparameterization is used as bit computation.

The actual all-eight-signed-three-clause UNSAT input has R>=1/8 at every
cube state, under this same prescribed flow. Consequently (10) forces
its J to diverge, while the input never has a Boolean witness. It satisfies
(1)--(12). This is a concrete dynamical scope check: cumulative gain
tracking is not itself a SAT progress certificate. It does not refute
a theorem explicitly restricted to satisfiable inputs.

## Precise surviving obligation

One still needs a SAT-restricted connection from these cumulative clause
payoffs to actual spin motion and simultaneous robust witness detection,
with a polynomial normalized-time and numerical-work bound from the
prescribed seed. The weight update maximizes cumulative K, while the
spin update descends the changing nonconvex function sum b_m K_m^2.
No convex minimax or spin-player regret guarantee has been established.
The earlier all-witness initial-distance counterexample prevents silently
assuming the simplest witness-distance descent inequality; it does not
disprove a stronger integrated argument.

A satisfying assignment may be a proof parameter in such a missing
inequality but cannot be used as initialization, advice or control input.
If a universal satisfiable-input deadline with verified detection were
proved, it could justify NO at that deadline and invoke the earlier
counted simulation argument. None follows from (6), (9) or (10) alone.
This increment proves exact cumulative comparisons with bounded control
discrepancy and an explicit moving-comparator cost. No numerical run,
new solver, general convergence theorem or P=NP result is supplied.
