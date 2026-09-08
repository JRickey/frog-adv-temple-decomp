#include "gba/dma.h"
#include "gfx.h"
#include "sound.h"
#include "gba/io.h"
#include "iwram.h"
#include "save.h"
#include "sprite_dma.h"
#include "types.h"

extern void Bg_InitMode0(void);
/* Screen_InstallOamA's canonical widths remain unaudited. */
extern void Screen_InstallOamA(s32 a, s32 b, s32 c, s32 d);
extern void Screen_Install(s32 flag, s32 a, s32 b, struct ScreenInstallArgs args, s32 last);
extern void Screen_ClearBlocks(s32 mode);
extern u8 Scene_DrawWindow(s32 a, s32 b, const void *c, s32 d, s32 e, s32 f);
extern void SaveSlot_DrawAllSlots(void);
extern s32 SaveSlot_DrawSelectionCursor(u8 idx);
extern u16 Input_Poll(void);

extern u16 gIwram_5398;

/* ROM tables anchored inside the sprite-frame-pointer block, indexed by the
 * scene id in gIwram_34B0._data (see linker.ld). sScreenTilemapTable[id] is
 * the tilemap2 source for the screen install; sSceneRecordTable[id] points at
 * a record whose [1]/[2] entries are handed to Scene_DrawWindow. Linker-assigned
 * so each base load is a relocation that agbcc materialises before the index. */
extern const void *const sScreenTilemapTable_308EF4[];
extern const void *const *const sSceneRecordTable_308110[];

