#include "game.h"
#include "gfx.h"
#include "sound.h"
#include "gba/dma.h"
#include "gba/io.h"
#include "iwram.h"
#include "save.h"
#include "types.h"

extern void Bg_WriteTilePair(u32 hflip, u8 col, u8 row, u16 tile, u32 palBank, u8 screen, u32 value);
extern void DrawTextGlyphs(const u8 *str, int len, int x, int y, int a, int b, int c);
extern void DrawNumber(u16 value, u8 x, u8 y, u16 a, u16 b, u8 c, u32 forceZeros);
extern void Bg_InitMode0(void);
extern void Screen_ClearBlocks(s32 mode);
extern void Screen_Install(s32 flag, s32 a, s32 b, struct ScreenInstallArgs args, s32 last);
extern void Screen_InstallOamA(s32 a, s32 b, s32 c, s32 d);
extern void Sprite_CycleDmaFrame(u32 a, u32 b, u32 c, u32 d);
extern void Sprite_AnimateFlip(void *self, u16 a, u16 b, u8 c, u8 count);
extern u8 Scene_DrawWindow(s32 a, s32 b, const void *c, s32 d, s32 e, s32 f);
extern void FileSelect_DrawSlots(void);
extern void sub_08017710(u8 slot);
extern u16 Input_Poll(void);

extern u16 gIwram_5398;
extern const u32 sOamDmaCfg_08100[4];
extern const u32 sUiOnOffLabelPtrs[10];
extern const u8 sCreditsMisc[24];
extern const u16 sScreenTilemapD8B98[1024];
extern const u16 sScreenPaletteDAB98[256];
extern const u8 sScreenCharTilesDAD98[38528];
extern const u16 sScreenTilemapE4418[1024];

/* Linker-assigned (see linker.ld) so the table base is materialised before
 * the gIwram_34B0 index load, like sScreenTilemapTable_308EF4. */
extern const void *const sScreenTilemapTable_308F84[];
extern const void *const sScreenTilemapTable_308EF4[];
extern const void *const *const sSceneRecordTable_308110[];

#define gIwram_3540 (*(u8 *)0x03003540)

struct OnOffLabels {
    const u8 *ptr[10]; /* [lang * 2] = ON label, [lang * 2 + 1] = OFF label */
};

