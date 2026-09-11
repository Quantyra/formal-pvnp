# S3059 proof-adversarial review

2026-09-11. Independent proof-adversarial lens for the [final mechanism derivation](2026-09-11-cnf-case-discovery.md), under [INTEGRITY-CLAIMS.md](../../INTEGRITY-CLAIMS.md). This concerns the selected all-subset bounded-case learner starting from ordinary CNF with no affine equations or guard annotations. Complexity and nonclaims reviews are separately assigned. No Lean certification or human peer review is claimed.

**Final proof-lens verdict: GO for the scoped mathematical result.** The case-learning rule is sound; the degree-three parity upper bound, all-round functional-pigeonhole invariant and stated exhaustive-enlargement work bound hold. The final narrative distinguishes relaxation points from CNF models and mathematical induction from finite tests. No required correction remains.

## Core proof obligations

The rule tests every assignment to every support up to the current budget, applies sound Boolean unit propagation and Gaussian closure, learns a full failed-pattern clause for each contradiction, and intersects the surviving **augmented** row spaces for common equations. Refuted cases may be excluded because they contain no actual models. Surviving closure systems may still contain spurious points: they are relaxations, not satisfiability certificates.

Case assumptions cover every actual model. Consequently both the failed-pattern clauses and equations justified in all surviving cases are unconditional consequences. Retaining the original clauses is essential. No OPEN result can be interpreted as SAT, and no construction may replace these closures with a free complete case solver.

For v variables and final budget W, at most `B_W=sum_(j=0..min(W,v)) binom(v,j) 2^j` patterns are tested per full maximum-budget sweep. There are at most B_W distinct pattern-negation clauses and at most v affine rank increases. At a fixed budget, every productive consistent pass adds a new clause or increases rank. Increasing the budget accounts separately for at most W+1 terminal sweeps. This supplies finite polynomial saturation for fixed W only when all scans, row operations, case closure and stored clauses/provenance are charged.

## Degree-three Tseitin positive family

Encode each degree-three vertex parity as the four clauses forbidding its wrong-parity assignments. Assigning any two incident edges makes the retained local clauses force the third edge to the value required by that vertex parity. Every nonconflicting closure for that pair therefore contains the three assigned-edge equations whose XOR is the vertex equation.

At budget two every such pair is tested. If every case at some support conflicts, the learner already refutes. Otherwise that vertex equation belongs to the common case consequence space. If the complete sweep proceeds without earlier refutation, the collected spaces together with the current equations contain every vertex parity. XORing them cancels each edge twice and contradicts odd total charge. Thus refutation occurs by the first complete budget-two sweep, or earlier. Explicit emission of every vertex row before an early contradiction is not required.

No initial parity annotations or graph-aware choice of supports are used by this argument. The graph description constructs the test CNF; the learner only sees clauses and exhaustively selected variable groups. This is a restricted-family upper bound, not a result about arbitrary CNFs.

## Functional pigeonhole obstruction, including earlier learning

Use v=n(n+1) variables p_(i,h), with n+1 pigeons and n holes. Include one at-least-one-hole clause for each pigeon, and binary at-most-one clauses for every two placements in one pigeon row or one hole column. The formula is UNSAT by injectivity. Fix W with n>=W+2.

In any assignment on at most W variables, the true placements either contain an at-most-one violation or form a partial matching. The former immediately conflict. In the latter, let t placements be true. Unit propagation sets their row and column peers false. For an unoccupied pigeon, at most t holes are occupied and at most W-t further placements were explicitly denied, leaving at least n-W>=2 possibilities. Thus no at-least-one clause becomes unit or empty. No further positive placement is forced, and the case remains consistent. Gaussian closure with no global affine equations adds nothing beyond these unit assignments.

This characterization survives earlier failed-pattern learning. Every conflicting pattern contains a pair of true placements violating an original at-most-one clause. Its learned nogood contains that original binary clause as a subclause and is therefore a weakening. Such a weakening cannot strengthen unit propagation: if it becomes unit on a literal of the original clause, that clause is already unit or conflicting; if its sole unassigned literal is outside the original clause, the original is already conflicting. Hence adding any number of these learned clauses preserves exactly the relevant original unit closure. This is an inference-level argument, not merely the observation that the clauses are logically redundant.

