# Independent non-claims review: port/cycle and expander cut, 2026-09-13

Verdict: GO-WITH-NOTES for the bounded four-module graph/cut increment at 3be6295e08492c766c42406714244e40fa1703e7. This is a source-level claims review, not independent compiler verification, source-hardness acceptance, or full S3126 closeout. The reviewer did not author or repair these four modules. Matrix-module authorship is separate and is not reviewed here. No compiler, source edit, Git mutation, or public action was performed for this review.

## Scope read and evidence interpretation

Read both full main files, both full Checks, both complete narrative receipts, and parsed their portable author JSON. Inspected the pinned RegGraph, SpectralBound, Cheeger outgoing-dart identity, EdgeExpansion bound and FamilyFin algBase/algFamily definitions. The two receipts repeat the same four-module author evidence: 19 profiles and 15 examples are totals, not 38 and 30. Their appendix expressly supersedes historical UNCOMPILED comments and records author verification only; a separate proof reviewer owns independent compilation. No independent theorem acceptance is inferred from source reading or the appendix alone.

## Claims aligned with actual statements

PortCycleReplacement builds an actual involutive rotation from the actual input involution R. Its vertex type is Fin n x Fin D with D=d+1>0; its labels are Fin 3. Thus degree three means three labelled outgoing darts per vertex, and order is exactly nD. It does not mean a simple graph with three distinct neighbours. Loops and parallel edges remain present. At D=1 the two internal labels form a cycle loop with zero cut contribution; at D=2 the two parallel cycle edges remain distinct and both crossing occurrences count. Empty n is permitted, with zero vertices and table length zero.

The cut convention is one half of the total mismatch over directed rotation darts. An undirected crossing orbit contributes one, loops contribute zero, and multiplicity is retained. cut_decomposition derives external plus cycle cut. Boolean majority takes true on ties; discrepancy is the actual mismatch count. minority_le_cycle uses a deliberately weak D multiplier, smallSide_transport and external_transport use actual counts and the involution, and cut_expansion derives h/[D(1+h+D)] from a positive INPUT expansion h. The input cut hypothesis remains explicit; it is not a source-hardness premise or an assumed final replacement bound.

ExpanderCutInstantiation identifies this half-mismatch boundary with the library's outgoing darts, then derives h=D(1-lam)/2 under the actual normalized spectral convention (squared norm contraction by lam^2 with 0<=lam<1). The empty graph case avoids division by its order. actual_family_expansion uses the fixed Complexity.algFamily and its own spectral theorem; no caller supplies a family-expansion certificate. algBase is chosen once, before n, and the family is built from that fixed base. This is not instance-dependent advice or a supplied hardness oracle.

port_cut_of_spectral is still a generic theorem for an actual successor-degree rotation with an explicit spectral hypothesis. The separate actual-family theorem and this theorem have NOT been joined into one exported fixed replacement family in these four files. The final source comment saying the remaining integration is degree transport applies only to this graph-level mathematical joining; it cannot be read as exhausting runtime, reduction, or source-hardness obligations. The receipts state that boundary correctly.

## Required non-claims

The finite table enumerates exactly 3nD labelled pairs and evaluates the provided R. Its ordinary data definitions and structural length theorem do not supply an encoding of arbitrary R, a binary machine model, or a polynomial-time witness for the composed replacement table. Upstream FP theorems for the original family do not automatically certify the new table. No full binary-input or uniform FP claim is supported here.

Neither pair implements the equality gadget, occurrence-cloud equation reduction, charged padding/gap constants, specialized near-satisfiable H?stad/PCP source reduction, or downstream hypercontractivity/decoder/learning chain. Degree three for the replacement does not establish the original family's degree bound, the final constraint-occurrence cap, pairwise intersection limit, or full soundness gap. Source hardness and P versus NP remain open in this formal route.

The authors correctly identify reused spectral-to-cut machinery and claim no new theorem discovery, quantum algorithm, novelty, publication readiness, or full paper consolidation. FixedPortCycleFamily and its Checks/receipt are outside this frozen scope and are not certified by this verdict, regardless of their presence in the working tree.

## Notes

Historical receipt prose contains question-mark substitutions where mathematical symbols were lost during earlier Unicode transport. Read the actual Lean statements and the explicit ASCII equations in this review for exact constants; those damaged prose fragments are not additional claims or formal evidence. Historical draft hashes and statements about no commit are provenance as of their recorded stage. The author appendix and the exact freeze below govern this review. Future public prose should render those expressions cleanly.

## Exact identities

All six current paths were compared with the named freeze. Raw equality or exact LF-normalized equality is recorded below. Any newline normalization is explicit; no unrelated source is covered.

```json
[
  {
    "path": "certifications/realizable-hardness/lean/PvNP/RealizableHardness/PortCycleReplacement.lean",
    "current_sha256": "a139bacfa951445c203c3c0a21f50a0d28fc79e94091bc940be97ef39f161c34",
    "frozen_sha256": "a139bacfa951445c203c3c0a21f50a0d28fc79e94091bc940be97ef39f161c34",
    "raw_equal": true,
    "LF_equal": true
  },
  {
    "path": "certifications/realizable-hardness/lean/PvNP/RealizableHardness/PortCycleReplacementChecks.lean",
    "current_sha256": "7a92daffd1c92598bef0fb4c720ed52e6e7c934fa840e759c3a57146095e9a1c",
    "frozen_sha256": "7a92daffd1c92598bef0fb4c720ed52e6e7c934fa840e759c3a57146095e9a1c",
    "raw_equal": true,
    "LF_equal": true
  },
  {
    "path": "certifications/realizable-hardness/lean/PvNP/RealizableHardness/ExpanderCutInstantiation.lean",
    "current_sha256": "5e1c7e545a6ae89439dabd524c424217f51444014e64afe3096b7914a16b04b8",
    "frozen_sha256": "5e1c7e545a6ae89439dabd524c424217f51444014e64afe3096b7914a16b04b8",
    "raw_equal": true,
    "LF_equal": true
  },
  {
    "path": "certifications/realizable-hardness/lean/PvNP/RealizableHardness/ExpanderCutInstantiationChecks.lean",
    "current_sha256": "4db5bd6b12de0589bd1b126ea5b264f5a946ff8e28dffc456ca629ddd3e25e54",
    "frozen_sha256": "4db5bd6b12de0589bd1b126ea5b264f5a946ff8e28dffc456ca629ddd3e25e54",
    "raw_equal": true,
    "LF_equal": true
  },
  {
    "path": "research/p-equals-np/2026-09-12-realizable-hardness-port-cycle-replacement-draft.md",
    "current_sha256": "553052e0ba16dcf2bfc36703de5fe73a48f192653b09a52c9b7e921c63a4fdca",
    "frozen_sha256": "553052e0ba16dcf2bfc36703de5fe73a48f192653b09a52c9b7e921c63a4fdca",
    "raw_equal": true,
    "LF_equal": true
  },
  {
    "path": "research/p-equals-np/2026-09-12-realizable-hardness-expander-cut-instantiation-draft.md",
    "current_sha256": "11d43034a7aaf236c37a8e8bf8f5c350dffb05d763403b0e89b7b0d5623f4a1f",
    "frozen_sha256": "11d43034a7aaf236c37a8e8bf8f5c350dffb05d763403b0e89b7b0d5623f4a1f",
    "raw_equal": true,
    "LF_equal": true
  }
]
```
