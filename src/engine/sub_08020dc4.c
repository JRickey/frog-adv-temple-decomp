#include "types.h"
#include "macros.h"

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

#define gStructAt3003570 (*(StructAt3003570 *)0x03003570)

extern u32 sub_0802E184(u32 handle);
extern u32 sub_0802D9EC(u32 sound, u32 a, u32 b, u32 c);
extern void sub_0802DC1C(u32 handle, u8 val);

/* sub_08020DC4 — (re)start the sound for one channel slot.
 *
 * entries[idx].fieldB holds the slot's current handle; if sub_0802E184
 * reports it still live, nothing is done. Otherwise the slot's queued
 * sound (entries[idx].fieldA) is restarted via sub_0802D9EC, panned with
 * the global pan byte (`c & 0x7f`), and the new handle is stored back.
 *
 * Ships NAKED + #ifdef NON_MATCHING — same unmatchable idiom as the
 * structurally identical sibling sub_08020E98 (same struct, same callee
 * trio). The baserom holds the base address in one callee-saved register
 * (r5) and forms `base+8`/`base+4` via `adds r0, r5, #0; adds r0, #8`,
 * then a commutative `adds r0, r4, r0` (offset + base). agbcc 2.x instead
 * re-materializes 0x03003570 from the literal pool a second time (two
 * extra pool words, +8 B) and flips the commutative-add operand order.
 * Neither is source-reachable: register pin, byte-offset locals, pointer
 * cache, and inline-vs-pointer struct shapes all gave 60-73 byte_diff.
 */
#ifdef NON_MATCHING
void sub_08020DC4(u8 idx)
{
    StructAt3003570 *p = &gStructAt3003570;
    u32 sound;
    u32 handle;

    if (sub_0802E184(p->entries[idx].fieldB) != 0)
        return;

    sound = p->entries[idx].fieldA;
    handle = -1;
    if ((p->flags & 0x10) != 0) {
        handle = sub_0802D9EC(sound, 0xff, 0xff, 0xff);
        sub_0802DC1C(handle, p->c & 0x7f);
    }
    p->entries[idx].fieldB = handle;
}
#else
NAKED
void sub_08020DC4(u8 idx)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, lr}\n"
        "    lsls    r0, r0, #24\n"
        "    ldr     r5, _08020E10\n"
        "    lsrs    r4, r0, #21\n"
        "    adds    r0, r5, #0\n"
        "    adds    r0, #8\n"
        "    adds    r6, r4, r0\n"
        "    ldr     r0, [r6, #0]\n"
        "    bl      sub_0802E184\n"
        "    cmp     r0, #0\n"
        "    bne     _08020E0A\n"
        "    adds    r0, r5, #4\n"
        "    adds    r0, r4, r0\n"
        "    ldr     r1, [r0, #0]\n"
        "    movs    r4, #1\n"
        "    negs    r4, r4\n"
        "    movs    r0, #0x10\n"
        "    ldrb    r2, [r5, #0]\n"
        "    ands    r0, r2\n"
        "    cmp     r0, #0\n"
        "    beq     _08020E08\n"
        "    adds    r0, r1, #0\n"
        "    movs    r1, #0xff\n"
        "    movs    r2, #0xff\n"
        "    movs    r3, #0xff\n"
        "    bl      sub_0802D9EC\n"
        "    adds    r4, r0, #0\n"
        "    movs    r1, #0x7f\n"
        "    ldrb    r5, [r5, #2]\n"
        "    ands    r1, r5\n"
        "    bl      sub_0802DC1C\n"
        "_08020E08:\n"
        "    str     r4, [r6, #0]\n"
        "_08020E0A:\n"
        "    pop     {r4, r5, r6}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_08020E10: .4byte 0x03003570\n"
        "    .syntax divided\n");
}
#endif
