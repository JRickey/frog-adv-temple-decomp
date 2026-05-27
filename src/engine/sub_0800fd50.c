#include "game.h"
#include "macros.h"
#include "types.h"

extern u8 sub_0800FE88(void);
extern void sub_0800EE94(u8 layer);
extern void sub_08016A40(void);
extern void sub_08006948(u8 *rec, u16 mask);

/* Title/scene tick: advance the room-state delay at 0x03006440, optionally
 * step its pose via sub_0800FE88, and on a transition signal tear down the
 * window/blend setup and DMA-clear OBJ-VRAM at 0x0600FB80.
 *
 * Returns 1 when the tick is in-progress / steady-state, 0 when the
 * teardown path runs (caller observes transition completion).
 *
 * Matching notes (agbcc):
 *   - `register u16 z asm("r4")` pins the zero-value to r4 so the four
 *     window-register stores AND the DMA-source halfword all reuse the
 *     same `movs r4, #0; strh r4, ...` instead of re-materializing zero.
 *   - The `asm volatile("" : "+r"(z))` barrier after the BL keeps agbcc
 *     from re-emitting `movs r4, #0` — it relies on r4 being callee-saved
 *     across sub_0800EE94.
 *   - Extended-pool layout: the function's 10 pool literals don't all fit
 *     in 4-byte halfword load range, so the trailing 7 spill into the
 *     compiled .o past the natural function-end-at-bx-r1 epilogue. Total
 *     compiled size is 0xC0 (192 B), not 0xA4 (164 B). The linker.ld
 *     slot is sized accordingly. */

u8 sub_0800FD50(void)
{
    u8 *state;
    u8 ret;
    u8 pose;
    vu32 *dma;
    vu16 *winh;
    u16 zero_buf;
    register u16 z asm("r4");

    ret = 1;
    state = (u8 *)0x03006440;
    if (*(u16 *)(state + 48) == 0) {
        state[11] = 8;
    }
    if (gGameStuff._unk00 - *(u32 *)(state + 4) >= state[11]) {
        pose = sub_0800FE88();
        *(u32 *)(state + 4) = gGameStuff._unk00;
    }
    if (gGameStuff._unk00 - *(u32 *)(state + 4) > 255 || *(u16 *)0x03005398 == 32 || pose == 254) {
        *(vu16 *)0x04000000 = *(vu16 *)0x04000000 & 0xDFFF;
        *(vu16 *)0x04000000 = *(vu16 *)0x04000000 & 0xBFFF;

        winh = (vu16 *)0x04000040;
        z = 0;
        *winh = z;
        winh = (vu16 *)((u8 *)winh + 4);
        *winh = z;
        winh = (vu16 *)((u8 *)winh + 4);
        *winh = z;
        winh = (vu16 *)((u8 *)winh + 2);
        *winh = z;

        sub_0800EE94(3);

        asm volatile("" : "+r"(z));
        zero_buf = z;
        dma = (vu32 *)0x040000D4;
        dma[0] = (u32)&zero_buf;
        dma[1] = 0x0600FB80;
        dma[2] = 0x810000C0;
        (void)dma[2];

        sub_08016A40();
        ret = 0;
        sub_08006948((u8 *)0x03006110, 2);
    }
    return ret;
}
