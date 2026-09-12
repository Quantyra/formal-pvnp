# Post-dimension frontier intake: paired PPSZ

2026-09-12; S3115; bounded author selection, pending independent final-file challenge.

**Author recommendation: NONE for the one operation examined.** This is a general SAT algorithm screen, not another rank-map specialization. The operation is executable in principle, but its main transition is already finite-domain PPSZ after grouping. The proposed source of a better exponent does not survive its first local comparison. This does not exclude a future new analysis or an additional, concretely specified operation. It is not an exhaustive search or a lower bound against pairing algorithms.

No experiment, implementation, proof campaign, commit, publication or successor is authorized by this note. All mathematics below is informal intake reasoning, not Lean verification, human peer review or novelty certification.

## Inherited evidence and literature trigger

The [research meta-graph](2026-09-11-research-meta-graph.md), especially S3105-S3114, is reused without rerunning its demonstrations. S3105 already supplies a circuit-compressed certificate escape for the old rank family. S3106 separates a missing selective transition from an unproved bound. S3107 supplies actual carry transitions but no selected frontier gain. S3111 rejects the specified full-rank tree sampler; S3112 rejects the specified dependent conditional law on exact deletion consistency. The dimension result has polynomial-time rank membership and preimage recovery. None supplies the present algorithm or a worst-case SAT barrier.

This intake serves T1/T2/T3 alignment for the bounded selection under the planning owner's literature-trigger note. Classical target: improved worst-case randomized general 3-SAT search/decision, with all inference and repetition costs charged. The parent protocol and INTEGRITY non-claims apply. Publication remains separate.

## Current primary comparisons

Sources were opened on 2026-09-12; this is a bounded search, not an exhaustive priority audit.

