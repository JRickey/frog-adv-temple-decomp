#include "game.h"
#include "gfx.h"
#include "sound.h"
#include "gba/dma.h"
#include "gba/io.h"
#include "iwram.h"
#include "types.h"

extern void Scroll_FlushTilemapWindow(u32, void *, void *);
extern void EntityPool_Reset(void);
extern void sub_08019A14(void);
extern void Sound_DrainIfActive(void);
extern const u8 sRoomDmaTable_080C1254[];

struct Unk03006420 {
    u32 active;
    u16 dispcnt;
    u16 _pad;
    struct ScrollData scroll;
    u8 _pad18;
    u8 tileBank; /* +25: high tilemap-entry bits (<<12) for the screen fill */
};

extern struct Unk03006420 gUnk03006420;

/* clang-format off */
#define FIXED_ARG_U32(reg, expr) ({ register u32 _v asm(reg) = (expr); _v; })
#define FIXED_ARG_PTR(reg, expr) ({ register void *_v asm(reg) = (void *)(expr); _v; })
/* clang-format on */

u32 BgBuffer_ApplyPending(void)
{
    struct Unk03006420 *base = &gUnk03006420;

    if (base->active == 0) {
        sub_08019A14();
        return 0;
    }

    REG_DISPCNT = base->dispcnt;

    *(struct ScrollData *)0x03003550 = base->scroll;

    Scroll_FlushTilemapWindow(FIXED_ARG_U32("r0", 0), FIXED_ARG_PTR("r1", 0x80 << 18), FIXED_ARG_PTR("r2", 0x0600e000));
    Scroll_FlushTilemapWindow(FIXED_ARG_U32("r0", 1), FIXED_ARG_PTR("r1", 0x02010000), FIXED_ARG_PTR("r2", 0x0600e800));
    Scroll_FlushTilemapWindow(FIXED_ARG_U32("r0", 2), FIXED_ARG_PTR("r1", 0x02020000), FIXED_ARG_PTR("r2", 0x0600f000));
    Scroll_FlushTilemapWindow(FIXED_ARG_U32("r0", 3), FIXED_ARG_PTR("r1", 0x02030000), FIXED_ARG_PTR("r2", 0x0600f800));

    base->active = 0;
    return 1;
}

/* Per-room DMA3 setup: clears the BG3 screen block, then streams two
 * room-specific source pointers (from the 24-byte ROM table at 0x080C1254,
 * indexed by gIwram_34B0) into palette RAM and back into VRAM, finally
 * arming REG_BG3CNT.
 *
 * tableBase is kept opaque (the barrier) so agbcc adds the +8/+4 field
 * offsets to the base register at runtime instead of folding each into a
 * separate pool constant. The zptr pointer-first store makes &zero (reused
 * as the fixed DMA source) materialize before the zero value. */
void LoadRoomBg3Graphics(void)
{
    u16 zero;
    u16 *zptr;
    vu32 *dma;
    u32 dst;
    u32 idx24;
    u32 tableBase;
    u32 entry;
    u32 cnt;

    zptr = &zero;
    *zptr = 0;

    dma = (vu32 *)0x040000D4;
    dma[0] = (u32)zptr;
    dst = 0x06008000;
    dma[1] = dst;
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0x400;
    cnt = dma[2];

    tableBase = 0x080C1254;
    asm volatile("" : "+r"(tableBase));
    idx24 = gIwram_34B0._data * 24;

    entry = tableBase + 8;
    dma[0] = *(const u32 *)(idx24 + entry);
    dma[1] = 0x050001A0;
    dma[2] = DMA_ENABLE | 0x30;
    cnt = dma[2];

    tableBase += 4;
    dma[0] = *(const u32 *)(idx24 + tableBase);
    dma[1] = dst;
    dma[2] = DMA_ENABLE | 0x2000;
    cnt = dma[2];
    (void)cnt;

    REG_BG3CNT = 0x1F08;
}

void BgPlane_FillTilemap(u8 arg)
{
    vu16 *dst;
    u16 i;

    switch (arg) {
    case 0:
        dst = (vu16 *)0x0600E000;
        break;
    case 1:
        dst = (vu16 *)0x0600E800;
        break;
    case 2:
        dst = (vu16 *)0x0600F000;
        break;
    case 3:
        dst = (vu16 *)0x0600F800;
        break;
    }

    i = 0;
    do {
        *dst = i + (gUnk03006420.tileBank << 12);
        dst++;
        i++;
    } while (i <= 0x3FF);
}

