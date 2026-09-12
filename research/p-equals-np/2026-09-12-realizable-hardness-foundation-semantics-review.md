# S3129/S3131 independent foundation semantics review

2026-09-12. Reviewer: foundation_semantics_review. Verdict: **GO-WITH-NOTES for continued isolated foundation audit; not adoption or kernel certification**.

Inspected complexitylib source at `6c248df7859f2f245e731c1e07057bf69d165fe2` (HEAD rechecked), in the existing S3129 isolated checkout. No Lean/Lake command, dependency installation, checkout mutation, or public action was performed. The concurrent foundation owner's build and subsequent exact axiom audit remain authoritative for kernel acceptance. This is a bounded semantic source audit, not an exhaustive audit of every transitive proof.

## Headline definitions are substantive

All paths below are relative to complexitylib.

| Source | Inspected meaning |
| --- | --- |
| `Complexitylib/Models/TuringMachine.lean:366,426,454` | Languages are sets of finite Boolean strings. TM/NTM have finite state types, fixed finite tape alphabet and fixed tape count; transitions read current head symbols and move/write locally. NTM branches on one Boolean per step. These are not language-oracle transitions. |
| `Complexitylib/Models/TuringMachine.lean:174,488,517,529,536` | Output requires the actual bits followed by a blank. Deterministic time is bounded step-relation reachability from the initialized input and blank work/output tapes, with halting and correct output. |
| `Complexitylib/Models/TuringMachine.lean:669,734,796,803` | Nondeterministic execution is a trace over a finite Boolean choice array. Deciding requires all paths to halt within the bound and membership iff a bounded accepting path exists. It does not merely assume the language is NP or bound only accepting paths. |
| `Complexitylib/Classes/Time.lean:38`; `Classes/NP.lean:26`; `Classes/P/Defs.lean:32` | NTIME existentially supplies such an NTM and a time bound with asymptotic domination; NP unions polynomial exponents. FP supplies an actual deterministic machine computing the whole output string within polynomial time. |
| `Complexitylib/Classes/NP/Reduction.lean:36,43,46` | Many-one reduction supplies an FP string function and membership equivalence on every input. NP-hardness quantifies over all NP languages. NP-completeness adds membership. No assumed SAT hardness appears in these definitions. |
| `Complexitylib/SAT/Language.lean:43,54` | SAT is an encoded satisfiable CNF, not NP itself under an alias. Short witness relation uses the encoded formula and Boolean assignment evaluation. |
| `Complexitylib/SAT/CookLevin/Assembly.lean:1082,1094,1105,1113,1120` | The final chain obtains a polynomial emitter time bound for the actual tableau reduction; converts arbitrary polynomially bounded machines to one tape; uses tableau correctness; then derives SAT hardness and combines SAT membership. The headline has no supplied NP-hardness premise. |

Finite alphabet/multitape conventions are appropriate machine foundations at this level. This review does not prove an independent equivalence theorem to every textbook machine convention; more importantly, no conversion to our formula encoding follows just from that observation.

## PCP constants, randomness, and implementation bridge

`Complexitylib/Classes/PCP/Defs.lean:83` defines a nonadaptive verifier with positions encoded by an FP function of the paired input and coins, and a verdict language in P. `answers` reads the actual proof at each address, defaulting to false past its end. `QueryBounded` bounds the number of queried positions on all input/coin strings. At line125 the class requires completeness exactly 1 and soundness at most 1/2 against every finite proof. `Classes/EventProb.lean:61` defines probability as rational cardinality divided by `2^T`, on `Fin T -> Bool`; these are actual uniform finite coins.

`Classes/PCP/Defs.lean:182` requires the randomness length to be writable in unary by an FP function. `Classes/PCP.lean:39` includes this Constructible condition in its union, together with logarithmic randomness and constant query bound. It therefore does not allow an arbitrary noncomputable length-dependent coin count to encode a language for free. `Internal/AlgPCP.lean:112` obtains those bounds existentially from each language's NP membership. It gives fixed constants for that language, not a uniform efficient algorithm over arbitrary descriptions of all constants or parameters.

The hard inclusion does not stop at an assumed verifier record:

