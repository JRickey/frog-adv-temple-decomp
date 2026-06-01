#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Searches a 5-entry (X, Y) lookup table at ROM 0x082f9cf4 for a coord
 * pair matching (s16)gIwram_35E0._field_8 / (u16)gIwram_35E0._field_A.
 * Returns 0 if no match or if the pendingMode/flag gates are not set;
 * otherwise returns the 1-based match index (after a side-effect call to
 * sub_08020C78(8)).
 *
 * Gates:
 *   - gGameStuff.pendingMode (offset 10) must be 1
 *   - *(u8*)(0x03006110 + 0x32) must be 1
 *
 * Shipped NAKED — but the prior "mov ip is corpus-unmatchable" rationale was WRONG
 * (a reclaim pass disproved it, 2026-05-28). The baserom caches the ROM table base in
 * the high register ip (`mov ip, r3`, read back as `mov r7, ip`), and that fold IS
 * reproducible from pure C via TWO-POINTER ALIASING: declare two pointers both set to
 * the same ROM literal (s16 *xtab / u16 *ytab = 0x082f9cf4), assigned AFTER the gate
 * checks, indexing X as xtab[i*2] and Y as ytab[i*2+1]. agbcc then loads the base once
 * (`ldr r3; mov ip, r3`) and reuses ip for the X-indexed load, exactly like baserom.
 *
 * Reclaim progress: byte_diff 86 -> 54 (size 116 B, prologue, X-load path, and the whole
 * control flow now match baserom). Working levers, by impact: (1) end-block written
 * `if (match != 0) { sub_08020C78(8); return match; } return 0;` (NOT early-return — this
 * fixed the size, 96->80); (2) table-pointer init AFTER the gates so agbcc keeps
 * `movs match,#0` second and doesn't hoist the base load to entry (80->54); (3) the
 * second gate via the gIwram_6110.state symbol+offset (not the bare 0x03006110+0x32
 * address) so +0x32 isn't folded into the pool literal; (4) two-pointer aliasing (above).
 *
 * REMAINING WALL (~54 byte_diff, a single instruction-selection diff): baserom computes
 * the Y address as `(base+2) + i*4` => `adds r0,r3,#2; adds r0,r1,r0; ldrh [r0,#0]`
 * (offset-0 load), but agbcc -O2 AND old_agbcc both reassociate-and-fold the +2 into the
 * load immediate => `adds r0,r1,r3; ldrh [r0,#2]`. No C phrasing found yet that blocks
 * that fold — permuter candidate / future corpus dig. Until then it stays NAKED; the
 * NON_MATCHING body below is the byte_diff-54 shape, the resume point for the next attempt.
 */

extern void sub_08020C78(u32 a);

