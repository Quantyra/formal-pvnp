#!/usr/bin/env bash
set -euo pipefail

HOME_ROOT=/home/dfredriksen_quantyra_org
REPO="$HOME_ROOT/presented-leaf-e599567-src"
PROJECT="$REPO/certifications/realizable-hardness"
SOURCE_ROOT="$PROJECT/lean"
SEED_PROJECT="$HOME_ROOT/benchmark-src/certifications/realizable-hardness"
PACKAGES="$SEED_PROJECT/.lake/packages"
LEAN="$HOME_ROOT/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean"
TOOLCHAIN_LIB="$HOME_ROOT/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/lib/lean"
RUN="$HOME_ROOT/presented-leaf-certification"
TARGET_ROOT="$HOME_ROOT/presented-leaf-fresh-target"
TARGET="$TARGET_ROOT/lib/lean"
EXPECTED_HEAD=e599567a629f6e4eb960b4b2543960095293d1d3
EXPECTED_MAIN=D19126D4962A13AF182462F56548FE74252100108D5BC1C9EF1C51EAEEBD1452
EXPECTED_CHECKS=E76DB5B1AF64E31131E785CAB057F194DF3428CE67E159693C61EE3B4AB0564E
MAIN_REL=PvNP/RealizableHardness/ActualPresentedLeafGluing.lean
CHECKS_REL=PvNP/RealizableHardness/ActualPresentedLeafGluingChecks.lean

