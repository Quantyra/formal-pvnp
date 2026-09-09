# Weight regret: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Baseline `2167173`.
Harness only. One independent reviewer covers the two separately reported
lenses; these are not two separately staffed reviews. No code, formal
modules/builds, commits, planning edits or publication are involved.

Reviewed stable `2026-09-08-weight-regret-attempt.md` against the retained
normalized flow and cycle-progress bounds. This verifies the written
cumulative identities and their scope, not a generic regret or convergence
theorem imported from another model.

## Proof-adversarial lens: GO for the exact cumulative comparisons

**Clock and logarithmic identities.** In normalized time,
(log a_m)'=rho H_m and (log A)'=rho barH. With unit initial a_m, integration
gives a_m=exp(C_m+Q_m). Integrating log b_m from its initial value -log M
then gives exactly (1). Every schedule payoff uses rho dxi, the original
model-time measure; equal normalized-time slots are not silently treated as
equal original-time intervals.

**Fixed-clause control discrepancy.** The primitive U_m of q_m-1/M resets
after every M-slot cycle. Its range width is 1-1/M, hence at most one,
including the M=1 case. Integration by parts against decreasing rho bounds
the initial-to-T discrepancy by rho(0)=1/M. On an arbitrary interval,
subtracting U_m(a) bounds the endpoint and variation terms by rho(a).
This handles all partial slots and cycles. For earlier and later clauses
in the fixed cyclic order, the primitive of q_m-q_l stays in [0,1], so the
sign and upper bound of (4) are correct.

For g_m=rho b_m, sum|g_m'|<=4rho^2. Summing the integration-by-parts terms
gives the boundary contribution at most rho(T), since sum g_m=rho, and
the integral contribution at most 4B2(T). This proves (5), including the
vanishing boundary contribution at full cycle endpoints. The constants
40,41 and c(T)<=42 account correctly for M>=1.

**Fixed comparator and log-sum-exp.** Applying log(Mb_m)<=log M to (1)
gives (6). Writing Q_m=t/M+delta_m with |delta_m|<=1/M and factoring
exp(t/M) from A gives the first inequality of (7), because the logarithm
of any probability-weighted mean of exp(delta_m) lies in [-1/M,1/M].
The usual elementary max-versus-log-mean bounds then give the two-sided
comparison with max C_m. These are fixed-clause cumulative comparisons;
none replaces max C_m by the time integral of max K_m.

**Moving comparator.** Integrating the weight identity on each comparator
segment and telescoping produces the displayed log ratios at every switch,
with the previous clause in the numerator and the new clause in the
denominator. Positivity gives each ratio upper bound log(1/rho(u_r)).
The initial weight contributes log M; the terminal log weight is nonpositive.
Segmentwise control discrepancy costs sum_(r=0)^S rho(u_r), and the
weighted control boundary adds rho(T). Thus the final factor (S+2)/M,
the S log(M+2T) term and the constant forty are correct. The bound explicitly
requires finitely many comparator switches and assigns a cost to them.

**Residual implication.** If R>=epsilon throughout, summing cumulative
residuals gives sum C_m>=epsilon t. A fixed clause has C_m at least their
average, so (10) follows with the stated 1/M loss. No hypothesis that one
clause stays maximally violated is needed. The alternative maximizing
comparator implication is valid only with the finite-switch hypothesis and
its complete cost retained.

**Combination with dissipation.** The cycle inequality (11) has the correct
241 constant and applies at complete cycle endpoints. The pairwise covariance
formula is nonnegative for K in [0,1], so D_K<=barK; its nonnegativity follows
from the earlier explicit expansion. Therefore integral rho D_K<=J. A lower
bound on J alone cannot force enough spin-force dissipation to contradict
(11). The draft correctly does not infer convergence from that comparison.

**Input size and clocks.** For T=NM, summing the per-cycle upper rho bound
gives sum_(ell=0)^(N-1) M/(M+ell/9). Its first term is one; integral
comparison bounds the rest by at most 9M log(1+T/(9M^2)). The lower clock
bound follows by integrating 1/(M+2xi). Thus both factors of M and the
endpoint restriction in (12) are correct. Inverting the upper inequality
gives the necessary condition

    T >= 9M^2 [exp((t-1)/(9M))-1]

when the right side is positive. This explains why a polynomial target in
the original clock, without controlling its relation to M and normalized
time, is not itself a polynomial normalized-time bound. It is not a general
physical or bit-complexity lower bound.

The retained eight-clause UNSAT run has positive residual everywhere and
t(T) tending to infinity. Equation (10) therefore forces J to diverge along
that actual run, consistently with all the other estimates. Cumulative
gain tracking alone is consequently not a witness certificate. No blocking
mathematical defect was found.

## Nonclaims lens: GO-WITH-NOTES for bounded exploratory use

The result is an exact analysis of the existing weight update. It does not
supply regret for the nonconvex spin dynamics, a convex minimax theorem,
or a SAT convergence guarantee. The comparator is a proof parameter and
does not become solver advice. Moving comparators incur explicit costs;
an arbitrary residual-maximizing path is not assumed cheaply available.

The note distinguishes original analog-model time from normalized time and
from counted bit work. Its constants are finite uniform discrepancy bounds,
not a complete computational deadline. Increasing cumulative weighted
residual payoff is not confused with simultaneous low residuals or a
directly verified Boolean witness.

The UNSAT example limits an all-formula inference and does not refute a
SAT-restricted progress theorem. Such a theorem, reliable detection and a
uniform counted simulation remain open. No arbitrary timeout, physical
device claim, general SAT capability or P=NP conclusion is approved.

Safe summary: clause-weight cumulative comparisons have bounded cyclic-control
discrepancy and an explicit moving-comparator cost, but the required link to
SAT-specific spin progress and a polynomial decision horizon remains absent.
No formal route-final or full-goal closeout follows.
