#!/usr/bin/env bash
set -euo pipefail

B=/home/dfredriksen_quantyra_org/formal-pvnp-e599567.bundle
D=/home/dfredriksen_quantyra_org/presented-leaf-e599567-src
EXPECTED_BUNDLE=FD98C5DB3B89F6C04552916E9E6315D806F26B8A596694278DA2E9EBBFC27A21
EXPECTED_HEAD=e599567a629f6e4eb960b4b2543960095293d1d3
EXPECTED_MAIN=D19126D4962A13AF182462F56548FE74252100108D5BC1C9EF1C51EAEEBD1452
EXPECTED_CHECKS=E76DB5B1AF64E31131E785CAB057F194DF3428CE67E159693C61EE3B4AB0564E
MAIN=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualPresentedLeafGluing.lean
CHECKS=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualPresentedLeafGluingChecks.lean

actual_bundle=$(sha256sum "$B" | awk '{print toupper($1)}')
printf 'expected_bundle_sha256=%s\nactual_bundle_sha256=%s\n' "$EXPECTED_BUNDLE" "$actual_bundle"
[[ "$actual_bundle" == "$EXPECTED_BUNDLE" ]]
VERIFY=/home/dfredriksen_quantyra_org/presented-leaf-e599567-bundle-verify.git
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
