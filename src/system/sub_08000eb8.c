#include "entity.h"
#include "game.h"
#include "gfx.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Scene09_Run — per-frame handler for game-mode 9 (and re-entered for
 * mode 24 — the AgbMain dispatch maps mode 9 to this function, but the
 * function itself loops as long as gGameStuff.mode stays at 9 or 24).
 *
 * The function maintains a 1-byte sub-state on the stack (at sp+0x141)
 * and dispatches on it via a computed jump through an inline 9-entry
 * table. Cases 0..8 each advance the sub-state, sometimes invoking
 * subsystem callees and setting gGameStuff.sceneType / gGameStuff._unk14.
 * After each case the function re-checks gGameStuff.mode: if it's still
 * 9 or 24 the loop continues with another Sound_ServiceQueue (per-frame tick
 * / VBlank wait); otherwise control falls through to the epilogue.
 *
 * Sub-state behaviour, mirroring Scene15_Main (mode 15/24) with
 * mode-9-specific callbacks and constants:
 *   0 -> sets gGameStuff.sceneType = 2; Entity_UpdateHitboxSlots(sp_buf, &r4_obj, 3)
 *        (a 3-arg dispatch); substate = 1; clears sp[+0x140].
 *   1 -> RunFadeTransition(&sp[+0x140], 0x08000d5d); on accept advances to
 *        2, clears gGameStuff._unk14 and sp[+0x140], then runs the
 *        WaitVblank-then-tail block. On reject just WaitVblank + tail.
 *   2 -> Scene_InitScan(&sp[+0x140]); on success advances to 3 and clears
 *        gGameStuff._unk14.
 *   3 -> Input_Poll -> gIwram_5398; if == 0x40 substate = 5 + Scene_LoadBg;
 *        else falls through to the gIwram_3720 / gIwram_6110 keypad gate:
 *          (gEntities[0].status & 8) -> substate = 4
 *          (gIwram_6110.inputFlags & 8) -> substate = 8
 *          neither -> Game_RunEntityFrame + WaitVblank + Game_ForceRender +
 *                     Entity_CheckAllCollisions + Player_CheckTileEvents + Scene09_UpdatePlayerTile(sp_buf,
 *                     &r4_obj); gGameStuff._unk14++.
 *   4 -> Scene_EntityTick(&localState); on accept (r0 != 0) skips advance;
 *        else substate = 7; then Entity_UpdateHitboxSlots(sp_buf, &r4_obj, 3),
 *        sp[+0x140] = 0.
 *   5 -> Input_Poll -> gIwram_5398; Scene_FadeUpdate(); if zero substate = 6
 *        and sp[+0x140] = 0; gates on gIwram_5328 — if non-zero skip;
 *        else substate = 3.
 *   6 -> sp[+0x140] test: if 0 call Blend_StartFade(0xBF) + increment;
 *        then ldrsb sp[+0x140] vs #1: must equal 1 to continue;
 *        Blend_StepFade() must return 0; then writes gIwram_3480.subState = 4,
 *        gIwram_3480[+6] = counter (the byte at sp+0x140 at the decision
 *        point), gGameStuff.mode = 4 (return to dispatcher).
 *   7 -> RunFadeTransition(&sp[+0x140], 0x0800a26d); on accept substate = 2,
 *        gGameStuff._unk14 = 0, sp[+0x140] = 0, EntityParam_Reset(); always
 *        falls through WaitVblank then tail.
 *   8 -> Game_FrameEnd(); fall straight to tail.
 *
 * The case-3 fallthrough block (mid-function, between cases 3 and 4 in
 * source order) is NOT a jump-table target — it's reachable only via
 * fall-through from case 3 when both the 0x40 check and the keypad
 * checks fail. The jump table skips it (case 4 in the table points to
 * Scene_EntityTick, not to the fallthrough). This is the case-number ≠
 * source-block-order trap documented in docs/codegen-notes.md.
 *
 * Shipped NAKED. The dispatch uses `mov pc, r0` after a jumpTable[idx]-
 * indexed `ldr` of an inline `.word` table. agbcc 2.x DOES emit this
 * for sequential `switch (0..N-1)` (the casesi insn pattern, per
 * docs/codegen-notes.md "mov pc, rN jump tables"), but the surrounding
 * 624-byte body with 29 pool entries, six adjacent IWRAM bases, and
 * a 332-byte stack buffer passed by pointer to 18 different callees
 * has not been matchable in pure C to date.
 *
 * Source-form variants attempted before NAKED (all > 100 byte_diff):
 *   1. Direct switch (case 0..8 sequential) — agbcc emits a jump table
 *      but interleaves the pool literals at different offsets than the
 *      baserom; case-block ordering also drifts.
 *   2. Cache &gIwram_5398 / &gGameStuff in fixed-register locals
 *      locals — agbcc respects the r4/r5 pins but baserom does NOT
 *      cache (re-emits ldr per case head); pinning forces caching
 *      where there shouldn't be any.
 *   3. Stack-buffer typing variations (`char sp_buf[320]; u8 sub` vs
 *      `struct { ... } locals;`) — both shift the +0x141 offset to
 *      a different sp computation; baserom uses `add r0, sp; #0x141`
 *      via a pool literal, which a struct member never emits.
 *   4. Splitting the do-while tail recheck into two explicit `if`s
 *      mirroring Scene15_Main — same diff.
 *   5. Explicit goto-shaped flow with `tail_with_finalize` and `tail`
 *      labels — agbcc coalesces the two tails into a single basic
 *      block, baserom keeps them distinct (the bl WaitVblank lives
 *      strictly on the case-1 / case-7 accept paths, not the bare-tail).
 *   6. Single raw `frame[332]` with macros for the sp+0x140/0x141/0x144
 *      slots, explicit initial tail jump, shared `tailWithFinalize`,
 *      corrected Scene_InitScan return width (u32 not u8), and low-register
 *      pins for state stores got the pure-C attempt down to byte_diff
 *      258 (verified, codex worktree iter-36-followup). Remaining drift
 *      is mainly literal-pool placement and the case-3 key gate's
 *      register order; a heavier pin attempt made codegen worse
 *      (byte_diff 294).
 *
 * Sibling precedent: Scene15_Main (src/game/mode_15.c, mode-15/24)
 * ships NAKED for the exact same shape. AgbMain (src/system/agb_main.c)
 * uses the same `mov pc, rN` dispatch and ships NAKED. This function
 * is the third cluster member; same justification.
 *
 * NON_MATCHING reference body documents intent for the phase-3 PC port.
 */

