#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
B="$HOME_ROOT/formal-pvnp-2018a4d.bundle"
D="$HOME_ROOT/presentation-descent-2018a4d-src"
VERIFY="$HOME_ROOT/presentation-descent-2018a4d-bundle-verify.git"
GATE_LOG="$HOME_ROOT/presentation-descent-2018a4d-gate.log"
EXPECTED_BUNDLE=475CFA697D143B8E2C70FB3DBD2AEA23FC52B06855812F338EB663AA21AED96E
EXPECTED_HEAD=2018a4d380f2b04af805501dc9a85b8996624441
EXPECTED_MAIN=F47A412556F00C2B06E026A2D4A58F8B1C9E74FA9BEFFE2480D1623E31848A6F
EXPECTED_CHECKS=510C82D88BF505A23C9A06A788C8EA040155979E19BD1BB8AF33403DD8F49D19
MAIN=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualLeafPresentationDescent.lean
CHECKS=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualLeafPresentationDescentChecks.lean
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
