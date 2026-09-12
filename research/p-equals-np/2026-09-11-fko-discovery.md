# FKO discovery attempt: why short random restrictions do not supply the packing

2026-09-11; S3064. Informal derivation under the [integrity boundary](../../INTEGRITY-CLAIMS.md). The [source contract](2026-09-11-fko-discovery-sources.md) records the existing certificate, closest sampling algorithm, and later spectral comparisons. No experiment, implementation, Lean result, novel algorithm or improved refutation runtime is claimed.

**Outcome:** the attempted random-restriction-plus-Gaussian mechanism is prior art. We derived a failure bound for its input-independent small-restriction version: at m=ceil(C n^(7/5)), any formula-independent list of R such restrictions with log R=o(n^(1/5) log n) fails with probability tending to one to reveal even a single inconsistent XOR subsystem. This statement has fixed constants and precise scope below. It does not cover clause-aware adaptive growth, minimum-weight dependency algorithms, or all FKO finders.

## The certificate and the operation we tried

The input is ordinary signed 3-CNF on n variables; every clause contains three distinct variables. Clause occurrences have separate IDs. For a clause c, let a_c in GF(2)^n indicate its three variables, and let b_c be 1 plus its negative-literal parity, modulo two. Thus the XOR equation a_c dot x=b_c expresses that an odd number of its Boolean literals are true. A nonempty set T of distinct clause IDs is an inconsistent even tuple when

    sum_{c in T} a_c = 0,   sum_{c in T} b_c = 1  over GF(2).

Its cardinality is even, because summing the incidence coordinates gives 3|T|=0 modulo two. This also makes the condition equivalent to odd total negative-literal parity. Every assignment violates at least one of these XOR equations. A single inconsistent XOR tuple does NOT refute the original OR clauses.