extern void Sound_ServiceQueue(void);
extern u8 RunFadeTransition(u8 *localState, u32 callbackTable);
extern u32 Scene_InitScan(u8 *localState);
extern u16 Input_Poll(void);
extern void Scene_LoadBg(void);
extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern void Scene09_UpdatePlayerTile(void *sp_buf, void *r4_obj);
extern u8 Scene_FadeUpdate(void);
extern u8 Blend_StepFade(void);
extern void EntityParam_Reset(void);
extern void Game_FrameEnd(void);

#define gIwram_5398       (*(u16 *)0x03005398)
#define gIwram_5328       (*(u8 *)0x03005328)
#define gIwram_3480_bytes ((u8 *)0x03003480)

#ifdef NON_MATCHING

/* Reference body — readable shape for the phase-3 PC port. Doesn't
 * compile to the same bytes; the NAKED form below is what matches. */
void Scene09_Run(void)
{
    u8 spByte;     /* sp + 0x140 */
    u8 localState; /* sp + 0x141 */
    u8 sp_buf[320];
    /* sp + 0x144: an opaque struct used as `&r4_obj` arg for
     * Entity_UpdateHitboxSlots, Scene09_UpdatePlayerTile, RunFadeTransition. Treat as void * here. */
    u8 r4_obj[8];

    localState = 0;

    do {
        Sound_ServiceQueue(); /* per-frame tick / VBlank wait */
        if (localState > 8)
            goto tail;

        switch (localState) {
        case 0:
            gGameStuff.sceneType = 2;
            Entity_UpdateHitboxSlots(sp_buf, r4_obj, 3);
            localState = 1;
            spByte = 0;
            break;
        case 1:
            if (RunFadeTransition(&spByte, 0x08000d5d) == 0) {
                WaitVblank();
                goto tail;
            }
            localState = 2;
            gGameStuff._unk14 = 0;
            spByte = 0;
            WaitVblank();
            goto tail;
        case 2:
            if (Scene_InitScan(&spByte) == 0)
                goto tail;
            localState = 3;
            gGameStuff._unk14 = 0;
            goto tail;
        case 3:
            gIwram_5398 = Input_Poll();
            if (gIwram_5398 == 0x40) {
                localState = 5;
                Scene_LoadBg();
                break;
            }
            if ((gEntities[0].status & 8) != 0) {
                localState = 4;
                break;
            }
            if ((gIwram_6110.inputFlags & 8) != 0) {
                localState = 8;
                break;
            }
            Game_RunEntityFrame();
            WaitVblank();
            Game_ForceRender();
            Entity_CheckAllCollisions();
            Player_CheckTileEvents();
            Scene09_UpdatePlayerTile(sp_buf, r4_obj);
            gGameStuff._unk14++;
            break;
        case 4:
            if (Scene_EntityTick((void *)&localState) == 0)
                localState = 7;
            Entity_UpdateHitboxSlots(sp_buf, r4_obj, 3);
            spByte = 0;
            break;
        case 5:
            gIwram_5398 = Input_Poll();
            if (Scene_FadeUpdate() == 0) {
                localState = 6;
                spByte = 0;
            }
            if (gIwram_5328 == 0)
                localState = 3;
            break;
        case 6: {
            s32 counter;
            if ((s8)spByte == 0) {
                Blend_StartFade(0xBF);
                spByte += 1;
            }
            counter = (s8)spByte;
            if (counter != 1)
                break;
            if (Blend_StepFade() != 0)
                break;
            gIwram_3480_bytes[0] = 4;
            gIwram_3480_bytes[6] = counter;
            gGameStuff.mode = GAME_MODE_ROUTER;
            break;
        }
        case 7:
            if (RunFadeTransition(&spByte, 0x0800a26d) != 0) {
                localState = 2;
                gGameStuff._unk14 = 0;
                spByte = 0;
                EntityParam_Reset();
            }
            WaitVblank();
            break;
        case 8:
            Game_FrameEnd();
            break;
        }

    tail:;
    } while (gGameStuff.mode == GAME_MODE_SCENE_09 || gGameStuff.mode == GAME_MODE_ATTRACT);
}

