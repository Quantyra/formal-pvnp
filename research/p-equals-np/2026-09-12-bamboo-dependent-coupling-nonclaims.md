# Dependent bilinear coupling: claims and selection review

2026-09-12; S3112 / S008. Independent AI nonclaims lens,
output_scope_review. Informal design/applicability review, not human peer
review, Lean verification, a new PSD theorem or publication certification.

## Actual design and scope

Read INTEGRITY-CLAIMS.md, planning's S3112 story, the complete saved
[dependent-coupling design](2026-09-12-bamboo-dependent-coupling-design.md)
and [independent design/checks](2026-09-12-bamboo-dependent-coupling-independent.md).
The final author design is 12039 bytes, SHA256
`642e8429c1057122d48e34bf44986de450dc3d63e4ad7c7a39c53cee667b92c3`.
Final actual independent crosschallenge is pinned below. This is a claims
review of these derivations, not another exhaustive literature audit.

The actual depth-one wiring uses root X=R and root
Y=[I_N,I_N,M_0^T,M_1^T,0], at q even>=1024, m=q^2, N=8q+4.
It gives child X^0=X^1=R and Y^l=M_l R^T, with output R M_l R^T.
M_l need not be symmetric, and the repeated/dependent parent columns are
permitted. Unused root columns fixed to zero specify a supported subclass;
this is not a redefinition of the full generator range. Original prefixes
are evaluated on assignments, not substituted as uncharged parity circuits
inside an explicit-monomial certificate.

For row-index context S of size k<=N, the proposed rule first samples
uniform ordered independent r rows, then independently samples each form
uniformly conditional on R_S M_l R_S^T=A_l[S,S]. Parent-column observations
may remain even when S is empty. At that empty context forms are uniform.
The rule is explicit, including the ordering, conditional fibers and
observable variables; it is not a named generic gluing requirement.

The map on forms is surjective of rank k^2, so each fiber has exactly
2^(N^2-k^2) elements for every prescribed local target. This proves
nonemptiness and the desired row marginal. It does not prove that the
observable form marginal remains unchanged after a row is added. The
reports correctly identify that direction-of-conditioning distinction.

## The actual failure is exact consistency of this rule

The first entry of root Y column 2N+1 is M_0(1,1), an original variable.
For one constrained row with diagonal target a, its expectation is

    1/2 + (2a-1)/(2(2^N-1)),

whereas the empty-row context gives 1/2. The exceptional nonzero row e_1
has probability 1/(2^N-1) and fixes this bit; all other rows leave it fair.
The second form does not reweight the row because its conditional fiber
count is constant. Deleting the row while keeping this parent column
therefore changes an observable degree-one moment.

The author's stated one-index bundle contains five row/column labels plus
one parent-column label. Its six-label count fits the previous numerical
B=2D scale even at q=1024, but this observation does not import the previous
source PSD into the new law. The discrepancy is exponentially small and
nonzero. Exact common moments cannot disregard it; no approximate-consistency
transfer has been supplied or claimed.

The independent reviewer also supplied the stronger all-zero-target formula

    E_k[M_0(1,1)] = 1/2-(2^k-1)/(2(2^N-1)).

It witnesses k=2 to k=1 drift in the same rule, so changing only its empty
prior to match one singleton does not repair higher-context deletion.
These zero targets are satisfiable. Nonempty local fibers and even globally
satisfiable target data do not prevent the observed marginal mismatch.
The all-zero extension is credited to that reviewer; this is not presented
as verification-only provenance for the entire S3112 assessment.

The justified conclusion is rejection of this uniform-row/conditionally-
uniform-form sampler as a projectively consistent family. There is no
well-defined common moment functional from this family on which to test
cross-node PSD. This is not a proof of negative square expectation, a
SoS lower bound, a general impossibility theorem for dependent columns,
or a claim that all reweighting/fixed-form/different-order rules fail.
Keeping M hidden cannot repair this exact original-variable interface.
A different rule must be specified and tested in its own right.

## Cost, coordinate packing and remaining boundary

One-sample affine-linear-algebra work and expected rejection sampling cost
are correctly distinguished from deterministic random-tape bounds,
enumeration of exponentially many fibers, all-context PSD verification,
and certificate transformations. The root seed remains 2mN, the depth-one
output is 2m^2, and intermediate seeds/prefixes remain witnesses. Sampling
one finite context in polynomial work supplies neither amplified hardness
nor an uncharged explicit-output construction.

The fixed-coordinate comparison packs two narrower matrix products into
four disjoint latent blocks. The author and independent report identify
this as elementary direct-product/coordinate geometry. The independent
report's w=q choice permits established width-w source local laws at
m=w^2 and gives consistency by products and deterministic evaluation,
with its stated 2|S|<=w-2 window. This provides a concrete narrower
comparison, not a new full-width coupling theorem.

Each shared row bundles multiple typed source labels, so any inherited
positivity must charge that conversion. Other widths or parameter pairs
are not automatically covered by public v4. Neither packing nor its
consistency proves that a useful restriction selects the subclass with
the needed original-monomial survival probability, or establishes a new
size theorem for the full-width tree. Standard local-law inputs and
coordinate operations receive credit; no novelty certification is made.

No new amplified SoS result, arbitrary-m theorem, circuit-compressed
hardness, computational pseudorandomness, inversion/SAT runtime hardness,
circuit lower bound or P-versus-NP conclusion follows. Assignments remain
over F_2 while any certificate/PSD reasoning would be over R. The public
v4 theorem and its explicit before-squaring/before-Boolean monomial-size
convention remain unchanged.

## Final crosschallenge and disposition

Read the complete actual final crosschallenge at SHA256
`05FCEAF3CF0985E6ACC7A997A05A321B36223EFCD8DF565515DAFDBD55E16D33`.
It reports PASS for the corrected author at the exact pin above and NONE
for this random-form sampler only. I reread the saved author's final cost
correction: expected rejection trials are at most two, with equality for
the last vector of a full basis. The reviewer supplied and is credited
for this endpoint correction, independent counterchecks, and the narrower
coordinate-product comparison. This is constructive design review, not
verification-only provenance.

**Final nonclaims disposition: GO for the corrected design assessment and
rule-specific NONE selection.** Actual nonempty-fiber and consistency
tests support this result. No operation is rejected merely because its PSD
bound is unproved; the necessary observable marginal identity already fails.
No alternate full-width law, global nonexistence or new hardness conclusion
is adopted. The published theorem is unchanged.

The root confirmed NONE for the specified law and authorized a scoped local
integration of the three design/review records and research graph after
final actual-file checks. The broader research objective remains ACTIVE
and unresolved. Only this record was written by this reviewer before that
authorized evidence closeout. No proof/public edits, experiment, push,
outreach or paid computation is performed. Frozen for scoped integration.
