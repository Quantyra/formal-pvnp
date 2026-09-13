# Independent complexity review: fixed port-cycle family, 2026-09-13

GO-WITH-NOTES for the bounded pair at 8c47f49396ce9b37668332b893eda216466c3541. S3132 under S3126. The reviewer authored matrix work, not either graph module. This is an independent complexity/source review; no compiler, source edits, Git or public action. Full main, Checks, author receipt narrative/JSON, and independent proof report/JSON were inspected. ExecutablePortRotation is excluded and not certified.

The construction actually eliminates the remaining caller-supplied expander choice for this graph family. Complexity.algBase is chosen once from the library existence theorem, and algFamily is defined from that same base before n. degree, predecessor, label equivalence, spectral constant and kappa therefore do not depend on n or on a coloring S. Noncomputable choice here is a fixed finite constant, not instance-dependent advice. It can in principle be hardwired into an existential machine witness; this pair neither extracts that base numerically nor proves such a new encoded witness.

The label equivalence is finCongr of D=(D-1)+1, justified by D>0. RegGraph.relabel retains the original vertices and conjugates the actual dart rotation. The spectral property is transported from the fixed family's own theorem, then the accepted port-cycle transformation is applied to that exact rotation. The final boundary_expansion takes only n and S; it does not accept an expansion law, final cut inequality, hardness premise or runtime certificate.

The resulting graph has nD vertices and exactly three outgoing dart labels. It is a regular multigraph in the rotation-system convention, not a simple cubic graph. Self-loops contribute zero crossing cut, parallel edges retain multiplicity, and no quotient merges neighbours. Half the total directed mismatch is exactly its undirected boundary with multiplicity, as boundary_eq_cut states. The coefficient is kappa=h/[D(1+h+D)] with h=D(1-lam)/2>0. All constants are fixed independently of n. For n=0 the port space is empty, order/table length are zero, and expansion is 0<=0; degree-three labels do not require nonempty vertices. The general inherited D=1/2 cycle conventions are valid, without claiming that the actual chosen library degree equals either value.

baseRotation_values is a pointwise equality of the numeric output vertex and label against the actual algFamily.rot on valid typed inputs. It is a useful semantic bridge but does not identify any total bitstring function, malformed-input behavior, encoding length, or running time. table is the actual finite typed list and table_length is exactly 3nD rows. A linear row count is not a linear binary output-length or FP theorem. The receipt's proposed nested unary row/table O(n+D) and O(nD(n+D)) bounds are explicitly future targets, not established results. The upstream original-family famRotFn/famTableFn FP results do not automatically prove FP for this new rotation/table; the same composed function must be defined, shown total, proved equal to these values on valid inputs and separately proved in FP.

Downstream occurrence-cloud regularization must charge the vertex blow-up D, the coefficient kappa and all equality-gadget equation counts. The pair does not establish the final occurrence cap, pair-intersection restriction, padding constant, completeness loss or NO gap. Its degree three is not by itself an at-most-ten occurrence theorem. Equality gadgets/cloud bookkeeping, specialized near-satisfiable H?stad source PCP, and the complete uniform encoded reduction remain open. Hypercontractivity/decoder/learning and final paper consolidation are not implied.

The author appendix distinguishes historical uncompiled text from its later actual author results. The separate independent proof report records session6038, both actual exits zero,12 standard profiles,6 examples and2 signatures using303 rehashed dependency artifact copies. This review reads that evidence without pretending to rerun it. It does not count author and independent profile totals as distinct mathematical results. Neither a novelty claim nor a P-versus-NP or full-hardness claim is warranted, and the receipt does not assert one. The original draft's pending Fin-transport language is superseded by the appendix; encoded FP obligations remain current.

## Exact evidence identities

Current and frozen source/receipt comparisons are explicit below. Any raw difference is only verified LF normalization. Independent proof artifacts are hashed separately and are not represented as part of the author freeze.

```json
{
  "frozen_scope": [
    {
      "path": "certifications/realizable-hardness/lean/PvNP/RealizableHardness/FixedPortCycleFamily.lean",
      "current_sha256": "a33cfe1e21f85937f33edad0d722cb81927a003ae2f5896dd9f352e580681ef1",
      "frozen_sha256": "a33cfe1e21f85937f33edad0d722cb81927a003ae2f5896dd9f352e580681ef1",
      "raw_equal": true,
      "LF_equal": true
    },
    {
      "path": "certifications/realizable-hardness/lean/PvNP/RealizableHardness/FixedPortCycleFamilyChecks.lean",
      "current_sha256": "e8df2852c20b5635e0465f4b75d5f3525e7ed64d4a237f9c32ef566e3818b812",
      "frozen_sha256": "e8df2852c20b5635e0465f4b75d5f3525e7ed64d4a237f9c32ef566e3818b812",
      "raw_equal": true,
      "LF_equal": true
    },
    {
      "path": "research/p-equals-np/2026-09-13-realizable-hardness-fixed-port-cycle-family-draft.md",
      "current_sha256": "03e8db6e802eb5c45270ed981d154ef2df89dccb7ac9a77c664d23f7bf677205",
      "frozen_sha256": "03e8db6e802eb5c45270ed981d154ef2df89dccb7ac9a77c664d23f7bf677205",
      "raw_equal": true,
      "LF_equal": true
    }
  ],
  "independent_proof_evidence": [
    {
      "path": "research\\p-equals-np\\2026-09-13-realizable-hardness-fixed-port-cycle-family-independent-proof-review.md",
      "sha256": "574461b650af09af542b32dcb40d769d3722ead85782732c1d375f408e18f15c"
    },
    {
      "path": "research\\p-equals-np\\2026-09-13-realizable-hardness-fixed-port-cycle-family-independent-proof-review.json",
      "sha256": "e21b87eb9f126b88132e97e38e7f416b3f874074b125176f1caeceb3422f0c48"
    }
  ]
}
```
