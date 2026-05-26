#include "macros.h"
#include "types.h"

/* UI text / overlay tables at 0x081bdf70..0x081be0b4.
 *
 * A tightly-packed cluster of small tables and string blocks used by the
 * level-transition / overlay code for the "ROUND N — LEVEL CLEARED" /
 * "YOU WIN" / "YOU LOSE" UI sequences. Surfaced by
 * tools/agent/refcount_pool_loads.py: address 0x081bdf70 (9 refs) is the
 * heavyweight anchor here; the surrounding small tables are extracted
 * coherently with it.
 *
 * Consumer pattern for sUiWindowBorderTiles (extract of 0x0801cd4e):
 *
 *     r1 = &sUiWindowBorderTiles[0]
 *     ldrh r0, [r1, #0]; strh r0, [bg_screen + corner]            -- TL
 *     for (col = 0; col < width; col++)
 *         strh ldrh [r1, #2], [bg_screen + top_edge + col*64]     -- top
 *     ldrh [r1, #4] -> top-right corner
 *     ... -- left/center/right/bottom-left/bottom/bottom-right
 *
 * 3x3 window-frame stamp: nine 16-bit BG tilemap codepoints arranged as
 * TL/T/TR/L/C/R/BL/B/BR. Used to draw the rounded text-window frame for
 * level transition banners and the option menu.
 *
 * --- 0x081bdf70 sUiWindowBorderTiles[9] (u16) ---
 *
 *   Anchor 2: 9 pool-load callsites from 0x0801cd4e and neighbours.
 *   The codepoints fall in the 0xf08X range (a charmap-encoded tile
 *   block holding the frame corners and edges).
 *
 * --- 0x081bdf82 (2 B pad) ---
 *
 *   Alignment to u32. Lives in its own bin so the linker.ld split
 *   reflects the actual on-ROM gap.
 *
 * --- 0x081bdf84 sLevelClearedLabels (124 B) ---
 *
 *   ASCII strings, ’|’-terminated:
 *     "ROUND"           - level number banner (English; reused for FR)
 *     "        "        - 8 spaces (right-pad for "ROUND N|")
 *     "LEVEL CLEARED|"  - English
 *     "NIVEAU Acheve[000]|" - French
 *     "EBENE Vollendet|"    - German
 *     "NIVEL Superado|"     - Spanish
 *     "LIVELLO Superato|"   - Italian
 *
 * --- 0x081be000 sLevelClearedExtraPtrs[2] (u32) ---
 *
 *   2 pointers {0x081bdfd0, 0x081bdfe0} -- into NIVEL Superado /
 *   LIVELLO Superato strings. Suggests the level-cleared text is
 *   addressed via two parallel pointer tables: the main one in the
 *   0x083086d8 master + this 2-entry tail for Spanish + Italian.
 *
 * --- 0x081be008 sWinLoseLabels (76 B) ---
 *
 *   "YOU WIN\0YOU LOSE\0\0\0\0" + 38 spaces + "0\0\0\0*\0\0\0TIME\0\0\0\0
 *   Yes\0No\0" — banner strings for the game-end overlay plus the digit
 *   glyph fill character and the "TIME" / "Yes" / "No" labels.
 *
 * --- 0x081be054 sUiGlyphCodepoints[30] (u16) ---
 *
 *   Two adjacent 15-entry charmap runs of tile codepoints:
 *     [0..14]  0xe011..0xe020 -- one decorative ribbon / 15-tile strip
 *     [15..29] 0xf001..0xf010 -- second 15-tile strip in a different
 *                                palette band
 *   Used to stamp a horizontal decorative bar across the screen
 *   (anchor: the "win" / "lose" / "credits" banner top/bottom strips).
 *
 * --- 0x081be090 sUiWorldLetterIds[9] (u32) ---
 *
 *   ASCII letters ’K’,’A’,’Q’,’R’,’R’,’O’,’A’,’A’ (each as zero-extended
 *   u32) — one-letter world identifiers, probably used to pick which
 *   regional info screen / save-icon glyph to render. The repetition
 *   (R twice, A three times) maps to ESRB/PEGI/CERO/ELSPA rating-board
 *   regional codes; the leading K is "Konami" / "K"-prefix.
 */

const u16 sUiWindowBorderTiles[9] = INCBIN_U16("data/ui/window_border_tiles.bin");
const u16 sUiWindowBorderPad[1] = INCBIN_U16("data/ui/window_border_pad.bin");
const u8 sLevelClearedLabels[124] = INCBIN_U8("data/ui/level_cleared_strings.bin");
const u32 sLevelClearedExtraPtrs[2] = INCBIN_U32("data/ui/level_cleared_extra_ptrs.bin");
const u8 sWinLoseLabels[76] = INCBIN_U8("data/ui/win_lose_strings.bin");
const u16 sUiGlyphCodepoints[30] = INCBIN_U16("data/ui/glyph_codepoints.bin");
const u32 sUiWorldLetterIds[9] = INCBIN_U32("data/ui/world_letter_ids.bin");
