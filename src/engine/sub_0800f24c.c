#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

struct ScrollObj {
    u8 _pad00[12];
    s32 x;
    s32 y;
    u8 _pad14[4];
    u16 boundY;
    u16 boundX;
    u8 _pad1c[4];
};

void sub_0800F24C(u8 countArg)
{
    register u32 count asm("r8") = (u8)countArg;
    register u32 zero asm("r9");
    register struct ScrollObj *objs asm("ip");
    register struct IwramAt3720 *src asm("r6");
    register s32 idx asm("r2");
    s32 *px;
    s32 *py;
    register struct ScrollObj *obj asm("r3");
    register s32 x asm("r1");
    register s32 y asm("r1");
    u8 i;

    if (gGameStuff.pendingMode == 6) {
        return;
    }
    i = 0;
    if (i >= count) {
        return;
    }
    objs = (struct ScrollObj *)0x030060A0;
    src = &gIwram_3720;
    zero = 0;
    do {
        u32 baseX;
        u32 baseY;
        idx = i << 5;
        baseX = (u32)objs + 12;
        px = (s32 *)(idx + baseX);
        *px = src->_field_2 - 120;
        baseY = (u32)objs + 16;
        py = (s32 *)(idx + baseY);
        *py = src->_field_4 - 80;
        if (src->_field_2 <= 119) {
            *px = zero;
        }
        if (src->_field_4 <= 79) {
            *py = zero;
        }
        x = src->_field_2;
        obj = (struct ScrollObj *)(idx + (u32)objs);
        {
            register u32 rawX asm("r0");
            register u32 shiftedX asm("r2");
            register s32 limitX asm("r0");
            rawX = obj->boundX;
            shiftedX = rawX << 3;
            limitX = (s32)shiftedX - 120;
            if (x > limitX) {
                limitX -= 120;
                *px = limitX;
            }
        }
        y = src->_field_4;
        {
            register u32 shiftedY asm("r2");
            register s32 limitY asm("r0");
            register u32 rawY asm("r3");
            rawY = obj->boundY;
            shiftedY = rawY << 3;
            limitY = (s32)shiftedY - 80;
            if (y > limitY) {
                limitY -= 80;
                *py = limitY;
            }
        }
        i++;
    } while (i < count);
}
