#include "macros.h"
#include "types.h"

/* BG tilemap at 0x08188edc..0x081896dc (2048 B, 1024 halfwords).
 *
 * Surfaced as a 1-ref pool anchor by iter-22 scout pass. Single
 * consumer at 0x08012b3a (tail of a setup function reached via fall-
 * through from 0x08012b14): a three-stage DMA register-setup sequence
 * that points DMA channel 3 at the tilemap and screenblock destination:
 *
 *   SAD = sScreenTilemap_188EDC   -> DAD = 0x0600E000 (BG screenblock 28)
 *   CNT = 0x80000400   (DMA_ENABLE | 0x400 halfwords = 2048 B; full block)
 *
 * The DMA copies exactly one screenblock (32x32 entries, the BG tilemap
 * geometry). 0x0600E000 is BG screenblock 28, identical to the
 * destination used by the iter-23 screen_c578 cluster and one of the
 * destinations used by the iter-18 screen_d8b98 cluster.
 *
 * The tilemap content is dense 16-bit entries with the standard GBA BG
 * tilemap layout (low 10 bits = tile id, bits 10-11 = h/vflip,
 * bits 12-15 = palette). The first 16 bytes are zero (transparent /
 * zero-tile leading run); the body contains structured tile-id runs.
 *
 * Sibling to: screen_c578 (same DMA template, dest, and shape), the
 * iter-22 bg_tilemap_19c312 pair (same renderer family). This anchor
 * was deferred from iter-22 because the iter-22 scout flagged it as
 * "unexamined". Confirming the screen-install pattern here closes that
 * deferral.
 *
 * TODO: rename once the consuming function at the head of this 0x12bxx
 * block lands in C. Likely a screen-install setup for a specific menu
 * or world background; the surrounding code at 0x12b5c-0x12b6e writes
 * a few small fields (0x0c=0, 0x10=8, 0x2c=0, 0x30=8) into a struct
 * before clearing a sentinel byte and returning -- classic graphics-
 * mode handoff.
 */

const u16 sScreenTilemap_188EDC[1024] = INCBIN_U16("data/sprite/screen_188edc/tilemap.bin");
