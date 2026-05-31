#include "macros.h"
#include "types.h"

/* For each bit i (0..7) set in *(0x03003610 + 0xD3), ORs a corresponding
 * flag into *(0x03003610 + 0xD4).  The bit-to-flag mapping comes from an
 * 8-entry jump table at 0x08012F2C; the baserom dispatches through it with
 * `mov pc, r0`, which agbcc 2.x cannot produce from C — hence NAKED.
 * class: class4-movpc, corpus: 2037 asm hits / 0 pure-C hits.
 */
#ifdef NON_MATCHING
void sub_08012F00(void)
{
    static const u8 flagByBit[8] = {0x20, 0x10, 0x80, 0x40, 0x02, 0x01, 0x08, 0x04};
    u8 *base = (u8 *)0x03003610;
    u8 src = base[0xD3];
    u8 i;

    for (i = 0; i <= 7; i++) {
        if ((src >> i) & 1)
            base[0xD4] |= flagByBit[i];
    }
}
#else
NAKED void sub_08012F00(void)
{
    asm(".syntax unified\n"
        "    push    {r4, lr}\n"
        "    movs    r3, #0\n"
        "    ldr     r2, _08012F24\n"
        "_08012F06:\n"
        "    adds    r0, r2, #0\n"
        "    adds    r0, #0xd3\n"
        "    ldrb    r0, [r0, #0]\n"
        "    asrs    r0, r3\n"
        "    movs    r1, #1\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _08012F90\n"
        "    cmp     r3, #7\n"
        "    bhi     _08012F90\n"
        "    lsls    r0, r3, #2\n"
        "    ldr     r1, _08012F28\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    mov     pc, r0\n"
        "    .align  2, 0\n"
        "_08012F24: .4byte 0x03003610\n"
        "_08012F28: .4byte _08012F2C\n"
        "_08012F2C: .4byte _08012F4C\n"
        "    .4byte  _08012F54\n"
        "    .4byte  _08012F5C\n"
        "    .4byte  _08012F64\n"
        "    .4byte  _08012F6C\n"
        "    .4byte  _08012F74\n"
        "    .4byte  _08012F7C\n"
        "    .4byte  _08012F84\n"
        "_08012F4C:\n"
        "    adds    r0, r2, #0\n"
        "    adds    r0, #0xd4\n"
        "    movs    r1, #0x20\n"
        "    b       _08012F8A\n"
        "_08012F54:\n"
        "    adds    r0, r2, #0\n"
        "    adds    r0, #0xd4\n"
        "    movs    r1, #0x10\n"
        "    b       _08012F8A\n"
        "_08012F5C:\n"
        "    adds    r0, r2, #0\n"
        "    adds    r0, #0xd4\n"
        "    movs    r1, #0x80\n"
        "    b       _08012F8A\n"
        "_08012F64:\n"
        "    adds    r0, r2, #0\n"
        "    adds    r0, #0xd4\n"
        "    movs    r1, #0x40\n"
        "    b       _08012F8A\n"
        "_08012F6C:\n"
        "    adds    r0, r2, #0\n"
        "    adds    r0, #0xd4\n"
        "    movs    r1, #2\n"
        "    b       _08012F8A\n"
        "_08012F74:\n"
        "    adds    r0, r2, #0\n"
        "    adds    r0, #0xd4\n"
        "    movs    r1, #1\n"
        "    b       _08012F8A\n"
        "_08012F7C:\n"
        "    adds    r0, r2, #0\n"
        "    adds    r0, #0xd4\n"
        "    movs    r1, #8\n"
        "    b       _08012F8A\n"
        "_08012F84:\n"
        "    adds    r0, r2, #0\n"
        "    adds    r0, #0xd4\n"
        "    movs    r1, #4\n"
        "_08012F8A:\n"
        "    ldrb    r4, [r0, #0]\n"
        "    orrs    r1, r4\n"
        "    strb    r1, [r0, #0]\n"
        "_08012F90:\n"
        "    adds    r0, r3, #1\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r3, r0, #24\n"
        "    cmp     r3, #7\n"
        "    bls     _08012F06\n"
        "    pop     {r4}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .syntax divided\n");
}
#endif
