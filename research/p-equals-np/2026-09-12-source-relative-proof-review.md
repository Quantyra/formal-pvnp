# S3089 independent proof-adversarial review

2026-09-12. S3089 / E004 / S008. Final review of the actual [source-relative comparison manuscript](2026-09-12-source-relative-comparison.md), equations (1)-(12) and the source-classified structural family. **GO for the bounded exact identities and scoped failed inferences; no improved forcing theorem is established.** Domain-only analytic review, with no author edits, commit, publication, push, spend or outreach. This is agent mathematical review, not Lean verification or human peer review.

## Independently derived directional counterexample

This example addresses an unrestricted source-linear-to-product comparison on canonical CCT cut certificates. It does **not** assert admission to the corrected source's preprocessed regular/Hlow classes, and it does not compare actual PPSZ forcing probabilities. Those distinctions are essential.

Take six variables x,y,a,b,c,d and the at-most-3-CNF

    (x OR NOT a OR NOT b)
    AND (a OR NOT c)
    AND (b OR NOT d)
    AND (y OR NOT b OR NOT c)
    AND (c) AND (d).

The units force c=d=1, then a=b=1, then x=y=1. This is its unique solution. Every variable has exactly the displayed critical clause under the all-ones assignment. The canonical sibling graph supplies edge ab from x and edge bc from y; choose H to be the two-edge path a-b-c, with the other vertices isolated. This is a genuine canonical sibling subgraph, without a claim that it survives source closure/classification.

At height two the root-x CCT has children a,b, followed by c,d, so its cut is (A OR C)(B OR D). The root-y CCT has children b,c; c terminates through its unit before the depth cap and is unsafe, while b has child d at the cap. Thus its cut is B OR D. The trees for a,b,c,d have no safe paths and their cut events are true. These follow the actual source safe-leaf convention, not a freely chosen Boolean event.

Put W1=phi(a)phi(b), W2=phi(b)phi(c), and

    L=1+epsilon(W1+W2),
    P=(1+epsilon W1)(1+epsilon W2),
    Delta=P-L=epsilon^2 W1 W2.

Both densities are positive and normalized for 0<=epsilon<=.1. Their individual vertex marginals are uniform and their edge marginals agree. The component-linear law is L here; P is the proposed product law.

For fixed root placement r, let M2(r)=integral_0^r phi(t)^2 dt. Integrating phi(a)phi(c) against A OR C gives -gamma(r)^2. Integrating phi(b)^2 against the D-averaged factor B OR D gives r*m2+(1-r)*M2(r). Consequently

    E_P Cut_x - E_L Cut_x
       = -epsilon^2 gamma(r)^2 [r*m2+(1-r)*M2(r)] < 0

for 0<r<1/2 and epsilon>0. All other roots' cut probabilities are unchanged: y depends only on b,d, whose marginal law is independent uniform under both measures, and the four other cut events are constant. Thus this is an aggregate height-two CCT cut deficit, not merely a local arbitrary-event sign test.

Its magnitude after integrating r is epsilon^2*I, with

    I >= m2*integral_0^(1/2) r*gamma(r)^2 dr
      = (3/32)*(1/16)*B(4,4) = 3/71680.

No numerical computation is needed for this beta-integral identity.

## Exact entropy cost and interpolation direction

Since log P is a sum of edge log-kernels and L,P have equal edge marginals,

    KL_2(L||U)-KL_2(P||U)=KL_2(L||P)>=0.

Thus the entropy benefit is real. It does not pay the cut deficit in this example. The chi-square upper bound gives

    KL_2(L||P)
       <= epsilon^4*m2^2*m4 / [(1-epsilon/sqrt(5))^2*ln 2].

Here m4=integral phi^4<=m2. Using epsilon<=.1, 1/sqrt(5)<=1/2 and ln2>=2/3 bounds the benefit by epsilon^4*16200/11829248. This is strictly below epsilon^2*3/71680 throughout 0<epsilon<=.1. Therefore the summed CCT cut-minus-KL objective is strictly lower at P than at L throughout that interval.

The same obstruction holds infinitesimally for the valid density interpolation R_lambda=L+lambda*Delta. Its cut expectation has constant derivative -epsilon^2*I. Since integral Delta=0 and integral Delta*log P=0, its entropy derivative satisfies

    -d/dlambda KL_2(R_lambda||U)
       = integral Delta*(log P-log R_lambda)/ln2.

For 0<=lambda<=1, P and R_lambda are at least .9 pointwise. The logarithm mean-value bound, together with P-R_lambda=(1-lambda)*Delta, yields

    0 <= -d/dlambda KL_2(R_lambda||U)
       <= (1-lambda)*epsilon^4*m2^2*m4/(.9*ln2)
       <= epsilon^4*45/32768.

At epsilon^2<=1/100 this is strictly smaller than epsilon^2*3/71680. Hence the derivative of the summed CCT cut-minus-KL objective is strictly negative even at the source endpoint lambda=0, and remains negative throughout this interpolation.

As a consistency check, expansion near zero gives entropy savings epsilon^4*m2^2*m4/(2 ln2)+O(epsilon^5). Quadratic and cubic terms agree because mixed moments involving a degree-one endpoint vanish. This expansion is not needed for the rational all-epsilon bounds above.

