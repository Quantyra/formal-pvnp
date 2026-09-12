# Dependent-column coupling: independent design and consistency checks

2026-09-12; S3112 / S008. Reviewer `output_fresh_proof`.
[Integrity boundary](../../INTEGRITY-CLAIMS.md).

**Result:** an explicit independent-row / uniformly conditioned
bilinear-form law is nonempty, but fails deletion consistency, detected
by a single observed form entry. A fixed coordinate-form comparison gives
a consistent narrower-leaf packing law. That comparison is not a new
full-width amplification result. The corrected actual author design
passes the bounded failure assessment recorded below.

The final [S3111 intake](2026-09-12-bamboo-amplification-intake.md) was read.
This task deliberately allows dependent parent columns; it does not
reintroduce the impossible full-rank parent-column closure from S3111.
This is analytic design/consistency assessment only, with no experiments,
implementation, publication, commit or push.

## One exact random-form candidate

Keep the original latent width N=8q+4 and m=q^2. A shared row context is
T subset [m], k=|T|<=N. It refers to k complete rows r_i of a matrix R;
it is not being identified with a single original typed X/Y label.
The local leaf constraints are

    r_i M_l r_j^T = (A_l)_(i,j),  i,j in T, l in {0,1},

where M_0,M_1 are arbitrary N-by-N matrices over F_2. They need not be
symmetric or invertible. No odd-row or all-ones-frame constraint is
silently imported into this new candidate.

Define the law exactly:

1. Sample the ordered rows (r_i:i in T) uniformly among linearly
   independent vectors of F_2^N.
2. Conditional on these rows, independently sample each M_l uniformly
   among solutions to R_T M_l R_T^T=A_l[T,T].
3. At T empty, sample M_0,M_1 independently and uniformly over all
   N-by-N matrices. All contexts expose the same form coordinates.

This is a candidate local law for a stratum of the original row-aligned
tree, not only an abstract polynomial equation: take parent Y's first
four N-column blocks to be [I_N,I_N,M_0^T,M_1^T]. Then
X_child0=X_child1=R, Y_childl=M_l R^T, and A_l=R M_l R^T.
The unused parent columns can be fixed to zero. Thus an entry of M_l
is an actual parent input bit. It can be observed before any R-row
label is selected. Prefixes are evaluated by the original Boolean gates.
This identifies why form-marginal consistency is a required interface,
not a demand about an irrelevant hidden variable.

### Nonemptiness and the tempting constant count

For every independent k-row frame R_T, the linear map

    M -> R_T M R_T^T

is onto the k-by-k matrices. Indeed, choose a right inverse B with
R_T B=I_k; then B A B^T maps to A. Its rank is k^2 and every fiber
has 2^(N^2-k^2) elements. Consequently the two-form law is nonempty
for arbitrary local targets, and its R_T marginal is exactly uniform.
The joint law is uniform on the admissible pairs of frames and forms.

That constant count is in the wrong direction to prove consistency
while retaining the forms. For fixed (M_0,M_1), let c_T(M_0,M_1) be
the number of independent frames satisfying both target matrices.
The marginal form probability is proportional to this c_T. It is not
uniform unless that frame count is constant over the form choices.

### A one-bit deletion countercheck

Let T={i}, and put a_l=(A_l)_(i,i). A singleton row r is uniform over
the 2^N-1 nonzero vectors. Given r, the condition on M_l is one nonzero
linear equation whose coefficient matrix is r^T r. For r=e_1, this
equation fixes (M_l)_(1,1)=a_l. For every other nonzero r, that form
entry remains a balanced bit: its coefficient functional is linearly
independent of the imposed functional. Therefore

    E_T[(M_l)_(1,1)]
      = 1/2 + (2a_l-1)/(2(2^N-1)).

At T empty its expectation is 1/2. Deleting the R row while keeping
just this one parent/form bit changes a moment of degree one.
The discrepancy is small but nonzero; exact source consistency cannot
ignore it. Conditioning the second form does not remove it, because
the forms are conditionally independent and every frame has the same
two-form fiber count.

This failure does not depend on an unusual nonsatisfiable local target.
For A_0=A_1=0 on every selected pair, one can compute for every k:

    E_T[(M_l)_(1,1)]
      = 1/2 - (2^k-1)/(2(2^N-1)).

To see this, W=span(R_T) is a uniform k-dimensional subspace. The
constraints set the bilinear form to zero on W times W. They force
M_11=0 precisely when e_1 belongs to W; otherwise M_11 is balanced.
The inclusion probability is (2^k-1)/(2^N-1). Thus the k=2 and k=1
marginals already differ. Resetting the empty-context form prior to
match one singleton does not fix higher-context deletion.

Equivalently, the all-zero form pair has probability
2^(-2(N^2-k^2)) in this all-zero-target law, another explicit indication
of the changing form marginal. No zero-probability conditioning issue
causes this example; every local joint law is nonempty.

**Disposition for this exact law: REJECT on deletion consistency.**
No PSD computation is necessary to expose its failure. Reweighting
forms or restricting them to another class would define a different
candidate and would need an actual common-marginal rule. This check is
not a theorem that every dependent-column or fixed-form law fails.

