# Design Plan

The plan for the hack. Claude reads this at the start of every session and keeps it current.

## Status

Setup only. Story, region, and features are not decided yet.

## Concept

- Title: TBD
- Premise / story: TBD
- Region / setting: TBD
- Tone and difficulty: TBD

## Big decisions

Decisions are only filled in after the owner agrees to them.

| Topic | Decision | Date |
|---|---|---|
| Base | pokeemerald-expansion (rh-hideout), `master` branch | 2026-09-28 |
| Game version built | Emerald | 2026-09-28 |

## Open questions

- What is the hack about? (story, region, starters)
- New region with new maps, or a remix of Hoenn?
- Which expansion features to turn on (for example DexNav, followers, difficulty options, level caps)?

## Species budget

- Expansion currently uses species IDs 1 to 1572 (this counts forms and Megas).
- Custom species go after that, starting at 1573.
- Hard limit: the save format stores species in 11 bits, so the last usable ID is 2046 (ID 2047 is taken by the Egg). That leaves room for 474 custom species.
- Owner's plan: about 2016 slots in total, so about 443 custom species (IDs 1573 to 2015). That fits.
- Claude warns the owner before any change would pass ID 2015, and the build refuses to compile past 2046 (`src/hack_limits.c`).
- Upstream updates can add new species. That shrinks our budget and shifts custom IDs, which breaks saves. Check this on every upstream update.
- `USE_DEXNAV_SEARCH_LEVELS` must stay off (it costs 1 save byte per species). The build enforces this.

## Graphics

- The owner supplies sprites. Until then, custom species use placeholder graphics.
