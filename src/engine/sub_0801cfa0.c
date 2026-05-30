#include "macros.h"
#include "types.h"

/* BG text-mode tilemap (screen) entry bits. */
#define TILEMAP_HFLIP 0x0400 /* bit 10: horizontal flip */

/* Map screenblock bases 28-31 (VRAM 0x06000000 + sb * 0x800). */
#define SCREENBLOCK_BASE(sb) (0x06000000u + (sb) * 0x800u)

/*
 * Writes a vertically-adjacent tile pair (top cell + the cell one row below)
 * into one of map screenblocks 28-31, at column `col`, row `row`. When
 * `value` is 0 both cells are cleared; otherwise the top cell gets the entry
 * `palBank | tile [| HFLIP]` and the bottom cell gets entry+1.
 */
void sub_0801CFA0(u32 hflip, u8 col, u8 row, u16 tile, u32 palBank, u8 screen, u32 value)
{
    /* low nibble of palBank into the bit12-15 palette field */
    u32 pal = (palBank << 28) >> 16;
    u32 base;

    switch ((s32)(u8)screen) {
    case 0:
        base = SCREENBLOCK_BASE(28);
        break;
    case 1:
        base = SCREENBLOCK_BASE(29);
        break;
    case 2:
        base = SCREENBLOCK_BASE(30);
        break;
    case 3:
        base = SCREENBLOCK_BASE(31);
        break;
    }

    if (value != 0) {
        if (hflip != 0) {
            u16 *dst = (u16 *)(row * 64 + (col * 2 + base));
            u32 entry = pal + (tile | TILEMAP_HFLIP);
            *dst = entry;
            dst += 32;
            *dst = entry + 1;
            return;
        }

        {
            u16 *dst = (u16 *)(row * 64 + (col * 2 + base));
            u32 entry = pal + tile;
            *dst = entry;
            dst += 32;
            *dst = entry + 1;
        }
        return;
    }

    {
        u16 *dst = (u16 *)(row * 64 + (col * 2 + base));
        *dst = value;
        dst += 32;
        *dst = value;
    }
}
