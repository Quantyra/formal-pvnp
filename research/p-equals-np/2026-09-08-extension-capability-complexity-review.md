# Extension capability: independent source and complexity review

S3040 / S008 / E004; baseline 95637c9. Reviewed the saved
[extension capability audit](2026-09-08-extension-capability-audit.md), the
consolidation specification Section 5, and `INTEGRITY-CLAIMS.md`. This is an
informal source/complexity review of one frozen contract, not implementation,
formal verification, publication approval or a general complexity result.

**Verdict:** the generator, semantic witness map and polynomial acceptance
macro pass their stated local checks. The full gate-using search has no proved
polynomial cumulative cost. Its capability remains unresolved, rather than
refuted by the original-variable resolution lower bound. The correct next
action is STOP this route at the audit boundary, with no implementation or
replacement sequence of special-case examples.

## Exact operation and encoding

The selectors are functions of the original assignment: first true positive
head, defaulting to the first head when all are false. Their prefix chains
select exactly one head, without free selector inputs or advice. For each
fixed input they define a Horn strengthening of F. The N-round increasing
closure reaches its least fixed point; absence of a false-head activation
then gives a model W of that strengthening and hence of F. Conversely every
F-model selects heads it satisfies, bounds all closure bits above, and is
accepted. Therefore SAT(F) iff SAT(E_F AND accept), but F(x) and accept(x)
need not agree pointwise. The example F=x1 OR x2 at input 00 correctly
illustrates the difference.

The AND/OR/NOT definitions are complete equivalences, with fresh IDs in
acyclic construction order. Every original input has a unique extension.
The derived constants do not add unexplained unit axioms: from t=NOT x1
and z=x1 AND t one derives NOT z by resolving the two implications from z
against the NOT definition, and o=NOT z then yields o. Empty formulas,
empty clauses and N=0 are handled before that construction.

Shared prefixes, antecedents and binary aggregation chains give
S=O((N+1)(N+ell+1))=O((L+2)^2) gates and references. Dense labels have
logarithmic bit length in S. Sequential reference lookup and literal scans
fit the deliberately loose polynomial generator/evaluator bound. These
costs apply to one supplied input. They do not evaluate all inputs or find
an accepting one.

## Actual resolution macro and cumulative costs

The saved proof really uses definition clauses. Under the temporary
assumptions activation=true and selected original head=false, its AND gates
force the antecedent closure bits. Prior invariants imply the corresponding
original variables. For a later selected head, the selector itself forces
that head true. For the first selected head, its OR gate forces the all-heads-
false prefix, which conflicts with the original clause once its antecedent
is true. The single-head case conflicts directly with that clause.

For the next carry bit, assuming it true and its original variable false
forces every contributing activation and the old carry false; the OR chain
conflicts. Finally, each false-head activation conflicts with its original
all-negative clause. This derives NOT bad and accept, or an earlier empty
clause, from F and E_F.

Reverse-reason resolution eliminates propagated literals and leaves a
subclause of the negated assumptions. The note explicitly retains stronger
subclauses, including unit or empty cases. This is necessary because the
permitted vocabulary contains no weakening rule. Such subclauses suffice
in later traces: they either force the needed literal or already conflict.
Assumption units are not retained as axioms. The proof does not silently
substitute a semantic implication for a legal inference.

With R=L+2 and V=O(R^2), O(R^2) obligations and at most V propagation events
per obligation give O(R^4) resolution lines. Width at most 2V yields the
stated O(R^6 log R) proof encoding. Scanning the bounded active database,
storing reasons, copying clauses, and checking references in the explicit
polynomial proof volume fit O(R^12 log^2 R) as a loose sequential bit bound.
The distinction between the small active database and retained proof lines
prevents uncounted recursive proof expansion. No tight-runtime claim is made.

Crucially, accept checks only false-head violations. The macro F,E_F proves
accept does not need a resolution proof of N-round stabilization or of the
universal relation F(W(x)). Those are separate semantic arguments, and a
returned concrete W is checked against F. This resolves the potential gap
that would arise if accept additionally asserted an unproved fixed-point
condition.

Appending a supplied refutation of E_F AND accept after this macro gives an
extension refutation of F with polynomial transfer overhead. This is a real,
limited capability. It neither constructs the supplied refutation nor bounds
its shortest length or discovery time.

## Full search and the lower-bound boundary

The final search actually resolves on generated gate variables. It is not
the earlier comparator that ignored all gates. Its second stream fairly
saturates the fixed augmented clause database, while the first enumerates
original inputs and checks returned witnesses. Equal alternation of actual
bit-machine steps charges both computations. Queue exhaustion is correctly
not a NO answer; an empty clause is required.

Allowing both signs gives at most 4^V canonical literal sets, O(16^V) pairs,
and O(V16^V) pivot attempts. Sequential scans of at most 4^V stored clauses
per attempt give the stated poly(V,L)64^V conservative upper bound, with
polynomial-size encoded IDs and a sequential FIFO queue. Initial proof
records add polynomial overhead. Enumeration separately costs
2^N poly(L). These estimates establish finite termination and expose the
uncontrolled work. They are upper bounds, not evidence that this particular
family requires exponential work.

Original-variable resolution lower bounds do not automatically transfer
through E_F. Substituting formulas for gate variables can destroy succinct
sharing and clauses; constant-width definitions do not provide a polynomial
proof translator. No such translator, lower bound, or universal speedup for
this fixed generated extension family was established. The unresolved issue
is actual cumulative search work before the first verified answer, not merely
how many gates were generated or whether a short proof might exist.

## Primary-source checks

* [Cook–Reckhow, Definition 1.5 and Section 4](https://www.cs.utoronto.ca/~sacook/homepage/cook_reckhow.pdf): p-simulation requires a polynomial-time translation of whole proofs. Definition 4.1 and Proposition 4.2 specify fresh definitional extensions and soundness by extending assignments. Section 1 distinguishes polynomial proof bounds from checking. These sources support the vocabulary and distinctions; their extended-Frege results are not a theorem identifying this fixed generator with every extended-resolution proof or furnishing its search algorithm.
* [Beame–Kautz–Sabharwal, Section 3.5, Proposition 4](https://www.cs.cornell.edu/~sabhar/publications/learnJAIR04.pdf): conflict clauses have resolution derivations from initial and previously derived clauses, by eliminating reason variables. The local macro supplies specific conflicts and a cost ledger. This precedent does not promise useful conflicts at arbitrary states.
* [Bessiere et al., Section 4, Lemma 4](https://arxiv.org/pdf/0905.3757): layering propagation is an established construction. Its consistency-checker setting is distinct from a general SAT decision theorem. The local generator and macro are applications of these techniques; no new proof-system or publication-level novelty is verified here.
* [Atserias–Müller, introduction and Theorem 1](https://www.cs.upc.edu/~atserias/papers/automating-resolution-np-hard/automating-resolution-np-hard.pdf): Resolution automatizability is time polynomial in input size plus shortest refutation length, and their polynomial automatizability obstruction is conditional on P not equaling NP. This concerns Resolution, not the present generated-extension subclass or unrestricted extended resolution. It is context for separating search from checking and proof length, not a lower bound imported against this candidate.

The source audit was targeted, not exhaustive. No claim is made about all
extended-resolution algorithms, current universal proof-length bounds, formal
Lean verification, or P versus NP. The useful result is a checked local
certificate-transfer macro; the general search bridge remains UNRESOLVED.
No further benchmark, implementation or special-case continuation is warranted
by this contract. A change of route would require a separately authorized,
concrete new research obligation rather than another example under this one.
