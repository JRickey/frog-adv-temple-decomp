#include "game.h"
#include "iwram.h"
#include "types.h"

asm(".global sub_08032C18\n"
    ".thumb_set sub_08032C18, 0x08032C19\n"
    ".global sub_08032E04\n"
    ".thumb_set sub_08032E04, 0x08032E05\n"
    ".global sub_0802D5EC\n"
    ".thumb_set sub_0802D5EC, 0x0802D5ED\n"
    ".global sub_0802E344\n"
    ".thumb_set sub_0802E344, 0x0802E345\n"
    ".global sub_0802E32C\n"
    ".thumb_set sub_0802E32C, 0x0802E32D\n");

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

void sub_0801BE7C(const u8 *str, int len, int x, int y, int a, int b, int c);
void sub_0801CF18(u8 value, int x, int y, int a, int b, int c);
void sub_0802D99C(void);
u32 sub_08032C18(void *a, void *b);
void sub_08032E04(void *a, void *b, void *c);
void sub_0802D5EC(void *a, void *b);
void sub_0802E344(u32 arg);
void sub_0802E32C(u32 arg);

/* Dispatch through a ROM handler table indexed by gIwram_3480._data[2].
 * Class-sibling of sub_080201C8 (which indexes gHandlerTable_08308AD4 by the
 * same byte); the indirect call lowers to `bl _call_via_r0` and the popped
 * lr lands in r0 before bx, discarding the handler's return value. */

void sub_080202A8(void)
{
    gHandlerTable_08308AEC[gIwram_3480._data[2]]();
}

/* Trailing mode-reset helper at 0x080202c8 — shares this compilation slice
 * with sub_080202A8 (nothing in the disassembled ROM BLs to it; kept as a
 * separate symbol so the surrounding layout stays byte-identical). Snaps the
 * game back to mode 4 and clears the dispatcher state bytes. */
void sub_080202C8(void)
{
    gGameStuff.mode = 4;
    gIwram_3480._data[0] = 8;
    gIwram_3480._unk14 = 0;
    gIwram_5398 = 0;
    gIwram_3480._data[2] = 0;
    gIwram_3480._data[5] = 0;
    gIwram_34A0._pad00 = 0;
}

void sub_080202F8(u8 pane, const u8 *str)
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

    sub_0801BE7C(str, 3, 3, y, 320, 4, 2);
    sub_0801CF18(gIwram_34B4._data[2], 12, y, 320, 4, 2);
    sub_0801BE7C(sWorldTileTypeMap, 3, 18, y, 320, 4, 2);
    sub_0801CF18(0, 23, y, 320, 4, 2);
}

void sub_08020388(void)
{
    u32 i;

    gIwram_0000._field_00 = 0x2000;
    gIwram_0000._field_03 = 0;
    gIwram_0000._pad02 = 8;
    gIwram_0000._field_08 = (const void *)0x083181C0;

    sub_0802D99C();

    for (i = 0; i <= 11; i = (u8)(i + 1)) {
        *(s32 *)((u8 *)gIwram_3574 + i * 8) = -1;
    }

    if (sub_08032C18(&gIwram_0000, (void *)0x03000010) > 0x3400) {
        for (;;) {
        }
    }

    sub_08032E04((void *)0x03000010, (void *)0x03000030, (void *)0x03000020);
    sub_0802D5EC(&gIwram_0000, (void *)0x03000020);
    sub_0802E344(0xF5);
    sub_0802E32C(0xCD);
}
