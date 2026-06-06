#include "game.h"
#include "iwram.h"
#include "types.h"

extern u32 ModeControl_GetFlag(u8 *base, u32 selector, u32 bit);
extern u32 Anim_CheckScreenIdle(void);
extern void CtrlFlags_SetBit(u8 *base, u32 selector, u32 bit);
extern void ModeControl_ClearBit(u8 *base, u32 selector, u32 bit);

void Gate_TryUnlock(void)
{
    u8 *base6110 = (u8 *)&gIwram_6110;

    if ((u8)ModeControl_GetFlag(base6110, 3, 8) == 0)
        return;
    if ((u8)Anim_CheckScreenIdle() == 0)
        return;

    {
        u32 *g = (u32 *)0x03005330;
        u8 *base3720 = (u8 *)gEntities;

        if (*g - *(u32 *)(base3720 + 0xb10) <= 120)
            return;
    }
    CtrlFlags_SetBit(base6110, 3, 3);
    ModeControl_ClearBit(base6110, 3, 8);
}

extern u32 Scene_EntityTick(u8 *state);
extern void sub_0800BE18(u8 *slots, u32 *out, s8 type);

void Gate_ResetSceneState(u8 *arg0, u8 *arg1, u32 *arg2, u8 *arg3, u32 *arg4)
{
    if (Scene_EntityTick(arg0) == 0)
        *arg0 = 8;

    {
        u8 *base = (u8 *)&gIwram_6110;
        gIwram_6110.scenePhase = 0;
        base[0x2a] = 0;
        base[0x2b] = 0;

        if (gIwram_6110.spawnMask != 1)
            return;
    }

    sub_0800BE18(arg1, arg2, 29);
    sub_0800BE18(arg3, arg4, 30);
}

extern void BgTilemap_LoadScene(void);
extern void Game_FrameEnd(void);

void Gate_FinishScene(void)
{
    BgTilemap_LoadScene();
    Game_FrameEnd();
}

extern void sub_0800B178(void *arg0);
extern u8 Tilemap_GetTileClass(u8 col, u8 row, s16 tileX, s16 tileY);
extern void Gate_OnTileStep(u8 tile);
extern void Gate_PollResult(void *arg0);

void Entity_UpdateHitAndDraw(void *arg0)
{
    u8 *base6110;
    struct IwramAt35E0 *p35E0;
    u32 mask;

    sub_0800B178(arg0);

    /* base6110 is materialized after the sub_0800B178 call so its pool load
     * lands past the BL (arg0 is live into the call). */
    base6110 = (u8 *)&gIwram_6110;
    if ((u8)ModeControl_GetFlag(base6110, 5, 4) == 0)
        goto tail;
    if ((u8)ModeControl_GetFlag(base6110, 5, base6110[0x2b]) != 0)
        goto tail;

    {
        /* gs anchors the gGameStuff pointer load ahead of the +0xb8c constant
         * (so 0xb8c lands in r1); the deref is deferred until after slot. */
        u32 *gs = &gGameStuff._unk00;
        u8 *base3720 = (u8 *)gEntities;
        u32 *slot = (u32 *)(base3720 + 0xb8c);
        u32 cur = *gs;

        if (cur - *slot <= 180)
            goto tail;

        {
            s16 *counter = (s16 *)(base3720 + 0xb70);
            *counter += 1;
            *counter = *counter % 2;
        }
        *slot = cur;
    }

tail:
    p35E0 = &gIwram_35E0;
    mask = 0x10;
    mask &= p35E0->_field_10;
    if (mask == 0)
        return;

    Gate_OnTileStep((u8)Tilemap_GetTileClass(p35E0->_field_18, p35E0->_field_19, p35E0->_field_8, p35E0->_field_A));
    Gate_PollResult(arg0);
}
