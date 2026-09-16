#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
REPO="$HOME_ROOT/rejection-union-37dae51-src"
PROJECT="$REPO/certifications/realizable-hardness"
SOURCE_ROOT="$PROJECT/lean"
PACKAGES="$HOME_ROOT/benchmark-src/certifications/realizable-hardness/.lake/packages"
LEAN="$HOME_ROOT/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean"
TOOLCHAIN_LIB="$HOME_ROOT/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/lib/lean"
RUN="$HOME_ROOT/rejection-union-37dae51-certification"
TARGET_ROOT="$HOME_ROOT/rejection-union-37dae51-fresh-target"
TARGET="$TARGET_ROOT/lib/lean"
GATE_LOG="$HOME_ROOT/rejection-union-37dae51-gate.log"
EXPECTED_HEAD=37dae5120b9da738216a12845c0ed9e594d8f264
EXPECTED_MAIN=999A3183F0AC58101811315DAE42A010AF0BB41B1C78286BDEF708D285033F83
EXPECTED_CHECKS=15F4924E325D863531F83414759FB7F910349159159064EE2522D07F53C1AB86
MAIN_REL=PvNP/RealizableHardness/ActualLeafRejectionUnion.lean
CHECKS_REL=PvNP/RealizableHardness/ActualLeafRejectionUnionChecks.lean
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
run_stage actual-leaf-presentation-descent PvNP.RealizableHardness.ActualLeafPresentationDescent
run_stage actual-leaf-center-restriction PvNP.RealizableHardness.ActualLeafCenterRestriction
run_stage actual-leaf-representative-sampler PvNP.RealizableHardness.ActualLeafRepresentativeSampler
run_stage main-1 PvNP.RealizableHardness.ActualLeafRejectionUnion
hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafRejectionUnion.olean" >"$RUN/main-hash-1.txt"
run_stage main-2 PvNP.RealizableHardness.ActualLeafRejectionUnion
hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafRejectionUnion.olean" >"$RUN/main-hash-2.txt"
[[ "$(cat "$RUN/main-hash-1.txt")" == "$(cat "$RUN/main-hash-2.txt")" ]]
run_stage checks-1 PvNP.RealizableHardness.ActualLeafRejectionUnionChecks
hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafRejectionUnionChecks.olean" >"$RUN/checks-hash-1.txt"
run_stage checks-2 PvNP.RealizableHardness.ActualLeafRejectionUnionChecks
hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafRejectionUnionChecks.olean" >"$RUN/checks-hash-2.txt"
[[ "$(cat "$RUN/checks-hash-1.txt")" == "$(cat "$RUN/checks-hash-2.txt")" ]]
assert_frozen final
cp "$RUN/source-before.sha256" "$RUN/source-after.sha256"
{
  echo "ActualLeafRejectionUnion.olean $(hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafRejectionUnion.olean")"
  echo "ActualLeafRejectionUnionChecks.olean $(hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafRejectionUnionChecks.olean")"
} >"$RUN/object-hashes.txt"
printf 'result=PASS\n'
