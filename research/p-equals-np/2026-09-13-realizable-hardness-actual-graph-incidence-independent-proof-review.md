# Independent proof review: actual graph incidence

2026-09-13. S3132/S3137 under S3126. Reviewer `/root/matrix_identity_independent_proof` did not author ActualGraphIncidence. **GO-WITH-NOTES for the actual retained-edge incidence bound.** Complete main and Checks were read; no mathematical or statement blocker found.

Source freeze `a5a7562d9852ec100c399de5b560a95c95ea1109`, main SHA256 `15db3bcbfe98d5b07096034358183e457eb2db8e555044ddc3a91bb673aa2b42`, Checks `81deaa23a11218429b9a0ba6aef4955a8545295227e7fba784c05a1319147585`; both raw-identical to current sources. Updated author receipt is frozen at `d3f61b62a69907b6bdb07ba36546654651533bd5`, hash `454d48d8760477e29ea0784c5096231f038c2e0386ffa47eecd5e760c7db27c9`. Author packet hash `6d0691dec192bd52ea790ae11382fc6c7a4c7554fbd91390c1916c609da36dd2` was checked.

Incident p e is actual equality of p with either endpoint of the retained nonloop representative dart. Nonloop distinctness proves these two alternatives exclusive. atPort selects the representative when its source is p and its reverse otherwise. It has source p only under the incidence premise; the theorem does not claim this for unrelated edges.

canonical_atPort holds even without incidence because either orientation canonicalizes to the same full representative dart. This supplies a left inverse for atPort and hence injectivity on full edge identities. The proof does not reduce edges to endpoint pairs. Parallel reversal orbits remain distinct.

On the incident-edge subtype, all selected darts have exactly the fixed source p. Equality of their Fin3 labels therefore gives equality of the full product darts, then equality of representative edges by the previous injectivity. The resulting injection into Fin3 proves at most three retained edge occurrences incident at a replacement vertex. No degree bound, simple-graph hypothesis, endpoint uniqueness among parallel edges or desired injection is supplied by a caller. Cardinality of the actual incidentEdges filter is then identified with the subtype cardinality.

Loops are absent from Edge by construction. The inequality is at most three, not exactly three: omitting loops can reduce incidence. At n=0 no p exists, as the explicit empty-vertex example verifies. This is a bound for replacement ports (original vertex plus port), not for all ports aggregated at one original source variable.

The theorem does not yet count gadget row degrees or include original equations. Turning an incident-edge bound into a cloud variable-degree theorem needs the local terminal degree facts and the actual row enumeration. It also supplies no serialized incidence map, FP witness, majority gap, source NP-hardness or full-paper certification.

Fresh independent root `.lake/build/actual-graph-incidence-independent-review-20260913` uses 305 original accepted artifacts, including independently built ActualGraphEdges, with original/copy/receipt hashes checked. No author Incidence export is reused. The pair runner verifies source freshness, absent target outputs, pinned manifest/toolchain/eleven packages, one thread and physical-memory guards (768 MiB preflight; 640 MiB owned-child stop), and preserves snapshots, raw logs and actual terminal metadata before display. Expected checks are nine profiles, five examples and two signatures. No source edits, Git, package or public changes were made.

## Independent build completed

Authorized session 92916 compiled main and Checks with actual EXIT 0 and unchanged source bytes, then terminated EXIT 0. All nine emitted profiles were parsed and use only propext, Classical.choice and Quot.sound; five examples and two signatures compiled. The main log retains two deprecated if_pos/if_neg warnings; Checks is clean. Source/log/output/metadata hashes and 305 original/copied dependencies were reverified. Embedded raw logs and runner text use direct UTF-8 byte decoding. Compiler ownership was immediately released. No retry, source repair, Git or public action occurred. This supersedes preparation status above; full cloud degree/source equations, FP and hardness remain open.
