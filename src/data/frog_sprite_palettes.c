#include "macros.h"
#include "types.h"

/* Five 16-color OBJ palettes at 0x080e3774..0x080e3814 (160 bytes total).
 *
 * Surfaced as 3-ref pool anchor by tools/agent/refcount_pool_loads.py.
 * Each of the three consumer call-sites DMAs exactly 0x20 bytes (one
 * palette) from 0x080e3774 to OBJ palette slots:
 *
 *   0x0801c722  REG_DMA3 -> 0x050001e0 (OBJ palette 7), cnt 0x10 hwords
 *   0x0801c9b4  REG_DMA3 -> 0x050001c0 (OBJ palette 6), cnt 0x10 hwords
 *   0x0801d98e  REG_DMA3 -> 0x050001c0 (OBJ palette 6), cnt 0x10 hwords
 *
 * Each consumer also DMAs OBJ tile pixel data from a paired source to
 * OBJ tile VRAM, suggesting palette[0] is the active palette for those
 * sprites. The remaining four palettes (at +0x20, +0x40, +0x60, +0x80)
 * are not directly referenced by any pool literal in the still-asm
 * code region scan; they are likely accessed via a runtime offset
 * computation in routines that have not yet landed in C, or are
 * variant-color tints for the same sprite. The structural grouping
 * (5 contiguous 16-color palettes, each starting with the standard
 * transparent 0x0000 color-0) terminates exactly at 0x080e3814 where
 * the existing text_080e3754 gap-comment notes the sprite-frame
 * region begins.
 *
 * TODO: rename once the consuming routines around [0x0801c700,
 *   0x0801d9a0] land in C and the sprite identity (which "frog
 *   sprite" these tint variants belong to) is confirmed. Also surface
 *   whether palettes 1-4 are referenced via offset arithmetic.
 */

const u16 sFrogSpritePalettes_E3774[5][16] = INCBIN_U16("data/ui/frog_sprite_palettes_e3774.bin");
