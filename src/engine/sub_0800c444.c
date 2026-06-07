#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Tile-event handler keyed on tile id 20: when the queried selector-5 flag is
 * still clear, set it (CtrlFlags_SetBit selector 5) and stamp two adjacent tiles
 * via BgMap_WriteTileAttr using the cached entity coords (gIwram_35E0._field_18/19).
 *
 * Matching notes (agbcc 2.x):
 *   - base6110 as a local u8 * anchors 0x03006110 in r4 across the BL to
 *     ModeControl_GetFlag so the CtrlFlags_SetBit call reuses that base register instead
 *     of re-materializing the pool literal.
 *   - p35E0 likewise pins 0x030035e0 in r4 for the two BgMap_WriteTileAttr calls. */

extern u8 ModeControl_GetFlag(u8 *base, u32 selector, u32 bit);
extern void BgMap_WriteTileAttr(u8 col, u8 row, u32 a, u32 b, u32 c);

void sub_0800C444(u8 tile)
{
    u8 *base6110;
    struct IwramAt35E0 *p35E0;

    if (tile != 20)
        return;

    base6110 = (u8 *)0x03006110;
    if (ModeControl_GetFlag(base6110, 5, 0) != 0)
        return;

    CtrlFlags_SetBit(base6110, 5, 0);

    p35E0 = &gIwram_35E0;
    BgMap_WriteTileAttr(p35E0->_field_18, p35E0->_field_19, 7, 0x57, 13);
    BgMap_WriteTileAttr(p35E0->_field_18, p35E0->_field_19, 8, 0x57, 14);
}
