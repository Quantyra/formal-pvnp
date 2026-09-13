# Complexity review: actual occurrence allocation

2026-09-13. S3132/S3137 under S3126. Reviewer specialization_complexity_review did not author ActualOccurrenceAllocation. The complexity and non-claims passes are separate assessments by this same reviewer, not two independent people/agents. Read the full main/Checks, dated receipt and existing actual-cloud assembly obligations. No compiler, Git, Lean source, package or public action was performed.

Both current raw sources equal freeze `6c41dba9ce9786c40523deaa15b78873fd288cb0`: main SHA256 `b818b97e0fd08c97a720cdc2034ba3cb59aae836b392ec46add8e91ffda4aa38`, Checks `bf81e6c86734c7cacf1af33f98f751d88ab66cfbcb0d704126c2d704f5b1b772`. The author receipt reports session 16835 pair EXIT 0, 25 standard-only profiles, eight examples and four signatures. Independent verification was starting at assignment; author results do not substitute for its terminal packet. Existing package provenance limitations remain as documented in the author receipt.

**GO-WITH-NOTES for actual ordered allocation and structural row correspondence.** No assumed generic bijection, freshness law, expansion or hardness certificate is introduced.

## Construction and quantifiers

Instance N m stores ordered Fin m -> Fin 3 -> Fin N source triples, per-row injectivity, and ZMod 2 right-hand sides. It makes no source hardness claim. Repeated equation occurrences retain separate Fin m identities. Methods are now correctly qualified under ActualOccurrenceAllocation.Instance; reviewers/callers must use that API, not stale pre-repair names.

slotList is the actual row-major product of finRange lists. occurrenceList v is its owner filter; nodup and membership are proved. ordinal derives the index from List.Nodup.getEquiv of that exact list, with an explicit membership conversion. ordinal_get identifies the stored slot at the resulting index. No arbitrary caller-chosen ordering or equivalence is assumed. occurrencePartition explicitly pairs each slot with its owner, so its Sigma-fiber cardinality proves sum_v size(v)=3m for the actual list lengths.

GlobalVar is the dependent Sigma of actual Cloud variables over source variable v. An occurrence maps to its own ordinal at port zero in its owner's cloud. recover_anchor proves recovery on this anchored image, hence global anchor injectivity. recover ignores the port's second coordinate, so a dummy nonzero port can recover the same slot as its zero-port anchor. No full inverse on all global ports, no characterization of every some-return as an anchor, and no graph compression is proved. The theorem only needs the left inverse on source slots.

Original RowId entries are Fin m; gadget entries are Sigma v of actual cloud RowId. Original constraints use anchored slots with their original rhs; gadget constraints use tagged actual cloud rows. rows concatenates originalRows and variable-ordered cloud lists, preserving local order by definition. This constructs the requested actual output surface instead of an abstract existence contract.

## Structural content

Distinct source slots have distinct anchors, so different original rows have disjoint supports even when their original variable triples repeat. Each original row has three distinct target variables. Tagged different clouds are disjoint. A gadget row's variables all have its owner tag.

The cross original/gadget theorem genuinely uses Instance.distinct: two shared entries would be two positions in one source row with the same original variable owner, so the positions coincide. This exact-three-distinct source promise must survive the eventual source-hardness construction; it is not optional merely because occurrence splitting makes target anchors distinct. Gadget/gadget intersections within a cloud use the accepted actual Cloud theorem, which preserves parallel orbits and fresh internals. Combining cases proves support cardinality three and intersection at most one for every pair of distinct RowId values.

row_mem_rows and rows_mem_iff prove both directions of membership between generated row records and indexed rows. They do not themselves prove list multiplicity, nodup, cardinality, positional bijection or equality of actual violation counts to an indexed sum. Pair-intersection plus support cardinality can rule out equal row functions at distinct indices, but this is not the missing proof that the construction lists each such index exactly once. Later row counts and gap denominators must prove that exact bridge rather than applying membership as if it already supplied it.

For m=0 all occurrence sizes and generated rows are empty. Unused source variables likewise have zero-size clouds by construction; they do not justify assuming every original variable occurs. The fraction/gap theorem will need positive m or separate empty behavior, but no such fraction theorem is claimed here.

## Runtime and remaining source join

The explicit finite allocation and sum_sizes are mathematical constructions and a numerical count. They do not prove binary encodings of ordinals/tags, getEquiv execution cost, actual representative/cloud generation in FP, or a polynomial-time source reduction. The noncomputable section and accepted fixed-base choice are not a substitute for those encoded proofs. Fixed family/L parameters must precede original source size when that later complexity theorem is stated.

Next prove exact list multiplicity and T=m+4E, then sum the actual edge bounds to T<=(1+18D)m. Derive global degree using accepted retained-edge incidence and local gadget degree plus at most one original-row incidence. Construct a compatible full YES extension and prove original-row semantics, and for every arbitrary output assignment prove majority decoding and global gap with actual row counts. Full H?stad source hardness and its exact-three-distinct promise remain upstream scientific requirements.

Remaining to-do list: S3137 independent build/other-lens verification; S3132 exact count/degree/YES/majority-gap and encoded source construction/hardness; S3131 sampler/machine runtime; S3134/S3135 decoder and parameters; S3136 learning; S3128 final manuscript reconciliation and proof consolidation. Full S3126 remains open.
