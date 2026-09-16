#!/usr/bin/env bash
set -euo pipefail

HOME_ROOT=/home/dfredriksen_quantyra_org
B="$HOME_ROOT/formal-pvnp-8c27978.bundle"
D="$HOME_ROOT/mz-lemma33-8c27978-src"
VERIFY="$HOME_ROOT/mz-lemma33-8c27978-bundle-verify.git"
GATE_LOG="$HOME_ROOT/mz-lemma33-8c27978-gate.log"
EXPECTED_BUNDLE=E9357667F5A2382B9DA2A5DB3DE2A9DA46955BA039E2C7B6A8C6244781D5780E
EXPECTED_HEAD=8c2797867e81bd4f69c35893e3574a3f042d1132
EXPECTED_RL_MAIN=87BE216E92B19AD2044BF5DB1551A3D36BE3993ABBD456FDCF16FA379274610C
EXPECTED_RL_CHECKS=55301CD33DFCE8764A7E65564995A0E2DBC17E280558AFF5DE80FF11395C7F46
EXPECTED_CO_MAIN=109346364F8886DA18F31EFD170F8D991AEF21ECD92D591408766815E1F7EF5F
EXPECTED_CO_CHECKS=A68C99D77565BBE9468F412891DFB95EF0BF97C1D8A9282596317800D18079BD
RL_MAIN=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualLeafRelationLaws.lean
RL_CHECKS=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualLeafRelationLawsChecks.lean
CO_MAIN=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualLeafTransportCoherence.lean
CO_CHECKS=certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualLeafTransportCoherenceChecks.lean

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
actual_rl_main=$(sha256sum "$D/$RL_MAIN" | awk '{print toupper($1)}')
actual_rl_checks=$(sha256sum "$D/$RL_CHECKS" | awk '{print toupper($1)}')
actual_co_main=$(sha256sum "$D/$CO_MAIN" | awk '{print toupper($1)}')
actual_co_checks=$(sha256sum "$D/$CO_CHECKS" | awk '{print toupper($1)}')
printf 'expected_rl_main_sha256=%s\nactual_rl_main_sha256=%s\n' "$EXPECTED_RL_MAIN" "$actual_rl_main"
printf 'expected_rl_checks_sha256=%s\nactual_rl_checks_sha256=%s\n' "$EXPECTED_RL_CHECKS" "$actual_rl_checks"
printf 'expected_co_main_sha256=%s\nactual_co_main_sha256=%s\n' "$EXPECTED_CO_MAIN" "$actual_co_main"
printf 'expected_co_checks_sha256=%s\nactual_co_checks_sha256=%s\n' "$EXPECTED_CO_CHECKS" "$actual_co_checks"
[[ "$actual_rl_main" == "$EXPECTED_RL_MAIN" ]]
[[ "$actual_rl_checks" == "$EXPECTED_RL_CHECKS" ]]
[[ "$actual_co_main" == "$EXPECTED_CO_MAIN" ]]
[[ "$actual_co_checks" == "$EXPECTED_CO_CHECKS" ]]
printf 'transfer_gate=PASS\n'
