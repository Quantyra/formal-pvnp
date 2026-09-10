# Independent quantum SAT literature checkpoint review

2026-09-10. Planning S3042 / E014 / E004; related S3040 / S008. Reviewed under `INTEGRITY-CLAIMS.md`.

This is **one independent reviewer applying three lenses** to a literature/resource checkpoint. It is not three separately staffed formal reviewers, a Lean build review, or formal theorem closeout. No implementation, experiment, commit, hardware spend or publication was performed by this reviewer.

## Artifacts and disposition

- [Mechanism audit](2026-09-10-quantum-sat-mechanism-audit.md)
- [Resource contract](2026-09-10-quantum-sat-resource-contract.md)

**GO for the single S3043 QAOA-plus-amplitude-amplification assumptions/resource audit on random 8-SAT. HOLD any claim of practical quantum advantage, general polynomial SAT, or a classical P=NP proof.** Quantum backtracking remains the rigorous structured baseline. The newer QAOA resource lead supplies a more specific unresolved success-to-runtime question than a routine tree demonstration. This justifies an audit, not a prediction of successful comparison or an immediate simulation campaign.

| Lens | Checkpoint verdict | Boundary |
|---|---|---|
| Proof and source adversarial | GO for resource-audit specification | The cited detection and witness bounds are distinct; no new proof has been supplied. Future algorithms must satisfy the actual oracle/tree hypotheses. |
| Complexity theory | GO with complete accounting | Query savings alone establish neither gate nor wall-clock advantage. Charge coherent predicates, heuristics, inverses, tree-bound acquisition, finding, precision and error. |
| Non-claims | GO for bounded research | Bounded-error UNSAT output is not a classical refutation certificate. SAT in BQP would not establish SAT in P. |

## Independent source checks

[Montanaro, Theorems 1.1 and 1.2, printed pp. 3–4](https://theoryofcomputing.org/articles/v014a015/v014a015.pdf): detection takes a supplied valid upper bound T and O(sqrt(T*n) log(1/delta)) predicate/heuristic evaluations. General witness search has O(sqrt(T)*n^(3/2)*log(n)*log(1/delta)) evaluations and need not know T beforehand. These are bounded-error guarantees. Full-tree T can greatly exceed the classical first-hit traversal; the audit must measure both. Coherent implementation must match the prescribed partial-assignment predicate and deterministic branching interface.

[Ambainis–Kokainis, corrected v3](https://arxiv.org/abs/1704.06774v3) replaces the full-tree dependence with the number of nodes actually explored by the classical procedure, with a tilde-O(sqrt(Tvisited)*n^(3/2)) bound in its access model. Thus the first-hit issue is not a universal obstruction to quantum backtracking. The refinement still needs charged coherent operations and does not provide a polynomial arbitrary-SAT bound.

[Campbell–Khurana–Montanaro (2019)](https://arxiv.org/pdf/1810.05582), abstract and Sections 1 and 8: the attractive estimates use particular instances and hardware assumptions. Their classical surface-code decoding cost removes the quoted advantage under their model. Grover outperforms backtracking in their studied usable-size k-SAT regime. These are historical estimates, not current measurements.

[Brehm–Weggemans, Quantum 10, 1975 (2026)](https://arxiv.org/abs/2412.13274v3), abstract and introduction: structured-instance comparisons and T-count accounting largely erase gains in their studied models; the one-day advantage is confined to a limited Grover/T-depth regime. This materially lowers expectations and makes structured instances, total gates and an effective classical solver mandatory controls. It is not an impossibility theorem for quantum SAT.

Additional leads were screened: [Jarret–Wan effective-resistance search](https://arxiv.org/abs/1711.05295) and [Quantum Search on Computation Trees (2025)](https://arxiv.org/abs/2505.22405). Neither is used to produce resource numbers here. A follow-up adopting them must recheck their hypotheses and error budgets; this checkpoint does not claim to identify the strongest current bound.

[Omanakuttan et al., QAOA+AA resource study (2025)](https://arxiv.org/abs/2504.01897), independently checked abstract only: predicts a random-8-SAT crossover under explicit large-scale fault-tolerant assumptions, using earlier QAOA scaling analysis. Its cited regimes require millions of physical qubits. This supports investigating the assumptions, not adopting a crossover forecast. The mechanism author's more detailed 2024 QAOA source reading is not independently rederived here. Validating that analysis and the 2025 full resource calculation is an explicit S3043 obligation.

## Required next evidence

For S3043, extract the precise ensemble, angles, depth and success-to-runtime assumptions from the 2024/2025 sources. An ensemble-average overlap cannot establish an individual-instance success floor or average inverse-square-root cost. Retain low-success tails and UNSAT mass; use UNKNOWN for an unverified no-witness result or charge a complete fallback. Derive the overlap threshold needed to repay both preparation directions and all amplification costs. The required output is an assumptions-and-threshold table and a decision on whether simulation would resolve an uncertainty.

If backtracking comparisons are developed within this audit, freeze an explicit static-tree rule and branching order. Distinguish SAT first-hit from full UNSAT exploration. Compare a conventional SAT solver and uniform Grover as well. Offline enumeration supplies ground truth only. Record logical gates, depth and workspace separately; give fault-tolerance estimates only under named assumptions. Negative overhead results are valid outputs.

For a later QAOA test, charge forward and inverse preparation separately in the overlap score, exclude zero-overlap controls from division, and keep that score distinct from complete SAT/UNSAT runtime. The contract's depth-one toy question does not validate the deeper resource-study regime and is not a second queued experiment. A deterministic simulation argument needs acceptance-probability error below the distance to a separating decision threshold.

## Revision verification

Re-read both author artifacts after revisions. Verified explicit inverse-preparation accounting, the half-gap deterministic threshold margin, separation of zero-overlap controls, the first-hit refinement, the 2019 decoding caveat and the newer structured-SAT resource cautions. Final priority is reconciled: the mechanism audit selects S3043, the contract defers selection to that audit, and backtracking is a comparator. No blocking correctness issue remains for this bounded checkpoint. Full validation of the QAOA scaling/resource forecast remains work for S3043, not completed evidence in S3042.
