# Decomposition preservation: proof and nonclaims review

2026-09-08. S3040 / S008 / E004. Baseline `5d50555`.
Harness only. One independent reviewer covers the two separately reported
lenses below; these are not two different reviewers. A separate agent supplies
the source/complexity review. No implementation, formal module, build, commit,
publication, or metadata change is part of this review.

Reviewed the stable `2026-09-08-decomposition-preservation-attempt.md`, including
the correction charging distinct created wires rather than repeatedly charging
reused output wires. Read `INTEGRITY-CLAIMS.md` and the parent claim-boundary
and three-lens protocols. No finite experiments are required for the symbolic
implication checked here.

## Proof-adversarial lens: GO for the stated source-dependent implication

I independently opened the [primary DNNF paper](https://arxiv.org/html/1411.1995v3),
checking its definitions and Theorems 1, 4 and 5. It supplies an unbounded
family with fixed positive vertex expansion and fixed bounded degree. Its
size measure is wires. Its lower bound covers general DNNF, without requiring
deterministic OR gates or a fixed structural tree. The paper permits constants
and signed literals. Connected expanders have no isolated vertices, so the
graph CNF has all N vertex variables and linearly many edges. These hypotheses
match the note. This inspection checks applicability; it is not an independent
reproof or formal certification of the external theorem.

The new transfer is sound:

1. For fresh x,t, substitution in
   `F=(NOT x OR t) AND product_edges(x OR u OR v)` gives F[0]=H and F[1]=t.
   Every clause initially depends syntactically on x. Thus the requested first
   bucket is all clauses and its exact projection is H OR t.
2. Conditioning any DNNF for H OR t on t=0 gives a DNNF for H without adding
   wires. Gatewise substitution proves equality; shrinking variable supports
   preserves every AND gate's disjointness. The source lower bound therefore
   transfers, even for an optimal compiler with perfect sharing.
3. The input has O(N) clauses/literal occurrences and uses explicit binary
   variable identifiers, so L=O(N log N) and N<=O(L). Consequently
   N=Omega(L/log L), and the exponential-in-N output bound is superpolynomial
   in L. On fixed-width indexed encodings L=Theta(N log N). There is no
   assumption of unit-cost unbounded variable names.
4. The first bucket starts with O(N) wires, while its output needs exponentially
   many. Thus exponentially many distinct wires must be created at this step;
   reusing old wires cannot avoid this lower charge. The revised cost text
   correctly avoids an invalid per-call charge for already shared output.

The explicit fallback compiler is valid: branch on a remaining syntactic
variable, recursively compile its two substitutions, and conjoin each result
with the corresponding signed literal. Each child omits that variable, making
the new AND gates decomposable. The syntactic variable count decreases, so
recursion terminates, with an exponential upper bound rather than a claimed
polynomial bound. OR gates need no disjointness condition.

The leaf-forgetting argument is also valid. Existential quantification
distributes through OR; at a decomposable AND a forgotten variable occurs in
at most one child. Replacing its two literal polarities by 1 therefore computes
the existential projection, without adding wires. Iterating this proof handles
any finite auxiliary set. In particular, if a DNNF D(V,t,A) satisfies
`exists A D = H OR t`, forgetting A and then conditioning t=0 yields a no-larger
DNNF for H. The auxiliary-variable claim is correct for that exact semantics;
it does not cover arbitrary external auxiliary constraints.

Finally, retaining x-independent factors outside the bucket preserves the
projected relation on every outside assignment. Iterating all variables and
evaluating the resulting constant gives both YES and NO correctly. This is
an informal correctness argument for a finite expensive procedure, not a
polynomial-time result. No blocking proof defect was found.

## Nonclaims lens: GO-WITH-NOTES for bounded exploratory use

The title, opening disclaimer, external-input paragraph, and final scope agree.
The result refutes the universal output-size requirement of a particular
single-DNNF projected-bucket contract. It does not establish a lower bound for
arbitrary circuits, all elimination orders, all SAT procedures, or P versus NP.

The draft expressly states that every selector formula is satisfiable by
x=t=1. Recognizing that witness, selecting t first, keeping ordinary NNF, or
changing the output contract are allowed alternatives. Thus representation
hardness is not confused with SAT decision hardness. The mixed-polarity example
`x AND NOT x` correctly demonstrates why independent forgetting is invalid
when factors share witnesses, without claiming every consistency mechanism is
expensive.

The imported bound remains named and source-dependent, and no new Lean theorem
or independent certification is asserted. The ordinary-vortex timing remark
only says reparametrization does not remove explicit output work under this
chosen representation. It supplies neither a fluid computer nor a standard
polynomial-time simulation theorem.

Safe closeout wording: the proposed universal DNNF bucket repair fails because
a selected first projection can require superpolynomial explicit output;
other representations and adaptive decisions remain open. Preserve this scope
in planning summaries. No claim-boundary expansion or full P=NP goal closeout
is approved by either lens.
