# Computable count: independent source-only preflight

2026-09-12. Reviewer `threshold_complexity_review`; no authorship of the reviewed count code. Candidate `fd834dbc268361483820db17fc36ee25a85575a5`. S3130/S3131 under S3126.

**Result: no additional mathematical or constructor defect identified by source inspection. Kernel acceptance is INCOMPLETE.** This is a static preflight, not a three-lens GO, an independent successful build, or certification of Checks.

## Scope and evidence

Read both ComputableSampleCount modules, their formalization receipt, the destination INTEGRITY-CLAIMS ledger, and archived manuscript lines 647-693 and its learning log-12 refinement. The applicable planning three-lens and claim-boundary protocols remain binding; no destination root AGENTS.md is present. Also inspected the pinned Mathlib/Data/Nat/Log.lean definition of Nat.clog, rather than inferring computability from the new definition's name.

All three candidate working files equal the frozen Git blobs after CRLF-to-LF normalization. Git LF SHA256:

| File | SHA256 |
|---|---|
| `lean/PvNP/RealizableHardness/ComputableSampleCount.lean` | `d611b5fe4b3770b27aeb05deb690fcc160948b96e6268fea681288cf6c26fac9` |
| `lean/PvNP/RealizableHardness/ComputableSampleCountChecks.lean` | `be871d6e381a479897b871a7caa57c6982862756606156fb940bfdf7f8b27bf5` |
| Formalization receipt | `7bc32cfc5e458c8a1c966bd2e28fd7b61e61fa8bf0b8895696557c51d473a13e` |

No compiler, evaluator, download or capacity-recovery action was run for this review. Main exit zero is author-attributed evidence; revised Checks is explicitly unverified after the resource stop.

## Specific assessment

- The constructor uses natural multiplication, squaring, Nat.clog and exponentiation. In the actual pinned library, clog recursively sends n to `(n+b-1)/b` when b>1 and n>1, with a proved decreasing argument. At base 2 this is a terminating natural recursion; no real comparison, Nat.ceil on reals, classical selection, or assumed bound is called by count. Importing analytic proofs in the same module does not make these definitions depend on computing real values.
- Its target is exactly `32*(N+11)*P^2`. From positive eps and `1/eps<=P`, both sides of the reciprocal inequality are nonnegative, so the square comparison is valid. The analytic threshold upper bound then gives log-12 threshold <= target <= count. The log-6 threshold follows by monotonicity. The casts preserve natural products/powers. No eps<=1 premise is silently used.
- The strict doubling bound correctly requires P>0, which makes target>1 and clog positive. The predecessor exponent argument is valid. P=0 deliberately gives count=1; positive eps makes the inverse-bound premise impossible there. Thus there is no claim of a useful confidence guarantee at an invalid zero inverse bound. N=0 remains meaningful and is included.
- The factor 2 for the two-sided tail and the assignment factor 2^N are already present in the imported threshold budget. The new constructor dominates the log-12 threshold, hence supplies a numeric factor <=1/6 and also <=1/3. It does not accidentally spend both confidence budgets independently or assume an HN transfer failure bound.
- The constructor is a conservative replacement, not an implementation of the archived exact least-real-threshold count. The difference is substantive even for small inputs: the checked target at N=0,P=1 is 352 and the proposed count is 512, whereas the log-12 threshold at eps=1 is 32*log(12). No equality theorem to the archived selection is stated. The existing receipt correctly requires manuscript/algorithm reconciliation before this replacement is used in the final artifact.

## Required closure, with no invented success

1. Run the final revised Checks to terminal success after capacity permits; verify the three named concrete equalities (512, 2048, 1), the three executable evaluations, and all 17 axiom queries. The present source provides plausible explicit clog inequalities for the nonzero examples, but source reading cannot certify their elaboration. Do not treat the earlier 14 profiles or a resource-terminated process as a successful audit of the revised candidate.
2. Compose the actual count with the sampler's concentration theorem. `base_budget` and `learning_budget` bound numeric expressions; no generated-list event or probability appears in their conclusions.
3. Supply a computed input-size-controlled P and the original-variable/support bounds, then the encoded machine/bit-cost argument. A natural result polynomial in N and P does not prove these parameters are polynomial in the source encoding. No new hidden obligation beyond those already retained was found here.
4. Reconcile the final manuscript's exact count selection with this conservative constructor, retaining its power-of-two and confidence properties. This is required correspondence work, not a new theorem of exact leastness.
5. Obtain the required fresh independent three lenses after the candidate's scoped exports and audits are green. This preflight cannot substitute for that closeout.

No candidate source, author receipt, publication artifact or other review was modified. This file alone records the static preflight. S3130/S3131 and full S3126 remain open.
