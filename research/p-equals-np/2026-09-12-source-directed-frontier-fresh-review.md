# Fresh mathematical audit of the source-directed frontier derivation

2026-09-12; S3123 / E004 / S008. Independent reviewer, not a proof author.
[Integrity boundary](../../INTEGRITY-CLAIMS.md).

**Final mathematical verdict: GO-WITH-NOTES for the exact candidate below.**
Publication remains HOLD pending the separate significance/publication gate.

Final reviewed SHA256 of
`2026-09-12-source-directed-frontier-design.md`:
`2AC6A5E0D3136E9E57CB7439804A143362920A914A6D5FD7606EBFA57AC3977C`.

The actual complete derivation, including the revisions made in response to
the findings below, has now been read and checked. No blocking mathematical
defect remains in the proposed fixed-parameter realizable CMMSA and learning
hardness conclusion, using the explicitly cited external theorem statements.
This is independent agent mathematical review, not Lean verification or
independent human peer review. It does not certify novelty or publication.

## Final review and findings disposition

The checked conclusion has the quantifier order: for every sufficiently large
**fixed** leaf bound L, there is a polynomial-time randomized many-one
reduction on input instances, with gap L^(1-o(1)), zero YES error, and an
o(1) NO satisfaction threshold. Its polynomial exponent may depend on L.
The learning transfer retains this fixed-parameter convention and zero YES
error. No uniform polynomial exponent for growing L is established.

The numerical modification is a new derivation, not an invocation of a
published theorem allowing completeness to be chosen after the alphabet.
The external inputs used here include MZ's outer-game bound and bounded
occurrence starting problem, its local decoding and list-counting theorems,
KMS's general repetition covering bounds, and HN's compilation and learning
transfer. Their relevant statement hypotheses were checked. Their entire
underlying proofs were not reproved or machine-verified in this review.

| Finding | Final disposition |
|---|---|
| Missing nonnegative epsilon domain | Explicitly corrected. |
| Posterior conditioning may change V | Bayes calculation checked; joint conditional sampler is the required law. |
| Possible h^4 loss in decoded success | Resolved: density factor only multiplies bad-event bounds; favorable probabilities multiply in the actual joint experiment. |
| Actual advice consists of vectors, not uniform subspaces | Explicit coupling costs at most 2^(r-J); it does not assume conditioning preserves the V marginal. |
| Conditional rank and zoom-out bounds | Rank bound, deletion tail, likelihood ratio, and mixture reweighting checked. |
| Undefined nontransverse table entries | Total tables now specified; their discrepancy is charged using joint and conditional intersection estimates. |
| Single-threshold maximal extension existence | HIGH finding resolved by the author's explicit threshold ladder and the second prover's independent threshold guess. Merely changing 5^r to 5^(r^2) would not have resolved it. |
| Nonintegral inner dimension | h restricted to multiples of the rational denominator; varying-m spacing explicitly constrained. |
| Multi-query completeness loss | All m+1 relevant outer blocks included, with legitimate-tuple conditioning charged. |
| Sampling, exact realizability | Simultaneous concentration precedes exceptions; final power-of-two list has an exact total sampler. |
| Polynomial common denominator | Upward integer-weight rounding and budget slack checked. |
| Hardness and asymptotic quantifiers | Fixed parameters, padding, enumeration, all-large-L selection, and advice overhead checked. |

### Decisive probability and source-interface checks

For each fixed legitimate U, the deletion variable has mean A h^2. The tail
above h^4 and Markov exclusions are below the lucky-advice scale after h
is sufficiently large. On the remaining advice, the Bayes density estimate
is applied only to the rank-failure event. Double-exponential J makes that
error negligible despite the h^4 exponent. This leaves no h^4 loss in the
favorable-event probability.

Conditioning a uniform d-subspace of V to contain Q induces the same V
posterior as sampling a uniform advice subspace of V. Under stable rank,
the chance that this subspace lies in W is uniformly close to 2^(-c(d-a)).
Consequently the additional W conditioning can be removed from the V law
with the stated additive error. The actual random-vector advice law couples
to this ideal joint experiment with negligible total error. These facts
justify multiplying the good-Q marginal by the good-V conditional
probability; no pointwise unconditional-V success assertion is needed.

