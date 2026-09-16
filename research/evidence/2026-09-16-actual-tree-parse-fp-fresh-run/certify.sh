#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
REPO="$HOME_ROOT/tree-parse-fp-52b57f2-src"
PROJECT="$REPO/certifications/realizable-hardness"
SOURCE_ROOT="$PROJECT/lean"
PACKAGES="$HOME_ROOT/benchmark-src/certifications/realizable-hardness/.lake/packages"
LEAN="$HOME_ROOT/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean"
TOOLCHAIN_LIB="$HOME_ROOT/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/lib/lean"
RUN="$HOME_ROOT/tree-parse-fp-52b57f2-certification"
TARGET_ROOT="$HOME_ROOT/tree-parse-fp-52b57f2-fresh-target"
TARGET="$TARGET_ROOT/lib/lean"
GATE_LOG="$HOME_ROOT/tree-parse-fp-52b57f2-gate.log"
EXPECTED_HEAD=52b57f29cd7d317bfa77a6d046f58ce3d44633a7
EXPECTED_MAIN=563831C5485F44DE298A0E896BD6A9843F5B338F8CDA428F15DFBFB9EB057074
EXPECTED_CHECKS=B9DA8EB5A89BDDA4F81FFA25D2B9D869E20B65978AD3A7ED8C344A131EDDBCA3
MAIN_REL=PvNP/RealizableHardness/ActualTreeParseFP.lean
CHECKS_REL=PvNP/RealizableHardness/ActualTreeParseFPChecks.lean
rm -rf "$RUN" "$TARGET_ROOT"
mkdir -p "$RUN" "$TARGET/PvNP/RealizableHardness"
[[ -f "$GATE_LOG" ]]
if grep -q 'bba6dbb380fa5dde490c45fd7806ccb05aa1e8a8' "$GATE_LOG"; then echo 'stale sibling gate log' >&2; exit 90; fi
grep -q "$EXPECTED_HEAD" "$GATE_LOG"
grep -q "$EXPECTED_MAIN" "$GATE_LOG"
grep -q "$EXPECTED_CHECKS" "$GATE_LOG"
grep -q 'transfer_gate=PASS' "$GATE_LOG"
cp "$GATE_LOG" "$RUN/transfer-gate.log"
cp "$HOME_ROOT/gate.sh" "$RUN/gate.sh"
cp "$HOME_ROOT/certify.sh" "$RUN/certify.sh"
hash_upper() { sha256sum "$1" | awk '{print toupper($1)}'; }
assert_frozen() {
  local label=$1 mh ch head
  mh=$(hash_upper "$SOURCE_ROOT/$MAIN_REL")
  ch=$(hash_upper "$SOURCE_ROOT/$CHECKS_REL")
  head=$(git -C "$REPO" rev-parse HEAD)
  printf '%s\thead=%s\tmain=%s\tchecks=%s\n' "$label" "$head" "$mh" "$ch" >>"$RUN/source-assertions.tsv"
  [[ "$head" == "$EXPECTED_HEAD" && "$mh" == "$EXPECTED_MAIN" && "$ch" == "$EXPECTED_CHECKS" ]]
}
run_stage() {
  local key=$1 module=$2
  local src="$SOURCE_ROOT/${module//./\/}.lean"
  local obj="$TARGET/${module//./\/}.olean"
  mkdir -p "$(dirname "$obj")"
  assert_frozen "before:$key"
  printf 'module=%s\nsource=%s\nobject=%s\n' "$module" "$src" "$obj" >"$RUN/$key.command.txt"
  set +e
  /usr/bin/time -v -o "$RUN/$key.time.txt" "$LEAN" -R "$SOURCE_ROOT" -o "$obj" "$src" >"$RUN/$key.stdout.log" 2>"$RUN/$key.stderr.log"
  local rc=$?
  set -e
  printf '%s\n' "$rc" >"$RUN/$key.exit.txt"
  cat "$RUN/$key.stdout.log" "$RUN/$key.stderr.log" >"$RUN/$key.combined.log"
  assert_frozen "after:$key"
  [[ $rc -eq 0 && -f "$obj" ]]
}
[[ -x "$LEAN" && -d "$PACKAGES" ]]
[[ "$(git -C "$REPO" rev-parse HEAD)" == "$EXPECTED_HEAD" ]]
[[ -z "$(git -C "$REPO" status --porcelain=v1 --untracked-files=all)" ]]
assert_frozen initial
hash_upper "$SOURCE_ROOT/$MAIN_REL" >"$RUN/source-before.sha256"
hash_upper "$SOURCE_ROOT/$CHECKS_REL" >>"$RUN/source-before.sha256"
export LEAN_NUM_THREADS=1
PACKAGE_PATHS=()
for name in cslib mathlib complexitylib plausible LeanSearchClient importGraph proofwidgets aesop Qq batteries Cli; do
  p="$PACKAGES/$name/.lake/build/lib/lean"
  [[ -d "$p" ]] && PACKAGE_PATHS+=("$p")
done
joined=$(IFS=:; printf '%s' "${PACKAGE_PATHS[*]}")
export LEAN_PATH="$TARGET:$joined:$TOOLCHAIN_LIB"
printf '%s\n' "$LEAN_PATH" >"$RUN/lean-path.txt"
find "$TARGET" -type f -print >"$RUN/preexisting-before.txt"
[[ ! -s "$RUN/preexisting-before.txt" ]]
run_stage exception-repair PvNP.RealizableHardness.ExceptionRepair
run_stage formula PvNP.RealizableHardness.Formula
run_stage cmmsa-codec PvNP.RealizableHardness.CMMSACodec
run_stage main-1 PvNP.RealizableHardness.ActualTreeParseFP
hash_upper "$TARGET/PvNP/RealizableHardness/ActualTreeParseFP.olean" >"$RUN/main-hash-1.txt"
run_stage main-2 PvNP.RealizableHardness.ActualTreeParseFP
hash_upper "$TARGET/PvNP/RealizableHardness/ActualTreeParseFP.olean" >"$RUN/main-hash-2.txt"
[[ "$(cat "$RUN/main-hash-1.txt")" == "$(cat "$RUN/main-hash-2.txt")" ]]
run_stage checks-1 PvNP.RealizableHardness.ActualTreeParseFPChecks
hash_upper "$TARGET/PvNP/RealizableHardness/ActualTreeParseFPChecks.olean" >"$RUN/checks-hash-1.txt"
run_stage checks-2 PvNP.RealizableHardness.ActualTreeParseFPChecks
hash_upper "$TARGET/PvNP/RealizableHardness/ActualTreeParseFPChecks.olean" >"$RUN/checks-hash-2.txt"
[[ "$(cat "$RUN/checks-hash-1.txt")" == "$(cat "$RUN/checks-hash-2.txt")" ]]
assert_frozen final
cp "$RUN/source-before.sha256" "$RUN/source-after.sha256"
{
  echo "ActualTreeParseFP.olean $(hash_upper "$TARGET/PvNP/RealizableHardness/ActualTreeParseFP.olean")"
  echo "ActualTreeParseFPChecks.olean $(hash_upper "$TARGET/PvNP/RealizableHardness/ActualTreeParseFPChecks.olean")"
} >"$RUN/object-hashes.txt"
printf 'result=PASS\n'
