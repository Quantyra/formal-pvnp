#!/usr/bin/env bash
set -euo pipefail

B=/home/dfredriksen_quantyra_org/formal-pvnp-bba6dbb.bundle
D=/home/dfredriksen_quantyra_org/leaf-transport-bba6dbb-src
EXPECTED_BUNDLE=2738FFBE05550A5858D9CB1F4474D1DB1A14DDA736E2723BCFF62DA9188A9313
EXPECTED_HEAD=bba6dbb380fa5dde490c45fd7806ccb05aa1e8a8
EXPECTED_MAIN=F1548559AE3135E8F75F2E8C255B530582DDEFA2E6D58AE02FC53C02460EE3E8
EXPECTED_CHECKS=D9BF5ED9B8CDCA2431584B4577C4C8BEE3011A82DC23FD819B02C22F96FBC3D9
MAIN=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualLeafTransport.lean
CHECKS=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualLeafTransportChecks.lean

actual_bundle=$(sha256sum "$B" | awk '{print toupper($1)}')
printf 'expected_bundle_sha256=%s\nactual_bundle_sha256=%s\n' "$EXPECTED_BUNDLE" "$actual_bundle"
[[ "$actual_bundle" == "$EXPECTED_BUNDLE" ]]
VERIFY=/home/dfredriksen_quantyra_org/leaf-transport-bba6dbb-bundle-verify.git
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
