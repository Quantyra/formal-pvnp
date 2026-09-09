# Full-cycle progress: independent complexity and source review

2026-09-08. S3040 / S008 / E004. Baseline c33adfe. Reviewed the stable `2026-09-08-cycle-progress-attempt.md` in full. Harness only; no code, commits, planning edits or new computational experiments.

## Source and retained-system boundary

The earlier `2026-09-08-normalized-sat-source-review.md` remains the applicable audit of the [original analog SAT paper and supplement](https://arxiv.org/pdf/1208.0526). No additional external convergence or complexity theorem is invoked in this increment. The candidate analyzes the specified cyclic control and asymmetric seed directly. It does not transfer almost-everywhere attraction, empirical ensemble scaling or original-solver claims to this deterministic modified system.

The rho factors, A=1/rho derivative and one-unit-per-clause schedule are retained correctly. Identities involving the control hold almost everywhere, with continuous states and absolutely continuous integrated quantities. A full cycle means M units of normalized time, not one free computational operation.

## Verified scale and averaging estimates

Because |(log b_m)'|<=2/M, every weight throughout a cycle is at least exp(-2), hence more than1/9, of its weight at that cycle's start. Each clause receives exactly one unit of control. Thus A'=barH implies A gains at least1/9 per complete cycle. Monotonicity extends the resulting bound to intermediate times and gives equation (2).

The sum comparison is correct: integral rho^2<=M sum_(ell>=0)(M+ell/9)^(-2)<=1/M+9<=10. This is a uniform finite squared-scale budget for all retained trajectories. It makes no satisfiability distinction and is consistent with the prior positive lower scale bound.

For f_m=rho b_m(K_m^2-E), sum f_m=0. Freezing each component at the same cycle-start point therefore cancels the frozen integral exactly. Reversing the integration order in the error bound does not introduce an extra M factor: for each m, only the future portion of its own unit-length slot is counted. The derivative integral itself still spans the whole M-unit cycle.

Independently differentiating f_m gives contributions bounded by2rho^2 from rho',2rho^2 from b', and2rho^2+6rho g from the residual and E derivatives, where g=||G||_infinity. Thus the stated6rho^2+6rho g bound is correct. Young's inequality gives6rho g<=g^2/2+18rho^2, and g^2<=||G||_2^2 gives equation (5). The coefficient24 and total remainder240 are valid.

The uniformly finite quantity is the rho-squared remainder after half the spin-force dissipation is absorbed. The full sum of absolute covariance errors is not proved bounded independently of horizon: its other displayed bound still depends on the integrated spin force. The candidate states this distinction correctly. Partial-cycle frozen terms need not cancel; their separately stated bound by1 is valid.

## Intrinsic dissipation and control baseline

Adding B_ctrl to P cancels the direct negative rho barq term, leaving precisely the boost covariance plus the intrinsic negative terms in equation (6). B_ctrl is explicitly analytical bookkeeping, not an uncounted additional machine state or freely implemented readout.

The telescoping identity for P_tilde follows from log rho(T)-log rho(0)=-integral rho(barK+barq). Its substitution yields equation (8): the intrinsic budget is at most241+integral rho barK, and hence at most241+log(1+2T/M). It is logarithmic, not a uniformly finite240 budget and not a witness deadline.

The unconditional cycle baseline also checks. With active clause j, E>=b_j K_j^2 gives D>=b_j(1-K_j^2)+b_j^2 K_j^2>=b_j^2. Weight comparison by1/9 throughout each slot, rho monotonicity and sum b_j(a)^2>=1/M yield rho(b)/(81M). This applies to solved, unsolved and UNSAT runs alike. At a satisfying vertex all residuals and G vanish, but D=barq under continued boosts; P_tilde is constant. This verifies the claimed distinction between perpetual control dissipation and progress toward a witness.

The intrinsic lower bound D_K>=b_j R(1-R^2)+b_j^2 R^3>=b_j^2 R is valid, including endpoints R=0 and R=1. Hence rho D_K>=rho^3 R. Its improved power of R does not repair its vanishing time weight. The cubic-scale contribution has a finite upper envelope, so keeping residual positive does not make this lower bound exceed the logarithmic upper budget.

## Complexity and quantifier verdict

The complete eight-clause UNSAT trajectory satisfies the same cycle identities and has R>=1/8 everywhere. Equation (8) forces its average intrinsic dissipation to zero along complete cycle endpoints. Therefore a positive constant per-unit-time or per-complete-cycle intrinsic lower bound covering every formula is impossible at this fixed input size. This does not exclude a theorem restricted to satisfiable inputs, an alternative progress measure, or eventual success of the modified algorithm on a particular satisfiable instance.

A SAT-restricted inverse-polynomial gain per complete unresolved cycle could be a useful sufficient target: since M is at most the explicit input size, polynomially many counted cycles would still give polynomial normalized time. Such a target must cover the actual deterministic seed and supply robust witness detection. A scale-dependent positive lower bound that merely accumulates harmonically or has finite integral is insufficient by itself. Generic or almost-sure statements cannot replace these quantifiers.

Neither a scalar potential nor a bounded covariance remainder measures full computational trajectory length or total bit work. No numerical controller, integration or detector work is waived by the analysis. The previous bounded-degree uniform simulation argument could be applied once a suitable polynomial horizon and detector are proved; this increment supplies neither that horizon nor a direct fixed-dimensional BGP application. Small rho and inverse-scale amplification alone prove neither polynomial nor exponential bit complexity.

The draft correctly states that a proved universal satisfiable-input deadline with effective certification would justify UNSAT for the remaining inputs at that deadline. The present estimates authorize no such timeout. The result is not a general algorithm-failure theorem and has no P=NP or P!=NP consequence.

Final verdict: GO for the stronger cycle scale estimate, uniformly finite absorbed covariance remainder, control separation and corrected logarithmic intrinsic budget. INCOMPLETE for SAT-restricted quantitative cycle progress and a general polynomial-time SAT algorithm. No mathematical or scope corrections were required in the saved candidate. This is an informal source/complexity review, not a formal proof or an implemented numerical validation.
