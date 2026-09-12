# Concrete triple restriction: source draft

2026-09-12; S3126/S3133. **UNCHECKED.** No Lean command, Lake build, axiom
audit, or independent review has been run for these sources. This record is
a source milestone only; the full theorem and S3133 remain open.

## Owned artifacts and source pins

- `lean/PvNP/RealizableHardness/TripleRestrictionRank.lean`
  SHA256 `1cbb6b609d280ec0b4ec0981bbf782e7731e2e81369d5e18e6e5aaf17d0894b0`
  (17177 UTF-8 bytes, LF, 386 non-ASCII characters).
- `lean/PvNP/RealizableHardness/TripleRestrictionRankChecks.lean`
  SHA256 `33e3aded9797d395035077ba02a902c7346816d0d985700006c0427d3aeb8149`
  (3129 UTF-8 bytes, LF, 16 non-ASCII characters).

Destination integrity source: `INTEGRITY-CLAIMS.md`; no destination
`AGENTS.md` or `INTEGRITY.md` exists. Source contract: the dependency
assessment dated 2026-09-12 and the posterior/zoom-out section of
`realizable-cmmsa-hardness/MANUSCRIPT.md`, especially its unconditional
rank estimate. This is a formalization of that documented argument, with
no new novelty claim.

## Actual objects and intended exports

The sample space is `Fin J -> Option (Fin 3)`. `none` retains all three
coordinates with rational mass `1-beta`; `some k` retains exactly k with
mass `beta/3`. The law is the concrete product of these masses, using the
existing finite product implementation. `blockMass_sum`, `probability_univ`,
`block_marginal`, and `drop_marginal` derive normalization and the actual
single-block marginal. No desired marginal or independence is a hypothesis.

`retained d` is the submodule of GF(2) coordinate vectors supported on kept
coordinates. `R` maps the c row coefficients linearly into the ambient
coordinate space; `FullRowRank R` is injectivity of this actual linear map.
`rowCombination` also constructs it directly from a finite matrix.

For every nonzero row combination, injectivity supplies a nonzero coordinate.
Its vanishing after restriction entails removal of that coordinate, hence
dropping its block. `coordinate_removed_bound` bounds this by beta.
`probability_cover` proves a finite union bound without requiring independent
events. The union contains exactly `2^c-1` nonzero coefficient vectors.
`badRows_probability` therefore targets the manuscript bound
`Pr[badRows R] <= (2^c-1)*beta`.

`badRows_iff_not_injective` relates this event to the restricted row map.
`restricted_rank_failure_probability` exports the bound for its actual
range finrank. `vanishing_on_retained_iff` proves that vanishing retained
coefficients is exactly vanishing as a functional on the selected subspace;
it uses actual coordinate test vectors.

The numeric codimension bridge is written, rather than assumed:

- `ambientEvaluation R` evaluates the independent row forms; `ambientKernel R`
  is their common-zero subspace W.
- `intersectionInRetained R d` is W intersect V, represented internally in V
  by comap along the subtype map. `intersection_eq_kernel` identifies it
  with the kernel of the actual restricted evaluation map.
- `rowFunctionals_injective` and `restrictedEvaluation_dual` use the actual
  bilinear evaluation and finite-dimensional double-dual equivalence.
- `goodRows_evaluation_surjective` and rank-nullity yield
  `goodRows_intersectionCodim`, for the numeric dimension difference.
- `intersection_codim_failure_probability` targets
  `Pr[intersectionCodim R d != c] <= (2^c-1)*beta`.

All these statements and their proof scripts await elaboration and kernel
checking. Their presence in source is not proof acceptance.

## Checks and boundaries

The Checks draft includes zero-mass atoms at beta=0 and beta=1, normalization
with J=0, the c=0 empty combination case, and a satisfiable one-row example
on one triple. The example has an explicit injectivity proof and loses its
row on a specified singleton draw; its beta=0 and beta=1/2 probability
conclusions use the main bound. The intended exports have `#print axioms`
commands, but no output has yet been obtained.

This fixes W as `ambientKernel R` before the unconditional draw. Applying
the result to an arbitrary decoder-provided W(Q) still requires representing
that W with its independent defining forms after fixing Q, followed by the
actual posterior likelihood-cutoff argument. There is no assertion that
W(Q) and V are independent after conditioning. No Grassmann enumeration,
Gaussian-binomial ratio, binomial tail, covering, decoder, machine-runtime,
or complete hardness theorem is discharged here.

## Verification and preservation record

An initial PowerShell-to-Python write replaced mathematical Unicode with
literal question marks. Root detected this before any compiler ran. Both
drafts were replaced through the patch tool, and exact UTF-8 readback and
SHA256 were checked. Remaining question marks are tactic subgoal syntax,
not damaged mathematical text. A static scan finds no forbidden proof
construct in the main source; the word "axiom" in the Checks header is
descriptive prose. This scan is not a Lean audit.

Compiler permission remains reserved to the foundation audit, followed by
the independent sample-count check and posterior module. This module must
receive an explicit compiler slot, actual successful main/Checks exports,
and actual axiom profiles, then three fresh independent proof, complexity,
and non-claims reviews. No acceptance verdict is assigned now. No public
push, release, paper publication, or new DOI action was performed.
