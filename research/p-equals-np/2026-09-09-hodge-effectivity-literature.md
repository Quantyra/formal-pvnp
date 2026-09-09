# Rational Hodge conjecture: bounded effectivity literature audit

S3040 / E004. Informal literature checkpoint under `INTEGRITY-CLAIMS.md`.
Both proof and counterexample directions are in scope. No theorem development,
experiment, implementation, publication, or claim about resolving Hodge or
P versus NP is made.

**Decision:** the checked literature supports concrete finite algebraic
operations, but this checkpoint identifies no justified general proof or
counterexample attack. Conditional decidability must not be used as an
unconditional decision procedure, and finite search failure must not become
a nonalgebraicity certificate. Simpson's full text was not recovered, so
its detailed algorithm remains a specifically recorded source limitation.

## Target and variants

The target is: for every smooth projective complex variety X and every
rational class gamma in H^(2p)(X,Q) of type (p,p), gamma belongs to the
Q-linear span of codimension-p algebraic-cycle classes. A positive instance
requires a finite rational combination, not necessarily an effective cycle.
A counterexample requires all these hypotheses and nonmembership in that
entire rational span. [Deligne's official problem description, Section 1 and
Section 2(i)–(v)](https://publications.ias.edu/sites/default/files/hodge.pdf)
specifies the rational projective statement, discusses the integral failure,
and explains that merely Kahler variants have counterexamples. Those variants
do not disprove this target. The document's Section 4 algorithm remark is
historical and is not asserted here as an up-to-date general impossibility.

Torsion obstructions that disappear after tensoring with Q, lack of an
effective representative, and nonprojective examples all require this scope
check. Likewise, proving a class is not Hodge may prove it nonalgebraic, but
then it is not a counterexample to the conjecture.

## Primary-source ledger and exact scope

### Simpson: verified abstract, unavailable detailed proof

[Publisher record and abstract](https://www.sciencedirect.com/science/article/pii/S0304397507007578),
Carlos Simpson, *Algebraic cycles from a computational point of view*,
Theoretical Computer Science 392 (2008), 128–140,
[DOI 10.1016/j.tcs.2007.10.008](https://doi.org/10.1016/j.tcs.2007.10.008).
The abstract says that the Hodge conjecture implies decidability of whether
a supplied topological cycle on a smooth projective variety over algebraic
complex numbers has an algebraic representative. It proposes searching for
representatives of classes already known to be Hodge.

The [author's publication page](https://math.univ-cotedazur.fr/u/carlos/papers.html)
confirms the paper but links only the DOI. Publisher full-text/PDF access and
bounded title/DOI searches did not recover the full paper. Therefore this
audit does not certify Simpson's theorem numbering, exact chain encoding,
period-comparison implementation, degree bounds or termination proof. It
also does not read the abstract as an integral-cycle theorem. The rational
homology formulation is independently reported in PTvL Section 2 below;
that is attribution by another primary research paper, not original-proof
verification. The direction of implication is conditional on HC, not a proof
of HC or a counterexample detector valid if HC fails.

### Poonen–Testa–van Luijk: explicit conditional stopping

[Primary full text, *Computing Neron–Severi groups and cycle class groups*](https://math.mit.edu/~poonen/papers/compute_ns.pdf).
Section 7 specifies homogeneous ideals, explicit integer combinations of
integral subvarieties, and finitely generated field/Galois-module data.
Proposition 7.8 computes singular cohomology groups in characteristic zero;
Theorem 7.9 proves its finite-coefficient cohomology-computability hypothesis
there. These are not rational Hodge-class membership algorithms.

Lemma 8.11 semidecides numerical independence by finding complementary
cycles with nonzero intersection determinant. Corollary 8.14 produces rank
lower bounds without a stopping certificate. Theorem 8.15(a), under
Hypothesis 7.4 and E^p (numerical equals homological equivalence), halts iff
T^p (the Tate surjectivity conjecture) holds and then returns numerical-cycle
rank. Its proof runs upper and lower bounds until they meet. Part (b) instead
requires the correct rank as input. This is neither an unconditional HC
algorithm nor a way to recognize nontermination. No polynomial bit bound
is supplied by these statements. For characteristic zero, retaining
Hypothesis 7.4 as an additional open assumption would be inaccurate.

### Urbanik: a genuine bounded-degree operation, different output

[Primary preprint, *Sets of Special Subvarieties of Bounded Degree*](https://arxiv.org/pdf/2109.07663),
[published article](https://doi.org/10.1112/S0010437X23007029).
Theorem 1.6 in the inspected preprint gives a terminating algorithm for a
polarizable variation of Hodge structure on a smooth quasi-projective base,
a fixed projective compactification and ample line bundle, and integer d.
The output is the constructible Hilbert-scheme locus of weakly special
subvarieties of degree at most d; Theorem 1.7 establishes constructibility.
It need not be a finite list of points. Section 2 specifies finite affine
presentations, computable field operations and algebraic bundle/connection
data; the geometric case uses algebraic de Rham data and Gauss–Manin.

This is an effective Hodge-theoretic result and prevents a blanket assertion
that nothing relevant is computable. It does not construct algebraic cycles
representing a chosen class, supply a universal degree cutoff, or compute
the complete algebraic-cycle span on one arbitrary fiber. No polynomial-time
or practical implementation bound is inferred here. The preprint's discussion
after Corollary 1.8 explicitly separates weakly special loci from the more
difficult general special-subvariety question.

## Encoding and where the proposed inference loses its bound

A concrete computational task must supply finite equations, coefficient-field
representations and a specified complex embedding, together with a marked
rational homology/cohomology class and a verified comparison convention.
Numerical coordinates alone do not specify exact rationality or an exact
Hodge condition. Arbitrary complex coefficients are not automatically finite
algorithm inputs. Simpson's algebraic-number input restriction therefore
cannot silently be promoted to every complex variety. This audit proves no
reduction of the full conjecture to that restriction.

For a proof route, an exhibited cycle must be checked on the intended variety
and compared with the intended class, with rational coefficients and
multiplicities accounted for. Finding representatives for finitely many
examples does not prove the universal statement. Even finite-dimensional
cohomology does not identify when an enumerated algebraic subspace is
complete. A missing bound may reside in degree, field extension, coefficient
height, comparison precision or the stopping criterion. None is a free
resource merely because each candidate has a finite description.

For a counterexample route, certified nonmembership in the span of all cycles
up to degree d only addresses that cutoff. Failure to find a cycle after
finite time is weaker still. To pass from such evidence to a counterexample,
one needs an independent exhaustive-span certificate or a genuine obstruction
valid for every degree and every rational combination, while retaining the
Hodge condition. Assuming HC to obtain a terminating decision method cannot
serve as that independent obstruction. Nor does numerical near-vanishing
certify exact period vanishing. A certified nonzero period or component whose
vanishing is required by the claimed (p,p) condition excludes that Hodge
premise rather than establishing the desired counterexample; arbitrary
nonzero periods do not exclude a Hodge class.
These are logical requirements of the two goals, not a claim of undecidability.

## One supported operation and checkpoint disposition

A concrete available operation is PTvL Lemma 8.11's intersection-matrix
certificate: from explicitly enumerated cycles, produce complementary cycles
and a nonzero determinant to certify numerical independence. A successful
certificate raises a rigorous lower bound; an unfinished search says nothing
negative. This is a useful bookkeeping operation, not the missing HC attack.
Urbanik's supplied-degree locus algorithm is another bounded tool, with a
different output contract. Neither fills the universal span/completeness gap.

Accordingly there is **no justified next general proof or counterexample
attack from the checked sources alone**. Stop at this literature checkpoint;
do not launch an unbounded cycle search or reinterpret its timeout as evidence
against HC. A later proposal would need explicit input data and one new,
independently justified representative-construction or exhaustive-obstruction
mechanism. Recovering Simpson's full text could refine the computational
contract, but is not itself such a mechanism. This is a bounded negative
feasibility assessment, not an impossibility theorem or an exhaustive survey
of Hodge theory. The overarching research objective remains incomplete.
