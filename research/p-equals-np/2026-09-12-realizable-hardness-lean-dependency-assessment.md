# S3126 full Lean certification: dependency and acceptance ledger

2026-09-12; S3126/S3127, E004/S008. Preliminary independent implementation
assessment, not the final proof-adversarial/complexity/non-claims review.
This is the authoritative initial full-goal dependency ledger requested by
the implementation agent. Status: **full certification open; concrete
implementation can proceed**. A proved repair lemma is useful progress,
not completion of the full theorem or the submission-paper goal.

## Frozen target and inspected environment

The target is the complete MANUSCRIPT Theorem 1 and Corollary 2, current
public main `bb1eaecd8067407c6a39414f57a631dfd810de9d`, manuscript SHA256
`ff00997c8c243e88982c41b0b0e24faaaafe36cec6f1903824599dc242538686`.
The v0.1.0 archive candidate was `9d839590a18da588915a21c88e2ef9caf2517f26`.
Read the full proof previously for extraction/scope and now reread its
formal target, seven imported contracts and exact dependency interfaces.
Preserved source significance/dependency audits remain mathematical inputs
to the work plan, not Lean proofs. Read S3126 and the local integrity ledger.

Active source HEAD at inventory: `5dc9f2b715f1b388cdfde6bc7021f7865ac327ff`.
Lean 4.13.0; lakefile pins mathlib v4.13.0, manifest revision
`d7317655e2826dc1f1de9a0c138db2775c4bb841`. Before new implementation,
90 PvNP Lean modules had no CMMSA/PCP/Grassmann/rand-many-one formalization
found by targeted source search. `BasicDefs.lean` explicitly has lightweight
stub semantics, including `bounded_degree` and `expander` defined as True.
`MetaComplexity.lean` has literature-assumption scaffolding. Neither is a
faithful complexity foundation for this result. The implementer is already
creating a separate `PvNP.RealizableHardness` namespace; do not replace or
claim unrelated umbrella placeholders as proofs of these dependencies.

## Exact full theorem acceptance target

There must be concrete functions sigma : Nat -> Nat and gamma : Nat -> Real,
with eventual sigma positive and gamma in (0,1), and proved limits
log(sigma L)/log L -> 1 and gamma L -> 0 at infinity. For every sufficiently
large *fixed* L, prove randomized polynomial-time many-one NP-hardness of
the encoded weighted indexed F[L]-CMMSA promise problem with epsilon=0.
The quantifiers put L before the reduction machine and its polynomial;
its exponent may depend on L. No uniform exponent for growing L is required.

A reduction consumes an encoded source instance and a polynomially bounded
uniform random bit string, always computes a polynomial-size output within
a polynomial time bound, and maps a YES (respectively NO) source to a YES
(respectively NO) target with probability at least 2/3. Output indices retain
multiplicity. Weights are positive rationals summing to one; 0<s<=1; YES is
existence of a weight<=s assignment satisfying every formula; NO universally
bounds acceptance strictly below gamma for all weight<=sigma*s assignments.
Leaf occurrences count separately. Prove a polynomial-magnitude common
denominator and required inverse-polynomial lower bounds in the encoded
size/variable conventions. Establish hardness for the actual NP class by
a verified NP-complete source and reduction composition, not by defining
NP to mean problems reducible to this target.

Corollary 2 must use HN's actual universal-program/advice model, including
its randomness-dependent, not necessarily computable advice function,
halting/failure and conditional statistical-distance requirements. Prove
that sufficiently large advice cap a permits
L=a-2*ceil(log2(a+1))-c_U, gap floor(0.49*sigma L), and threshold 5*gamma L.
YES has a linear-time program of bounded description agreeing exactly one;
NO quantifies over *all* programs below expanded description size, not just
efficient programs. The explicit sampler, program-string lengths and machine
overhead require an encoding/simulation proof. A theorem about circuits or
fixed sampler-description length would not certify this corollary.

