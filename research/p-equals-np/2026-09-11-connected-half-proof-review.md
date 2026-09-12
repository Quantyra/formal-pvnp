# S3073 independent oracle and rational-packing review

2026-09-11, under [integrity](../../INTEGRITY-CLAIMS.md). Target: [connected-half-pricing.md](2026-09-11-connected-half-pricing.md). **GO for the general-list oracle, exact rational packing, bit implementation and source-based FKO application**, after reading the saved adopted half-union version. The present reviewer originated the structural pairing/separator arguments in [the structural companion](2026-09-11-connected-half-structure.md), and therefore does not independently approve those lemmas or their enumeration bound. Their independent check belongs to the source/theory reviewer. The items below were assessed independently of their derivation.

## General list oracle

The required assumption is explicit coverage: every short minimal circuit admits a disjoint partition into two listed nonempty sets, with total size at most k. Keys retain incidence syndrome, sign parity and cardinality. For each nonnegative rational price query, recomputing a cheapest representative in each key preserves the comparison with any covered circuit. The representatives need not remain disjoint: equal syndrome and opposite sign produce a nonempty odd zero-sum symmetric difference, of size at most the sum of the retained cardinalities. Its price is at most their summed price. Thus neither overlap nor adaptive prices create a hidden failure event.

Any short odd tuple partitions into minimal circuits and has an odd component of no greater nonnegative price. Therefore comparison with all short minimal circuits implies comparison with the minimum price over all short odd tuples. The selected output is itself in that family, so the inequality must attain its exact minimum. Empty pair availability is equivalent to an empty short-odd-tuple family under coverage. The algorithm can stop with the empty packing in that case. Scanning cardinality pairs within a syndrome is polynomial in k per syndrome; it does not require all pairs of list elements. Exact sorting, new-price rescanning and original-ID processing are charged.

The corresponding packing reduction is also sound: replace each weighted odd tuple by an odd minimal component, and add weights when components coincide. Every clause load decreases or stays fixed and total mass is unchanged. Since those components already belong to the original short-tuple family, the two fractional packing optima agree. No claimed random-input structural prevalence is needed once the coverage lemma is available.

## Multiplicative-weights guarantee

Let W be the finite optimal short-tuple packing mass. Nonempty supports and unit capacities give W<=M. When W>0, normalize positive row weights to sum one. An optimal packing normalized by W has expected price at most 1/W, hence the exact pricing oracle returns a tuple of normalized price at most 1/W in every round.

For eta=epsilon/4, each selected row weight is multiplied by 1+eta. Total row weight therefore increases by at most 1+eta/W. After J rounds, its logarithm is at most log M+eta J/W, whereas a maximum-load row has log weight L_max log(1+eta). Combining and using log(1+eta)>=eta/(1+eta) gives

    L_max/J <= (1+eta) [1/W + log M/(eta J)].

With b=ceil(log2(max(2,M))) and J=ceil(16 M b/epsilon^2), log M/(eta J)<=epsilon/(4M)<=epsilon/(4W). Thus L_max/J<=(1+epsilon/4)^2/W<=(1+epsilon)/W for the stated 0<epsilon<=1/2. The constants and inequality directions check. Repeated outputs receive weight 1/L_max each, so coalescing them yields exact row loads at most one and mass J/L_max>=W/(1+epsilon). Each nonempty output ensures L_max>=1. No value of W is needed by the procedure.

## Exact bit implementation and output

For eta=a/q rational, conceptual weights (1+eta)^(l_c) can be represented after t rounds by integers (q+a)^(l_c) q^(t-l_c) sharing denominator q^t. Multiplying selected rows by q+a and unselected rows by q implements the next round exactly; common scaling does not change a pricing minimizer. Bit lengths are O(J log(q+a)), hence polynomial in M, inverse epsilon and epsilon's encoding length. Summation, comparisons, syndrome keys and sorting have polynomial bit overhead. J is polynomial in those original parameters, so J complete list rescans preserve list length times polynomial cost, rather than an unspecified polynomial in list length.

Final weights have denominator at most J. Their nonnegativity, signs, incidence cancellation, row loads and mass can all be checked exactly in the explicit output size. The general deterministic implication requires the actual optimum W/(1+epsilon) to exceed a certified threshold. A vanishing margin can enlarge inverse-epsilon cost and must not be hidden in the displayed exponent. The final author's source-specific constant-margin application is checked separately below.

## Final FKO application and directed eigenvalue precision

Independently opened the [original FKO primary PDF](https://www.microsoft.com/en-us/research/wp-content/uploads/2017/03/unsat.pdf). Section 4, printed p. 9, defines robust witnesses by t>d(I+n lambda). Corollary 4.2's proof explicitly attributes robust witnesses with k=O(n^(1/5)) to its random-input analysis at sufficiently large fixed density constant. Its introductory model selects distinct signed clauses uniformly. These are imported source results, not newly proved random-family statements.

Normalize the source witness by its actual maximum load: W_0=t/d_actual>=1 and W_0>2H for H=(I+n lambda)/2. Since W_all>=W_0, the algorithm with epsilon=1/2 returns mass at least 2W_0/3>H+W_0/6>=H+1/6. A directed threshold error at most 1/8 leaves strictly more than 1/24. Thus this application does have a constant margin supplied by the source, with its density and support constants; it is not left as an unsupported tuple-existence inference.

The matrix is symmetric rational. Exact positivity of all leading principal minors is equivalent to positive definiteness of xI-M, hence to x>lambda_max. A failed test means x<=lambda_max, including equality. Gershgorin bounds widened by one initialize a false-test lower endpoint and true-test upper endpoint. Bisection to interval width 1/(4n) gives a directed eigenvalue overestimate at most that width, hence threshold overestimate at most 1/8. If the initial interval width is R, O(log(4nR)) tests suffice. Rational endpoints and all determinant calculations have polynomial bit lengths, and exact elimination provides polynomial bit work. This establishes a computational prescription, not an implemented or tested numerical routine.

For iid uniform signed clauses, the probability of any repeated signed clause is O(M^2/n^3)=O(n^(-1/5)) at M=Theta(n^(7/5)). Conditioning on no repetition gives the source's uniform distinct-clause model. Consequently its high-probability existence statement transfers with an additional o(1) exception. The iid original-row degree bound is a separate binomial-tail event; a union bound combines them without independence. Choosing a sufficiently large source-dependent support cap preserves the stated runtime application. Neither a sharp constant nor strongest-prior superiority is established.

## Scope

The final adopted text explicitly handles the empty input, uses the half-union list with all generation and grouping costs charged, and states an exponential upper bound without claiming a matching lower bound. The oracle and wrapper depend only on coverage and therefore remain valid for that adopted list. Substituting its separately reviewed size bound preserves linear list dependence times polynomial original-input and inverse-accuracy costs; it does not square the list or silently enumerate every tuple. This is informal mathematical review, not Lean verification, implementation validation, a strongest-prior assessment, or a P-versus-NP result. The structural proof is independently approved by a different reviewer, not by its originator here. No outstanding mathematical correction remains in this lens's scope.
