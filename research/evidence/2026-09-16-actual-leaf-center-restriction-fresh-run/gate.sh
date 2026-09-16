#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
B="$HOME_ROOT/formal-pvnp-f54f116.bundle"
D="$HOME_ROOT/center-restriction-f54f116-src"
VERIFY="$HOME_ROOT/center-restriction-f54f116-bundle-verify.git"
GATE_LOG="$HOME_ROOT/center-restriction-f54f116-gate.log"
EXPECTED_BUNDLE=2430E1D05B92A0EA6C80A290B4A5FABDF72CAE16BDCEA2F1CB0A3F84DA6082F6
EXPECTED_HEAD=f54f116d18971d814ba51cbcdbcf1fc664c9fdfc
EXPECTED_MAIN=EDCA7DE73001D70F0122203973CE4B1CB8CD06407106546C8F3ED2B4E7900621
EXPECTED_CHECKS=1FF7F87726CDE25CB228B7D917F9CAE4F6DE8E72B67FA5E20D60657CC3A2AC6D
MAIN=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualLeafCenterRestriction.lean
CHECKS=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualLeafCenterRestrictionChecks.lean
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
