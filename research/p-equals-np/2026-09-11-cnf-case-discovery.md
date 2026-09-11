# S3059: discovering case groups from ordinary CNF

2026-09-11. S3059 / S008 / E004. **Result:** exhaustive two-variable case discovery recovers vertex parity equations from unannotated degree-three Tseitin CNFs and refutes odd charge. But on functional pigeonhole CNFs, every case group of size at most h-2 produces no useful new affine or propagation information. Increasing the budget exhaustively through that level incurs superpolynomial work in the CNF input size. This is an exact limitation of the chosen deterministic policy, not a general SAT, resolution or P-versus-NP lower bound. [Integrity boundary](../../INTEGRITY-CLAIMS.md).

## One selected policy and its resource question

Three policies were considered: (1) groups chosen only from individual clause supports; (2) **selected**, exhaustive variable groups with iterative enlargement; (3) heuristic enlargement from a selected conflict. The third has no justified progress rule here, and the first could miss useful groups for merely syntactic reasons. The selected policy examines every group within its budget, so its obstruction does not depend on a privileged index prefix, padding or a favorable renaming.

Input is ordinary explicit CNF F on v explicitly represented variables and a maximum budget W. No affine equations, guards, group annotations, graph labels or short proof enter the discovery function. It initializes its global affine basis to empty and retains the original clauses. Constructor metadata used to generate tests is not passed to support selection.

For r=0,1,...,min(W,v), form all subsets T of variables with |T|<=r, ordered by size and then lexicographically. For each T, enumerate every binary assignment. Under each assignment perform Boolean unit propagation plus Gaussian propagation from already learned global equations. Repeatedly feed forced variables between the two procedures until stable or contradictory.

For a contradictory case, propose the clause forbidding its exact assignment. For a consistent case, retain the augmented affine consequence space of the propagation relaxation. Intersect these spaces over all surviving assignments to T and propose a basis of the common equations. A case is not declared satisfiable merely because this relaxation is consistent. If all assignments to T fail, report UNSAT.

Every group in one sweep uses the same snapshot of learned equations and clauses. Add proposed equations and previously absent nogoods at the end of the sweep. Repeat that budget while rank or the learned-clause set changes; only at its fixed point enlarge r. Final fixed point at W returns **OPEN**, meaning unresolved, not SAT. No remaining exhaustive SAT fallback or oracle is hidden in OPEN.

The attempted progress claim is that this exhaustive enlargement reaches useful new information on every UNSAT CNF within polynomial total input work. The pigeonhole family below refutes that claim for this policy: merely knowing that some large group will eventually reveal more is not an efficient discovery bound.

## Source alignment and soundness

