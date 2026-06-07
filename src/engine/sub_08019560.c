#include "game.h"
#include "gfx.h"
#include "iwram.h"
#include "macros.h"
#include "types.h"
#include "gba/dma.h"
#include "gba/io.h"

/* Linker-assigned (docs/codegen-notes.md "Adjacent IWRAM bases"): keeping
 * the table opaque to agbcc holds its pool load ahead of the gIwram_3480
 * index read, matching the baserom. */
extern void (*const gHandlerTable_08308058[])(void);

/* Dispatch through a ROM handler table indexed by gIwram_3480._data[3].
 * Class-sibling of GameMode_Menu26 (which indexes by _data[4]); both share
 * the 0x08308058 table and discard the handler's return value (the popped
 * lr lands in r0 before bx). */

void GameMode_Menu25(void)
{
    gHandlerTable_08308058[gIwram_3480._data[3]]();
}

extern void SoundMixer_Stop(void);
extern s32 Screen_TickFlash(void);
extern u32 GetFrameTick(void);

void Menu25_WaitFadeIn(void)
{
    u32 now;

    SoundMixer_Stop();
    gIwram_3480._data[5] = 0;
    gIwram_3608._data = 0;

    if (Screen_TickFlash() != 0)
        return;

    now = GetFrameTick();
    now -= gIwram_3480._unk0C;
    if (now <= 0x77)
        return;

    gIwram_3480._unk0C = GetFrameTick();
    gIwram_3480._data[0]++;
    Blend_StartFade(0xBF);
}

extern const void *const sUiAssetSlots[];

/* Declared s32 (canonical type is u8) so agbcc compares the return value
 * directly with `cmp r0, #0` instead of zero-extending via `lsls #24`,
 * matching the baserom's branch. */
extern s32 Blend_StepFade(void);
extern u16 Screen_BeginFlash(u16 arg);

/* Reload the status-bar BG3 graphics (DMA3 from sUiAssetSlots[3..5] into
 * tile/palette/map VRAM), arm BG3 + 1D-OBJ, and re-init the fade-out
 * (Screen_BeginFlash). Skips the whole reload while the fade-in ticker
 * (Blend_StepFade) is still counting down. Sibling of UiScreen_Init, which
 * does the same DMA3 sequence with sUiAssetSlots[0..2]. */
void Menu25_ReloadStatusBarBg(void)
{
    volatile DmaChannel *dma;

    gIwram_3480._data[5] = 0;

    if (Blend_StepFade() != 0)
        return;

    REG_BG3CNT = 0x1E08;

    dma = &REG_DMA3;
    dma->src = sUiAssetSlots[3];
    dma->dst = (void *)0x06008000;
    dma->cnt = DMA_ENABLE | 0x890;
    (void)dma->cnt;

    dma->src = sUiAssetSlots[4];
    dma->dst = (void *)0x05000000;
    dma->cnt = DMA_ENABLE | 0x100;
    (void)dma->cnt;

    dma->src = sUiAssetSlots[5];
    dma->dst = (void *)0x0600F000;
    dma->cnt = DMA_ENABLE | 0x400;
    (void)dma->cnt;

    REG_DISPCNT = DISPCNT_OBJ_1D | DISPCNT_BG3_ON;

    Screen_BeginFlash(0xBF);
    gIwram_3480._data[0]++;
}

/* Resets the status-bar dispatch state (clears _data[7] and _data[0])
 * once the fade-in ticker has finished. Same guard idiom as
 * Menu25_ReloadStatusBarBg. */
void Menu25_ResetAfterFade(void)
{
    if (Blend_StepFade() != 0)
        return;

    gIwram_3480._data[7] = 0;
    gIwram_3480._data[0] = 0;
}

/* Bumps the status-bar sub-state counter (_data[3]). Companion to
 * Menu25_AdvanceAndReturn, which does the same _data[3]++ but also seeds _data[9]
 * and clears _data[0]. */
void Menu25_AdvanceSubstate(void)
{
    gIwram_3480._data[3]++;
}

/* Advances the status-bar dispatch sub-state (_data[3]++) and seeds the
 * game-state machine into mode 4, clearing _data[0], once the fade-in
 * ticker (Blend_StepFade) finishes. Companion of Menu25_AdvanceSubstate (no mode
 * seed). r stores the ticker result so r3 holds 0 when we later clear
 * _data[0], letting agbcc emit `strb r3,[r1,#0]` directly. */
