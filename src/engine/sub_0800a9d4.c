#include "iwram.h"
#include "macros.h"
#include "types.h"

extern s8 EntityHitbox_FindPoint(s8 a, s16 x, s16 y);
extern u8 ModeControl_GetFlag(u8 *base, u32 selector, u32 bit);
extern void EntityHitbox_RegisterGridPoints(u8 a, u8 b, u8 c, u8 d);
extern void CtrlFlags_SetBit(u8 *base, u32 selector, u32 bit);

void TileCacheProbe_HandleTile20(u8 tile)
{
    struct IwramAt35E0 *p35E0;
    u8 *base6110;
    u8 result;
    u8 *exitBase;
    register u32 exitBit asm("r2");

    if (tile != 20)
        return;

    p35E0 = &gIwram_35E0;
    result = (u8)EntityHitbox_FindPoint(8, p35E0->_field_8, p35E0->_field_A);

    switch ((s8)result) {
    case 2:
        base6110 = (u8 *)0x03006110;
        if (ModeControl_GetFlag(base6110, 5, 2) == 0) {
            EntityHitbox_RegisterGridPoints(9, p35E0->_field_18, 0, 1);
            CtrlFlags_SetBit(base6110, 8, 0);
        }
        break;
    case 3:
        base6110 = (u8 *)0x03006110;
        if (ModeControl_GetFlag(base6110, 5, 3) == 0) {
            EntityHitbox_RegisterGridPoints(10, p35E0->_field_18, 0, 1);
            CtrlFlags_SetBit(base6110, 8, 1);
        }
        break;
    }

    exitBase = (u8 *)0x03006110;
    exitBit = result;
    CtrlFlags_SetBit(exitBase, 5, exitBit);
}
