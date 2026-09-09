# Holographic literature checkpoint: the complete SAT signature language

S3040 / S008 / E004, 2026-09-09. Informal primary-source audit under
`INTEGRITY-CLAIMS.md`. No implementation, experiment, formal theorem increment,
publication or complexity separation is claimed.

**Decision:** reject the proposed conventional common invertible 2-by-2 basis
into planar matchgates, and the equality-compatible common-basis affine or
product-type targets. Published signature criteria already exclude the
OR3/equality subset. This is not a rejection of every holographic algorithm,
input-dependent encoding, or zero-preserving SAT procedure. There is no
literature-supported general SAT algorithm to implement from this checkpoint.

## 1. Primary sources and exact scope

**Cai--Fu**, [full primary preprint, arXiv:1603.07046](https://arxiv.org/pdf/1603.07046),
[published SIAM article](https://epubs.siam.org/doi/10.1137/17M1131672):
Theorem 6.1-prime, printed p.80, classifies planar Boolean #CSP(F): tractability
occurs for F contained in A, P, or Hadamard-transformed matchgates; otherwise
counting is #P-hard. Section 2 uses algebraic complex coefficients for the
computational model. Equality of arbitrary arity is implicit in #CSP; planarity
concerns the variable/constraint incidence graph. This is not a classification
of all planar Holant algorithms. Apply the criterion to OR3: its support has
seven points, whereas affine support, and unary/equality/disequality product
support, have power-of-two cardinality. Thus OR3 belongs to neither A nor P.
With unnormalized Hadamard H, H^(tensor 3) OR3 is [7,-1,-1,-1], violating
matchgate parity. This directly checks all three canonical #CSP cases.

**Cai--Guo--Williams**, [full primary preprint, arXiv:1307.7430](https://arxiv.org/pdf/1307.7430):
Theorems 1.1--1.2 give polynomial recognition/construction for affine/product
holographic transformations, with full-table and symmetric succinct input
models respectively. Definition 2.6 includes transformed EQ2 compatibility.
A stronger explicit test here uses Definition 6.3:

    OR3 = (1,1)^(tensor 3) + (-1,0)^(tensor 3),
    theta = ((a0*a1+b0*b1)/(a1*b0-a0*b1))^2 = 1.

The vectors are independent; OR3's flattening has independent rows
[0,1,1,1] and [1,1,1,1], so it is nondegenerate. Corollary 6.8 requires
 theta in {0,-1,-1/2} for affine transformability. Lemma 2.12 and Lemma 6.7
require theta in {0,-1} for product transformability (P2=A2). Both fail.
These are evaluated necessary criteria, not an assertion that recognition
software was executed. They apply because left EQ2 transforms as
EQ2 T^(tensor 2), while right OR3 transforms by (T^-1)^(tensor 3), exactly
Definition 2.6. No equality-free arbitrary tensor-orbit exclusion is inferred.

**Cai--Lu**, [published primary full text, JCSS 77 (2011), 41--61](https://pages.cs.wisc.edu/~jyc/papers/matchgate-arts-to-sc.pdf),
DOI 10.1016/j.jcss.2010.06.005: Definition 4.3 and Theorem 4.1, printed
pp.49--50, recognize simultaneous realizability of symmetric generators and
recognizers on a common size-one basis. Section 5.1, p.50, applies the exact
basis conditions to EQ2 generators and OR_k recognizers. Compatibility requires
omega^2=2 and omega^k=+1 or -1, hence 2^k-1=0 in the coefficient field.
For k=3 this is impossible in characteristic zero. This already excludes our
larger signed SAT language. Theorem 5.1's modular construction must retain its
modulus: an integer count reduced modulo 7 does not preserve its zero status.
The formula (x OR y OR z) AND (x OR y OR z) has seven satisfying assignments
and residue zero; every variable occurs twice and its incidence graph K2,3
is planar. The
symmetric recognition theorem does not itself cover an arbitrary nonsymmetric
crossing tensor or unrestricted higher-dimensional encodings.

## 2. Full constraint contract, not isolated OR gadgets

The companion [SAT contract](2026-09-09-holographic-sat-contract.md) specifies
a bipartite network with left generators and right recognizers. The two
obstructions above use exactly its left EQ2 and right OR3, so adding more
required signatures cannot restore a common basis into the same target class.

| Required operation | Exact obligation for this encoding |
|---|---|
| Clause | OR3=[0,1,1,1], in symmetric Hamming-weight notation. |
| Negated occurrence | Binary disequality NOT(x,y)=1[x differs from y], not a change of sign of the clause tensor. |
| Equality/copy | EQ1, EQ2 and EQ3; a tree of ternary equality nodes and identity subdivisions implements higher fanout with unique internal extension. |
| Pins | Both delta0 and delta1 are explicit signatures when shortening clauses or conditioning for readout. They cannot be silently granted after transforming the other signatures. |
| Crossings | For cyclic boundary order (a,b,c,d), the ordinary wire crossing is 1[a=c]1[b=d]. A different signed tensor requires a proof that the complete contraction retains the required output. |

The contract's copy-tree and Boolean-gate encodings are polynomial size with
unique auxiliary assignments, preserving the integer count. A global basis
change does not change the underlying graph. Consequently a successful local
signature conversion would still require compatible graph geometry. In
particular, tensor-factor notation does not eliminate crossings or independent
copy obligations. The OR3/EQ2 failures arise before these additional tests.

## 3. What the exclusions do and do not establish

Exact count preservation, or preservation up to a known nonzero factor, would
permit SAT decision by an exact zero test. Local preservation of Boolean
support is weaker: signed or complex contributions can cancel after summation.
A proposed decision-only gadget therefore needs an all-instance equivalence
between SAT and nonzero output; matching supports or reducing counts modulo a
fixed integer does not supply that equivalence.

The counting-hardness branch of a classification is not an unconditional
proof that polynomial counting is impossible and is not a SAT lower bound.
For example, monotone OR formulas are satisfied by the all-one assignment;
the counting problem and its decision version have different obligations.
The concrete no-go conclusions here instead use incompatible algebraic
signature conditions. They concern a common size-one basis and the stated
matchgate, affine, or product target, including equality compatibility.

Edge-dependent bases, instance-dependent gadgets, larger encodings and other
tractable targets are not certified or universally excluded by this audit.
They need their own simultaneous contraction identity, uniform construction,
geometry and output analysis. Merely assigning a separately convenient basis
to every gate does not discharge those requirements.

For fixed constant-arity rational signatures the initial tables are constant
size. If transforms or gadgets vary with the input, their algebraic degrees,
coefficient heights, description sizes and construction costs must be charged.
An exponentially large truth table is not a polynomial input representation
just because its arity is short to write. Exact zero testing also needs the
specified finite representation; arbitrary complex constants are not a free
computational oracle.

## 4. Bounded disposition

The concrete operation supported by the literature is simultaneous signature
recognition followed, when it succeeds, by the corresponding exact contraction
algorithm. Here published necessary tests already reject the three proposed
common-basis targets. Implementing the failed transform search would add no
missing general-case argument. No benchmark or new special-case construction
is warranted by this checkpoint.

A future proposal would need a materially different explicit transformation
contract and an efficiently evaluable target, with count or zero preservation
proved for the entire signed SAT network. This audit supplies no such proposal,
and makes no novelty, full-literature-exhaustiveness, or P-versus-NP claim.
