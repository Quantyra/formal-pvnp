# Bamboo v2/v3: bounded contribution and prior-art audit

2026-09-12; S3108 / S008. Evidence comparison only.
[Integrity boundary](../../INTEGRITY-CLAIMS.md).

**Verdict: a specific source-relative guarantee remains unmatched in the
inspected primary results; novelty and priority remain unknown.** The
substantive candidate contribution is the conditional mixed-row estimate
for the unchanged rank-constrained bamboo local laws, and its consequence
for arbitrary sums of complete-row functions. The v3 size theorem is a
consequential application of that estimate and the source's existing
restriction. It is not a newly invented restriction, general positivity
principle, proof-system separation, or unrestricted circuit-size bound.

This audit found no named theorem that already supplies all the exact
hypotheses and conclusion below. That finding is narrower than a novelty
certificate. General decomposition and spectral tools are established;
an unpublished observation or a more economical existing-theorem
derivation remains possible. The present audit does not establish that
the analytic proof is optimal or technically deep by field standards.

## Exact artifacts and prior audit read

The public comparison target is v3.0.0, commit
`613ceb80a6211097cd8e353c47ad79ba3069ecb5` of
[weak-rank-positivity-window](https://github.com/Quantyra/weak-rank-positivity-window/tree/v3.0.0).
The preserved v2 theorem is FULL-NOTE.md; the v3 theorem and row-space
argument are SIZE-NOTE.md. The mathematical sources are S3099 at
`90868e5d032db6dba4cdf61d8a3fe07bfacdbfd7` and S3103 at
`ea7a89576712fc21ae0127d688f703dfa05b1af1`.

Read the public proofs and attribution; the S3099
[source review](2026-09-12-shared-row-conditioning-source-review.md) and
[fresh proof review](2026-09-12-shared-row-conditioning-fresh-review.md);
the S3103 [source review](2026-09-12-bamboo-size-source-review.md);
and the earlier [significance comparison](2026-09-12-weak-rank-significance.md).
The earlier full-variable obstruction record is not confused with the
later successful S3099 proof. Earlier historical no-size claims describe
earlier versions, not the v3 theorem.

These are informal AI-reviewed mathematics. This audit adds literature
comparison, not human peer review, independent formal verification, or a
fresh proof certification. It does not edit the public mathematical text.

## Version and search record

Checked the live [ECCC TR26-133 record](https://eccc.weizmann.ac.il/report/2026/133/)
and [arXiv history](https://arxiv.org/abs/2608.08760) on 12 September 2026.
ECCC displays 7 August 2026 and no listed revision. ArXiv lists only v1,
submitted 9 August 2026. Its current PDF still says in Section 2.2 that
the bamboo method's extension to SoS was not pursued. The record also
lists a STOC 2026 proceedings reference; no claim of having compared
every proceedings/full-version byte is made.

Used the already-audited ECCC primary text for its exact numbering and
cross-checked the live [arXiv v1 PDF](https://arxiv.org/pdf/2608.08760v1).
Their pagination differs. No newer listed arXiv/ECCC theorem was found.

Searches included the exact title and identifier with SoS, positivity,
bamboo and weak rank; local distributions with conditional correlation
and PSD; high-dimensional expansion and approximate orthogonal
decomposition; and pseudocalibration with positivity. The exact-title
searches returned the original paper and secondary mirrors/summaries,
not an identified later primary extension. Secondary summaries were not
used as mathematical evidence. This is not exhaustive citation closure:
no complete citing-paper database export, private manuscript search,
author inquiry, or priority certification was performed.

## Hypotheses and conclusions that must actually match

Write d(n)=floor(n/(32 log_2 n)). All vector constraints defining the
local laws are over F_2; polynomial certificates and positivity are over
R. The actual prefix variables U remain variables in the encoding.

| Artifact | Exact hypothesis | Guaranteed conclusion |
|---|---|---|
| v2 FULL-NOTE | Even n>=1024, m=n^2, A=I_m; the source's uniform augmented independent X/Y frames, prescribed cross products, odd vectors and true prefixes | R(p^2)>=0 for every Boolean-reduced p of ordinary degree <=d(n), allowing arbitrary sums over different row contexts |
| v3 row-space lemma | Residual width q, same source law, q even>=1024, m=q^2, B=2d(q) | R(p^2)>=0 when each monomial mentions <=B typed row/column labels, with no ordinary-degree bound or bound on the total labels across p |
| v3 size theorem | Unrestricted simple-bamboo input width N=8q+4, m=q^2, A=I_m; exact clause-falsification and Boolean equations | Every identity sum f_i g_i + sum h_j^2=-1 has S>= (8/7)^((2d(q)-1)/2) |

Here S=sum_i ||f_i||||g_i||+sum_j ||h_j|| counts original explicit
ordinary monomials, including roots before squaring and repeated
occurrences. It imposes no degree bound and charges no coefficient-bit
length. It is not arithmetic-circuit size. The size scale is
exp(Omega(N/log N)), not exp(Omega(N)); the explicit input has polynomial
length in N. Input width N and residual width q cannot be interchanged.

## The original weak-rank result is the closest comparison

The primary paper's Lemma 6.4 gives SA row-degree hardness for the
restricted simple encoding. Its Theorem 6.11 gives SA size hardness.
Definitions 6.5--6.8 and Lemmas 6.7, 6.9--6.10 provide the local laws,
consistency, random substitution, survival estimate and local clause
check used here. They do not state the full varying-context square PSD.
Theorem 5.18 gives SoS hardness for a different perfect-matching
encoding; its matching extension variables are not prefix U variables.
Neither changing the proof-system name nor changing the variable
encoding is an identified implication to this precise theorem.
[Primary source](https://arxiv.org/pdf/2608.08760v1).

Thus the public result addresses a special parameter regime of the
source's suggested SoS direction. It does not settle that direction in
its entire generality, provide its stronger SA exponent for SoS, or
establish a new proof-complexity generator with all the source's stretch
and arbitrary-output guarantees.

### The A and m uniformity gap is not one undifferentiated obstacle

Source Lemma 6.4 and Theorem 6.11 quantify over every Boolean output
matrix A and every m>n, subject to the theorem's width conditions. The
source's generator interpretation relies on hardness across outputs,
not merely on the contradictory identity-output member. Public v3
states only A=I_m and m=q^2. It therefore cannot be quoted as the source's
full SoS-generator analogue.

Inspection of the displayed proof separates two issues. The local
Fourier/rank-deletion estimates in FULL-NOTE are explicitly uniform in
affine right-hand sides and supported separator assignments. Prescribed
A entries choose cosets and character signs; the worst-case estimates
use residual pairing rank and dimensions rather than an identity-entry
formula. The identity matrix supplies the stated public family's simple
rank contradiction. This is evidence that output uniformity at the
same m may require a carefully checked scope extension rather than a
new local spectral mechanism. No arbitrary-A theorem is adopted here.

In contrast, m enters the global context count. The intermediate
comparison would require checking the displayed sufficient inequality

    (sum_(r<=2D) binom(2m,r)) * 2^(-n/2+4D+5) < 1.

The public constants verify it only for m=n^2 and the stated D.
Arbitrarily large m cannot be carried through that calculation for free;
the earlier full-functional obstruction at exponential m also makes
indiscriminate unchanged-functional PSD extension untenable. A
generator application might need only a specified polynomial m regime,
not literally every m, but that regime, uniform output statement and
any amplification/reduction must be stated and reviewed explicitly.
The random restriction itself already preserves A and m: it is not the
missing source of this uniformity. These are evidence distinctions,
not a selected successor, new theorem, or generator construction.

## Where the additional mathematics is located

The exact source-dependent estimate in FULL-NOTE (1)--(15) is uniform
over every supported separator and every pair of disjoint mixed added
blocks of total typed support at most 4d(n):

    rho(block A; block B | separator=s)
        <= 2^(-n/2+4d(n)+5).

The operator acts on **all** centered complete-row L2 functions with the
actual conditional marginals, not just low-coordinate-weight characters.
It retains both same-side rank exclusions and prescribed cross outputs.
This supplies what local consistency by itself does not supply.

Its proof uses an affine bilinear character operator of rank
h=n-u-v+t, probability-normalized norm 2^(-h/2), rank-deletion bounds,
a rank-k Fourier-channel estimate 2^(-hk/2), and counting channels by
rank rather than by all matrix entries. Same-side exclusions use a
Schur bound. Total covariance reduces mixed grouping to pure cases with
enlarged supported separators. These general tools are familiar. The
source-specific work is verifying their fibers, normalization, uniformity
and growing-support estimates together in this exact law.

The assembly in FULL-NOTE (16)--(24) is an elementary finite-dimensional
lemma: decompose a local function into complements of all proper-support
spaces, annihilate nested pairings, and bound incomparable pairings by
conditional correlation. With L_ctx=sum_(r<=2d(n)) binom(2n^2,r), it gives

    R(p^2) >= [1-(L_ctx-1) epsilon] sum_A ||h_A||^2 >= 0.

The important accounting is supports rather than the exponentially large
dimensions of their complete-row spaces. This is useful, but it should
not be promoted into an original general decomposition method. The
row-space lemma is already latent in these all-L2 estimates; v3 explicitly
states and justifies the stronger scope needed by the restriction.

The remaining v3 argument is mostly transfer accounting: count original
g_i/h_j monomials under S, apply the source's survival estimate to their
interior row support, and use the surviving root supports plus local
annihilation of the substituted original clauses. Its handling of roots,
complements and boundary rows is necessary correctness work. It is not a
second independent spectral mechanism or a new restriction distribution.
The corrected D/E template transcription is source restoration, not a
mathematical improvement to the source.

## Decisive general-theorem comparisons

**Local positivity versus PSD.** Kothari--Lin's August 2026
[Theorems 1.2--1.3](https://arxiv.org/html/2608.18048v1) separate exact
Cauchy--Schwarz from SA local positivity and give an approximate inequality
with additive coefficient-l1 terms. Those terms do not certify exact
nonnegativity for unrestricted polynomial coefficients. The public proof
instead needs a relative operator estimate after resolving local kernels.
Thus generic SA consistency or approximate Cauchy--Schwarz does not
subsume the unchanged R theorem. This comparison was already present in
the earlier audit and is retained for its exact logical role.

**Dependent-input decomposition.** The earlier S3099 audit checked
[Chastaing--Gamboa--Prieur, Theorem 1](https://arxiv.org/abs/1112.1788v3).
Its positive lower-domination hypothesis fails for one bamboo X/Y pair:
the joint law forbids a dot parity having positive product-marginal mass.
This rules out that direct import, not every general decomposition
theorem. The public proof constructs local complements directly and does
not assert product-law orthogonality.

**HDX approximate orthogonality.** Read Dikstein--Dinur--Filmus--Harsha,
[arXiv:1804.08155v5](https://arxiv.org/pdf/1804.08155v5), dated January
2024, Theorems 3.2, 4.6 and 6.2, and Corollaries 6.11--6.12. These give
decomposition and approximate orthogonality for functions on measured
complexes/expanding posets under specified operator hypotheses. They are
substantial precedent for the general method. They do not state the
bamboo conditional estimate or identify its moment form. Their constants
also require tracking as the level grows; a fixed-level O(gamma) is not
automatically the public d(n) window.

One must not reject an HDX route simply because there is no global
satisfying assignment on all m labels. A truncated complex of locally
valid assignments can still be formed. The missing applicability map is
more precise: prove the required walk/link estimates for that weighted
object and identify its inner product with the **unchanged** union-law
pairing. Ordinary top-face averaging introduces containment weights
depending on supports and intersections. No verified renormalization or
named theorem removing those differences was located. HDX could offer a
different or shorter derivation; this audit does not prove otherwise.

**Explicit HDX SoS hardness.** Dinur--Filmus--Harsha--Tulsiani,
[arXiv:2009.05218v1](https://arxiv.org/pdf/2009.05218v1), 11 September
2020, Theorem 1.1, constructs explicit 3XOR instances hard for
O(sqrt(log n)) levels using LSV complexes, cosystolic expansion and local
isoperimetry. Its variables correspond to edges and its constraints to
triangles. It does not identify the bamboo family, its functional, or its
prefix encoding. A reduction preserving the relevant moments/certificate
measure would be additional mathematics, not a consequence of both
results mentioning expansion and SoS.

**Pseudocalibration.** Read Barak--Hopkins--Kelner--Kothari--Moitra--Potechin,
[arXiv:1604.03084v2](https://arxiv.org/pdf/1604.03084v2), April 2016,
Theorem 1.1 and the positivity/factorization organization in Sections
3, 6 and 7. Their planted-clique lower bound comes with a model-specific
PSD analysis; pseudocalibration is not a theorem that every prescribed
locally consistent functional is PSD. The bamboo proof preserves its
deterministic pre-existing moments, rather than choosing moments by a
planted-instance truncation. No instance distribution, truncation identity
and applicable PSD theorem mapping that construction to this R was found.
Finite Fourier analysis and approximate Gram factorization remain known
machinery, not evidence of independent methodological novelty here.

## Significance, limitations and disposition

Relative to the source as currently posted, v2/v3 answer a real extra
question: the actual simple-bamboo functional supports a growing
full-variable/row-space square-positivity window, and the source's
restriction can consequently exclude small **explicit monomial** SoS
certificates for the specified unrestricted family. This is more than a
renaming of its SA theorem or another fixed-character Gram calculation.
The strongest potentially distinctive object to cite is the uniform
mixed-separator estimate and exact unchanged-functional conclusion.

The size corollary makes that analytic result useful to proof complexity,
but most of its transfer machinery is imported. There is no basis here
for claiming a new general SoS lower-bound method, first-ever weak-rank
SoS bound, optimal constants/exponent, or a contribution to unrestricted
proof-system hardness. The separately reviewed
[compression intake](2026-09-12-bamboo-compression-intake.md) identifies
known polynomial circuit certificates for this family through matrix
identity proofs and rational Hilbert-like IPS. That limitation is
compatible with v3 and materially limits broader significance.

Recommended description: an informal, AI-reviewed, source-specific
positivity extension and explicit-size consequence using established
tools, with priority unasserted. No identified prior theorem forces a
retraction of the stated delta; no unsuccessful search justifies adding
novelty language. This audit selects no new theorem route and requests no
publication change. Human specialist assessment would add evidence about
interest and priority, but no outreach is authorized or performed here.

Only this audit record was written. No theorem, experiment, public edit,
commit, push, release or paid action was performed. A subsequent review
should check the exact comparison maps and this bounded verdict rather
than treat this literature audit as mathematical certification.
