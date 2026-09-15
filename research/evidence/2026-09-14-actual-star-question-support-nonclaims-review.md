# Actual star question support: non-claims-boundary review

S3126/S3137; 2026-09-14. Top-level non-claims-boundary lens. This review inspected the exact live and frozen Lean sources, the locked contract, the preceding mathematical audit, and the author attempt-09 execution evidence. It did not compile or edit Lean source.

**Verdict: GO-WITH-NOTES for the bounded finite-incidence increment and its author diagnostic evidence.** The two proved theorems establish only a generic support-intersection fact under explicit `hlinear`, `GoodQuestion`, and excluded-row hypotheses. They do not formalize an actual geometric source, the later private-coordinate/span/gluing/transport/descent chain, an emitted star constructor, repeated-representative coherence, joint acceptance, a switching lemma, any Frege/AC0/circuit lower bound, P=NP or P!=NP, the complete manuscript theorem, or publication readiness.

## Exact reviewed bytes and evidence

- Live and frozen main `ActualStarQuestionSupport.lean`: SHA256 `d61e78cc98be9bff83e9f779b950dfed48aa8fa629efde5f6fd147e97442b8a5`. The live source is byte-identical to the source compiled in the main author run.
- Live and attempt-09 frozen `ActualStarQuestionSupportChecks.lean`: SHA256 `8a79467f322e86f43a144397d9f7ac4f21d821623a97c492abd64d73b76d4203`. The live source is byte-identical to the source compiled in attempt 09.
- Corrected contract `research/evidence/2026-09-14-actual-star-joint-labeling-next-contract.md`: SHA256 `fef7d441dae02a56c92bd6d6cdb09dfea126176234a6581f64b892ccc8210974`. Its preserved pre-correction packet is separately identified in that contract as SHA256 `36fae8a6b1f037b0680a38d4a0c1360b1d4310d1e41103253e0eb81060651c0d`.
- Mathematical audit `research/evidence/2026-09-14-actual-star-coherence-adversarial-audit.md`: SHA256 `f0197561fe046ffb15c05f29926d4176014478b024f19b03027ea38acd823e05`.
- Main author raw log: SHA256 `361b3650ce338bfccd14d306d6f356b8ef84f2d4e14f8a978807d05bf39fc897`; terminal: SHA256 `5fbb6bb045e7268f0b0e9ee9b1ea6ef7993d54557afe42f14f03a8c6a0ddaa1a`. The terminal records exit code 0, unchanged source, complete required outputs, and `diagnostic_only: true`.
- Attempt-09 Checks raw log: SHA256 `882f91afc6e3245167a74347b593037080a7135accca1934d8889effce37c492`; terminal: SHA256 `d88975f8785112590e1cd6ec33720ebfa52cea47edd35adec5b518727676c7eb`; telemetry: SHA256 `110481b4e7705cea6cd7df5e2881b650ac9b6b7b7e6f1a07239f34d8e32b22c0`; executed plan: SHA256 `b0c4db8450df86ae5dce78fae2f2960469280344a40beb51659c2bfdcf0f4b27`; runner: SHA256 `df01be1856ead5d93f1d72c80eb902b033c139a5f5a896be060e3a008738726a`. The terminal records exit code 0, unchanged source, no guard stop, and `diagnostic_only: true`.

Attempt 09 has a chronology caveat. `verifier-result.json` SHA256 `76aa613117a21cfe6d0ee9b7b8130ff8d5a584873f7af8d49d1d0cf4c1468f8b` records the earlier disabled-wrapper verification and says no compiler ran. It is valid preparation evidence only. The subsequently modified authorized plan and the actual terminal/raw log are the evidence for the successful author execution. Descriptions must not cite the stale verifier result as proof of the run or present the whole directory as one immutable packet without explaining this sequence.

## Formal and source boundary

The main defines `questionSupport` as a finite union and `GoodQuestion` as pairwise disjointness plus the full no-cross condition. It proves:

1. two points of an excluded row that both lie in the selected support are equal; and
2. consequently, an excluded row intersects that support in at most one point.

These statements retain every material premise. They make no source-instantiation, row-size-three, right-hand-side, probability, label, transport, acceptance, or hardness assertion. The four Checks cover empty support, a one-point overlap, a disjoint excluded row, and a two-point counterexample when the no-cross part of `GoodQuestion` fails. Ordinary kernel `decide` is used in finite examples; `native_decide` is absent.

Raw `#print axioms` output for each theorem is exactly:

```text
[propext, Classical.choice, Quot.sound]
```

This is the expected standard imported profile. Direct token inspection of both exact source files found no `sorry`, `admit`, `axiom`, `native_decide`, `unsafe`, or `opaque`. Both raw logs contain zero errors and zero compiler sorry warnings. The main raw log has one unused-section-variable warning for the explicit `[Fintype X] [Fintype E]` context of `excluded_row_points_eq`; attempt 09 has 25 unused-simp-argument warnings. These warnings do not add assumptions or weaken statements. Exit code alone is not being used to infer the axiom profile.

## Allowed wording

The following formulations stay within the evidence:

- "Lean proves a bounded finite-incidence lemma: under global pairwise row linearity and the explicit `GoodQuestion` no-cross condition, an excluded row meets the selected question support in at most one variable."
- "The exact main source `d61e78cc...` and Checks source `8a79467f...` compiled successfully in author diagnostic runs; both general theorems print exactly the standard profile `propext`, `Classical.choice`, and `Quot.sound`."
- "Four finite checks exercise the empty, one-overlap, disjoint, and inadmissible two-overlap boundary cases."
- "This increment supplies the first support-combinatorics component specified by the corrected next-contract; source instantiation and the geometric/coherence chain remain open."
- "The manuscript-level audit gives a conditional mathematical route under imported geometry and transport lemmas; this Lean increment does not certify those imports."

## Blocked wording

Do not say or imply any of the following:

- that `ActualStarQuestionSupport` formalizes the actual MZ/Grassmann geometric source, its quotient vertices, side-condition alphabets, representative sampling, or source distribution;
- that the actual occurrence/gadget/regularized source has already been connected to `GoodQuestion`, even though the contract identifies candidate upstream support and linearity interfaces;
- that private coordinates, span intersection, side-condition agreement, gluing, inverse transport, presentation descent, repeated-representative equality, or full star coherence are Lean-proved;
- that one global labeling jointly accepts all stars, or even that an actual emitted star/query has been constructed and accepted in Lean;
- that the generic Star formula compiler is now instantiated by the actual source or that every emitted query compiles to `some`;
- that a switching lemma, Frege lower bound, AC0 lower bound, circuit lower bound, PHP lower bound, P=NP, P!=NP, or any resolution of P versus NP follows;
- that the complete manuscript theorem is formalized, independently accepted, submission complete, publication ready, or ready for public announcement;
- that attempt 09 is an independent rebuild or three-lens route acceptance; it is an author diagnostic execution reviewed here only for claims boundaries;
- that `verifier-result.json` certifies the successful attempt-09 compile, because it predates execution and explicitly records a disabled runner.

The appropriate route status is therefore a reviewed, compiled local lemma pair with clean standard axiom profiles and useful negative/positive finite checks. The next-contract itself accurately marks the remaining source-instantiation and geometric proof chain as future kernel obligations; those boundaries must remain in every planning, audit, manuscript, release, and announcement description.
