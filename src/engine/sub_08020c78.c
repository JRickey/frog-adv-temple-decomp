#include "types.h"

typedef struct {
    u8 flags;
    u8 b;
    u8 c;
    u8 d;
} StructAt3003570;

#define gStructAt3003570 (*(StructAt3003570 *)0x03003570)

extern u32 sub_0802D9EC(u32 sound, u32 a, u32 b, u32 c);

/* Returns -1 unless bit 4 of the 0x03003570 flags byte is set, in which
 * case it (re)starts `sound` via sub_0802D9EC and returns the new handle.
 *
 * Same matching lever as the sibling sub_08020B88: accumulate the mask
 * into its own variable (`mask = mask & p->flags`) so agbcc hoists
 * `movs r0, #16` ahead of the `ldrb`, and pin the base pointer to r1 /
 * the mask to r0 to fix the register colouring.
 */
u32 sub_08020C78(u32 sound)
{
    register StructAt3003570 *p asm("r1");
    register int mask asm("r0");
    u32 handle;

    handle = -1;
    p = &gStructAt3003570;
    mask = 0x10;
    mask = mask & p->flags;
    if (mask != 0) {
        handle = sub_0802D9EC(sound, 0xff, 0xff, 0xff);
    }
    return handle;
}
