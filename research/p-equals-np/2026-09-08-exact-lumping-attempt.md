# Exact equitable quotients and a minimal histogram example

2026-09-08. S3040 / S008 / E004. Harness-only informal research.
Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-exact-lumping-2026-09-08.md`.
Read with `INTEGRITY-CLAIMS.md` and the heat/reaction attempts. The finite
partition, polynomial and root arguments below are self-contained. No
general representation lower bound, SAT hardness claim, physical device
or P=NP result is asserted. No simulation, code or commit is supplied.

## The exact quotient contract

Let L be the hypercube generator on {0,1}^n,

    (Lu)_x=sum_i(u_(x xor e_i)-u_x).

A partition P of its vertices is equitable if, for every pair of cells
A,B, the number q_AB of neighbors in B of a vertex x in A is independent
of the choice of x. It is initially compatible with f if f is constant
on every cell. Consider the entire vector subspace of functions constant
on cells, not just one selected output or a single fitted trajectory.

For u_x=v_A on cell A, equitability gives

    (Lu)_x=sum_B q_AB(v_B-v_A).

Thus that subspace is invariant under L. Conversely, if L maps every
cell-constant vector back to a cell-constant vector, applying it to each
cell indicator shows neighbor counts into every other cell are constant;
the total degree n then determines the count into the vertex's own cell.
Hence this invariant-subspace condition is exactly equitability.

Coordinatewise reaction also preserves cell constants. Therefore for
the previous heat-plus-logistic model the quotient is exactly

    v_A'=sum_B q_AB(v_B-v_A)+4n v_A(1-v_A),         (1)

with compatible initial values. Lifting its solution by cell labels gives
the full solution, by uniqueness. The heat quotient is (1) without the
reaction. The same observation applies to any identical locally Lipschitz
scalar reaction on every coordinate. It does not claim all possible
trajectory-specific compression schemes are equitable partitions.

## A growing equality-block family and its actual transitions

Fix k>=1. There are k independent blocks, each with 2k bits, so n=2k^2.
Within each block impose equality along a path using, for every adjacent
pair a,b, the two clauses (not a OR b) and (a OR not b). Let F_k be the
conjunction of all these clauses and f its SAT indicator. A block satisfies
its constraints exactly when all its bits are0 or all are1.

For block b with Hamming weight w_b, define its type

    j_b=min(w_b,2k-w_b),  0<=j_b<=k.

Let h_j count the blocks of type j. Thus h=(h_0,...,h_k), h_j>=0 and
sum_j h_j=k. Every such histogram is attained by some assignment. The
initial indicator equals1 exactly in the histogram h_0=k; it is0 in
all the other histogram cells.

The one-bit flip counts within a single block are

    j -> j+1: 2k-j,                 0<=j<k;
    j -> j-1: j,                    1<=j<k;
    k -> k-1: 2k.                                     (2)

The middle type j=k needs the special last line: both weight k-1 and
weight k+1 have type k-1, so all 2k flips decrease the type. There is
no type-preserving single-bit flip. These formulas also cover k=1,
with the middle range1<=j<k empty.

For standard histogram unit vectors e_j, the quotient generator is

    (Qv)_h
      =sum_(j=0)^(k-1) h_j(2k-j)[v_(h-e_j+e_(j+1))-v_h]
       +sum_(j=1)^(k-1) h_j j[v_(h-e_j+e_(j-1))-v_h]
       +2k h_k[v_(h-e_k+e_(k-1))-v_h].              (3)

Terms with h_j=0 are omitted. The outgoing rates sum to2k sum h_j=n.
The neighbor counts depend only on h, proving equitability directly.
The exact reaction quotient is v_h'=(Qv)_h+4n v_h(1-v_h). Each row has
at most2k outgoing transitions with polynomially bounded integer rates.
Histogram labels themselves have only O(k log(k+1)) bits.

Stars and bars gives exactly

    D_k=binom(2k,k)                                  (4)

histogram cells. We next prove that this is minimal for the specified
equitable, initially compatible partition contract, rather than merely
counting a convenient orbit partition.

## Heat trajectories distinguish all histogram cells

Write r=exp(-2t), a=(1+r)/2 and p=(1-r)/2. Heat evolution factors over
independent blocks and their product initial indicator. For a block of
type j, the probability of arriving at either constant block is

    a^(2k-j)p^j+a^j p^(2k-j)
      =2^(-2k)(1-r^2)^j P_(2k-2j)(r),
    P_d(r)=(1+r)^d+(1-r)^d, P_0=2.                (5)

Consequently the full heat value at a vertex of histogram h is

    H_h(r)=2^(-n)(1-r^2)^(J_h)
                 product_(j=0)^k P_(2k-2j)(r)^h_j,
    J_h=sum_j j h_j.                               (6)

This is a polynomial in r. Equality of two heat trajectories for all
t>=0 would make their polynomials identical, because r ranges over an
interval with infinitely many points.

First, P_d(1) and P_d(-1) are nonzero for every nonnegative even d:
they equal2^d for d>0, and2 for d=0. The zeros at r=1 and r=-1 in
(6) therefore each have multiplicity exactly J_h. Identical polynomials
must have the same J_h, after which those real-root factors can be
cancelled.

For every positive even d, the roots of P_d solve

    ((1+r)/(1-r))^d=-1.

Writing the d roots of -1 as exp(i(2ell+1)pi/d) yields the finite roots

    r=i tan((2ell+1)pi/(2d)),  ell=0,...,d-1.       (7)

No denominator vanishes because d is even, so -1 is not among these
dth roots of -1. Equivalently these are all d roots of the degree-d
polynomial, and they are simple. The smallest modulus is
tan(pi/(2d)), attained at the positive/negative imaginary pair. This
modulus strictly decreases as d increases. Thus the particular root
i tan(pi/(2d)) cannot be a root of any P_e with 0<e<d and e even.

Suppose two histograms gave identical polynomials but some multiplicity
h_j with j<k differed. Cancel their common positive-degree factors and
choose the largest remaining degree d=2k-2j. One side has a positive
power of P_d and the other does not; all other remaining positive degrees
are smaller. Evaluating at its smallest-modulus imaginary root makes
only that side zero, a contradiction. Larger-degree factors cannot
interfere: they were common and already cancelled. This descending
argument does not assume that different P_d are pairwise coprime.

Hence every h_j for j<k agrees. The remaining factor P_0=2 has no roots,
so its multiplicity is recovered from the fixed block count
h_k=k-sum_(j<k)h_j. It agrees too. We have proved

    h != h_prime implies H_h and H_hprime are distinct polynomials. (8)

This is separation as heat trajectories, not necessarily at one fixed
time. No floating root comparison or generic-position assumption is used.

## Minimality within the exact partition method

In any initially compatible equitable partition, the heat solution remains
constant on each cell at every time, by the invariant-subspace argument.
Equation (8) therefore forbids a cell from containing vertices of two
different histograms. Every such partition refines the histogram partition.
Since (3) proves that the histogram partition itself is equitable and
initially compatible, it is the coarsest one and has the minimum number
of cells, namely D_k. This proves the requested minimum; it is not just
an upper bound from an exhibited symmetry.

The conclusion concerns exact closure for every vector constant on cells.
It does not bound quotients or other descriptions fitted only to one
nonlinear trajectory, approximations, selected-coordinate evaluators,
non-partition representations, or algorithms that need only a SAT answer.
In particular no equality of heat and reaction trajectories is assumed:
heat separation supplies the necessary invariant for an equitable
partition, while (1) separately gives the exact reaction quotient.

The elementary bounds

    4^k/(2k+1)<=binom(2k,k)<=4^k                   (9)

follow because the central binomial coefficient is the largest of the
2k+1 terms summing to4^k. Thus the minimum state count is2^Theta(k),
or2^Theta(sqrt(n)). The formula has2k(2k-1)=O(n) clauses and explicit
binary-name length O(n log n); this count is superpolynomial in that
encoded length. It is not a2^Omega(n) bound. Explicitly storing and
updating all quotient states therefore remains superpolynomial for this
family, despite the short labels and sparse rows. Merely naming a cell
implicitly does not yet implement the full quotient evolution.

## What still compresses, and what this attempt does not exclude

This is an easy SAT family: setting every bit to0 is an immediate witness.
Its heat coordinate also has the exact product evaluator (5)--(6), using
polynomially many arithmetic operations on block counts and scalar powers.
At the precision budgets of the earlier heat note, rational approximation
of a,p and polynomial-bit arithmetic give polynomial work. Computing this
single heat value does not require materializing the D_k-state quotient.
The minimum-partition result is therefore not a heat-evaluation or SAT
complexity lower bound even on its own example.

The nonlinear reaction generally does not preserve the product of block
heat solutions. Still, the equitable lower bound does not exclude other
nonlinear compression, repeated local evaluation, or a specially designed
selected-coordinate method. It shows precisely that the successful
n+1-state symmetry quotient of the preceding singleton example does not
extend to a uniformly polynomial exact equitable quotient merely by
grouping these independent equality blocks.

The bounded result is an exact quotient with verified transition rates
and a proof of its minimum size under the stated closure contract.
A uniformly efficient succinct evaluator for arbitrary CNF remains
unconstructed. No general representation hardness, SAT deadline, P=NP
result, simulation, code or commit follows from this increment.
