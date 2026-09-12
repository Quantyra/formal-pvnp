# Minimum-separator gate charge: failed witness transfer

S3080, started September 11 and drafted September 12, 2026. Filename retains the planning date. Under [integrity](../../INTEGRITY-CLAIMS.md); uses the exact finite-slab model and unproved R from [S3079](2026-09-11-fixed-threshold-restriction.md). Draft for independent three-lens review. No implementation, experiment, Lean, novelty or P-versus-NP claim.

**Outcome:** minimum-separator semantics gives genuine promised critical witnesses, but the attempted transfer of those witnesses to the duplication diagonals fails at two identifiable steps. No quantitative gate-loss bound is obtained. This is not a counterexample to R. The current argument cannot justify a further charge-proof campaign without a new witness-transport or gate-record mechanism.

## Joint records and the actual quantity

Fix original n,beta,L,T and q in the S3079 finite slab. Write W=2^q and let C be a minimum-size B2 promise separator with s=S_q(L,T) gates. For j in [q], D_j is the set of truth tables of functions ignoring argument j. Its embedding rho_j maps W/2 table bits to W bits by duplicating the appropriate pairs.

For each j independently, process the same topological order of C. Map input labels to their rho_j labels, retain constants, evaluate constant functions, bypass projections and valid equal-input simplifications, and hash-cons identical B2 gate records (gate function plus ordered predecessor records). A nontrivial unary function still costs a gate. After processing, retain only records reaching the output. This is the S3079 simplifier; it does not decide arbitrary semantic equivalence. Let r_j(C) be the number of distinct retained gate records and let loss_j(C)=s-r_j(C).

For an exact gate-level ledger, give every retained record one originating original-gate label, choosing the earliest origin in the fixed order. Different retained records have different chosen origins. All other original gates are charged as lost, whether bypassed, merged or pruned. This assigns each original gate an indicator ell_(v,j), with

    sum_v ell_(v,j) = loss_j(C),
    sum_j sum_v ell_(v,j) = q s - sum_j r_j(C).

Pruning and shared fanout are included once, not once per path. Input identifications are not gate losses. R asks for some minimizing C and some j with loss_j(C)>=(1-2^(-1-epsilon))s. An average charge of this size would suffice, but is stronger than the existence claim and has not been established. The identity above supplies no positive lower bound on its own.

## What minimum size actually forces

For every gate v and b in {0,1}, replace the output of v by the free constant b at all fanouts and prune. This saves at least the gate v. Since C is a minimum separator, the resulting circuit C_(v<-b) fails on some promised table x. On that table, the original value v(x) must differ from b, and forcing v to b changes C's output. Thus each gate has a promised critical witness for each constant replacement.

The two witnesses need not have opposite promise labels, need not agree across gates, and need not lie on any D_j. This statement was originated by the independent challenger and cross-checked by the proof reviewer. Its proof uses actual minimum-separator semantics, not an arbitrary padded circuit. It does not give a distribution of witnesses or a rule choosing them favorably.

## Attempted transport into a diagonal

The natural operation on a critical table f is to fix argument j to b and duplicate the resulting cofactor into a table g in D_j. Because B2 allows substitution of constants without increasing gate count,

    size(g)=size(f|x_j=b)<=size(f).

Consequently every YES table maps to YES by this operation. The corresponding NO assertion does not follow. The explicit three-gate multiplexer gives

    size(f)<=size(f|x_j=0)+size(f|x_j=1)+3.

Use one gate for NOT(x_j) AND f0, one for x_j AND f1, and one OR gate; the first is a single B2 gate, not a free NOT. This inequality guarantees a NO cofactor only from size(f)>2T+3. Our exact NO promise is merely size(f)>T. The interval of missing guarantee is material; widening the source promise to repair it would change the problem and would need a new connection to the OPS antecedent.

This is a failed inference, not a constructed example whose every cofactor is easy. No assumption is made about which end of the NO range contains a critical witness. Moreover, even if a particular cofactor remains promised, C's internal gate values and forced-gate output difference are evaluated on a different W-bit table. The criticality relation need not be preserved by the implication size(g)<=size(f). The attempted transport therefore lacks both a NO-label guarantee and a criticality-preservation argument.

