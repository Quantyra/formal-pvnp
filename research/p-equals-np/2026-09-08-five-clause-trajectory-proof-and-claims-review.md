# Five-clause trajectory: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Baseline `4018086`.
Harness only. One independent reviewer covers the two separate lenses below;
these are not two separately staffed reviews. No commits, planning edits or
formal modules/builds are part of this review.

Reviewed `2026-09-08-five-clause-trajectory-attempt.md`,
`probe_five_clause_trajectory.py`, and `validate_five_clause_trajectory.py`.
Also inspected the complete terminal transcript and the final result/scope
text. **Final endpoint verdict: GO for this fixed computer-assisted IVP
certificate.** The author reports exit code zero; the saved transcript contains
all sixteen integer milestones and the successful 512-step terminal record.

## Proof-adversarial lens: GO for the fixed trajectory certificate

**Retained IVP.** Both scripts use the five sign triples in the specified order,
three spins, five normalized weights and one reciprocal scale. The initial
values are (1/8,1/4,3/8) and six copies of 1/5. Their residual polynomials,
omitted-literal polynomials, spin field, auxiliary field and scale derivative
match the retained normalized system. No rho factor is lost. The interval
code uses active clause floor(j/32) modulo five at step j of length 1/32;
the floating probe separately restarts integration intervals at integer
switches. Both schedules match the original unit-slot rule.

**Floating evidence.** The probe's Boolean verifier correctly checks the
returned sign vector against every clause. The witness (-,+,+) satisfies
all five independently of any ODE approximation. The floating residual above
1/8 is correctly distinguished from a small-residual certificate. Solver
tolerances alone do not bound exact-flow error, and are not used in the
interval proof.

**Directed arithmetic.** Interval addition and positive-integer division
round outward in separate 70-digit FLOOR/CEILING contexts. Exact copy_negate
avoids default-context rounding. Multiplication selects the correct minimum
and maximum corner products for all sign cases, with outward rounding of each
selected product. Both-straddling intervals explicitly compare the relevant
two lower and two upper products. Initial decimal construction uses integers
or exact finite strings, not binary floats. Step powers are formed through
the same interval multiplication.

I independently ran an ephemeral audit of the actual multiplication function,
using exact Fraction corner products as reference: all 784 interval-pair
cases formed from endpoints {-2,-1,-0.1,0,0.1,1,2} exactly matched their
corner extrema. Sixteen additional pairs with more than 70-digit endpoints
passed outward-containment checks under real rounding. No code file or
bytecode was created and no second full integration was run. These finite
checks supplement the sign-case audit rather than replacing it.

**Segment enclosure.** On the proven exact invariant set, K<=1, K_mi<=1/2,
rho<=1/5, and the weights are a probability vector. Hence the absolute
coordinate speed bounds (1,2/5,2/25) used by the code are valid. Expanding
each certified starting interval by h times its corresponding bound encloses
the true segment. Intersecting with the spin cube, coordinate bounds of the
weight simplex, and the scale range is legitimate because these are proved
constraints on the exact IVP. The nonincreasing scale additionally justifies
its previous upper endpoint as a tube bound. This is an a priori real tube;
no numerical Picard/tolerance assumption is substituted for inclusion.

**Taylor induction.** Interval convolution in the coefficient recursion
encloses the normalized Taylor derivatives of the autonomous slot field
for every initial state in its input box. The center polynomial contains
orders zero through fifteen. The independent tube recurrence encloses the
sixteenth coefficient A16 at every state along the exact segment. The
Taylor integral remainder is

    h^16 integral_0^1 16(1-u)^15 A16(y(hu)) du.

The scalar weight is nonnegative and integrates to one. Therefore h^16
times the interval A16(tube) encloses the remainder coordinatewise. Horner
evaluation plus this remainder and valid invariant intersections give the
next endpoint enclosure. Repeating starts from exact rational initial
intervals. No step straddles a switch; the preceding slot's one-sided smooth
extension supplies the common continuous endpoint. Differentiability across
control switches is unnecessary.

**Terminal evidence.** All 512 steps completed with order sixteen and precision
seventy, and the terminal strict-sign verifier returned (-,+,+). I parsed the
entire saved transcript and independently checked its sixteen sequential
integer milestones, configuration, final weight-sum enclosure, and the
containment of the quoted coarse boxes at xi=14 and xi=16 using exact
Fractions. All passed. In particular the certified spin box at xi=14 is

    [-0.002591,-0.002590] x [0.139022,0.139024] x [0.244942,0.244944].

It lies strictly in the (-,+,+) orthant, whose vertex satisfies all five
clauses. The inclusion induction therefore supports actual exact-flow
orthant entry by time fourteen, not merely a guessed witness. This is not
a first-hitting-time statement. The optional 1/100 reporting margin of the
floating probe is only met at its later reported time sixteen; the draft
explicitly distinguishes that reporting policy from certified signs at
fourteen.

The coarse xi=16 box also gives the exact lower residual bound
34358441/200000000>1/8, independently recomputed from the three rational
factors. Thus actual small-residual failure coexists with a valid rounded
witness at that endpoint. No use of the small-residual sufficient detector
is incorrectly asserted.

The arithmetic, inclusion argument and terminal data have no identified
blocker for this bounded computer-assisted certificate. This is a reviewed
Python/Decimal implementation and transcript, not a proof-assistant theorem
or a second independent full interval integration.

## Nonclaims lens: GO-WITH-NOTES for bounded exploratory use

The final draft distinguishes a directly verified Boolean witness from
exact-flow entry into its sign region, and now supplies the latter through
the completed directed interval certificate. The initially proposed target
box is separate from the actual final enclosure. Agreement between floating
runs or solver tolerances is not treated as proof.

The completed certificate concerns one fixed trajectory of one fixed
five-clause formula. It shows later orthant entry despite initial
witness-distance repulsion; it does not establish a general convergence
theorem, uniform SAT horizon, UNSAT rule, fluid implementation or P=NP.
No such stronger claims or full-goal closure are approved by this review.
