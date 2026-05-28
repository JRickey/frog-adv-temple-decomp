#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern u8 sub_0800CE10(u8 a, u8 b, s16 c, s16 d);
extern void sub_0800E600(u32 a);
extern void sub_080008DC(void);
extern u32 sub_0800FD50(void);
extern u8 sub_08009BA0(void);
extern void sub_0800A540(void);
extern void sub_08020C78(u32 a);

/* sub_08009884 — per-frame entity-tile reaction handler (arg = event id).
 *
 * Bails if gIwram_3720.field_34 bit 0x04 is set. Otherwise classifies the
 * entity's current tile twice via sub_0800CE10(coordX, coordY, tileX, tileY):
 *   - class 3 (first call): if the entity's signed counter at gIwram_35E0[4]
 *     is below the gIwram_6110 threshold, run a pendingMode % 3 sound cue
 *     (sub_0800E600(5 or 6)) and drain sub_0800FD50 via sub_080008DC; else
 *     raise gIwram_35E0.field_10 bit 0x100.
 *   - class 1 (second call): raise gIwram_6110.field_2e bit 0x04.
 * Then, if sub_08009BA0 reports active, set gIwram_6110.field_2e bit 0x02.
 * Finally, for event ids 30..37 (arg - 30 in 0..7), if this id beats the
 * stored gIwram_35E0.field_5 high-water mark, record it and fire
 * sub_0800A540 + sub_08020C78(4).
 *
 * Ships NAKED + #ifdef NON_MATCHING for instruction-scheduling drift.
 * The pure-C body (below) is structurally exact and reaches byte_diff 21
 * — the residual is three sites where agbcc 2.x picks a different but
 * equivalent operand-load order than the baserom compiler:
 *   - the `field_34 & 4` test loads the base pointer into r0 (then
 *     clobbers it with the constant 4) vs baserom's r1-reuse;
 *   - `field_10 |= 0x100` and `field_2e |= 4` load the field before the
 *     constant vs baserom's const-first schedule.
 * Discovery: splitting `t = arg - 30` into `t = arg; t = t - 30;` (a
 * permuter find) flipped the dominant r5/r6 allocation and dropped the
 * diff 132 → 21; from there decomp-permuter plateaued (base score 2730,
 * best 2580 over ~1800 iter) and five manual variations of the three
 * `|=` sites (temp `t = K; t |= field`, `K | field` operand swap,
 * separate bit var) each only moved the drift between registers without
 * removing it. The load-order choice is not source-reachable in agbcc 2.x.
 */

