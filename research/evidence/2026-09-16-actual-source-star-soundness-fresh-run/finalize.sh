#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
REPO="$HOME_ROOT/source-star-soundness-f35269d-src"
PROJECT="$REPO/certifications/realizable-hardness"
SOURCE_ROOT="$PROJECT/lean"
PACKAGES="$HOME_ROOT/benchmark-src/certifications/realizable-hardness/.lake/packages"
LEAN="$HOME_ROOT/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean"
RUN="$HOME_ROOT/source-star-soundness-f35269d-certification"
TARGET="$HOME_ROOT/source-star-soundness-f35269d-fresh-target/lib/lean"
EXPECTED_HEAD=f35269d0abecc290f2d79e25a2b1a470d738dc43
EXPECTED_MAIN=0C42DE927035271B413CB57F25C631BE076E7140BB365125AB06208A47BF6F9B
EXPECTED_CHECKS=2870AAA586F4DF0C873983906B6D30A269CED6B2ED3CFABC42F5330CF7BA254D
MAIN_REL=PvNP/RealizableHardness/ActualSourceStarSoundness.lean
CHECKS_REL=PvNP/RealizableHardness/ActualSourceStarSoundnessChecks.lean
hash_upper() { sha256sum "$1" | awk '{print toupper($1)}'; }
assert_frozen() {
  local label=$1 mh ch head
  mh=$(hash_upper "$SOURCE_ROOT/$MAIN_REL"); ch=$(hash_upper "$SOURCE_ROOT/$CHECKS_REL")
  head=$(git -C "$REPO" rev-parse HEAD)
  printf '%s\thead=%s\tmain=%s\tchecks=%s\n' "$label" "$head" "$mh" "$ch" >>"$RUN/source-assertions.tsv"
  [[ "$head" == "$EXPECTED_HEAD" && "$mh" == "$EXPECTED_MAIN" && "$ch" == "$EXPECTED_CHECKS" ]]
}
assert_frozen finalize-before
keys=(actual-star-question-support actual-star-span-intersection port-cycle-replacement expander-cut-instantiation fixed-port-cycle-family actual-graph-edges actual-graph-incidence equality-gadget actual-equality-cloud actual-equality-cloud-degree actual-occurrence-allocation actual-occurrence-counts actual-occurrence-degree actual-occurrence-completeness actual-finite-3lin-source tagged-finite-3lin-source actual-question-mass-bridge tagged-question-mass-bridge actual-tagged-question-mass actual-tagged-question-retained-mass actual-tagged-conditioning-transport actual-tagged-base-projection-transport actual-tagged-failure-transport actual-rhs-functional-construction actual-star-side-condition-agreement actual-compatible-rhs-functional submodule-functional-gluing actual-presented-leaf-gluing actual-leaf-transport actual-leaf-relation-laws actual-leaf-transport-coherence actual-leaf-presentation-descent actual-leaf-center-restriction actual-leaf-representative-sampler actual-leaf-rejection-union actual-leaf-rejection-union-checks actual-star-acceptance actual-source-star-completeness main-1 main-2 checks-1 checks-2)
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
  echo "scope=fresh isolated target; reachable project-source closure including tagged-failure then source-star-soundness main+Checks twice"
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
tar -czf "$HOME_ROOT/source-star-soundness-f35269d-certification.tar.gz" source-star-soundness-f35269d-certification source-star-soundness-f35269d-gate.log gate.sh certify.sh finalize.sh
printf 'result=PASS\nartifact_manifest_sha256=%s\narchive=%s\n' "$manifest" "$(hash_upper "$HOME_ROOT/source-star-soundness-f35269d-certification.tar.gz")"