void Menu25_AdvanceAndReturn(void)
{
    s32 r = Blend_StepFade();

    if (r != 0)
        return;

    gIwram_3480._data[3]++;
    gGameStuff.mode = GAME_MODE_ROUTER;
    gIwram_3480._data[0] = r;
}

/* Sets the game-state mode to 4 and zeros the dispatch index and two
 * related state bytes, once the fade-in ticker (Blend_StepFade) finishes.
 * r stores the ticker result so r2 holds 0 when agbcc emits the
 * strb-of-register stores. Sibling of Menu25_Enter (mode=25 path). */
void Menu25_ReturnToRouter(void)
{
    s32 r = Blend_StepFade();

    if (r != 0)
        return;

    gGameStuff.mode = GAME_MODE_ROUTER;
    gIwram_3480._data[3] = r;
    gIwram_3480._data[0] = r;
    gIwram_3480._data[5] = r;
}

/* Sets the game-state mode to 25 (0x19) and seeds the dispatch state:
 * clears _data[0,5,4], sets _data[3]=2. Sibling of Menu25_ReturnToRouter. */
void Menu25_Enter(void)
{
    gGameStuff.mode = GAME_MODE_MENU_25;
    gIwram_3480._data[0] = 0;
    gIwram_3480._data[5] = 0;
    gIwram_3480._data[3] = 2;
    gIwram_3480._data[4] = 0;
}

void sub_080196E8(void)
{}

/* Rectangular tilemap blit into a BG screenblock via DMA3. The descriptor's
 * four bytes are [0]=x, [1]=y (tile coords), [2]=halfwords per row, [3]=row
 * count. mode picks the destination screenblock (28..31 at 0x0600E000 +
 * mode*0x800); src and dst are both biased by the (x + y*32) tile offset and
 * advance one screenblock row (0x40 bytes) per iteration. Called from
 * SaveSlot_DrawSelectionCursor. */
void TileBlit(u8 *attr, const u16 *src, u8 mode)
{
    u16 *dst;
    u8 row;

    src += attr[0] + (attr[1] << 5);

    switch (mode) {
    case 0:
        dst = (u16 *)0x0600E000;
        break;
    case 1:
        dst = (u16 *)0x0600E800;
        break;
    case 2:
        dst = (u16 *)0x0600F000;
        break;
    case 3:
        dst = (u16 *)0x0600F800;
        break;
    }

    dst += attr[0] + (attr[1] << 5);

    for (row = 0; row < attr[3]; row++) {
        REG_DMA3.src = src;
        REG_DMA3.dst = dst;
        REG_DMA3.cnt = DMA_ENABLE | attr[2];
        (void)REG_DMA3.cnt;

        src += 0x20;
        dst += 0x20;
    }
}

/* Copies the overlapping rectangle between two tilemap descriptors into a BG
 * screenblock via DMA3. Both descriptors share the [0]=x, [1]=y, [2]=halfwords
 * per row, [3]=row count layout (see TileBlit); the copied rectangle uses
 * the per-field minimum of the two, so the smaller of source/destination wins.
 * src is read from base (biased by the source descriptor's tile offset); dst is
 * the mode-selected screenblock (28..31 at 0x0600E000 + mode*0x800), biased by
 * the destination descriptor's tile offset. Sibling of TileBlit. */
void BgTilemap_BlitRectClipped(const u8 *dstAttr, const u8 *srcAttr, const u16 *base, u8 mode)
{
    const u16 *src;
    u16 *dst;
    u8 rows;
    u8 width;
    u8 row;

    rows = (dstAttr[3] <= srcAttr[3]) ? dstAttr[3] : srcAttr[3];
    width = (dstAttr[2] <= srcAttr[2]) ? dstAttr[2] : srcAttr[2];

    src = base + (srcAttr[0] + (srcAttr[1] << 5));

    switch (mode) {
    case 0:
        dst = (u16 *)0x0600E000;
        break;
    case 1:
        dst = (u16 *)0x0600E800;
        break;
    case 2:
        dst = (u16 *)0x0600F000;
        break;
    case 3:
        dst = (u16 *)0x0600F800;
        break;
    }

    dst += dstAttr[0] + (dstAttr[1] << 5);

    for (row = 0; row < rows; row++) {
        REG_DMA3.src = src;
        REG_DMA3.dst = dst;
        REG_DMA3.cnt = DMA_ENABLE | width;
        (void)REG_DMA3.cnt;

        src += 0x20;
        dst += 0x20;
    }
}
