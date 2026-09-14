# Gadget and regularized-source recovery bundle

This bundle preserves the successful repaired sources and the actual raw evidence that previously existed only under ignored .lake/build roots. It does not replace the old archival drafts, modify a live Lean source, or promote any diagnostic export into an accepted proof closure.

`manifest.json` records SHA256, byte length, original repository-relative path and bundle-relative path for every payload. Original JSON, logs, scripts, patches and source snapshots are copied verbatim, including their historical absolute paths and diagnostic flags. The manifest supplies the relocation map. No script is automatically runnable from this new location: its original build-root assumptions remain historical provenance.

Seven files in `sources/` preserve the four repaired Gadget mains, unchanged Gadget Checks, repaired RegularizedSource main and unchanged RegularizedSource Checks. `runs/` preserves the seven corresponding successful author attempts, plus the later fresh five-module verification session 23366. That fresh run's sources/logs/metadata remain distinct from author evidence; the differing Rows export hashes are not collapsed.

No .olean exports or recursive lower dependency cache are included. Their original output paths and hashes remain recorded. Existing lower receipts and historical failed runs remain outside this bundle; this is a source-and-own-evidence recovery archive, not a standalone toolchain or full offline replay package. The original ignored roots remain untouched. Folded verifier recovery is owned separately and is not included.

The accompanying dated three-lens/fresh-build notes retain their chronological limits. In particular older diagnostic-only records remain diagnostic-only even though a later fresh execution exists. Archiving them does not itself establish root acceptance, a whole regularized constructor theorem, upstream proof closure, or the full paper theorem.

The bundle-local .gitattributes disables text normalization to preserve original raw hashes across Git checkout. Raw run payloads are treated as binary diffs. Long historical filenames require Windows Git core.longpaths=true (the archive operation uses this setting per command, without changing repository configuration).
