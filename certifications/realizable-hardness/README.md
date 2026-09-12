# Realizable hardness companion package

**UNCOMPILED. All companion Lean files are unverified on this toolchain.**
The full randomized NP-hardness theorem and learning corollary are absent.
This package prepares their eventual single-kernel assembly; its current
aggregate imports the candidate foundation headlines and finite proof components.

Run future package operations from this directory, not the repository root.
The root Lean 4.13 umbrella remains separate. This package pins Lean
4.34.0-rc2 and the candidate complexitylib, mathlib and cslib revisions in
`lakefile.toml`. The isolated foundation audit passed its exact targets and
axiom checks (125d0eb); this does not adopt or verify the companion graph.
Dependency resolution and creation of a verified manifest are
pending; no dependencies, caches or compiled artifacts are included here.

`source-map.json` records the source commit, original Git LF and working-byte
hashes, mirrored hashes and every import-path patch for all 31 mirrored files.
Its ordered `transforms` field is the complete byte-reconstruction recipe:
CRLF normalization, any explicitly listed UTF-8 BOM removal, and listed UTF-8
literal import replacements. Historical BOM provenance was corrected in
e10ca87; current per-entry transforms describe the selected source bytes.
The companion aggregate `lean/PvNP.lean` explicitly imports every mirrored
main and Checks file. Original verification status does not transfer to this
package. Recompile and audit all reused source against the selected toolchain;
never reuse root 4.13 oleans or add its build directory to the search path.

The two PosteriorReweighting files are explicitly synchronized from accepted
bounded source f6126f7213c91741932be465e8041f26e7e8427f, reviewed in
2b2ccf7145e17085225bfc601b981c0db87ff694. The two SeedEncoding files come from
UNCOMPILED root draft 2ecc1f668a6cf22336cd9d19f159e4ec49bb2a84 and are not
accepted proofs. SeedEncoding's split Mathlib import is mapped to
Mathlib.Logic.Equiv.Fin.Basic, inspected in the pinned source only.
The other 27 mirrors, including the triple-restriction draft, remain frozen at
their recorded pins. The map's per-entry source_commit is authoritative;
initial_source_commit describes only the original mirror baseline. None of
these source synchronization changes supplies companion kernel evidence.

After the foundation audit and compiler/capacity handoff, resolve the pinned
dependencies, verify actual revisions and commit the resulting manifest.
Test package loading and scoped imports, repair API incompatibilities without
weakening statements, then build all main and Checks modules and inspect
actual axiom profiles. Material proof changes require independent proof,
complexity and non-claims reviews. Source-level TOML inspection is not a Lake
parse or a build result.

Subsequent accepted ports become this integration package's canonical sources.
Any later root fixes must be explicitly ported, mapped and rechecked; do not
silently overwrite modified mirrors. The full dependency ledger remains
controlling: machine encodings/runtime, bounded-coin randomized composition,
specialized PCP/geometry/decoding, learning transfer and fixed-L parameter
assembly must still be proved here before final certification.
