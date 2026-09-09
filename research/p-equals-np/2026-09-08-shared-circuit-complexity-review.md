# Shared-circuit and controlled-packet complexity review

2026-09-08. S3040 / S008 / E004. Independent harness reviewer; informal mathematical and algorithmic review. No Lean verification or publication.

## Scope and current status

Reviewed the local nonclausal literature gate, shared-circuit endpoint attempt and its executable, plus complexity claims in the packet-gate and source-certificate attempts. The factor-aware extension has now been inspected and independently exercised. Verdict: GO for the explicitly bounded informal results; INCOMPLETE for the uniform polynomial-time SAT endpoint and the P=NP objective. No mathematical blocker to retaining this research increment was found.

## Verified raw-rule findings

The Boolean quotient F2[x]/(x_i^2+x_i) makes every represented value Boolean. The rule E_x(S)=S0+S1+S0*S1 is pointwise OR and hence exactly existential projection. Iterating it gives the SAT decision bit, but exactness alone supplies no polynomial work bound. The displayed mixed nonlinear projection for xy+z=0 and xu+v=0 is correct on every outside assignment; XOR alone fails with two witnesses.

The specified raw binary-DAG normalizer has a valid exponential-work obstruction on the equality family in the all-x-before-y order. Distinct full minterm functions require distinct roots; the described construction generates them. The argument is about this exact construction trace, not a minimal circuit representing its output. Paired ordering defeats the example. No conclusion about all orders or stronger rewrite strategies follows. An exponential upper recurrence alone would not have proved a lower bound; the explicit generated-root argument is the relevant evidence.

Cumulative nodes and cofactor calls account for work discarded before the final constant result. They remain operation counters, not standalone bit-time measurements. The note correctly keeps variable-support, node-index and deterministic data-structure overhead separate. No arbitrary Boolean-equivalence oracle is provided. Testing zero in the Boolean quotient for a satisfaction indicator would solve UNSAT; ordinary unrestricted-field PIT does not provide such a test.

## Primary-source boundary

[Miksa--Nordstrom](https://arxiv.org/html/1505.01358v1), section 1.1 and Theorems 4.9--4.10, use expanded-monomial proof size and impose the stated expander hypotheses. They support retirement of cumulative explicit-support polynomial-calculus saturation. They do not supply a DAG gate-count lower bound.

[Grochow--Pitassi](https://arxiv.org/html/1404.3820v1), Definition 1.1 and the introductory representation discussion, represent algebraic certificates by circuits. This supports keeping representation measures distinct. Certificate existence, certificate verification and deterministic efficient certificate search are separate obligations; the local candidate does not claim their equivalence. The shared quotient-circuit search here is not asserted to be their IPS theorem.

## Packet/source computational scope

The packet model performs O((L+n+1)2^n) gate slots for its explicit exhaustive SAT microprogram. Polynomial-size loop descriptions and workspace do not execute exponentially many slots in polynomial Turing time. Its integrated damping estimate is controller-specific, not a universal energy or computation lower bound. Nonlocal packet sensors, distributed actuators and the boundary-driven transport channel remain added assumptions. The finite channel latency restriction is correctly retained. A completed source certificate remains uninstantiated; the rational coefficient envelope does not close outer admissibility, pressure, contraction or completed-tail obligations. None of these artifacts proves a polynomial standard-model SAT algorithm.

## Independent execution evidence

The original circuit script exited 0: mixed overlap 16/16, equality tests k=1,...,8 in both orders, and exact minterm audits for k<=4. A separate seeded arbitrary-DAG check covered 80 DAGs, four projected variables each and all eight remaining assignments (2,560 checks), all passing. These finite checks audit implementation consistency; they do not replace the pointwise correctness proof or establish universal asymptotics.

The packet check independently exited 0 (16 gate corners, source allocations, Taylor write certificate and 91 small CNFs). The source check independently exited 0 and explicitly reported that global admissibility, pressure bounds, contraction and completed tail were not checked.


## Factor-aware extension review

Equation (4) is sound: an x-independent Boolean product can be factored out of the OR of two cofactors. Conservative syntactic dependency sets may miss opportunities but cannot invalidate the transformation. The explicit factor list avoids recursively expanding shared product DAGs into occurrence trees. The XOR-spine recognizer soundly computes the parity of x occurrences while rejecting x-dependent multiplication; an accepted joint factor has the form x+G with G independent of x. The program tests this on the joined dependent bucket, not on one constraint while ignoring other x constraints. Its memoized unique-node visits are an appropriate bounded work counter, with dictionary and support overhead still owed.

The second mixed projection 1+v+uv+uz+uvz is the satisfaction indicator of (z=v=0) OR (u=v); the next projection over u is constant 1. The common-z family retains nonlinear terms, although its local-first schedule is an easy special case with a free local pivot. The proposed bound O(k^2) list-classification work and O(k) pivot/gate work for that schedule is justified: one factor disappears per local pivot. This proves no general easy-input promise and no all-input bound. Joining the factors first leaves a descendant that can be processed repeatedly. Counting original factors once does not bound that subsequent work. The document correctly treats measured hub-first growth as finite evidence, and its allowed doubling recurrence as an unclosed upper recurrence, not as a universal exponential lower bound.

The final script was independently rerun successfully, including 16+8+4 mixed projection assignments, factor-aware equality k=8 (34 nodes, 0 cofactors, 36 classified factors, 40 unique pivot nodes), and the displayed nonlinear bucket table. A separate seeded check used 40 arbitrary four-variable factor DAGs and all 24 orders (960 exact SAT decisions); all passed against direct enumeration. Every recognized XOR-spine pivot in those circuits was also checked by full outside truth tables (828 accepted-pivot checks), all passing. This is an implementation audit; pointwise identities are the universal correctness argument.

Minor instrumentation clarification requested of the author: the initial factor_scans counter counted each list element once while partitioning with two comprehensions. Either single-pass partitioning or defining the count as classified factors resolves the constant-factor naming discrepancy. It does not change the complexity verdict, and the finite node/cofactor figures are unaffected.

## Remaining endpoint obligation

A polynomial cumulative construction and evaluation bound for a specified adaptive algorithm on arbitrary CNF inputs remains missing. A robust controlled fluid realization would additionally need effective completed-source data and quantified sensor, control, preparation and readout resources, with a standard-model simulation theorem. The current records are clear about these missing obligations. The bounded review must not be reported as approval of P=NP, a complete fluid computer, or a universal circuit-growth theorem.
