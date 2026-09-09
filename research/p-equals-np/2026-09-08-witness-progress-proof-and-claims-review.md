# Witness progress: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Baseline `6d9ec9e`.
Harness only. One independent reviewer covers the two separately reported
lenses; these are not two separately staffed reviews. No code, formal
modules/builds, commits, planning edits or publication are involved.

Reviewed stable `2026-09-08-witness-progress-attempt.md`, including the final
parameter-range, boundary-invariance and stopping-condition corrections.
The review checks the written identities and bounded implications, not an
external convergence theorem or a full-goal closeout.

## Proof-adversarial lens: GO after the recorded corrections

**Witness-relative identity.** Differentiating V_v=(1/2)sum(s_i-v_i)^2 gives
sum(s_i-v_i)G_i with no weight derivative: v is fixed and this potential has
no b dependence. For a witness-true literal, c(s_i-v_i)/(1-cs_i)=-1;
for a witness-false literal it is (1+cs_i)/(1-cs_i). The resulting sign and
factor -2 in (2) are correct with the actual instantaneous weights.

At a vanishing denominator, the weighted product K_m^2 times the quotient
has the displayed polynomial extension: one factor (1-cs_i) remains and the
other literal factors are squared. Thus the potential derivative extends
continuously to cube faces, although Gamma considered separately need not
be bounded. The note does not divide by a zero literal factor in the field.

**Geometry and boundary invariance.** The initial draft omitted an upper bound
on a. Review required and verified the correction 1/3<a<1: without it the
claimed sublevel containment would be false for a>1. In the corrected range,
V_v<=(1-a)^2/2 forces every |s_i-v_i|<=1-a, hence v_i s_i>=a.
For a false witness literal, cs_i<=-a, giving the ratio upper bound
(1-a)/(1+a). At most two literals can be false in a width-at-most-three
clause satisfied by v, proving the positive margin (4).

The revised invariance argument explicitly handles a zero derivative at the
original boundary. Choose a' strictly between 1/3 and a. On the larger
sublevel associated with a', the derivative is nonpositive. Integration up
to any proposed first exit from that larger sublevel prevents V_v from
increasing at all, so a trajectory initially in the smaller one remains
there. The retained cube invariance and continuous polynomial derivative
handle intersections with cube faces and scheduled switches. No strict
normal derivative is incorrectly assumed.

**Conditional horizon.** Review also required explicit 0<epsilon<1/8, which
is now present. Before a residual hit, E>=rho epsilon^2 follows from the
weight of a maximizing clause. The assumed beta inequality then gives
-V_v'>=2 beta rho epsilon^2. Integrating the lower bound
rho>=1/(M+2xi) gives exactly (5). At the stated horizon the putative decrease
would be V_v(0)+1, contradicting nonnegativity. This proves a hit, or an
earlier directly verified witness, provided the extra hypothesis persists
until that event. The final stopping wording makes this alternative explicit.

This bound is exponential in a linear V_v(0) when beta and epsilon are fixed.
It is an available sufficient bound, not a runtime lower bound. Rescaling the
potential also rescales its descent rate and cannot eliminate that dependence
by a change of units. The aligned sublevel already rounds to a satisfying
assignment, so its invariance supplies no general search mechanism.

**Actual-seed all-witness example.** Each of the five distinct clauses forbids
exactly its opposite Boolean sign pattern. They exclude the two uniform
assignments and the three assignments with two negative coordinates. The
remaining three vertices are exactly the witnesses listed in the table.
The all-positive rounded seed fails the all-negative clause, so the run is
not bypassed by initial witness verification.

Independent rational multiplication at (1/8,1/4,3/8) reproduces the five
residuals and all three G coordinates. Dotting G with s-v, with the factor
1/2 convention in V_v retained, gives respectively the positive numerators
17441,47529,25857 over 10485760. The potential values 71/64,87/64,103/64
also match. Thus every possible fixed satisfying witness has positive
distance derivative at the actual selected seed. The first boost changes
weight derivatives, not these instantaneous spin velocities.

The nearest witness is unique at the seed with a strict value gap.
Continuity preserves that identity for a short initial interval; smooth
within-slot evolution preserves its positive derivative there. Therefore
the minimum of these half-squared distances, and equivalently of squared
distances, also initially increases. Indeed all three fixed-witness
derivatives remain positive briefly. This defeats the stated pointwise
descent hypothesis even when a witness is chosen nonconstructively for the
proof. It does not establish trapping, slow runtime or failure of a future
cycle-integrated argument.

No blocking mathematical defect remains after the three verified corrections.

## Nonclaims lens: GO-WITH-NOTES for bounded exploratory use

The witness is explicitly a fixed analysis parameter, never supplied to the
algorithm or used to select controls. This avoids solving SAT implicitly
through witness advice. The actual weights and deterministic seed remain
part of the claimed dynamics; no almost-sure source theorem is promoted to
an all-input guarantee.

The local alignment result, hypothetical beta inequality and conditional
exponential horizon are distinguished from an established polynomial
decision theorem. The counterexample concerns all pointwise witness-distance
choices at this selected seed, not all possible potentials or the entire
algorithm. No P=NP impossibility claim follows from the failed inequality.

The draft preserves the distinction between a verified witness, a residual
certificate and an arbitrary timeout. A universal SAT-success deadline with
reliable detection would support a NO decision on remaining inputs; the
required deadline is not obtained here. No physical implementation or
standard-model complexity theorem is implied by these informal identities.

Safe summary: exact witness-relative differentiation gives a conditional
local descent criterion and an insufficient exponential hit bound, while
a five-clause actual-seed example repels every satisfying vertex initially.
An all-input SAT-restricted progress theorem remains open. No stronger claim
expansion, formal route-final status or full P=NP completion is approved.