void sub_0801EA08(void)
{
    struct OnOffLabels labels;
    u32 attr;
    u8 row;

    labels = *(const struct OnOffLabels *)sUiOnOffLabelPtrs;

    attr = (attr & 0xffffff00) | 0x06;
    attr = (attr & 0xffff00ff) | 0x0200;
    attr = (attr & 0x00ffffff) | 0x04000000;
    attr = (attr & 0xff00ffff) | 0x00120000;

    switch (gIwram_3480.cursorIndex) {
    case 0:
        attr = (attr & 0xffff00ff) | 0x0200;
        break;
    case 1:
        attr = (attr & 0xffff00ff) | 0x0600;
        break;
    case 2:
        attr = (attr & 0xffff00ff) | 0x0a00;
        break;
    case 3:
        attr = (attr & 0xffff00ff) | 0x0e00;
        break;
    }

    REG_DMA3.src = sScreenTilemapTable_308F84[gIwram_34B0._data];
    REG_DMA3.dst = (void *)0x0600f000;
    REG_DMA3.cnt = DMA_ENABLE | 0x400;
    (void)REG_DMA3.cnt;

    /* if/else rather than early-out: the baserom lays the != 3 body out first
     * and reaches the == 3 body through an inverted bne/b pair. */
    if (gIwram_34B0._data != 3) {
        Bg_WriteTilePair(1, 18, 3, 0x13d, 5, 2, gIwram_34B4._data[0] == 0);
        Bg_WriteTilePair(0, 22, 3, 0x13d, 5, 2, gIwram_34B4._data[0]);
        if (gIwram_34B4._data[0] != 0)
            DrawTextGlyphs(labels.ptr[gIwram_34B0._data * 2], 3, 19, 3, 0x140, 5, 2);
        else
            DrawTextGlyphs(labels.ptr[gIwram_34B0._data * 2 + 1], 3, 19, 3, 0x140, 5, 2);

        Bg_WriteTilePair(1, 18, 7, 0x13d, 5, 2, gIwram_34B4._data[1] == 0);
        Bg_WriteTilePair(0, 22, 7, 0x13d, 5, 2, gIwram_34B4._data[1]);
        if (gIwram_34B4._data[1] != 0)
            DrawTextGlyphs(labels.ptr[gIwram_34B0._data * 2], 3, 19, 7, 0x140, 5, 2);
        else
            DrawTextGlyphs(labels.ptr[gIwram_34B0._data * 2 + 1], 3, 19, 7, 0x140, 5, 2);
    } else {
        Bg_WriteTilePair(1, 18, 3, 0x13d, 5, 2, gIwram_34B4._data[0] == 0);
        Bg_WriteTilePair(0, 21, 3, 0x13d, 5, 2, gIwram_34B4._data[0]);
        if (gIwram_34B4._data[0] == 0) {
            DrawTextGlyphs(labels.ptr[gIwram_34B0._data * 2 + 1], 3, 19, 3, 0x140, 5, 2);
            DrawTextGlyphs(sCreditsMisc, 3, 20, 1, 0x140, 5, 2);
        } else {
            DrawTextGlyphs(labels.ptr[gIwram_34B0._data * 2], 3, 19, 3, 0x140, 5, 2);
            DrawTextGlyphs(sCreditsMisc + 4, 3, 20, 2, 0x140, 5, 2);
        }

        Bg_WriteTilePair(1, 24, 7, 0x13d, 5, 2, gIwram_34B4._data[1] == 0);
        Bg_WriteTilePair(0, 27, 7, 0x13d, 5, 2, gIwram_34B4._data[1]);
        if (gIwram_34B4._data[1] == 0) {
            DrawTextGlyphs(labels.ptr[gIwram_34B0._data * 2 + 1], 3, 25, 7, 0x140, 5, 2);
            DrawTextGlyphs(sCreditsMisc, 3, 26, 5, 0x140, 5, 2);
        } else {
            DrawTextGlyphs(labels.ptr[gIwram_34B0._data * 2], 3, 25, 7, 0x140, 5, 2);
            DrawTextGlyphs(sCreditsMisc + 4, 3, 26, 6, 0x140, 5, 2);
        }

        attr = (attr & 0xff00ffff) | 0x001a0000;
        attr = (attr & 0xffffff00) | 0x02;
    }

    /* `row` (not a literal per call) keeps the spinner row in r8 across the
     * calls after the first if/else join. */
    row = 11;
    if (gIwram_34B4._data[2] == 3)
        Bg_WriteTilePair(1, 18, row, 0x13d, 5, 2, 0);
    else
        Bg_WriteTilePair(1, 18, row, 0x13d, 5, 2, 1);
    if (gIwram_34B4._data[2] == 9)
        Bg_WriteTilePair(0, 22, row, 0x13d, 5, 2, 0);
    else
        Bg_WriteTilePair(0, 22, row, 0x13d, 5, 2, 1);
    DrawNumber(gIwram_34B4._data[2], 20, row, 0x140, 5, 2, 0);

    row = 15;
    if (gIwram_34B4._data[3] == 3)
        Bg_WriteTilePair(1, 18, row, 0x13d, 5, 2, 0);
    else
        Bg_WriteTilePair(1, 18, row, 0x13d, 5, 2, 1);
    if (gIwram_34B4._data[3] == 9)
        Bg_WriteTilePair(0, 22, row, 0x13d, 5, 2, 0);
    else
        Bg_WriteTilePair(0, 22, row, 0x13d, 5, 2, 1);
    DrawNumber(gIwram_34B4._data[3], 20, row, 0x140, 5, 2, 0);

    Tilemap_SwapPalette((const TilemapRect *)&attr, 5, 4, 2);
}

