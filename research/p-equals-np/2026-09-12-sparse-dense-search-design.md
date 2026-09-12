# Sparse/dense search design: collision-weighted restriction schedule

2026-09-12; S3117 under E004/S008. Bounded design and local mathematical assessment. **Selection NONE: the proposed extra multiplicity credit fails its cost contract.** This is a failed explicit construction attempt, not an advance in SAT algorithms. No implementation, experiment, proof campaign or public action was performed.

The planning frontier, literature trigger, S3117 story, inherited protocol and inbox, destination integrity ledger and research meta-graph were read. The worktree was initially clean. The operation and closest known comparison were sent to the independent challenger and orchestrator before derivation; the orchestrator then authorized the bounded counterexample and repair assessment. This note owns only that assessment.

## Exact literature contracts

For fixed k and polynomial-clause satisfiable k-CNF with S=2^(delta n+o(n)) solutions, Liu's Theorem 1 gives deterministic witness time 2^((1-lambda_k+lambda_k delta+H_2(delta))n+o(n)). Theorem 3 gives unique-case time 2^((1-lambda_k)n+o(n)). Here lambda_3=2-2 ln 2 and 1-lambda_3 approximately 0.386294. Section 4 already tries all restriction sizes, all variable subsets and all assignments with bounded unique-search calls; S is not an input oracle. Its cost includes binomial(n,ceil(log_2 S))*2^ceil(log_2 S) such calls. [Liu, primary paper](https://arxiv.org/pdf/2001.06536).