void FileSelect_Init(void)
{
    struct ScreenInstallArgs args;

    args._unk00 = 0;
    args.tilemap1 = (const void *)0x081d8b98;
    args.tilemap2 = sScreenTilemapTable_308EF4[gIwram_34B0._data];
    args._unk0C = 0;

    gIwram_3480.cursorIndex = 0;

    if (gIwram_34A0.reentryFlag == 0) {
        Bg_InitMode0();

        REG_DMA3.src = (const void *)0x081dab98;
        REG_DMA3.dst = (void *)0x05000000;
        REG_DMA3.cnt = DMA_ENABLE | 0x100;
        (void)REG_DMA3.cnt;

        REG_DMA3.src = (const void *)0x081dad98;
        REG_DMA3.dst = (void *)0x06000000;
        REG_DMA3.cnt = DMA_ENABLE | 0x4000;
        (void)REG_DMA3.cnt;

        REG_DMA3.src = (const void *)0x081e4418;
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

    REG_DMA3.src = (const void *)0x081d8b98;
    REG_DMA3.dst = (void *)0x0600e800;
    REG_DMA3.cnt = DMA_ENABLE | 0x400;
    (void)REG_DMA3.cnt;

    SaveSlot_DrawAllSlots();

    if (gIwram_34A0.reentryFlag != 0) {
        const void *const *rec = sSceneRecordTable_308110[gIwram_34B0._data];
        Scene_DrawWindow(0, 6, rec[1], 28, 0, 1);
    }

    gIwram_3480.menuStep++;
}

void FileSelect_Update(void)
{
    gIwram_5398 = Input_Poll();

    switch (gIwram_5398) {
    case 16:
    case 64: {
        const void *const *rec;
        u8 poseIdx;
        u8 finalIdx;

        Sound_Play(1);

        rec = sSceneRecordTable_308110[gIwram_34B0._data];
        if ((*(u8 *)&gSaveData >> (poseIdx = gIwram_3480.cursorIndex)) & 1) {
            if (Scene_DrawWindow(0, 6, rec[2], 28, 0, 0) == 0)
                break;
            finalIdx = gIwram_3480.cursorIndex;
        } else {
            finalIdx = poseIdx;
        }

        if (SaveSlot_DrawSelectionCursor(finalIdx) == 0)
            SaveSlot_DrawAllSlots();
        break;
    }
    case 1:
        Sound_Play(2);
        if (gIwram_3480.cursorIndex == 0) {
            gIwram_3480.cursorIndex = 3;
            break;
        }
        gIwram_3480.cursorIndex--;
        break;
    case 2: {
        /* Two read-modify-writes on the cursor byte. `next` is assigned twice, so
         * global-alloc colours it (r1) and the block keeps exactly three local
         * pseudos: agbcc's 3-qty hand sort in local-alloc is a broken compare on
         * qty numbers, which lets the base pointer (born first) take r0. See
         * docs/codegen-notes.md "local-alloc's <=3-qty hand sort". */
        u32 three;
        u32 next;

        Sound_Play(2);
        next = gIwram_3480.cursorIndex + 1;
        gIwram_3480.cursorIndex = next;
        three = 3;
        next = three & *(volatile u8 *)&gIwram_3480.cursorIndex;
        gIwram_3480.cursorIndex = next;
        break;
    }
    }

    if (gIwram_5398 == 32) {
        gIwram_5398 = 0;
        Sound_Play(0);
        gIwram_34A0.reentryFlag = 0;
        Screen_InstallOamA(0, 30, 6, 2);
        gIwram_3480.menuStep++;
    } else if (gIwram_5398 != 0 && gIwram_5398 != 16 && gIwram_5398 != 64) {
        gIwram_5398 = 0;
        SaveSlot_DrawAllSlots();
    } else {
        Sprite_CycleDmaFrame(sOamDmaCfg_08100);
    }
}

/* The adjacent save-slot routines share file-select ownership and flags. */
#include "text.h"
#include "gba/dma.h"
#include "iwram.h"
#include "save.h"
#include "types.h"

extern void TileBlit(u32 *attr, const void *src, u8 mode);
extern void DrawByteDecimal(u8 value, u8 x, u8 y, u16 a, u16 b, u8 c);
extern void DrawNumber(u16 value, u8 x, u8 y, u16 a, u16 b, u8 c, u32 forceZeros);
extern u8 CountHighestBit(u32 bits);

/* Renders the four save slots: for each populated slot draws its name, two
 * counters and a completion percentage; for each empty slot blits a
 * placeholder sprite. The slot whose index equals gIwram_3480.cursorIndex is
 * highlighted. An OAM-style attribute word is built on the stack and its
 * address handed to the sprite helpers. */
void SaveSlot_DrawAllSlots(void)
{
    u32 attr;
    u8 slotMask;
    vu16 fill; /* volatile: forces &fill to be re-materialised for the DMA src
                  store instead of being CSE'd with the fill=0 store */
    u32 *attrp;
    u8 i;
    int emptyRow; /* function-scoped so the empty-slot row byte is computed
                     before &attr is pinned (keeps the add r4 after it) */

    attr = (attr & 0xffffff00) | 0x02;
    attr = (attr & 0xffff00ff) | 0x0300;
    attr = (attr & 0x00ffffff) | 0x04000000;
    attr = (attr & 0xff00ffff) | 0x001a0000;

    slotMask = gSaveData.header.slotMask;

    fill = 0;
    REG_DMA3.src = (const void *)&fill;
    REG_DMA3.dst = (void *)0x0600f000;
    REG_DMA3.cnt = 0x81000400;
    (void)REG_DMA3.cnt;

    i = 0;
    attrp = &attr;

    for (; i <= 3; i++) {
        if ((slotMask >> i) & 1) {
            u32 mask = 0xffffff00; /* load the mask constant before attr */
            u32 byte;
            u8 y;

            attr = (attr & mask) | 0x03;
            byte = (u8)(i * 4 + 3) << 8;
            attr = (attr & 0xffff00ff) | byte;
            y = i * 4 + 4; /* shares the i*4 subexpression with the attr byte */
            TileBlit(attrp, (const void *)0x081D8398, 2);

            DrawTextGlyphs(gSaveData.slots[i].name, 3, 3, y, 0x140, 5, 2);
            DrawTextGlyphs((const u8 *)0x081BE800, 3, 12, y, 0x140, 5, 2);
            DrawByteDecimal(gSaveData.slots[i]._field5, 12, y, 0x140, 5, 2);

            if (gSaveData.slots[i]._field6 > 99) {
                DrawNumber(gSaveData.slots[i]._field6, 18, y, 0x140, 5, 2, 0);
            } else if (gSaveData.slots[i]._field6 > 9) {
                DrawNumber(gSaveData.slots[i]._field6, 19, y, 0x140, 5, 2, 0);
            } else {
                DrawNumber(gSaveData.slots[i]._field6, 20, y, 0x140, 5, 2, 0);
            }

            {
                /* `count` is assigned twice and compared directly so it stays a
                 * global-alloc pseudo (r1): a block-local count inherits r0 from
                 * the call return and the multiply ties to it instead of to the
                 * constant. `pct` only exists to pass the value as u8 without an
                 * early conversion copy. */
                int count;
                u8 pct;

                count = CountHighestBit(gSaveData.slots[i]._field0);
                count = (u8)((count * 100) >> 4);
                pct = count;

                if (count != 100) {
                    DrawByteDecimal(pct, 23, y, 0x140, 5, 2);
                } else {
                    DrawNumber(100, 22, y, 0x140, 5, 2, 0);
                }
            }

            if (gIwram_3480.cursorIndex == i) {
                Tilemap_SwapPalette((const TilemapRect *)attrp, 5, 4, 2);
                Tilemap_SwapPalette((const TilemapRect *)attrp, 7, 6, 2);
            }
        } else {
            const u32 *table = (const u32 *)0x08308ef4;
            u8 *ap = (u8 *)&attr;

            *(u8 *)attrp = 3;
            emptyRow = i * 4 + 4;
            /* keep &attr in its own register (r4) across the call, distinct
               from attrp's spill slot */
            asm("" : "+r"(ap));
            ap[1] = emptyRow;
            /* load the table base before dereferencing gIwram_34B0._data as the
               index */
            asm("" : "+r"(table));
            TileBlit((u32 *)ap, (const void *)table[gIwram_34B0._data], 2);

            if (gIwram_3480.cursorIndex == i) {
                Tilemap_SwapPalette((const TilemapRect *)ap, 5, 4, 2);
            }
        }
    }
}

#include "constants/input.h"
#include "game.h"
#include "iwram.h"
#include "save.h"
#include "sound.h"
#include "types.h"

extern void *Memcpy(void *dst, const void *src, u32 n);
extern void TileBlit(u32 *attr, const void *src, u8 arg2);
extern int SaveSlot_UpdateScreen(u8 arg0);

int SaveSlot_DrawSelectionCursor(u8 arg0)
{
    struct {
        u8 name[10];
        u8 pad[2];
        u32 attr;
    } s;

    Memcpy(s.name, (const void *)0x081BE804, 10);

    {
        u32 mask = 0xffffff00;
        s.attr = (s.attr & mask) | 0x02;
    }
    s.attr = (s.attr & 0xffff00ff) | 0x0300;
    s.attr = (s.attr & 0x00ffffff) | 0x04000000;
    s.attr = (s.attr & 0xff00ffff) | 0x001a0000;

    switch (arg0) {
    case 0:
        s.attr = (s.attr & 0xffff00ff) | 0x0300;
        break;
    case 1:
        s.attr = (s.attr & 0xffff00ff) | 0x0700;
        break;
    case 2:
        s.attr = (s.attr & 0xffff00ff) | 0x0b00;
        break;
    case 3:
        s.attr = (s.attr & 0xffff00ff) | 0x0f00;
        break;
    }

    TileBlit(&s.attr, (const void *)0x081D8398, 2);
    Tilemap_SwapPalette((const TilemapRect *)&s.attr, 5, 4, 2);
    return SaveSlot_UpdateScreen(arg0);
}

extern u16 Input_Poll(void);
extern void SaveMenu_DrawWorldInfoRow(u8 pane, const u8 *str);
extern void Sprite_AnimateFlipWithShadow(u32 *self, u16 u1, u16 u2, u8 u3, u8 count);
extern void SaveCommit(u8 slot, void *name);

extern u16 gIwram_5398;
#define gIwram_3540 (*(u8 *)0x03003540)

/* BG screenblock 30 (32x32 u16). Each save slot owns a 4-row band of it; the
 * slot's info row is drawn at (x=3, y=4) of that band by
 * SaveMenu_DrawWorldInfoRow, each initial one tile wide by two tiles tall.
 * The two glyph halves of initial i live SAVE_NAME_TOP / SAVE_NAME_BOTTOM
 * entries past column i of the band.
 *
 * Every access site forms `band` and `glyph = band + cursor` as two separate
 * locals: indexing the band inline lets agbcc fold the row offset into the
 * VRAM base constant, and summing the column inside an address expression
 * puts the cursor*2 term first (EXPAND_SUM keeps it as a MULT, and expr.c
 * orders MULT operands first). See docs/codegen-notes.md. */
#define SAVE_SLOT_BAND(slot) ((u16 *)(0x0600F000 + (slot) * 0x100))
#define SAVE_NAME_TOP        (4 * 32 + 3)
#define SAVE_NAME_BOTTOM     (5 * 32 + 3)

int SaveSlot_UpdateScreen(u8 slot)
{
    u8 name[SAVE_SLOT_NAME_LEN];
    u32 attr;
    u32 lastBlinkTick;
    u32 lastPollTick;
    u8 cursor;
    u16 glyphTop;
    u16 glyphBottom;
    u16 blinkTop;
    u16 blinkBottom;

    gIwram_5398 = 0;
    cursor = 0;
    lastBlinkTick = 0;
    lastPollTick = 0;
    name[0] = SAVE_NAME_DEFAULT;
    name[1] = SAVE_NAME_DEFAULT;
    name[2] = SAVE_NAME_DEFAULT;
    {
        u16 *band = SAVE_SLOT_BAND(slot);
        u16 *glyph = band + cursor;
        glyphTop = glyph[SAVE_NAME_TOP];
        glyphBottom = glyph[SAVE_NAME_BOTTOM];
    }
    blinkTop = 0;
    blinkBottom = 0;

    SaveMenu_DrawWorldInfoRow(slot, name);

    /* B on the first initial backs out, A on the last one confirms; anywhere
     * else those two buttons just move the cursor. */
    while (!(gIwram_5398 == INPUT_B && cursor == 0) && !(gIwram_5398 == INPUT_A && cursor == 2)) {
        switch (gIwram_5398) {
        case INPUT_UP:
            Sound_Play(2);
            if (name[cursor] > 'A')
                name[cursor]--;
            else if (name[cursor] == 'A')
                name[cursor] = 'Z';
            break;
        case INPUT_DOWN:
            Sound_Play(2);
            if (name[cursor] <= 'Y')
                name[cursor]++;
            else if (name[cursor] == 'Z')
                name[cursor] = 'A';
            break;
        case INPUT_LEFT:
        case INPUT_B:
            Sound_Play(2);
            if (cursor != 0)
                cursor--;
            break;
        case INPUT_RIGHT:
        case INPUT_A:
            Sound_Play(2);
            if (cursor != 2)
                cursor++;
            break;
        }

        if (gIwram_5398 != 0) {
            u16 *band;
            u16 *glyph;

            SaveMenu_DrawWorldInfoRow(slot, name);
            band = SAVE_SLOT_BAND(slot);
            glyph = band + cursor;
            glyphTop = glyph[SAVE_NAME_TOP];
            glyphBottom = glyph[SAVE_NAME_BOTTOM];
            blinkTop = 0;
            blinkBottom = 0;
        } else if (gGameStuff._unk00 - lastBlinkTick > 5) {
            u16 *band;
            u16 *glyph;

            blinkTop = (blinkTop == 0) ? glyphTop : 0;
            band = SAVE_SLOT_BAND(slot);
            glyph = band + cursor;
            glyph[SAVE_NAME_TOP] = blinkTop;
            blinkBottom = (blinkBottom == 0) ? glyphBottom : 0;
            glyph[SAVE_NAME_BOTTOM] = blinkBottom;
            lastBlinkTick = gGameStuff._unk00;
        }

        if (gGameStuff._unk00 - lastPollTick > 3) {
            gIwram_5398 = Input_Poll();
            lastPollTick = gGameStuff._unk00;
            Sprite_CycleDmaFrame(sOamDmaCfg_08100);
        } else {
            gIwram_5398 = 0;
        }
    }

    if (gIwram_5398 == INPUT_A) {
        u16 *band;
        u16 *glyph;

        Sound_Play(1);
        band = SAVE_SLOT_BAND(slot);
        glyph = band + cursor;
        glyph[SAVE_NAME_TOP] = glyphTop;
        glyph[SAVE_NAME_BOTTOM] = glyphBottom;

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

        Sprite_AnimateFlipWithShadow(&attr, 4, 5, 2, 10);
        gIwram_34A0.reentryFlag = 1;
        Screen_InstallOamA(1, 29, 6, 2);

        gGameStuff.unlockedWorlds = 0;
        gGameStuff.sceneType = 0;
        gGameStuff.mode = GAME_MODE_WORLD_MAP;
        gIwram_3540 = 0;
        gSaveData.header._field2 = gIwram_34B4._data[3];
        gIwram_35E0.lives = gIwram_34B4._data[2];
        gIwram_35E0.coins = 0;
        gIwram_35E0.elementsCollected = 0;
        gIwram_35E0.initials[0] = name[0];
        gIwram_35E0.initials[1] = name[1];
        gIwram_35E0.initials[2] = name[2];
        SaveCommit(gIwram_3480.cursorIndex, name);
        gEntities[0].status = 0;
        gIwram_35E0._field_10 = 0;
        gIwram_5398 = 0;
        return 1;
    }

    if (gIwram_5398 == INPUT_B)
        Sound_Play(0);
    gIwram_5398 = 0;
    return 0;
}
