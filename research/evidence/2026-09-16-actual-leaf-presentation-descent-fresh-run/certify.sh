#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
REPO="$HOME_ROOT/presentation-descent-2018a4d-src"
PROJECT="$REPO/certifications/realizable-hardness"
SOURCE_ROOT="$PROJECT/lean"
PACKAGES="$HOME_ROOT/benchmark-src/certifications/realizable-hardness/.lake/packages"
LEAN="$HOME_ROOT/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean"
TOOLCHAIN_LIB="$HOME_ROOT/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/lib/lean"
RUN="$HOME_ROOT/presentation-descent-2018a4d-certification"
TARGET_ROOT="$HOME_ROOT/presentation-descent-2018a4d-fresh-target"
TARGET="$TARGET_ROOT/lib/lean"
GATE_LOG="$HOME_ROOT/presentation-descent-2018a4d-gate.log"
EXPECTED_HEAD=2018a4d380f2b04af805501dc9a85b8996624441
EXPECTED_MAIN=F47A412556F00C2B06E026A2D4A58F8B1C9E74FA9BEFFE2480D1623E31848A6F
EXPECTED_CHECKS=510C82D88BF505A23C9A06A788C8EA040155979E19BD1BB8AF33403DD8F49D19
MAIN_REL=PvNP/RealizableHardness/ActualLeafPresentationDescent.lean
CHECKS_REL=PvNP/RealizableHardness/ActualLeafPresentationDescentChecks.lean
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
run_stage actual-star-question-support PvNP.RealizableHardness.ActualStarQuestionSupport
run_stage actual-star-span-intersection PvNP.RealizableHardness.ActualStarSpanIntersection
run_stage port-cycle-replacement PvNP.RealizableHardness.PortCycleReplacement
run_stage expander-cut-instantiation PvNP.RealizableHardness.ExpanderCutInstantiation
run_stage fixed-port-cycle-family PvNP.RealizableHardness.FixedPortCycleFamily
run_stage actual-graph-edges PvNP.RealizableHardness.ActualGraphEdges
run_stage equality-gadget PvNP.RealizableHardness.EqualityGadget
run_stage actual-equality-cloud PvNP.RealizableHardness.ActualEqualityCloud
run_stage actual-occurrence-allocation PvNP.RealizableHardness.ActualOccurrenceAllocation
run_stage actual-occurrence-counts PvNP.RealizableHardness.ActualOccurrenceCounts
run_stage actual-finite-3lin-source PvNP.RealizableHardness.ActualFinite3LinSource
run_stage actual-rhs-functional-construction PvNP.RealizableHardness.ActualRhsFunctionalConstruction
run_stage actual-star-side-condition-agreement PvNP.RealizableHardness.ActualStarSideConditionAgreement
run_stage actual-compatible-rhs-functional PvNP.RealizableHardness.ActualCompatibleRhsFunctional
run_stage submodule-functional-gluing PvNP.RealizableHardness.SubmoduleFunctionalGluing
run_stage actual-presented-leaf-gluing PvNP.RealizableHardness.ActualPresentedLeafGluing
run_stage actual-leaf-transport PvNP.RealizableHardness.ActualLeafTransport
run_stage actual-leaf-relation-laws PvNP.RealizableHardness.ActualLeafRelationLaws
run_stage actual-leaf-transport-coherence PvNP.RealizableHardness.ActualLeafTransportCoherence
run_stage main-1 PvNP.RealizableHardness.ActualLeafPresentationDescent
hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafPresentationDescent.olean" >"$RUN/main-hash-1.txt"
run_stage main-2 PvNP.RealizableHardness.ActualLeafPresentationDescent
hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafPresentationDescent.olean" >"$RUN/main-hash-2.txt"
[[ "$(cat "$RUN/main-hash-1.txt")" == "$(cat "$RUN/main-hash-2.txt")" ]]
run_stage checks-1 PvNP.RealizableHardness.ActualLeafPresentationDescentChecks
hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafPresentationDescentChecks.olean" >"$RUN/checks-hash-1.txt"
run_stage checks-2 PvNP.RealizableHardness.ActualLeafPresentationDescentChecks
hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafPresentationDescentChecks.olean" >"$RUN/checks-hash-2.txt"
[[ "$(cat "$RUN/checks-hash-1.txt")" == "$(cat "$RUN/checks-hash-2.txt")" ]]
assert_frozen final
cp "$RUN/source-before.sha256" "$RUN/source-after.sha256"
{
  echo "ActualLeafPresentationDescent.olean $(hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafPresentationDescent.olean")"
  echo "ActualLeafPresentationDescentChecks.olean $(hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafPresentationDescentChecks.olean")"
} >"$RUN/object-hashes.txt"
printf 'result=PASS\n'