For any tested support T, consider the union of its surviving Gaussian relaxations. The all-zero assignment on T gives no positive placements and its relaxation contains the zero vector and every unit vector e_j with j outside T. For j in T, choose the assignment making only j true. It is a partial matching; its propagated negatives are all zero in e_j, so its surviving relaxation contains e_j. The union thus contains zero and every coordinate unit vector. An affine equation valid throughout it must have right-hand side zero (test zero) and every coefficient zero (test each unit vector).

Therefore the common augmented row space contains no nontrivial affine equation at any support. Inductively, global affine rank remains zero; learned clauses remain at-most-one weakenings; and no case outside the already identified matching violations becomes contradictory. Every budget through W saturates to OPEN. There is always at least the consistent all-zero case at each support, so no all-cases-conflicting shortcut applies.

Crucially, zero and e_j are **not models of the pigeonhole CNF or its full conditional formulas**. They witness weakness of the affine summaries of surviving cases. This distinction avoids the vacuous claim that an UNSAT relation itself has a nontrivial model-based affine hull. The result is incompleteness of this exact bounded-case learner, not a general SAT, proof-system or lower-bound theorem.

For the prescribed exhaustive budget growth with final budget at least n-2, the sweep at budget n-2 alone enumerates at least `binom(n(n+1),n-2) 2^(n-2)` patterns before it can increase the budget or finish OPEN there. For n>=3 this is at least `(2n)^(n-2)`, whereas the explicit functional-CNF encoding has `O(n^3 log(n+1))` bits. Thus this exhaustive growth incurs superpolynomial work on the family. This concerns the stated enumeration policy, including failed attempts, and does not assert that budget n-1 succeeds or that other support-selection methods incur the same cost.

## Independent executable and evidence checks

The reviewer inspected the [driver](2026-09-11-cnf-case-discovery.py) and wrote a separate [read-only proof checker](2026-09-11-cnf-case-discovery-proof-check.py). Run it from the satellite root with:

`python research/p-equals-np/2026-09-11-cnf-case-discovery-proof-check.py`

It reads the five complete CNFs in the [saved result](2026-09-11-cnf-case-discovery.json), verifies their canonical input hashes and all three code/dependency pins, then independently replays Boolean propagation for every reported support pattern. It imports none of the author's propagation or linear-algebra implementation. These fixtures have no committed affine equations or new nogoods before their final sweep, which the checker asserts; their case Gaussian spaces therefore consist exactly of the independently reconstructed unit equations.

For every learned common equation, the checker verifies support on fixed variables and the correct constant in every surviving case of its recorded scope. It independently XORs the final batch provenance masks to each reported row and contradiction. On every PHP support it also checks zero and every coordinate unit vector against an explicitly selected surviving case's affine units. Those checks do not assert that the points satisfy the full CNF.

The replay passed **1,165 case closures, 70 conflicts, ten common equations, two batch contradictions, 5,257 PHP summary-witness checks and five input pins**. Complete case/scope counts agree with the saved exhaustive sweep counts. The author's five controls and five family cases passed separately. Script SHA256-LF is `5c78d364f2fb609b9b7affb2397e7ba5815e77c8fad42a5a5eb867a1e0cbe400`, with the S3058 and transitive S3056 helper pins also verified.

The tiny PHP fixtures add no new nogoods: their failed two-positive patterns are already input at-most-one clauses. Thus the computational checks alone do not exercise later addition of larger weakening clauses. The induction above, including the explicit unit-propagation domination argument, supplies that all-round obligation. No large-budget experiment or timing extrapolation is claimed.

The [source comparison](2026-09-11-cnf-case-discovery-sources.md) identifies established exhaustive lookahead, backdoor and common-affine-consequence precedents. No identification with a different failed-literal hierarchy, novelty certification or unrestricted proof-search bound follows from this review.
