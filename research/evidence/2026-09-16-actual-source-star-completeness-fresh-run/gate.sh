#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
B="$HOME_ROOT/formal-pvnp-c574bd9.bundle"
D="$HOME_ROOT/source-star-completeness-c574bd9-src"
VERIFY="$HOME_ROOT/source-star-completeness-c574bd9-bundle-verify.git"
GATE_LOG="$HOME_ROOT/source-star-completeness-c574bd9-gate.log"
EXPECTED_BUNDLE=A9C3351F2AE5060658765B5CC300518D10D99FB61BB019B3702EC147425708F8
EXPECTED_HEAD=c574bd9549543368f26902447a33c7c3427fef3e
EXPECTED_MAIN=192ABD6EA975620C5161FDEEB655F346488911A04CEB24970DBEBE8AE534E648
EXPECTED_CHECKS=2C8E0B3D1D80C024B7F68C6F6D5850F3E683D96970818460F89EAD638274097D
MAIN=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualSourceStarCompleteness.lean
CHECKS=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualSourceStarCompletenessChecks.lean
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
