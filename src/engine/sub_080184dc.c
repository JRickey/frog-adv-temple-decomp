#include "types.h"

typedef struct {
    u8 x;
    u8 y;
    u8 w;
    u8 h;
} TilemapRect;

void sub_080184DC(const TilemapRect *rect, u16 oldPal, u16 newPal, u8 screen)
{
    u16 *base;
    u16 *row;
    u16 entry;
    u8 col;
    u8 r;

    switch (screen) {
    case 0:
        base = (u16 *)0x0600E000;
        break;
    case 1:
        base = (u16 *)0x0600E800;
        break;
    case 2:
        base = (u16 *)0x0600F000;
        break;
    case 3:
        base = (u16 *)0x0600F800;
        break;
    }

    oldPal = (oldPal & 0xf) << 12;
    newPal = (newPal & 0xf) << 12;

    base += rect->x + rect->y * 32;

    for (r = 0; r < rect->h; r++) {
        for (col = 0; col < rect->w; col++) {
            /* index-first integer add (offset + base) so agbcc emits
             * `adds r4, r0, r6` instead of base-first `adds r4, r6, r0` */
            row = (u16 *)((r * 64) + (u32)base);
            entry = row[col];
            if ((entry & 0xf000) == oldPal) {
                entry = entry & 0x0fff;
                row[col] = entry + newPal;
            }
        }
    }
}
