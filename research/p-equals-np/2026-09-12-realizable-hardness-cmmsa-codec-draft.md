# Concrete CMMSA binary codec: source draft

2026-09-12. S3131 under S3126. **UNCOMPILED.** No kernel acceptance, axiom-profile execution, FP theorem, or full reduction is claimed.

Read the S3131 randomized-reduction-semantics story, actual Formula and ExceptionRepair definitions, SamplingFormulaPromises interfaces, the machine assembly audit preserved by 25ed651, and manuscript conventions at lines 23--36. The satellite and planning boundaries already read in this route apply. Implementation is confined to the satellite. No compiler, Git, accepted source, package configuration, or public operations were performed.

## Representation and semantic contract

The manuscript requires positive rational coordinate weights summing to one, an indexed nonempty list of existing positive AND/OR formulas of at most fixed L leaves, and rational budget 0<s<=1. This draft validates exactly those fields. Epsilon, gamma, sigma and the fixed leaf bound L are problem parameters rather than redundant input fields. Formula occurrences remain ordered list positions, so duplicate formulas have distinct indices. Zero-variable data cannot satisfy positive normalized weights and a valid nonempty formula list.

The binary wire syntax is a prefix binary tree: false is a leaf, true introduces two recursively encoded children. Digit lists have constant-size tags and one cell per binary digit. Natural values use little-endian binary digits; positive rational weights and budgets use numerator/denominator digit lists, rejecting denominator zero. The parser accepts equivalent noncanonical rational encodings and leading zero digits. It never enumerates a natural's value to encode it. The proved draft length bound for a digit field is at most 4 times its digit count plus one. This is a representation bound, not a machine-time result.

Tree parsing is total with fuel equal to input bit length plus one; the fuel measures nesting, not numeric magnitudes. After a tree is parsed, leftover input must be empty. The semantic parser reads explicit finite weights and formulas, checks every variable index against the coordinate list length, and constructs the existing Formula (Fin N) syntax. A computable validity predicate checks weight positivity and normalization, formula nonemptiness and leaf bounds, and budget range. Malformed tags, denominator zero, out-of-range indices, invalid fields, or trailing bits return none.

Instance L retains the validated syntax tree, with a computable semantic projection to the parsed finite Data. This design preserves exact round trips for different valid byte representations of the same rational data. It is not a quotient by semantic equivalence. No arbitrary formula or probability function is accepted as input data.

## Draft proofs and checks

The tree parser has a prefix/suffix round-trip proof under an explicit depth budget, and encoded length bounds that budget. The public decode_encode theorem returns the original validated instance; encoding injectivity follows. Instance.valid exports the actual semantic validity of every accepted instance. decoded_data, decoded_yes and decoded_no preserve semantic interpretation after the round trip.

The cost is the existing ExceptionRepair weight sum with indexed explicit coordinate weights. Satisfaction is the existing average over list positions of Formula.eval. YES uses an existential assignment of cost at most s and satisfaction at least 1-epsilon. NO universally quantifies assignments of cost at most sigma*s and uses strict satisfaction below gamma. These match the existing pipeline semantics; no surrogate Boolean function replaces the formula syntax.

Thirteen axiom queries and thirteen examples are present but unrun. Examples include duplicate occurrences, leaf-bound rejection, denominator zero, out-of-bounds indices, empty formula-list rejection, binary magnitude four, digit-length accounting, an actual normalized one-coordinate/two-occurrence instance, empty input and trailing input.

## Exact source hashes

- CMMSACodec.lean: `9de95cfb82cd1e224d4c43ad0970dc6a262519aeb66dd14adfa6161fec879ef4`.
- CMMSACodecChecks.lean: `52c2aadeb5d5052c60a96acd6308c0b5973387b4bc51f44fd9b9acfa918c48b7`.

## Remaining work

Compilation may expose API, dependent-match, termination, or simplification issues. The current source does not yet provide the semantic-data-to-syntax constructor for arbitrary finite pipeline outputs. That constructor must encode rational numerators/denominators and Fin indices in binary and prove its parsed Data equals the actual repaired/rounded/sampled output, including coordinate renaming from Fin N sum Fin M and all duplicate occurrences. Consequently this draft must not be cited as a completed encoded-constructor bridge merely because valid syntax has a round trip.

Also outstanding: bounds for full output bit length, rational arithmetic and reduced denominators, a concrete FP parser/executor, fixed-L polynomial runtime, total malformed-input behavior of the eventual reduction executor, and proof that each seeded output tape encodes the actual finite pipeline output. The decoder's rejection policy is defined here; the machine's failure-output policy is not. No arbitrary binary magnitude may be converted to a unary enumeration in those next steps without a size bound. Existing abstract randomized machine assembly does not discharge these obligations.

Independent compilation and all three review lenses remain required. Full specialized hardness, learning transfer, paper reconciliation, and eventual final proof consolidation in the paper repository remain open.
