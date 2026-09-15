# Actual tagged failure transport closeout

Date: 2026-09-15. Disposition: **GO-WITH-NOTES**. This increment closes the actual-source-to-conditioned-one-block failure transport obligation. Under the explicit source-extension premise, Lean proves that one conditioned ordered tagged block fails with mean at most `(4 / 3) * J * eta`. It does not establish clique-resampling stationarity, the outer block union, actual-star acceptance, soundness, or the headline reduction.

## Frozen sources

| Source | SHA-256 |
|---|---|
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualTaggedFailureTransport.lean` | `F3455245210FF8FA22421FD2EE886FB730B3854284F253F4C1082DF0AFFDAC16` |
| `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualTaggedFailureTransportChecks.lean` | `E712882B84A5DF306EC95CD7212507F9D3B020609679F394AB417997FB448B69` |

The exact theorem chain is:

1. `actualTaggedFailureIndicator_eq_baseProjection` identifies failure of an ordered tagged block exactly with failure after projecting every tagged row to its base row.
2. `actualBaseFailureIndicator_nonneg` supplies the nonnegativity premise required by the previously certified conditioning transport.
3. `actualBaseFailureIndicator_le_sum` bounds the indicator of any failure in the block by the sum of its coordinate failure indicators.
4. `sum_eval_eq_card_pow_mul_sum` proves the constant-fibre counting identity for evaluation at one coordinate of the full ordered function space.
5. `actualBaseFailureIndicator_uniformMean_le` combines those facts into the finite union bound
   `uniformBaseMean(any queried row fails) <= J * violations(x) / card(I.RowId)`.
6. `actualSourceExtension_failureRate_le` uses the exact source-extension violation identity and the actual row-count lower bound to derive
   `violations(I.sourceExtension y) / card(I.RowId) <= eta`
   from `0 <= eta` and `I.sourceViolations y <= eta * m`.
7. `actualTaggedGoodFailureMean_sourceExtension_le` composes the tagged/base identity, the uniform ordered-base bound, the source-extension bridge, and the certified `4 / 3` conditioning inequality.

The final theorem has the force-bearing premises `4 <= T`, `0 < m`, `0 <= eta`, and

```text
(I.sourceViolations y : Real) <= eta * (m : Real).
```

Its conclusion is

```text
actualTaggedGoodMean I (actualPaddingCopies J T) J
  (actualTaggedFailureIndicator I (I.sourceExtension y))
    <= (4 : Real) / 3 * (J : Real) * eta.
```

Thus the canonical completed claim is:

> For the actual semantic occurrence-allocation source, an assignment violating at most an `eta` fraction relative to the original `m` source rows induces, after source extension, padding, and conditioning on a good ordered tagged `J`-tuple, a one-block failure mean at most `(4 / 3) J eta`.

This is an ordered tuple result with replacement. It uses a finite union bound and does not assume coordinate independence or uniformity of the conditioned base projection.

## Target-fresh certification

The canonical certification folder is `research/evidence/2026-09-15-actual-tagged-failure-transport-fresh-run`. The finalized SHA-256 of `artifact-hashes.txt`, recorded by `artifact-hashes-manifest.sha256`, is `4AEDC064895353B3ADF044A15F62F00F91346BBAF752774E9EC167FDCAB3F398`. All 25 manifest rows were independently rehashed successfully by the three reviewers.

An interim hash beginning `FFE4` was sampled while the certifier was still finalizing the receipt. That orchestration timing race was corrected before review. Every reviewer used the finalized `4AED...F398` manifest and found the current evidence internally consistent.

The isolated target was seeded from the previously certified base-projection-transport dependency tree while excluding the current main and Checks artifacts. Main and Checks were then compiled sequentially with Lean `4.34.0-rc2` and one Lean thread. This is target-fresh main-and-Checks certification against recorded immutable seeded dependencies; it is not a full source rebuild of every transitive dependency.

| Module | Exit | Object SHA-256 |
|---|---:|---|
| `ActualTaggedFailureTransport` | 0 | `C442B43E6F1523EE12CEA6709DA37CDCB48295C175CA6BEE9FA6E3556A1E7F81` |
| `ActualTaggedFailureTransportChecks` | 0 | `29AE123326A75ABCD57EF53415417053D11ED3B8D01D3D64C5317B30B51B0265` |

The source hashes were stable before and after compilation. The forbidden scan found no `sorry`, `admit`, `native_decide`, or explicit source-level `axiom`. The printed theorem profiles contain only the standard `propext`, `Classical.choice`, and `Quot.sound` axioms, with no project-specific axiom. Both modules exited successfully; reported diagnostics are style or linter warnings rather than proof failures.

## Checks and fixtures

The Checks module exposes both indicator definitions and all seven theorem signatures, and prints the axiom profile for every theorem. Its fixtures exercise the zero-coordinate branch, the indicator's zero and one values, and a nonvacuous `J = 1` uniform-bound branch.

The final theorem fixture uses `J = 0`, so that particular fixture is arithmetically vacuous. The indicator `0`/`1` fixtures and the positive-`J` uniform-bound fixture separately exercise the meaningful branches, while the frozen general theorem is kernel checked for arbitrary `J`. All three reviewers treated this as a fixture-strength note, not a mathematical gap in the proved theorem.

## Three-lens review

| Lens | Verdict | Review SHA-256 |
|---|---|---|
| Proof-adversarial | GO-WITH-NOTES | `CFD4416B3AE875346E31E0D67056F27D94E709E236ACABCF01621925FED25F70` |
| Complexity theory | GO-WITH-NOTES | `E54FD5D9690870D037135D804BBF18B141771F640DBDDA80C8EDBA7CD6B33D52` |
| Non-claims boundary | GO-WITH-NOTES | `F810BFAF2E170B739DAE65231116F9281E2BD5F3BC083F647E0DF95601A6FBA5` |

All lenses accepted the frozen one-block completeness bridge. Their notes agree that the source-error premise is assumed rather than produced, conditioning is represented by the exact finite good-set mean rather than an executable rejection sampler, and the theorem does not extend automatically to clique-resampled blocks.

## Claim boundary and next consumer

This increment does not prove sampler or clique stationarity, rejection-sampler realization or runtime, the `(m_star + 1)` outer failure union, `ActualStarCompletenessUnion`, actual-star acceptance, the final `tau / 75 < tau` arithmetic, source hardness, soundness, a polynomial-time randomized reduction, the manuscript headline theorem, a learning result, publication readiness, or any conclusion about P versus NP.

The next exact consumer is the sampler-stationarity bridge for the concrete clique-resampling kernel. Once each resampled block is proved to have the required good ordered tagged marginal, the one-block theorem can feed the rejection union and `ActualStarCompletenessUnion`. The remaining dependency path is:

```text
actual-source conditioned one-block failure transport  [this increment]
  -> exact clique sampler stationarity
  -> marginal transport to every resampled block
  -> rejection union / ActualStarCompletenessUnion
  -> actual-star honest-label acceptance
  -> quantitative parameter assembly
  -> source hardness and soundness bridges
  -> encoded polynomial-time randomized reduction
  -> headline theorem, learning corollary, and manuscript reconciliation
```
