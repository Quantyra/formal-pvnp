# Normalized analog SAT: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Baseline `8df8582`.
Harness only. One independent reviewer covers the two separate lenses below;
these are not two separately staffed reviews. Source/complexity alignment is
audited by another reviewer. No code, tests, formal modules/builds, commits,
planning edits or publication are part of this review.

Reviewed the stable `2026-09-08-normalized-analog-sat-attempt.md`, including
the final clarification of original analog-model time, the almost-everywhere
scope of the energy derivative, and the planning-gate repository location.
The proof review below checks the declared equations and new corrected rule;
it does not independently reprove the external article's dynamics.

## Proof-adversarial lens: GO for the stated normalized rule and counterexample

**Normalization.** From A=sum a_m and a_m'=a_m K_m, one obtains
A'=A barK, b_m'=b_m(K_m-barK), and rho'=-rho barK in original time.
Multiplication by dt/dxi=rho gives precisely (3). For the correction, replace
K_m by K_m+q_m only in auxiliary growth and its weighted mean. This gives
(5) without changing the normalized spin vector field G. The retained rho
factors in the auxiliary equations are necessary and present. Reconstruction
a_m=b_m/rho is valid whenever rho>0.

**Bounded state and global normalized evolution.** Clause factors lie in
[0,2], so 0<=K_m<=1 and 0<=K_mi<=1/2 for the stated normalized polynomials.
Absent incidences contribute zero. At either spin-cube face, clauses whose
literal is already true give zero in that coordinate; opposite literals point
inward. Positive auxiliary weights preserve the cube. The b dynamics preserve
positivity and sum b=1. Since 0<=barH<=2,
(1/rho)'=barH in normalized time, proving
1/(M+2xi)<=rho<=1/M. Also |G_i|<=sum b_m=1. Smooth slot vector fields on
bounded finite-time states, with locally finite switches, concatenate uniquely
and do not permit finite-xi escape.

Integrating the lower rho bound yields t(xi)>=log(1+2xi/M)/2. Thus infinite
normalized time is not compressed into finite original-model time here.
The per-weight growth bound a_m(t)<=exp(2t) follows from unit initialization
and K_m+q_m<=2. These statements are mathematical model bounds, not hardware
performance estimates.

**Actual corrected counterexample.** For the two opposing three-literal
clauses, permutation of the three variable coordinates leaves each clause
and every clause-weight-only spin field unchanged. Equal initial coordinates
therefore stay equal by uniqueness, even when the two clause weights differ
and across every schedule switch. On that diagonal, substituting the residual
polynomials gives the fifth-power vector field in (7).

In the first slot barH=5/8 at the initial state. Consequently b_+'=1/8 and
b_-'=-1/8, while z'=0. Differentiating (7) on the first slot gives
z''=(1/8-(-1/8))/32=1/128. This verifies that the proposed correction actually
escapes the original stationary origin. It nevertheless cannot escape the
equal-coordinate subspace. There max(K_+,K_-)=(1+|z|)^3/8>=1/8, so it never
reaches the strict all-clause certificate. Any common sign/tie rounding of the
diagonal also fails one clause. Mixed Boolean signs satisfy the formula, so
this is a genuine satisfiable counterexample to the proposed universal
progress statement, not an UNSAT instance or merely the old stationary trap.

The extension to other clause-weight-only controls is sound under the same
well-posed symmetric spin field and equal-coordinate initialization. It does
not cover variable-specific controls, different initialization, or preprocessing
that changes the declared algorithm. No asymptotic experiment is needed: one
exact satisfiable counterexample disproves the universal convergence claim.

**Certificate and numerical error.** If a clause is false after rounding,
each of its factors is at least one, hence its residual is at least 2^-k.
The strict residual test is therefore sufficient, including zero-spin ties.
On the convex cube each partial residual derivative has magnitude at most
1/2. Summing along the segment between the true and approximate spin points
gives the stated k delta/2 error, plus the residual evaluation error. The
assumption that both points lie in the cube is explicit. Direct Boolean
verification of any proposed rounded assignment is independently definitive.
None of these sufficient tests proves the trajectory will find a witness.

**Energy identity.** The spin gradient of E_b is -G, so its spin contribution
is -sum_i G_i^2. The changing weights contribute rho times the stated
covariance. This proves (10) within slots and almost everywhere on the
continuous switched path; the final text includes this qualification. For
unboosted nonnegative residuals the covariance is nonnegative, as seen from
one half the sum over clause pairs of b_m b_l (K_m-K_l)^2(K_m+K_l).
It cannot be discarded in a descent proof. The weighted-energy example at
z=1 correctly exhibits the need for lower weight bounds and is not claimed
to be a state reached by the specific trajectory.

No blocking defect was found. The conclusion is that this explicit corrected
mechanism fails its required progress criterion, not that every analog SAT
mechanism fails.

## Nonclaims lens: GO-WITH-NOTES for bounded exploratory use

The candidate is explicitly a new controlled system; dynamical results for
the original source are not inherited without proof. Almost-all or random
initialization statements are not promoted to guarantees for the specified
deterministic start. The added schedule is syntax-based and fully specified,
with controller and switching costs identified as unfinished obligations.

The text distinguishes bounded normalized coordinates from inverse-scale
conditioning and from polynomial computational work. It neither equates a
large scale sensitivity with exponentially many bits nor identifies the
piecewise controlled system with a fixed autonomous polynomial ODE.
"Physical time" is expressly defined as original analog-model time, avoiding
an implication of implemented hardware.

Both-outcome scope is honest: residual failure does not certify UNSAT, and
a timeout would misclassify the explicit satisfiable example. The invariant
diagonal is an obstruction to the chosen correction and its stated
clause-weight-only extension, not an arbitrary SAT lower bound or P!=NP.

Safe summary: exact normalization retains the auxiliary scale; round-robin
clause boosts leave the balanced origin but still fail on an invariant
satisfiable diagonal, and no finite UNSAT rule is supplied. This specific
mechanism does not fulfill the P=NP objective. No stronger claim expansion,
physical device claim or full-goal completion is approved.
