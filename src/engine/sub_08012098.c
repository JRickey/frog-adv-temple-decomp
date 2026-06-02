#include "game.h"
#include "gba/io.h"
#include "iwram.h"
#include "types.h"

struct IwramAt6410 {
    u8 _pad00[8];
    u32 _field_08;
    u8 _maxFrames;
};

extern struct IwramAt6410 gIwram_6410;
extern void sub_0800EE34(u8 layer);

/* The explicit gs/iw pointer vars force both pool loads before any
 * dereferences, which sets up the LIFO register reuse order that gives
 * r2=upper-byte and r3=lower-byte in the MMIO section. */
u32 sub_08012098(void)
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
        sub_0800EE34(2);
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