## Scope of the failed inference

The example refutes an unrestricted theorem that replacing a finite component-linear law with its same-edge-marginal product improves the summed canonical CCT certificate objective. It does not refute a comparison restricted to correctly preprocessed Hlow source instances or a surplus-aware argument exploiting additional structure. The six clauses already force the entire unique assignment at sufficient strength, so the actual forcing count is constant; the cut deficit is not an actual PPSZ success-probability deterioration. Source closure, TwoCC membership, density classes, sponsor eligibility and preserved unary laws must be checked before importing this example into a more restricted claim.

This diagnostic therefore challenges the proposed generic sign and cost inference without claiming a source theorem is false or the product mechanism is impossible.

## Actual-manuscript inspection

I read the saved main equations (1)-(11), including the generic reverse-interpolation discussion. **GO for those bounded mathematical claims.** The direct derivations above independently support its all-root example and finite entropy/interpolation comparisons. The main uses the slightly looser .9 denominator for both endpoint and derivative bounds; its resulting 45/32768 coefficient is valid and still strictly dominated by the cut loss for epsilon<=.1.

For a general selected path component, equation (2) follows exactly from matching edge marginals. The same identity adds over independent replaced components; unchanged source unary and cycle factors cancel. Equation (3) is therefore a correct identity for any fixed observable G, whether cut count or actual forced count. The counterexample then explicitly chooses the cut observable and is not transferred to actual forcing.

The endpoint derivative identity (10) is also exact: integral(P-A)*log P=0, while integral(P-A)*log(P/A)=KL(P||A)+KL(A||P). Differentiating normalized entropy has no leftover integral(P-A) term. Hence J'(0)=g_C plus the symmetric relative entropy. The actual manuscript preserves the finite source baseline and does not deduce a positive derivative from a weaker clean-tree bound.

For feasible negative interpolation, linear expectation minus relative entropy is concave and the displayed second derivative is -(1/ln2)integral Delta^2/Q_lambda. If A is uniformly positive, a sufficiently small two-sided interval exists; on Q_lambda>=A/2 the manuscript's curvature bound follows. A nonzero derivative admits a positive local move in its sign direction. This provides neither a uniform derivative magnitude nor a linear-in-n gain, as the author correctly states. No new mechanism is inferred from generic variational optimization.

The final source-classified positive transfer, surplus charge, structural coverage and compatible epsilon/depth/strength choices remain unproved. This proof GO is not an improved PPSZ result or a publication recommendation.

## Final source-family appendix inspection

I independently inspected the added cyclic-groups construction and the [primary source's label-density definition](https://arxiv.org/pdf/2207.11071v1), printed pages 27–28, equations (17)–(18). The unique-solution argument is exact: all positive triples allow at most two zeros, while any zero requires another zero in the next group and hence one in each of L>=3 groups.

For the one-shot two-original-clause inference, the potentially new prime implicates arise by resolving the two clauses. Two different critical clauses have a complementary pair only in successive groups; their nontrivial resolvent has four distinct literals because the three involved groups are distinct. Critical/positive resolution may yield width three when the positive critical literal is shared, but it retains at least two positive literals. For example, x OR NOT y OR NOT z and x OR y OR w yield x OR w OR NOT z. This corrects an initially stronger informal claim that all mixed resolvents had width four or were tautological; the final manuscript correctly asserts only that no additional critical clause arises. Two all-positive clauses have no complementary literal. Thus the claimed empty TwoCC set follows under the source's stipulated one-shot closure. This argument would not establish the same statement for an iterated closure using new clauses.

Each original variable's only critical clause creates exactly one triangle edge in the next group; the resulting sibling graph is a disjoint union of triangles. Taking all those edges is an admissible degree-two H selection. For canonical occurrences, each depth step advances the group index, so a distinct same-group label first appears at depth at least L. Noncanonical branches do not contribute to canonical label density. Bounding the number of canonical depth-d nodes by 2^d gives

    sum_(d>=L) 2^d*r^(d+1) = r*(2r)^L/(1-2r).

Multiplying by the exact source density weight and using r/(1-r)^3<=4 produces equation (12), 2/[(L+1)(L+2)], at every finite CCT height. For a fixed positive threshold one must choose L to beat that threshold; knowing only an upper cap on the threshold would not suffice. The actual manuscript includes the appropriate threshold-dependent choice. With the specified full-triangle H selection and components already below the size cap, one may take H_low to contain every triangle and obtain zero replaceable path components. This is a statement about this admissible selection, not a prohibition on deliberately cutting edges to choose a different H.

The seven-clause implication witness is also sound. If root x=0, one child a or b must be zero. For zero child a, the two positive triples force both grandchildren u,v to one, contradicting C_a; the b branch is symmetric. All listed triples use distinct variables for L>=3. Thus each x is implied by at most seven original clauses, proving the asserted easy-forcing escape. The structural example cannot exclude a stronger worst-case guarantee that uses this surplus.

Final GO includes this appendix and its explicit distinction from the generic six-variable negative-cut example. It does not certify positive source-relative gain, a new SAT exponent, an obstruction to all surplus-aware analyses, novelty or publication readiness. No unresolved mathematical correction remains in the reviewed statements.
