#include "macros.h"
#include "types.h"

/* Screenblock-29 source tilemap family at 0x081e9418..0x081ecc18 (7 x 2 KiB).
 *
 * Seven sibling 32x32 halfword tilemaps that are DMA-installed into
 * VRAM screenblock 29. All go through the same DMA3 triple emitted by
 * the function near 0x0801e738 (still in asm/disasm_0x0801e28c.s):
 *
 *   REG_DMA3SAD = &sScreenTilemap_<variant>
 *   REG_DMA3DAD = 0x0600e800   (VRAM screenblock 29)
 *   REG_DMA3CNT = 0x80000400   (DMA_ENABLE | 0x400 halfwords = 2 KiB)
 *
 * Two of the seven (sScreenTilemap_E9C18, sScreenTilemap_EA418) are
 * loaded directly from the consumer’s literal pool: E9C18 is the
 * default source, and EA418 is substituted when the IWRAM mode word
 * gUnk_030034b0 == 3. The other five are reached through the offset
 * table at 0x08308f84 (still raw INCBIN, see "Offset table" below).
 *
 * The sVramTilePtrTable at 0x08308EF0 also references these as slots
 * [37..41]; the earlier slots [32..36] (0x081e6418, 0x081e7c18,
 * 0x081e7418, 0x081e8418, 0x081e8c18) are sibling 2 KiB tilemaps of
 * the same shape, extracted into screen_tilemaps_e6418.c and
 * screen_tilemaps_e7418.c (split around the tilemap_e6c18 anchor
 * that sits between slots 32 and 34 in ROM).
 *
 * Content: sparse 32x32 halfword tilemap. Most non-zero entries reuse
 * a small set of tile ids as 17-cell-wide stripes on rows 2..17 -- the
 * same "low-detail status backdrop" shape seen in sBgTilemap_E6C18
 * (its near neighbour, also destined for screenblock 29). The
 * variants likely correspond to logo / HUD-label swaps for difficulty
 * or language modes rather than wholesale layout changes.
 *
 * Offset table at 0x08308f84 (5 entries, indexed by some selector
 * that is NOT gUnk_030034b0 -- the latter only gates the E9C18/EA418
 * default-vs-mode3 swap):
 *
 *   [0] 0x081e9418 -> sScreenTilemap_E9418
 *   [1] 0x081eac18 -> sScreenTilemap_EAC18
 *   [2] 0x081eb418 -> sScreenTilemap_EB418
 *   [3] 0x081ec418 -> sScreenTilemap_EC418   (note: table order swaps
 *   [4] 0x081ebc18 -> sScreenTilemap_EBC18    BC18 and C418 vs. ROM order)
 *
 * The offset table extends backwards (0x081d / 0x081e6418 / etc.,
 * starting around 0x08308e00) and forwards (nine 0x0821xxxx entries
 * of a different geometry, terminated by a 0x00000000 sentinel at
 * 0x08308fbc). All of that is still raw INCBIN; extracting it needs
 * separate consumer analysis -- the entries surfaced here are only the
 * 0x081exxxx slice that resolves to this 2 KiB tilemap family.
 *
 * TODO: rename each variant to sScreenTilemap_<purpose> once the
 * selector indexing 0x08308f84 gets a semantic name. The current
 * sScreenTilemap_E9C18 (default) and sScreenTilemap_EA418 (mode3)
 * names are address-derived placeholders too -- promote together.
 */

const u16 sScreenTilemap_E9418[1024] = INCBIN_U16("data/sprite/screen_tilemaps_e9418/tilemap_table0.bin");
const u16 sScreenTilemap_E9C18[1024] = INCBIN_U16("data/sprite/screen_tilemaps_e9418/tilemap_default.bin");
const u16 sScreenTilemap_EA418[1024] = INCBIN_U16("data/sprite/screen_tilemaps_e9418/tilemap_mode3.bin");
const u16 sScreenTilemap_EAC18[1024] = INCBIN_U16("data/sprite/screen_tilemaps_e9418/tilemap_table1.bin");
const u16 sScreenTilemap_EB418[1024] = INCBIN_U16("data/sprite/screen_tilemaps_e9418/tilemap_table2.bin");
const u16 sScreenTilemap_EBC18[1024] = INCBIN_U16("data/sprite/screen_tilemaps_e9418/tilemap_table4.bin");
const u16 sScreenTilemap_EC418[1024] = INCBIN_U16("data/sprite/screen_tilemaps_e9418/tilemap_table3.bin");
