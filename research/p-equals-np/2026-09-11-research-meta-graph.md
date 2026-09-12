# Research meta-graph: evidence, transformations and open transitions

2026-09-11; S3068 user-directed addition, updated through S3070. This is a persistent research ledger, not an executable quantum walk, a discovered holographic algorithm or a new complexity result. Nodes record a representation and its required query; edges record an established transformation, a restricted failure, or an unproved step. This small ledger is a different level from the exponentially large lifted-state graph inside the rooted-operator node. Double covers and quantum interference would act on that internal graph, not automatically on ledger arrows that may be lossy or noninvertible. The [novelty assessment](2026-09-11-fko-novelty.md) supplies the claim-level conclusion.

```mermaid
flowchart TD
  CNF[Explicit signed 3-CNF]
  GEOM[Distinct even-incidence tuple family]
  ODD[Odd tuples with verified clause loads]
  CERT[Sound FKO tuple certificate]
  ROOTCERT[Sound rooted spectral refutation]
  ONE[One verified odd tuple]
  LOCAL[Capped maximum-overlap growth]
  ROOT[Rooted Kikuchi operator and defect data]
  WALK[Labeled signed killed walk]
  FREE[Labeled degree-normalized non-killed walk]
  START[Classical stationary start on good random inputs]
  ELIG[Necessary root-balanced parity eligibility]
  EXAMPLE[Finite nonempty retained label cycle]
  KILL[Suppressed killed-history output on good random inputs]
  DIRECT[Direct identity or Walsh planar-matchgate route]
  MOM[Normalized even trace moment]
  UPPER[Certified global spectral upper bound]
  DOUBLE[State plus sign-parity bit]
  TENSOR[Compatible tensor basis and tractable contraction]
  QUANT[Costed coherent walk and useful output]
  CNF -. U1: geometric discovery .-> GEOM
  GEOM -->|V1: sign filter| ODD
  ODD -->|V2: verify inequality| CERT
  CNF -->|V3: declared policy| LOCAL
  LOCAL -. F1: restricted failure .-> GEOM
  CNF -->|V4: rooted construction| ROOT
  ROOT -->|V5: row queries| WALK
  WALK -->|F2: sampler-specific bound| KILL
  ROOT -->|V9: change normalization| FREE
  ROOT -->|V11: rejection preparation| START
  START -->|V12: classical walk start| FREE
  FREE -->|N1: output invariant only| ELIG
  EXAMPLE -->|E1: finite feasibility only| ELIG
  FREE -->|V10: negative return only| ONE
  FREE -. U5: mass and coverage .-> ODD
  CNF -. F3: direct route fails prerequisites .-> DIRECT
  WALK -->|V6: expectation identity| MOM
  WALK -->|V7: negative return only| ONE
  ONE -. U4: yield and coverage .-> ODD
  MOM -. U2: accuracy and proof .-> UPPER
  UPPER -. U3: all defect terms .-> ROOTCERT
  WALK -->|V8: parity double cover| DOUBLE
  ROOT -. S1: tractable basis unknown .-> TENSOR
  DOUBLE -. S2: implement and extract .-> QUANT
```

ROOTCERT is the complete rooted spectral certificate, distinct from the FKO tuple certificate CERT. V7 ends at one odd tuple; the unproved U4 edge must supply sufficient yield and verified clause coverage before V2 applies.

