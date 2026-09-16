#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
B="$HOME_ROOT/formal-pvnp-38d9ad0.bundle"
D="$HOME_ROOT/selected-cmmsa-38d9ad0-src"
VERIFY="$HOME_ROOT/selected-cmmsa-38d9ad0-bundle-verify.git"
GATE_LOG="$HOME_ROOT/selected-cmmsa-38d9ad0-gate.log"
EXPECTED_BUNDLE=B34C42046F98938828481CDCD9D8B35275FAB118C1D9E2E9BD9CFEE84C5C2A52
EXPECTED_HEAD=38d9ad0df63e42cea9190657f836822892184010
EXPECTED_MAIN=A0EFD901492C1D0DDB0012B3CDF545B06C51574812F5AC894257309E0B560786
EXPECTED_CHECKS=3F4971152605229124AB5D1EF04D6758FF89589F8B42F4E843CC2138D5A5136C
MAIN=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualSelectedCmmsaSeededMap.lean
CHECKS=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualSelectedCmmsaSeededMapChecks.lean
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
