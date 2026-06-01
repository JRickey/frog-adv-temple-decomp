#include "game.h"
#include "iwram.h"
#include "types.h"

extern u32 sub_0800679C(u8 *base, u32 selector, u32 bit);
extern u32 sub_08011884(void);
extern void sub_08006600(u8 *base, u32 selector, u32 bit);
extern void sub_080066C4(u8 *base, u32 selector, u32 bit);

void sub_0800534C(void)
{
    u8 *base6110 = (u8 *)&gIwram_6110;

    if ((u8)sub_0800679C(base6110, 3, 8) == 0)
        return;
    if ((u8)sub_08011884() == 0)
        return;

    {
        u32 *g = (u32 *)0x03005330;
        u8 *base3720 = (u8 *)&gIwram_3720;

        if (*g - *(u32 *)(base3720 + 0xb10) <= 120)
            return;
    }
    sub_08006600(base6110, 3, 3);
    sub_080066C4(base6110, 3, 8);
}

extern u32 sub_08009C14(u8 *state);
extern void sub_0800BE18(u8 *slots, u32 *out, s8 type);

void sub_080053A4(u8 *arg0, u8 *arg1, u32 *arg2, u8 *arg3, u32 *arg4)
{
    if (sub_08009C14(arg0) == 0)
        *arg0 = 8;

    {
        u8 *base = (u8 *)&gIwram_6110;
        gIwram_6110.scenePhase = 0;
        base[0x2a] = 0;
        base[0x2b] = 0;

        if (gIwram_6110.spawnMask != 1)
            return;
    }

    sub_0800BE18(arg1, arg2, 29);
    sub_0800BE18(arg3, arg4, 30);
}

extern void sub_08015A00(void);
extern void sub_0800DE80(void);

void sub_080053F4(void)
{
    sub_08015A00();
    sub_0800DE80();
}

extern void sub_0800B178(void *arg0);
extern u8 sub_0800CD88(u8 col, u8 row, s16 tileX, s16 tileY);
extern void sub_0800AE3C(u8 tile);
extern void sub_0800B07C(void *arg0);

void sub_08005404(void *arg0)
{
    u8 *base6110;
    struct IwramAt35E0 *p35E0;
    u32 mask;

    sub_0800B178(arg0);

    /* base6110 is materialized after the sub_0800B178 call so its pool load
     * lands past the BL (arg0 is live into the call). */
    base6110 = (u8 *)&gIwram_6110;
    if ((u8)sub_0800679C(base6110, 5, 4) == 0)
        goto tail;
    if ((u8)sub_0800679C(base6110, 5, base6110[0x2b]) != 0)
        goto tail;

    {
        /* gs anchors the gGameStuff pointer load ahead of the +0xb8c constant
         * (so 0xb8c lands in r1); the deref is deferred until after slot. */
        u32 *gs = &gGameStuff._unk00;
        u8 *base3720 = (u8 *)&gIwram_3720;
        u32 *slot = (u32 *)(base3720 + 0xb8c);
        u32 cur = *gs;

        if (cur - *slot <= 180)
            goto tail;

        {
            s16 *counter = (s16 *)(base3720 + 0xb70);
            *counter += 1;
            *counter = *counter % 2;
        }
        *slot = cur;
    }

tail:
    p35E0 = &gIwram_35E0;
    mask = 0x10;
    mask &= p35E0->_field_10;
    if (mask == 0)
        return;

    sub_0800AE3C((u8)sub_0800CD88(p35E0->_field_18, p35E0->_field_19, p35E0->_field_8, p35E0->_field_A));
    sub_0800B07C(arg0);
}
