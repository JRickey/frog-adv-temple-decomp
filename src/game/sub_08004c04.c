#include "entity.h"
#include "game.h"
#include "gfx.h"
#include "sound.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"

extern void EntityScript_BuildSlotData(u8 partId, u8 *out);
extern void Game_FrameEnd(void);

void Mode14_Setup(u8 *buf, u32 arg1, u32 arg2)
{
    gGameStuff.sceneType = 14;
    EntityScript_BuildSlotData(5, buf);
    Entity_UpdateHitboxSlots((void *)arg1, (void *)arg2, 17);
}

extern void EntityDispatch_RunFrame(void);

void Mode15_Setup(void)
{
    ModeControl_Init(&gIwram_6110, 0x80, 0xf, (const void *)0x082f9bd0, 1, 5);
    SpriteAsset_LoadSheet(0xf, 0);
    EntityDispatch_RunFrame();
}

extern void Game_RunEntityFrame(void);
extern void WaitVblank(void);
extern void Game_ForceRender(void);
extern void Entity_CheckAllCollisions(void);
extern void Player_CheckTileEvents(void);

void Mode17_RunFrame(u32 a, u32 b, u32 c)
{
    Entity_RunScript(5, (void *)a);
    Game_RunEntityFrame();
    WaitVblank();
    Game_ForceRender();
    Entity_CheckAllCollisions();
    Player_CheckTileEvents();
    Player_HandleTileTransitions((void *)b, (void *)c);
    gGameStuff._unk14++;
}

void Mode_InitEntityState(u8 *state, u32 arg1, u32 arg2)
{
    u8 *base;

    if (gIwram_35E0._field_5 <= 2) {
        base = (u8 *)&gIwram_6110;
        ModeControl_ClearBit(base, 3, 0);
        ModeControl_ClearBit(base, 3, 1);
    } else {
        CtrlFlags_SetBit((u8 *)&gIwram_6110, 3, 1);
    }

    if (Scene_EntityTick(state) == 0)
        state[0] = 7;

    Entity_UpdateHitboxSlots((void *)arg1, (void *)arg2, 17);
}

void Mode_EndScene(void)
{
    Game_FrameEnd();
}

extern u32 ModeControl_GetFlag(u8 *base, u32 selector, u32 bit);
extern void sub_0800BE18(u8 *slots, u32 *out, s8 type);
extern void sub_0800BF24(u8 *slots, u32 *out, s8 type);
extern void sub_0800BEBC(u8 *slots, u32 *out, s8 type, u8 tile);
extern void BgMap_WriteTileAttr(u8 col, u8 row, u32 a, u32 b, u32 c);
extern u8 Tilemap_GetTileClass(u8 col, u8 row, s16 tileX, s16 tileY);
extern void BgTilemap_DmaVariantA(void);
extern void BgTilemap_DmaVariantB(void);
extern void AnimChannels_Reset(void);
extern void StatusBar_Update(void);

