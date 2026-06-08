#include "macros.h"
#include "gfx.h"
#include "iwram.h"
#include "types.h"
#include "game.h"

struct IwramAt64C0 {
    u8 _pad00[10];
    u8 field_a; /* +0x0a: cleared on init */
};

extern struct IwramAt64C0 gIwram_64C0;
extern struct IwramAt64C0 gIwram_6580;
extern struct ScrollBlitLayer gIwram_6480;
extern struct ScrollBlitLayer gIwram_6500;
extern struct ScrollBlitLayer gIwram_6540;
extern struct BgScrollState gIwram_60A0[3];

extern void FrogStatusBar_Update(void);
extern void Selector_StepScrollAxes(u16 a, u8 b, u16 c, u8 d);
extern void DmaJob_Advance(struct TransferDesc desc, u8 mode, void *buf);

u8 BgScroll_Step(void)
{
    u8 ok = 0;
    u8 *state = (u8 *)0x03003610;

    switch (*state) {
    case 0:
        gIwram_64C0.field_a = ok;
        gIwram_6580.field_a = ok;
        *(vu16 *)0x04000050 = 0x1744;
        *(vu16 *)0x04000052 = 0x0c04;
        *state = 1;
        BgLayer_Disable(2);
        break;
    case 1: {
        struct ScrollBlitLayer *p6480;
        struct TransferDesc *desc;

        FrogStatusBar_Update();
        Selector_StepScrollAxes(0, 0, 0xa0, 1);

        p6480 = &gIwram_6480;
        if (p6480->lastTick == gGameStuff._unk00) {
            if (p6480->frameCtr != 2)
                p6480->frameCtr--;
            if (gIwram_6500.frameCtr != 0)
                gIwram_6500.frameCtr--;
        }

        gIwram_60A0[0].scrollX = 24;
        gIwram_60A0[0].scrollY = 40;
        gIwram_60A0[1].scrollX = (s16)gIwram_6540._field_34 + 24;
        gIwram_60A0[1].scrollY = gIwram_6480._field_36 + 40;

        desc = (struct TransferDesc *)0x08306f6c;
        DmaJob_Advance(*desc, gIwram_6500.frameCtr, &gIwram_64C0);

        if (gIwram_6480._field_36 > 159)
            ok = 1;
        break;
    }
    }

    return ok;
}
