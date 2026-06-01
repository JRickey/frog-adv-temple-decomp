#include "types.h"

/* Zero-inits the gIwram_6110 mode cluster (offsets 0x00..0x33) and installs
 * the per-mode config table pointer at offset 0x34. Called once per
 * dispatcher case in sub_08000918's mode select; the (a, table, e, f) tuple
 * varies by mode. `b` (the third arg) is accepted by every caller but unused
 * here. See src/data/mode_config_2f99e8.c for the per-mode anchor inventory.
 *
 * Matching notes (old_agbcc):
 *   - The 0x04/0x08, 0x14/0x18, 0x1c/0x20 offset pairs clear as 64-bit
 *     stores (`unsigned long long = 0`), which old_agbcc materialises as the
 *     r4/r5 register pair.
 *   - `hz asm("r2")` is the halfword/word zero; the byte zero local `z`
 *     naturally lands in r6. This preserves the order the two `movs #0` are
 *     emitted (r6 before r2).
 *   - `rE asm("r9")` / `rF asm("r8")` hold the two stack args; the baserom
 *     loads them into the high regs up front and keeps them to the tail. */

void sub_0800658C(void *baseIn, u32 a, u32 b, const void *table, u32 e, u32 f)
{
    u8 *base = (u8 *)baseIn;
    register u32 rE asm("r9") = e;
    register u32 rF asm("r8") = f;
    u8 z = 0;
    register u32 hz asm("r2") = 0;

    *(u16 *)(base + 0x00) = hz;
    *(unsigned long long *)(base + 0x04) = 0;
    *(u16 *)(base + 0x0c) = hz;
    *(u32 *)(base + 0x10) = hz;

    *(u16 *)(base + 0x24) = 1;
    *(u16 *)(base + 0x26) = hz;
    *(u16 *)(base + 0x28) = hz;
    *(base + 0x2a) = z;
    *(base + 0x2b) = z;
    *(base + 0x2c) = z;
    *(u16 *)(base + 0x2e) = hz;
    *(base + 0x31) = z;

    *(unsigned long long *)(base + 0x14) = 0;
    *(unsigned long long *)(base + 0x1c) = 0;
    *(base + 0x33) = z;

    *(base + 0x02) = (u8)rF;
    *(base + 0x32) = (u8)rE;
    *(base + 0x30) = (u8)a;
    *(u32 *)(base + 0x34) = (u32)table;
}