#ifdef NON_MATCHING
void sub_08009884(u8 arg)
{
    u8 cls;
    s32 t;

    if (gIwram_3720._field_34 & 4)
        return;

    cls = sub_0800CE10(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8, gIwram_35E0._field_A);
    t = arg;
    t = t - 30;
    if (cls == 3) {
        if ((s8)gIwram_35E0._data[4] >= gIwram_6110._field_2) {
            gIwram_35E0._field_10 |= 0x100;
        } else {
            u8 mod = gGameStuff.pendingMode % 3;
            if (mod == 1) {
                sub_0800E600(5);
            } else if (mod == 2) {
                sub_0800E600(6);
            }
            t = arg - 30;
            while (sub_0800FD50() != 0) {
                sub_080008DC();
            }
        }
    }

    cls = sub_0800CE10(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8, gIwram_35E0._field_A);
    if (cls == 1) {
        gIwram_6110._field_2e |= 4;
    }
    if ((u8)sub_08009BA0() != 0) {
        if ((gIwram_6110._field_2e & 2) == 0) {
            gIwram_6110._field_2e |= 2;
        }
    }

    if ((u8)t <= 7) {
        if ((s8)gIwram_35E0._field_5 < t) {
            gIwram_35E0._field_5 = t;
            sub_0800A540();
            sub_08020C78(4);
        }
    }
}
#else
NAKED
void sub_08009884(u8 arg)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, lr}\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r6, r0, #24\n"
        "    ldr     r1, _090098D0\n"
        "    movs    r0, #4\n"
        "    ldrh    r1, [r1, #52]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    bne     _09009976\n"
        "    ldr     r4, _090098D4\n"
        "    ldrb    r0, [r4, #24]\n"
        "    ldrb    r1, [r4, #25]\n"
        "    movs    r3, #8\n"
        "    ldrsh   r2, [r4, r3]\n"
        "    movs    r5, #10\n"
        "    ldrsh   r3, [r4, r5]\n"
        "    bl      sub_0800CE10\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r0, r0, #24\n"
        "    adds    r5, r6, #0\n"
        "    subs    r5, #30\n"
        "    cmp     r0, #3\n"
        "    bne     _09009918\n"
        "    movs    r1, #4\n"
        "    ldrsb   r1, [r4, r1]\n"
        "    ldr     r0, _090098D8\n"
        "    ldrb    r0, [r0, #2]\n"
        "    cmp     r1, r0\n"
        "    blt     _090098DC\n"
        "    movs    r1, #128\n"
        "    lsls    r1, r1, #1\n"
        "    adds    r0, r1, #0\n"
        "    ldrh    r2, [r4, #16]\n"
        "    orrs    r0, r2\n"
        "    strh    r0, [r4, #16]\n"
        "    b       _09009918\n"
        "    .align  2, 0\n"
        "_090098D0: .word 0x03003720\n"
        "_090098D4: .word 0x030035e0\n"
        "_090098D8: .word 0x03006110\n"
        "_090098DC:\n"
        "    ldr     r0, _090098F8\n"
        "    ldrb    r0, [r0, #10]\n"
        "    movs    r1, #3\n"
        "    bl      __umodsi3\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r0, r0, #24\n"
        "    cmp     r0, #1\n"
        "    bne     _090098FC\n"
        "    movs    r0, #5\n"
        "    bl      sub_0800E600\n"
        "    b       _09009906\n"
        "    .align  2, 0\n"
        "_090098F8: .word 0x03005330\n"
        "_090098FC:\n"
        "    cmp     r0, #2\n"
        "    bne     _09009906\n"
        "    movs    r0, #6\n"
        "    bl      sub_0800E600\n"
        "_09009906:\n"
        "    adds    r5, r6, #0\n"
        "    subs    r5, #30\n"
        "    b       _09009910\n"
        "_0900990C:\n"
        "    bl      sub_080008DC\n"
        "_09009910:\n"
        "    bl      sub_0800FD50\n"
        "    cmp     r0, #0\n"
        "    bne     _0900990C\n"
        "_09009918:\n"
        "    ldr     r3, _0900997C\n"
        "    ldrb    r0, [r3, #24]\n"
        "    ldrb    r1, [r3, #25]\n"
        "    movs    r4, #8\n"
        "    ldrsh   r2, [r3, r4]\n"
        "    movs    r4, #10\n"
        "    ldrsh   r3, [r3, r4]\n"
        "    bl      sub_0800CE10\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r0, r0, #24\n"
        "    cmp     r0, #1\n"
        "    bne     _0900993C\n"
        "    ldr     r0, _09009980\n"
        "    movs    r1, #4\n"
        "    ldrh    r2, [r0, #46]\n"
        "    orrs    r1, r2\n"
        "    strh    r1, [r0, #46]\n"
        "_0900993C:\n"
        "    bl      sub_08009BA0\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    beq     _09009958\n"
        "    ldr     r2, _09009980\n"
        "    ldrh    r1, [r2, #46]\n"
        "    movs    r0, #2\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    bne     _09009958\n"
        "    movs    r0, #2\n"
        "    orrs    r0, r1\n"
        "    strh    r0, [r2, #46]\n"
        "_09009958:\n"
        "    lsls    r0, r5, #24\n"
        "    lsrs    r0, r0, #24\n"
        "    cmp     r0, #7\n"
        "    bhi     _09009976\n"
        "    ldr     r1, _0900997C\n"
        "    movs    r0, #5\n"
        "    ldrsb   r0, [r1, r0]\n"
        "    cmp     r0, r5\n"
        "    bge     _09009976\n"
        "    strb    r5, [r1, #5]\n"
        "    bl      sub_0800A540\n"
        "    movs    r0, #4\n"
        "    bl      sub_08020C78\n"
        "_09009976:\n"
        "    pop     {r4, r5, r6}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "    .align  2, 0\n"
        "_0900997C: .word 0x030035e0\n"
        "_09009980: .word 0x03006110\n"
        "    .syntax divided\n");
}
#endif
