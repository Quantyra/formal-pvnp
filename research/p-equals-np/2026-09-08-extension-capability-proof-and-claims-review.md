# Extension capability: proof and claims review

2026-09-08. S3040 / S008 / E004, baseline 95637c9. Reviewed the final
[capability audit](2026-09-08-extension-capability-audit.md) against the
consolidation Section 5 vocabulary. This same harness reviewer covers the
two lenses below; they are not two independent reviewers. The source/complexity
audit is separate. No code, benchmark, formal module or build was involved.

## Proof-adversarial lens — GO for the bounded result and stop decision

The generator is a legal acyclic definitional extension. Its only free inputs
are the original assignment variables. For each multihead clause, the prefix
gates select exactly the first true head, or the first head when none is true.
Single-head and false-head cases are handled separately. No existentially
free selector variables or answer-dependent choices are inserted. The shared
prefixes and each layer's antecedents have explicit linear-in-occurrences
construction; the N closure layers give the stated quadratic gate/wire bound
in binary input length. Sequential reference handling admits the conservative
polynomial bit bound stated in the audit.

Constants obey the allowed rules: from t iff NOT x_1 and z iff (x_1 AND t),
resolve the definition clauses to derive NOT z; from o iff NOT z derive o.
There is no constant axiom or unsupported fresh input. N=0, empty clauses and
empty formulas are handled directly before this construction. Aliased singleton
inputs preserve the previously generated IDs and introduce no cycle.

For fixed input x the selectors choose one Horn strengthening. Its iteration
starts at zero, is monotone and reaches the least fixed point by N rounds.
Consequently absence of a false-head violation gives a model W(x) of that
strengthening and hence of F. Conversely F(x) implies that x satisfies the
chosen strengthening, bounds every closure layer from above, and prevents
false-head violations. This proves the two implications used in the audit
and the existential satisfiability equivalence. It does not prove pointwise
equality between F and accept. The supplied disjunction example correctly
shows acceptance with W(x) different from the original input. No original
variable is constrained to equal its witness-output gate.

The Section 3 macro uses the actual gate clauses, rather than a search which
ignores them. Its induction is sound:

* Under a positive activation assumption, full AND definitions expose the
  antecedent closure bits. Prior invariants imply their original input bits.
  For a single head, assuming that head false conflicts with the original
  clause. For a later selected head its selector AND directly forces that
  head true. For the first selected head, assuming it false forces the
  fallback prefix and all heads false, again conflicting with the original
  clause. Facts use the derived true constant.
* For a carry wire and an original head assumed false, the established
  activation/carry subclauses force every OR input false or produce an
  earlier conflict. The full OR chain then conflicts with the assumed carry.
* At the final layer, a false-head activation forces all its original
  antecedent bits true and conflicts with its all-negative clause. The
  derived negative activation units force bad false and accept true, unless
  an earlier empty clause has already supplied a refutation.

Reverse reason elimination is legitimate binary resolution for these traces.
The final text requires syntactically consistent temporary assumptions and
explains why each actual obligation qualifies. Reasons are stored at first
propagation, so reverse order removes propagated literals without a cyclic
reason graph. The derived clause can be a strict subclause of the intended
invariant. Keeping that stronger clause preserves every later propagation
argument: it either forces the needed literal or conflicts earlier. No
weakening is required. The final output is explicitly either the accept unit
or the empty clause; the latter is not treated as a resolution derivation
of accept.

The polynomial ledger is sufficient. There are O(R^2) obligations on
V=O(R^2) variables, at most O(V) reverse-resolution steps per obligation,
and width at most 2V. Hence O(R^4) lines and O(R^6 log R) proof bits are
conservative upper bounds. The active propagation database contains only
the original/definition clauses and established target subclauses; retained
intermediate proof lines are not repeatedly promoted into search rules.
The stated loose O(R^12 log^2 R) bound permits sequential record lookup,
failed scans, copying, duplicate comparison and checking. It is a bound for
these predetermined propagation conflicts, not for finding useful arbitrary
conflicts or extensions.

The certificate transfer is correctly one-way and conditional on supplied
evidence. If the macro returns empty, F with its legal definitions is already
refuted. Otherwise its accept derivation supplies the unit needed to append
a given refutation of E_F AND accept. This creates a permitted extension
refutation of F with polynomial additional overhead. It neither constructs
that refutation nor bounds its length/search. Semantic correctness of the
witness map plus checking a concrete original-CNF witness suffices for a
YES output; the audit does not falsely claim a formal resolution derivation
of the fixed-point argument or of all of F(W(x)).

Section 4 genuinely permits resolution on both gate and original variables.
The initial FIFO now includes initial-initial pairs through the same insertion
routine used for new clauses. Canonical literal sets, both pivot orientations,
and exact comparison give finite exhaustive saturation. Its completeness
argument by the binary assignment tree uses resolution or retains a stronger
child blocking clause; it needs no weakening. Keeping tautologies is harmless
and is included in the 4^V literal-set count. Thus O(16^V) pairs and the
conservative poly(V,L) times 64^V work bound, including linear-list duplicate
search, are valid upper bounds. They are not lower bounds for this family.

The second stream enumerates original inputs and directly checks any W it
returns. Equal alternation pays for both streams; either exhausted answerless
stream now explicitly halts while the other continues. SAT eventually yields
a checked witness, and UNSAT eventually yields an empty clause from saturation.
Neither queue exhaustion nor failed trial inputs are relabeled as a NO
certificate. Finite completeness holds; no polynomial general search bound
has been demonstrated.

Requested corrections were the consistent-assumption qualification, the
accept-or-empty alternative without weakening, initial queue population, and
continuation after either stream exhausts. All four are present in the final
file. No substantive correction remains. Verification was symbolic inspection
of the actual derivation and ledger; no experiment was needed or run.

## Non-claims lens — GO WITH NOTES / STOP general continuation

The bounded positive result is a uniformly generated, polynomial acceptance
derivation or earlier refutation in the defined gate vocabulary, with the
explicit certificate-transfer consequence. This is more than a short circuit
description. It remains an application of definition/propagation techniques;
this review does not certify publishable novelty or a new proof system.

Unique extensions preserve the meaning of every input assignment; they do
not choose a good input. The acceptance implication cannot be used as a
free solver for its remaining existential query. Gate count, small local
definition width, polynomial proof checking and polynomial translation
overhead do not imply polynomial search or short certificates on all inputs.
Discarded work and the actual gate-using search are exposed rather than hidden
behind a useful-extension oracle.

The ordinary-resolution limitation of the earlier original-variable-only
candidate applies only to that comparator. Nothing here establishes a
polynomial simulation of proofs using E_F by original-variable resolution,
or a lower bound on this generated extension family. Conversely, escaping
that previous certificate description does not establish efficient stronger
reasoning. Both possibilities remain open in the stated scope.

The checkpoint's action is therefore correctly **STOP: the local macro passes,
but no general-case search operation passes the cumulative-cost gate**. No
implementation, further special-case sequence or benchmark is recommended
by this review. There is no P-versus-NP conclusion, whole-flow/physical-device
claim, formal route-final closure or publication authorization. The broader
objective remains unresolved; ending this single audit is not achieving it.
