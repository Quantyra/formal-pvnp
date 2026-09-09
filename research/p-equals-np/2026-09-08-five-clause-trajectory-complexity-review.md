# Five-clause trajectory: independent complexity and source review

2026-09-08. S3040 / S008 / E004. Baseline 4018086. Reviewed the final `2026-09-08-five-clause-trajectory-attempt.md`, both Python programs and the completed validation transcript. Harness only; no commits, planning edits, new solver configuration or formula search.

## Fixed computation and evidence levels

The two programs retain the same five clauses in the stated order, the nine-state normalized polynomial field, asymmetric rational seed, initial b_m=rho=1/5 and integer-slot cyclic control. The rho factors in both auxiliary equations are present. Neither program encodes a satisfying witness in the initial state or control.

I independently reproduced the single floating probe once. It returned the same xi=16 margin-qualified witness, reported coordinates and608 RHS evaluations under SciPy1.17.1. Its clause products and omitted-factor derivatives implement the displayed field correctly, and each integration interval ends at a known control switch. The horizon cap is512, but this run stops at16. This reproduction is evidence of implementation fidelity, not a rigorous error estimate for DOP853.

Three distinct claims are correctly separated. The Boolean vertex (-,+,+) satisfies all five clauses regardless of any ODE computation. The floating run suggests that the specified trajectory reaches that sign pattern. The directed interval computation, together with the inclusion proof, certifies an endpoint of the specified exact IVP. Agreement between two floating outputs would not establish the third claim, and the draft does not use it that way.

## Interval arithmetic and inclusion audit

The new arithmetic dependency was checked against the [official Python Decimal documentation](https://docs.python.org/3/library/decimal.html). Decimal contexts specify arithmetic precision and rounding; FLOOR and CEILING round in opposite outward directions, while copy_negate performs exact sign inversion without context rounding. Integer and finite-decimal construction is exact. The validator uses those explicit contexts for its interval arithmetic rather than silently inheriting ordinary ambient-precision operations.

Inspection of the multiplication branches confirms the correct extremizing endpoint pairs for every sign configuration, including two intervals straddling zero. Addition, division by positive integers and exact negation preserve inclusion. The recurrence uses rational constants and interval polynomial convolution. The finite decimal output endpoints represent exact rationals.

The segment tube is justified independently of the numerical approximation: cube/simplex invariance and rho<=1/5 imply |s_i'|<=1, |b_m'|<=2/5 and |rho'|<=2/25. Expanding a certified starting interval by h times these bounds contains the true next segment. Intersecting with known invariant coordinate bounds, and using monotone rho, narrows an enclosure without altering the flow or projecting its true state.

The order15 Taylor polynomial and h^16 times the order16 coefficient enclosure on the whole segment tube give the stated integral-remainder inclusion. The coefficient recurrence bounds the corresponding polynomial derivative expressions at every possible point in the tube; it does not need an arbitrary tube point's solution to remain in that tube. Interval Horner evaluation and outward operations preserve the induction from exact initial data. All512 steps of size1/32 align with the integer switches; one-sided fixed-field Taylor formulas end at the common continuous state, with no derivative continuity across switches assumed.

This supports a computer-assisted IVP certificate under the reviewed Python implementation and arithmetic semantics. It is not a proof-assistant checked theorem. I inspected the completed validation output rather than duplicating the longer fixed validation run.

## Final endpoint and margins

The terminal transcript reports validated_endpoint=true with512 steps, order16 and70 decimal digits. Its xi=16 intervals are contained in the final note's three widened rational intervals. The xi=14 transcript also lies inside the stated coarse box, whose first coordinate is strictly negative and other two strictly positive. Direct verification of that sign vector therefore proves an exact-IVP rounded witness is available by normalized time14.

The by14 statement is not the first hitting time and is not the probe's first1/100-margin stopping time. At14 the negative coordinate has magnitude about0.0025903, sufficient for the much sharper rigorous sign enclosure but below that probe margin; the fixed probe's stronger margin criterion is met at16. This does not change the IVP, seed or control.

The rational lower bound on the all-negative residual at16 is also correct: (247/250)(113/100)(1231/1000)/8=34358441/200000000>1/8. Thus a verified rounded Boolean witness can coexist with failure of the stronger all-clause small-residual sufficient condition. The success certificate here is direct Boolean verification with certified signs.

## Complexity and generalization boundary

The example's earlier simultaneous initial increase of every witness distance remains true. Certified later entry shows that this initial repulsion is not a permanent trapping argument for this trajectory; it does not restore the failed pointwise Lyapunov invariant. No asymptotic conclusion follows from one fixed nine-dimensional instance or from its fixed512-step certificate.

The scripts count real numerical work rather than treating normalized model time as free computation. Their present finite success establishes neither a uniform integration cost nor a polynomial witness deadline over arbitrary formula sizes. It supplies no UNSAT timeout, no general convergence theorem for the corrected flow, and no fluid-device implementation. The original analog-SAT source audit remains unchanged; no empirical observation has been substituted for its missing all-input guarantees.

Final verdict: GO for the reviewed computer-assisted exact-IVP witness by14 and the separately scoped floating observation and Boolean certificate. INCOMPLETE for general SAT convergence, an all-input polynomial deadline and P=NP. No mathematical or complexity-scope corrections were required in the final saved candidate.
