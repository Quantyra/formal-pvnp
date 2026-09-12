# Ordinary-CNF counting and parity feedback (S3060)

2026-09-11. Informal mathematical derivation and exact finite checks; no Lean theorem, general SAT algorithm, proof-system lower bound, novelty claim, or publication result. Read [integrity](../../INTEGRITY-CLAIMS.md) and the [primary-source comparison](2026-09-11-counting-parity-sources.md).

The selected operation automatically recognizes some at-most-one (AMO) constraints and queries their parity in a Gaussian basis. Its elementary interaction is effective on the explicit family below: both specified component policies return OPEN, while their feedback refutes the same CNF. Every clause inequality and discovered AMO inequality also has a common fractional feasible point. This does not separate cutting planes, extended pseudo-Boolean reasoning, or arbitrary parity solvers. The combined policy itself remains incomplete on an explicit infinite family.

## One selected policy

Input is ordinary CNF on n explicitly indexed Boolean variables. There are no supplied parity rows, guards, clique labels, auxiliary-variable roles, or cardinality annotations. Normalize duplicate literals and tautologies and retain all original clauses. The constructor labels below describe test inputs only; the solver does not receive them.

Each deterministic sweep performs unit propagation, simplifies by fixed bits, and then:

1. **Bounded affine seed.** Partition residual clauses by their exact variable support. For each support of size at most three, enumerate its local truth table. Learn equations only when that entire exact-support bucket is an affine relation; an empty relation refutes. Keep the CNF. Gaussian-eliminate these equations together with previously learned rows and units, and propagate any entailed unit. This is not arbitrary local-window hull extraction: clauses on smaller supports are in different buckets. The unchanged S3055 extractor implements precisely this convention.
2. **Counting discovery.** Make a graph whose edges are residual clauses `(not u OR not v)`. For every edge uv propose `C={u,v} union (N(u) intersect N(v))`. Check every pair in C and accept only a clique; deduplicate identical accepted sets. Each accepted C supplies `sum_C x <= 1`. All positive clauses supply `sum_C x >= 1`. No maximum-clique, cover, matching, LP, or semantic recognition oracle is used.
3. **Fixed aggregate.** Sum all positive-clause lower inequalities and all accepted-clique upper inequalities. Test whether their coefficient vectors L and U are proportional by positive integers alpha,beta, using one coordinate, gcd reduction, and an all-coordinate check. If `alpha L=beta U` but the multiplied lower constant exceeds the upper constant, refute. This is a deliberately specified aggregate, not complete integer inequality reasoning.
4. **Feedback.** A positive clause whose support exactly equals an accepted AMO support implies odd parity; add that row. For every accepted C, reduce its incidence mask against the Gaussian basis. If its parity is even, force all its variables to zero. If odd, append its positive clause if absent. Gaussian contradiction or an empty clause refutes.

Repeat until a fixed point. Results are UNSAT or OPEN; OPEN never asserts satisfiability. Counting-only disables all Gaussian/extraction/parity conversion. Parity-only disables clique discovery, aggregation, and count/parity conversion. Both receive the identical original CNF and perform unit propagation.

