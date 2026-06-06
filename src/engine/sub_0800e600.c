#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Window + DMA3 + per-room state init.
 *
 * Programs the four window-control registers, populates a struct at
 * 0x03006440 (room/scene state), fires DMA3 from a ROM-resident source
 * at 0x080E38B0 into OBJ-VRAM at 0x0600FB80 (192 words), then raises
 * REG_DISPCNT to display-on with the chosen layer/window mix.
 *
 * The room-state pointer at struct +12 is fetched from a ROM table
 * (24-byte stride) at 0x080C1254 indexed by gIwram_34B0._data, then
 * by `arg` as a u32-stride index within the resulting subtable.
 *
 * Matching notes (old_agbcc):
 *   - Window-reg pointer pinned to r2 so the four strh's emit as a
 *     halfword-pointer walk with 4/4/2 byte strides (skipping
 *     WIN0V/WIN1V).
 *   - tableBase (0x080C1254) pinned to r4 so it's loaded before
 *     gIwram_34B0's address; the volatile barrier locks that order.
 *   - The two zero locals (u8 for state[8], u16 for state[+48]/+50)
 *     are pinned to r1/r2 with a no-op barrier so both materialize
 *     before the strb at state[8]. Without this, agbcc emits the strb
 *     immediately after the r1=0 mov, dropping r2=0 between strb and
 *     the next stmt instead of before strb. */

void Scene08_MapScreenInit(u8 arg)
{
    register vu16 *win asm("r2");
    u32 tableBase;
    register u16 zero asm("r2");
    u8 *state;
    vu32 *dma;
    u32 cnt;

    win = (vu16 *)0x04000040;
    *win = 0xF0;
    win = (vu16 *)((u8 *)win + 4);
    *win = 0x70A0;
    win = (vu16 *)((u8 *)win + 4);
    *win = 0x0808;
    win = (vu16 *)((u8 *)win + 2);
    *win = 0x3F3F;

    state = (u8 *)0x03006440;
    *(u32 *)(state + 20) = 0x0600FBC2;
    *(u32 *)(state + 36) = 0x0600FBC2 + 0x80;

    tableBase = 0x080C1254;
    asm volatile("" ::"r"(tableBase));
    *(u32 *)(state + 12) = ((u32 **)(tableBase + gIwram_34B0._data * 24))[0][arg];

    {
        u8 z1 = 0;
        zero = 0;
        state[8] = z1;
    }
    *(u16 *)(state + 44) = arg;

    dma = (vu32 *)0x040000D4;
    dma[0] = 0x080E38B0;
    dma[1] = 0x0600FB80;
    dma[2] = 0x800000C0;
    cnt = dma[2];
    (void)cnt;

    *(u16 *)(state + 48) = zero;
    *(u16 *)(state + 50) = zero;
    state[11] = 8;
    *(vu16 *)0x04000000 = 0x3B40;
}
