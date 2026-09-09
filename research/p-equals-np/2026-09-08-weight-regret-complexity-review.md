# Clause-weight regret: independent source and complexity review

2026-09-08. S3040 / S008 / E004. Baseline 2167173. Reviewed the stable `2026-09-08-weight-regret-attempt.md` in full. Harness only; no commits, code changes, numerical suites or planning edits.

## Source and exact theorem shape

The prior analog-SAT source audit remains applicable. No generic multiplicative-weights, replicator, convex-game or convergence theorem is imported in this increment. The displayed comparisons are derived directly from the retained ODE. Accordingly there are no extra external learning-rate, adversary or convexity hypotheses being silently borrowed from such a theorem.

The actual comparison clock is t(T)=integral rho dxi. In that clock a_m grows with rate K_m+q_m(xi(t)), while the control slots have unequal t durations. The exact exponential formula and normalization yield C_m-J=log(M b_m)+B-Q_m. This is a static comparator for one clause over the whole horizon. The comparator may be chosen after observing the trajectory for purposes of analysis; it is not advice used by the solver.

## Control discrepancies and static comparator

The primitive U_m is periodic, vanishes at cycle boundaries and has range width at most1. Integration by parts against decreasing rho gives |Q_m-t/M|<=1/M. Subtracting U_m(a) yields the arbitrary-phase interval estimate by rho(a). For an earlier and later clause, the primitive of q_m-q_l lies in [0,1], so its weighted cumulative bias is nonnegative and at most1/M. These comparisons quantify the real clock discrepancy rather than asserting exact cancellation from equal normalized slot lengths.

The separate weighted-control estimate is necessary and valid. For g_m=rho b_m, summing derivative magnitudes gives at most4rho^2. The primitive boundary term is at most rho(T); the derivative integral is at most4B2(T). Thus |B-t/M|<=rho(T)+40, with boundary term zero at full-cycle endpoints. No factor M or partial-cycle term is omitted.

Combining these estimates with log(M b_m)<=log M proves the upper regret bound log M+42. Independently, bounding every Q_m-t/M between -1/M and1/M inside the exponential sum proves the two-sided log-sum-exp comparison. Its constants and the max-C_m bounds in equation (7) are correct. These estimates are uniform in elapsed time but are statements about cumulative clause payoffs, not instantaneous maximum residual or a satisfying assignment.

## Moving comparators and residual consequences

Segmentwise integration of the logarithmic weight equation gives the switching identity (8), including the intermediate ratios of old and new comparator weights. The initial term contributes log M; b_m>=rho bounds each switching logarithm by log(1/rho), and the control discrepancy contributes the sum of segment-start scales. The stated bound log M+S log(M+2T)+40+(S+2)/M is therefore valid for the finite-S comparator described.

There is no free exchange of max_m integral with integral max_m. A residual-maximizing clause path would need a useful switch-count bound before the moving-comparator result could supply a corresponding uniform estimate. Arbitrary measurable comparators are correctly left outside this finite-S assertion. The comparator has not been promoted to a change of the algorithm or a freely implemented oracle.

The weaker pigeonhole implication needs no such switching assumption: sum C_m>=epsilon t forces max C_m>=epsilon t/M, hence equation (10). The factor1/M is explicit. This only guarantees cumulative weighted residual payoff under persistent violations; it does not imply simultaneous small clause residuals or a verified rounded solution.

## Compatibility with the potential and clocks

The covariance of K and K^2 is nonnegative by the displayed pairwise identity. Consequently D_K<=barK, and the residual portion of the intrinsic dissipation integral is bounded above by J itself. A lower bound on J therefore does not make that portion exceed the same J appearing on the right side of the cycle budget. No lower bound on adequate spin progress follows by subtraction. The draft correctly identifies this missing connection.

The model-time bounds follow from the earlier reciprocal-scale estimates. At T=NM, the decreasing harmonic sum is bounded by its first term plus an integral, which gives the stated upper estimate; the previously established lower estimate integrates to the stated logarithm. Thus cumulative gain in model time can grow only logarithmically in normalized time. Reaching a large model time can entail exponentially larger normalized time relative to t/M; a polynomial statement in one clock alone cannot simply be relabeled polynomial numerical work in the other. These inequalities do not prove a lower bound on the actual SAT hitting time.

The eight-clause UNSAT trajectory supplies a consistent actual-system check: R>=1/8, t tends to infinity, and equation (10) forces J to diverge while no Boolean witness exists. All comparator and potential identities still hold. This rules out treating cumulative gain tracking as an all-formula SAT certificate; it does not refute a SAT-restricted progress theorem.

## Algorithmic obligation and verdict

The weight player tracks K, whereas the spin field descends the changing nonconvex weighted K^2 objective. Neither compatible primal regret nor a convex minimax hypothesis has been established. The current exact weight identities cannot supply those missing spin guarantees. A satisfying vertex could legitimately enter a proof-only inequality, but using it to configure the actual computation would require an effective construction.

A complete decision theorem still needs progress from the prescribed deterministic seed to robust verified detection within a uniform polynomial horizon, together with counted simulation, control and readout costs. The earlier finite-degree simulation argument remains conditional on such a horizon and detector. No fixed-dimensional BGP theorem, generic convergence claim, or arbitrary UNSAT timeout follows from this increment.

Final verdict: GO for the exact cumulative comparisons, bounded cyclic-control discrepancies, explicit switching-comparator cost and carefully limited residual implication. INCOMPLETE for the SAT-restricted spin-progress bridge, a general polynomial-time SAT algorithm and P=NP. No mathematical or scope corrections were required in the saved candidate.