| Primary source | Relevant strongest comparison |
|---|---|
| [Jiang and Cai, July 2026, Theorem 1.1, Corollary 1.2 and Section 2.1](https://arxiv.org/html/2607.10697v1) | Reports randomized bases 1.306969598 for Unique-3-SAT and 1.307031578 for general 3-SAT. These improve the analysis of unchanged PPSZ using common-coordinate recombination; the existing unique-to-general lifting is unchanged. It reports the latter as best known. We use that reported frontier, without independently auditing the paper's proof. Fixed implication strength is chosen before the asymptotic input limit. |
| [Hertli et al., CP 2016, PPSZ for CSPs with more than two colors](https://www.tu-chemnitz.de/informatik/theoretische-informatik/publications/2016%20CP%20ppsz_for_csp%20with%20grant%20ack.pdf) | The finite-domain operation already removes colors contradicted by bounded inference and samples among survivors. Table 2 gives approximately 2.479 per variable for (4,3)-CSP, about 1.5745 per original Boolean variable after pairing. That generic upper guarantee is weaker than Boolean PPSZ; it is not a lower bound on the grouped subclass. |
| [Li and Scheder, ISAAC 2021, Impatient PPSZ, Section 1.2 and Theorem 1](https://drops.dagstuhl.de/storage/00lipics/lipics-vol212-isaac2021/LIPIcs.ISAAC.2021.33/LIPIcs.ISAAC.2021.33.pdf) | A stronger finite-domain comparison includes early assignment when only two colors remain, restricted to an initial portion of the random order. The paper proves an improvement on unique-solution formulas for d >= 3 and k >= 2. Mere early pair assignment is therefore not a new mechanism; its theorem does not automatically beat the Boolean general-SAT frontier after this grouping. |
| [Hansen, Kaplan, Zamir and Zwick, STOC 2019, Sections 2.3-2.4](https://people.csail.mit.edu/virgi/6.1420/papers/fasterksat.pdf) | Biased-PPSZ already uses efficiently computed types and enumerated biases, including disjoint-clause scaffolding. The useful step is a structural bias-or-forcing analysis. Naming adaptive weights or an unknown solution correlation is insufficient to add such a step. |

## Candidate A: paired contradiction-table sampling

Input is an explicit 3-CNF F with n Boolean variables, m clauses and bit length L. Remove tautologies and duplicate clauses at polynomial cost. Assume n even for description; an odd final variable is a singleton with two values. Choose a uniform random permutation and group consecutive variables into blocks. This induces a uniform matching and a uniform block order. No satisfying assignment or hidden critical-clause graph is an algorithm input.

Fix an integer D independently of n. At residual F[rho] and next block B=(x,y), compute the four-entry table

    T_B = {a in {0,1}^2 : no set H of at most D residual clauses
                          makes H together with B=a unsatisfiable}.

Compute this by enumerating clause subsets H and assignments to their variables; no SAT oracle is free. If T_B is empty, fail this run. Otherwise sample uniformly from T_B, append that pair assignment to rho, simplify, and continue. Accept only after checking the complete assignment against the original F.

The intended difference from Boolean PPSZ was to exploit a non-product pair relation before committing the first bit. A table with three surviving values costs log2(3) bits under uniform joint guessing rather than two unbiased bits. This is the specific transition proposed; the hoped-for advance was a uniform exponent saving after all stages, rather than compact representation alone.

### Preservation and full resource contract

Every original satisfying assignment survives every table along its own prefix. Table deletion is sound because its witness H is part of the residual formula. This is a lossy local test of extendibility: a surviving pair need not have any complete extension. Sampling produces only a verified witness or FAILURE. A finite unsuccessful run does not provide an unsatisfiability certificate.

Let Q_D(m)=sum_{j=0}^D binom(m,j). A direct table query costs at most O(Q_D(m) * 2^(3D+2) * poly(D,L)); all work is classical bit work. There are at most ceil(n/2) tables per run, at most four candidate colors each, polynomial input storage and streaming subset/assignment enumeration. Restriction, permutation generation, table sampling and final O(L) verification are included. Small constant-domain sampling can use exact rejection with constant expected random-bit cost; bounded caps need their own failure allowance. Intermediate formulas never exceed the input clause count. No all-solutions output, counting, proof discovery or general CNF-to-XOR recognition is supplied.

For fixed D this is polynomial work per run. D growing with n changes the cost and cannot be hidden in O*(.). Every fixed satisfying assignment has run probability at least 4^(-n/2)=2^(-n) for even n. A demonstrated better worst-case success p(n) would permit O(p(n)^(-1) log(1/delta)) independent runs with one-sided error at most delta. Time, random bits and repetitions must all be charged. A portfolio retaining ordinary PPSZ preserves its exponential guarantee up to scheduling overhead but creates no improvement by itself.

### Exact same-instance comparison

Encode each block as one four-valued variable. An original Boolean clause involves at most three blocks. Its forbidden assignments can be listed as at most eight forbidden-color tuples: each of at most three companion bits has two possibilities. Construction uses O(m) constant-size tuples and O(L) bit scale, with a constant-factor increase; satisfiability and witnesses are preserved exactly.

At the grouped-constraint level the candidate is ordinary CSP PPSZ. Under the primary papers' forbidden-tuple clause convention, D original-clause witnesses use at most 8D tuple clauses. Conversely, D tuple witnesses are implied by at most D originating Boolean clauses. Thus fixed-strength simulations require care: this is not a claim that the two conventions give exactly the same table at the identical numerical D. The independent challenger supplied this correction and the CP2016 comparison.

The algorithm's main operation is consequently already known. A stronger subclass-specific analysis could still be new, but would need an additional structural statement that is not supplied by this equivalence.

### First falsifiable obligation and its result

The proposed first local justification was: joint sampling improves, or at least preserves, the probability of every feasible target pair relative to sequential guessing with the same available local relation. That statement is false. For the surviving table {01,10,11}, sequential x-then-y unbiased guessing with sound propagation gives probabilities 1/2, 1/4, 1/4 respectively; joint sampling gives 1/3 each. It helps two targets and hurts the other. The relation is the ordinary clause x OR y, so this is a local diagnostic with an easy same-instance solver, not a hard SAT family or an algorithm runtime lower bound.

A weaker global theorem would have to control which table entries are selected by satisfying assignments along the entire random-order process. In exact terms, if T_i(pi,alpha) is the surviving table along a solution alpha's prefix, the candidate success probability is

    E_pi [ sum_{alpha satisfies F} product_i 1 / |T_i(pi,alpha)| ].

To beat the cited general-SAT frontier, this quantity needs a uniform lower bound c^(-n) / poly(L) for some explicit c < 1.307031578, with a sufficiently large fixed D and charged finite-strength errors. This identity is a target contract, not a mechanism proving that bound. Unique-case analysis alone does not import the existing Boolean PPSZ lifting theorem for this changed process.

The challenger also identified a sparse-input occupancy issue: a fixed unordered variable pair is matched with probability 1/(n-1). Summing three pairs per width-three clause, the expected number of internalized clause pairs is at most 3m/(n-1). Thus on m=O(n), direct within-clause pairing alone gives only O(1) expected opportunities, not an established linear exponent gain. Longer bounded-clause relations are not excluded by this calculation. This ordinary matching expectation does not control the exponentially weighted or tilted success measure in the sum-product formula, so it is not an upper bound on success or a runtime lower bound. No demonstration suite was run.

## Escape-route audit and conditional relevance

| Comparison | Assessment |
|---|---|
| Representation | Same instance has a linear-size finite-domain encoding, and can always return to its original Boolean encoding. Four colors do not create a harder or easier query automatically. |
| XOR / algebra | On explicitly supplied affine constraints, Gaussian elimination is a polynomial-time escape. Pair correlation is not evidence against that escape. No arbitrary-CNF recognition theorem is assumed. |
| Counting / symmetry | Uniform surviving local colors are not uniform global solution counts. Exact continuation counts would change the algorithm and are not a free oracle. No symmetry discovery or quotient guarantee is supplied. |
| Decomposition / preprocessing | Disconnected components, 2-SAT recognition and tractable residuals are available same-instance alternatives. The three-entry example is already 2-SAT. Their preprocessing/discovery work must be charged in any enlarged algorithm. |
| Proof existence / discovery | This is verified witness search, not a lower bound for a proof system or a refutation compiler. FAILURE has no short-NO-certificate claim. |
| Quantum | Entire operation is classical; no amplitude amplification, quantum preparation or readout assumption is used. |

A smaller fixed exponential base for arbitrary 3-SAT would be an algorithmic advance toward understanding worst-case search, but would not settle P versus NP. Even a polynomial-time randomized one-sided SAT algorithm would yield NP=RP, not automatically P=NP. A deterministic polynomial total-bit-time algorithm deciding every 3-CNF, for example through a proved polynomial-time construction of an adequate hitting set of runs, would imply P=NP. No such bound, derandomization or construction is supplied. Conversely, failure of this candidate would imply no separation.

## Selection and stop-loss

Select **NONE for Candidate A**, pending the independent final-file review. The grounds are the known CSP transition and failure of the stated local advantage, together with no additional specified mechanism addressing the global target correlation. This is not rejection solely because the final bound is unproved. A concrete new transition with an unproved structural estimate remains eligible under the frontier protocol.

Only one candidate was examined deeply. A second was not manufactured from generic lookahead scores or renamed adaptive biases; those ingredients already have relevant published mechanisms, and no separate structural operation was developed here. No conclusion about all algorithms, all pair strategies, or the existence of a better SAT algorithm follows. Do not open an automatic experiment, parameter optimization, encoding specialization or successor after this NONE. The broader complexity objective remains unresolved.

Provenance: the independent challenge agent contributed the fixed-strength clause-convention correction, the CP2016 comparison and the sparse matching diagnostic before final-file review. That is substantive intake contribution, not verification-only work. The author read the saved [challenge](2026-09-12-post-dimension-frontier-challenge.md), agreed with its operation-specific NONE and incorporated its explicit tilted-measure caution. Its eventual final-file verdict must be recorded separately by the planning owner.
