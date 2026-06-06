#include "game.h"
#include "iwram.h"
#include "types.h"

asm(".global sub_08032C18\n"
    ".thumb_set sub_08032C18, 0x08032C19\n");

/* Linker-assigned (docs/codegen-notes.md "Adjacent IWRAM bases"): keeping
 * the table opaque to agbcc holds its pool load ahead of the gIwram_3480
 * index read, matching the baserom. */
extern void (*const gHandlerTable_08308AEC[])(void);

extern u16 gIwram_5398;
extern const u8 sWorldTileTypeMap[];

struct IwramAt0000ForSoundInit {
    u16 _field_00;
    u8 _pad02;
    u8 _field_03;
    u32 _pad04;
    const void *_field_08;
};

extern struct IwramAt0000ForSoundInit gIwram_0000;
extern s32 gIwram_3574[];

void DrawTextGlyphs(const u8 *str, int len, int x, int y, int a, int b, int c);
void DrawByteDecimal(u8 value, int x, int y, int a, int b, int c);
void LevelLayout_SetupManager(void);
u32 sub_08032C18(void *a, void *b);
void BuildRangeTable(u32 *src, u32 value, u32 *dst);
void SoundSystem_Transfer(void *a, void *b);
void SoundSystem_SetVolCountB(u32 arg);
void SoundSystem_SetVolCountA(u32 arg);

/* Dispatch through a ROM handler table indexed by gIwram_3480._data[2].
 * Class-sibling of GameMode_Menu07 (which indexes gHandlerTable_08308AD4 by the
 * same byte); the indirect call lowers to `bl _call_via_r0` and the popped
 * lr lands in r0 before bx, discarding the handler's return value. */

void GameMode_FileSelect(void)
{
    gHandlerTable_08308AEC[gIwram_3480._data[2]]();
}

/* Trailing mode-reset helper at 0x080202c8 — shares this compilation slice
 * with GameMode_FileSelect (nothing in the disassembled ROM BLs to it; kept as a
 * separate symbol so the surrounding layout stays byte-identical). Snaps the
 * game back to mode 4 and clears the dispatcher state bytes. */
void SaveMenu_ResetDispatcher(void)
{
    gGameStuff.mode = GAME_MODE_ROUTER;
    gIwram_3480._data[0] = 8;
    gIwram_3480._unk14 = 0;
    gIwram_5398 = 0;
    gIwram_3480._data[2] = 0;
    gIwram_3480._data[5] = 0;
    gIwram_34A0._pad00 = 0;
}

void SaveMenu_DrawWorldInfoRow(u8 pane, const u8 *str)
{
    u32 y;

    switch (pane) {
    case 0:
        y = 4;
        break;
    case 1:
        y = 8;
        break;
    case 2:
        y = 12;
        break;
    case 3:
        y = 16;
        break;
    }

    DrawTextGlyphs(str, 3, 3, y, 320, 4, 2);
    DrawByteDecimal(gIwram_34B4._data[2], 12, y, 320, 4, 2);
    DrawTextGlyphs(sWorldTileTypeMap, 3, 18, y, 320, 4, 2);
    DrawByteDecimal(0, 23, y, 320, 4, 2);
}

void LevelLayout_InitManager(void)
{
    u32 i;

    gIwram_0000._field_00 = 0x2000;
    gIwram_0000._field_03 = 0;
    gIwram_0000._pad02 = 8;
    gIwram_0000._field_08 = (const void *)0x083181C0;

    LevelLayout_SetupManager();

    for (i = 0; i <= 11; i = (u8)(i + 1)) {
        *(s32 *)((u8 *)gIwram_3574 + i * 8) = -1;
    }

    if (sub_08032C18(&gIwram_0000, (void *)0x03000010) > 0x3400) {
        for (;;) {
        }
    }

    BuildRangeTable((u32 *)0x03000010, 0x03000030, (u32 *)0x03000020);
    SoundSystem_Transfer(&gIwram_0000, (void *)0x03000020);
    SoundSystem_SetVolCountB(0xF5);
    SoundSystem_SetVolCountA(0xCD);
}
