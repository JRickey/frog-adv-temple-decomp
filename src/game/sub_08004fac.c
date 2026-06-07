#include "game.h"
#include "gfx.h"
#include "entity.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

/* TODO: decomp */

/* --- SceneLoop_22: non-matching reference (NAKED .incbin below provides the matching bytes) --- */
#ifdef NON_MATCHING
#include "game.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void Sound_ServiceQueue(void);
extern u32 Scene_SelectEntityLimit(void);
extern u8 RunFadeTransition(u8 *localState, u32 callbackTable);
extern void RunWorldSelectTransition(u32 arg);
extern u32 Scene_InitScan(u8 *localState);
extern void CtrlFlags_SetBit(void *base, u32 selector, u32 bit);
extern u16 Input_Poll(void);
extern void Scene_LoadBg(void);
extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);
extern void SpawnCycle_Update(u8 *buf0, u32 *out0, u8 *buf1, u32 *out1);
extern void sub_0800BE18(u8 *slots, u32 *out, s8 type);
extern u8 Scene_FadeUpdate(void);
extern u8 Blend_StepFade(void);
extern void BgTilemap_LoadScene(void);
extern void Game_FrameEnd(void);

extern u16 gIwram_5398;
extern u8 gIwram_5328;

void SceneLoop_22(void)
{
    struct {
        u8 buf[0x300];
        s8 accept;
        u8 state;
        u8 pad[2];
        u32 out0[2];
        u32 out1[2];
    } frame;
    u32 handle;

    {
        u8 *statep;
        register u8 zero asm("r1");
        statep = &frame.state;
        zero = 0;
        *(volatile u8 *)statep = zero;
    }
    goto tail;

    do {
        Sound_ServiceQueue();
        switch (frame.state) {
        default:
            goto tail;
        case 0:
            gGameStuff.pendingMode = 15;
            handle = Scene_SelectEntityLimit();
            frame.state = 1;
            frame.accept = 0;
            break;
        case 1:
            if (RunFadeTransition((u8 *)&frame.accept, 0x080052CD) == 0)
                goto finalize;
            *(volatile u8 *)&frame.state = 2;
            gGameStuff._unk14 = 0;
            frame.accept = 0;
            goto finalize;
        case 2:
            RunWorldSelectTransition(15);
            EntityParam_Apply(handle);
            frame.state = 3;
            break;
        case 3:
            if (Scene_InitScan((u8 *)&frame.accept) == 0)
                goto tail;
            *(volatile u8 *)&frame.state = 4;
            gGameStuff._unk14 = 0;
            CtrlFlags_SetBit(&gIwram_6110, 3, 4);
            break;
        case 4: {
            gIwram_5398 = Input_Poll();
            if (gIwram_5398 == 0x40) {
                frame.state = 6;
                Scene_LoadBg();
                goto tail;
            }
            if ((gEntities[0].status & 8) != 0) {
                frame.state = 5;
                goto tail;
            }
            if ((gIwram_6110.inputFlags & 8) != 0) {
                frame.state = 9;
                goto tail;
            }
            {
                register u32 *p0 asm("r4") = frame.out0;
                register u32 *p1 asm("r5") = frame.out1;
                Game_RunEntityFrame();
                WaitVblank();
                Game_ForceRender();
                Entity_CheckAllCollisions();
                Player_CheckTileEvents();
                SpawnCycle_Update(frame.buf, p0, frame.buf + 0x180, p1);
            }
            gGameStuff._unk14++;
            break;
        }
        case 5: {
            register u8 *statep asm("r4") = &frame.state;
            register u32 *q0 asm("r5") = frame.out0;
            register u32 *q1 asm("r6") = frame.out1;
            register u8 *maskp asm("r4");
            u32 off = 0x180;
            if (Scene_EntityTick(&frame.state) == 0)
                *statep = 8;
            gIwram_6110.scenePhase = 0;
            gIwram_6110.byteFlags8 = 0;
            gIwram_6110.gateByte = 0;
            maskp = &gIwram_6110.spawnMask;
            if (*maskp == 1) {
                sub_0800BE18(frame.buf, q0, 29);
                sub_0800BE18(frame.buf + 0x180, q1, 30);
                if (*maskp == 1) {
                    sub_0800BE18(frame.buf, q0, 29);
                    asm("" : "+r"(off));
                    sub_0800BE18(frame.buf + off, q1, 30);
                }
            }
            frame.accept = 0;
            break;
        }
        case 6:
            gIwram_5398 = Input_Poll();
            if (Scene_FadeUpdate() == 0) {
                frame.state = 7;
                frame.accept = 0;
            }
            if (gIwram_5328 != 0)
                goto tail;
            frame.state = 4;
            break;
        case 7: {
            s32 counter;
            if ((s8)frame.accept == 0) {
                Blend_StartFade(0xBF);
                frame.accept += 1;
            }
            counter = (s8)frame.accept;
            if (counter != 1)
                goto tail;
            if (Blend_StepFade() != 0)
                goto tail;
            gIwram_3480._data[0] = 4;
            gIwram_3480._data[6] = counter;
            gGameStuff.mode = GAME_MODE_ROUTER;
            break;
        }
        case 8:
            if (RunFadeTransition((u8 *)&frame.accept, 0x0800A26D) == 0)
                goto finalize;
            *(volatile u8 *)&frame.state = 3;
            gGameStuff._unk14 = 0;
            frame.accept = 0;
            EntityParam_Apply(handle);
        finalize:
            WaitVblank();
            break;
        case 9:
            gEntities[22].status |= 8;
            BgTilemap_LoadScene();
            Game_FrameEnd();
            break;
        }

    tail:;
    } while (gGameStuff.mode == GAME_MODE_SCENE_22);
}
#else
NAKED void SceneLoop_22(void)
{
    asm(".incbin \"frog_us_baserom.gba\", 0x4fac, 0x314\n");
}
#endif /* NON_MATCHING */