Final certification requires both conclusions and all transitive dependency
proofs to compile from pinned source without sorry/admit, new theorem axioms,
native_decide or circular assumptions. Record `#print axioms` for the final
FQNs and inspect their definitions and actual hypotheses: standard foundational
axioms only are allowed. A theorem `(h : FullPCPHardness) -> Conclusion` can
have a clean axiom profile and still be conditional. No required source
hardness/decoding/learning assumption may remain as an undischarged argument,
typeclass, structure field or an opaque trusted declaration at final closeout.

## Ordered module ledger and exact missing obligations

Names below are proposed under `lean/PvNP/RealizableHardness/`; status is
pending unless actual compiled theorem evidence is later added. This table
is a dependency plan, not a declaration that future modules exist.

| Module / dependency | Required mathematical and encoding work | Immediate predecessors |
|---|---|---|
| Formula.lean | Positive AND/OR AST, Bool semantics, actual leaf counts, variable relabeling, indexed lists, normalized rational weight/budget, satisfaction fraction and strict promises. Sum variables preserve original/exception identities and repeated indices. | Finset, Fintype, Rat |
| ExceptionRepair.lean | Prove repaired YES witness, raw budget <=3*sigma*s/8, original NO use plus exception-count <=3*Gamma/8, strict acceptance <11*Gamma/8<2*Gamma, normalized budget, one extra leaf, no witness oracle in constructor. Preserve epsilon>=0, sigma>=8 and epsilon*sigma<=Gamma/2. | Formula semantics / finite-average kernel |
| WeightRounding.lean | Least power-of-two D>=8(N'+1)/t; upward a_i, A0, clipped B0; preserved YES and NO with gap floor(sigma_new/2); positive normalized weights and polynomial numeric common denominator. | Rational sums/ceil, size model |
| FiniteSampling.lean | Rational finite distributions, dyadic cumulative rounding with total variation bound, product trials, simultaneous concentration over 2^N assignments, least power-of-two sample count and failure budget; exact final list sampler with bounded coins. | PMF or finite rational probability, concentration |
| Encoding.lean / RandomizedReduction.lean | Bit encodings/decoders and malformed-input policy, input/output lengths, computable constructor runtime, polynomial bounded coins, YES/NO success and composition. Noncomputable choice cannot implement a reduction. | Machine-backed FP/NP or explicit verified bridge |
| Outer3Lin.lean | MZ Theorem 3.1: arbitrarily small fixed positive YES error with absolute NO gap, bounded occurrence and no pair in two equations; prove actual reduction and runtime. Trace this theorem's prior dependencies recursively to verified foundations. | NP-complete source + appropriate PCP/gap machinery |
| OuterGame.lean | MZ Claim 3.2 classical smooth repeated game with shared vector advice and value <=2^(-kappa*beta*J); kappa independent of later YES error. | Outer3Lin, repetition/prover-game probability |
| Grassmann.lean | GF(2) finite subspaces, Gaussian binomial cardinalities and ratios, uniform subspace measures, quotients, dimension/rank identities, transversality union bounds. | Finite field/vector space/mathlib |
| StarPCP.lean | MZ Section 3.3/Lemmas 3.3-3.4: legitimate tuples with both disjointness conditions, equivalence classes and unique transport, weighted star sampler/labels, clique consistency/collision bound, finite enumerable support. | Grassmann, OuterGame |
| GrassmannDecoder.lean | Full MZ Theorem 4.2 proof at exact side conditions: threshold 2^(-2(1-1000*rho)hm), a+c<=10m/rho, lucky mass 2^(-6h^2), agreement C=2^(-2(1-1000*rho^2)h)/5. This is a major imported combinatorial proof, not a generic PCP theorem. | Source theorem's transitive local tests/decoding |
| MaximalPairCounting.lean | MZ Definition 5.4 and MZ24 revision1 Theorem5.26 specialized delta=rho/m, narrow advice/codimension 10m/rho, cutoff and ambient conditions, list bound with constants independent of J. | Source counting/zoom-out proof, Grassmann |
| Covering.lean | KMS Definition4.5/Lemmas4.6-4.7, Section8 unconditional proofs: exact independent triple deletion law, basic and advice-conditioned covering distances, exception mass and 2^d*beta<=1/8. Do not import historical conjectural headline. | Grassmann + finite probability |
| PosteriorZoom.lean | New Bayes likelihood calculation, binomial tail, Markov exceptional sets, conditional rank bound, weighted mixture comparison including division by p0, random-vector coupling and total-table transversality. Preserve actual joint law of V,Q. | Grassmann, Covering, finite probability |
| ThresholdLadder.lean | A nonmaximal pair extends at the next threshold; codimension strictly drops, stop by r, independent threshold guess, actual maximal-pair list bound and extension agreement. | MaximalPairCounting + finite rank descent |
| ModifiedPCP.lean | Instantiate J=2^(2^(A*h^2)), beta=A*h^2/J, choose A before h, rational-dimension integrality, every explicit/implicit eventual bound, soundness contradiction and padding. Choose arbitrary fixed tau only after alphabet R. | OuterGame, StarPCP, Decoder, PosteriorZoom, ladder |
| StarCompilation.lean | HN Lemma4.6: occurrence weights, repeated-variable consistency, <=(m+1)R leaves and quantitative list-decoding soundness coefficient. Provide reduction algorithm and polynomial support. | StarPCP, Formula, source HN proof |
| SecretSharing.lean / LearningTransfer.lean | HN Theorem3.5 and Lemma5.1 in full: recursive L-bit sharing, reconstruction/security, program/universal-machine proof, 0.49 and five constants, advice overhead, zero YES on every transfer seed, bounded NO failure. | Formula, encoded program model, probability, denominator |
| ParameterChoice.lean | Integral h spacing b_m; finite largest admissible m; every fixed m eventually admissible, m(L)->infinity, log R/log L->1; floors/constant losses; all-small-input handling; transformed advice cap. | Limits/log/ceil, all quantitative modules |
| Main.lean / Audit.lean | Compose concrete reductions and discharge every contract; exact final CMMSA and learning statements plus nonvacuity and full dependency axiom profile. | Every module above |

These are missing *formal obligations*, not newly identified mathematical
errors in the reviewed informal argument. General analytic big-O assertions
must become quantified bounds with constants and parameter dependence; an
`exists sufficientlyLarge` theorem still needs its Lean proof. The huge fixed
constants are legitimate, but cannot be left as unproved numeric claims.
Maximal-pair enumeration is a prover strategy, not a computation charged to
the reduction; output support enumeration is part of the reduction and must
have its own finite polynomial bound. Explicit-list repair must never be
applied to an unmaterialized exponential distribution.

## Exact local library reuse

The v4.13 checkout contains `Mathlib.Probability.ProbabilityMassFunction`
Basic, Monad, Constructions, Integrals and Binomial. Actual useful symbols:
`PMF.bind`, `PMF.bind_apply`, `PMF.bind_bind`, `PMF.filter`, `PMF.filter_apply`,
`PMF.bernoulli`, `PMF.binomial`, `PMF.binomial_apply`. Filter needs evidence
that the conditioning event meets support: zero-mass cases cannot disappear.
`Mathlib.Probability.Moments` proves
`ProbabilityTheory.measure_ge_le_exp_mul_mgf` and its lower-tail analogue;
this provides Chernoff infrastructure, not the desired simultaneous
Hoeffding inequality without further proof. Finite rational probability is
also reasonable for the first semantic modules and can later be bridged.

Use Finset sums/cardinality and Bool truth evaluation for ExceptionRepair;
`Mathlib.Data.Rat.Floor` and `Mathlib.Algebra.Order.Floor` for rounding;
`Mathlib.LinearAlgebra.Dimension.Finrank`, FiniteDimensional and Submodule
for Grassmann work; `Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics`
and SpecificLimits for eventual estimates. No exact Gaussian-binomial/
MZ decoder package was found in this pinned local checkout.

`Mathlib.Computability.TMComputable` has `Turing.FinTM2`,
`TM2ComputableInTime`, `TM2ComputableInPolyTime` and identity witnesses.
It is genuine machine/time infrastructure, but the local file's main results
are identity computability, not a ready full NP/PCP reduction library.
Do not confuse `Computability.Reduce`'s computable reducibility with
polynomial-time randomized promise reducibility.

## Current external source reuse: verified scope and limits

The targeted primary-source search found real Lean repositories; it does
not establish that no other formalizations exist. No dependency was installed
or umbrella toolchain changed in this audit.

**Complexitylib is the strongest immediate adoption candidate.**
https://github.com/SamuelSchlesinger/complexitylib at
`6c248df7859f2f245e731c1e07057bf69d165fe2`, toolchain 4.34.0-rc2.
Read actual Classes/PCP.lean, PCP/Defs.lean, Classes/NP/Reduction.lean and
SAT/CookLevin/Assembly.lean, not just README. `Complexity.MapReducesPoly`
requires a concrete f in FP and an all-input semantic equivalence;
`Complexity.NPHard` quantifies all languages in the actual library NP.
`Complexity.SAT.NPComplete_language` follows its concrete machine reduction.
`Complexity.PCP_theorem` states NP equals the union of PCP r q for
constructible r=O(log n), q=O(1). `PCPVerifier` has FP-computable query
positions and a verdict in P, finite coin strings, completeness one and
soundness one half. Thus it could supply foundational Cook-Levin/constant-gap
PCP machinery, but is NOT the exact MZ star arity/alphabet/soundness or
completeness-after-alphabet theorem needed here.

Downloaded its 3,750,299-byte archive into memory for source inspection;
1,687 Lean files, 375-file recursive local import closure from PCP and
CookLevin. A nested-comment-stripped scan of that closure found no `axiom`,
`sorry`, `admit`, `sorryAx` or `native_decide` tokens. This is evidence about
source declarations, not a kernel axiom audit or a successful build. Imported
mathlib/core declarations and metaprogram elaboration have not been certified
by this scan. Actual kernel `#print axioms Complexity.PCP_theorem` and
`#print axioms Complexity.SAT.NPComplete_language` remain adoption gates.
The required toolchain is not installed locally. Its archive contains
Kolmogorov/average-case infrastructure but no matches for Grassmann,
Nanashima, Minzer, Safra, 3Lin/ThreeLin or secret sharing; no exact advanced
import replacement was located. This negative search is bounded, not proof
of global absence.

**Other potential reuse leads, not approved dependencies:**
- https://github.com/YuvalFilmus/grassmann-degree-one at
  `39e1cad52229acd636a88ec992075fe27f99eb42`, Lean4.27.0. Actual Basic.lean
  defines `GrassmannDegreeOne.Grassmannian k` as submodules of finrank k,
  plus projective points and Boolean degree-one functions. Useful finite
  geometry lead; it is not a proof of MZ decoding or KMS covering. No build
  or full transitive axiom audit performed here.
- https://github.com/PierreSenellart/descriptive-complexity at
  `de212562ab27e2577524f6985d161d624dad3c9e`, Lean4.33.0. The project's
  documented NP/FO-reduction route uses logical classes and explicit machine
  bridges; adopting it requires checking those bridges against our bitstring
  randomized/time model. A file named PcpComplete in Computability concerns
  a different computability route according to its location; the acronym
  alone is not evidence of probabilistically checkable proof machinery. Its
  content was not audited here. Do not infer compatibility from headlines.
- https://github.com/tanktechnology/CLRS-Lean at
  `0455d094c3aaeb4f024795f2047a91787ddfb876`, Lean4.32.0-rc1, has concrete
  Chapter34 CookLevin/circuitization source paths. Public documentation is a
  reuse lead, not an audited import. Complexitylib has the closer inspected
  reduction plus PCP interface and should be tried first.

## Concrete next actions and adoption boundary

1. Continue the implementer's real finite-average ExceptionRepair and
   Formula AST modules on 4.13; build their exact theorems and give concrete
   YES/NO/nondegenerate witnesses. Then prove normalization/leaf bridge and
   WeightRounding. This makes progress independent of library migration.
2. Root has created S3129 READY for this isolated kernel audit. Route an
   isolated pinned Complexitylib checkout/package under the active
   research lane, with its own toolchain and manifest. Build the exact two
   exported imports above and record kernel axiom profiles and assumptions.
   Inspect `exists_pcp_of_mem_NP` plus its concrete verifier/gap transform,
   not only the class equality. If green, either port the small new semantic
   modules to that package or prove a precise encoding bridge; do not blindly
   upgrade the 90-module umbrella or mix incompatible .olean files.
3. Define randomized promise reductions and NP target acceptance early.
   Then pursue the actual outer 3-Lin/repetition interface and specialized
   Grassmann/covering/decoding proofs. A generic PCP theorem may reduce the
   base-theorem burden but does not discharge these modules by implication.
4. Give every ledger row an owning child story, exact exported theorem and
   build/axiom evidence as implementation reaches it. Keep unproved contracts
   explicitly marked pending; conditional assembly can organize work but
   must never count as full certification.
5. The submission paper must retain the complete theorem and proof, with an
   honest theorem-to-Lean crosswalk updated from this ledger. Until Main and
   both final conclusions close, describe only the exact formally checked
   subset. Full S3126 remains active; neither an isolated green helper nor
   a polished PDF closes it. Final build is followed by the required three
   independent top-level review lenses and actual metadata/publication gate.

No impossibility or fixed completion-time estimate is asserted. The critical
path is now concrete and partly reusable. This audit wrote only this ledger;
no code, proof manuscript, dependencies, commits, pushes or releases changed.

## First completed formal increment: S3127

2026-09-12 integration update. The preliminary inventory above is preserved
as historical assessment. `ExceptionRepair.lean`, `Formula.lean` and
`Checks.lean` now provide an actual kernel-checked finite indexed rational
repair construction and its positive AND/OR syntax bridge at commit
`1693d167b1e3e23b229ac4c70418c0fead54798a`. This includes witness repair,
universal strict NO preservation with natural floor(sigma/4), exact coordinate
weights, normalization/positivity and budget lemmas, and precisely one added
leaf occurrence. The three sources were not altered during evidence closeout.

The [implementation receipt and final three-lens table](2026-09-12-realizable-hardness-repair-formalization.md)
record build/audit GO, [proof GO](2026-09-12-realizable-hardness-repair-proof-review.md),
[complexity GO-WITH-NOTES](2026-09-12-realizable-hardness-repair-complexity-review.md),
and [non-claims GO](2026-09-12-realizable-hardness-repair-nonclaims-review.md).
S3127 is complete only for this bounded semantic/formula increment; full
S3126 remains open. Reviewers are AI agents, not human peers.

The remaining complexity notes have explicit owners: S3131 must assemble
valid encoded instances and certify enumeration, construction, input/output
length and runtime; S3130 must prove sampling, rounding and numeric common
denominator bounds; S3132-S3135 must discharge the specialized outer-game,
Grassmann, decoding, modified-PCP and compilation obligations; S3136 owns
the exact learning transfer; S3137 owns fixed-parameter asymptotics and final
assembly. The weaker local algebraic hypotheses do not replace the complete
promise-domain conditions. Finite/noncomputable sums do not certify a machine,
and input NO promises do not assert source NP-hardness. Preserve fixed L
before selecting the reduction machine and polynomial bound.

Separately, S3128 has a local 14-page typeset paper at the isolated paper
repository commit `419736bb99fac4c6fb71e9fc12cd3bab66fe307a`, PDF SHA256
`7282701f19d0427819f51f2afc1ac438ee5dcc02a64adb62b21cb61687ee37b9`.
Its separate AI content/visual review reported GO and an identical independent
rebuild. It is a local draft, not a new public archive or formal certificate.
Neither that paper nor this repaired subset closes the full formalization goal.
