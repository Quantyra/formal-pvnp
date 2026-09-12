# S3127 finite repair: independent complexity review

2026-09-12. Top-level complexity-theory-reviewer, assigned directly by the
planning orchestrator. Verdict: **GO-WITH-NOTES for the bounded semantic
increment; full S3126 certification remains open**. No blocking complexity
defect found in the reviewed theorem statements or their correspondence to
the exception lemma. This verdict does not certify the manuscript's full
hardness theorem, its computational reduction, or its learning corollary.

## Frozen scope and method

Reviewed commit `1693d167b1e3e23b229ac4c70418c0fead54798a`, specifically
`lean/PvNP/RealizableHardness/{ExceptionRepair,Formula,Checks}.lean`, the
repair-formalization note and the dependency assessment. HEAD matched the
requested commit and the three source files had no diff against it.
Read satellite `INTEGRITY-CLAIMS.md`, planning S3127 and the formal three-lens
closeout protocol. Read the public manuscript's conventions, theorem
statements and complete explicit-list exception lemma. The manuscript
checkout HEAD was `419736bb99fac4c6fb71e9fc12cd3bab66fe307a`; its manuscript
has no diff from ledger target `bb1eaecd8067407c6a39414f57a631dfd810de9d`
and SHA256 remains
`ff00997c8c243e88982c41b0b0e24faaaafe36cec6f1903824599dc242538686`.

This is an independent source/statement complexity review. No compiler was
launched: the implementation's successful pinned compilation and 13 axiom
profiles are supplied build evidence, while independent proof/build review
belongs to the parallel proof-adversarial lens. No source, manuscript,
dependency, shared Audit, commit, or remote was changed by this lens.

## Correspondence checked

| Obligation | Finding |
|---|---|
| Indexed explicit list and duplicates | `I -> Formula V` and `Fintype I` count indices, not distinct formula values. `Sum.inr i` gives each index its own exception coordinate even when formulas repeat. `Nonempty I` is required for completeness and normalized output weights. The broader soundness lemma also permits empty indices; this does not remove the nonempty requirement when assembling valid manuscript instances. |
| Formula syntax and leaf bound | Positive variables and binary AND/OR match the manuscript syntax. `rename Sum.inl` preserves old variable identities. `leaves_repair` counts occurrences and proves precisely old leaves + 1; `repair_complete` propagates the at-most-L bound to L+1. There is no unproved claim that a shared DAG size equals leaf count. |
| Rational weights and actual cost | `repairedWeights` implements old raw weights and fresh raw `lam/card I`, divided by `1+lam`. `repairedWeight_eq_sum` connects aggregate semantic cost to the selected output coordinate sum. With positive old weights, positive lambda and nonempty indices, positivity follows; with old sum one, output sum one follows. |
| YES quantifiers | Given an actual original witness, `exception_completeness` constructs its complement-of-acceptance exception assignment and proves both repaired budget and satisfaction of every index. Formula construction itself does not take that witness or failed-index set. This is an existence proof, not a SAT or counting oracle in the constructor. |
| NO quantifiers | `Formula.repair_sound` takes arbitrary `y : Sum V I -> Bool`, splits it into arbitrary old and exception assignments, and uses an explicit universal source NO promise. It does not restrict NO assignments to those arising from the YES repair rule or to efficient assignments. |
| Gap and threshold | The formula theorem uses natural-number `sig / 4` before rational coercion: the exact floor, not rational division. `sig >= 8` is present. Its result is strict acceptance `< 2 * gam`; the source NO comparison is also strict. |
| Soundness accounting | Under `eps*sig <= gam/2`, lambda*epsilon is at most s/2. Expanded raw cost is at most 3*sig*s/8. Nonnegative old/exception costs place the old part inside the source NO budget and bound exception fraction by 3*gam/8. Boolean OR subadditivity then gives a strict bound below 11*gam/8 and hence 2*gam. This is the manuscript argument. |
| Budget and parameter domains | Separate lemmas prove positive t and t <= 1. Under the manuscript hypotheses, lambda > 0, epsilon <= 1, floor(sig/4) >= 2 and 0 < 2*gam < 1. The local soundness theorem intentionally needs fewer hypotheses, so it alone does not assert these domain conclusions. |

