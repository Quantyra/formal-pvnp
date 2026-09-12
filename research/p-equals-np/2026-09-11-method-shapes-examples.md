# Six examples connecting solver methods

2026-09-11; S3062. This is a cross-method map of existing evidence under the [claims boundary](../../INTEGRITY-CLAIMS.md). It reuses the checked S3061 [theory](2026-09-11-solver-frontier-theory.md), [practice](2026-09-11-solver-frontier-practice.md) and [alternatives](2026-09-11-solver-frontier-alternatives.md) notes. No experiment, new inference derivation, theorem increment or general hardness claim is made.

**The examples establish different obstacles, not a common structural barrier.** A long proof in one language can become a short calculation in another; a short proof need not be efficiently discoverable; a finite implementation timeout establishes neither kind of theorem.

## 1. Odd-charge Tseitin on bounded-degree expanders

**Same object.** Fix a connected bounded-degree expander graph, one Boolean variable per edge, and vertex parity equations with odd total charge. Encode each constant-arity equation by the clauses excluding its falsifying assignments. The input is this standard CNF, not an arbitrary equivalent encoding.

**Limitation [theorem].** Expansion gives large resolution width and exponential resolution refutation size. This transfers to a solver only while its deductions and preprocessing have an efficient translation into the restricted proof system. [Ben-Sasson–Wigderson](https://people.inf.ethz.ch/emo/SatSem05/Papers/BensassonWidgerson01.pdf).

**Escape and cost [known algorithm].** The original local truth-table buckets expose the constant-arity XOR equations. Checked extraction costs polynomial work here; Gaussian elimination then obtains the contradictory sum in polynomial bit operations. Supplying those equations is another valid input interface but must be distinguished from discovering hidden parity in general CNF. S3059's [ordinary-CNF case-discovery example](2026-09-11-cnf-case-discovery.md) provides an already checked alternative recovery on degree-three Tseitin. Current branch-and-cut literature also gives quasipolynomial CP upper bounds for these parity encodings, so “parity defeats counting” is false. [Fleming et al., 2026](https://www.theoryofcomputing.org/articles/v022a002/v022a002.pdf).

**Remaining unknown.** No hardness remains for this explicitly recognized pure-affine family under unrestricted classical computation. Useful parity extraction from arbitrary mixed encodings is a different question. SLS or quantum search for a satisfying assignment cannot help refute this already UNSAT pure-affine instance more fundamentally than its known algebraic certificate.

## 2. Standard functional pigeonhole CNF

**Same object.** For h+1 pigeons and h holes, use variables x(i,j), one positive row clause per pigeon, negative pairs forbidding two holes in a row, and negative pairs forbidding two pigeons in a column. Do not add onto clauses or replace the polynomial encoding silently.

**Limitation [theorem].** Standard functional-PHP CNFs require exponential PCR proof size in the usual monomial representation. The cited result explicitly distinguishes functional PHP from onto-functional PHP, which is easy for polynomial calculus. [Miksa–Nordstrom, abstract and main results](https://arxiv.org/abs/1505.01358).

**Escape and cost [known counting].** Row/column at-most-one groups are recoverable by explicit checks of their negative pairs; this is polynomial on the stated encoding. Sum the positive row requirements and valid group upper bounds to contradict the number of holes. The already checked [S3060 implementation](2026-09-11-counting-parity.md) recognizes these groups and uses a proportional aggregate. Recognition, Boolean validity of an AMO, and proof inside PCR are different tasks; the counting escape does not violate the PCR lower bound. A PB proof must charge its own justified group conversion and arithmetic, not treat stronger input inequalities as free PCR lines.

**Remaining unknown.** This familiar PHP is not a common obstruction. The limitation concerns a proof representation, while a stronger language preserves the needed cardinality information economically. Neither this example nor Tseitin shows that combining their successful solvers handles arbitrary mixtures.

## 3. Random 3-CNF at the FKO certificate density

**Same distribution.** Take n variables and m=ceil(C n^(7/5)) distinct signed three-variable clauses uniformly, for sufficiently large constant C. This is not constant-density near-threshold SAT search, planted SAT, or the competition SDP instance. The S3061 theory note records the asymptotically negligible collision correction if independent clause sampling is used.

**Limitation [theorem, scoped model].** Resolution has superpolynomial/exponential-in-a-power-of-n size obstructions in the relevant sub-n^(3/2) regime. The corresponding short-proof question changes when the language includes threshold reasoning. [Muller–Tzameret, introduction](https://arxiv.org/abs/1101.3970).

**Escape and cost [existence, not efficient finder].** FKO supplies polynomial-size UNSAT certificates with high probability and a subexponential search procedure; Muller–Tzameret formalize their soundness in polynomial-size TC0-Frege proofs. Thus one cannot claim absence of short proofs across the methods on this same distribution. [FKO](https://www.microsoft.com/en-us/research/wp-content/uploads/2017/03/unsat.pdf), [Muller–Tzameret](https://arxiv.org/abs/1101.3970).

**Remaining unknown [supported frontier].** Constructing such a sound certificate in deterministic polynomial time, with high probability over this distribution, remains the precise S3061 discovery question. Its bounded current-source check identifies the efficient-refutation benchmark around sufficiently large C n^(3/2), not n^(7/5). The missing operation is effective certificate discovery, including tuple selection/overlap control and numerical verification; neither a supplied proof simulation nor uncharged quantum search closes it. SLS cannot certify these UNSAT formulas by failing to find witnesses. This question carries no observed competition-panel failure evidence.

## 4. One exact empirical syndrome-decoding candidate

**Same artifact.** `SDP_136_18_712.sanitized.cnf.xz`, GBD ID `de3440b67769e7af00e58ec9cce9847b`. The [S3061 receipt](2026-09-11-sat2026-unsolved-intersection.json) records all 33 submitted sequential configurations timing out under the competition's 5,000-CPU-second, 32-GB contract. GBD reports unknown truth status. This is reused public metadata, not a new run or independently certified truth value.

**Limitation [finite observation].** The intersection is real for those configurations and budget. They are not 33 independent proof paradigms, and the observation does not establish failure of native XOR/PB, specialized decoding, unrestricted portfolios, parallel runs or quantum methods.

**Generic mathematical shape, not recovered provenance.** Binary syndrome decoding asks for a point in the affine coset `{e: H e=s over GF(2)}` intersected with a Boolean low-Hamming-weight set, for example `{e: wt(e)<=t}`. Gaussian elimination handles the linear part; the weight condition selects globally among its solutions. Some formulations require exact weight instead. This describes the problem class only: the matrix, threshold, weight convention and CNF encoding of the competition artifact have not been recovered. No LP, SOS or ISD run on that artifact is established here.

**Possible escape and cost [untested].** Classical/quantum information-set decoding works on the native matrix and weight condition; the relevant memory, list construction, elimination and oracle costs differ from CNF branching. Published SAT/XNF/PB decoding comparisons exist, but S3061 recovered no identity mapping from their inputs to this file. [Berton–Cherif–Delaplace](https://link.springer.com/chapter/10.1007/978-3-032-26204-2_12), [quantum ISD](https://arxiv.org/pdf/1703.00263).

**Remaining unknown [provenance and matched comparison].** Recover original H, syndrome, weight condition, generator promise and witness map before comparing methods on the same instance. Infer nothing from 136/18/712. A specialized solver might remove the candidate entirely. No FKO, PCR or resolution lower bound has been joined to this artifact.

## 5. One-in-three SAT and its affine relaxation

**Same relation, different representations.** For a clause with three Boolean literal values, exactly one true implies odd parity, but odd parity also permits all three true. The published 2026 RSRA method uses the parity solution space while retaining residual constraints excluding the unwanted case. [Lu et al., final Results and Methods](https://www.nature.com/articles/s43588-026-01007-8.pdf).

**Limitation [relaxation and empirical evidence].** Gaussian elimination alone solves the relaxed system, not necessarily the original problem. The paper's quantum scaling evidence concerns specified random positive one-in-three instances, not a worst-case lower bound or the SDP competition row. Its final Methods already include subspace-aware classical sampling and random-walk baselines.

**Escape and cost [partial known reduction].** Rank-r affine reduction replaces 2^n assignments by an affine space of size 2^(n-r), when consistent. This reduction is shared mathematical preprocessing, not inherently quantum. The residual “2-SAT within an affine subspace” does not become ordinary 2-SAT merely by naming it so; quotient substitution changes literals into affine functions. Charge reduction, representation, residual checking and parameter acquisition as appropriate.

**Remaining unknown [comparative].** Whether the reported residual quantum benefit survives stronger specialized classical processing and full costs is a live source-identified comparison. There is no new mechanism here, and no guarantee from a good local-energy average to global satisfying-assignment probability without the required error scale. UNSAT certification is separate from both classical and quantum sampling failure.

## 6. Existing paired-path fixed-cut example

**Same explicit input.** Reuse S3056: x_i=y_i for k>=2, positive adjacent-pair clauses on X, negative adjacent-pair clauses on Y, and the supplied cut X/Y. Each local clause graph is a path; the affine coupling is a matching. [Existing derivation and checks](2026-09-11-decomposition-mechanism.md).

**Limitation [exact fixed-rule calculation].** With the specified standard-basis ascending syndrome order, only the two alternating strings survive, and first-witness search attempts floor(2^k/3)+1 syndromes. This is not a lower bound on arbitrary decomposition, ordering or SAT algorithms.

**Escape and cost [known local repair].** Substitute the equalities and combine corresponding positive/negative adjacent clauses; they express inequality of consecutive bits. The resulting sparse affine chain is solved polynomially. The existing note supplies this repair; none is newly implemented here. Small separate blocks and few final survivors did not make finding compatibility free.

**Remaining unknown.** There is no remaining hardness claim for this family. It illustrates why a separator/interface count must be tied to discovery and local work, and why global representation choice matters. It supplies no general efficient decomposition strategy or new research target.

## What the connections do and do not establish

| Connection | Supported conclusion |
|---|---|
| Tseitin to Gaussian; PHP to counting | A representation-specific lower bound can coexist with a polynomial escape on the same explicit relation. |
| FKO to threshold-Frege | Expressing a short certificate and finding it are different resource questions even on the same distribution. |
| SDP panel to specialized decoding | A concrete common timeout can coexist with missing cross-representation evidence; the escape is possible, not demonstrated. |
| Affine relaxation and paired paths | Keeping a compact relaxation or few compatible outcomes does not by itself compute the nonlinear compatibility. |

These are recurring **questions** about representation, information retained, and discovery cost, not one established invariant that lower-bounds all methods. “For each method there is a difficult family” does not imply “there is one family difficult for every method.” Even a same-instance intersection over a fixed finite panel does not quantify over all algorithms.

The strongest supported unresolved theoretical example remains the FKO certificate finder on its specified distribution. The strongest concrete empirical comparison remains the SDP identity/specialized-method gap. They should remain separate. No common structural barrier, new mechanism, or P-versus-NP implication has been established by this map.
