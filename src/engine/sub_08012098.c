#include "game.h"
#include "gfx.h"
#include "gba/dma.h"
#include "gba/io.h"
#include "iwram.h"
#include "types.h"

/* The explicit gs/iw pointer vars force both pool loads before any
 * dereferences, which sets up the LIFO register reuse order that gives
 * r2=upper-byte and r3=lower-byte in the MMIO section. */
u32 Selector_StepColorFade(void)
{
    GameStuff *gs;
    struct IwramAt6410 *iw;
    u32 pos;
    u16 t1, t2;

    gs = &gGameStuff;
    iw = &gIwram_6410;
    pos = gs->_unk00;
    if (pos - iw->_field_08 < iw->_maxFrames)
        return 0;

    iw->_field_08 = pos;

    t1 = *(vu16 *)0x04000052 >> 8;
    t2 = *(vu16 *)0x04000052 & 0xff;

    if (t2 == 0 && t1 == 15) {
        BgLayer_Disable(2);
        return 1;
    }

    if (t1 != 15)
        t1 = (u16)(t1 + 1);

    if (t2 != 0)
        t2 = (u16)(t2 - 1);

    t1 = (u16)((u8)t1 << 8);
    *(vu16 *)0x04000052 = t1 + t2;
    return 0;
}

extern u8 gIwram_53A0[];
extern u8 gEntities_03003720[];

struct IwramAt6480_12100 {
    u8 _pad00[54];
    s16 field_36;
};

struct IwramAt6540_12100 {
    u8 _pad00[10];
    u8 field_a;
};

extern struct IwramAt6480_12100 gIwram_6480;
extern struct IwramAt6540_12100 gIwram_6540;

void Selector_ResetState(void)
{
    u16 zero;
    struct IwramAt6110 *ctrl;

    ctrl = &gIwram_6110;
    ctrl->byteFlags8 = ctrl->byteFlags8 & 0xf0;
    ctrl->gateByte = ctrl->gateByte & 0xf0;

    gIwram_53A0[1] = 0;
    gIwram_53A0[0xff] = 0;
    gEntities_03003720[0x1a5b] = 0;

    gIwram_6480.field_36 = 0;
    *(u8 *)&gIwram_6480 = 0;
    *((u8 *)&gIwram_6480 + 2) = 0;

    gIwram_6540.field_a = 0;

    zero = 0;
    REG_DMA3.src = &zero;
    REG_DMA3.dst = (void *)0x02020000;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0x8000;
    (void)REG_DMA3.cnt;
}

struct ScrollState_60A0 {
    u8 _pad00[12];
    s32 scrollX;
    s32 scrollY;
    u8 _pad14[24];
    s32 scrollX2;
    s32 scrollY2;
};

extern struct ScrollState_60A0 gIwram_60A0;

/* The position word lives at offset 0 of the 0x03005330 block (gGameStuff._unk00).
 * Read it through the linker symbol gIwram_5330 rather than the gGameStuff constant
 * macro: a real symbol makes agbcc load the address into a scratch reg, dereference,
 * then copy it into a callee-saved reg for reuse at the cache store (the baserom's
 * load-then-spread); the constant-address macro folds to a single pseudo and drops
 * the copy. */
extern u32 gIwram_5330;

/* Within each switch the +2 case precedes the -2 case so the case bodies land in the
 * baserom's physical order (the +2 body falls through the cmp #2/#4 test). */
void UpdateScrollFromAnimChannels(void)
{
    s32 x;
    s32 y;

    if (gIwram_5330 - gIwram_6150._field_08 >= gIwram_6150._maxFrames) {
        switch (gIwram_6150._field_00) {
        case 2:
            gIwram_6150._field_04 += 2;
            break;
        case 1:
            gIwram_6150._field_04 -= 2;
            break;
        case 0:
            if (gIwram_6150._field_04 != 0) {
                if ((s32)gIwram_6150._field_04 > 0)
                    gIwram_6150._field_04 -= 2;
                else
                    gIwram_6150._field_04 += 2;
            }
            break;
        }
        gIwram_6150._field_08 = gIwram_5330;
    }

    if (gIwram_5330 - gIwram_5360._field_08 >= gIwram_5360._maxFrames) {
        switch (gIwram_5360._field_00) {
        case 4:
            gIwram_5360._field_04 += 2;
            break;
        case 3:
            gIwram_5360._field_04 -= 2;
            break;
        case 0:
            if (gIwram_5360._field_04 != 0) {
                if ((s32)gIwram_5360._field_04 > 0)
                    gIwram_5360._field_04 -= 2;
                else
                    gIwram_5360._field_04 += 2;
            }
            break;
        }
        gIwram_5360._field_08 = gIwram_5330;
    }

    x = gIwram_60A0.scrollX + (s32)gIwram_5360._field_04;
    gIwram_60A0.scrollX = x;
    y = gIwram_60A0.scrollY + (s32)gIwram_6150._field_04;
    gIwram_60A0.scrollY = y;
    gIwram_60A0.scrollX2 = x;
    gIwram_60A0.scrollY2 = y;
}
