# Witness-relative progress: independent complexity and source review

2026-09-08. S3040 / S008 / E004. Baseline 6d9ec9e. Reviewed the saved `2026-09-08-witness-progress-attempt.md` in full. Harness only; no code, commits, planning edits or numerical experiments.

## Source and witness quantifiers

The existing `2026-09-08-normalized-sat-source-review.md` remains applicable to the [original analog SAT paper and supplement](https://arxiv.org/pdf/1208.0526). Its attraction and escape discussion does not supply a worst-case polynomial witness-relative progress bound for this modified cyclic flow and prescribed seed. Exceptional initial sets and the distinction between ensemble scaling and an all-input theorem remain relevant. No new external convergence theorem is invoked by the current draft.

A satisfying vertex used only as an existential parameter in a proof is legitimate: proving that for every satisfiable input some witness supports a uniform analysis of the unchanged algorithm would not itself require computing that witness. In contrast, selecting the control, initialization, detector or runtime bound through unknown witness information would need an effective construction. The candidate keeps the witness out of its actual computation and does not charge witness selection as a free operation.

The target being tested is stronger than descent toward an arbitrary chosen witness: it asks for descent toward at least one witness. The example enumerates the entire solution set, so its obstruction addresses that existential choice as well. This quantifier strengthening is supported by the calculation, not merely asserted from one inconvenient witness.

## Exact derivative and local condition

Independent derivation verifies V_v'=-2 sum b_m K_m^2 Gamma_m. True-witness literals contribute exactly minus one to the distance derivative after the displayed division; false-witness literals contribute the positive ratio in the draft. The time-varying b_m remain their actual instantaneous values. There is no omitted b_m' term because V_v has no weight dependence.

The polynomial continuation of the quotient products is correct. It permits the derivative identity on cube faces without implying that the separate Gamma expression is bounded there. Satisfaction only guarantees a true literal count, not dominance over the false-literal ratios, so the source of the possible wrong sign is explicit.

For 1/3<a<=1, the alignment estimate Gamma_m>=(3a-1)/(1+a) follows from at most two false-witness literals in a clause of width at most three. The stated squared-distance sublevel set lies inside that alignment box. Its nonincreasing boundary derivative, together with the locally Lipschitz polynomial flow, gives the claimed forward invariance. A small hypothesis clarification was requested during review: explicitly bound a above by1, since a>1/3 alone would also permit a>1 and invalidate the sublevel-to-box statement.

This is local stability around an already identifiable satisfying sign pattern, not a mechanism for entering that region from the general seed. Every point of the box already rounds to the satisfying witness. The draft recognizes this limitation rather than presenting local attraction as global search.

## Conditional horizon and actual-seed counterexample

Under the additional persistent weighted margin condition, E>=rho epsilon^2 before a residual hit gives equation (5). The scale lower bound integrates logarithmically. The extra one in the exponent of equation (6) gives a strict contradiction with V_v>=0 if no hit has occurred. The resulting bound is exponential in the available O(n) potential range for constant beta and epsilon. It is an upper bound obtainable under an unproved condition, not an exponential lower bound on the real runtime. Scaling the potential also scales its descent coefficient and cannot remove that dependence.

The five distinct clauses exclude exactly five of the eight Boolean vertices. The remaining vertices are precisely (-,+,+), (+,-,+) and (+,+,-), with no omitted witness. Initial all-true rounding fails the all-negative clause, so the counterexample is at an actual unresolved start for the retained algorithm.

Independent literal-factor substitution verifies the residual numerators (495,135,175,231,105), the three G coordinates and the table. In particular, on the common denominator10485760 the three distance derivatives are17441,47529 and25857, all positive. The three initial potential values are71/64,87/64 and103/64. The control boost first changes auxiliary derivatives and does not alter these initial spin derivatives.

The unique nearest witness is the first one. Its strict distance gap persists locally, and its strictly positive derivative persists in the first slot. Thus the minimum squared distance to the solution set increases initially as claimed. All three fixed-witness derivatives are positive on a sufficiently short interval. Choosing a favorable witness after inspecting the seed therefore cannot recover the proposed pointwise descent invariant.

This disproves that invariant and the strictly positive weighted margin condition at the initial point. It does not show permanent failure, rule out a cycle-integrated argument, or prove that any algorithm needs exponential time. A witness-distance potential can initially increase along a successful computation.

## Standard-model obligation and verdict

Potential range and coordinate distance are analytical quantities, not full computational trajectory length. No preparation, evolving-weight evaluation, cyclic controller, numerical integration or witness-readout work disappears through the proof parameter. The prior uniform finite-degree simulation argument can only be used after a suitable polynomial success horizon and robust detection criterion are established; neither follows here. No fixed-dimensional BGP theorem or generic convergence assertion fills this gap.

The strict residual threshold is a valid route to verified rounding when reached with an effective numerical margin. A theorem for every satisfiable input, combined with uniform simulation and certified detection, could justify rejecting all remaining inputs at its deadline. Mere failure of the candidate potential, or expiration of its unsupported polynomial timeout, cannot justify UNSAT. The conditional exponential horizon is also not a P=NP result even if its missing geometric hypothesis were discharged.

Final verdict: GO for the witness-relative derivative, local sufficient condition, conditional quantitative bound and all-witness actual-seed counterexample. NO-GO for the attempted universal pointwise witness-distance descent invariant. INCOMPLETE for an all-input SAT-restricted polynomial progress theorem and general polynomial-time SAT. The explicit parameter bounds 1/3<a<1 and 0<epsilon<1/8, and the enlarged-sublevel invariance justification, are present and verified in the final candidate. No corrections remain. This is an informal review, not a formal proof or numerical integration validation.
