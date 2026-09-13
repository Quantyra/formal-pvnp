# Realizable-hardness companion: independent proof review

2026-09-12; S3137 / S3126; AI proof-adversarial reviewer and independent build verifier.

**GO-WITH-NOTES for the finite integration increment.** No blocking vacuity,
hypothesis weakening, statement substitution or axiom leakage was found. This
verdict does not certify the full randomized hardness theorem or learning corollary.

## Exact scope and provenance

Candidate `6d7718919d681f57e28559bd0ee584c450cb2446`, exactly the 33
`source-map.json` entries and the original `lean/PvNP.lean` aggregate with
35 imports (33 mapped modules and two foundation modules). Unmapped
RandomizedReduction drafts and root Lean 4.13 geometry sources are excluded.
Destination worktree was clean before review; no source/config/map/README
file was changed. No destination AGENTS.md exists. Read the companion README,
source map, author build evidence, full dependency assessment, planning protocol
and formal three-lens protocol.

All 33 source Git blobs were independently recovered at their per-entry pins,
SHA256 checked, and reconstructed through ordered map transforms. Each literal
replacement was required to have exactly one occurrence. Reconstructed bytes
matched current mirrors and map hashes. The final map hash is
`b60506d4a969d19e9f3d87615a1fd09274b6a07f9459381b657b9c2b8d93f297`.
All eleven dependency HEADs match the manifest; its SHA256 is
`825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0`.
Forty-four named author log blocks also match their raw log hashes and text
(after CRLF normalization); prior failed author attempts remain failures.

## Proof-adversarial findings

- All compatibility diffs were inspected against original Git source. No theorem
  hypothesis or conclusion changed. The sole declaration-type textual change is
  qualification of relocated `Basis` as `Module.Basis`; the defining forms still
  use the complete annihilator basis. Other changes are relocated imports,
  renamed arithmetic/log APIs with corrected iff direction, default-transparency
  `convert!`, explicit goal alignment, Boolean case splitting, or removal of
  tactics after the goal has already closed. No retained elaboration option
  changes kernel trust.
- Exception repair uses a fresh coordinate for every indexed formula and
  constructs the satisfying witness by negating its failed indices. The output
  constructor does not depend on a witness. The NO proof applies its explicit
  source promise after establishing the old weight budget, and the floor loss
  is retained. Empty-index algebraic identities are distinguished from normalized
  probabilities, whose required nonemptiness/normalization hypotheses remain.
- Upward rounding retains positive common denominators, clips the budget, and
  proves the actual half-gap budget inclusion. Pipeline Parameters carry validity
  conditions, not both YES and NO promises. Their implications are separate;
  concrete valid YES and NO examples show the pipeline is not universally vacuous.
- Sampling uses actual cumulative rational cuts, finite seed fibres and product
  probabilities, including zero-mass atoms, duplicate draws and nonrectangular
  events. Bernoulli curvature gives both tails; the assignment union is over
  exactly all `2^N` assignments. Positive sample counts justify division. The
  strict good-event complement and epsilon/8 approximation losses align with
  epsilon/4; logarithmic thresholds and the conservative integer count give the
  stated 2/3 and 5/6 guarantees for the actual formula output.
- Seed flattening is an actual row-major equivalence. Prefix fibre cardinality
  proves padding invariance, including empty prefixes/widths. It does not prove
  Turing-machine runtime or polynomial input-length bounds.
- Posterior normalization requires positive marginal. Null-marginal algebraic
  identities never assert a normalized conditional law there. Normalized
  reweighting retains the likelihood-stability, bad-mass, and small-error inputs,
  including the necessary division by p0. This is a generic finite lemma.
- Restriction rank uses the concrete independent triple law and a union over
  nonzero row combinations. Arbitrary-subspace representation proves both full
  rank and exact common kernel from the whole annihilator. Its conclusion is
  the numeric codimension of the actual intersection with the retained subspace.
  W is fixed before the draw; no adaptive-W or posterior-independence inference
  is supplied. Zero codimension and a genuine coordinate hyperplane are checked.

