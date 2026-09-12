# Arbitrary-subspace representation: author verification

2026-09-12; S3126/S3133. **AUTHOR VERIFIED; INDEPENDENT REVIEW PENDING.**
Actual main and Checks exports passed, with 13 standard-only axiom profiles
and all examples successful. Three fresh independent reviews remain required;
this is not independent acceptance or complete S3133 certification.

## Scope and sources

The accepted `TripleRestrictionRank` candidate is
`4021e7cdff5e41152c07000a3e2e0135c2e181d0`, with independent three-lens
integration `20039749e65dcb0eb719fed130aa9860bce855ea`. All three dated
triple-review receipts identify arbitrary W representation as a remaining
interface. This draft implements that interface, using the local S3133
story and full-goal dependency ledger. Destination integrity source remains
`INTEGRITY-CLAIMS.md`; no destination `AGENTS.md` exists.

Only these three new files are owned by this increment. The accepted triple
source, companion package, manuscript, and other modules are unchanged.

- `lean/PvNP/RealizableHardness/SubspaceRestriction.lean`: 6168 UTF-8 bytes,
  128 lines, SHA256
  `f6cd2342704fe24a3b3b5f8b0ff22d3f9cc54e11d69c5f3a695cc8af08944506`.
- `lean/PvNP/RealizableHardness/SubspaceRestrictionChecks.lean`: 3111 UTF-8
  bytes, 73 lines, SHA256
  `8061a8cbf674e63c617e204a87df22b2abeb345784bd8e44dbea1d113e38c7bf`.

Both are LF files, with actual mathematical Unicode preserved. Neither contains a literal question
mark or a forbidden proof construct in the static scan. These facts are
source hygiene, not proof verification.

## Concrete representation, rather than an assumed interface

For arbitrary `W : Submodule (ZMod 2) (Vector J)`, `codim W` is defined as
the actual natural-number difference between the ambient and W finranks.

1. `annihilator_finrank` derives the dimension of W's actual dual annihilator
   from the dual-of-quotient equivalence, dual dimension, and quotient
   rank-nullity. The number of rows is therefore proved to be `codim W`.
2. `annihilatorBasis` uses `Module.finBasisOfFinrankEq` on that proved
   equality. The associated finite-coordinate equivalence enumerates the
   full annihilator, not a chosen subset assumed to span it.
3. `coordinateDual` is the standard coordinate-basis dual equivalence.
   `coordinateDual_apply` identifies its application with the exact dot
   pairing used by `TripleRestrictionRank.evaluate`, through equality on
   every coordinate basis vector.
4. `definingForms W` composes the annihilator coordinate equivalence, actual
   submodule inclusion, and inverse coordinate-dual equivalence. Its type
   is exactly `Coeff (codim W) ->linear Vector J`.
5. `definingForms_full` proves injectivity by composing actual injections.
   `definingForms_kernel` proves the ambient common-zero subspace is W:
   every annihilator form is represented, and vanishing of every annihilator
   form characterizes membership in W. No existence, injectivity, or kernel
   identity is supplied as a hypothesis or structure field.

`exists_independent_defining_forms` exposes the completed intended
representation assertion as an existence theorem. It is noncomputable
mathematical basis choice, not an executable representation algorithm.

## Verified probability statement

`codimInRetained W d` is the actual dimension difference inside the selected
coordinate subspace V, with W intersect V represented by comap along V's
subtype. `represented_codim` identifies this event with the accepted triple
module's numeric intersection-codimension event.

`arbitrary_subspace_failure_probability` consequently states, for each
fixed arbitrary W and rational `0 <= beta <= 1`,

`Pr[codimInRetained W d != codim W] <= (2^(codim W)-1)*beta`.

It consumes the actual normalized unconditional triple-deletion law. W is
fixed before the draw. The theorem does not take an unproved representation
contract and does not replace numeric codimension with only row-rank failure.

## Boundary checks and remaining work

