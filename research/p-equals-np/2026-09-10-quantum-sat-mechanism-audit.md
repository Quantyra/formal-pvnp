# Quantum SAT mechanism audit

2026-09-10. S3042 / E014 / E004, related S3040 / S008. Internal bounded literature and resource-contract audit, under `INTEGRITY-CLAIMS.md`. No implementation, hardware run, new theorem, publication, or general polynomial SAT claim.

## Decision

**Continue one bounded audit of fixed-angle QAOA preparation plus amplitude amplification on random 8-SAT; retain quantum backtracking as the rigorous tree baseline.** Newer sources below give this ensemble-specific candidate a more concrete research question than an ordinary DPLL demonstration. The question is whether per-instance success tails support the advertised end-to-end resource advantage. This is a research starting point, not evidence that quantum computers solve arbitrary SAT in polynomial time. Adiabatic work remains parked without an explicit gap contract.

This addresses literature triggers T1/T2/T3 after the previous route stops. It does not reopen the failed signature transformations in [the holographic contract](2026-09-09-holographic-sat-contract.md). The full-input, exact-output, preparation, precision, and witness obligations there remain useful accounting discipline; quantum bounded-error decision is explicitly a different output contract.

## Established mechanisms and exact scope

Let n be the number of explicitly represented Boolean variables, L the input bit length, m the number of clauses, K the number of satisfying assignments, and delta the allowed algorithmic failure probability.

| Mechanism | Established result and source location | What remains expensive or unproved |
|---|---|---|
| Amplitude amplification | Brassard et al., Theorems 2–3, printed pp. 6–8: a measurement-free preparation A with success probability a>0 can be amplified using O(1/sqrt(a)) calls to A and its inverse. Uniform SAT preparation gives a=K/2^n. | Each iteration pays preparation/inverse, predicate and reflections. Theorem 3's unrestricted search runs forever when a=0; do not use it alone as an UNSAT algorithm. |
| Quantum backtracking/walk | Montanaro, Theorem 1.1, printed p. 3: given a valid tree-size upper bound T, detection uses O(sqrt(T*n) log(1/delta)) evaluations each of predicate P and branching heuristic h. Theorem 1.2, p. 4: general witness-or-not-found uses O(sqrt(T)*n^(3/2)*log(n)*log(1/delta)) evaluations, without knowing T in advance. Both have failure at most delta and polynomial space for the stated backtracking framework. | P and h must be computable coherently; total gate cost is not query count. Exponential T still yields exponential cost. Stateful learned-clause solvers do not automatically fit this fixed-tree interface. |
| Adiabatic evolution | Jansen–Ruskai–Seiler, Theorem 3 and Eq. (6), printed pp. 4–5: a separated spectral subspace and bounded derivatives give an explicit adiabatic error bound involving inverse gap powers, derivatives, subspace size and evolution time. | A SAT energy encoding alone supplies none of the required uniform gap/runtime guarantees. Endpoint degeneracy and the chosen subspace require care. A small gap in one schedule does not exclude every schedule. |
| QAOA | Farhi–Goldstone–Gutmann, Section II, Eqs. (6)–(10), and Section VI: the optimum expectation over angles improves with depth and approaches the optimum as depth tends to infinity. Section VI explicitly permits exponentially large depth and distinguishes objective quality from overlap with optimal strings. | Need depth, parameter-search cost, compilation precision, shots and SAT probability. A good approximation ratio does not certify SAT or UNSAT. |

