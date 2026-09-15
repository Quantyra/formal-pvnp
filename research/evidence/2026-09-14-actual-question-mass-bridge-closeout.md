# Actual question mass bridge closeout

Date: 2026-09-14

## Exact obligation

The frozen theorem is:

    theorem rowId_incidence_card_le_four
        {N m : Nat} (I : ActualOccurrenceAllocation.Instance N m)
        (x : I.GlobalVar) :
        ((Finset.univ : Finset I.RowId).filter
          (fun q => x ∈ I.support q)).card ≤ 4

This is the concrete occurrence-sensitive row-incidence degree input required by the manuscript route from the actual source law to the later ordered-question mass argument. The theorem has no added assumptions: its only inputs are the concrete allocation instance and a global variable.

## Implementation and proof route

ActualQuestionMassBridge.lean proves the exact bridge rowId_incidence_card_eq_degree from the filtered Finset I.RowId cardinality to ActualOccurrenceDegree.degree I x using I.rowIndices_toFinset, I.rowIndices_nodup, I.rows_eq_map, List.countP_map, and I.support_eq. The public theorem then rewrites by this equality and applies ActualOccurrenceDegree.degree_le_four I x. The proof retains occurrence row IDs and does not deduplicate equal row values or add a degree premise.

Frozen source hashes:

| Source | SHA256 |
|---|---|
| ActualQuestionMassBridge.lean | 6489420AFB68BA48237D3BB181AD4FFD2B4B9669356D0E7BDB611D7594E08727 |
| ActualQuestionMassBridgeChecks.lean | 4765B053B42AFA083C07A737F14CA0691DB2B2C67C957D550EE16CFE099055D5 |

## Canonical verification

Canonical evidence folder:

research/evidence/2026-09-14-actual-question-mass-bridge-refactored-fresh-run/

The v4.34.0-rc2 direct Lean run compiled main and Checks sequentially, with the target seeded from the recorded probe overlay and the merged temporary root excluded. Both commands exited 0 with zero errors. The exact public signatures and #print axioms output are recorded in checks.stdout.

| Artifact | Result or SHA256 |
|---|---|
| Main exit | 0 |
| Checks exit | 0 |
| Main object | 3C94A1D0E386C5C8C1CC93767D3FB5244CCFEAB22347637DEBE9B6F2E38694AA |
| Checks object | B253F4C702CB9AFD115D34B5B9BEE0F498D80F70A5FEA8B98CDEC9C19AF1E28B |
| Axiom profile | propext, Classical.choice, Quot.sound only |
| Forbidden-token scan | exit 0; no forbidden token found |
| Source stability | before and after hashes identical |
| terminal.json | 894B8BEDE600348F0C86BA79207A81E2E14C91890711175396F8423F811B9E1A |
| artifact-hashes.txt | 1A56744B56CE08FAE5134ED46D1F8AA97494BE32D446386E560FBC598445BFCB |
| overlay.manifest | EDE8C0A45D3CE3D71344AA8E13F1F0894EFED50568DB219C18C9DE891DCCC46F |
| package-revisions.txt | 6269F31895613561DB9B5A5990991BEE7EF9D38A05A08B6F1A67E7FC04EFDDCB |

Raw stdout/stderr, exit metadata, source hashes, target seeding, dependency provenance, object hashes, and the scan transcript are retained in that folder.

## Three-lens review

| Lens | Verdict | Review SHA256 |
|---|---|---|
| Proof-adversarial | GO-WITH-NOTES | 0539C7B796043BFFA5DF8985A17E67BD1D2D20AA53E5201787EC0EC01973A7EF |
| Complexity theory | GO-WITH-NOTES | DD7F348C06163A8E0598D5F867B0D2A95DA5C1C6259F2A246CEAD28C40F2FB02 |
| Non-claims boundary | GO-WITH-NOTES | 99DD6437670D71369563FFD6811C712ACC6925A675A239F99956CF01811700BC |

The review note records a meaningful repeated-owner fixture with two source rows, occurrence-anchor injectivity, and exact cardinality-to-degree equality. A proposed direct numeral fixture and separate internal-variable example were not added because the dependent noncomputable cardinality did not reduce by ordinary computation; the general imported degree theorem already covers both port and internal cases. This is retained in hardening-numeric-blocker.txt.

## Claim boundary and next consumer

The direct consumer is conflict_degree_le, instantiated with the concrete incidence bound D = 4. The current increment establishes the source incidence premise only. It does not prove conflict counting, question mass, conditioning, acceptance, the reduction, hardness, P versus NP, or publication.

Explicit remaining boundaries are:

- no conflict_degree_le or conflict count;
- no ordered-question mass or conditioning theorem;
- no acceptance theorem;
- no randomized reduction;
- no hardness claim;
- no P versus NP claim;
- no publication conclusion.

The exact next route is:

    actual occurrence allocation
      -> rowId_incidence_card_le_four
      -> conflict_degree_le
      -> bad ordered-question count
      -> ordered GoodQuestion mass and conditioning
