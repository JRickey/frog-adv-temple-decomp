#include "types.h"
#include "macros.h"

/* sub_08020E98 — broadcast a 7-bit value to all live sound-channel handles.
 *
 * The struct at 0x03003570 holds a sound-channel handle table starting at
 * offset 4: 12 entries × 8 B, each `{ s32 fieldA; u32 fieldB; }`. Entries
 * with fieldA == -1 are unused slots; for each live slot, fieldB is the
 * handle to forward into sub_0802DC1C (the sound parameter-set helper that
 * sub_0802090C's tail handlers also call). The 7-bit mask `arg & 0x7F`
 * strips the high bit — likely a "looping" flag separate from the value.
 *
 * Ships NAKED + #ifdef NON_MATCHING for a 1-byte commutative-add encoding
 * drift: baserom emits `adds r0, r2, r0` (i*8 + (base+4)); agbcc 2.x emits
 * `adds r0, r0, r2` ((base+4) + i*8) for every plausible source shape. Same
 * value, different Thumb-1 instruction encoding (0x1810 vs 0x1880 — one
 * bit swap in the rN/rM slot).
 *
 * Evidence: pure-C draft reached byte_diff 1 after iteration on the
 * `do { ... } while(0)` wrap (permuter discovery, score 330→310 at
 * iter ~80 then plateau). Five manual variations tried for the residual
 * operand-order flip: byte-arithmetic `i*8 + (u8*)base`, explicit entry
 * pointer `&p->entries[i]`, pointer increment, separate offset local,
 * inline struct vs pointer chain — all gave same-or-worse diff. The
 * commutative-add operand order is not source-reachable in agbcc 2.x.
 *
 * Locally redefined struct: existing typedef definitions in
 * src/game/sub_08020b30.c and src/engine/sub_0800de80.c carry only
 * offsets 0..3. This file needs the entries[] field; the typedef stays
 * local until the subsystem is named and we can promote a shared header.
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

extern void sub_0802DC1C(u32 handle, u8 val);

#ifdef NON_MATCHING
void sub_08020E98(u32 arg)
{
    u8 i;
    StructAt3003570 *p;
    u32 *fieldB_arr;
    u32 m_shifted;

    arg = arg << 24;
    do {
        i = 0;
        p = &gStructAt3003570;
        fieldB_arr = &p->entries[0].fieldB;
        m_shifted = arg & 0x7F000000;
        do {
            if (p->entries[i].fieldA != -1) {
                sub_0802DC1C(fieldB_arr[i * 2], (u8)(m_shifted >> 24));
            }
            i++;
        } while (i <= 11);
    } while (0);
}
#else
NAKED
void sub_08020E98(u32 arg)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    lsls    r0, r0, #24\n"
        "    movs    r4, #0\n"
        "    ldr     r6, _08020ED4\n"
        "    adds    r7, r6, #0\n"
        "    adds    r7, #8\n"
        "    movs    r5, #0xfe\n"
        "    lsls    r5, r5, #23\n"
        "    ands    r5, r0\n"
        "_08020EAA:\n"
        "    lsls    r2, r4, #3\n"
        "    adds    r0, r6, #4\n"
        "    adds    r0, r2, r0\n"
        "    ldr     r1, [r0, #0]\n"
        "    movs    r0, #1\n"
        "    negs    r0, r0\n"
        "    cmp     r1, r0\n"
        "    beq     _08020EC4\n"
        "    adds    r0, r2, r7\n"
        "    ldr     r0, [r0, #0]\n"
        "    lsrs    r1, r5, #24\n"
        "    bl      sub_0802DC1C\n"
        "_08020EC4:\n"
        "    adds    r0, r4, #1\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r4, r0, #24\n"
        "    cmp     r4, #11\n"
        "    bls     _08020EAA\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_08020ED4: .word 0x03003570\n"
        "    .syntax divided\n");
}
#endif

/* Setter for the offset-3 counter byte that sub_08020EE4 (++) and
 * sub_08020F08 (--) maintain. The value arrives in the second argument
 * register (r1); r0 is unused on entry and is reused to hold the base. */
void sub_08020ED8(u32 unused, u32 value)
{
    gStructAt3003570.d = value;
}