Sources: [amplitude amplification PDF](https://arxiv.org/pdf/quant-ph/0005055), [backtracking journal PDF](https://theoryofcomputing.org/articles/v014a015/v014a015.pdf), [adiabatic bound PDF](https://arxiv.org/pdf/quant-ph/0603175), [QAOA PDF](https://arxiv.org/pdf/1411.4028).

The backtracking formulas above are not claims of advantage over the best classical SAT solver. They compare the specified tree procedure. Their source's Section 3 supplies the partial-assignment implementation interface; a branch-order-dependent early SAT hit can be cheaper classically than inspecting the complete tree. No unique-solution promise is assumed here. Full-tree dependence is not a fundamental limit of quantum backtracking: [Ambainis–Kokainis, corrected v3](https://arxiv.org/abs/1704.06774v3) uses tree-size estimation to make runtime depend on the classically visited portion. This refinement must be included before any claim that our conservative baseline is the strongest known comparator; no refined gate estimate is supplied here.

## Proposed total-cost contract for the backtracking baseline

The following is our proposed accounting specification, not a measured implementation or a new theorem.

**Input and local operation.** Use a fixed, explicit CNF and a deterministic branching rule. At first, avoid learned state and randomized history. P accepts when every clause already has a true literal, rejects when a clause has all literals assigned false, and otherwise returns undecided. h selects the next unassigned variable in a predeclared ordering. Any accepted partial assignment can be completed arbitrarily and then verified against the original CNF. These rules preserve all solutions and produce depth at most n. The circuit must process negated literals, repeated occurrences, empty clauses and unused variables correctly.

**Reversible work.** Hardwire/read the formula with the cost charged; no free QRAM. Implement local clause scans, index decoding, P, h, child/parent operations, controlled reflections and their uncomputation. Let Gstep(L,n,epsilon) be the compiled gate cost of one coherent walk step to operator error epsilon, including ancilla cleanup and any conversion of node encodings. Let Qw be the proven number of walk uses for the chosen detection or witness procedure. Report

    Gtotal <= Gsetup + Qw * Gstep(L,n,epsilon) + Greadout + Gverify.

This is a ledger, not an evaluated numeric bound. Report logical qubits, peak workspace, gate count and depth separately. Do not label an abstract register operation as one physical gate. For a conservative error budget, allocate at most delta/3 to ideal algorithm failure, delta/3 to compilation (choose epsilon <= delta/(3*Qw) in a telescoping operator-norm bound), and delta/3 to implemented logical faults. Physical error-correction cost is a further model, not presently estimated.

**Tree size and output.** Detection needs a justified T upper bound. Full tree enumeration to obtain T costs work and cannot be free preprocessing. Tiny-instance enumeration is permitted only as benchmark ground truth; an actual solver must use an analytic upper bound or the source's adaptive witness procedure with its costs. SAT output includes a classically checked assignment, costing a formula scan. UNSAT/not-found remains a bounded-error decision under the algorithm's complete budget, not a classical refutation certificate. Repetition reduces error; it does not create a deterministic proof.

**Mandatory controls.** Compare the identical classical tree traversal, a strong conventional SAT solver, and uniform Grover search. For Grover's decision control, use a finite O(2^(n/2)) constant-error search budget with unknown K, independently repeat O(log(1/delta)) times, and verify every candidate. A satisfactory derivation must give its cutoff constant: it follows by truncating the positive-success expected bound at a constant multiple of its worst case and applying Markov's inequality. With no solution, verification never accepts. The resulting conservative total is O((Gpredicate+n)*2^(n/2)*log(1/delta)) plus setup. This extension is our stated accounting inference, not Theorem 3's literal forever-running algorithm.

**Geometric meaning.** A quantum walk uses phase and interference across adjacent partial assignments. It need not explicitly traverse every classical branch. Tree height n is only one parameter: T can approach 2^(n+1)-1 even with that height. Teleportation of the represented state does not remove T from this contract. A theorem replacing the expensive dependence by a polynomial would require additional mathematical structure, not merely a physical relabeling of a step.

## Why a resource checkpoint is discriminating

Campbell–Khurana–Montanaro, *Applying quantum algorithms to constraint satisfaction problems* (2019), already compare compiled Grover and backtracking methods with classical solvers. Their Section I and later resource tables show why oracle overhead and fault-tolerance matter; under their studied k-SAT regimes, Grover can beat quantum backtracking at usable sizes despite backtracking's asymptotic appeal. Their abstract also reports loss of advantage when charging their surface-code classical decoding processing. Their estimates are historical, assumption-dependent predictions, not current hardware measurements or guarantees for our inputs. [Author-hosted full text](https://people.maths.bris.ac.uk/~csxam/papers/aquacsp.pdf).

The useful unknown here is therefore **whether our explicitly chosen family and coherent pruning operation produce enough reduction in T to pay for their gate overhead**. That is narrower and testable. There is no novelty claim for combining ordinary DPLL with this known quantum walk.

## Next discriminating action and stop-loss

### Newer primary evidence changes the priority

Boulebnane–Montanaro (2024), [PRX Quantum 5, 030348](https://journals.aps.org/prxquantum/pdf/10.1103/PRXQuantum.5.030348), studies fixed-angle QAOA success on random k-SAT. Proposition 3 (p. 14) expresses ensemble-average success; Section II's asymptotic analysis has a sufficiently-small-angle justification. Section III C and Fig. 4 distinguish mean-success-derived scaling from median runtime and small-instance fits. The reported random 8-SAT scaling advantage beyond roughly 14 layers is a numerical/analytic prediction against tested solvers, not an all-instance theorem. The paper explicitly discusses amplitude amplification. These are more targeted grounds for investigation than a generic low-energy landscape.

The [2025 QAOA+AA resource study, arXiv:2504.01897](https://arxiv.org/abs/2504.01897) reports an assumption-dependent crossover with large physical resources. Only its current abstract was checked in this audit; its numerical crossover is not independently validated here and should not be adopted as an operational forecast.

Brehm–Weggemans, [*Assessing fault-tolerant quantum advantage for k-SAT with structure*](https://ir.cwi.nl/pub/36210/36210.pdf), accepted 2025-12-29, Sections 3.1–3.2 and Tables 2–4, examines structure-sensitive classical/Grover/backtracking comparisons. It finds severe practical limits in its tested regimes, particularly when witness recovery and gate count are charged. Section 4.1 leaves better heuristics open. This is evidence against assuming a routine tree speedup becomes practical advantage, not a theorem excluding every quantum algorithm or the QAOA candidate.

### Selected follow-up: per-instance success and complete decision cost

Route one bounded follow-up to successor S3043 (from checkpoint S3042), before any implementation campaign:

1. Extract and verify the 2024/2025 QAOA+AA scaling assumptions, formula ensemble, fixed angles, training costs and per-instance success-to-runtime conversion. In particular distinguish E[a(F)], E[1/a(F)], E[1/sqrt(a(F))], medians and low quantiles on satisfiable instances. They are different statistics; 1/sqrt(E[a(F)]) is not a justified average runtime estimate. Preserve the UNSAT mass rather than silently conditioning it away.
2. Form the resource inequality for each satisfiable F: `(2*G_A(F)+G_predicate(F)+G_reflections(F))/sqrt(a(F))` versus uniform Grover and paired classical early-stopping cost, adding amplification constants, compilation, readout and faults. A polynomial gate advantage within this family is a bounded quantum target even if both runtimes remain exponential. Derive the minimum success probability needed to beat the comparator at each depth; require a proved lower bound or measured distribution with uncertainty, never just a favorable mean.
3. Resolve the missing decision rule. If a(F) has no known lower bound on every satisfiable input in the claimed scope, failure to sample a witness is UNKNOWN. One conservative total solver can follow a failed budget with ordinary bounded-error Grover; that keeps an exponential fallback and its full cost. A classical complete solver fallback is another explicit option. Assess whether the claimed gain survives including those calls and mixed SAT/UNSAT workloads. No assumed positive success floor may be imported from an ensemble mean.

The artifact should be a checked assumptions-and-threshold table, plus a GO/STOP decision on whether small simulations would discriminate an unresolved claim. This is a concrete audit/proof-obligation target, not yet a new algorithm contribution. The older generic benchmark outline below is subordinate; do not launch it as a separate routine demonstration:

1. Freeze a small, reproducible benchmark contract with SAT and UNSAT instances, easy controls, and one structured family. Record exact classical-tree definitions, branching order, paired classical solvers, seeds and limits before results.
2. Derive a reversible resource estimate for the specified P/h operations and compare complete budgets with the Grover control. Tiny ideal simulations may validate probabilities and compilation, but simulation wall time is not quantum execution time and small instances establish no asymptotic advantage.
3. Continue only if a reproducible cost reduction or a precise structural conjecture survives. If overhead erases the gain, record that failure; do not compensate by omitting preprocessing, UNSAT cases, inverses, readout, repetitions or classical baselines.

No hardware/cloud spend, implementation, or new proof campaign occurred in this audit. Implementing QAOA or adiabatic evolution still requires an explicit Hamiltonian/mixer, parameter preparation procedure, measured observable, SAT/UNSAT decision rule and resource bound to test. Neither attractive low-energy plots nor selected satisfiable instances satisfy that contract.

## Evidence limits and non-claims

Primary PDFs were accessed on 2026-09-10; theorem statements and indicated sections were readable. This is a canon-first bounded audit, not an exhaustive 2026 algorithm survey and not a claim that the quoted backtracking bound is the latest or strongest known bound. No latest hardware parameters or present-day solver rankings were asserted. Existing worktree status was empty before this agent wrote its one owned artifact; this artifact is intentionally left uncommitted for parent review.

Established quantum speedups do not establish P=NP. A polynomial bounded-error quantum SAT algorithm would place SAT in BQP; an additional deterministic classical polynomial simulation/decision argument would still be needed for P=NP. This audit provides no such algorithm, simulation or new lower bound, and changes no public claims.
