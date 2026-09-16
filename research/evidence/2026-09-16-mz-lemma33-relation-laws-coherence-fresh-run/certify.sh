#!/usr/bin/env bash
set -euo pipefail

HOME_ROOT=/home/dfredriksen_quantyra_org
REPO="$HOME_ROOT/mz-lemma33-8c27978-src"
PROJECT="$REPO/certifications/realizable-hardness"
SOURCE_ROOT="$PROJECT/lean"
SEED_PROJECT="$HOME_ROOT/benchmark-src/certifications/realizable-hardness"
PACKAGES="$SEED_PROJECT/.lake/packages"
LEAN="$HOME_ROOT/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean"
TOOLCHAIN_LIB="$HOME_ROOT/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/lib/lean"
RUN="$HOME_ROOT/mz-lemma33-8c27978-certification"
TARGET_ROOT="$HOME_ROOT/mz-lemma33-8c27978-fresh-target"
TARGET="$TARGET_ROOT/lib/lean"
GATE_LOG="$HOME_ROOT/mz-lemma33-8c27978-gate.log"
EXPECTED_HEAD=8c2797867e81bd4f69c35893e3574a3f042d1132
EXPECTED_RL_MAIN=87BE216E92B19AD2044BF5DB1551A3D36BE3993ABBD456FDCF16FA379274610C
EXPECTED_RL_CHECKS=55301CD33DFCE8764A7E65564995A0E2DBC17E280558AFF5DE80FF11395C7F46
EXPECTED_CO_MAIN=109346364F8886DA18F31EFD170F8D991AEF21ECD92D591408766815E1F7EF5F
EXPECTED_CO_CHECKS=A68C99D77565BBE9468F412891DFB95EF0BF97C1D8A9282596317800D18079BD
RL_MAIN_REL=PvNP/RealizableHardness/ActualLeafRelationLaws.lean
RL_CHECKS_REL=PvNP/RealizableHardness/ActualLeafRelationLawsChecks.lean
CO_MAIN_REL=PvNP/RealizableHardness/ActualLeafTransportCoherence.lean
CO_CHECKS_REL=PvNP/RealizableHardness/ActualLeafTransportCoherenceChecks.lean

rm -rf "$RUN" "$TARGET_ROOT"
mkdir -p "$RUN" "$TARGET/PvNP/RealizableHardness"

# Increment-scoped gate log only. Never copy a sibling transfer-gate.log.
[[ -f "$GATE_LOG" ]]
if grep -q 'bba6dbb380fa5dde490c45fd7806ccb05aa1e8a8' "$GATE_LOG"; then
  echo 'stale sibling gate log detected' >&2
  exit 90
fi
grep -q "$EXPECTED_HEAD" "$GATE_LOG"
grep -q "$EXPECTED_RL_MAIN" "$GATE_LOG"
grep -q "$EXPECTED_RL_CHECKS" "$GATE_LOG"
grep -q "$EXPECTED_CO_MAIN" "$GATE_LOG"
grep -q "$EXPECTED_CO_CHECKS" "$GATE_LOG"
grep -q 'transfer_gate=PASS' "$GATE_LOG"
cp "$GATE_LOG" "$RUN/transfer-gate.log"
cp "$HOME_ROOT/gate.sh" "$RUN/gate.sh"
cp "$HOME_ROOT/certify.sh" "$RUN/certify.sh"

hash_upper() { sha256sum "$1" | awk '{print toupper($1)}'; }

assert_frozen() {
  local label=$1
  local rlm rlc com coc head
  rlm=$(hash_upper "$SOURCE_ROOT/$RL_MAIN_REL")
  rlc=$(hash_upper "$SOURCE_ROOT/$RL_CHECKS_REL")
  com=$(hash_upper "$SOURCE_ROOT/$CO_MAIN_REL")
  coc=$(hash_upper "$SOURCE_ROOT/$CO_CHECKS_REL")
  head=$(git -C "$REPO" rev-parse HEAD)
  printf '%s\thead=%s\trl_main=%s\trl_checks=%s\tco_main=%s\tco_checks=%s\n' \
    "$label" "$head" "$rlm" "$rlc" "$com" "$coc" >>"$RUN/source-assertions.tsv"
  [[ "$head" == "$EXPECTED_HEAD" && "$rlm" == "$EXPECTED_RL_MAIN" && "$rlc" == "$EXPECTED_RL_CHECKS" && "$com" == "$EXPECTED_CO_MAIN" && "$coc" == "$EXPECTED_CO_CHECKS" ]]
}

