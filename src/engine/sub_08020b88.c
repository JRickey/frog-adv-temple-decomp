#include "types.h"
#include "sound.h"

typedef struct {
    u8 flags;
    u8 b;
    u8 c;
    u8 d;
} StructAt3003570;

#define gStructAt3003570 (*(StructAt3003570 *)0x03003570)

extern void SoundSlot_Load(u32 arg);
extern void SoundSlot_QueueRequest(void);

/* When bit 0 of the 0x03003570 flags byte is set, forward `arg` to
 * SoundSlot_Load and then poke SoundSlot_QueueRequest.
 *
 * agbcc matching levers (the readable form `if (gStructAt3003570.flags & 1)`
 * drifts by 4 bytes):
 *   - read the struct by value (`s = *p`) so agbcc hoists `movs r0, #1`
 *     ahead of the `ldrb`, matching the baserom's schedule;
 *   - accumulate the mask into its own variable (`mask = mask & s.flags`)
 *     so the `ands` result lands in the constant's register, not the byte's;
 *   - pin the base pointer to r1 and the mask to r0 to fix the colouring.
 */
void Sound_PlayIfEnabled(u32 arg)
{
    StructAt3003570 *p;
    int mask;
    StructAt3003570 s;

    p = &gStructAt3003570;
    s = *p;
    mask = 1;
    mask = mask & s.flags;
    if (mask) {
        SoundSlot_Load(arg);
        SoundSlot_QueueRequest();
    }
}
