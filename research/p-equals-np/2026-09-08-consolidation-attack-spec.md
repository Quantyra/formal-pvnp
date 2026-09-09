# Consolidation checkpoint: a rejected direct attack and the next decision gate

S3040 / S008 / E004. **PREIMPLEMENTATION SPECIFICATION / NO IMPLEMENTATION
AUTHORIZATION.** Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-consolidation-2026-09-08.md`.
Read with `INTEGRITY-CLAIMS.md` and the final
[signed-message note](2026-09-08-signed-messages-attempt.md). The user requested
consolidation and a novelty checkpoint, not another technical increment.
Nothing below is a new implemented solver, experiment or general theorem.

**Recommendation:** do not implement the direct Horn-head enumeration or
ordinary-resolution learning continuation as a proposed polynomial-time
general SAT attack. Its closest mechanisms are established, and known
resolution lower bounds contradict the proposed uniform progress criterion
specified below. No credible replacement general-case algorithm has yet been
identified. The different next action recommended here is one bounded
**circuit-extension capability audit**, not a new P=NP proof attempt or a
promise of efficient extended-resolution search.

## 1. What survived, and what is not novel

The Horn note provides exact boundary-aware closure, a compact evaluator,
private witnesses and a scoped original-tree cost bound. It does not control
the exponential vector of disjunctive head choices. The most relevant primary
precedents are:

| Mechanism | Closest verified primary source | Checkpoint consequence |
|---|---|---|
| Least Horn model and propagation | [Dowling–Gallier, Sections 1–2](https://www.seas.upenn.edu/~cis5110/Dowling-Gallier-Horn-sat.pdf) | The closure engine is classical. |
| Finite propagation unrolled into a polynomial layered circuit | [Bessiere–Katsirelos–Narodytska–Walsh, Section 4, Theorem 2/Lemma 4](https://arxiv.org/pdf/0905.3757) | The local Horn compiler is an application/reformulation of an established technique, not an identified new compilation paradigm. Their consistency-checker hypotheses are not a general SAT evaluator. |
| Exact disjunctions of Horn/renamable-Horn theories | [Boufkhad et al., *Tractable Cover Compilations*, Sections 1,3–4](https://www.ijcai.org/Proceedings/97-1/Papers/020.pdf) | Head-choice OR is a particular tractable-cover construction. Cover discovery/size must be paid for. |
| Clause learning as stored explanations of failed assignments | [Beame–Kautz–Sabharwal, Sections 2.4 and 3.5, Proposition 4](https://www.cs.cornell.edu/~sabhar/publications/learnJAIR04.pdf) | Decision-only Horn-guided learning sits within established DPLL/clause-learning reasoning when explanations use ordinary resolution. |

There is no identified publication-level general-case advance in renaming
these mechanisms. The retained contribution is careful local formulation,
explicit scope/cost tests and negative evidence against several proposed
uniform invariants. The existing finite corpus contains sixteen distinct
small general formulas, not evidence for a worst-case theorem; adaptive
selection lost its total charged metric against static degree on every one.

Do not next try to make an exact polynomial-size OR of ordinary Horn messages
for all models. The familiar independent complementary-pair relation already
has 2^k models whose pairwise coordinatewise meets violate a pair. An ordinary
Horn relation contained in that relation can contain at most one of these
models; existential Horn auxiliaries preserve meet closure. An exact cover
therefore needs 2^k such pieces. This is a checkpoint application of the
existing pair examples and meet property, not a new lower-bound claim. It
does not apply to renamable-Horn covers in general: an appropriate polarity
change makes these particular complementary pairs Horn. Nor does it obstruct
finding a single witness. Decision-only pruning is the correct direct route
to assess next, rather than insisting on a full all-model cover.

## 2. Concrete deterministic decision-only candidate, before coding

Call the candidate **Horn-guided chronological search with resolution
explanations**. It introduces no extension variables. Its entire state is:
the original canonical signed CNF F; an append-only list D of original and
learned clauses; the original-variable decision/propagation trail; a DFS
stack; and a DAG of explicit resolution proof records. No semantic cache,
SAT oracle, free model count or ignored unsuccessful compilation is allowed.
The deterministic rules would be:

1. Relabel variables densely and fix clause IDs and literal order. At each
   DFS node restrict all clauses in D by the current trail, paying the full
   scan. Extract the clauses with at most one remaining positive literal.
2. Compute their least Horn closure with the trail assignments respected.
   Scan rules in clause-ID order; for each first derivation store its actual
   source clause as reason. Preserve the reason DAG, rather than merely the
   final truth bits. A conflict is an empty clause, a forced false trail bit,
   or a triggered false-head rule.
3. On conflict, use reverse-trail resolution with those reason clauses until
   the resulting clause involves decisions only. Store the clause and its
   derivation; discard a duplicate only after exact canonical literal-list
   comparison. Return failure from the current subtree. A cached clause can
   be used only as the explicitly stored consequence it is; there is no
   unverified claim that two residual functions are equivalent.
4. If there is no Horn conflict, extend the trail by forced true variables,
   and set other unassigned variables false to obtain the Horn least-model
   candidate. Check that complete assignment against every original clause
   (and D). If it satisfies them, return its original-variable witness.
5. Otherwise choose the lowest-ID violated clause, and its lowest-ID still
   unassigned positive head. Branch on that original variable, true first
   then false, using chronological DFS. A violated clause cannot be one of
   the satisfied Horn residuals; it has at least two remaining positive
   heads. No complete head-choice vector is supplied in advance.
6. If both children fail, resolve their blocking explanations on the branch
   variable to obtain the parent's blocking clause. If a returned explanation
   already blocks the parent without that variable, use it directly. Continue
   until a witness is found or the root is blocked by the empty clause.

There are no restarts or learned-clause deletions in this specification.
Every explicit branch fixes a previously unassigned original variable, so
DFS is finite. Learned clauses are consequences of F and cannot delete a
model. Horn closure derives only forced literals in its current context;
least-model guesses of unforced false bits are used only for checked witness
proposals, never as forced facts. The two Boolean branches cover every
remaining model. Hence a returned assignment is a verified YES witness and
exhausted root search is a valid NO with a resolution refutation. This is
ordinary finite completeness, not a polynomial termination guarantee.

This is a fully specified classical-style candidate, not a claim of novelty.
The specification uses decisions on original variables so that its proof
power is unambiguous: Horn reasons are unit-resolution derivations under the
trail; learned explanations and branch combination are ordinary resolution.
The proof DAG shares prior derivations, but it does not change the proof
system. Adding fresh gate definitions later would be a different candidate.

## 3. Cost ledger, including discarded work

Let L be total binary input length and N the original variable count. Let
V be the number of processed search nodes, D_t the stored clause-bit volume
at node t, and R_t the stored proof/trail/cache-bit volume. The ledger must
include all of the following, not merely successful Horn evaluations:

| Operation | Required charged work/storage |
|---|---|
| Restriction and Horn extraction | Every original/learned clause and literal scanned; each temporary residual and reason reference built. |
| Closure and witness proposals | All failed rounds, reason construction, candidate assignment creation and complete original-CNF verification. |
| Decisions/backtracking | Clause/head selection, trail copies or undo entries, rejected branches and stack manipulation. |
| Learning | Every resolution step and its literal manipulation; canonicalization; duplicate lookup/comparison even for discarded clauses; proof-reference bit lengths. |
| Cache/provenance | All allocated records, retained witnesses/reasons and namespace/context labels; nothing gets free semantic equality. |
| Termination | Actual checked witness or explicit root refutation, including reconstruction/output. |

Simple deterministic list scans suffice for each operation; a loose bound
has the form poly(N,L) times a sum of polynomial functions of D_t+R_t over
all visited nodes. That is not a polynomial bound in L unless the visits,
database/proof growth and discarded work are themselves controlled. If an
implementation later uses hashing, deletion, restarts or a different cache,
their construction, comparisons, retention and replay costs must be added.
No such optimization is presumed by this preimplementation document.

## 4. A specific, non-oracular progress hypothesis—and why it fails here

The proposed cumulative invariant would be a **certified frontier-mass
contraction**, not the statement "there are polynomially many states."
View the deterministic DFS as splitting disjoint partial-assignment cubes.
The pending frontier, including the active cube, represents complete Boolean
assignments not yet removed by a checked conflict explanation. A cube fixing
d variables has weight 2^(N-d). Refine cubes as necessary to record forced
literal exclusions; each exclusion must carry the already specified
resolution explanation. Splitting alone preserves total frontier weight;
certified pruning decreases it. This is a potential for analysis, not an
oracle telling the solver how many satisfying assignments remain. In
particular it is not the set of models of the original input, which would
be vacuously empty on UNSAT inputs.

**Proposed lemma CF(d), now rejected for this candidate:** there is a fixed
constant d such that, from every reachable nonterminal checkpoint of every
input of length L, within at most p(L)=(L+2)^d further actual bit operations,
including all learning/cache/proof work, the specified algorithm either
returns a checked witness, exhausts the certified frontier with its root
refutation, or removes at least a 1/p(L) fraction of the then-current
frontier weight. Any bookkeeping that represents these cubes must also fit
the charged block; partial work cannot be reset between checkpoints.

This has an exact measurable quantity and a concrete counterexample target.
If true, the initial weight at most2^N would fall below1 after O(N*p(L))
nonterminal blocks. Integer weight then forces exhaustion, giving a
polynomial O(N*p(L)^2) total bound, including certificate generation. It
would handle both outcomes without a separate UNSAT oracle. The lemma is
not assumed by any proposed operation.

But this cannot be the general-case lemma for the candidate above. Its
NO certificate is an ordinary resolution refutation of size at most its
charged bit work. [Ben-Sasson–Wigderson, Theorem 4.4 and Corollary 4.5](https://people.inf.ethz.ch/emo/SatSem05/Papers/BensassonWidgerson01.pdf)
give exponential resolution length for odd-charge Tseitin contradictions
on connected 3-regular edge-expander families. These are bounded-width
CNFs with linear literal-occurrence size in the graph size q; with explicit
binary variable IDs the input length is O(q log q), while the resolution
lower bound is 2^{Omega(q)}. Thus no fixed d can make CF(d) hold uniformly
for this ordinary-resolution candidate. This is imported proof-complexity
evidence, not a new lower-bound proof and not a conclusion about all SAT
algorithms, unrestricted extensions or P versus NP.

This discriminator is worth applying before easy examples because it attacks
the exact certificate class and all choices of branching/ordinary conflict
learning, not one poor ordering or an unlucky random sample. The stop-loss
has already triggered at the literature/capability level: **do not code this
candidate in order to seek a universal polynomial bound.** Heuristic SAT
engineering would be a different goal requiring explicit authorization.

## 5. One different next action, with a bounded acceptance gate

No credible new general-case algorithm is currently justified by these
artifacts. The recommended different action is one preimplementation
**circuit-extension capability audit**, with a single contract artifact as
its deliverable. It must not quietly become another implementation or a
claim that short extended-resolution proofs can always be found quickly.

The finite allowed vocabulary for the audit is fresh, acyclic binary AND,
binary OR and unary NOT gate definitions, plus binary resolution. Inputs a,b
of a new gate must be original variables or already introduced gate variables;
g must be fresh. The exact defining clauses are:

    g <-> (a AND b):
        (NOT g OR a), (NOT g OR b), (g OR NOT a OR NOT b);
    g <-> (a OR b):
        (g OR NOT a), (g OR NOT b), (NOT g OR a OR b);
    g <-> NOT a:
        (g OR a), (NOT g OR NOT a).

The sole logical inference, besides introducing a complete fresh definition,
is resolution of (C OR v) and (D OR NOT v) to (C OR D). Literal/identical-clause
deduplication is syntactic only. No other macro, semantic-equivalence test,
projection rule, parity axiom or SAT oracle is silently permitted; any proposed
macro must give its expansion in these rules and charge for that expansion.
One-sided gate implications are not accepted as complete definitions.
Fresh gate names, acyclic dependencies and full definitions give a unique
extension of every original assignment. A SAT answer must still be checked
on the original CNF; a NO answer requires an explicitly checkable refutation
using only the permitted definitions and inference rules. Merely storing
the original SAT predicate as one circuit is not projection, evaluation or
proof search. These are standard definitional extensions, not a novelty claim.

The one audit must deliver:

1. The exact allowed gate definitions and inference operations, input/output
   relation and private-variable scoping. Identify whether each proposed
   useful macro expands to polynomial-size **ordinary** resolution over the
   original input or genuinely uses the stronger extension discipline.
2. A deterministic, non-oracular rule for generating any proposed macro or
   extension, with total gate/edge/bit/proof-search cost, including failed
   candidates and witness/definition checking. "Choose a useful extension"
   or "find a short proof" does not satisfy this requirement.
3. One precise new cumulative lemma tied to that operation, plus a primary
   literature comparison and a family that would refute it. It must survive
   the ordinary-resolution obstruction without depending only on a known
   Gaussian-elimination solution of a parity family or another tractable
   subclass. A general-purpose operation with a constructive generation
   bound is required before an implementation proposal can be considered.

**Acceptance/stop-loss:** finish after that one contract and capability
comparison. If the macro is merely resolution with a renamed cache, reject
it by the present discriminator. If it assumes polynomial extended-proof
length/search, unpaid circuit evaluation or free existential projection,
equivalence/proof search, or unbounded auxiliary construction,
mark the operation unresolved and do not implement it. If no operation
passes, report that no credible next general-case attack has been identified;
do not launch a larger benchmark or substitute a special-case success.
Passing this audit would authorize at most a separately reviewed technical
proposal, not a P=NP claim. This recommendation is deliberately an audit
decision, not an invented alternative general algorithm.

## Consolidated decision

The exact Horn evaluator survives as a classical tractable mechanism with
careful local accounting. Polynomial exact ordinary-Horn covers are not a
general solution; decision-only ordinary-resolution learning also cannot
support the desired uniform polynomial invariant. The most responsible
checkpoint outcome is **NO-GO for the direct implementation, GO only for
the bounded capability audit above**. No substantive general-case novelty
or successful full P=NP route is claimed, and the overarching research goal
is not marked achieved.