## Independent kernel execution

All 33 modules and the original aggregate independently exported with exit 0,
serially in session 36677. Lean reports 4.34.0-rc2, compiler commit
`6a10ac8c22beadecabdbb0919c2b50214762f91d`.
The launch command from the companion directory was:

```powershell
$env:LEAN_NUM_THREADS='1'
$env:PYTHONUTF8='1'
$env:PYTHONIOENCODING='utf-8'
elan run leanprover/lean4:v4.34.0-rc2 lake --no-cache env python $env:TEMP/S3137-independent-review.py
```

The durable JSON below includes the exact executed runner and per-module commands.
It sets LEAN_PATH to the isolated review output directory first, **removes the
author companion output directory**, and keeps only the pinned dependency/core
paths supplied by Lake. Modules are topologically ordered. Each command is
`lean -o <isolated-output.olean> <absolute-frozen-source.lean>`; successful
subsequent imports therefore consume reviewed companion reexports. No root
4.13 artifacts, cache downloads or broad Lake/native rebuild were used.
The runner checks free C space before each module and every ten seconds while
running; its 640 MiB emergency stop did not fire. Raw stdout/stderr is saved
before result printing, with an actual exit code and SHA256 for source, output
and log. No independent failed attempt or source repair occurred.

There are **298 actual axiom profiles**, matching the 298 source queries. Every
profile uses only a subset of `propext`, `Classical.choice`, `Quot.sound`.
The exact finite examples and five #eval outputs also compiled: count
512/2048/1 and the two expected Boolean lists. A nested-comment/string-aware
scan of exactly 33 mapped sources found no sorry, admit, sorryAx, native_decide,
axiom or unsafe tokens. This scan supplements kernel evidence; it does not
replace it. Foundation artifacts were reused at the audited same-version pins,
not independently rebuilt transitively in this review.

## Notes and remaining obligations

The aggregate's historical `UNCOMPILED` comment is stale and should be corrected
when review status is integrated; it does not affect the imported statements.
Harmless unused-tactic/import/simp warnings were retained rather than changing
frozen source. Standard axiom profiles are not proofs that all hypotheses of
the full hardness result have been discharged.

The full dependency ledger still controls: actual encoded randomized polynomial
reduction and composition, specialized PCP/Grassmann/covering/decoder proofs,
learning transfer, fixed-L asymptotics, and final Main/Audit are outstanding.
The paper must reconcile against those final theorems before full certification
or announcement. This review makes no novelty, P-versus-NP resolution, new
publication or human peer-review claim. Other two review lenses are recorded
separately by the orchestrator.

## Export evidence

