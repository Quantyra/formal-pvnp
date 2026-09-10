# QAOA success and total-cost audit

2026-09-10. S3043 / E014 / E004, following S3042. Satellite research under `INTEGRITY-CLAIMS.md`. This is a resource/math audit, not a quantum simulation, hardware prediction, solver implementation or complexity result.

**Disposition: GO for one reanalysis of the released per-instance success data at supported depths, using the recovered published depth-14 and depth-60 angles. STOP adoption of the numerical crossover as reproduced or of its constant-factor amplification guarantee as proved.** Prefer reanalysis of released per-instance results; simulate only missing observations. This does not reject a legitimate SAT-conditioned ensemble advantage merely because it is not an arbitrary-SAT algorithm.

## 1. Source assumptions and what is being checked

Full primary texts were accessed; the applicable ensemble, success, training, compilation and stopping sections were inspected. Their long analytic proofs and physical compilation are not independently reconstructed. The companion source audit records full provenance.

| Primary source | Relevant source facts | Audit obligation |
|---|---|---|
| [Boulebnane-Montanaro, PRX Quantum 5, 030348 (2024)](https://journals.aps.org/prxquantum/pdf/10.1103/PRXQuantum.5.030348), Definition 1, Eq.13, III B-C, IV A | Poisson clause count of mean rn; recovered angle configuration uses r=176.54; literals sampled with replacement. Shared angles trained on 100 size-12 formulas; validation retains SAT instances at n=12..20. Both mixer and violation-cost angles carry a factor 1/2. Small-angle analytic mean-success exponent; numerical depth extrapolation. Median-runtime scaling is empirical. | Keep unconditional versus SAT-conditioned data distinct. Map angles exactly; transfer between clause-count ensembles and between r=176.54 and r=176 requires separate checking. Small-size median agreement is evidence, not a tail bound at n=179. |
| [Omanakuttan et al., arXiv:2504.01897v1 (2025)](https://arxiv.org/html/2504.01897v1), II, IV.1, IV.6-7 | Fixed 176n clauses, replacement literals, SAT-filtered classical samples at n=30..70. Sparrow median nanosecond fit; QAOA model imports mean-success exponent. Depth-623 crossover extrapolates smaller-depth evidence. Compilation charges inverse, oracles, synthesis and factories; routing excluded. Parallel classical budget matches decoding power. | Compare identical statistics/units and expose unknown tails. Revalidate stopping constants. Conditioning is legitimate for a promised-SAT benchmark; filtering is not a free operational SAT test. |

The 2025 formula for Q uses U_QAOA with a zero-state reflection, whereas its preparation starts at |+>^n. Our convention is unambiguous: A = U_QAOA H^(tensor n), and the amplified iterate uses A S_0 A^dagger S_F. Include the Hadamards and all clean ancillas. Treat source shorthand as requiring this clarification, not as evidence that the intended algorithm fails.

The 2024 gamma/2 times violation Hamiltonian corresponds to gamma_2025 = gamma_2024/2, since the 2025 negative-satisfied-count cost equals violation count minus mI. Mixer beta is unchanged between those two papers. The companion source audit matches the released generalized-binomial coefficient exp(+i gamma_stored/2)-1 against journal A9 exp(-i gamma_journal/2)-1, giving gamma_journal=-gamma_stored and beta_journal=beta_stored. Hence gamma_2025=-gamma_stored/2. This coefficient match still requires one published overlap reference check before new circuit evaluation; raw arrays must not be imported unchanged. Clause signs, duplicate literals and tautological clauses must preserve the generated formula's exact semantics.

## 2. Exact per-instance cost test (our derivation)

Fix F and fixed angles. Let a = probability a measurement of A|0> satisfies F; g = K/2^n is the corresponding uniform probability. Both are evaluation data, never assumed available to an operating solver. Define theta = asin(sqrt(a)). One trial containing j clean amplitude-amplification iterations succeeds with

    s_j(a) = sin^2((2j+1) theta).

In one explicitly chosen unit, define A_c as initial preparation cost, D_c as one full iteration cost, V_c as measurement plus classical verification/reset cost, and H_c as one-off compilation/training charge. Then

    D_c = cost(A) + cost(A inverse) + cost(S_F) + cost(S_0),
    b_j = A_c + j D_c + V_c.

The inverse need not have identical physical cost when schedules/feedforward differ. State the actual cost model. For an indefinite repeat of this fixed trial, expected successful-instance cost is H_c + b_j/s_j(a) when s_j(a)>0. This follows directly from a geometric stopping time. For a fixed comparator expected cost C in the same units, the **exact condition** is

    C > H_c  and  sin^2((2j+1) asin(sqrt(a))) > b_j/(C-H_c).

That is the exact per-instance success threshold *set*. For j>0 it generally comprises several intervals, rather than a single lower bound, because amplification oscillates. A blanket scalar threshold without a schedule/overlap promise is incorrect. On the first increasing lobe, if t=b_j/(C-H_c) is in (0,1), the condition reduces to

    a > sin^2(asin(sqrt(t))/(2j+1)),
    with 0 <= a <= sin^2(pi/(2(2j+1))).

These conditions require j fixed independently of unknown a. Optimizing j using exact offline a is an oracle-assisted benchmark, not the cost of an implementable unknown-overlap solver. For j=0 the exact condition is simply a>b_0/(C-H_c).

For uniform Grover use the SAME accounting with its preparation H^n, its iteration cost D_G, and success s_j(g). Comparing two fixed restart trials is exactly b_Q/s_j(a) < b_G/s_k(g) after including any different one-off charges. Do not compare our exact QAOA restart cost with only Grover's asymptotic query count.

For a multi-trial schedule with j_1,...,j_R fixed beforehand, write s_i=s_(j_i)(a), q_0=1 and q_i=product_(h<=i)(1-s_h). Independent fresh trials yield

    expected cost to stop or exhaust = H_c + sum_i q_(i-1) b_(j_i),
    probability of exhausting schedule = q_R,
    maximum scheduled cost = H_c + sum_i b_(j_i).

These are the primary quantities for resource comparison. If a trial randomizes its iteration count, average s and b over that randomization first; fresh randomness and state reset are required. Compare a high-confidence budget to a high-confidence budget, and an expected stopping time to an expected stopping time.

## 3. Useful scalar envelope, explicitly not an exact stopping theorem

If a separately justified implementation has charged cost envelope B_Q + kappa_Q D_Q/sqrt(a), then beating a comparator budget C>B_Q is ensured by

    a > [kappa_Q D_Q/(C-B_Q)]^2.

Here B includes all initial preparation, compilation, training amortization, readout and fixed overhead not already in D. If C<=B_Q, this envelope cannot certify a win. If the right side exceeds 1, no a can satisfy it. This is sufficient for that certified upper envelope; only if the cost model is equality does it become necessary as well.

With negligible matched fixed costs and comparable amplification constants, relative to Grover this becomes a/g > (D_Q/D_G)^2. Thus 10-fold iteration overhead requires over 100-fold overlap improvement. A success gain alone is insufficient.

For a classical comparator, use either (a) measured same-instance expected nanoseconds under fixed machine/core/restart policy, with all quantum costs converted to nanoseconds under a named architecture, or (b) separate operation vectors without a wall-clock advantage claim. Classical instructions, logical gates, QEC cycles and CPU nanoseconds are not interchangeable. If no calibrated quantum schedule is available, report the threshold as a function of D_Q in seconds instead of inventing a conversion. The published Sparrow median fit is a source-model comparison, not per-instance expected C. A median classical extrapolation cannot be silently substituted for a mean in this inequality.

## 4. Distribution and termination obligations

On a SAT-conditioned ensemble, convexity gives E[a^(-1/2)] >= E[a]^(-1/2). With variable per-formula cost, the relevant quantity is E[D(F)/sqrt(a(F))], preserving covariance. Median and quantile costs should be computed from the per-instance costs directly. A mean success exponent cannot identify their tails.

A synthetic counterexample illustrates the gap without asserting anything about the papers' actual data: 99% of formulas have a=.01 and 1% have a=10^-12. Inverse square root of mean success is approximately 10.05; mean inverse square root is 10009.9. Even within promised SAT, an overlap of zero for some formula is possible for a particular preparation, and indefinite amplification then fails. Positive UNSAT mass makes uncapped search runtime infinite. Report that mass separately rather than discarding it silently.

A finite QAOA schedule returning no witness reports UNKNOWN unless it has an applicable success guarantee. A complete fallback can run a fixed deterministic complete classical solver, costing C_fb(F), or a bounded-error uniform search with its own documented budget. With a fresh deterministic fallback the exact expected total is

    H_c + sum_i q_(i-1) b_(j_i) + q_R C_fb(F).

Every UNSAT input has q_R=1, hence pays the whole failed prefix plus fallback. The worst-case total pays the full prefix and full fallback. A mixed ensemble averages this expression over both SAT and UNSAT. This full decision extension is an additional task, not a condition invalidating a clearly labeled promised-SAT search result.

For high-confidence operation, allocate delta_total among algorithmic failure, compilation approximation and hardware failure. A claimed 99% entanglement fidelity is not automatically a <=1% failure bound for every input state; establish the required channel/output-error bound or keep a model-dependent label. Repeating R times does not automatically divide coherent approximation errors by R. For a per-trial success lower bound s_min, choose R>=ceil(log(delta_alg)/log(1-s_min)); absence of such a bound cannot be repaired merely by selecting a large R.

## 5. Bounded verification and source-constant issue

The stdlib [arithmetic check](2026-09-10-qaoa-cost-arithmetic.py) produces [JSON evidence](2026-09-10-qaoa-cost-arithmetic.json). It executes scalar formulas only. Re-run with Python; it has assertions and no network, SAT search or quantum simulation.

The source's Theorem IV.1, Eq.13 prescribes j=ceil(pi/(8 theta)-1/2) and claims at least 1/2 success on theta_a in [theta/2,theta]. At theta=pi/4 and theta_a=pi/8, j=0 and success=(2-sqrt(2))/4=0.1464466094. This refutes that intermediate bound as written. It does not refute amplitude amplification or the existence of an O(1/sqrt(a)) unknown-overlap method. A corrected algorithm and fully charged constants are needed before adopting the reported factor-four overhead. Source PDF and HTML agree; independent reviewer confirmed.

A conservative repair is available without relying on that stage assertion: randomly choose j uniformly from 0..M-1. Direct trigonometric summation gives mean success 1/2-sin(4M theta)/(4M sin(2theta)). If a_min<=a<=1/2 and M>=1/sqrt(2a_min), this is at least 1/4. Mixing this trial equally with an unamplified trial gives a >=1/8 success floor for every a>=a_min (including a>=1/2). Thus R=ceil(log(delta)/log(7/8)) fresh mixed trials suffice under that explicit promise. Charge actual preparation plus each randomized j, and inverse calls. Without a_min, use a capped growing schedule and the complete fallback above. This repair supplies a valid conservative option, not a reproduction of the source's constant or optimality claim.

A source-equation substitution uses n=179, p=623, representative c=2112, n_P=27, d=28, and a one-microsecond code cycle. Results:

| Arithmetic output | Value | Status |
|---|---:|---|
| Imported-fit success | 1.80615e-5 | Fit assumption, not measured overlap |
| Ideal pi/(4 sqrt(a)) | 184.805 | Arithmetic only |
| Iteration logical cycles / seconds | 2,772,099 / 77.619 | Representative compilation inputs |
| Ideal runtime / assumed factor-four runtime | 3.985 h / 15.938 h | Constant unverified; not reported 14.99 h reproduction |
| Sparrow serial fitted runtime | 572.791 h | Equation substitution, not benchmark rerun |
| 46-core speed model / parallel fitted runtime | 35.442 / 16.161 h | Imported parallelism model, not hardware measurement |
| Threshold using that factor-four and comparator | 1.75660e-5 | Illustrative conditional envelope only |

The closeness of the last threshold to the assumed success shows sensitivity, not confirmation. Exact archived crossover inputs, proper confidence statistic, repaired amplification constants, routing, and success-distribution evidence remain necessary. The source's infidelity/fidelity convention around Eq.23 also needs resolution before physical-qubit reconstruction; the companion audit tracks it. Neither the fit nor the reported crossover is reproduced here.

## 6. Single actionable follow-up: released-data reanalysis

**Question:** At published supported depths, how much does replacing inverse-root mean success with per-instance finite-schedule costs change the predicted benefit? Analyze every usable released p=14/p=60 per-instance row at available n=12..20, preserving formula IDs and counts. SAT-conditioned data cannot recover an omitted UNSAT fraction: label that unknown instead of fabricating it. A Poisson-to-fixed-count comparison is only possible if both actual datasets exist. No new simulation is queued by this disposition.

Use the published p=14 and p=60 arrays in PhaseCraft/qaoa_ksat_paper_data at commit 5c7ee19db385e8a2bad075206e6483cbab43eadb, file lib/optimal_angles.py, SHA256 a25049edf7c11dd3a69ee1e36a01bde851fbd86cdf8cf5394cdc8d4fde123821 (recovered by the companion source audit). Reanalyze sufficient released per-instance observations before generating missing data; match their ensemble, formula IDs and conventions first. No new angle optimization. Exact array/convention mismatch is a STOP condition.

For S3044, first inventory the archive schema and pin formula IDs, density, clause-count ensemble, depth, angle convention and whether each row is a per-instance probability or an aggregate. Preserve omitted/zero/UNSAT outcomes as explicit metadata. Freeze a single restart schedule and cost model only after identifying usable matched records; use Section 2 to evaluate it without running quantum circuits. Report E[a], inverse-root mean, mean inverse-root where finite, medians, upper quantiles and zero-overlap counts separately. Preserve cost/probability covariance and distinguish SAT-conditioned outputs from the unavailable unconditional population if SAT filtering removed it.

Keep classical fallback CPU seconds separate from logical quantum costs until a stated architecture provides a conversion. No total-runtime advantage follows from adding those unlike units. If per-instance probabilities are absent, report that exact evidence gap and the source audit's conceptual missing-data design; do not silently launch simulations. Density transfer (176.54 to 176) and clause-count transfer (Poisson to fixed) are distinct variables and must not be conflated. The companion source audit describes a contingent multi-arm design for that distinction; it is not a frozen or runnable preregistration here.

Only S3044 archive inventory/reanalysis is the next action. No simulation seed, sample count, circuit run or hardware task is queued by S3043. A later simulation requires a reconciled preregistration and an angle-convention reference check. Released-data reanalysis cannot validate p=623 or n=179 extrapolation or recover an omitted UNSAT mass.
Continue beyond that single test only if matched per-instance costs show a reproducible benefit or isolate a specific statistical failure needing explanation. If the cost gain vanishes, record STOP for that tested preparation/depth/ensemble. No extrapolation-driven hardware recommendation, P=NP result, novel algorithm or all-instance guarantee follows from this audit.