#else

/* NAKED form — matches the baserom byte-for-byte. The inline jump
 * table at _sub_08000EB8_jumpTable is consumed by `mov pc, r0` and so
 * MUST end up at the exact relative offset agbcc would have placed it
 * (right after the literal pool that follows the table-index load).
 * The .syntax-divided trailer is mandatory — see docs/codegen-notes.md
 * ".syntax unified bleed".
 */
NAKED
void Scene09_Run(void)
{
    asm(".syntax unified\n"
        "    push    {r4, r5, lr}\n"
        "    sub     sp, #332\n"
        "    ldr     r0, _sub_08000EB8_pool_off141_init\n"
        "    add     r0, sp\n"
        "    movs    r1, #0\n"
        "    strb    r1, [r0, #0]\n"
        "    b       _sub_08000EB8_tail\n"
        "    .hword  0\n"
        "_sub_08000EB8_pool_off141_init:    .4byte 0x00000141\n"
        "_sub_08000EB8_loopHead:\n"
        "    bl      Sound_ServiceQueue\n"
        "    ldr     r0, _sub_08000EB8_pool_off141_loop\n"
        "    add     r0, sp\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r0, #8\n"
        "    bls     _sub_08000EB8_dispatch\n"
        "    b       _sub_08000EB8_tail\n"
        "_sub_08000EB8_dispatch:\n"
        "    lsls    r0, r0, #2\n"
        "    ldr     r1, _sub_08000EB8_pool_jumpTablePtr\n"
        "    adds    r0, r0, r1\n"
        "    ldr     r0, [r0, #0]\n"
        "    mov     pc, r0\n"
        "    .hword  0\n"
        "_sub_08000EB8_pool_off141_loop:    .4byte 0x00000141\n"
        "_sub_08000EB8_pool_jumpTablePtr:   .4byte _sub_08000EB8_jumpTable\n"
        "_sub_08000EB8_jumpTable:\n"
        "    .4byte _sub_08000EB8_case0\n"
        "    .4byte _sub_08000EB8_case1\n"
        "    .4byte _sub_08000EB8_case2\n"
        "    .4byte _sub_08000EB8_case3\n"
        "    .4byte _sub_08000EB8_case4\n"
        "    .4byte _sub_08000EB8_case5\n"
        "    .4byte _sub_08000EB8_case6\n"
        "    .4byte _sub_08000EB8_case7\n"
        "    .4byte _sub_08000EB8_case8\n"
        "_sub_08000EB8_case0:\n"
        "    add     r1, sp, #324\n"
        "    ldr     r2, _sub_08000EB8_pool_gGameStuff_case0\n"
        "    movs    r4, #0\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r2, #10]\n"
        "    mov     r0, sp\n"
        "    movs    r2, #3\n"
        "    bl      Entity_UpdateHitboxSlots\n"
        "    ldr     r1, _sub_08000EB8_pool_off141_case0\n"
        "    add     r1, sp\n"
        "    movs    r0, #1\n"
        "    strb    r0, [r1, #0]\n"
        "    add     r0, sp, #320\n"
        "    strb    r4, [r0, #0]\n"
        "    b       _sub_08000EB8_tail\n"
        "_sub_08000EB8_pool_gGameStuff_case0: .4byte 0x03005330\n"
        "_sub_08000EB8_pool_off141_case0:    .4byte 0x00000141\n"
        "_sub_08000EB8_case1:\n"
        "    add     r4, sp, #320\n"
        "    ldr     r1, _sub_08000EB8_pool_callback_0d5d\n"
        "    adds    r0, r4, #0\n"
        "    bl      RunFadeTransition\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000EB8_case1_accept\n"
        "    b       _sub_08000EB8_tail_with_finalize\n"
        "_sub_08000EB8_case1_accept:\n"
        "    ldr     r1, _sub_08000EB8_pool_off141_case1\n"
        "    add     r1, sp\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r1, #0]\n"
        "    ldr     r1, _sub_08000EB8_pool_gGameStuff_case1\n"
        "    movs    r0, #0\n"
        "    str     r0, [r1, #20]\n"
        "    strb    r0, [r4, #0]\n"
        "    b       _sub_08000EB8_tail_with_finalize\n"
        "_sub_08000EB8_pool_callback_0d5d:    .4byte 0x08000D5D\n"
        "_sub_08000EB8_pool_off141_case1:    .4byte 0x00000141\n"
        "_sub_08000EB8_pool_gGameStuff_case1: .4byte 0x03005330\n"
        "_sub_08000EB8_case2:\n"
        "    add     r0, sp, #320\n"
        "    bl      Scene_InitScan\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000EB8_case2_accept\n"
        "    b       _sub_08000EB8_tail\n"
        "_sub_08000EB8_case2_accept:\n"
        "    ldr     r1, _sub_08000EB8_pool_off141_case2\n"
        "    add     r1, sp\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r1, #0]\n"
        "    ldr     r1, _sub_08000EB8_pool_gGameStuff_case2\n"
        "    movs    r0, #0\n"
        "    str     r0, [r1, #20]\n"
        "    b       _sub_08000EB8_tail\n"
        "_sub_08000EB8_pool_off141_case2:    .4byte 0x00000141\n"
        "_sub_08000EB8_pool_gGameStuff_case2: .4byte 0x03005330\n"
        "_sub_08000EB8_case3:\n"
        "    bl      Input_Poll\n"
        "    ldr     r1, _sub_08000EB8_pool_iwram5398_case3\n"
        "    strh    r0, [r1, #0]\n"
        "    lsls    r0, r0, #16\n"
        "    lsrs    r0, r0, #16\n"
        "    cmp     r0, #0x40\n"
        "    bne     _sub_08000EB8_case3_not40\n"
        "    ldr     r1, _sub_08000EB8_pool_off141_case3\n"
        "    add     r1, sp\n"
        "    movs    r0, #5\n"
        "    strb    r0, [r1, #0]\n"
        "    bl      Scene_LoadBg\n"
        "    b       _sub_08000EB8_tail\n"
        "    .hword  0\n"
        "_sub_08000EB8_pool_iwram5398_case3:  .4byte 0x03005398\n"
        "_sub_08000EB8_pool_off141_case3:    .4byte 0x00000141\n"
        "_sub_08000EB8_case3_not40:\n"
        "    ldr     r1, _sub_08000EB8_pool_iwram3720_case3\n"
        "    movs    r3, #8\n"
        "    movs    r2, #8\n"
        "    adds    r0, r2, #0\n"
        "    ldrh    r1, [r1, #0x34]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08000EB8_case3_not_held\n"
        "    ldr     r1, _sub_08000EB8_pool_off141_case3b\n"
        "    add     r1, sp\n"
        "    movs    r0, #4\n"
        "    strb    r0, [r1, #0]\n"
        "    b       _sub_08000EB8_tail\n"
        "    .hword  0\n"
        "_sub_08000EB8_pool_iwram3720_case3:  .4byte 0x03003720\n"
        "_sub_08000EB8_pool_off141_case3b:   .4byte 0x00000141\n"
        "_sub_08000EB8_case3_not_held:\n"
        "    ldr     r1, _sub_08000EB8_pool_iwram6110_case3\n"
        "    adds    r0, r2, #0\n"
        "    ldrh    r1, [r1, #0x2e]\n"
        "    ands    r0, r1\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08000EB8_case3_fallthrough\n"
        "    ldr     r0, _sub_08000EB8_pool_off141_case3c\n"
        "    add     r0, sp\n"
        "    strb    r3, [r0, #0]\n"
        "    b       _sub_08000EB8_tail\n"
        "_sub_08000EB8_pool_iwram6110_case3:  .4byte 0x03006110\n"
        "_sub_08000EB8_pool_off141_case3c:   .4byte 0x00000141\n"
        "_sub_08000EB8_case3_fallthrough:\n"
        "    add     r4, sp, #324\n"
        "    bl      Game_RunEntityFrame\n"
        "    bl      WaitVblank\n"
        "    bl      Game_ForceRender\n"
        "    bl      Entity_CheckAllCollisions\n"
        "    bl      Player_CheckTileEvents\n"
        "    mov     r0, sp\n"
        "    adds    r1, r4, #0\n"
        "    bl      Scene09_UpdatePlayerTile\n"
        "    ldr     r1, _sub_08000EB8_pool_gGameStuff_case3ft\n"
        "    ldr     r0, [r1, #20]\n"
        "    adds    r0, #1\n"
        "    str     r0, [r1, #20]\n"
        "    b       _sub_08000EB8_tail\n"
        "_sub_08000EB8_pool_gGameStuff_case3ft: .4byte 0x03005330\n"
        "_sub_08000EB8_case4:\n"
        "    ldr     r4, _sub_08000EB8_pool_off141_case4\n"
        "    add     r4, sp\n"
        "    add     r5, sp, #324\n"
        "    ldr     r0, _sub_08000EB8_pool_off141_case4\n"
        "    add     r0, sp\n"
        "    bl      Scene_EntityTick\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000EB8_case4_skip\n"
        "    movs    r0, #7\n"
        "    strb    r0, [r4, #0]\n"
        "_sub_08000EB8_case4_skip:\n"
        "    mov     r0, sp\n"
        "    adds    r1, r5, #0\n"
        "    movs    r2, #3\n"
        "    bl      Entity_UpdateHitboxSlots\n"
        "    add     r1, sp, #320\n"
        "    movs    r0, #0\n"
        "    strb    r0, [r1, #0]\n"
        "    b       _sub_08000EB8_tail\n"
        "_sub_08000EB8_pool_off141_case4:    .4byte 0x00000141\n"
        "_sub_08000EB8_case5:\n"
        "    bl      Input_Poll\n"
        "    ldr     r1, _sub_08000EB8_pool_iwram5398_case5\n"
        "    strh    r0, [r1, #0]\n"
        "    bl      Scene_FadeUpdate\n"
        "    lsls    r0, r0, #24\n"
        "    lsrs    r2, r0, #24\n"
        "    cmp     r2, #0\n"
        "    bne     _sub_08000EB8_case5_skip\n"
        "    ldr     r0, _sub_08000EB8_pool_off141_case5\n"
        "    add     r0, sp\n"
        "    movs    r1, #6\n"
        "    strb    r1, [r0, #0]\n"
        "    add     r0, sp, #320\n"
        "    strb    r2, [r0, #0]\n"
        "_sub_08000EB8_case5_skip:\n"
        "    ldr     r0, _sub_08000EB8_pool_iwram5328_case5\n"
        "    ldrb    r0, [r0, #0]\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000EB8_tail\n"
        "    ldr     r1, _sub_08000EB8_pool_off141_case5\n"
        "    add     r1, sp\n"
        "    movs    r0, #3\n"
        "    strb    r0, [r1, #0]\n"
        "    b       _sub_08000EB8_tail\n"
        "    .hword  0\n"
        "_sub_08000EB8_pool_iwram5398_case5:  .4byte 0x03005398\n"
        "_sub_08000EB8_pool_off141_case5:    .4byte 0x00000141\n"
        "_sub_08000EB8_pool_iwram5328_case5:  .4byte 0x03005328\n"
        "_sub_08000EB8_case6:\n"
        "    add     r4, sp, #320\n"
        "    movs    r0, #0\n"
        "    ldrsb   r0, [r4, r0]\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000EB8_case6_check\n"
        "    movs    r0, #0xBF\n"
        "    bl      Blend_StartFade\n"
        "    ldrb    r0, [r4, #0]\n"
        "    adds    r0, #1\n"
        "    strb    r0, [r4, #0]\n"
        "_sub_08000EB8_case6_check:\n"
        "    ldrb    r4, [r4, #0]\n"
        "    lsls    r4, r4, #24\n"
        "    asrs    r4, r4, #24\n"
        "    cmp     r4, #1\n"
        "    bne     _sub_08000EB8_tail\n"
        "    bl      Blend_StepFade\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    bne     _sub_08000EB8_tail\n"
        "    ldr     r0, _sub_08000EB8_pool_iwram3480_case6\n"
        "    movs    r1, #4\n"
        "    strb    r1, [r0, #0]\n"
        "    strb    r4, [r0, #6]\n"
        "    ldr     r0, _sub_08000EB8_pool_gGameStuff_case6\n"
        "    strb    r1, [r0, #9]\n"
        "    b       _sub_08000EB8_tail\n"
        "_sub_08000EB8_pool_iwram3480_case6:  .4byte 0x03003480\n"
        "_sub_08000EB8_pool_gGameStuff_case6: .4byte 0x03005330\n"
        "_sub_08000EB8_case7:\n"
        "    add     r4, sp, #320\n"
        "    ldr     r1, _sub_08000EB8_pool_callback_a26d\n"
        "    adds    r0, r4, #0\n"
        "    bl      RunFadeTransition\n"
        "    lsls    r0, r0, #24\n"
        "    cmp     r0, #0\n"
        "    beq     _sub_08000EB8_tail_with_finalize\n"
        "    ldr     r1, _sub_08000EB8_pool_off141_case7\n"
        "    add     r1, sp\n"
        "    movs    r0, #2\n"
        "    strb    r0, [r1, #0]\n"
        "    ldr     r1, _sub_08000EB8_pool_gGameStuff_case7\n"
        "    movs    r0, #0\n"
        "    str     r0, [r1, #20]\n"
        "    strb    r0, [r4, #0]\n"
        "    bl      EntityParam_Reset\n"
        "_sub_08000EB8_tail_with_finalize:\n"
        "    bl      WaitVblank\n"
        "    b       _sub_08000EB8_tail\n"
        "    .hword  0\n"
        "_sub_08000EB8_pool_callback_a26d:    .4byte 0x0800A26D\n"
        "_sub_08000EB8_pool_off141_case7:    .4byte 0x00000141\n"
        "_sub_08000EB8_pool_gGameStuff_case7: .4byte 0x03005330\n"
        "_sub_08000EB8_case8:\n"
        "    bl      Game_FrameEnd\n"
        "_sub_08000EB8_tail:\n"
        "    ldr     r0, _sub_08000EB8_pool_gGameStuff_tail\n"
        "    ldrb    r0, [r0, #9]\n"
        "    cmp     r0, #9\n"
        "    bne     _sub_08000EB8_tail_not9\n"
        "    b       _sub_08000EB8_loopHead\n"
        "_sub_08000EB8_tail_not9:\n"
        "    cmp     r0, #24\n"
        "    bne     _sub_08000EB8_epilogue\n"
        "    b       _sub_08000EB8_loopHead\n"
        "_sub_08000EB8_epilogue:\n"
        "    add     sp, #332\n"
        "    pop     {r4, r5}\n"
        "    pop     {r0}\n"
        "    bx      r0\n"
        "_sub_08000EB8_pool_gGameStuff_tail:  .4byte 0x03005330\n"
        "    .syntax divided\n");
}

#endif
