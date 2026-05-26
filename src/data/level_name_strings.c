#include "macros.h"
#include "types.h"

/* Localized world / level name string pool at 0x081bda44..0x081bdf70.
 *
 * 1324 bytes of pipe-terminated (’|’) ASCII strings, organized as 25
 * world names (5 worlds x 5 languages: EN/FR/DE/ES/IT) followed by 25
 * "world cleared" strings (same layout).
 *
 * Indexed via the master pointer table at 0x083086d8 (already laid down in
 * sprite_anim_block / adjacent rodata), which holds:
 *
 *   0x083086d8 + 0x00  : 5 ptrs - English world names
 *   0x083086d8 + 0x14  : 5 ptrs - French world names
 *   0x083086d8 + 0x28  : 5 ptrs - German world names
 *   0x083086d8 + 0x3c  : 5 ptrs - Spanish world names
 *   0x083086d8 + 0x50  : 5 ptrs - Italian world names
 *   0x083086d8 + 0x64  : 5 ptrs-to-language-table (English first)
 *   0x083086d8 + 0x78  : 5 ptrs - English "WORLD CLEARED"
 *   0x083086d8 + 0x8c  : 5 ptrs - French "Acheve"
 *   0x083086d8 + 0xa0  : 5 ptrs - German "Vollendet"
 *   0x083086d8 + 0xb4  : 5 ptrs - Spanish "Superado"
 *   0x083086d8 + 0xc8  : 5 ptrs - Italian "Superato"
 *
 * String catalog (offsets relative to the block base 0x081bda44):
 *
 *   English worlds:
 *     "Temple of the Frog|", "Sky City|", "Sea Town|",
 *     "Ancient Ruins|", "Goblin Caverns|"
 *   French worlds:
 *     "Temple des Grenouilles|", "Cite’ du Ciel|",
 *     "Ville de la Mer|", "Ruines Antiques|",
 *     "Caverne des Lutins|"
 *   German worlds:
 *     "Tempel des Frosches|", "Himmelsstadt|", "Seestadt|",
 *     "Antike Ruinen|", "Koboldhoehlen|"
 *   Spanish worlds:
 *     "El Templo de la Rana|", "La Ciudad Cielo|",
 *     "La Ciudad Marina|", "Las Ruinas Antiguas|",
 *     "Las Cavernas del Duende|"
 *   Italian worlds:
 *     "Tempio della Rana|", "Citta’ del Cielo|",
 *     "Citta’ del Mare|", "Antichi Ruderi|",
 *     "Caverne dei Folletti|"
 *   Followed by the same five worlds in each language with the
 *   per-language "completed" suffix appended (TEMPLE OF THE FROG CLEARED,
 *   Temple des Grenouilles Acheve, Tempel des Frosches Vollendet,
 *   El Templo de la Rana Superado, Tempio della Rana Superato, ...).
 *
 * Accented / extended characters are encoded as ASCII + [NNN] charmap
 * escapes (e.g. "Cit[233] du Ciel" is "Cite du Ciel" with U+00E9 at the
 * ’e’). The escapes are produced by tools/preproc but only when the
 * source is processed through the preprocessor — INCBIN bytes pass
 * through unchanged.
 *
 * The block is treated as one opaque buffer here because the existing
 * 0x083086d8 pointer table addresses individual strings by absolute ROM
 * address: shipping each string as its own symbol would explode the C
 * to 50+ named locals while gaining nothing the pointer table doesn’t
 * already encode.
 */

const u8 sLevelNameStrings[1324] = INCBIN_U8("data/ui/level_name_strings.bin");
