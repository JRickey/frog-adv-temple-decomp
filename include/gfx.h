#ifndef GUARD_GFX_H
#define GUARD_GFX_H

#include "types.h"

/* Canonical prototypes for the graphics / sprite / tilemap / blend / screen
 * helpers in src/engine, centralized from per-caller ad-hoc externs
 * (see tools/agent/unify_prototype.py). */

struct TransferDesc {
    u32 word0;
    u32 word4;
    u32 word8;
    u32 wordC;
};

struct TilemapTableEntry {
    u16 unk00;
    u16 unk02;
    u16 unk04;
    u16 unk06;
    u8 unk08;
    u8 pad09[7];
    void *tiles;
    u8 pad14[4];
};

u8 TileMap_GetCell(u32 x, u32 y);

void ScrollCamera_Update(u8 countArg);

void Scroll_RunSubtypeTicks(u8 arg);

u16 Blend_StartFade(u16 arg);

u32 SpriteAsset_LoadSheet(u8 a, u8 b);

u16 Screen_BeginFlash(u16 arg);

s32 Screen_TickFlash(void);

void sub_08015194(void);

void Scroll_UpdateCamera(u8 countArg);

void BgLayer_Disable(u8 layer);

void BgLayer_Enable(u8 layer);

#endif /* GUARD_GFX_H */
