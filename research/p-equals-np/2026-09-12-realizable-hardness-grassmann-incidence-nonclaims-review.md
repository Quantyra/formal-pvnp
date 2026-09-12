# Grassmann incidence: non-claims boundary review

Verdict: **GO-WITH-NOTES** for the concrete finite incidence-law increment.
Full S3126 certification and final paper reconciliation remain open.

Reviewer: independent top-level AI non-claims-boundary reviewer, 2026-09-12.
This is a source and wording review, not human peer review, novelty review,
an independent compiler run, or certification of the full hardness theorem.

## Frozen evidence and review scope

Reviewed candidate `3fb16f4508396007d35270b2657c217c75e62de7` in
`C:/Users/Dan/Desktop/Projects/formal-pvnp`, specifically
`GrassmannIncidence.lean`, `GrassmannIncidenceChecks.lean`, and the dated
Grassmann incidence author formalization receipt. All three worktree files
have no diff against the frozen commit. Working-file SHA256 values:

- Main: `1faa084993341ee4505eeb44d1de96917cbcbc4cad8e454ac7d9033eb29ae49c`.
- Checks: `5cfe158eac23235603629ffff58fa7f0ec266b4c8a3fe14849de9a441b39cc48`.

Read the actual declarations and boundary examples, destination README
non-claims boundary, planning formal-three-lens-closeout protocol, full
Lean dependency assessment, and `realizable-cmmsa-hardness/MANUSCRIPT.md`
lines 304-423. The destination has no root AGENTS.md. The separate complexity
review was also inspected; this verdict comes from comparing source targets
with the manuscript and author wording, rather than adopting its verdict.

The author receipt reports main session 35756 and Checks session 34767
returned exit 0, with seventeen requested axiom profiles: selected_kept
uses propext; the other sixteen use propext, Classical.choice and Quot.sound.
These are attributed author results here. Independent export and axiom
verification belongs to the proof reviewer and is not inferred from this
source review. The recorded unused-binder warning is not hidden. This review
ran no compiler, downloaded nothing, and changed no source, companion file,
Git index, commit, release, or paper.

## Wording supported by the declarations

The module constructs the actual finite type of a-dimensional submodules
of the GF(2) ambient coordinate space. The incidence fibre is the subset
contained in the retained space, and its actual cardinality supplies the
kernel denominator. Nonempty fibres are proved under a <= J by an explicit
linear embedding onto one retained coordinate in each of the first a blocks.
The range supplies the required subspace. The same embedding proves retained
dimension at least J. These are substantive geometric premises discharged
by the source, not a supplied normalized-kernel assumption.

The reciprocal-cardinality kernel is zero off incidence and normalized on
each nonempty fibre. Its prior is the existing triple product mass. The joint,
advice marginal, and conditional definitions instantiate the actual kernel
in the accepted finite Bayes machinery. The source proves normalization,
support, a positive-prior ratio identity and a positive-marginal Bayes
identity. The author's label "actual advice-incidence law" is justified
within these premises and the probability-domain qualifications below.

The Checks examples cover zero advice dimension, zero blocks, beta endpoints,
one-block retained dimension and nonincidence support. They do not claim
Gaussian counting estimates or any asymptotic posterior bound. Seventeen
axiom-print requests are not seventeen discharges of the full dependency
ledger; the receipt accurately restricts them to this module.

## Required qualifications

- Normalization is an algebraic total-sum identity for every rational beta.
  A probability interpretation requires 0 <= beta <= 1, as reflected in
  the joint and marginal nonnegativity premises. Signed masses outside
  this range are not probability distributions merely because they sum to one.
- Uniform incidence normalization requires a <= J. The final parameter
  construction must establish that premise; it is not proved here from
  the manuscript's eventual parameter choices.
- `conditional_normalized` and `bayes_joint` explicitly require positive
  advice marginal. At marginal zero, total rational division makes every
  conditional atom zero, not a normalized conditional distribution.
  `conditional_ratio` requires positive prior and remains an algebraic
  identity even at zero marginal; its probabilistic reading still needs
  the probability range and a positive conditioning marginal.
- The current random variable is the complete triple-choice record. The
  manuscript denotes its retained geometric subspace by V. A later proof
  must identify these spaces or push the finite law forward correctly;
  the current atomwise formula alone is not that bridge.
- No posterior independence is assumed or established. An unconditional
  rank estimate cannot be reused after conditioning without the pending
  likelihood and exceptional-set bounds. Later W(Q) is fixed after Q;
  this is not permission to choose W adaptively from the draw itself.
- The noncomputable finite type, cardinality and sums are mathematical
  semantics, not an enumeration algorithm, efficient sampler, runtime
  certificate, polynomial output bound, or bounded-coin implementation.

These qualifications agree with the author receipt. No blocking wording
expansion was found in the frozen main, Checks or receipt. Their "independent
review pending" status is appropriately conservative until closeout evidence
is integrated; this review does not update that status by itself.

## Remaining obligations and public boundary

S3133 still needs Gaussian-binomial cardinality formulas and product-ratio
estimates, exact retained dimension in terms of dropped blocks, the binomial
law and tail, exceptional-advice and low-marginal bounds, comparison with the
uniform ambient advice law, and the actual likelihood bound 8 * 2^(2aT).
The exact Bayes identity is only the first equality of that argument.

The posterior rank estimate must compose those bounds with the accepted
unconditional arbitrary-subspace result. The KMS joint sampler conditioned
on Q contained in L, its posterior identification, covering distances,
zoom-out probability ratios, and relative weighted-mixture estimates remain
to be supplied in the actual geometric law. The generic accepted Bayes and
reweighting lemmas do not instantiate these geometric obligations themselves.

The ledger's outer-game/3-Lin, decoder, maximal-pair, modified-PCP, star
compilation, exact HN learning transfer, encoded randomized reductions,
fixed-L parameter limits and final assembly remain required. Acceptance of
this module supplies no source NP-hardness theorem, full nearlinear-gap
hardness proof, learning corollary, or uniform growing-L polynomial result.

No quantum algorithm, complexity-class separation, P=NP or P!=NP conclusion,
novelty certification, publication readiness, or peer-review status follows
from this increment. The archived DOI identifies a released artifact, not
the completion of the remaining Lean obligations. The final paper must
describe the exact checked subset until both full conclusions and all
dependencies have compiled and passed the required final reviews.

Accept this finite-law increment with these notes once independent build
and all three review lenses are recorded. Do not close full S3126 or advertise
full formal certification on the strength of this verdict.
