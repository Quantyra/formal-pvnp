#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
B="$HOME_ROOT/formal-pvnp-10c3b9b.bundle"
D="$HOME_ROOT/theorem1-10c3b9b-src"
VERIFY="$HOME_ROOT/theorem1-10c3b9b-bundle-verify.git"
GATE_LOG="$HOME_ROOT/theorem1-10c3b9b-gate.log"
EXPECTED_BUNDLE=5F9D372836FA9B04D14AE9229789007DE977D91806287955E4687497A7454775
EXPECTED_HEAD=10c3b9b9653852f56e300fc2b8cc202ece2dbf71
EXPECTED_MAIN=C62AAE87A1A4319198D648A431206750C3F48F8562590DAB56DDBA962678ABAF
EXPECTED_CHECKS=CE241ECFC419AC0D93E7A703B7980BBE92BFDD4613F6EDB6452A1E5524FF2029
MAIN=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualTheorem1.lean
CHECKS=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualTheorem1Checks.lean
rm -f "$GATE_LOG"
exec > >(tee "$GATE_LOG") 2>&1
actual_bundle=$(sha256sum "$B" | awk '{print toupper($1)}')
printf 'expected_bundle_sha256=%s\nactual_bundle_sha256=%s\n' "$EXPECTED_BUNDLE" "$actual_bundle"
[[ "$actual_bundle" == "$EXPECTED_BUNDLE" ]]
rm -rf "$VERIFY"
git init --bare "$VERIFY"
git -C "$VERIFY" bundle verify "$B"
rm -rf "$D"
git clone --no-checkout "$B" "$D"
git -C "$D" checkout --detach "$EXPECTED_HEAD"
actual_head=$(git -C "$D" rev-parse HEAD)
printf 'expected_head=%s\nactual_head=%s\n' "$EXPECTED_HEAD" "$actual_head"
[[ "$actual_head" == "$EXPECTED_HEAD" ]]
status=$(git -C "$D" status --porcelain=v1 --untracked-files=all)
printf 'status_begin\n%s\nstatus_end\n' "$status"
[[ -z "$status" ]]
actual_main=$(sha256sum "$D/$MAIN" | awk '{print toupper($1)}')
actual_checks=$(sha256sum "$D/$CHECKS" | awk '{print toupper($1)}')
printf 'expected_main_sha256=%s\nactual_main_sha256=%s\nexpected_checks_sha256=%s\nactual_checks_sha256=%s\n' \
  "$EXPECTED_MAIN" "$actual_main" "$EXPECTED_CHECKS" "$actual_checks"
[[ "$actual_main" == "$EXPECTED_MAIN" ]]
[[ "$actual_checks" == "$EXPECTED_CHECKS" ]]
printf 'transfer_gate=PASS\n'
