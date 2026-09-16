#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
B="$HOME_ROOT/formal-pvnp-f35269d.bundle"
D="$HOME_ROOT/source-star-soundness-f35269d-src"
VERIFY="$HOME_ROOT/source-star-soundness-f35269d-bundle-verify.git"
GATE_LOG="$HOME_ROOT/source-star-soundness-f35269d-gate.log"
EXPECTED_BUNDLE=F5B7912CCFB531F6CAED6AF98C15E2CD30C26C3CAD6E1FB9CB160F23CEF1986D
EXPECTED_HEAD=f35269d0abecc290f2d79e25a2b1a470d738dc43
EXPECTED_MAIN=0C42DE927035271B413CB57F25C631BE076E7140BB365125AB06208A47BF6F9B
EXPECTED_CHECKS=2870AAA586F4DF0C873983906B6D30A269CED6B2ED3CFABC42F5330CF7BA254D
MAIN=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualSourceStarSoundness.lean
CHECKS=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualSourceStarSoundnessChecks.lean
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
