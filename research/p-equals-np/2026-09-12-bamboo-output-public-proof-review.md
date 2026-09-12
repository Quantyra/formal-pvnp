# Version 4 arbitrary-output public extraction: mathematical review

2026-09-12; S3110 / S008. Reviewer `output_fresh_proof`.
[Integrity boundary](../../INTEGRITY-CLAIMS.md).

**PASS for the actual frozen OUTPUT-NOTE.md and its stated indexed
generator corollary.** No mathematical repair or theorem-scope correction
is required. This is an informal AI-agent mathematical review, distinct
from the earlier private-source review. It is not human peer review,
Lean verification, novelty certification, or a publication decision.

## Exact artifact and files read

Public destination: Quantyra/weak-rank-positivity-window, candidate branch
`candidate/v4-output-uniformity`, based on v3.0.0 commit
`613ceb80a6211097cd8e353c47ad79ba3069ecb5`. The frozen actual mathematical
artifact is OUTPUT-NOTE.md, 22,963 bytes, SHA256
`8B37A7B333BCF2BD0CD4552364486DC3B5FA3E930601FB8168A890C19DB28BE2`,
Git blob `069565e25d8d991476f80bdfb6385972a62571d4`.

I read the entire OUTPUT-NOTE.md, including its separate corollary and
proof; the complete linked FULL-NOTE.md and SIZE-NOTE.md; and README.md,
SOURCES.md, REVIEW.md and CITATION.cff. I checked the new metadata's
mathematical claims, exact encoding, source interfaces and limitations.
Historical review verdicts were not used as mathematical premises.

The accompanying working-file SHA256 pins, all independently checked
against the curator's frozen manifest, are:

| File | SHA256 |
|---|---|
| README.md | `9693B6C1C7575D25D5DAA219B5AD82F0B0E6F4FADED84D29C9CF6253588D0BBA` |
| SOURCES.md | `EAC0FCBDB859A83FB24A514E095D153A040BE1B44B7424F4307048124A1CC148` |
| REVIEW.md | `B7C4FBE244B8AD9124D6DC5756032787C45621B238D596FBA1988FC3C4ED33C0` |
| CITATION.cff | `079ED1192CB2D89AD0B047175C056E60AE86AEE284A56B6554C9326FA85058CC` |

At this snapshot REVIEW.md correctly marks actual extraction reviews as
pending. Integrating the completed review status requires a subsequent
metadata check; this verdict does not preapprove arbitrary later edits.

The private derivation pin is formal-pvnp commit
`4b748b22aa87587f761ddd2d99f342f427a9b0c9`. The theorem's mathematical body
from its exact-conventions section through the size-transfer section is
identical to the frozen private source after line-ending normalization.
That comparison supplements, and does not replace, the actual whole-file
reading and checks below. The public corollary was read as a proof in its
own right, not inferred from the private source's PASS.

## Actual extraction obligations

The public theorem preserves q even>=1024, m=q^2, N=8q+4,
D=floor(q/(32 log_2 q)), B=2D and a=sqrt(7/8). Arbitrary A is fixed
throughout each local law and certificate. There is no averaging over
outputs. The restricted residual positivity law and the unrestricted
original certificate encoding remain distinct.

The augmented local laws state the boundary vectors, oddness, separate
frame independence and every prescribed A entry. Their pairing matrix
retains its actual rank t. The affine extension count is either the
full fiber count or that count minus 2^(r+1-t), according to right-hand-side
membership. Its positivity and realization-independent value establish
nonempty uniform deletion marginals through q-2 labels. This supplies the
complete-row conditional laws used by the proof without a global law.

For arbitrary supported separators the direction-space pairing rank is
h=q-r-s-2+t. The character norm 2^(-h/2) is probability-normalized;
affine translations contribute only separate signs. The singleton and
block rank deletions, rank-k Fourier channels of rank kh, channel counting,
and both retained-measure and output-density normalizers are retained.
In particular gamma/(1-gamma) does not discard the probability of a
prescribed output matrix. Uniform source marginals justify the same-side
failure indicator's constant means and Schur estimate. The covariance
reduction conditions only on supported source data and preserves the
total-support budget. The linked FULL-NOTE states the operator/maximal
correlation convention explicitly and proves the same reduction.

The resulting epsilon=2^(-q/2+4D+5) applies to arbitrary complete-row
functions. The J_T decomposition is local and finite-dimensional;
consistency lifts its identities to each pair union. Nested supports pair
to zero and incomparable supports are controlled after conditioning on
their intersection. The context count and parameter inequalities give
L_ctx epsilon<1/2. Thus the conclusion covers unrestricted sums of
bounded-row monomials, including high ordinary degree. No fixed-context
positivity or merely degree-bounded result is substituted for this claim.