For YES witnesses the label problem disappears but the second failure remains. Minimality proves that constant replacement fails somewhere on the original promise; it does not prove it fails on the union of diagonals. Replacing this existential statement by one about each D_j is the precise unsupported step in the proposed semantic charge.

## The location gap is real, but not a refutation of R

Both promise labels occur outside all the selected diagonals. Parity on q variables has a B2 circuit with q-1 XOR gates and depends on every variable. Hence it is YES outside every D_j whenever q-1<=L, which holds eventually throughout the original fixed-small-beta slab.

For NO, each D_j contains 2^(W/2) tables, so their union has at most q*2^(W/2). The S3079 count bounds the number of tables with size<=T by 2^H_n. In its counting regime W>=4(H_n+L+1), and for sufficiently large q,

    2^H_n + q*2^(W/2) < 2^W.

There is therefore a NO table outside the union. The challenger supplied this counting observation; independent proof review is required for its use here. These examples show that membership in a promise class alone cannot locate a witness on a diagonal. They do not show that any minimum separator's critical witnesses avoid every diagonal, let alone that every minimum separator violates R.

## Why semantic importance still does not charge syntactic losses

Criticality means a gate is necessary somewhere before restriction. Loss_j measures which records become unnecessary or coincide after one specific restriction. Necessity before restriction has no proved monotone relationship with that loss. A critical witness on D_j, even if supplied, would ordinarily certify that constant replacement is still wrong there, rather than demonstrate a gate collapse. A valid positive charge would need an additional argument about equivalences, substitutions or common records, not only witness existence.

Even equality of two gate functions on D_j is not automatically equality of their topological records. The stated simplifier merges identical records and specified trivial rewrites, not arbitrary equivalent subcircuits. Stronger semantic minimization could decrease r_j, but using it would change R's constructive simplification contract; it cannot be treated as a free operation. The present count deliberately includes every retained gate and all sharing.

Thus the proposed path 'minimum size -> critical promised witnesses -> diagonal witnesses -> many merged records' breaks at witness transport and again at the semantic-to-syntactic inference. Neither the input dependence bound from S3079 nor a generic circuit-wiring example fixes either break. No lower bound on sum_(v,j) ell_(v,j), beyond nonnegativity, has been derived in this attempt.

## Sources, selection and review

The [published OPS theorem, Definition 2.4 and Theorem 1.4](https://theoryofcomputing.org/articles/v017a011/v017a011.pdf) supplies the exact promise and conditional direct implication. [Chen-Hirahara-Oliveira-Pich-Rajgopal-Santhanam, Sections 1.3 and 5](https://arxiv.org/pdf/1911.08297) explains locality barriers for named models and techniques. Its oracle-extended Formula-XOR statements are not a theorem excluding the present general-circuit gate charge. Both primary PDFs were reopened; no source theorem asserts our proposed shrinkage. Criticality, multiplexer transport and record accounting above are elementary local derivations, not claimed new techniques.

The next action is not another parameter adjustment or syntactic padding test. A continuation would need a specific mechanism translating separator semantics into record collapse despite the two failures just identified. None is supplied here. Park this particular witness-to-diagonal charging argument; R remains open in this investigation, and the continuing goal remains unresolved.

Closeout metadata: September 12, 2026; September 11 filenames retain task continuity.

| Lens | Actual verdict and scope |
|---|---|
| [Proof-adversarial](2026-09-11-separator-gate-proof-review.md) | GO: exact loss ledger, criticality, transport inequality and outside-diagonal diagnostics. Independently checks challenger-origin observations. |
| [Complexity](2026-09-11-separator-gate-complexity-review.md) | GO: actual saved failed argument and gate accounting. No positive charge or R counterexample approved. |
| [Non-claims](2026-09-11-separator-gate-nonclaims-review.md) | GO: final main and ledger retain the failed-inference scope, unproved R and parked witness-transfer argument. |

This note does not count the conditional S3079 implication or these diagnostics as achieved gate-shrinkage progress. No Lean or implementation verification is claimed.