The general semantic soundness theorem allows nonnegative old weights and
positive rational sigma/gamma; this is a legitimate stronger algebraic
statement. The formula wrapper restores natural sigma and its floor.
Omission of `gam < 1/2` from that wrapper is not a soundness error: the
inequality is valid beyond the promise-problem domain. A final instance
constructor must restore the upper threshold bound and all other validity
requirements together.

## Actionable notes and acceptance boundaries

1. **Assemble the valid-instance bridge before citing a complete formal
   exception reduction.** The present result is a collection of semantic,
   formula and normalization theorems. Add an encoded indexed-instance
   definition and a theorem bundling nonemptiness, positive normalized
   rational weights, `0 < t <= 1`, integer positive floor gap, threshold
   in `(0,1)`, L+1 leaf bound, YES and universal NO preservation. In
   particular derive epsilon <= 1 from the exact manuscript hypotheses;
   do not silently treat the weaker hypotheses of `repair_sound` as the
   complete valid-instance domain. This is a future assembly obligation,
   not a blocker for the accurately described semantic increment.

2. **Do not equate finite/noncomputable definitions with a certified
   algorithm.** The finite sums, rational arithmetic and formula constructor
   are mathematically appropriate. `Fintype` data and `noncomputable`
   declarations do not provide a machine, bit encoding, input/output length
   bound, or polynomial-time proof. Provide enumeration/encoding bridges
   for N old and M indexed fresh variables, list copying/renaming, rational
   operations and output size. The explicit-list precondition matters:
   this theorem cannot justify traversing an exponential implicit support.
   Sampling and its bounded-randomness, simultaneous-success guarantees
   remain separate obligations.

3. **Separate bit length from numeric denominator magnitude.** Rational
   output weights are proved, but polynomial bit lengths and
   inverse-polynomial lower bounds are not. In particular, arithmetic
   closure in the rationals does not establish the final theorem's
   polynomial-magnitude common denominator. The planned upward rounding,
   renormalization, clipped budget and associated extra gap loss require
   their own proofs and an explicit size convention. Neither normalization
   nor the 13 standard-axiom profiles discharges these claims.

4. **Keep the source promise distinct from source hardness.** `hno` is an
   honest input promise, and no NP assertion is obtained from it. The
   scoped import chain uses the finite rational/formula development rather
   than the umbrella's True-valued complexity stubs. Full certification
   still requires actual NP semantics, a verified NP-complete source,
   randomized polynomial many-one reductions and composition, the listed
   PCP/Grassmann/decoding/compilation contracts, asymptotics and the exact
   bounded-advice learning transfer. Clean axiom profiles for a theorem
   with these facts assumed would remain conditional.

5. **Preserve the fixed-parameter quantifier order.** The dependency ledger
   correctly fixes sufficiently large L before choosing its reduction
   machine and polynomial bound. It need not supply a uniform L-to-machine
   algorithm or an exponent independent of L. The finite lemma introduces
   no incompatible uniformity claim; it also proves none of the eventual
   parameter limits or family-of-reductions conclusions.

The implementation note already acknowledges these limits. The dependency
ledger is a suitable open-obligation plan, not evidence that those modules
are proved. The one-coordinate YES and NO checks demonstrate meaningful
source promises; they are not tests or certification of reduction runtime.

## Closeout recommendation

Accept S3127's explicitly bounded finite semantic repair increment once
the other required independent lenses and build receipt are recorded.
Retain the above assembly, encoding, rounding and hardness obligations in
the full-goal ledger and dependent stories. Do not close S3126 or describe
Theorem 1/Corollary 2 as fully Lean-certified on this basis. No new research
mechanism, public claim expansion or implementation redesign is required
by this complexity review.
