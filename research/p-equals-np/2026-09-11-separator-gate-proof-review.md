# Minimum-separator gate charge: independent proof review

S3080, begun September 11 and reviewed September 12, 2026. Filename retains the planning date. Under [integrity](../../INTEGRITY-CLAIMS.md). **GO for the scoped failed-inference assessment** in the saved [main](2026-09-11-separator-gate-charge.md). No positive gate-loss inequality, counterexample to R, novel lower-bound method or P-versus-NP result is approved.

## Actual accounting and partial-function minimality

I read S3080's planning story/intake, S3079's exact B2 model and the saved main and complexity review. The inherited [OPS source](https://theoryofcomputing.org/articles/v017a011/v017a011.pdf) supplies a conditional implication, not a shrinkage estimate; its model and quantifiers were independently inspected in the preceding review.

The ledger counts distinct retained gate records after every specified rewrite and final output pruning. Each original gate creates at most one new record, and each retained record has a distinct originating gate. Choosing one origin per retained record and charging every other original gate as lost gives exactly s-r_j. It does not count input-label identification as a removed gate or count a shared record once per path. Unary nonconstant functions remain charged. The displayed sum identity is exact, but supplies no positive average saving.

I independently verified the complexity-originated critical-witness lemma on the actual partial promise problem. Redirect every fanout (and the output if necessary) of a selected gate to an available constant b, then remove that gate and unreachable gates. The circuit is smaller. Minimum separator size implies failure on at least one promised input, regardless of its behavior off promise. If the selected gate originally had value b there, topological evaluation would leave every downstream value unchanged, a contradiction. Hence the witness has the opposite gate value and is sensitive to forcing b. Repeating for both constants gives two witnesses, without any requirement that their promise labels differ or that they lie on a duplication diagonal. No minimization oracle is used.

## Transport and location checks

The author's cofactor transport calculation checks exactly in B2. Restricting a function and then duplicating its cofactor preserves the cofactor's size and cannot increase the original size. Conversely two cofactor circuits can be combined with three gates: one asymmetric AND computing (NOT x_j) AND f_0, one AND for x_j AND f_1, and one OR. The asymmetric AND is one available B2 gate, so no uncharged negation occurs. This yields size(f)<=size(f_0)+size(f_1)+3. It supplies a hard cofactor from size(f)>2T+3, but does not justify such a conclusion from the weaker current promise size(f)>T. The main correctly refrains from claiming a constructed counterexample in the intervening range.

I independently checked the challenger-originated examples outside all diagonals. Parity costs q-1 XOR gates and depends on all q arguments; L>=q-1 holds eventually uniformly throughout the original fixed-beta slab because L grows exponentially in original n while q<=n. Each diagonal has exactly 2^(W/2) tables. With H_n<=W/4-1 and q tending to infinity in the stopping regime, 2^H_n+q 2^(W/2)<2^W. Some table of size>T therefore lies outside their union. These are examples of both promise labels outside the union, not examples locating any particular minimum separator's critical witnesses. The main preserves that essential distinction.

## Verdict and exact remaining gap

The attempted argument needs both promise-preserving transport of the relevant critical witnesses and a justified relation between those witnesses and syntactic record losses. Neither follows from minimality. Even a supplied critical witness on a diagonal concerns sensitivity there, not equality of two syntactic gate records. Semantic equality would itself need a justified additional rewrite before being charged by the specified simplifier.

The main accurately records these missing inferences, preserves arbitrary DAG sharing and depth, and parks this particular argument without declaring R false or establishing a universal obstruction. This is an analysis of why the attempted semantic charge does not presently work. It is not achieved gate-shrinkage progress or a verified new stepping stone. No experiment, code, Lean work, commit or publication was performed by this review.