#ifdef NON_MATCHING
u8 sub_08009BA0(void)
{
    s16 *xtab;
    u16 *ytab;
    s16 needleX;
    u16 needleY;
    u8 match = 0;
    u8 i;

    if (gGameStuff.pendingMode != 1)
        goto end;
    if (*(u8 *)(0x03006110 + 0x32) != 1) /* lever 3: prefer gIwram_6110.state symbol */
        goto end;

    /* lever 2: init the alias pointers AFTER the gates (no `mov ip` hoist to entry) */
    xtab = (s16 *)0x082f9cf4;
    ytab = (u16 *)0x082f9cf4;
    needleX = (s16)gIwram_35E0._field_8;
    i = 0;
    do {
        u8 cur = i;
        i = (u8)(i + 1);
        if (needleX != xtab[cur * 2]) /* lever 4: aliased base → `mov ip` reuse */
            continue;
        needleY = gIwram_35E0._field_A;
        if (needleY != ytab[cur * 2 + 1]) /* the +2 fold here is the remaining wall */
            continue;
        match = i;
    } while (i <= 4);

end:
    if (match != 0) { /* lever 1: not early-return — matches baserom size + end block */
        sub_08020C78(8);
        return match;
    }
    return 0;
}
#else
NAKED u8 sub_08009BA0(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, r7, lr}\n"
        "    movs    r6, #0\n"
        "    ldr     r0, _pool_gGameStuff\n"
        "    ldrb    r0, [r0, #10]\n"
        "    cmp     r0, #1\n"
        "    bne     _sub_08009BA0_check\n"
        "    ldr     r0, _pool_iwram_6110\n"
        "    adds    r0, #50\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r0, #1\n"
        "    bne     _sub_08009BA0_check\n"
        "    movs    r2, #0\n"
        "    ldr     r4, _pool_iwram_35E0\n"
        "    ldr     r3, _pool_table_82F9CF4\n"
        "    mov     ip, r3\n"
        "    movs    r0, #8\n"
        "    ldrsh   r5, [r4, r0]\n"
        "_sub_08009BA0_loop:\n"
        "    lsls    r1, r2, #2\n"
        "    mov     r7, ip\n"
        "    adds    r0, r1, r7\n"
        "    movs    r7, #0\n"
        "    ldrsh   r0, [r0, r7]\n"
        "    adds    r2, #1\n"
        "    cmp     r5, r0\n"
        "    bne     _sub_08009BA0_step\n"
        "    adds    r0, r3, #2\n"
        "    adds    r0, r1, r0\n"
        "    ldrh    r1, [r4, #10]\n"
        "    ldrh    r0, [r0, #0]\n"
        "    cmp     r1, r0\n"
        "    bne     _sub_08009BA0_step\n"
        "    lsls    r0, r2, #24\n"
        "    lsrs    r6, r0, #24\n"
        "_sub_08009BA0_step:\n"
        "    lsls    r0, r2, #24\n"
        "    lsrs    r2, r0, #24\n"
        "    cmp     r2, #4\n"
        "    bls     _sub_08009BA0_loop\n"
        "_sub_08009BA0_check:\n"
        "    lsls    r4, r6, #24\n"
        "    cmp     r4, #0\n"
        "    bne     _sub_08009BA0_match\n"
        "    movs    r0, #0\n"
        "    b       _sub_08009BA0_ret\n"
        "    .align  2, 0\n"
        "_pool_gGameStuff:    .4byte 0x03005330\n"
        "_pool_iwram_6110:    .4byte 0x03006110\n"
        "_pool_iwram_35E0:    .4byte 0x030035e0\n"
        "_pool_table_82F9CF4: .4byte 0x082f9cf4\n"
        "_sub_08009BA0_match:\n"
        "    movs    r0, #8\n"
        "    bl      sub_08020C78\n"
        "    lsrs    r0, r4, #24\n"
        "_sub_08009BA0_ret:\n"
        "    pop     {r4, r5, r6, r7}\n"
        "    pop     {r1}\n"
        "    bx      r1\n"
        "    .align  2, 0\n"
        "    .syntax divided\n");
}
#endif

/* Mode-transition step.
 *
 * Called once per frame in the game's mode-2 / dispatch loop. Decides
 * whether to advance to a queued state (path-1, ProcA dispatch) or
 * commit the pending mode (path-2, sub_0801E28C gate). The byte at
 * *arg is a u8 flag that the caller resets to zero when path-2 commits.
 *
 * Returns 1 only when path-2 commits (sub_0801E28C said "ready" and
 * the entity-state byte got overwritten with gIwram_34B4[2]). All
 * other code paths return 0.
 *
 * sEntityProcA[gGameStuff.pendingMode] is the per-entity-type "init"
 * handler from the parallel-arrays cluster at 0x080c0c74; agbcc emits
 * the indirect call as `bl _call_via_r0`.
 *
 * Shipped NAKED. The pure-C body in the NON_MATCHING block compiles to
 * byte_diff=6 — same fifth-class register-coloring drift documented in
 * docs/codegen-notes.md ("Fifth unmatchable class"). Two distinct
 * sub-issues: (1) `(gGameStuff._unk10 & 1) == 0` emits `ldrb r1; movs
 * r0, #1` in built whereas baserom emits `movs r0, #1; ldrb r1` —
 * statement order baserom-side appears to put the constant before the
 * load. (2) The `sEntityProcA[gGameStuff.pendingMode]()` index landed
 * in r0 (agbcc) vs r2 (baserom). Operand-flip, local-cache, register-
 * pin variations all either kept byte_diff at 6 or regressed.
 */

