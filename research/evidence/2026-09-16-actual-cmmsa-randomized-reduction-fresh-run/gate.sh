#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
B="$HOME_ROOT/formal-pvnp-c058348.bundle"
D="$HOME_ROOT/cmmsa-randomized-reduction-c058348-src"
VERIFY="$HOME_ROOT/cmmsa-randomized-reduction-c058348-bundle-verify.git"
GATE_LOG="$HOME_ROOT/cmmsa-randomized-reduction-c058348-gate.log"
EXPECTED_BUNDLE=84B92F831B892BB537BF5EB4DB62CA3C9ACF82192852E9958005B338CE859CAF
EXPECTED_HEAD=c0583486d30e65fa3c672a21b163be6f5c1c5b0e
EXPECTED_MAIN=9CDDC139FCF64A07A4E759AD8F5AA78337123FB0EA131E77924421FC4F776283
EXPECTED_CHECKS=BF1C7E8BAA430A75CDC94F6E5DE8A68406000C8E23CE0D4955B18546B7390850
MAIN=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualCMMSARandomizedReduction.lean
CHECKS=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualCMMSARandomizedReductionChecks.lean
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
