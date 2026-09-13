# Independent adversarial proof review: matrix/Grassmann identity

Reviewer: `/root/matrix_identity_independent_proof`, independent of the authors.
Scope: S3134/S3126, eight Incidence, Moment, Fibre, Identity main/Checks modules.
Verdict: **GO-WITH-NOTES for this bounded eight-module increment**. Source review found no mathematical or statement blocker. This is not acceptance of the full hardness theorem.

## Frozen-source audit

Incidence/Moment are reviewed against `4673d9be00eccae5adafe90139aa50c2a95cba9f`; Fibre/Identity against `1e6a5bf82f3ba2fbc6454ae3a5b6d8f8dbc4f537`. The associated verification-plan JSON records each raw working hash and Git blob hash. Both Identity files have CRLF working bytes versus LF Git bytes; normalized equality was checked, and raw equality is explicitly false. The other six are raw-identical.

All eight files were read, including every Checks example. Source headers still say uncompiled/source-only; these are stale author-era comments and must eventually be reconciled with actual review evidence. They do not change theorem statements.

## Mathematical assessment

- Incidence counts extensions of a fixed actual frame, not an averaged or postulated anchor. Each next column is outside its preceding span. The dependent continuation type has an explicit column-list bijection, preserving order and avoiding extra proof multiplicity. Its cardinality is the successive product of ambient cardinality minus span cardinality.
- Moment identifies lists with actual finite column arrays. Concatenation is `Sum.elim M B`; the span and linear-independence theorem refer to these columns. Its unconditional denominator is all extension arrays, preserving the probability of rank failure.
- Fibre proves the missing reverse implication: full concatenated rank implies sequential extension validity. The reanchor equivalence moves the first extension column into the last anchor position with explicit old/new/tail index identities. Internal arrays in a containing subspace lift into the ambient span fibre, and ambient fibre arrays restrict back column by column. Equality of span follows from inclusion and equal finite rank. The two maps are inverse on actual payloads, yielding constant fibre size without a coupling premise.
- Identity transports containing-frame spaces to subspaces above the actual base span. It proves their cardinality positive under `d+w <= finrank V`, so normalization never silently divides by an empty space in the headline theorem. The conditional extension law follows from these counts. Base-frame averaging uses the earlier accepted Grassmann frame-count identity.
- `grassmannExperiment` explicitly averages over a uniformly selected base subspace and all functions from `Fin t` into its containing spaces. `matrixExperiment` explicitly averages over raw base arrays and all extension-array tuples. `iid_mean_power` is the finite product-sum identity, not an independence assumption about an external sampler. These are exact finite probability laws; they are not executable polynomial-time samplers.
- The scalar alpha is derived as the probability of the actual joint rank event. The main result is `matrixMoment = alpha * grassmannExperiment`, with the raw experiment separately proved equal to the moment. No arbitrary alpha, assumed moment identity, decoder, or external coupling certificate appears in the theorem hypotheses.
- The loss bound applies the elementary product union bound and `1-p^t <= t(1-p)`. Every rank-failure term is at most `2^(d+w-1)/2^n`; there are `d+t*w` such contributions. The sufficient one-half inequality remains an explicit hypothesis of the factor-two theorem. This increment does not prove the paper's later parameter choice satisfies it.

## Edge cases and scope

The bound `d+w <= n` is essential for positive factors and actual containing spaces; results are not asserted as normalized Grassmann probabilities outside it. Zero extension width produces one empty extension and extension factor one. Zero base width has the unique empty independent base. Zero ambient dimension forces both widths zero. Zero total dimension has a separate factor-two theorem without a positive-dimension assumption. Zero copies use the empty product and retain the base-rank indicator: a deficient base contributes zero even when its extension mean is raised to power zero. The rank event explicitly includes base independence as a conjunct, so it does not become vacuous at `t=0`. All-zero and all-one indicator behavior is consistent with the exact sums; all-one Grassmann mass is proved one under the dimension bound.

No blocker was found in the statements or proof structure. No claim is made here about MZ parameter integrality, hypercontractive decoding, source-PCP hardness, polynomial runtime, full NP-hardness, learning transfer, novelty, or P versus NP.

## Independent verification preparation

Prepared a fresh isolated output root `certifications/realizable-hardness/.lake/build/matrix-identity-independent-review-20260913`. Exactly 77 original accepted dependency exports were copied from their recorded original locations and their hashes rechecked. Provenance comes from the accepted joint-vector verification receipt with SHA256 `4d9d4e59272cee51d790f87d642006c8012c1817d0a1cae97bd80b15a3b2b78e`: its 73 original dependency records plus its four independently compiled exports. No author matrix export is used as an accepted dependency.

The prepared runner will compile all eight modules in dependency order, with a fresh-output assertion, pinned manifest and eleven package commits, pinned Lean executable version, source-hash preflight, dependency rechecks, one thread, 768 MiB physical-memory preflight and 640 MiB owned-child stop. It writes raw logs and actual terminal exit metadata before displaying UTF-8 logs, and stops on compilation failure or a changed source. Expected Checks coverage is 77 selected axiom queries and 29 examples. These are expected counts, not results.

**No compiler process was launched.** Root must grant the exclusive compiler slot after its current owner releases it. Actual exports, terminal metadata, complete profile results and source stability remain required before changing this verdict.

## Independent compilation completed

After root granted the exclusive compiler slot, session 69402 compiled all eight modules with actual EXIT 0, then the runner returned terminal EXIT 0. The compiler slot was immediately released. All source hashes remained unchanged. All 77 emitted axiom profiles were parsed from the raw logs and are subsets of propext, Classical.choice and Quot.sound; all 29 source examples were included in successful Checks exports. All eight metadata/log/output triples were rehashed, and the 77 original dependency sources and copies rechecked after the run. The verification JSON records commands, terminal codes, memory measurements, pins, separate frozen/working hashes and artifact hashes. No source edits, retry builds, or Git mutations occurred. The preceding preparation section is historical; its pending-build status is superseded by this result.
