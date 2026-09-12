# Arbitrary-output bamboo: independent mathematical review

2026-09-12; S3109 / S008. Reviewer: `bamboo_size_nonclaims`, serving here
as the independent mathematical proof lens, not the author or nonclaims lens.

**Main theorem PASS** for the complete actual
[author file](2026-09-12-bamboo-output-uniformity.md), SHA256
`CADA42936367F0F238BEE5EEEAB873BB9535EE463C1C8F5EA85D5A566170A7D9`.
No blocking mathematical defect, missing hypothesis or required proof repair
was found. **Separate generator-implication PASS**, under this theorem, for
the exact indexed map and encoding examined below. This is not a publication
decision, novelty certification, Lean verification or human peer review.

## Independence and evidence

My previous roles in this sequence were nonclaims/selection review and
metadata integration. I supplied no construction, analytic estimate,
extension count or repair for the present arbitrary-output theorem or its
underlying positivity theorem. This proof verdict is based on the actual
mathematics, not those earlier roles or the source review's GO label.

I read the whole saved author proof and independently checked its argument
against the actual S3099 equations (7)--(30), the S3103 row-space/size
argument, and the cached primary ECCC TR26-133 text at Definition 4.3,
Definition 6.1 and (35), Definitions 6.5--6.8 and Lemmas 6.7, 6.9--6.10.
These primary passages explicitly quantify over arbitrary Boolean outputs.
I inspected the source's extension-count proof and semantic substitution
cases directly. No prior source/proof verdict was used as a substitute.

