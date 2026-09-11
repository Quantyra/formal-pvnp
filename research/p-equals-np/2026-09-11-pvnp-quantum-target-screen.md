# Quantum target screen for actual P versus NP progress

2026-09-11. S3054 / S008 / E004, with E014 adjacency. Under README.md and INTEGRITY-CLAIMS.md. **Selection: NONE of the three examined quantum candidates meets the gate.** This is a finding about the present evidence and proposed methods, not a claim that quantum techniques cannot contribute to P versus NP.

The requirement is stronger than an interesting open problem or a valid implication: there must be a bounded first mathematical task and a concrete reason our existing method could address it. None is currently available. The deferred amplification constant question, finite success statistics, and one implementation's resource costs do not supply that reason.

An intermediate restricted result can qualify when it has a specified extension mechanism and an evidence-backed opening; the gate does not demand an immediate complete P-versus-NP proof. These candidates fail because that supported extension mechanism is missing.

## Common models and evidence

Here P, NP, PH and BQP refer to unrelativized **decision languages on explicit finite bit strings**. Quantum algorithms use uniform polynomial-time construction, a standard finite gate set or polynomially computable synthesis, polynomial workspace and bounded error on every input. A gate count must include input access, preparation and classical control. Oracle/query results and nonuniform circuit lower bounds are separately labeled.

Reused local evidence:

- [Implication map](2026-09-11-complexity-implication-map.md): distinguishes sufficient propositions from tractable approaches.
- [S3052 bridge assessment](2026-09-11-restricted-simulation-bridge-assessment.md) and [exact source contract](2026-09-11-restricted-simulation-source-contract.md): STOP the LOWESA-to-general-SAT transfer; fixed correlated angles, global acceptance, and a useful all-input gap remain missing.
- [Quantum mechanism audit](2026-09-10-quantum-sat-mechanism-audit.md): known search/backtracking speedups and heuristic evidence do not give general polynomial SAT.
- [Holographic contract](2026-09-09-holographic-sat-contract.md): the conventional common size-one planar-matchgate construction fails an exact equality/OR compatibility test. This blocks that construction, not every contraction method.
- [QAOA contribution assessment](2026-09-11-qaoa-contribution-assessment.md): HOLD publication; finite tails and construction-specific cost failures are not general algorithm lower bounds.

A height or step representation cannot itself limit every algorithm. A gate may mix many basis states; a classical algorithm may exploit the formula description without visiting the proposed nodes. Any lower bound needs an invariant proved to constrain the full target model. None of the cited local artifacts supplies such an invariant for all polynomial-time quantum or classical algorithms.

## Candidate 1: prove NP is not contained in BQP

**Exact sufficient target.** Prove that there exists a language L in NP such that no uniform polynomial-time bounded-error quantum machine decides L. Equivalently one can target SAT outside BQP: for every such machine Q, some explicit CNF F has decision error greater than 1/3. A superpolynomial lower bound against arbitrary polynomial-size quantum circuit families would be stronger than needed and must not be silently assumed.

**Implication.** P is contained in BQP. Thus L outside BQP is outside P, and P differs from NP. A quantum lower bound here is an additional burden relative to merely excluding deterministic polynomial-time algorithms; its relevance to the mission does not make it easier.

