#!/usr/bin/env bash
set -euo pipefail
root=/home/dfredriksen_quantyra_org/benchmark-src/certifications/realizable-hardness
cd "$root"
run=/home/dfredriksen_quantyra_org/benchmark-result
rm -rf "$run"
mkdir -p "$run/target/PvNP/RealizableHardness"
main=lean/PvNP/RealizableHardness/SubmoduleFunctionalGluing.lean
checks=lean/PvNP/RealizableHardness/SubmoduleFunctionalGluingChecks.lean
lean=/home/dfredriksen_quantyra_org/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean
pkg=.lake/packages
export LEAN_NUM_THREADS=1
export LEAN_PATH="$run/target:$pkg/mathlib/.lake/build/lib/lean:$pkg/complexitylib/.lake/build/lib/lean:$pkg/plausible/.lake/build/lib/lean:$pkg/LeanSearchClient/.lake/build/lib/lean:$pkg/importGraph/.lake/build/lib/lean:$pkg/proofwidgets/.lake/build/lib/lean:$pkg/aesop/.lake/build/lib/lean:$pkg/Qq/.lake/build/lib/lean:$pkg/batteries/.lake/build/lib/lean:/home/dfredriksen_quantyra_org/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/lib/lean"
sha256sum "$main" "$checks" >"$run/source-before.sha256"
/usr/bin/time -v -o "$run/main.time" "$lean" -R lean -o "$run/target/PvNP/RealizableHardness/SubmoduleFunctionalGluing.olean" "$main" >"$run/main.stdout" 2>"$run/main.stderr"
/usr/bin/time -v -o "$run/checks.time" "$lean" -R lean -o "$run/target/PvNP/RealizableHardness/SubmoduleFunctionalGluingChecks.olean" "$checks" >"$run/checks.stdout" 2>"$run/checks.stderr"
sha256sum "$main" "$checks" >"$run/source-after.sha256"
find "$run/target" -type f -print0 | sort -z | xargs -0 sha256sum >"$run/output-hashes.sha256"
"$lean" --version >"$run/toolchain.txt"
printf '%s\n' "$LEAN_PATH" >"$run/lean-path.txt"
uname -a >"$run/system.txt"
lscpu >>"$run/system.txt"
free -b >>"$run/system.txt"
printf '%s\n' '52324cc3f6f307332c5ceca07668eb8c18e379c1' >"$run/git-commit.txt"
