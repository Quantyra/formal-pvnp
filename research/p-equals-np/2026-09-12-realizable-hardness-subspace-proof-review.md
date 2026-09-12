# Arbitrary-subspace restriction: independent proof-adversarial review

2026-09-12; S3126/S3133. Reviewer: `subspace_proof_review`, independently
assigned by the planning orchestrator. **GO-WITH-NOTES**, limited to the
fixed arbitrary-subspace unconditional numeric codimension theorem.

## Candidate and actual verification

Reviewed candidate `f7dcf6730ade00f2d9187d5db7c220d88b9b0ae4` and the complete
main, Checks, and author receipt, against `INTEGRITY-CLAIMS.md`, S3133 and
the planning three-lens protocol. No destination AGENTS.md exists.

- `lean/PvNP/RealizableHardness/SubspaceRestriction.lean`: SHA256
  `f6cd2342704fe24a3b3b5f8b0ff22d3f9cc54e11d69c5f3a695cc8af08944506`.
- `lean/PvNP/RealizableHardness/SubspaceRestrictionChecks.lean`: SHA256
  `8061a8cbf674e63c617e204a87df22b2abeb345784bd8e44dbea1d113e38c7bf`.

Both hashes matched before and after independent compilation. Actual commands,
from the formal-pvnp repository with `LEAN_NUM_THREADS=1`:

```text
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/SubspaceRestriction.olean lean/PvNP/RealizableHardness/SubspaceRestriction.lean
elan run leanprover/lean4:v4.13.0 lake env lean -o .lake/build/lib/PvNP/RealizableHardness/SubspaceRestrictionChecks.olean lean/PvNP/RealizableHardness/SubspaceRestrictionChecks.lean
```

Main session **64782 exited 0** without diagnostics. Checks session **17088
exited 0**, all examples successful and all **13** printed axiom profiles
exactly `[propext, Classical.choice, Quot.sound]`. No sorry, admit, new axiom,
native_decide, or elaboration-option override occurs in these two sources.
The initial wildcard hygiene command was not expanded by PowerShell and
reported an invalid filename; it was corrected to the two explicit paths.
This did not affect either successful compiler command.

Fresh native checks found no competing Lean/Lake before launch and none after
the two actual terminal outcomes. Available C capacity was 6.945 GB initially
and 6.940 GB at release. No downloads, cache cleanup, proof edits, companion
changes, or toolchain changes were performed. The compiler reservation was
explicitly released to the root after both terminal results.

## Mathematical audit

`codim W` is the ambient finrank minus the finrank of the actual submodule W.
`annihilator_finrank` derives the annihilator dimension from the actual
dual-of-quotient equivalence and quotient rank-nullity. The natural-number
subtraction is justified by that dimension equality, not an assumed row count.

`coordinateDual_apply` identifies the standard basis dual equivalence with
the exact dot pairing in the accepted triple module. Its proof checks every
coordinate basis vector. `annihilatorBasis` enumerates the full annihilator
using the proved finrank equality. `definingForms` composes its inverse
coordinate equivalence with the injective annihilator inclusion and inverse
coordinate dual. Thus `definingForms_full` proves actual injectivity.

`definingForms_kernel` proves both inclusions. For the inclusion from the
constructed kernel into W, it uses surjectivity onto every annihilator functional and the characterization
of W by vanishing of all such functionals. It does not assume a kernel
identity, independence, existence of a representation, or a spanning subset.
The existence theorem therefore discharges the previously missing arbitrary-W
representation interface.

`codimInRetained` uses the finrank of the actual retained subspace and of
W's comap along its inclusion. `represented_codim` rewrites the established
kernel equality, and `arbitrary_subspace_failure_probability` instantiates
the accepted `TripleRestrictionRank.intersection_codim_failure_probability`
with the constructed independent forms. The inspected imported definitions
use the actual product law (keep all with mass 1-beta, each singleton with
mass beta/3), and the actual numeric intersection codimension. The conclusion
is therefore the desired fixed-W unconditional event bound
`Pr[codimInRetained W d != codim W] <= (2^(codim W)-1)*beta`, with rational
`0 <= beta <= 1`. No extra representation hypothesis survives.

## Boundary and nonvacuity checks

Checks successfully cover top W with codimension zero and zero failure mass,
bottom W with ambient codimension six for two triples, arbitrary W for J=0,
and its kernel identity. The coordinate hyperplane example is nontrivial:
the coordinate projection is proved surjective, rank-nullity gives actual
codimension one, and its full-rank representation, kernel equality, beta=0
zero failure and beta=1/2 upper bound compile. Bottom and empty cases are
dimension/representation checks, not an exhaustive enumeration of their
probability laws; the general theorem covers them. No high-severity vacuity,
hidden-hypothesis, or statement mismatch was found.

## Limits

W is fixed outside the probability event; this is not simultaneous success
over all W and does not permit choosing W after observing the draw. A W(Q)
application must fix Q and separately establish the actual posterior transfer.
Basis choice here is noncomputable mathematics, not an efficient representation
algorithm. No incidence likelihood, tail cutoff, posterior independence,
Grassmann counting, decoder, machine runtime, full hardness, learning theorem,
single-toolchain package certification, novelty, or publication readiness is
proved by this increment. These explicit limits motivate GO-WITH-NOTES and
do not block acceptance of the stated bounded theorem.
