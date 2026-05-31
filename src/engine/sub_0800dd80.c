#include "game.h"
#include "types.h"

extern void sub_0802D558(void *src, void *dst, u32 mode);
extern void sub_0802D8F8(void);
extern void sub_0801756C(u8 a, void *b);

/* Per-mode scene reset: marks the current pending mode as visited in
 * gGameStuff._unk0C (bitmap of seen modes), CpuFastSet-zeroes a 32-byte
 * VRAM region at 0x06010000 (OBJ tile 0), clears the 128-entry OAM
 * shadow at 0x030054a0 to {y=0xf0 (hidden), 0, 0, 0}, runs sub_0802D8F8,
 * then dispatches sub_0801756C with a byte from 0x03003538 plus a table
 * base 0x03003600. Finally sets gGameStuff.mode to 23 if pendingMode is
 * 15, otherwise 29.
 *
 * Matching notes (old_agbcc):
 *   - gGameStuff is loaded into r2 once for the visited-bitmap update
 *     (reads offset 10 twice, RMW on offset 12) and reloaded into r1
 *     at the tail for the mode write — baserom emits a fresh pool load.
 *   - The OAM-shadow clear writes the y=0xf0 sentinel separately and
 *     then runs an inner loop writing 3 zero halfwords via a post-
 *     incrementing pointer, matching the baserom's 8-byte stride. */

void sub_0800DD80(void)
{
    register GameStuff *g asm("r2") = &gGameStuff;
    register u16 *p asm("r0");
    register s32 i asm("r1");
    register u16 *base asm("r5");
    register u16 zero_h asm("r3");
    register u16 sentinel asm("r4");
    u8 *p_3003500;
    u32 zero;

    asm volatile("" : "+r"(g));

    if (g->pendingMode != 0) {
        g->_unk0C |= 1 << (g->pendingMode - 1);
    }

    zero = 0;
    sub_0802D558(&zero, (void *)0x06010000, 0x01000008);

    i = 0;
    base = (u16 *)0x030054a0;
    zero_h = 0;
    sentinel = 0xf0;
    do {
        register s32 next asm("r2");
        register s32 inner asm("r1");
        p = (u16 *)(i * 8);
        p = (u16 *)((u32)p + (u32)base);
        *p = sentinel;
        next = i + 1;
        p++;
        inner = 2;
        do {
            *p = zero_h;
            p++;
            inner--;
        } while (inner >= 0);
        i = next;
    } while (i <= 127);

    sub_0802D8F8();

    p_3003500 = (u8 *)0x03003500;
    asm volatile("" : "+r"(p_3003500));
    p_3003500 += 0x38;
    sub_0801756C(*p_3003500, (void *)0x03003600);

    {
        register GameStuff *g2 asm("r1") = &gGameStuff;
        asm volatile("" : "+r"(g2));
        if (g2->pendingMode == 15) {
            g2->mode = 23;
        } else {
            g2->mode = 29;
        }
    }
}

extern void sub_0800A520(void);
extern u32 sub_080115F8(void);
extern void sub_08009A58(void);
extern void sub_08009188(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);

void sub_0800DE0C(void)
{
    register u32 done asm("r5") = 0;
    GameStuff *gs;
    u8 *base = (u8 *)0x03003720;
    u32 off = 0x32a;
    u8 val;

    base[off] = val = 2;
    *(u16 *)(base + 0xd1 * 4) |= val;
    *(u32 *)(base + 0xb1c) = gGameStuff._unk00;
    gGameStuff._unk22 = (u16)gGameStuff._unk00;
    gs = &gGameStuff;

    do {
        sub_0800A520();
        if (sub_080115F8() != 0) {
            if (gs->_unk00 - (u32)(s16)gs->_unk22 > 0xdb) {
                register u32 one asm("r0") = 1;
                done |= one;
            }
        }
        sub_08009A58();
        sub_08009188();
        sub_080008DC();
        sub_0800A328();
        {
            register u32 check asm("r0") = 1;
            check &= done;
            if (check == 0)
                continue;
        }
        break;
    } while (1);
}