void RoomSelect_InitDisplay(void)
{
    u16 zero;
    vu32 *dma;
    u16 *win;
    u32 idx24;
    u32 tableBase;

    EntityPool_Reset();

    *(u16 *)&zero = 0;

    dma = (vu32 *)0x040000D4;
    dma[0] = (u32)&zero;
    dma[1] = 0x06000000;
    dma[2] = DMA_ENABLE | DMA_SRC_FIXED | 0x8000;
    (void)dma[2];

    REG_BG3CNT = 0x1F08;

    win = (u16 *)0x04000040;
    *win = 0;
    win += 2;
    *win = 0;
    win += 2;
    *win = 0;
    win += 1;
    *win = 0;

    REG_DISPCNT = REG_DISPCNT & ~DISPCNT_WIN0_ON;
    REG_DISPCNT = REG_DISPCNT & ~DISPCNT_WIN1_ON;

    gIwram_3550._data[6] = 0;
    gIwram_3550._data[7] = 0;

    tableBase = (u32)sRoomDmaTable_080C1254;
    idx24 = gIwram_34B0._data * 24;
    tableBase += 4;
    dma[0] = *(const u32 *)(idx24 + tableBase);
    dma[1] = 0x06008000;
    dma[2] = DMA_ENABLE | 0x2000;
    (void)dma[2];

    gIwram_34C0.cursor = 0;
    gIwram_34C0.delay = 0;
    gIwram_34C0.holdFlag = 0;

    gIwram_6110.inputFlags ^= 8;

    Sound_DrainIfActive();
    Sound_PlayIfEnabled(15);
}

typedef void (*GameProc)(void);

extern const u32 sEntityProcB[17];
extern const u32 sEntityProcC[17];
extern const u16 sWinPoseScreenCoords[];
extern const u8 sUnkPtrPair_82F998C[];

extern u8 GetHighestUnlockedWorld(void);
extern void WorldMap_DrawPathTiles(u8 count);
extern void LoadWorldLevelLayoutAlt(void);
/* Declared with s32 coordinate params so the s16 x/y are sign-extended at
 * the call site (lsls #16 / asrs #16), matching the baserom. */
extern void Player_InitEntity(s32 x, s32 y, u8 g, u8 h);
extern void BgScrollBlit(u8 arg);
extern void sub_08008174(void);
extern void Entity_UpdateVisibility(void);
extern void Entity_Advance(void);
extern void Game_ForceRender(void);

/* Win-pose / level-transition entry. Reads the transition state byte at
 * 0x03003540: state 0 drives the win-pose camera from gGameStuff.pendingMode,
 * state 2 from the highest live world flag (GetHighestUnlockedWorld). Seeds the player
 * sprite at the chosen screen coords, primes the gIwram_6110 mode-control
 * block (the two flagBank words are set to 0xFFFFFFFF, not -1, so each pair
 * loads the 0xffffffff/0 pool constants), then runs the per-frame entity
 * dispatch tail. */
void WinPose_Init(void)
{
    u8 idx;
    u8 idx2;
    s16 x;
    s16 y;
    const u16 *coords;

    EntityPool_Reset();

    switch (*(u8 *)0x03003540) {
    case 0:
        idx = gGameStuff.pendingMode;
        break;
    case 2:
        idx = (u8)(GetHighestUnlockedWorld() + 1);
        if (idx > 15)
            idx = 15;
        break;
    }

    idx2 = GetHighestUnlockedWorld();
    if (idx2 > 14)
        idx2 = 15;

    /* Each sWinPoseScreenCoords entry is a packed (u16 x, u16 y). The y read
     * uses an explicit byte offset so agbcc recomputes the address from idx
     * instead of CSE-folding it into `[x_addr, #2]` — the baserom shifts the
     * index twice for y. */
    coords = sWinPoseScreenCoords;
    x = coords[idx * 2];
    y = *(const u16 *)((u32)coords + ((idx * 2 + 1) << 1));

    gGameStuff.pendingMode = 0;
    ModeControl_Init(&gIwram_6110, 20, 2, sUnkPtrPair_82F998C, 1, 0);

    EntityPool_Reset();
    Player_InitEntity(x, y, 1, 0x23);

    ((GameProc)sEntityProcC[0])();

    if (*(u8 *)0x03003540 == 0) {
        if (idx2 > idx)
            WorldMap_DrawPathTiles((u8)(idx2 + 1));
        else
            WorldMap_DrawPathTiles(idx);
    } else if (*(u8 *)0x03003540 == 2) {
        WorldMap_DrawPathTiles((u8)(idx2 + 1));
    }

    BgScrollBlit(2);
    LoadWorldLevelLayoutAlt();

    gIwram_6110.flagBank0 = 0xFFFFFFFFLL;
    gIwram_6110.flagBank1 = 0xFFFFFFFFLL;

    sub_08008174();
    ((GameProc)sEntityProcB[0])();
    Entity_UpdateVisibility();
    Entity_Advance();
    Game_ForceRender();
}

void WorldMap_SetPathTile(u8 tileX, u8 tileY);
void Entity_UpdateAndRender(void);
int ScriptStep_Advance(u8 index, int useTableA);

u8 MapCursor_Step(u8 index, u8 noSnap, int useTableA, int skipAdvance)
{
    u8 flags;

    flags = 0;

    if (noSnap == 0) {
        WorldMap_SetPathTile((gEntities[0].x - 4) / 8, (gEntities[0].y + 4) / 8);
    }

    if (skipAdvance == 0) {
        flags = ScriptStep_Advance(index, useTableA);
    }

    if (flags & 8) {
        gEntities[0].x += 2;
    }
    if (flags & 2) {
        gEntities[0].y += 2;
    }
    if (flags & 4) {
        gEntities[0].x -= 2;
    }
    if (flags & 1) {
        gEntities[0].y -= 2;
    }

    Entity_UpdateAndRender();

    if (flags == 0xFF) {
        return 0;
    }
    return 1;
}
