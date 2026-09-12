# Arbitrary-output bamboo: fresh adversarial mathematics review

2026-09-12; S3109 / S008. Independent fresh mathematical lens,
`output_fresh_proof`. [Integrity boundary](../../INTEGRITY-CLAIMS.md).

**PASS for the exact informal theorem and conditional generator implication
identified below.** No mathematical revision is required by this review.
This is an AI-agent analytic audit, not Lean verification, human peer review,
novelty certification, or a publication decision.

## Exact objects and review independence

The complete author file reviewed is
[arbitrary-output row-space positivity and size](2026-09-12-bamboo-output-uniformity.md),
SHA256 `CADA42936367F0F238BEE5EEEAB873BB9535EE463C1C8F5EA85D5A566170A7D9`.
I independently read its proof, the mathematical bodies of
[the size mechanism](2026-09-12-bamboo-size-mechanism.md) and
[the underlying conditional positivity proof](2026-09-12-shared-row-conditioning.md),
and the primary source's Definition 4.3 and Section 6, especially Definitions
6.1, 6.5--6.8 and Lemmas 6.7, 6.9--6.10. The primary source is
[Garlik--Gryaznov--Ren--Tzameret, ECCC TR26-133](https://eccc.weizmann.ac.il/report/2026/133/).
The local primary PDF text and the rendered printed page 72 were inspected;
the latter verifies all entries of the displayed D/E templates.

I also reviewed the mathematical conditional-generator section of the
[source review](2026-09-12-bamboo-output-source-review.md), SHA256
`F95B9530A6ADBC50430003E8331691BD302F9347A17F3A052152B19936CE60F2`.
Its verdict and the older verdict tables were not premises for this review.
I supplied no author construction or repair and changed no author file.

## Obligations checked directly

| Obligation | Finding |
|---|---|
| Arbitrary-A nonempty, consistent augmented local fibers | PASS; extension counts retain the actual augmented pairing matrix and its rank |
| Affine right-hand sides, Fourier norm and probability normalization | PASS; affine shifts are separate sign multipliers, with rank exclusions and normalization charged |
| Same-side dependence and mixed grouping | PASS; uniform marginals justify the Schur bound; conditional covariance uses supported source fibers |
| Complete-row assembly across arbitrary label sums | PASS; local identities lift to pair unions, with explicit all-context diagonal dominance |
| A-preserving restriction, clauses and unrestricted certificate size | PASS; every clause vanishes locally and original root/multiplier occurrences control the union bound |
| Satisfiable-output vacuity and nonrange classification | PASS; unrestricted satisfiability is exactly binary rank at most N |
| Conditional generator arithmetic and encoding | PASS; indexed polynomial stretch and explicit SoS hardness apply to the stated prefix encoding only |

### Local laws: arbitrary output does not create an extension obstruction

For a supported separator, write u=r+1, v=s+1 and let C be the dot-pairing
matrix of the independent augmented frames. Its entries, including the
zero e-dot-e entry, boundary ones, and selected A entries, are prescribed.
Consequently its rank t and the image of the map from span(e,X) to the
coordinates of dot products with (e,Y) are determined by that data.

An additional X row has 2^(q-v) affine solutions. The inadmissible solutions
inside span(e,X) number either zero or 2^(u-t); the nonempty case is exactly
membership of its prescribed right-hand side in the image of C (with the
appropriate orientation). This membership and count are independent of
the concrete frame coordinates. Since r+s<=q-3 before the last addition,
q-v>u, even subtracting all 2^u span points leaves a positive number.
The symmetric argument adjoins Y rows. Starting from the single nonzero
vector e on each side constructs every context through q-2 labels.

Equal extension counts prove uniform deletion marginals, not merely equal
moments of a few low-degree observables. Conditioning on a supported fixed
separator preserves these identities. Complete row-atom indicators are
available, and prefix bits are deterministic row functions. Thus the
conditional marginals used later really are the specified uniform fibers.
No global realization of A or special identity-matrix rank is needed.

### Norm estimates: no missing output probability or affine factor

The direction spaces are V-perp and U-perp. The left radical is
U intersect V-perp, of dimension u-t, so their pairing rank is
h=q-u-v+t. The probability-normalized character operator has norm
2^(-h/2): its squared operator has signed rank-one blocks on radical
cosets, with nonzero eigenvalue 2^(-h). Translating either affine fiber
adds separate linear characters on the two sides and a constant sign.
These are isometries and preserve the norm even when the right-hand sides
change with A.

The deleted singleton proportions are zero or 2^(-h). Compressing to
retained sets and renormalizing their probability measures costs at most
1/(1-2^(-h)). The prescribed output changes the sign of the character.
The density normalizer Z obeys |Z-1|<=alpha; it is not silently set to one.
Centering uses the actual retained source marginals, so its constant
density term vanishes and alpha/(1-alpha) is valid.

For pure blocks, sequential span counting remains valid for different
row-specific affine cosets: the preceding span has dimension at most
u+i and pairing rank at least t. This gives the displayed geometric
deletion bounds, including empty affine intersections. A rank-k Fourier
channel has direction-space rank kh by the tensor-product matrix rank
identity. Its affine terms are again separate signs. Counting channels
by factorizations yields at most 2^(k(a_X+b_Y)) per rank shell and the
geometric bound tau/(1-tau). The retained tuple normalization and the
final output normalizer are both charged in gamma/(1-gamma).
In particular the potentially tiny raw probability of a complete output
matrix is handled by the scaled Fourier expansion, not omitted.

For same-side blocks the product law is conditioned on combined rank.
Its admissible marginals are uniform by the already established extension
counts. The failure indicator therefore has constant row and column means
e. The probability-weighted Schur bound is ||F||<=e, and the centered
conditional density gives e/(1-e). The proposed e_ab bounds that e after
charging the second block's individual rank conditioning.

For completeness, the mixed-block inequality follows by decomposing
Cov(f(P),g(Q,R)) into covariance of conditional means given Q and expected
conditional covariance. The first term is bounded using rho(P;Q) and
the contraction of conditional expectation. The second is bounded by
the supremum conditional correlation and Cauchy--Schwarz on conditional
variances. Applying this on both sides gives the four stated pure terms.
The added conditioning only enlarges a supported separator, and deleting
unused blocks invokes genuine conditional marginal consistency. It does
not condition an independent comparison law on all mixed internal outputs.

The total-support bounds imply the stated t0,d0 estimates, including the
same-side numerator bound by d0. The generous constants 4t0, 4d0 and
epsilon=16t0 are valid throughout q even>=1024 with the stated D.

### Positivity assembly and restriction transfer

The orthogonal complement J_T removes the span of all proper-subset
spaces. Finite-dimensional projection followed by induction yields the
claimed local decomposition; uniqueness is unnecessary. Each local
almost-sure identity lifts to every pair union by consistency. This proves
the expansion of R_A(p^2) even when the polynomial as a whole involves
far more than q labels and its components have high ordinary degree.

Distinct nested supports pair to zero. For incomparable supports both
components have conditional mean zero on their intersection. Conditional
mixing and Cauchy--Schwarz bound the pairing by epsilon times their norms.
The number of possible supports is at most 2(2q^2)^(2D), whose logarithm
is at most 1+3q/16. Together with 4D<=q/8 this yields
L_ctx epsilon<=2^(-3q/16+6)<1/2. Thus positivity is proved on the required
bounded-row monomials with unrestricted sums, rather than on a single
context alone. The degree-D consequence follows from two labels per
actual variable, including U.

The source substitution hypotheses hold: m=q^2>N=8q+4>=20 and
16 divides N-4 because q is even. The source quantifies over every A.
The templates match printed page 72. Their parity conditions and even
q give total interior output A_ij. The displayed offsets and endpoint
prefixes then agree for both output bits. Neither offsets nor boundary
prefixes add labels. The semantic clause check is legitimate in each
at-most-two-label residual law, including transitions across block
boundaries and final endpoints. The six displayed falsification
polynomials encode XOR-of-AND exactly; they are not real arithmetic
summation equations.

Lemma 6.9 applies to the interior subterm of each original monomial,
including repeated powers or optional twin literals after interpreting
their Boolean support. Endpoint factors become constants. Since every
nonzero axiom has at least one monomial, the number T of root/multiplier
occurrences is at most S. For S<a^(-(B-1)), the union bound is strictly
less than one. A good substitution leaves at most B-2 labels per surviving
root/multiplier monomial. Complement expansion can be large but adds no
labels and is not charged again. Counting roots before squaring is crucial
and is done correctly.

A multiplier monomial together with its clause uses at most B labels;
the product vanishes in that actual local law. Boolean and twin equations
vanish in the quotient. Square monomials use at most 2B-4 labels and
the row-space PSD theorem applies to every whole root image. Applying the
normalized functional to the substituted identity therefore contradicts
-1. This is a direct real polynomial homomorphism argument; no unproved
SA-to-SoS or arbitrary-sign ideal simulation is used.

### Conditional generator derivation

For G_q(X,Y)=XY, the seed count is 2mN=16q^3+8q^2 and output count
is m^2=q^4. Their ratio q^2/(16q+8) exceeds one for the displayed q.
Consequently t_q=Theta(s_q^(4/3)). The explicit O(q^5) gate computation
and indexed construction are polynomial in seed length; binary indexing
adds only logarithmic overhead. Prefix witnesses are uniquely determined
by the seed and do not change seed length.

The exact inversion CNF has 2mN+m^2N variables and (6N-2)m^2 clauses:
one output, three base and six per subsequent prefix step for each entry.
Its width is at most four and description length O(q^5 log q).
Binary rank factorization proves range(G_q)={A:rank(A)<=N} in both
directions, with zero padding for smaller ranks. Evaluation at a
satisfying Boolean assignment makes a real SoS refutation impossible,
so hardness on these outputs is correctly vacuous. Every nonrange output
has the claimed certificate lower bound under the all-A theorem.

The exponent q/log q translates to s_q^(1/3)/log s_q and
t_q^(1/4)/log t_q up to constants. Hence the bound is superpolynomial
also in the explicit CNF bit length. This yields the claimed indexed,
encoding-specific proof-complexity generator implication. It supplies no
hardness for a different circuit encoding or compressed root representation.
Polynomial-time rank testing and factorization remain available, and
there is no computational pseudorandomness, SAT-algorithm, iteration,
all-length padding, or P-versus-NP conclusion.

## Final disposition

The exact frozen author theorem and the identified conditional generator
derivation pass this fresh mathematical lens. There are no outstanding
mathematical repair obligations from this audit. The source restriction
and consistency remain credited imports. No Lean build was applicable to
this prose-only review. Only this review record was written; no author or
public artifact was edited, and no commit, push, release, outreach, or
paid computation was performed. Frozen for integration.