extern void sub_0800EF90(void);
extern void sub_0800A05C(void);
extern u32 sub_0801E28C(void);
extern void sub_0802D8F8(void);
extern void sub_08006ADC(struct IwramAt35E0 *p);
extern void sub_08007874(s32 a);
extern const u32 sEntityProcA[17];

#ifdef NON_MATCHING
u8 sub_08009C14(u8 *flag)
{
    sub_0800EF90();
    sub_0800A05C();

    if (gIwram_35E0._data[0] == 1) {
        gIwram_3720._field_34 = 0;
        if (sub_0801E28C() != 0) {
            gIwram_35E0._data[0] = gIwram_34B4._data[2];
            gIwram_35E0._field_5 = 0;
            *flag = 0;
            sub_0802D8F8();
            return 1;
        }
        sub_0802D8F8();
        gGameStuff.mode = 25;
        return 0;
    }

    if ((gGameStuff._unk10 & 1) == 0)
        sub_08006ADC(&gIwram_35E0);
    sub_08007874(gIwram_35E0._field_5);
    ((void (*)(void))sEntityProcA[gGameStuff.pendingMode])();
    if (gGameStuff.mode == 24) {
        gGameStuff.mode = 4;
        gGameStuff.pendingMode = 0;
        gIwram_3480._data[0] = 4;
        return 0;
    }
    sub_0802D8F8();
    return 0;
}
#else
NAKED u8 sub_08009C14(u8 *flag)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, r6, lr}\n"
        "    adds    r6, r0, #0\n"
        "    bl      sub_0800EF90\n"
        "    bl      sub_0800A05C\n"
        "    ldr     r5, _pool_iwram_35E0_a\n"
        "    ldrb    r0, [r5, #0]\n"
        "    cmp     r0, #1\n"
        "    bne     _sub_08009C14_pending_branch\n"
        "    ldr     r0, _pool_iwram_3720\n"
        "    movs    r4, #0\n"
        "    movs    r1, #0\n"
        "    strh    r1, [r0, #52]\n"
        "    bl      sub_0801E28C\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08009C14_set_mode_25\n"
        "    ldr     r0, _pool_iwram_34B4\n"
        "    ldrb    r0, [r0, #2]\n"
        "    strb    r0, [r5, #0]\n"
        "    strb    r4, [r5, #5]\n"
        "    strb    r4, [r6, #0]\n"
        "    bl      sub_0802D8F8\n"
        "    movs    r0, #1\n"
        "    b       _sub_08009C14_epilogue\n"
        "    .align  2, 0\n"
        "_pool_iwram_35E0_a: .4byte gIwram_35E0\n"
        "_pool_iwram_3720:   .4byte gIwram_3720\n"
        "_pool_iwram_34B4:   .4byte gIwram_34B4\n"
        "_sub_08009C14_set_mode_25:\n"
        "    bl      sub_0802D8F8\n"
        "    ldr     r1, _pool_gGameStuff_a\n"
        "    movs    r0, #25\n"
        "    strb    r0, [r1, #9]\n"
        "    b       _sub_08009C14_ret0\n"
        "    .align  2, 0\n"
        "_pool_gGameStuff_a: .4byte 0x03005330\n"
        "_sub_08009C14_pending_branch:\n"
        "    ldr     r4, _pool_gGameStuff_b\n"
        "    movs    r0, #1\n"
        "    ldrb    r1, [r4, #16]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08009C14_skip_6ADC\n"
        "    adds    r0, r5, #0\n"
        "    bl      sub_08006ADC\n"
        "_sub_08009C14_skip_6ADC:\n"
        "    movs    r0, #5\n"
        "    ldrsb   r0, [r5, r0]\n"
        "    bl      sub_08007874\n"
        "    ldr     r1, _pool_proc_a\n"
        "    ldrb    r2, [r4, #10]\n"
        "    lsls    r0, r2, #2\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    bl      _call_via_r0\n"
        "    ldrb    r0, [r4, #9]\n"
        "    cmp     r0, #24\n"
        "    beq     _sub_08009C14_mode24\n"
        "    bl      sub_0802D8F8\n"
        "    b       _sub_08009C14_ret0\n"
        "    .align  2, 0\n"
        "_pool_gGameStuff_b: .4byte 0x03005330\n"
        "_pool_proc_a:       .4byte sEntityProcA\n"
        "_sub_08009C14_mode24:\n"
        "    movs    r0, #0\n"
        "    movs    r1, #4\n"
        "    strb    r1, [r4, #9]\n"
        "    strb    r0, [r4, #10]\n"
        "    ldr     r0, _pool_iwram_3480\n"
        "    strb    r1, [r0, #0]\n"
        "_sub_08009C14_ret0:\n"
        "    movs    r0, #0\n"
        "_sub_08009C14_epilogue:\n"
        "    pop     {r4, r5, r6}\n"
        "    pop     {r1}\n"
        "    bx      r1\n"
        "    .align  2, 0\n"
        "_pool_iwram_3480:   .4byte gIwram_3480\n"
        "    .syntax divided\n");
}
#endif