| Edge | Evidence and exact scope | Cost or outstanding obligation |
|---|---|---|
| V1 | Conditional sign filtering for a sign-blind selected family; FKO already uses this architecture. [S3065](2026-09-11-adaptive-fko.md) | Distinct tuple IDs, sign access, load checks; the probability theorem does not discover the family. |
| V2 | Given tuples and a certified spectral bound, the strict FKO inequality is pointwise sound. [S3064](2026-09-11-fko-discovery.md) | Compute imbalance, loads and a directed numerical upper enclosure; reject if the inequality is not established. |
| V3/F1 | Exact capped, maximum-overlap, uniform-tie, sign-blind policy is defined; its fresh-restart failure at K=Theta(n^(1/5)) is restricted to that policy and random model. [S3066](2026-09-11-focused-growth.md) | Charges failed attempts; does not cover larger exploration followed by pruning or history-based priorities. |
| U1 | Short useful tuple families exist at the FKO scale; our efficient finder is missing. | Support, distinctness, sufficient normalized mass and full construction time. |
| V4 | Existing rooted operator construction accounts for every input clause. [Operator source](2026-09-11-global-fko-sources.md) | Implicit input is compact; dimension binom(n,ell), diagonal trace and defect sums remain charged. |
| V5/V6 | Channel-labeled killed walks have polynomial local queries; signed return expectation equals tr(H^(2p))/N. [S3067](2026-09-11-global-fko.md) | Number of walks, length, exact transition probabilities, precision and failures. An expectation identity is not an upper certificate. |
| V7 | A negative closed 2p-step rooted walk reduces to at most 4p original clause IDs with odd parity. [S3067](2026-09-11-global-fko.md) | Verify original labels; no lower bound on useful return frequency or packing coverage. |
| U4/U5 | One verified tuple is not yet a useful family. Neither non-killed normalization nor stationary preparation establishes aggregate weighted return mass. [S3070](2026-09-11-nonkilled-return.md) | Bound nonempty root-balanced, retained-realizable parity-return mass and capacity-controlled outputs. An inverse-polynomial mass targets polynomial sampling; a weaker quantified improvement over existing search is also meaningful. |
| V11/V12 | Uniform state/root rejection samples classical pi(S) proportional to retained degree. On the specified iid-input and uniform-root good event, expected proposals are O(n^(13/5)), each polynomial work. [S3070](2026-09-11-nonkilled-return.md) | Shared input exception is o(1); finite caps report no output. This proves classical access, not useful return mass or efficient coherent preparation. |
| N1 | Every closed-history selector q obeys Bq=0 and Rq=0. This is necessary eligibility, not a generator or sufficient retained realization. [Retained-cycle audit](2026-09-11-retained-cycle-audit.md) | A fixed degree-two e-clause cover survives independent random rooting with probability PM(dual)/3^e <=3^(-e/2). No aggregate scarcity or adaptive-cover bound follows. |
| E1 | The finite four-clause K4 dual example has two parallel retained channels with a nonempty label cycle. [S3070](2026-09-11-nonkilled-return.md) | Establishes feasibility only, not random-input frequency, short useful mass or coverage. Preserve channel labels rather than only aggregated matrix signs. |
| F2 | On the specified iid-support, independent uniform-root good event, killed-history output is at most exp(-Omega(n^(1/5) log log n/log n)) per trajectory. [Reviewed S3069](2026-09-11-interference-extraction.md) | Shared input exception is only o(1). Uniform over starts on that fixed operator; standard tagged-sampler amplification is scoped separately. Not an interference or quantum lower bound. |
| V9/V10 | Normalize by retained degree instead of G+d_*, retaining channel labels; a negative closed L-step return still gives one verified odd tuple of size at most 2L. [S3069](2026-09-11-interference-extraction.md) | Restart isolated rows; charge row queries and readout. This is a different operator, so H_ref trace and spectral bounds do not transfer. |
| F3 | The direct incidence-network identity/Walsh standard planar-matchgate attempt fails its signature/topology prerequisites. [Holographic companion](2026-09-11-holographic-extraction.md) | Does not exclude arbitrary bases, gadgets, other representations or specialized coefficient methods. Code-enumerator reformulation alone has no cheaper contraction. |
| U2/U3 | Statistical trace accuracy and complete pointwise refutation are different contracts. [S3067](2026-09-11-global-fko.md) | Dimension-dependent accuracy for the chosen moment route, independently sound upper proof, and every global defect term. |
| V8 | Familiar signed double cover records cumulative sign as a bit. | Twice as many graph states; does not itself accelerate finding an opposite-sheet return. |
| S1 | Holographic transformations can preserve tensor contractions under compatible changes of basis. | No simultaneously tractable transformed signatures/topology or cheap certified contraction has been shown for this operator. |
| S2 | A signed graph can define a coherent quantum evolution under an explicit implementation. | State preparation, oracle construction, normalization, evolution time, accuracy, measurement and usable certificate extraction are unproved here. |

