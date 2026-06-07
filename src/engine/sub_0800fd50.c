#include "game.h"
#include "gfx.h"
#include "macros.h"
#include "types.h"

extern u8 Credits_RenderStep(void);
extern void StatusBar_Update(void);
extern void EntityRec_ClearKeyFlags(u8 *rec, u16 mask);

/* Title/scene tick: advance the room-state delay at 0x03006440, optionally
 * step its pose via Credits_RenderStep, and on a transition signal tear down the
 * window/blend setup and DMA-clear OBJ-VRAM at 0x0600FB80.
 *
 * Returns 1 when the tick is in-progress / steady-state, 0 when the
 * teardown path runs (caller observes transition completion).
 *
 * Matching notes (agbcc):
 *   - `z` is pinned to r4 so the four window-register stores and DMA source
 *     halfword all reuse the same `movs r4, #0; strh r4, ...` instead of
 *     re-materializing zero.
 *   - The empty barrier after the BL keeps agbcc
 *     from re-emitting `movs r4, #0` — it relies on r4 being callee-saved
 *     across BgLayer_Enable.
 *   - Extended-pool layout: the function's 10 pool literals don't all fit
 *     in 4-byte halfword load range, so the trailing 7 spill into the
 *     compiled .o past the natural function-end-at-bx-r1 epilogue. Total
 *     compiled size is 0xC0 (192 B), not 0xA4 (164 B). The linker.ld
 *     slot is sized accordingly. */

s32 Scene08_MapScreenTick(void)
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
        pose = Credits_RenderStep();
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

        BgLayer_Enable(3);

        asm volatile("" : "+r"(z));
        zero_buf = z;
        dma = (vu32 *)0x040000D4;
        dma[0] = (u32)&zero_buf;
        dma[1] = 0x0600FB80;
        dma[2] = 0x810000C0;
        (void)dma[2];

        StatusBar_Update();
        ret = 0;
        EntityRec_ClearKeyFlags((u8 *)0x03006110, 2);
    }
    return ret;
}
extern void Room_StreamOamAttribs(s16 arg);

void Credits_WriteRow(void)
{
    u8 *state;
    u16 x;
    u16 y;
    u32 cnt;
    u32 base;
    u32 bk;
    u16 t;

    state = (u8 *)0x03006440;
    if (state[8] == 0xFF) {
        return;
    }

    x = *(u16 *)(state + 48);
    y = *(u16 *)(state + 50);
    base = *(u32 *)(state + 20);

    *(u16 *)((y << 7) + ((x << 1) + base)) =
        (u16)(x + (__extension__({
                  u32 y6 = (u32)(y << 6);
                  u32 r0v = (u32)0xffffe0a0;
                  asm(".syntax unified\n\t.thumb\n\t.inst.n 0x1c04\n\t.syntax divided\n" : "=r"(bk) : "r"(r0v));
                  y6 + bk;
              })));

    x = *(u16 *)(state + 48);
    y = *(u16 *)(state + 50);
    *(u16 *)((y << 7) + ((x << 1) + base) + 64) = (u16)(x + bk + (y << 6) + 32);

    cnt = *(u16 *)(state + 48);
    cnt++;
    *(u16 *)(state + 48) = cnt;
    if ((u16)cnt != 32) {
        return;
    }

    *(u16 *)(state + 48) = 0;
    t = 0;
    y = *(u16 *)(state + 50);
    if (y == 0) {
        t = 1;
    }
    *(u16 *)(state + 50) = t;

    state[8]++;
    Room_StreamOamAttribs(*(s16 *)(state + 44));
}
