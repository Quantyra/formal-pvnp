# Independent proof review: actual fixed port-cycle family

2026-09-13. S3132/S3126. Reviewer `/root/matrix_identity_independent_proof` did not author these sources. **GO-WITH-NOTES for this bounded actual-family instantiation.** No mathematical or statement blocker found.

Both complete Lean files were read and checked raw-identical to freeze `8c47f49396ce9b37668332b893eda216466c3541`. Main SHA256 `a33cfe1e21f85937f33edad0d722cb81927a003ae2f5896dd9f352e580681ef1`; Checks SHA256 `e8df2852c20b5635e0465f4b75d5f3525e7ed64d4a237f9c32ef566e3818b812`. Inspected the underlying RegGraph.relabel/ofRot definitions and accepted spectral-to-port-cut interface.

## Statement and proof audit

`degree` refers to the actual fixed Complexity.algFamily degree; it is not a caller-supplied constant. Positivity justifies degree = predecessor+1 despite natural subtraction. `finCongr` transports the labels without changing numeric values. RegGraph.relabel conjugates the rotation on labels while retaining vertices and multiplicities. Thus baseRotation has exactly the successor-degree port type required by the accepted replacement construction.

The spectral bound comes from Complexity.algFamily.spectral_graph and its relabel invariance. The ofRot graph in baseRotation_spectral has the same vertex type, dart type and rotation; `change` is checked by Lean's definitional equality, not a new equality premise or an assumed expander. Proof-irrelevant graph fields do not alter its spectral operator.

The replacement graph has degree three and order n*degree, not n vertices. Its vertex type is the port cloud. The boundary/cut identity expands the exact half-total crossing sum with the product dart index; it preserves the accepted counting convention. Loops and parallel edges are retained. Degree three is a dart-degree assertion, not a simple-graph maximum-degree claim after quotienting or deleting multiplicities.

The coefficient is h/[degree*(1+h+degree)], with h=degree*(1-lam)/2 from the actual fixed family. Both factors in the denominator are positive, and h>0 follows from lam<1. Neither degree nor lam depends on n. The final cut/boundary theorem has only n and the actual vertex coloring as explicit inputs; no caller-supplied expansion, spectral certificate, source-hardness or runtime premise remains. The printed full boundary signature confirms this scope.

At n=0 the vertex/port types are empty; graph order and table length are zero and the cut inequality is 0<=0. Nonempty dart type and degree three do not require a nonempty vertex type. The n=1 checks verify order degree and table length 3*degree. The definitions do not take a simple-graph quotient in these cases.

`table` is the actual port-cycle table of this actual base rotation. Its length is 3*n*degree. `baseRotation_values` proves numerical label preservation against Complexity.algFamily.rot; it does not itself give a machine encoding or FP witness. The namespace is noncomputable and uses the library's fixed chosen base. No uniform procedure for finding a new base per n is claimed. Fixed-family implementation and encoded-runtime transfer remain separate work.

## Independent build evidence

Fresh root: companion `.lake/build/fixed-port-cycle-independent-review-20260913`. Reused 299 original accepted upstream artifact files and four graph exports from independent expander session 50193. All 303 originals and copies were hash-verified before launch and after completion. No author FixedPortCycleFamily export was reused.

Exclusive authorized session 6038 compiled main and Checks with two actual EXIT 0 results and terminal runner EXIT 0. Sources remained unchanged. Twelve emitted profiles contain only propext, Classical.choice and Quot.sound; six examples and two fully qualified signature checks compiled. No warning, retry, source edit or guard stop occurred. Compiler ownership was released immediately after terminal completion.

The runner checked the pinned Lean 4.34.0-rc2 identity, manifest and eleven package revisions, used one thread, required 768 MiB available physical memory before each child, and would stop only its own child below 640 MiB. Raw logs and actual terminal metadata were durable before display. The accompanying JSON preserves their hashes and raw UTF-8 strings using byte.decode without newline conversion. Its runner text likewise exactly decodes the LF runner bytes. This avoids conflating the author's historically normalized embedded runner text with its raw CRLF bytes.

This acceptance is limited to the actual constant-degree expanding family and its typed table/rotation facts. It does not certify the encoded rotation as FP, a complete gap-3Lin construction, specialized source hardness, the full paper theorem, or publication readiness. Source headers saying uncompiled remain stale historical comments; actual independent results above supersede them. No Git mutations or public actions were made.
