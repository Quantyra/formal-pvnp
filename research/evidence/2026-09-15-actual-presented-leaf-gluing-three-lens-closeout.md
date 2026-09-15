# Actual presented-leaf gluing three-lens closeout

Date: 2026-09-15. Result: **ACCEPTED WITH NOTES**. This post-certification closeout joins the frozen source, target-fresh cloud certification, and three independent top-level reviews. It is deliberately outside the immutable in-run manifest; the original certification receipt remains byte-for-byte unchanged.

## Frozen increment

- Source commit: `e599567a629f6e4eb960b4b2543960095293d1d3` (`prove actual presented leaf gluing`).
- Certification commit: `6422609d04c6632035892431b7c77af0b6db7b08` (`certify actual presented leaf gluing`).
- Main source SHA-256: `D19126D4962A13AF182462F56548FE74252100108D5BC1C9EF1C51EAEEBD1452`.
- Checks source SHA-256: `E76DB5B1AF64E31131E785CAB057F194DF3428CE67E159693C61EE3B4AB0564E`.
- Cloud main object SHA-256: `3AE5AB5229E44A73D0AB545987E93E028E5F0C522DF88149ED10983F51E82C4B`.
- Cloud Checks object SHA-256: `A6F2D6F0D0B023265916D4BD7F58DDE23D9A35F1A1A34208D65BE96538D31165`.
- Canonical in-run `artifact-hashes.txt` SHA-256: `3EADD48379297AAD61EF5ADF24D73498770D1529A32969D008FE6D742E502BED`.
- Original certification `closeout.md` SHA-256: `2EF5C4A96813E6B7EAFA82F2AD7A3C138FE30F05D5420C2C399EDA8AF06C51CD`.

The increment defines the actual-source `PresentedLeaf`, `RawLeafLabel`, `LeafVertex`, and `LeafLabel` carriers and discharges these public theorem statements at their frozen signatures:

```lean
theorem H_eq_of_domain_eq
    (P Q : PresentedLeaf I J h)
    (hD : P.domain = Q.domain) : P.H = Q.H

theorem respectsAt_iff_of_domain_eq
    (P Q : PresentedLeaf I J h)
    (hP : P.domain = D) (hQ : Q.domain = D)
    (f : RawLeafLabel I D) :
    RespectsAt P hP f ↔ RespectsAt Q hQ f

theorem actual_existsUnique_gluedLeafRhsFunctional
    (I : ActualOccurrenceAllocation.Instance N m)
    (P : PresentedLeaf I J h)
    (U' : Finset I.RowId)
    (hU' : GoodQuestion I.support U')
    (f : RawLeafLabel I P.domain)
    (hf : RespectsAt P rfl f) :
    ∃! F : ↥(P.domain ⊔ equationSpan I.support U') →ₗ[ZMod 2] ZMod 2,
      F.comp (Submodule.inclusion le_sup_left) = f ∧
      ∀ e (he : e ∈ U'),
        F ⟨equationVector I.support e,
          Submodule.mem_sup_right
            (equationVector_mem_equationSpan I.support U' e he)⟩ =
          I.rowRhs e
```

The Checks module includes meaningful nonempty and empty fixtures. The result is force-bearing because same-domain presentations now give the same equation span and RHS condition, and an actual leaf label extends uniquely over the exact next domain `D ⊔ H_U'`.

## Certification

The content-addressed transfer gate verified the complete Git bundle, exact source commit, clean detached checkout, both frozen source hashes, and source stability before compilation. A new empty target rebuilt the 15-module project-source dependency closure followed by main and Checks; all 17 stages exited `0`. The source scan found no `sorry`, `admit`, `native_decide`, or explicit source-level `axiom`. Printed theorem profiles contain only `propext`, `Classical.choice`, and `Quot.sound`. The canonical 139-row evidence inventory independently rehashed with zero mismatches.

The cloud objects differ from local cached objects because the target-fresh certification ran on Linux while the local cache was produced in another target and operating-system context. The certification relies on exact source provenance, locked revisions, fresh successful kernel elaboration, stable within-run hashes, axiom inspection, and independent evidence rehash rather than cross-platform object-byte equality.

## Three-lens review

| Lens | Verdict | Review SHA-256 | Accepted scope / note |
|---|---|---|---|
| Proof-adversarial | **GO-WITH-NOTES** | `0748B5D68AF81FBD41F002C973429FC0BDBDB7316F4E3DC083579D39614B7DE3` | No proof gap, unsound cast, hidden satisfiability premise, false uniqueness claim, quantifier weakening, forbidden mechanism, or provenance defect found. Add coverage for distinct presentations in the next transport consumer; the exact `2^(2h)` label count remains open. |
| Complexity-theory | **GO-WITH-NOTES** | `CE6BBAACD2321F80D9DD87B4C474F2A4CB5C76FA50FDE3FEB8939F0BAC163179` | Accepts the actual presentation, descent, and unique gluing step. Equivalence, transport/coherence, repeated-address semantics, sampling/stationarity, acceptance, and hardness remain open. `GoodQuestion` sampling and retained mass must be connected explicitly later. |
| Non-claims boundary | **GO-WITH-NOTES** | `4234B5F5DE84017341102C96A4C894B6BBE5A140C64373CC03485A4C1936B392` | Accepts only the bounded formal increment. It does not authorize broader manuscript claims, DOI changes, release, or public announcement. |

No lens returned `INCOMPLETE` or `NO-GO`; no review-debt story is required for this increment.

## Manuscript consumer and remaining path

The immediate manuscript consumer is **leaf equivalence and one-way transport**: use `actual_existsUnique_gluedLeafRhsFunctional` to move an actual label to a related target leaf and prove that the restriction is well-defined.

Remaining headline path:

```text
leaf equivalence and one-way transport
→ identity, inverse, and coherence
→ presentation descent and repeated-address semantics
→ center restriction
→ representative sampler and stationarity
→ actual-star acceptance
→ outer soundness and source hardness
→ reduction/runtime/asymptotics
→ manuscript reconciliation and release package
```

The current increment proves no sampler, stationarity, acceptance, hardness, reduction, `P = NP`, or `P ≠ NP` result.

## Cloud state and cost

- Estimated increment cost: `$0.175266`.
- Estimated cumulative GCP spend: **`$0.340771`**.
- Remaining under the `$250` operational ceiling: `$249.659229`.
- Builder state at closeout: **`TERMINATED`**, private address only, no external access configuration.
- The retained 200 GiB disk continues to accrue an estimated `$0.657533/day` while stopped.

## Canonical evidence inventory

| Role | Path |
|---|---|
| Target-fresh certification | `research/evidence/2026-09-15-actual-presented-leaf-gluing-fresh-run/` |
| Certification receipt | `research/evidence/2026-09-15-actual-presented-leaf-gluing-fresh-run/closeout.md` |
| Proof-adversarial review | `research/reviews/2026-09-15-actual-presented-leaf-gluing-proof-adversarial-review.md` |
| Complexity-theory review | `research/reviews/2026-09-15-actual-presented-leaf-gluing-complexity-theory-review.md` |
| Non-claims review | `research/reviews/2026-09-15-actual-presented-leaf-gluing-nonclaims-review.md` |
| This post-certification closeout | `research/evidence/2026-09-15-actual-presented-leaf-gluing-three-lens-closeout.md` |

This file is the canonical three-lens table and consuming-dependency record for the accepted theorem increment. The original cloud-run manifest remains the canonical content-addressed inventory for certification artifacts created during the run.
