# S3133 actual posterior-density source draft

Status: **UNCOMPILED. No successful Lean run, axiom result, or independent
acceptance is claimed.** Source-only work in the active formal-pvnp satellite.
No compiler, downloads, Git operations, existing source/map/aggregate changes,
paper changes, publication, or push were performed for this task.

## Scope and route

Read the full certification dependency ledger, local planning protocol and
literature-trigger protocol, S3133, the source-directed frontier literature
note, and the IGH inbox. The destination has no top-level AGENTS.md.
This continues the selected manuscript posterior derivation; it introduces
no new research lane or novelty claim. The complete realizable hardness and
learning goals, including all source PCP and machine dependencies, stay open.

## Actual mathematical construction

`PosteriorDensity.ambientMass Q` is the reciprocal of the cardinality of
the actual ambient advice type: all a-dimensional submodules of GF(2)^(3J).
`card_advice` derives its cardinality from the existing exact independent-frame
double count, obtaining the actual Gaussian binomial `[3J choose a]_2`.
Positivity and normalization are proved as scripts, rather than supplied as
assumptions. The count theorem is unrestricted; positivity/normalization use
`a <= J`, sufficient for the application.

`kernel_div_marginal_le` splits on actual containment `Q <= retained d`.
Noncontainment gives zero kernel. For containment, it uses the actual fibre
cardinality identity and the good-marginal inequality to derive
`kernel / marginal <= 2 * [3J choose a]_2 / [dim(retained d) choose a]_2`.
The good-marginal condition implies strictly positive marginal; the fibre
denominator is positive from actual incidence nonemptiness.

`conditional_density_le` concludes

    conditional beta Q d / prior beta d <= 8 * 2^(2*a*T)

with exactly these substantive hypotheses:

- `a + 1 <= J`;
- `ambientMass Q / 2 <= adviceMarginal beta Q`;
- `dropCount d <= T`;
- `0 < prior beta d`.

It invokes the actual Bayes identity and GaussianRatio's retained count bound.
The required spare dimension follows from `J <= dim(retained d)` and the exact
dimension identity. Neither a desired density bound nor a desired Gaussian
ratio is a supplied argument. This algebraic density statement needs no
additional beta range once its explicit positive-atom and marginal conditions
hold. Probability interpretations and subsequent mass/event statements
explicitly assume `0 <= beta <= 1`.

`conditional_mass_le` covers all prior atoms under these probability
hypotheses: positive atoms use the density statement, and zero atoms have
exactly zero posterior mass. Thus boundary beta values are permitted and do
not disappear under an implicit positive-support assumption.

`event_transfer` composes the existing finite event-cutoff theorem with this
actual density estimate. It retains

    tailMass beta Q T = Pr[D > T | Q]

as an actual finite sum, not as an assumed small number or an asserted
binomial tail proof. `fixed_subspace_failure_transfer` then uses the already
formalized unconditional arbitrary-subspace failure bound to conclude

    Pr[codim_V(W intersect V) != codim(W) | Q]
      <= 8 * 2^(2*a*T) * (2^codim(W)-1) * beta + Pr[D > T | Q].

The natural subtraction in `2^codim(W)-1` matches the existing numeric rank
bound. W is fixed before the draw; it can be selected as a function of the
already fixed Q. There is no union over W and no posterior independence claim.

## Dependency status and verification boundary

- PosteriorReweighting, TripleRestrictionRank, SubspaceRestriction are among
  the accepted 33 companion finite modules, per the root route evidence.
- GrassmannIncidence, GrassmannCounting, TripleRestrictionDimension are the
  author-green geometry candidate; independent geometry review is separately
  owned by root and was ongoing at task routing.
- GaussianRatio was the **UNCOMPILED** draft cd5462a at task routing; author
  compilation is separately queued. This draft cannot be accepted before
  that dependency is verified. No GaussianRatio file was edited here.
- PosteriorDensity and its checks remain **UNCOMPILED**. Scripts were inspected
  against the actual companion sources; elaboration success is not inferred.
- A literal source scan of the two owned Lean files found no `sorry`, `admit`,
  `native_decide`, or top-level `axiom` tokens. That scan is not a kernel audit.

Intended checks: 11 `#print axioms` queries and seven examples: normalization
in empty ambient space, zero-dimensional advice mass, noncontained advice,
zero prior atom, exclusion of null good marginals, zero-cutoff mass bound,
and zero-advice-dimension positive-atom bound. All are **UNRUN**.

Owned Lean SHA256:

- PosteriorDensity.lean: `5dc530b504a032c23526449e4928294a31082a71d3f6f1b0d5a173bc50e8b6ea`
- PosteriorDensityChecks.lean: `b0749bbeb21d59dbfd7ada467e2b372757fd4c04c330d403b5046e1307d5976c`

Remaining: author compilation and diagnostic repair without weakening
statements; independent three-lens review; actual binomial tail and exceptional
advice-set bounds; KMS covering and mixture-relative error estimates; specialized
PCP/decoder, encoded randomized reduction, HN learning transfer, fixed-L
parameter assembly, final theorem axioms, and paper reconciliation. This
source draft discharges none of those remaining obligations by implication.
