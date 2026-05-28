#include "macros.h"
#include "types.h"

void sub_08016A40(void);

struct StructA74 {
    u8 _field_00;
    u8 _pad01;
    u16 _field_02;
    u8 _field_04;
    u8 _field_05;
    u8 _pad06[6];
    u8 _field_0C;
    u8 _field_0D;
    u8 _pad0E[2];
    u16 _field_10;
    u16 _field_12;
    u8 _pad14[4];
    u32 _field_14;
};

/* Initializes the struct at *p from four args plus one stacked byte arg,
 * zeroing the +12/+13 byte fields and the +16/+18 halfwords and +20 word,
 * then calls sub_08016A40() between writing +4 and +5.
 *
 * NAKED + NON_MATCHING: documented unmatchable Class 1 (high-register
 * constant pins). The baserom prologue needlessly saves r8
 * (`push {r4-r6,lr}; mov r6,r8; push {r6}`), pins r8 = 0 and reads it
 * back to source the two `strb [r4,#12/13]` zero stores, and holds r6 = 0
 * for the +16/+18/+20 stores. agbcc 2.x will not spill a materialised
 * constant into a high register, so it emits a smaller prologue and reuses
 * a low register for the zero — irreducible byte drift. See
 * docs/codegen-notes.md "High registers".
 */
#ifdef NON_MATCHING
void sub_08006A74(struct StructA74 *p, u8 a, u16 b, u8 c, u8 e)
{
    p->_field_00 = a;
    p->_field_02 = b;
    p->_field_04 = c;
    sub_08016A40();
    p->_field_05 = (u8)e;
    p->_field_0D = 0;
    p->_field_0C = 0;
    p->_field_14 = 0;
    p->_field_10 = 0;
    p->_field_12 = 0;
}
#else
NAKED
void sub_08006A74(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, lr}\n"
        "    mov     r6, r8\n"
        "    push    {r6}\n"
        "    adds    r4, r0, #0\n"
        "    ldr     r5, [sp, #20]\n"
        "    lsls    r5, r5, #24\n"
        "    lsrs    r5, r5, #24\n"
        "    movs    r6, #0\n"
        "    strb    r1, [r4, #0]\n"
        "    movs    r0, #0\n"
        "    mov     r8, r0\n"
        "    strh    r2, [r4, #2]\n"
        "    strb    r3, [r4, #4]\n"
        "    bl      sub_08016A40\n"
        "    strb    r5, [r4, #5]\n"
        "    mov     r0, r8\n"
        "    strb    r0, [r4, #13]\n"
        "    strb    r0, [r4, #12]\n"
        "    str     r6, [r4, #20]\n"
        "    strh    r6, [r4, #16]\n"
        "    strh    r6, [r4, #18]\n"
        "    pop     {r3}\n"
        "    mov     r8, r3\n"
        "    pop     {r4, r5, r6}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .syntax divided\n");
}
#endif
