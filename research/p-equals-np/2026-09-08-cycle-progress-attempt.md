# Full control cycles: covariance cancellation and intrinsic dissipation

2026-09-08. S3040 / S008 / E004. Harness-only informal proof attempt.
Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-cycle-progress-2026-09-08.md`.
Read with `INTEGRITY-CLAIMS.md`, `2026-09-08-global-potential-attempt.md`
and the asymmetric-seed attempt. No general SAT theorem or route-final claim.

## Retained flow and notation

Retain the normalized asymmetric-seed, cyclic-boost system. In normalized
time xi, let

    H_m=K_m+q_m,       barH=sum_m b_m H_m,
    E=sum_m b_m K_m^2,       barK=sum_m b_m K_m,
    s'=G,       b_m'=rho b_m(H_m-barH),
    rho'=-rho^2 barH,       A=1/rho.

There are M>=1 clauses, exactly one q_m=1 per unit slot, and each clause is
selected once in each M-slot cycle. Initial a_m=1 gives b_m=1/M,rho=1/M.
The spin seed is unchanged. Positivity and invariance give 0<=K_m<=1,
0<=barH<=2, sum b_m=1, b_m>=rho and rho<=1/M. All identities involving
derivatives hold within slots and almost everywhere on the continuous path.
Use 3-CNF below; the same estimates work for clause widths at most three.

The previous potential P=E+log rho satisfies

    P'=-||G||_2^2-rho D,
    D=barH-Cov_b(K^2,H)>=0,
    integral_0^T (||G||_2^2+rho D)
       <=1+log(1+2T/M).                                  (1)

The objective here is to distinguish unavoidable control-cycle dissipation
from progress associated with clause residuals. The original source audit
remains applicable; no new dynamical theorem is imported.

## First cycle consequence: a sharper inverse-scale bound

Let a=ell M and b=a+M be consecutive cycle boundaries. Since
| (log b_m)' |<=2rho<=2/M, throughout this cycle

    b_m(xi)>=exp(-2)b_m(a)>b_m(a)/9.

The rational bound uses e<3. Crucially A'=barH, so integrating the one unit
assigned to each clause yields

    A(b)-A(a)>=integral_a^b sum_m q_m b_m
             >=(1/9)sum_m b_m(a)=1/9.

Consequently, at every xi>=0,

    rho(xi)<=1/[M+floor(xi/M)/9].                         (2)

This complements the earlier lower bound rho>=1/(M+2xi). It implies the
useful UNIFORM finite budget

    B2:=integral_0^infinity rho^2 dxi
       <=M sum_{ell>=0}(M+ell/9)^(-2)
       <=1/M+9<=10.                                    (3)

For the last step, bound the decreasing sum by its first term plus its
integral. Thus a full cycle, rather than only the instantaneous active weight,
controls the reciprocal scale. This is not a satisfiability statement.

## Exact cycle averaging of the covariance caused by boosts

Define the continuous absolutely continuous quantities

    f_m=rho b_m(K_m^2-E),          sum_m f_m=0.

The boost covariance term is sum_m q_m f_m. On a full cycle [a,b], freeze
each f_m at a. Since each clause is active for EXACTLY one unit,

    sum_m integral_(slot m) f_m(a) dxi=sum_m f_m(a)=0.

Subtract these frozen values and use the fundamental theorem of calculus:

    | integral_a^b rho Cov_b(K^2,q) dxi |
       <=sum_m integral_(slot m)|f_m(xi)-f_m(a)| dxi
       <=integral_a^b sum_m |f_m'| dxi.                  (4)

There is no omitted factor M: after reversing the order of integration,
the future portion of the ONE slot assigned to a fixed m has length at
most one. The derivative integral in (4) does span the entire M-unit cycle.

Let g=||G||_infinity. The literal product bounds give
|(K_m^2)'|<=3g. Also sum_m|b_m'|<=2rho, |rho'|<=2rho^2,
and |E'|<=2rho+3g by differentiating its defining weighted sum.
Since |K_m^2-E|<=1, differentiating f_m and summing therefore gives

    sum_m |f_m'|<=6rho^2+6rho g.

Applying Young's inequality 6rho g<=g^2/2+18rho^2 and g^2<=||G||_2^2,
we obtain the explicit full-cycle error estimate

    | integral_a^b rho Cov_b(K^2,q) |
       <=(1/2)integral_a^b ||G||_2^2
          +24 integral_a^b rho^2.                       (5)

Across any number of complete cycles the sum of the last terms is at most
24B2<=240, independent of elapsed time. Without Young's inequality, the
absolute cycle-error sum is at most
6B2+6 sqrt(B2 integral ||G||_2^2), by Cauchy--Schwarz. Neither formula
replaces a sampled derivative or a scheduled switch by an uncounted oracle.

For a final partial cycle the frozen terms do NOT cancel. A simple separate
bound is |integral_partial rho Cov_b(K^2,q)|<=integral_partial rho barq
<=M rho(a)<=1, using the partial cycle's starting point a. The results below
are stated at complete cycle endpoints to keep this extra term explicit.

## The control-compensated potential and intrinsic budget

Separate the intrinsic, unboosted part

    D_K=barK-Cov_b(K^2,K)
       =sum_m b_m K_m(1-K_m^2)+E barK>=0.

For analysis define

    B_ctrl(xi)=integral_0^xi rho barq,
    P_tilde=E+log rho+B_ctrl.

B_ctrl is bookkeeping for the known control contribution, not a new solver
state or a freely implemented physical memory. Direct differentiation gives

    P_tilde'=-||G||_2^2-rho D_K+rho Cov_b(K^2,q).          (6)

Thus over a full cycle, (5) implies

    integral_a^b [(1/2)||G||_2^2+rho D_K]
       <=P_tilde(a)-P_tilde(b)+24 integral_a^b rho^2.     (7)

The potential need not decrease on every cycle; (7) is a corrected
dissipation estimate with a summable error. Telescoping through T=NM and
using (3), E(0)-E(T)<=1, and

    P_tilde(0)-P_tilde(T)=E(0)-E(T)+integral_0^T rho barK,

gives

    integral_0^T [(1/2)||G||_2^2+rho D_K]
       <=241+integral_0^T rho barK
       <=241+log(1+2T/M).                               (8)

The final comparison uses barK<=barH and the exact logarithmic scale law.
This is a bound on intrinsic dissipation after separately accounting for
control effects. It still has a logarithmic budget; no residual-hit deadline
has been deduced from it.

## A positive cycle lower bound that is only a control baseline

If j is the active clause, the full D in (1) satisfies

    D>=b_j(1-K_j^2)+E b_j>=b_j^2.

During a full cycle b_j(xi)>=b_j(a)/9 and rho(xi)>=rho(b). Hence

    integral_a^b rho D
       >=rho(b)sum_j b_j(a)^2/81
       >=rho(b)/(81M).                                 (9)

All M slots are included; the final1/M is Cauchy--Schwarz on the probability
weights. This lower bound holds on both satisfiable and unsatisfiable runs.
At a satisfying vertex, all K_m vanish and G=0, yet D=barq>0 under the
continued boosts. There P_tilde is constant, while P still decreases.
This makes explicit why the unconditional positive quantity (9) cannot be
called progress toward finding a satisfying assignment. The drift allowed
by its scale dependence is compatible with the logarithmic budget (1).

## The remaining residual coercivity is too weak to force a hit

Let R=max_m K_m and select a maximizing index j. Nonnegativity gives

    D_K>=b_j R(1-R^2)+b_j^2 R^3
        =b_j R[1-(1-b_j)R^2]>=b_j^2 R>=rho^2 R.

Therefore the intrinsic integrand obeys rho D_K>=rho^3 R. This improves
the earlier rho^3 R^4 consequence, but its time weight remains insufficient:
from rho<=1/M and (3),

    integral_0^infinity rho^3<=B2/M<infinity.

An unresolved residual bounded away from zero is compatible with such a
finite lower contribution. Integrating this inequality cannot contradict
(8) or produce a finite witness horizon. This is failure of this particular
coercivity estimate, not an impossibility theorem.

The actual eight-clause UNSAT trajectory from the previous note remains
a useful check: R>=1/8 for every cube state, but it satisfies all of
(2)--(9). In particular its intrinsic dissipation averaged over complete
cycles tends to zero by (8), while it never reaches a SAT certificate.
A positive constant lower bound per unit time on all-formula intrinsic
progress would contradict this run. A constant lower bound per COMPLETE
cycle would likewise contradict (8) at fixed input size. Neither argument
refutes a theorem explicitly restricted to satisfiable inputs.

## Exact missing lemma and current outcome

To finish this route one needs a SAT-restricted quantitative statement:
before a robust verified witness is reached, complete-cycle intrinsic
dissipation or another counted form of progress must accumulate fast enough
to exceed the available budget by a polynomial horizon. The lower bound
rho^3 R above and the unconditional control baseline (9) do not do that.
A cycle inequality with a uniformly inverse-polynomial gain would be useful
only if it measures actual SAT progress and includes any exceptional seed
trajectories; a generic or almost-sure assertion would not suffice.

If a universal satisfiable-input deadline and certified detection were
proved, the earlier finite-degree simulation analysis could be applied to
its polynomial normalized-time horizon, with unsuccessful inputs declared
UNSAT at that justified deadline. No such deadline follows here.

The concrete increment is the stronger cycle-derived scale estimate, its
finite rho-squared budget, and cancellation of the boost covariance up to
a summable absorbed error. These provide a quantitative cycle-level account
without mistaking perpetual control dissipation for a SAT decision. The
full P=NP objective remains unresolved. No numerical integration, new solver
implementation or numerical test suite was used.
