# S3087 independent proof-adversarial review

2026-09-12. Actual manuscript: [conditional-forcing derivation](2026-09-12-conditional-forcing.md). Scope is this analytic research increment, not the published arithmetic certificate. Independent AI-agent mathematical review; no Lean verification or external human peer review.

Decision: GO for equations (1)-(10), with the stated path-forest, positive-probability rectangular threshold-history, CCT and imported cut-to-forcing assumptions, and for the exact failed pre-cleanup pivotal inference. Full improved forcing-minus-entropy gain remains INCOMPLETE. The two small findings below were corrected and rechecked in the actual manuscript. No publication recommendation is made.

## Exact conditional law

Removing a vertex separates a path into at most two components. Under vertexwise threshold-cell observations and a fixed root placement, component evidence factorizes. Integrating one component produces an affine message in phi. Dividing by its constant coefficient gives (1), where q is an expectation under a positive tilted cell law. Thus q lies in [-1/sqrt(5),1], and 1+epsilon*q'*mu is at least 1-epsilon/sqrt(5). Point conditioning is understood as the regular conditional density at the fixed root value, and its variance is zero.

Multiplying the two incoming messages gives numerator 1+epsilon*(a+b)*phi+epsilon^2*a*b*phi^2. Its integral and partial integral give (2) exactly. The denominator lower bound uses a*b>=-1/sqrt(5). Arbitrary cut-event conditioning need not factorize this way; the draft correctly restricts the proof to sequential rectangular placement histories.

## Constants and path-length uniformity

For 0<r<1/2, the early-cell mean is (1-2r)^(3/2), the late-cell mean has absolute value at most that, and the unobserved mean is zero. Popoviciu's variance bound is below .53. At epsilon<=.1 the geometric message contraction is below .0555 and K<1.06k. Along a component without the root, induction gives K. The single component containing the root adds at most B; a nonadjacent root's effect on the immediate neighbor correction includes at least one contraction factor. Consequently all three message bounds preceding (4) are uniform in path length and the number of revealed cells.

Subtracting the first-order template from (2) gives the linear message correction plus the normalized quadratic remainder with V=M2-r*m2. This is precisely bounded by (4). The powers of d=1-2r in K and B yield the first part of (3); |V|<=r and gamma<=r yield the other. Exact rational evaluation of the displayed conservative decimal upper bounds gives approximately 1.3051232043<2 and 4.8159769512<5. This verifies the stated constants, not just their orders. At epsilon=0 the error is zero.

For r>=1/2, all threshold-cell means and the fixed root's phi vanish. Starting from path endpoints, every message is zero. Successive threshold bits therefore are independent Bernoulli(r), even conditioned on the root. This cancellation would fail for arbitrary additional exact-placement observations, which the manuscript excludes.

## Aggregation and repeated labels

The lower bound p_- in (5) is conservative for both possible nonroot neighbors and the optional fixed-root neighbor. An adaptive sequential coupling on distinct labels dominates independent Bernoulli(p_-) bits without asserting that the original bits are independent. Cut is monotone, so this is a valid lower comparison.

The antichain splitting step has a direct Boolean proof. A cut event is the conjunction, over root-to-leaf paths, of the disjunction of early labels on that path. After conditioning on other labels, a repeated label whose occurrences form an antichain leaves either a constant or a conjunction of a subset of its occurrences. Sharing that label has probability p, at least p^k for k independent required copies. Splitting one label at a time therefore only decreases cut probability. Extending early terminal branches pessimistically yields the complete binary recurrence Q_0=0, Q_(h+1)=(p+(1-p)Q_h)^2 under the draft's safe-leaf/depth convention.

Each root marginal is uniform under the normalized path-forest product measure. Integration and summation give (6); the imported finite-strength cut-to-forcing implication and the established entropy upper bound give (7). This is a finite global conservative bound. Since p_-<=r and entropy is subtracted, it supplies no stronger PPSZ guarantee. The manuscript does not add an unearned sibling bonus. Cycles are excluded unless cut into paths, with removed-edge credit forfeited.

## Realizable failed inference

The five-clause CNF in the draft has exactly one model: c=d=1 by the units, then a=b=1, then x=1. Its depth-two canonical CCT has no same-label ancestor repetition but repeats c,d across branches. Its cut event is (A or CD) and (B or CD), equivalently AB or CD. This is an actual admissible repeated-label diagnostic for the stated unrestricted claim, not an arbitrary correlated-bit event.

