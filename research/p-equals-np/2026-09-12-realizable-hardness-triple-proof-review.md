# Triple restriction: independent proof-adversarial review

2026-09-12; S3126/S3133. Reviewer: top-level `triple_proof_review`, independent
of the author. **GO-WITH-NOTES for the bounded unconditional numeric
codimension theorem.** No HIGH vacuity, hypothesis, or statement defect found.
This does not close S3133 or certify the complete hardness/learning proof.

## Frozen source and verification

Candidate: `4021e7cdff5e41152c07000a3e2e0135c2e181d0`.

| File under `lean/PvNP/RealizableHardness/` | SHA256 |
| --- | --- |
| `TripleRestrictionRank.lean` | `50d2e5689be0ec37153c1fa37bbaadfaf9d17c07c1a694f64cb35fb4302f9ba9` |
| `TripleRestrictionRankChecks.lean` | `89e3c004fb206b5f81d3679dd3a9197dfd5c2eae754c32df511814077b39adf3` |

Read the complete main and Checks source, author receipt, local
`INTEGRITY-CLAIMS.md`, planning formal-three-lens protocol and S3133 story.
Inspected the concrete `trialMass`, its normalization, and event-factorization
dependency in `FiniteSampling.lean`. No destination `AGENTS.md` exists.

Independent exports used `LEAN_NUM_THREADS=1`, Lean `v4.13.0`, and existing
mathlib `d7317655e2826dc1f1de9a0c138db2775c4bb841`. Commands:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/TripleRestrictionRank.olean lean/PvNP/RealizableHardness/TripleRestrictionRank.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/TripleRestrictionRankChecks.olean lean/PvNP/RealizableHardness/TripleRestrictionRankChecks.lean
```

| Independent session | Actual terminal result |
| --- | --- |
| 90834 main | Exit 0; two unnecessary-sequence-focus style warnings. |
| 20714 Checks | Exit 0; all examples and 22 axiom profiles; one unnecessary-simpa style warning. |

All 22 parsed profiles contain only `propext`, `Classical.choice`, and
`Quot.sound`, including `intersection_codim_failure_probability` and
`exampleRows_full`. These are outputs of the independent run, not inferred
from the author's receipt. The current Checks source was compiled exactly,
including its updated status comment. Source hashes and candidate equality
were rechecked after both exports and remained unchanged. A source scan found
no sorry, admit, native_decide, custom theorem axiom, or heartbeat override;
the word "axiom" in the Checks header is descriptive text.

Fresh native scans found no competing compiler before launch and no remaining
Lean/Lake process after both exits. C free capacity was 7,902,580,736 bytes
before main, 7,518,351,360 before Checks, and 7,193,579,520 after completion.
No download, cleanup, restart, toolchain change, source edit, or companion
build occurred. Compiler ownership was explicitly released to root after both
terminal results. This receipt was the reviewer's only review-phase file
change. Root subsequently authorized a separate exact four-evidence-file
integration, including the author receipt's closeout table; this does not
authorize source changes or publication.

## Adversarial mathematical checks

1. The sample space is genuinely `Fin J -> Option (Fin 3)`, with product
   mass obtained from the implemented finite product. `none` keeps all
   coordinates and has mass `1-beta`; each singleton has mass `beta/3`.
   Normalization and one-block marginals are derived. They are not supplied
   as hypotheses. Nonnegativity, monotonicity, union bounds and all probability
   inequalities require `0 <= beta <= 1`. Algebraic normalization alone is
   stated for arbitrary rational beta; outside that interval it should not
   be interpreted as a nonnegative probability measure.
2. Removal of a chosen coordinate implies a dropped block, giving the valid
   (possibly loose) upper bound beta. For nonzero u, actual injectivity of R
   yields a nonzero coordinate of R(u). Vanishing after restriction entails
   removal of this coordinate. No independence of these vanishing events is
   assumed. The finite union runs over every nonzero coefficient vector, with
   exact cardinality `2^c-1` over GF(2).
3. `badRows` is equivalent to failure of injectivity of the actual restricted,
   zero-padded row map. Range finrank is proved to be c on the good event.
   FullRowRank is substantive: removing it would invalidate the bound at
   beta=0. Its satisfiability is witnessed by the explicit one-row example.
4. The final result is stronger than a renamed row-rank event. `retained d`
   is the actual coordinate subspace V. The dot pairing is evaluated on V;
   coordinate test vectors prove equivalence of coefficient vanishing and
   functional vanishing. `ambientKernel R` is the actual common-zero space W,
   and its comap to V is proved equal to the restricted evaluation kernel.
5. The evaluation map is proved to equal the dual of the row-functional map
   composed with the finite-dimensional double-dual equivalence. Good rows
   imply injectivity of the row-functional map, hence surjectivity of its
   dual and of evaluation. Rank-nullity then proves the numeric dimension
   difference `finrank V - finrank (W intersect V)` equals c. Natural
   subtraction is justified by that dimension identity, not by an unsupported
   subtraction assumption. The failure event inclusion into badRows yields
   the final numeric `intersection_codim_failure_probability` bound.
6. Checks cover beta=0 and beta=1 zero-mass atoms, J=0 normalization, c=0
   absence of nonzero combinations, and a concrete full-rank one-row map
   with a singleton draw that loses its row. Its beta=0 and beta=1/2 bounds
   compile. For impossible dimensions, FullRowRank can be unsatisfiable;
   this is the necessary independence hypothesis, not global vacuity.

## Remaining obligations and permitted use

The bounded theorem applies to a fixed R, with W defined as its evaluation
kernel, under the unconditional product law. Representing an arbitrary
decoder subspace W(Q) by independent defining forms after fixing Q remains
required. The actual posterior likelihood cutoff must then transfer the
unconditional estimate. Neither independence of W(Q) and V after conditioning
nor the posterior estimate follows from this module.

Concrete Grassmann incidence laws/counts, Gaussian-binomial ratios, tails,
covering/decoding, specialized PCP reductions, actual encoded machine runtime,
and the full hardness and learning theorems remain outside this review.
This acceptance does not transfer automatically to the uncompiled companion
package or establish paper-wide certification or novelty.
