# Gaussian near-one estimates: independent proof review

2026-09-12; S3126 / S3134. Verdict **GO-WITH-NOTES**, bounded to actual finite binary Gaussian count-ratio identities and estimates. This is independent AI review, not human peer review or full hardness certification.

Frozen candidate `e0410fcf2c9408a300d9853496656a26325d0b03`. Complete main/Checks, author receipt and the imported GaussianRatio orientation/product definition were inspected under the existing companion and planning three-lens instructions. No source, Git, configuration, aggregate, dependency or publication changes were made.

## Independent verification

Session **53403** terminated with actual exit **0**. Both main and Checks exported into fresh `.lake/build/gaussian-nearone-independent-review-20260912/lib/lean`. All **11** requested profiles appeared in source order, containing only `propext`, `Classical.choice` and `Quot.sound`; all **8** examples elaborated. Source token audit found no sorry, admit, native_decide or new axiom declarations. Main's diagnostic log is empty.

The adjacent `2026-09-12-realizable-hardness-gaussian-nearone-proof-verification.json` records full runner, commands, environment, eleven package pins, all 61 dependency copy hashes, frozen/current sources, raw UTF-8 logs, log/output hashes, memory prechecks and actual exits. Its SHA256 is `2498f9f71290c75e5af31ed2ba3923541dcdc7df2ebf6260e43a9d4187e6a551`.

All 61 prior ordinary oleans were verified against their original independent export receipts, copied from the sampler-proximity independent root, then verified again. Only the fresh local output root and pinned package/core roots appeared in LEAN_PATH; author and earlier independent proof output roots were excluded. Only the new pair compiled, without aggregate/broad build or cache download.

Lean 4.34.0-rc2 compiler `6a10ac8c22beadecabdbb0919c2b50214762f91d` was verified. Manifest SHA256 was `825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0`, and all eleven actual checkout HEADs matched. LEAN_NUM_THREADS=1. GlobalMemoryStatusEx measured 3,011,350,528 available physical bytes before main and 3,031,822,336 before Checks, above the 768 MiB precheck. The runner monitored its owned child against the 640 MiB physical-memory/disk floor. Raw bytes and actual exit metadata were preserved before UTF-8 decoding. Compiler ownership was released on terminal completion.

| Export | Source SHA256 | Independent output SHA256 |
|---|---|---|
| GaussianNearOne | `74428b3a8efc279bf44a08fb300961943a54d2c554095ce93cd63337cafb01d1` | `4650e598f60960e3bfe02a8f22774de2c6efba7535106e8975ad6fc4900d412c` |
| GaussianNearOneChecks | `a035454b89a8dfcc853fb7bbfa3baa8274ccf989abcd47143ec8936462090763` | `aa743913f433e8f368efa81a526dce32c5378c36bab93cc2673d5be2540e1949` |

## Adversarial mathematical audit

The ratio is the actual rational cast `gaussian (n-c) b / gaussian n b`, with leading factor `1/2^(b*c)`. The imported identity initially has the opposite orientation; taking its inverse correctly reverses both Gaussian and normalized-frame quotients and changes the power to its reciprocal. The theorem proves this identity rather than assuming a ratio formula or desired closeness.

The explicit product factors are `(1-2^i/2^(n-c))/(1-2^i/2^n)` for i<b. For m<=n the normalized frame product at m is at most the product at n. The elementary product lower bound gives normalizedFrame(m,b)>=1-E, E=(2^b-1)/2^m. Since the denominator normalized product is positive and at most one, division can only increase the nonnegative numerator. Thus the relative factor lies in [1-E,1], with the correct orientation and no independence hypothesis.

The domain c<=n and b+1<=n-c provides one spare dimension. It ensures all relevant Gaussian counts and normalized products are positive, avoiding invalid inverse cancellation or zero-denominator semantics. Natural subtraction is only simplified using explicit dimension inequalities. The theorem intentionally does not cover the boundary m=b without the spare dimension; it must not be used there by dropping that premise.

`error_le_inverse_pow` proves E<=2^(-k) from b+k<=m. `gaussian_near_one_pow` carries the equivalent original-dimension budget b+c+k<=n. Setting k=1 yields a lower bound leading/2; setting k=J/2 yields the exact finite exponent floor(J/2), since J is natural. For odd J this is not literally a bound with the real exponent J/2. An asymptotic real-half rewrite would need a separate constant-factor conversion; no such rewrite is claimed by this review.

The admissible domain is nonempty, including explicit positive examples n=4,b=1,c=1 and n=6,b=2,c=1,k=3 in Checks. Zero b and zero c identities are separately verified. The all-zero Gaussian ratio equals one, but the spare-dimension theorem is correctly unavailable there; the boundary example proves the identity directly. Large k cannot be supplied without the actual spare-space budget. No circularity or vacuity issue was found.

## Notes and remaining scope

No blocking proof, orientation, cast, dimension, or product-bound issue was found. Historical UNCOMPILED banners are superseded by author and independent evidence; unchanged proof bytes were preserved.

The source's probability terminology refers to the intended interpretation of the count ratio. This module itself does not identify a concrete probability kernel or event with that ratio, prove eventual dimension budgets for the prescribed sampler, or compare normalized posterior mixtures. Those connections remain mandatory before using it as a sampler probability statement. Specialized geometry/decoder dependencies, full fixed-L assembly, encoded runtime, hardness and learning transfer remain outside this review. No novelty, complete certification or publication-readiness claim follows.