After completing the main argument check, the root additionally assigned
the [source report's generator implication](2026-09-12-bamboo-output-source-review.md).
I read its whole written derivation at SHA256
`F95B9530A6ADBC50430003E8331691BD302F9347A17F3A052152B19936CE60F2`
and independently checked the source's definition of encoding-sensitive
proof-complexity generators. That corollary is assessed separately below.

## Nonempty, consistent arbitrary-output laws

For independent augmented separator bases of U and V, their pairing matrix
is exactly the displayed C with boundary entries 0 and 1 and interior
A_(I,J). Its rank t is determined by the prescribed matrix, not the frame
coordinates. A new X row solves s+1 independent equations and hence has
2^(q-s-1) affine candidates. The restriction of the pairing to U has rank t,
so its forbidden intersection has either zero or 2^(r+1-t) points. Whether
the prescribed vector lies in the image is likewise determined by C and
the new output row. The admissible extension count is therefore constant
across supported realizations. For r+s<=q-3 it is positive even after
subtracting the crude upper bound 2^(r+1).

The symmetric Y step and the even-q base (e,e) give nonemptiness through
support q-2. Constant extension counts give uniform marginal consistency
for deletion, including complete-row atom probabilities and deterministic
prefix evaluations. Conditioning on a supported separator gives exactly
the uniform retained affine/frame fibers used later. No rank condition on
the full output A or global satisfying assignment is needed. This matches,
and explicitly checks, the primary source's general-A consistency argument.

## Conditional estimates retain all output dependence

The direction-space pairing has rank
`h=q-(r+1)-(s+1)+t`: its left radical is U intersect V-perp of dimension
r+1-t. Probability normalization therefore gives character-operator norm
2^(-h/2). Affine shifts add separate row/column signs and a global sign,
so the norm is unchanged. The deleted affine-span fractions are zero or
2^(-h), yielding the claimed normalization factor. The prescribed new
dot value changes the Fourier sign; the normalizer is bounded through its
absolute deviation, not an assumed identity-output value.

For multiple pure rows, the sequential forbidden-span intersection is at
most 2^(dim U+i-t), independently of its right-hand side. The union bound
therefore gives the displayed delta_X and delta_Y. A rank-k output-channel
matrix has tensor-product direction rank kh and norm 2^(-kh/2), even for
different affine cosets per row. Counting rank-k matrices by factorizations
gives at most 2^(k(a_X+b_Y)) channels. The geometric bound, separate rank
restriction and normalizer control establish gamma/(1-gamma) with no use
of a special pattern in A. Uniform source marginals are the retained tuple
laws by the already-checked consistency; they are not freely chosen
comparison marginals.

For same-side blocks, the combined law is the independent admissible-block
product conditioned on combined rank. Consistency makes the failure
indicator's row and column means constant. Thus its weighted Schur norm
is bounded by that mean, justifying e/(1-e); a small average alone would
not suffice. No missing same-side output equations arise: all such
prescriptions concern separator vectors of the opposite type.

The total-covariance inequality follows by bounding covariance of the
conditional means and the expected conditional covariance, each with the
appropriate L2 variance bound. Splitting both mixed blocks gives exactly
the four terms displayed in (5). All conditioning events are supported
source events; their enlarged separators retain the same total support.
Thus neither internal output conditioning nor a hidden quadratic channel
count adds an uncharged loss.

The numeric estimates are sufficient uniformly in A. With total support
at most 4D, tau<=t0, both deletions<=d0, and the same-side numerator<=d0.
The displayed t0,d0<=1/16 give opposite correlation<=4t0 and same-side
correlation<=4d0. The four-term reduction is consequently bounded by
16t0=2^(-q/2+4D+5). All these are complete-row L2 estimates; no ordinary-
degree hypothesis has been silently inserted.

## Row-space PSD and all-context budget

The finite-dimensional J_T decomposition exists by projection and induction
over proper supports; uniqueness or efficient computation is unnecessary.
For each monomial pair, its union has at most 2B=4D labels, where both
local almost-sure decompositions lift by consistency. Expanding there and
combining equal-support components preserves exactly R_A(p^2), even when
p has many labels across its sum and components have high ordinary degree.

Nested distinct supports pair to zero. Incomparable components have zero
conditional means on their intersection, so the uniform mixed estimate
and Cauchy--Schwarz bound their pairing by epsilon times their norms.
There are at most L_ctx supports, not one factor per local Hilbert-space
dimension. The diagonal-domination inequality therefore applies to the
whole sum, with arbitrary real coefficients and cancellations.

At m=q^2, the stated log-count bound and 4D<=q/8 imply
`L_ctx epsilon <= 2^(-3q/16+6)<1/2`. Every relevant union also lies in
the source domain q-2. This proves the declared arbitrary-A B-row PSD
statement. Degree-D actual X/Y/U monomials have at most 2D typed labels,
which gives the ordinary-degree consequence without changing U to an
uncharged parity polynomial. Nothing here proves an unrestricted-m window.

## Exact size transfer

The full clause table matches Definition 6.1, including both output bits
and all six Boolean XOR-of-AND falsifiers. The source substitution already
allows arbitrary A. The saved D/E entries match the corrected S3103
templates; the extension changes neither them nor the distribution.
Their star/star parity and even boundary counts give A_ij in either case,
with the prescribed endpoint cancellations and prefix offsets. The same
m and A survive at residual width q. Even q gives the source congruence
condition, and m=q^2>N for the entire stated range.

The source survival lemma concerns the interior subterm. Endpoint factors
become constants, so stripping them does not omit residual labels. Powers
and optional twins do not invalidate its constant-killing estimate; extra
Boolean-quotient vanishing only helps. The original multiplier/root
occurrence count T is at most the stated S since nonzero axioms each
have at least one monomial. Root squares are not expanded for that count.
The union bound under S<a^(-(B-1)) yields a restriction killing every
occurrence with at least B-1 interior labels.

Surviving literal-product images have at most B-2 labels; complement
expansion may be huge but adds none. The ring homomorphism preserves each
whole root square. A full clause image has at most two original labels
and vanishes pointwise on their residual law, including at block boundaries
where output and base constraints are both needed. This is the primary
source's semantic check, not an unproved SA-to-ideal simulation. Its product
with each surviving multiplier fits a common law on at most B labels and
has zero expectation. Boolean and twin images vanish in the quotient.

Every square term lies in R_A's domain and is nonnegative by row-space
PSD; every axiom term is annihilated. Normalization then contradicts -1.
The strict small-size assumption proves the stated weak lower bound for
every A, with no certificate-degree or coefficient-size hypothesis.

## Satisfiability and nonvacuity

The original unaugmented CNF is satisfiable iff rank_F2(A)<=N. A rank-r
factorization with r<=N pads to the required X,Y dimensions and determines
all prefixes; conversely its Boolean clauses enforce that product.
In-range outputs therefore have no real SoS refutation by evaluation at
a satisfying Boolean point, so the refutation-size statement is correctly
vacuous there. For rank(A)>N it is a nonrange contradiction and the bound
applies to every refutation. I_m is a concrete nonrange example since m>N.
The local functional theorem itself is valid in both cases. The text does
not falsely assert that every output is contradictory.

## Separate generator implication: PASS under the theorem

The source report proposes G_q(X,Y)=XY over F_2, indexed by even q>=1024,
with m=q^2, N=8q+4 and fixed row-major bit encodings. The seed contains
exactly 2mN=16q^3+8q^2 bits and the output m^2=q^4 bits. Hence output
length exceeds seed length throughout this range and is Theta(seed^(4/3)).
This is a polynomial-stretch indexed family, not an all-length convention
or an iterated near-quadratic construction.

The map has m^2 dot products of N bits and therefore O(m^2 N)=O(q^5)
Boolean operation cost, with an explicit polynomial-time circuit generator.
Its inversion CNF uses exactly the adopted prefix-gate encoding: 2mN+m^2N
variables, (6N-2)m^2 clauses of width at most four, and O(q^5 log q)
standard indexed description length. The count follows from one output,
three base and 6(N-1) transition clauses per entry. Prefix bits are uniquely
determined extension witnesses, not seed bits. The restricted proof's
oddness/all-ones boundary is not imposed on this original generator.
Adding product variables would change the audited encoding.

Range equivalence is precisely rank(A)<=N as checked above. For every
nonrange output, the main theorem forbids refutations smaller than K_q;
for range outputs soundness forbids any refutation. Thus the source's
every-output encoding-sensitive hardness condition is met by the proven
all-A theorem at these parameters. K_q is
`exp(Omega(q/log q))=exp(Omega(seed^(1/3)/log seed))`
and `exp(Omega(output^(1/4)/log output))`, superpolynomial in output and
explicit CNF bit length. Non-surjectivity follows from the length count
and is witnessed independently by I_m.

This is a valid explicit corollary of the checked theorem and the source
definition, not extra spectral mathematics or automatic credit to a review
label. The map, fixed original encoding, every-output quantifier and size
measure must accompany any later claim packet. The current author's main
file withholds a generator claim; this separately requested implication
review does not itself amend that file or approve public release.

The generator is not computationally pseudorandom or hard to invert on
its range: finite-field rank testing and factorization are polynomial.
No general SAT runtime lower bound, circuit-SoS hardness, other-encoding
hardness, iteration/amplification, unrestricted-m theorem, function-generator
consequence or P-versus-NP conclusion follows from this corollary.

Final verdicts: **PASS main actual theorem; PASS exact generator implication
under that theorem.** These are informal AI-agent analytic reviews. No
author revision was required or supplied. Lean/build/axiom-profile checks
are inapplicable because no formal implementation was produced. Only this
review record was written; no author/public edits, experiment, commit, push,
publication, outreach or paid computation was performed by this reviewer.
