#include "game.h"
#include "gfx.h"
#include "iwram.h"
#include "types.h"

extern void Sound_ServiceQueue(void);
extern void Scene08_StartIntro(u32 a, u32 b);
extern u8 RunFadeTransition(u8 *localState, u32 callbackTable);
extern u32 Scene_InitScan(u8 *localState);
extern u16 Input_Poll(void);
extern void Scene_LoadBg(void);
extern void EntityRec_ClearKeyFlags(u8 *rec, u16 mask);
extern u8 Player_CheckSpecialTileMatch(void);
extern void Scene08_MapScreenInit(u8 arg);
extern void Scene08_PlayFrameTick(u32 a, u32 b);
extern void Scene_DisableBg2(void);
extern void Mode8_StateStep(u8 *state, u32 a, u32 b);
extern u8 Scene_FadeUpdate(void);
extern u8 Blend_StepFade(void);
extern void EntityParam_Reset(void);
extern void WaitVblank(void);
extern void Mode8_Teardown(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

/* Scene08_Main — per-frame handler for game-mode 8 (and re-entered for mode 24,
 * the attract demo). Sibling of Scene15_Main (mode_15.c) / Scene12_Main
 * (sub_080019b4.c): a sub-state machine that loops while gGameStuff.mode stays
 * at 8 or 24, dispatching on a 1-byte sub-state through a 14-entry jump table. */
void Scene08_Main(void)
{
    struct {
        u8 buf[0x28];
        s8 spByte;
        u8 state;
        u8 pad[2];
        u8 obj[8];
    } frame;
    register u8 *statep asm("r6");
    u32 mode;
    register u8 *statepInit asm("r0");

    /* The sub-state pointer is held in a callee-saved register across the whole
     * loop because &frame.state lands at a non-word-aligned sp offset (0x29) that
     * is expensive to recompute. Building the address in statepInit (r0) for the
     * init store and copying it into the long-lived statep (r6) reproduces the
     * baserom's "compute in r0, adds r6, r0, #0" prologue; the volatile store
     * keeps the zero-init from being folded to a direct sp-relative store.
     * (Same idiom as the matched siblings Scene15_Main / Scene12_Main.) */
    {
        u8 zero;
        statepInit = &frame.state;
        zero = 0;
        *(volatile u8 *)statepInit = zero;
    }
    mode = gGameStuff.mode;
    statep = statepInit;
    if (mode == GAME_MODE_SCENE_08)
        goto loop;
    if (mode == GAME_MODE_ATTRACT)
        goto loop;
    goto epilogue;

loop:
    Sound_ServiceQueue();

    switch (*statep) {
    default:
        goto tail;
    case 0:
        Scene08_StartIntro((u32)frame.buf, (u32)frame.obj);
        *statep = 1;
        frame.spByte = 0;
        break;
    case 1:
        if (RunFadeTransition((u8 *)&frame.spByte, 0x08000CB1) == 0)
            goto finalize;
        *statep = 2;
        gGameStuff._unk14 = 0;
        frame.spByte = 0;
        goto finalize;
    case 2:
        if (Scene_InitScan((u8 *)&frame.spByte) == 0)
            goto tail;
        *statep = 3;
        gGameStuff._unk14 = 0;
        goto tail;
    case 3:
        gIwram_5398 = Input_Poll();
        if (gIwram_5398 == 0x40) {
            *statep = 6;
            Scene_LoadBg();
            goto tail;
        }
        if ((gEntities[0].status & 8) != 0) {
            *statep = 4;
            goto tail;
        }
        if ((gIwram_6110.inputFlags & 2) != 0) {
            EntityRec_ClearKeyFlags((u8 *)&gIwram_6110, 2);
            Scene08_MapScreenInit((u8)(Player_CheckSpecialTileMatch() - 1));
            *statep = 5;
            goto tail;
        }
        if ((gIwram_6110.inputFlags & 8) != 0) {
            EntityRec_ClearKeyFlags((u8 *)&gIwram_6110, 8);
            *statep = 13;
            goto tail;
        }
        Scene08_PlayFrameTick((u32)frame.buf, (u32)frame.obj);
        goto tail;
    case 4:
        Scene_DisableBg2();
        Mode8_StateStep(statep, (u32)frame.buf, (u32)frame.obj);
        /* volatile so this store is exempt from cross-jumping: case 0 ends with
         * the identical "spByte = 0; goto tail" tail, and -O2 would otherwise
         * tail-merge the two. The baserom keeps both inline. */
        *(volatile u8 *)&frame.spByte = 0;
        break;
    case 5:
        gIwram_5398 = Input_Poll();
        if (Scene08_MapScreenTick() != 0)
            goto tail;
        *statep = 3;
        EntityRec_ClearKeyFlags((u8 *)&gIwram_6110, 2);
        goto tail;
    case 6: {
        u8 fade;
        gIwram_5398 = Input_Poll();
        fade = Scene_FadeUpdate();
        if (fade == 0) {
            Scene_DisableBg2();
            *statep = 7;
            frame.spByte = fade;
        }
        if (gIwram_5328 != 0)
            goto tail;
        *statep = 3;
        goto tail;
    }
    case 7: {
        s32 counter;
        if ((s8)frame.spByte == 0) {
            Blend_StartFade(0xBF);
            frame.spByte += 1;
        }
        counter = (s8)frame.spByte;
        if (counter != 1)
            goto tail;
        if (Blend_StepFade() != 0)
            goto tail;
        gIwram_3480.subState = 4;
        gIwram_3480.reloadFlag = counter;
        gGameStuff.mode = GAME_MODE_ROUTER;
        goto tail;
    }
    case 8:
        if (RunFadeTransition((u8 *)&frame.spByte, 0x0800A26D) != 0) {
            *statep = 2;
            gGameStuff._unk14 = 0;
            EntityParam_Reset();
            frame.spByte = 0;
        }
    finalize:
        WaitVblank();
        break;
    case 13:
        Mode8_Teardown();
        break;
    }

tail:
    if (gGameStuff.mode == GAME_MODE_SCENE_08 || gGameStuff.mode == GAME_MODE_ATTRACT)
        goto loop;
epilogue:;
}
