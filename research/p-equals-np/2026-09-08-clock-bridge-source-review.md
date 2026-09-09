# Clock-to-complexity bridge: primary-source and complexity review

2026-09-08. S3040 / S008 / E004. Baseline 445fbf7. Independent harness-only review. No code, commits or planning edits.

## Exact primary theorem target

[Bournez--Graca--Pouly, arXiv:1609.08059v3](https://arxiv.org/html/1609.08059v3), Definition 2.1/Theorem 2.2: a language is in P exactly when a fixed-dimensional rational polynomial ODE y'=p(y), initialized by a fixed bivariate polynomial q at psi_k(w)=(sum_i w_i k^(-i),|w|), recognizes it. The alphabet is {0,...,k-2}. Solutions exist for all nonnegative times. Full-state length is integral ||y'||_infinity and satisfies length(0,t)>=t. Once |y_1|>=1 it remains outside that interval. After length reaches a fixed polynomial in |w|, y_1>=1 for members and y_1<=-1 for nonmembers. Continuity makes that committed sign irreversible.

Theorem 7.2 extends coefficients to a generable field K with R_G subset K subset R_P. Rational coefficients suffice for the target here. Definition 2.3/Theorem 2.4 concern continuous real functions on compact intervals with polynomial-length accuracy convergence; they are a different characterization, not a substitute for the language theorem. HTML was used to verify non-strict inequalities mangled by PDF text extraction. All these are named external results, not local formal proofs.

## Positive sufficient bridge for this research goal

Construct the fixed rational p,q and dimension for the SAT language, prove the global solution and length/output properties above for every encoded input, and the quoted language theorem supplies SAT in deterministic polynomial time. This is a positive sufficient target. It does not require a physical realization in order to yield that mathematical conclusion. Conversely, a fluid realization without that reduction or another standard-model algorithm does not discharge the target.

The existing packet proposal has an input-dependent register network, scalar PDEs, nonlocal sensors, distributed feedback and an external schedule. Listing those components does not identify them with one fixed polynomial ODE. The completed fluid source is not instantiated. A finite approximation requires its own error, encoding, global continuation, dimension, coefficient and output arguments. A finite cutoff can be compatible with a subsequently constructed global recognizer, but that construction must actually be given.

The amplitude comparison variables used to prove scalar correctness are not automatically physical state coordinates. A lower bound on their normalized path is a statement about that representation unless a quantitative map from the proposed simulator or fluid state is supplied. Kinetic energy and curve length are different mathematical quantities.

## Independent norm and coordinate checks

For any v in R^d, ||v||_infinity <= ||v||_2 <= sqrt(d)||v||_infinity. Integrating yields the same inequalities for path lengths. For fixed d these are constant factors. For input-dependent polynomial d they are polynomial factors, but this does not by itself convert a family of systems to the fixed-dimensional characterization. Unbounded dimension cannot be hidden in a phrase such as equivalent norms.

For an absolutely continuous path a and increasing absolutely continuous time substitution on a finite interval, the chain rule and change of variables preserve its path length when the same path segment is traversed. Shorter external time alone does not shorten that segment. Arbitrary singular maps require their own regularity qualification.

Coordinate scaling changes length. If z=epsilon a, then Len(z)=epsilon Len(a), while decoding a=z/epsilon has Lipschitz constant 1/epsilon. An exponentially large decoder constant has only polynomially many bits when its logarithm is polynomial; this numerical observation is not an exponential bit-complexity lower bound. What fails without further proof is a uniformly well-conditioned identification of the two trajectory costs.

A time-dependent decoder also requires an explicit term. If a(t)=D(t,z(t)), with spatial derivative norm at most K, then |a'|<=K||z'||+|partial_t D(t,z(t))| under ordinary differentiability assumptions. A shrinking latent path therefore does not bound decoded variation unless both terms are controlled. Clock-driven variation belongs in the model and cannot be treated as free readout.

## Review status

Exact source audit and final candidate review are complete. Verdict: GO for the explicitly conditional trajectory/decoder bounds and ideal-clock calculation; INCOMPLETE for the polynomial-time SAT bridge and P=NP. The bridge is not a blanket restriction on Navier--Stokes, physical computation, or all SAT algorithms.


## Final candidate complexity review

Inspected `2026-09-08-clock-trajectory-bridge-attempt.md` in full. The sampled alternation bound K Len(X)>=2gJ follows directly from the declared decoder inequalities and partition length. The author counts the least significant assignment bit at completed samples, not the monotone answer flag or HOLD slots. The binary enumerator has J=2^n-1 such transitions. Restricting the universal claim to ordinary formulas with L=O(n log n) correctly makes the lower bound superpolynomial in input length; redundant encodings do not invalidate or strengthen it.

The time-dependent decoder inequality includes explicit temporal variation on a common domain. The controller-state version charges the controller path with its own Lipschitz factor. This prevents the proof from assigning arbitrary externally changing interpretation zero cost. Partition length invariance under increasing continuous bijections of finite intervals is exact and needs no differentiable change-of-variables assumption.

The packet calculation keeps transported volume constant during a run and separates an input-dependent initial volume from time shrinkage. The two-state L2 sensor inequality is valid on the specified constant-D and bounded-c domain. The warning that a whole-space L-infinity error bound does not imply an L2 error bound is necessary and correct. For the exact controlled mode, differentiating constant ||p||2^2 gives <p,p'>=0, so the displayed squared-derivative identity and Len(c)>=sqrt(D) Var(a) follow under the stated L2 absolute-continuity hypotheses. Identifying this with a simulator's full-state length still needs a quantified norm-dominating map, which the note explicitly retains.

The ideal-clock lift is a rational polynomial system for fixed integer q. Differentiating y=(1-t)^(-1/q) gives y'=y^(q+1)/q and s'=y^(q+1); the initial conditions and s=q(y-1) are consistent. In the full three-coordinate infinity norm, s' dominates tau' and y', so integration gives exactly M length up to s=M. Omitting s still leaves at least M/q from y variation, with upper bound elapsed time+M/q. The finite-time pole fails the global recognizer requirement. An extension cannot erase length already traversed, and none is constructed here. These observations concern this clock embedding only.

The short rational cutoff description, exponentially small amplitudes and exponentially large inverse sensitivities are correctly distinguished from exponential bit precision or bit runtime. The packet-normalization tradeoff is a necessary condition on the declared faithful trace, not an implementation theorem. BGP's language characterization does not separately demand a polynomially Lipschitz decoder for every intermediate simulated register; that is an additional hypothesis of this local trace lemma. Failure of that hypothesis, or long length of this particular representation, does not exclude a faster endpoint algorithm or a different polynomial-length recognizer for SAT.

No mathematical or complexity-scope corrections are required. Final verdict remains GO for these bounded informal results; INCOMPLETE for the actual fixed-system polynomial-length SAT construction, controlled-fluid-to-standard-model reduction and P=NP objective. No numerical regression can replace the missing uniform theorem; no code tests or commits were performed by this reviewer.
