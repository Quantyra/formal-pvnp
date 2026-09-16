#!/usr/bin/env bash
set -euo pipefail

HOME_ROOT=/home/dfredriksen_quantyra_org
REPO="$HOME_ROOT/relation-laws-e77fda3-src"
PROJECT="$REPO/certifications/realizable-hardness"
SOURCE_ROOT="$PROJECT/lean"
SEED_PROJECT="$HOME_ROOT/benchmark-src/certifications/realizable-hardness"
PACKAGES="$SEED_PROJECT/.lake/packages"
LEAN="$HOME_ROOT/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean"
RUN="$HOME_ROOT/relation-laws-certification"
TARGET="$HOME_ROOT/relation-laws-fresh-target/lib/lean"
EXPECTED_HEAD=e77fda3102152ca111daf3464af4a45931178f81
EXPECTED_MAIN=87BE216E92B19AD2044BF5DB1551A3D36BE3993ABBD456FDCF16FA379274610C
EXPECTED_CHECKS=EBCFCE831F66382614D9D0EF9FBD30D566E0B019BC9C955F943FD61658C90626
MAIN_REL=PvNP/RealizableHardness/ActualLeafRelationLaws.lean
CHECKS_REL=PvNP/RealizableHardness/ActualLeafRelationLawsChecks.lean

assert_frozen() {
  local label=$1 mh ch head
  mh=$(sha256sum "$SOURCE_ROOT/$MAIN_REL" | awk '{print toupper($1)}')
  ch=$(sha256sum "$SOURCE_ROOT/$CHECKS_REL" | awk '{print toupper($1)}')
  head=$(git -C "$REPO" rev-parse HEAD)
  printf '%s\thead=%s\tmain=%s\tchecks=%s\n' "$label" "$head" "$mh" "$ch" >>"$RUN/source-assertions.tsv"
  [[ "$head" == "$EXPECTED_HEAD" && "$mh" == "$EXPECTED_MAIN" && "$ch" == "$EXPECTED_CHECKS" ]]
}

assert_frozen finalize-before
keys=(actual-star-question-support actual-star-span-intersection port-cycle-replacement expander-cut-instantiation fixed-port-cycle-family actual-graph-edges equality-gadget actual-equality-cloud actual-occurrence-allocation actual-occurrence-counts actual-finite-3lin-source actual-rhs-functional-construction actual-star-side-condition-agreement actual-compatible-rhs-functional submodule-functional-gluing actual-presented-leaf-gluing actual-leaf-transport main checks)
for key in "${keys[@]}"; do
  rc=$(cat "$RUN/$key.exit.txt")
  printf '%s\t%s\n' "$key" "$rc"
  [[ "$rc" == 0 ]]
done >"$RUN/stage-exits.tsv"

[[ -f "$TARGET/PvNP/RealizableHardness/ActualLeafRelationLaws.olean" ]]
[[ -f "$TARGET/PvNP/RealizableHardness/ActualLeafRelationLawsChecks.olean" ]]

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
  echo "scope=fresh isolated target; complete 17-module reachable project-source dependency closure rebuilt sequentially, then frozen main and Checks; only locked external package objects and Lean toolchain supplied by retained cache"
  echo "stages=ActualStarQuestionSupport,ActualStarSpanIntersection,PortCycleReplacement,ExpanderCutInstantiation,FixedPortCycleFamily,ActualGraphEdges,EqualityGadget,ActualEqualityCloud,ActualOccurrenceAllocation,ActualOccurrenceCounts,ActualFinite3LinSource,ActualRhsFunctionalConstruction,ActualStarSideConditionAgreement,ActualCompatibleRhsFunctional,SubmoduleFunctionalGluing,ActualPresentedLeafGluing,ActualLeafTransport,ActualLeafRelationLaws,ActualLeafRelationLawsChecks"
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
