# Design Plan

The plan for the hack. Claude reads this at the start of every session and keeps it current.

## Status

Setup done. Order of work, set by the owner:
1. Research features from other hacks: Heart & Soul, Emerald Rogue, Elite Redux. Results in `FEATURE_RESEARCH.md`. Decided: port Heart & Soul's randomizer; everything else comes from expansion.
2. Next: fusion roster (remove expansion's species, add 52 bases + 1326 fusions with placeholder sprites). Then port the randomizer.
3. Integrate features. Having lots of features is the hack's main draw.
4. Only then: region and story.

## Pinned

- Multiple active abilities (a fusion's 3 abilities all active). Required feature. Not using the Traits add-on: it targets expansion 1.16.2 and merging into 1.17 hit ~450 conflicts. Plan: build our own on expansion later (Traits and Elite Redux can serve as references), or find another solution. Until then, fusions store their 3 abilities in the normal ability slots.

## Concept

- Title: TBD
- Premise / story: new story (later)
- Region / setting: new region (later)
- Pokémon: 52 bases (see Base roster). Any two different bases can fuse (A+B = B+A), giving 1326 fusions (52 x 51 / 2). 1378 species in total. Sprites come from the Pokémon Infinite Fusion project.
- Tone and difficulty: TBD

## Base roster (final, 2026-09-28)

52 bases. Every base is monotype: its only type is the type of its group below (original types are dropped).

| Type | Bases |
|---|---|
| Normal | Porygon, Dunsparce, Teddiursa |
| Fire | Growlithe, Cyndaquil, Numel |
| Water | Azurill, Corsola, Mudkip |
| Electric | Pichu, Voltorb, Mareep |
| Grass | Bulbasaur, Celebi, Shroomish |
| Ice | Swinub, Snorunt, Spheal |
| Fighting | Mankey, Tyrogue, Makuhita |
| Poison | Ekans, Gulpin, Koffing |
| Ground | Sandshrew, Phanpy, Baltoy |
| Flying | Zubat, Murkrow, Swablu |
| Psychic | Mew, Spoink, Jirachi |
| Bug | Paras, Pineco, Wurmple |
| Rock | Shuckle, Larvitar, Nosepass |
| Ghost | Gastly, Misdreavus, Sableye |
| Dragon | Dratini, Bagon |
| Dark | Sneasel, Houndour, Carvanha |
| Steel | Magnemite, Aron, Beldum |
| Fairy | Cleffa, Togepi |

By original generation: Gen 1: 14, Gen 2: 19, Gen 3: 19.

## Fusion rules

- Types: a fusion has both parents' types (e.g. Growlithe + Mudkip = Fire/Water). Same-type parents give a single type.
- Stats: for each stat separately, fusion = (2 x higher parent's stat + 1 x lower parent's stat) / 3, rounded to the nearest whole number. Example: Growlithe + Mudkip = 53 HP / 70 Atk / 48 Def / 63 SpA / 50 SpD / 53 Spe.
- BST: bases are scaled to exactly 400 BST. Fusions: calculate stats with the rule above, then scale to 500 BST. The fusion calculation uses the bases' 400-scaled stats (owner, 2026-09-28).
- Abilities: each base gets one ability, picked from a pool. A fusion's 3 ability slots = parent A's ability, parent B's ability, and one extra ability picked from a large pool based on its type combination. All three abilities are active at the same time (owner, 2026-09-28); see Pinned. Pools: TBD.

## Big decisions

Decisions are only filled in after the owner agrees to them.

| Topic | Decision | Date |
|---|---|---|
| Base | pokeemerald-expansion (rh-hideout), `master` branch | 2026-09-28 |
| Game version built | Emerald | 2026-09-28 |
| Feature sources | Expansion's own features, plus Heart & Soul's randomizer. No Traits, Rogue, or Elite Redux code. One held item per Pokémon. | 2026-09-28 |

## Open questions

- Decided (owner, 2026-09-28): Option A. Remove expansion's species to free IDs, and make every fusion its own species. Upstream merges will get harder; accepted.
- Decided: the Pokédex has 52 entries (the bases), not one per fusion.
- Decided (2026-09-28): 52 bases. 52 + 1326 fusions = 1378 species, which fits under the 2046 cap with 668 IDs to spare.
- Pokédex save space: fine with 52 entries.
- ROM space: the ROM is 80% full now. About 1500 fusions' sprites need several MB, so unused expansion species graphics will likely have to be turned off.
- Infinite Fusion sprites are made by many fan artists. Check their reuse rules and credit the artists. They also need resizing to 64x64 with 16 colors.

- What is the hack about? (story, region, starters)
- New region with new maps, or a remix of Hoenn?
- Which expansion features to turn on: decided one at a time as we go.

## Species budget

- Expansion currently uses species IDs 1 to 1572 (this counts forms and Megas).
- Custom species go after that, starting at 1573.
- Hard limit: the save format stores species in 11 bits, so the last usable ID is 2046 (ID 2047 is taken by the Egg). That leaves room for 474 custom species.
- Plan: 1378 species (52 bases + 1326 fusions), replacing expansion's species (Option A). 668 spare IDs for anything extra.
- Claude warns the owner before any change would pass the planned 1378 species, and the build refuses to compile past 2046 (`src/hack_limits.c`).
- Upstream updates can add new species. That shrinks our budget and shifts custom IDs, which breaks saves. Check this on every upstream update.
- Save space is the other limit. Free space measured on 2026-09-28: SaveBlock1 304 bytes, SaveBlock2 84 bytes, SaveBlock3 1620 bytes. Each new National Dex number costs 2 bits in SaveBlock1 (seen + caught), so 443 new dex entries cost about 112 bytes. Forms and Megas without their own dex number cost nothing here. Features that add save data (new flags, vars, DexNav, etc.) share this space. The build fails if a block overflows.
- `USE_DEXNAV_SEARCH_LEVELS` must stay off (it costs 1 save byte per species). The build enforces this.

## Graphics

- The owner supplies sprites. Until then, custom species use placeholder graphics.