Let I be the total absolute positive/negative occurrence imbalance. Use the original FKO symmetric matrix M: zero diagonal, each clause contributes +1/2 for each differently signed variable pair and -1/2 for each same-sign pair. With a certified rational upper bound L>=lambda_max(M), a satisfying CNF assignment violates at most H=(I+nL)/2 of the associated XOR equations. A collection of t tuples with each clause in at most d tuples forces at least ceil(t/d) violations. Consequently t/d>H is a sufficient refutation condition. This is sound for all inputs satisfying the encoding and verification conditions, not only random ones. [FKO, Definitions 2.1-2.3 and Theorem 2.6](https://www.microsoft.com/en-us/research/wp-content/uploads/2017/03/unsat.pdf).

The proposed mechanism was:

1. Choose a small variable set U without consulting the clauses, and retain all clauses wholly inside U.
2. Run Gaussian elimination with provenance to find an inconsistent XOR dependency, if one exists.
3. Accumulate the discovered tuples and solve or update their clause-capacity packing; accept UNSAT only after checking the final numerical certificate.

Choosing U, inducing clauses and Gaussian testing are already studied by Wu et al., Section IV.2. Their focused boundary growth in Section IV.3 is a different, input-dependent procedure and is not covered by the bound below. We do not claim to improve or newly introduce their mechanism. [Wu et al., Sections IV.2-IV.3](https://arxiv.org/pdf/1303.2413).

## Why packing does not remove the discovery obligation

For discovered tuples, normalized fractional packing is sufficient. Assign nonnegative rational weights y_T such that sum_{T containing c} y_T<=1 for each clause c. If W=sum_T y_T, every assignment has at least W XOR failures: sum the tuple inequalities and use the load bounds. Therefore W>H also certifies UNSAT, with no rounding required. Tuple membership, parity, rational loads and the strict inequality must all be checked; a spectral upper bound requires a directed, certified error bound, not just an approximate eigenvalue.

For any packing in which all tuple lengths are at least ell,

    ell W <= sum_T |T| y_T <= m,  so W <= m/ell.

This is an exact capacity bound. At the FKO scale the known spectral/imbalance bound has order n^(6/5), while m has order n^(7/5), making n^(1/5) the relevant tuple-length scale. This comparison motivates short tuples; it does not prove that every particular formula has H of that order or that every long Gaussian output is useless. In particular, an upper bound on output length is not a lower bound permitting the capacity inequality.

FKO already enumerate candidate tuples and optimize a packing LP. Replacing this by column generation would need to implement its missing separation operation. For the normalized version the dual is

    minimize sum_c p_c;  p_c>=0;
    sum_{c in T} p_c>=1 for every allowed short inconsistent tuple T.

A violated constraint is a tuple with price below one. Gaussian elimination can solve existence of Az=0, b dot z=1, but does not minimize support or price, nor enforce a short-support bound. Naming the weighted sparse-dependency problem as an oracle does not give a faster algorithm. The present attempt used small restrictions to make an ordinary Gaussian output short; the following calculation shows why that particular substitute fails.

## Restricted-sampling proposition

Fix C>0 and B>0, independent of n. Draw m=ceil(C n^(7/5)) clauses independently and uniformly from the 8 binom(n,3) signed clauses. Let U_1,...,U_R be any sets of variables, each of size at most B n^(1/5), with their joint choice independent of the formula. They may be fixed in advance, mutually dependent, or randomly sampled independently of the input. Suppose

    log R = o(n^(1/5) log n).

Then, as n tends to infinity, with probability 1-o(1), every induced XOR subsystem on these sets is consistent. In particular, polynomially many such restrictions fail to discover any tuple, even if arbitrarily powerful processing is allowed within each induced subsystem.

The same asymptotic conclusion holds for uniform sampling without replacement of distinct signed clauses. This is a statement about a specified discovery access pattern, not a lower bound against unrestricted algorithms or adaptive variable selection.

### 1. Count even dependencies by pairing their incidence slots

Take e distinct clause IDs, with e even. There are 3e ordered variable slots. If every variable has even degree, their slots admit a perfect pairing in which each pair receives the same variable. There are at most (3e)^(3e/2) pairings. Each chosen clause's ordered variables are uniform among (n)_3=n(n-1)(n-2) distinct ordered triples. Ignoring the distinctness restriction when counting favorable assignments only enlarges the numerator.

For a fixed U of size s, at most s^(3e/2) assignments are compatible with each pairing and lie wholly in U. Thus, writing X_e(U) for the number of even e-clause subsets induced by U,

    E X_e(U) <= binom(m,e) (3e)^(3e/2) s^(3e/2) / (n)_3^e.

Signs need not be counted: an odd-signed dependency is a subset of these even incidence dependencies. Multiple pairings may describe the same assignment, which is harmless for this upper bound.

For all sufficiently large n there is a fixed D=D(C)>0 such that

    E X_e(U) <= [D sqrt(e) n^(-1/10) (s/n)^(3/2)]^e.       (1)

This follows from binom(m,e)<=(em/e)^e, where the first e in the numerator is Euler's number, and m=O_C(n^(7/5)). To avoid that notational collision, equivalently use binom(m,e)<=(exp(1)m/e)^e. All constants are independent of the chosen U and e. For example D=60 max(1,C) works for sufficiently large n, using m<=2 max(1,C)n^(7/5) and (n)_3>=n^3/2.

### 2. Globally, substantially shorter even dependencies are absent

Apply (1) with s=n. Choose a>0 so small that D sqrt(a)<=1/4, and put k_0=floor(a n^(1/5)). With probability 1-o(1), there is no nonempty even dependency of size at most k_0 anywhere in the formula.

To see this, union-bound the expected counts for even e from 2 to k_0. For e<=log n, the bracket is at most D sqrt(log n)n^(-1/10), which tends to zero, so the geometric sum starting at e=2 tends to zero. For log n<e<=k_0, the bracket is at most 1/4, and the remaining geometric tail also tends to zero. Odd e cannot be even incidence dependencies. This proves the assertion without a claim about the exact typical shortest size or its sharp constant.

Call this high-probability event G. It is shared by all restrictions; its failure probability is charged once, not multiplied by R.

### 3. Gaussian inconsistency implies a small supported dependency

Within s variables, let the columns of the augmented matrix be (a_c,b_c) in GF(2)^(s+1). XOR inconsistency means that (0,...,0,1) lies in their span. Expressing this vector in a column basis gives a subset of at most s+1 distinct clauses with zero variable incidence and odd b sum. This is a constructive polynomial-time Gaussian fact. It does not assert that the subset is minimum weight.

On G, such a subset would have size e>k_0. Therefore the event that a particular induced subsystem is inconsistent, intersected with G, is contained in the event that X_e(U)>0 for some k_0<e<=s+1.

### 4. Small restrictions almost never capture that many coordinated incidences

For s<=B n^(1/5) and e<=s+1, equation (1) has bracket at most K(C,B)n^(-6/5) for all sufficiently large n. Consequently

    Pr[induced XOR on U inconsistent AND G]
      <= sum_{e=k_0+1}^{s+1} [K(C,B)n^(-6/5)]^e
      <= exp(-c(C,B) n^(1/5) log n),                       (2)

for some constant c(C,B)>0 and sufficiently large n. An empty summation is zero. The estimate is uniform over every fixed eligible U; independence of the chosen sets from the formula lets us condition on their entire list and apply the same bound.

The probability any of the R subsystems is inconsistent is at most

    Pr[not G] + R exp(-c(C,B) n^(1/5) log n) = o(1).

This proves the proposition. It also shows why a small expected induced edge count alone was not an adequate argument: enough repeated trials can overcome polynomial rarity of individual edges. Equation (2) instead charges the rare coordinated dependency after globally excluding shorter ones.

Finally, the probability of a duplicate signed clause in the with-replacement model is at most binom(m,2)/(8 binom(n,3))=O_C(n^(-1/5)). Conditional on no collision, the formula is a uniform set of m distinct signed clauses. Conditioning therefore changes the asymptotic failure conclusion by o(1), establishing the stated comparison.

## Work, output and limits of the attempted mechanism

One implementation can scan all m clauses for each restriction, build the s-variable augmented columns, and maintain a column basis with provenance. Store at most s+1 independent original augmented columns, their IDs, and elimination transformations in coordinates of that selected basis. This compact provenance scheme takes O(m(s+1)^2) bit operations per restriction, plus input indexing costs, and polynomial workspace: O(n+m log n+s^2+sm) bits is a conservative bound including membership, clause IDs, basis and provenance. One successful extraction has at most s+1 IDs. These are implementable upper bounds; no minimum-weight solver is hidden in them.

All failed restrictions cost work too. The proposition rules out nonvanishing success probability for every input-independent restriction list with log R=o(n^(1/5) log n); it is not a universal time lower bound for data structures, nor a proof that any number at that scale succeeds. Original FKO enumeration already has a 2^(O(n^(1/5) log n)) bound. Thus this attempt supplies no asymptotic improvement over that finder. Later spectral tradeoffs and their different output guarantees are described in the source note; we do not call the original FKO bound the strongest unrestricted refutation algorithm.

If R tuples were found, explicit lists, rational weights, load sums and all LP work would still be charged. For polynomially many listed tuples, an explicit rational LP has ordinary polynomial input size, subject to the chosen bit-length bound. This does not solve the exponentially implicit pricing problem. Repeated tuple copies do not improve normalized mass. Deleting clauses to enforce loads cannot create a dependency inside a fixed U, but the distribution of adaptive residual formulas must not be assumed fresh random input.

Larger restrictions escape the theorem's hypothesis. Their expected induced clause count is m(s/n)^3, with clauses per retained variable of order C s^2/n^(8/5). The density balance occurs near s=n^(4/5), far above the desired n^(1/5) scale. This is only a first-moment density comparison, not a theorem that inconsistency begins at that value or that every extracted tuple is long. A larger induced subsystem could contain a short useful dependency; locating it is precisely the support-sensitive operation that ordinary existence testing does not supply.

Similarly, adaptively growing U along the observed clause boundary is outside the proposition. The formula reveals correlations that oblivious restrictions ignore. No claim is made that this adaptive escape works at FKO density, or that the known empirical focused search is polynomially successful there.

## What the derivation did and did not establish

The attempted improvement failed at a concrete operation: restricting enough to guarantee a short ordinary Gaussian output makes the required dependency exponentially unlikely to be captured by an input-independent selection. Packing sophistication cannot repair zero discoveries. The derived proposition is a scoped sampling limitation, not a lower bound for the weighted pricing problem or all FKO certificate discovery. Its novelty has not been assessed; the mechanism itself is explicitly prior art.

A successful replacement would have to exploit the observed incidence structure to find short odd dependencies with sufficient distinct clause coverage, and prove its total work and normalized packing mass. Gaussian feasibility, the existence of many tuples, and an implicit LP alone do not discharge that obligation. No such improved finder was obtained. No experiment, automatic successor, general SAT result or P versus NP claim follows.
