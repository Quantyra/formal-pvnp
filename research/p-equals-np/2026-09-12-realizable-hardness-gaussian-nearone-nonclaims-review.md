# Gaussian near-one estimates: non-claims review

2026-09-12; S3134 / S3126. Verdict: **GO-WITH-NOTES** for actual finite Gaussian-count identities and relative error bounds. This independent AI wording review is not human peer review or certification of the full hardness proof.

## Evidence

Read the complete GaussianNearOne main and Checks, the dated author receipt's claims and compiler outcome, and the complete independent proof and complexity reports. The previously read planning three-lens protocol governs this review. No compiler, Git, source, public, or nested-agent action was performed.

The pair has no working-tree difference from frozen `e0410fcf2c9408a300d9853496656a26325d0b03`. Checked SHA256: main `74428b3a8efc279bf44a08fb300961943a54d2c554095ce93cd63337cafb01d1`; Checks `a035454b89a8dfcc853fb7bbfa3baa8274ccf989abcd47143ec8936462090763`; dated author receipt `b29e362fdbeea80048c9a4a6d094a20c9fc9783f78954473d9a3d18f054412f8`.

Author evidence records session 34893 with both exports successful on unchanged source. The independent proof report records session 53403 actual exit 0, eleven standard-subset profiles and eight elaborated examples. Its verification JSON hash was checked as `2498f9f71290c75e5af31ed2ba3923541dcdc7df2ebf6260e43a9d4187e6a551`. This lens attributes build results to that separate verification; it did not rerun or independently reconstruct the compiler process. Historical UNCOMPILED banners are superseded by the recorded evidence.

## Permitted mathematical description

For c<=n and b+1<=n-c, the theorem concerns the actual binary Gaussian-count ratio G(n-c,b)/G(n,b). Its leading factor is p0=2^(-bc), and its relative deficit is bounded by E=(2^b-1)/2^(n-c): p0*(1-E)<=ratio<=p0. The product identity and reciprocal orientation are proved rather than supplied as assumptions. "Near one" describes the relative factor ratio/p0, not the ratio itself; p0 can be small.

The spare dimension b+1<=n-c is part of the stated domain and cannot be dropped to cover n-c=b. Natural subtraction requires c<=n. The general estimates include b=0 or c=0 when the domain holds. The all-zero ratio is checked separately and equals one; that example does not satisfy or extend the spare-dimension theorem. No division-by-zero convention is being used to justify a positive lower bound.

The power specialization requires b+c+k<=n and gives relative deficit at most 2^(-k). k=1 gives ratio>=p0/2. k=0 supplies a weaker lower estimate and does not assert useful asymptotic closeness by itself. The J/2 specialization uses natural floor(J/2). It is not the exact real-half exponent for arbitrary odd J; a constant-factor conversion, or proof of even J for the prescribed family, is needed for that interpretation. The finite theorem neither assumes nor proves an eventual regime in which its dimension budget holds.

## Wording notes and remaining obligations

The source docstring "actual probability of an additional codimension c", the theorem name gaussian_probability_ge_half, and the receipt's probability terminology describe an intended counting interpretation. The exported statements themselves contain Gaussian counts, not a concrete event or probability kernel. The receipt explicitly acknowledges this limitation. Treating these names as proof that a specified posterior event has that probability would overstate the result. Recommended external wording is "finite Gaussian-count ratio estimate" until the event/count identity is composed and verified.

In particular, the substitutions n=dim(V)-a and b=d-a, the required rank-stable event identity, all dimension and natural-subtraction hypotheses, eventual b+c+floor(J/2)<=n, conditioning positivity, unstable-draw mass, and comparison of normalized posterior mixtures remain separate obligations. The rare-conditioning contribution involving zeta/p0 is not removed by a near-one relative count factor. No final posterior probability bound follows from this component alone.

No blocking claim inflation was found subject to these explicit qualifications. This is a finite form of an estimate already used in the manuscript, with no supported novelty or new algorithm claim. It does not establish specialized PCP/decoder or list machinery, encoded randomized polynomial runtime, fixed-L asymptotics, complete CMMSA hardness, exact learning transfer, P=NP or P!=NP, complete paper reconciliation, publication readiness, or announcement readiness.
