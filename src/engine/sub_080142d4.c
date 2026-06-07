#include "macros.h"
#include "gfx.h"
#include "types.h"
#include "iwram.h"

struct IwramAt6480 {
    u8 _pad00[4];
    u32 field_4;
    u8 _pad08[3];
    u8 field_b;
    u8 _pad0C[42];
    u16 field_36;
};

struct IwramAt6540 {
    u8 _pad00[52];
    s16 field_34;
    u16 field_36;
};

extern struct IwramAt6480 gIwram_6480;
extern struct IwramAt6540 gIwram_6540;
extern struct BgScrollState gIwram_60A0[3];

extern void DmaJob_Advance(struct TransferDesc desc, u8 mode, void *buf);
extern void Selector_StepScrollAxes(u16 a, u8 b, u16 c, u8 d);

u8 GateRoom_UpdateSlide(void)
{
    if (gIwram_6480.field_36 != 0xc0) {
        if (gIwram_6110.scenePhase & 1)
            BgLayer_Enable(2);
    }

    {
        struct TransferDesc *desc = (struct TransferDesc *)0x0830775c;
        DmaJob_Advance(*desc, ((u8 *)desc)[2], (void *)0x030064c0);
    }

    Selector_StepScrollAxes(0, 0, 0, 1);

    {
        struct BgScrollState *p60a0 = gIwram_60A0;
        u32 f10;

        p60a0[2].scrollX += gIwram_6540.field_34;
        f10 = p60a0[0].scrollY;
        p60a0[2].scrollY = f10 + (s16)gIwram_6480.field_36;

        gIwram_6540.field_36 = 312 - gIwram_6480.field_36;

        if (gIwram_6480.field_36 == 0) {
            BgLayer_Disable(2);
            return 1;
        }
    }
    return 0;
}
