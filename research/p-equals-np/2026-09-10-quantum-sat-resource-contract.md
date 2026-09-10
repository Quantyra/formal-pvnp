# Quantum SAT resource contract and bounded interference question

S3042 / E014 / E004, related S3040 / S008, 2026-09-10. Literature/resource audit in the satellite research surface, under `INTEGRITY-CLAIMS.md`. No implementation, hardware run, Lean theorem, P=NP result, or demonstrated quantum advantage. Read with the September 9 holographic contract and September 8 consolidation attack specification. Those specific classical obstructions do not automatically transfer to quantum circuits.

## Disposition

Proceed with a bounded quantum-algorithm investigation, keeping **quantum advantage** separate from **a classical P=NP proof**. Standard coherent verification plus amplitude amplification is a concrete baseline. The useful candidate is a formula-dependent interference circuit that improves initial satisfying overlap enough to repay preparation and inverse-preparation costs. Entanglement and teleportation are available mechanisms, not standalone complexity guarantees.

## 1. Exact height encoding

Let F be an explicitly encoded CNF on n variables with m clauses and input length L including literal occurrences. Remove tautological clauses and repeated literals by polynomial preprocessing; handle an empty clause directly. Computational basis vector |x> represents a full assignment, not a partial-search-tree node. Define

    E_F(x) = number of clauses violated by x,
    H_F = sum_c P_c,
    P_c = product over literals l in c of Q_l,
    Q_(x_i) = (I + Z_i)/2,
    Q_(not x_i) = (I - Z_i)/2.

These diagonal projectors act as identity on variables outside the clause. With Z|0>=|0> and Z|1>=-|1>, H_F|x>=E_F(x)|x>. Thus zero energy exists exactly when F is satisfiable. The explicit matrix has dimension 2^n, but its clause description is polynomial. A polynomial description does not supply a ground state.

For 3-CNF, each projector is at most 3-local. For general CNF, reversibly computing clause flags avoids expanding every projector into exponentially many Pauli terms. One may alternatively use the prior contract's polynomial, uniquely extendible 3-CNF conversion, charging the added variables: uniform search over auxiliaries can change search cost, so preserve original-variable search with coherently computed auxiliary values when comparing baselines.

Height is a constraint-violation score. Under a transverse-field mixer, bit-flip edges connect Hamming-neighbor assignments. This geometry differs from a tree whose depth is n. A small energy separation at the *final* Hamiltonian does not bound the minimum spectral gap along an interpolation or supply an initial ground-state overlap.

## 2. Implementable standard quantum baseline

Compile the ordinary CNF verifier into a clean reversible circuit

    U_F |x>|b>|0...0> = |x>|b XOR F(x)>|0...0>.

Store intermediate Boolean gate values, copy the final bit, then reverse the computation. This elementary construction uses polynomial workspace and gates; a direct formula circuit has O(L) Boolean gates, and a clean Toffoli/CNOT/X compilation has O(L) logical gates and ancillas under ordinary all-to-all logical connectivity. Routing and fault tolerance are additional costs on an actual device.

