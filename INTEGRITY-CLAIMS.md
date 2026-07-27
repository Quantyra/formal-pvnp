# Integrity & Claims Ledger (private umbrella)

**Scope:** private Lean development surface for the Quantyra PvNP program.
This file states the default non-claims posture for the umbrella repository.

## Non-claims

This repository does **not** establish or imply:

- `P != NP` or `P = NP`
- an NP or circuit lower bound
- a Frege/PHP lower bound beyond an exactly scoped, audited theorem statement
- a general lower bound for all proof systems
- a general SAT solver or general CNF-to-XOR recognizer

## Public citation rule

Do **not** cite this private umbrella as the public archival artifact.
Cite the relevant public curated repository and DOI instead, for example:

- `formal-resolution-lower-bounds` (resolution / Tseitin DAG size-width line)
- `formal-switching-lemma` (switching / bounded-depth schedule line)
- `certified-affine-extraction` (affine extraction line)

## Audit surface

Primary axiom-audit entrypoint:

```bash
elan run leanprover/lean4:v4.13.0 lake build PvNP.Audit
```

Publication-facing exports must carry their own `Audit.lean` pins and
`INTEGRITY-CLAIMS.md` in the destination public artifact.

## Hygiene

- No secrets, tokens, or credentials belong in this repository.
- No local absolute filesystem paths or Google Drive paths belong in tracked docs.
- Scratch, planning, and entity-ops material belong outside this Lean-only tree.
