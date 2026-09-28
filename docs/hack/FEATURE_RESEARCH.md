# Feature Research

Research into hacks the owner picked as feature sources. Done 2026-09-28.
Our base: pokeemerald-expansion 1.17 (master).

Owner's decision (2026-09-28): port Heart & Soul's randomizer and the Traits system. All other features come from expansion itself.

Randomizer port notes: `src/randomizer.c` (~1350 lines) plus data tables, a config file, 11 files with hooks (wild, trainer, items, starters, eggs, abilities, moves, evolutions, types, stats, type chart), settings bits in SaveBlock3, and its page of the new-game challenge menu (`src/challenge_menu.c`). Its species tables (starters, legendaries, baby Pokémon, gen scope) must be rewritten for the fusion roster.

Port difficulty:
- Easy: already in expansion, only a config switch.
- Medium: copy code from a hack built on a similar expansion version, fix conflicts.
- Hard: the source hack uses a different engine, so the feature has to be rewritten.

## Sources

| Hack | Built on | Portability |
|---|---|---|
| [Heart & Soul 2.0](https://github.com/PokemonHnS-Development/pokehns-expansion) | expansion 1.15 + Modern Emerald | Good. Close to our code. Many features are Johto-story specific. |
| [Emerald Rogue](https://github.com/Pokabbie/pokeemerald-rogue) (`expansion` branch) | expansion 1.7 (old) + a lot of custom code | Mixed. Features are tied into its roguelite loop and an old expansion version. |
| [Elite Redux](https://github.com/Elite-Redux/eliteredux-source) | Its own engine (Inclement Emerald), partly C++ | Poor. Not expansion-based. |
| [Traits and Items](https://github.com/bassforte123/pokeemerald-complete) (branch `Trait-and-Items`) | expansion 1.16.2 | Good. Found while checking multiple abilities (see below). |

## Multiple abilities per Pokémon

Expansion does NOT support this natively (each Pokémon has exactly 1 active ability). So Elite Redux was checked.

- Elite Redux: up to 3 innate abilities plus 1 normal ability. Its battle engine is different from expansion's, so its code can't be copied.
- Better route: the "Traits and Items" feature branch, made for expansion and partly based on old Elite Redux code (with permission). It adds:
  - Innates: up to 3 extra always-on abilities per species, plus the normal ability (4 total). The count is configurable.
  - Multi-Items: a Pokémon can hold 2 items. Can be turned off separately.
  - A "Traits" summary page, stacked ability pop-ups, AI support, and tests.
  - Limitation: moves like Worry Seed or Neutralizing Gas only affect the normal ability, not innates.
- It targets expansion 1.16.2; we're on 1.17, so merging needs conflict fixing (Medium-Hard).
- Save cost: innates cost nothing. Multi-Items adds a second held item to every Pokémon in the save, including the PC. Needs a save-space check.
- Fusion idea (owner to decide): a fusion's innates could come from its two parents.
- Elite Redux's hundreds of custom abilities would each need rewriting (Hard). Worth picking only favourites.

## Heart & Soul features

| Feature | In expansion? | Port |
|---|---|---|
| Following Pokémon, day/night, dynamic palettes, DexNav, level caps, HGSS Pokédex, map pop-ups, NPC followers | Yes | Easy (config) |
| Fake clock (1 in-game day per hour of play) | Partly (fake RTC exists) | Easy-Medium |
| Overworld wild Pokémon you can see on routes | Partly (object events exist) | Medium |
| New-game options menu: Gamemode, Features, Difficulty, Challenges | No | Medium |
| Randomizer (starters, wilds, trainers, types, moves, abilities, evolutions, type chart, items, chaos mode) | No | Medium |
| Nuzlocke modes (Easy/Normal/Hard, dupes clause, shiny clause, PC cemetery) | No | Medium |
| Difficulty options: party size limit, EXP multiplier, no items in battle, IV/EV rules, fewer escapes, no Pokémon Center, shop price multiplier, evolution limits, one-type run, BST equalizer, mirror mode | Mostly no | Medium |
| Shiny odds option and alternative shiny palettes | Partly | Medium |
| Wild Pokémon drop their held items | No | Medium |
| HMs usable without teaching the move | Partly | Easy-Medium |
| PokéGear (phone rematches, radio, map) | No | Medium-Hard |
| Voltorb Flip | No | Medium |
| Mom's savings, berry-based custom Poké Balls | No | Medium |
| Tutors and trades can use Pokémon in the PC | No | Medium |
| Surf/Bike music toggle, GB Player music toggle, clock on start menu, shiny markers | No | Easy-Medium |
| Johto/Kanto maps, story, roamers, Kimono Girls, etc. | n/a | Not useful (new region planned) |

## Emerald Rogue features

| Feature | In expansion? | Port |
|---|---|---|
| Ride Pokémon in the overworld | No | Medium-Hard |
| Player outfits and custom colours | No | Hard |
| Quest system with rewards | No | Hard |
| Visible wild Pokémon in the overworld | Partly | Medium |
| Improved battle info HUD | No | Medium |
| Voltorb Flip, Safari, game show minigames | No | Medium |
| Hub town that grows with progress | No | Hard (tied to roguelite) |
| Procedural routes / adventure paths, roguelite runs | No | Very hard (a different game style) |
| Online multiplayer (needs a desktop companion app) | No | Not recommended (players must install an app) |
| Randomized trainers by region/gen | No | Medium |

## Elite Redux features (besides abilities)

| Feature | In expansion? | Port |
|---|---|---|
| Hundreds of custom abilities | No | Hard (rewrite each one) |
| Reworked moves and Pokémon balance | Balance is just data | Medium (data re-entry; mostly irrelevant with our own fusions) |
| Difficulty modes and randomizer options | No | Hard (different engine; Heart & Soul's are easier to port) |

## Recommended order

1. Traits and Items (it touches the battle engine everywhere, so it's easiest to do before anything else).
2. Easy config features the owner wants.
3. Heart & Soul's options menu, randomizer, Nuzlocke, difficulty options (these share one menu system).
4. Rogue's ride Pokémon, battle HUD, overworld Pokémon.
5. Everything else, one at a time.
