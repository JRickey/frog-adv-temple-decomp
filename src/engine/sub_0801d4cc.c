#include "gba/dma.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void sub_0802E13C(void);
extern void sub_08020C78(u32 a);
extern void sub_0801D33C(u8 arg);

/* Per-room/scene state init + double DMA3 OBJ-VRAM clear. Sibling of
 * sub_0800E600 (same 0x03006440 state struct, same 0x080C1254 ROM table
 * indexed by gIwram_34B0._data with a 24-byte stride).
 *
 * Loads state+12 from a ROM subtable (table[idx][0] then byte offset
 * arg*4 + 0x9C), zeroes the per-room counters, raises sub_0802E13C, kicks
 * sub_08020C78 with table2[arg+1], DMA3-clears two OBJ-VRAM regions from a
 * stack halfword of 0, then chains sub_0801D33C(arg).
 *
 * Matching notes (old_agbcc):
 *   - tableBase pinned to r3 + input barrier so 0x080C1254 loads before the
 *     gIwram_34B0 address; the index add is written `idx*24 + tableBase` so
 *     the result lands in r0 (not the pinned r3).
 *   - idx2 = arg + 1 with a barrier blocks the `table2[arg+1]` reassociation
 *     that would fold +1 into the pool constant / ldr offset.
 *   - byteZero (r0) and halfZero (r4) pinned + barrier so the r0 zero
 *     materializes before the r4 zero; r4's zero is then held across both
 *     BLs and reused as the DMA stack-fill halfword.
 */
void sub_0801D4CC(u8 arg)
{
    u8 *state;
    u32 tableBase;
    const u32 *const *entry;
    const u32 *base;
    const u32 *table2;
    u32 idx2;
    register u16 zero asm("r4");
    vu16 fill;

    state = (u8 *)0x03006440;
    *(u32 *)(state + 20) = 0x0600F84C;
    *(u32 *)(state + 36) = 0x0600F84C + 0x80;

    tableBase = 0x080C1254;
    asm volatile("" ::"r"(tableBase));
    entry = (const u32 *const *)(gIwram_34B0._data * 24 + tableBase);
    base = entry[0];
    *(u32 *)(state + 12) = *(const u32 *)((const u8 *)base + arg * 4 + 0x9C);

    {
        register u8 byteZero asm("r0") = 0;
        u16 halfZero = 0;
        asm volatile("" : "+r"(byteZero), "+r"(halfZero));
        state[8] = byteZero;
        zero = halfZero;
    }
    *(u16 *)(state + 44) = zero;
    *(u16 *)(state + 48) = zero;
    *(u16 *)(state + 50) = zero;
    state[11] = 8;

    sub_0802E13C();

    table2 = (const u32 *)0x081BE094;
    idx2 = arg + 1;
    asm volatile("" : "+r"(idx2));
    sub_08020C78(table2[idx2]);

    fill = zero;
    REG_DMA3.src = (const void *)&fill;
    REG_DMA3.dst = (void *)0x0600FBC0;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0xC0;
    (void)REG_DMA3.cnt;

    fill = zero;
    REG_DMA3.src = (const void *)&fill;
    REG_DMA3.dst = (void *)0x0600F800;
    REG_DMA3.cnt = DMA_ENABLE | DMA_SRC_FIXED | 0xC0;
    (void)REG_DMA3.cnt;

    sub_0801D33C(arg);
}
