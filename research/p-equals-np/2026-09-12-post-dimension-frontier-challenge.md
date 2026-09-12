# S3115 independent mechanism selection challenge

2026-09-12; S008. Private research-selection record under the
[integrity boundary](../../INTEGRITY-CLAIMS.md). No proof implementation,
experiment, commit, public action, or paid computation is authorized here.

**Disposition: NONE for investing in the specified paired-PPSZ
proposal.** The operation exists and its soundness is not the rejection
reason. It is known finite-domain PPSZ after grouping, with no additional
specified mechanism supporting a better worst-case guarantee. A new analysis
of a known algorithm could be worthwhile research; this assessment does not
require the desired bound to be proved before exploration.

## Scope and prior failures

I read S3115, the frontier research protocol and contribution-first correction,
the literature-trigger protocol, integrity ledger, and research graph's
S3105-S3112 history, including the actual post-bamboo and dependent-coupling
reviews. The old whole-certificate circuit lower-bound target has a known
same-instance upper-bound escape; missing selective carry transitions,
specified but established compilation/differencing rules, and an explicitly
inconsistent random-form law were different failure types. None is reopened.
The published dimension result has no P-versus-NP implication and is not the
mechanism examined here.

## Independent primary-source refresh

Sources were opened independently on September 12, 2026; these are bounded
source checks, not a complete survey or independent validation of every proof.

