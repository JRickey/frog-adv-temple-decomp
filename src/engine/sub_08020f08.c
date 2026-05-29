#include "types.h"

/* Decrements the offset-3 counter byte in the sound-channel struct at
 * 0x03003570. While the counter stays positive, forwards the caller's byte
 * argument plus the new counter value into sub_0802DC1C. Sibling
 * sub_08020EE4 is the matching increment.
 *
 * When the counter underflows past 0 (the decremented byte reads back as
 * 0xFF) the channel is released: the handle in this channel's entries[arg]
 * slot is retired through sub_0802E100 instead.
 *
 * The base is taken via the linker-assigned gIwram_3570 symbol rather than
 * a (*(T *)0x03003570) cast: this function derives two distinct addresses
 * from the base (offset 3 and the entries[] table at offset 8), and agbcc
 * 2.x would CSE-fold base+8 into a fresh address constant rather than reuse
 * the live base register. The opaque symbol forces a single base load that
 * the entries access reuses with `adds r1, #8`. See docs/codegen-notes.md
 * "Adjacent IWRAM bases". (Sibling sub_08020EE4 reads only offset 3, so it
 * never triggers the fold and keeps the plain cast.) */

typedef struct {
    s32 fieldA;
    u32 fieldB;
} SoundChannelEntry;

typedef struct {
    u8 flags;
    u8 b;
    u8 c;
    u8 d;
    SoundChannelEntry entries[12];
} StructAt3003570;

extern u8 gIwram_3570;

extern void sub_0802DC1C(u8 value, u8 counter);
extern u32 sub_0802E100(u32 handle);

void sub_08020F08(u8 value)
{
    StructAt3003570 *p = (StructAt3003570 *)&gIwram_3570;

    p->d--;
    if ((u8)p->d != 0xFF) {
        sub_0802DC1C(value, p->d);
        return;
    }
    sub_0802E100(p->entries[value].fieldB);
}
