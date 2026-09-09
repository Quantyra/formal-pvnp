# Reaction amplification: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Harness-only independent review of
`2026-09-08-reaction-amplification-attempt.md`. One reviewer covers both
lenses below; these are not two independent reviewers. Source/complexity
review is assigned separately. This is an informal derivation audit, with
no formal module, build, numerical experiment, code change or commit.

## Proof-adversarial lens — GO

The substantive derivations pass. One minor range clarification was
requested: the constant positive preparation-bias example should explicitly
use 0<delta<1 to justify saying that perturbed run stays in the unit cube.
The author applied this clarification; the saved change was verified.
No outstanding corrections remain.

The polynomial vector field points inward on every face of the unit cube.
Local uniqueness and boundedness therefore give a global exact solution
from the Boolean initial vector. Variation of constants uses a positive
heat semigroup and nonnegative reaction along that exact solution, proving
u>=h. The previous heat kernel consequently supplies minimum u(1)>=4^(-n)
on every SAT input, at every vertex.

The spatially constant logistic trajectory is a solution of the same
diffusion-reaction system. Its comparison with u is justified by the
linear difference equation with nonnegative off-diagonal entries and
bounded diagonal coefficients. Positivity of this time-dependent system
preserves the initial order without assuming a differentiable minimum.
The logistic value at time2 is exactly the displayed expression. Since
exp(4n)>16^n, A=4^(-n)exp(4n)>4^n>=4, and
A/(1-g+A)>A/(1+A)>4/5. UNSAT gives the identically zero solution by
uniqueness. The asserted constant gap is therefore valid. n=0 is handled
directly before setting up these positive-dimension arguments.

The signed-perturbation argument does not use cube invariance for the
perturbed system. Until its sup error reaches1, the perturbed coordinates
are in [-1,2]; together with exact coordinates in [0,1], this gives
|4n(1-u-u_tilde)|<=8n. Variation of constants and heat sup contraction
give the scalar integral inequality with coefficient8n. Its Gronwall
bound is at most exp(8nt)(delta+t eta). The rational budget in (7) gives
exp(16n)(delta+2eta)<1/16 because exp(1)<4. A first exit at error1 is
impossible. The bounded neighborhood also ensures continuation through
time2, so finite-time blowup of an arbitrary polynomial perturbation is
not silently excluded without argument. Piecewise-continuous bounded
forcing is compatible with the integral equation and the a.e. derivative.

An additional readout error1/16 makes the total error less than1/8.
The stated UNSAT upper bound1/8 and SAT lower bound27/40 leave threshold
1/2 strictly separated. On the explicit UNSAT family, spatially constant
initial bias eliminates diffusion; the logistic expression (8) and its
threshold delta=1/(1+exp(8n)) are exact. Choosing any fixed delta in (0,1)
does eventually exceed the threshold as n grows. This is actual
preparation sensitivity, not a claim that every error direction is harmful.

Differentiating normalized energy without a one-half factor gives exactly
the unordered-edge coefficient -2^(1-n) and reaction term8n times the
normalized sum u^2(1-u). Its maximum per coordinate is4/27, yielding
32n/27 instantaneous and64n/27 integrated upper bounds. E<=1 follows
from invariance, while the singleton's E(0)=2^(-n) and E(2)>16/25
demonstrate nonmonotonicity. The full sup-speed bound2n and horizon2
give path length at most4n. Neither normalization conceals a factor error
in these mathematical estimates; physical costs are separate.

The coefficient recurrence correctly combines the diffusion term with
the convolution for the quadratic reaction. The final draft defines the
coefficients directly as time-zero derivatives divided by factorials;
smoothness of the polynomial ODE suffices for these finite derivatives. For the
singleton at1^n, induction on coefficient order proves zero support
beyond that order's graph-distance neighborhood. At a vertex of distance
d>0, all local lower coefficients vanish at the first possible order.
Only the d nearer neighbors contribute, each with first coefficient1;
division by d gives coefficient1 at order d. Thus a_n(0)=1, while every
lower coefficient there vanishes. A Taylor polynomial of degree below n
gives zero at time2 and fails the required constant-error approximation.
No convergence at time2 of the infinite series is used.

Permutation symmetry of this special initial condition and equation is
preserved by uniqueness. A weight-k vertex has k neighbors of weight
k-1 and n-k of weight k+1, yielding exactly system (13) with boundary
terms omitted. This proves an n+1 dimensional description of this family,
not a general compression theorem or a proved numerical complexity bound.

## Nonclaims lens — GO-WITH-NOTES

The amplifier is a substantive mathematical constant-gap construction,
with explicit sensitivity and error budgets. It is a new exponential-
dimensional model, not an established Navier--Stokes implementation.
The reaction contributes positively to energy; no purely dissipative or
thermodynamically free amplification is asserted.

The full-state sup-path length is polynomial in the chosen norm, but the
state has2^n coordinates and the explicit RHS has n2^n neighbor terms.
The initial Boolean predicate has a short description without thereby
providing efficiently prepared or evaluated full-state data. Thus the
path bound alone is not a standard polynomial-time SAT algorithm or a
justified application of a fixed-dimensional analog-computation bridge.

Exponentially small input/forcing tolerances need only O(n) specification
bits here. That fact neither supplies physical precision nor bounds the
cost of maintaining all coordinates. Conversely, the draft does not
mistake tolerance magnitude for an exponential bit-length requirement.

The Taylor obstruction excludes the specified degree-below-n global
truncation, not all polynomial-degree schemes, repeated stepping or other
representations. The symmetric example's exact compression is expressly
retained to prevent an unrestricted hardness inference.

A uniform deterministic polynomial evaluator for u_0(2) from arbitrary
succinct CNF input at additive error1/8 would decide SAT by the proven gap.
No such evaluator is constructed or proved impossible. No general
physical lower bound, fluid computer, unconditional P=NP conclusion or
full-goal closure is supported. The bounded informal results pass; the
uniform evaluator and full research objective remain unresolved.
