# GCP Lean builder benchmark receipt

## Disposition

The builder is operationally reliable for Lean and materially faster on the measured increment. The cloud main and Checks builds exited `0`, their sources were stable during the run, and their `.olean` hashes exactly match the prior certified Windows objects. The measured total compile time was `7.38 s` in GCP versus `103.357847 s` in the controlled Windows comparison, a `14.005x` speedup.

This particular cloud run is **not a replacement canonical certification**. Its source hashes do not match the frozen source hashes at the claimed repository commit, and the downloaded result archive does not contain the source bytes needed to explain the difference. The next cloud run must transfer a content-addressed archive, verify its SHA-256 before extraction, verify `git rev-parse HEAD`, and reject the run before compilation if the source hashes differ from the frozen ledger.

## Resource and security state

- Project: `quantyra-lean-cert-20260915`
- Instance: `quantyra-lean-builder-01` (`8337954477286097405`)
- Zone: `us-central1-a`
- Actual fallback machine: `c3-highmem-8`, 8 vCPU, 64 GiB, x86-64
- Image: Ubuntu 24.04 LTS (`ubuntu-2404-noble-amd64-v20260906`)
- Boot/cache disk: 200 GiB `pd-balanced`, auto-delete with the instance
- Labels: `entity=quantyra`, `workload=lean-certification`, `environment=research`
- Current state: `TERMINATED`; no current external IP
- Shielded VM: Secure Boot, vTPM, and integrity monitoring enabled
- Login: OS Login enabled and project SSH keys blocked
- Service-account scopes are the default restricted scopes recorded in `instance-state-sanitized.json`.

An external access configuration was temporarily present from `15:02:23.430` to `15:10:01.101` local time so the benchmark artifacts could be transferred, then removed. No custom firewall rule was added, but the project's auto-created `default` network has the standard broad `default-allow-ssh` and `default-allow-rdp` rules recorded in `firewall-state.json`. Future runs should use IAP/private access and avoid adding an external IP; if that path cannot be made reliable, the default ingress posture should be tightened before another temporary public address is attached.

The startup metadata exactly matches `startup-script.sh` at SHA-256 `EFFCAEF9716F3FDAF12944FC7D83980904939CFD19F68606887E89BA550DE0CD`. It installs a systemd timer that checks every five minutes and powers off after 2,700 seconds without a Lean/Lake/package/transfer process or interactive login. This verifies the installed configuration, not an autonomous shutdown event: this benchmark was manually stopped before 45 idle minutes elapsed.

## Timing reconciliation

The authoritative successful-instance interval is:

- creation: `2026-09-15T14:56:35.165-07:00`
- start: `2026-09-15T14:56:46.283-07:00`
- stop: `2026-09-15T15:12:26.701-07:00`
- compute duration: `940.418 s` (`15m 40.418s`)

The operations log contains one successful insertion and one stop for instance ID `8337954477286097405`; earlier insertion operations failed before creating resources. There is no successful restart/recreate history. The earlier informal estimate of about 43 minutes was not billable VM runtime and must not be used for cost accounting.

## Reproduced increment

- Claimed commit: `52324cc3f6f307332c5ceca07668eb8c18e379c1` (`prove unique submodule functional gluing`)
- Toolchain: Lean `4.34.0-rc2`, compiler commit `6a10ac8c22beadecabdbb0919c2b50214762f91d`
- Threads: `LEAN_NUM_THREADS=1`
- Main: `SubmoduleFunctionalGluing.lean`
- Checks: `SubmoduleFunctionalGluingChecks.lean`
- Result archive SHA-256: `C294EC22B98DBB60317CD8C1A530145F9B225068237D4CEE539ACEE9A941871C`

