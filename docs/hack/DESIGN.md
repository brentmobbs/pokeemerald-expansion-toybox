# Design Plan

The plan for the hack. Claude reads this at the start of every session and keeps it current.

## Status

Setup done. Order of work, set by the owner:
1. Research features from other hacks: Heart & Soul, Emerald Rogue, Elite Redux. Results in `FEATURE_RESEARCH.md`. Decided: only Heart & Soul's randomizer is ported; everything else comes from expansion.
2. Next: fusion roster (remove expansion's species, add 54 bases + 1431 fusions with placeholder sprites). Then port the randomizer.
2. Integrate features. Having lots of features is the hack's main draw.
3. Only then: region and story.

## Concept

- Title: TBD
- Premise / story: new story (later)
- Region / setting: new region (later)
- Pokémon: 54 first-stage bases. Any two different bases can fuse (A+B = B+A), giving 1431 fusions (54 x 53 / 2). 1485 species in total. Sprites come from the Pokémon Infinite Fusion project.
- Tone and difficulty: TBD

## Big decisions

Decisions are only filled in after the owner agrees to them.

| Topic | Decision | Date |
|---|---|---|
| Base | pokeemerald-expansion (rh-hideout), `master` branch | 2026-09-28 |
| Game version built | Emerald | 2026-09-28 |
| Feature sources | Expansion's own features, plus Heart & Soul's randomizer only. No Traits/Items, Rogue, or Elite Redux code. | 2026-09-28 |

## Open questions

- Decided (owner, 2026-09-28): Option A. Remove expansion's species to free IDs, and make every fusion its own species. Upstream merges will get harder; accepted.
- Decided: the Pokédex has 54 entries (the bases), not one per fusion.
- Decided (2026-09-28): 54 bases. 54 + 1431 fusions = 1485 species, which fits under the 2046 cap with 561 IDs to spare.
- Pokédex save space: fine with 54 entries.
- ROM space: the ROM is 80% full now. About 1500 fusions' sprites need several MB, so unused expansion species graphics will likely have to be turned off.
- Infinite Fusion sprites are made by many fan artists. Check their reuse rules and credit the artists. They also need resizing to 64x64 with 16 colors.

- What is the hack about? (story, region, starters)
- New region with new maps, or a remix of Hoenn?
- Which expansion features to turn on: decided one at a time as we go.

## Species budget

- Expansion currently uses species IDs 1 to 1572 (this counts forms and Megas).
- Custom species go after that, starting at 1573.
- Hard limit: the save format stores species in 11 bits, so the last usable ID is 2046 (ID 2047 is taken by the Egg). That leaves room for 474 custom species.
- Plan: 1485 species (54 bases + 1431 fusions), replacing expansion's species (Option A). 561 spare IDs for anything extra.
- Claude warns the owner before any change would pass the planned 1485 species, and the build refuses to compile past 2046 (`src/hack_limits.c`).
- Upstream updates can add new species. That shrinks our budget and shifts custom IDs, which breaks saves. Check this on every upstream update.
- Save space is the other limit. Free space measured on 2026-09-28: SaveBlock1 304 bytes, SaveBlock2 84 bytes, SaveBlock3 1620 bytes. Each new National Dex number costs 2 bits in SaveBlock1 (seen + caught), so 443 new dex entries cost about 112 bytes. Forms and Megas without their own dex number cost nothing here. Features that add save data (new flags, vars, DexNav, etc.) share this space. The build fails if a block overflows.
- `USE_DEXNAV_SEARCH_LEVELS` must stay off (it costs 1 save byte per species). The build enforces this.

## Graphics

- The owner supplies sprites. Until then, custom species use placeholder graphics.
