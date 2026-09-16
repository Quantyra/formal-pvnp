#!/usr/bin/env bash
set -euo pipefail

B=/home/dfredriksen_quantyra_org/formal-pvnp-e77fda3.bundle
D=/home/dfredriksen_quantyra_org/relation-laws-e77fda3-src
EXPECTED_BUNDLE=5C86BC88686EBA1376AE06FB3EDC8AF93A92EEF4CFF1C38E69EDEC90A0BB8C25
EXPECTED_HEAD=e77fda3102152ca111daf3464af4a45931178f81
EXPECTED_MAIN=87BE216E92B19AD2044BF5DB1551A3D36BE3993ABBD456FDCF16FA379274610C
EXPECTED_CHECKS=EBCFCE831F66382614D9D0EF9FBD30D566E0B019BC9C955F943FD61658C90626
MAIN=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualLeafRelationLaws.lean
CHECKS=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualLeafRelationLawsChecks.lean

actual_bundle=$(sha256sum "$B" | awk '{print toupper($1)}')
printf 'expected_bundle_sha256=%s\nactual_bundle_sha256=%s\n' "$EXPECTED_BUNDLE" "$actual_bundle"
[[ "$actual_bundle" == "$EXPECTED_BUNDLE" ]]
VERIFY=/home/dfredriksen_quantyra_org/relation-laws-e77fda3-bundle-verify.git
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
