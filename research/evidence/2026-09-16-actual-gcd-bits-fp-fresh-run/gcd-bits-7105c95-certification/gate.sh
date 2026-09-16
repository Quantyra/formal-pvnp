#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
B="$HOME_ROOT/formal-pvnp-7105c95.bundle"
D="$HOME_ROOT/gcd-bits-7105c95-src"
VERIFY="$HOME_ROOT/gcd-bits-7105c95-bundle-verify.git"
GATE_LOG="$HOME_ROOT/gcd-bits-7105c95-gate.log"
EXPECTED_BUNDLE=D706ABC78AC3B786CF47FE1DF4FBB4DEDE73B9796F20BC39B5B377C47D9AD756
EXPECTED_HEAD=7105c9504c55226b4143624a4f0143379e11c1ba
EXPECTED_MAIN=8C9B46562B478EB93870249071E8636FFEC80A6F8A068E681D2467E0963FBD8A
EXPECTED_CHECKS=3FF960978E4C1567E74B764704612B72044A76639DA2D18EFAC0EF92921422E6
MAIN=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualDecodeInputFP.lean
CHECKS=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualDecodeInputFPChecks.lean
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
