# S3133 actual retained dimension source draft

2026-09-12; S3126 parent. **UNCOMPILED, not accepted.**

The draft uses the actual `TripleRestrictionRank.Draw`, `kept` and `retained`.
`dropCount d` counts blocks where d chooses `some k`, rather than `none`.
`retainedEquiv d` restricts a supported ambient vector to the kept-coordinate
subtype; its inverse extends by zero. Both inverse and linearity proofs are
written explicitly. The resulting finrank is the kept-coordinate cardinality.

`keptEquiv` splits a kept coordinate into its block and kept coordinate within
that block. `keptBlock_card` counts its actual fibre as three for `none` and
one for `some k`. Summing these finite counts proves the intended exact
identity

    finrank(retained d) + 2 * dropCount d = 3 * J.

The subtraction form follows, with a separate bound on twice the drop count.
There are no supplied dimension/cardinality oracles. The Checks source has
15 intended axiom commands, empty J, all-none, all-singleton, and a concrete
mixed two-block example with retained dimension four.

No compiler or axiom checks have run. Lean 4.13.0 and mathlib
d7317655e2826dc1f1de9a0c138db2775c4bb841 are the intended source pins.
No accepted source, frozen GrassmannCounting draft, companion artifact or
public material is changed. This is a standard finite coordinate-space
identity; no mathematical novelty or publication claim is made.

| Lens | Verdict | Note |
|---|---|---|
| Build/audit | INCOMPLETE | Source-only draft; compiler owned by companion integration. |
| Proof-adversarial | INCOMPLETE | Required after actual build. |
| Complexity | INCOMPLETE | Required after actual build. |
| Non-claims | INCOMPLETE | Required after actual build. |

Remaining: compile and repair the exact statements, audit and independently
review all three lenses, compose with the exact Grassmann count after its
own verification. Probability of the drop count, binomial tails, Gaussian
ratios, posterior estimates and the complete specialized hardness/learning
proof and paper reconciliation remain separate open obligations. The source
does not claim any probability law, runtime bound or complete certification.
