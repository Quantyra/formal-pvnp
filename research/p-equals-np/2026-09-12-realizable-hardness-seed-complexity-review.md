# S3131 SeedEncoding complexity review

Date: 2026-09-12. Parent: S3126. Lens: independent top-level complexity-theory reviewer.

Verdict: **GO-WITH-NOTES**, restricted to the finite seed equivalence and fixed padding component. This is a source-only review, not an independent compiler or kernel audit.

## Reviewed evidence

Candidate: `e629518767cf00e54462abb2c1c7329ecd679187`.
Read the actual main and Checks sources, their dated seed-encoding formalization receipt, `JointSamplingLaw.lean`, the installed mathlib finite equivalences, `README.md`, `INTEGRITY-CLAIMS.md`, and the planning lane's formal three-lens closeout protocol. No local `AGENTS.md` exists at this repository root. The candidate comparison for both source files was empty.

Actual working-file SHA256 values matched the author's frozen values:

| File | SHA256 |
| --- | --- |
| `lean/PvNP/RealizableHardness/SeedEncoding.lean` | `6c4b145869109b08df7ec0d466c4001f5a14537b715e61f3731dc7056c705ad8` |
| `lean/PvNP/RealizableHardness/SeedEncodingChecks.lean` | `7f09856c5816c4731e46bdc45cbe1a1ad38922fecf1a2047ef5c77f8ce55cb28` |

The receipt attributes successful main session 9810 and Checks session 3397, 25 standard-only axiom profiles, and two evaluation lists to the author. I did not run a compiler or independently reproduce those outputs. Separate proof-adversarial and non-claims reviews are required for collective acceptance.

## Complexity and quantifier assessment

1. `flatten`, `unflatten`, `seedEquiv`, `splitBits`, `joinBits`, `splitEquiv`, and `takePrefix` are explicit computable finite-function constructions. Installed `finProdFinEquiv` sends `(i,j)` to `j + b*i`; its inverse uses quotient and remainder. Installed `finTwoEquiv` sends zero to false and one to true. This agrees with the source's row-major convention. It does not reverse the two indices or interchange bit values.

2. Both inverse equations are universally quantified over natural M and b. No positivity hypothesis excludes zero trials or zero width. In either case the domain of the flat function is empty, but its function space contains one seed. Checks explicitly cover both inverse directions and this cardinality. Thus these cases are not incorrectly treated as empty probability spaces.

3. `eventEquiv` transports an arbitrary event on B along an equivalence A to B. `flat_event_card` and `flat_probability` correctly instantiate it with the inverse of `seedEquiv`: a flat seed is unflattened before testing the original array event. The denominator is transported together with the event subtype. There is no premise assuming the desired probability preservation and no restriction to rectangular events.

4. `sampleFlat_probability` composes that event law with the actual `sampleArray_probability`. Its right side uses the existing discretized inverse-CDF masses `FiniteSampling.mass p (2^b)`, not the original rational masses p without their discretization error. It preserves the exact cumulative normalization and nonnegativity assumptions of the sampler theorem. The diagonal event in Checks exercises a nonrectangular instance.

5. `prefixFibreEquiv` explicitly identifies the fibre over any fixed n-bit prefix with the k-bit suffix space. `prefixEventEquiv` identifies any prefix event's inverse image with the event subtype times all suffixes. Therefore the factor `2^k` occurs in both numerator and denominator and cancels; its positivity is proved. Padding includes n = 0 and k = 0. This does not assume a separate independence hypothesis: uniformity is the explicitly counted law on all n+k-bit strings. It does not assert preservation for biased or correlated external coin sources.

6. `padded_sampleFlat_probability` correctly takes the first M*b bits from a seed of length M*b+k and then applies the same actual sampler. It establishes exact event-law transfer for each fixed natural k, including arbitrary Prop-valued events, rather than only marginal equalities.

## Required limits

The probability definitions use noncomputable real-valued cardinality expressions and classical decidability for arbitrary Prop events. This is legitimate mathematical event semantics, not an algorithm for deciding those events or evaluating their probabilities efficiently. Computable finite equivalences do not imply polynomial-time computation of arbitrary event cardinalities.

Likewise, a Lean function `Fin n -> Bool` is a mathematical finite-function representation. This component does not supply a concrete tape or encoded list representation, bit-cost bounds, a machine implementing the rational inverse-CDF sampler, or a polynomial runtime theorem. Parameters p, S, M, and b are supplied to the finite construction; their encoded input access and computation costs are not established here.

The fixed-k theorem can be instantiated mathematically for each input after choosing a valid nonnegative padding amount. It does not itself construct an input-dependent polynomial coin envelope, prove M*b lies below it, or prove an actual machine consumes only that prefix. That bridge still requires encoded input sizes, computable bounds, representation conversion, malformed-input behavior, and correspondence between machine output and this sampler on every seed.

The component therefore supports a necessary seed-law step toward S3131. It supplies neither a full randomized promise reduction nor NP-hardness, a specialized PCP/geometry theorem, the learning corollary, or a P-versus-NP result. Acceptance here does not establish compilation or integration in the separate Lean 4.34 companion package.

No source, companion, toolchain, cache, Git index, release, or publication was changed by this review. Only this review receipt was written; it remains uncommitted for root integration.
