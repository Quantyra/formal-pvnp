# Deterministic SAT-search intake: bounded selection NONE

2026-09-12; S3116 under E004/S008. Source commit `379044b4a0cff6c92349ad909de503e31a9cc299`. Source/screening finding only; no new mechanism, theorem, solver or research advance is selected.

The planning frontier and literature-trigger protocols, destination integrity ledger and existing research meta-graph were read. This is distinct from S3115 paired-PPSZ and the rank-family extensions. The graph already records known enumeration, exact pricing, proof-discovery and conditional deterministic-search bridges; none is reopened here. T2 exploratory intake is discharged by this bounded literature note, subject to planning closeout. No new execution follows automatically.

## Relevant primary guarantees

The strongest general deterministic 3-SAT bound found in this bounded search is Liu's `O*(1.32793^n)` (rounded-up base), using branching, chains and generalized covering codes. Theorem 6.7 of the extended paper is the relevant 3-SAT statement. This is a source-reported bound, not an exhaustive September 2026 record certification. Search included 2025/2026 queries; no stronger applicable primary deterministic bound was found. [Liu, ICALP 2018 and extended version](https://arxiv.org/pdf/1804.07901).

Moser--Scheder already construct a full derandomization of Schoning with time `O((2-2/k+epsilon)^n poly(n))`, for every fixed positive epsilon. Merely making local-search choices deterministic is therefore not a new contribution. [Primary paper](https://arxiv.org/abs/1008.4067).

Liu's partial PPSZ derandomization explicitly constructs a subexponential enumerable permutation family using limited-independence hashing and enumerates bounded guess strings. Unique k-SAT takes `2^((1-lambda_k)n+o(n))`; with `S=2^(delta n)` solutions the stated general-case search guarantee is `2^((1-lambda_k+lambda_k delta+H_2(delta))n+o(n))`. Here lambda_k is the paper's PPSZ saving constant, not a newly improved PPSZ constant. The algorithm need not know S: it interleaves all restriction sizes, variable subsets and assignments. The count-guided isolation construction is an analysis tool, not its executable oracle. This does not import the latest randomized PPSZ exponent or a fast general UNSAT timeout. [Theorems 1 and 3, Section 4](https://arxiv.org/pdf/2001.06536).

Dense-CNF search also already exceeds simple seed enumeration: Servedio--Tan find a witness for poly(n)-clause CNF of density at least epsilon in `n^(soft-O((log log n)^2))` time for epsilon at least inverse polylog(n). That density promise excludes general sparse-witness inputs. [Primary paper](https://arxiv.org/abs/1801.03588).

Lyu's explicit depth-d size-m circuit PRG uses `O(log^(d-1)(m) log(m/epsilon) log log(m))` seed bits; depth two covers CNF. Enumeration costs `2^s` evaluations plus generator construction/evaluation, not polynomial merely because each evaluation is efficient. To hit a potentially unique satisfying assignment through additive-error fooling requires epsilon below `2^-n`; this bound then supplies no competitive general 3-SAT exponent. PRG fooling and formula-specific deterministic search are different contracts. [Primary paper](https://arxiv.org/abs/2301.10102).

## One operational screen, not a new candidate

The only additional concrete screen considered replacing exact residual-count queries by truncated inclusion-exclusion upper bounds inside deterministic prefix search. This is already known machinery: Zaleski explicitly implements SAT through inclusion-exclusion and Bonferroni bounds, including compatible clause intersections and progressive truncation. Ordinary witness self-reduction does not turn that into a new construction. [Primary source, Section 2](https://arxiv.org/pdf/1712.06587). This source was identified by the independent challenger.

For clarity, the screened operation is fully specified. Input is an explicit 3-CNF, with ordinary read access to its literals; no SAT, count, satisfying-assignment or random-function oracle. Fix an even truncation order r, initially r=2. At a prefix, simplify and unit-propagate, reject an empty clause, and accept an empty residual after verifying an arbitrary completion against the original formula. Otherwise let N be the remaining variable count and let A_i be the subcube falsifying residual clause i. Enumerate all clause subsets J of size at most r. Their intersection has size zero if falsification demands conflict, and otherwise `2^(N-v(J))`, where v(J) counts demanded variables. Compute exactly

`U_r = sum_(j=0)^r (-1)^j sum_(|J|=j) |intersection_(i in J) A_i|`.

Reject only if `U_r=0`; otherwise branch on the lowest-index remaining variable, try 0 then 1, and return a verified witness or UNSAT when both recursive branches reject. This is a complete deterministic branching procedure; positive U_r is not a satisfiability certificate.

Seed length is zero. With Q=sum_(j=0)^min(r,m) binomial(m,j), construction and evaluation cost per node is `Q poly(n,m,r)` bit operations; integer accumulators have `O(n+r log(m+1))` bits. Intersections can be streamed in polynomial working space for fixed r. At most `2^(n+1)-1` prefix nodes are examined, giving only the generic `2^n Q poly(n,m,r)` bound here, not a runtime lower bound. Raising r charges the entire Q cost; r=m restores exact inclusion-exclusion with up to `2^m` intersections per node. No hit list is assumed free.

The first falsifiable obligation would be a new structural pruning statement strong enough to establish total time below the general deterministic comparator. The elementary Bonferroni identity supplied by the challenger explains the immediate obstacle: an assignment violating t clauses contributes 1 when t=0, and `binomial(t-1,r)` when t>=1. Thus U_r equals the true solution count plus nonnegative contributions from assignments violating more than r clauses. Any r+1 jointly falsifiable residual clauses prevent exact-zero pruning even if a disjoint unsatisfiable core exists. This is a local bound diagnostic, not an exponential solver lower bound; decomposition or ordinary branching may easily handle such examples.

## Decision and exact relevance

NONE. No changed cancellation, restriction-selection or construction operation addressing this obstacle emerged in this bounded intake. The reason is known-operation subsumption and absence of a concrete proposed difference, not a requirement that a speculative final bound already be proved. The sources do not supply an advance for this screen: their fast guarantees require different machinery or additional promises, and the direct inclusion-exclusion source already supplies its central operation. No experimental replay is useful at this point.

A proven smaller exponential deterministic base for all 3-CNF would improve an exact-algorithm guarantee but would not resolve P versus NP. A uniform deterministic search procedure with a known polynomial total-bit-time bound on all satisfiable 3-CNF, sound witness checking, and the corresponding polynomial timeout would decide 3-SAT and imply P=NP. No such bound or operation is supplied here. No separation follows from failure of this screen.

Only source review and selection evidence were produced: no proof campaign, experiment, code change, public action, commit, outreach or spend. Independent review may correct this note. No novelty or exhaustive impossibility claim is made; the wider research objective remains unresolved.
