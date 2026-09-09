# Branching dual: independent complexity and source review

2026-09-08. S3040 / S008 / E004. Reviewed `2026-09-08-branching-dual-attempt.md` against the retained reaction amplifier and `INTEGRITY-CLAIMS.md`. No satellite AGENTS.md was found in the file inventory. Harness only; no commits, pushes, code changes, experiments or planning edits.

## Exact representation and source scope

The first-event renewal equation has the correct rate n+lambda and the correct squared descendant term. Conditional independence starts after a split from the common position; terminal leaves are not generally independent. Substituting u=1-v gives exactly Lu+lambda u(1-u), with lambda=4n and the Boolean initial indicator. Thus the raw OR of terminal witness checks has expectation equal to the reaction solution. No external branching-representation theorem is imported; the finite construction and equations establish the identity directly.

Stopped-population expectations prove nonexplosion without assuming the desired population law. The geometric solution of the pure-birth equations is normalized and has the stated mean and tail. The formula remains independent of the CNF predicate because branching clocks are independent of its values and all movements.

## Expected and typical work

A full genealogy has N_2-1 splits. Conditional on the tree, motion events have mean n times its total particle duration; integrating the population mean gives(exp(8n)-1)/4. The expected total event count(5/4)(exp(8n)-1) is correct.

The lower-tail bound Pr[N_2<=B]<=B exp(-8n) is also correct and rules out an interpretation based only on rare huge outliers. In particular the population exceeds4^n with probability greater than1-64^(-n). Thus explicitly generating the full tree has exponential work with high probability as well as in expectation. This is an implementation cost, not a lower bound for every way to evaluate its expectation.

Stopping upon a verified witness needs careful quantifiers. The full-tree calculation alone does not establish the early-success runtime on satisfiable instances. However, an otherwise unaugmented rule that stops only after finding a witness must traverse the full generated experiment on UNSAT instances. Its total polynomial guarantee is already excluded by those inputs. Formula-aware preprocessing, other stopping certificates and different algorithms remain outside that conclusion. This distinction was flagged for the final author wording.

The ideal randomized witness probability exceeds4/5 on SAT and is zero on UNSAT. Independent trials give the stated one-sided miss bound, but neither finite trial failure nor random naming of the expectation yields the earlier deterministic evaluator contract. No probability-class conclusion with polynomial runtime follows from an exponentially costly trial.

## Exact scope of the capped-tree obstruction

The cap hypotheses are sufficient for equation (9): selection may inspect branching genealogy and independent randomness but is independent of movements and the formula; every retained path has total diffusion duration t; the edge walks retain their original law; the output is the raw OR of at most B terminal witness checks. Conditional on such a genealogy, every retained endpoint has the duration-t heat marginal.

For the singleton target1^n from root0^n, that marginal success probability is at most2^(-n). The union bound does not require independent leaves and therefore gives the stated B2^(-n) cap bound. At time2 the target expectation exceeds4/5, so polynomial B cannot preserve the amplified constant signal. The claimed necessary population for success probability at least4/5 follows directly.

This does not cover position-dependent retention, formula-aware pruning, altered roots or movement laws, arbitrary output postprocessing, or general selected-coordinate evaluation. Such operations can invalidate the individual heat marginal or the raw-OR form. The singleton formula itself has a trivial explicit satisfying assignment. Its role is to test the specified sampler, not to prove SAT hardness or failure of every initialization and algorithm.

## Finite-bit and aggregation boundary

The continuous stochastic law is not treated as a unit-cost exact-real implementation. The Yule cutoff exp(8n)log(1/epsilon) is a sufficient exponential tail cutoff, not a polynomial proposal. A separate conditional-TV budget over a finite number M of transitions implies a total error bound by coupling, but the draft does not claim to have implemented those conditional samples or established a cheap total event cap.

Sampling only edge endpoints can avoid recording every motion jump, while retaining the exponential full genealogy and terminal count. Likewise O(n) logarithmic precision descriptions for exponential event budgets do not make the number of sampled events polynomial. Continuous-time identities, finite random-bit algorithms, expected work and deterministic worst-case work remain distinct.

Final verdict: GO for the exact branching identity, full-tree work bounds and strictly specified genealogy-only raw-OR cap obstruction. INCOMPLETE for a uniformly polynomial succinct evaluator or general SAT algorithm. The final candidate now explicitly distinguishes UNSAT full-tree work from unresolved SAT early-success time and states conditional TV uniformly over histories. No corrections remain. The full P=NP objective remains unresolved.
