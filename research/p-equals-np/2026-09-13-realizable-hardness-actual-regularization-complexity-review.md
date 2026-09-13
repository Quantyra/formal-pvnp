# Actual regularization: independent complexity review

Verdict: **GO-WITH-NOTES** for the conditional finite regularization certificate.
Encoded FP, upstream source hardness and full S3126 certification remain open.

Reviewer incidence_complexity_review did not author this pair. I did author
the related CloudDegree and OccurrenceDegree proofs, the latter imported here.
This review relies on their earlier independent acceptance rather than counting
this pass as a fresh independent audit of my own dependency proofs. The current
assembly/cardinality/fraction statements were inspected independently. The
non-claims pass is by this same reviewer; independent proof/build verification
is separately assigned. No human peer review is claimed.

Read full main/Checks, updated author receipt, actual Allocation carrier/list,
Counts bounds, Completeness extension, Soundness coefficient/conditional
fraction and Degree interfaces, plus assembly and three-lens protocols.
No review-path conflict. Inspected pair matches freeze
15e43dfb7f25f3ee646bd1e73b51c8235a3a56a3 without diff; working SHA256:

- Main: 1519a97bca309cb055deb428965d902fdf56e1d22b57a276424581a3af4cb95a.
- Checks: a3e438133ba7932916067273201396a781b8c8f689dc4c105a38789ebdb6d685.

## Same-instance construction, not an assumed contract

Certificate I refers only to the already constructed I.GlobalVar, I.rows,
I.rowIndices, I.row, I.support, I.edgeCount and I.sourceExtension. certificate
fills every field from actual proofs; it takes no caller-supplied certificate,
output-degree/expansion/charging bound or separate hypothetical row family.
Nonempty (Certificate I) is therefore an actual proved assembly. It is not,
by itself, a complexity-class assertion. Field inspection is essential to
its meaning, and those fields expose the conditional source premises honestly.

Original row injectivity uses actual occurrence anchors; gadget row injectivity
composes the actual cloud embedding with its owner tag. Ordered rows, support
size, pair intersections, degrees and counts all concern this same output.
The rows_nodup conclusion does not erase repeated source equations: distinct
source occurrences are allocated to distinct anchors. Parallel edge occurrences
remain distinct through their fresh internal tags. No endpoint quotient or
pruning substitutes a smaller carrier.

## Cardinalities and fractions

Each cloud has n*D graph ports and five internals per retained edge. The Sigma
sum and actual sum_sizes = 3*m give exactly 3*D*m + 5*E global variables,
including dummy ports and fresh internals. Actual 2*E <= 9*D*m yields twice
the variable count <=51*D*m, and hence the conservative integer bound <=26*D*m.
The arithmetic is consistent; no rounded-down coefficient is used. Row counts
are exactly T=m+4*E and bounded by m<=T<=(1+18*D)*m. These identities include
empty/unused clouds and m=0 without division.

YES fraction uses the explicit global sourceExtension's exact count equality,
eta>=0, m>0, and actual T>=m; it proves error fraction <=eta, not equality
of source and target fractions. NO fraction uses the same output, arbitrary
target assignment, delta>=0, m>0, and the universal source NO promise. Its
coefficient is lambda*delta/(1+18*D), where lambda=min(1,kappa)>0.
Positive delta gives positive gap; gap is not asserted independent of delta.
D/kappa and both blowup constants are fixed independently of the instance
and eta. YES and NO are separate implications, not simultaneous promises.

## Limits of the certificate

Instance supplies the structural distinct-variable input format, not an
NP-hardness theorem or a decoder for malformed wire inputs. Cardinality linear
in explicit row count m is not encoded output bit length or a runtime bound.
No function in the actual machine FP class is provided by this certificate.
Near-perfect/absolute-gap source hardness, encoded construction, full advanced
PCP/decoder/learning and final fixed-L theorem/paper joins remain indispensable.

The author reports session66199 pair0, twelve standard-only profiles, seven
examples and four signatures; packet
8c71ad884c1182deb57a64a6540d9231e958d944a54fe011c1f95348e85a41b2
preserves the failed cardinality elaboration. These are attributed author
results; this source-only pass makes no independent execution/cache claim.
No blocking complexity defect found in the conditional finite assembly.
No compiler, source, Git, package or public action was performed.
