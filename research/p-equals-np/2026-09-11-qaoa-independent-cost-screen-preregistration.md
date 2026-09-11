# S3046 independent cost screen: preregistration

2026-09-11, S3046 / E014 / E004. This is one NEW independent instance, not a replacement for the missing S3045 source formula. S3045 remains blocked.

Before any instance outcome: choose n=16, k=8, r=176.54 and NumPy PCG64 seed 20260911. Draw m from Poisson(r*n), then for each clause draw eight variable IDs uniformly from1..n with replacement, followed by eight independent0/1 signs (1 negates). Preserve all clauses, multiplicities and tautologies. No SAT rejection, seed change, formula selection or angle tuning. `--prepare` saves JSON clauses, DIMACS CNF and a timestamped hash-bound manifest without computing K, energy or quantum success.

Use both recovered published p14/p60 arrays, unchanged stored order, beta_journal=beta_stored and gamma_journal=-gamma_stored. The reused tested engine applies exp(-i gamma_journal E/2), then exp(-i beta X_i/2). This is explicitly a paper-defined circuit, not a recovered source-driver replication. No sign variant is tried. The full arrays and script/engine hashes are frozen in the manifest before target evolution.

Resource cap:120seconds for paired target/diagnostic work,512MiB peak working set,one local process/one numerical thread. Complex128, norm-squared drift<=1e-10 without renormalization; reuse the independent small dense/literal tests at1e-12. Enumerate E and K only as a local diagnostic and compare66 fixed assignments against the independent literal evaluator. If K=0, save the UNSAT outcome and stop without evolution/reselection. Otherwise execute exactly the p14/p60 pair and retain both results, including any zero overlap.

## Frozen cost model

Use a common symbolic logical unit R=S_F+S_0, where both the satisfying-state mark and zero-state reflection include their full compute/uncompute. Let H be uniform preparation, L one QAOA layer and V verification/reset; A_Q=H+pL, A_uniform=H, inverse cost equals forward cost. These are logical-operation block costs, not CPU time or hardware-cycle estimates. Numeric sensitivity cases are fixed as (H/R,V/R)=(.01,.01),(.1,.1),(1,1); they are hypothetical assumptions, not measured implementation costs. Published fixed-angle training and compilation are treated as offline/amortized for this kernel screen; an end-to-end claim must add them explicitly.

For success a, one trial with j amplification iterations has s_j=sin^2((2j+1)asin(sqrt(a))) and cost b_j=(1+2j)A+jR+V. Minimize expected restart cost b_j/s_j over all nonnegative integer j, including zero, using exact offline a only. Once b_j is at least a current finite incumbent, no later j can improve because success<=1. This gives a finite global search without an arbitrary32-iteration cap or first-peak assumption. Apply it equally to uniform a=K/2^n.

For each preparation depth and sensitivity case, calculate the largest nonnegative layer cost ratio permitting a win against globally optimized uniform cost C_G:

    max_j [C_G*s_j(a) - (1+2j)H - jR - V] / [p(1+2j)].

The search ends when the zero-layer trial cost (1+2j)H+jR+V >= C_G, which rules out any positive L at that or later j. No positive maximum means no admissible positive layer cost in that scenario, not a universal algorithm impossibility. Positive maxima are conditional break-even thresholds, not measured gate advantage. Verify the optimizer on synthetic a0/a1 and against an independent10000-j enumeration, and verify costs on both sides of a synthetic threshold before real outcomes.

Known-a iteration choice and exact enumeration are diagnostic aids, not available free to an unknown-overlap solver. Infinite repeated search assumes positive overlap; this screen provides no general UNSAT stopping rule, fallback guarantee or broad classical comparison. A single outcome cannot establish a distributional effect or scaling.

After this one screen, stop and report whether the overlap gain leaves plausible preparation-cost headroom under the stated assumptions. Do not launch an ensemble campaign, synthesis effort, hardware task or parameter search. Independent reviewer accepted the preregistered model before outcome generation; final manifest and results remain reviewable before any commit.
