# Conditional forcing under the path product kernel: local cancellation, global loss

2026-09-12. S3087 / E004 / S008. Independent proof, source/complexity and non-claims reviews complete; scoped analytic GO, improved forcing INCOMPLETE, publication HOLD.

**Outcome: INCOMPLETE.** The path measure admits a threshold-specific, path-length-independent second-order conditional-error bound, including an exact root exposure. A conservative global CCT forcing bound follows by domination and repeated-label splitting. That repair discards the positive sibling contribution and therefore does not improve PPSZ. The attempt to retain that contribution using clean-tree pivotal weights fails at an explicitly realized repeated-label CCT. This is not a counterexample to an improved product-measure analysis, a new SAT mechanism, or a completed overnight objective.

## Target and sources

The intended theorem is a worst-case lower bound on

\[
 \sum_x\Pr_D[\operatorname{Forced}_w(x)]-\operatorname{KL}_2(D\Vert U)
 \ge (2-2\ln2+\beta)n-o(n)
\]

with an actual certified bonus exceeding the applicable corrected-source guarantee, after jointly choosing finite implication strength, bias, and size threshold. The ordering measure is an auxiliary proof measure depending on a fixed unique solution, not an algorithm supplied that solution.

Closest primary source: [Scheder, corrected full version, arXiv:2207.11071v1](https://arxiv.org/pdf/2207.11071v1), Sections 3, 7.2–7.4 and 7.8. Its CCT construction prohibits repeated labels on a down-path, permits repetitions in separate branches, and converts a cut to forcing at sufficient strength. Its biased-node estimate is applied after independence/distinct-label cleanup. Its informal Markov-chain discussion already identifies the conditional-dependence issue. The corrected 22-edge/12-to-11 estimates remain separate imported results; none is substituted unchanged into our product law. [The preceding assessment](2026-09-12-witness-discovery-mechanism.md) gives the kernel and the already published arithmetic reproduction. That reproduction is not this proposed advance.

The precise attempted difference is to retain path edges while bounding the additional forcing loss, rather than only compute their entropy. No priority, optimality, or new algorithm claim is made. All calculations below are analytic; no finite experiment or source-code change was required.

## Exact conditional messages

Let H be a finite disjoint union of paths, and

\[
 D_\epsilon(t)=\prod_{uv\in E(H)}(1+\epsilon\phi(t_u)\phi(t_v)),\quad
 \phi(t)=\sqrt{1-2t}(1-5t)\,1_{t\le1/2},\quad 0\le\epsilon\le .1.
\]

Write \(\gamma(r)=r(1-2r)^{3/2}\) below one half and zero above, \(m_2=3/32\), and \(c=1/\sqrt5\). Thus \(-c\le\phi\le1\).

Fix a root label x with placement r. Reveal any subset of other labels only through the threshold bits \(1_{t_u<r}\). Every resulting positive-probability history is a product of cells \([0,r], [r,1], [0,1]\), with at most the one point cell \(\{r\}\). This is not an assumption that conditioning on a whole cut event is rectangular.

For a cell A set \(\mu_A=E_A\phi\), \(\nu_A=E_A\phi^2\). A directed message from a path component into its adjacent vertex has the form \(1+\epsilon q\phi(t)\), up to a constant. Eliminating the next vertex gives the exact recurrence

\[
 q=\frac{\mu_A+\epsilon q'\nu_A}{1+\epsilon q'\mu_A},\qquad
 q-\mu_A=\frac{\epsilon q'\operatorname{Var}_A\phi}{1+\epsilon q'\mu_A}. \tag{1}
\]

All messages are conditional expectations of phi, so lie in [-c,1]. The denominator is at least \(1-\epsilon c\). The point cell has variance zero and sends q=phi(r), independently of evidence beyond it.

At an unrevealed vertex v, with effective messages a,b from its two sides (missing side zero), let \(M_2(r)=\int_0^r\phi^2\) and \(V(r)=M_2(r)-rm_2\). Its exact conditional probability is

\[
 p_v=\frac{r+\epsilon\gamma(r)(a+b)+\epsilon^2abM_2(r)}{1+\epsilon^2abm_2}. \tag{2}
\]

The product denominator in (2) is at least \(1-\epsilon^2cm_2\), including opposite-sign messages. Conditional probabilities given only a root/threshold history are therefore controlled without assuming unconditioned distance correlations persist after exposure.

## Threshold-specific second-order lemma

For each immediate H-neighbor u of v, let \(\mu_u\) be its *bare cell mean*: zero if unrevealed, \(\gamma(r)/r\) if revealed early, \(-\gamma(r)/(1-r)\) if revealed late, and \(\phi(r)\) if it is x. Define

\[
 p_v^{(1)}=r+\epsilon\gamma(r)\sum_{u\sim_Hv}\mu_u.
\]

**Lemma.** Under every history above, for \(0<r<1/2\),

\[
 |p_v-p_v^{(1)}|\le R_\epsilon(r):=
 \min\{2\epsilon^2(1-2r)^2,\;5\epsilon^2r\}. \tag{3}
\]

For \(r\ge1/2\), every threshold bit other than the fixed root is exactly independent Bernoulli(r), and the error is zero. Endpoint r=0 is interpreted by a limit.

Proof details, retaining the cancellation: put \(d=1-2r\), \(k=d^{3/2}\), \(B=|\phi(r)|\le(3/2)\sqrt d\). Every nonpoint cell has \(|\mu_A|\le k\). Popoviciu's bound gives \(\operatorname{Var}_A\phi\le(1+c)^2/4<.53\). Set

\[
 \lambda=\frac{.53\epsilon}{1-\epsilon c},\qquad K=\frac{k}{1-\lambda}.
\]

For epsilon at most .1, \(\lambda/\epsilon<.555\), \(K<1.06k\). Equation (1), iterated down a side without the root, bounds its message by K. A side containing the root is bounded by K+B. There is at most one such side. If the root is the immediate neighbor its message has no correction to its bare mean; otherwise its contribution to that correction acquires at least one lambda. Consequently

\[
 |(a+b)-\textstyle\sum\mu_u|\le\lambda(2K+B),\quad
 |ab|\le K(K+B),\quad |a+b|\le2K+B.
\]

Subtract the first-order expression from (2). Its absolute error is at most

\[
 \epsilon\gamma\lambda(2K+B)+
 \frac{\epsilon^2K(K+B)\bigl(|V|+\epsilon\gamma(2K+B)m_2\bigr)}{1-\epsilon^2cm_2}. \tag{4}
\]

Use \(|V|\le m_2\), \(\gamma\le d^{3/2}/2\), and the bounds above. The coefficient of \(\epsilon^2d^2\) is smaller than

\[
 .555(3.62)/2+
 \frac{1.06(2.56)\left(3/32+.1(3.62)(3/32)/2\right)}{1-.01(.45)(3/32)}<2.
\]

Alternatively \(|V|\le r\), \(\gamma\le r\), K<=1.06 and B<=1.5 bound the coefficient of epsilon-squared times r by

\[
 .555(3.62)+
 \frac{1.06(2.56)\left(1+.1(3.62)(3/32)\right)}{1-.01(.45)(3/32)}<5.
\]

This proves (3). For r>=1/2 both threshold-cell means and phi(r) vanish. Recurrence (1) then sends zero from every end/root, proving independence of all threshold bits by sequential conditioning. Arbitrary exact-value exposures would destroy this cancellation; they are not used here.

## Substantive repair: a conservative bound for every full CCT

Equation (3) permits a global bound without assuming independent CCT occurrences. Define, for r<1/2,

\[
 j(r)=\gamma(r)/(1-r),\qquad
 p_-(r)=\max\{0,\ r-\epsilon\gamma(r)(2j(r)+|\phi(r)|)-R_\epsilon(r)\}, \tag{5}
\]

and p_-(r)=r otherwise. In any threshold history each nonroot neighbor's bare mean is at least -j(r); a root neighbor's contribution is at least -|phi(r)|. Thus every successive distinct-label threshold bit has conditional success probability at least p_-(r). Sequential coupling gives domination by independent Bernoulli(p_-(r)) **on labels**, including labels in other roots' trees and variables not incident to useful edges. No independence of the original measure is asserted.

A CCT cut is monotone in those bits. Under the independent label law, split repeated occurrences into independent copies with the same success probability. This can only decrease cut probability: condition on other occurrences; because a repeated label forms an antichain, each root-to-leaf path contains at most one of its occurrences, and the remaining Boolean requirement is a conjunction of a subset of them (or a constant). Shared success probability p is at least p raised to the number of required copies. Repeating this operation yields independent occurrences. Early terminal branches can pessimistically be extended to a complete binary safe-leaf tree.

Let Q_0(p)=0 and \(Q_{h+1}(p)=(p+(1-p)Q_h(p))^2\). For an actual height-h CCT T_x the result is the finite, fully aggregated lower bound

\[
 \sum_x\Pr_D[\operatorname{Cut}(T_x)]\ge
 n\int_0^1 Q_h(p_-(r))\,dr. \tag{6}
\]

Use the source cut-to-forcing implication with enough strength to accommodate all clauses in each chosen tree. Together with the already derived path entropy estimate this gives

\[
 \sum_x\Pr_D[\operatorname{Forced}_w(x)]-\operatorname{KL}_2(D\Vert U)
 \ge n\int_0^1Q_h(p_-(r))\,dr-.0064\epsilon^2|E(H)|. \tag{7}
\]

This is a real forcing-loss bound covering every root and all repeated labels on a path forest. It has the wrong sign to improve the baseline: p_-<=r and the KL cost is nonnegative. The monotone domination step sacrifices exactly the favorable sibling conditional contributions we needed to retain. It is not legitimate to add the source's positive sibling gain to (7), since that gain has already been discarded in this comparison.

Cycles are not covered by the path messages or their normalization. Cutting at least one edge of each cycle creates a forest to which (7) applies; no credit for those removed edges is retained. A normalized cyclic product requires additional analysis. Isolated vertices are covered. TwoCC bonuses, high-label structural gains and overlapping paths have not been claimed separately; the conservative full-tree bound applies regardless of such classifications.

## Why retaining the gain is still open

The cancellation in (3) would make even a hypothetical 1/(1-2r) susceptibility integrable, since \(\int_0^{1/2}d^2/d\,dr=1/4\). This is only an integrability diagnostic, not an established susceptibility bound for the hybrid CCT law. In fact the homogeneous limiting independent-tree cut function below saturation is Q(r)=r^2/(1-r)^2 and its derivative 2r/(1-r)^3 stays bounded at one half. Neither that homogeneous derivative nor a geometric occurrence-weight estimate is automatically the correct derivative during dependent-label cleanup.

Here is an exact **realizable CCT** test of that invalid step. The unique-satisfying at-most-3-CNF

\[
 (x\vee\neg a\vee\neg b)\wedge
 (a\vee\neg c\vee\neg d)\wedge
 (b\vee\neg c\vee\neg d)\wedge(c)\wedge(d)
\]

has all-ones as its unique solution. Its canonical height-two CCT for x has children a,b, and both children have children c,d. The safe leaves occur at the depth cap. Writing capitals for early-placement bits gives

\[
 \operatorname{Cut}=(A\vee CD)(B\vee CD)=AB\vee CD.
\]

Under independent label bits with parameter r, decreasing the single shared C probability by delta decreases cut probability **exactly** by \(\delta r(1-r^2)\). After incorrectly splitting the two C occurrences first, the sum of their pivotal derivatives at the independent occurrence law is \(2r^2(1-r)(1+r-r^2)\). At r=1/10 these are respectively .099 and .01962. The loss of a shared label therefore cannot be charged using the occurrence-clean tree derivative as if cleanup had already happened. This realizes the relevant CCT and down-path restrictions; it is not an arbitrary correlated-pair toy.

Scope is essential: this formula is not certified to satisfy the source regular/padded/TwoCC-free hypotheses, and its five clauses already force the entire solution when w>=5. It supplies neither a SAT-hard family nor a counterexample to aggregate forcing gain. It refutes only the proposed unrestricted pre-cleanup occurrence-weight inference. Its repeated-label cut probability 2r^2-r^4 already exceeds the corresponding independent-occurrence probability, so a surplus-aware cleanup might pay some of this loss; that repair is not excluded.

### A signed local repair that works, and the remaining hybrid obligation

There is a nontrivial cancellation beyond scalar domination. On an isolated path a-b-c with no root in the component and no external evidence, compare the actual event B(A OR C) with the event after replacing B by a fresh independent Bernoulli(r) bit while preserving the actual marginal law of A,C. Integrating out b leaves endpoint density 1+epsilon^2*m2*phi(a)*phi(c). Direct expansion gives original-minus-replaced probability

\[
 \gamma(r)^2\bigl(2\epsilon(1-r)-\epsilon^2V(r)\bigr)\ge0. \tag{8}
\]

For event ABC the corresponding difference is

\[
 \gamma(r)^2\bigl(2\epsilon r+\epsilon^2V(r)\bigr)\ge0, \tag{9}
\]

since -rm2<=V<=m2(1-r). These are exact signed replacement inequalities, rather than a worst-case bound that deletes every positive term. They show why the first cleanup idea is worth trying.

They do not cover all hybrid steps. After earlier replacements/exposures, the endpoint base measures acquire fields, repeated occurrences of b may remain elsewhere in the event, and the root may lie in the same component. In particular a one-edge exact-root field changes a single endpoint density to 1+epsilon*phi(r)*phi(t). Its threshold/phi covariance has numerator

\[
 \gamma(r)+\epsilon\phi(r)V(r)-\epsilon^2\phi(r)^2\gamma(r)m_2.
\]

For fixed positive epsilon this is negative sufficiently near r=1/2 from below: writing d=1-2r, its leading terms are d^(3/2)/2 minus (3*epsilon*m2/4)*sqrt(d). Thus the positive covariance used in (8)–(9) cannot be assumed under all root-conditioned hybrid fields. This is a conditional-density sign diagnostic on a path, not a claimed regular-CCT or total-forcing counterexample. The resulting adverse effect still has the saturation cancellation of (3); the problem is charging it through the actual event.

One exact formulation of the outstanding mixed-sensitivity charge is available. Fix an actual CCT cut indicator f_x and root value r. Put W_e=phi(t_u)phi(t_v) for e=uv, substituting t_x=r. For 0<=theta<=epsilon define

\[
 M_{x,e,f}(r,\theta)=\int f_x(t)W_eW_f
            \prod_{g\ne e,f}(1+\theta W_g)\,dt_{V\setminus\{x\}}.
\]

Path normalization and uniform root marginals imply the exact second derivative

\[
 \frac{d^2}{d\theta^2}P_{D_\theta}(f_x\mid t_x=r)
       =2\sum_{e<f}M_{x,e,f}(r,\theta). \tag{10}
\]

Under the independent base law, disjoint nonroot edge pairs contribute gamma(r)^4 times a fourth mixed discrete derivative of the cut function. Adjacent edges a-b, b-c instead contribute

\[
 \gamma(r)^2\bigl[m_2\,E\Delta_a\Delta_c f_x\vert_{B=0}
                  +M_2(r)E\Delta_a\Delta_b\Delta_c f_x\bigr].
\]

Root-incident pairs have additional phi(r) factors and lower-order derivatives. Repeated labels require derivatives on distinct labels, not their occurrences. At theta>0 the residual product in (10) is the correct hybrid weight; replacing it by independent clean-tree probabilities is precisely an unproved comparison.

A depth-uniform bound on the integrated negative part of the sum in (10), over all roots and actual source-admissible H, would control the second-order aggregate remainder by C*n*epsilon^2. It must be combined with a positive **proved first-order aggregate** for that same H and a signed, surplus-aware cleanup preserving the sibling credit. Neither a bound on this mixed sum nor that transfer for uncut source paths has been established here. Summing absolute terms individually can also count edges outside the cut's support which cancel only after integration; that is not a justified efficient charge. Equations (8)–(10) delimit the attempted repair more sharply than an assertion that correlations are simply difficult.

The justified repair was to perform the independent-label domination and antichain splitting before using clean-tree recurrence; equations (5)–(7) show its exact price. A sharper repair must retain sibling-pair benefit while cloning antichains and transporting the root-conditioned messages. The missing statement is a signed cleanup inequality that controls the loss of the **actual shared-label cut event** by a depth-uniform integrable charge, with positive sibling credit kept in the same inequality. Equation (3) alone bounds a single reveal, not that signed cleanup operation.

For comparison, reveal every distinct nonroot label in a height-h CCT and use the first-order conditional template as a sequential auxiliary law. It is a valid sequential probability law in this epsilon range, although generally order-dependent. Maximal coupling and (3) bound the cut probability difference from the true law by \(N_xR_\epsilon(r)\), with \(N_x\le2^{h+1}-2\). Integrating and summing gives at most \(n\epsilon^2(2^{h+1}-2)/3\). This is a finite global remainder, but the auxiliary law has no proved favorable forcing bound and the exponential height factor is not compatible evidence for the required improvement.

## Quantifiers, costs and next gate

A successful continuation must exhibit jointly admissible epsilon>0, finite h and implication strength w covering the CCT clause count, with a proved positive net bonus after both the finite-height baseline error and every second-order/structural loss. Taking h to infinity while silently keeping an exponential-in-h remainder constant is invalid. Taking epsilon arbitrarily small at fixed h does not remove the fixed truncation error. No jointly successful choice is supplied here.

The actual PPSZ operation remains uniform-order bounded implication, unbiased guesses, and checking the output against the original CNF. For fixed w a run has polynomial cost n^{O(w)}; exponential repetitions remain necessary for the available guarantees. The solution-dependent graph is a proof object, not free preprocessing. This attempt does not provide a randomized polynomial witness finder, RP=NP, deterministic polynomial SAT, P=NP, or a lower bound.

Selection: retain equations (1)-(10) as a reviewed bounded analytic attempt and exact failed-inference diagnosis. Full conditional-forcing improvement remains INCOMPLETE; novelty and publication readiness are unestablished.

| Review lens | Actual review | Scoped decision |
|---|---|---|
| Proof adversarial | [Proof review](2026-09-12-conditional-forcing-proof-review.md) | GO for (1)-(10) under their stated assumptions and the failed pre-cleanup inference; improved forcing INCOMPLETE |
| Source / complexity | [Source and complexity review](2026-09-12-conditional-forcing-complexity-review.md) | GO for bounded path-forest and isolated signed analysis; aggregate gain and joint parameter slack INCOMPLETE |
| Non-claims boundary | [Non-claims review](2026-09-12-conditional-forcing-nonclaims-review.md) | GO for the bounded record; HOLD publication of this incomplete mechanism |

These are independent AI-agent reviews of an analytic manuscript, not Lean verification or external human peer review. The review table does not upgrade the forcing result or complete the overnight objective. No publication, push, paid computation, source release, or external communication was performed for S3087. The already published corrected-source reproduction and its curated v1.0.0 artifact remain unchanged.
