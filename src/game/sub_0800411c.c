#include "game.h"
#include "gfx.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* TODO: decomp */

/* --- SceneLoop_20: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "types.h"

extern void Sound_ServiceQueue(void);
extern void EntityScript_BuildSlotData(u32 partId, u8 *out);
extern void LoadPartEntry(u8 partId, u8 *out, u8 tag);
extern void Entity_UpdateHitboxSlots(u32 a, u32 b, u8 c);
extern u8 RunFadeTransition(u8 *localState, u32 callbackTable);
extern u32 Scene_InitScan(u8 *localState);
extern u16 Input_Poll(void);
extern void Scene_LoadBg(void);
extern void Entity_RunScript(u32 a, u32 b);
extern void EntityScript_Advance(u32 a, u32 b, u32 c);
extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern void Scene20_UpdateParts(u32 a, u32 b, u32 c, u32 d);
extern u8 Scene_FadeUpdate(void);
extern u8 Blend_StepFade(void);
extern void EntityParam_Reset(void);
extern void Game_FrameEnd(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

#define STATE (*(volatile u8 *)&ctrl[1])

void SceneLoop_20(void)
{
    u8 buf0[612];
    u8 buf1[72];
    u8 buf2[108];
    u8 buf3[32];
    u8 buf4[128];
    u8 ctrl[4];
    u8 pair11[8];
    u8 pair16[8];

    STATE = 0;
    goto tail;

loop:
    Sound_ServiceQueue();

    switch (STATE) {
    default:
        goto tail;
    case 0: {
        u8 *p11 = pair11;
        u8 *p16 = pair16;
        gGameStuff.pendingMode = 13;
        EntityScript_BuildSlotData(2, buf0);
        LoadPartEntry(3, buf1, 2);
        LoadPartEntry(4, buf2, 2);
        Entity_UpdateHitboxSlots((u32)buf3, (u32)p11, 11);
        Entity_UpdateHitboxSlots((u32)buf4, (u32)p16, 16);
        STATE = 1;
        ctrl[0] = 0;
        break;
    }
    case 1:
        if (RunFadeTransition(&ctrl[0], 0x08004471) == 0)
            goto finalize;
        STATE = 2;
        gGameStuff._unk14 = 0;
        ctrl[0] = 0;
        goto finalize;
    case 2:
        if (Scene_InitScan(&ctrl[0]) == 0)
            goto tail;
        STATE = 3;
        gGameStuff._unk14 = 0;
        break;
    case 3: {
        register u32 nextState asm("r3");
        struct Entity *p3720;
        gIwram_5398 = Input_Poll();
        if (gIwram_5398 == 0x40) {
            STATE = 5;
            Scene_LoadBg();
            goto tail;
        }
        p3720 = gEntities;
        nextState = 8;
        if ((p3720->status & 8) != 0) {
            STATE = 4;
            goto tail;
        }
        if ((gIwram_6110.inputFlags & 8) != 0) {
            STATE = nextState;
            goto tail;
        }
        {
            u8 *p11 = pair11;
            u8 *p16 = pair16;
            Entity_RunScript(2, (u32)buf0);
            EntityScript_Advance(0, 3, (u32)buf1);
            EntityScript_Advance(1, 4, (u32)buf2);
            Game_RunEntityFrame();
            WaitVblank();
            Game_ForceRender();
            Entity_CheckAllCollisions();
            Player_CheckTileEvents();
            Scene20_UpdateParts((u32)buf3, (u32)p11, (u32)buf4, (u32)p16);
            gGameStuff._unk14++;
        }
        break;
    }
    case 4: {
        u8 *statep = &ctrl[1];
        u8 *p11 = pair11;
        u8 *p16 = pair16;
        if ((s8)gIwram_35E0._field_5 <= 1)
            gIwram_6110.scenePhase = 0;
        else
            gIwram_6110.scenePhase = 1;
        if (Scene_EntityTick(statep) == 0)
            *statep = 7;
        Entity_UpdateHitboxSlots((u32)buf3, (u32)p11, 11);
        Entity_UpdateHitboxSlots((u32)buf4, (u32)p16, 16);
        ctrl[0] = 0;
        break;
    }
    case 5:
        gIwram_5398 = Input_Poll();
        if (Scene_FadeUpdate() == 0) {
            STATE = 6;
            ctrl[0] = 0;
        }
        if (gIwram_5328 == 0)
            STATE = 3;
        break;
    case 6: {
        s32 counter;
        if ((s8)ctrl[0] == 0) {
            Blend_StartFade(0xBF);
            ctrl[0] = ctrl[0] + 1;
        }
        counter = (s8)ctrl[0];
        if (counter != 1)
            goto tail;
        if (Blend_StepFade() != 0)
            goto tail;
        gIwram_3480._data[0] = 4;
        gIwram_3480._data[6] = counter;
        gGameStuff.mode = GAME_MODE_ROUTER;
        break;
    }
    case 7:
        if (RunFadeTransition(&ctrl[0], 0x0800A26D) != 0) {
            STATE = 2;
            gGameStuff._unk14 = 0;
            ctrl[0] = 0;
            EntityParam_Reset();
        }
    finalize:
        WaitVblank();
        break;
    case 8:
        Game_FrameEnd();
        break;
    }

tail:
    if (gGameStuff.mode == GAME_MODE_SCENE_20 || gGameStuff.mode == GAME_MODE_ATTRACT)
        goto loop;
}
#else
NAKED void SceneLoop_20(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x411c, 0x300\n");
}
#endif /* NON_MATCHING */
