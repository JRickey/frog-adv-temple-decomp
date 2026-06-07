#include "game.h"
#include "gfx.h"
#include "entity.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void Sound_ServiceQueue(void);
extern u32 Scene_SelectEntityLimit(void);
extern u8 RunFadeTransition(u8 *secondary, u32 callbackTable);
extern void RunWorldSelectTransition(u32 arg);
extern u32 Scene_InitScan(u8 *secondary);
extern u16 Input_Poll(void);
extern void Scene_LoadBg(void);
extern u8 ModeControl_GetFlag(void *base, u32 selector, u32 bit);
extern void ModeControl_ClearBit(void *base, u32 selector, u32 bit);
extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern u32 Tilemap_GetTileClass(u8 col, u8 row, s32 tileX, s32 tileY);
extern void TileArrival_UpdateModeFlags(u8 arg);
extern void Scene_EnterLevel(void);
extern void Entity_InitShadow(void);
extern u8 Scene_FadeUpdate(void);
extern u8 Blend_StepFade(void);
extern void Game_FrameEnd(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

void SceneLoop_16(void)
{
    s8 secondary;
    u8 state;
    u32 r6;

    state = 0;
    if (gGameStuff.mode != GAME_MODE_SCENE_16)
        return;

    do {
        Sound_ServiceQueue();
        if (state > 11)
            goto tail;

        switch (state) {
        case 0:
            gGameStuff.pendingMode = 9;
            r6 = Scene_SelectEntityLimit();
            state = 1;
            secondary = 0;
            goto tail;
        case 1:
            if (RunFadeTransition((u8 *)&secondary, 0x08002E11) == 0)
                goto cleanup;
            state = 2;
            gGameStuff._unk14 = 0;
            secondary = 0;
            goto cleanup;
        case 2:
            RunWorldSelectTransition(9);
            EntityParam_Apply(r6);
            state = 3;
            goto tail;
        case 3:
            if (Scene_InitScan((u8 *)&secondary) == 0)
                goto tail;
            state = 4;
            gGameStuff._unk14 = 0;
            secondary = 0;
            goto tail;
        case 4:
            gIwram_5398 = Input_Poll();
            if (gIwram_5398 == 0x40) {
                state = 7;
                Scene_LoadBg();
                goto tail;
            }
            if ((gEntities[0].status & 8) != 0) {
                state = 5;
                goto tail;
            }
            if (ModeControl_GetFlag(&gIwram_6110, 8, 0) != 0) {
                state = 10;
                goto tail;
            }
            if (ModeControl_GetFlag(&gIwram_6110, 8, 1) != 0) {
                ModeControl_ClearBit(&gIwram_6110, 8, 1);
                state = 6;
                goto tail;
            }
            Game_RunEntityFrame();
            WaitVblank();
            Game_ForceRender();
            Entity_CheckAllCollisions();
            Player_CheckTileEvents();
            if ((gIwram_35E0._field_10 & 0x10) != 0) {
                TileArrival_UpdateModeFlags((u8)Tilemap_GetTileClass(gIwram_35E0._field_18, gIwram_35E0._field_19,
                                                                     gIwram_35E0._field_8, gIwram_35E0._field_A));
            }
            gGameStuff._unk14++;
            goto tail;
        case 5:
            if (Scene_EntityTick(&state) == 0)
                state = 9;
            secondary = 0;
            goto tail;
        case 6:
            Scene_EnterLevel();
            gEntities[1].status |= 8;
            Entity_InitShadow();
            state = 4;
            gGameStuff._unk14 = 0;
            goto tail;
        case 7:
            gIwram_5398 = Input_Poll();
            if (Scene_FadeUpdate() == 0) {
                state = 8;
                secondary = 0;
            }
            if (gIwram_5328 == 0)
                state = 4;
            goto tail;
        case 8: {
            s32 counter;
            if (secondary == 0) {
                Blend_StartFade(0xBF);
                secondary++;
            }
            counter = secondary;
            if (counter != 1)
                goto tail;
            if (Blend_StepFade() != 0)
                goto tail;
            gIwram_3480._data[0] = 4;
            gIwram_3480._data[6] = counter;
            gGameStuff.mode = GAME_MODE_ROUTER;
            goto tail;
        }
        case 9:
            if (RunFadeTransition((u8 *)&secondary, 0x0800A26D) != 0) {
                state = 3;
                gGameStuff._unk14 = 0;
                secondary = 0;
                EntityParam_Apply(r6);
            }
            /* fall through */
        cleanup:
            WaitVblank();
            goto tail;
        case 10:
            state = 11;
            goto tail;
        case 11:
            Game_FrameEnd();
            goto tail;
        }

    tail:;
    } while (gGameStuff.mode == GAME_MODE_SCENE_16);
}
