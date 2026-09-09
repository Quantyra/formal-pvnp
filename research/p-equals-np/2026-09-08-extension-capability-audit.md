# Extension capability audit: canonical Horn choices and an acceptance proof

S3040 / S008 / E004. Single bounded audit under `INTEGRITY-CLAIMS.md` and
the [consolidation specification](2026-09-08-consolidation-attack-spec.md),
Section 5. Planning gate in Quantyra-Planning:
`docs/research/pvnp/literature-review-extension-capability-2026-09-08.md`.
No implementation, experiment, publication or general complexity claim.

**Decision: STOP / no implementation recommendation.** The specified generator
does support a polynomial, legal resolution derivation of its acceptance bit
from F and fresh definitions, or an earlier empty clause. It is more than
merely writing down a circuit.
However, this implication does not find an accepting input. The power and
search cost of resolution using the generated gates remain unresolved; the
ordinary-resolution lower bound from the checkpoint cannot be transferred to
them. No operation passes the checkpoint's general polynomial-search gate.

## 1. Frozen generator and actual input semantics

Let F be a normalized CNF of binary length L on N distinct occurring variables,
relabeled densely.
Remove repeated literals and tautological clauses syntactically. Check an
empty clause immediately; an empty conjunction is true. Unused variables may
be set to zero in a returned witness. Handle N=0 directly. Below N>=1.

Write clause m as A_m -> OR(h_m1,...,h_mq), where A_m is the conjunction of
variables occurring negatively. Fix original clause order and increasing head
IDs. The only free inputs are the ORIGINAL variables x. In particular a
fresh head-selector input is not a permitted definitional extension.

For q>=2 define gates for

    d_mj(x) = AND_(i<=j) NOT x_hmi,
    s_m1(x) = x_hm1 OR d_mq(x),
    s_mj(x) = d_m,j-1(x) AND x_hmj,  j>=2.          (1)

Exactly one selector is true: the first true positive head, or the first
head if all heads are false. For q=1 use selector 1. For q=0 retain the
false-head constraint. These are functions of a supplied assignment, not a
rule which somehow knows a satisfying assignment.

Construct the selected Horn closure symbolically, starting with all bits 0:

    c_v^0 = 0,
    a_m^t = AND_(u in A_m) c_u^t,
    r_mj^t = s_mj(x) AND a_m^t,
    c_v^(t+1) = c_v^t OR OR_(m,j:hmj=v) r_mj^t,
                    0<=t<N.                       (2)

For a single head the activation may simply be a_m^t. False-head clauses
contribute no positive activation. Set

    bad(x) = OR_(m:q=0) AND_(u in A_m) c_u^N,
    accept(x) = NOT bad(x),
    W(x) = (c_1^N,...,c_N^N).                      (3)

Acceptance checks only absence of a false-head violation. There is no
additional gate asserting that c^N is a fixed point or that F(c^N) is true.
Those facts will be proved semantically and the returned witness will also
be checked directly against F.

Expand each nonbinary AND/OR in listed order into a binary chain; alias a
single input. Every new gate uses exactly the complete AND/OR/NOT definition
clauses in the consolidation specification. For constants introduce
t=NOT x_1, z=x_1 AND t, o=NOT z. Thus z=0 and o=1 follow from definitions;
they are not extra axioms. Their units have constant-size resolution proofs.
All gate IDs are fresh and follow construction order. Let E_F be the complete
definition set. It has a unique extension for EVERY original assignment.

There are S=O((N+1)(N+ell+1))=O((L+2)^2) gates and wires, where ell is the
literal-occurrence count. Shared antecedents and prefix chains are actually
generated once at the specified layer, not expanded as formulas. A sequential
record-list implementation constructs their O(S log(S+2))-bit encoding in
O((L+2)^4 log^2(L+2)) bit work. No semantic hash or inferred equivalence is
used. Evaluating the same explicit circuit at one supplied input has the
same conservative bound, including reference lookup and original-CNF witness
verification. This is a generator/evaluator bound, not a search bound.

## 2. Exact semantics and why acceptance is not a free witness input

For a fixed x, (1) selects one Horn strengthening H_s of F. Iteration (2)
is increasing. Any nonfixed round adds a variable, so N rounds reach its
least fixed point. Hence

    accept(x)=1  =>  H_s(W(x))=1  =>  F(W(x))=1.     (4)

Conversely, if F(x)=1, the selected head is true whenever its antecedent is
true. Thus x satisfies H_s. Every closure bit is bounded above by x; no
false-head antecedent can fire. Therefore

    F(x)=1 => accept(x)=1,
    SAT(F) <=> exists x accept(x)=1
           <=> SAT(E_F AND accept).                (5)

The successful output W(x) need not equal x. For F=(x_1 OR x_2), input
(0,0) selects the first head, closure returns (1,0), and acceptance is true.
Thus (5) is not pointwise equivalence F(x)=accept(x). Neither x=W(x) nor
acceptance at a predetermined input is silently asserted. With genuine free
head inputs instead of (1), one would have a different existential search
space; adding those inputs is not a definition of the original inputs.

