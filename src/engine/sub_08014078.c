#include "macros.h"
#include "types.h"

extern void sub_0800E85C(u8 arg);
extern void sub_0800EB1C(void);
extern void sub_08010958(u8 arg0, u8 arg1);
extern void sub_0800F24C(u8 arg);
extern void sub_0800EBDC(u8 arg);
extern void sub_08016A40(void);

void sub_08014078(void)
{
    sub_0800E85C(2);
    sub_0800EB1C();
    sub_08010958(5, 3);
    sub_0800F24C(2);
    sub_0800EBDC(2);
    sub_08016A40();
}

/* struct for the first 4-register argument block (16 bytes, passed in r0-r3).
 * The prologue spills these to the local frame and accesses fields
 * via a base pointer (add r0, sp, #20). */
struct AnimParams {
    u16 field_00; /* [+0] */
    u16 field_02; /* [+2] */
    u16 field_04; /* [+4] */
    u16 field_06; /* [+6] */
    u8 field_08;  /* [+8] */
    u8 _pad09;
    u8 _pad0a;
    u8 _pad0b;
    u8 field_0c; /* [+12] */
};

/* Destination animation-state struct accessed via r3. Fields used:
 * +8 (u8 index), +9, +11, +16 (u32), +44..54 (u16 coords). */
struct AnimState {
    u8 _pad00[8];
    u8 idx;      /* +0x08: index into table */
    u8 field_09; /* +0x09 */
    u8 _pad0a;
    u8 field_0b; /* +0x0b */
    u32 _pad0c;
    u32 field_10; /* +0x10 */
    u8 _pad14[24];
    u16 field_2c; /* +0x2c */
    u16 field_2e; /* +0x2e */
    u16 field_30; /* +0x30 */
    u16 field_32; /* +0x32 */
    u16 field_34; /* +0x34 */
    u16 field_36; /* +0x36 */
};

/* Copies coords from AnimParams into AnimState and computes an updated
 * field_10 pointer based on the animation mode.
 *
 * Shipped NAKED. The prologue uses a Thumb TPCS backtrace layout
 * (sub sp, #16 BEFORE push {r4-r7, lr}) that agbcc cannot generate
 * from standard C without the -mtpcs-leaf-frame compiler flag, which
 * our agbcc build does not support.
 */
#ifdef NON_MATCHING
void sub_080140A0(u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 *table, u32 unused, struct AnimState *dest, u32 scale)
{
    u16 v5 = (u16)arg1;
    u16 v4 = (u16)(arg1 >> 16);
    u8 r6 = (u8)scale;
    u32 v1;
    u8 mode;

    dest->field_09 = (u8)arg2;
    dest->field_30 = v5;
    dest->field_32 = v4;
    dest->field_2c = v5;
    dest->field_2e = v4;

    v1 = table[dest->idx];
    dest->field_10 = v1;

    dest->field_0b = (u8)arg3;

    mode = (u8)arg2 & 0xF;

    switch (mode) {
    case 2:
        dest->field_34 = (u16)arg0;
        dest->field_36 = (u16)(arg0 >> 16) + v4 - r6;
        dest->field_10 = v1 + (u16)(dest->field_32 - r6) * (u16)dest->field_30 * 2;
        break;
    case 1:
    case 3:
        dest->field_34 = (u16)arg0;
        dest->field_36 = (u16)(arg0 >> 16);
        break;
    case 4:
        dest->field_34 = (u16)arg0 + v5 - r6;
        dest->field_36 = (u16)(arg0 >> 16);
        dest->field_10 = v1 + (u16)(dest->field_30 - r6) * 2;
        break;
    }
}
#else
NAKED void sub_080140A0(u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 *table, u32 unused, struct AnimState *dest,
                        u32 scale)
{
    asm(".syntax unified\n"
        "    sub     sp, #16\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    str     r0, [sp, #20]\n"
        "    str     r1, [sp, #24]\n"
        "    str     r2, [sp, #28]\n"
        "    str     r3, [sp, #32]\n"
        "    ldr     r3, [sp, #44]\n"
        "    ldr     r0, [sp, #48]\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r6, r0, #24\n"
        "    add     r0, sp, #20\n"
        "    ldrb    r2, [r0, #8]\n"
        "    strb    r2, [r3, #9]\n"
        "    ldrh    r5, [r0, #4]\n"
        "    strh    r5, [r3, #48]\n"
        "    ldrh    r4, [r0, #6]\n"
        "    strh    r4, [r3, #50]\n"
        "    strh    r5, [r3, #44]\n"
        "    strh    r4, [r3, #46]\n"
        "    ldr     r1, [sp, #36]\n"
        "    ldrb    r7, [r3, #8]\n"
        "    lsls    r0, r7, #2\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r1, [r0, #0]\n"
        "    str     r1, [r3, #16]\n"
        "    add     r0, sp, #20\n"
        "    ldrb    r0, [r0, #12]\n"
        "    strb    r0, [r3, #11]\n"
        "    movs    r0, #15\n"
        "    ands    r0, r2\n"
        "    cmp     r0, #2\n"
        "    beq     _sub_080140A0_case2\n"
        "    cmp     r0, #2\n"
        "    bgt     _sub_080140A0_gt2\n"
        "    cmp     r0, #1\n"
        "    beq     _sub_080140A0_case13\n"
        "    b       _sub_080140A0_done\n"
        "_sub_080140A0_gt2:\n"
        "    cmp     r0, #3\n"
        "    beq     _sub_080140A0_case13\n"
        "    cmp     r0, #4\n"
        "    beq     _sub_080140A0_case4\n"
        "    b       _sub_080140A0_done\n"
        "_sub_080140A0_case2:\n"
        "    add     r0, sp, #20\n"
        "    ldrh    r0, [r0, #0]\n"
        "    strh    r0, [r3, #52]\n"
        "    add     r0, sp, #20\n"
        "    ldrh    r0, [r0, #2]\n"
        "    adds    r0, r4, r0\n"
        "    subs    r0, r0, r6\n"
        "    strh    r0, [r3, #54]\n"
        "    ldrh    r2, [r3, #50]\n"
        "    subs    r0, r2, r6\n"
        "    ldrh    r7, [r3, #48]\n"
        "    muls    r0, r7\n"
        "    b       _sub_080140A0_tail\n"
        "_sub_080140A0_case13:\n"
        "    add     r0, sp, #20\n"
        "    ldrh    r0, [r0, #0]\n"
        "    strh    r0, [r3, #52]\n"
        "    add     r0, sp, #20\n"
        "    ldrh    r0, [r0, #2]\n"
        "    strh    r0, [r3, #54]\n"
        "    b       _sub_080140A0_done\n"
        "_sub_080140A0_case4:\n"
        "    add     r0, sp, #20\n"
        "    ldrh    r0, [r0, #0]\n"
        "    adds    r0, r5, r0\n"
        "    subs    r0, r0, r6\n"
        "    strh    r0, [r3, #52]\n"
        "    add     r0, sp, #20\n"
        "    ldrh    r0, [r0, #2]\n"
        "    strh    r0, [r3, #54]\n"
        "    ldrh    r2, [r3, #48]\n"
        "    subs    r0, r2, r6\n"
        "_sub_080140A0_tail:\n"
        "    lsls    r0, r0, #1\n"
        "    adds    r0, r1, r0\n"
        "    str     r0, [r3, #16]\n"
        "_sub_080140A0_done:\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r3}\n"
        "    add     sp, #16\n"
        "    bx      r3\n"
        "    .syntax divided\n");
}
#endif
