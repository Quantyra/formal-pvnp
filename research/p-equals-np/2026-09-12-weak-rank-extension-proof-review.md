# Independent proof review: full X-only weak-rank Gram extension

2026-09-12; S3091 / E004 / S008; [integrity](../../INTEGRITY-CLAIMS.md).

**Verdict: PASS for the full X-only positivity theorem and matching-order first-failure bound in the [actual author draft](2026-09-12-weak-rank-extension.md).** I inspected the complete author draft after checking its early statement, including its explicit constants and asymptotic conclusions. This is an AI-agent proof review, not formal verification, peer review, or novelty certification. The author supplied the independent-odd-row comparison, conditioning estimate, full Fourier Gram, Gershgorin argument, and matching-order conclusion before this reviewer checked them. This reviewer supplied no candidate construction or new mathematical repair.

## Source contract

I read the locally downloaded primary text of [Garlik--Gryaznov--Ren--Tzameret, TR26-133](https://eccc.weizmann.ac.il/report/2026/133/download/), Definitions 6.5--6.6, Lemma 6.7, and the definition of R in the proof of Lemma 6.4. A live PDF fetch timed out. For the X-only marginal and even n, the source is uniform over odd rows which, together with the all-ones vector e, are independent. R is defined through row degree n-2. This does not assert an ordinary-degree pseudoexpectation on every variable of the encoding.

## Independent checks of the proposed argument

Let Q have m independent uniformly odd n-bit rows. Coordinate Fourier characters indexed by subsets of the mn coordinates of size at most D are orthonormal under Q if 2D<n. Indeed, a nonempty symmetric difference has size at most 2D; its character has nonzero mean on an odd row only when its support on that row is empty or the whole row. Whole-row support is excluded by 2D<n. This argument includes odd within-row character supports; it does not silently discard the characters which fail to descend through e. These characters span all multilinear X polynomials of ordinary degree at most D by the invertible coordinate change between x and 1-2x.

For any t relevant rows, passage to the quotient by e preserves uniformity, and the odd affine hyperplane has N=2^(n-2) points. After j independent odd quotient rows, exactly 2^(j-1) points of their span are odd. Consequently the source marginal is Q conditioned on independence of these t quotient rows, with failure probability

    delta_t = 1 - product_(j=1)^(t-1) (1-2^(j-1)/N)
            <= (2^(t-1)-1)/N.

The conditioning event is local to each moment's row support. No global event requiring m independent quotient rows is needed or available when m>n-1. This distinction does not impair an entrywise perturbation argument.

For a nonconstant character Z with Q expectation zero and |Z|=1, its conditional mean has absolute value at most delta_t/(1-delta_t), by separating Q expectation over the event and its complement. Gram diagonal entries remain exactly one. Every off-diagonal entry is such a character on at most 2D rows. Therefore, with L=sum_(j=0)^D binom(mn,j), the minimum Gram eigenvalue is at least

    1 - (L-1) delta/(1-delta),

where delta=(2^(2D-1)-1)/N, provided delta<1. This follows directly by bounding the off-diagonal quadratic form with sum_(a!=b)|c_a c_b| <= (L-1) sum_a c_a^2. The sufficient condition is equivalently L*(2^(2D-1)-1)<N. With 2D<=n-2, all squared-polynomial entries are in the actual source domain.

Exact-integer evaluation of this sufficient inequality for m=n^2 gives the largest certified D as 1, 1, 3, 5, 10, 19, 36 at n=16,32,64,128,256,512,1024 respectively. These are checks of a sufficient bound, not exact first-failure degrees; no enumeration of a gigantic Gram matrix is claimed.

## Final draft and constants

The actual draft uses the exact delta_(2D) in its theorem and the union bound only to derive its explicit sufficient choice. Both uses are valid. For D=floor((n-4)/(log_2(mn)+2)), q=mn, the inequalities L<=2q^D and delta_(2D)<2^(2D-n+1) give L delta_(2D)<2^(D(log_2 q+2)-n+2)<=1/4. Its eigenvalue coefficient (1-L delta)/(1-delta) is then greater than 3/4. The D=0 constant case is correctly separated. Since log_2 q+2>=3, the domain bound 2D<=2(n-4)/3<=n-2 also holds. For m=n^2 this D is asymptotically of order n/log n.

I also re-read the earlier obstruction and its independent proof review. Its p has ordinary degree at most 2k=O(n/log n) and its square is in R's domain, with negative expectation. Combining this upper bound with the new full X-only positive-space lower bound establishes the stated Theta(n/log n) scale for the minimum degree of an X-only polynomial having a defined negative square. This remains an order bound, not an exact first-failure spectrum. For any fixed polynomial row exponent, the explicit positivity window eventually exceeds c log n for each fixed c; hence the exclusion of constant/logarithmic-degree X-only witnesses is correct.

No mathematical defect or repair was identified. The introductory shorthand about degree Omega(n/log n) was clarified to say "degree at most D"; the theorem and proof already had the correct quantifiers. I then inspected the author's final added recall of the upper-bound proof: the orbit average, excluded-covector count, Gram entries, parameter inequalities, and degree/domain accounting agree with the previously reviewed calculation and pass. For editorial precision, the geometric-sum failure bound is for t>=1 (t=0 has its separately declared value zero), and conditioning refers to the local frame-success event. Neither clarification changes an application in the proof, where every off-diagonal support is nonempty. The full theorem needs neither new experiments nor a Lean build for this mathematical-review disposition.

## Claims boundary

Positivity of this entire X-only polynomial space is stronger than positivity of the old single-character principal block, but it is still only a principal block of the encoding's full functional. Y variables and auxiliary variables remain outside the argument. No feasible SoS extension, satisfaction of all ordinary-degree constraints, SoS lower bound, proof-size transfer, or P-versus-NP conclusion follows. Combined with the prior explicitly negative X-only square, suitable explicit asymptotic constants can locate the first X-only positivity failure to order n/log n for m=n^2; they do not identify its exact threshold.

No Lean build, commit, push, publication, outreach, or paid computation was performed. Only this review file is authored by this reviewer.

## Curated candidate mathematical extraction

I independently read the actual curated candidate's NOTE.md, README.md, and REVIEW.md after extraction. Its positivity proof, source domain, conditioning events, complete low-degree character basis, upper witness, and asymptotic conclusion agree with the argument reviewed above. The explicit transitivity explanation and the t>=1 restriction on the failure bound are correct. Mathematical extraction: PASS. The review disclosure correctly distinguishes the earlier constructive contributor from the independent proof reviewer and does not claim human peer review or formal verification. I requested two statement-level precision edits: include n>=16 directly in the abstract and exclude the zero polynomial in the strict-positive logarithmic-degree corollary. Neither changes the already precise theorem or its proof. This extraction check is a mathematical disposition, not publication authorization or novelty certification.

Both requested precision edits were verified in the final candidate. The reviewed NOTE.md SHA-256 is `04127A71BB16B61D0F130861B7ACEE4C15C64FCA2967673A10F37983655D6613`. Final mathematical extraction verdict remains PASS.
