#include "types.h"

typedef struct {
    u8 flags;
    u8 b;
    u8 c;
    u8 d;
} StructAt3003570;

#define gStructAt3003570 (*(StructAt3003570 *)0x03003570)

extern void sub_08031E24(u32 arg);
extern void SoundSlot_QueueRequest(void);

/* When bit 0 of the 0x03003570 flags byte is set, forward `arg` to
 * sub_08031E24 and then poke SoundSlot_QueueRequest.
 *
 * agbcc matching levers (the readable form `if (gStructAt3003570.flags & 1)`
 * drifts by 4 bytes):
 *   - read the struct by value (`s = *p`) so agbcc hoists `movs r0, #1`
 *     ahead of the `ldrb`, matching the baserom's schedule;
 *   - accumulate the mask into its own variable (`mask = mask & s.flags`)
 *     so the `ands` result lands in the constant's register, not the byte's;
 *   - pin the base pointer to r1 and the mask to r0 to fix the colouring.
 */
void sub_08020B88(u32 arg)
{
    register StructAt3003570 *p asm("r1");
    register int mask asm("r0");
    StructAt3003570 s;

    p = &gStructAt3003570;
    s = *p;
    mask = 1;
    mask = mask & s.flags;
    if (mask) {
        sub_08031E24(arg);
        SoundSlot_QueueRequest();
    }
}