The representation and mixed arithmetic principles are known. In particular, [Gocht and Nordstrom (AAAI 2021), Section 4](https://ojs.aaai.org/index.php/AAAI/article/download/16494/16301) give pseudo-Boolean certification of parity using extension variables and rounding. Our finite calculation is not a new general parity/counting principle or a plain-cutting-planes simulation theorem.

## Soundness and charged termination

For a Boolean sum s with `0 <= s <= 1`, even parity implies s=0, and odd parity implies s=1. Conversely s=1 implies odd parity. These are the exact conversion lemmas. Clique checks certify every necessary binary clause; bucket enumeration certifies the learned affine relation; row reduction tests an actually entailed parity. All deductions preserve the original CNF's models. The proportional aggregate is a positive integer combination of valid inequalities.

Let B be original literal volume, n the declared dimension, and P=B+O(n^4), a bound on retained original/learned literal volume. A sweep considers at most n(n-1)/2 clique candidates, each with O(n^2) pair checks: O(n^4) elementary graph work. There is no free search for better cliques. Exact-support seed enumeration has at most eight assignments and eight candidate normals per bucket; current code includes this full work. Gaussian elimination and every queried incidence mask are charged polynomial bit operations on rows of n bits.

Negative binary edges can change only when another variable is fixed: added clauses are positive. Thus there are at most n+1 graph epochs, each with at most O(n^2) accepted supports. At most O(n^3) distinct positive feedback clauses can ever be appended, each of length at most n. Fixed variables increase at most n times and independent Gaussian rank at most n times. A productive sweep adds a fixed bit, increases row rank, or appends a new clause. Therefore there are O(n^3+n+1) sweeps, including the final unproductive sweep. Repeated unchanged equations or log entries do not count as progress.

A loose conservative bound is O((n^3+n+1)(P+n+1)^4) bit operations under an elementary dense implementation; it includes clause scans, failed clique candidates, canonicalization, bounded truth tables, row operations, unit propagation, aggregate checks, and every membership query. This is a polynomial upper bound, not a tight implementation benchmark. Coefficients in the aggregate and gcd multipliers have O(log(P+n)) bits. Row masks have n bits. Working matrices, accepted supports, and all learned positive clauses are polynomial size. The actual script also retains per-sweep unit/feedback logs, including repeated exact-one row proposals; at most O(n^3+n+1) logs of polynomial size must be charged, rather than just the final rank. It neither searches for witnesses nor enumerates all CNF assignments in its solving policy. Exhaustive checks below are separately bounded diagnostic oracles.

## All-size interaction from ordinary CNF

For every k>=4, use X={x1,...,xk}, Y={y1,y2}, and k-2 fresh chain variables t2,...,t_(k-1). Include:

- every pairwise negative clause enforcing AMO(X), and `(not y1 OR not y2)`;
- `(x1 OR y1)` and `(x2 OR y2)`;
- the ordinary CNF truth-table encodings of `t2=x1 XOR x2`, `t_j=t_(j-1) XOR x_j` for 3<=j<=k-1, and `t_(k-1)=xk`.

Each width-three parity equation is encoded by its four forbidden-assignment clauses and the final equality by two clauses. No native XOR reaches the solver. There are 2k variables, O(k^2) clauses/literal volume, and O(k^2 log k) indexed encoding bits. The parity chain implies XOR(X)=0.

**Discovery.** The only negative binary edges are the complete graph on X and the edge on Y. Each candidate within X yields X, and the Y candidate yields Y. Parity gadgets have distinct exact supports; their buckets are affine and yield the chain equations. Negative AMO pairs and positive cover pairs are separate, non-affine three-point buckets. The conservative k>=4 boundary avoids suggesting a full width-three semantic recognizer; the exact bucket restriction is essential to the stated component comparison.

**Combined refutation.** Summing the discovered chain equations yields XOR(X)=0. Incidence-mask membership finds this consequence for the discovered clique X. Even parity plus AMO(X) forces every x_i=0. The two cover clauses then force y1=y2=1, contradicting AMO(Y). All premises and conclusions are derived from the same CNF. Construction and the policy above have polynomial cost on the entire family.

**Specified components.** The counting-only policy has no units and no exact-one matched cover support. Its lower aggregate has coefficient one on x1,x2,y1,y2 and zero on x3,...,xk and the auxiliaries. Its upper aggregate has coefficient one on all X and Y. These vectors are not proportional. It stops OPEN. The parity-only policy obtains the homogeneous chain equations, which force no individual variable; the nonlinear buckets yield no equations. It also stops OPEN. These are exact policy statements, not lower bounds on richer algorithms or representations.

**Stronger fractional check.** Set x1=x2=y1=y2=1/2, every other X variable to zero, and all chain auxiliaries to zero. This satisfies every discovered AMO inequality and every original CNF clause linearization. The first XOR gadget point (1/2,1/2,0) is the average of its satisfying assignments 000 and 110; all later gadgets and the final equality are at their all-zero satisfying assignment. Both cover inequalities are tight. Thus even the full ordinary clause linear relaxation plus the discovered AMO inequalities does not refute this family. This feasible fractional point does not satisfy the Boolean parity constraint and says nothing about integer cuts or extensions.

## Useful old-family repair and explicit remaining failure

On functional pigeonhole CNF with h+1 pigeons and h holes (h>=3), negative edges connect cells in a common row or column. A common-neighbor candidate from an edge is precisely that row or column; no unrelated cell is adjacent to both endpoints. Accepted AMOs are all h+1 rows and h columns. Every variable appears twice in their upper sum and once in the positive row-clause lower sum. Doubling the lower sum gives `2(h+1) <= 2h+1`, a contradiction. This repairs the S3059 policy obstruction by a known counting argument, not a new pigeonhole result.

For a different failure, take five variables and, for every three-element subset T, include both its all-positive and all-negative clause. These are all ten NAE-three constraints. Every Boolean assignment has at least three variables of one value, so this CNF is UNSAT. There are no binary negative edges or units. Each exact-support bucket has six satisfying points and full affine hull, hence is non-affine and supplies no seed equation. There are no accepted cliques, so the aggregate and feedback cannot act. The policy returns OPEN. Arbitrarily many disjoint copies give an infinite growing input family with the same failure, proved componentwise. This is an elementary incompleteness example, not a hard family for all SAT/counting/parity methods.

## Exact evidence and boundaries

Run `python research/p-equals-np/2026-09-11-counting-parity.py` from the satellite root. The [script](2026-09-11-counting-parity.py) and [JSON](2026-09-11-counting-parity.json) preserve constructors, full input CNFs, exact half-unit witnesses, result traces/counters, and LF-normalized script/helper SHA-256 pins. No hidden formula archive is required. The unchanged imported helper is [S3055 extraction](2026-09-11-mechanism-discovery.py).

Author run: four boundary controls and ten family cases passed. Four interaction cases k=4..7 give counting OPEN / parity OPEN / hybrid UNSAT, with exact fractional inequality checks and exhaustive UNSAT checks. Two odd-parity variants k=4,5 remain satisfiable and return OPEN. Two pigeonhole controls h=3,4 refute by the aggregate certificate. One and two copies of the NAE obstruction are exhaustively UNSAT but return OPEN. Solver counters are distinct from exhaustive validation; elapsed time is not an advantage comparison. JSON includes final Gaussian rows, clauses/units that triggered selected deductions, clique lists for the interaction checks, and aggregate certificates, not a complete proof-assistant certificate for every intermediate row operation.

The result is a concrete, automatic, sound feedback operation with a proved polynomial saturation bound and a proved limited interaction. It is already related closely to established pseudo-Boolean/XOR reasoning. No supported novelty or general complexity progress follows. Its remaining failure is explicit; no new benchmark, compilation campaign, or successor is launched by this note.
