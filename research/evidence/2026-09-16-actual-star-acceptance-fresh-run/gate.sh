#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
B="$HOME_ROOT/formal-pvnp-5606cd9.bundle"
D="$HOME_ROOT/star-acceptance-5606cd9-src"
VERIFY="$HOME_ROOT/star-acceptance-5606cd9-bundle-verify.git"
GATE_LOG="$HOME_ROOT/star-acceptance-5606cd9-gate.log"
EXPECTED_BUNDLE=B35E7AEE2C12E30C14D4D3E4BF9E7F57068B1BD7A251B6C4EE55B0C495AC56DE
EXPECTED_HEAD=5606cd972f47575fe592945bcd4d47c0dcc5d3f2
EXPECTED_MAIN=1186473CFA3CD659FAECFD14B555C91890FCF39D5C10E1E601CA5CBE642BC7A5
EXPECTED_CHECKS=ED0E8DA930DFA90DE081F24A8F656093A3918EA3ACF5DDC393470FED885FE585
MAIN=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualStarAcceptance.lean
CHECKS=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualStarAcceptanceChecks.lean
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
