# Fresh mathematical review: canonical partial-to-total completion

2026-09-12; S3120 / E004 / S008. Independent mathematical lens under
[integrity](../../INTEGRITY-CLAIMS.md). **GO-WITH-NOTES** for the exact existential
counterexample theorem in the final author artifact. No blocking defect found.
This reviewer did not participate in the derivation, supply a repair, or select
a successor. This is informal mathematical review, not Lean verification,
human peer review, novelty certification, or a general complexity claim.

## Actual artifacts and review boundary

Read the author construction, intermediate cubic argument, and final
strengthening in [design](2026-09-12-partial-total-circuit-design.md), SHA256
`D2D2E55113EC6B1995FDCF295009B95108A652111170F5CA4BFA638F330803C8`.
Also read [challenge](2026-09-12-partial-total-circuit-challenge.md), SHA256
`20B3DB4F68986059059B76C04180FEA55469AEFBE1C22388373F52E2FB7497D5`.
The challenger discloses participation in the derivation; its verdict was not
used as a substitute for checking the argument.

Read the destination integrity ledger and the supplied planning protocol,
formal-three-lens closeout protocol, and frontier-research protocol. No
destination AGENTS.md was present, including the repository file search.
Only this owned review was written. Lean build is **N/A: informal theorem**.
No experiments, author-file edits, commits, pushes, or public changes occurred.

The reviewed statement is: for every sufficiently large integer n, some
explicit-length partial table p on n bits satisfies

    C*(p) <= floor(n/2)-1,
    C(H(p)) > floor(2^(n/3)).

Here existence does not mean efficient construction of a suitable p. H is
exactly the author's degree-first, fixed degree/lex column order, left-to-right
RREF rule with no column swaps and all free coefficients zero. Circuits count
AND2, OR2 and NOT gates, with constants and input wires free and arbitrary
depth, sharing and fan-out. The theorem concerns this rule, not all polynomial
time completion algorithms or partial-to-total reductions.

## 1. Representation and Reed-Muller facts

The evaluation vectors of the multilinear monomials are linearly independent
over F_2: evaluating on indicator vectors of subsets gives the triangular
subset-incidence matrix. All 2^n monomials consequently form the full function
basis. Thus RM(d,n) has dimension K_d=sum_(i<=d) binom(n,i), and H always
finds a consistent system by degree n. Restricting equations to specified
rows is exactly the evaluation-code erasure problem used in the proof.

