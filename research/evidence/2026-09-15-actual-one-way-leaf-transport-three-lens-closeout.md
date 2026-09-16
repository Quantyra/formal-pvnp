# Actual one-way leaf transport three-lens closeout

Date: 2026-09-15. Result: **ACCEPTED WITH NOTES**. This post-certification closeout joins the frozen source, the canonical target-fresh cloud certification, and three independent top-level reviews. It is outside the immutable in-run artifact manifest, which remains byte-for-byte unchanged.

## Frozen increment

- Source commit: `bba6dbb380fa5dde490c45fd7806ccb05aa1e8a8` (`prove actual one way leaf transport`).
- Canonical certification commit: `7e06ca3260b140cc7e0c58c22473f09d1b30f2a2` (`certify actual one way leaf transport`).
- Superseded sibling receipt: `419d70a629a560f0bf9a358dc433fa76aaf9fbbb`. The canonical commit preserves the raw logs and corrected 144-row local inventory without changing the frozen sources or cloud build result.
- Main source SHA-256: `F1548559AE3135E8F75F2E8C255B530582DDEFA2E6D58AE02FC53C02460EE3E8`.
- Checks source SHA-256: `D9BF5ED9B8CDCA2431584B4577C4C8BEE3011A82DC23FD819B02C22F96FBC3D9`.
- Cloud main object SHA-256: `1CEE9647728163F2BBC71D6AA429BEFD78AA1883BB24CDE9A307A060B6465AE2`.
- Cloud Checks object SHA-256: `C015F98C7F2172C704216A87A7E415AD832964FD899D3D4FFB5EB92D511C7FF2`.
- Canonical 144-row `artifact-hashes.txt` SHA-256: `0BD43BFD1113C6C8DB98230AB66061EFA1B67500BAAF33DD4C93ACC237EDF41E`; independent rehash: 144 present, 0 mismatches.
- Certification `closeout.md` SHA-256: `3D96F9782112FE4E03EEEEE3BA02180532E05F7F9940A8EA68D5B6603BAA9E4E`.

The increment discharges the following conditional one-way claim at its frozen signature:

```lean
theorem existsUnique_compatibleTransport
    (P Q : PresentedLeaf I J h) (hPQ : P.Rel Q)
    (f : RawLeafLabel I P.domain)
    (hf : RespectsAt P rfl f) :
    ∃! g : RawLeafLabel I Q.domain,
      RespectsAt Q rfl g ∧ TransportCompatible P Q hPQ f g
```

The theorem takes an actual occurrence-allocation source, related actual presentations, a source raw label, and an explicit proof that the label respects the source RHS. It constructs the unique target raw label that respects the target RHS and is the target restriction of a common functional extending the source label and respecting every target equation. The relation witness is supplied, not derived.

The same module defines the exact manuscript presentation relation

```lean
P.Rel Q := P.domain ⊔ Q.H = Q.domain ⊔ P.H
```

and proves the relation-dependent target-domain inclusion, the target-RHS theorem for the constructed label, compatibility through the common functional, and uniqueness among compatible target labels. The nonempty fixture transports between distinct actual two-row questions with different RHS values. The empty fixture separately exercises the zero-dimensional boundary.

## Certification

The content-addressed transfer gate verified the bundle hash, complete Git bundle, detached exact source commit, clean checkout, and both frozen source hashes before compilation. Forty source-stability assertions rechecked HEAD and hashes before, between, and after every stage. The cloud target started empty for project-source outputs and rebuilt the complete 16-module reachable project-source closure, followed by main and Checks. All 18 stages exited `0` under Lean `4.34.0-rc2`.

Main took 2.04 seconds and Checks took 16.30 seconds; peak RSS was 3,481,316 KiB. The nested-comment-aware source scan is clean for `sorry`, `admit`, `native_decide`, and source-level `axiom`. Printed proof profiles contain only `propext`, `Classical.choice`, and `Quot.sound`. The cloud object hashes are certification-context hashes; local Windows cached objects are not claimed to be byte-identical.

