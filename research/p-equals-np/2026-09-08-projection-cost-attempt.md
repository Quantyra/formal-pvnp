# Exact pair-mask projection and cumulative cost attempt

2026-09-08; S3040 / E004 / S008; harness only, no OpenCode.
Destination: this repository, `research/p-equals-np/`.
This is a research derivation and executable falsification attempt, not a Lean
proof, commit, public theorem announcement, or route-final closeout.

## Target and literature alignment

The target is still a deterministic polynomial-bit-work SAT algorithm, motivated
by the vortex endpoint problem. This follow-on attacks the previous note's
specific missing operation: repeated exact projection of pairs with arbitrary
crossing clauses. An accelerating clock is not used as a unit-cost oracle.

T3 alignment within S3040: [Darwiche and Marquis, A Knowledge Compilation Map](https://arxiv.org/abs/1106.1819)
was reopened on 2026-09-08. It distinguishes compact representations from
efficient supported operations. For the limitation below, the primary paper
[Ben-Sasson and Wigderson, Short Proofs Are Narrow—Resolution Made Simple](https://people.inf.ethz.ch/emo/SatSem05/Papers/BensassonWidgerson01.pdf)
was opened; Theorem 4.4 and Corollary 4.5, printed page 156 (PDF page 8), give
exponential resolution size for odd-charge Tseitin CNFs on connected 3-regular
expanders. This is a known result used to test this particular algorithm, not
new evidence separating P and NP.

| Literature step | This candidate | Gap or consequence |
|---|---|---|
| Compilation size versus query cost | Constant number of mask-group gates | Must compose later projections efficiently |
| General-resolution refutations | Each flat pair output has a constant-step derivation | Adaptive order cannot escape this proof-system boundary |
| Tseitin expander size lower bound | Applies to flat clause-only version | A universal polynomial cumulative bound for that version is false |
| More expressive computation | Nested gates or algebraic reasoning are possible | No all-input polynomial evaluator established |

In scope: derive the pair rewrite, check exactness and certificates, identify the
precise cumulative limitation. Out of scope: new classical lower bounds, claims
about all SAT algorithms, or a fluid-to-Turing simulation theorem. Stop-loss:
do not continue tuning flat pair-elimination order as if its universal
polynomial bound remained open. Decision: reject that universal bound; keep the
factored semantic identity only as a candidate needing a nonclausal cumulative
evaluation theorem. No new force story is opened by this note.

## A concrete rewrite, with no retained four-way branch list

Let the eliminated pair be p=(a,b), and let D be its allowed assignments.
For an ordinary CNF, D={00,01,10,11}. A pinned AND output c=0 gives
D={00,01,10}; c=1 gives D={11}. Domain restrictions must be explicit input
constraints, not inferred from an unknown SAT answer.

Write each clause as L_j(p) OR R_j(x), where x are remaining variables. Define

    M_j = {s in D : L_j(s)=false}.

Discard empty masks: their clauses are true for every allowed pair state.
For a fixed outside assignment x, clause j forbids precisely M_j when R_j(x)
is false, and forbids nothing otherwise. Therefore the exact projection fails
iff the masks of false residual clauses cover D.

Group equal masks and let G_M(x)=AND_{j:M_j=M} R_j(x). An inclusion-minimal
cover of D is a collection K of distinct nonempty masks whose union is D and
whose proper subcollections do not cover D. The exact factored identity is

    exists p in D F(p,x)
      = AND_{minimal mask covers K} (OR_{M in K} G_M(x)).             (1)

Proof: G_M is false exactly when at least one residual in its group is false.
Failure of the right side is exactly a mask cover all of whose groups have
a false residual. Choose one such clause in each group. Conversely every
collection of false residuals covering D contains a minimal cover after
duplicate masks are removed. This gives both implications. Empty D projects
to false; with nonempty D and no covers the empty conjunction is true.

Every minimal cover has at most |D| masks: each member has a state not covered
by the other members, and these private states differ. Thus there are at most
15 groups and a constant number of covers for a pair (at most 49 for four
states; the implementation enumerates them). On a CNF input, the shared-gate
version of (1) has O(L) size and construction work up to fixed constants.
This is a real local compression identity. It is not a final SAT value while
x remains unquantified.

## Candidate repeated rewrite and informal correctness argument

Distribute each disjunction of conjunctions in (1). For each minimal cover K
and each selection of one residual clause from each group, emit their union
as a clause. Remove tautologies, duplicates, and syntactically subsumed clauses.
This yields a CNF for the exact projected relation. With m input clauses the
number of raw candidates is at most sum_{j=1}^4 binomial(m,j)=O(m^4).
For the c=0 domain this improves to O(m^3).

The reproducer applies this rule repeatedly. At each stage it computes the
output for every available pair and chooses minimum clause count, then minimum
literal count, then lexicographic pair. It counts work for rejected pairs too.
Odd numbers of variables use an unused padding variable. It terminates with
true or false after at most ceil(n/2) selected projections, or earlier on the
empty CNF / empty clause. Exactness of existential projection proves the final
Boolean answer correct for all CNFs in this informal mathematical derivation.
This supports termination and correctness of the proposed iteration; it does
not establish an approved repository general-SAT-solver capability. The
executable evidence is limited to the finite tests below. Its attempted
worst-case polynomial complexity bound fails as described below.

For the simple implementation, normalization compares pairs of generated
clauses. If m_i clauses remain before stage i and L bounds original total
encoding size, a loose total-work upper bound is

    O(L * sum_i n_i^2 * (1 + m_i^8)),                              (2)

including comparison of all candidate pairs. No extension definitions are
introduced. The only possible fresh variable is an unused padding variable,
so clause width is at most the original variable count. Thus a
universal polynomial bound on the sum in (2) would suffice, but does not follow
from a constant number of gates in one factored projection. The raw recurrence
m_(i+1)<=O(m_i^4) is not polynomial after n/2 stages.

## What the local compression gains, and what the naive invariant loses

For D={00,01,10}, take t clauses in each of the groups

    (a OR b OR u_i), (a OR NOT b OR v_i), (NOT a OR b OR w_i).

Their masks are the three singletons of D. The flat rewrite emits exactly
t^3 distinct clauses (u_i OR v_j OR w_k), none tautological or subsumed.
The input has 3t crossing clauses and the domain axiom NOT a OR NOT b.
The factored form is simply

    (AND_i u_i) OR (AND_i v_i) OR (AND_i w_i).

Therefore flat clause count need not decrease, whereas factored local output
really avoids this cubic product. This particular formula is easy to satisfy;
the example disproves only a local size-decrease invariant. It is not used as
an all-input runtime lower bound. The rule accepts arbitrary additional clauses
on remaining variables, retaining their constraints exactly.

## Stronger result: the flat clause-only candidate cannot have the desired bound

Here is the required proof-system simulation, not just a representation analogy.
Consider one non-tautological generated clause R and its selected source clauses.
For every pair state s, choose a source whose mask contains s. Its outside
residual is included in R. Its pair literals are all false on s, so weakening
that source yields R OR C_s, where C_s is the full two-literal clause excluding
s. For states outside D use the explicit domain clause C_s instead. There are
four states, hence at most four such weakenings. Resolve the two b-polarity
clauses for each value of a, then resolve the resulting a-polarity clauses.
This derives R in three resolutions. The reproducer checks every set inclusion
and every resolution equality for each non-tautological generated clause.

Retained old clauses require no inference. Deleting tautologies, duplicate
clauses or subsumed clauses adds none. On an UNSAT input this procedure ends
with the empty clause, so recording each actually retained generated clause
gives a resolution-with-weakening refutation with at most seven inference lines
per generated clause, in addition to input axioms. The constant-size derivation
does not depend on the width of R. Explicit line encoding costs O(L) per line.
Weakening can be removed without increasing resolution line count: propagate a
subclause at each line; at a resolution, resolve the propagated parents if both
pivots survive, otherwise propagate a parent subclause missing its pivot. The
final subclause of the empty clause is empty. This gives an ordinary resolution
refutation. No extension definitions or unproved semantic clauses are present.
The optional unused padding variable may occur in weakening lines of the
seven-step certificate. Restrict it to either Boolean value throughout that
proof: discard satisfied lines, and propagate or resolve the remaining
subclauses. Since no input clause mentions it, the original input is unchanged,
and the final empty clause remains. This removes the dummy variable without
increasing proof size, so it cannot evade a lower bound over the original input.

Consequently the known expander Tseitin resolution lower bound applies to this
*entire flat clause-only algorithm*, regardless of adaptive pair order or
syntactic subsumption. On a family with N graph vertices it must produce
2^{Omega(N)} proof lines, and hence cannot have polynomial total bit work in
the standard O(N log N) indexed input length. This rules out the desired
cumulative bound for this candidate, not merely one fixed pair order.

It does not rule out P=NP. In particular these Tseitin instances are affine
systems and Gaussian elimination solves them efficiently. Adding that operation
is a legitimate escape from this limitation; it is not implemented here and
would need its own all-input algorithm and complexity analysis on mixed
nonlinear constraints. Likewise retaining (1) as a nested circuit is outside
the clause-only proof-trace argument. Its next elimination cannot assume the
input is a CNF or that an entire compound gate has an x-independent mask.

## Exact remaining inequality for the factored version

Let C_i be the actual shared Boolean circuit after i projections. A valid
factored continuation must construct C_(i+1) representing exists(a,b) C_i,
with its construction cost W_i charged in standard bit operations, and finally
evaluate the closed circuit. The still-missing universal theorem is

    sum_i W_i + sum_i |C_i| <= L^c

for one fixed c and all CNF inputs, including arbitrary nonlinear overlaps.
Formula (1) proves only the first CNF-to-circuit step. General four-cofactor
substitution gives a correct next step but may multiply circuit size by four;
hash-consing identical gates gives no proven universal bound. Reusing the
one-step O(L) statement at every stage would therefore be an invalid inference.
Any successful approach must give a genuine nonclausal cumulative simplification
or another evaluated endpoint algorithm, with construction and readout costs.

## Reproducer and current outcome

Run `python research/p-equals-np/check_projection_cost.py` from repository root.
Observed exit code 0:

- 14,640 local truth comparisons, including every one of the 16 pair domains,
  against exhaustive existential evaluation; both flat and factored forms agree.
- 2,538 local non-tautological outputs have checked seven-step certificates.
- 80 adaptive full-endpoint tests: 30 YES, 50 NO; 5,161 raw candidates charged
  across all tested pair choices; 5,103 certificates checked in these runs.
- Cubic crossing family t=1,...,5 produces 1,8,27,64,125 flat output clauses.

The finite runs verify the implemented operation, not asymptotic complexity or
the cited external theorem. The elementary identity and certificate construction
are the analytic arguments; the literature supplies the known proof-system
lower bound. Outcome: an exact locally compressed projection was obtained, and
its flat repeated version has a decisive candidate-wide limitation. The nested
circuit escape lacks its required cumulative evaluation bound. No P=NP proof,
fluid logic device, or polynomial fluid simulator is supplied. The full goal
remains unresolved.
