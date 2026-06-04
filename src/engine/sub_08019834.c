#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"
#include "gba/dma.h"
#include "gba/io.h"

extern const u32 sOamDmaCfg_08100[4];

extern void sub_080184DC(void *self, u16 a, u16 b, u8 c);
extern void sub_0801E270(u32 n);
extern void sub_080185C0(u32 a, u32 b, u32 c, u32 d);

void sub_08019834(void *self, u16 u1, u16 u2, u8 u3, u8 count)
{
    if (count == 0)
        return;

    do {
        if (count & 1)
            sub_080184DC(self, u1, u2, u3);
        else
            sub_080184DC(self, u2, u1, u3);
        sub_0801E270(5);
        sub_080185C0(sOamDmaCfg_08100[0], sOamDmaCfg_08100[1], sOamDmaCfg_08100[2], sOamDmaCfg_08100[3]);
        count = (u8)(count - 1);
    } while (count != 0);
}

void sub_080198A8(u32 *self, u16 u1, u16 u2, u8 u3, u8 count)
{
    u32 attr;

    attr = (*self & 0xffffff00) | 0x0f;
    attr = (attr & 0xff00ffff) | 0x20000;

    if (count == 0)
        return;

    do {
        if (count & 1) {
            sub_080184DC(self, u1, u2, u3);
            sub_080184DC(&attr, 6, 7, u3);
        } else {
            sub_080184DC(self, u2, u1, u3);
            sub_080184DC(&attr, 7, 6, u3);
        }
        sub_0801E270(5);
        sub_080185C0(sOamDmaCfg_08100[0], sOamDmaCfg_08100[1], sOamDmaCfg_08100[2], sOamDmaCfg_08100[3]);
        count = (u8)(count - 1);
    } while (count != 0);
}

void sub_08019958(u32 x)
{
    gIwram_34B0._data = x;
}
