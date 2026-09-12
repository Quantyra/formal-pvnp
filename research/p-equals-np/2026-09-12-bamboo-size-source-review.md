# Source and complexity audit of the bamboo-specific size route

2026-09-12; S3103 / E004 / S008; [integrity](../../INTEGRITY-CLAIMS.md).
**Final actual-author-file source/model and complexity-scope verdict: GO.**
This supersedes the preliminary pending statuses below. The independent
proof lens must certify the new row-space PSD argument and final theorem.

I authored the preceding exact degree corollary, not the present size-route
construction or the underlying full-PSD theorem. My role here is primary
source applicability and complexity interpretation, not independent proof
certification of a construction to which I contribute. I supplied the source
contract, parameter and certificate-count checks below. I also pointed out
that the semantic clause cases in source Lemma 6.10 can be checked locally
without importing its stated SA conversion as an SoS equality simulation;
the author independently reported using that same approach. This is disclosed
methodological overlap, not an independent proof verdict on that bridge.

## Strongest directly relevant source route

I read the cached primary text of Garlik--Gryaznov--Ren--Tzameret,
[ECCC TR26-133](https://eccc.weizmann.ac.il/report/2026/133/), Section 6.2,
Definitions 6.8, Lemmas 6.9--6.10 and Theorem 6.11, as well as Definitions
4.3--4.4 and Section 6.1's exact simple-bamboo and local-law conventions.
The source already supplies a size-to-row-degree restriction mechanism for
this simple-bamboo encoding. Its Theorem 6.11 concludes an SA size lower
bound (sqrt(8/7))^((n-4)/8-1), under m>n>=20 and 16 dividing n-4.
That is the relevant mechanism to audit first. No generic variable-count
size-degree tradeoff is needed to formulate this route.

Write the input width as N=8q+4 with q even. Source Definition 6.8 keeps m
and A and changes the width to q, with the residual **restricted** simple
bamboo system BT-bullet-Rank-prime_q^m(A). Its two endpoint pairs use
coordinates {1,2,N-1,N}. Row types are sampled independently from [4],
and each free X/Y row has an independent random bit. The 8 blocks use the
source's D/E patterns. Every old X/Y/U literal maps to a constant or one
literal in the residual variables, including boundary prefix U variables.
The maps to complements are literal substitutions, not linear substitutions
that are assumed to preserve expanded monomial count.

The exact imported PSD window requires m=q^2 and A=I_m at the residual
width. Choosing these already in the input gives m=q^2>N for q>=1024.
One must not start with m=N^2 and then assert that the residual parameters
meet m=q^2. The proposed family with input width 8q+4 and m=q^2 avoids that
parameter mismatch directly. Its unsatisfiability is nonvacuous by
rank(XY)<=N<m=rank(I_m) over F_2.

## Probability contract and the special endpoints

Lemma 6.9 says that, for a term t and a subterm t' excluding coordinates
{1,2,N-1,N}, with r typed labels in t',

    Pr[t restricted by rho is not zero] <= (sqrt(7/8))^r.

The square root is on the constant 7/8, not on r. The source proof takes
a minimal row-covering subterm, decomposes its bipartite support into
isolated vertices and stars, and uses independent row data across those
components. The estimate applies to literal terms, hence also to ordinary
monomials viewed as terms containing only positive literals.
Repeated powers in an ordinary monomial can be replaced by their Boolean
squarefree term for this survival/support check: Boolean evaluation is
unchanged and support does not grow. This does not assume a raw-degree
bound on the original certificate.

Every variable at those four special coordinates maps to a constant,
including each prefix U at those coordinates. They can affect whether an
image vanishes, but cannot contribute residual row support. The interior
subterm therefore controls the number of surviving residual typed labels.
The substitution never adds a free label: boundary-prefix images can drop
one label. These points are necessary when using Lemma 6.9 on high-support
original monomials; it is not a statement that every original high-row
monomial is killed with the same bound irrespective of its endpoints.

## Exact SoS size and the root-polynomial issue

Source Definition 4.3 measures SoS size by

    sum_i ||f_i|| ||g_i|| + sum_j ||h_j||

in the identity sum_i f_i g_i + sum_j h_j^2=-1. Here ||p|| is expanded
ordinary monomial count, and the square contribution counts the root
polynomial h_j, not the expansion of h_j^2. Boolean equations must be
included expressly in the Boolean instance; optional twins have their
complement and Boolean equations. For each retained nonzero axiom f_i,
||f_i||>=1. Thus the original multiplier and root monomials together
number at most the declared certificate size. Zero axioms contribute no
useful certificate summand and can be deleted.

It is consequently legitimate to union-bound the source killing estimate
over original monomials of g_i and h_j. It is not legitimate to replace
the source size by the number of expanded squared-root cross terms without
accounting for that change. Nor should one assume the complement
substitution preserves expanded ordinary monomial count: the expansion of
a long literal product can be large. What is preserved for this argument
is that every resulting monomial has support inside that product's label
set. Once a uniform row-bounded positivity theorem is available, arbitrary
sums over such terms need no bound on the size of their expanded images.

## What the published positivity proof does and does not state

The existing public theorem states positivity for every actual polynomial
of ordinary degree at most D=floor(q/(32 log_2 q)). It does not state
positivity for every polynomial of typed row degree at most 2D and arbitrary
ordinary degree. The latter conclusion cannot simply be cited as the
published theorem: a long monomial within one row need not have ordinary
degree at most D.

There is a concrete proof-level lead. The full proof's final bridge uses
the entire finite Hilbert space L2(rho_A) of complete-row functions for
|A|<=2D, decomposes each original monomial in that space, pairs pieces in
unions of size<=4D, and applies an all-context count. Its operator estimate
is also on complete-row functions. The ordinary-degree hypothesis enters
that bridge through the bound on the original monomial's typed support.
This permits an explicit proposed extension, but it must be written and
independently audited as an additional row-bounded theorem, including the
local-identity transport and quantitative loss. High-degree complete-row
functions cannot be silently declared to have low ordinary degree.

## Residual axioms: the exact source transport boundary

Lemma 6.10 is stated for SA. It checks original output and base axioms,
special summation endpoints, starts of blocks, and interiors of blocks.
Every restricted original clause is either satisfied, a residual gate
axiom, or a consequence of the relevant residual output and base axioms.
All relevant variables stay within the original pair of free typed labels;
the boundary index m+1 contributes no free label. At an internal block
start the previous residual output can be needed along with the next base
gate. It must not be dropped from the local satisfaction check.

The source's claim of a constant-size **SA derivation** is not by itself
an equality-ideal representation usable with arbitrary signed multipliers
inside an SoS identity. A faithful route can instead verify each image
clause directly on the residual local source law using the source's
semantic cases. If the entire clause-multiplier support fits that law,
its expectation vanishes pointwise. This only needs local satisfaction,
not a small SoS proof conversion, a global satisfying measure, or a claim
that arbitrary SA proof lines can be inserted into an SoS identity.

Substitution preserves a polynomial identity and sends each square to a
square. Boolean and twin equations vanish under residual Boolean reduction
and complement substitution. The author must keep the row budget for
each whole clause times each surviving multiplier term, not infer it
from a cancellation in an expanded product.

## Pending actual-file audit and boundaries

The author has proposed a conservative root/multiplier cutoff of 2D-2,
with a union bound over terms having interior row count at least 2D-1.
The stated source estimate and size convention support this proposed
threshold contract. Its final consequence, constants, local satisfaction
argument and new row-bounded PSD statement must be checked against the
saved author record before a final disposition is assigned.

Any successful result here would concern a particular SoS monomial-size
measure and an explicit simple-bamboo family. It would not be an ordinary
degree result alone, a result for all proof systems, a SAT runtime lower
bound or a complexity-class separation. The existing PMRank SoS size
result uses another encoding and remains a separate precedent. Novelty
and priority are unknown. No experiment, commit, push, publication,
outreach or paid computation was performed for this source audit.

## Final actual-file audit

I read the entire saved [author record](2026-09-12-bamboo-size-mechanism.md),
then verified its corrected template lines against a visual rendering of
the primary PDF's printed page 72. The final inspected author SHA256 was
`BD3DD17A493D9F1F481FBBD3946882F3AFC0904935CF07F5F4F8B80F6C318258`.

Two source-transcription defects were found and corrected by the author:
the first E row is `[1 0 0 1 * * * *]`, and the first D row is
`[1 * 1 0 0 * * *]`. Plain PDF text extraction had misleading column
alignment for D. I checked all remaining template rows visually and
verified that the saved author file now contains the exact source matrices.
These corrections are my source-audit contribution; they must not be
described as a review that required no correction. They restore the
specified source restriction, not a newly designed distribution or a
repair of its probabilistic proof. I used the PDF skill for this read-only
visual source check.

The final source/model match is GO. The input is the unaugmented,
unrestricted **simple** bamboo system at N=8q+4,m=q^2,A=I_m. Its residual
is exactly the source restricted prime system at q,m,A, including both
boundary parity strips. All width, parity and m>width hypotheses hold.
No matching-variable or z-variable simulation is smuggled into this route.

The size and probability conventions match the primary source. The saved
proof counts original g/h monomials under Definition 4.3's actual size;
Lemma 6.9 supplies the factor a^r with a=sqrt(7/8). The conservative
cutoff r>=B-1 is sufficient to put surviving root and multiplier images
on at most B-2 rows. It treats endpoint factors correctly, does not count
squared-root cross terms, does not assume short complement expansions,
and does not impose an unmentioned degree restriction. A product with
a whole substituted clause then fits at most B residual typed rows.

The saved row-space lemma is explicitly presented as an additional
derivation from the complete-row estimates, not quoted as an already
published ordinary-degree result. The cited source spaces, uniform
conditional operator hypotheses, and local marginal transport apply to
these high-ordinary-degree complete-row functions. The independent proof
reviewer remains responsible for the decomposition and quantitative PSD
deduction; this review certifies their source applicability and honest
statement scope.

The saved clause check uses the correct local semantic cases, including
outputs at block boundaries, and keeps arbitrary-sign multipliers inside
a genuine satisfying local law. It does not use the source's SA conversion
as an unproved SoS ideal simulation. Normalization and the support-domain
contract for all residual square and axiom terms are stated explicitly.

The resulting claim is bounded correctly: monomial size at least
`(8/7)^((2D-1)/2)` for q even>=1024, D=floor(q/(32 log_2 q)), N=8q+4,
m=q^2. Its scale is `exp(Omega(N/log N))`, not `exp(Omega(N))`. The
formula has polynomially many explicit variables and clauses; even
including variable-index encodings leaves polynomial input length, so
this bound is superpolynomial in that explicit input length. Coefficient
bit complexity and circuit-compressed certificate presentations are not
silently identified with the declared monomial-size measure.

This is a source-specific SoS size route using the published SA restriction
and an additionally proved square-positivity bridge. It does not claim the
restriction or positive-functional contradiction as newly invented, and
it does not contradict the separate, stronger-exponent PMRank theorem for
another encoding. Novelty remains unestablished. No arbitrary-SAT runtime,
all-proof-systems, circuit, or P-versus-NP consequence is supplied.

**GO for this exact source/model and complexity interpretation.** This is
an AI-agent audit with disclosed source corrections, not human peer review,
Lean verification, or independent certification of contributed mathematics.
