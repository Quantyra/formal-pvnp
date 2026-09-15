# Actual presented-leaf gluing cloud certification

Date: 2026-09-15. Result: **PASS**. This is the target-fresh certification receipt for source commit `e599567a629f6e4eb960b4b2543960095293d1d3`. It is certification evidence, not a three-lens review or a claim that the manuscript theorem is complete.

## Provenance gate

Before any Lean process ran, a complete-history Git bundle was created from the local repository and verified locally. The bundle SHA-256 was `FD98C5DB3B89F6C04552916E9E6315D806F26B8A596694278DA2E9EBBFC27A21` on both sides of the IAP transfer. Remote `git bundle verify` passed, the checkout was detached at the exact frozen commit, and `git status --porcelain=v1 --untracked-files=all` was empty.

The remote raw source SHA-256 values matched the frozen ledger:

| Source | SHA-256 |
|---|---|
| `ActualPresentedLeafGluing.lean` | `D19126D4962A13AF182462F56548FE74252100108D5BC1C9EF1C51EAEEBD1452` |
| `ActualPresentedLeafGluingChecks.lean` | `E76DB5B1AF64E31131E785CAB057F194DF3428CE67E159693C61EE3B4AB0564E` |

The harness checked the exact commit and both source hashes initially and before and after every compile stage: 36 matching assertions, with no mismatch.

## Fresh build

The successful run used Lean `4.34.0-rc2`, `LEAN_NUM_THREADS=1`, and a newly created target with no preexisting project object. It rebuilt the complete 15-module project-source import closure, then main and Checks, sequentially. All 17 stages exited `0`. Locked external package objects and the locked Lean toolchain came from the retained cache.

The first attempt stopped at `PortCycleReplacement` because the retained VM cache lacked the locked Complexitylib PCP objects. No main-module compile had begun. The three required package targets were then built from the already-present pinned Complexitylib source at commit `6c248df7859f2f245e731c1e07057bf69d165fe2`; that preparation exited `0`. The final run used a new empty target and passed. The bounded first-failure diagnostic and package-build transcript are preserved because they changed the build route.

| Module | Exit | Wall time | Peak RSS | Object SHA-256 |
|---|---:|---:|---:|---|
| `ActualPresentedLeafGluing` | 0 | 2.53 s | 3,461,052 KiB | `3AE5AB5229E44A73D0AB545987E93E028E5F0C522DF88149ED10983F51E82C4B` |
| `ActualPresentedLeafGluingChecks` | 0 | 13.14 s | 3,462,824 KiB | `A6F2D6F0D0B023265916D4BD7F58DDE23D9A35F1A1A34208D65BE96538D31165` |

The source scan found no `sorry`, `admit`, `native_decide`, or explicit source-level `axiom`. The Checks output reports only `propext`, `Classical.choice`, and `Quot.sound` for the three printed theorem profiles. The cloud artifact manifest initially covered 125 files and independently rehashed with zero mismatches.

The two cloud object hashes differ from the informational local cached objects (`BA60AD4A...E6F7` and `B1B6167D...57D9`). All 17 project objects differ from their current local cache counterparts because this run rebuilt the full project dependency closure into a fresh Linux target while the local cache was produced in a different target and operating-system build context. Object-byte equality across those contexts is not a certification invariant. Exact source identity, locked package revisions, target freshness, successful kernel elaboration, stable hashes, axiom output, and evidence rehash are recorded directly.

## Cloud controls and cost

The builder ran from `15:53:39.841-07:00` to `16:11:32.298-07:00` (1,072.457 seconds), was stopped immediately after the content-addressed result transfer, and is verified `TERMINATED`. Its only interface has private address `10.128.0.2` and no external access configuration. The 45-minute shutdown timer remained configured.

IAP was initially unreachable because the hardened VPC had no SSH ingress from Google's IAP TCP-forwarding range. A narrow rule now permits only TCP 22 from `35.235.240.0/20` and targets only the builder service account. No external IP, broad SSH rule, or public service was introduced. The retained internal-only rule is unchanged.

The estimated increment is `$0.175266` (`$0.157661` compute plus `$0.017606` disk accrual since the prior cost checkpoint). Estimated cumulative spend is **`$0.340771`**, leaving `$249.659229` under the hard operational ceiling. This is a list-price estimate rather than an invoice. The stopped 200 GiB disk continues at approximately `$0.657533/day`.

## Evidence boundary

`transfer-gate.log`, `source-assertions.tsv`, `stage-exits.tsv`, the per-stage raw logs and GNU time reports, `fresh-output-inventory.tsv`, `signature-axioms.txt`, `forbidden-scan.txt`, `object-comparison.json`, and the GCP state snapshots are authoritative for this run. `transfer-receipt.json` authenticates both directions of transfer. Reviews must assess the frozen source independently; this receipt does not supply any of the proof-adversarial, complexity-theory, or non-claims verdicts.
