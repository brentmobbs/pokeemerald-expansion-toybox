# Notes for Claude

This is a Pokémon ROM hack built on rh-hideout/pokeemerald-expansion. The owner does not code and does not install tools. Claude does all the work.

## Every session

1. Read `docs/hack/DESIGN.md` and `docs/hack/CHANGELOG.md` first.
2. Keep both up to date. Every change the owner will test gets a CHANGELOG entry that says whether it breaks existing saves.
3. Ask the owner before any big design decision. Don't guess.
4. Explain things in plain, short language. The owner is a beginner.

## Rules

- Never commit an original Pokémon ROM or a built ROM (`*.gba` is in `.gitignore`).
- Species: warn the owner before anything would push the last species ID past 2015 (their planned 2016 slots). Hard cap is 2046, enforced by `src/hack_limits.c`.
- Never enable `USE_DEXNAV_SEARCH_LEVELS`.
- Use placeholder graphics for new species until the owner supplies sprites.
- Hack-specific files live in `docs/hack/`, `hack/`, and `src/hack_limits.c`. Prefer config options in `include/config/` over editing engine code, so upstream updates merge cleanly.

## Building

- Cloud sessions install the toolchain automatically (`.claude/hooks/session-start.sh` runs `hack/setup_env.sh`). If it's missing, run `bash hack/setup_env.sh`.
- Build: `make -j$(nproc) all` produces `pokeemerald.gba` (about 3.5 minutes from clean).
- GitHub Actions (`.github/workflows/build-rom.yml`) builds every push and uploads the ROM as an artifact.

## Pulling upstream updates

```
git remote add upstream https://github.com/rh-hideout/pokeemerald-expansion.git   # once per session
git fetch upstream master
git merge upstream/master
```

- If upstream changed `.github/workflows/build.yml`, `docs.yml`, or `labels.yml`, delete them again (`git rm`); we don't use them.
- After merging: build, check the species count against the budget in DESIGN.md, and note in CHANGELOG whether saves still work.