## What holography or interference would add

A meta-graph can immediately make research more useful by retaining transformations, failed hypotheses, source links, costs and output guarantees. Adding an edge requires evidence; an earlier failed route is not silently restored by renaming its representation. Nodes in this ledger are different kinds of objects, so their adjacency is not automatically a unitary or Hamiltonian.

For the actual signed walk there is a more concrete, already known graph construction. Replace each state S by (S,0) and (S,1). A positive channel preserves the bit and a negative channel flips it. A negative closed walk in the original graph becomes a path from (S,0) to (S,1). For positive and negative adjacency parts A+ and A-, the lifted adjacency is A+ tensor I + A- tensor X. This is the standard signed double cover, not a new mechanism. [Brown et al., Section 5, equation 25](https://arxiv.org/pdf/1211.0505).

A sign-basis change separates the unsigned and signed sectors. It makes cancellation explicit; it does not prove that a useful negative path can be found or read out cheaply. A quantum walk would require an implementable normalized evolution and a success/output analysis. The current killed classical walk is not itself unitary, and a research-ledger edge is not a physical transition.

Here 'holographic' has a precise algorithmic meaning, distinct from physical holography. Valiant's Holant theorem preserves the appropriate global sum under compatible local basis descriptions, while matchgate constructions can make that sum a tractable weighted perfect-matching/Pfaffian computation in the required setting. Arbitrary tensor networks do not become easy simply by changing basis. All transformed local constraints must fit a tractable class together, with the required topology, and the basis and contraction must be obtained at charged cost. [Valiant, Theorem 4.1 and matchgrid definitions](https://people.seas.harvard.edu/~valiant/holographic11-07.pdf).

The useful open research question is therefore specific: can a representation change expose a simultaneously tractable global computation while preserving the needed all-input certificate or sufficiently detectable output? No such transformation or interference advantage has been established for these FKO instances. The graph records that obligation; it is not a proposal to run a new experiment or draft a paper.

## S3069 update and live boundary

The reviewed killed-sampler result diagnoses the chosen normalization, not intrinsic witness sparsity. The separate FREE node removes that normalization penalty while preserving original-clause witness verification. V10 still ends at ONE, and U5 remains unproved: return probability must exclude parity-empty backtracking, and enough useful outputs must survive clause-load checks. The extra edge to ODD is an unresolved combined yield-and-coverage obligation, not a demonstrated transformation.

The holographic companion checks a direct coefficient representation of short odd tuples. Its identity/Walsh and direct-planarity failures are F3 only; S1 remains speculative rather than refuted. Neither a changed basis nor the non-killed walk is recorded as an improved FKO finder. An improved random-input finder would still lack the worst-case bridge needed for P versus NP.

Evidence: [main derivation and three-lens table](2026-09-11-interference-extraction.md), [prior quantum output contract](2026-09-11-interference-prior-art.md), and [direct holographic assessment](2026-09-11-holographic-extraction.md). [Final independent claims-scope inspection](2026-09-11-interference-nonclaims-review.md) is GO for this ledger update; no executable graph, experiment or novelty conclusion is added.

## S3070 update: eligibility and classical access, not a finder

N1 is an invariant edge: it says what every output must satisfy, not that the walk efficiently produces such an output. Ordinary even-cover existence is insufficient to establish root balance or retained realization. The fixed-cover perfect-matching calculation cannot be applied to a root-adaptively selected family, nor can its exponential suppression be summed without accounting for all candidates. E1 explicitly rules out an all-cycles-cancel interpretation while making no distributional claim.

V11 closes a classical preparation-cost obligation on the declared random good event. It does not establish a quantum state-preparation advantage. U5 remains the substantive unresolved aggregate mass-and-coverage transition, and no new finder or novelty claim is recorded. No next sampler variant is selected. See the [main three-lens table](2026-09-11-nonkilled-return.md) and [global-alternatives comparison](2026-09-11-nonkilled-alternatives.md). [Final independent non-claims inspection](2026-09-11-nonkilled-nonclaims-review.md) is GO for this graph update.
