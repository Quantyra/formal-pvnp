# Simple-bamboo SoS size: independent mathematical proof review

2026-09-12; S3103 / E004 / S008; [integrity](../../INTEGRITY-CLAIMS.md).
Reviewer: `consequence_nonclaims`, serving here as the independent **proof**
lens, not the S3103 nonclaims lens.

**Final PASS for the actual analytic size theorem and its newly proved
row-space PSD bridge, after both template corrections.** I read the complete
argument and independently rechecked the corrected templates against the
rendered primary page, then reread the entire substitution, shrinkage and
axiom-annihilation sections of the final
[author file](2026-09-12-bamboo-size-mechanism.md), SHA256
`BD3DD17A493D9F1F481FBBD3946882F3AFC0904935CF07F5F4F8B80F6C318258`.
No remaining mathematical blocker, missing hypothesis or necessary repair
was found. The precise conclusion is explicit SoS certificate monomial size
at least `(8/7)^((2D-1)/2)`, for even q>=1024, N=8q+4, m=q^2,
A=I_m and D=floor(q/(32 log_2 q)).

## Independence, primary evidence and correction provenance

I supplied no construction or repair for this theorem, the row-space bridge
or the earlier PSD theorem. My prior role was nonclaims/publication review
and metadata integration for S3101/S3102; it is not reused as a proof verdict.
I independently checked the current argument against the actual source.

