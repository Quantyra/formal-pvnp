# S3133 exact Grassmann counting source draft

2026-09-12. Parent S3126; source-only increment. **UNCOMPILED; not accepted.**

## Exact intended statements

`Grass V a` is the actual type of GF(2) submodules of V with dimension a.
`Frame V a` is the actual type of independent ordered a-tuples in V.
The explicit `flatten` map sends a subspace with an internal frame to the
ambient frame. Its injectivity is proved by recovering the subspace as the
span; surjectivity chooses that actual span and lifts each frame vector into it.
Thus `frameEquiv` is a counted-bases equivalence, not a supplied counting oracle.

The pinned mathlib source
`.lake/packages/mathlib/Mathlib/LinearAlgebra/Matrix/GeneralLinearGroup/Card.lean`
contains `card_linearIndependent`, proved by extending independent frames
with vectors outside their span. We inspected its proof and use its exact
product, with field cardinality 2. This gives the intended double count

    card(Grass V a) * product(i<a, 2^a - 2^i)
      = product(i<a, 2^dim(V) - 2^i), for a <= dim(V).

Positivity of the left factor's frame product permits natural division.
`gaussian n a` is this natural product quotient for a <= n and zero otherwise.
`card_grass` states the exact subspace cardinality for every a, including a=0
and a>dim(V). `gaussian_zero`, `gaussian_self` and `gaussian_of_lt` expose
the boundary conventions. The formula is standard finite geometry; no
mathematical novelty is claimed.

`containedEquiv W` constructs the equivalence between subspaces of W and
ambient subspaces contained in W using actual submodule map/comap. Its
surjectivity proves the dimension of the preimage by the subtype-map
dimension theorem. `incidenceCount_eq` connects the already defined sampler
fibre cardinality to `gaussian (finrank (retained d)) a`. It does not introduce
a substitute denominator or assume its value. The dimension in this statement
is the actual retained submodule dimension.

## Verification status

No compiler, cache download, axiom audit or independent review has run on
these files. The Checks source contains 21 intended axiom commands, empty
and out-of-range cases, n=a, and nontrivial GF(2)^3 counts (seven lines and
seven planes). Elaboration and all outputs remain unverified. Source-only
inspection is not kernel evidence. The pinned source toolchain is Lean 4.13.0,
mathlib d7317655e2826dc1f1de9a0c138db2775c4bb841.

| Lens | Verdict | Note |
|---|---|---|
| Build/audit | INCOMPLETE | Compiler slot belongs to the foundation integration route. |
| Proof-adversarial | INCOMPLETE | Fresh independent review required after build green. |
| Complexity | INCOMPLETE | Fresh independent review required after build green. |
| Non-claims | INCOMPLETE | Fresh independent review required after build green. |

The draft may be preserved in an exact three-file commit under root grant;
that commit is not formal acceptance. No accepted module, companion package,
manuscript, public release or claim metadata is changed by this increment.

## Remaining exact work

Compile and repair these exact statements without weakening their targets;
run Checks and inspect axiom profiles; obtain all three independent reviews.
Prove the retained-dimension arithmetic identity dim(V)=3J-2D for the actual
drop count. Establish the Gaussian product-ratio estimates, actual posterior
likelihood bound, tail/exceptional-mass and KMS conditioning identities.
The natural cardinality formula here does not yet give those rational bounds.
There is no algorithmic enumeration, runtime theorem, specialized PCP/decoder,
learning transfer or complete hardness certification in this module. Full S3133
and S3126, companion compilation and final paper reconciliation remain open.
