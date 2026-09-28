# Design Plan

The plan for the hack. Claude reads this at the start of every session and keeps it current.

## Status

Setup done. Order of work, set by the owner:
1. Research features from a list of other hacks the owner will provide (which ones expansion already has, which to port).
2. Integrate features. Having lots of features is the hack's main draw.
3. Only then: region and story.

## Concept

- Title: TBD
- Premise / story: new story (later)
- Region / setting: new region (later)
- Pokémon: 64 first-stage Pokémon. Any two can fuse, giving 2016 fusions (64 x 63 / 2). Sprites come from the Pokémon Infinite Fusion project.
- Tone and difficulty: TBD

## Big decisions

Decisions are only filled in after the owner agrees to them.

| Topic | Decision | Date |
|---|---|---|
| Base | pokeemerald-expansion (rh-hideout), `master` branch | 2026-09-28 |
| Game version built | Emerald | 2026-09-28 |

## Open questions

- Fusion count: are there 2016 dex entries (fusions only) or 2080 (fusions plus the 64 bases)? Can a Pokémon fuse with itself? Is A+B the same as B+A?
- Species ID problem: expansion already uses IDs 1 to 1572, and the save format caps IDs at 2047. 2016 fusions as separate species don't fit. Options:
  - A: remove most of expansion's species to free IDs (big engine edit, painful upstream merges).
  - B: store a fusion as "base species + partner" (like Infinite Fusion does), so only the 64 bases need IDs (engine work on save data, stats, sprites, Pokédex).
  - Waiting on the owner's choice.
- Pokédex save space: 2080 entries need about 520 bytes of seen/caught flags. Only about 562 are available if expansion's own dex is replaced. Tight.
- ROM space: the ROM is 80% full now. About 2000 fusions' sprites need several MB, so unused expansion species graphics will likely have to be turned off.
- Infinite Fusion sprites are made by many fan artists. Check their reuse rules and credit the artists. They also need resizing to 64x64 with 16 colors.

- What is the hack about? (story, region, starters)
- New region with new maps, or a remix of Hoenn?
- Which expansion features to turn on (for example DexNav, followers, difficulty options, level caps)?

## Species budget

- Expansion currently uses species IDs 1 to 1572 (this counts forms and Megas).
- Custom species go after that, starting at 1573.
- Hard limit: the save format stores species in 11 bits, so the last usable ID is 2046 (ID 2047 is taken by the Egg). That leaves room for 474 custom species.
- Owner's first plan was about 2016 slots in total (about 443 custom species). The fusion plan (see Open questions) replaces this and does not fit as separate species.
- Claude warns the owner before any change would pass ID 2015, and the build refuses to compile past 2046 (`src/hack_limits.c`).
- Upstream updates can add new species. That shrinks our budget and shifts custom IDs, which breaks saves. Check this on every upstream update.
- Save space is the other limit. Free space measured on 2026-09-28: SaveBlock1 304 bytes, SaveBlock2 84 bytes, SaveBlock3 1620 bytes. Each new National Dex number costs 2 bits in SaveBlock1 (seen + caught), so 443 new dex entries cost about 112 bytes. Forms and Megas without their own dex number cost nothing here. Features that add save data (new flags, vars, DexNav, etc.) share this space. The build fails if a block overflows.
- `USE_DEXNAV_SEARCH_LEVELS` must stay off (it costs 1 save byte per species). The build enforces this.

## Graphics

- The owner supplies sprites. Until then, custom species use placeholder graphics.