| Source | Relevant comparison |
|---|---|
| [Jiang--Cai, July 2026, Theorem 1.1 and Corollary 1.2](https://arxiv.org/html/2607.10697v1) | Claims randomized worst-case bases 1.306969598 for Unique-3-SAT and 1.307031578 for general 3-SAT. The algorithm and unique-to-general lifting remain unchanged; common-coordinate recombination of existing estimates supplies the improvement. This is a current benchmark, not a bound independently proved in this assessment. |
| [Hertli et al., CP 2016, Sections 1-2 and Table 2](https://www.tu-chemnitz.de/informatik/theoretische-informatik/publications/2016%20CP%20ppsz_for_csp%20with%20grant%20ack.pdf) | Finite-domain PPSZ rules out colors through bounded implication and samples a surviving color. General finite-domain constraints are converted to forbidden-tuple clauses with constant overhead when domain and arity are fixed. Table 2 reports base 2.479 per variable for (4,3), in both unique and general cases. |
| [Li--Scheder, ISAAC 2021](https://drops.dagstuhl.de/storage/00lipics/lipics-vol212-isaac2021/LIPIcs.ISAAC.2021.33/LIPIcs.ISAAC.2021.33.pdf) | Impatient PPSZ adds early assignments when two colors remain, with a restricted timing rule; the paper improves the unique-solution bound for domain size at least three. This stronger transition is a necessary comparison before inventing an early block-decoding variant. |
| [Scheder, 2018 primary report](https://eccc.weizmann.ac.il/report/2018/179/) | Multiple-solution CSP analysis is already a distinct literature subject. A unique-solution estimate must not silently be used for general formulas. Only the primary report abstract was inspected here; no numerical improvement is imported from it. |
| [Le Gall--Tamaki, April 2026](https://arxiv.org/html/2604.12131v1) | The paper supplies classical conditioning-and-search dequantizations for the relevant short-path CSP setting, improving the classical exponent over that inferred from the earlier claimed super-quadratic comparison. This was checked as an alternative frontier comparator, not selected as a new operation. |

## Actual proposed operation and representation escape

The proposer supplied this explicit transition before writing its final note:
randomly permute Boolean variables, partition into consecutive disjoint pairs,
and, at each pair, remove any of its four assignments contradicted by at most D
residual original clauses. Choose uniformly among survivors and substitute.
D is fixed; contradictory empty domains reject the run; a completed witness
must be checked against the original formula. An odd variable needs a singleton
last block. The intended advance is a uniform worst-case success exponent
better than the current general 3-SAT benchmark, including all general-case
and repetition costs.

A pair is a four-valued variable. Each original 3-clause becomes a constraint
on at most three such variables. Its forbidden tuples have constant size
(at most eight for an ordinary clause on three distinct original variables).
Thus the pair transition is exactly bounded-implication CSP PPSZ if an original
constraint, rather than each expanded forbidden tuple, is the budget unit.
With the paper's forbidden-tuple clause unit, the inference budgets need a
constant rescaling: D original clauses expand to at most 8D clauses, and D
expanded clauses originate from at most D original clauses. Literal equality
of the two algorithms at the same numerical D is not asserted.

For a fixed pairing the block order induced by a uniformly random Boolean
permutation is uniform. The new outer random pairing changes representation,
but no additional elimination, correlation-repair, or scheduling transition
was specified. The reduction is exact and preserves assignments; it does not
itself prove a better exponent. The generic Table 2 guarantee becomes roughly
1.5745^n in the original Boolean variable count, weaker than the Boolean
benchmark. That comparison is an available upper bound, never a lower bound
on the paired algorithm's actual success.

## First falsifiable obligations and independent attacks

1. A local benefit is not uniform dominance. If the allowed pair table is
   00, 01, 10, uniform block sampling gives each probability 1/3. Ordinary
   sequential sampling with sound forcing gives probabilities 1/4, 1/4, 1/2
   in the order x then y. Pairing helps two outcomes and harms the third.
   This checks only the transition, not a worst-case formula lower bound.
2. A usable analysis needs a structural quantity charging correlated pair
   gains against losses, order changes, and general-case effects. No such
   additional inequality or quantitative reason for a uniform gain was
   supplied in the proposed operation. Naming the desired exponent would
   merely name the remaining obligation. An explicit speculative inequality
   linked to the transition could justify further work even while unproved.
3. Random matching does not automatically expose linear local structure.
   In a formula with m clauses of width at most three, the expected number
   of within-clause variable pairs matched together is at most 3m/(n-1).
   For sparse formulas this is O(1), so direct within-clause pairing alone
   gives no linear-gain explanation. Longer bounded-implication correlations
   are not excluded. Expectation alone cannot bound exponentially weighted
   success probabilities; no global runtime conclusion is drawn.

## Resource and implication audit

At most m^D clause subsets, each involving at most 3D Boolean variables, can
be checked by exhaustive assignment testing. Four pair values and at most n
blocks give a loose polynomial per-run bound for fixed D, including residual
construction. Storage, exact uniform sampling over one to four survivors,
substitution, final O(m)-scale witness checking, and any formula preprocessing
remain charged. If D grows with n, the polynomial claim must be reconsidered.
No assignment oracle is hidden in this explicitly brute-force implication
test. A run's polynomial cost does not bound the number of repetitions.

The original 3-CNF representation retains its Boolean PPSZ baseline. XOR
recognition, counting, symmetry or decomposition can additionally help on
particular inputs; no same-instance matched solver hardness is claimed.
The proposal supplies neither short UNSAT certificates nor an exact counter.
An improved constant exponential randomized SAT algorithm alone proves
neither P=NP nor P!=NP. Even hypothetical polynomial success with polynomial
per-run work first yields a one-sided randomized decision result; a
deterministic polynomial-time complete algorithm would be needed for the
stated direct P=NP conclusion. General-case lifting and derandomization are
separate obligations, not free consequences of grouping.

## Selection boundary

The NONE recommendation concerns investment in this proposal as currently
specified. It does not falsify its desired exponent or deny that an original
analysis of the paired representation might exist. The concrete reason to
stop is known-operation subsumption without a further proposed mechanism or
structural argument for the claimed advance, not the absence of a proof.

I did not manufacture a replacement from short-path conditioning/search:
relabeling its conditioning step, or requesting a better low-energy bound,
would repeat the same selection defect. No second concrete independent
candidate is selected. This bounded search does not exhaust the frontier and
does not authorize an automatic experimental successor.

## Actual saved-file challenge

I read the complete [author intake](2026-09-12-post-dimension-frontier-intake.md)
at SHA256 `73D312F5B03576A7C804822C41E6BD7A3F9BB9C94F4B8E0D5D260DFF8CADCD99`.
The analysis above was sent independently before that file existed. Its
three-entry table uses a complemented version of the example above and its
probabilities are correct. The stated sum over complete satisfying assignments
of path-probability products is also correct: verified outputs are disjoint
events. It does not provide the desired lower bound by itself.

The source budget conversion, fixed-D bit-cost, matching calculation,
finite-strength and repetition separation, and conditional NP=RP versus P=NP
distinction check. The author expressly does not claim its desired exponent
was falsified or that a known algorithm cannot have a new analysis. No
additional proof/experiment route follows from the global success identity.

One source-scope correction was requested: the Li--Scheder comparison must
explicitly say its improvement is for unique-solution formulas, not leave
that qualifier implicit when discussing general 3-SAT. This changes no
selection reasoning. I reread the complete corrected author file at SHA256
`F033241C2EF0B8C5E2F446D2F29EB46CA6FE374F8639C04BE4F1086113C85347`.
It explicitly states the unique-solution scope for d>=3 and k>=2 and also
includes the exponentially weighted success-measure caution. No outstanding
correction remains. This final hash supersedes the initial reviewed snapshot.

**Independent assessment: PASS for this bounded selection, NONE for the
specified investment candidate.** This is substantive AI-agent source and
mechanism challenge, not formal verification, novelty certification, or
human expert review. Only this owned private evidence file was written.
