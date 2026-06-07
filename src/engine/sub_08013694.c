#include "macros.h"
#include "gfx.h"
#include "iwram.h"
#include "types.h"
#include "game.h"

struct IwramAt64C0 {
    u8 _pad00[10];
    u8 field_a; /* +0x0a: cleared on init */
};

struct IwramAt6480 {
    u8 _pad00[4];
    u32 field_4; /* +0x04: position/anchor (compared against gGameStuff._unk00) */
    u8 _pad08[3];
    u8 field_b; /* +0x0b: frame counter (floored at 2) */
    u8 _pad0C[42];
    s16 field_36; /* +0x36: signed coord */
};

struct IwramAt6540 {
    u8 _pad00[52];
    s16 field_34; /* +0x34: signed coord */
};

struct IwramAt60A0 {
    u8 _pad00[12];
    u32 field_c;  /* +0x0c */
    u32 field_10; /* +0x10 */
    u8 _pad14[24];
    u32 field_2c; /* +0x2c */
    u32 field_30; /* +0x30 */
};

extern struct IwramAt64C0 gIwram_64C0;
extern struct IwramAt64C0 gIwram_6580;
extern struct IwramAt6480 gIwram_6480;
extern struct IwramAt6540 gIwram_6540;
extern struct IwramAt60A0 gIwram_60A0;

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
        struct IwramAt6480 *p6480;
        struct TransferDesc *desc;

        FrogStatusBar_Update();
        Selector_StepScrollAxes(0, 0, 0xa0, 1);

        p6480 = &gIwram_6480;
        if (p6480->field_4 == gGameStuff._unk00) {
            if (p6480->field_b != 2)
                p6480->field_b--;
            if (gIwram_6500.field_b != 0)
                gIwram_6500.field_b--;
        }

        gIwram_60A0.field_c = 24;
        gIwram_60A0.field_10 = 40;
        gIwram_60A0.field_2c = gIwram_6540.field_34 + 24;
        gIwram_60A0.field_30 = gIwram_6480.field_36 + 40;

        desc = (struct TransferDesc *)0x08306f6c;
        DmaJob_Advance(*desc, gIwram_6500.field_b, &gIwram_64C0);

        if (gIwram_6480.field_36 > 159)
            ok = 1;
        break;
    }
    }

    return ok;
}
