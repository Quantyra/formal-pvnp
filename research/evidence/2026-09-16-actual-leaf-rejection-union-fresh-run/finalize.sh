#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
REPO="$HOME_ROOT/rejection-union-37dae51-src"
PROJECT="$REPO/certifications/realizable-hardness"
SOURCE_ROOT="$PROJECT/lean"
PACKAGES="$HOME_ROOT/benchmark-src/certifications/realizable-hardness/.lake/packages"
LEAN="$HOME_ROOT/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean"
RUN="$HOME_ROOT/rejection-union-37dae51-certification"
TARGET="$HOME_ROOT/rejection-union-37dae51-fresh-target/lib/lean"
EXPECTED_HEAD=37dae5120b9da738216a12845c0ed9e594d8f264
EXPECTED_MAIN=999A3183F0AC58101811315DAE42A010AF0BB41B1C78286BDEF708D285033F83
EXPECTED_CHECKS=15F4924E325D863531F83414759FB7F910349159159064EE2522D07F53C1AB86
MAIN_REL=PvNP/RealizableHardness/ActualLeafRejectionUnion.lean
CHECKS_REL=PvNP/RealizableHardness/ActualLeafRejectionUnionChecks.lean
hash_upper() { sha256sum "$1" | awk '{print toupper($1)}'; }
assert_frozen() {
  local label=$1 mh ch head
  mh=$(hash_upper "$SOURCE_ROOT/$MAIN_REL"); ch=$(hash_upper "$SOURCE_ROOT/$CHECKS_REL")
  head=$(git -C "$REPO" rev-parse HEAD)
  printf '%s\thead=%s\tmain=%s\tchecks=%s\n' "$label" "$head" "$mh" "$ch" >>"$RUN/source-assertions.tsv"
  [[ "$head" == "$EXPECTED_HEAD" && "$mh" == "$EXPECTED_MAIN" && "$ch" == "$EXPECTED_CHECKS" ]]
}
assert_frozen finalize-before
keys=(actual-star-question-support actual-star-span-intersection port-cycle-replacement expander-cut-instantiation fixed-port-cycle-family actual-graph-edges equality-gadget actual-equality-cloud actual-occurrence-allocation actual-occurrence-counts actual-finite-3lin-source actual-rhs-functional-construction actual-star-side-condition-agreement actual-compatible-rhs-functional submodule-functional-gluing actual-presented-leaf-gluing actual-leaf-transport actual-leaf-relation-laws actual-leaf-transport-coherence actual-leaf-presentation-descent actual-leaf-center-restriction actual-leaf-representative-sampler main-1 main-2 checks-1 checks-2)
for key in "${keys[@]}"; do rc=$(cat "$RUN/$key.exit.txt"); printf '%s\t%s\n' "$key" "$rc"; [[ "$rc" == 0 ]]; done >"$RUN/stage-exits.tsv"
[[ "$(cat "$RUN/main-hash-1.txt")" == "$(cat "$RUN/main-hash-2.txt")" ]]
[[ "$(cat "$RUN/checks-hash-1.txt")" == "$(cat "$RUN/checks-hash-2.txt")" ]]
python3 - "$SOURCE_ROOT/$MAIN_REL" "$SOURCE_ROOT/$CHECKS_REL" >"$RUN/comment-stripped-source.txt" <<'PY'
import pathlib, sys
for p in map(pathlib.Path, sys.argv[1:]):
    s = p.read_text(encoding='utf-8'); out=[]; i=0; depth=0; string=False; escape=False
    while i < len(s):
        if depth:
            if s.startswith('/-', i): depth += 1; i += 2
            elif s.startswith('-/', i): depth -= 1; i += 2
            else:
                if s[i]=='\n': out.append('\n')
                i += 1
        elif string:
            out.append(s[i])
            if escape: escape=False
            elif s[i]=='\\': escape=True
            elif s[i]=='"': string=False
            i += 1
        elif s.startswith('/-', i): depth=1; i += 2
        elif s.startswith('--', i):
            j=s.find('\n', i)
            if j<0: break
            out.append('\n'); i=j+1
        else:
            out.append(s[i])
            if s[i]=='"': string=True
            i += 1
    if depth: raise SystemExit(f'unclosed block comment in {p}')
    print(f'-- stripped-source-boundary: {p.name}'); print(''.join(out))
PY
SCAN='\bsorry\b|\badmit\b|\bnative_decide\b|^[[:space:]]*axiom\b'
set +e; grep -Eni "$SCAN" "$RUN/comment-stripped-source.txt" >"$RUN/forbidden-scan.txt"; scan_rc=$?; set -e
[[ $scan_rc -eq 1 ]]
printf 'pattern=%s\nresult=clean (no matches)\n' "$SCAN" >"$RUN/forbidden-scan.txt"
cp "$RUN/checks-2.stdout.log" "$RUN/signature-axioms.txt"
{
  echo "date_utc=$(date --iso-8601=seconds)"
  echo "git_head=$(git -C "$REPO" rev-parse HEAD)"
  echo "toolchain=$($LEAN --version)"
  echo "LEAN_NUM_THREADS=1"
  echo "fresh_target=$TARGET"
  echo "source_checkout_clean=true"
  echo "scope=fresh isolated target; 21-module reachable project-source closure then rejection-union main+Checks twice"
  uname -a; lscpu; free -b
} >"$RUN/provenance.txt"
for name in cslib mathlib complexitylib plausible LeanSearchClient importGraph proofwidgets aesop Qq batteries Cli; do
  p="$PACKAGES/$name"; [[ -d "$p/.git" ]] && printf '%s\t%s\n' "$name" "$(git -C "$p" rev-parse HEAD)"
done >"$RUN/package-revisions.tsv"
assert_frozen finalize-after
find "$RUN" -maxdepth 1 -type f ! -name artifact-hashes.txt ! -name artifact-hashes-manifest.sha256 ! -name independent-rehash.txt -printf '%f\t%s\t' -exec sha256sum {} \; | awk -F '\t' '{split($3,a," "); print $1 "\t" $2 "\t" toupper(a[1])}' | sort >"$RUN/artifact-hashes.txt"
manifest=$(hash_upper "$RUN/artifact-hashes.txt")
printf '%s  artifact-hashes.txt\n' "$manifest" >"$RUN/artifact-hashes-manifest.sha256"
fail=0
while IFS=$'\t' read -r name size hash; do
  actual_size=$(stat -c %s "$RUN/$name"); actual_hash=$(hash_upper "$RUN/$name")
  [[ "$actual_size" == "$size" && "$actual_hash" == "$hash" ]] || fail=$((fail+1))
done <"$RUN/artifact-hashes.txt"
{
  echo "artifact_rows=$(wc -l <"$RUN/artifact-hashes.txt")"
  echo "row_mismatches=$fail"
  echo "artifact_manifest_sha256=$manifest"
  echo "result=$([[ $fail -eq 0 ]] && echo PASS || echo FAIL)"
} >"$RUN/independent-rehash.txt"
[[ $fail -eq 0 ]]
cd "$HOME_ROOT"
tar -czf "$HOME_ROOT/rejection-union-37dae51-certification.tar.gz" rejection-union-37dae51-certification rejection-union-37dae51-gate.log gate.sh certify.sh finalize.sh
printf 'result=PASS\nartifact_manifest_sha256=%s\narchive=%s\n' "$manifest" "$(hash_upper "$HOME_ROOT/rejection-union-37dae51-certification.tar.gz")"
