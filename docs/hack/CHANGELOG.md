# Changelog

One entry per build the owner might test. Newest first.
"Save compatible" means an existing save file keeps working with this build.

## Setup (2026-09-28)

- Base: pokeemerald-expansion `master` at commit `9ae17306`.
- Added a GitHub Actions workflow that builds the ROM on every push and offers it as a download.
- Removed upstream's own CI workflows (they build FireRed/LeafGreen and run the full test suite, which this hack doesn't need).
- Added build checks: too many species, or DexNav search levels turned on, now stops the build.
- Gameplay: unchanged from plain expansion.
- Save compatible: yes (nothing that affects saves was changed).