run_stage() {
  local key=$1
  local module=$2
  local src="$SOURCE_ROOT/${module//./\/}.lean"
  local obj="$TARGET/${module//./\/}.olean"
  local outdir
  outdir=$(dirname "$obj")
  mkdir -p "$outdir"
  assert_frozen "before:$key"
  printf 'module=%s\nsource=%s\nobject=%s\n' "$module" "$src" "$obj" >"$RUN/$key.command.txt"
  set +e
  /usr/bin/time -v -o "$RUN/$key.time.txt" \
    "$LEAN" -R "$SOURCE_ROOT" -o "$obj" "$src" \
    >"$RUN/$key.stdout.log" 2>"$RUN/$key.stderr.log"
  local rc=$?
  set -e
  printf '%s\n' "$rc" >"$RUN/$key.exit.txt"
  cat "$RUN/$key.stdout.log" "$RUN/$key.stderr.log" >"$RUN/$key.combined.log"
  assert_frozen "after:$key"
  [[ $rc -eq 0 ]]
  [[ -f "$obj" ]]
}

[[ -x "$LEAN" && -d "$PACKAGES" ]]
[[ "$(git -C "$REPO" rev-parse HEAD)" == "$EXPECTED_HEAD" ]]
[[ -z "$(git -C "$REPO" status --porcelain=v1 --untracked-files=all)" ]]
assert_frozen initial
{
  hash_upper "$SOURCE_ROOT/$RL_MAIN_REL"
  hash_upper "$SOURCE_ROOT/$RL_CHECKS_REL"
  hash_upper "$SOURCE_ROOT/$CO_MAIN_REL"
  hash_upper "$SOURCE_ROOT/$CO_CHECKS_REL"
} >"$RUN/source-before.sha256"

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

run_stage relation-laws-main-1 PvNP.RealizableHardness.ActualLeafRelationLaws
hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafRelationLaws.olean" >"$RUN/relation-laws-main-hash-1.txt"
run_stage relation-laws-main-2 PvNP.RealizableHardness.ActualLeafRelationLaws
hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafRelationLaws.olean" >"$RUN/relation-laws-main-hash-2.txt"
[[ "$(cat "$RUN/relation-laws-main-hash-1.txt")" == "$(cat "$RUN/relation-laws-main-hash-2.txt")" ]]

run_stage relation-laws-checks-1 PvNP.RealizableHardness.ActualLeafRelationLawsChecks
hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafRelationLawsChecks.olean" >"$RUN/relation-laws-checks-hash-1.txt"
run_stage relation-laws-checks-2 PvNP.RealizableHardness.ActualLeafRelationLawsChecks
hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafRelationLawsChecks.olean" >"$RUN/relation-laws-checks-hash-2.txt"
[[ "$(cat "$RUN/relation-laws-checks-hash-1.txt")" == "$(cat "$RUN/relation-laws-checks-hash-2.txt")" ]]

run_stage coherence-main-1 PvNP.RealizableHardness.ActualLeafTransportCoherence
hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafTransportCoherence.olean" >"$RUN/coherence-main-hash-1.txt"
run_stage coherence-main-2 PvNP.RealizableHardness.ActualLeafTransportCoherence
hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafTransportCoherence.olean" >"$RUN/coherence-main-hash-2.txt"
[[ "$(cat "$RUN/coherence-main-hash-1.txt")" == "$(cat "$RUN/coherence-main-hash-2.txt")" ]]

run_stage coherence-checks-1 PvNP.RealizableHardness.ActualLeafTransportCoherenceChecks
hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafTransportCoherenceChecks.olean" >"$RUN/coherence-checks-hash-1.txt"
run_stage coherence-checks-2 PvNP.RealizableHardness.ActualLeafTransportCoherenceChecks
hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafTransportCoherenceChecks.olean" >"$RUN/coherence-checks-hash-2.txt"
[[ "$(cat "$RUN/coherence-checks-hash-1.txt")" == "$(cat "$RUN/coherence-checks-hash-2.txt")" ]]

assert_frozen final
{
  hash_upper "$SOURCE_ROOT/$RL_MAIN_REL"
  hash_upper "$SOURCE_ROOT/$RL_CHECKS_REL"
  hash_upper "$SOURCE_ROOT/$CO_MAIN_REL"
  hash_upper "$SOURCE_ROOT/$CO_CHECKS_REL"
} >"$RUN/source-after.sha256"

find "$TARGET" -type f -printf '%P\t%s\t' -exec sha256sum {} \; | \
  awk -F '\t' '{split($3,a," "); print $1 "\t" $2 "\t" toupper(a[1])}' | sort >"$RUN/fresh-output-inventory.tsv"
{
  echo "ActualLeafRelationLaws.olean $(hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafRelationLaws.olean")"
  echo "ActualLeafRelationLawsChecks.olean $(hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafRelationLawsChecks.olean")"
  echo "ActualLeafTransportCoherence.olean $(hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafTransportCoherence.olean")"
  echo "ActualLeafTransportCoherenceChecks.olean $(hash_upper "$TARGET/PvNP/RealizableHardness/ActualLeafTransportCoherenceChecks.olean")"
} >"$RUN/object-hashes.txt"

printf 'result=PASS\n'
