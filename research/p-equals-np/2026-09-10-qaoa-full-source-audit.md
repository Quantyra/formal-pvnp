# QAOA source and replication contract

2026-09-10. S3043 / E014 / E004; predecessor S3042, related S3040/S008. Internal source audit under `INTEGRITY-CLAIMS.md`. No solver implementation, simulation, hardware run, spend, release or claim expansion.

## Decision

**STOP adoption of the published crossover as a validated estimate. GO for one bounded source-data diagnostic, before considering new simulation.** The candidate remains fixed-angle QAOA plus amplitude amplification (AA) for a specified random 8-SAT distribution. The full papers identify useful interference, but do not establish the per-instance overlap distribution or the general decision contract needed for our stronger goal.

The next diagnostic is to recompute the AA-relevant inverse-square-root success statistics from the original per-instance data. If those data suffice, another toy simulation adds little. A new simulation should address only the Poisson-to-fixed-clause ensemble transfer specified below, and should remain on hold until the angle and input manifest is verified. Neither diagnostic can validate extrapolation to depth 623 or practical advantage at 179 variables.

## Sources, versions and access

- **Boulebnane and Montanaro:** *Solving Boolean Satisfiability Problems With The Quantum Approximate Optimization Algorithm*, PRX Quantum **5**, 030348 (2024). [Journal PDF](https://journals.aps.org/prxquantum/pdf/10.1103/PRXQuantum.5.030348), [APS full-text download](https://harvest.aps.org/v2/journals/articles/10.1103/PRXQuantum.5.030348/fulltext). The 32-page journal text, appendices and references were inspected. Its separately linked supplemental proof material was not independently proof-checked. Do not confuse its numbering with the 77-page arXiv manuscript, which was consulted only for access recovery.
- **Omanakuttan et al.:** *Threshold for Fault-tolerant Quantum Advantage with the Quantum Approximate Optimization Algorithm*, [arXiv:2504.01897v1](https://arxiv.org/pdf/2504.01897v1), 2 April 2025, 30 pages. Main methods and appendices A–D/resource tables inspected. The attempted v2 HTML URL returned 404; the accessible PDF explicitly identifies v1. Equation (13) on printed p. 9 was visually checked against the rendered PDF. Circuit diagrams were inspected for resource context, not independently verified gate by gate.

This replaces the predecessor's abstract-only access limit for the 2025 study. It is not an independent numerical reproduction of either paper or a certification of every proof.

## Assumptions table

| Obligation | Exact source location and supplied evidence | Audit disposition |
|---|---|---|
| 2024 input law | Definition 1, p. 5: m is Poisson(r*n); each of k literals is drawn uniformly with replacement, including signs. Table I, p. 9 uses r=176.54 for k=8. | Preserve literal repetitions/tautologies and the random clause count. |
| 2025 benchmark law | IV F(b), p. 12: m=176*n exactly, independent variable draws with replacement and sign probability 1/2; Kissat rejects UNSAT samples; at least 70 retained SAT instances per n=30,...,70. | Different finite-size distribution and conditioning. No silent interchange with the analytic ensemble. |
| Analytic success theorem | 2024 Proposition 1/Eqs. (15)–(20), pp. 5–6; Proposition 3/Eq. (A8), p. 14. Fixed depth, fixed angles; sufficiently small gamma for the asymptotic saddle-point result. | An exponent for mean success, not a theorem about mean runtime, quantiles, all angles or depth growing with n. |
| Angle training | 2024 IV A3, pp. 11–12: gradient descent on empirical average success over 100 size-12 instances, fixed training set; initialization beta=0.01, gamma=-0.01. Analytic optimization becomes difficult at moderate p. | Charge training/amortization. Claimed convergence/optimality is empirical. Reusing angles across inputs does not make their discovery free. |
| Validation depth/size | 2024 III B–D, Figs. 1–4: small-instance checks n=12,...,20; analytic exponent data through p=10, empirical data through p=60. | These checks do not validate p=623 or the large-n crossover. |
| Success statistic | 2024 III C and IV explicitly distinguish mean success from runtime and report divergent median scaling/tails. | This limitation is acknowledged by the original authors; our diagnostic must measure the AA-relevant statistic. |
| Depth extrapolation | 2024 Fig. 2 fits c(p)=0.69*p^(-0.32); 2025 II B adopts a_model=2^(-c(p)*n). 2025 III and Appendix D expressly identify extrapolation risk. | Model hypothesis, not an arbitrary-depth theorem or per-instance overlap floor. |
| Classical comparator | 2025 Eq. (1): median Sparrow TTS fit 2^((0.176+-0.011)n+19.369+-0.657) ns; IV F supplies hardware, 1000s limit and SAT filtering. IV G transfers parallelization from Rand-9's shifted-exponential fit. | Incomplete SAT search comparator. Match median/mean, conditioning, cutoff and parallel resources before declaring an advantage. |
| Complete decision | 2025 II A expressly calls QAOA incomplete. | Lack of UNSAT certification does not refute that source's stated search task. It does block importing its cost into our complete SAT/UNSAT task without fallback. |

## Mean success is not average runtime

Write a(F) for the success probability on a formula F and restrict to SAT instances when taking negative powers. The analytic object is E[a(F)] (sometimes called an annealed success exponent after taking log). A quenched log-success quantity is E[log a(F)]; neither is E[1/sqrt(a(F))], the ideal AA search-work statistic. The papers do not provide an equality between these objects. Jensen gives

    E[1/sqrt(a)] >= 1/sqrt(E[a]).

Replacing the left side by the right can underestimate average cost. It supplies no tail control. The median is another statistic, and c(p) fitted from average overlap cannot simply be reused for its exponent. If the unconditioned law has any UNSAT mass, indefinite search has infinite mean completion time; this is already discussed in the 2024 paper. A finite complete solver needs an explicit error-controlled stopping or fallback procedure.

There are three distinct transfers to test: Poisson(176.54*n) to fixed 176*n; unconditioned to SAT-conditioned; mean overlap to distribution of inverse-square-root overlap. A fit agreeing at small n does not establish any of these uniformly. For a dataset with SAT fraction pi, report E[a]=pi*E[a|SAT], the separate UNSAT count, and all conditional runtime statistics. Do not assign UNSAT instances a small positive probability to make logarithms finite.

## What the 2025 resource calculation actually charges

Using its model a_model, Eq. (7) charges an AA iterate as

    Tq_ideal = pi/(4*sqrt(a_model)) *
       [2*p*(T_mixer+T_phaser)+T_OC+T_O0].

Eqs. (8)–(11) give mixer synthesis, parallel phaser dispatch, clause oracle and zero-state reflection times in logical cycles. IV B/Eqs. (14)–(18) model synthesis error and imperfect T states; IV C/Theorem IV.2 and Appendix B specify TACU ancillas/CCZ consumption. Appendix C charges oracle computation/uncomputation. Resource-state factories and ancilla reuse are counted in II D; IV E budgets classical decoders. Fig. 3's headline is p=623, n=179, 73.91 million physical qubits and 14.99 hours under the paper's assumptions. That is a model output, not a measurement or our forecast.

Two source dependencies prevent treating this as a fully audited engineering bound: III explicitly omits qubit routing, and the power-law depth assumption remains unverified. The fidelity composition in IV B–D is a noise model, not automatically a worst-case bound on success error from coherent synthesis. Appendix D's optimal-depth formula explicitly cautions against committing to the fit at arbitrary depth. No constant-overlap polynomial-SAT conclusion may be inferred by extrapolating it indefinitely.

The public calculation code additionally exposes important conventions. Its `get_8_SAT_params` uses `qaa_fac=4`, `acc=0.99`, the success model above, and code distance based on `log(1-acc)`. Thus IV D's printed statement setting target *infidelity* to 0.99 conflicts with the apparent intended 99% fidelity; the code uses 0.01 infidelity. This is a source convention issue to document, not grounds to silently choose a favorable interpretation. The fourfold AA factor multiplies runtime in the code; fidelity budgeting must be checked against the actual restarted schedule before interpreting the total failure probability. No code execution/reproduction was performed here.

## Narrow error in the stated AA schedule

The 2025 Theorem IV.1 proof, Eq. (13), starts theta=arcsin(1/sqrt(2))=pi/4 and selects

    m = ceil(pi/(8*theta)-1/2).

It states that success becomes at least 1/2 for theta_a in [theta/2,theta]. At theta_a=pi/8 this gives m=0 and success sin^2(pi/8)=(2-sqrt(2))/4, approximately 0.1464. Therefore that interval guarantee is false as written. The independently checked rendered equation agrees with the extraction.

This invalidates adoption of that proof as justification of the precise factor-four constant. It does not invalidate standard amplitude amplification or prove that the candidate cannot work. A repaired schedule, its initial measurements, repeated preparations and query accounting must be costed explicitly. Also use full preparation A=U_QAOA*H^(tensor n): Eq. (3) defines U_QAOA without Hadamards, while Eq. (6)'s all-zero reflection must act relative to the actual prepared state. A reflection about the all-plus state is an equivalent correct formulation.

## Code/data manifest and angle convention

The 2025 [Zenodo record 15122122](https://doi.org/10.5281/zenodo.15122122) API and its 80,563-byte `zenodo_upload.zip` were read in memory. It contains plotting notebooks, `utils.py`, classical solver results, coloring/synthesis data and fitted model outputs. Its `optimized_parameters.txt` contains classical shifted-exponential fits, **not QAOA angles**. No per-instance QAOA overlaps or depth-623 angle schedule was identified in that archive.

The 2024 authors' [PhaseCraft data repository](https://github.com/PhaseCraft/qaoa_ksat_paper_data) was pinned to commit `5c7ee19db385e8a2bad075206e6483cbab43eadb`. The downloaded `lib/optimal_angles.py` SHA256 is `a25049edf7c11dd3a69ee1e36a01bde851fbd86cdf8cf5394cdc8d4fde123821`; dictionary `(8,176.54)` contains depth-14 and depth-60 beta/gamma arrays. `lib/analysis_helpers.py` expects per-instance `instance_benchmark_qaoa_result*.json` with `eval_qaoa_success_probability`; its default-p substitution must not conceal missing depth metadata. The README points to [Zenodo 7764484](https://doi.org/10.5281/zenodo.7764484), `data_23032023.tar.gz`, 177,713,853 bytes. An in-memory download completed at closeout and matched advertised MD5 `c40fb21998acec76f92511a1e86258ed`. Its directory listing contains 2,033,188 members; a sampled classical benchmark has n, k, r, instance_id and benchmark_id fields. No archive files were extracted or retained locally. Detailed depth/paired-overlap inventory remains the next dependency; existence of a loader and archive is not proof that every needed paired record is present.

The stored gamma convention must be checked: `generalized_binomial_sum.py` uses exp(+i*gamma/2) in the first half of its coefficient product, whereas journal Eq. (A9) uses exp(-i*gamma/2). Matching those expressions gives gamma_journal=-gamma_stored, with beta unchanged in the displayed coefficient convention. Journal Eq. (13) then uses exp(-i*beta*sum(X)/2) and exp(-i*gamma_journal*H_unsat/2). The 2025 cost Hamiltonian is H_unsat-m*I and has no extra phase factor 1/2, so matching it requires gamma_2025=gamma_journal/2 (irrelevant global phase omitted), beta_2025=beta_journal. Pin the complete arrays, ordering and formula encoding and verify a known overlap before any experiment. Do not copy positive stored gamma into the journal formula without resolving this convention.

## One diagnostic and the simulation gate

**Chosen next action:** inspect the 2024 archive, validate checksum and field identity, then reanalyse existing n=12,...,20 records at p=14 and p=60. Report count, conditioning, mean a, median a^(-1/2), mean a^(-1/2), 90th/99th percentiles, minimum overlap, and `R=E[a^(-1/2)]*sqrt(E[a])` with uncertainty. Use the same formulas to pair depths and compare to uniform preparation a0=K/2^n where K is supplied/verified; do not call a missing field zero. Reanalysis may disprove the assumption that an inverse-mean shortcut is a useful finite-size proxy; it cannot establish large-n concentration.

If source records cannot test the **ensemble transfer**, one candidate simulation can be preregistered, but is not launched by this audit: use the pinned depth-14 and depth-60 angles unchanged, n in {12,16,20}, 200 independently generated formulas per ensemble and size, comparing (A) Poisson(176.54*n), (B) fixed round(176.54*n), and (C) fixed 176*n. All literal draws use replacement and independent signs. Retain every generated formula; report SAT-conditioned statistics plus full UNSAT fraction separately. These three arms separate Poissonization from density change. Same distribution seed families/angle set and held-out formula identities must be recorded before outcomes.

Predeclare the materiality test: an inverse-mean AA estimate differing by more than a factor two from measured mean inverse-square-root work, with a 95% bootstrap interval wholly above two, rejects that proxy on the tested finite family. Report paired depth effects and the analogous ensemble ratios regardless of sign. An interval spanning the threshold is inconclusive. Even a small discrepancy is only a finite-size observation, not a GO for p623. Existing data reanalysis comes first; no retraining, no hardware, and no extrapolated speedup claim. The complete decision/fallback threshold is owned by the companion S3043 cost contract.

## Closeout boundary

The useful operation is quantum interference that improves overlap before AA. The specific literature supplies a candidate and resource model, while the audited missing link is a matched per-instance success/cost distribution plus a reliable decision contract. This audit finds neither general polynomial SAT nor P=NP, and makes no impossibility or novelty claim. Owning artifact is intentionally uncommitted for orchestrator review; no other files were edited.