Independently opened [Borissov--Manev (2004), Section 2 and Proposition
(vii)](https://www.math.bas.bg/serdica/2004/2004-303-324.pdf). It states these
RM parameters, distance 2^(n-d), and binary disjoint splitting of a nonminimal
word. Its small-parameter classifications are not needed. Minimal means
inclusion-minimal nonzero support, not minimum weight.

The author's distance induction is valid: for a+x_n b with b nonzero,
wt(a)+wt(a+b)>=wt(b), and b has degree at most d-1 in n-1 variables.
For b=0 the two slices coincide and weights double; if d exceeds n-1 in
that branch, the endpoint nonzero weight bound suffices. Constants and full
degree supply the base/end cases. A degree-d monomial attains the bound.
No unproved asymptotic classification of minimal words is imported.

## 2. Minimal-word count

For a nonminimal binary codeword c, choose a nonzero proper-support word u.
Then c+u has support precisely supp(c) minus supp(u), so both summands are
nonzero and disjoint. Iterated splitting terminates by strict support decrease.
Final components remain pairwise disjoint and are minimal in the same code.
Every component has weight at least 2^(n-d); their union has at most 2^n
points. Therefore at most 2^d components occur, including for words of
smaller actual degree. The zero word is the empty decomposition.

If M_d counts the nonzero minimal words, every codeword is represented by
an ordered tuple of length 2^d drawn from those words plus zero, padding
as necessary. Nonuniqueness only increases the representation count. Hence

    2^K_d <= (M_d+1)^(2^d),
    M_d >= 2^(K_d/2^d)-1.

The direction of this inequality is correct. No injection of words into
unordered decompositions, or uniqueness of disjoint splitting, is assumed.
The earlier cubic argument's subtraction of words with at most one cubic
coefficient is also valid, but the strengthening does not require that filter.

## 3. Exact compatible fiber and circuit witness

For minimal nonzero g in RM(d,n), choose its highest nonzero monomial f
in the declared order and set h=g+f. Let p equal f outside supp(g), with
stars inside. The monomial f is a consistent total extension. If its degree
is r>=1 it has r-1 binary AND gates; if r=0 it is the free constant one.
For d>=1 this gives C*(p)<=max(r-1,0)<=d-1 in the actual measured basis.

The homogeneous evaluation kernel on specified rows consists exactly of
RM(d,n) words supported inside supp(g). Minimality excludes every nonzero
proper-support word. Over F_2, equal support means equal word, so the
kernel is exactly {0,g}, not merely a subspace containing g. Since f is
compatible, the entire degree-at-most-d affine solution fiber is {f,h}.
This step would not hold with the same wording over a larger field, but the
algorithm and code are explicitly binary.

Evaluation injectivity makes this a statement about coefficient vectors as
well as tables. Every lower-degree compatible polynomial is already in this
two-element fiber. Thus an uncounted lower-degree completion cannot cause
the algorithm to stop early with some other output.

## 4. Selected degree, unique free column, and constants

If deg(h)=r, both fiber members have degree r, so no smaller degree is
consistent. The kernel at degree r is still exactly span(g). Let j be g's
highest nonzero column. All columns before j are independent; otherwise a
dependency supported there would give a nonzero kernel vector unequal to g.
Column j is dependent on those preceding it by g's relation. Any additional
dependent column later would increase nullity above one. Thus j is exactly
the unique nonpivot/free column in left-to-right elimination. Row-pivot
choices do not affect that characterization. Since f_j=1 and h_j=0, the
free-zero convention selects h.

If h is nonzero and deg(h)<r, it is the only member of {f,h} at that lower
degree, and no member occurs at a smaller degree. The first consistent
system therefore uniquely returns h; no assertion about its free columns
is needed. If h=0 and f is nonconstant, zero is the only compatible constant
and is returned at degree zero. If g=f=1, p is wholly unspecified and the
degree-zero free-zero rule returns zero despite both constants being
compatible. That last case is in fact unavailable for a minimal word when
d>=1 permits a proper-support monomial, but handling it explicitly is harmless.
The zero polynomial is not assigned a problematic ordinary degree.

These cases exhaust the possibilities and prove that each counted minimal
g really forces H(p)=h. A hard alternative completion alone would not suffice;
the argument establishes the actual deterministic output.

Nonblocking wording note: the cubic paragraph says nonzero kernel coordinates
"below that free column" are impossible. Its precise intended meaning is
coordinates with index greater than j, equivalently columns to the right of
the free column; coordinates before j can be nonzero. The immediately following
unique-dependency sentence is correct and fixes the interpretation, as does
the independent check above. This is a wording clarification, not a missing
proof or a change to the final theorem. The author file was not edited.

## 5. Collisions and counting the measured circuits

For fixed h, specifying the deleted monomial f reconstructs g=h+f uniquely.
There are K_d possible f, so output multiplicity is at most K_d, including
all degree drops and constant cases. Consequently at least M_d/K_d distinct
functions occur as actual outputs of small-witness-compatible partial tables.
No distinct-mask or injectivity assumption is required.

Every circuit with t<=T counted gates admits a topological gate ordering.
For each gate, allowing three types and two arbitrary predecessor indices
among n+T+2 wires overcounts all valid gates, including unary NOT. Input
wires, both free constants, unused gates, and all output-wire choices are
covered by the safe description bound

    Q(n,T)=(T+1)(n+T+2)[3(n+T+2)^2]^T.

For t<T the exponent T only enlarges the bound. Sharing and fan-out do
not introduce further data beyond references to previous wires; they are
not silently excluded as they would be in a formula count. Each computable
function has at least one such description, so Q upper-bounds functions
with minimum circuit size at most T. The calculation does not replace
general circuits by sparse polynomials or use ANF density as a lower bound.

## 6. Exponent comparison and final quantifiers

Take d=floor(n/2). Binomial symmetry gives K_d>=2^(n-1) for both parities
of n, and K_d<=2^n. Set A=K_d/2^d>=1. Then

    log2(M_d/K_d)
      >= A-1-log2 K_d
      >= 2^(ceil(n/2)-1)-n-1.

The first inequality uses 2^A-1>=2^(A-1), correctly accounting for the
subtracted one. For T=floor(2^(n/3)), log2 Q(n,T)=O(n*2^(n/3)). The
ratio 2^(n/2)/(n*2^(n/3)) diverges, so eventually the forced-output count
strictly exceeds Q at every integer n, not merely along a subsequence.
Some forced output therefore has C(H(p))>T while its witness has
C*(p)<=d-1. Floors and the lack of a numerical starting n do not weaken
the stated sufficiently-large-n existential conclusion.

For any fixed polynomial preservation bound b(n+C*(p)), its magnitude on
0<=C*(p)<=n/2 is polynomially bounded in n. The exponential lower bound
eventually exceeds it. This justifies failure of every fixed polynomial
bound in n+C*(p) for this rule. It does not contradict the polynomial-in-
table-length implementation of H or its O(n*2^n) circuit upper bound.

The choice of a suitable minimal g is existential. Neither the circuit count
nor table construction provides an efficient method to find it, an explicitly
named hard function in NP, or a uniform lower-bound family. Complex masks
are allowed inputs to the rejected universal preservation contract, and their
information is fully charged in the explicit N-entry input. No general
partial-to-total impossibility, MCSP hardness result, or P-versus-NP claim
follows. Historical unresolved passages are expressly superseded by the
author's final strengthening.

**Final mathematical verdict: GO-WITH-NOTES for the exact pinned theorem.**
The sole note is the nonblocking directional wording above; no mathematical
repair or additional hypothesis is requested. The scope/integration lens remains
separate; this file is frozen for that closeout.
