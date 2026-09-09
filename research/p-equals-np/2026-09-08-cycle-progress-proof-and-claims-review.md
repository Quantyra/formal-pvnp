# Cycle progress: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Baseline `c33adfe`.
Harness only. One independent reviewer covers both separately reported lenses;
these are not two separately staffed reviews. No code, formal modules/builds,
commits, planning edits or publication are part of this review.

Reviewed stable `2026-09-08-cycle-progress-attempt.md` against the retained
normalized flow and the prior global-potential derivation. The checks below
concern its written finite-cycle estimates and claims, not a formal or
full-objective closeout.

## Proof-adversarial lens: GO for the stated cycle estimates

**Scale across full cycles.** The logarithmic weight derivative has magnitude
at most 2rho<=2/M. Over a length-M cycle, every weight is therefore at least
exp(-2) times its starting value, strictly greater than one ninth of that
value. Because A'=barH and each clause receives precisely one unit of
activation, the reciprocal scale increases by at least 1/9 each complete
cycle. Between boundaries A remains nondecreasing. This proves the floor
function bound for every time, including boundaries.

Bounding each cycle by its starting rho value gives
M sum_(ell>=0)(M+ell/9)^(-2). The first-term-plus-integral estimate is
1/M+9<=10 for every M>=1. Thus B2 is a uniform finite upper bound; it does
not depend on satisfiability or require a positive residual.

**Covariance averaging and boundary terms.** For f_m=rho b_m(K_m^2-E), the
sum is exactly zero and all f_m are locally absolutely continuous. Freezing
at a cycle start cancels because each activation interval has length one.
After subtracting frozen values, reversing the two integrals assigns to each
|f_m'| a weight equal to a future portion of that clause's one slot, at most
one. Hence no factor M is missing in (4). Derivatives hold almost everywhere,
and continuous states generate no switch jump terms. A partial cycle does
not cancel; its separate upper bound M rho(a)<=1 is correct.

**Derivative estimate and absorption.** For clause width at most three,
|(K_m^2)'|<=3||G||_infinity. The weighted derivative formula for E gives
|E'|<=2rho+3||G||_infinity. In f_m', the rho and b derivatives each contribute
at most 2rho^2 after summation, while differentiating K_m^2-E contributes
2rho^2+6rho||G||_infinity. Thus the total is exactly bounded by
6rho^2+6rho||G||_infinity as claimed.

Young's inequality gives 6rho g<=g^2/2+18rho^2, and g^2<=||G||_2^2.
Adding the original 6rho^2 yields the coefficient 24. The rho-squared
remainder sums to at most 240. This is a bound after absorbing half the
spin-force integral; it does not prove a uniform 240 bound on the raw
absolute covariance integral. The separate unabsorbed Cauchy--Schwarz
estimate is also correct.

**Compensated intrinsic budget.** Adding the integral of rho barq to P
cancels that part of the logarithmic scale drift, yielding exactly (6).
Integrating and applying the signed covariance upper bound produces (7).
The boundary identity is
P_tilde(0)-P_tilde(T)=E(0)-E(T)+integral rho barK.
Consequently the constant is 1+240=241, and barK<=barH gives the final
logarithmic upper bound. P_tilde is not asserted to decrease each cycle,
and its added integral is analytical bookkeeping, not a free implementation.

**Control baseline.** For the active clause j, the full D is at least
b_j(1-K_j^2)+E b_j. Since E>=b_j K_j^2 and K_j<=1, this is at least b_j^2.
Using each weight's cycle lower bound, rho's ending value, and
sum b_j(a)^2>=1/M proves (9). At a satisfying Boolean vertex, all residuals
and spin velocities vanish, but D=barq remains positive under continued
boosts. P_tilde is then constant. This verifies directly that the positive
control baseline is not evidence of progress toward SAT.

**Residual estimate and actual-run check.** For a maximizing residual R,
the two nonnegative contributions in D_K give
b_j R(1-R^2)+b_j^2 R^3. Factoring and using R<=1 shows this is at least
b_j^2 R>=rho^2 R. Multiplying by rho leaves an integrable scale weight:
integral rho^3<=B2/M. A residual bounded away from zero therefore supplies
only a finite lower contribution and cannot contradict the logarithmic
budget or force a hit via this inequality alone.

The retained eight-clause UNSAT run has R>=1/8 for all time yet obeys the
cycle estimates. Its intrinsic-dissipation average along cycle endpoints
tends to zero. A fixed positive all-formula lower rate, per unit time or
per full cycle at this fixed input size, would contradict that bound. The
draft correctly makes no such inference about a SAT-restricted theorem.

No blocking mathematical defect was found. These are cycle-accounting and
bounded-coercivity results, not a universal witness deadline.

## Nonclaims lens: GO-WITH-NOTES for bounded exploratory use

The result strengthens the reciprocal-scale estimate and makes control
covariance cancellation quantitative. Its summable remainder is explicitly
the rho-squared term after absorption. Summaries must preserve that distinction
and must not claim the full covariance has a uniform finite absolute integral.

The draft separates perpetual control dissipation, intrinsic dissipation and
verified witness progress. It does not assert that cycle positivity or a
decreasing potential yields a SAT certificate. It retains the residual-bound
failure as a limitation of that estimate, not an impossibility theorem for
the flow, analog computation or P=NP.

A SAT-restricted quantitative progress/deadline theorem and robust detection
remain missing. Exceptional deterministic trajectories are not replaced by
almost-sure claims, and no general timeout is justified by this increment.
The conditional use of the earlier simulation argument is tied to a future
proved polynomial horizon, not assumed here.

Safe summary: complete control cycles give a uniform rho-squared budget and
a compensated intrinsic-dissipation inequality with an absorbed finite error;
the available residual lower bound still does not imply a witness deadline.
No stronger claim expansion, formal route-final status or full P=NP goal
completion is approved.
