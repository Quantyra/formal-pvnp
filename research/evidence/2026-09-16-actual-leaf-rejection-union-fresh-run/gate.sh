#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
B="$HOME_ROOT/formal-pvnp-37dae51.bundle"
D="$HOME_ROOT/rejection-union-37dae51-src"
VERIFY="$HOME_ROOT/rejection-union-37dae51-bundle-verify.git"
GATE_LOG="$HOME_ROOT/rejection-union-37dae51-gate.log"
EXPECTED_BUNDLE=7CD2092D464DBCBF037CDAB2E9A6AB636CA5DD2995066A543231CE9F4949BC20
EXPECTED_HEAD=37dae5120b9da738216a12845c0ed9e594d8f264
EXPECTED_MAIN=999A3183F0AC58101811315DAE42A010AF0BB41B1C78286BDEF708D285033F83
EXPECTED_CHECKS=15F4924E325D863531F83414759FB7F910349159159064EE2522D07F53C1AB86
MAIN=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualLeafRejectionUnion.lean
CHECKS=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualLeafRejectionUnionChecks.lean
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
