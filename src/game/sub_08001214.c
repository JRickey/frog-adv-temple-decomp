#include "game.h"
#include "gfx.h"
#include "entity.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void Sound_ServiceQueue(void);
extern u32 Scene_SelectEntityLimit(void);
extern u8 RunFadeTransition(u8 *flag, u32 callbackTable);
extern void RunWorldSelectTransition(u32 arg);
extern u32 Scene_InitScan(u8 *flag);
extern u16 Input_Poll(void);
extern void Scene_LoadBg(void);
extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern void Entity_UpdateHudState(void);
extern u8 Scene_FadeUpdate(void);
extern u8 Blend_StepFade(void);
extern void BgMap_WriteTileAttr(u8 col, u8 row, u32 a, u32 b, u32 c);
extern void Game_FrameEnd(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

void Scene10_Main(void)
{
    s8 spByte4;
    u8 substate;
    u32 r7;

    substate = 0;

    if (gGameStuff.mode != GAME_MODE_SCENE_10)
        return;

    do {
        Sound_ServiceQueue();
        if (substate > 9)
            goto tail;

        switch (substate) {
        case 0:
            gGameStuff.sceneType = 3;
            r7 = Scene_SelectEntityLimit();
            substate = 1;
            spByte4 = 0;
            break;
        case 1:
            if (RunFadeTransition((u8 *)&spByte4, 0x08001485) == 0)
                goto finalize;
            substate = 2;
            gGameStuff._unk14 = 0;
            spByte4 = 0;
            goto finalize;
        case 2:
            RunWorldSelectTransition(3);
            EntityParam_Apply(r7);
            substate = 3;
            break;
        case 3:
            if (Scene_InitScan((u8 *)&spByte4) == 0)
                goto tail;
            substate = 4;
            gGameStuff._unk14 = 0;
            CtrlFlags_SetBit(&gIwram_6110, 8, 1);
            goto tail;
        case 4:
            gIwram_5398 = Input_Poll();
            if (gIwram_5398 == 0x40) {
                substate = 6;
                Scene_LoadBg();
                goto tail;
            }
            if ((gEntities[0].status & 8) != 0) {
                substate = 5;
                goto tail;
            }
            if ((gIwram_6110.inputFlags & 8) != 0) {
                substate = 9;
                goto tail;
            }
            Game_RunEntityFrame();
            WaitVblank();
            Game_ForceRender();
            Entity_CheckAllCollisions();
            Player_CheckTileEvents();
            Entity_UpdateHudState();
            gGameStuff._unk14++;
            goto tail;
        case 5:
            if (Scene_EntityTick(&substate) == 0)
                substate = 8;
            spByte4 = 0;
            break;
        case 6:
            gIwram_5398 = Input_Poll();
            if (Scene_FadeUpdate() == 0) {
                substate = 7;
                spByte4 = 0;
            }
            if (gIwram_5328 == 0)
                substate = 4;
            break;
        case 7: {
            s32 counter;
            if ((s8)spByte4 == 0) {
                Blend_StartFade(0xBF);
                spByte4 += 1;
            }
            counter = (s8)spByte4;
            if (counter != 1)
                goto tail;
            if (Blend_StepFade() != 0)
                goto tail;
            gIwram_3480.subState = 4;
            gIwram_3480.reloadFlag = counter;
            gGameStuff.mode = GAME_MODE_ROUTER;
            break;
        }
        case 8:
            if (RunFadeTransition((u8 *)&spByte4, 0x0800a26d) != 0) {
                substate = 3;
                gGameStuff._unk14 = 0;
                spByte4 = 0;
                EntityParam_Apply(r7);
            }
        finalize:
            WaitVblank();
            goto tail;
        case 9:
            BgMap_WriteTileAttr(gIwram_35E0._field_18, gIwram_35E0._field_19, 6, 11, 15);
            BgMap_WriteTileAttr(gIwram_35E0._field_18, gIwram_35E0._field_19, 6, 10, 15);
            BgMap_WriteTileAttr(gIwram_35E0._field_18, gIwram_35E0._field_19, 7, 11, 7);
            Game_FrameEnd();
            break;
        }

    tail:;
    } while (gGameStuff.mode == GAME_MODE_SCENE_10);
}