**Nearest established result.** Bennett, Bernstein, Brassard and Vazirani, [full text](https://arxiv.org/pdf/quant-ph/9701001), Theorem 3.5 and proof, pp. 8–10 of the preprint, establish a random-oracle NP lower bound for quantum time o(2^(n/2)). Their proof concerns oracle access to a length-preserving function and oracle-defined inverse-image existence. It does not prove a lower bound for a succinct CNF given in full. The phase/hybrid argument constrains changes in query answers; it does not prevent a machine from analyzing an available circuit or formula description.

**Would-be first task and why it is rejected.** One would need an explicit-input invariant that survives arbitrary polynomial quantum preprocessing while forcing superpolynomial work for an NP language. No such invariant or preservation lemma is present in our height, holographic or QAOA work. Calling it a query-to-explicit-input transfer does not shrink the obligation. Replacing the oracle by its full truth table changes the input length exponentially; replacing it by a small circuit exposes structure and requires a fresh hardness argument. Failure of our particular QAOA family cannot exclude every Q.

**Disposition: NO GO.** No bounded first lemma with a supported opening. A fresh Grover lower-bound proof, small instance search, or additional fixed-ansatz failure would be a side result under this objective.

## Candidate 2: prove PH is not contained in BQP

**Exact sufficient target.** Find a fixed finite k and a language L in Sigma_k^P with no uniform polynomial-time bounded-error quantum decision algorithm. PH is the union of these finite levels. This is an unrelativized lower-bound target, not a comparison on oracle inputs.

**Implication.** If P=NP, the polynomial hierarchy collapses to P, which is contained in BQP. Contrapositively, PH not contained in BQP implies P!=NP. The target need not identify an NP language outside BQP; it is a different sufficient route, not a license to reverse containments.

**Nearest established results and direction.** Raz and Tal's [primary paper](https://eccc.weizmann.ac.il/report/2018/107/download/), abstract and introduction, proves an oracle with **BQP^O not contained in PH^O**. Both the direction and oracle qualifier differ from this candidate. Aaronson, Ingram and Kretschmer's [The Acrobatics of BQP](https://eccc.weizmann.ac.il/report/2021/164/revision/3/download/), introduction and Section 3, additionally exhibits an oracle with P=NP but BQP different from P. Consequently even substantial quantum advantage and a classical collapse can coexist in a relativized world. This does not settle an unrelativized implication, but prevents using those oracle results as the requested P/NP conclusion.

**Would-be first task and why it is rejected.** The paper's quantum-aware restriction techniques concern oracle/query objects. Transferring a restriction bound to an explicitly encoded PH language against unrestricted polynomial quantum computation is not an identified local step. Our formal switching/restricted-proof infrastructure supplies no established transfer mechanism. Merely formalizing the oracle theorem or strengthening a bounded-depth classical comparator would not certify progress toward the target required here.

**Disposition: NO GO.** No explicit language/model-specific analytic foothold has been isolated. The apparent closeness of a hierarchy-collapse contrapositive is logical, not evidence of tractability.

## Candidate 3: one general-SAT quantum decider plus a deterministic simulation of that same family

**Exact sufficient target.** Give uniform polynomial algorithms G and S and a fixed polynomial resource bound such that, for every CNF bit string F of length N:

1. G(F) describes a polynomial-size circuit C_F whose acceptance a_F is at least 2/3 on SAT and at most 1/3 on UNSAT.
2. S(F) deterministically returns a rational b_F in polynomial bit time with `|b_F-a_F|<=1/12`.

Thresholding b_F at 1/2 gives SAT in P, hence P=NP. S may exploit that particular circuit family; full-state output and simulation of all BQP are unnecessary. If S instead succeeds only with bounded probability over its own randomness on each fixed F, direct composition gives SAT in BPP, not deterministic P without an additional derandomization argument.

**Nearest theorem already audited.** Fontana et al., [published full PDF](https://strathprints.strath.ac.uk/92079/7/Fontana-etal-QI-2025-Classical-simulations-of-noisy-variational-quantum-circuits.pdf), Theorem 1, p. 5, provides deterministic LOWESA construction but only a full-independent-angle-space RMSE guarantee. It is not a pointwise guarantee for prescribed shared QAOA angles. Its polynomial precision dependence does not make exponentially small overlaps distinguishable in polynomial input length. The observable extension also has representation/quasi-norm costs. S3052 checked these exact mismatches and found no new nonvacuous lemma; it did not prove simulation impossible.

**Would-be first task and why it is rejected.** The earlier evidence establishes neither G's all-input acceptance gap nor S's matched guarantee. Asking for both as a new lemma simply moves the unresolved problem into two premises. A simulator for already easy circuit families does not construct G. A quantum algorithm for a tractable restricted formula family does not construct a general-SAT decider. The common-basis holographic failure and finite QAOA costs give no positive construction repairing either premise.

**Disposition: NO GO.** Reopening LOWESA with only bounded degree, adding teleportation, or changing a height representation does not resolve the named missing assumptions. No repeated simulation is justified.

## Current source check and stopping decision

Primary theorem statements/proof scope in BBBV and Raz–Tal were checked in accessible full PDFs on this date; the relevant introduction/Section 3 material in *Acrobatics* was consulted for containment direction and relativization. The ECCC record lists revision 3 of *Acrobatics* (24 April 2024), with a correction to Lemma 53; the current revision retains the cited oracle separation. Fontana's published theorem and dependencies were fully audited in S3052 earlier today and reused. Targeted 2026 searches for NP/BQP/PH status yielded, among other primary records, [*Complexity of detecting large coefficients in the Pauli basis*](https://arxiv.org/abs/2606.19545), which explicitly uses NP not contained in BQP as a hardness **hypothesis**. Its abstract was used only as a recent status cross-check, not as a theorem supporting a new route. No accepted unrelativized resolution was found in this bounded check; absence from a search is not an exhaustive status proof. No later adjacent preprint is used to manufacture a candidate.

**No quantum target is recommended for a proof campaign from these three routes.** This outcome preserves the Chief Scientist's P/NP priority: the next choice should come from a demonstrable mathematical opening, not from maintaining quantum adjacency. It does not reject the independent classical assessment or unknown future quantum techniques. S3053 stays deferred, and all S3048/S3050/S3052 STOP/HOLD boundaries remain intact.

No experiments, new proofs, manuscript drafting, outreach, publication, push, or commit were performed for this screen.
