#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
B="$HOME_ROOT/formal-pvnp-dbdca87.bundle"
D="$HOME_ROOT/read-rat-dbdca87-src"
VERIFY="$HOME_ROOT/read-rat-dbdca87-bundle-verify.git"
GATE_LOG="$HOME_ROOT/read-rat-dbdca87-gate.log"
EXPECTED_BUNDLE=F06511A2A11C1BF42C43B7850143835005DC60624435358184501BDF1DAA863F
EXPECTED_HEAD=dbdca8728e164f41d9fbe005ab699f48450c67f4
EXPECTED_MAIN=2508B3F45C37D04889D3B6448F0DAF44E8842F625B8D778D743E3A920D487763
EXPECTED_CHECKS=9380B508A6BF71A74311AA8B6884921982D9B8CB3CB0DDC4D43FE80DC65E0B7A
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
