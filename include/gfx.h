#ifndef GUARD_GFX_H
#define GUARD_GFX_H

#include "types.h"

/* Canonical prototypes for the graphics / sprite / tilemap / blend / screen
 * helpers in src/engine, centralized from per-caller ad-hoc externs
 * (see tools/agent/unify_prototype.py). */

typedef struct SpriteAssetIndexEntry {
    u32 dataPtr;
    u8 stride;
    u8 rows;
    u8 _field_6;
    u8 _field_7;
} SpriteAssetIndexEntry;

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

/* Scroll-animation descriptor: two ROM entries at 0x08306e08 / 0x08306e28
 * describe one scroll-animation channel each. Each AnimDesc is 24 bytes. */
typedef struct AnimDesc {
    u8 state;
    u8 _pad01[3];
    u32 field_04;
    u32 field_08;
    u8 maxFrames;
    u8 _pad0d;
    s16 field_0e;
    u8 _pad10[4];
    u32 field_14;
} AnimDesc;

struct ScaleAnimDesc {
    u16 dstX;
    u16 dstY;
    u16 width;
    u16 rows;
    u8 flags;
    u8 _pad09[7];
    const u16 **srcTable;
    u32 _pad20;
};

struct DmaDesc2Entry {
    u16 maxCount;
    u8 threshold;
    u8 _pad3;
    u32 *srcPtrTable;
    u32 destAddr;
    u16 count;
    u16 _pad0e;
};

struct ScrollData {
    u32 f0;
    u32 f1;
    u32 f2;
    u32 f3;
};

/* Display-state save/restore block at 0x03006420 (IWRAM). Saved by
 * BgBuffer_ApplyPending before flushing; restored by Display_RestoreState.
 * tileBank (+25) is the high tilemap-entry bits used for screen fill. */
struct Unk03006420 {
    u32 active;
    u16 dispcnt;
    u16 _pad;
    struct ScrollData scroll;
    u8 _pad18;
    u8 tileBank; /* +25: high tilemap-entry bits (<<12) for the screen fill */
};

extern struct Unk03006420 gUnk03006420;

u8 TileMap_GetCell(u32 x, u32 y);

void ScrollCamera_Update(u8 countArg);

void Scroll_RunSubtypeTicks(u8 arg);

u16 Blend_StartFade(u16 arg);

u32 SpriteAsset_LoadSheet(u8 a, u8 b);

u16 Screen_BeginFlash(u16 arg);

s32 Screen_TickFlash(void);

void ScrollBlit_ResetLayers(void);

void Scroll_UpdateCamera(u8 countArg);

void BgLayer_Disable(u8 layer);

void BgLayer_Enable(u8 layer);

/* Tile-blit engine: copies srcTable[srcIndex] rows into VRAM at (dstX, dstY).
 * Scalar params are declared u32 because agbcc generates the entry-narrowing masks
 * (lsls/lsrs) only for u32 params; narrower types at the call site are safe.
 * srcTable is void* to accommodate callers passing TilemapTableEntry.tiles (void*)
 * or const u16** from ScaleAnimDesc; ABI-identical either way. */
void Tilemap_BlitTileRows(u32 flags, u32 dstX, u32 dstY, u32 widthArg, u32 srcRowsArg, void *srcTable, u32 srcIndex);

#endif /* GUARD_GFX_H */
