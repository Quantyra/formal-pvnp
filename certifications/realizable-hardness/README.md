# Realizable hardness companion package

**PARTIALLY COMPILED. Independent companion port reviews remain pending.**
Twenty-nine of 33 modules passed author exports: BernoulliMGF and its Checks,
ExceptionRepair, Formula and Checks, SamplingThreshold and its Checks,
ComputableSampleCount and its Checks, WeightRounding and its Checks,
FiniteSampling and its Checks, FiniteConcentration and its Checks,
FiniteRepairRoundingPipeline and its Checks, InverseCDFSampler and its Checks,
JointSamplingLaw and its Checks, PosteriorReweighting and its Checks,
SamplingGuarantee and its Checks, SamplingFormulaPromises and its Checks,
SeedEncoding and its Checks. The Checks groups printed
13, 13, 29, 17, 25, 19, 24, 18, 18, 11, 13, 18, 15 and 25 standard-only axiom profiles respectively;
count evaluation printed
512, 2048 and 1.
Other modules remain pending unless explicitly
recorded in `build-evidence.md`; successful source ports do not certify the whole graph.
The full randomized NP-hardness theorem and learning corollary are absent.
This package prepares their eventual single-kernel assembly; its current
aggregate imports the candidate foundation headlines and finite proof components.

Run future package operations from this directory, not the repository root.
The root Lean 4.13 umbrella remains separate. This package pins Lean
4.34.0-rc2 and the candidate complexitylib, mathlib and cslib revisions in
`lakefile.toml`. The isolated foundation audit passed its exact targets and
axiom checks (125d0eb); this does not adopt or verify the companion graph.
Dependency resolution completed successfully; `lake-manifest.json` records
the eleven resolved package revisions, each checked against its actual checkout
HEAD and the audited foundation pins. Dependency source clones are local build
state, not committed sources. No build caches or companion proof artifacts were
downloaded or produced by this resolution.

`source-map.json` records the source commit, original Git LF and working-byte
hashes, mirrored hashes and every import-path patch for all 33 mirrored files.
Its ordered `transforms` field is the complete byte-reconstruction recipe:
CRLF normalization, any explicitly listed UTF-8 BOM removal, and listed UTF-8
literal import and proof-tactic replacements. Historical BOM provenance was corrected in
e10ca87; current per-entry transforms describe the selected source bytes.
The companion aggregate `lean/PvNP.lean` explicitly imports every mirrored
main and Checks file. Original verification status does not transfer to this
package. Recompile and audit all reused source against the selected toolchain;
never reuse root 4.13 oleans or add its build directory to the search path.

The two PosteriorReweighting files are explicitly synchronized from accepted
bounded source f6126f7213c91741932be465e8041f26e7e8427f, reviewed in
2b2ccf7145e17085225bfc601b981c0db87ff694. SeedEncoding is synchronized from
accepted bounded source e629518767cf00e54462abb2c1c7329ecd679187, reviewed in
a20160f382f54ba8b18902be7aeaf05736f8cd0e. TripleRestrictionRank is synchronized
from accepted bounded source 4021e7cdff5e41152c07000a3e2e0135c2e181d0,
reviewed in 20039749e65dcb0eb719fed130aa9860bce855ea.
SubspaceRestriction is added from accepted bounded source
f7dcf6730ade00f2d9187d5db7c220d88b9b0ae4, with three independent
GO-WITH-NOTES reviews integrated in cc8c972300a29736ddc2cab715071bfe3b2fb392.
SeedEncoding's split Mathlib import is mapped to
Mathlib.Logic.Equiv.Fin.Basic, inspected in the pinned source only.
SubspaceRestriction's direct Mathlib imports exist at the pinned revision and
needed no path patches; that source inspection is not a compilation result.
The other 27 mirrors remain frozen at their recorded pins in this synchronization.
The map's per-entry source_commit is authoritative;
initial_source_commit describes only the original mirror baseline. None of
these source synchronization changes supplies companion kernel evidence.

Resolution evidence: session 6318 returned exit 0 for
`elan run leanprover/lean4:v4.34.0-rc2 lake --no-cache update`, with
`LEAN_NUM_THREADS=1` and `MATHLIB_NO_CACHE_ON_UPDATE=1`. The latter disabled
mathlib's automatic cache-get action in its post-update hook. Actual Lake parsed
the TOML; the toolchain remained unchanged. Manifest SHA256:
`825d2e1a20005a259fdf5b181528b391dd6ba18a52c86127caf4c3be990e04f0`.
All 33 mirror hashes were rechecked after resolution. This is dependency and
configuration evidence only, not proof compilation or foundation adoption.

After a separate compiler/capacity grant, test scoped imports and repair API
incompatibilities without
weakening statements, then build all main and Checks modules and inspect
actual axiom profiles. Material proof changes require independent proof,
complexity and non-claims reviews. Successful dependency resolution is not a
proof build result.

Subsequent accepted ports become this integration package's canonical sources.
Any later root fixes must be explicitly ported, mapped and rechecked; do not
silently overwrite modified mirrors. The full dependency ledger remains
controlling: machine encodings/runtime, bounded-coin randomized composition,
specialized PCP/geometry/decoding, learning transfer and fixed-L parameter
assembly must still be proved here before final certification.