The Checks source includes top and bottom W, J=0 with arbitrary W,
representation equality at J=0, zero failure mass for top W, and a genuine
coordinate hyperplane in one triple. The coordinate evaluation is explicitly
surjective; rank-nullity derives hyperplane codimension one. Its representation
and beta=0 and beta=1/2 probability consequences are included. Thirteen
`#print axioms` commands completed successfully. Every output lists exactly
`propext`, `Classical.choice`, and `Quot.sound`.

The required author gate completed under root's explicit exclusive compiler
grant, Lean 4.13.0, cached pinned mathlib, and `LEAN_NUM_THREADS=1`. Fresh
native/capacity checks showed no competing compiler and more than 7 GB free.
No dependency downloads, cleanup, companion changes, or toolchain changes
were performed.

| Session | Target | Actual outcome |
| --- | --- | --- |
| 92475 | Main | Exit 1: a single inferred module/field ambiguity in the quotient-dual finrank equality. |
| 67906 | Main | Exit 0, no warnings; the equality now carries its explicit dimension type. |
| 67608 | Checks | Exit 0, no warnings; all examples and 13 standard axiom profiles. |

The sole proof correction supplies an explicit type to the dimension
equality; no representation premise was added and no statement weakened.
The main tested SHA256 was
`241089689ff57a7b345214c9728d71e7dc3b36080425185e03fbf2f994fa8fac`;
Checks tested SHA256 was
`757724d6c4f0b7ea1a94a4c1e2dea487d4848184de2c1817a65d5f56956e7f68`.
Final files differ from these only in status comments. Exact byte reconstruction
of both tested pins was verified; per root instruction no redundant build
was run solely for these comments. Three fresh independent review lenses
remain required against the final candidate pins above.

Even successful verification would not supply a posterior law, incidence
likelihood ratio, tail cutoff, conditional independence, simultaneous success
over all W, Gaussian-binomial counts, Grassmann/covering/decoder theorem,
machine runtime, full hardness or learning theorem, or publication readiness.
For W(Q), Q must first be fixed and the actual posterior transfer still
applied separately. No new novelty or public-release claim is made.

## Independent three-lens bounded acceptance

The author-pending history above is preserved. Candidate
`f7dcf6730ade00f2d9187d5db7c220d88b9b0ae4` is now **ACCEPTED IN BOUNDED
SCOPE**, after three distinct top-level reviews. The main and Checks hashes
recorded above remain unchanged. No Lean source or companion package was
changed during evidence integration.

| Lens | Verdict | Actual evidence |
| --- | --- | --- |
| Independent build/audit | GO | Main session 64782 exit 0; Checks session 17088 exit 0; all examples and 13 profiles exactly propext, Classical.choice, Quot.sound. |
| Proof-adversarial | GO-WITH-NOTES | `2026-09-12-realizable-hardness-subspace-proof-review.md`; actual arbitrary-W representation, injection, kernel identity and numeric event checked. |
| Complexity | GO-WITH-NOTES | `2026-09-12-realizable-hardness-subspace-complexity-review.md`; fixed-W quantifiers and noncomputable basis boundary retained. |
| Non-claims | GO-WITH-NOTES | `2026-09-12-realizable-hardness-subspace-nonclaims-review.md`; wording confined to unconditional finite-dimensional result. |

Independent compilation used cached Lean 4.13.0 and LEAN_NUM_THREADS=1,
with no competing compiler at launch or release, no downloads and no source
changes. Both actual terminal exits were observed before compiler release.

Acceptance discharges the arbitrary fixed-W defining-forms interface and
its unconditional numeric intersection-codimension bound. It does not close
S3133 or the full goal. Actual posterior likelihood and tail transfer, the
Grassmann/incidence/covering/decoder dependencies, runtime and full hardness
and learning statements, single-toolchain package verification, and final
paper reconciliation remain open. No simultaneous-all-W, adaptive-W,
efficient basis algorithm, novelty or publication-readiness claim follows.