- `Internal/AlgFormula.lean:83` derives the FP family of exact 3-CNFs from the actual SAT hardness theorem and the 3SAT reduction.
- `Internal/AlgGapAll.lean:54,59,62` defines the padded iterated graph, the string constructor, and proves their encoding equality. Lines78 and87 derive completeness and gap soundness for that actual graph. Line145 proves the actual string constructor is in FP using bounded iteration and polynomial length rulers.
- `Internal/Dinur.lean:349` builds the Amplifier record from the concrete step operation, with fields discharged by earlier step completeness, edge-count and gap lemmas. It is not a fresh desired-property premise passed into the headline. The full transitive analytic/combinatorial proof has not been independently re-proved in this review.
- `Internal/AlgGapCSP.lean:105,168` constructs the algorithmic CSP and proves its actual edge count, endpoints, symbol codec and verdict correspond to the graph. Its helper FP/encoding hypotheses are discharged in `AlgPCP`, rather than being left as headline assumptions.
- `Internal/AlgUniform.lean:37,54` obtains uniform polynomial output bounds and a computable length-only padding ruler. `AlgPCP` explicitly uses it to keep coin counts dependent on input length alone.
- `Internal/FamilyFin.lean:393` chooses a finite base once, from the existence theorem in `TowerFin.lean:474`, then builds the numbered family. Such a fixed finite constant can be hardwired into an existential FP machine; the source proves FP for the resulting constructor. This is not permission to treat arbitrary input-dependent classical choice as an implementation. An executable extracted artifact and effective numerical constants are separate deliverables.

## Findings and boundaries

1. **Documentation correction recommended, not a detected theorem failure.** `PCP/Defs.lean:65-66` introductory comment says a proof of length `q n * 2 ^ r n` suffices. The given dense-string/address definition does not itself imply this: binary encoded addresses may be exponentially large, even when few addresses are queried. For example, a verifier querying address `2^n` and requiring that bit to be true has one query and can encode its address in O(n) bits, but its accepting dense proof needs at least `2^n+1` bits. The correct small object is an answer table indexed by coin string and query slot, together with consistency. `Internal/SubsetNPFinal.lean:110` does exactly that: it bounds this table's length, checks consistency, and reconstructs some finite proof. Thus the inspected reverse inclusion avoids the comment's misleading dense-length assertion. Do not repeat that assertion in our foundation documentation.

2. **Encoding bridge remains open.** SAT's current encoding uses unary variable indices (`SAT/Language.lean` witness bound explicitly relies on this). `Encoding/DataEncode.lean:94` encodes natural numbers via binary bits, including generic PCP position lists. Both are concrete encodings, but their coexistence does not prove a polynomial conversion for our weighted monotone formulas, rationals, denominators, thresholds or malformed-input behavior. In particular, converting arbitrary binary integers to unary can be exponential. Faithful target encodings, length bounds and machine cost of every sampling/rounding operation are still S3131 obligations.

3. **Randomized reductions are not discharged.** `Classes/Promise/Defs.lean:29,50,56` provides disjoint YES/NO languages and deterministic FP maps preserving both sides. This is a suitable starting interface; it is not the bounded-uniform-randomness promise reduction with separately quantified YES/NO success required by the manuscript. Finite seed-probability lemmas still need the encoding/runtime and composition bridge.

4. **Generic PCP is insufficient for the specialized manuscript contract.** Constant queries, logarithmic randomness, completeness 1 and soundness 1/2 do not provide the required Outer3Lin gap/occurrence structure, repeated outer game, MZ advice/rank/decoder theorem, Grassmann posterior geometry, KMS covering, star compilation, fixed-L parameter ordering or HN learning reduction. None is discharged by either headline inspected here. The full dependency ledger remains controlling.

5. **No circularity or vacuity found in the inspected headline route.** The inspected definitions and connecting proofs support continuing the audit. This is narrower than declaring the entire library correct: exact target build exits, standard axiom profiles, deeper transitive checks when warranted, toolchain compatibility, and all application interfaces remain separate gates. Lean4.34.0-rc2 source is not thereby adopted into the active Lean4.13 package.

Planning context inspected: S3129 and S3131 in Quantyra-Planning, and `research/p-equals-np/2026-09-12-realizable-hardness-lean-dependency-assessment.md` in formal-pvnp. This receipt changes no source, mathematical claim, release, or full-goal completion status.
