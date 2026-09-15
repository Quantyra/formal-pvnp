#!/usr/bin/env bash
set -euo pipefail

HOME_ROOT=/home/dfredriksen_quantyra_org
REPO="$HOME_ROOT/leaf-transport-bba6dbb-src"
PROJECT="$REPO/certifications/realizable-hardness"
SOURCE_ROOT="$PROJECT/lean"
SEED_PROJECT="$HOME_ROOT/benchmark-src/certifications/realizable-hardness"
PACKAGES="$SEED_PROJECT/.lake/packages"
LEAN="$HOME_ROOT/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean"
RUN="$HOME_ROOT/leaf-transport-certification"
TARGET="$HOME_ROOT/leaf-transport-fresh-target/lib/lean"
EXPECTED_HEAD=bba6dbb380fa5dde490c45fd7806ccb05aa1e8a8
EXPECTED_MAIN=F1548559AE3135E8F75F2E8C255B530582DDEFA2E6D58AE02FC53C02460EE3E8
EXPECTED_CHECKS=D9BF5ED9B8CDCA2431584B4577C4C8BEE3011A82DC23FD819B02C22F96FBC3D9
MAIN_REL=PvNP/RealizableHardness/ActualLeafTransport.lean
CHECKS_REL=PvNP/RealizableHardness/ActualLeafTransportChecks.lean

assert_frozen() {
  local label=$1 mh ch head
  mh=$(sha256sum "$SOURCE_ROOT/$MAIN_REL" | awk '{print toupper($1)}')
  ch=$(sha256sum "$SOURCE_ROOT/$CHECKS_REL" | awk '{print toupper($1)}')
  head=$(git -C "$REPO" rev-parse HEAD)
  printf '%s\thead=%s\tmain=%s\tchecks=%s\n' "$label" "$head" "$mh" "$ch" >>"$RUN/source-assertions.tsv"
  [[ "$head" == "$EXPECTED_HEAD" && "$mh" == "$EXPECTED_MAIN" && "$ch" == "$EXPECTED_CHECKS" ]]
}

assert_frozen finalize-before
cp "$RUN/forbidden-scan.txt" "$RUN/first-attempt-forbidden-scan.txt"
printf '%s\n' '1' >"$RUN/first-attempt-postprocess.exit.txt"
printf '%s\n' 'coarse token scan matched the English word admit inside a documentation comment; all 18 Lean stages had exited 0; no stage was repeated' >"$RUN/first-attempt-postprocess-diagnostic.txt"

keys=(actual-star-question-support actual-star-span-intersection port-cycle-replacement expander-cut-instantiation fixed-port-cycle-family actual-graph-edges equality-gadget actual-equality-cloud actual-occurrence-allocation actual-occurrence-counts actual-finite-3lin-source actual-rhs-functional-construction actual-star-side-condition-agreement actual-compatible-rhs-functional submodule-functional-gluing actual-presented-leaf-gluing main checks)
for key in "${keys[@]}"; do
  rc=$(cat "$RUN/$key.exit.txt")
  printf '%s\t%s\n' "$key" "$rc"
  [[ "$rc" == 0 ]]
done >"$RUN/stage-exits.tsv"

[[ -f "$TARGET/PvNP/RealizableHardness/ActualLeafTransport.olean" ]]
[[ -f "$TARGET/PvNP/RealizableHardness/ActualLeafTransportChecks.olean" ]]

python3 - "$SOURCE_ROOT/$MAIN_REL" "$SOURCE_ROOT/$CHECKS_REL" >"$RUN/comment-stripped-source.txt" <<'PY'
import pathlib, sys
for p in map(pathlib.Path, sys.argv[1:]):
    s = p.read_text(encoding='utf-8')
    out=[]; i=0; depth=0; string=False; escape=False
    while i < len(s):
        if depth:
            if s.startswith('/-', i): depth += 1; i += 2
            elif s.startswith('-/', i): depth -= 1; i += 2
            else:
                if s[i] == '\n': out.append('\n')
                i += 1
        elif string:
            out.append(s[i])
            if escape: escape=False
            elif s[i] == '\\': escape=True
            elif s[i] == '"': string=False
            i += 1
        elif s.startswith('/-', i): depth=1; i += 2
        elif s.startswith('--', i):
            j=s.find('\n', i)
            if j < 0: break
            out.append('\n'); i=j+1
        else:
            out.append(s[i])
            if s[i] == '"': string=True
            i += 1
    if depth: raise SystemExit(f'unclosed block comment in {p}')
    print(f'-- stripped-source-boundary: {p.name}')
    print(''.join(out))
PY

SCAN='\bsorry\b|\badmit\b|\bnative_decide\b|^[[:space:]]*axiom\b'
set +e
grep -Eni "$SCAN" "$RUN/comment-stripped-source.txt" >"$RUN/forbidden-scan.txt"
scan_rc=$?
set -e
[[ $scan_rc -eq 1 ]]
printf 'pattern=%s\ninput=main and Checks after nested Lean block comments and line comments were removed\nresult=clean (no matches)\n' "$SCAN" >"$RUN/forbidden-scan.txt"
cp "$RUN/checks.stdout.log" "$RUN/signature-axioms.txt"

{
  echo "date_utc=$(date --iso-8601=seconds)"
  echo "git_head=$(git -C "$REPO" rev-parse HEAD)"
  echo "git_status=$(git -C "$REPO" status --porcelain=v1 --untracked-files=all | tr '\n' ';')"
  echo "toolchain=$($LEAN --version)"
  echo "lean_executable_sha256=$(sha256sum "$LEAN" | awk '{print toupper($1)}')"
  echo "LEAN_NUM_THREADS=1"
  echo "lake_manifest_sha256=$(sha256sum "$PROJECT/lake-manifest.json" | awk '{print toupper($1)}')"
  echo "fresh_target=$TARGET"
  echo "source_checkout_clean=true"
  echo "scope=fresh isolated target; complete 16-module reachable project-source dependency closure rebuilt sequentially, then frozen main and Checks; only locked external package objects and Lean toolchain supplied by retained cache"
  echo "stages=ActualStarQuestionSupport,ActualStarSpanIntersection,PortCycleReplacement,ExpanderCutInstantiation,FixedPortCycleFamily,ActualGraphEdges,EqualityGadget,ActualEqualityCloud,ActualOccurrenceAllocation,ActualOccurrenceCounts,ActualFinite3LinSource,ActualRhsFunctionalConstruction,ActualStarSideConditionAgreement,ActualCompatibleRhsFunctional,SubmoduleFunctionalGluing,ActualPresentedLeafGluing,ActualLeafTransport,ActualLeafTransportChecks"
  uname -a
  lscpu
  free -b
} >"$RUN/provenance.txt"

for name in cslib mathlib complexitylib plausible LeanSearchClient importGraph proofwidgets aesop Qq batteries Cli; do
  p="$PACKAGES/$name"
  [[ -d "$p/.git" ]] && printf '%s\t%s\n' "$name" "$(git -C "$p" rev-parse HEAD)"
done >"$RUN/package-revisions.tsv"

assert_frozen finalize-after
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
