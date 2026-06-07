#include "game.h"
#include "gfx.h"
#include "sound.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* SceneLoop_17 — per-frame handler for game-mode 17 (re-entered for mode 24).
 * Same family as Scene15_Main (mode 15): an on-stack sub-state machine that
 * loops while gGameStuff.mode stays at 17 or 24, dispatching each tick through
 * a 9-entry computed-jump table after a per-frame Sound_ServiceQueue() tick.
 *
 * Three stack cells drive it: a dispatch sub-state byte, a 0x87-seeded
 * halfword, and a signed counter byte. The 72-byte head of the frame is the
 * scratch buffer handed to EntityScript_BuildSlotData on entry.
 *
 * Built with old_agbcc (see Makefile): the newer agbcc schedules the case-3
 * `ldrh` flag reads ahead of the shared `8`-constant materialisation, while
 * the baserom (and old_agbcc) defer them. The case-3 local base pointers keep
 * each flag read in the expected block, and the case-6 split `c0`/`c` locals
 * keep the two signed counter probes distinct.
 */

extern void Sound_ServiceQueue(void);
extern void EntityScript_BuildSlotData(u32 arg, void *buf);
extern u8 RunFadeTransition(u8 *state, u32 callbackTable);
extern u32 Scene_InitScan(u8 *state);
extern u16 Input_Poll(void);
extern u16 PollKeys_DPad(void);
extern void Scene_LoadBg(void);
extern void GameMode_SceneTick(void *arg, void *buf);
extern u8 Scene_FadeUpdate(void);
extern u8 Blend_StepFade(void);
extern void EntityParam_Reset(void);
extern void WaitVblank(void);
extern void Game_FrameEnd(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

void SceneLoop_17(void)
{
    u8 buf[72];
    u8 counter;
    u16 hw;
    u8 state;

    state = 0;
    hw = 0x87;

    while (gGameStuff.mode == GAME_MODE_SCENE_17 || gGameStuff.mode == GAME_MODE_ATTRACT) {
        Sound_ServiceQueue();
        if (state > 8)
            continue;

        switch (state) {
        case 0:
            gGameStuff.sceneType = 10;
            EntityScript_BuildSlotData(6, buf);
            state = 1;
            counter = 0;
            break;
        case 1:
            if (RunFadeTransition(&counter, 0x0800359D) == 0)
                goto finalize;
            state = 2;
            gGameStuff._unk14 = 0;
            counter = 0;
            goto finalize;
        case 2:
            if (Scene_InitScan(&counter) == 0)
                break;
            state = 3;
            gGameStuff._unk14 = 0;
            break;
        case 3:
            if (gIwram_6110.scenePhase == 0)
                gIwram_5398 = Input_Poll();
            else
                gIwram_5398 = PollKeys_DPad();
            if (gIwram_5398 == 0x40) {
                state = 5;
                Scene_LoadBg();
                break;
            }
            {
                struct Entity *p3720 = gEntities;
                if ((p3720->status & 8) != 0) {
                    state = 4;
                    break;
                }
            }
            {
                struct IwramAt6110 *p6110 = &gIwram_6110;
                if ((p6110->inputFlags & 8) != 0) {
                    state = 8;
                    break;
                }
            }
            GameMode_SceneTick(&hw, buf);
            break;
        case 4:
            if (Scene_EntityTick(&state) == 0)
                state = 7;
            gIwram_6110.scenePhase = 0;
            hw = 0x87;
            counter = 0;
            break;
        case 5:
            gIwram_5398 = Input_Poll();
            if (Scene_FadeUpdate() == 0) {
                state = 6;
                counter = 0;
            }
            if (gIwram_5328 == 0)
                state = 3;
            break;
        case 6: {
            s32 c0;
            s32 c;
            c0 = (s8)counter;
            if (c0 != 0)
                goto state6_check;
            Blend_StartFade(0xBF);
            counter++;
        state6_check:
            c = (s8)counter;
            if (c != 1)
                break;
            if (Blend_StepFade() != 0)
                break;
            gIwram_3480._data[0] = 4;
            gIwram_3480._data[6] = c;
            gGameStuff.mode = GAME_MODE_ROUTER;
            break;
        }
        case 7:
            if (RunFadeTransition(&counter, 0x0800A26D) != 0) {
                state = 2;
                gGameStuff._unk14 = 0;
                counter = 0;
                EntityParam_Reset();
            }
            /* fall through */
        finalize:
            WaitVblank();
            break;
        case 8:
            Game_FrameEnd();
            break;
        }
    }
}

void Scene17_LoadPart(void *buf)
{
    gGameStuff.sceneType = 10;
    EntityScript_BuildSlotData(6, buf);
}

extern void EntityDispatch_RunFrame(void);

/* Sibling of Scene06_Init/Scene_Init_04. Installs config table 0x082f9aec into
 * the gGameStuff_6110 cluster via the shared 6-arg setup helper, then primes
 * the post-setup state (SpriteAsset_LoadSheet(0xb, 0); EntityDispatch_RunFrame()). */
void Scene17_ModeControlInit(void)
{
    ModeControl_Init(&gIwram_6110, 0x80, 0xb, (const void *)0x082f9aec, 1, 3);
    SpriteAsset_LoadSheet(0xb, 0);
    EntityDispatch_RunFrame();
}

void Scene17_PauseCheck(u8 *state, u16 *hw)
{
    if (Scene_EntityTick(state) == 0)
        *state = 7;
    gIwram_6110.scenePhase = 0;
    *hw = 0x87;
}

void sub_080035F8(void)
{
    Game_FrameEnd();
}

extern u32 Tilemap_GetTileClass(u8 col, u8 row, s16 tileX, s16 tileY);

void Scene17_TileCheck(void)
{
    struct IwramAt35E0 *p;
    u8 tile;

    if ((gEntities[0].status & 4) != 0)
        return;

    if (gIwram_6110.scenePhase != 2)
        return;

    p = &gIwram_35E0;
    tile = (u8)Tilemap_GetTileClass(p->_field_18, p->_field_19, p->_field_8, p->_field_A);

    if ((gGameStuff._unk10 & 1) != 0)
        return;

    if (tile != 2)
        return;

    PlayerFlags_Set(p, 0x400);
    Sound_Play(0x5d);
}
