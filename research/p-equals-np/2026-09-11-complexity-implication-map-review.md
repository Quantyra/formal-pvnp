# Independent implication-map review

2026-09-11. S3051 / E014 / E004, under `INTEGRITY-CLAIMS.md`. One independent reviewer applies source/proof, complexity and non-claims lenses. No new proof, experiment or publication claim.

## Review criteria

Every edge must identify its direction and scope. Sufficient conditions are not automatically necessary or equivalent. P=NP implies NP is contained in BQP and collapses PH to P; consequently NP not contained in BQP, or PH not contained in BQP, is sufficient for P!=NP. Neither separating BQP from P nor separating BQP from PH is known by itself to settle P versus NP.

Quantum SAT plus an appropriate deterministic classical simulation is an AND gate, not two separate routes to P=NP. The SAT decision algorithm must be uniform, polynomial in the explicit input length, and correct with bounded error on both SAT and UNSAT. The deterministic simulation must preserve its acceptance gap within polynomial bit/time cost. Randomized approximate sampling generally yields a randomized classical algorithm; nonuniform simulation gives a different circuit/advice statement. Restricted promises, uncharged state preparation or exponential precision cannot silently supply the missing general algorithm.

NP not contained in P/poly and NP!=coNP are sufficient for P!=NP; their converse directions are not known. Cook–Reckhow requires nonexistence of any polynomially bounded system, not a lower bound for one selected proof system. The same distinction applies to a restricted circuit representation or a single proposed search procedure. Oracle separations stay relativized.

The S3049 dated source review supports reuse of these standard relationships; it does not certify novel research targets or prove that a major class separation is easier than P versus NP. A bounded bridge audit may inspect a conditional route; an active attempt to prove its major unresolved premise is a different task.

## Final disposition

Read the [map and 15-edge ledger](2026-09-11-complexity-implication-map.md) in full. The diagram's arrows express proposition implication, not class containment unless written inside a node. Its conjunctions correctly require both premises. E1–E15 pass the logical review, including deterministic SETH to ETH, quantum ETH to classical ETH, and the negated Cook–Reckhow equivalence. No false converse was found.

The same-family bridge is operationally sound: acceptance at least 2/3 versus at most 1/3, with deterministic additive estimation error at most 1/12 and threshold 1/2, yields a deterministic correct decision. That is sufficient and does not require exact full-state simulation. Its input, uniformity, circuit generation and bit-precision costs are explicit. A randomized estimator instead supports a bounded-error randomized algorithm under its corresponding success guarantee.

The proposed Q8 strategy is a theorem-scope/novelty audit, not an active proof effort or an identified SAT algorithm. The requested nonvacuity correction was verified in the final map: current QAOA success can be much smaller than 1/12, so a zero estimate can meet constant additive error without distinguishing SAT. An instance-scale additive or relative target may be required for a particular use and can radically change simulation complexity. The hypothetical constant-gap decider's accuracy budget cannot be transferred as a usefulness guarantee to these circuits. The final map also explicitly requires randomized estimation success at least 2/3 on every input and supplies the input-length convention for the one-way-function edge.

| Lens | Verdict | Scope |
|---|---|---|
| Source/proof | GO | Reuses S3049's checked standard sources; the 15 edges are elementary compositions/contrapositives or the stated Cook–Reckhow equivalence, not new theorems. |
| Complexity | GO | AND gates, uniformity, promise/error/precision limits and one-system versus universal lower bounds are distinguished. Missing arrows mean no established implication, not impossibility of one. |
| Strategy/non-claims | GO for a bounded audit | No claim that grand separations are easier. A proposed restricted-simulation scope check requires useful accuracy and a concrete missing result; it does not supply the unresolved general SAT decision premise or activate new execution. |

The map preserves S3048's construction-specific STOP and S3050's combined-publication HOLD. The next action, if selected, is only one bounded comparison against an exact existing simulation theorem; do not launch a broad simulator, proof or publication campaign from an implication arrow.
