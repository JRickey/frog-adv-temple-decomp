#include "types.h"

/* Initialises a set of fields in the entity record `s`:
 * clears the flag byte at 0x31, zeroes the four 32-bit fields at
 * 0x14/0x18/0x1c/0x20, then writes the three caller-supplied values
 * to 0x30 (a), 0x32 (c), and 0x34 (b).
 *
 * Matching note (old_agbcc): `z1 asm("r4")` / `z2 asm("r5")` force
 * old_agbcc to allocate both callee-saved registers as zero-holders,
 * producing `movs r4,#0; movs r5,#0` and the alternating
 * `str r4/r5; str r4/r5` store sequence seen in the baserom.
 * Without the pins old_agbcc collapses to a single r0=0 and only
 * pushes r4 (giving the wrong prologue and [sp,#8] vs [sp,#12]). */
void Entity_InitMotionFields(u8 *s, u8 a, u8 unused, u32 b, u8 c)
{
    register u32 z1 asm("r4");
    register u32 z2 asm("r5");

    *(u8 *)(s + 0x31) = 0;

    z1 = 0;
    z2 = 0;
    *(u32 *)(s + 0x14) = z1;
    *(u32 *)(s + 0x18) = z2;
    *(u32 *)(s + 0x1c) = z1;
    *(u32 *)(s + 0x20) = z2;

    *(u8 *)(s + 0x32) = c;
    *(u8 *)(s + 0x30) = a;
    *(u32 *)(s + 0x34) = b;
}

void Entity_OrFlags(u8 *s, u16 v)
{
    *(u16 *)(s + 0x2e) |= v;
}