Prepare |+>^n in n Hadamards. Phase kickback through U_F marks satisfying assignments, and reflection about |+>^n completes a Grover iterate. Ancillas must be uncomputed before diffusion. If M>0 assignments satisfy F, initial success is a=M/2^n. Established amplitude amplification costs O(1/sqrt(a)) uses of preparation, its inverse, and verification at constant success probability. Unknown success probability can be handled without knowing M in advance. [Brassard et al., *Quantum Amplitude Amplification and Estimation*](https://arxiv.org/abs/quant-ph/0005055)

Use a bounded unknown-solution search schedule, capped at O(2^(n/2)) iterations for constant error, and independent repetitions for error delta. Measure candidates and check them against the original CNF. A true UNSAT instance never yields a verified witness; after the cap return a bounded-error UNSAT decision. On SAT instances the probability of this erroneous decision must be at most delta. It is not a deterministic UNSAT certificate. The resulting worst-case logical gate bound is O(poly(L) 2^(n/2) log(1/delta)), with explicit schedule constants to be fixed in any implementation. The unknown-count search and oracle lower bounds are established by [Boyer et al., *Tight bounds on quantum searching*](https://arxiv.org/abs/quant-ph/9605034). The lower-bound scope is unstructured oracle search, not every algorithm inspecting CNF structure.

## 3. Resources a proposed shortcut must pay

| Item | Obligation |
|---|---|
| Circuit construction | Uniform polynomial-time compiler from F; no solution-dependent advice. |
| Initial state A_F|0> | Charge all gates, data loading, ancillas, parameter selection, failed preparations, and A_F inverse. |
| Interference | Give explicit finite gates and a success probability, not merely a large entangled state. |
| Precision | Finite angle descriptions and synthesis accuracy; bound accumulated error over the entire amplified circuit. |
| Amplification | For overlap a_F, charge preparation and inverse on each use: approximately (C_A + C_Ainv + C_verify + C_reflect)/sqrt(a_F) on successful instances, plus error controls. |
| No-solution case | A justified stopping rule and uniform error bound; absence of a sampled witness alone is insufficient. |
| Readout | Measure an assignment and verify it. No free list of amplitudes, exact exponentially small probabilities, or whole-state tomography. |
| Classical control | Charge parameter search, training, repeated circuits, and any preprocessing or classical solver calls. |
| Hardware | Count connectivity/routing, error correction, total shots, and wall-clock costs separately from logical complexity. |

Postselecting the verifier output to 1 would produce only satisfying assignments, but the raw success probability is M/2^n and is zero on UNSAT inputs. Ordinary rejection repeats cost inverse probability; amplification gives the square-root improvement above. Treating arbitrary rare outcomes as freely selectable changes the model: PostBQP=PP is the precise established result, not BQP=PP. [Aaronson, *Quantum Computing, Postselection, and Probabilistic Polynomial-Time*](https://arxiv.org/abs/quant-ph/0412187)

Teleportation transfers an already prepared qubit using an entangled pair, a measurement, two classical bits and a correction. It does not map a nonsolution assignment into a solution or select an unknown computational destination. Gate teleportation still requires preparing its resource states and applying corrections. The original protocol is [Bennett et al., *Teleporting an unknown quantum state via dual classical and Einstein-Podolsky-Rosen channels*](https://people.disim.univaq.it/~serva/teaching/Bennet.1993.pdf).

## 4. Bounded interference question for candidate selection

This is a concrete candidate question, not a separately queued experiment. The companion mechanism audit and review select the next investigation after assessing newer QAOA-plus-amplification resource studies. If selected, test this precise candidate preparation on small explicitly enumerated CNFs:

    A_F(beta,gamma) = exp(-i beta sum_i X_i) exp(-i gamma H_F) H^(tensor n).

This is the depth-one alternating cost/mixer construction, within the established QAOA family, not a new paradigm. Its clause phase gates commute and can be compiled by computing each violation flag, applying a phase, and uncomputing. A phase layer alone preserves all measurement probabilities; the mixer is essential. QAOA's original optimization results do not establish exact general SAT success or efficient UNSAT recognition. [Farhi, Goldstone and Gutmann, *A Quantum Approximate Optimization Algorithm*](https://arxiv.org/abs/1411.4028)

**Question:** Does a fixed, preregistered angle pair improve the gate-adjusted satisfying-overlap score `(C_A+C_Ainv+C_verify+C_reflect)/sqrt(a_F)` over uniform-state amplification on held-out CNFs matched for n, m and M but with different clause incidence geometry?

A bounded first test would use n=4..12, include unique/multiple-solution and UNSAT controls, fix an angle grid and training/held-out split before results, and record all tested parameters. Exhaustive counting is permitted only for offline evaluation and corpus matching; it must not enter the proposed algorithm. Report raw overlap, preparation gate cost, gate-adjusted amplification estimate, worst instances and distributions. Compare uniform amplification and an explicit classical solver as separate baselines. Do not call the score a complete decision runtime: it does not include a proved unknown-overlap stopping guarantee or the tuning charge. Here C_A and C_Ainv are forward and inverse preparation costs. UNSAT controls have zero satisfying overlap and are excluded from the overlap ratio; evaluate their no-witness behavior and stopping/error contract separately. Finite-precision simulation must have numerical cross-checks; it supplies bounded evidence only.

This can falsify a specific cheap geometry-sensitive preparation hypothesis. It does not assume the desired overlap bound, and a positive small-instance result is neither an asymptotic speedup nor grounds to claim a polynomial SAT algorithm. An entanglement statistic by itself is not the success metric. A future general claim needs an actual all-input lower bound on overlap or a different explicit mechanism, along with total polynomial costs and reliable UNSAT handling.

## 5. Complexity interpretation

A uniform polynomial-resource quantum SAT decision procedure with bounded error would put SAT in BQP and hence NP inside BQP; it would not establish P=NP. An efficient classical randomized sampler reproducing such a procedure's output with sufficiently small total-variation error would give a bounded-error randomized classical SAT decision algorithm (SAT in BPP), not automatically a deterministic one. If it outputs witnesses with adequate success, classical witness verification gives a one-sided randomized search route. A deterministic polynomial-time approximation of the relevant acceptance probability to additive error smaller than half the separation between the amplified acceptance and rejection probability bounds would instead permit deterministic thresholding and put SAT in P. These are separate obligations. Simulating teleportation or a restricted circuit family alone has no such consequence unless that family contains the complete efficient SAT solver.

Review target: validate the resource/error contract and narrow experiment question before implementation; do not route-close a general quantum SAT claim from this note.


## 6. Priority relative to quantum backtracking

Grover remains the uniform baseline and quantum backtracking supplies a rigorous structured baseline. Final candidate priority belongs to the companion mechanism audit and independent review, including their assessment of newer QAOA-plus-amplification resource studies. Section 4 records one precise interference question without creating a competing experiment queue. [Montanaro, *Quantum walk speedup of backtracking algorithms*](https://arxiv.org/abs/1509.02374) supplies bounded-error search or no-solution output with O(sqrt(T) n^(3/2) log n) predicate tests in its stated backtracking setting, where T is tree size. This is an established structured speedup, not a polynomial general-SAT bound.

A discriminating backtracking resource audit would freeze an explicit history-independent branching/pruning rule, make its reversible predicate and heuristic costs explicit, and compare the charged quantum walk estimate with the identical classical tree and uniform Grover. Do not transplant modern history-dependent clause learning into the static-tree theorem without a new applicability argument. A tree-size bound, any doubling schedule, finding-versus-detection overhead, and ancilla cleanup must be accounted for before a circuit experiment. Finite classical enumeration of T is offline evidence, not a free preprocessing oracle for the algorithm. Reuse of existing precisely specified classical search infrastructure is one selection consideration; it does not settle priority over the newer interference-preparation evidence.