Enumeration by increasing group size is established, not a new search principle: [Williams-Gomes-Selman, Algorithm 4.1](https://www.ijcai.org/Proceedings/03/Papers/168.pdf) already searches variable subsets with a subsolver. A group producing only partial consequences is not automatically a strong backdoor. [Gwynne-Kullmann, Definition 4.3](https://arxiv.org/pdf/1204.6529v5) studies recursive failed-literal reductions; we do not identify this affine learner with that hierarchy. [Andraschko-Danner-Kreuzer, Proposition 4.10(c)](https://doi.org/10.1007/s11786-024-00594-x) supplies the common-affine-consequence precedent. The [focused source comparison](2026-09-11-cnf-case-discovery-sources.md) records their exact scopes.

Unit/Gaussian propagation is sound under the case assumptions. Contradiction justifies their negation clause. Every actual model has one of the enumerated assignments; hence an equation common to every surviving case's sound affine consequence space holds globally. Failed cases contain no actual model and may be excluded. Learned affine equations are added alongside the original CNF, never substituted for a nonlinear relation without justification.

The case spaces are relaxations: they omit unpropagated nonlinear information. This distinction is essential to the lower-bound argument below, which uses assignments in these affine relaxations, not assignments satisfying an UNSAT formula.

## Positive family: parity recovered without annotations

Take any connected simple degree-three graph. Encode each vertex equation, on its three incident edge variables, as the four clauses forbidding the wrong-parity assignments. Give the vertex charges odd total parity. Only this ordinary CNF is supplied to the learner.

For any vertex, choose two incident edge variables. That pair is among the groups examined at budget two. Under each assignment to the pair, the original four clauses force the third edge to the unique value satisfying the vertex parity, unless the case already conflicts. Thus every surviving case's affine consequence space contains that vertex parity equation. Its common space contains the equation as well. This uses clause propagation; no parser is told which four clauses form a parity block.

If a scope has no surviving case, the learner already refutes the formula. Otherwise, by the end of a complete budget-two sweep, the collected common spaces together contain all vertex equations. Their XOR is 0=1 because each edge occurs twice and total charge is odd. Gaussian elimination refutes. Earlier learned facts cannot invalidate this argument: the original clauses remain, and additional sound propagation can only force the necessary value or expose a conflict.

The number of groups and cases at this fixed budget is polynomial, and all propagation, joins and elimination are charged. This is a restricted parity-discovery result using known operations, not arbitrary hidden-XOR recognition or a new general lower-bound breakthrough. The finite controls use K4 and the triangular prism; the all-graph reasoning above does not extrapolate from their timings.

## Functional pigeonhole family and all-group obstruction

Let F_h have h+1 pigeons and h holes, h>=3. Variable p_(i,j) means pigeon i occupies hole j. Include:

- one length-h at-least-one clause for each pigeon;
- a negative binary at-most-one clause for each pair of holes within a pigeon;
- a negative binary at-most-one clause for each pair of pigeons within a hole.

Thus positive occupied cells must form an injective placement of h+1 pigeons into h holes, which is impossible. This elementary counting argument proves UNSAT. There are v=h(h+1) variables, O(h^3) clauses/literal occurrences and O(h^3 log h) bits with indexed variable names.

Fix any r<=h-2 and any assumption group T with |T|<=r. We prove an invariant covering every assignment to every such group and all earlier learning by the specified policy.

### Propagation under a consistent partial matching

If two assumed-true cells share a pigeon or hole, an original at-most-one clause immediately conflicts. Otherwise the assumed-true cells form a partial matching. Let t be their number. They force only negative assignments to other cells in occupied rows or columns.

For an unoccupied pigeon row, occupied columns remove at most t choices; explicitly assumed-false cells remove at most r-t further choices. At least h-r>=2 holes remain. Thus no at-least-one clause becomes false or unit. Occupied rows already have their true cell. At-most-one clauses can propagate more negative values but cannot introduce a positive placement. Negative assumptions cannot contradict a true cell because a group assigns each distinct variable once. Therefore propagation is consistent and stops with exactly assumptions and such forced negatives. Gaussian reasoning over these coordinate-unit equations adds no relation or contradiction beyond them.

Consequently, among these cases, conflicts occur precisely when an assumed-true pair violates an original at-most-one constraint. This statement concerns this propagation procedure, not full satisfiability of the residual pigeonhole problem.

### Learned nogoods cannot strengthen later propagation

The negation clause of any failed pattern contains the original negative at-most-one pair responsible for that failure. It is a weakening of that existing binary clause. Adding it contributes no new unit-propagation strength: if the larger clause became unit, its subsuming binary clause would already be unit or contradictory; if the binary clause were satisfied, so would the larger clause be.

This also handles later sweeps and enlarged budgets. New pattern clauses may be syntactically distinct at widths above two, but they remain redundant for propagation. Rank progress cannot be inferred from the number of logged clauses. The invariant is preserved even when the policy records every such weakening rather than discarding it.

### Every common affine space is trivial

For any fixed T, the all-false assignment is a consistent case. Its propagated affine relaxation contains the zero vector. For every variable p, choose the case whose T-pattern agrees with the unit vector e_p: if p is in T it is the sole assumed-true cell; otherwise all cells in T are false. The partial-matching argument shows consistency, and its affine relaxation contains e_p. All forced negative cells have zero in that vector.

Therefore the union of the consistent case affine relaxations contains zero and every unit vector. Any affine equation common to all cases must hold on this union. Zero forces its constant term to zero; each unit vector forces its corresponding coefficient to zero. Only the trivial equation remains.

These vectors are generally not models of F_h; zero violates every pigeon at-least-one clause. Their role is to expose the information lost by the propagation-to-affine relaxation. Treating them as satisfying assignments would invalidate the argument.

Initially there are no learned affine equations. The weakening argument preserves the same propagation behavior after every clause batch, and the union argument prevents the first nontrivial affine equation from ever being learned. Inductively, every budget through h-2 reaches a fixed point with no refutation and no affine rank increase. The policy returns OPEN for every W<=h-2, despite F_h being UNSAT. This covers all variable groups, not just local, disjoint or specially indexed choices.

## What automatic enlargement costs

For v variables define

`B_W = sum_(j=0..min(W,v)) binomial(v,j) * 2^j`.

One full budget-W sweep tests exactly B_W assignment cases, including the empty group. At most B_W distinct pattern clauses can ever be added, and at most v independent affine equations can be learned. Across all budgets, there are at most v+B_W productive sweeps and at most W+1 terminal no-progress sweeps. Each case performs at most v assignment-producing propagation rounds plus a final scan, with polynomial Boolean/Gaussian bit work in the current explicit representation. Row-space intersection and membership witnesses are likewise charged.

For fixed W this gives polynomial total work. The persistent basis has at most v rows; learned clauses use at most B_W*W literal entries. Temporary scope lists, up to 2^W surviving bases for one group, proposed-equation logs, batch matrices, hashing/comparison and per-case Gaussian certificates must be included. The implementation retains candidate-equation logs across sweeps, whose length is bounded by the number of sweeps times the number of groups times v, not merely by rank v. All are polynomial in N+v+B_W for fixed W. No linear memory bound is claimed.

Growing W does not retain a uniform polynomial guarantee. On F_h, the prescribed exhaustive growth through r=h-2 cannot terminate with a refutation or affine advance earlier. Its complete sweep at that budget alone contains

`binomial(h(h+1),h-2) * 2^(h-2) >= (2h)^(h-2)`

cases, using binomial(v,k)>=(v/k)^k. This is superpolynomial in the O(h^3 log h) input encoding. The bound charges cases actually mandated by the specified sweep, including unsuccessful searches. It does not assert that budget h-1 succeeds, that these formulas are hard for every algorithm, or that every case-learning policy must exhaust these groups.

The failure is therefore stronger than 'a fixed width might miss something': this automatic, complete enlargement rule itself pays superpolynomial discovery cost on an explicit family before the proved obstruction ceases to apply. Different inference, counting arguments or selection policies remain outside this result.

## Exact checks and reproducibility

Run from the satellite root:

`python research/p-equals-np/2026-09-11-cnf-case-discovery.py`

The [script](2026-09-11-cnf-case-discovery.py) imports the pinned S3058 propagation/join helpers and their S3056 linear dependency. It calls propagation with no guarded rows and initializes no affine equations. [Results](2026-09-11-cnf-case-discovery.json) embed each complete ordinary CNF and variable count, constructor parameters, a canonical input hash, all three code hashes, and scope/case/propagation/elimination counters. Formula metadata is used only by fixture generation and checking, never by `discover(cnf,n,budget)`.

Five controls and five family cases passed. K4 and prism3 odd Tseitin CNFs refute at budget two. Functional PHP with h=3,W=1 and h=4,W=2 returns OPEN with rank zero after complete sweeps. Reversing every variable label in the first PHP case gives the same obstruction. The h=4 run tests 1,41,801 cases at budgets 0,1,2 respectively, including every unproductive case. These small tests do not attempt the asymptotic explosion.

The finite PHP budgets do not generate novel larger weakenings: their failed-pattern clauses already equal original binary constraints. The general weakening induction above, rather than an unrun large-width test, supplies that part of the theorem. Gaussian XOR certificates and common-space membership are checked during execution; most per-case traces are discarded. The JSON retains counters, learned candidate rows, exact inputs and final batch certificates where present, not a complete permanent proof trace for every case.

The final local run took under one second. Timings are diagnostic only; all-size conclusions follow from the derivations. Full assignment enumeration is used only for small control/Tseitin validation, not by the learner as a hidden SAT oracle. No S3058 guarded-family rerun is presented as a new result.

**Strongest supported conclusion:** ordinary CNF suffices for automatic recovery of the tested parity structure, but exhaustive bounded-case affine learning cannot obtain stronger information from these pigeonhole instances before expensive enlargement. The ingredients have clear prior precedents; novelty of this precise policy/counterfamily formulation is unverified. This completes one substantive mechanism attempt without a general SAT claim, publication or automatic successor.