The total second-prover table depends only on V and its fixed completion.
Its agreement with the original table is used only where both underlying
vertices are transverse. The added joint estimate for advice meeting the
completion's side-condition space is valid even though that completion
depends on V: conditional on V, Q is uniform. The subsequent Markov
exclusion and quotient-space bounds charge the exceptional entries.

The threshold ladder is necessary. Failure of maximality at B_j supplies
a proper extension at B_j/5; codimension decreases at every step. Thus one
of at most r+1 thresholds works. The second prover guesses the threshold,
and the imported counting theorem applies at every level because the
smallest B_j still exceeds its agreement cutoff for sufficiently large h.
The extra guess is a constant cost for fixed m and rho. All decoded-success
costs therefore fit 2^(-C_* h^2); C_* is independent of the later YES error.
Choosing A from this bound and the outer soundness constant gives the
strict outer contradiction after legitimate-tuple conditioning.

The rho denominator restriction makes the actual test dimensions integral.
The added requirement b_m <= sqrt(log L) makes the spacing loss o(log L)
even along the chosen m(L), while every fixed m eventually qualifies.
This supplies the all-sufficiently-large-L asymptotic rather than only
hardness on a sparse sequence of alphabet powers.

### Downstream reduction checks

The compiled gap coefficient exceeds the selected 1/16. Independent AND
products, dyadic approximation and the simultaneous Hoeffding bound retain
the input promises needed by the exception lemma. Its output has one
exception variable per index and exactly perfect completeness on successful
reduction outputs. Making the list length a power of two prevents the
approximate construction sampler from introducing later realizability
error.

In the rounding step, upward integer weights retain the YES witness after
the additive N' budget allowance. A NO candidate within the halved rounded
budget has old weight at most (9/16) times the previous NO budget. Thus
rounding retains soundness and gives the polynomial common denominator
needed for integral learning string lengths. HN's learning transfer can
then use a polynomial multiple of that denominator. The combined reduction
failure probability is bounded by reserving separate list and transfer
budgets. Constant gap losses and logarithmic advice overhead preserve the
claimed exponent and vanishing threshold.

### Nonblocking notes and limits

- Read `g|_V` in the threshold-ladder paragraph as the restriction to
  `W(Q) intersect V`, which is the function's stated domain there. The
  notation is imprecise; the domain and extension argument are unambiguous.
- Choose the least suitable powers of two for M and D (and a polynomial
  multiple for the learning length). The existence of polynomial-size
  choices is what the runtime statement uses; arbitrary oversized choices
  are not part of that statement.
- Scope of the source-parameter discrepancy is the inspected MZ arXiv v1.
  This review makes no allegation about an uninspected published version.
- The result remains dependent on the cited mathematical theorem inputs;
  no claim of a self-contained proof of those inputs is made. The finding
  of no remaining blocking defect is scoped to this exact reviewed text.

The reviewer supplied objections and checked the author's revisions; the
reviewer did not write the proof or its repairs. The source challenger is
not counted as an independent verifier. No experiment, commit, push,
publication, or formal proof was performed. P versus NP, one-way functions,
the growing-L question, and the linear approximation threshold are not
settled by this conclusion.

## Historical interim audit (superseded by the disposition above)

The inspected design is a DURABLE WORKING DRAFT whose posterior, zoom-out,
parameter-composition, sampling and encoding arguments are explicitly pending.
Initial inspected SHA256:
`AE82F59FDDC9A23CFAC88E1D68E1FC9727AD4D49BFE2764EB6DFD33355180F15`.
This is an audit pin for the incomplete draft, not a frozen complete proof.
At that stage final mathematical disposition required the completed actual
file and its new hash. The source challenger contributed to the derivation, so its verdict
is not used as independent verification here.

## Stable elementary lemma

The exception construction's algebra checks provided `epsilon >= 0` is made
explicit. The draft only calls epsilon rational and imposes an upper bound;
this omits its required domain. With `0 <= epsilon sigma <= Gamma/2`, raw
budget is at most `3 sigma s/8`. The old coordinates remain within the old
soundness budget. Enabled exception coordinates repair at most `3 Gamma/8`
of the indexed list. The union bound is strict because the old NO promise is
strict. Repeated formulas cause no problem when list indices retain distinct
exception variables. Normalization, one additional leaf, and existential
choice of repaired indices are valid. For fixed positive sigma and Gamma,
the claimed inverse-polynomial lower bounds also survive.

This verifies a conditional explicit-list transformation, not the NP-hardness
of its input promise in the required parameter range.

