# Source-directed realizable CMMSA hardness: exception variables

2026-09-12; S3123 / E004 / S008; [integrity](../../INTEGRITY-CLAIMS.md).
**DURABLE WORKING DRAFT, not a reviewed theorem. Publication HOLD.**
Root authorized the exception-variable lemma and a bounded dependency audit
of the PCP composition. The elementary lemma below is complete. The full
parameter-extension argument and its composition are proposed below;
until fresh review is complete, no resolution of the
source's open question is claimed.

## Published target and selected difference

The selected question is the realizable-case question in Section 7 of
[Hirahara and Nanashima, A Sharp Characterization of Pessiland, revision 1](https://eccc.weizmann.ac.il/report/2026/052/revision/1/download/):
restore epsilon=0 in Theorems 1.3 and 1.8. Revision 1 is dated June 23,
2026; its corrected regime has each sufficiently large leaf/advice bound
fixed independently of instance length. The prior version's superconstant
parameter claim is not used. The target factor is ell^(1-o(1)), not C ell.

The concrete operation adds one positive exception literal to each member
of an explicitly sampled CMMSA list. Its quantitative application needs
completeness error chosen after fixing the PCP alphabet. This is a proposed
structural application of elementary slack variables, with no claim that
slack variables themselves are new. The main audit concerns whether that
parameter order is valid for the source's actual PCP construction.

Two source gaps were inspected: the random-linear-density 3-CNF bounded-depth
Frege question in [Gryaznov and Talebanfard](https://arxiv.org/html/2403.02275v2)
and the selected realizable question. The first was not selected; a bound
for that fixed proof system has no direct P-versus-NP implication. Supporting
PCP sources below are dependencies of the second question, not additional
candidate gaps. No S3120-S3122 rejected operation is reused.

## Explicit-list exception lemma

Input: M>=1 monotone formulas F_1,...,F_M on N variables, each with at most
L leaves; positive rational weights w_i summing to one; positive rational
budget s<=1; integer sigma>=8; rational 0<Gamma<1/2; and rational epsilon
with epsilon>=0 and epsilon sigma <= Gamma/2. The promises are:

* YES: some assignment of weight at most s satisfies at least 1-epsilon
  of the list, counting indices with multiplicity.
* NO: every assignment of weight at most sigma s satisfies strictly less
  than Gamma of the list.

Set lambda=sigma s/Gamma. Introduce M fresh variables e_j and replace
F_j by F_j OR e_j. Give original variables raw weights w_i and every e_j
raw weight lambda/M; divide every weight by 1+lambda. Set

    t = (s + lambda epsilon)/(1+lambda),
    sigma_new = floor(sigma/4), Gamma_new = 2 Gamma.

In the YES case, take an original witness and enable exactly the exception
bits for its failed list indices. Its raw weight is at most s+lambda epsilon,
and it satisfies every augmented formula. No witness or failed-index set
is needed to compute the reduction: these choices establish existence.

In the NO case, any augmented assignment of normalized weight at most
sigma_new t has raw weight at most

    floor(sigma/4)(s+lambda epsilon) <= 3 sigma s/8.

Its original-variable part therefore satisfies less than Gamma of the
original list. Its enabled exception bits occupy at most

    (3 sigma s/8)/lambda = 3 Gamma/8

of list indices. The augmented acceptance fraction is strictly less than
11 Gamma/8, hence strictly less than 2 Gamma. This proves the claimed
perfect-completeness gap reduction. Normalization cancels in both budget
comparisons, and t<=1 because s<=1 and epsilon<=1.

The output has N+M variables, M formulas and at most L+1 leaves per formula.
Construction copies the list, adds M OR gates, and performs rational
arithmetic on input rationals. It is polynomial in the actual input and
output bit lengths. For fixed sigma,Gamma, inverse-polynomial lower bounds
on w_i and s imply the same for the normalized weights, t, and lambda/M.
No SAT, optimum, or counting oracle is used. Applying this directly to an
exponential implicit distribution would be invalid; sampling precedes it.

## PCP dependency audit: completed observations

Use h for the Grassmann dimension parameter, m for the number of leaf
queries, rho for the soundness slack, and J for outer repetition. These
are distinct from the final monotone leaf bound L and instance length.

[Minzer and Zheng, Near Optimal Hardness of Approximating k-CSP, v1](https://arxiv.org/html/2510.23991v1)
is the inspected PCP version. Its alphabet has size R=2^(2h). Its outer
3-Lin completeness parameter can be any fixed positive number; its NO
gap is an absolute constant. The numerical inference from its displayed
J=2^(100h^2), beta=loglog(J)/J to the outer-value premise of Lemma 5.7
does not follow just from Claim 3.2: beta J is only O(log h), whereas that
premise asks for an exponent proportional to h^2. This is a bounded
dependency observation, not a claim that its main theorem is false.

The proposed explicit replacement is

    J = 2^(2^(A h^2)), beta = A h^2/J,

where A is a sufficiently large fixed integer chosen from the outer
soundness and decoding constants. This retains beta=loglog(J)/J but
increases beta J while reducing the covering errors. It is a modification,
not the parameters printed in the source.

General repetition parameters are supported by
[Khot, Minzer and Safra, On Independent Sets, 2-to-2 Games and Grassmann Graphs, Section 4.4](https://theoryofcomputing.org/articles/v021a010/v021a010.pdf).
Lemmas 4.6 and 4.7 give, under 2^d beta<=1/8, the basic statistical-distance
bound beta sqrt(J) 2^(d+4), and the zoom-in bound sqrt(beta) J^(1/4) 2^(d+5)
outside a sqrt(beta) J^(1/4) fraction of zoom-ins. Their conditioning is
conditioning the joint subspace sampler, which also changes the posterior
distribution of V; an unconditional V sampler is not interchangeable.

The proposed full argument explicitly controls that posterior, then
condition on a bounded-codimension zoom-out. The proposed control truncates
the number D of deleted equation blocks at h^4, uses binomial tails, and
uses the density bound O(2^(2 r h^4)) for an r-dimensional advice Q with
non-negligible marginal density. The details, remaining source uses,
sampling, denominator control and learning transfer follow in the next
sections as a proposed proof awaiting independent review.

## Parameter extension: posterior and zoom-out argument

This section supplies the parameter modification rather than treating an
inverse-alphabet completeness error as part of a black-box theorem.
All logarithms here are base two. Fix m and a positive rational rho.
Import the local decoding and bounded-number-of-maximal-zoom-outs results
in MZ Theorem 4.2 and Theorem 5.5. Their parameters r and the constants
in their bounds depend on m,rho; their ambient space may be enlarged.
Choose h sufficiently large relative to these fixed parameters and a
multiple of b_m, the denominator of the selected rational rho. Then
2(1-rho)h and all test dimensions are integers. All
subspaces below are over GF(2), U consists of J disjoint triples, and
dim(U)=3J. The side-condition space H_U has dimension J.

Write a=r_dim for an advice dimension, 0<=a<=r, and c for a zoom-out
codimension, 0<=c<=r. Write d=2h. In the outer sampler each triple retains
all three coordinates with probability 1-beta, and otherwise retains a
uniformly chosen single coordinate. Thus the number of dropped blocks
D is Bin(J,beta), and dim(V)=3J-2D. Let P be the uniform distribution on
a-subspaces Q of U. Let P' be the marginal obtained by first sampling V,
then sampling a uniform a-subspace of V.

For J=2^(2^(A h^2)) and beta=A h^2/J, the advice statistical distance obeys

    SD(P,P') <= delta_adv := beta sqrt(J) 2^(a+4).

This is smaller than 2^(-100h^2) for sufficiently large h. Likewise the
KMS zoom-in exceptional fraction

    delta_zoom := sqrt(beta) J^(1/4)

and the conditional distance delta_zoom 2^(d+5) are smaller than
2^(-100h^2), after increasing the fixed lower bound on h. The condition
2^d beta<=1/8 is satisfied. Increasing A does not cause a circular choice:
A depends only on fixed decoding/outer constants, and h is chosen afterward.

Set T=h^4 and zeta=2^(-30h^2). The binomial tail has the explicit bound

    Pr[D>T] <= (e A h^2/T)^T <= 2^(-100h^2)

for sufficiently large h (round T to an integer if needed). Except on a
P'-mass at most 2^(-70h^2) of Q, Markov's inequality gives
Pr[D>T | Q]<=zeta. Passing from P' to P adds at most delta_adv to this
exceptional mass. Further, the set where P'(Q)<P(Q)/2 has P-mass at most
2 delta_adv, by the definition of statistical distance. Intersect these
good sets with the KMS good zoom-in set. The excluded P-mass is at most

    delta_zoom + 3 delta_adv + 2^(-70h^2) < 2^(-20h^2).

Fix a Q outside this exceptional set. For any V with D<=T, Bayes' rule
and the Gaussian binomial formula give

    Pr[V | Q]/Pr[V]
      = 1[Q subset V] / ( [dim(V) choose a]_2 P'(Q) )
      <= 2 [3J choose a]_2 / [3J-2D choose a]_2
      <= 8 * 2^(2aT).

The last inequality follows by factoring out 2^(2aD) in the product
formula; the remaining finite products are bounded by an absolute
constant because 3J-2D is much larger than a. This is a density bound
for the actual posterior, not an assumption that V remains unconditioned.

Now let W=W(Q) be any subspace containing Q, of codimension c<=r.
Once Q is fixed, W is fixed before V is sampled. Express W as the kernel
of a rank-c matrix. Failure of codim_V(W intersect V)=c means that some
nonzero linear combination of its rows has support entirely outside V.
For each of the at most 2^c-1 combinations, select one nonzero coordinate.
That coordinate is removed with probability at most beta. A union bound
therefore gives the unconditional estimate (2^c-1)beta, uniformly in W.
Applying the posterior density bound on D<=T, and then the tail bound,
gives, for this same Q,

    Pr[codim_V(W intersect V) != c | Q]
       <= 8 * 2^(2aT) (2^c-1) beta + zeta
       <= 2 zeta.

The last inequality holds for large h because J is double exponential in
h^2. The estimate is valid for every W(Q) of the permitted codimension;
there is no union over all W, no assumption that W is chosen independently
of Q, and no use of an unconditional rank estimate after conditioning.

The KMS distribution conditioned on Q is exactly the posterior needed
here. Indeed, the probability a uniform d-subspace L of V contains Q is

    1[Q subset V] [d choose a]_2 / [dim(V) choose a]_2.

The numerator is independent of V, so conditioning the joint (V,L)
sampler on Q subset L induces the same V posterior as sampling Q uniformly
inside V. This also explains why an unconditioned outer draw is invalid.

For the zoom-out, put b=d-a and p0=2^(-cb). On the rank-stable event,
the additional probability of L subset W, given V and Q, is

    p_V = [dim(V)-a-c choose b]_2 / [dim(V)-a choose b]_2
        = p0 (1 + O(2^(-J/2))).

This product estimate is uniform: dim(V)>=J always, while a,c,d are
O_{m,rho}(h). Under the uniform U sampler the corresponding probability
is at least p0/2 for large h. Conditioning two distributions at distance
Delta on an event of probability at least p0/2 changes their distance by
at most O(Delta/p0). Apply this with the KMS conditional distance
Delta=delta_zoom 2^(d+5).

Finally compare the posterior mixture with the mixture additionally
weighted by p_V. Rank-unstable V have posterior mass at most 2 zeta;
their contribution to the normalized weighted mixture is O(zeta/p0).
On the remaining V, p_V/p0 differs from one by O(2^(-J/2)). Hence for
any event concerning L, the difference between these two mixtures is

    O(2^(-J/2) + zeta/p0).

Both this expression and Delta/p0 are much smaller than 2^(-10h^2), since
p0>=2^(-2rh). Therefore agreement with a decoded function on a uniform
L satisfying Q subset L subset W transfers to the actual posterior
experiment with additive error below 2^(-10h^2). This supplies the
conditional-on-W step with the correct V distribution. It also supplies
the rank stability required when the two provers extend their functions.

### Decoder probability is measured in the same joint law

The outer advice consists of shared random vectors in V (MZ Section
3.2), and both provers take the span of the same first a vectors after
independently guessing a. Given linear independence, the span is uniform
among a-subspaces of V. The probability of dependence is at most
sum_{i=0}^{a-1} 2^(i-dim(V)) <= 2^(r-J). Thus the actual vector-advice law
and the ideal experiment V then uniform Q subset V differ in statistical
distance by at most 2^(r-J). This error is negligible compared with every
success term below; no alteration of the outer game is needed.

Fix a good first-prover question U. In the ideal joint experiment the
marginal law of Q is P', and the conditional law of V is exactly the
posterior analyzed above. The favorable advice set has P-mass at least
2^(-6h^2)-2^(-20h^2)-2^(r+1-2J). Passing to P' subtracts delta_adv,
so its P'-mass is at least 2^(-8h^2). For each such Q the expected
agreement under the actual posterior V is at least C-2^(-10h^2), hence
at least C/2. Since agreement is in [0,1], the posterior probability
that it is at least C/4 is at least C/4. Subtracting the rank-failure
probability 2 zeta leaves at least C/8 for large h.

These two probabilities multiply within the actual joint experiment:
P'(good Q) times Pr[good V | Q]. They are never converted to an
unconditional V success probability for a fixed Q. In particular, the
factor 8*2^(2a h^4) was used solely to upper-bound a rank-failure event;
its reciprocal is not a loss in the decoded success bound. The
independent-vector correction subtracts at most 2^(r-J) from the final
joint success, again negligible. The threshold-ladder strategy below supplies the maximal-extension step.
### Total tables and transverse subspaces

The source vertices L plus H_U require L intersect H_U={0}. For each
U, extend the induced table to all d-subspaces by assigning the zero
linear function on otherwise undefined entries. The local decoding
Theorem 4.2 is applied with its stated side-condition/transversality
hypothesis. Its resulting agreement on the full conditioned Grassmann
space, or equivalently the agreement after charging the exceptional
entries, loses a negligible amount quantified here.

If Q intersect H_U={0} and W contains Q+H_U with codimension at most r,
a uniform d-subspace L between Q and W fails transversality only if
L/Q meets (H_U+Q)/Q nontrivially. A union bound over nonzero vectors
of this J-dimensional image bounds this probability by

    2^(J+d-dim(W)+1) <= 2^(-2J+d+r+1).

This follows from Pr[z in a uniform b-subspace of an n-space]
=(2^b-1)/(2^n-1), and applies with an extra factor at most two if a
preceding distribution was already conditioned on transversality.
It is negligible compared with C.

For each second-prover question V fix an arbitrary legitimate completion
U_0(V) containing V. Define its total table on every d-subspace L of V
by T1[L+H_{U_0}]|L when transverse, and by zero otherwise. This definition
depends only on V and the fixed global assignment table. Whenever L is
transverse to both H_U and H_{U_0}, the source clique-consistency relation
identifies the two values. No equality is asserted on other entries.

Here are explicit charges for those other entries in the actual joint
law for a fixed original U. On D<=T, dim(V)>=3J-2T. For uniform Q subset
V, the probability Q meets H_{U_0(V)} nontrivially is at most
2^(a+J-dim(V)+1) <= 2^(-2J+2T+r+1). This bound is valid although U_0
is selected after V. Including the tail gives joint probability at most
2^(-100h^2)+2^(-2J+2T+r+1). By Markov, except on P'-mass at most
2^(-69h^2), its posterior probability for fixed Q is at most zeta.
Passing to P adds delta_adv. Remove these Q from the good advice set;
the total removed advice mass still fits the bound 2^(-20h^2).

For remaining Q,V with D<=T, rank stability, and Q disjoint from both
side-condition spaces, take L uniform between Q and W intersect V.
For either side-condition space the same quotient union bound gives
nontransversality probability at most

    2^(J+d-(dim(V)-r)+1) <= 2^(-2J+2T+d+r+1).

For H_{U_0} not contained in W intersect V use its intersection with
that space; its dimension is at most J, which only improves this bound.
Thus replacing either total table by the actually defined transverse
values costs at most twice this bound on good V, plus the posterior
tail and exceptional probabilities O(zeta). These are below
2^(-10h^2). Enlarge the finite lower bound on h to absorb all such
additive errors simultaneously. In the subsequent agreement ledger
one may use expected agreement C/2, good-V agreement C/4, and good-V
probability C/8 as already budgeted. No undefined table entry or
unproved identity on nontransverse L is used.
### Explicit threshold ladder for maximal extensions

A single arbitrarily lowered threshold does not guarantee maximality.
Instead the second prover guesses j uniformly from {0,...,r} and uses
B_j=C/(4*5^j). For a favorable V, begin with (W(Q) intersect V,g|_V),
which has codimension at most r and agreement at least B_0=C/4. At
stage j, if the pair is (B_j,1/5)-maximal, stop. Otherwise Definition
5.4 supplies a proper extension of the pair with agreement at least
B_j/5=B_{j+1}. Replace the pair by that extension. Each replacement
strictly decreases codimension, so this process stops by stage r,
at latest at the whole space, where no proper extension exists.

Thus at one of these r+1 thresholds a maximal pair exists whose function
extends the first prover's restriction. The second prover enumerates all
maximal pairs of codimension at most r at the guessed threshold and
chooses uniformly; this is a strategy for a value bound, not a polynomial
algorithm used by the reduction. Theorem 5.5 bounds each such list by
B_j^(-2)*2^(O_{m,rho}(h))=2^(O_{m,rho}(h)). Its threshold hypothesis holds:
the local agreement is C=2^(-2(1-1000rho^2)h)/5, so

    B_r / 2^(-2(1-rho^3)h)
       = 2^(2(1000rho^2-rho^3)h)/(20*5^r) >= 1

for sufficiently large h (take rho<1). Codimension is at most the
source local bound r<=10m/rho; the advice dimension is also within
Theorem 5.5. This costs the additional constant factor 1/(r+1), with
no single-threshold existence assumption. Random compatible extensions
then agree with probability at least 2^(-r).
## Completing the modified PCP parameter order

Fix m>=2 and a desired exponent slack xi>0; set rho=xi/4000, shrinking it
further if necessary to meet the imported local theorems. Use the same
star-query construction as MZ, with the new J,beta above. The following
table checks every ambient/repetition-dependent loss used in its decoding
argument. Local Grassmann decoding and the maximal-zoom-out counting
theorem are imported; the numerical parameter extension is argued here.

| Use | Control under the replacement |
|---|---|
| Ambient dimensions in local decoding | 3J and dim(V)>=J exceed every fixed lower bound depending on h; H_U has dimension J and the same disjoint-triple structure. |
| Duplicate clique choices | The source Gaussian-binomial comparison decreases exponentially in J; for large h the union over m^2 pairs is at most 2^(-J). |
| Lucky advice meeting H_U | Its uniform probability is at most 2^(r+1-2J). |
| Advice/zoom-in covering | The bounds above and their exceptional Q sets are less than 2^(-20h^2), below the local decoding lucky mass 2^(-6h^2). |
| Zoom-out and rank steps | The posterior calculation above gives error below 2^(-10h^2), below the decoded agreement C>=2^(-O_{m,rho}(h)). |
| Number of maximal zoom-outs | The imported bound is 2^(O_{m,rho}(h)) for the relevant agreement and codimension; its constants do not depend on J. |
| Random extensions | Their agreement cost is at most a factor 2^r, since codimensions are bounded by r. |

Consequently the source's local-to-outer decoding strategy, with these
errors retained instead of dropped, has success at least 2^(-C_* h^2)
for some fixed C_*=C_*(m,xi), whenever the composed test has value above
R^(-(1-xi)m). To see the scale explicitly, the factors are a test-density
term 2^(-O_m(h)), a constant dimension-guess factor, lucky-advice mass at
least 2^(-8h^2), decoded agreement 2^(-O_{m,rho}(h)), a list-choice factor
2^(-O_{m,rho}(h)), and extension probability at least 2^(-r).
The exponent slack between rho and xi absorbs the fixed multiplicative
losses and the 2^(-J) clique loss. No factor depending exponentially on J
is paid in this decoded success probability.

The fixed outer NO gap gives, by the outer-game bound, success at most
2^(-kappa beta J), with kappa>0 depending on the fixed advice size and
outer NO gap, not on the outer YES error. Choose an integer

    A > (C_*+10)/kappa.

Then this is at most 2^(-(C_*+10)h^2), contradicting the decoded success.
Conditioning on legitimate equation tuples changes it by at most a factor
two, as ensured by padding below. Thus the modified PCP has soundness
at most R^(-(1-xi)m), where R=2^(2h).

Only after fixing m,xi,h,J,beta do we fix any desired positive constant
PCP completeness error tau. Select the outer 3-Lin YES error

    epsilon_1 <= tau / (100(m+1)J).

The starting hardness theorem allows every fixed positive epsilon_1 with
an absolute NO gap. In particular, this does not require exactly
satisfiable linear equations to be NP-hard. Its reduction exponent may
depend on epsilon_1, which is allowed because every parameter here is a
constant independent of the input length.

To account for discarded illegitimate tuples, take sufficiently many
disjoint copies of the outer instance so their probability a is at most
min(tau/100,1/4). The bound is O(J^2/N_outer) with a constant from the
bounded occurrence condition. Copies preserve the value and degree bound.
The number required depends only on the already fixed parameters; for
an input of length n the padded size is O(n+N_min), still polynomial.
Conditioning on legitimate U multiplies a failure probability by at most
1/(1-a). The sampler's marginal for each clique-resampled U'_i is uniform
over legitimate U: the initial vertex is uniform, and uniform resampling
within its equivalence class preserves that measure. All relevant spaces
have the same dimensions and number of transverse extensions.

An honest global labeling satisfies the composed constraint whenever the
equations in the original U and all m resampled U'_i are satisfied.
Union bounding gives failure at most

    (m+1)J epsilon_1/(1-a) <= tau/75 < tau.

Using all m+1 blocks is deliberately conservative; no equality between a
single-block bound and the multi-query acceptance event is needed. This
establishes the required parameter order: for each fixed m,xi and each
sufficiently large h, every fixed positive tau is available without
increasing R. J and the source input-size threshold can be very large,
and all are charged as fixed constants.

The construction and enumeration cost is N_outer^(O_{m}(J)) with constants
depending on these choices, plus the starting outer reduction. It is not
a polynomial with a uniform exponent when L, h or tau vary with input
length. No superconstant-parameter hardness claim is made.

## From the modified PCP to an explicit realizable list

Use HN's star-projection compilation and its occurrence weights, retaining
repeated leaf-variable consistency as in its Lemma 4.6. It gives formulas
with at most (m+1)R leaves, a normalized honest budget s, and a constant
NO satisfaction bound 3/4 up to weight sigma s, where we may safely take
the explicit integer

    sigma = floor(R^(1-1/m)/16), xi=1/m^2.

For implementation this floor is computed by integer root comparison;
no irrational number is an encoded weight. The constant 1/16 is smaller
than the coefficient in the source's list-decoding bound. For sufficiently
large R, sigma>=8. Set q=floor(sqrt(m)) and take an AND of q independently
sampled base formulas. Put

    Gamma = 2(3/4)^q, epsilon = Gamma/(16 sigma),
    tau = epsilon/(4q).

The modified PCP above permits this tau after R has been fixed. The
AND-product YES failure is at most q tau=epsilon/4; the NO satisfaction
fraction is at most (3/4)^q=Gamma/2. The local leaf bound is q(m+1)R.

Let N_0 be the number of monotone variables. Materialize the finite
sampling support if necessary; for fixed parameters it has polynomial
size in the outer input. Its rational probabilities and occurrence
weights have polynomial bit descriptions. A positive atom is a product
of a fixed number of inverse-polynomial choices, so positive variable
weights and s are inverse-polynomially bounded. Adding rational numbers
may enlarge a common denominator, which is handled separately below.

Construct a bounded-random-bit sampler whose distribution has statistical
distance at most epsilon/8 from the exact product distribution. One
implementation enumerates its S atoms and rounds cumulative rational
probabilities to a dyadic grid with at least log2(8S/epsilon) bits. Charge
the support enumeration and rational arithmetic. This is polynomial for
fixed L; it is not an oracle for an exponentially large support.

Take a list length M that is a power of two and satisfies

    M >= (N_0 ln 2 + ln 6)/(2 (epsilon/8)^2).

Draw M independent formulas from this sampler. Hoeffding's inequality and
a union bound over 2^N_0 assignments imply, with probability at least 2/3,
that all empirical satisfaction fractions differ from their exact product
probabilities by at most epsilon/4, including the sampling-distribution
error. Hence the list's YES failure is at most epsilon/2, and its NO
acceptance is at most Gamma/2+epsilon/4 < Gamma. The exception lemma may
therefore use the conservative error budget epsilon. Its condition
epsilon sigma<=Gamma/2 holds with a factor-eight margin.

Apply that lemma to this actual list. The output satisfies all constraints
in its YES case, with ratio floor(sigma/4), threshold 2 Gamma, and at most
q(m+1)R+1 leaves per formula. Failure of the randomized reduction occurs
only in the sampling event already bounded by 1/3. The completed list
has an exact uniform sampler using log2(M) random bits. In particular,
the later learning reduction sees epsilon=0 exactly; it does not inherit
the approximate sampler used to construct the list.

## Rational-weight control and learning transfer

Polynomial bit lengths alone do not make all weights integral multiples
of 1/poly(n). We supply a rounding step before any use of fixed-length
strings w_i lambda in the learning reduction. Let v_i be the final
normalized weights on N' variables and t its YES budget. Choose a power
of two D>=8(N'+1)/t, set a_i=ceil(D v_i), A_0=sum_i a_i, and

    B_0=min(A_0, ceil(D t)+N'), v'_i=a_i/A_0, t'=B_0/A_0.

A YES assignment remains feasible, since its integer weight is at most
D t+N'. Conversely, any assignment with v'-weight at most
(sigma_new/2)t' has original v-weight at most

    (sigma_new/2) B_0/D
      <= (sigma_new/2)(t+(N'+1)/D)
      <= (9/16) sigma_new t < sigma_new t.

Thus the NO acceptance threshold is unchanged if the gap factor is
rounded down to floor(sigma_new/2). Formula leaves and satisfaction are
unchanged. D and A_0 are polynomial numeric quantities because t has an
inverse-polynomial lower bound; all new weights and the budget share the
polynomial common denominator A_0. The clipping in B_0 guarantees t'<=1
and does not weaken either displayed inequality.

Represent the power-of-two list by its exact sampler. Every monotone
formula with L leaves admits the source's L-bit-total secret-sharing
construction. HN Lemma 5.1 explicitly allows epsilon=0: it keeps that
completeness error, multiplies the NO threshold by five, loses a factor
0.49 in the size gap, and uses advice bound

    L + 2 ceil(log2(L+1)) + c_U.

Its length parameter can be chosen as a polynomial multiple of A_0, so
all strings of length v'_i times that parameter have integral lengths.
The parameter is also increased by a polynomial factor to meet its stated
description and soundness bounds. These adjustments are polynomial in
the actual instance size. Perfect completeness holds for every randomness
string of this transfer; its additional randomized failure probability is
on the NO side. Boost the list-construction success to, for example, 5/6
by replacing ln 6 with ln 12 in M; combine with the transfer's sufficiently
small failure probability to obtain a randomized many-one reduction with
success at least 2/3. Finitely many small inputs can be handled by a fixed
truth table, a constant cost depending on the fixed parameters.

## Final asymptotic parameter choice and proposed conclusion

For each fixed sufficiently large target leaf bound L, consider integers
m>=256 with m<=sqrt(log2 L). Let q=floor(sqrt(m)) and

    h(L,m)=b_m floor( log2((L-1)/(q(m+1)))/(2b_m) ), R=2^(2h).

Additionally require b_m<=sqrt(log2 L). Require h(L,m) to exceed every
fixed lower bound used above for that m
and xi=1/m^2, including sigma>=8 and all numerical error inequalities.
Choose the largest admissible m. Every fixed m is admissible for all
sufficiently large L, so m(L) tends to infinity. The finite selection
does not assert a polynomial-time algorithm uniform in L; for each fixed
L it fixes the constants of a uniform polynomial-time reduction on inputs.
The same fixed-parameter convention is used in the revised source.

The final leaf bound is at most L by construction. Moreover,

    log R = log L - O(log(m+1)+b_m) = log L - o(log L),
    log sigma / log L -> 1,
    Gamma=2(3/4)^floor(sqrt(m)) -> 0.

All floor operations, the exception lemma, weight rounding and learning
transfer lose only constant factors in sigma. They therefore preserve
sigma=L^(1-o(1)). For the learning target with advice cap a, choose
L=a-2 ceil(log2(a+1))-c_U; for large a this is positive and the advice
overhead fits within a. Also L/a tends to one, preserving the exponent.

**Proposed theorem, requiring fresh full-file review:** for every
sufficiently large fixed leaf bound L there are an integer gap
sigma_L=L^(1-o(1)) and a threshold gamma_L=o(1) such that the realizable
problem Gap^(0,gamma_L)_(sigma_L) F[L]-CMMSA is NP-hard under randomized
polynomial-time many-one reductions. The same fixed-parameter realizable
conclusion follows for GapLearn with its stated advice bound. This would
answer the selected epsilon=0 part of the source's Section 7 question,
using the modified parameter argument above. It does not address the
separate superconstant-L question or close the nearlinear-to-linear gap.

This conclusion is presented for adversarial review, not as an established
research advance. The source challenger contributed the conditioning and
encoding audit. A separate reviewer must check the complete numerical
extension, imported-theorem interfaces and asymptotic composition before
root assigns any stronger status.

## Claims and review boundary

Even a successful completion would give strengthened NP-hardness under
randomized reductions, not P!=NP. A polynomial solver for the resulting
promise problem would yield a randomized SAT algorithm; NP contained in
BPP is not P=NP. The factor ell^(1-o(1)) remains below the C ell threshold
associated with one-way functions in the source. No one-way function,
NP-versus-coNP result, or general proof lower bound follows here.

The proposer and source challenger both contributed to the dependency
analysis. Neither is a fresh independent verifier of the resulting proof.
Root routes a separate actual-file mathematical review. No experiment,
formal proof, commit, push, public communication or paid computation has
been performed in this pass. The broader objective remains unresolved.
