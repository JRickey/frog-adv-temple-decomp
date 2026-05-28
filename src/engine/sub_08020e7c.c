#include "types.h"
#include "macros.h"

/* sub_08020E7C — retire one sound-channel slot's handle.
 *
 * Trivial member of the 0x03003570 sound-channel-table family (see the
 * structurally identical siblings sub_08020DC4 and sub_08020E98 in this
 * cluster): load entries[idx].fieldB (the slot's handle) and forward it to
 * sub_0802E100, which clears the slot if the handle is still live. The
 * result is discarded — the baserom pops lr into r0 and `bx r0`, clobbering
 * the callee's return, so this is a void tail call, not a forwarding return.
 *
 * Ships NAKED + #ifdef NON_MATCHING for the same `base + 8` CSE-fold the two
 * siblings hit: the baserom materializes 0x03003570 from the pool and forms
 * the entries[] offset with a separate `adds r1, #8`, then a commutative
 * `adds r0, r0, r1` (idx*8 + base+8). agbcc 2.x always folds the constant
 * field offset into the pool literal (0x03003578, or 0x03003574 when the
 * fieldB +4 is folded too), collapsing the two pool words to one and
 * shifting every following encoding. Not source-reachable — pointer-cache,
 * entries-array pointer, and inline-struct shapes all reproduce the fold.
 */

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

extern u32 sub_0802E100(u32 handle);

#ifdef NON_MATCHING
void sub_08020E7C(u8 idx)
{
    StructAt3003570 *p = &gStructAt3003570;
    sub_0802E100(p->entries[idx].fieldB);
}
#else
NAKED
void sub_08020E7C(u8 idx)
{
    asm(".syntax unified\n"
        "    push    {lr}\n"
        "    lsls    r0, r0, #24\n"
        "    ldr     r1, _08020E94\n"
        "    lsrs    r0, r0, #21\n"
        "    adds    r1, #8\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    bl      sub_0802E100\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_08020E94: .word 0x03003570\n"
        "    .syntax divided\n");
}
#endif
