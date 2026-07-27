# Integrity & Claims Ledger

**Scope:** umbrella Lean development surface for the Quantyra PvNP /
proof-complexity program. Primary audit entrypoint: `lean/PvNP/Audit.lean`.

## Non-claims

This repository does **not** establish or imply:

- `P != NP` or `P = NP`
- an NP or circuit lower bound
- a Frege/PHP lower bound beyond an exactly scoped local theorem **or** a named
  imported classical statement that is explicitly firewalled as imported
- a general lower bound for all proof systems
- a general SAT solver or general CNF-to-XOR recognizer

## How to read this umbrella

| Kind of material | How to cite |
|---|---|
| Local Lean theorem with standard axioms only | Exact FQN + commit/tag + `#print axioms` |
| Named imported classical boundary | Conditional wording only; name the import |
| Magnification / barrier catalogue data | Literature map only; no unconditional separation |
| Curated public artifact (preferred for papers) | That repo’s DOI / release, not this umbrella alone |

## Named imports (examples)

- Expander-Tseitin resolution import boundary in
  `ResolutionImportedExpanderBound.lean` (named axiom; conditional packaging only).
- Bounded-depth Frege/PHP literature bound import in `FregePHPLowerBound.lean`
  (named axiom; conditional packaging only).

Local packaging theorems that consume these imports are **not** local proofs of
the imported combinatorial cores.

## Audit

```bash
elan run leanprover/lean4:v4.13.0 lake build PvNP.Audit
```

Publication exports to narrow public artifacts must carry their own Audit pins
and integrity files in those destinations.

## Hygiene

- No secrets, tokens, or credentials.
- No local absolute filesystem paths or Google Drive paths in tracked docs.
- Claim-language scrub: affirmative “P=NP lane / probe / claim” research jargon
  removed from publication-facing comments (2026-07-26).