| Module | Exit | Axiom profiles | Log SHA256 |
|---|---:|---:|---|
| BernoulliMGF | 0 | 0 | `2c10f123df6b6385935dd8a8d7cf0c146cc33b50bc8a488c61440981336cd85b` |
| BernoulliMGFChecks | 0 | 13 | `e7d8b8191ed6e7c53225f79b1bd7b5f6ec523752fee7afae2e5d6937e65440c0` |
| ExceptionRepair | 0 | 2 | `24ff45c751cfdd70da3378adb568838dbd161e7460a860f7cae3a8823c926f0e` |
| Formula | 0 | 3 | `24ebceed43492322a68afdddf57d485fd11af48f17a0a40603920083d96eed49` |
| Checks | 0 | 13 | `f0ba50a8aaa936e7421df2d7b953a46ac09fe61cebc2d2957e0c4da8a710361c` |
| SamplingThreshold | 0 | 0 | `80672e77c22dbb0db5ef813c829267aed716523f1018897b88947502221fb13f` |
| ComputableSampleCount | 0 | 0 | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| ComputableSampleCountChecks | 0 | 17 | `956732bce88c55e9ce9adb815932b0ea2cd48f15d61e6c7c44464539c165aa20` |
| WeightRounding | 0 | 0 | `587c7bac3e73c8466435e72e1f5ee1f23cee6393a7b5705329d5d411b2a5e3cb` |
| FiniteSampling | 0 | 0 | `30075fb63053c44748123548dee17e0dec628308d8ca132a72558fa1c86907e6` |
| FiniteConcentration | 0 | 0 | `2e4e64fe0f8bf731fae85008d5bb13b7194b08ba2bd7ae49b945d70070aac783` |
| FiniteConcentrationChecks | 0 | 24 | `a2f54ee6909f505b987e5aad10c559a86da9ea1b2edcb35cf33f711e439ba37b` |
| FiniteRepairRoundingPipeline | 0 | 0 | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| FiniteRepairRoundingPipelineChecks | 0 | 18 | `962582be68cb8d14809fab782c11adf65644ea0cdfde3f3678ea27489d7eef34` |
| FiniteSamplingChecks | 0 | 19 | `55b965c15c962970e20341935a9613973eb6be33c620f128ab66e01f52f8503a` |
| InverseCDFSampler | 0 | 0 | `5495d063c04b9eb7ff4be410e1b26bcd02dc29b672ac4393eda4dc031193962f` |
| InverseCDFSamplerChecks | 0 | 18 | `d010c0ed1dbdb63a28cf33f866aafe3fec80dde982c4b5a73bf85e3c41e0e0d7` |
| JointSamplingLaw | 0 | 0 | `bd64287640dfe37b157497d7b240d60bda6526c04c62d794e55a0386407ec732` |
| JointSamplingLawChecks | 0 | 11 | `1b84a9aa2ebdb43b92704531f25448e6bb196bd154cde84f28352fa9a6e50ba2` |
| PosteriorReweighting | 0 | 0 | `3a57abef70ffd9d42db165b23fcf06e16a231ef5c8b8df227e5b06f8f4567bbc` |
| PosteriorReweightingChecks | 0 | 13 | `800519f4e29d917ad25a520152dff78ab317c96ff2291ae09fb06bfb5d6dacb6` |
| SamplingGuarantee | 0 | 0 | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| SamplingFormulaPromises | 0 | 0 | `ba67b807dda2671956e5a90c4cb8c34105ff3e2f91ef7cfdb87e4b88c5c635f2` |
| SamplingFormulaPromisesChecks | 0 | 15 | `ac4b8d750298cd770f68aa3ef08debdb14538fee909ffb05a2f9805e51891fbe` |
| SamplingGuaranteeChecks | 0 | 18 | `5c32317c42b9ff60d887f30abd791af07f04d5cb3664e9a2736bed1df02b8492` |
| SamplingThresholdChecks | 0 | 29 | `0c9848f808d33a2420370cd8ded411ab8d635ba54abd541d966bea60346374ec` |
| SeedEncoding | 0 | 0 | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |
| SeedEncodingChecks | 0 | 25 | `5e325cc1dd082346d3a18e54d7a9c94295e90fc51fff29eef731215e4649d6e9` |
| TripleRestrictionRank | 0 | 0 | `a779a1ddcb4db6d4ed1ebe4b2954953bba97c14eec569781d842e9f8c01bd51c` |
| SubspaceRestriction | 0 | 0 | `d135beadda412a96ff33cba078a59f0af18fa448534c3a93f05bd5f6ef255bd1` |
| SubspaceRestrictionChecks | 0 | 13 | `137646a0a7346a5da3617772eb6911f2b11cda10cdad1e7977494d0140439775` |
| TripleRestrictionRankChecks | 0 | 22 | `986f39e48f7542cca883ac56566453e4d9de4ae4e3500c959d1687d074111896` |
| WeightRoundingChecks | 0 | 25 | `3a72db83e4a58640d96975a362c18134ef7fabb6c09091c01361f2fba6e76273` |
| PvNP | 0 | 0 | `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855` |

Complete exact commands, raw logs, output/source hashes, query profiles and runner: [2026-09-12-realizable-hardness-companion-proof-verification.json](2026-09-12-realizable-hardness-companion-proof-verification.json). Receipt SHA256 `bbb5ca413cbeb1d691e8b4291aa640512a722615a8512b8de4f62b3b999f59c4`.
