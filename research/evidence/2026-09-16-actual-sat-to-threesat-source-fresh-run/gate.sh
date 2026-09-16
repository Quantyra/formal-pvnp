#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
B="$HOME_ROOT/formal-pvnp-1488ff8.bundle"
D="$HOME_ROOT/sat-to-threesat-1488ff8-src"
VERIFY="$HOME_ROOT/sat-to-threesat-1488ff8-bundle-verify.git"
GATE_LOG="$HOME_ROOT/sat-to-threesat-1488ff8-gate.log"
EXPECTED_BUNDLE=1AEC5D52B2DE5C9EBC32E193039BB661EA83B2CF9429E0969D57D2AAEDAD1278
EXPECTED_HEAD=1488ff84c6d1daad1c1174aa469aeeddedc360aa
EXPECTED_MAIN=5ADF857840ED4242C184AE248BCFC90703E8D1F250776A975C67B0A6E1A988E4
EXPECTED_CHECKS=16E3EF2C31E2BF2B1BDFE16D5C324793BBDC9553631FA22E9C7683CB4143B8E9
MAIN=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualSatToThreeSatSource.lean
CHECKS=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualSatToThreeSatSourceChecks.lean
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
