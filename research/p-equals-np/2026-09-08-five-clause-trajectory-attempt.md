# Following the actual five-clause trajectory after initial repulsion

2026-09-08. S3040 / S008 / E004. Harness-only informal research.
Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-five-clause-2026-09-08.md`.
No general SAT theorem, physical device or P=NP result.

## Fixed experiment and current evidence

Retain exactly the five clauses in the witness-progress note, in order
(-,-,-),(-,+,+),(+,-,+),(+,+,-),(+,+,+). The nine-state normalized system
and unit cyclic boosts are unchanged. Initial spins are(1/8,1/4,3/8),
each of five weights is1/5, and rho=1/5.

`probe_five_clause_trajectory.py` runs one bounded DOP853 floating probe,
with a horizon cap512, restarting only the integration interval at every
known integer control switch. It uses rtol1e-11,atol1e-13 and stops at the
first integer sample with a directly verified rounded witness and every
spin magnitude greater than1/100. These numerical tolerances are NOT
rigorous trajectory error bounds.

The run, SciPy1.17.1, returned at xi=16 after608 right-hand-side evaluations:

    spins=(-0.011133284478746395,
            0.1313205299894454,
            0.2324985975025591),
    rho=0.09862991869008447,
    max residual=0.17235340757052028.

The rounded vertex(-,+,+) satisfies every input clause by exact Boolean
verification. It is a valid witness for the formula regardless of numerical
ODE accuracy. However, these floating values alone do NOT prove that the
specified exact trajectory reaches that orthant by16. In particular the
measured residual exceeds1/8, so this is direct witness verification rather
than the earlier all-clause small-residual certificate.

## Bounded validation result

The completed directed-interval run certifies an endpoint enclosure at
xi=16 contained in the following coarse rational box:

    [-0.012,-0.010] x [0.130,0.133] x [0.231,0.234]

for the three spins. The complete much narrower endpoints appear in the
saved transcript. Thus the exact trajectory reaches the witness orthant
despite the earlier initial increase of all witness distances.

A single fixed-configuration interval Taylor validation completed:
known integer switches, outward rounded interval arithmetic, finite degree
polynomial RHS, and a Taylor remainder bounded on an a priori enclosure of
each short trajectory segment. Global cube/simplex invariance supplies the
segment bounds. No solver tolerance, empirical agreement, or second floating
trajectory will be substituted for that proof. Validation status and exact
output are recorded below.

## Fixed interval method and inclusion proof

The reproducer is `validate_five_clause_trajectory.py`; its single run uses
512 steps of exactly 1/32, Taylor order 16, and 70 decimal digits.
`2026-09-08-five-clause-validation-output.txt` records integer-time
enclosures and the terminal disposition. No adaptive restart or parameter
sweep is used. Its arithmetic uses separate Decimal contexts with FLOOR
and CEILING rounding. Endpoint addition, subtraction, multiplication and
division by positive integers are directed; negation is exact. Multiplication
selects the extremizing endpoint pairs by signs. Powers of the step are
repeated interval multiplications. Printed finite decimal endpoints are
exact rational numbers, not approximate interval annotations.

Reproduce from the repository root with
`python research/p-equals-np/validate_five_clause_trajectory.py`.
The validator requires only Python's standard library; SciPy is needed
only for the separate floating probe. The transcript records every integer
time, the final nine-coordinate interval, and the Boolean endpoint check.

For each fixed control slot, let F denote the nine-dimensional polynomial
field. With K_m=product_i(1-c_mi s_i)/8 and K_mi the corresponding product
omitting i, divided by 8, the code evaluates exactly

    G_i = sum_m 2 b_m c_mi K_m K_mi,
    H_m = K_m + q_m, Hbar = sum_m b_m H_m,
    F = (G, (rho b_m(H_m-Hbar))_m, -rho^2 Hbar).

No normalization, projection or clamping changes the IVP. Intersections
with known invariant sets below narrow enclosures of this same IVP.

On the invariant spin cube and positive weight simplex, with rho<=1/5,
K_m<=1, |K_mi|<=1/2 and 0<=Hbar<=2. Hence
|G_i|<=1, |b_m'|<=2/5, |rho'|<=2/25 and rho is nonincreasing.
Given a certified endpoint interval I, enlarging its coordinates by h
times these bounds encloses the entire next exact segment. Intersecting
with [-1,1] for spins, [0,1] for weights and [0,1/5] for rho preserves
inclusion; the rho upper endpoint can also be bounded by its previous
upper endpoint. This gives the real segment tube J without a numerical
existence assumption. Polynomial local existence and the invariant compact
region supply the exact global solution across the finitely many slots.

The jet recurrence starts with z_0 in I and computes
(k+1)z_(k+1)=[t^k]F(sum_j z_j t^j) by interval polynomial convolution.
Induction encloses every exact Taylor coefficient based at every point of
I. The order-15 endpoint polynomial is evaluated by interval Horner's rule.
A separate recurrence based at J encloses the order-16 coefficient
A_16(z)=y_z^(16)(0)/16! for every z in J. The exact Taylor integral
remainder is h^16 times a convex weighted average of A_16 along the
segment, so h^16 A_16(J) encloses it. Adding this remainder to the endpoint
polynomial and intersecting with the invariant bounds proves the next
endpoint enclosure. This induction starts at exact rational initial data.
The index floor(j/32) modulo 5 gives the fixed active clause; no step
straddles a switch. At a switch the preceding slot's one-sided Taylor
formula reaches the common continuous endpoint, and the next slot starts
there with the new field. No differentiability across switches is assumed.

The validation checks strict endpoint spin signs and then verifies the
resulting Boolean vertex against all five clauses. A successful terminal
check, together with this arithmetic/inclusion argument, certifies the
exact IVP's endpoint orthant; a failed check would supply only an enclosure
too wide to certify it.

## Terminal certificate and exact consequence

The one fixed validation run completed all 512 steps, exit code 0, with
`validated_endpoint: true` and signs (-1,1,1). Its final spin intervals
are contained in

    [-0.011133284478747,-0.011133284478745]
    [ 0.131320529989445, 0.131320529989447]
    [ 0.232498597502558, 0.232498597502561].

These deliberately widened finite-decimal intervals are rational
enclosures. The integer-time transcript already certifies (-,+,+) at
xi=14, with the coarse spin box

    [-0.002591,-0.002590] x [0.139022,0.139024] x [0.244942,0.244944].

Therefore the specified exact IVP has a verified rounded Boolean witness
by normalized time 14; this is not a claim of the first hitting time.
The probe's additional 1/100 reporting margin is met at 16, not at 14;
the interval certificate at 14 proves its strict signs directly.
Every clause is satisfied: the first by its first negative literal, the
second by its first negative literal, the third by its third positive
literal, the fourth by its second positive literal, and the fifth by its
second or third positive literal. Neither initialization nor control used
this witness as advice.

At xi=16 the earlier coarse box also gives the exact lower bound

    K_--- >= (247/250)(113/100)(1231/1000)/8
           = 34358441/200000000 > 1/8.

Thus this certified success uses direct Boolean verification, while the
uniform small-residual sufficient criterion is still false at this endpoint.
The floating probe did not supply the rigorous error bound: the directed
interval induction supplied a separate enclosure of the original IVP.
This is a computer-assisted certificate with a reviewed Python arithmetic
implementation, not a proof-assistant checked theorem.

## Scope

This certified success for one fixed example establishes no uniform
SAT deadline or UNSAT stopping rule. It shows that the earlier local
repulsion counterexample is not evidence of trapping on this trajectory.
The goal remains an all-input polynomial-time decision theorem, not this
single-instance witness.