## 3. A legal polynomial gate macro: deriving acceptance under F

This part uses the actual definition clauses in resolution. It does not
replace a semantic implication by a new proof rule.

The elementary trace conversion used below is explicit. Run deterministic
unit propagation from a stated clause database plus a syntactically consistent
set of temporary assumption literals. All uses below satisfy this condition:
they assume one generated literal, or a generated closure/activation literal
and the negation of a distinct original input. Contradictory assumptions
alone are not a license to derive a tautology from an empty database.
Store the original clause justifying each first propagated literal. If a
conflict occurs, resolve the conflict clause backwards with reasons in
reverse propagation order. The result is a subclause of the negated
assumptions, derived from the database by binary resolution alone. There
are at most as many resolutions as propagated variables. If the result is
stronger than the intended clause, KEEP that subclause; no weakening rule is
being introduced. A unit or empty result is handled as such. Temporary
assumption units never become permanent axioms. This is the standard conflict
explanation mechanism; the argument is the reverse-reason elimination just
given, not an oracle for finding a contradiction.

Use original clauses, E_F, the constant units, and previously obtained
subclauses of the following invariants as the active propagation database:

    NOT c_v^t OR x_v,
    NOT r_mj^t OR x_hmj.                            (6)

The base c^0=z is covered by the derived unit NOT z. At each layer derive
activation invariants before the next carry invariants:

* To derive the activation invariant, temporarily assume r_mj^t and
  NOT x_hmj. The AND definitions force a_m^t and its c_u^t inputs; prior
  invariants force every x_u in A_m. For a single head, its original clause
  now conflicts. For j>=2 the selector definition immediately forces x_hmj.
  For the first head of a multihead clause, s_m1 is true and x_hm1 false.
  Its OR definition forces d_mq; the prefix AND/NOT definitions force ALL
  original positive heads false. Its original clause again conflicts.
  Empty antecedents use the derived constant 1. This is a concrete
  propagation trace, not enumeration of possible head assignments.
* To derive the next carry invariant, assume c_v^(t+1) and NOT x_v.
  Previously derived subclauses of (6) force c_v^t and all incoming
  activations false (or already conflict). The OR chain then forces
  c_v^(t+1) false. Reverse the trace as above.

After N layers, temporarily assuming a false-head activation forces all its
c_u^N bits true, hence all original x_u true. Its original all-negative
clause conflicts. Extract the negative activation unit. These units force
bad false and hence accept true through its definitions. An earlier empty
clause is already a valid refutation; otherwise this constructs

    F, E_F |-resolution C,
        where C is {accept} or the empty clause.    (7)

Equation (7) separates two possible proof outputs; it adds no inference rule.
An empty clause need not be weakened into accept. The macro proves ONLY this
alternative. It does not purport to derive a general resolution
proof of the fixed-point counting argument or the full relation F(W(x)).
The semantic proof of (4), followed by direct checking of a concrete W,
suffices for SAT output. This distinction avoids using semantic convergence
as an unexpanded inference rule.

For an explicit loose cost ledger put R=L+2 and V=N+S=O(R^2). There are
O(R^2) propagation obligations, each with at most V propagated variables.
For propagation, scan only F, E_F and the O(R^2) target subclauses already
established; intermediate proof lines are retained for proof checking, not
repeatedly installed as new search heuristics. Each trace contributes O(V)
resolution lines of width at most 2V. Total proof-line count is O(R^4),
encoded proof volume O(R^6 log R). Full sequential lookup, clause copying,
canonical deduplication, failed scans and explicit proof checking fit the
deliberately loose O(R^12 log^2 R) bit bound. Constants are uniform, not
dependent on the satisfiability of F. Stronger subclauses and early conflicts
only shorten this procedure. This accounts for discarded trace work too.

One concrete consequence is certificate transfer. If the macro has not already
refuted F, a refutation of E_F AND accept can be appended after its acceptance
derivation to refute F using permitted fresh
definitions and resolution. The transfer overhead is polynomial and explicit.
It supplies neither that refutation nor a short or efficiently discoverable
one. Starting a search with accept as an unexplained unit would omit (7).

## 4. Full gate-using search: specified, finite, and not bounded polynomially

To assess the permitted capability rather than deliberately ignore the
gates, fix the following deterministic general procedure. After the macro,
return NO if it produced an empty clause. Otherwise run two streams with
equal alternation of elementary bit-machine steps:

1. Enumerate complete original inputs in lexicographic order. Evaluate
   (1)-(3); for each accepting input check W against F and return that original
   witness. Pay every rejected input and every gate/reference scan.
