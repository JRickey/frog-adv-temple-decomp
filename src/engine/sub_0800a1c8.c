#include "game.h"
#include "iwram.h"
#include "types.h"

extern const u32 sEntityParamTable[17];
extern void sub_08020BAC(void);
extern void sub_08020B88(u32 arg);

void sub_0800A1C8(void)
{
    u8 m;
    u32 value;
    GameStuff *p;

    p = &gGameStuff;

    m = p->pendingMode;
    if ((u8)(m % 3) == 0)
        return;
    if (m == 16)
        return;

    value = 0;
    sub_08020BAC();
    if (gIwram_6110._field_32 == 1) {
        const u32 *table = sEntityParamTable;
        /* Reuse the now-dead base pointer so agbcc overwrites r5 with the table index. */
        p = (GameStuff *)(u32)p->pendingMode;
        value = table[(u32)p];
    }
    sub_08020B88(value);
}

int sub_0800A214(void)
{
    /* result pinned to r5 so the &gGameStuff pointer lands in r4 — baserom
     * keeps the base live across both BLs; the natural allocation swaps r4/r5. */
    register int result asm("r5");
    GameStuff *p = &gGameStuff;

    switch (p->_unk00 % 3) {
    case 0:
        result = 13;
        break;
    case 1:
        result = 8;
        break;
    case 2:
        result = 18;
        break;
    }

    if ((u8)(p->pendingMode - 15) <= 1)
        result = 7;

    sub_08020BAC();
    return result;
}

void sub_0800A258(u32 arg)
{
    sub_08020BAC();
    sub_08020B88(arg);
}