## Independently inspected source contracts

Primary sources accessed directly:

- [Hirahara--Nanashima, TR26-052 revision 1](https://eccc.weizmann.ac.il/report/2026/052/revision/1/download/), definitions 1.7 and 4.1, theorems 1.3/1.8, sections 4.2--4.3, lemma 5.1 and section 7.
- [Minzer--Zheng, arXiv 2510.23991v1](https://arxiv.org/html/2510.23991v1), sections 3.2--3.3, 5.1, 5.3--5.4. This review does not attribute findings to an uninspected published version.
- [Khot--Minzer--Safra, Theory of Computing 2025](https://theoryofcomputing.org/articles/v021a010/v021a010.pdf), definition 4.5 and lemmas 4.6--4.7, including their conditional-distribution interpretation.

The HN target uses each sufficiently large leaf bound fixed independently of
instance length. Its local formulas are normalized-weight instances; learning
transfer preserves zero completeness error if its input has zero error.
MZ's printed theorem orders completeness error before alphabet choice.
Its outer-game bound is not by itself the fixed-alphabet strengthening sought
here. The draft correctly labels its alteration as new derivation.

The reported numerical discrepancy is supported as an inference gap in the
inspected MZ v1: the displayed repetition choice gives `beta J = O(log h)`
where the outer-value premise invoked later is exponentially small in `h^2`.
This observation does not disprove the published main theorem. General-J KMS
covering bounds require their explicit dimension/smoothness hypothesis and
condition the joint sampler; they do not license replacing posterior V by
unconditional V.

## Pending proof obligations and adversarial findings

1. **Posterior and rank order.** The law of V after advice Q must be derived
   from the actual advice experiment, including rank failures. Zoom-out
   conditioning further changes this law. Applying an unconditional
   codimension failure estimate to a Q-dependent W is unjustified without
   an explicit density/conditioning argument. General covering alone does
   not prove this interchange.

2. **Potential exponent loss.** The proposed deletion cutoff `h^4` gives a
   density factor of order `2^{O(r h^4)}`. If that factor divides the
   favorable-event probability, decoded outer success may have exponent
   `h^4`, invalidating comparison with `2^{-A h^2}`. If it is used only to
   multiply already negligible bad-event probabilities, that particular
   problem may disappear. The current draft does not yet say which occurs.
   Every such loss must appear in the final success product.

3. **Completeness query multiplicity.** Actual MZ constraints sample m
   clique-side vertices. Reusing its displayed one-query completeness loss
   `J epsilon1` without explaining multiplicity is insufficient. The full
   proof must charge all queried vertices and filtering. A smaller chosen
   outer error is allowed only after its parameter order is justified.

4. **Remaining source uses.** The new repetition choice must satisfy the
   inner ambient-dimension requirements, advice-dimension limits, list-size
   theorem premises, side-condition exclusions, clique collision estimates,
   and strict outer contradiction after all conditioning and rounding losses.
   The original lemma number cannot substitute for this audit because its
   quantitative proof is being modified.

5. **Encoding is stronger than rational arithmetic.** Polynomial rational
   bit length is enough for the exception lemma. It does not ensure a
   polynomial-magnitude common denominator for learning string lengths
   `w(i) lambda`. Any replacement by empirical occurrence weights must
   specify the stage and reestablish its soundness promise. A polynomial
   list need not have a polynomial least common multiple of arbitrary
   input denominators.

6. **Sampling first and realizability.** Sampling must preserve all relevant
   old assignments simultaneously before exceptions are introduced, with
   explicit accuracy and failure budget. A fixed-bit circuit cannot sample
   an arbitrary-size list exactly uniformly by simple fixed-width indexing.
   Every fallback or padded output of its actual sampler must retain a
   perfect common satisfying witness. Neither rejection nontermination nor
   an approximate sampler's error may silently be called zero error.

7. **Quantifiers and runtime.** An enormous fixed J is compatible with
   polynomial instance runtime, but the proof must fix its parameters first,
   bound all enumeration/padding/sampling work in the instance size, and
   derive the claimed functions for every sufficiently large final leaf
   bound, rather than only a sparse sequence of alphabet powers. No
   superconstant parameter theorem or one-way-function consequence is
   established by the draft.

These findings were sent to root and the author as review conditions, without
editing or repairing the proof. Formal Lean checking is N/A to this informal
mathematical argument. No experiment, commit, push or publication was done.
