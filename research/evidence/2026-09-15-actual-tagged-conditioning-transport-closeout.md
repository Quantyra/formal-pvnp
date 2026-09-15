# Actual tagged conditioning transport closeout

Date: 2026-09-15. Disposition: **GO-WITH-NOTES**. This increment formalizes the finite conditioning calculation on the actual tagged ordered-question carrier. It proves that conditioning any nonnegative real score on the good-question set costs at most `4/3`, and therefore at most `2`. It does not identify a manuscript failure score, transport the law to unordered questions, or construct the actual star.

## Frozen sources

| Source | SHA-256 |
|---|---|
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualTaggedConditioningTransport.lean` | `4C4D97A764ADD32F54806830B42460169DBFF69A5FFBCD3D5AD5E2DECE06C284` |
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualTaggedConditioningTransportChecks.lean` | `1ECD3F99C5E3C31B9910588ADC344B2FC0570B2815DE14628223C0A1DD0AF61E` |

The module defines the uniform full-space mean and the uniform good-set mean on

```text
Fin J -> Fin K x I.RowId
```

and proves three public theorems:

- `actualTaggedGoodMean_eq_gatedUniformMean_div_goodMass`, the exact finite quotient identity;
- `actualTaggedGoodMean_le_four_thirds_mul_uniformMean_of_nonneg`, the `4/3` upper bound for every pointwise nonnegative real score; and
- `actualTaggedGoodMean_le_two_mul_uniformMean_of_nonneg`, the manuscript-facing factor-two corollary.

Checks exposes both definitions and all three theorems, prints their axiom profiles, tests zero and one scores at `J = 0`, and exercises a nonconstant nonnegative equality-indicator score at `J = 2`, `T = 4`.

## Fresh certification

The canonical certification folder is `research/evidence/2026-09-15-actual-tagged-conditioning-transport-fresh-run`. The SHA-256 of `artifact-hashes.txt` recorded by `artifact-hashes-manifest.sha256` is `8AB7CDBE388B62A358EF06AD052FEE35CA98B6E8EA539145A7938DD03F4D9BD9`. The dependency seed manifest SHA-256 is `28CCD2CAC37CF99A109375A95D0ACB1DADCA4ED1E6429BDF59A17758C1B4BD93`.

The isolated target was seeded from the certified retained-mass target while excluding the conditioning-transport main and Checks artifacts. Both excluded objects were absent before compilation. Main was compiled before Checks using direct `lean.exe`, Lean `4.34.0-rc2`, and one Lean thread. This is a target-fresh main-and-Checks build against a copied and hashed dependency tree; it is not a full source rebuild of every transitive dependency.

| Module | Exit | Object SHA-256 |
|---|---:|---|
| `ActualTaggedConditioningTransport` | 0 | `78082F14478AE65D23D22A99877EABD6EC1F9BB23C569373F41D7FF2A252E26C` |
| `ActualTaggedConditioningTransportChecks` | 0 | `72AF400B84A10F7E230DED81F53F46E89D79840F57CCFD8E212E179D50746243` |

The source hashes were stable before, between, and after compilation. The source scan found no `sorry`, `admit`, `native_decide`, or explicit source-level `axiom`. The five printed axiom profiles contain only `[propext, Classical.choice, Quot.sound]`; no project-specific axiom was introduced.

## Three-lens review

| Lens | Verdict | Review SHA-256 |
|---|---|---|
| Proof-adversarial | GO-WITH-NOTES | `354CACA0EC34F296CFF2A84BA2D1D57778B9FC4375AF39CFA3F4C5CA539306DC` |
| Complexity theory | GO-WITH-NOTES | `2F73A8C0936AF1B97514FA1F4DC4C641EF2C4869570B8CB8CDAF809C6B0E99F5` |
| Non-claims boundary | GO-WITH-NOTES | `4CBB7D319F58EB25E6962E6A928CF06BA2160496E13161DB7FA63B58C4DF5CDE` |

All reviewers independently matched the frozen source hashes, certification manifest, and target-fresh object hashes. They accepted the exact quotient identity and both inequalities while preserving the distinction between a score bound on ordered tagged tuples and a distributional transport theorem.

## Claim boundary and next consumers

This closes the conditioning-multiplier obligation for nonnegative real scores on the semantic actual-source space of ordered independently tagged row tuples, under `4 <= T` and `0 < m`. For indicator scores it supplies the standard conditional-event inequality. The direct next consumer is the exact `baseProjection` score inequality: identify the unconditioned tagged mean of a base-dependent score with its intended base-space mean and apply the certified conditioning bound without asserting that the conditioned base projection is uniform.

After that score bridge, the route requires ordered-to-subset transport with permutation invariance and exact `J!` fibres. The concrete equivalence-class clique-resampling kernel and actual-star marginal remain structurally missing. Further open obligations include the positive-`tau` copy-count choice proving the `tau/100` branch, concrete star failure scores and their source-error expectations, the `(m+1)J` union bound and final arithmetic, actual-star acceptance, the encoded polynomial-time source and sampler, randomized-reduction assembly, the headline hardness theorem, the learning corollary, and manuscript reconciliation.

This increment does not prove conditioned base uniformity, uniformity on legitimate unordered subsets, clique stationarity, actual-star acceptance, the source producer, the randomized reduction, NP-hardness of the manuscript target, manuscript correctness, novelty, publication readiness, `P = NP`, or `P != NP`.
