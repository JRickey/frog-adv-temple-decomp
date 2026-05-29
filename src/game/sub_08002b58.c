#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* sub_08002B58 -- per-frame handler for game-mode 16 (the mode AgbMain
 * dispatches to this function). A 1-byte sub-state lives on the stack
 * (sp+1, the `state` local, kept in r5) and a second scratch byte at sp+0
 * (`secondary`). The function loops as long as gGameStuff.mode stays 16,
 * dispatching on the sub-state through a 12-entry `mov pc, rN` jump table
 * (cases 0..11).
 *
 * Shipped as NAKED inline asm + NON_MATCHING reference C. The function body
 * (cases 0..11, the dispatcher, the epilogue) compiles byte-for-byte under
 * old_agbcc; the ONLY residual diff is the prologue's register colouring --
 * the baserom pins &state into r5 BEFORE reading gGameStuff.mode (state ptr
 * in r0, gGameStuff base in r1), whereas agbcc/old_agbcc read mode first and
 * pin r5 afterwards. That `&localState`-pinned-across-the-loop prologue is
 * the documented mode-X dispatcher wall (see docs/codegen-notes.md "Iter-38"
 * wall #1) -- it is NOT controllable from C and is shared by the entire
 * sibling cluster (sub_08000918 / EB8 / 1214 / 1508 / 19B4 / 2844), all of
 * which ship NAKED for the same reason. Corpus-confirmed: every `sub sp, #4`
 * + state-byte mov-pc dispatcher across all agbcc-era decomps lives only in
 * hand-asm; zero pure-C precedent. The NON_MATCHING body documents the
 * structure (verified byte-exact except the 10-byte prologue) for phase 3.
 */

extern void sub_08020BC0(void);
extern u32 sub_0800A214(void);
extern u8 sub_0800A104(u8 *secondary, u32 callbackTable);
extern void sub_0801B514(u32 arg);
extern void sub_0800A258(u32 arg);
extern u32 sub_08009D9C(u8 *secondary);
extern u16 sub_080004C4(void);
extern void sub_0800E060(void);
extern u8 sub_0800679C(void *base, u32 selector, u32 bit);
extern void sub_080066C4(void *base, u32 selector, u32 bit);
extern void sub_0800A2D8(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);
extern void sub_080094F8(void);
extern void sub_08009984(void);
extern u32 sub_0800CD88(u8 col, u8 row, s32 tileX, s32 tileY);
extern void sub_0800ACE8(u8 arg);
extern u32 sub_08009C14(u8 *state);
extern void sub_08002AE8(void);
extern void sub_0800A540(void);
extern u8 sub_0800E6A8(void);
extern u8 sub_08010694(u8 arg);
extern u8 sub_080106B8(void);
extern void sub_0800DE80(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

#ifdef NON_MATCHING

/* Reference body -- compiles to the baserom bytes for the entire function
 * body; only the prologue register colouring differs (see header note). */
void sub_08002B58(void)
{
    s8 secondary;
    u8 state;
    u32 r6;

    state = 0;
    if (gGameStuff.mode != 16)
        return;

    do {
        sub_08020BC0();
        if (state > 11)
            goto tail;

        switch (state) {
        case 0:
            gGameStuff.pendingMode = 9;
            r6 = sub_0800A214();
            state = 1;
            secondary = 0;
            goto tail;
        case 1:
            if (sub_0800A104((u8 *)&secondary, 0x08002E11) == 0)
                goto cleanup;
            state = 2;
            gGameStuff._unk14 = 0;
            secondary = 0;
            goto cleanup;
        case 2:
            sub_0801B514(9);
            sub_0800A258(r6);
            state = 3;
            goto tail;
        case 3:
            if (sub_08009D9C((u8 *)&secondary) == 0)
                goto tail;
            state = 4;
            gGameStuff._unk14 = 0;
            secondary = 0;
            goto tail;
        case 4:
            gIwram_5398 = sub_080004C4();
            if (gIwram_5398 == 0x40) {
                state = 7;
                sub_0800E060();
                goto tail;
            }
            if ((gIwram_3720._field_34 & 8) != 0) {
                state = 5;
                goto tail;
            }
            if (sub_0800679C(&gIwram_6110, 8, 0) != 0) {
                state = 10;
                goto tail;
            }
            if (sub_0800679C(&gIwram_6110, 8, 1) != 0) {
                sub_080066C4(&gIwram_6110, 8, 1);
                state = 6;
                goto tail;
            }
            sub_0800A2D8();
            sub_080008DC();
            sub_0800A328();
            sub_080094F8();
            sub_08009984();
            if ((gIwram_35E0._field_10 & 0x10) != 0) {
                sub_0800ACE8((u8)sub_0800CD88(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8,
                                              gIwram_35E0._field_A));
            }
            gGameStuff._unk14++;
            goto tail;
        case 5:
            if (sub_08009C14(&state) == 0)
                state = 9;
            secondary = 0;
            goto tail;
        case 6:
            sub_08002AE8();
            gIwram_3720._field_6c |= 8;
            sub_0800A540();
            state = 4;
            gGameStuff._unk14 = 0;
            goto tail;
        case 7:
            gIwram_5398 = sub_080004C4();
            if (sub_0800E6A8() == 0) {
                state = 8;
                secondary = 0;
            }
            if (gIwram_5328 == 0)
                state = 4;
            goto tail;
        case 8: {
            s32 counter;
            if (secondary == 0) {
                sub_08010694(0xBF);
                secondary++;
            }
            counter = secondary;
            if (counter != 1)
                goto tail;
            if (sub_080106B8() != 0)
                goto tail;
            gIwram_3480._data[0] = 4;
            gIwram_3480._data[6] = counter;
            gGameStuff.mode = 4;
            goto tail;
        }
        case 9:
            if (sub_0800A104((u8 *)&secondary, 0x0800A26D) != 0) {
                state = 3;
                gGameStuff._unk14 = 0;
                secondary = 0;
                sub_0800A258(r6);
            }
            /* fall through */
        cleanup:
            sub_080008DC();
            goto tail;
        case 10:
            state = 11;
            goto tail;
        case 11:
            sub_0800DE80();
            goto tail;
        }

    tail:;
    } while (gGameStuff.mode == 16);
}

#else

NAKED
void sub_08002B58(void)
{
    asm(".syntax unified\n"
        "    push {r4, r5, r6, lr}\n"
        "    sub sp, #4\n"
        "    mov r0, sp\n"
        "    adds r0, #1\n"
        "    movs r1, #0\n"
        "    strb r1, [r0, #0]\n"
        "    ldr r1, _sub_08002B58_pool_0030\n"
        "    adds r5, r0, #0\n"
        "    ldrb r1, [r1, #9]\n"
        "    cmp r1, #16\n"
        "    beq _sub_08002B58_0018\n"
        "    b _sub_08002B58_02a0\n"
        "_sub_08002B58_0018:\n"
        "    bl sub_08020BC0\n"
        "    ldrb r0, [r5, #0]\n"
        "    cmp r0, #11\n"
        "    bls _sub_08002B58_0024\n"
        "    b _sub_08002B58_0296\n"
        "_sub_08002B58_0024:\n"
        "    lsls r0, r0, #2\n"
        "    ldr r1, _sub_08002B58_pool_0034\n"
        "    adds r0, r0, r1\n"
        "    ldr r0, [r0, #0]\n"
        "    mov pc, r0\n"
        "    .hword 0\n"
        "_sub_08002B58_pool_0030:    .4byte 0x03005330\n"
        "_sub_08002B58_pool_0034:    .4byte _sub_08002B58_jumpTable\n"
        "_sub_08002B58_jumpTable:\n"
        "    .4byte _sub_08002B58_0068\n"
        "    .4byte _sub_08002B58_0084\n"
        "    .4byte _sub_08002B58_00ac\n"
        "    .4byte _sub_08002B58_00be\n"
        "    .4byte _sub_08002B58_00e0\n"
        "    .4byte _sub_08002B58_01a0\n"
        "    .4byte _sub_08002B58_01b6\n"
        "    .4byte _sub_08002B58_01e0\n"
        "    .4byte _sub_08002B58_0214\n"
        "    .4byte _sub_08002B58_025c\n"
        "    .4byte _sub_08002B58_028c\n"
        "    .4byte _sub_08002B58_0292\n"
        "_sub_08002B58_0068:\n"
        "    ldr r1, _sub_08002B58_pool_0080\n"
        "    movs r4, #0\n"
        "    movs r0, #9\n"
        "    strb r0, [r1, #10]\n"
        "    bl sub_0800A214\n"
        "    adds r6, r0, #0\n"
        "    movs r0, #1\n"
        "    strb r0, [r5, #0]\n"
        "    mov r0, sp\n"
        "    strb r4, [r0, #0]\n"
        "    b _sub_08002B58_0296\n"
        "_sub_08002B58_pool_0080:    .4byte 0x03005330\n"
        "_sub_08002B58_0084:\n"
        "    ldr r1, _sub_08002B58_pool_00a4\n"
        "    mov r0, sp\n"
        "    bl sub_0800A104\n"
        "    lsls r0, r0, #24\n"
        "    cmp r0, #0\n"
        "    bne _sub_08002B58_0094\n"
        "    b _sub_08002B58_027e\n"
        "_sub_08002B58_0094:\n"
        "    movs r0, #2\n"
        "    strb r0, [r5, #0]\n"
        "    ldr r0, _sub_08002B58_pool_00a8\n"
        "    movs r1, #0\n"
        "    str r1, [r0, #20]\n"
        "    mov r0, sp\n"
        "    strb r1, [r0, #0]\n"
        "    b _sub_08002B58_027e\n"
        "_sub_08002B58_pool_00a4:    .4byte 0x08002E11\n"
        "_sub_08002B58_pool_00a8:    .4byte 0x03005330\n"
        "_sub_08002B58_00ac:\n"
        "    movs r0, #9\n"
        "    bl sub_0801B514\n"
        "    adds r0, r6, #0\n"
        "    bl sub_0800A258\n"
        "    movs r0, #3\n"
        "    strb r0, [r5, #0]\n"
        "    b _sub_08002B58_0296\n"
        "_sub_08002B58_00be:\n"
        "    mov r0, sp\n"
        "    bl sub_08009D9C\n"
        "    cmp r0, #0\n"
        "    bne _sub_08002B58_00ca\n"
        "    b _sub_08002B58_0296\n"
        "_sub_08002B58_00ca:\n"
        "    movs r0, #4\n"
        "    strb r0, [r5, #0]\n"
        "    ldr r0, _sub_08002B58_pool_00dc\n"
        "    movs r1, #0\n"
        "    str r1, [r0, #20]\n"
        "    mov r0, sp\n"
        "    strb r1, [r0, #0]\n"
        "    b _sub_08002B58_0296\n"
        "    .hword 0\n"
        "_sub_08002B58_pool_00dc:    .4byte 0x03005330\n"
        "_sub_08002B58_00e0:\n"
        "    bl sub_080004C4\n"
        "    ldr r1, _sub_08002B58_pool_00fc\n"
        "    strh r0, [r1, #0]\n"
        "    lsls r0, r0, #16\n"
        "    lsrs r0, r0, #16\n"
        "    cmp r0, #64\n"
        "    bne _sub_08002B58_0100\n"
        "    movs r0, #7\n"
        "    strb r0, [r5, #0]\n"
        "    bl sub_0800E060\n"
        "    b _sub_08002B58_0296\n"
        "    .hword 0\n"
        "_sub_08002B58_pool_00fc:    .4byte 0x03005398\n"
        "_sub_08002B58_0100:\n"
        "    ldr r1, _sub_08002B58_pool_0114\n"
        "    movs r0, #8\n"
        "    ldrh r1, [r1, #52]\n"
        "    ands r0, r1\n"
        "    cmp r0, #0\n"
        "    beq _sub_08002B58_0118\n"
        "    movs r0, #5\n"
        "    strb r0, [r5, #0]\n"
        "    b _sub_08002B58_0296\n"
        "    .hword 0\n"
        "_sub_08002B58_pool_0114:    .4byte 0x03003720\n"
        "_sub_08002B58_0118:\n"
        "    ldr r4, _sub_08002B58_pool_0130\n"
        "    adds r0, r4, #0\n"
        "    movs r1, #8\n"
        "    movs r2, #0\n"
        "    bl sub_0800679C\n"
        "    lsls r0, r0, #24\n"
        "    cmp r0, #0\n"
        "    beq _sub_08002B58_0134\n"
        "    movs r0, #10\n"
        "    strb r0, [r5, #0]\n"
        "    b _sub_08002B58_0296\n"
        "_sub_08002B58_pool_0130:    .4byte 0x03006110\n"
        "_sub_08002B58_0134:\n"
        "    adds r0, r4, #0\n"
        "    movs r1, #8\n"
        "    movs r2, #1\n"
        "    bl sub_0800679C\n"
        "    lsls r0, r0, #24\n"
        "    cmp r0, #0\n"
        "    beq _sub_08002B58_0154\n"
        "    adds r0, r4, #0\n"
        "    movs r1, #8\n"
        "    movs r2, #1\n"
        "    bl sub_080066C4\n"
        "    movs r0, #6\n"
        "    strb r0, [r5, #0]\n"
        "    b _sub_08002B58_0296\n"
        "_sub_08002B58_0154:\n"
        "    bl sub_0800A2D8\n"
        "    bl sub_080008DC\n"
        "    bl sub_0800A328\n"
        "    bl sub_080094F8\n"
        "    bl sub_08009984\n"
        "    ldr r3, _sub_08002B58_pool_0198\n"
        "    movs r0, #16\n"
        "    ldrh r1, [r3, #16]\n"
        "    ands r0, r1\n"
        "    cmp r0, #0\n"
        "    beq _sub_08002B58_018c\n"
        "    ldrb r0, [r3, #24]\n"
        "    ldrb r1, [r3, #25]\n"
        "    movs r4, #8\n"
        "    ldrsh r2, [r3, r4]\n"
        "    movs r4, #10\n"
        "    ldrsh r3, [r3, r4]\n"
        "    bl sub_0800CD88\n"
        "    lsls r0, r0, #24\n"
        "    lsrs r0, r0, #24\n"
        "    bl sub_0800ACE8\n"
        "_sub_08002B58_018c:\n"
        "    ldr r1, _sub_08002B58_pool_019c\n"
        "    ldr r0, [r1, #20]\n"
        "    adds r0, #1\n"
        "    str r0, [r1, #20]\n"
        "    b _sub_08002B58_0296\n"
        "    .hword 0\n"
        "_sub_08002B58_pool_0198:    .4byte 0x030035E0\n"
        "_sub_08002B58_pool_019c:    .4byte 0x03005330\n"
        "_sub_08002B58_01a0:\n"
        "    adds r0, r5, #0\n"
        "    bl sub_08009C14\n"
        "    cmp r0, #0\n"
        "    bne _sub_08002B58_01ae\n"
        "    movs r0, #9\n"
        "    strb r0, [r5, #0]\n"
        "_sub_08002B58_01ae:\n"
        "    mov r1, sp\n"
        "    movs r0, #0\n"
        "    strb r0, [r1, #0]\n"
        "    b _sub_08002B58_0296\n"
        "_sub_08002B58_01b6:\n"
        "    bl sub_08002AE8\n"
        "    ldr r1, _sub_08002B58_pool_01d8\n"
        "    adds r1, #108\n"
        "    movs r0, #8\n"
        "    movs r4, #0\n"
        "    ldrh r2, [r1, #0]\n"
        "    orrs r0, r2\n"
        "    strh r0, [r1, #0]\n"
        "    bl sub_0800A540\n"
        "    movs r0, #4\n"
        "    strb r0, [r5, #0]\n"
        "    ldr r0, _sub_08002B58_pool_01dc\n"
        "    str r4, [r0, #20]\n"
        "    b _sub_08002B58_0296\n"
        "    .hword 0\n"
        "_sub_08002B58_pool_01d8:    .4byte 0x03003720\n"
        "_sub_08002B58_pool_01dc:    .4byte 0x03005330\n"
        "_sub_08002B58_01e0:\n"
        "    bl sub_080004C4\n"
        "    ldr r1, _sub_08002B58_pool_020c\n"
        "    strh r0, [r1, #0]\n"
        "    bl sub_0800E6A8\n"
        "    lsls r0, r0, #24\n"
        "    lsrs r1, r0, #24\n"
        "    cmp r1, #0\n"
        "    bne _sub_08002B58_01fc\n"
        "    movs r0, #8\n"
        "    strb r0, [r5, #0]\n"
        "    mov r0, sp\n"
        "    strb r1, [r0, #0]\n"
        "_sub_08002B58_01fc:\n"
        "    ldr r0, _sub_08002B58_pool_0210\n"
        "    ldrb r0, [r0, #0]\n"
        "    cmp r0, #0\n"
        "    bne _sub_08002B58_0296\n"
        "    movs r0, #4\n"
        "    strb r0, [r5, #0]\n"
        "    b _sub_08002B58_0296\n"
        "    .hword 0\n"
        "_sub_08002B58_pool_020c:    .4byte 0x03005398\n"
        "_sub_08002B58_pool_0210:    .4byte 0x03005328\n"
        "_sub_08002B58_0214:\n"
        "    mov r0, sp\n"
        "    ldrb r0, [r0, #0]\n"
        "    lsls r0, r0, #24\n"
        "    asrs r0, r0, #24\n"
        "    cmp r0, #0\n"
        "    bne _sub_08002B58_0230\n"
        "    movs r0, #191\n"
        "    bl sub_08010694\n"
        "    mov r0, sp\n"
        "    mov r1, sp\n"
        "    ldrb r1, [r1, #0]\n"
        "    adds r1, #1\n"
        "    strb r1, [r0, #0]\n"
        "_sub_08002B58_0230:\n"
        "    mov r0, sp\n"
        "    movs r4, #0\n"
        "    ldrsb r4, [r0, r4]\n"
        "    cmp r4, #1\n"
        "    bne _sub_08002B58_0296\n"
        "    bl sub_080106B8\n"
        "    lsls r0, r0, #24\n"
        "    cmp r0, #0\n"
        "    bne _sub_08002B58_0296\n"
        "    ldr r0, _sub_08002B58_pool_0254\n"
        "    movs r1, #4\n"
        "    strb r1, [r0, #0]\n"
        "    strb r4, [r0, #6]\n"
        "    ldr r0, _sub_08002B58_pool_0258\n"
        "    strb r1, [r0, #9]\n"
        "    b _sub_08002B58_0296\n"
        "    .hword 0\n"
        "_sub_08002B58_pool_0254:    .4byte 0x03003480\n"
        "_sub_08002B58_pool_0258:    .4byte 0x03005330\n"
        "_sub_08002B58_025c:\n"
        "    ldr r1, _sub_08002B58_pool_0284\n"
        "    mov r0, sp\n"
        "    bl sub_0800A104\n"
        "    lsls r0, r0, #24\n"
        "    cmp r0, #0\n"
        "    beq _sub_08002B58_027e\n"
        "    movs r0, #3\n"
        "    strb r0, [r5, #0]\n"
        "    ldr r0, _sub_08002B58_pool_0288\n"
        "    movs r1, #0\n"
        "    str r1, [r0, #20]\n"
        "    mov r0, sp\n"
        "    strb r1, [r0, #0]\n"
        "    adds r0, r6, #0\n"
        "    bl sub_0800A258\n"
        "_sub_08002B58_027e:\n"
        "    bl sub_080008DC\n"
        "    b _sub_08002B58_0296\n"
        "_sub_08002B58_pool_0284:    .4byte 0x0800A26D\n"
        "_sub_08002B58_pool_0288:    .4byte 0x03005330\n"
        "_sub_08002B58_028c:\n"
        "    movs r0, #11\n"
        "    strb r0, [r5, #0]\n"
        "    b _sub_08002B58_0296\n"
        "_sub_08002B58_0292:\n"
        "    bl sub_0800DE80\n"
        "_sub_08002B58_0296:\n"
        "    ldr r0, _sub_08002B58_pool_02a8\n"
        "    ldrb r0, [r0, #9]\n"
        "    cmp r0, #16\n"
        "    bne _sub_08002B58_02a0\n"
        "    b _sub_08002B58_0018\n"
        "_sub_08002B58_02a0:\n"
        "    add sp, #4\n"
        "    pop {r4, r5, r6}\n"
        "    pop {r0}\n"
        "    bx r0\n"
        "_sub_08002B58_pool_02a8:    .4byte 0x03005330\n"
        "    .syntax divided\n");
}

#endif
