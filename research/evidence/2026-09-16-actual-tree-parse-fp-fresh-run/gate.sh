#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
B="$HOME_ROOT/formal-pvnp-52b57f2.bundle"
D="$HOME_ROOT/tree-parse-fp-52b57f2-src"
VERIFY="$HOME_ROOT/tree-parse-fp-52b57f2-bundle-verify.git"
GATE_LOG="$HOME_ROOT/tree-parse-fp-52b57f2-gate.log"
EXPECTED_BUNDLE=F164DAC94862776ADEEBC2E49296E7A78211F6DA6460D00B1C4D16F36109F0CF
EXPECTED_HEAD=52b57f29cd7d317bfa77a6d046f58ce3d44633a7
EXPECTED_MAIN=563831C5485F44DE298A0E896BD6A9843F5B338F8CDA428F15DFBFB9EB057074
EXPECTED_CHECKS=B9DA8EB5A89BDDA4F81FFA25D2B9D869E20B65978AD3A7ED8C344A131EDDBCA3
MAIN=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualTreeParseFP.lean
CHECKS=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualTreeParseFPChecks.lean
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