2. Saturate the original clauses, E_F and all retained macro proof clauses
   by binary resolution, USING gate variables as well as original variables.
   Canonical clauses are sorted literal sets. Keep tautological clauses too,
   so their exclusion is not an extra rule. For each new clause enqueue its
   pairs with all currently retained clauses. Process the FIFO queue in
   insertion order, each variable in ID order and both complementary pivot
   orientations in fixed order. Append a new resolvent only after full
   literal-set comparison against the stored list; retain its parent/pivot
   proof record. Duplicate attempts are charged, not forgotten. Return NO
   only upon the empty clause. Queue exhaustion alone is not a NO answer.

Initialize the FIFO by inserting the initial database clauses, in original,
definition and proof-record order, through this same exact deduplication and
pair-enqueue procedure. Thus initial-initial pairs are included too.

No new definitions are introduced after the frozen generator. Gate-clause
reasoning is unrestricted within these specified binary-resolution steps;
it is not the old original-variable-only conflict rule. Equal alternation
means paying both streams, not invoking free parallel computation. If
either stream exhausts without an answer, it halts and the other continues;
this includes enumeration exhausting on UNSAT while saturation continues.

Correctness: fresh definitions preserve all F-models; (7) is an actual proof.
Thus an empty clause is a valid extension refutation. On SAT, (5) ensures
enumeration finds a checked witness. On UNSAT, exhaustive resolution over
the database eventually finds the empty clause. Completeness here can be
seen directly by the finite binary assignment tree: at a false leaf take a
falsified input clause, and combine two child blocking clauses by resolving
on the branch variable, or retain a child clause already blocking the parent.
Those resolution steps are among the saturated pairs. This establishes
finite both-outcome termination, not efficiency.

There are at most 4^V canonical literal sets, allowing both signs. The queue
has at most O(16^V) pairs; at most O(V*16^V) pivot attempts. List deduplication
may scan 4^V clauses per attempt. Thus poly(V,L)*64^V is a conservative
finite bit-work upper bound for saturation, including unsuccessful attempts,
queue construction, IDs and proof records. Enumeration costs
2^N*poly(L), separately. These are upper bounds, not demonstrated exponential
lower bounds for this generated family. No benchmark has been run.

## 5. Capability verdict, exact missing step and stop decision

The new macro uniformly gives a polynomial acceptance derivation or an earlier
refutation in the generated vocabulary. It legally enables the certificate transfer following
(7). That is the bounded positive result of this audit. It is an application
of known propagation/definition techniques, not a claimed new proof system
or a polynomial decision procedure.

The precise unresolved algorithmic quantity is the total bit work of the
gate-using search in Section 4 up to its first checked witness or empty clause,
including every preceding queue entry, rejected input, duplicate comparison
and stored proof. A useful general lemma would need to produce a successful
search schedule with a uniform polynomial bound on that quantity, not merely
assert existence of polynomial-size extension proofs or count the generated
gates. For the frozen schedule, even such a scheduling theorem is absent.
We have no independently justified contraction, selection or amortization
lemma for it. Calling this absence a new 'polynomial states' conjecture would
only rename the missing SAT search. The acceptance implication itself is
not such a lemma: (5) is still an existential query over all original inputs.

An evaluator-only DFS using falsified ORIGINAL clauses as explanations would
fall under the prior ordinary-resolution obstruction. That is merely a
comparator. It does NOT polynomially simulate arbitrary proofs using E_F,
and does not reject the gate-using procedure above. Conversely, bounded
gate count and constant-width defining clauses do not establish stronger
efficient search. No lower bound or polynomial simulation for this particular
generated extension family is established in this audit.

The closest primary precedents clarify the scope:

* [Bessiere et al., Section 4, Lemma 4](https://arxiv.org/pdf/0905.3757)
  explicitly unroll propagation into layers. The generator uses this familiar
  pattern; their consistency-checker theorem is not a general SAT search
  theorem and is not imported as one.
* [Beame, Kautz and Sabharwal, Section 3.5, Proposition 4](https://www.cs.cornell.edu/~sabhar/publications/learnJAIR04.pdf)
  derives conflict clauses by resolving reason clauses. The macro above
  specifies which conflicts occur and counts their construction; it does not
  assume a useful conflict can always be found for arbitrary search states.
* [Cook and Reckhow, Definition 1.5 and Section 4](https://www.cs.utoronto.ca/~sacook/homepage/cook_reckhow.pdf)
  distinguish polynomial proof simulation from the availability of extension
  rules. A polynomial proof translator is a separate obligation, not a
  consequence of constant-size local gate definitions.

**Single acceptance decision:** the legal generator and macro pass their
local capability checks, but the proposed general-case continuation does not
pass the cumulative search-cost gate. Mark that bridge UNRESOLVED and STOP
this audit. Do not implement the saturation procedure, launch a special-case
chain or infer that known ordinary-resolution lower bounds apply to its
extensions. No credible new general polynomial attack is justified by this
audit; the overarching goal is not achieved.
