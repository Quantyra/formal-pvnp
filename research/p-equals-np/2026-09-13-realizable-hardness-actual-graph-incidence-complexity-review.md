# Actual graph incidence: independent complexity review

Verdict: **GO-WITH-NOTES**, limited to retained-edge incidence at a fixed
actual graph port. S3132/S3137 and full S3126 remain open.

Reviewer: incidence_complexity_review, independently assigned by the root
orchestrator; not the source author specialization_complexity_review.
This is a source review, not an independent compiler run. Read the planning
formal-three-lens protocol, ActualGraphIncidence main/Checks, ActualGraphEdges,
the actual-cloud-assembly obligations, and the author draft receipt including
its verification update at d3f61b62a69907b6bdb07ba36546654651533bd5.
No existing file at this review path was found before creation.

Candidate: a5a7562d9852ec100c399de5b560a95c95ea1109. SHA256 of the actual
inspected companion files:

- Main: 15db3bcbfe98d5b07096034358183e457eb2db8e555044ddc3a91bb673aa2b42.
- Checks: 81deaa23a11218429b9a0ba6aef4955a8545295227e7fba784c05a1319147585.

## Statement and construction

Edge n retains a full representative dart with IsRep, not an unordered
endpoint pair. Incident p e tests its two actual endpoints. The imported
representative construction excludes loops by strict endpoint rank order;
it preserves different reversal orbits even when endpoint pairs coincide.
incident_exclusive uses actual distinct terminals and therefore does not
silently count a retained loop once instead of twice. This theorem concerns
the loop-filtered edge set, not total multigraph degree including loops.

atPort chooses an orientation of the entire dart. canonical_atPort recovers
the representative on both branches, so atPort is injective even on all
retained edges. The local label injection does not confuse this with an
injection from all edges into three labels: its domain is IncidentEdge p.
For that domain atPort_source proves the first component equals the fixed p;
equality of labels then gives equality of full darts, hence equality of
representative occurrences. Parallel edges cannot collapse in this argument.

The injection into Fin 3 proves Fintype.card (IncidentEdge p) <= 3; the
subtype/filter cardinality bridge supplies the same result for the actual
incidentEdges Finset. The three-label carrier is part of the concrete
rotation graph definition, not an assumed incidence bound or a supplied
simple-graph premise. There is no source-degree, expansion, or desired
cardinality premise hidden in the exported bound.

Quantification is over all n and actual p : Vertex n. The n=0 example
eliminates an impossible vertex; it is not a nonempty graph witness. The
other examples instantiate the exact source, canonicalization, distinct
labels, and cardinality statements. They are appropriate interface checks,
not experiments proving an unformalized global cloud statement.

## Remaining implications

This discharges the actual retained-edge incidence step in the assembly
note. To obtain gadget row degree <=3, the actual row construction must
prove exactly one terminal-row occurrence per incident edge, with no other
rows involving that port. Global degree <=4 additionally needs actual source
occurrence allocation and at most one original-row occurrence per anchor.
Internal row degree and global pair-intersection statements remain their
own construction obligations; parallel copies need fresh indexed internals.

There is no encoded FP theorem here. Noncomputable finite cardinalities and
finite incidence sets do not prove allocation/filtering/serialization runtime
or size relative to the original encoded source. Majority decoding, actual
generated-row gap, compatible YES extension, and upstream near-perfect
exact-3Lin source hardness are not consequences of this local bound alone.
Neither the fixed-L quantifier order nor any final PCP/learning dependency
is discharged by these nine lemmas.

The author receipt attributes pair EXIT 0, nine foundational-only axiom
profiles, five examples, and two signatures to session 28599. This review
does not independently attest that execution or the dependency cache;
the separate proof/build reviewer owns that gate. No compiler, Git mutation,
source edit, download, or public action was performed for this review.

No blocking complexity defect found. Accept this bounded increment only
after the remaining independent review/build evidence closes; do not infer
global cloud degree, source hardness, or full certification from its GO.
