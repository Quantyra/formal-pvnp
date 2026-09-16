#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
REPO="$HOME_ROOT/theorem1-10c3b9b-src"
PROJECT="$REPO/certifications/realizable-hardness"
SOURCE_ROOT="$PROJECT/lean"
PACKAGES="$HOME_ROOT/benchmark-src/certifications/realizable-hardness/.lake/packages"
LEAN="$HOME_ROOT/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean"
TOOLCHAIN_LIB="$HOME_ROOT/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/lib/lean"
RUN="$HOME_ROOT/theorem1-10c3b9b-certification"
TARGET_ROOT="$HOME_ROOT/theorem1-10c3b9b-fresh-target"
TARGET="$TARGET_ROOT/lib/lean"
GATE_LOG="$HOME_ROOT/theorem1-10c3b9b-gate.log"
EXPECTED_HEAD=10c3b9b9653852f56e300fc2b8cc202ece2dbf71
EXPECTED_MAIN=C62AAE87A1A4319198D648A431206750C3F48F8562590DAB56DDBA962678ABAF
EXPECTED_CHECKS=CE241ECFC419AC0D93E7A703B7980BBE92BFDD4613F6EDB6452A1E5524FF2029
MAIN_REL=PvNP/RealizableHardness/ActualTheorem1.lean
CHECKS_REL=PvNP/RealizableHardness/ActualTheorem1Checks.lean
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
run_stage randomized-reduction PvNP.RealizableHardness.RandomizedReduction
run_stage randomized-reduction-assembly PvNP.RealizableHardness.RandomizedReductionAssembly
run_stage actual-cmmsa-randomized-reduction PvNP.RealizableHardness.ActualCMMSARandomizedReduction
run_stage main-1 PvNP.RealizableHardness.ActualTheorem1
hash_upper "$TARGET/PvNP/RealizableHardness/ActualTheorem1.olean" >"$RUN/main-hash-1.txt"
run_stage main-2 PvNP.RealizableHardness.ActualTheorem1
hash_upper "$TARGET/PvNP/RealizableHardness/ActualTheorem1.olean" >"$RUN/main-hash-2.txt"
[[ "$(cat "$RUN/main-hash-1.txt")" == "$(cat "$RUN/main-hash-2.txt")" ]]
run_stage checks-1 PvNP.RealizableHardness.ActualTheorem1Checks
hash_upper "$TARGET/PvNP/RealizableHardness/ActualTheorem1Checks.olean" >"$RUN/checks-hash-1.txt"
run_stage checks-2 PvNP.RealizableHardness.ActualTheorem1Checks
hash_upper "$TARGET/PvNP/RealizableHardness/ActualTheorem1Checks.olean" >"$RUN/checks-hash-2.txt"
[[ "$(cat "$RUN/checks-hash-1.txt")" == "$(cat "$RUN/checks-hash-2.txt")" ]]
assert_frozen final
cp "$RUN/source-before.sha256" "$RUN/source-after.sha256"
{
  echo "ActualTheorem1.olean $(hash_upper "$TARGET/PvNP/RealizableHardness/ActualTheorem1.olean")"
  echo "ActualTheorem1Checks.olean $(hash_upper "$TARGET/PvNP/RealizableHardness/ActualTheorem1Checks.olean")"
} >"$RUN/object-hashes.txt"
printf 'result=PASS\n'