The public clause list specifies both output literals, all base clauses
and all six XOR-of-AND falsification equations. Boolean and optional twin
equations are present. The D/E templates match the primary source page 72
examined in the source audit, and match the complete public SIZE-NOTE.
The source substitution hypotheses hold because q is even and m>N.
Offsets retain A_ij, the template parity gives the same total output,
and the endpoint prefixes cancel the two random parity bits correctly.
Original clauses vanish on their at-most-two-label residual laws,
including transitions across blocks. This uses the source's semantic
check, not an unproved arbitrary-sign ideal simulation.

The public size proof retains the exact measure
S=sum_i ||f_i||||g_i||+sum_j ||h_j|| on ordinary explicit monomials.
Since all axioms are nonzero, the number of root/multiplier monomial
occurrences is at most S. The strict union bound with threshold B-1
produces a restriction with at most B-2 residual labels per surviving
monomial. Complement expansion adds no labels. Roots are counted before
squaring, and the proof applies row-space positivity to each complete
root image. Clause products use at most B labels and square monomials
at most 2B-4, so the final application of R_A is within its domain.
The result remains exp(Omega(N/log N)), with no degree or coefficient-bit
restriction and no circuit-compressed representation claim.

## Independent check of the public corollary

The public map is explicitly G_q(X,Y)=XY over F_2, with row-major seed
ordering and output ordering. Its seed count 2mN=16q^3+8q^2 and output
count m^2=q^4 are correct. Thus output length is Theta(s_q^(4/3)), while
the expansion ratio is q^2/(16q+8)=Theta(s_q^(1/3)). The public proof
distinguishes those two quantities and verifies that the ratio exceeds
one in the stated range.

Computing all dot products costs O(q^5) Boolean operations. Indexed loops
construct the map and its exact inversion CNF in polynomial time, with
O(log q)-bit indices. The CNF counts are 2mN+m^2N variables and
(6N-2)m^2 clauses, with width at most four and O(q^5 log q) binary
description length. Prefix U variables are uniquely determined witnesses,
not seed bits, and neither augmented boundaries nor oddness are imposed
on the original map. No extra product-variable gate encoding is inserted.

Rank submultiplicativity and padded rank factorization prove that the
range is precisely rank(A)<=N. In-range instances are satisfiable, so
evaluation at a satisfying Boolean assignment forbids a real SoS
refutation and makes the lower-bound statement vacuous. Nonrange
instances are contradictory and inherit the proved all-output bound.
I_m is nonrange because m>N, and the elementary cardinality bound also
proves non-surjectivity.

The exponent q/log q translates correctly to
s_q^(1/3)/log s_q and t_q^(1/4)/log t_q up to constants. It is
superpolynomial in output length and the displayed CNF bit length.
The corollary is therefore valid as its explicitly defined indexed,
encoding-specific proof-complexity generator statement. Polynomial-time
rank testing and rank-factorization inversion remain compatible with it.
No iteration, all-length padding, other encoding, computational
pseudorandomness, general circuit-certificate lower bound or
P-versus-NP conclusion is supplied or implied by this derivation.

## Linked history and metadata

The linked FULL-NOTE proves its narrower identity-output, ordinary-degree
statement and supplies the complete-row estimates used by SIZE-NOTE.
SIZE-NOTE independently spells out the identity-output row-space bridge
and size mechanism. OUTPUT-NOTE does not silently reinterpret their
historical theorem quantifiers as arbitrary A; it writes the arbitrary-A
proof explicitly.

I independently verified preservation of the following Git blobs from
v3.0.0, rather than relying on working-file line endings:

| Preserved file | Git blob |
|---|---|
| NOTE.md | `d66725171fe42f78541382d7b31902230e90a9bf` |
| FULL-NOTE.md | `6a5f09aadfd0732a6a7824b22e1aec3c350bdc45` |
| COROLLARY.md | `5a515f8a0301bc6de46edd72438c37e03a1084dc` |
| SIZE-NOTE.md | `4f7f0750b2e805d65a1789ec3cc4fc43af6f521c` |
| LICENSE | `f5e23913507cd1b6fd26f7cf8a6487b37484d8f6` |

README, source attribution, review disclosure and citation abstract retain
the fixed parameters, exact measure, output-length relation, encoding
boundary and satisfiable-case vacuity. Earlier no-size or identity-only
statements are identified as historical. The new metadata attributes the
restriction and consistency to the primary source and separates the
generator derivation from independent verification. None of its current
mathematical summaries widens the theorem proved in OUTPUT-NOTE.
This mathematical review does not certify an exhaustive literature or
priority search, or replace the separate source/nonclaims lens.

Only this private review record was written. No public or author proof
was edited, and no commit, push, release, outreach, paid computation,
experiment or Lean implementation was performed. The exact frozen public
mathematics passes without repair. Frozen for integration.
