// Build-time safety checks for this hack. The build fails if a limit is broken.
#include "global.h"
#include "constants/species.h"
#include "config/dexnav.h"

// Box Pokémon store species in an 11-bit field (max value 2047).
// SPECIES_EGG sits right after the last custom species, so it must fit too.
STATIC_ASSERT(SPECIES_EGG <= 2047, HackTooManySpecies);

// Needs 1 save byte per species; with ~2000 species it would overflow the save.
STATIC_ASSERT(USE_DEXNAV_SEARCH_LEVELS == FALSE, HackDexNavSearchLevelsMustStayOff);