Servedio--Tan Theorem 1 applies to arbitrary M-clause CNF of density at least epsilon>0, with time (Mn/epsilon)^[soft-O((log log(Mn)+log(1/epsilon))^2)]. The almost-polynomial specialization has M=poly(n), epsilon>=1/polylog(n). Section 2 already tries successive dyadic density guesses; unknown density alone is not the gap. Their restriction search uses approximate counting to preserve bias from below, paying 2^(r_SL+r_PRG)*T_count(n,delta_count)*p^(-1) ln n. Thus the theorem is not restricted to high density, but its dependence on tiny epsilon becomes expensive. [Primary paper](https://arxiv.org/pdf/1801.03588).

The general deterministic comparator retained from the [S3116 intake](2026-09-12-deterministic-search-intake.md) is Liu's O*(1.32793^n), source-reported rounded base, not an exhaustive current-record certification. The sparse/dense minimum and density guessing are existing baselines. A changed rule must improve a paid transformation/search bound, not simply choose that minimum.

## Proposed operation, before its failure assessment

Input is an explicit signed 3-CNF G and an explicit universe V of N unassigned variables. Unit propagation is deterministic (lowest-index unit first); contradictions reject. Record every forced bit. Keep variables absent from the simplified clauses in V unless they were actually assigned, so model counts and uniform density use the stated universe. Canonicalization removes tautologies and duplicate clauses and sorts literal and clause lists. No semantic equivalence, SAT, exact counting or hidden witness oracle is used.

At each nonterminal node use b=min(N,ceil(log_2(max(2,N)))). Enumerate every b-subset B of V and every assignment a to B. Simplify and unit-propagate. Reject syntactic conflicts; for each other result retain its unassigned universe U_a and canonical residual H_a. Group results by the exact pair (U_a,H_a). A class c has multiplicity w_c, size N_c=|U_c|, and the lexicographically first representative with its B assignment and forced-bit reconstruction record. Different forced-bit values can be grouped when their residual and remaining universe agree: each representative still has its own valid reconstruction.

Define the exactly computable rational score

    C(t)=2^ceil(2t/5),       J(B)=sum_c C(N_c)/w_c.

Choose a B minimizing J(B), breaking ties lexicographically. Visit its classes in decreasing w_c, breaking ties by representative assignment. This is the proposed changed block-selection and scheduling rule. The rational exponent 2/5 is a computable surrogate for the unique-case exponent, not an imported general-case bound. Exact rational comparisons avoid assuming exact comparison of expressions involving ln 2.

For definiteness, at each visited residual with t variables first simulate the fixed Liu unique-search algorithm for C(t) bit steps and then the fixed Servedio--Tan search algorithm, with epsilon=1/L(t)^2 where L(t)=ceil(log_2(t+2)), for C(t) bit steps. Fix deterministic machines implementing the published constructions once, and charge simulation overhead. Accept only a witness checked against this residual and then the original input. Timeout or unsuccessful output means continue; it never means UNSAT. If neither returns a verified witness, recurse using the block rule. An empty residual gets any completion of its explicit free universe, followed by full verification. A node returns UNSAT only when all representative recursive branches reject. The finite cutoffs specify an operation without claiming either source promise holds on a particular call. Changing them to source-guaranteed caps would require charging those caps.

Grouping is exact preservation: every satisfying assignment extends one nonconflicting B assignment and its forced bits, and the corresponding representative has the same residual relation on the same U. Hence G is satisfiable iff at least one representative residual is satisfiable. No nonidentical residual is silently discarded. Formula width stays at most three; clause count does not grow under restriction and normalization. This is informal reasoning, not a new Lean theorem or implemented solver.

Construction cost per node is

    A(G)=binomial(N,b)*2^b*poly(N,M),

including all unsuccessful candidate blocks, propagation, canonicalization, grouping and rational score comparisons. Multiplicities are at most 2^b, and exact rational score numerators/denominators have polynomial bit length here because at most 2^b=O(N) classes occur in a block. Candidate blocks can be processed one at a time; keep only the winning table. This is N^O(log N) work per node, not polynomial. Reconstruction, retained tables, recursion, every trial simulation and unsuccessful child are charged. A safe total expression is the sum over actually visited nodes of A(G), both bounded solver simulations and verification/reconstruction costs. The recursion terminates because b>=1. No faster global bound is established.

## Closest known operation and intended extra obligation

Syntactic residual caching and component caching are established #DPLL/knowledge-compilation machinery: merge repeated residual work and solve each retained residual once. Dynamic variable choice and residual caches already coexist. [Sang et al., SAT 2004](https://www.satisfiability.org/SAT04/accepted/65.html); [de Colnet, SAT 2024](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.SAT.2024.11).

The proposed difference was specifically to select whole blocks and schedule by an inverse-multiplicity score, hoping collisions would yield an additional amortized discount toward the intermediate-density gap. Novelty of that particular heuristic is unknown and is not asserted. Merely rediscovering caching would not qualify. The first falsifiable obligation was: after duplicate residuals have already been merged, can w_c support crediting the remaining class evaluation by a further factor 1/w_c, or certify that its density/sparse-search parameters improve enough to justify that credit? This local accounting obligation is weaker and more concrete than conjecturing an improved worst-case exponent. It fails below.

## Bounded derivation and exact failure

For a fixed B, with the stated explicit free universes, let S(H_c) count models on U_c. Unique unit-propagation extensions give the exact identity

    S(G)=sum_c w_c*S(H_c).

Consequently

    mu(G)=sum_c w_c*2^(N_c-N)*mu(H_c).

When no propagation occurs all N_c=N-b, giving the simpler mixture mu(G)=sum_c (w_c/2^b)*mu(H_c). With propagation, replacing these weights indiscriminately by w_c/2^b is incorrect. These identities do not provide an algorithm for computing S(H_c).

The elementary free-variable case is F(z,x)=H(x) with b unused z variables. All 2^b assignments collapse to the same H. Its model count gains a factor 2^b, but its uniform density is exactly mu(H). The remaining residual solver receives exactly H. Grouping avoids 2^b copies of that task; it does not divide the cost of the retained evaluation by 2^b. Removing free variables in preprocessing gives the same elementary escape and the same absence of extra credit.

The same local diagnostic does not require unused input variables. Let

    F(x,z,t)=H(x) AND conjunction_(i=1)^r (z_i OR t_i),
    B={z_1,t_1,...,z_r,t_r}.

Every padding variable occurs in a non-tautological clause. Exactly 3^r assignments to B leave the identical residual H; all other assignments give a syntactic conflict. Thus w=3^r, S(F)=3^r*S(H), and mu(F)=(3/4)^r*mu(H). The restriction boosts density relative to F by (4/3)^r, not by w=3^r; the class still has exactly H's internal density and search task. Choose H_k as k disjoint positive 3-clauses if a concrete arbitrarily low residual density is wanted: mu(H_k)=(7/8)^k, which remains below inverse-polylog thresholds for large k. H_k has an obvious witness and is deliberately not evidence of solver hardness. For every r>=2 with even block size b=2r, k can be chosen so that ceil(log_2(3k+2r))=2r, so this candidate B occurs within the prescribed block enumeration. This does not prove the minimum-score rule selects B.

If a fixed deterministic residual subroutine takes t_H positive steps on H, executing it once still takes t_H steps, whereas executing it separately on w identical residuals takes w*t_H steps. Caching changes the latter to t_H; a second credit t_H/w is not an execution-cost identity. Using the numeric proxy C instead does not repair that missing implication. This is a local counterexample to the multiplicity-to-density/cost inference, not a lower bound on t_H, a disproof of every possible global amortized inequality, or a theorem that this block heuristic always performs badly.

## Repair assessment and decision

The valid cached recurrence pays one full T(H_c) per visited distinct residual, plus all block-construction costs and bounded calls. Removing 1/w_c yields an ordinary residual-cost proxy sum_c C(N_c), still without a general-case guarantee because C is a unique-case-inspired proxy. Keeping decreasing-w order is a heuristic; class size supplies no certificate that the first class is satisfiable, dense, uniquely satisfiable or cheap internally. Propagation and component decomposition can help the padding examples, which are not common hard instances. Symmetry/caching already explains their duplicate savings. No XOR, algebraic or quantum lower bound is inferred.

A nontrivial repair would need additional formula-derived evidence controlling residual solution structure or evaluation work after grouping, with its discovery cost charged. No such additional operation emerged in this bounded attempt. Therefore selection is NONE, not a selected collision mechanism and not a new residual-research campaign. Preserve the explicit failed score and its exact counteraccounting; do not open automatic replay experiments.

Even a proved improved exponential runtime for all 3-CNF would not resolve P versus NP. A uniform deterministic witness procedure with a known polynomial total-bit-time guarantee on every satisfiable 3-CNF, sound verification and the corresponding polynomial timeout would imply a polynomial 3-SAT decision algorithm and P=NP. Nothing here supplies that bound, nor any separation. Novelty and broader frontier significance are unestablished. The full research objective remains unresolved.