void SpawnCycle_Update(u8 *arg0, u32 *arg1, u8 *arg2, u32 *arg3)
{
    if ((u8)ModeControl_GetFlag((u8 *)&gIwram_6110, 3, 3)) {
        u8 *base3720 = (u8 *)gEntities;
        u32 off = 0xaf2;
        *(u16 *)(base3720 + off) = 0;
        CtrlFlags_SetBit((u8 *)&gIwram_6110, 3, 4);
        ModeControl_ClearBit((u8 *)&gIwram_6110, 3, 3);
    }

    if ((u8)ModeControl_GetFlag((u8 *)&gIwram_6110, 3, 4)) {
        CtrlFlags_SetBit((u8 *)&gIwram_6110, 3, 5);
        CtrlFlags_SetBit((u8 *)&gIwram_6110, 3, 0);
        ModeControl_ClearBit((u8 *)&gIwram_6110, 3, 6);

        if (gIwram_6110.spawnMask == 1) {
            BgTilemap_DmaVariantA();
            sub_0800BE18(arg0, arg1, 29);
            sub_0800BE18(arg2, arg3, 30);
        }

        gIwram_6110.byteFlags8 = 0;
        gIwram_6110.gateByte = 0;
        ModeControl_ClearBit((u8 *)&gIwram_6110, 3, 4);
    }

    if (gIwram_35E0._data[4] == 5) {
        u32 mask = gIwram_6110.spawnMask + 1;
        gIwram_6110.spawnMask = mask;
        gIwram_6110.flags0 = 0;
        gIwram_35E0._data[4] = 0;
        gIwram_6110.byteFlags8 = 0;
        gIwram_6110.gateByte = 0;

        if ((u8)mask == 4) {
            BgMap_WriteTileAttr(gIwram_35E0._field_18, gIwram_35E0._field_19, 7, 4, 15);
            BgMap_WriteTileAttr(gIwram_35E0._field_18, gIwram_35E0._field_19, 6, 4, 15);
            gIwram_6110.inputFlags |= 8;
            ModeControl_ClearBit((u8 *)&gIwram_6110, 3, 7);
            return;
        }

        ModeControl_ClearBit((u8 *)&gIwram_6110, 3, 7);

        if (gIwram_6110.spawnMask == 1) {
            sub_0800BE18(arg0, arg1, 29);
            sub_0800BE18(arg2, arg3, 30);
        }

        if (gIwram_6110.spawnMask == 2) {
            sub_0800BE18(arg0, arg1, 29);
            sub_0800BE18(arg2, arg3, 30);
            BgTilemap_DmaVariantB();
        }

        AnimChannels_Reset();
        Sound_Play(28);

        {
            u8 *base3720 = (u8 *)gEntities;
            u32 off = 0xb10;
            /* Pinning the OR mask to r3 makes agbcc materialize `movs r3, #8`
               in the loop preheader before the induction-variable setup,
               matching the baserom's `movs r3,#8; adds r2,#0xdc; movs r1,#15`
               order (a plain literal puts the movs after the IV inits). */
            register u32 bit asm("r3");
            s32 i;
            u16 *p;

            *(u32 *)(base3720 + off) = gGameStuff._unk00;

            bit = 8;
            p = (u16 *)(base3720 + 0xdc);
            for (i = 15; i >= 0; i--) {
                *p |= bit;
                p = (u16 *)((u8 *)p + 0x38);
            }
        }

        StatusBar_Update();
        CtrlFlags_SetBit((u8 *)&gIwram_6110, 3, 8);
    }

    if ((u8)ModeControl_GetFlag((u8 *)&gIwram_6110, 3, 9)) {
        u32 *g = &gGameStuff._unk00;
        u8 *base3720 = (u8 *)gEntities;
        u32 off = 0xb48;
        if (*g - *(u32 *)(base3720 + off) > 120) {
            CtrlFlags_SetBit((u8 *)&gIwram_6110, 3, 0);
            CtrlFlags_SetBit((u8 *)&gIwram_6110, 3, 5);
            gIwram_6110.gateByte = 0;
            ModeControl_ClearBit((u8 *)&gIwram_6110, 3, 9);
        }
    }

    if (gIwram_6110.spawnMask == 1) {
        /* short-circuit || — the baserom skips the second probe when the
           first is set, so the calls must stay inside the condition */
        if ((u8)ModeControl_GetFlag((u8 *)&gIwram_6110, 3, 0) || (u8)ModeControl_GetFlag((u8 *)&gIwram_6110, 3, 7)) {
            sub_0800BF24(arg0, arg1, 29);
            sub_0800BF24(arg2, arg3, 30);
        }
    }

    if ((gIwram_35E0._field_10 & 0x10) == 0)
        return;
    if (gIwram_6110.spawnMask != 1)
        return;
    if ((u8)ModeControl_GetFlag((u8 *)&gIwram_6110, 3, 0) == 0)
        return;

    {
        u8 tile = (u8)Tilemap_GetTileClass(gIwram_35E0._field_18, gIwram_35E0._field_19, gIwram_35E0._field_8,
                                           gIwram_35E0._field_A);
        sub_0800BEBC(arg0, arg1, 29, tile);
        sub_0800BEBC(arg2, arg3, 30, tile);
    }
}
