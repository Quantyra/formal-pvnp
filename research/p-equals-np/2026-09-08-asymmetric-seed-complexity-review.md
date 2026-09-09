# Asymmetric seed: independent source and complexity review

2026-09-08. S3040 / S008 / E004. Baseline 26ee6fb. Harness-only review of `2026-09-08-asymmetric-seed-attempt.md`. No code, commits, planning edits, numerical experiments or claim expansion.

## Source boundary

The primary-source findings in `2026-09-08-normalized-sat-source-review.md` remain applicable. The [original Ercsey-Ravasz--Toroczkai paper and supplement](https://arxiv.org/pdf/1208.0526) do not establish a worst-case polynomial deterministic decision algorithm for this modified flow and seed. Statements about attraction with exceptional initial sets and ensemble scaling cannot certify this prescribed rational initialization. This increment supplies its own restricted-family argument; it does not inherit the original solver's convergence claims through a change of control law. No new external theorem is needed for the elementary derivations reviewed below.

## Seed, dynamics and growing-family bound

The seed i/[2(n+1)] has polynomial total binary description length, and its minimum gap is exactly inverse polynomial. It contains no SAT answer. Coordinate separation alone gives no quantitative separation from arbitrary formula-dependent exceptional sets.

The retained rho factors are correct. Positive original weights initialized at one remain at least one under K+q>=0. Since (1/rho)'=barH<=2, each normalized weight is at least rho>=1/(M+2xi). This lower bound incorporates the actual changing normalization and cyclic control.

Independent factorization verifies equation (3). For either complementary clause its contribution to A_ij is at least b_m K_m^2/2, including boundary zeros by the polynomial inequality. A positive gap therefore cannot shrink on a disjoint complementary block. If that block's maximum residual remains at least epsilon, integrating its logarithmic derivative gives equation (5). With epsilon=1/32 the exponent denominator is4096. Substitution of H from equation (6) forces an initial gap at least1/[2(n+1)] to reach at least4, contradicting the cube bound2. The exponent is enormous but fixed, so this is a polynomial normalized-time first-hit bound for the growing disjoint-block family, not merely a fixed-size example.

Individual first hits need not coincide. The explicit observer resolves this correctly by retaining independently verified assignments for disjoint variable blocks. It costs O(n) witness bits plus flags, and shared-variable consistency is explicitly absent from the extension. The argument does not assert simultaneous global small residuals or silently reuse this observer for overlapping clauses.

The sampling and error margins are valid: a delay of at most1/192 increases a three-variable clause residual by at most1/128, so a hit below1/32 produces a sample below5/128. The two-sided allowance 2[(3/2)/4096+1/4096] still leaves the upper endpoint below1/16. Clipping preserves the spin error bound. The approximate spin residual itself remains strictly below1/8, which certifies its rounded local Boolean assignment; direct clause verification adds an independent discrete check before storage.

## Concrete uniform bit-work audit

The vector field in each slot has degree at most6: the highest degree occurs in rho b_m sum_l b_l K_l and rho^2 sum_l b_l K_l. On the complex coordinate polydisc of radius2, the literal-product bounds imply |K|<4, |K_mi|<2, |G_i|<=32M, and auxiliary component bounds below60(M+1). Thus B=128(M+1) is valid. The input-dependent dimension d and field description have polynomial size.

The final clarified domain uses a numerical center within1/4 of the exact invariant real set, then a complex spatial ball of radius1/4. This ball stays in the complex1/2 neighborhood of the exact set. Coordinate Cauchy discs there justify the conservative derivative row bound4dB. The stated time radius1/(16dB) controls displacement and gives contraction factor at most1/4. This establishes a uniform geometric Taylor tail locally without assuming that approximate states preserve the simplex exactly.

The step denominator12288dB is an integer multiple of192, so all sampling and integer switching times are step boundaries. H is polynomial in the family size, and hence so is the step count. Propagating local error through Lipschitz amplification over H+1 requires log(1/eta)=O(Lips(H+1)+log Nstep+log(1/delta)) bits, which is still polynomial. Exponential amplification in a polynomial time bound does not entail exponential binary precision.

Truncated univariate-series evaluation of the explicit fixed-degree field, followed by division by the coefficient index, uses polynomially many arithmetic operations in Taylor order and input length. It avoids expanded multivariate derivative enumeration. Intermediate arithmetic also needs guard bits: convolution bounds, the Cauchy coefficient bounds and the explicit fixed-degree field give intermediate magnitudes with polynomial logarithms; multiplying local arithmetic error-amplification bounds across the polynomial operation count likewise gives a polynomial logarithm. Working precision can therefore allocate the required local rounding budget with polynomial guard bits. Merely bounding final Taylor coefficients would not suffice, which was flagged during review. A dyadic tolerance smaller than the displayed eta can be chosen from its elementary exponential upper bounds; an exact transcendental arithmetic oracle is unnecessary.

This is a sufficient uniform simulation argument for the explicitly bounded controlled IVP and restricted-family horizon. It is not an implemented solver or performance measurement. It does not invoke the fixed-dimensional BGP characterization for a growing-dimensional family, discard a clock coordinate, or assume that a bounded normalized state automatically has polynomial computational cost.

## Global invariant and decision scope

Independent substitution checks the four-clause residuals and the negative initial derivative of s2-s1. The seed is the actual n=3 seed, the initial normalized weights are1/4, and the first control boost does not enter the instantaneous spin force. The proposed universal monotonic-gap invariant is therefore false on this satisfiable overlapping formula. This is not evidence that its trajectory never succeeds, that every asymmetric seed fails, or that any SAT algorithm requires superpolynomial time.

The result proves finite, effective witness production only for the stated disjoint complementary family, which is structurally easy and always satisfiable. There is no all-input SAT hitting theorem. Consequently the restricted H cannot justify an UNSAT answer on arbitrary inputs. Conversely, a proved universal polynomial success horizon for every satisfiable instance together with the required simulation and certified detection would allow rejection of the remaining instances at the deadline; a separate negative-certificate formalism is not intrinsically required.

## Verdict

GO for the asymmetric-seed initialization, quantitative growing-family progress, explicit witness observer, and bounded uniform simulation argument. NO-GO for the attempted universal nondecreasing-gap invariant. INCOMPLETE for a general polynomial-time SAT algorithm and P=NP. The analytic-neighborhood ambiguity was corrected during review; polynomial guard-bit justification was added and verified in the final candidate. These are informal mathematical and complexity checks, not a Lean formalization or an executed numerical validation.
