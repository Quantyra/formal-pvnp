# pvnp (private Lean development surface)

Private Lean 4 development repository for the Quantyra P vs NP / proof-complexity
program. This tree contains **only** the Lean proof surface and build metadata.

It is split from the older mixed local workspace
`C:\Users\Dan\Desktop\Projects\Quantyra` so planning, entity ops, and scratch
files are not mixed into the proof repo.

## Scope

- Lean library: `lean/PvNP`
- Toolchain: `leanprover/lean4:v4.13.0` (see `lean-toolchain`)
- Package: Lake package `pvnp`, library target `PvNP`

## Public curated artifacts

Do **not** treat this private repo as the public citation surface. Public
Zenodo/GitHub artifacts remain narrow splits, including:

- `https://github.com/Quantyra/formal-resolution-lower-bounds`
- `https://github.com/Quantyra/formal-switching-lemma`
- `https://github.com/Quantyra/certified-affine-extraction`

## Build

```bash
elan run leanprover/lean4:v4.13.0 lake build PvNP.Audit
```

## Non-claims boundary

This repository is a private research development surface. Presence of theorem
scaffolding does **not** by itself establish `P != NP`, `P = NP`, NP/circuit
lower bounds, Frege/PHP lower bounds, or general SAT-solving claims. Public
wording must follow the Quantyra claim-boundary protocol and the relevant
public artifact `INTEGRITY-CLAIMS.md` files.

## Planning / coordination

Entity planning remains in `C:\Users\Dan\Desktop\Projects\IGH\Quantyra-Planning`.
Active lane tracking: `stories/S008-track-core-quantyra-research-lane.md`.
