# Mixed-charge source and complexity review

2026-09-12. S3088 / E004 / S008. Independent review of the actual [mixed-interaction manuscript](2026-09-12-mixed-interaction-charge.md), after reading the planning integrity/frontier protocol, S3088 intake and S3087 manuscript and reviews. This is analytic AI-agent review, not Lean verification or external peer review.

**GO for the bounded contraction, actual-event score bound and integrated threshold-template comparison. Improved forcing INCOMPLETE; publication HOLD.** No favorable aggregate forcing coefficient or jointly successful parameter choice is established.

## Source and model contract

[Scheder's corrected full version](https://arxiv.org/pdf/2207.11071v1), Sections 3, 6 and 7, supplies the relevant comparison. CCT labels cannot repeat along a down-path; incomparable occurrences share placements. For 3-CNF, Lemma 8 gives sufficient strength w >= 2^(h+1). The selected sibling graph is a multigraph of maximum degree two. The source additionally classifies low/high-density and TwoCC-free edges after its closure. Its component density (22) is 1+theta times the sum of edge kernels, with at most 22 edges; components are sampled independently. TwoCC variables receive a separate unary bias. Lemma 52 uses independent bits on a distinct-label infinite complete binary tree, finitely many biases, and no biased proper ancestor of the repaired node. These hypotheses do not follow from a path graph or from the proposed sequential template.

The manuscript correctly restricts its law to finite simple path forests. Removed cycle or parallel-cycle edges receive no unearned benefit. Its support and label order are fixed independently of threshold r. It retains the exact root identity and placement and does not clone antichain occurrences. These details make the marginalization and translation legitimate for actual CCT cuts. The template family need not be the conditional family of a single ordering distribution; entropy remains charged to the original normalized D.

## Exact aggregate accounting

I independently suggested and checked the support reduction: integrating an unsupported leaf contributes one; integrating a degree-two internal path produces theta^L*m2^(L-1). Contracted endpoints remain actual variables. Long unsupported tails disappear and intervening gaps are attenuated; supported components cannot simply be deleted because the cut function couples them.

The targeted disconnected-component test is exact. For the already realized cut AB OR CD and H={ab,cd}, each independent pair has probability q=r^2+theta*gamma^2, so the cut probability is 2q-q^2 and its second derivative is -2*gamma^4. The integral is -1/36960. This refutes connected-H-only cancellation for the stated general CCT claim. It neither certifies post-closure regular/TwoCC-free admissibility nor refutes positive total forcing. The formula's small fixed-strength escape remains relevant.

The score argument in (3)-(5) controls the actual event under its actual measure. With parent-before-child exposure, integrating a child against its normalized transition makes the edge score mean zero. Thus cross terms vanish in the unrestricted score second moment, while the argument retains all event-weighted cross terms through a valid absolute bound. This is distinct from asserting that each marked pair vanishes with the cut indicator inserted.

Integrating the exact root restores uniform parent marginals. A fixed-root parent marginal alone need not be uniform. Cancelling the transition factor gives the stated a^2 term, and the denominator bound gives the m2^2 term. The final coefficient is below .024882 and hence below .025. This reduces the full Taylor remainder to .0125*epsilon^2*sum K_x, but does not bound sum K_x by O(n). The support size can still grow exponentially with CCT height.

## Threshold translation and its limits

The final manuscript uses conservative derivative constants and delta=4*epsilon^2. The correction functions A, B and C include the moving exact root. Its lower threshold slope 1-4*epsilon >= 3/5, attractiveness in previously revealed bits, and the true conditional error at most 2*epsilon^2 justify the common-uniform sequential coupling. The clipped endpoints are the all-zero and all-one laws. This comparison is on shared labels and does not invoke the source's independent-occurrence lemma.

For a bounded nondecreasing event-probability function, integrating a shift changes its integral by at most delta. Therefore (11) is a depth-uniform bound on the absolute value of the integrated true-minus-template discrepancy. It is not asserted to be the integral of the pointwise absolute discrepancy. More importantly, it is not a true-minus-affine-Taylor bound: products of affine sequential transition probabilities retain higher-order terms. The manuscript states these distinctions correctly.

## First-order source transfer audit

There is an exact but limited transfer. On the same fixed edge set H, the derivative at zero of the source's product of component-linear densities and that of the edge-product density are both sum_e W_e. Hence every fixed finite cut event has the same first derivative, including exact-root conditioning when root marginals are uniform. Component length does not enter this identity. The matching template first derivative is also valid for a fixed finite event.

This does not by itself transfer a positive numerical aggregate coefficient. A source bound of the form F(theta) >= B+a*theta need not imply F'(0) >= a when F(0)>B: preexisting uniform cut surplus can support the inequality. Taking its difference quotient against B is invalid. Moreover, changing from the selected low-density edge set to all uncut paths changes the signed edge sum; adding edges is not known to improve every cut probability. Omitting the source's unary TwoCC bias also changes the first derivative. A valid continuation must track the same edge selection, root penalties, classification and any surplus, or rederive the first-order aggregate explicitly. A finite-epsilon corrected-source coefficient is not an automatic derivative certificate.

## Costs and disposition

Equation (12) is a useful conditional bridge. Its B(epsilon,h) is not supplied. Even with a prospective linear gain, the 4*n*epsilon^2 translation loss, path entropy, finite-height baseline error and all structural losses must fit one positive slack calculation. Taking epsilon small at a fixed depth does not eliminate truncation error; taking depth large while retaining the support-size Taylor constant is equally unjustified. The sufficient implication strength grows exponentially with height. Fixed w gives polynomial per-run work, not polynomial total SAT search under the available guarantees.

The exact support calculation and threshold translation are substantive bounded progress over the previous reveal-union bound. They do not certify novelty, a stronger PPSZ exponent, a polynomial witness finder or progress resolving P versus NP. No author file, implementation, commit, public release, push, paid compute or communication was performed by this reviewer. The public arithmetic reproduction remains a separate artifact. Retain this review with the incomplete forcing obligation visible.