## Constructive comparison: fixed coordinate forms

There is an elementary valid comparison that must not be mislabeled as
full-width amplification. Choose an even w with 4w<=N. Split the latent
coordinates into four w-blocks and padding and set

    r_i = (x_i^0, y_i^0, x_i^1, y_i^1, 0).

Let M_0 have an identity block from the x^0 positions to the y^0
positions and zeros elsewhere. Define M_1 analogously on the x^1/y^1
blocks. These are fixed coordinate bilinear forms, so

    r_i M_l r_j^T = x_i^l dot y_j^l.

For each T with 2|T|<=w-2, independently sample each pair
(x_i^l,y_i^l:i in T) from the established width-w augmented source
law rho_(T,T)^(A_l), including its prescribed outputs and separate
augmented frame conditions. Concatenate the rows as above. This gives
nonempty laws and deletion consistency directly from the two source
families. The R rows are independent because even their x^0 components
are independent. The forms are deterministic, so observing them before
rows introduces no reweighting discrepancy.

In the tree this can be realized using fixed parent coefficient blocks
C_l,D_l that select the corresponding coordinates, with M_l=C_l D_l^T.
Child inputs occupy only w of their N coordinates and are zero-padded.
Parent columns are dependent coordinate vectors, as intended. Prefixes
and unused outputs can be evaluated deterministically from these rows.

For the current N=8q+4, choosing w=q is possible and matches the known
m=w^2 local laws. This is the direct product of two independent narrower
leaf sources placed in a coordinate basis. Its consistency is credited
to the source local-law theorem plus elementary product/coordinate
packing, not to a new full-width coupling mechanism. Each full shared
row packages four typed leaf labels; inherited positivity, if used, must
charge that support conversion explicitly. No new full-width PSD or
explicit SoS size-transfer theorem is asserted by this comparison.

In particular the ability to place narrower leaf laws in this stratum
does not establish that arbitrary full-width leaf sources glue, that a
useful random restriction selects this stratum with the necessary
original-monomial survival bound, or that the iterated certificate has
the required lower bound. Those are different obligations.

## Actual-file crosschallenge and final disposition

The random-form law, its nonemptiness proof and its one-bit and k-row
deletion counterchecks were sent to the root before reading the author's
saved design. The fixed-coordinate comparison was separately sent with
its narrower-leaf limitation. I then read the complete actual
[author design](2026-09-12-bamboo-dependent-coupling-design.md), snapshot
`CF164B8FA7EE35DB67C78D9A3921270B39C6B60CF07A9F57966A9E0661903BE1`.
It specifies the same random-form rule and a necessary bundled-context
test, not merely an unspecified gluing obligation.

The actual wiring, every matrix dimension, local base/prefix/wiring
satisfaction and affine-fiber count agree with the calculations above.
The first entry of parent Y column 2N+1 is exactly M_0(1,1). Thus the
observed-bit test lives in original tree variables. The author's bundle
contains root X_i, the two child X_i rows and the two child Y_i columns,
plus that parent Y column: six typed labels. At q=1024 the old numerical
B equals six, so this is not the previous N-column closure failure.
No inherited PSD is assumed merely from that numerical comparison.

The k-row all-zero-target formula and the tensor coefficient-space
justification are correct and attributed to the independent challenge.
They show why recalibrating only the empty-context prior to one singleton
does not repair this exact rule. Both targets can be zero and globally
satisfiable; nonrange hardness is not the source of this inconsistency.

The sampling-cost claims were checked. Building k^2 linear equations in
N^2 unknowns and elementary elimination cost O(k^4 N^2); a fully stored
kernel basis can cost O(N^4). These justify the author's loose polynomial
bound for one exact random sample. Child columns require O(N^2)
arithmetic operations and prefixes can then be accumulated in O(N).
These costs do not include context enumeration, PSD tests or certificate
compilation, which the author correctly keeps separate.

One endpoint correction was required: the final vector of a full
N-dimensional independent basis has rejection-sampling acceptance
probability exactly 1/2 and hence expected trial count exactly two.
The prior wording “fewer than two even at k=N” was incorrect. The author
changed it to “at most two,” with the strict and equality cases stated
and this correction disclosed. I checked the actual saved correction.
It changes no asymptotic bound or deletion conclusion.

Final author artifact: 12,039 bytes, SHA256
`642E8429C1057122D48E34BF44986DE450DC3D63E4AD7C7A39C53CEE667B92C3`.
Its coordinate-splitting comparison correctly discloses lower effective
leaf width and does not import a theorem at unapproved parameters.
The explicit w=q product local law in this independent record is a
constructive narrower-width comparison, not a repair of the dense
random-form law or a new full-width amplification mechanism.

**Final independent disposition: PASS for the corrected design assessment;
NONE for the specified dense random-form sampler.** It fails a demonstrated
necessary deletion identity before any PSD question. This rejects one
actual law, not all dependent-column designs or speculative PSD routes.
No replacement full-width operation is selected. Contributions include
independent derivation of the counterchecks, the explicit narrower product
comparison and the sampling-endpoint correction; this is a constructive
design challenge rather than verification-only provenance. Only this
independent private record was written. Frozen for integration.