I read the cached primary text of Garlik--Gryaznov--Ren--Tzameret,
[ECCC TR26-133](https://eccc.weizmann.ac.il/report/2026/133/), including
Definition 4.3, Definitions 6.2--6.8 and Lemmas 6.7, 6.9--6.10, with the
Theorem 6.11 argument. I inspected the actual S3099 complete-row estimates
and local-complement argument and its fresh independent adversarial review,
as well as S3101's exact clause and certificate contract. The earlier PSD
source is pinned at `90868e5d032db6dba4cdf61d8a3fe07bfacdbfd7`; the prior
degree consequence is at `918e90fd9117b6689c068bac0148e8556149f454`.

The source/model reviewer found two template transcription errors. The author
corrected E's first row from `1 0 1 0 * * * *` to `1 0 0 1 * * * *`, and
D's first row from `1 1 0 0 * * * *` to `1 * 1 0 0 * * *`. The latter star
was misaligned in plain extracted text. My provisional PASS preceded the
second correction; I marked that verdict pending and independently inspected
all eight template rows in the rendered primary page 72 before reinstating
PASS on the final hash above. Both corrected matrices match that rendering.
The provisional E-only hash `05560D9E851983C962CA0E4044BEFC5ADCF67DA06C647016D508950BC46D1F7F`
is superseded and must not be represented as the final reviewed source.
These source corrections must be disclosed; the record must not state that
every reviewer supplied verification without correction. I supplied neither.

## The row-space lemma is actually proved

An ordinary root-degree bound alone cannot cover a surviving term with
arbitrarily many coordinates in one row. The manuscript expressly identifies
this gap and proves its required stronger lemma: R is nonnegative on p^2
when every monomial of Boolean-reduced p has at most B=2D typed rows.
There is no bound on p's total labels, ordinary degree or monomial count.

The S3099 input used is its complete-row maximal-correlation estimate through
(21), not merely its final ordinary-degree theorem. Those estimates concern
arbitrary centered L2 functions on the genuine source fibers, uniformly over
supported separators with total support at most 4D. The proof and the earlier
fresh audit retain full-rank exclusions, exact marginals, prefix evaluation
and prescribed outputs; no low-degree qualifier occurs in that operator
estimate. Thus it is applicable to the newly considered complete-row spaces.

For each monomial on A with |A|<=B, the finite-dimensional decomposition
through J_A and proper subsets exists; uniqueness is unnecessary. Combining
components with the same support produces one h_A in J_A. Each pair of
original monomials fits in a union of at most 2B=4D labels, where both local
identities hold almost surely by complete-row marginal consistency. Expanding
there and marginalizing each component pair proves the displayed equality
for R(p^2). It does not apply R to high-degree representatives outside its
row-domain, or require a globally satisfying assignment.

For incomparable supports their intersection is proper on both sides, so
the J components have conditional mean zero there. The imported uniform
correlation estimate and Cauchy--Schwarz give the claimed off-diagonal bound.
Properly nested supports pair to zero, including the constant case. Diagonal
pairings are the true local squared norms. Only the number of supports L,
not the dimensions of the local Hilbert spaces, enters diagonal dominance.
With B=2D the support count and epsilon are exactly the previously proved
ones: log_2 L<=1+6D log_2 q<=1+3q/16 and
L epsilon<=2^(-3q/16+6)<1/2. Consequently the new row-space PSD conclusion
follows for the declared entire range, with no new unproved analytic estimate.

## Source substitution and the residual family

N=8q+4 meets the source's N>=20 and 16|(N-4) assumptions because q is even.
m=q^2>N for q>=1024. The substitution preserves m and A and leaves residual
width q, exactly matching the PSD parameters m=q^2. The author correctly
does not start with m=N^2 or silently transfer an available bound at that
different residual parameter.

The corrected D/E templates, four endpoint assignments, block-offset map
and U prefix/complement cases agree with Definition 6.8. Each old variable
maps to a constant or a residual literal. Both boundary-prefix families
are retained and can drop a typed label, never add one. All variables at
positions 1,2,N-1,N, including their U prefixes and optional twins, map to
constants. This justifies discarding their factors when measuring interior
support; counting all original labels instead would not justify the same
survival estimate.

As an additional deterministic verification, I checked the displayed final
four-by-eight templates directly: each of their 16 columns has exactly one
zero, one one and two stars; each of the 16 D/E row pairs has odd star/star
count and even star/one and one/star counts. All checks pass. This finite
table check supplements the direct visual source comparison; it is neither
a parameter sweep nor a substitute for the general restriction proof.

For actual residual source assignments on the original clause's at most
two labels, the substituted old clause is satisfied. The author's semantic
check matches Lemma 6.10: initial gates are constant, internal block gates
are actual residual gates with parity offsets, block boundaries use the
previous output and next base, and the final gates use residual outputs.
Even q makes a constant-one block's total parity zero; the corrected
templates give odd star/star and even mixed star/one block counts. These
facts give the original prescribed output. All clause-falsification products
therefore vanish on the law. No erroneous real gate equation is substituted
for the Boolean parity relation.

This is a semantic local-satisfaction import from the source's case analysis.
It is not an assertion that the SA refutation conversion automatically
produces an equality-only SoS certificate. No such simulation is needed.

## Exact size accounting and probability

Definition 4.3 indeed charges
S=sum_i ||f_i|| ||g_i|| + sum_j ||h_j||, with the square roots explicitly
represented. It does not charge the number of expanded h_j^2 monomials.
Since every supplied axiom is nonzero, the number T of original monomial
occurrences across all multipliers and roots is at most S. This includes
the Boolean and optional twin-equation multipliers. Distinct occurrences
are counted separately, so no unnoticed sharing convention reduces T.

Source Lemma 6.9 applies to the interior subterm of each such monomial and
gives a^{r(t)}, a=sqrt(7/8), as a survival upper bound. Repeated powers do
not alter the constant-killing event or typed support. Optional twin factors
are source literals under the complementary substitution. Its proof kills
terms by zero constant factors; any additional Boolean-quotient vanishing
only helps. Thus no problematic increase in the failure probability arises
from passing to the real polynomial homomorphism or then the Boolean quotient.

If S<a^{-(B-1)}, a union bound over original g/h monomials with interior
support at least B-1 has total probability below one. Independence between
these many events is unnecessary. There is therefore a substitution killing
every such monomial. All remaining images have at most B-2 labels per
monomial after any complement expansion and Boolean reduction. They may have
arbitrarily many total labels across the polynomial; the proved row-space
lemma was designed to cover exactly that situation.

Affine expansion may increase monomial counts enormously, but it neither
adds row labels nor creates new events in this original-monomial union
bound. The proof does not assume a small restricted certificate. Squares
remain squares of the complete substituted roots by the homomorphism, so
there is no omitted square-expansion cost or loss of positivity. Arbitrary
coefficient magnitude and arbitrary finite root degree are permitted by
the theorem; compressed arithmetic-circuit presentations are not covered.

## Annihilation, nonvacuity and asymptotics

For one surviving multiplier image, its entire support is at most B-2,
even if its expanded polynomial has many terms. Adjoining the complete
substituted clause uses at most B rows. In that common law the clause is
zero pointwise. Consistency identifies the expanded/reduced product's R
value with its expectation there. Summing over original multiplier monomials
therefore annihilates the entire axiom product; cancellations are harmless.
Boolean and twin equations vanish directly in the quotient.

Each root has monomialwise support at most B-2 and hence satisfies the
new B-row PSD lemma. Its square has at most 2B-4<=q-2 labels per monomial;
clause products use at most B<=q-2. The whole reduced identity is in R's
domain. R(1)=1 then contradicts a sum of nonnegative square values equaling
-1. This excludes all S below the threshold and proves the stated weak
inequality S>=a^{-(B-1)} without a degree restriction on the certificate.

Nonvacuity holds for the original family itself: its Boolean clauses force
XY=I_m over F_2 whereas rank(XY)<=N<m. The real Boolean axioms eliminate
non-Boolean solutions. As q grows, D=Theta(q/log q) and N=8q+4, giving
the stated exp(Omega(N/log N)) bound. Since the explicit formula size is
polynomial in N, this is superpolynomial in that input length. The parameter
subsequence and certificate model remain explicit; no bound for the separate
product-z or perfect-matching encoding follows from this proof.

Final verdict: **PASS** for this exact corrected analytic theorem. This is
an AI-agent mathematical audit under the named source/analytic imports,
not Lean verification, human peer review, novelty certification, publication
approval, or a conclusion about arbitrary proof systems or P versus NP.
The source-model and independent nonclaims decisions remain separate.
No experiment, implementation, commit, push, release, publication, outreach
or paid computation was performed by this reviewer.
