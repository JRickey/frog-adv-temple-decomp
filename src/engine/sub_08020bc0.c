#include "types.h"

typedef struct {
    u8 flags;
    u8 b;
    u8 c;
    u8 d;
} StructAt3003570;

#define gStructAt3003570 (*(StructAt3003570 *)0x03003570)

extern u32 sub_08032148(void);
extern void SoundSlot_QueueRequest(void);

/* When bit 1 of the 0x03003570 flags byte is set and sub_08032148() reports
 * zero, poke SoundSlot_QueueRequest. Sibling of sub_08020B88 in this cluster (same
 * push{lr}/bx-r0 void-tail epilogue).
 *
 * agbcc matching lever (same as sub_08020B88 / sub_08020C78): accumulate the
 * mask into its own variable (`mask = mask & p->flags`) so agbcc hoists
 * `movs r0, #2` ahead of the `ldrb`, and pin the base pointer to r1 / the
 * mask to r0 to fix the register colouring.
 */
void sub_08020BC0(void)
{
    register StructAt3003570 *p asm("r1");
    register int mask asm("r0");

    p = &gStructAt3003570;
    mask = 2;
    mask = mask & p->flags;
    if (mask != 0) {
        if (sub_08032148() == 0) {
            SoundSlot_QueueRequest();
        }
    }
}

/* Store the argument byte into the 0x03003570 struct's second field.
 * Arg is u32, not u8: the baserom stores the raw register (strb r0) without
 * the lsls/lsrs zero-extend agbcc emits for a u8 parameter. */
void sub_08020BE4(u32 arg)
{
    gStructAt3003570.b = arg;
}
