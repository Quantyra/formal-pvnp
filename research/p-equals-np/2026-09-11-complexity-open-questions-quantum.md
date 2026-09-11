# Quantum complexity: open questions and bounded paper candidates

2026-09-11 snapshot. S3049 / E014 / E004; selective companion to the classical catalog. Research-planning evidence under `INTEGRITY-CLAIMS.md`, not new proofs, a comprehensive survey or authorization to execute every candidate. **The most credible near-term targets are Q8, Q11 and Q12 below.** Their novelty is unverified; routine application or numerical reproduction alone is not a research contribution.

Status means no general resolution was found in the dated primary-source check, with specific recent results distinguished from the remaining question. Most new references were checked at author abstract/introduction level, not fully proof-audited. The QAOA papers have the deeper preceding local audits. Each proposed subquestion is our research suggestion, not a quotation or a claim that nobody has studied it.

Use uniform polynomial-size quantum circuits with a fixed efficiently approximable gate set and bounded error unless stated otherwise. BQP concerns decision languages; QMA and its variants are conventionally promise classes. Sampling, function, oracle, advice and promise variants must not silently replace the stated question. P ⊆ BPP ⊆ BQP ⊆ PP ⊆ PSPACE and BQP ⊆ QCMA ⊆ QMA are standard containments; BQP is closed under complement. [Watrous, *Quantum Computational Complexity*](https://arxiv.org/abs/0804.3401), sections on polynomial-time quantum computation and quantum proofs, supplies definitions and background rather than current-status certification.

## Q1. Does P = BQP? Does BPP = BQP?

**Open, major separation/collapse questions.** Distinguish deterministic classical simulation from randomized classical simulation. Shor's algorithms do not prove either separation because classical polynomial-time factoring is not excluded. Oracle advantages do not establish unrelativized advantages. [Bernstein–Vazirani, *Quantum Complexity Theory*](https://doi.org/10.1137/S0097539796300921) is foundational; [Bennett et al., *Strengths and Weaknesses of Quantum Computing*](https://arxiv.org/abs/quant-ph/9701001), abstract and introduction, explains the oracle boundary.

**P-vs-NP implication:** P=BQP alone does not place NP in P; it would do so together with NP⊆BQP. P≠BQP alone is not known to imply P≠NP. P=BQP implies BPP=P, but BPP=BQP alone does not establish deterministic simulation.

**Smaller candidate:** for an explicitly specified bounded-treewidth QAOA circuit family, prove a uniform classical sampler with total-variation error ε and polynomial dependence on input length and 1/ε, counting the decomposition cost. Nearest baseline is Q8's simulation literature. **Tractability:** moderate for a sharply restricted family; likely routine without an improved structural parameter. The headline equality is not a paper-sized deliverable.

## Q2. Is NP ⊆ BQP; equivalently, is SAT in BQP?

**Open, major algorithmic question.** SAT is complete under classical polynomial reductions. A quantum SAT decision algorithm must work on every formula with controlled error, including UNSAT. Black-box search lower bounds apply to oracle access, not arbitrary explicit CNF algorithms. [Bennett et al.](https://arxiv.org/abs/quant-ph/9701001) prove random-oracle lower bounds; this does not settle explicit SAT.

**P-vs-NP implication:** NP⊆BQP does not by itself prove P=NP. Conversely, NP⊈BQP would imply P≠NP, since P⊆BQP. A deterministic classical polynomial SAT algorithm would prove P=NP.

**Smaller candidate:** a theorem for one explicit bounded-degree or bounded-width SAT family giving total coherent preparation, search, witness extraction and UNSAT error costs against its best classical parameterized algorithm. Nearest work: [Montanaro, quantum backtracking](https://arxiv.org/abs/1509.02374), and Q11. **Tractability:** moderate only after narrowing; a speedup over exhaustive search is insufficient if dynamic programming already solves the family efficiently.

## Q3. Is BQP contained in PH? Is PH contained in BQP?

**Both unrelativized containments remain open; they are different directions.** [Raz–Tal, *Oracle Separation of BQP and PH*](https://eccc.weizmann.ac.il/report/2018/107/), abstract and oracle corollary, prove the existence of O with BQP^O ⊈ PH^O. They do not prove BQP⊈PH or PH⊈BQP without an oracle.

**P-vs-NP implication:** BQP⊈PH alone is not known to settle P vs NP. PH⊈BQP would imply P≠NP, because P=NP collapses PH to P⊆BQP. PH⊆BQP implies NP⊆BQP but not P=NP.

**Smaller candidate:** formalize one finite-query hybrid/Fourier lemma used in a Forrelation lower bound with explicit error and query parameters, then seek a quantitatively stronger bound for a specified restricted circuit model. Nearest work: Raz–Tal and [Wu's stochastic-calculus simplification](https://arxiv.org/abs/2007.02431). **Tractability:** formal verification is feasible background work; novelty of a stronger inequality is unknown and difficult. No credible direct unrelativized-separation plan yet.

## Q4. Does QMA = QCMA?

**Open without an oracle.** QMA allows polynomial-size quantum witnesses, QCMA classical witnesses with a quantum verifier. **The standard classical-oracle separation is no longer open:** [Bostanci–Haferkamp–Nirkhe–Zhandry](https://arxiv.org/abs/2511.09551), November 2025, construct one via spectral Forrelation; [Bostanci–Huang–Vaikuntanathan](https://arxiv.org/abs/2602.09385), February 2026, give a good-code construction and additional advice separations. These are relativized results, not an unconditional separation of the ordinary classes.

**P-vs-NP implication:** neither proposed equality nor inequality has a known direct implication deciding P vs NP. Classical witness length and quantum verification cannot be replaced with NP verification.

**Smaller candidate:** audit the good-code oracle's membership-query and list-recovery parameters against an explicitly bounded witness model; ask whether a sharper witness-length/query tradeoff holds for that model. **Tractability:** difficult specialist work; oracle implementation on hardware is not the missing theorem. Nearest-work overlap is especially high after the 2026 result; no novel sublemma identified yet.

## Q5. Does QMA = coQMA?

**Open.** This asks whether every quantum-verifiable YES promise also has a quantum-verifiable NO promise. BQP⊆QMA∩coQMA. [*Characterizing the intersection of QMA and coQMA*](https://arxiv.org/abs/2102.03108), abstract, relates total functional quantum witnesses to this intersection. [Vinkhuijzen–Deutz, ECCC TR19-131](https://eccc.weizmann.ac.il/report/2019/131/), abstract, derives PH⊆QMA under QMA=coQMA; this is a consequence of a hypothesis, not proof of that hypothesis.

**P-vs-NP implication:** no direct resolution is known from the equality or its negation. In particular, PH⊆QMA is not PH=P.

**Smaller candidate:** for a restricted Hamiltonian family, define checkable upper- and lower-energy certificates with an explicit promise gap and prove where their verification class lies. Begin with commuting/projector structure, retaining a gap that cannot be scaled away. **Tractability:** potentially moderate for a new restricted family, but known stabilizer/commuting special cases make novelty uncertain. This links to our SAT+UNSAT contract discipline, not a claimed path to general quantum NO certificates.

## Q6. Does QMA = QMA1 (perfect completeness)?

**Open in the usual finite-register model.** [Jeffery–Witteveen, *QMA = QMA1 with an infinite counter*](https://arxiv.org/abs/2506.15551), abstract, establishes the modified infinite-counter statement and a finite amplification result extremely close to completeness one. It does not establish ordinary QMA=QMA1. [Aaronson–Harris–Witteveen, *Limits to black-box amplification in QMA*](https://arxiv.org/abs/2509.21131), abstract, gives quantitative black-box limitations via a quantum oracle.

**P-vs-NP implication:** none known directly. Near-perfect completeness is not exact completeness, and neither makes the verifier deterministic classical polynomial time.

**Smaller candidate:** a finite-precision robustness theorem for one explicitly fixed amplification schedule, accounting for synthesis error, preparation and rejection on both sides of the promise. Nearest work is the two 2025 papers and standard QMA amplification; our AA schedule audit is a methodological connection, not the same theorem. **Tractability:** moderate numerical/error bookkeeping; genuine novelty needs a new bound or regime, not re-proving black-box amplification.

## Q7. Does the Hamiltonian quantum PCP conjecture hold?

**Open.** For some constant locality k and constants a<b, ask whether distinguishing λmin(Σ_i H_i)≤am from λmin(Σ_i H_i)≥bm is QMA-hard, where 0≤H_i≤I and there are m local terms. Fix the reduction notion explicitly; the proof-verification formulation permits quantum reductions. Ordinary inverse-polynomial-gap Local Hamiltonian completeness does not establish a constant relative gap. [Aharonov–Arad–Vidick](https://arxiv.org/abs/1309.7495) specifies the conjecture.

**Settled/distinct:** [Anshu–Breuckmann–Nirkhe](https://arxiv.org/abs/2206.13228) prove NLTS, a low-energy circuit-depth obstruction, not QMA-hardness. [Natarajan–Nirkhe 2024](https://arxiv.org/abs/2403.13084) correct a games-PCP amplification claim and distinguish games from Hamiltonians. [Sun–Vidick, June 2026](https://arxiv.org/abs/2606.09588) obtain an interactive polylog-query characterization; interaction and polylogarithmic queries do not solve constant-query noninteractive qPCP.

**P-vs-NP implication:** a qPCP theorem is a hardness equivalence, not a proof that the complete problem is outside P. No direct P-vs-NP resolution follows.

**Smaller candidate:** a quantitative obstruction to one specific proposed gap-amplification transformation, tracking locality, term norm, relative gap and Pauli-support growth. Nearest work is the 2024 correction and its suggested weaker spectral restrictions. **Tractability:** difficult but bounded; do not propose re-proving NLTS as an open target.

## Q8. Where exactly does efficient classical simulation stop for restricted circuits?

**Open classification program, not one universal conjecture.** State the circuit family, noise channel, observable/output task and error metric first. Exact strong simulation, one-observable additive estimation, and approximate sampling are different tasks. Clifford/stabilizer and suitable low-width families already have efficient simulation algorithms.

Recent nearest work sharply limits broad claims: [Rajakumar–Watson–Liu, SODA 2025](https://www.nist.gov/publications/polynomial-time-classical-simulation-noisy-iqp-circuits-after-constant-depth) give efficient sampling for IQP circuits with specified dephasing/depolarizing noise beyond a critical constant depth. [Fontana et al., 2025](https://doi.org/10.1038/s41534-024-00955-1), discussion, give average-over-parameter error guarantees and explicitly distinguish correlated-parameter limitations. These are not simulation theorems for every low-noise QAOA circuit.

**P-vs-NP implication:** efficient simulation of a restricted family alone settles nothing about SAT. Efficient randomized weak simulation of all BQP circuits would give BPP=BQP, not automatically P=NP.

**Smaller candidate, priority:** for fixed-angle, correlated-parameter bounded-degree QAOA, prove either a uniform Pauli-truncation error bound for one specified observable or an explicit family witnessing failure of that proposed bound. Count dependence on depth, noise and cutoff. **Tractability:** moderate; nearest-work audit must rule out a direct existing corollary. SAT success is a global projector, so a local-energy guarantee cannot be substituted for overlap accuracy.

## Q9. Can approximate sampling advantage rest on weaker average-case assumptions?

**Open robustness/average-case-hardness program.** For a specified random boson-sampling or circuit ensemble and constant total-variation sampling error, prove the required probability-estimation hardness and anticoncentration with explicit parameters. Worst-case exact #P-hardness alone is insufficient. [Aaronson–Arkhipov](https://arxiv.org/abs/1011.3245) develops the conditional framework. [Bouland et al., updated *Exponential improvements to the average-case hardness of BosonSampling*](https://arxiv.org/abs/2411.04566), abstract, improve robustness substantially while retaining a gap to the full approximate-sampling target. [PRX 16, 021059, June 2026](https://doi.org/10.1103/xc7b-sjm5) addresses linear-mode density, still with explicit average-case assumptions.

**P-vs-NP implication:** proving a conditional hardness theorem is not proving its assumptions. PH noncollapse would imply P≠NP, but a sampler causing a collapse to a finite PH level does not by itself imply P=NP. Sampling hardness is not a quantum SAT algorithm.

**Smaller candidate:** an assumption ledger and reduction for one collision/noise regime, distinguishing total variation, relative probability error and instance-failure fraction. **Tractability:** ledger feasible but not automatically publishable; removing a genuine robustness gap is hard and outside our present SAT evidence base. Avoid hardware-only “advantage verification” claims from a proxy score.

## Q10. Are quantum ETH/SETH hypotheses true, and what do they imply?

**Open assumptions, not lower-bound theorems.** A quantum ETH version asserts no bounded-error 2^o(n)-time quantum algorithm for 3-SAT. A SAT-based quantum SETH version asserts that for every ε>0 there is a clause width k for which k-SAT has no O(2^((1/2−ε)n)poly(n))-time quantum algorithm. The width quantifier matters. More general QSETH frameworks have additional compression/black-box assumptions; they are not interchangeable.

Nearest primary sources: [Aaronson et al., closest pair](https://arxiv.org/abs/1911.01973) and [Buhrman–Patro–Speelman, QSETH framework](https://arxiv.org/abs/1911.05686). [Chia–Shen, 2025](https://arxiv.org/abs/2510.07495) gives conditional fixed-locality Hamiltonian bounds; do not present those as unconditional quantum lower bounds.

**P-vs-NP implication:** proving a quantum ETH/SETH lower-bound hypothesis of this SAT form would imply P≠NP. Refuting it by a faster exponential algorithm would not prove P=NP, or even SAT∈BQP.

**Smaller candidate:** for one CNF-to-local-Hamiltonian encoding, audit variable/ancilla blowup and promise-gap precision to determine the exact transferred exponent. **Tractability:** moderate as a correctness audit; a paper needs a new reduction or demonstrably stronger parameter tradeoff. Existing conditional fixed-locality results rule out claiming that entire direction is unexplored.

## Q11. Can structural query speedups survive nonuniform node costs and coherent memory costs?

**Open for specified SAT/search families; broad variable-time query frameworks already exist.** [Vihrovs, *Quantum Search on Computation Trees*, v2 November 2025](https://arxiv.org/abs/2505.22405), abstract, gives marked-vertex detection using O(√(TD)) step queries with depth D and T=Σ_v t_v², where t_v is a node-computation time. Its unknown-time search query bound is stated as optimal; rediscovering it is not an open target. Detection is not automatically witness extraction or a full gate bound.

**P-vs-NP implication:** oracle/step-query lower or upper bounds do not settle explicit SAT time complexity. Even a quadratic speedup of an exponential tree is exponential.

**Smaller candidate, priority:** freeze one reversible bounded-degree DPLL branching/pruning policy and prove total gate/space cost as a function of its actual per-node times and first-solution traversal, comparing with the same classical early-stopping policy and a stronger classical solver. No free clause learning, tree construction or coherent RAM. Nearest work includes [Campbell–Khurana–Montanaro](https://arxiv.org/abs/1810.05582), [Ambainis–Kokainis](https://arxiv.org/abs/1704.06774v3), Vihrovs, and [Brehm–Weggemans, 2026](https://doi.org/10.22331/q-2026-01-20-1975). **Tractability:** moderate for a parameterized theorem; practical advantage may disappear after accounting. This directly tests the user's “height” intuition without assuming tree height is all the work.

## Q12. When do QAOA success gains yield an expected-cost advantage after amplification?

**Open for a rigorously fixed ensemble/circuit/cost model; proposed local research question.** Let a_F be a formula's SAT success probability under a frozen circuit. Can one prove lower-tail control strong enough to bound E[a_F^(-1/2)] and total restarted-AA cost against a stated classical comparator? A bound on E[a_F] alone does not answer this. SAT-conditioned and unconditional distributions must remain separate, and a_F=0 requires an explicit policy.

Nearest work: [Boulebnane–Montanaro 2024](https://doi.org/10.1103/PRXQuantum.5.030348), [the 2025 QAOA/AA resource paper](https://arxiv.org/abs/2504.01897), and [Brehm–Weggemans 2026](https://doi.org/10.22331/q-2026-01-20-1975). The local [S3043 source audit](2026-09-10-qaoa-full-source-audit.md), [S3044 inventory](2026-09-10-qaoa-data-inventory.md), and [S3045 recovery](2026-09-11-qaoa-source-recovery.md) already document assumptions and provenance limits. A mean-exponent fit or one small-instance replay is not a tail theorem.

**P-vs-NP implication:** none from a fixed-ensemble average-case speedup. Even uniform polynomial quantum SAT cost would establish NP⊆BQP, not P=NP without classical derandomized simulation.

**Smaller candidate, priority:** prove an explicit tail-to-resource sufficient condition for a fixed restart/fallback policy, then identify a stated sparse factor-graph family where it is nonvacuous or establish a counterexample to the required tail assumption. **Tractability:** moderate for the cost theorem, high difficulty for useful ensemble tail bounds. Elementary Jensen inequalities and finite-data summaries alone are unlikely to be novel. Reuse the proposed S3048 cost-accounting scope rather than opening a duplicate proposal; no new simulation is authorized by this catalog.

## Settled results and stale-list traps

| Tempting “open problem” | Correct status and boundary |
|---|---|
| QIP versus PSPACE | [Jain–Ji–Upadhyay–Watrous](https://arxiv.org/abs/0907.4737) proved QIP=PSPACE. Interaction with a prover is not BQP computation. |
| Whether entangled multiprover proofs reach only decidable languages | [Ji et al.](https://arxiv.org/abs/2001.04383) proved MIP*=RE. Unbounded provers and unrestricted entanglement resources are not efficient SAT solvers or teleportation shortcuts. |
| Existence of NLTS Hamiltonians | Proved; see Q7. Not the Hamiltonian qPCP theorem. |
| Standard classical-oracle separation QMA/QCMA | Proved in 2025–26; see Q4. Ordinary QMA/QCMA remains open. |
| Optimal unknown-time search query scaling | Vihrovs' 2025 result resolves its stated query-model question; see Q11. Gate/space cost for a concrete encoding remains separate. |
| Best certificate-versus-quantum-query exponent as a safe old open question | [Ambainis–Iraids–Kokainis, arXiv:2609.11664](https://arxiv.org/abs/2609.11664), submitted September 10, 2026, claims a near-quartic separation tight up to logs. Very recent preprint, abstract checked only: review the proof before relying on it, but do not pitch the previous open question as untouched. |

## Prioritization and next gate

1. **Q12:** closest to existing evidence. First compare the proposed tail/restart theorem precisely against current AA and resource analyses; stop if it is only standard probability algebra with renamed parameters.
2. **Q11:** strongest connection to tree-height intuition and reversible algorithm design. First specify one branching/pruning policy and audit whether existing computation-tree theorems already imply the desired cost bound.
3. **Q8:** credible quantum-computing alternative. First determine whether correlated fixed angles and the chosen global/local observable fall outside the published simulator's guarantee, rather than merely outside its experiments.

Q1–Q7 are strategic questions and training directions, not realistic promises of quick papers. Q9–Q10 require specialist tools and careful assumptions. Before promoting any suggestion, require a focused full-text nearest-work review, a one-sentence new theorem or counterexample target, its exact model/quantifiers, and a plausible falsifying result. Only then create an execution story. None of these directions currently establishes or implies a local P=NP/P≠NP result.

Search/access log: primary-source searches on 2026-09-11 included explicit 2025/2026 status terms for BQP/NP/PH, QMA/QCMA/coQMA/perfect completeness, qPCP/NLTS, noisy simulation, average-case sampling hardness and quantum ETH/SETH. Recent papers dated through this snapshot were considered; repository abstracts and publisher/author pages were accessed successfully. General web results and open-problem aggregators were discovery aids only, not cited as theorem evidence. A dated search is not a proof that no later or less-visible resolution exists; status and novelty must be refreshed before publication.
