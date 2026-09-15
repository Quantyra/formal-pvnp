# Actual tagged base-projection transport closeout

Date: 2026-09-15. Disposition: **GO-WITH-NOTES**. This increment identifies the exact unconditioned base-score law of the full tagged ordered carrier and bounds its conditioned good-carrier counterpart. It does not assert that conditioning preserves a uniform base projection.

## Frozen sources

| Source | SHA-256 |
|---|---|
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualTaggedBaseProjectionTransport.lean` | `A90C2EFB35D40A278F80E873720B8C8181D2CC05F08EBB1A1AED8BBA2584A2E0` |
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualTaggedBaseProjectionTransportChecks.lean` | `795FF7E76726BAB026203245C4FA91272B3D7095D6F1C974F47D7BE7106184B4` |

The frozen module proves two public theorems:

- `actualTaggedUniformMean_baseProjection_eq`: if `0 < K`, the uniform mean of `g (baseProjection u)` over the full ordered tagged carrier is exactly the uniform mean of `g` over ordered base-row tuples. The proof uses the tagged-tuple product equivalence and cancels the common positive tag-space cardinality.
- `actualTaggedGoodMean_baseProjection_le_four_thirds`: if `4 <= T`, `0 < rowCount`, and `g` is nonnegative, the mean of `g (baseProjection u)` over good tagged tuples is at most `4/3` times its uniform ordered-base mean. This composes the certified conditioning inequality with the exact unconditioned identity.

The `0 < K` helper is substantive: it constructs an inhabitant of `Fin J -> Fin K`, proves the tag-function space has positive cardinality, and justifies cancellation. It also covers `J = 0`. The Checks module includes that empty-coordinate case and a stronger two-row, two-coordinate fixture with a nonconstant zero-one equality score. The latter proves both score branches and exercises the conditioned theorem without making the transported conclusion vacuous.

## Target-fresh certification

The canonical certification folder is `research/evidence/2026-09-15-actual-tagged-base-projection-transport-fresh-run`. The SHA-256 of `artifact-hashes.txt`, recorded by `artifact-hashes-manifest.sha256`, is `5651FFAA82FD899C148AF63228C1478EF176FDBC4DDA97EEAAA78650F4779D71`.

The isolated target was seeded from the certified conditioning-transport dependency tree while excluding the current main and Checks artifacts. Both reviewed objects were absent before compilation. Main and Checks were then compiled sequentially with Lean `4.34.0-rc2` and one Lean thread.

| Module | Exit | Object bytes | Object SHA-256 |
|---|---:|---:|---|
| `ActualTaggedBaseProjectionTransport` | 0 | 163,880 | `0C30FA64D1B31F490152AB13A824630B9E877E239578E976EA951409ABE9E379` |
| `ActualTaggedBaseProjectionTransportChecks` | 0 | 61,664 | `1D1FBD1606FB7DEAFA5CED671FB55C02582837BD5653DDA3BDC48D111953BD59` |

The source hashes remained stable throughout certification. The source scan found no `sorry`, `admit`, `native_decide`, or explicit source-level `axiom`. `#print axioms` reports only the standard `[propext, Classical.choice, Quot.sound]` profile. This receipt certifies target-fresh main-and-Checks compilation against immutable hashed dependencies; it is not a full transitive dependency rebuild from source.

## Three-lens review

| Lens | Verdict | Review SHA-256 |
|---|---|---|
| Proof-adversarial | GO-WITH-NOTES | `1E41B6B7828C37FA60DB34ADA62D6E2E5A7A3E1A700FE4DA42C9774EA45013FF` |
| Complexity theory | GO-WITH-NOTES | `E525A35BAFFDBA9D8A062A444E54A47B8FBF866740C7B2CF9FC172CCE47B6320` |
| Non-claims boundary | GO-WITH-NOTES | `6A311F2C0AF3713B3D0F828F6715437522FAC067B8E1C9EEE9202B61F8125636` |

All reviewers independently matched the frozen source hashes, the certification-manifest hash, and every manifest entry. They accepted the exact constant-fibre identity and the conditioned one-sided expectation domination. Their shared qualification is essential: good-tuple conditioning can bias the base projection because different base tuples can retain different numbers of tag assignments.

## Claim boundary and dependency consumer

The completed claim is: before conditioning, forgetting independent uniform copy tags preserves the uniform mean of every real score on ordered base-row tuples; after restricting to good tagged tuples, every nonnegative base score has mean at most `4/3` times its uniform ordered-base mean under the stated padding premises.

This does not prove exact uniformity after conditioning, ordered-to-subset transport, clique-resampling stationarity, an actual-source failure bound, actual-star acceptance, the positive-`tau` branch, the multi-block rejection union bound, an encoded randomized reduction, NP-hardness, the manuscript headline theorem, or either resolution of P versus NP.

The next consuming obligation is the concrete actual zero-one block-failure indicator and its theorem that the conditioned initial-block failure probability is at most `(4/3) * J * eta` in the YES case. That theorem must connect the semantic actual source assignment/value hypothesis to the ordered-row base score without adding independence. The subsequent force-bearing obligations are the concrete clique/star stationarity bridge and the rejection union bound across the original and resampled blocks.
