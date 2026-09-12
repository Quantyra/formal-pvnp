# Post-bamboo frontier intake: target-directed modular lifting

2026-09-12; S3106 / S008. Bounded literature and research-selection intake.
[Integrity boundary](../../INTEGRITY-CLAIMS.md).

**Selection: NONE.** One concrete algorithmic proposal outside bamboo was
screened: use small-modulus Subset Sum computations, then refine only
the target's carry fibers, compressing certified dense portions as
arithmetic progressions. The strongest current primitives already make
the small-modulus and pseudopolynomial stages efficient. They do not
supply the selective exact-lifting operation or its charged size bound.
This intake also supplies no concrete selective update rule of its own.
That design gap, rather than an unproved bound alone, is why it is not selected
for another implementation or demonstration campaign.

## What this intake deliberately changes

Read the planning S008 frontier method and contribution-first correction,
the current research meta-graph and the completed bamboo compression
assessment. This screen does not reopen unrestricted bamboo circuit
hardness, PPSZ recombination, constant-image IPS, universal external-field
stencils, quantum state preparation, MCSP gate shrinkage, or complete
resolution-frontier compilation. It does not nominate a restricted proof
class merely because the larger class has a known upper bound.

The representation here is an explicit list of positive binary integers
and one target. The desired operation is exact integer target membership,
with a recoverable subset on YES and a sound exhausted search on NO.
The intended improvement is polynomial dependence on the input **bit
length**, replacing dependence on the numeric target or on an explicitly
enumerated set of reachable sums. This would give deterministic polynomial
SAT through a standard polynomial-bit-length reduction, hence P=NP.
A smaller exponential improvement could be algorithmically interesting,
but would need its own quantitative recurrence and is not the claimed
payoff of this screen.

## Current primary baseline

