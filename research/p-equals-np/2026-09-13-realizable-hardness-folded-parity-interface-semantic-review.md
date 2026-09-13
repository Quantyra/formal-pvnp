# Folded parity execution interface: independent semantic review

2026-09-13. S3132/S3137. Bounded GO-WITH-NOTES for the proposed finite verifier contract, conditional on implementing the explicit identities below. This is source-design review, not Lean acceptance, a source-hardness theorem, or novelty evidence. No Lean edits or compiler run occurred.

## Primary sign convention: retain off-domain bit false

I read the full design, preserved extraction, the relevant primary text, and rendered author-PDF printed pages 6, 15 and 16 to resolve missing minus glyphs. Printed page 6 explicitly uses -1 for logical true and +1 for logical false. Page 15 says satisfying conditioning inputs have h(x)=-1; Lemma 2.34 excludes support points with h(x)=+1. Page 16 pairs (g AND h) with ((-g) AND h). Therefore the design's bit b representing (-1)^b has logical true=bit true=1 and logical false=bit false=0. Its outside-domain canon=false is correct for literal logical conditioning. Changing the default to bit true would cease to be the same conditioned query to the same raw proof table.

Make the convention explicit in the contract: sat(y)=true iff the primary sign-valued h(y)=-1. In bits, conditioning is cond(sat,f)(y)=if sat(y) then f(y) else false. It is logical bit conjunction; sat is an ordinary Bool predicate, not a +1-is-satisfying sign predicate. Negation/complement of a sign-valued truth vector is pointwise Bool.not. This reconciliation is necessary documentation, not a requested function change.

## One raw table and predicate-dependent representatives

For every sorted label list V, use one raw table P_V indexed by full truth vectors on its assignment enumeration. Define D={y | sat(y)}. For nonempty D choose y0=min D and set s=f(y0), c(y)=if sat(y) then f(y) xor s else false. Evaluate E(P,V,sat,f)=P_V(c) xor s.

This is exactly the simultaneous construction on printed page 16 for a definite admissible selection rule: select, from cond(sat,f) and cond(sat,not f), the member whose value at y0 is false. If s=false it is cond(sat,f); if s=true it is cond(sat,not f) and the answer is complemented. The two conditioned candidates are distinct because D is nonempty. No predicate key belongs in the raw address.

The selection rule is uniform as an algorithm but depends on D through y0. It is not a single predicate-independent equivalence relation on all full vectors. Different predicates can select the same full c, and must then read exactly the same P_V(c). This reuse is legitimate and agrees with SWP Definition 3.3, printed page 21. It does not permit prescribing an independent arbitrary conditioned function for every predicate. Future statements should quantify one raw P and derive every E from it.

An arbitrary Nat-valued proof-bit function P induces these tables by P_V(c)=P(address(V,c)). Conversely, the injective address encoding allows extending any fixed family of full tables to a total Nat proof, with default values outside the encoding image; such a semantic extension need not be an executable decoder. Encoding V with the full ordered vector is essential. List labels must be sorted without duplicates and the assignment order fixed globally, so equal sets cannot accidentally denote different tables. No left/right namespace is allowed.

When U=W, the A access uses the full domain and the B accesses use the actual selected-clause predicate. They are different derived evaluations of the same table. They may query identical addresses with equal or opposite signs; this is an intended equality, not a collision defect. For the later decoder argument A_U depends only on U and its fixed folding rule, not on the first prover's clause tuple. B may depend on W and h because the first prover receives that tuple. This question-dependence must survive the formal interface.

## Honest proof versus arbitrary proof

For a single global Boolean assignment x define the honest raw table by H_V(c)=c(index(x restricted to V)). For every selected domain containing that restriction, H_V(c) xor s=f(index(x restricted to V)). This holds simultaneously for every predicate satisfied by x. It does not hold for arbitrary x outside D, and no such claim is needed. Shared-address honesty is automatically consistent: equal V/c produces equal raw H_V(c), regardless of which query constructed it.

For arbitrary P, dependence only on f restricted to D follows from equality of s and c; complementing f preserves c and flips s. Thus the derived table is odd and insensitive to off-domain coordinates for every raw proof, without an honesty assumption. These are precisely the local properties needed for the later odd-support and conditioning-support arguments, but those Fourier arguments are not proved by this note.

Three-query parity uses these evaluated bits, not just the three raw P bits: xor(P(a_i) xor s_i)=false iff xor(P(a_i))=xor(s_i). Retain all three address occurrences even when two or three coincide. The accepted Source rowValue is the sum of three ZMod 2 terms, and rhsValue maps Bool false/true to 0/1, so this algebra identifies the actual satisfaction predicate. For universal source-assignment claims, also state the reverse Bool/ZMod 2 transport using the accepted rhsBool/rhsValue roundtrip; do not silently restrict arbitrary ZMod 2 assignments to an assumed Boolean subset.

