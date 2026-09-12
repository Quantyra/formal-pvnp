# Interference route: prior algorithm and extraction contract

2026-09-11; S3069 independent source scout under [integrity](../../INTEGRITY-CLAIMS.md). Read S3067/S3068 and the S3069 intake. No new algorithm, experiment, implementation, novelty assessment or final three-lens approval is supplied.

## Strongest directly relevant quantum result checked

[Schmidhuber-Hastings v1, Sections 12.1-12.4, Theorem 12.7 and Remark 12.8](https://arxiv.org/pdf/2607.29672v1) uses the odd inference operator H_o, not the refutation operator H_ref. Its observable is guide overlap with a high-energy spectral band. Independent main, guide and validation pools support filtering and extraction of a Boolean vector correlated with the planted assignment. Recovery unweights the accepted state, reduces it to a one-particle density matrix, then uses tomography and validation.

For fixed arity k and bias rho, with L=k floor(ell/k), L^2 log n=o(n), and sufficient m>=C rho^(-2)n^(k/2)/ell^(k/2-1), its stated cost is tilde-O(binom(n,L)^(1/4) L^(O_k(L)) n^(O_k(1))). The L-dependent factor may rival the fourth-root term when L is polynomial in n. Remark 12.8 explicitly makes no quantum-refutation claim. This paragraph summarizes accessed statements, not an independent certification of the full proof.

The guide/sparse-Hamiltonian predecessor is [Quartic quantum speedups for planted inference, v2](https://arxiv.org/pdf/2406.19378v2), which the July source explicitly imports for its clause-product guide and guided detection procedure. A proposal based solely on coherent sparse access, guide preparation, spectral filtering or amplitude amplification must compare with this existing architecture rather than claim those ingredients as new.

## Exact mismatch with the present task

The desired FKO output is a collection of original clause-ID subsets, each parity-inconsistent, with enough distinct useful weight under verified clause capacities. A planted-correlated Boolean vector is a different mathematical object. The current task has random null formulas and no given planted assignment whose correlation could certify that tuple mass. Even a successful planted/null discriminator need not produce a proof that a particular formula is unsatisfiable.

The relevant unanswered extraction statement would need to identify an efficiently preparable state and a measurement whose output distribution has sufficiently large probability on verifiable original-clause witnesses. It must also bound witness support, repeated outputs and shared loads. A promise about eigenvalue-band mass does not imply this statement. Neither a negative edge nor generic state transfer supplies a short negative closed walk with the required labels and coverage.

There are two separate soundness opportunities. A randomized or quantum search may output a concrete tuple that a classical verifier checks exactly; bounded-error search then does not compromise the tuple's correctness. But if the output is only a claimed spectral upper bound, an exceptional underestimate can compromise refutation. That second route needs a sound certificate for the upper bound and the complete scalar defect terms. The source's rejection of a quantum-refutation claim does not rule out future quantum search with classical witness verification.

## What is routine and what remains a frontier

Signed double-cover identities and coherent evolution are already in the S3068 ledger. They reorganize amplitudes but do not give an input-specific success probability. If different histories are retained in orthogonal registers, amplitudes associated with those distinct histories do not interfere in a measurement ignoring the registers; if history is erased, extracting a valid original-clause witness needs its own reconstruction argument. This is a basic output-contract issue, not a no-go theorem against quantum algorithms.

A substantive new result here would be a useful bound linking actual-instance operator structure to short labeled witness probability and capacity coverage, or an efficiently checkable global refutation bound obtained at lower total cost. No such implication was found in the accessed quantum theorem statements. Claiming that no such result exists anywhere would exceed this scout's search.

At the FKO scale ell=Theta(n^(1/5)), the currently quoted theorem still carries a subexponential-dimensional factor and an L-dependent guide overhead. It cannot be reported as a polynomial-time stepping stone merely because the workspace stores a lifted index compactly. The inference/refutation operator distinction also prevents directly transplanting its planted guide analysis to the current H_ref walk.

## Search and scope

Primary sources checked: July 2026 v1 Sections 12.1-12.4 including the two-threshold promise, reversible-oracle statement, accepted-band recovery, theorem and explicit scope remark; predecessor arXiv:2406.19378v2. Focused queries included `quantum refutation random kXOR certificate Kikuchi witness extraction 2026` and `quantum walk negative cycle signed graph witness extraction interference`.

Search also surfaced signed-graph state-transfer and specially marked-edge search results. Their snippets were not used as support for a theorem about our rooted operator or original-clause witnesses. No exhaustive citation crawl or full-proof verification was performed. The strongest comparison is the already existing guided planted-inference algorithm, with its actual output and charged overhead retained. This note supplies source constraints to the mechanism authors; candidate proof review remains separate.