## Three-lens review

| Lens | Verdict | Review SHA-256 | Accepted scope / note |
|---|---|---|---|
| Proof-adversarial | **GO-WITH-NOTES** | `622B166AB4C2AF2EFAE2B7467A0411AF7EA6B63461BB3C2904EF9D8898109438` | No false statement, direction error, circular compatibility proof, weakened uniqueness, forbidden proof mechanism, nonstandard axiom, or provenance defect found. Transport remains raw-label, conditional, one-way, and noncomputable. |
| Complexity-theory | **GO-WITH-NOTES** | `F2A92181BD14AF89FC54C1E5490166F8A46081F37B228FB142DB70841F8B2AF9` | Accepts the local MZ Lemma 3.4 existence/uniqueness obligation for a supplied related pair. The actual-incidence equivalence bridge, coherent descent, sampler, acceptance, and hardness remain open. |
| Non-claims boundary | **GO-WITH-NOTES** | `3BDDC7C78529DEF77C290944B6F6E41B4D24E225C32910CDD991C0625F1EE88B` | Accepts only conditional one-way actual-source transport. It does not authorize broader manuscript, hardness, novelty, DOI, release, announcement, or P-versus-NP claims. |

No lens returned `INCOMPLETE` or `NO-GO`; no review-debt story is required for this increment.

## Manuscript consumer and remaining path

The immediate consumer is the **actual-incidence relation-law and coherent transport layer**. The next theorem must use the actual incidence representation to establish the relation laws required by the manuscript, especially transitivity; generic submodule-supremum algebra cannot prove it. Once those laws are available, the transport API must prove identity, inverse, composition/path coherence, proof-argument independence where needed, and packaging/descent to `LeafLabel` values.

Remaining headline path:

```text
actual-incidence Rel laws / clique equivalence
→ identity, inverse, and coherent LeafLabel transport
→ presentation descent and repeated-address semantics
→ center restriction
→ representative sampler and stationarity
→ actual-star acceptance
→ outer soundness and source hardness
→ reduction/runtime/asymptotics
→ manuscript reconciliation and release package
```

The current theorem does not prove relation transitivity, clique equivalence, presentation independence, repeated-address semantics, finite label cardinality, an executable transport algorithm, sampling or stationarity, star acceptance, source hardness, a reduction, `P = NP`, or `P ≠ NP`.

## Cloud state and cost

- Estimated increment cost: `$0.096222`.
- Estimated cumulative GCP spend: **`$0.4369929865`**.
- Remaining under the `$250` operational ceiling: `$249.5630070135`.
- Builder power state at closeout: **`TERMINATED`**.
- Network state: private-only, with no external IP/access configuration.
- The retained 200 GiB balanced disk remains chargeable while the VM is stopped.

## Canonical evidence inventory

| Role | Path |
|---|---|
| Frozen main source | `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualLeafTransport.lean` |
| Frozen Checks source | `certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualLeafTransportChecks.lean` |
| Target-fresh certification | `research/evidence/2026-09-15-actual-leaf-transport-fresh-run/` |
| Certification receipt | `research/evidence/2026-09-15-actual-leaf-transport-fresh-run/closeout.md` |
| Proof-adversarial review | `research/reviews/2026-09-15-actual-leaf-transport-proof-adversarial-review.md` |
| Complexity-theory review | `research/reviews/2026-09-15-actual-one-way-leaf-transport-complexity-theory-review.md` |
| Non-claims review | `research/reviews/2026-09-15-actual-leaf-transport-nonclaims-review.md` |
| This post-certification closeout | `research/evidence/2026-09-15-actual-one-way-leaf-transport-three-lens-closeout.md` |

This file is the authoritative three-lens table and consuming-dependency record for this accepted theorem increment. It does not modify or replace the canonical in-run certification manifest.
