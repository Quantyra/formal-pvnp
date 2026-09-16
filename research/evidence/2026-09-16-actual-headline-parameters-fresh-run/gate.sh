#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
B="$HOME_ROOT/formal-pvnp-605b07e.bundle"
D="$HOME_ROOT/headline-params-605b07e-src"
VERIFY="$HOME_ROOT/headline-params-605b07e-bundle-verify.git"
GATE_LOG="$HOME_ROOT/headline-params-605b07e-gate.log"
EXPECTED_BUNDLE=90D65643E108E45553F1444895F1DC23BAB658E2D9C8F9CD1A3BA8403B427DD5
EXPECTED_HEAD=605b07e8d192f13772bdeac9ab16e3772b491d5a
EXPECTED_MAIN=29767BDCE518085DB0590A260293003083858169FCC30D49A299217D913FC20C
EXPECTED_CHECKS=1000E3BD838BF74C7C3EE923F5816E45421169C471FBC7BE49C3A556EE949B48
MAIN=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualHeadlineParameters.lean
CHECKS=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualHeadlineParametersChecks.lean
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