rm -rf "$RUN" "$TARGET_ROOT"
mkdir -p "$RUN" "$TARGET/PvNP/RealizableHardness"
cp "$HOME_ROOT/transfer-gate.log" "$RUN/transfer-gate.log"
cp "$HOME_ROOT/gate.sh" "$RUN/gate.sh"
cp "$HOME_ROOT/certify.sh" "$RUN/certify.sh"
cp "$HOME_ROOT/complexitylib-cache.stdout" "$RUN/complexitylib-cache.stdout.log"
cp "$HOME_ROOT/complexitylib-cache.stderr" "$RUN/complexitylib-cache.stderr.log"
for f in "$HOME_ROOT/presented-leaf-first-attempt-diagnostic"/*; do
  cp "$f" "$RUN/first-attempt-$(basename "$f")"
done

assert_frozen() {
  local label=$1
  local mh ch head
  mh=$(sha256sum "$SOURCE_ROOT/$MAIN_REL" | awk '{print toupper($1)}')
  ch=$(sha256sum "$SOURCE_ROOT/$CHECKS_REL" | awk '{print toupper($1)}')
  head=$(git -C "$REPO" rev-parse HEAD)
  printf '%s\thead=%s\tmain=%s\tchecks=%s\n' "$label" "$head" "$mh" "$ch" >>"$RUN/source-assertions.tsv"
  [[ "$head" == "$EXPECTED_HEAD" && "$mh" == "$EXPECTED_MAIN" && "$ch" == "$EXPECTED_CHECKS" ]]
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
sha256sum "$SOURCE_ROOT/$MAIN_REL" "$SOURCE_ROOT/$CHECKS_REL" >"$RUN/source-before.sha256"

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
run_stage main PvNP.RealizableHardness.ActualPresentedLeafGluing
run_stage checks PvNP.RealizableHardness.ActualPresentedLeafGluingChecks

assert_frozen final
sha256sum "$SOURCE_ROOT/$MAIN_REL" "$SOURCE_ROOT/$CHECKS_REL" >"$RUN/source-after.sha256"

find "$TARGET" -type f -printf '%P\t%s\t' -exec sha256sum {} \; | \
  awk -F '\t' '{split($3,a," "); print $1 "\t" $2 "\t" toupper(a[1])}' | sort >"$RUN/fresh-output-inventory.tsv"
sha256sum "$TARGET/PvNP/RealizableHardness/ActualPresentedLeafGluing.olean" \
  "$TARGET/PvNP/RealizableHardness/ActualPresentedLeafGluingChecks.olean" >"$RUN/object-hashes.txt"

SCAN='\bsorry\b|\badmit\b|\bnative_decide\b|^[[:space:]]*axiom\b'
set +e
grep -Eni "$SCAN" "$SOURCE_ROOT/$MAIN_REL" "$SOURCE_ROOT/$CHECKS_REL" >"$RUN/forbidden-scan.txt"
scan_rc=$?
set -e
if [[ $scan_rc -eq 0 ]]; then exit 91; fi
if [[ $scan_rc -ne 1 ]]; then exit 92; fi
printf 'pattern=%s\nresult=clean (no matches)\n' "$SCAN" >"$RUN/forbidden-scan.txt"
cp "$RUN/checks.stdout.log" "$RUN/signature-axioms.txt"

{
  echo "date_utc=$(date --iso-8601=seconds)"
  echo "git_head=$(git -C "$REPO" rev-parse HEAD)"
  echo "git_status=$(git -C "$REPO" status --porcelain=v1 --untracked-files=all | tr '\n' ';')"
  echo "toolchain=$($LEAN --version)"
  echo "lean_executable_sha256=$(sha256sum "$LEAN" | awk '{print toupper($1)}')"
  echo "LEAN_NUM_THREADS=$LEAN_NUM_THREADS"
  echo "lake_manifest_sha256=$(sha256sum "$PROJECT/lake-manifest.json" | awk '{print toupper($1)}')"
  echo "fresh_target=$TARGET"
  echo "source_checkout_clean=true"
  echo "scope=fresh isolated target; complete 15-module reachable project-source dependency closure rebuilt sequentially, then frozen main and Checks; only locked external package objects and Lean toolchain supplied by retained cache"
  echo "stages=ActualStarQuestionSupport,ActualStarSpanIntersection,PortCycleReplacement,ExpanderCutInstantiation,FixedPortCycleFamily,ActualGraphEdges,EqualityGadget,ActualEqualityCloud,ActualOccurrenceAllocation,ActualOccurrenceCounts,ActualFinite3LinSource,ActualRhsFunctionalConstruction,ActualStarSideConditionAgreement,ActualCompatibleRhsFunctional,SubmoduleFunctionalGluing,ActualPresentedLeafGluing,ActualPresentedLeafGluingChecks"
  uname -a
  lscpu
  free -b
} >"$RUN/provenance.txt"

for name in cslib mathlib complexitylib plausible LeanSearchClient importGraph proofwidgets aesop Qq batteries Cli; do
  p="$PACKAGES/$name"
  [[ -d "$p/.git" ]] && printf '%s\t%s\n' "$name" "$(git -C "$p" rev-parse HEAD)"
done >"$RUN/package-revisions.tsv"

for key in actual-star-question-support actual-star-span-intersection port-cycle-replacement expander-cut-instantiation fixed-port-cycle-family actual-graph-edges equality-gadget actual-equality-cloud actual-occurrence-allocation actual-occurrence-counts actual-finite-3lin-source actual-rhs-functional-construction actual-star-side-condition-agreement actual-compatible-rhs-functional submodule-functional-gluing main checks; do
  printf '%s\t%s\n' "$key" "$(cat "$RUN/$key.exit.txt")"
done >"$RUN/stage-exits.tsv"

find "$RUN" -maxdepth 1 -type f ! -name artifact-hashes.txt ! -name artifact-hashes-manifest.sha256 ! -name independent-rehash.txt \
  -printf '%f\t%s\t' -exec sha256sum {} \; | \
  awk -F '\t' '{split($3,a," "); print $1 "\t" $2 "\t" toupper(a[1])}' | sort >"$RUN/artifact-hashes.txt"
manifest=$(sha256sum "$RUN/artifact-hashes.txt" | awk '{print toupper($1)}')
printf '%s  artifact-hashes.txt\n' "$manifest" >"$RUN/artifact-hashes-manifest.sha256"

fail=0
while IFS=$'\t' read -r name size hash; do
  actual_size=$(stat -c %s "$RUN/$name")
  actual_hash=$(sha256sum "$RUN/$name" | awk '{print toupper($1)}')
  [[ "$actual_size" == "$size" && "$actual_hash" == "$hash" ]] || fail=$((fail+1))
done <"$RUN/artifact-hashes.txt"
{
  echo "artifact_rows=$(wc -l <"$RUN/artifact-hashes.txt")"
  echo "row_mismatches=$fail"
  echo "artifact_manifest_sha256=$manifest"
  echo "result=$([[ $fail -eq 0 ]] && echo PASS || echo FAIL)"
} >"$RUN/independent-rehash.txt"
[[ $fail -eq 0 ]]

printf 'result=PASS\nartifact_manifest_sha256=%s\n' "$manifest"
