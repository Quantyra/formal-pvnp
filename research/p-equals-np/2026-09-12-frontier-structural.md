# Weak-rank local distributions: a polynomial-dimension Gram obstruction

2026-09-12; S3090 under E004/S008; [integrity](../../INTEGRITY-CLAIMS.md). Research assessment, not a formal proof or publication artifact. **The unchanged-functional mechanism is rejected.** No SoS lower bound, new proof-complexity generator, or P-versus-NP conclusion is established.

## One candidate and its actual target

The candidate was to reuse the current weak-rank Sherali--Adams (SA) local distributions as a sum-of-squares (SoS) pseudoexpectation. The first falsifiable obligation is positivity on squares, before attempting a size-to-degree argument or generator iteration. The intended regime is m polynomial in n, not exponentially many matrix rows.

The closest primary source is [Garlik--Gryaznov--Ren--Tzameret, TR26-133](https://eccc.weizmann.ac.il/report/2026/133/download/), dated August 7, 2026. Section 6.1, Definitions 6.5--6.6 and Lemma 6.7 construct consistent local distributions for their restricted bamboo-tree rank encoding; Lemma 6.4 gives SA row-degree n-1. Section 2.2, printed page 14, explicitly leaves extension of this method to SoS unpursued. This is specific to the bamboo-tree route: Theorems 2.3 and 5.18 already give SoS size lower bounds for the distinct perfect-matching encoding. Their functional R has domain row-degree at most n-2. For X-only rows, its law is uniform on odd vectors in F_2^n that, together with the all-ones vector, are linearly independent. The ordinary SoS positivity requirement is stronger than SA term positivity. These are source imports, not reproved source theorems.

A successful extension plus a separately proved size-transfer argument would give a lower bound for a stronger restricted proof system on explicit rank formulas. That is a meaningful proof-complexity intermediate objective, but would not imply P != NP: a fixed-system lower bound does not exclude every polynomially bounded Cook--Reckhow system. Neither the source's generator iteration nor its circuit-lower-bound-formula consequences transfer to SoS automatically. There is no direct PNP implication from the result below.

## Exact first-step calculation

Fix even n >= 16, m=n^2, and A=I_m, so rank(A)>n. Write e for the all-ones vector, H for the odd vectors, and

    f_i = (-1)^(x_{i,1}+x_{i,2}) = (1-2x_{i,1})(1-2x_{i,2}).

The following calculation concerns only X rows, so A does not enter their local marginal. It remains a test on the intended unsatisfiable rank family.

Let V=F_2^n/<e>, of dimension d=n-1. Because n is even, parity descends to a nonzero covector a on V. The character b(v)=v_1+v_2 also descends, and b is neither 0 nor a. A source sample on t distinct X rows becomes a uniform ordered independent t-frame v_1,...,v_t with a(v_i)=1. Every quotient frame has exactly 2^t lifts, so uniformity is preserved.

For fixed such a frame, the stabilizer of a acts transitively on covectors outside {0,a}. Equivalently, its action on these frames permits replacing fixed b by a uniform covector outside {0,a} when computing the restriction pattern (b(v_1),...,b(v_t)). Restriction to an independent frame is surjective; each pattern z in F_2^t has 2^(d-t) preimages among all covectors. Removing 0 and a removes one preimage of 0^t and one of 1^t. Consequently, for every positive even t <= n-2,

    R(product_{i in T} f_i)
      = [2^(d-t) sum_z (-1)^|z| - 1 - (-1)^t]/(2^d-2)
      = -1/(2^(n-2)-1).                                      (1)

For odd t the same expression is zero. For t=0 the moment is 1. This is a calculation about the source's particular distribution, not every locally consistent distribution for the rank constraints.

Take

    k = 2 ceil(n/(2 log_2 n)),
    C = { S subset [m] : |S|=k },
    M = binom(m,k), N=2^(n-2),
    g_S = product_{i in S} f_i, p = sum_{S in C} g_S.

For distinct S,T, S symmetric-difference T has positive even size at most 2k. Boolean multilinear reduction gives g_S g_T=g_(S symmetric-difference T). Thus the complete Gram matrix of these g_S is

    G = N/(N-1) I_M - 1/(N-1) J_M.                           (2)

Its eigenvalues are N/(N-1) on the sum-zero subspace, and (N-M)/(N-1) on the constant vector. In particular,

    R(p^2) = M(N-M)/(N-1).                                   (3)

For even n>=16 the chosen k satisfies 2k<=n-2. One way to check the range is k<=n/log_2 n+2, and n/log_2 n+2<=(n-2)/2 for n>=16; the latter difference is increasing there and is positive at 16. Therefore every monomial of the expanded square has row-degree at most n-2, inside R's actual domain. Its ordinary polynomial degree is at most 4k=O(n/log n).

Furthermore k<n and

    M = binom(n^2,k) >= (n^2/k)^k > n^k >= 2^n > N.           (4)

Equations (3)--(4) give an explicit negative square in the polynomial-m regime. Thus the source functional cannot itself be used as a SoS functional through this degree. The certificate is symbolic and has exponentially many indexed summands; no polynomial-size SoS refutation follows from its existence.

For example n=16,m=256,k=4 gives M=174792640>N=16384, row-degree 8 and ordinary squared degree at most 16. The asymptotic family, rather than this small example, is what prevents dismissing the obstruction as an exceptional low-n defect.

## What passes, what fails, and novelty limits

For this entire character block, (2) proves positivity exactly when M<=N. This is only a principal Gram block, not positivity of the full functional at smaller degree. It supplies no smaller-degree SoS lower bound. A replacement functional is not constructed.

The initial square sum_i f_i failed only at m>N, an exponential-row regime where an exponential-in-n proof-size lower bound would cease to be superpolynomial in input length. That preliminary diagnostic is superseded by the multirow calculation above; it is not the main rejection evidence.

The useful local outcome is an explicit obstruction to one concrete attempted transfer, at m=n^2 and row-degree O(n/log n). The exact calculation uses elementary frame symmetry and character orthogonality. It may be known or implicit in existing work; no priority, fastest-bound, or novel-theorem claim is made. The source itself already proposes investigating SoS, so merely proposing that extension is not discovery.

Bounded primary-source searches on September 12 covered the paper title with SoS/sum-of-squares, and rank-principle pseudoexpectation positivity. The [arXiv record](https://arxiv.org/abs/2608.08760) was checked alongside the full ECCC PDF; no separate primary follow-up establishing this exact Gram calculation was found in these searches. Search absence does not establish novelty. Unreviewed automated summaries were not used as mathematical evidence.

Disposition: reject **reuse of this unchanged functional through the displayed degree**. Do not infer that weak rank has short SoS proofs, that a modified functional cannot work, or that all lower-degree versions fail. No automatic successor campaign or publication is selected. The overall goal remains unresolved.

## Verification and contribution record

The source PDF and its relevant definitions, consistency lemma, and open-directions section were read. Exact rational spot checks gave the even-character moments -1/15 at n=6 and -1/63 at n=8, and integer checks of (4) and the domain inequality passed at n=16,32,64,128,256. The general argument is equations (1)--(4), not those finite checks.

The initial scout derived the pair-character diagnostic. The independent selection reviewer proposed the multirow character construction and polynomial-m amplification, and the scout independently derived its quotient-frame count, degree/domain accounting, and parameter bound. This is a substantive reviewer contribution, so that reviewer is not independent of the final mathematics. The separate independent mathematical review is complete and linked below; it certifies the bounded calculation, not novelty or a complexity-gain edge. No Lean build, commit, push, publication, outreach, or paid computation occurred.

## S3090 review closeout

| Lens | Actual record | Outcome and scope |
|---|---|---|
| Independent proof | [Proof review](2026-09-12-frontier-proof-review.md) | PASS for the two bounded mathematical rejection tests. |
| Source and complexity | [Selection/constructive-source review](2026-09-12-frontier-reselection-review.md); [structural source review](2026-09-12-frontier-structural-source-review.md) | GO for scoped source contracts, complexity consequences and structural source correction. |
| Independent non-claims | [Nonclaims review](2026-09-12-frontier-nonclaims-review.md) | GO for preservation and the scoped ledger entry; publication HOLD. |

The selection reviewer contributed mathematics and is not the independent proof lens. The proof reviewer is distinct and contributed no candidate mathematics; the structural source reviewer is distinct from the structural author. These are AI-agent reviews, not Lean verification, human peer review or novelty certification. Selection NONE for the two tested candidates; broader objective ACTIVE. The [S3090 ledger node](2026-09-11-research-meta-graph.md#s3090-reject-two-tested-frontier-operations) preserves their bounded rejection evidence. No public artifact is changed.