void sub_0801EED4(void)
{
    struct ScreenInstallArgs args;

    args._unk00 = 0;
    args.tilemap1 = sScreenTilemapD8B98;
    args.tilemap2 = sScreenTilemapTable_308EF4[gIwram_34B0._data];
    args._unk0C = 0;

    gIwram_3480.cursorIndex = 0;

    if (gIwram_34A0.reentryFlag == 0) {
        Bg_InitMode0();

        REG_DMA3.src = sScreenPaletteDAB98;
        REG_DMA3.dst = (void *)0x05000000;
        REG_DMA3.cnt = DMA_ENABLE | 0x100;
        (void)REG_DMA3.cnt;

        REG_DMA3.src = sScreenCharTilesDAD98;
        REG_DMA3.dst = (void *)0x06000000;
        REG_DMA3.cnt = DMA_ENABLE | 0x4000;
        (void)REG_DMA3.cnt;

        REG_DMA3.src = sScreenTilemapE4418;
        REG_DMA3.dst = (void *)0x0600e000;
        REG_DMA3.cnt = DMA_ENABLE | 0x400;
        (void)REG_DMA3.cnt;
    } else {
        s32 flag;

        Screen_ClearBlocks(14);

        flag = (gIwram_34A0.reentryFlag == 0);
        Screen_Install(flag, 29, 6, args, 2);

        REG_DISPCNT |= DISPCNT_BG3_ON;
    }

    REG_DISPCNT |= DISPCNT_BG1_ON;

    REG_DMA3.src = sScreenTilemapD8B98;
    REG_DMA3.dst = (void *)0x0600e800;
    REG_DMA3.cnt = DMA_ENABLE | 0x400;
    (void)REG_DMA3.cnt;

    FileSelect_DrawSlots();

    if (gIwram_34A0.reentryFlag != 0) {
        const void *const *rec = sSceneRecordTable_308110[gIwram_34B0._data];
        Scene_DrawWindow(0, 6, rec[3], 28, 0, 1);
    }

    gIwram_5398 = 0;
    gIwram_34A0.dispatchIdx++;
}

void sub_0801F020(void)
{
    u32 attr;

    gIwram_5398 = Input_Poll();

    switch (gIwram_5398) {
    case 1:
        Sound_Play(2);
        if (gIwram_3480.cursorIndex == 0) {
            gIwram_3480.cursorIndex = 3;
            break;
        }
        gIwram_3480.cursorIndex--;
        break;
    case 2: {
        /* Same trick as FileSelect_Update: pin the constant to r1 and the
         * reload to r2 so the 0x3480 base lands in r0 (unpinned, agbcc swaps
         * r0/r1 and hoists the constant above the reload); the volatile
         * reload keeps the baserom's two read-modify-writes separate. */
        register u8 three asm("r1");
        register u8 reloaded asm("r2");

        Sound_Play(2);
        gIwram_3480.cursorIndex++;
        three = 3;
        reloaded = *(volatile u8 *)&gIwram_3480.cursorIndex;
        gIwram_3480.cursorIndex = three & reloaded;
        break;
    }
    case 16:
    case 64:
        Sound_Play(1);
        if ((gSaveData.header.slotMask >> gIwram_3480.cursorIndex) & 1) {
            attr = (attr & 0xffffff00) | 0x03;
            attr = (attr & 0xffff00ff) | 0x0400;
            attr = (attr & 0x00ffffff) | 0x03000000;
            attr = (attr & 0xff00ffff) | 0x00180000;

            switch (gIwram_3480.cursorIndex) {
            case 0:
                attr = (attr & 0xffff00ff) | 0x0400;
                break;
            case 1:
                attr = (attr & 0xffff00ff) | 0x0800;
                break;
            case 2:
                attr = (attr & 0xffff00ff) | 0x0c00;
                break;
            case 3:
                attr = (attr & 0xffff00ff) | 0x1000;
                break;
            }

            Sprite_AnimateFlip(&attr, 4, 5, 2, 10);

            gIwram_34A0.reentryFlag = 1;
            gSaveData.cursor = gIwram_3480.cursorIndex;
            Screen_InstallOamA(1, 29, 6, 2);
            sub_08017710(gIwram_3480.cursorIndex);
            gGameStuff.mode = GAME_MODE_WORLD_MAP;
            gIwram_3540 = 2;
            gSaveData.header._field2 = gIwram_34B4._data[3];
        }
        break;
    }

    if (gIwram_5398 == 32) {
        Sound_Play(0);
        gIwram_34A0.reentryFlag = 0;
        Screen_InstallOamA(0, 28, 6, 2);
        gIwram_34A0.dispatchIdx++;
    } else if (gIwram_5398 != 0 && gIwram_5398 != 16 && gIwram_5398 != 64) {
        FileSelect_DrawSlots();
    } else {
        Sprite_CycleDmaFrame(sOamDmaCfg_08100[0], sOamDmaCfg_08100[1], sOamDmaCfg_08100[2], sOamDmaCfg_08100[3]);
    }

    gIwram_5398 = 0;
}
