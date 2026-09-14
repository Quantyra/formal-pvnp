# Strict CNF flag transitions: independent review

2026-09-13. S3132/S3137. **GO for the concrete finite scanner, all-word grammar equivalence and mathematical application of the pinned FP combinators.** No blocking finding. This does not certify a compiled Lean parser, the whole raw producer, practical compilation feasibility of an expanded transition table, or source hardness.

Candidate: `2026-09-13-realizable-hardness-strict-cnf-flag-transition-derivation.md`, SHA-256 `2b7de56cd90a9c4a6e6d91e51ca5cdf68673142c320e34af1ecbd224c321bdd4`, 20419 bytes. I read all nine sections and directly checked the relevant pinned DataEncode, recFold, recFoldClamp, recFoldClamp_mem_FP, recFoldClamp_eq_recFold, equality and composition APIs.

Reviewer incidence_complexity_review supplied the fixed-depth scanner route and earlier encoding checks, but did not author the sixteen frames, transitions, invariant or FP cascade. That design contribution limits any claim of wholly independent invention review; this is a distinct detailed verification of the author's concrete realization. No compiler, Lean/source module, experiment, Git or paper action occurred.

## Automaton and grammar

The frame inventory has exactly sixteen entries: one C, three each A/R/L/N, two B, and one E. The maximum permitted role path C-A-R-L-N-B-E has seven frames. Lists add siblings and cannot create an additional role cycle. The code width is exactly 2+3+7*4=33; depth distinguishes meaningful zero-valued C slots from padding, and all noncanonical codes fall to Bad.

The next-child and close/update tables implement the actual right-associated Clause=(Literal,(Literal,Literal)), Literal=(Nat,Bool) grammar. A/R/L require exactly two ordered children; B permits zero or one empty child; E permits none. N tracks the last COMPLETED Bool digit, not a framing bit, and closes only for empty digits or final true. This is precisely minimal little-endian Nat.bits, including zero's empty list. Role ambiguity of the empty Data node is resolved by its parent context. ContextOK rejects arbitrary invalid stacks; no reachable parse needs a stack beyond depth seven.

The prefix invariant supplies an actual matched tree and its completed child lists as proof data. Each transition preserves the stated role/progress information. Done is reached only by closing the root, and every subsequent bit goes permanently to Bad. Thus acceptance concerns the entire word, not a prefix. Conversely every grammar subtree follows the listed transitions, with root and canonical Nat cases explicit. Applying actual Bool/list/pair/Nat encoding equations proves the exact DataEncode range characterization. The proof does not rely on a generic balanced-parenthesis theorem.

Empty input, initial close, missing close, extra pair children, multiple roots, malformed Bool/E subtrees and high-zero Nat digits are all rejected by concrete transitions. Empty CNF [false,true] is accepted. No bound on label magnitude or Nat digit count is imposed by the finite state space.

## Same-function FP composition

The finite equality cascade is a fully specified total function: each branch returns a 33-bit state code and the final branch returns Bad. The enumeration includes every valid state code; enc is injective. Finite induction using the actual eqFlagFn_mem_FP and selectHeadFn_mem_FP proves membership for each bit transition. This is an explicit finite construction, not an assumed generic DFA theorem. Its very large fixed table is not claimed practically small.

Actual recFold packs its step input as pair(pair W accumulator) tail, so pairSnd(pairFst z) extracts the intended accumulator. Actual recFoldClamp_mem_FP requires FP steps and initializer plus a natural polynomial bound; constant polynomial 33 supplies the exact stated function. The candidate proves length exactly 33 for recFold on EVERY word and W, including arbitrary direct step inputs. This is stronger than recFoldClamp_eq_recFold's universal bounded-length premise, so the clamp removal is justified and not merely a reachable-state assertion.

recFold consumes the recursive tail first, applying the head last. Therefore recFold on reverse(w) is the chronological left scan on w. The candidate's packInput uses that reversal and the correct outer pair; the final equality/branch maps exactly Done to [true] and every other result to []. Composition applies to this same all-word function, including malformed inputs. It does not invoke the reverse direction of Cobham completeness or a presumed machine witness.

The imported combinators' FP conclusions do supply mathematical existential TM witnesses when these constructions and equalities are formalized. There is currently no new kernel-checked strictCNFFlag theorem from this artifact. The grammar invariant, explicit finite cascade and combinator applications still need implementation and compilation before local certification.

## Remaining boundary

The flag decides exact canonical CNF membership; it does not decode/materialize labels or produce folded rows. Gating an arbitrary unproved producer on the flag does not establish that producer's FP membership. The same-function entryFn, outcome loops, empty-domain scan, address/RHS serialization and whole-source equality remain separate tasks. No full producer or hardness completion follows from accepting this scanner derivation.

## Rehashed pinned API files

- `Complexitylib/Encoding/DataEncode.lean`: `5fe45322139611eb24cdcb58e2a03db8056ea62f0231606fed7accd0e7524e97`.
- `Complexitylib/Classes/P/Cobham/Internal.lean`: `7e1cc7e6efce97d8e57435e5121972cc19bb6b0192bacdd8c350cfe72a044033`.
- `Complexitylib/Classes/P/Cobham/Internal/Reverse.lean`: `27cc98e7d96b4f764e2a243566db49711b99c9ada4cf36cb5a3f5f201024f353`.
- `Complexitylib/Classes/Containments/Internal/FPBridge.lean`: `f65eebfd519f2964f02075e19ba1b58bc4f1db3fe4ecc3bb255799d324a0b07e`.
- `Complexitylib/Classes/P/Composition.lean`: `e2634b6dc5526e18b488ca823382f3cd283fc193aff1ed9b37be132ac691e01b`.

These are raw current-file hashes; the author records normalized comparison to package pin 6c248df7859f2f245e731c1e07057bf69d165fe2. This review made no new build or Git identity claim.
