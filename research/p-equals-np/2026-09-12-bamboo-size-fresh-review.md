# S3103 fresh adversarial proof review

2026-09-12. Reviewer: `bamboo_size_fresh`. **PASS** for the exact analytic
explicit-monomial SoS size theorem in the reviewed artifact. No blocking
mathematical defect found. This is an independent AI-agent proof audit, not
Lean verification, human peer review, or novelty certification.

Reviewed actual file: [size mechanism](2026-09-12-bamboo-size-mechanism.md),
SHA256 `BD3DD17A493D9F1F481FBBD3946882F3AFC0904935CF07F5F4F8B80F6C318258`.
The review read the mathematical argument directly and did not rely on other
review verdicts. The S3099 mathematical source was compared to commit
`90868e5d032db6dba4cdf61d8a3fe07bfacdbfd7`; there was no file diff.
The cached primary [ECCC TR26-133](https://eccc.weizmann.ac.il/report/2026/133/)
text was checked at Definitions 4.3, 6.5--6.8 and Lemmas 6.7, 6.9--6.10,
and Theorem 6.11. The actual PDF's printed pages 72 and 73 were rendered
and visually read; the corrected D/E tables agree entry by entry.

## Stronger PSD bridge

This is a stronger consequence of the source proof, not an import of its
ordinary-degree theorem. I independently checked the chain supplying it:

- In the supported separator fiber, the character pairing has residual
  rank `h=q-u-v+t`, so its probability-normalized operator norm is
  `2^(-h/2)`. Affine shifts give separate sign multipliers. Removing the
  rank-deficient portions incurs the stated normalization cost.
- For pure opposite-side blocks, channel rank k gives pairing rank kh;
  the factorization count `2^(k(a+b))` bounds the number of rank-k channels.
  Summing the geometric series and conditioning each side on admissibility
  gives (14)--(15). Source consistency supplies the actual uniform
  admissible conditional marginals, including prescribed output constraints.
- For pure same-side blocks, the bad combined-rank indicator has constant
  row and column averages by consistency. The Schur estimate in (18) is
  therefore applicable; a small average alone would not have sufficed.
- The total-covariance inequality (19) follows by bounding covariance of
  conditional means and expected conditional covariance separately.
  Applying it on both sides gives (20), with enlarged supported separators
  and unchanged total support. It does not condition an independent density
  on all internal mixed-block outputs at a hidden quadratic cost.

These are complete-row L2 bounds. No ordinary-degree condition enters
(7)--(21). Consequently every monomial supported on at most B=2D labels
is an eligible local function, even when it contains arbitrarily many
coordinates or powers in those rows.

The J_A decomposition exists by finite-dimensional orthogonal projection
and induction on proper subsets. It need not be canonical or efficiently
computable. Local almost-sure equalities lift to each pair union by
consistency, legitimizing the expansion of R(p^2) without a global law.
Nested-support pairings vanish. For incomparable supports the components
have zero conditional means on their intersection, so the uniform
conditional maximal-correlation bound applies. The all-support estimate
uses at most `sum_(r<=2D) binom(2q^2,r)` components, covering arbitrary
coefficient signs and arbitrarily many input monomials.

The numerical inequalities are sufficient: `4D<=q/8`,
`log2 L<=1+6D log2 q<=1+3q/16`, and
`L epsilon<=2^(-3q/16+6)<1/2` for the stated range. Pair unions have at
most 4D labels, within q-2. Thus the stronger bounded-row PSD lemma is
proved by the already supplied estimates and the explicitly repeated
hierarchical argument.

## Restriction, occurrence counting, and annihilation

The original parameter is N=8q+4, so `(N-4)/8=q` and even q ensures
the source divisibility hypothesis. The original and residual m are both
q^2. In particular m>N for q>=1024. The proof does not incorrectly start
with m=N^2 or apply the residual estimate at that different m.

The rendered primary D/E templates match the file, including every star.
The four endpoint assignments, gamma values, parity offsets, and three
types of residual prefix literals match Definition 6.8. Complements have
the correct offset convention. Boundary-strip prefixes involve only the
surviving original typed label, and no image introduces another label.

Definition 4.3 charges `sum ||f_i|| ||g_i|| + sum ||h_j||`, with square
roots explicitly represented. Since every retained axiom is nonzero,
the number of original g/h monomial occurrences is at most S. Endpoint
stripping is allowed by Lemma 6.9's arbitrary interior-subterm statement.
Repeated powers cannot change the killed-by-a-zero-factor event or the
row set. The proof of that lemma bounds survival by constant-zero
killings, so it remains valid for ordinary polynomial monomials with
optional literal twins, without relying on cancellation in the quotient.

With `a=sqrt(7/8)`, the union bound is applied to occurrences having
interior support at least B-1. If `S<a^(-(B-1))`, a substitution kills all
such occurrences. Every remaining image then has at most B-2 labels.
The one-extra-label threshold is deliberate: adding the at-most-two-label
clause gives a union of at most B labels. No independence between the
different monomial survival events is needed.

Literal substitution is a real ring homomorphism when complements are
written 1-v; it preserves each square as a square of the entire substituted
root. Affine expansion can be enormous, but every expanded term retains
the same bounded row support. No bound on the expanded certificate size
is used. Signed coefficients and cancellations inside a root therefore
create no gap in either the probability count or the PSD application.

An axiom image need not be identified with a single residual axiom or
converted using an equality-ideal simulation. Lemma 6.10's semantic check
shows that it vanishes pointwise on the relevant residual local law:
endpoint transitions use constants and outputs, interior transitions use
the corresponding residual gate, and block boundaries use output/base
conditions. Even q and the template parity properties give the overall
output. All these conditions hold in the actual prefix-evaluated local
law. For each surviving multiplier term, the union law of its support
and the original clause labels is available and yields expectation zero.
Boolean and twin-equation images vanish in the Boolean quotient.

Thus all axiom products are in R's domain and have value zero, all root
squares are in its domain and have nonnegative value, and the substituted
identity would imply `-1>=0`. This establishes the exact stated lower
bound, without importing SA positivity as square positivity.

## Verdict boundary and provenance

**PASS:** for even q>=1024, N=8q+4, m=q^2, and
`D=floor(q/(32 log2 q))`, every specified explicit SoS certificate for the
unaugmented simple-bamboo encoding of I_m has
`S >= (8/7)^((2D-1)/2)`. The asymptotic consequence is
`exp(Omega(N/log N))`, superpolynomial in this polynomial-size explicit
CNF family. This is not an `exp(Omega(N))` bound and says nothing about
circuit-compressed roots, arbitrary proof systems, or P versus NP.

The reviewer supplied verification only, with no theorem repair,
construction, or change to the candidate. Only this review artifact was
written in the repository. No build, commit, push, publication, outreach,
or paid computation was performed.