Changing the shared C success probability with other independent labels at r gives derivative r(1-r^2). Independently unfolding both C and D occurrences first gives sum of C-occurrence derivatives 2*r^2*(1-r)*(1+r-r^2). At r=.1 these are .099 and .01962. The smaller unfolded derivative cannot bound the shared-label loss. I also exhaustively checked all 32 CNF assignments and the equivalent Boolean cut/pivotal events with standard-library exact arithmetic. This diagnostic is not a regular worst-case SAT family; in particular the five clauses already imply all values at sufficient fixed strength.

## Findings and scope

1. The draft initially printed .019602 for the unfolded derivative at r=.1. Exact evaluation is .01962. The symbolic formula and counterexample direction are correct; author notified to correct the decimal.
2. The draft initially called total clean-tree pivotal weight asymptotic to a constant divided by 1-2r. For simultaneous equal marginal perturbation, the limiting clean-tree probability is Q(r)=(r/(1-r))^2 below .5, whose derivative 2r/(1-r)^3 remains bounded approaching .5. A coarse exploration/exposure upper bound may grow like 1/(1-2r), but it must not be identified with exact total pivotal sensitivity without qualification. Author notified to remove or specify the upper-bound meaning. Neither (1)-(7) nor the counterexample uses that assertion.

The finite N_x*R coupling remainder is valid: the first-order template lies in [0,1] (below .5 it stays between .8r and 1.2r), and summing conditional total-variation errors bounds any cut-event discrepancy. The integral bound epsilon^2/3 follows already from the 2*epsilon^2*(1-2r)^2 branch of R. Exponential height dependence is explicitly charged. No favorable forcing bound for that auxiliary law has been established.

No author, public-artifact or planning files were edited by this reviewer. No commit, push, publication, paid computation, or outreach was performed. GO cannot be promoted into a new uniform forcing gain, solver, complexity separation, novelty claim, or publication gate.


## Final disposition and review of the signed repair

Both earlier findings are resolved: the actual draft now has .01962 and replaces the susceptibility assertion with a hypothetical integrability diagnostic plus the correct limiting Q derivative. I inspected the added signed-repair section before extending GO to (8)-(10).

For the isolated a-b-c path, expansion of B(A or C) gives base probability r(2r-r^2), linear term 2*epsilon*gamma^2*(1-r), and quadratic term -epsilon^2*M2*gamma^2. Replacing B by an independent bit while retaining the endpoint marginal changes only the quadratic contribution to -r*epsilon^2*m2*gamma^2. Their difference is (8). For ABC the analogous expansion gives 2*epsilon*r*gamma^2+epsilon^2*V*gamma^2, proving (9). The bounds -r*m2<=V<=(1-r)*m2 prove nonnegativity throughout the stated epsilon range. These statements require the isolated unconditioned triple and are not asserted under all hybrid evidence.

The exact-root one-edge marginal has density 1+epsilon*phi(r)*phi(t), already normalized because integral phi=0. Directly subtracting E[I]*E[phi] from E[I*phi] gives the displayed covariance. Near r=1/2 from below, V tends to m2/2 and phi(r)=-3*sqrt(d)/2+O(d^(3/2)), so its leading negative term is -(3*epsilon*m2/4)*sqrt(d), dominating gamma~d^(3/2)/2 for fixed positive epsilon. Thus the sign reversal is real; its scope is a conditional-density diagnostic, not a source-admissible worst-case forcing refutation.

For a finite forest the product density is polynomial in theta and its root marginal remains identically uniform. Differentiating the normalized conditional probability therefore introduces no derivative of a normalizing denominator. The product rule gives exactly two times the unordered distinct-edge-pair sum in (10). This would require modification for a cyclic product and is correctly restricted to the forest.

At theta=0, integrating a mean-zero phi over a label's two threshold cells gives gamma times the label's discrete difference. Four distinct nonroot endpoints therefore give the fourth mixed difference with gamma^4. For adjacent edges, the shared factor is phi(b)^2, whose early integral is M2 and total integral m2. Splitting the b-bit dependence into its value at zero plus its difference gives precisely the stated adjacent-edge formula. Repeated CCT labels must remain single variables in these derivatives; repeated occurrences cannot be differentiated as independent labels. At positive theta the residual product stays in the integral, as the draft requires.

An integrated bound on the negative part of the summed second derivative would supply an O(n*epsilon^2) Taylor remainder, but no such bound or compatible favorable first-order aggregate has been proved. The final scoped GO covers the exact local identities and the identified missing inequality, not its solution. The published curated repository remains untouched.
