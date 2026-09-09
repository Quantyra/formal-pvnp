# Support elimination: independent complexity and source review

2026-09-08. S3040 / S008 / E004. Reviewed the final `2026-09-08-support-elimination-attempt.md` in full. Harness only; no commits, pushes, code changes, numerical suites or planning edits.

## Classical source and exact decision operation

I independently verified [Davis and Putnam, A Computing Procedure for Quantification Theory](https://web.stanford.edu/class/cs357/DP60.pdf), Section4 RuleIII, printed page210, and the next page's instruction to return the result to CNF. The attribution is to its finite propositional elimination step, not to a new procedure, the entire first-order method or modern DPLL branching.

The existential resolution identity and witness lifting are correct for units, empty remainders, absent polarities and tautological resolvents. If a positive remainder is false, all negative remainders must be true; otherwise choosing the variable false satisfies its positive clauses. Reverse elimination has assigned every variable needed in those saved remainders. Thus the explicit procedure returns a witness or detects inconsistency without a counting oracle or an unevaluated existential query.

## Binary closure and corrected bit accounting

Width at most2 is preserved by elimination. The exact clause-universe bound is1+2n+4 binom(n,2)=2n^2+1. Therefore arbitrary cycles and graph density do not destroy polynomial closure. The stated algorithm is a valid positive decision-only result beyond the preceding tree-factor construction.

The initial indexed-deduplication bound was clarified during review. The final version batches O(n^4) candidates per variable, sorts their O(log(n+2))-bit keys and deduplicates by scanning. Sequential merge sorting, for example, realizes the conservative O(n^5 log^2(n+2)) multitape bit bound without unit-cost random access. The O(n^4 log(n+2)) candidate buffer and O(n^3 log(n+2)) retained witness records are now explicitly counted. Normalization and reverse verification add polynomial work; no optimal2-SAT claim is made.

For arbitrary CNF the normalized universe has at most3^n clauses and each stage at most9^n candidate pairs. Sorting, canonicalization, records and polynomially many stages fit the displayed poly(L,n)9^n upper bound. That bound would not follow from scanning an exponentially sized dictionary for every candidate; the final text explicitly uses sorting. It is a finite general algorithm, not a polynomial guarantee.

## Projected-CNF test

Full gate equivalences and an output pin give a width-at-most-three input with a unique satisfying extension exactly when OR_i(a_i AND b_i) holds. Eliminating all auxiliary variables first while keeping an exact auxiliary-free CNF must therefore represent that relation.

The2^m false assignments with one zero per pair force2^m distinct clauses. If the same implicate were false at two such assignments, it would remain false at their coordinatewise OR, for both positive and negative literals. That OR satisfies the relation, a contradiction. The matching expansion and its private falsifying assignments show essentiality and confirm that duplicate, tautology or subsumption removal cannot rescue that representation.

The lower bound is for the projected relation in auxiliary-free CNF after the specified auxiliary-first schedule. It does not restrict all variable orders, early decision, retained auxiliaries or shared Boolean circuits. The example is satisfiable by inspection and has a linear-size DNF, so the result is not a SAT or general representation lower bound.

## Shared residuals and remaining work

Keeping the conjunctions factored before their OR avoids the immediate CNF distribution. The general cofactor construction is also concrete: traverse the bounded-fanin explicit DAG, memoize old-node/bit restrictions, and form their OR. Its result computes existential elimination rather than deferring that operation to another solver. Reverse evaluation of stored branches gives a valid witness.

For reachable-node size S, the two-copy-plus-OR bound is valid as a one-stage upper bound. Repeating it is not a polynomial cumulative bound. Existing shared nodes need not be charged as new copies, but allocation, restriction traversals and reverse evaluations must all be counted. The candidate correctly supplies no universal growth lower bound from this upper recurrence and no automatic polynomial guarantee from hash-consing.

Fresh gate encodings of successive residual circuits reintroduce existential variables. Merely doing that cannot reuse a decreasing original-variable argument as proof of polynomial total work. A successful decision-only refinement would need an actual cumulative bound or another algorithm; computing exact weighted counts is not a prerequisite imposed by this review.

## Final verdict

GO for classical exact elimination and lifting, polynomial binary-CNF closure on cyclic graphs, the scoped projected-CNF obstruction and the explicit shared-cofactor alternative. INCOMPLETE for a polynomial cumulative bound on arbitrary3CNF or general polynomial SAT. The bit-accounting clarification is verified in the final candidate; no corrections remain. No all-SAT lower bound, exact-counting prerequisite or P=NP conclusion follows.
