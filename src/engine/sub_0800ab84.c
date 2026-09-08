#include "iwram.h"
#include "entity.h"
#include "sound.h"
#include "macros.h"
#include "types.h"
#include "game.h"

extern u8 ModeControl_GetFlag(u8 *base, u32 selector, u32 bit);

void FrogPad_CheckTile(u8 tile)
{
    struct IwramAt35E0 *p35E0;
    s8 result;
    u8 *base;
    register u8 *base5 asm("r5");
    register u32 bit asm("r2");
    u8 *checkBase;

    if (tile != 20)
        return;

    p35E0 = &gIwram_35E0;
    result = EntityHitbox_FindPoint(19, p35E0->_field_8, p35E0->_field_A);

    if (result != 0)
        goto nonzero;

    base = (u8 *)0x03006110;
    bit = (u8)result;
    goto set5;

nonzero:
    base5 = (u8 *)0x03006110;
    bit = (u8)(result - 1);
    if (ModeControl_GetFlag(base5, 5, bit) == 0)
        goto play;

    bit = (u8)result;
    base = base5;

set5:
    CtrlFlags_SetBit(base, 5, bit);
    goto check;

play:
    Sound_Play(114);

check:
    checkBase = (u8 *)0x03006110;
    if (ModeControl_GetFlag(checkBase, 5, 0) == 0)
        return;
    if (ModeControl_GetFlag(checkBase, 5, 1) == 0)
        return;
    if (ModeControl_GetFlag(checkBase, 5, 2) == 0)
        return;
    if (ModeControl_GetFlag(checkBase, 5, 3) == 0)
        return;

    CtrlFlags_SetBit(checkBase, 5, 15);
    ModeControl_ClearBit(checkBase, 8, 1);
}

void TileCollect_OnStep(u8 tile)
{
    u8 *pCtrlBase;
    struct IwramAt6110 *pState;

    if (tile != 20)
        return;

    pCtrlBase = (u8 *)0x03006110;

    if (ModeControl_GetFlag(pCtrlBase, 5, 0) == 0) {
        CtrlFlags_SetBit(pCtrlBase, 5, 0);
        Sound_Play(25);
        CtrlFlags_SetBit(pCtrlBase, 8, 4);
    } else if (ModeControl_GetFlag(pCtrlBase, 5, 1) == 0) {
        CtrlFlags_SetBit(pCtrlBase, 5, 1);
        Sound_Play(25);
        CtrlFlags_SetBit(pCtrlBase, 8, 4);
    } else if (ModeControl_GetFlag(pCtrlBase, 5, 2) == 0) {
        CtrlFlags_SetBit(pCtrlBase, 5, 2);
        Sound_Play(25);
        CtrlFlags_SetBit(pCtrlBase, 8, 4);
    }

    pState = &gIwram_6110;
    if (pState->selector5Flags == 7)
        CtrlFlags_SetBit((u8 *)pState, 8, 5);

    CtrlFlags_SetBit((u8 *)pState, 8, 2);
}

extern s8 SpriteAnim_GetPermIndex(s8 idx);

void TileArrival_UpdateModeFlags(u8 tile)
{
    struct IwramAt35E0 *p35E0;
    struct IwramAt6110 *base5;
    struct IwramAt6110 *base4;
    struct IwramAt6110 *base2;
    register u16 flags asm("r1");
    s8 result;

    if (tile == 20) {
        p35E0 = &gIwram_35E0;
        result = (u8)EntityHitbox_FindPoint(20, p35E0->_field_8, p35E0->_field_A);

        base5 = &gIwram_6110;
        if (ModeControl_GetFlag((u8 *)base5, 5, (u8)result) == 0) {
            CtrlFlags_SetBit((u8 *)base5, 5, (u8)result);
            Sound_Play(25);
        }

        flags = base5->selector5Flags;
        if ((flags & 1) && (flags & 0x20)) {
            if (ModeControl_GetFlag((u8 *)base5, 8, 4) == 0) {
                CtrlFlags_SetBit((u8 *)base5, 8, 4);
                Sound_Play(52);
            }
        }

        base4 = &gIwram_6110;
        if ((base4->selector5Flags & 0x12) == 0x12) {
            if (ModeControl_GetFlag((u8 *)base4, 8, 5) == 0) {
                CtrlFlags_SetBit((u8 *)base4, 8, 5);
                Sound_Play(52);
            }
        }

        base4 = &gIwram_6110;
        if ((base4->selector5Flags & 0x84) == 0x84) {
            if (ModeControl_GetFlag((u8 *)base4, 8, 6) == 0) {
                CtrlFlags_SetBit((u8 *)base4, 8, 6);
                Sound_Play(52);
            }
        }

        base4 = &gIwram_6110;
        if ((base4->selector5Flags & 0x48) == 0x48) {
            if (ModeControl_GetFlag((u8 *)base4, 8, 7) == 0) {
                CtrlFlags_SetBit((u8 *)base4, 8, 7);
                Sound_Play(52);
            }
        }

        base2 = &gIwram_6110;
        if ((base2->byteFlags8 & 0xf0) == 0xf0)
            CtrlFlags_SetBit((u8 *)base2, 8, 0);
    }

    if (tile == 22) {
        p35E0 = &gIwram_35E0;
        result = EntityHitbox_FindPoint(21, p35E0->_field_8, p35E0->_field_A);
        result = SpriteAnim_GetPermIndex((s8)result);
        gIwram_6110.spawnMask = (u8)result;
        Sound_Play(70);
        CtrlFlags_SetBit((u8 *)&gIwram_6110, 8, 1);
    }
}

void Gate_OnTileStep(u8 tile)
{
    struct IwramAt35E0 *p35E0;
    register u8 *spawn asm("r4");
    register u8 *spawn5 asm("r5");
    register struct IwramAt6110 *base6110 asm("r5");
    u8 *base3720;
    s8 result;
    u8 rand;

    if (tile != 20)
        return;

    p35E0 = &gIwram_35E0;
    result = EntityHitbox_FindPoint(23, p35E0->_field_8, p35E0->_field_A);

    if (result == -1)
        return;

    if (result == 4) {
        spawn = (u8 *)0x03006110;
        if (ModeControl_GetFlag(spawn, 5, 4) != 0)
            return;
        CtrlFlags_SetBit(spawn, 5, 4);

        spawn += 0x33;
        if (*spawn == 15) {
            rand = 0;
            goto write;
        }

        rand = (u8)RandRange(4);
        if (((*spawn >> (s8)rand) & 1) == 0)
            goto write;

        spawn5 = spawn;
        do {
            rand = (u8)RandRange(4);
        } while (((*spawn5 >> (s8)rand) & 1) != 0);

    write:
        gIwram_6110.gateByte = rand;

        base3720 = (u8 *)gEntities;
        *(u32 *)(base3720 + 0xb8c) = gGameStuff._unk00;
        *(u16 *)(base3720 + 0xb70) = 1;
        return;
    }

    /* Struct-pointer read (not a folded 0x0300613b literal) keeps the
       0x03006110 base live in r5 across the call cluster. */
    base6110 = (struct IwramAt6110 *)0x03006110;
    if (ModeControl_GetFlag((u8 *)base6110, 5, 4) == 0)
        return;
    if (result != base6110->gateByte)
        return;

    CtrlFlags_SetBit((u8 *)base6110, 5, (u8)result);
    result = (s8)(result + 8);
    if (ModeControl_GetFlag((u8 *)base6110, 5, (u8)result) != 0)
        return;
    CtrlFlags_SetBit((u8 *)base6110, 5, (u8)result);
}
