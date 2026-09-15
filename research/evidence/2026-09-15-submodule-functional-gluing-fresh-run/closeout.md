# Submodule-functional gluing certification closeout

- Status: certification PASS; independent three-lens reviews are intentionally out of scope and remain pending.
- Repository commit: `52324cc3f6f307332c5ceca07668eb8c18e379c1`.
- Frozen main SHA-256: `3AFDACA24136FB81140471BD7CB40398CE61A2D1896DD78973E25041D51E7D73`.
- Frozen Checks SHA-256: `E41183DB2B49F958C7CA0FA753AB58721AD63D7ACAFA1DDD2715DB54CAE4DA52`.
- Freshness: the isolated target did not contain the main or Checks object before compilation.
- Compilation: main exit `0`; Checks exit `0`; no compiler warnings or errors.
- Object SHA-256: main `77D109A27663844EB3D553C7F23FBB4C064A34AFE9B0F977A5156B14DCC415E7`; Checks `D40CF30A445FF7DFC18F927BAF4FED5657A8D5EBE8CE723AA7CE64F0D9D7518E`.
- Source stability: PASS before/after hashes equal.
- Forbidden scan: clean for `sorry`, `admit`, `native_decide`, and explicit `axiom` declarations.
- Axiom profile: `propext`, `Classical.choice`, and `Quot.sound` only.
- Inventory: `47E91D48E0931589929CDF88E7815185B29A4EA634F9218B7D2031794542DE1B` before this closeout file was added; the canonical artifact manifest below covers the final evidence directory.
- Scope: target-fresh main-and-Checks build against immutable seeded transitive dependencies. The module has no direct project dependency. This is not a complete source rebuild of Mathlib.
- Claims boundary: this evidence certifies the exact generic gluing theorem and its fixtures only; it does not certify manuscript integration, actual-source instantiation, label transport, star acceptance, or the headline reduction.
