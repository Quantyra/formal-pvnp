#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
REPO="$HOME_ROOT/source-star-soundness-f35269d-src"
PROJECT="$REPO/certifications/realizable-hardness"
SOURCE_ROOT="$PROJECT/lean"
PACKAGES="$HOME_ROOT/benchmark-src/certifications/realizable-hardness/.lake/packages"
LEAN="$HOME_ROOT/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean"
TOOLCHAIN_LIB="$HOME_ROOT/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/lib/lean"
RUN="$HOME_ROOT/source-star-soundness-f35269d-certification"
TARGET_ROOT="$HOME_ROOT/source-star-soundness-f35269d-fresh-target"
TARGET="$TARGET_ROOT/lib/lean"
GATE_LOG="$HOME_ROOT/source-star-soundness-f35269d-gate.log"
EXPECTED_HEAD=f35269d0abecc290f2d79e25a2b1a470d738dc43
EXPECTED_MAIN=0C42DE927035271B413CB57F25C631BE076E7140BB365125AB06208A47BF6F9B
EXPECTED_CHECKS=2870AAA586F4DF0C873983906B6D30A269CED6B2ED3CFABC42F5330CF7BA254D
MAIN_REL=PvNP/RealizableHardness/ActualSourceStarSoundness.lean
CHECKS_REL=PvNP/RealizableHardness/ActualSourceStarSoundnessChecks.lean
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
run_stage actual-graph-incidence PvNP.RealizableHardness.ActualGraphIncidence
run_stage equality-gadget PvNP.RealizableHardness.EqualityGadget
run_stage actual-equality-cloud PvNP.RealizableHardness.ActualEqualityCloud
run_stage actual-equality-cloud-degree PvNP.RealizableHardness.ActualEqualityCloudDegree
run_stage actual-occurrence-allocation PvNP.RealizableHardness.ActualOccurrenceAllocation
run_stage actual-occurrence-counts PvNP.RealizableHardness.ActualOccurrenceCounts
run_stage actual-occurrence-degree PvNP.RealizableHardness.ActualOccurrenceDegree
run_stage actual-occurrence-completeness PvNP.RealizableHardness.ActualOccurrenceCompleteness
run_stage actual-finite-3lin-source PvNP.RealizableHardness.ActualFinite3LinSource
run_stage tagged-finite-3lin-source PvNP.RealizableHardness.TaggedFinite3LinSource
run_stage actual-question-mass-bridge PvNP.RealizableHardness.ActualQuestionMassBridge
run_stage tagged-question-mass-bridge PvNP.RealizableHardness.TaggedQuestionMassBridge
run_stage actual-tagged-question-mass PvNP.RealizableHardness.ActualTaggedQuestionMass
run_stage actual-tagged-question-retained-mass PvNP.RealizableHardness.ActualTaggedQuestionRetainedMass
run_stage actual-tagged-conditioning-transport PvNP.RealizableHardness.ActualTaggedConditioningTransport
run_stage actual-tagged-base-projection-transport PvNP.RealizableHardness.ActualTaggedBaseProjectionTransport
run_stage actual-tagged-failure-transport PvNP.RealizableHardness.ActualTaggedFailureTransport
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
run_stage actual-leaf-rejection-union PvNP.RealizableHardness.ActualLeafRejectionUnion
run_stage actual-leaf-rejection-union-checks PvNP.RealizableHardness.ActualLeafRejectionUnionChecks
run_stage actual-star-acceptance PvNP.RealizableHardness.ActualStarAcceptance
run_stage actual-source-star-completeness PvNP.RealizableHardness.ActualSourceStarCompleteness
run_stage main-1 PvNP.RealizableHardness.ActualSourceStarSoundness
hash_upper "$TARGET/PvNP/RealizableHardness/ActualSourceStarSoundness.olean" >"$RUN/main-hash-1.txt"
run_stage main-2 PvNP.RealizableHardness.ActualSourceStarSoundness
hash_upper "$TARGET/PvNP/RealizableHardness/ActualSourceStarSoundness.olean" >"$RUN/main-hash-2.txt"
[[ "$(cat "$RUN/main-hash-1.txt")" == "$(cat "$RUN/main-hash-2.txt")" ]]
run_stage checks-1 PvNP.RealizableHardness.ActualSourceStarSoundnessChecks
hash_upper "$TARGET/PvNP/RealizableHardness/ActualSourceStarSoundnessChecks.olean" >"$RUN/checks-hash-1.txt"
run_stage checks-2 PvNP.RealizableHardness.ActualSourceStarSoundnessChecks
hash_upper "$TARGET/PvNP/RealizableHardness/ActualSourceStarSoundnessChecks.olean" >"$RUN/checks-hash-2.txt"
[[ "$(cat "$RUN/checks-hash-1.txt")" == "$(cat "$RUN/checks-hash-2.txt")" ]]
assert_frozen final
cp "$RUN/source-before.sha256" "$RUN/source-after.sha256"
{
  echo "ActualSourceStarSoundness.olean $(hash_upper "$TARGET/PvNP/RealizableHardness/ActualSourceStarSoundness.olean")"
  echo "ActualSourceStarSoundnessChecks.olean $(hash_upper "$TARGET/PvNP/RealizableHardness/ActualSourceStarSoundnessChecks.olean")"
} >"$RUN/object-hashes.txt"
printf 'result=PASS\n'
