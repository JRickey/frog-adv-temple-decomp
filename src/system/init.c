#include "game.h"
#include "gba/intr.h"
#include "gba/io.h"
#include "types.h"

/* sub_0802D558 is a thin Thumb wrapper around BIOS SWI 12 (CpuFastSet):
 *   r0=src, r1=dst, r2=count|mode-bits. The high bit of `count` (0x01000000)
 *   selects fill-mode (read src once, replicate into dst). */
extern void sub_0802D558(void *src, void *dst, u32 mode);

extern void sub_08035D7C(void);
extern void sub_0802F4B0(void);

/* Called from Init1. Zero-clears OBJ tile 0 (32 bytes at 0x06010000) and
 * an unnamed 1KB IWRAM buffer at 0x030054a0 via CpuFastSet fill mode. */
void sub_0800072C(void)
{
    u32 zero1 = 0;
    u32 zero2;

    sub_0802D558(&zero1, (void *)0x06010000, 0x01000008);
    zero2 = 0;
    sub_0802D558(&zero2, (void *)0x030054a0, 0x01000100);
}

/* Step the LCG seed and return the result modulo `range`.
 * Multiplier 109 / increment 1021 — small-period generator used for
 * gameplay randomness (callers TBD; verified via struct_xref on offset 28). */
u8 sub_08000764(u8 range)
{
    gGameStuff.rngSeed = gGameStuff.rngSeed * 109 + 1021;
    return (u8)(gGameStuff.rngSeed % range);
}

/* VBlank IRQ handler. Reached only via INTR_VECTOR (no static `bl 0x790`
 * exists). Per frame:
 *   - sub_08035D7C: ARM trampoline that re-enables IRQs (BX-pc, B IntrEnable).
 *   - Increment _unk00 (frame counter) unless _unk18 bit 0 is set (paused?).
 *   - Increment _unk04 (unconditional tick).
 *   - For game modes outside [8,23] and != 29 (i.e. not in-game), commit
 *     deferred VRAM state: CpuFastSet copy 1024 bytes of OAM shadow at
 *     0x030054a0 into OAM, then write 6 halfwords of BG scroll shadow at
 *     0x03003550 into REG_BG0HOFS..REG_BG2VOFS.
 *   - sub_0802F4B0: TBD post-VBlank work (audio mixer? input?).
 *   - REG_IF = IRQ_VBLANK: ack VBlank.
 *   - *(u16*)0x03006148 = 1: "VBlank done" semaphore for the main-loop wait. */
void sub_08000790(void)
{
    /* `register T *p asm("rN")` pins the agbcc register choice so the
     * `ldr Rn, =&gGameStuff` lands on r1 first (target's instruction
     * scheduling). Without these hints agbcc picks r2 and the entire
     * function falls off the matching path. */
    register GameStuff *g asm("r1");
    u8 mode;

    sub_08035D7C();
    g = &gGameStuff;
    if ((g->_unk18 & 1) == 0) {
        g->_unk00++;
    }
    g->_unk04++;
    mode = g->mode;
    if ((u8)(mode - 8) > 15 && mode != 29) {
        register vu16 *dst asm("r1");
        register u16 *src asm("r2");

        sub_0802D558((void *)0x030054a0, (void *)0x07000000, 0x100);
        dst = (vu16 *)0x04000010;
        src = (u16 *)0x03003550;
        /* The first 5 stores use *dst++ to force `strh; adds r1, #2`;
         * the final `*dst = src[5]` matches the baserom's last iteration
         * (no trailing adds, plain `strh r0, [r1, #0]`). vu16 on dst
         * prevents agbcc from folding the last store into an indexed
         * `strh r0, [r1, #2]` form. */
        *dst++ = src[0];
        *dst++ = src[1];
        *dst++ = src[2];
        *dst++ = src[3];
        *dst++ = src[4];
        *dst = src[5];
    }
    sub_0802F4B0();
    REG_IF = IRQ_VBLANK;
    *(volatile u16 *)0x03006148 = 1;
}
