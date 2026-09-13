# Actual retained-edge incidence: source draft

2026-09-13. S3132/S3137 under S3126. SOURCE ONLY: no compiler, observed evaluation, independent acceptance or further Git operation. Main and Checks are newly authored satellite source. The earlier assembly note was separately frozen under its exact grant; Git was released before writing these files.

This implements the next incidence obligation from actual-cloud-assembly-obligations. It imports ActualGraphEdges, whose accepted source freeze is f6977d1c87a814ebfb63437259423d3afef3f987; no active Cloud source is imported or edited. Incident p e means one of the actual retained edge's endpoints is p. IncidentEdge p keeps the representative dart identity, so parallel orbits remain distinct. incidentEdges is the corresponding finite filter.

atPort picks the representative if its source is p and its reverse otherwise. On an incident edge the source is proved p, and canonical_atPort recovers the original full representative for either branch. Thus atPort is injective as a dart map. Equality of incident labels at a fixed p implies equality of both components of the full dart; canonical recovery then forces equality of retained edge occurrences. The resulting injection IncidentEdge p -> Fin 3 proves cardinality at most three, with a bridge to the actual incidentEdges Finset.

The proof supplies no degree or simple-graph premise. Endpoint exclusivity comes from the accepted edge_terminals_distinct. Loops were already omitted by ActualGraphEdges; two distinct parallel orbits consume different dart labels at a shared endpoint, so their incidences are not collapsed. Empty n has no port; Checks includes elimination of a hypothetical Vertex 0 rather than fabricating an incident set at a nonexistent port.

The main contains nine public proof scripts; Checks requests nine axiom profiles, two signatures and five examples. These have not been compiled. Potential elaboration points are decidable subtype inference and the subtype-cardinality bridge; inspect actual terminal diagnostics when a compiler slot is separately granted, without weakening the injection or replacing it with an incidence hypothesis. The exact current Mathlib Fintype.card_subtype interface was read before authoring the bridge.

This provides only the graph incidence component of eventual degree<=4: the Cloud still needs a theorem that each retained edge contributes exactly one gadget row incidence at each terminal, and the original occurrence allocator must prove at most one original-row incidence per anchor port. Fresh internal degree, full generated-row counts, majority gap, encoded FP filtering/allocation and original source hardness remain separate. No full cloud degree, FP, gap, NP-hardness, novelty or final-paper certification is claimed.

Source identities:

```json
[
  {
    "path": "certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualGraphIncidence.lean",
    "sha256": "15db3bcbfe98d5b07096034358183e457eb2db8e555044ddc3a91bb673aa2b42",
    "bytes": 3405
  },
  {
    "path": "certifications/realizable-hardness/lean/PvNP/RealizableHardness/ActualGraphIncidenceChecks.lean",
    "sha256": "81deaa23a11218429b9a0ba6aef4955a8545295227e7fba784c05a1319147585",
    "bytes": 1182
  }
]
```

Remaining to-do list: authorized scoped compilation/repair and three independent lenses for this pair; actual occurrence allocation/cloud degree and gap construction under S3132; source hardness, source-size/FP, decoder, sampling runtime, learning and finalized paper/proof consolidation remain full-goal obligations.

## Author verification update

The earlier source-only status is superseded for author compilation. Actual session 28599 returned terminal EXIT 0 after both main and Checks passed without repairs or retries. Both sources remained raw-identical to freeze a5a7562d9852ec100c399de5b560a95c95ea1109. Nine emitted profiles contain only propext, Classical.choice and Quot.sound; five examples and two signatures compiled. Main retained two deprecated if_pos/if_neg warnings; Checks was clean. Compiler ownership was released immediately after terminal completion.

The fresh actual-graph-incidence-author-20260913 root copied 305 artifacts directly from original accepted locations: the 304-entry GraphEdges closure plus its independent main export. All original/copy and assigned acceptance-receipt hashes were rechecked before and after. Runner verified the pinned Lean commit, manifest and all eleven package revisions, used one thread, and enforced physical-memory preflight 768 MiB and owned-child stop 640 MiB. No guard stop, package download or broad rebuild occurred. Source snapshots and raw logs/terminal metadata were saved before display. Existing package-cache provenance limits remain; this does not claim a fresh whole-dependency build.

Portable packet: certifications/realizable-hardness/.lake/build/actual-graph-incidence-author-20260913/author-verification.json, SHA256 6d0691dec192bd52ea790ae11382fc6c7a4c7554fbd91390c1916c609da36dd2. It embeds exact runner, plan, copies, logs, metadata and source snapshots. Independent proof, complexity and non-claims review remain required. No full cloud-degree, encoded FP, gap/source-hardness or final-paper acceptance follows from this author build.