## Exceptional domains and actual enumeration

If D is empty, the two conditioned functions coincide. A function constant under conditioning cannot simultaneously be odd. Returning none is correct. The later producer must check globally for such a selected clause tuple and branch to its fixed NO source, rather than replacing only this tuple while claiming exact normal-verifier equality. A full satisfying assignment would restrict to a witness in every tuple's domain, so an empty witness certifies the original CNF unsatisfiable. This proof is valid even with repeated clause occurrences, repeated literal labels and overlapping U/W.

The two repeated-label contradictory rows proposed for NO have exact optimum 1/2: each row value is 3a=a in ZMod 2, so exactly one RHS is met for either value. The single zero-RHS row proposed for the m=0 branch has an all-zero satisfying assignment. Prioritize m=0 or prove the u>=1 question enumeration is empty there; restrict the Q-positive and exact normal-experiment equality theorems to m>0 and no empty domain. The exceptional branches should receive separate promise theorems, not be folded into that equality.

The design's clause-position sampler is a uniform sampler over occurrences. With repeated literals it need not equal uniform choice over distinct variable names. This is correct as a concrete total extension, but application of the primary regular E3-CNF theorem must specify its clause format and reconcile occurrence sampling with the exact clause-variable game. Do not infer that equivalence solely from calling the input CNF. For ordinary three-distinct-variable clauses the two samplers coincide. This is an upstream specialization obligation, not a defect in preserving repeated rows downstream.

## Existing APIs and review boundary

Inspected ActualSourceNormalization Source/Valid/wire, rowValue/rhsValue and flags, and the pinned DataEncode.bitstringEncode_injective API. Source is an ordered List (Nat * (Nat * Nat)) paired with List Bool; Valid is length equality. Construct paired outcomes then unzip, preserving multiplicity. DataEncode already supplies injection for serializing the pair of label list and full vector list; the proposed positive wordNat coding still needs its own injectivity and length proofs. None of these APIs supplies raw decoding or an FP runtime merely from a structured definition.

The repository README and companion README preserve the root/companion toolchain separation and bounded nonclaims. No destination AGENTS.md or docs/protocol.md exists at the checked satellite root; the parent S3132/S3137 routing and companion boundary apply. I authored downstream Normalization, CompactLookup, FiniteBridge, OriginalRows, WireBridge and the paused regularized-producer draft; I did not author this folded-parity design. This review relies on their separately accepted bounded interfaces, not on a new revalidation of those proofs.

The author has now frozen the sign clarification in design commit fddd61d76706c0484f35748042f048e128e6390b (raw=frozen SHA256 549e0fe0 prefix); it retains off-domain false. Implementation must prove the exact cond/pair-selection identity above and quantify a single raw proof family; separate empty-domain and normal equality branches; preserve the clause-position versus distinct-variable sampling obligation. No semantic defect was found requiring a change to the original off-domain false representative. No full Fourier, repetition, source-hardness, runtime or publication claim is accepted here.

## Evidence identities

- C:\Users\Dan\Desktop\Projects\formal-pvnp\research\p-equals-np\2026-09-13-realizable-hardness-folded-parity-execution-interface.md: SHA256 549e0fe033414c5fceca1beaee90ccc33e15d8d863a103100e92702b13b6517b.

- C:\Users\Dan\AppData\Local\Temp\s3132-hastad-optimalinap.pdf: SHA256 864df36f2bc692e47f1c94aff0afec34297e27116a5d76f204199e9ce098fa64.

- C:\Users\Dan\AppData\Local\Temp\s3132-hastad-layout.txt: SHA256 0b771d4539401742c0c41a89a201c318e6557ab6aada7de60df69610614bfe91.

- C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\lean\PvNP\RealizableHardness\ActualSourceNormalization.lean: SHA256 c0c967e5fcaadf0f8388969da96285f4a22caa56a5461c8949bcc9a56cfca7a4.

- C:\Users\Dan\Desktop\Projects\formal-pvnp\certifications\realizable-hardness\.lake\packages\complexitylib\Complexitylib\Encoding\DataEncode.lean: SHA256 5fe45322139611eb24cdcb58e2a03db8056ea62f0231606fed7accd0e7524e97.

Glyph inspection used local renders C:/Users/Dan/AppData/Local/Temp/s3132-fold-review-page6.png, page15.png and page16.png. These are inspection derivatives of the pinned local PDF, not new source acquisitions. Primary page references take precedence over layout line numbers, which shift when form-feed characters are counted as line breaks.
