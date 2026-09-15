# Submodule-functional gluing closeout

Date: 2026-09-15. Disposition: **GO-WITH-NOTES**. This increment closes the generic algebraic gluing obligation: two fixed linear maps on submodules that agree on their intersection have a unique common linear extension to the submodule sum. It does not instantiate the manuscript's actual coordinate and equation-span domains or complete label transport, star acceptance, or the headline reduction.

## Frozen theorem and sources

The reviewed source commit is `52324cc3f6f307332c5ceca07668eb8c18e379c1` (`prove unique submodule functional gluing`). The theorem is:

```lean
theorem existsUnique_glue_on_sup
    {K V W : Type*} [Field K]
    [AddCommGroup V] [Module K V]
    [AddCommGroup W] [Module K W]
    (A B : Submodule K V)
    (f : A →ₗ[K] W) (g : B →ₗ[K] W)
    (hagree : ∀ z : ↥(A ⊓ B),
      f ⟨z.1, z.2.1⟩ = g ⟨z.1, z.2.2⟩) :
    ∃! F : ↥(A ⊔ B) →ₗ[K] W,
      F.comp (Submodule.inclusion le_sup_left) = f ∧
      F.comp (Submodule.inclusion le_sup_right) = g
```

| Source | SHA-256 |
|---|---|
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/SubmoduleFunctionalGluing.lean` | `3AFDACA24136FB81140471BD7CB40398CE61A2D1896DD78973E25041D51E7D73` |
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/SubmoduleFunctionalGluingChecks.lean` | `E41183DB2B49F958C7CA0FA753AB58721AD63D7ACAFA1DDD2715DB54CAE4DA52` |

The proof chooses one `A + B` decomposition for each element of `A ⊔ B`, proves that `f a + g b` is independent of that choice using agreement on `A ⊓ B`, and then proves linearity, the two restriction equations, and uniqueness. It does not assume a direct sum or uniqueness of decompositions. The Checks module exercises a nonzero full-overlap functional and the zero-submodule branch.

## Target-fresh certification

The canonical certification folder is `research/evidence/2026-09-15-submodule-functional-gluing-fresh-run`. Its in-run contents remain unchanged. The SHA-256 of `artifact-hashes.txt`, recorded in `artifact-hashes-manifest.sha256`, is `E63C8B32DE354264FA8A9AD3A8CAD5CBCE12E80C20ACB875B0E7D7BB395C88C0`; all 26 manifest rows were independently rehashed by the reviewers.

The isolated target contained neither target object before compilation. Main and Checks were compiled sequentially with Lean `4.34.0-rc2`, both exited `0`, and both source hashes remained stable. This is a target-fresh build against immutable seeded transitive dependencies, not a full source rebuild of Mathlib.

| Module | Exit | Object SHA-256 |
|---|---:|---|
| `SubmoduleFunctionalGluing` | 0 | `77D109A27663844EB3D553C7F23FBB4C064A34AFE9B0F977A5156B14DCC415E7` |
| `SubmoduleFunctionalGluingChecks` | 0 | `D40CF30A445FF7DFC18F927BAF4FED5657A8D5EBE8CE723AA7CE64F0D9D7518E` |

The forbidden scan found no `sorry`, `admit`, `native_decide`, or explicit source-level `axiom`. The theorem's printed axiom profile contains only `propext`, `Classical.choice`, and `Quot.sound`. Classical choice is used to select decompositions and is exposed rather than hidden.

## Three-lens review

| Lens | Verdict | Review SHA-256 |
|---|---|---|
| Proof-adversarial | GO-WITH-NOTES | `BD43DDC17D84E1A331588666128E5C6ABD7126853E180EB271BB459CC25043AE` |
| Complexity theory | GO-WITH-NOTES | `2A3FD8A21D85D5F3C49CD1489F773C835B07186FABAA830F8845A3D7ADF351A6` |
| Non-claims boundary | GO-WITH-NOTES | `B0AA5D76D8ACF851C71776A35DEE5336A53DF75312F4A79C08EA3A955DE63B26` |

All three lenses accept the theorem as the canonical generic gluing mechanism. Their notes agree that it supplies neither the two input functionals nor their compatibility, and that mathematical existence and uniqueness here do not provide a computable or polynomial-time construction.

## Claim boundary and next consumer

The defensible claim is:

> Lean verifies that two linear maps on submodules which agree on their intersection have a unique common linear extension to the submodule sum.

This does not establish an actual-source wrapper, the manuscript leaf domain or label type, label transport, representative independence, an actual star carrier or acceptance theorem, clique-resampling stationarity, soundness, a randomized polynomial-time reduction, hardness, publication readiness, or any conclusion about P versus NP.

The next exact consumer must specialize the theorem to the certified actual coordinate-space and equation-span maps, discharge the certified intersection-agreement premise, and expose restriction equations matching the forthcoming label definition. The remaining route is:

```text
generic unique gluing on a submodule sum                          [this increment]
  -> actual-source coordinate/equation-span gluing wrapper
  -> manuscript leaf-domain and label realization
  -> label transport, inverse/descent, representative independence
  -> actual star carrier and honest acceptance
  -> clique-resampling stationarity and completeness
  -> soundness, formula compilation, and randomized reduction
  -> fixed-parameter hardness, learning corollary, and reconciliation
```
