# Asymmetric seed: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Baseline `26ee6fb`.
Harness only. One independent reviewer covers both separately reported lenses;
these are not two separately staffed reviews. A separate reviewer audits source
and complexity scope. No code files, formal builds, commits, planning edits or
publication are part of this review.

Reviewed stable `2026-09-08-asymmetric-seed-attempt.md`, including the final
complex-neighborhood and intermediate-arithmetic precision clarifications.
This is an informal mathematical review, not an implemented numerical run.

## Proof-adversarial lens: GO for the restricted-family result and invariant test

**Seed and weight bounds.** The specified coordinates i/[2(n+1)] are distinct
rationals in (0,1/2), with consecutive separation d0=1/[2(n+1)]. The retained
corrected growth is nonnegative in original model time, so a_m>=1. Thus
b_m=a_m rho>=rho and the earlier reciprocal-scale lower bound applies to
each clause, despite global normalization and the cycling schedule.

**Gap identity.** Subtracting the two spin equations within a complementary
triple gives the common factor (s_i-s_j) and exactly the coefficient in (3).
Both summands are nonnegative on the cube, so the initial sign and lower gap
are preserved. For the positive clause, K_+^2 divided by its coefficient
without b_+ equals (1-s_i)(1-s_j)/2, at most two. Cross-multiplication proves
the same inequality when a factor vanishes. The negative clause has the same
argument. Hence A_ij>=b_m K_m^2/2 for either clause. These are identities for
the actual evolving weights, not a fixed-weight proxy.

**Hit bound.** If a block's maximum residual never falls below epsilon, its
positive gap obeys log(d(X)/d(0))>=epsilon^2 log(1+2X/M)/4. The maximizing
clause may vary because both weights have the same lower bound. For epsilon
=1/32, the coefficient is 1/4096. At the chosen H, multiplying the initial
gap lower bound by 8(n+1) forces d(H)>=4, contradicting the cube's maximum
gap two. Thus each block has a strict hit by H. This proves individual hits,
not simultaneous low residuals. Global normalized weights from other disjoint
blocks do not affect the estimate.

**Witness detection.** Each triple residual is 3/2-Lipschitz in normalized
time from its three partial derivatives and |s_i'|<=1. The first sample at
or after a strict 1/32 hit has residual below 5/128 on the 1/192 grid and
occurs before H+1. The stated two-sided enclosure budget adds at most
5/4096, still strictly below 1/16. Clipping approximations into the cube
does not increase spin error. Their residuals consequently remain below the
1/8 rounding threshold, and direct Boolean verification makes each latch
definitive. Combining latched assignments is legitimate because the variable
blocks are disjoint. No argument combines inconsistent overlapping witnesses.

**Restricted-family bit-work bound.** The slot field has degree at most six:
the largest spin product has one b factor and residual degrees three and two;
the normalized auxiliary products have the same maximum degree. Literal
product estimates on the radius-two polydisc give the stated bounds on K,
K_mi, G, barH and auxiliary components, all below B=128(M+1).

A coordinate-disc Cauchy estimate gives the conservative row-sum derivative
bound 4dB on the complex half-neighborhood of the exact real invariant set.
A numerical start within one quarter of that set and its additional
quarter-radius Picard ball lie inside this domain. At Rtime=1/(16dB), the
displacement bound is at most 1/16 and the contraction factor at most 1/4.
Local analytic solutions therefore have a common time radius and bounded
coefficients. The proposed hstep is Rtime/768, safely within the stated
geometric-tail ratio. Its denominator is divisible by 192, so both sampling
and integer switching times are grid boundaries; Taylor steps do not cross
a discontinuous control change.

The global error estimate is a standard discrete Gronwall consequence of
the local Lipschitz flow bound: at most Nstep local errors amplify by at most
exp(Lips(H+1)). The chosen local error leaves a factor-four reserve and keeps
the numerical centers within the assumed neighborhood by induction. Strict
switch alignment preserves this estimate for the concatenated slots.

The coefficient recursion uses truncated univariate series in the explicit
fixed-degree field, not all multivariate derivative tensors. Its number of
arithmetic operations is polynomial in order and input size. Cauchy coefficient
growth and the displayed product convolution bounds keep logarithms of
intermediate magnitudes polynomial; the revised text also budgets forward
rounding amplification and guard bits. Divisors are known nonzero rationals
and positive integer indices. Thus polynomial order/precision suffice even
though local errors are exponentially small in the polynomial horizon.
This avoids the invalid inference that a polynomial real-time horizon alone
implies polynomial numerical work. Here H has a very large but fixed degree,
so the resulting bound is polynomial for this restricted growing family.
No implementation or practical feasibility is established.

**Actual-seed overlap calculation.** I independently multiplied the rational
literal factors at (1/8,1/4,3/8). The four residual numerators over 2048 are
175,135,385,495. Summing the signed coordinate terms gives exactly the three
G values in (8), and G2-G1=-17825/524288. The initial clause boost changes
auxiliary derivatives, not that instantaneous spin vector field. Hence the
negative derivative tests the specified corrected system at its actual seed.
The formula is satisfiable by (true,true,false), has both signs of each
variable, and its rounded all-true seed fails C4. The counterexample therefore
disproves the proposed global monotone-gap invariant without invoking an
unreachable state or an already-successfully-terminated run.

This last calculation does not prove failure or slow convergence of the
revised algorithm itself. No blocking proof defect was found in the stated
restricted-family theorem or this more limited invariant obstruction.

## Nonclaims lens: GO-WITH-NOTES for bounded exploratory use

The positive result concerns an easy, always-satisfiable disjoint-block family
and an explicit latching observer. Its polynomial bound is a quantitative
dynamics result for that family, not a new general SAT complexity theorem.
The note makes both facts explicit. The overlap example invalidates one
progress measure and is not advertised as a counterexample to convergence
of every asymmetric initialization or the whole corrected flow.

The seed is syntax-based, but distinct coordinates do not certify avoidance
of all exceptional invariant sets. No almost-everywhere attraction theorem
is promoted to a deterministic guarantee. The model-time interpretation,
piecewise control costs and uniform numerical error obligations remain
declared; no physical fluid implementation or blanket BGP translation follows.

For general formulas, failure at H is not a valid NO certificate. The draft
correctly notes that a genuinely universal SAT success horizon, effective
simulation and reliable detector would suffice for a timeout-based decision;
it does not demand a separate refutation mechanism unnecessarily. The required
universal horizon is absent here.

Safe summary: asymmetric initialization has a proved finite detectable
success bound on disjoint complementary triples, with an explicit theoretical
bit-work argument; a selected-seed overlapping example defeats the attempted
monotone-gap extension. All-input convergence and decision complexity remain
open. No stronger claim expansion or full P=NP goal completion is approved.
