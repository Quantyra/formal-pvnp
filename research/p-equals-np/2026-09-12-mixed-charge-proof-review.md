# S3088 independent proof review

2026-09-12. Reviewed actual [mixed-interaction manuscript](2026-09-12-mixed-interaction-charge.md), S3088 intake, and the reviewed S3087 assumptions. This is independent agent mathematical review, not Lean verification or external human peer review. No author-file edits, commit, publication, push, paid computation, or outreach.

**Decision: GO for the exact support contraction, support-charged second derivative, and depth-uniform comparison to the nonlinear sequential template, within the stated finite path-forest model.** No improved forcing-minus-KL guarantee, depth-uniform affine Taylor remainder, positive template forcing contribution, novelty or publication readiness is certified. One harmless decimal-bound finding is recorded below.

## Support reduction and the disconnected diagnostic

Integrating a terminal label outside event/root support removes its sole kernel because integral phi=0. Integrating a degree-two internal label multiplies the two coupling parameters by m2. Induction therefore proves the length-L coefficient theta^L*m2^(L-1). This is exact marginalization, not an independence approximation. The support includes the root even if the Boolean event does not depend on it. Components with no supported labels vanish; remaining components contract to a forest on support labels. No cycle normalization or multigraph extension is implicitly used.

For the prior actual CCT AB OR CD with disjoint H edges ab and cd, the pair-early probability is q=r^2+theta*gamma^2 and the two pairs are independent under the chosen H. Thus event probability is 2q-q^2 and its second derivative is -2*gamma^4. Substitution u=2r gives integral gamma^4=(1/32)B(5,7)=1/73920. Hence the displayed -1/36960 is exact. This genuinely tests the disconnected-supported-pair cancellation rule, while the manuscript correctly withholds source regularity and SAT-hardness claims.

## The actual second derivative

For each oriented contracted edge, the child transition integrates to one. Its score s_e has zero expectation conditional on all preceding exposures, since the kernel cancels its denominator and integral phi(child)=0. This remains true for edges leaving the fixed root. Ordering forest edges parent before child makes their scores martingale differences, so E_r S^2=sum_e E_r s_e^2.

Twice differentiating the finite product density gives exactly equation (3): the log derivative supplies S, and the second log derivative supplies -sum s_e^2 plus the k'' terms. The conditional density is normalized for every theta with the root fixed, since the root marginal is uniform for every theta. Thus there is no missing derivative of a normalizing factor.

Because 0<=f_x<=1, the triangle inequality bounds the S^2 and sum s_e^2 contributions by twice the sum of edge score second moments. This step does not claim that mixed terms vanish after inserting f_x. Integrating r recovers the unconditional path law and hence uniform parent marginals. Bounding the transition denominator by 1-.1/sqrt(5) proves the first term in (4). In the absolute k'' term the transition denominator cancels exactly; integrating child then parent gives (integral |phi|)^2=.03456.

The sequences k'_L=L(theta*m2)^(L-1) and k''_L=L(L-1)m2(theta*m2)^(L-2), L>=2 for the latter, are decreasing from their respective first terms because the successive ratios are at most 2*.1*m2 and 3*.1*m2. Their maxima are 1 and 2m2. Consequently the coefficient is

    2*m2^2/(1-.1/sqrt(5)) + .03456*(2*m2) < .025.

One can prove the strict inequality without floating-point arithmetic by replacing 1/sqrt(5) with 9/20; the resulting rational upper bound is still below .025. Taylor's integral remainder gives .0125*epsilon^2*sum K_x. This is support-charged, not O(n*epsilon^2) without further control of sum K_x.

**Resolved minor finding:** the original prose said the coefficient was below .024881, but its numerical value is approximately .0248810447378154. The author changed the prose to .024882, and I rechecked the actual file. Equation (5) and all claimed theorem constants are unaffected. A direct arithmetic evaluation checked this named rounding uncertainty; no solver or mathematical experiment was performed.

## Conditional-template derivatives and validity

The actual draft deliberately uses the conservative constants |A'|<=1, |B'|<=9/8 and |C'|<=2. They are valid. In the variable u=2r the listed Bernstein coefficients (1,-1,0,0) and (1,-2,1,0) exactly represent A' and C'. The convex-hull property supplies their bounds. Differentiating B=-r*A/(1-r) and using (1-2r)^2<=(1-r)^2 gives the displayed bound 1+r(1-2r)<=9/8.

With at most two neighboring contributions, derivative of every fixed-history probability is at least 1-4*epsilon>=3/5. Corrections extend continuously to zero above one half, and endpoint values are p(0)=0 and p(1)=1. Piecewise integration of the lower derivative bound proves global monotonicity and that p is a valid probability at every history, including histories with zero probability under an endpoint law. Changing a revealed neighboring bit from late to early adds epsilon*gamma^2/[r(1-r)]>=0. The fixed root contribution is C(r), and it changes with r; it is not treated as a constant external field during translation.

Stronger derivative constants were discussed in coordination but are unnecessary and are not the claimed manuscript constants. The actual comparison uses delta=4*epsilon^2, not 2.5*epsilon^2.

## Depth-uniform coupling and integration

The root-specific reveal order is deterministic and is shared by all compared laws. Therefore each induction step compares histories on the same labels. For positive-probability true histories, S3087 supplies |q_r(h)-p_r(h)|<=2*epsilon^2 independently of depth and reveal count. If h_true<=h_upper and r+delta<=1, monotonicity in history and threshold yields

    p_(r+delta)(h_upper) >= p_r(h_true)+(3/5)*delta
                         >= q_r(h_true).

The last inequality holds because (3/5)*4*epsilon^2>=2*epsilon^2. Using a common uniform random number preserves the coordinatewise order at the next bit. The lower coupling is symmetric. When the shift crosses an endpoint, the template law is all zeros or all ones, providing the comparison directly. At epsilon=0 equality holds. Conditional laws at the exact endpoints can be interpreted through their continuous limiting versions.

The event is the same fixed, r-independent monotone Boolean function of distinct labels throughout the coupling. A repeated CCT occurrence is not a new coordinate. Root conditioning is handled separately for each r; shifting the template means shifting its root field as well. These conditions suffice for (10) even with repeated labels. They would not automatically hold for a reveal order that changes with the realized history or an event definition that changes with r.

The same fixed-order coupling makes F_x(s) nondecreasing. Constant extension outside [0,1] gives

    0 <= integral_0^1 [F_x(r+delta)-F_x(r)] dr <= delta,

and the corresponding lower-shift inequality. Integrating the pointwise sandwich proves (11). Its assertion is the absolute value of the integrated discrepancy, not an L1 bound on the pointwise discrepancy; the draft states the correct version. Linearity and the triangle inequality sum the bound to 4*n*epsilon^2 without requiring independent root events.

## Remaining mathematical boundary

Every one-step template probability is affine in epsilon, but multiplying the history-dependent transition factors makes the joint law nonlinear. Matching the derivative at epsilon=0 for each fixed finite event does not control its uniform-in-depth Taylor remainder. Equation (11) therefore supplies a real depth-uniform comparison while leaving both the favorable template forcing contribution and the alternative template Taylor-charge route unproved.

Equation (12) is valid conditionally on its explicitly missing lower bound B(epsilon,h), together with sufficient-strength cut-to-forcing and the preceding entropy estimate. No jointly positive epsilon/height/strength choice is supplied. The manuscript maintains the distinction between the bounded analytic increment and the unresolved goal. This proof GO does not authorize promotion into a stronger PPSZ exponent, a polynomial witness algorithm, a complexity separation, or publication.
