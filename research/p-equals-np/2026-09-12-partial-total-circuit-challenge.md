# Partial-to-total circuit completion: independent challenge

**Latest bounded-pass outcome: the actual-output counting argument below
refutes every fixed polynomial circuit-size preservation bound for this
specific canonical completion rule.** Earlier
UNRESOLVED statuses are retained as the first-pass record and are superseded
for this particular target. No general partial-to-total impossibility follows.

2026-09-12; S3120/E004/S008. Independent source and mechanism review under
[integrity](../../INTEGRITY-CLAIMS.md), the frontier protocol and the planning
literature trigger. The prior [meta-graph](2026-09-11-research-meta-graph.md),
MCSP magnification, separator-compression and streaming failures were read.
This record concerns an explicit proposed completion operation. No experiment,
implementation, proof campaign, publication, commit or separation is performed
or authorized by this review.

## Current source constraints

| Primary source inspected September 12 | Exact relevant scope and limit |
|---|---|
| [Hirahara, NP-Hardness of Learning Programs and Partial MCSP, FOCS 2022 / ECCC TR22-119](https://eccc.weizmann.ac.il/report/2022/119/download/) | The abstract establishes NP-hardness of partial MCSP under randomized polynomial-time reductions. This is a partial-function result, not a total-function circuit-completion algorithm. The full PDF initially opened; subsequent targeted extraction failed. No exact gap or gate-basis normalization is imported from an uninspected theorem here. |
| [Hirahara-Oliveira-Santhanam, CCC 2018](https://drops.dagstuhl.de/storage/00lipics/lipics-vol102-ccc2018/LIPIcs.CCC.2018.5/LIPIcs.CCC.2018.5.pdf), Theorem 1, Definition 7, Section 3.2, Theorem 45 | Polynomial-time deterministic hardness is established for OR-AND-MOD circuits with size measured by top fan-in. Partial-to-total encoding uses affine-subspace structure with calibrated additive cost. Theorem 45 separately gives an approximation-preserving construction, with multiplicative factor equal to the number of unspecified positions. This is real positive evidence that mask costs can be calibrated, but it does not transfer the structural lower bound to unrestricted Boolean circuits measured by all gates. |
| [Ilango, The Minimum Formula Size Problem is (ETH) Hard](https://www.rahulilango.com/papers/MFSP-hard.pdf), Definition 7, Lemma 9, Theorem 5 | De Morgan formulas are measured by leaves. For nonconstant-compatible partial gamma, Extend on n+2s variables has exact leaf complexity L(gamma)+L(star-mask)+2s when s is at least min(L(gamma),L(star-mask)). The output table has N*2^(2s) entries. Polynomial cost therefore needs the appropriate logarithmic s regime. Exact polynomial search-to-decision for formulas is also established, but neither result is an arbitrary-circuit preservation theorem. |
| [Hirahara-Ilango, FOCS 2025 proceedings](https://www.rahulilango.com/papers/MCSP-Proceedings-2025.pdf), Theorem I.1 | Constant-factor approximation of total MCSP is NP-hard under deterministic quasipolynomial-time nonadaptive reductions assuming subexponentially secure NIWI for SAT, almost-everywhere subexponential nondeterministic hardness of coNP, and almost-everywhere delta*2^n/n circuit hardness of P^NP/poly. This current conditional result must not be called an unconditional polynomial many-one reduction. Its hypotheses are not supplied here. |
| [Carmosino-Dang-Jackman, STACS 2026](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.STACS.2026.23), abstract and main statements | Total XOR Simple Extension is in P both when negations count and when they are free. The method exploits linear optimal size, bounded fan-out of every optimal circuit, and efficiently enumerable polynomially many optimal shapes relative to truth-table length. Read-once OR extensions were already easy. These are exact obstructions to using those simple-extension hardness mechanisms, not to every completion or to Gaussian interpolation. |

The focused search covered partial/total MCSP reductions, formula extensions,
and 2025/2026 follow-ups. It is not an exhaustive novelty certification. Random
oracle results, conditional results, restricted circuit bases, formula leaf
measures and arbitrary circuit gate measures remain distinct.

## Candidate submitted for challenge

Input p is an explicit ternary table on n variables, with N=2^n entries. List
multilinear GF(2) monomials in the author's fixed degree-then-lexicographic
order. For each degree d, solve the evaluation equations on specified rows;
take the first consistent degree, and the RREF solution with all free
coefficients zero. Output the full table H(p) of that polynomial. Variable and
monomial ordering must be fixed in the final specification.

This is concrete enough for one bounded derivation. The operation is standard
polynomial interpolation and Gaussian elimination; the proposed advance is a
new bound on the circuit size of its selected output, not invention of those
operations. A source-supported open question alone would not have been enough.

There are at most N columns and N rows. Testing all n+1 degrees by ordinary
elimination and evaluating all monomials at all N points takes polynomial time
and space in N (a loose O((n+1)N^3+nN^2) bit-operation bound suffices with
straightforward representations). Degree n always works because every total
Boolean function has a multilinear GF(2) representation. There is no circuit
oracle, witness-dependent choice or truth table of length 2^N in this rule.

Fix one circuit basis and size measure for both optima. For example, count
binary AND/OR and unary NOT gates, permit constants and input wires for free,
and allow unrestricted fan-out. Every output agrees with p, giving

    C*(p) <= C(H(p)).

This soundness direction is immediate. The conjectured substantive direction
is C(H(p)) <= a*C*(p)+b*q(n), with uniform constants and a specified polynomial
q independent of p and N. The author must make those quantifiers explicit.
Changing basis is only a constant-factor simulation in general, not an exact
threshold-preserving identity. GF(2) operations used to construct the table
must not silently redefine the measured circuit basis.

## First mechanism challenge

The unspecified-position mask controls which evaluation rows occur, hence
the pivot pattern and selected coefficients. The needed derivation must turn
the existence of a small agreeing circuit into a small circuit for this exact
canonical completion without embedding the arbitrary mask. Polynomial work
on the N-entry table alone gives a circuit bound polynomial in N, far above
the conjectured polynomial-in-n additive loss for small C*(p).

A count of all low-degree functions does not refute the conjecture: only
outputs actually selected from small-circuit-compatible partial tables count.
Likewise, many ANF coefficients do not imply high unrestricted circuit size.
OR_n has a dense degree-n GF(2) expansion and a small ordinary circuit. Thus a
failed coefficient-count proof is a failure of that proof strategy, not a
counterexample to the actual bound. A valid refutation needs an explicit
family p_n, control of the selected H(p_n), an upper bound on C*(p_n), and a
lower bound violating every asserted choice of constants/exponent. A finite
example can reject specified constants, but cannot reject an unspecified
poly(n) loss.

Constants and affine-compatible inputs are useful sanity cases, but success
there alone says little about arbitrary small circuits. In particular, the
all-star table returns zero under the free-zero convention; a nonempty
constant-compatible table succeeds at degree zero. These remove the simplest
mask-exposure objection to default zero filling, without controlling higher
degree pivot dependence. No counterexample to the actual chosen completion
has been established in this initial challenge.

## Threshold and implication challenge

Even if the upper bound were proved, an exact MCSP oracle at threshold
T=a*s+b*q(n) would separate partial instances with C*(p)<=s from those with
C*(p)>T. It would not decide every partial instance at threshold s: instances
with s<C*(p)<=T have no guaranteed answer. Thus this is a conditional
gap-preservation contract. To inherit any literature hardness, its source
YES/NO thresholds, rounding, error model and basis must match that gap. The
partial hardness abstract alone supplies no such matching certificate.

This operation also does not recover a small circuit: it computes a table
claimed to admit one. It supplies neither circuit-description prefix queries
nor the parked separator reconstruction mechanism. An MCSP NP-hardness result
alone would not prove P!=NP or P=NP. Combining a deterministic polynomial
hardness reduction with a deterministic polynomial MCSP algorithm would give
P=NP; with randomized reductions the precise consequence retains randomness.
No such reduction or algorithm is established here, and no assumption that
P!=NP is used to reject the candidate.

## Authorized bounded derivation update

The orchestrator subsequently authorized the bounded derivation, and the
author fixed the target as

    C(H(p)) <= 2*C*(p) + 10*(n+1)^2.

The basis is the counted AND2/OR2/NOT basis specified above. This replaces the
earlier unspecified constants for this candidate. The proposed stress class
specifies the value one at 1^n and values zero at an arbitrary subset of the
other points, so AND_n witnesses C*(p)<=n-1. The all-star and constant cases
therefore cannot alone explain the chosen completion on this class.

The first circuit-construction attempt uses the actual selected coefficients.
At selected degree d it directly evaluates at most sum_(j<=d) binom(n,j)
monomials and combines them by XOR, implemented using four counted gates per
binary XOR. This gives a charged O(n*sum_(j<=d) binom(n,j)) upper bound, not
the target for unrestricted d. For d<=2 a sharper count uses at most
binom(n,2) AND gates, at most n+binom(n,2) four-gate XOR combinations, and a
constant toggle. It is below 10*(n+1)^2. Thus degree at most two cannot provide
a counterexample. This is an elementary construction bound, not a new
preservation result for the stress class, whose selected degree is unbounded.

For higher degrees the attempted proof needs an additional relation between
the actual pivot-selected polynomial and the small agreeing AND circuit.
None was obtained. Large selected coefficient count would invalidate this
particular direct-evaluation estimate without excluding a different small
circuit. No counterexample to the fixed target was established. This is an
unresolved bounded derivation, not an impossibility or selection NONE.

The author supplied a readable [FOCS 2022 proceedings version](https://ieee-focs.org/FOCS-2022-Papers/pdfs/FOCS2022-4Bu7jGV9xIcveUWYj3oWoi/551900a968/551900a968.pdf),
which was independently opened at Theorem I.2 and the following paragraph.
Its circuit thresholds are q=s/log(s) versus q*n^epsilon, with
s=2^Theta(n). This gap asymptotically absorbs fixed basis-conversion constants
and the target's quadratic additive term. Its displayed YES guarantee is
probability-one agreement under a distribution D over specified points. The
independent check of Section II.B resolves the support issue for produced
instances: the construction obtains the partial function by enumerating the
support of its example distribution. Thus the specified positions are exactly
that support; agreement probability one is full agreement there. This uses the
particular reduction's construction, not a general support oracle for arbitrary
samplers. With fixed finite-basis simulation constants and sufficiently large
n, its growing gap therefore conditionally supports the proposed total-MCSP
threshold. The abstract-only warning above is superseded by this inspected
theorem and construction check. Randomized reductions remain randomized, and
the circuit-preservation bound remains unproved.

## Remaining active structural obligation

The candidate remains active and unresolved; this review does not close it.
The suggested zero-set/Reed-Muller fiber direction needs care about degree:
if an agreeing f has degree at most the selected d, the coefficient solution
set is coeff(f)+ker(E_(S,d)), where E_(S,d) evaluates degree-at-most-d
polynomials on specified rows S. Its RREF-selected representative still needs
a circuit-size bound. If deg(f)>d, f is outside that coefficient space and
cannot be used as that affine fiber's base point without enlarging the space.
For the AND witness with degree n, this second regime includes every selected
d<n. Minimum-support codeword information alone does not give an ordinary
circuit bound for the actual pivot-selected representative. No lemma resolving
either regime is claimed.

## Verdict

GO for the explicit candidate and its bounded unresolved assessment.
Preservation and novelty are UNPROVED. No completed hardness
reduction, complexity implication, new algorithmic guarantee or route-final
approval is given. The final author record must retain the mask obligation,
gap limitation and distinction between a failed derivation and an actual
counterexample. This source/mechanism review is not formal proof verification
or three-lens approval of a theorem.

## Second authorized pass: actual-output counting refutes the fixed target

The orchestrator authorized a further bounded mathematical challenge of the
minimal-support route. The author and this reviewer independently identified
the disjoint-decomposition count below and then cross-checked the same
selection argument. This is a mathematical existence argument about the exact
completion rule, not an experiment, explicit circuit-hard function
construction, general MCSP lower bound, or complexity-class separation.

The primary [Borissov-Manev, Minimal Codewords in Linear Codes, 2004](https://www.math.bas.bg/serdica/2004/2004-303-324.pdf)
was opened at Section 2. It states the Reed-Muller dimension and minimum
distance and its Proposition (vii) gives the disjoint binary splitting
property used here. Minimal means inclusion-minimal nonzero support, not
minimum weight. The paper's detailed classifications for specific small
parameters are not needed. A separate Ghent primary PDF search result concerned
low-weight minimal words; opening it timed out, and no classification from it
is used.

### 1. There are sufficiently many minimal cubic codewords

Fix n>=3, N=2^n, K_d=sum_(j=0)^d binom(n,j), and let M count nonzero
minimal-support codewords of RM(3,n). Its dimension is K_3 and every nonzero
word has weight at least N/8.

For completeness, the distance lower bound has the standard elementary
induction: write a nonzero degree-at-most-d polynomial in the last variable
as b+x_n*a. If a=0 its weight is twice the weight of b. Otherwise its two
slices b and b+a have total weight at least the weight of a, which has degree
at most d-1 in n-1 variables. Together with the constant/nonzero base cases,
this yields weight at least 2^(n-d).

If a binary codeword c is not minimal, choose nonzero u with support strictly
contained in support(c). Then c=u+(c+u), and the two nonzero summands have
disjoint supports properly contained in support(c). Recurse; support size
strictly decreases. Every final summand is minimal, and all final supports
are pairwise disjoint. The minimum-weight bound limits the number of summands
to eight. Zero is the empty sum. Thus every one of the 2^K_3 words has a
representation by at most eight minimal words, and

    2^K_3 <= sum_(i=0)^8 binom(M,i) <= (M+1)^8,
    M >= 2^(K_3/8)-1.

No uniqueness of decomposition is needed: counting possible representations
upper-bounds the number of represented codewords. The second inequality can
also be seen by padding an ordered representation to eight slots with zero.

At most (1+binom(n,3))*2^K_2 cubic-or-lower polynomials have zero or one cubic
monomial. Subtracting these from M leaves a family G of minimal words with
at least two cubic monomials, with

    |G| >= 2^(K_3/8)-1-(1+binom(n,3))*2^K_2 = 2^Omega(n^3).

Here K_3/8=n^3/48+O(n^2), whereas K_2+log2(1+binom(n,3))=O(n^2).
The lower bound is asserted for sufficiently large n, not for every small
parameter.

### 2. Every counted word gives an actual selected completion

For g in G, let f be its highest-ordered cubic monomial under the design's
fixed degree/lex order, set U=support(g), and define p(x)=f(x) for x outside
U and p(x)=* for x in U. The monomial f has a two-AND-gate circuit, so
C*(p)<=2. Constructing this p from a supplied coefficient vector g takes
polynomial time in its N-entry output length; finding a circuit-hard g is
not claimed efficient or required for the existence argument.

A degree-at-most-three polynomial k vanishes outside U exactly when its
support is contained in U. By minimality of g and uniqueness of binary words
with a given support, the only such k are zero and g. Hence the degree-three
solution fiber is exactly {f,h}, where h=f+g.

Both f and h have degree exactly three: removing the highest cubic monomial
of g leaves at least one other cubic monomial. Consequently no lower-degree
solution exists, and the algorithm reaches exactly d=3.

Let j be the highest nonzero coefficient index of g. The homogeneous
evaluation matrix has one-dimensional kernel spanned by g. Its only free
column in left-to-right elimination is j. To see this without assuming a
pivot convention, the columns before j are independent, since any dependency
among them would be a kernel vector other than g. Column j depends on them
by g's relation. Every later column adds rank, since any further dependency
would give an independent kernel vector. This argument uses the fixed column
order, and is unaffected by the choice of pivot row.

The coefficient of f at j is one, while that of h is zero. Setting the unique
free coefficient to zero therefore selects h, exactly as the actual rule
requires. This establishes H(p)=h, not just the existence of some hard
alternative completion.

### 3. Actual outputs exceed the target circuit budget

For any fixed output h, every possible preimage g satisfies g=h+f with f a
cubic monomial. Thus multiplicity is at most binom(n,3), and the number of
distinct actual outputs obtained above is at least |G|/binom(n,3), still
2^Omega(n^3). No injectivity assumption is hidden here.

Set T=4+10(n+1)^2. A counted AND2/OR2/NOT circuit with at most T gates can be
described by its gate count, a topological ordering, each gate's type and
predecessor indices, and its output wire. An intentionally loose upper bound
on all such descriptions is

    (T+1)*(n+T+2)*[3*(n+T+2)^2]^T = 2^O(n^2 log n).

Free constants and input-wire outputs are included; allowing two predecessor
slots even for unary NOT only overcounts. Arbitrary depth, sharing and fan-out
are allowed. For sufficiently large n this is strictly smaller than the
number of distinct actual outputs. Therefore some p in the specified family
has

    C*(p)<=2  and  C(H(p))>4+10(n+1)^2 >= 2*C*(p)+10(n+1)^2.

This refutes the fixed target (P). It does not merely show that direct ANF
evaluation is expensive, and it makes no assumption that P differs from NP.
The counterexample is existential within an exactly defined family; no
specific enormous truth table or optimal circuit has been computed.

### Independent verdict on this pass

GO for this scoped refutation of the specified deterministic completion's
fixed quadratic-loss target. The proof supplies the formerly missing actual
fiber, minimum selected degree, free-column orientation and sufficient-output
count. The earlier active-UNRESOLVED designation is superseded for (P), while
the general research objective remains unresolved. This result does not rule
out different completion rules, different preservation losses or other
partial-to-total encodings, and no novelty or publication claim is certified.
The orchestrator owns final closeout and any required additional review.

## Same-route strengthening: exponential selected circuits from linear witnesses

At the orchestrator's request the author and reviewer checked a stronger
version of the same argument. It requires no new codeword classification.
This reviewer contributed to the derivation and therefore is not an
independent final proof lens for it; a fresh reviewer is required for that
role. The following is the checked mathematical statement awaiting that
separate closeout.

For any n and 1<=d<=n, let M_d count minimal nonzero words in RM(d,n).
Disjoint splitting and minimum weight 2^(n-d) give

    M_d >= 2^(K_d/2^d)-1.

For each minimal g, choose its highest-ordered nonzero monomial f, and again
define p=f outside support(g), with stars inside. Let r=deg(f)<=d and h=g+f.
The entire degree-at-most-d compatible fiber is exactly {f,h}. If h has
strictly smaller degree than r, it is the unique solution at the first
consistent degree, so H(p)=h. If h and f both have degree r, the kernel in
degree-at-most-r remains {0,g}; its unique free column is the highest nonzero
coefficient of g, and H(p)=h by the prior argument. If h is zero, the zero
completion is uniquely chosen at degree zero unless f is also constant;
the constant case has the same free-zero result. Thus the actual selection
holds for all minimal g; the earlier exclusion of single highest-degree
terms was unnecessary for this strengthened statement.

Every f is a monomial of degree at most d and has at most d-1 counted gates
(constants are free). For fixed h there are at most K_d possible preimages
g=h+f. Therefore at least M_d/K_d distinct actual outputs arise from inputs
with C*(p)<=d-1.

Now take d=floor(n/2), for sufficiently large n. Symmetry of binomial
coefficients gives K_d>=2^(n-1), while K_d<=2^n. Writing
A=K_d/2^d, the bound 2^A-1>=2^(A-1) yields

    log2(M_d/K_d) >= A-1-log2(K_d)
                   >= 2^(ceil(n/2)-1)-n-1.

Set T=floor(2^(n/3)). The same circuit-description count has logarithm
O(n*2^(n/3)), which is strictly below this output-count lower bound for all
sufficiently large n. Consequently, for every sufficiently large n there
exists a partial table p with

    C*(p)<=floor(n/2)-1,
    C(H(p))>floor(2^(n/3)).

This rules out any fixed polynomial upper bound in n+C*(p) for the specified
completion rule, not just the initially proposed quadratic additive loss.
It remains an existential input family, with explicit masking and exact
selection conditional on its minimal word; no efficiently computable family
of hard functions is produced. Constructing a table from a supplied g still
takes polynomial time in N=2^n. The cost of finding a suitable g is not
claimed polynomial. No conclusion about other completion algorithms or the
possibility of a general partial-to-total reduction follows.