typedef void (*GameProc)(void);

extern const u32 sEntityParamTable[17];
extern const u32 sEntityProcB[17];
extern const u32 sEntityProcC[17];
extern const u8 sEntitySubtypeLut[20];

extern void sub_08020BAC(void);
extern void sub_08020B88(u32 arg);
extern void sub_0800A05C(void);
extern void sub_080077AC(s8 a, s16 b, s8 c);
extern void sub_0800F24C(u8 arg);
extern void sub_0800A520(void);
extern void sub_08009A58(void);
extern void sub_08009188(void);
extern void sub_080008DC(void);
extern void sub_0800A328(void);

void sub_08009CBC(void)
{
    struct IwramAt6110 *s;
    GameStuff *p;
    u32 value;

    p = &gGameStuff;

    /* The `!= 16` read is volatile-qualified so agbcc re-loads pendingMode after the
     * __umodsi3 call instead of caching it in a callee-saved reg across the BL; that
     * keeps the base in r4 (re-read each time), matching the baserom. */
    if ((u8)(p->pendingMode % 3) != 0 && ((volatile GameStuff *)p)->pendingMode != 16) {
        value = 0;
        sub_08020BAC();
        if (gIwram_6110.state == 1) {
            const u32 *table = sEntityParamTable;
            /* Reuse the now-dead base pointer so agbcc overwrites r4 with the index. */
            p = (GameStuff *)(u32)p->pendingMode;
            value = table[(u32)p];
        }
        sub_08020B88(value);
    }

    sub_0800A05C();
    sub_080077AC((s8)gIwram_35E0._data[0], *(s16 *)&gIwram_35E0._data[2], 0);

    {
        const u32 *procC;
        GameStuff *base;
        register u8 idx1 asm("r1");
        register u8 idx2 asm("r2");
        register u32 offset asm("r0");

        procC = sEntityProcC;
        base = &gGameStuff;
        idx1 = base->pendingMode;
        offset = ((u32)idx1 << 2) + (u32)procC;
        ((GameProc)(*(const u32 *)offset))();

        {
            register const u8 *lut asm("r0");
            lut = sEntitySubtypeLut;
            idx2 = base->pendingMode;
            sub_0800F24C(*(const u8 *)(idx2 + (u32)lut));
        }

        {
            register const u32 *procA asm("r1");
            procA = sEntityProcA;
            idx2 = base->pendingMode;
            offset = ((u32)idx2 << 2) + (u32)procA;
            ((GameProc)(*(const u32 *)offset))();
        }

        idx1 = base->pendingMode;
        offset = ((u32)idx1 << 2) + (u32)procC;
        ((GameProc)(*(const u32 *)offset))();

        s = &gIwram_6110;
        s->flagBank0 = -1;
        s->flagBank1 = -1;

        sub_0800A520();

        {
            register const u32 *procB asm("r1");
            procB = sEntityProcB;
            idx2 = base->pendingMode;
            offset = ((u32)idx2 << 2) + (u32)procB;
            ((GameProc)(*(const u32 *)offset))();
        }

        sub_08009A58();
        sub_08009188();
        sub_080008DC();
        sub_0800A328();

        base->_unk14 = 0;
    }
}
