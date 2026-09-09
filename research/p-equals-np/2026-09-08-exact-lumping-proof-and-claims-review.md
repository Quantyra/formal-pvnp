# Exact lumping: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Harness-only independent review of
`2026-09-08-exact-lumping-attempt.md`. The same reviewer covers the two
lenses below; they are not two independent reviews. Source/complexity
review is assigned separately. No formal module, build, numerical test,
implementation edit or commit is involved.

## Proof-adversarial lens — GO

The stable draft passes without corrections.

Equitability is equivalent to invariance of the entire cell-constant
subspace under L. Off-cell indicator tests recover the corresponding
neighbor counts, and fixed total degree recovers within-cell counts.
Identical coordinatewise reaction preserves this subspace, so the lifted
quotient solves the full IVP. Uniqueness justifies the lift. This is
closure for arbitrary cell-constant vectors, not a fitted output model.

Each block has 2k bits and is satisfying exactly at its two constant
assignments. For type j<k, there are 2k-j flips toward type j+1 and j
toward j-1. At the middle weight k, both directions reduce the type,
giving 2k flips to k-1. No flip preserves type. Formula (3) multiplies
these counts by the number of blocks of each type, so its row totals
are 2k times k=n. Zero-count terms are omitted before accessing their
target labels. The k=1 boundary case has only types0 and1 and the
correct two flips in either direction. The claimed histogram partition
is therefore equitable and its initial indicator is constant on cells.

Histograms are weak compositions of k into k+1 parts, giving exactly
binom(2k,k) attained cells. This is initially an upper bound from the
constructed quotient; the later separation proof supplies minimality.

For a block of weight w, its two constant targets contribute
a^(2k-w)p^w+a^w p^(2k-w). Taking j=min(w,2k-w) and factoring yields
equation (5), including j=k where P_0=2 correctly counts the two targets.
Independent block heat kernels and the product initial indicator give
equation (6) with scalar2^(-n). Distinct polynomial functions imply
distinct heat trajectories because r=exp(-2t) ranges over an interval.

Neither P_d(1) nor P_d(-1) vanishes, including d=0. Thus the real-root
multiplicities in H_h recover J_h exactly, permitting cancellation of
the factor (1-r^2)^J_h. For positive even d, r=1 is not a root and the
fractional linear substitution z=(1+r)/(1-r) identifies the d roots
of P_d with the roots of z^d=-1. Since d is even, z=-1 is excluded;
all roots give finite, distinct r=i tan((2ell+1)pi/(2d)). The smallest
modulus is tan(pi/(2d)), strictly decreasing with d. Its positive
imaginary root cannot occur for any smaller positive even degree.

After cancelling common factors, take the largest degree with unequal
histogram multiplicity. Its smallest-modulus imaginary root zeros only
the side containing that factor: all remaining factors on the other
side have smaller degrees, and the constant factors are nonzero.
This contradicts polynomial equality. Larger degrees were cancelled,
so shared roots between other pairs of P_d cause no gap in this proof.
All positive-degree multiplicities agree; h_k is then fixed by total
block count. No nonexistent root of P_0 is used.

Every initially compatible equitable partition keeps its heat solution
constant on each cell for all times. The proved trajectory separation
therefore forces every such partition to refine the histogram partition.
Together with its directly verified equitability, this proves that the
histogram partition is the coarsest and has the minimum cell count.
No claim of separation at one specified time is required. The argument
does not equate the nonlinear reaction and heat trajectories; it uses
the heat trajectory as a necessary consequence of equitability.

The central binomial bounds follow from the largest term among 2k+1
terms summing to4^k. With n=2k^2 they yield2^Theta(sqrt(n)), not
2^Omega(n). The formula has k(2k-1) equality edges and twice that many
clauses, as stated. Its encoded length is O(n log n), so explicitly
materializing all quotient cells is superpolynomial in that length.
Polynomial label size and sparse rows do not materialize that array.

Finally the exception is substantive: block products directly evaluate
the heat coordinate with polynomial work at the previous precision
budgets. Scalar parameters can be approximated with sufficient guard
bits and O(n)-factor product error control; their weighted sums are
explicitly factored on this family. An all-zero SAT witness is immediate.
Neither requires evolving the full minimum equitable quotient.

## Nonclaims lens — GO-WITH-NOTES

The result proves a minimum state count under the exact, initially
compatible equitable-partition contract. It is stronger than merely
counting symmetry orbits, but narrower than a lower bound on arbitrary
descriptions or algorithms. The draft maintains both distinctions.

The minimum does not apply to approximate quotients, representations
tailored to one nonlinear trajectory, selected-coordinate evaluation,
non-partition compression, or SAT-only decisions. It also does not show
that an implicit quotient cannot be exploited without materializing all
its cells. The exhibited easy heat evaluator and SAT witness explicitly
prevent those stronger interpretations even on the example family.

The nonlinear product structure remains unproved; the exact quotient
extends to reaction because its whole subspace is invariant. That fact
does not supply a uniformly polynomial reaction evaluator. Likewise the
minimum quotient size is not a physical storage or Navier--Stokes lower
bound and does not establish a general SAT deadline or P=NP result.

Safe result: the growing equality-block family has a verified exact
histogram quotient and a proved superpolynomial minimum cell count for
this partition method. Uniform succinct evaluation for arbitrary CNF
remains unresolved. The bounded informal finding passes; no formal or
full-goal closeout is approved.
