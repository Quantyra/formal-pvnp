#!/usr/bin/env bash
set -euo pipefail
HOME_ROOT=/home/dfredriksen_quantyra_org
B="$HOME_ROOT/formal-pvnp-4702d23.bundle"
D="$HOME_ROOT/representative-sampler-4702d23-src"
VERIFY="$HOME_ROOT/representative-sampler-4702d23-bundle-verify.git"
GATE_LOG="$HOME_ROOT/representative-sampler-4702d23-gate.log"
EXPECTED_BUNDLE=1C0983D8A3B67E5E4282ED31D6FDD098A3802C8AFCFD130160BC232C49E51FC3
EXPECTED_HEAD=4702d23909a48d72c28fa44ccc51b7902d1cb35f
EXPECTED_MAIN=F276FE422B2609C0F1A23555876A74DF1B3EB343C6C0EB5ED4410D0176963790
EXPECTED_CHECKS=F3CAE694C22E61830C88A845F9A3CCB83BF1F2F3D82D5B6E13F178521E0278BC
MAIN=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualLeafRepresentativeSampler.lean
CHECKS=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualLeafRepresentativeSamplerChecks.lean
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