**Deterministic pseudopolynomial and output-sensitive algorithms.**
Chan's January 2026 paper gives a deterministic near-linear-in-t algorithm
for all reachable Subset Sum targets through t (Theorem 2.7), and
derandomizes output-sensitive bounds depending on |OUT|. Its canonical
subset generation and weaker halvers avoid assuming that the solutions
were already known. Lemma 2.4 still charges the numeric universe: its
canonical-family bound is roughly b^2 u, with construction roughly b^3 u,
up to logarithms. Thus the current deterministic baseline is substantially
stronger than old Bellman DP or an unimplemented derandomization proposal.
[Primary paper, Sections 2--3](https://arxiv.org/pdf/2601.01390).

**Modular computation.** Potepa's deterministic algorithm computes all
reachable residues modulo p in O(p log p alpha(p)) time and O(p) space
(Theorem 2). Its input is a compact residue/multiplicity list; reducing an
explicit list adds input-reading and bit-arithmetic costs. Shift-trees
amortize updates against newly reached residue positions. They represent
reachability in Z_p, not which integer carries have been achieved inside
one residue class. A near-linear modular stage is already known.
[Primary paper](https://arxiv.org/pdf/2012.06062).

**Dense integer structure.** Bringmann and Wellnitz give a near-linear
regime controlled by t, maximum item, total sum and multiplicity; their
Theorem 1.4 includes the multiplicity factor. Their structural theorem
finds a central interval of reachable sums under density and
no-almost-divisor hypotheses. Their algorithmic removal of almost
divisors is efficient under the same density regime. This is more
powerful than assuming every sumset must be explicitly listed, but does
not apply to an arbitrary conditioned carry fiber. Their conditional
fine-grained lower bounds are hypothesis-dependent, not unconditional
evidence against P=NP.
[Primary paper, Theorems 1.2--1.4 and 3.3--3.4](https://arxiv.org/pdf/2010.09096).

**Space improvement is a separate resource.** Sajith's 2025 primary
preprint states randomized near-linear pseudopolynomial time with
polynomial space and a deterministic near-Bellman-time polynomial-space
algorithm. Even accepting its stated guarantees, its time still depends
on the numeric target. This screen does not independently certify that
preprint or confuse polynomial space with polynomial time.
[Primary abstract and version record](https://arxiv.org/abs/2508.04726).

These are the strongest directly relevant guarantees located and checked
in this bounded search, not an exhaustive priority or fastest-algorithm
certification. No heuristic benchmark or unreviewed P=NP announcement is
used as an established premise.

## Exact SAT instance interface

For clarity, use the usual digit reduction from a preprocessed 3-CNF with
v variables and c clauses, each with distinct literals. There are v+c
base-ten columns. For each variable create two numbers: both have digit
one in its variable column, and each has digit one in precisely the clause
columns satisfied by its truth setting. For each clause add two slack
numbers with respective digits one and two in that clause column only.
The target has digit one in every variable column and four in each clause
column.

No column sum can carry: variable columns sum to at most two, and each
clause column to at most six. Hitting the variable digits picks exactly
one setting per variable; slack reaches four precisely when at least one
of that clause's literals is satisfied. The instance has 2v+2c items and
O(v+c) bits per item and target. The numeric target may be exponential
in v+c. This paragraph fixes a standard encoding, not a new reduction or
a claim that its output has the dense-source parameters.

Let A denote this multiset, W its total sum, and L its full binary input
length. A result polynomial in L for all such images would suffice for
general SAT. Applying a near-linear-in-t algorithm directly is not that
result. Applying an output-sensitive algorithm directly also requires a
new bound on the relevant reachable-sum output, not merely its compact
input description.

## Concrete proposed operation

The screened idea was the following target-directed refinement scheme.

1. Start with a modulus p bounded by a fixed polynomial in L. Compute
   modular reachable sets and obtain actual subset witnesses for residues
   when the chosen primitive provides them, charging reconstruction.
   If t modulo p is unreachable, certify NO; if a recovered subset has
   exact integer sum t, certify YES.
2. A modular witness with sum t+kp for nonzero k supplies no decision.
   Refine its integer carry information. Maintain a tree of residue
   classes at moduli p, 2p, 4p, ... and visit only fibers relevant to
   reaching the exact target. Keep item-disjointness data when combining
   partial witnesses; a residue match must not reuse an item.
3. Whenever a fiber can be certified to contain a whole arithmetic
   progression of integer sums, store the progression and its membership/
   witness certificate instead of its individual sums. Refine remaining
   exceptional carry regions. Reject only after all target-compatible
   regions have been soundly excluded.

The intended mathematical lever is **density-versus-refinement**: either
a large carry fiber has a certifiable regular part, or its irregularity
should restrict the number of future target-compatible branches enough
to pay for refinement. This is the proposed mechanism, not an assumption
that every long interval is full. It differs from merely computing several
small independent modular answers and applying the Chinese remainder
theorem: those answers need not be witnessed by one common subset.

## First falsifiable obligation and full cost

For an item split A=A_left disjoint-union A_right and modulus p, define

    U_r = {s : s is a subset sum of A_left and s = r mod p},
    V_(t-r) = {s : s is a subset sum of A_right and s = t-r mod p}.

The exact query for that residue is U_r intersect (t-V_(t-r)) nonempty.
Knowing that both fibers are nonempty is insufficient. A minimum, maximum,
gcd or one witness in each fiber does not answer this intersection query.

The first proposed invariant would have to bound, for every SAT-reduction
image, the total number of materialized exceptional carry records plus
the total size and construction cost of all certified progression pieces
by L^C for one fixed C. Each refinement must be performed from the input
items and current records, without a subset-sum/extension-feasibility
oracle, and must preserve the exact intersection query above. The charge
must include failed branches, recomputations, witness copies, bit
operations, and construction/verification of the regularity certificates.

There are only O(log W) possible doubling levels. That alone does not
bound work: the total number of visited fibers, their representations and
the cost of evaluating a single selected fiber could still be enormous.
If each level simply invokes the published modular algorithm with its
full doubled modulus, the final cost depends on W and is pseudopolynomial.
If the modulus remains small, the uncomputed carry-fiber information is
exactly what prevents a complete NO decision.

The exact intersection equation states a correctness requirement; it does
not specify a selective lifting algorithm. The only fully specified update
here is exhaustive modular recomputation after doubling, which retains
pseudopolynomial cost. For the selective version this intake gives no rule
to construct a conditioned fiber, certify a progression without first
enumerating it, or choose and update exception records. The proposed
total-work quantity is an accounting target, not a local structural
potential with an update law. This is the specific design gap behind
NONE. A concrete speculative rule with an unproved quantitative invariant
would be eligible for a separate force intake; prior proof or prior
literature support for that invariant is not required. No claim is made
that such a rule or invariant cannot work.

## Why the available tools do not establish that invariant

The modular algorithm amortizes newly reached **residues** in a fixed
finite group. A refinement can leave that group-level support unchanged
while revealing additional distinct integer carries. Its amortization
does not charge those new records. Restricting to a residue also couples
which input items may be selected; the resulting fiber is not supplied
as an independent unconstrained item multiset to which one can reapply
the same algorithm for free.

The dense theorem concerns a genuine multiset satisfying a quantitative
density hypothesis. A large number of possible witnesses in a carry
fiber is not that hypothesis. The SAT digit construction intentionally
preserves many separate coordinates in large binary integers. There is
no established preprocessing step converting all of its conditioned
fibers into the dense theorem's inputs at polynomial total cost.
Computing all exceptional sums first in order to recognize the regular
part would already incur the cost the proposal seeks to remove.

Chan's canonical representatives preserve sum and cardinality under a
carefully costed construction. They do not make integer-sum-conditioned
fibers available at a cost depending only on their descriptions. Using
the canonical-family theorem with exponentially large u would preserve
the published guarantee and miss the desired bit-length bound.

No candidate local quantity or selective transition was specified that
connects failure of density to fewer later refinements. The problem is
not that a specified transition lacks a proof: the transition itself is
missing. Testing exhaustive modular recomputation would test the known
baseline, while testing the desired selective operation would first
require inventing an additional mechanism. This intake therefore stops
before implementation without ruling out that future design work.

## Same-instance escapes and scope of the decision

The screened method is compared with modular DP, modern deterministic
pseudopolynomial computation, output-sensitive computation and certified
dense structure. Meet-in-the-middle remains an exponential alternative.
The original SAT instance may also be easy after unit propagation, XOR
elimination, symmetry handling or decomposition; this assessment does
not label the digit encoding hard for those solvers. Conversely, examples
where such methods solve an instance do not establish the missing
uniform selective-lifting bound. No new toy examples, benchmark suite,
quantum interpretation or claim about all solvers is needed to make this
selection decision.

The direct implication to P=NP is conditional on a complete deterministic
polynomial bit-time algorithm, including NO cases. A randomized modular
filter, a supply of short witness descriptions or polynomial workspace
alone gives no such implication. Neither an NP-hard reduction nor a
SETH-based bound forbids speculative algorithm design; the reason for
NONE here is the absence of a specified selective operation and local
refinement invariant, not the absence of a proof for a concrete one.

Only one proposal was evaluated deeply enough to state this contract.
No second candidate is manufactured from a named open question. There
is no surviving implementation, proof campaign or automatic successor
selected by this intake. The overall research objective remains open;
this completed selection result does not declare the frontier exhausted.

## Execution and review boundary

Read S008's frontier protocol and current graph exclusions, browsed the
primary literature above, and compared the exact representation, query,
construction cost and claimed implication. Only this owned intake file
was written. No experiment, implementation, theorem formalization,
publication, other-file edit, commit, push, outreach or paid computation
was performed. Independent selection/nonclaims review remains separate.
