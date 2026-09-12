# S3106 independent post-bamboo frontier selection

2026-09-12; S008. Reviewer: `bamboo_size_fresh`.
**Independent scout selection: NONE among the two concrete mechanisms
tested below.** This bounded result does not say that the research
frontier is exhausted. It rejects neither strong sparsification nor
probabilistic rank as research areas. The broader P-versus-NP objective
remains unresolved.

I read the frontier research protocol, its contribution-first correction,
the literature-trigger protocol, current graph through S3105, and the
prior constructive/reselection assessments. The exclusions therefore
include the exact bamboo whole-certificate compression route, the
oracle-removal catalytic reconstruction proposal, and automatic returns
to parked PPSZ/MCSP/quantum or toy-obstruction packages. I independently
browsed primary sources before seeing the author's new intake.

## Candidate 1: repeated forced-variable merging to shrink exact SAT

**Closest guarantee.** Bedert--Nakajima--Okrasa--Zivny give a polynomial-time
strong sparsification algorithm for monotone 1-in-3-SAT with
O(n^(2-epsilon)) clauses, epsilon about 0.0028. The May 2026 v4 explicitly
distinguishes strong sparsification from deleting constraints. Its
Section 3 uses a mod-2 relaxation of 2-in-3-SAT to find forced equalities;
its principal application is approximate hypergraph coloring. Section 5
also provides merge-free instances with Omega(n^1.725...) constraints.
[Primary v4, Theorem 2 and Sections 3,5](https://arxiv.org/html/2507.17878v4).

**Proposed difference and mechanism.** Iterate sound forced-equality
merges and relaxation recomputation until the residual has O(log L)
variables, where L is the original explicit input length, then enumerate
the residual assignments and lift a witness. For an UNSAT instance, the
procedure must either produce a sound contradiction or reach a residual
whose exhaustive check rejects. A uniform polynomial total-time version
would decide an NP-complete exact constraint problem in P. This is a
specific closure mechanism, not an inference that fewer clauses imply
tractability.

**First falsifiable obligation.** Every nonterminal instance outside
the stated small residual class must admit a sound merge discoverable
in polynomial time, or the procedure must return a correctly justified
decision. Iteration must have a polynomial bound, and the terminal check
and witness reconstruction are charged. No promise of satisfiability or
oracle for the full solution set is permitted.

**Challenge and verdict.** The source's merge-free families already
invalidate the universal progress-by-merging premise. The published
subquadratic clause bound does not imply logarithmically many remaining
variables; recomputing a fixed point supplies no new equality. Even a
perfect oracle returning all forced pairwise equalities cannot merge
variables that are not equal in all solutions. Reject the proposed
universal merge-to-small-residual mechanism at intake, without a new
experiment. This is a failure of the proposed operation, not evidence
that these particular residual families are hard for all solvers.

Adding branching, algebraic elimination of richer relations, or a solver
for every merge-free residual changes the operation and reintroduces
the missing search guarantee. No such operation with a justified total
cost was identified here. Approximate coloring, mod-2 consistency, and
linear-size ordinary sparsification do not answer exact satisfiability.
No successor is selected merely by naming one of those missing steps.

## Candidate 2: factor cross-quadratic terms before threshold batching

**Closest guarantee.** Limaye--Srinivasan--Srinivasan give deterministic
#SAT algorithms for ACC0 composed with degree-three polynomial threshold
gates, using constructive probabilistic-rank representations. Their
Theorem 20 has a genuine exponential saving for the stated depth, size,
and coefficient-bit regimes. Remark 2 identifies the degree-four
arbitrary-weight gap: a split produces quadratically many terms, and the
resulting majority approximation loses the needed sublinear degree.
Bounded-weight MAX-4-CSP and algorithms for a single PTF do not resolve
composition with many arbitrary-weight gates.
[Primary MFCS 2025 paper, Remark 2 and Theorem 20](https://drops.dagstuhl.de/storage/00lipics/lipics-vol345-mfcs2025/LIPIcs.MFCS.2025.67/LIPIcs.MFCS.2025.67.pdf).

**Proposed difference and mechanism.** For a fixed balanced variable
partition x,y, isolate a degree-four polynomial's (2,2) component

    P_22(x,y)=sum_(i<j,k<l) C_(ij,kl) x_i x_j y_k y_l.

Factor C into a short sum of outer products. Treat the corresponding
quadratic forms of x and y as batched features, then feed fewer mixed
summands to the source's threshold/probabilistic-polynomial machinery.
The intended gain over direct quadratic lifting is a uniform reduction
of the number of mixed summands to n^(2-delta), for some fixed delta>0,
without expanding coefficient bit length or paying exponential discovery
cost. The proposed exact factorization, rather than the broad open
problem of degree-four probabilistic rank, is the object challenged.

**First falsifiable obligation.** Every input cross-quadratic coefficient
matrix must have such a short exact factorization, discoverable in time
polynomial in its explicit bit encoding, with all factors of polynomial
bit length. A successful factor bound would still require a separate
uniform rank construction, error/seed management, exact #SAT extraction,
and total running-time analysis beating the appropriate existing
algorithm. No theorem that the factor bound alone supplies that final
algorithm is asserted.

**Challenge and verdict.** Let each side have t variables and index rows
and columns of C by its K=binom(t,2) quadratic monomials. The choice
C=I_K has rank K over Q. Any sum of r outer products has rank at most r,
so the proposed universal r=n^(2-delta) exact factorization fails.
This elementary coefficient-rank check is a selection diagnostic, not a
new lower-bound theorem. Allowing arbitrary separate polynomial features
does not remove it: taking their quadratic coefficient parts recovers
the same coefficient-matrix factorization. The input has tiny integer
coefficients, so poor weight precision is not the cause of this failure.

This does not lower-bound the probabilistic rank of the thresholded
Boolean function. In fact, the displayed diagonal polynomial has extra
symmetry which another algorithm could exploit. It refutes exactly the
factor-first universal compression proposed here. Replacing exact
factorization with an error-tolerant, sign-preserving structured sketch
would require a new mechanism; a bare request for a better probabilistic
rank bound is not enough under the contribution-first protocol.

The source already has deterministic counting despite using
probabilistic polynomials internally; merely proposing to derandomize
it would not be a new advance. A next algorithm would need to include
sampling/construction, all seed or amplification costs, feature length,
matrix multiplication, exact counting, and coefficient arithmetic.
Pointwise constant error does not certify exact UNSAT: a unique witness
must not be lost. No such replacement guarantee was established here.

## Selection consequence

These candidates have direct exact-decision or counting relevance and
explicit first obligations, but their proposed operations fail before
implementation. Neither is promoted just because its surrounding area
contains open problems. No claim of novelty follows from the bounded
search, and no claim that all current primary literature was exhausted
is made. Search results through the session date did not justify a
stronger applicable theorem for either operation.

For candidate 1, a polynomial-time complete algorithm would imply P=NP;
the imported sparsifier does not provide one. For candidate 2, a real
improvement would first be an exact exponential-time #SAT algorithm for
a specified circuit class. A circuit lower-bound consequence would
require checking the precise algorithm-to-lower-bound theorem and its
uniform size/depth quantifiers. No P=NP or P!=NP conclusion would follow
merely from a faster exponential algorithm.

The independent scout result above was reached before the author's
candidate was available. The required actual-file challenge follows.
No experiment suite, proof implementation, public edit, commit, push,
outreach, or paid computation was performed. Only this owned selection
file was written.

## Actual author-intake challenge: target-directed modular lifting

I subsequently read the entire saved
[author intake](2026-09-12-post-bamboo-frontier-intake.md), SHA256
`D7634F4B719A3AE39CEC45AF7E957035BB0D0132E1FC6021E04D82D5EF234E93`.
This is a review of the separately assigned author's proposal, not an
additional independently scouted candidate or an automatic successor.

**Verdict: agree with NONE for the operation specified in this snapshot.**
Its input, exact query and desired output are concrete enough to audit,
but its selective transition is not specified. This is a design-level
selection rejection, not a requirement that a speculative invariant
already be proved or appear in the literature, and not a proven
impossibility for adaptive modular algorithms.

I independently opened Chan's January 2026 primary paper. Theorem 2.7
is deterministic time near-linear in the numeric t; Lemma 2.4 generates
about b^2 u canonical subsets at about b^3 u cost, up to logarithms.
Section 3 retains dependence on the number of reachable output sums.
These contracts agree with the author, and none is polynomial in log t
alone. [Chan, Sections 2--3](https://arxiv.org/html/2601.01390v1).

Potepa's modular algorithm likewise charges the numeric modulus and
computes reachable residue positions under compact multiplicity input;
it does not deliver integer carry sets or a shared witness across
different moduli. [Primary ESA paper](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.ESA.2021.76).
Bringmann--Wellnitz's dense-regime results depend on the actual item
multiset's quantitative density parameters. They do not apply merely
because a conditioned carry fiber has many possible witnesses.
[Primary dense Subset Sum paper](https://arxiv.org/pdf/2010.09096).

The digit-encoding interface checks: at a variable digit at most two
units can be selected; at a clause digit at most three literal units
and three slack units can be selected. Therefore base ten prevents
carry. Target one selects exactly one truth setting, and available
slack sums 0,1,2,3 reach target four precisely for literal count 1,2,3.
The stated polynomial bit-length and potentially exponential numeric
target are correct. This is the usual reduction, not a new mechanism.

The exact split query `U_r intersect (t-V_(t-r)) != empty` correctly
exposes the missing information. The presence of both residues only
gives two existential witnesses; equality of their integer sum to t
requires compatibility of their carries. The author explicitly retains
item-disjointness and does not make the independent-CRT-witness error.
No uncharged polynomial bound is inferred from the logarithmic number
of modulus doublings.

The important challenge is stronger than saying there may be many
reachable sums. A query-specific algorithm might avoid representing
most of them. It must therefore provide a construction rule proving
which exceptional fibers can be skipped without losing the only exact
witness or an UNSAT obstruction. In the current proposal, identifying
the fibers relevant to completion is not an implemented or proved
primitive. Certified arithmetic-progression storage is also insufficient
unless membership/witness certificates can be constructed and composed
without first enumerating the hidden fiber. Reapplying an unconstrained
Subset Sum theorem to a fiber would discard its selection correlations.

The proposed polynomial potential is presently an aggregate desired
work bound, not a candidate local structural quantity with an update
rule. The problem is not that a specified update has an unproved
decrease bound. There is no selective update to analyze: how a fiber
is constructed, how a progression certificate is produced, and which
exception record is replaced by which new records are left undesigned.
Exhaustively recomputing all residues after doubling is specified, but
that is the known pseudopolynomial baseline. A concrete speculative
selective rule and a proposed structural reason it might control work
would justify a derivation attempt even with an unproved invariant.
No existing theorem or prior success would be required. The note
correctly stops this bounded screen without claiming a universal
obstruction or exhaustion of the frontier.

No correction to the author's selection verdict or claimed implication
is requested. A complete deterministic polynomial bit-time exact
algorithm on these images would imply P=NP; the inspected primitives
and invariant proposal do not establish it. All three independently
assessed operations in this combined intake remain unselected. No
weakened representation class, toy check, or automatic successor is
recommended by this reviewer. The author and independent scout's
choices were distinct, and this agreement concerns the actual saved
argument rather than deference to the author's NONE label.

### Selection-criterion correction and final amended-file check

The root correctly challenged the initial wording that referred to
an unsupported invariant: missing proof is permissible in speculative
research. I rechecked the author's amended design-gap paragraphs at
SHA256 `F9CD527DCC9EE297331C1F5E5F3FAFAC02F7A4356E4EBFCC8D997CBBC2451073`.
They expressly distinguish the absent selective transition from an
unproved bound on a concrete transition. The clarification agrees with
the operational check above; no mathematical correction is needed.

The final NONE applies to selecting a force/implementation campaign
from the current unspecified selective branch. It does not veto further
invention of that branch, demand a proved polynomial bound before
exploration, or require literature to have solved the new mechanism.
No concrete selective transition was falsified in this review. This
distinguishes the author intake's design gap from the two independent
scout mechanisms above, whose exact proposed universal operations were
tested and rejected. The initial actual-file hash remains provenance;
the amended hash is the final reviewed author snapshot.
