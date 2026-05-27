#include "types.h"

/* Generic bit-clear accessor on a struct at `base` — the "clear bit"
 * companion to sub_0800679C ("test bit"). Same (selector, bit) shape;
 * ten populated cases (selector >= 10 falls through to the shared
 * pop/bx epilogue, leaving the struct untouched).
 *
 * Selector 1 clears one bit in a 64-bit halfword pair stored at
 * offsets 4 / 8. The mask is built as `~(1ULL << bit)`; old_agbcc
 * inlines this as a `__ashldi3(1, 0, bit)` call followed by two
 * `mvns`. Both halves are then AND'd back into the struct.
 *
 * Selectors 7 / 8 / 9 fold through a shared `clear_byte` epilogue
 * that builds the bitmask in r1 and clears the bit at the byte
 * pointer prepared in each case (`p asm("r0")` keeps the pointer in
 * r0 across the dispatch).
 *
 * Matching notes (old_agbcc):
 *   - `base asm("r4")` pins the struct base into the callee-saved
 *     register that survives the `__ashldi3` call in selector 1.
 *   - Selector 1: the union access on `m.u32a[0/1]` (instead of
 *     `(u32)m64` / `(u32)(m64>>32)`) is load-bearing — the cast form
 *     makes old_agbcc materialise the high half via an extra
 *     `adds r0, r1, #0` copy before the AND, which shifts every
 *     trailing `b.n` and jump-table entry by two bytes. Accessing
 *     the halves through a union lets it keep them in the libgcc
 *     return-pair registers (r0/r1) and emit `ands r3, r1` directly.
 *   - `lo asm("r2")` / `hi asm("r3")` pin the two struct halves to
 *     the registers the baserom uses for the back-to-back
 *     `ands; ands; str; str` pair.
 *   - `p asm("r0")` pins the byte pointer used by selectors 7/8/9
 *     so the shared `clear_byte` block ships as
 *     `adds r0, r4, #N` for each, without spurious r0/r1 copies. */

void sub_080066C4(void *baseIn, u32 selectorIn, u32 bitIn)
{
    register u8 *base asm("r4") = (u8 *)baseIn;
    u32 selector = (u8)selectorIn;
    u32 bit = (u8)bitIn;
    u32 mask;
    register u8 *p asm("r0");

    switch (selector) {
    case 0:
        mask = 1 << bit;
        *(u16 *)(base + 0) = *(u16 *)(base + 0) & ~mask;
        break;
    case 1: {
        union {
            unsigned long long u64;
            u32 u32a[2];
        } m;
        register u32 lo asm("r2");
        register u32 hi asm("r3");
        m.u64 = ~(1ULL << bit);
        lo = *(u32 *)(base + 4);
        hi = *(u32 *)(base + 8);
        lo &= m.u32a[0];
        hi &= m.u32a[1];
        *(u32 *)(base + 4) = lo;
        *(u32 *)(base + 8) = hi;
        break;
    }
    case 2:
        mask = 1 << bit;
        *(u16 *)(base + 12) = *(u16 *)(base + 12) & ~mask;
        break;
    case 3:
        mask = 1 << bit;
        *(u32 *)(base + 16) = *(u32 *)(base + 16) & ~mask;
        break;
    case 4:
        mask = 1 << bit;
        *(u16 *)(base + 0x24) = *(u16 *)(base + 0x24) & ~mask;
        break;
    case 5:
        mask = 1 << bit;
        *(u16 *)(base + 0x26) = *(u16 *)(base + 0x26) & ~mask;
        break;
    case 6:
        mask = 1 << bit;
        *(u16 *)(base + 0x28) = *(u16 *)(base + 0x28) & ~mask;
        break;
    case 7:
        p = base + 0x2c;
        goto clear_byte;
    case 8:
        p = base + 0x2a;
        goto clear_byte;
    case 9:
        p = base + 0x2b;
    clear_byte:
        mask = 1 << bit;
        *p = *p & ~mask;
        break;
    }
}
