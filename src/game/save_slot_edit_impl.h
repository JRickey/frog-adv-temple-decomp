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
extern const u32 sOamDmaCfg_08100[4];

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
            Sprite_CycleDmaFrame(sOamDmaCfg_08100[0], sOamDmaCfg_08100[1], sOamDmaCfg_08100[2], sOamDmaCfg_08100[3]);
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
