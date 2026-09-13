# Independent proof review: encoded fixed-family rotation

2026-09-13. S3132/S3137 under S3126. Reviewer `/root/matrix_identity_independent_proof` did not author this module. **GO-WITH-NOTES for the same-function FP rotation and agreement increment.** Full source/Checks and relevant library definitions were inspected; no mathematical or statement blocker found.

Scope is ExecutablePortRotation main/Checks at `b48024f255ed12d70340c5ca16488218ad37b059`. Exact working/frozen hashes and raw equality flags are recorded in the accompanying JSON. Author packet SHA256 is `692a5224fceb70085763b700b83c2cd6f3d57787e7d6a070acb71be7baca09c7`; author verification is not substituted for the independent run.

## Same-function and hypothesis audit

rotationFn is one total List Bool -> List Bool function. rotationFn_mem_FP proves membership for that definition by composition of actual projection, pairing, length comparison, constant, modular arithmetic and fixed-family rotation functions. The concluding mem_FP_of_eq uses definitional equality to the very rotationFn later appearing in rotationFn_agrees. There is no different fast witness function assumed extensionally equal to the graph, no supplied runtime premise, and no abstract agreement certificate.

The external branch calls algBase.famRotFn at levelBound=2*X. Inspected famRotFn_mem_FP and famRotFn_eq: the former proves FP for each fixed finite base/polynomial, and the latter identifies its output using a fit-level upper bound. The present fitLevel_bound actually discharges that bound with fitLevel_le. external_agrees derives n>0 from an actual v:Fin n, then uses famRotVal_eq and the already accepted baseRotation_values. It does not assume agreement with the intended graph.

algBase is a single Classical.choose of exists_finBase. It is independent of n, and all finite base data and degree constants may be fixed in the program witnessing FP. This is compatible with an existence theorem for one polynomial-time machine; it is not an algorithm to discover the base anew, a numerical extraction of its table, or an observed executable evaluation. The noncomputable declaration is therefore not itself a contradiction of FP membership, but claims of a supplied runnable extracted base would exceed this evidence.

The two cycle branches compute j+1 mod degree and j+(degree-1) mod degree, returning reverse dart labels 2 and 1 respectively. Forward/inverse finRotate value theorems connect these arithmetic operations to the exact accepted port-cycle rotation. degree positivity handles modulo and natural predecessor; degree_eq keeps the successor index type and actual constant degree synchronized. Case analysis covers every i:Fin3. The external branch returns label zero. Thus all three cases identify the same actual involution, retaining loops and parallel darts.

Agreement is for every valid canonical encoded dart, with v:Fin n and the exact port index type. This domain is nonempty for positive n because the fixed degree is positive and Fin3 is nonempty. For n=0 there are no valid vertices; a separate theorem proves every zero-size canonical raw request returns empty. Invalid vertex/index/label canonical requests likewise return empty, so the positive-input agreement is not being used to hide zero-size behavior.

Input fields encode sizes and indices in unary through nested pairing. FP is with respect to this encoded bit length; it is not a binary-n cost theorem. Projections and length operations on arbitrary strings remain total, but neither all-true unary syntax nor canonical outer pairing is validated. Malformed raw strings can be interpreted by these projections and lengths. That behavior is explicitly part of the chosen total extension; only invalid numeric canonical requests have the stated rejection theorems.

This proves no full serialized replacement table, no occurrence/equality gadget, no bounded-degree gap-3Lin reduction and no full hardness theorem. It establishes the narrow encoded rotation FP/agreement connection that those later constructions may use.

## Independent preparation

Fresh output root: companion `.lake/build/executable-port-rotation-independent-review-20260913`. Copied and rehashed 2762 artifacts from original accepted locations, covering 212 upstream modules and six accepted satellite exports. All 212 original/local source hashes and trace hashes were rechecked; each local source was compared with the pinned Git blob after LF normalization, retaining separate raw hashes. Acceptance receipts and historical log hashes were also checked. No Rotation author output was copied.

This reuses original accepted upstream builds; it is not a fresh compilation of the 212-module dependency closure. The independent pair runner rechecks source/artifact/receipt hashes, toolchain and eleven pins, fresh output absence and one-thread memory guards (768 MiB preflight, 640 MiB owned-child stop). It preserves source snapshots, raw logs and actual exit metadata before output display. Embedded runner/log text uses direct UTF-8 byte decoding, with newline normalization recorded only where source/Git comparisons require it. Expected checks are fifteen profiles, seven examples and two full signatures.

## Independent build completed

Authorized session 46598 compiled main and Checks with actual EXIT 0 and unchanged sources, then terminated EXIT 0. Fifteen emitted profiles were parsed and use only propext, Classical.choice and Quot.sound; seven examples and both full-signature checks compiled. The printed FP theorem names the identical rotationFn used by agreement and has no extra premise. Main log is empty; no diagnostics were emitted. All 2762 original/copied artifacts and 212 original/local source hashes were rechecked after the run, along with the two source/log/output/metadata triples. Compiler ownership was released immediately. No source repair, retry, download or public action occurred. Full table/gadget/source-hardness and paper completion remain open.