| Stage | GCP wall | GCP peak RSS | Windows wall | Windows peak working set | Object SHA-256 |
|---|---:|---:|---:|---:|---|
| Main | 6.47 s | 1,833,020 KiB | 86.575632 s | 1,024,806,912 bytes | `77D109A27663844EB3D553C7F23FBB4C064A34AFE9B0F977A5156B14DCC415E7` |
| Checks | 0.91 s | 1,826,572 KiB | 16.782215 s | 1,003,507,712 bytes | `D40CF30A445FF7DFC18F927BAF4FED5657A8D5EBE8CE723AA7CE64F0D9D7518E` |

Both cloud commands exited `0`; stderr was empty. The Checks output reports only `propext`, `Classical.choice`, and `Quot.sound`. The Windows comparison outputs have the same object hashes and empty stderr; the timing harness lost the subprocess exit-code property after process reaping, so its successful compile status is corroborated by the pre-existing canonical local certification, which independently records both exits as `0`.

## Source-hash finding

Cloud source-before and source-after are equal:

- main: `0D11251A3C71395FCC48E976ED023524C497C2BBA1CC1517C03DF92060439619`
- Checks: `88143FDB927662410BD8979832EF451C01621B104E2EFA10A3D198A79F067CD9`

The commit blobs, current clean working-tree files, and frozen local certification instead agree on:

- main: `3AFDACA24136FB81140471BD7CB40398CE61A2D1896DD78973E25041D51E7D73`
- Checks: `E41183DB2B49F958C7CA0FA753AB58721AD63D7ACAFA1DDD2715DB54CAE4DA52`

The two Git blobs contain LF endings and no CRLF sequences, so CRLF-to-LF normalization does not explain the mismatch. The cloud script wrote the expected commit as a literal rather than recording `git rev-parse HEAD`, and the result archive omitted the cloud source files. Consequently the exact cloud source bytes cannot be compared now. Exact object equality is strong execution evidence, but it does not repair raw-source provenance under the certification contract.

## Cost and retention

At `2026-09-15T15:28:01-07:00`, the on-demand estimate was:

- compute: `$0.138250`, using `940.418 s` at `$0.529232/hour`
- disk through that time: `$0.014353`, using 200 GiB at `$0.000136986/GiB-hour`
- temporary external IPv4: `$0.000636` using a conservative `$0.005/hour`
- network/minor ancillary allowance: `$0.01`
- estimated total: `$0.163238`; conservative cumulative ceiling: **`$0.20`**

This is a list-price estimate rather than an invoice: billing export latency, free-tier treatment, discounts, and byte-level network metering may change the eventual charge. It is far below the `$250` operational ceiling. Rates were taken from the official [general-purpose VM pricing](https://cloud.google.com/products/compute/pricing/general-purpose), [disk pricing](https://cloud.google.com/compute/disks-image-pricing), and [network pricing](https://cloud.google.com/vpc/network-pricing) pages.

Stopped compute does not accrue VM runtime charges, but the retained 200 GiB disk continues at about `$0.657533/day` or `$19.999956` per 730-hour month. Because formalization is active and this benchmark showed a 14x compile speedup, retain the builder stopped for imminent increments while repairing the transfer gate. Reassess within 24 hours; if no near-term cloud build is scheduled and the cache is reproducible, delete the instance and auto-delete disk. The release-milestone instruction still requires deleting disposable resources after required evidence/cache artifacts are preserved.

## Evidence map

- `benchmark-result/`: raw cloud stdout, stderr, GNU time records, system inventory, source hash records, and output hashes
- `gcp-benchmark-result.tar.gz`: unchanged downloaded result bundle
- `local-comparison-raw.json`: fresh Windows timing and memory sample
- `instance-state-sanitized.json`, `disk-state.json`, `operations-sanitized.json`, `firewall-state.json`: read-only GCP state snapshots without credentials
- `cost-estimate.json`: reproducible cost arithmetic and rates
- `run-benchmark.sh`, `startup-script.sh`: scripts used by the run
- `commands.txt`: bounded command transcript
- `artifact-hashes.sha256`: canonical evidence manifest

