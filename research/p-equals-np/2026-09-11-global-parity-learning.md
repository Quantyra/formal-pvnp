# S3058: deterministic global parity learning across guard cases

2026-09-11. S3058 / S008 / E004. **Result:** complete case analysis on supplied two-variable guard supports can discover common global parity equations even when none of the individual cases produces a conflict. On the constructed nonlinear guarded-path rings, those equations yield a polynomial-work refutation for every ring size and path length. The policy also learns a nonlinear guard exclusion from a growing guarded Tseitin contradiction. These are exact restricted-family results and finite checks, not a general SAT algorithm or novelty claim. [Integrity boundary](../../INTEGRITY-CLAIMS.md).

## Policy chosen and source overlap

Three policies were considered: (1) group identical guards and learn only their negations on conflict; (2) **selected**, test complete guard-support assignments using global propagation and learn both failed assignments and common affine consequences; (3) search for new guard supports or useful proofs. Policy 3 is not implemented or assumed. The guard supports in policy 2 are explicitly present in the input, so the policy does not ask an oracle which assumptions will help.

The common-consequence principle is established. [Andraschko-Danner-Kreuzer (2024), Proposition 4.10(c) and Example 4.11](https://doi.org/10.1007/s11786-024-00594-x) give an intersection of linear consequences across complementary alternatives. [Beame-Sun (2026), Theorem 4.10](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.SAT.2026.5) relates suitable decisions/restarts to a supplied parity-resolution proof; it does not provide a deterministic finder of that proof. The [source comparison](2026-09-11-global-parity-learning-sources.md) distinguishes these precedents from our fixed-support policy and family analysis. We claim neither a new abstract join rule nor a new general parity-CDCL algorithm.

## Exact input and deterministic selection

Input has three explicit parts: unconditional affine equations over GF(2), ordinary CNF clauses, and guarded affine rows

`(l_1 AND ... AND l_r) => (a dot x = b)`.

Each guard is a normalized conjunction of signed variable literals with distinct underlying variables. A contradictory guard can be discarded, repeated literals removed, and an empty guard treated as unconditional. The fixtures obey this grammar directly. All variable dimensions, masks, clauses and guarded rows are explicitly encoded; long paths and inactive variables count toward input size.

Freeze the scope list to the empty support followed by the sorted distinct variable supports of original nonempty guards. Let w be its maximum size. For every scope T, enumerate all assignments to T in binary order. Scope enumeration never grows in response to learned clauses and does not enumerate all subsets of variables. A pass uses the same snapshot of global equations and CNF for every case.

### Global closure inside one case

Starting with the case assumptions, repeat:

1. Run syntactic Boolean unit propagation on the original CNF and learned clauses.
2. Activate every guarded row whose entire guard is now true. Do not activate an unknown guard or substitute a favorable assignment for it.
3. Apply Gaussian elimination to the current global equations, activated rows and assigned-variable equations. Detect inconsistency and extract any individually forced variable values.
4. Feed those values into unit propagation, continuing until no variable is added or conflict occurs.

All scans are deterministic. Conditional rows can involve variables arbitrarily far apart; there is no bounded spatial window in this closure. At most n variable assignments are added per case, followed by a final scan. Only implications actually established by these operations are used. A consistent closure is an overapproximation of the full conditional formula, not a satisfiability certificate.

### Learned information

If a case is inconsistent, learn the clause forbidding exactly that scope assignment. Its width is at most w; no minimal conflict core is sought. Failure under the empty scope certifies UNSAT immediately.

For every surviving case, regard its Gaussian equations as vectors `(a,b)` in GF(2)^(n+1), encoding `a dot x=b`. Compute the intersection of their augmented row spaces. Every vector in that intersection is an affine equation supported by every surviving case. Failed cases have no models, and the scope assignments cover all possibilities, so these common equations hold unconditionally in the original formula.

Row-space intersection is computed by linear algebra, not by enumerating equations or assignments: solve for pairs of coefficient vectors giving equal combinations of two bases, then map a kernel basis to the shared rows. Iterate this across the finitely many surviving cases. If all cases fail, the scope partition itself is an UNSAT certificate. Add common equations and failed-pattern clauses simultaneously after the pass, then repeat until contradiction or no new rank/clauses.

The only verdicts are **UNSAT** and **OPEN**. OPEN is unresolved, not SAT. This policy does not search remaining assignments or return an unverified witness.

## Soundness, provenance and termination

Within a case, unit propagation and activation of true guards are sound under its assumptions. Every Gaussian row is an XOR combination of its input equations. A failed case consequently justifies its exact assumption-negation clause. Common equations are sound because every actual model belongs to one of the exhaustive cases and satisfies that case's inferred equations. No independence or probability assumption about guard bits is used.

The implementation records case assumptions, unit steps with clause or Gaussian reasons, active guarded-row indices, and Gaussian input tags. Gaussian elimination carries a bit mask selecting the input rows in each derived XOR; every emitted row and contradiction is checked against that combination. Common rows additionally carry row-combination witnesses in each surviving case. Final batch inconsistency has its own XOR certificate. This is computational provenance for an informal argument, not a Lean proof or a statement that the separate reviewer has formally certified every trace.

Let the frozen supports be T_0=empty,T_1,...,T_g and define `B=sum_j 2^|T_j|`, including the one empty case. There are at most B possible pattern-negation clauses. A productive consistent pass either increases affine rank or adds at least one previously absent such clause. Rank increases at most n times and at most B clauses can be added, so there are at most n+B productive passes, plus a final unproductive sweep. Contradiction can terminate sooner. These are bounds on the specified saturation process, not on arbitrary proof search.

## Family A: a nonlinear guard exclusion with global parity provenance

Take the connected k-prism graph for k>=3, with 2k vertices and 3k edges. Give each edge a Boolean variable and each vertex its incident-edge parity equation. Use an odd total charge, and guard every vertex equation by the same conjunction g AND h. There are no other constraints in this fixture.

Under g=h=1, XORing all vertex equations yields 0=1: every edge occurs twice. Connectedness means the only nonempty dependence among the incidence rows uses all vertices, so a proper subset of the vertex equations is consistent. Gaussian elimination finds the contradiction without choosing a minimal subset; its provenance certifies the global combination.

Under the other three guard assignments, no vertex equation activates and all data variables are free. The learned consequence is therefore exactly `NOT g OR NOT h`. This is nonlinear as an affine relation: its three allowed two-bit patterns have full affine hull, so no nontrivial unconditional affine equation expresses that exclusion. The policy learns the clause, then reaches OPEN. The formula is satisfiable, but OPEN deliberately makes no satisfiability claim.

This demonstrates that a bounded-width learned guard clause can have an unbounded-length global parity derivation. The graph family is not used to claim a new resolution lower bound, and conditional Gaussian conflict explanation is already standard.

## Family B: long guarded paths around a nonlinear AND ring

For every m>=3 and path length ell>=1, use shared endpoint variables x_0,...,x_(m-1), control variables g_i,h_i, and indicators z_i. The ordinary clauses encode

`z_i <=> (g_i AND h_i)`

using `(NOT z_i OR g_i)`, `(NOT z_i OR h_i)`, and `(z_i OR NOT g_i OR NOT h_i)`. Add the unconditional equation

`XOR_i z_i = 1`.

For each i and each pattern (alpha,beta) in {0,1}^2, create its own length-ell path from x_i to x_(i+1 mod m). All ell-1 internal variables are fresh for that pattern and that edge. Guard every path row by `g_i=alpha AND h_i=beta`. The first edge's parity charge is alpha*beta and every other edge has charge zero. Different patterns have disjoint internal variables even though their endpoints are shared.

There are 4m guarded paths and 4m*ell guarded rows. The total variable count is `4m + 4m(ell-1)=4m*ell`; the three-clause AND definitions and indicator parity are also charged. Inactive path internals are unrestricted.

### Exact path projection

When a path activates, XORing its ell equations gives

`x_i XOR x_(i+1) = alpha*beta`.

Conversely, any endpoint values satisfying this equation extend along the path: choose each next internal value from the preceding edge equation, with the last equation satisfied precisely by the endpoint condition. Thus the endpoint equation is the exact existential effect, not a heuristic summary. This proof works for every ell without compiling a parity constraint into CNF.

### Why conflict-only learning finds nothing initially

The only nonempty scopes are the m pairs {g_i,h_i}. In one case, unit propagation fixes z_i=alpha*beta, and exactly one path at position i activates. Other guard pairs remain unassigned. Since m>=3, the indicator parity still has at least two unknown z variables and forces no individual value. The active path is consistent with free endpoints and forces no individual endpoint or internal bit. Remaining AND clauses have no units. The closure therefore stops consistently in every case, including the empty case.

The conflict-only comparator learns no clause and returns OPEN at its first fixed point. This is an exact failure of that comparator, not evidence that all conflict learning is powerless on the family. The m>=3 restriction matters; smaller rings can produce additional propagation.

### What the common-consequence policy discovers

In every case for pair i, the active path gives the endpoint parity alpha*beta, while the AND clauses give z_i=alpha*beta. Their XOR is the same equation in all four cases:

`E_i: x_i XOR x_(i+1) XOR z_i = 0`.

Hence E_i lies in the intersection of the four augmented affine consequence spaces, even though the active path's internal variables differ across cases. No case has to be contradictory for this information to be learned.

The basis output by row-space intersection need not contain E_i verbatim. Its span together with the already-present equations contains E_i, which the exact checker verifies. Collecting these spans for all m scopes and eliminating globally produces `XOR_i z_i=0`, because every endpoint occurs twice. This contradicts the original odd indicator parity. The policy therefore refutes the family in its first common-consequence pass, independently of m and ell; total work in that pass is polynomial in the fully written input.

This is a concrete interaction between nonlinear AND clauses, conditional long paths and global equation learning. It is not a positive-guard Horn least-model shortcut: activation includes both signs of each guard variable and the indicator XOR is constrained to odd parity. The comparison establishes the benefit of common equations over the specified conflict-only rule, not superiority over existing XNF/CDCL solvers or the earlier entire research portfolio.

## Bit work, learned size and limits

Let N be the explicit input bit length and n the active variable count. For fixed maximum guard width w, `B<=1+g*2^w` is polynomial in input size. Each case costs at most n productive assignment rounds plus a final round; every round scans clauses/guards and eliminates explicitly stored binary rows. Dense Gaussian operations, row-space intersections, guard checks, variable names and provenance masks all incur ordinary bit work. There is no real-arithmetic or precision assumption.

Each scope contributes at most n independent common equations before batching. The persistent affine basis has at most n rows, and at most B learned clauses of width at most w are retained. Temporary common bases from all scopes, batch inputs and proof masks must also be stored or streamed. A deliberately loose total bound is

`O((n+B+1) * B * (n+1) * poly(N+B*n^2))`,

where dense elimination and provenance operations supply the polynomial factor. This charges the final unsuccessful sweep, all case closures, row-space joins, full guarded-path input and learned-clause scans. Retaining all diagnostic traces, as the checker does, multiplies polynomial per-case trace size by this polynomial number of cases/passes. No linear-memory or exact machine-time claim is made. If w grows, enumeration of 2^w cases is not free.

Polynomial saturation does not imply completeness outside the refuted ring family. With no effective nonempty guard supports, a CNF with no unit consequences and no affine input can remain untouched under the empty-case closure, regardless of whether it is satisfiable. Existing easy implication-cycle examples already illustrate that limitation; no new broad benchmark was run. Learning more scopes, composing richer nonlinear consequences or finding short parity proofs are separate operations with no bound established here.

## Exact evidence and scope of the result

Run from the satellite root:

`python research/p-equals-np/2026-09-11-global-parity-learning.py`

The [script](2026-09-11-global-parity-learning.py) uses the pinned [S3056 linear helper](2026-09-11-decomposition-mechanism.py). [Saved JSON](2026-09-11-global-parity-learning.json) records four controls and six family cases: guarded prisms k=3,4; AND rings m=3,4 with path lengths 1 and 3. It includes exact constructor parameters, provenance traces and SHA256-LF hashes of both code files. The pinned deterministic constructors recover every original equation, clause, guard and variable identity; no unavailable external formula is required.

All controls and cases passed, with the final local run under one second. The prism cases learn their binary guard exclusion and return OPEN. The ring cases return OPEN with no new clauses under conflict-only learning and UNSAT under common-equation learning. Gaussian certificates and case-membership witnesses are checked exactly. An initial test assertion incorrectly demanded that target equations lie in the newly emitted basis alone; it was corrected to test the span of that basis plus existing equations, matching the mathematical contract. No algorithmic policy or fixture was changed to obtain a favorable result.

The all-size derivations above, rather than finite timing extrapolation, justify the family claims. Global closure computes a sound relaxation inside each case and does not call a SAT oracle. Common-consequence intersection and guarded Gaussian reasoning have explicit prior precedents; originality of this particular policy/family presentation is not established. The supported result is a deterministic, provenance-carrying discovery of useful nonlocal consequences on these exact families, with an explicit polynomial bound and an OPEN boundary. No general P-versus-NP result, publication or automatic successor follows.
