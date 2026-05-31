#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Linker-assigned (docs/codegen-notes.md "Adjacent IWRAM bases"): keeping
 * the table opaque to agbcc holds its pool load ahead of the gIwram_3480
 * index read, matching the baserom. */
extern void (*const gHandlerTable_08308058[])(void);

/* Dispatch through a ROM handler table indexed by gIwram_3480._data[3].
 * Class-sibling of sub_08019540 (which indexes by _data[4]); both share
 * the 0x08308058 table and discard the handler's return value (the popped
 * lr lands in r0 before bx). */

void sub_08019560(void)
{
    gHandlerTable_08308058[gIwram_3480._data[3]]();
}

extern void sub_08020B50(void);
extern s32 sub_08010710(void);
extern u32 sub_08000900(void);
extern u8 sub_08010694(u8 arg);

void sub_08019580(void)
{
    u32 now;

    sub_08020B50();
    gIwram_3480._data[5] = 0;
    gIwram_3608._data = 0;

    if (sub_08010710() != 0)
        return;

    now = sub_08000900();
    now -= gIwram_3480._unk0C;
    if (now <= 0x77)
        return;

    gIwram_3480._unk0C = sub_08000900();
    gIwram_3480._data[0]++;
    sub_08010694(0xBF);
}
