#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
REPO="$HOME_ROOT/gcd-bits-7105c95-src"
PROJECT="$REPO/certifications/realizable-hardness"
SOURCE_ROOT="$PROJECT/lean"
PACKAGES="$HOME_ROOT/benchmark-src/certifications/realizable-hardness/.lake/packages"
LEAN="$HOME_ROOT/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/bin/lean"
TOOLCHAIN_LIB="$HOME_ROOT/.elan/toolchains/leanprover--lean4---v4.34.0-rc2/lib/lean"
RUN="$HOME_ROOT/gcd-bits-7105c95-certification"
TARGET_ROOT="$HOME_ROOT/gcd-bits-7105c95-fresh-target"
TARGET="$TARGET_ROOT/lib/lean"
GATE_LOG="$HOME_ROOT/gcd-bits-7105c95-gate.log"
EXPECTED_HEAD=7105c9504c55226b4143624a4f0143379e11c1ba
EXPECTED_MAIN=8C9B46562B478EB93870249071E8636FFEC80A6F8A068E681D2467E0963FBD8A
EXPECTED_CHECKS=3FF960978E4C1567E74B764704612B72044A76639DA2D18EFAC0EF92921422E6
MAIN_REL=PvNP/RealizableHardness/ActualDecodeInputFP.lean
CHECKS_REL=PvNP/RealizableHardness/ActualDecodeInputFPChecks.lean
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
run_stage weight-rounding PvNP.RealizableHardness.WeightRounding
run_stage finite-sampling PvNP.RealizableHardness.FiniteSampling
run_stage bernoulli-mgf PvNP.RealizableHardness.BernoulliMGF
run_stage finite-concentration PvNP.RealizableHardness.FiniteConcentration
run_stage inverse-cdf-sampler PvNP.RealizableHardness.InverseCDFSampler
run_stage joint-sampling-law PvNP.RealizableHardness.JointSamplingLaw
run_stage sampling-threshold PvNP.RealizableHardness.SamplingThreshold
run_stage computable-sample-count PvNP.RealizableHardness.ComputableSampleCount
run_stage sampling-guarantee PvNP.RealizableHardness.SamplingGuarantee
run_stage finite-repair-rounding-pipeline PvNP.RealizableHardness.FiniteRepairRoundingPipeline
run_stage sampling-formula-promises PvNP.RealizableHardness.SamplingFormulaPromises
run_stage cmmsa-encoding PvNP.RealizableHardness.CMMSAEncoding
run_stage cmmsa-pipeline-encoding PvNP.RealizableHardness.CMMSAPipelineEncoding
run_stage executable-rounding PvNP.RealizableHardness.ExecutableRounding
run_stage finite-source-sampler PvNP.RealizableHardness.FiniteSourceSampler
run_stage executable-pipeline PvNP.RealizableHardness.ExecutablePipeline
run_stage seed-encoding PvNP.RealizableHardness.SeedEncoding
run_stage executable-pipeline-input PvNP.RealizableHardness.ExecutablePipelineInput
run_stage actual-tree-parse-fp PvNP.RealizableHardness.ActualTreeParseFP
run_stage main-1 PvNP.RealizableHardness.ActualDecodeInputFP
hash_upper "$TARGET/PvNP/RealizableHardness/ActualDecodeInputFP.olean" >"$RUN/main-hash-1.txt"
run_stage main-2 PvNP.RealizableHardness.ActualDecodeInputFP
hash_upper "$TARGET/PvNP/RealizableHardness/ActualDecodeInputFP.olean" >"$RUN/main-hash-2.txt"
[[ "$(cat "$RUN/main-hash-1.txt")" == "$(cat "$RUN/main-hash-2.txt")" ]]
run_stage checks-1 PvNP.RealizableHardness.ActualDecodeInputFPChecks
hash_upper "$TARGET/PvNP/RealizableHardness/ActualDecodeInputFPChecks.olean" >"$RUN/checks-hash-1.txt"
run_stage checks-2 PvNP.RealizableHardness.ActualDecodeInputFPChecks
hash_upper "$TARGET/PvNP/RealizableHardness/ActualDecodeInputFPChecks.olean" >"$RUN/checks-hash-2.txt"
[[ "$(cat "$RUN/checks-hash-1.txt")" == "$(cat "$RUN/checks-hash-2.txt")" ]]
assert_frozen final
cp "$RUN/source-before.sha256" "$RUN/source-after.sha256"
{
  echo "ActualDecodeInputFP.olean $(hash_upper "$TARGET/PvNP/RealizableHardness/ActualDecodeInputFP.olean")"
  echo "ActualDecodeInputFPChecks.olean $(hash_upper "$TARGET/PvNP/RealizableHardness/ActualDecodeInputFPChecks.olean")"
} >"$RUN/object-hashes.txt"
printf 'result=PASS\n'
