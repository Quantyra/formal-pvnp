# GCP Lean builder network-hardening addendum

## Scope and disposition

This addendum records the post-benchmark control-plane state of the dedicated
project `quantyra-lean-cert-20260915`. It supersedes the firewall warning in
`../2026-09-15-gcp-lean-builder-benchmark/README.md` as a statement of the
project's **later network state**. It does not modify or supersede the original
benchmark's timing, object-hash, source-provenance, or cost findings.

At `2026-09-15T15:32:58.8978322-07:00`:

- `quantyra-lean-builder-01` (`8337954477286097405`) was `TERMINATED` in
  `us-central1-a`.
- Its sole interface had only private address `10.128.0.2`; the interface JSON
  contained no `accessConfigs` field, so no external IPv4 configuration was
  attached.
- The project had no reserved Compute Engine addresses.
- `default-allow-ssh`, `default-allow-rdp`, and `default-allow-icmp` were absent.
- The only firewall rule was `default-allow-internal`, limited to source range
  `10.128.0.0/9` on the default VPC.
- The retained 200 GiB `pd-balanced` boot/cache disk was `READY` and remained
  attached to the stopped instance.

The original benchmark receipt correctly described the broad default ingress
rules that existed when its `firewall-state.json` was captured. Those three
rules were subsequently deleted. This later, content-addressed snapshot is the
authoritative evidence for the hardened state above.

## Cost update

Using the same list-price assumptions as the benchmark receipt, estimated
cumulative spend through the capture time was `$0.165505`, with the conservative
cumulative ceiling still `$0.20`. Stopped compute adds no VM runtime charge.
The retained disk continues at approximately `$0.657533/day` or `$19.999956`
per 730-hour month. These are estimates, not invoice data; billing export
latency, credits, discounts, and metered network usage can change the final
charge.

## Provenance and limits

`instance-state.json`, `network-interfaces.json`, `firewall-state.json`,
`address-state.json`, and `disk-state.json` preserve direct, read-only `gcloud`
outputs captured under active identity `dfredriksen@quantyra.org`.
`resource-state.json` is the bounded summary and cost calculation derived from
those outputs. `commands.txt` records the queries. `artifact-hashes.sha256`
authenticates this addendum's evidence files but intentionally excludes itself.

The snapshots establish the Compute Engine control-plane state returned at the
capture time. They do not prove historical packet flow, guest-OS state, or an
eventual billing invoice. The benchmark receipt's source-provenance caveat also
remains fully in force: the prior cloud run is execution evidence and is not a
replacement canonical certification.
