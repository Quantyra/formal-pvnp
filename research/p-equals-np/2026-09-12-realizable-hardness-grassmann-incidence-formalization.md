# Actual advice-incidence law — bounded acceptance

Status: accepted finite incidence-law component after independent exports and
three-lens review. Full S3126 certification and paper reconciliation remain open.
The original UNCOMPILED draft was preserved as af45e86 before compilation.
No downloads, cache changes, or companion edits were performed.

Route: S3133 under S3126; actual posterior section of MANUSCRIPT.md,
lines 304–423, and the full Lean dependency assessment. Destination is
formal-pvnp, root Lean 4.13 and its existing pinned mathlib.

## Concrete construction

Advice J a consists of actual a-dimensional GF(2) submodules of Vector J.
It is finite by injection of submodules into the finite powerset of the
finite ambient vector space. The incidence fibre filters all advice
subspaces by Q <= retained d. Its cardinality is the denominator of the
uniform kernel; kernel normalization is derived from this finite sum.

Nonempty fibres are proved without assuming a dimension-existence oracle:
embed d a places the first a scalar coordinates on one selected retained
coordinate in each of the first a blocks. For a <= J it is injective.
Its range is an a-dimensional subspace contained in retained d. Taking
a = J and codRestrict proves finrank(retained d) >= J. This handles J=0
and a=0 without conditioning on an empty law.

The prior is exactly FiniteSampling.trialMass of TripleRestrictionRank's
blockMass. The joint is prior times the derived incidence kernel. The
marginal and posterior instantiate accepted PosteriorReweighting definitions.
Joint and marginal normalization, support, positive-marginal posterior
normalization, exact Bayes identity, and positive-prior likelihood ratio
are explicit. Nonnegativity uses the genuine beta range 0 <= beta <= 1;
the algebraic total-sum identities do not require that range.

## Source inspection and checks

Inspected actual pinned mathlib definitions finrank_range_of_inj,
finrank_le_finrank_of_injective, Module.finrank_pi, mul_inv_cancel₀.
Checks request seventeen axiom profiles and exercise zero advice dimension,
zero ambient blocks, beta endpoints, a one-block dimension bound and
nonincidence support. Main session 35756 and Checks session 34767 both
returned actual exit 0 using root Lean 4.13 with LEAN_NUM_THREADS=1 and
explicit -o exports into .lake/build/lib/PvNP/RealizableHardness.

All seventeen requested axiom profiles were printed. selected_kept uses
only propext; the other sixteen use propext, Classical.choice and Quot.sound.
No sorry, admit, new axiom or native_decide occurs. The main export has one
harmless unused Q binder warning in its constant fibre sum; this is retained.

Initial main session 86670 returned exit 1 with local-attribute syntax,
pointwise map-law reduction, pair reconstruction, Advice unfolding for a
finite instance, and sum_filter rewrite errors. These were repaired without
altering theorem targets. Successful exports were not rerun for comments:
the final source differs from compiled source only in status comments.
At completion no native Lean/Lake process remained and C free space was
4,313,624,576 bytes, above the 512 MiB guard.

## Independent verification and three-lens closeout

Frozen source candidate: `3fb16f4508396007d35270b2657c217c75e62de7`.
Independent proof reviewer main session 48701 and Checks session 27608 both
returned actual exit 0 under the root Lean 4.13 toolchain, with
LEAN_NUM_THREADS=1 and explicit exports to the same .lake/build/lib paths.
The only main warning was the unused Q binder already recorded above.
All seventeen actual axiom profiles were verified: selected_kept uses
propext only; the other sixteen use propext, Classical.choice and Quot.sound.
No source changes or cosmetic recompilations were made for this closeout.

| Lens | Verdict | Evidence |
|---|---|---|
| Build/audit | GO | Independent main 48701 and Checks 27608 exited 0; all 17 profiles verified |
| Proof-adversarial | GO-WITH-NOTES | [Proof review](2026-09-12-realizable-hardness-grassmann-incidence-proof-review.md); no blocking statement defect |
| Complexity | GO-WITH-NOTES | [Complexity review](2026-09-12-realizable-hardness-grassmann-incidence-complexity-review.md); finite law only, machine and parameter obligations remain |
| Non-claims | GO-WITH-NOTES | [Non-claims review](2026-09-12-realizable-hardness-grassmann-incidence-nonclaims-review.md); wording bounded to the actual component |

These are independent AI review lenses, not human peer review or novelty
certification. Source working-file SHA256 values remain:

- Main: `1faa084993341ee4505eeb44d1de96917cbcbc4cad8e454ac7d9033eb29ae49c`.
- Checks: `5cfe158eac23235603629ffff58fa7f0ec266b4c8a3fe14849de9a441b39cc48`.

The unchanged source headers preserve the historical author-stage status;
this evidence receipt records the subsequent bounded acceptance.

## Remaining obligations and claims boundary

Independent three-lens review and root-toolchain exports are complete for
this component; combined-toolchain integration remains a separate obligation.
This does not establish the Gaussian-binomial cardinality formula or its
ratio estimates, dropped-block tails, exceptional advice bounds, KMS
couplings, the conditioned rank bound, decoder, or any runtime theorem.
The draw variable retains the complete block-choice record; later use of
geometric V must identify or push forward that record faithfully. No
posterior independence is assumed. Noncomputable finite enumeration and
dimension reasoning are mathematical objects, not an efficient algorithm.
The full hardness and learning theorem and paper reconciliation remain open.
