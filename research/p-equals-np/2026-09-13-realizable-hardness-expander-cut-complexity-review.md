# Port-cycle and spectral cut: independent complexity review

2026-09-13. Reviewer `/root/rounding_nonclaims_review`, not author of either reviewed component. S3132 under S3126; destination formal-pvnp. **GO-WITH-NOTES for this graph/cut increment.** This source review does not supply independent compilation, source-hardness certification, or publication approval.

Read all four modules, both receipt narratives and the upstream normalized SpectralBound, card_dartsBetween_compl_ge, fixed algBase/algFamily definitions and famRotFn FP/equality interfaces. The separate proof reviewer owns compiler replay. No reviewed source or dependency was edited.

Freeze: 3be6295e08492c766c42406714244e40fa1703e7. Current/frozen identities verified (any line-ending differences are represented by separate raw hashes):

| Module | Current SHA256 | Frozen SHA256 |
| --- | --- | --- |
| PortCycleReplacement | a139bacfa951445c203c3c0a21f50a0d28fc79e94091bc940be97ef39f161c34 | a139bacfa951445c203c3c0a21f50a0d28fc79e94091bc940be97ef39f161c34 |
| PortCycleReplacementChecks | 7a92daffd1c92598bef0fb4c720ed52e6e7c934fa840e759c3a57146095e9a1c | 7a92daffd1c92598bef0fb4c720ed52e6e7c934fa840e759c3a57146095e9a1c |
| ExpanderCutInstantiation | 5e1c7e545a6ae89439dabd524c424217f51444014e64afe3096b7914a16b04b8 | 5e1c7e545a6ae89439dabd524c424217f51444014e64afe3096b7914a16b04b8 |
| ExpanderCutInstantiationChecks | 4db5bd6b12de0589bd1b126ea5b264f5a946ff8e28dffc456ca629ddd3e25e54 | 4db5bd6b12de0589bd1b126ea5b264f5a946ff8e28dffc456ca629ddd3e25e54 |

## Mathematical content and quantifiers

PortCycleReplacement takes an actual rotation R on Fin n x Fin D, D=d+1, with involution proof. The output rotation has three distinct dart labels and nD vertices. External label follows R; forward/backward labels traverse inverse cycle permutations and exchange their labels. Degree three means three darts per vertex, not three distinct neighbors. Loops and parallel edges are retained. D=1 contributes cycle loops; D=2 contributes parallel cycle edges. Simplifying to a simple graph would change the semantics and counts.

The cut is half total endpoint mismatches over darts. Involution pairs opposite crossing darts, so this equals the undirected multiplicity count. cut_decomposition, majority discrepancy transport and original-cut transport yield coefficient h/[D*(1+h+D)] from a genuine input-cut hypothesis h>0. The output expansion inequality itself is not assumed. The minority bound is weak but valid: discrepancy <= D times the cloud cycle boundary. It gives a positive fixed coefficient when h and D are fixed, but offers no parameter-independent expansion constant if D grows.

ExpanderCutInstantiation identifies the same half-total count with outgoing darts, then uses the pinned spectral cut theorem with h=D*(1-lam)/2. SpectralBound is normalized squared L2 contraction with parameter lam squared, and lam is explicitly nonnegative and below one. No normalized/unnormalized factor of D or double-count factor is silently dropped. The elementary product-over-sum estimate pays the factor 1/2. The empty graph branch avoids division by order; it is vacuous expansion on zero vertices and cannot by itself support a nonempty occurrence gadget.

actual_family_expansion has no caller-supplied expansion premise: it instantiates the actual fixed algFamily and proves its coefficient positive. algBase is chosen once as a finite base independently of input size. This is not input-dependent advice. However, a fixed mathematical choice is not a numerically displayed executable release artifact, and no concrete small original degree is proved. port_cut_of_spectral is still a separate generic successor-degree application with a spectral hypothesis. An explicit Fin-label transport connecting this exact library family to this exact replacement remains necessary before claiming a single fully instantiated degree-three family.

## Encoded complexity boundary

The finite rotation/table definitions provide real construction content, and table_length counts exactly 3*n*D rows. They do not prove FP for an arbitrary R argument: an arbitrary function on a finite type carries no encoded cost bound. At fixed D, explicit enumeration is plausibly polynomial in an explicit graph-size parameter, but not automatically polynomial in a binary encoding of n alone. The output itself contains Omega(nD) rows. The final source reduction must account for its graph-size parameter and actual input encoding.

The upstream famRotFn_mem_FP theorem certifies its own encoded function. famRotFn_eq identifies that function on paired unary n,v,i inputs under n>0 and a fit-level polynomial bound. It is not already an FP theorem for the replacement table, arbitrary binary n, or an arbitrary R. Successor/predecessor port operations, label transport, enumeration, all-input fallback and pointwise agreement with the mathematical rotation must be implemented and composed with those actual FP witnesses. Table length cannot replace those missing equalities and runtime proofs.

For the occurrence reduction, padding grows cloud size by fixed D and expansion weakens to the displayed coefficient. Both losses must be charged in the equality-gadget count and soundness denominator. Degree three alone does not prove a maximum-occurrence bound for the later equation system: the equation gadget and incidence bookkeeping must also be implemented and checked. No claim is justified that the source gap survives without quantitative accounting.

## Remaining obligations and wording

The receipts explicitly retain the Fin transport, encoded replacement FP composition, equality gadget/cloud construction and complete specialized PCP/Gap3Lin hardness as remaining tasks. These limits are correct. The historical receipt prose contains damaged Unicode/question marks and stale uncompiled wording; the actual reviewed source is repaired and its author appendix records compilation. Public manuscript use must take constants from the verified Lean statements and replace damaged historical prose, not copy ambiguous glyphs.

Permissible result: an actual degree-three port-cycle transformation has a proved quantitative cut bound under input expansion; the actual fixed library expander satisfies the required base cut inequality; the generic spectral port application is proved. Do not describe this as a completed bounded-occurrence hardness reduction, certified replacement-table FP theorem, new expander discovery, or P-versus-NP result.

Author evidence reports 19 standard-only axiom profiles and 15 examples; that does not replace independent compiler verification. Full S3126 remains active: actual family/encoded integration, source hardness, decoder/learning dependencies, full paper reconciliation and final proof consolidation/fresh-checkout verification are still required. No blocking complexity defect found within the bounded theorem statements.
