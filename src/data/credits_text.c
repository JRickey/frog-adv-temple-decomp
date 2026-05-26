#include "macros.h"
#include "types.h"

/* Credits-screen text + UI label cluster at 0x081be0b4..0x081be810.
 *
 * Three logical sub-clusters:
 *   1. Pipe-terminated ASCII credit-line strings (the studio + name roll).
 *   2. ON/OFF localization labels for the options menu, indexed via a
 *      10-entry pointer table.
 *   3. A small grab-bag of helper bytes (char-range bounds + the placeholder
 *      "fashfjsfa" / "000" tokens) tucked at the tail.
 *
 * --- 0x081be0b4 sCreditsTextStrings (1780 B) ---
 *
 *   The full credits ASCII pool. Each line starts with a single-digit
 *   format code (’1’, ’2’, ’3’) interpreted by the credits-renderer as
 *   "section title / sub-heading / staff-line" before the printable text.
 *   Lines end with ’|’ (single line break) or ’||’ (double break).
 *
 *   Notable section markers:
 *     ’1CREDITS|’                  - top-level title
 *     ’2Konami Software Shanghai|’ - studio sub-header
 *     ’3Producer|’, ’3Director|’   - role labels
 *
 *   Strings are referenced via the master pointer table starting at
 *   0x08308750 and continuing through 0x08308920+, which lays out the
 *   credits roll order. Individual strings are not given separate C
 *   symbols here because (a) every consumer addresses them by ROM ptr
 *   through that table, and (b) the credits scroll is data, not code.
 *
 * --- 0x081be7a8 sUiOnOffLabels (40 B) ---
 *
 *   ’1CREDITS|’ (a duplicate / unreferenced trailing copy) plus the
 *   options-menu ON/OFF labels:
 *     ’ON ’, ’OFF’, ’OUI’, ’NON’, ’AN ’, ’AUS’, ’SI’, ’NO’
 *   Each is a 4-byte null-padded ASCII slot, indexed via
 *   sUiOnOffLabelPtrs.
 *
 * --- 0x081be7d0 sUiOnOffLabelPtrs[10] (const u8 *) ---
 *
 *   10 absolute ROM pointers into sUiOnOffLabels (with two trailing
 *   wraparound entries pointing back to ’ON ’ / ’OFF’). 5 languages x 2
 *   (on, off) = 10 entries. Indexed by current option_value * 2 +
 *   language * 2.
 *
 *   Single pool-load callsite at 0x0801ea60.
 *
 * --- 0x081be7f8 sCreditsMisc (24 B) ---
 *
 *   { 0x20, 0x7e, 0x202020, "fashfjsfa\0", "000\0" } -- char-range bounds
 *   (’ ’ .. ’~’) used by a glyph-validator, plus left-over debug
 *   placeholder strings the build forgot to strip. The "fashfjsfa" /
 *   "000" tokens are visible in the raw ROM and are clearly developer
 *   placeholder text never wired to anything.
 *
 * The 0x081be810..0x081bee64 byte map (sWorldTileTypeMap) and the
 * 0x081bee64+ tilemap-encoded credits roll are extracted separately —
 * see src/data/credits_tilemap.c and src/data/world_tile_map.c.
 */

const u8 sCreditsTextStrings[1780] = INCBIN_U8("data/ui/credits_text_strings.bin");
const u8 sUiOnOffLabels[40] = INCBIN_U8("data/ui/on_off_labels.bin");
const u32 sUiOnOffLabelPtrs[10] = INCBIN_U32("data/ui/on_off_ptrs.bin");
const u8 sCreditsMisc[24] = INCBIN_U8("data/ui/credits_misc.bin");
