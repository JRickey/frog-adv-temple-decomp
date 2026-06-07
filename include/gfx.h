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

struct ScreenInstallArgs {
    u32 _unk00;
    const void *tilemap1;
    const void *tilemap2;
    u32 _unk0C;
};

struct Rect2 {
    u16 _field_0;
    s16 _field_2;
    s16 _field_4;
};

typedef struct FrameDescriptor {
    u16 x;
    u16 y;
    u16 w;
    u16 h;
    const u16 *tile_data;
} FrameDescriptor;

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
