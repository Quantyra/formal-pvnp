# Certification closeout

Result: **PASS**. Commit `8c2797867e81bd4f69c35893e3574a3f042d1132` was certified through an exact content-addressed Git-bundle gate and a target-fresh cloud build.

This supersedes the relation-laws receipt at `6da7f1ce41535cceea462bd4c756dbf08f84034d` for two defects: the empty-fixture inverse coverage gap (repaired in Checks source `55301CD33DFCE8764A7E65564995A0E2DBC17E280558AFF5DE80FF11395C7F46`) and the stale pre-compilation `transfer-gate.log` that recorded sibling commit `bba6dbb`. The increment-scoped gate log in this directory records bundle SHA `E9357667F5A2382B9DA2A5DB3DE2A9DA46955BA039E2C7B6A8C6244781D5780E`, detached HEAD `8c27978`, a clean checkout, and all four frozen source hashes before Lean ran.

Frozen hashes:

- Relation-laws main `ActualLeafRelationLaws.lean`: `87BE216E92B19AD2044BF5DB1551A3D36BE3993ABBD456FDCF16FA379274610C`
- Relation-laws Checks `ActualLeafRelationLawsChecks.lean`: `55301CD33DFCE8764A7E65564995A0E2DBC17E280558AFF5DE80FF11395C7F46`
- Coherence main `ActualLeafTransportCoherence.lean`: `109346364F8886DA18F31EFD170F8D991AEF21ECD92D591408766815E1F7EF5F`
- Coherence Checks `ActualLeafTransportCoherenceChecks.lean`: `A68C99D77565BBE9468F412891DFB95EF0BF97C1D8A9282596317800D18079BD`

All 25 stages exited 0. Relation-laws main and Checks were compiled twice with identical object hashes; coherence main and Checks were compiled twice with identical object hashes. Fresh object hashes:

- `ActualLeafRelationLaws.olean`: `2AD7B111371F0523DD0AC037F519919A4224F5317EDCE980CF380A6D214C3F13`
- `ActualLeafRelationLawsChecks.olean`: `EDB86FCD8906B7296900346248C2CA564C5DC27CEB937293AC38C9B48C2A0357`
- `ActualLeafTransportCoherence.olean`: `2BD63A04269AF7CD0449978C5818207E95698DCC6A1714362629E0581965FCD8`
- `ActualLeafTransportCoherenceChecks.olean`: `609CC944485484BE49FE31C5E85E3B16341897342DC48258A1021E47B3671D5C`

The returned archive SHA was `F020AF27BAF5613762C86EACDE0F15D1D94BB191D52C9843FD7B532A2B17A4AC`. The artifact manifest was `7F0CF58791F54838615C386CD1EF23286DBF2C30CF76D4C5D34BFA7451366352` with 176 rows and zero rehash mismatches. Printed axiom profiles contain only `propext`, `Classical.choice`, and `Quot.sound`. Forbidden-token scan of comment-stripped main and Checks sources was clean.

The VM was stopped at `2026-09-15T18:35:39.439-07:00` and is `TERMINATED`. Its interface has no external IP. Estimated increment was `$0.1361979513488889`; cumulative estimated GCP spend is `$0.6511686334698888`, leaving `$249.3488313665301` under the hard ceiling. The stopped 200 GiB disk continues to accrue storage cost.

This receipt does not supply the independent proof-adversarial, complexity-theory, or non-claims-boundary verdicts and does not claim the manuscript theorem is complete.
