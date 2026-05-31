#include "game.h"
#include "iwram.h"
#include "types.h"

/* Linker-assigned (docs/codegen-notes.md "Adjacent IWRAM bases"): keeping
 * the table opaque to agbcc holds its pool load ahead of the gIwram_3480
 * index read, matching the baserom. */
extern void (*const gHandlerTable_08308AE0[])(void);

extern u16 gIwram_5398;

/* Dispatch through a ROM handler table indexed by gIwram_3480._data[2].
 * Class-sibling of sub_080201C8 (which indexes gHandlerTable_08308AD4 by the
 * same byte); the indirect call lowers to `bl _call_via_r0` and the popped
 * lr lands in r0 before bx, discarding the handler's return value. */

void sub_080201E8(void)
{
    gHandlerTable_08308AE0[gIwram_3480._data[2]]();
}

/* Mode-reset helper at 0x08020208 — shares this compilation slice with
 * sub_080201E8 (not reached by any ROM BL; kept as a separate symbol so the
 * surrounding layout stays byte-identical). Snaps the game back to mode 4,
 * clears dispatcher state bytes, and sets _data[20] = 2. */
void sub_08020208(void)
{
    gGameStuff.mode = 4;
    gIwram_3480._data[0] = 8;
    gIwram_3480._unk14 = 2;
    gIwram_5398 = 0;
    gIwram_3480._data[2] = 0;
    gIwram_3480._data[5] = 0;
    gIwram_34A0._pad00 = 0;
}

/* Mode-reset helper at 0x0802023c — shares this compilation slice with
 * sub_080201E8 (not reached by any ROM BL; kept as a separate symbol so the
 * surrounding layout stays byte-identical). Snaps the game back to mode 4,
 * clears dispatcher state bytes, sets _data[20] = 1, and clears
 * gIwram_34A0.dispatchIdx. */
void sub_0802023C(void)
{
    gGameStuff.mode = 4;
    gIwram_3480._data[0] = 8;
    gIwram_3480._unk14 = 1;
    gIwram_5398 = 0;
    gIwram_3480._data[2] = 0;
    gIwram_3480._data[5] = 0;
    gIwram_34A0.dispatchIdx = 0;
}

extern u16 sub_08010694(u16 arg);

void sub_08020270(void)
{
    gGameStuff.mode = 4;

    gIwram_3480._data[0] = 4;
    gIwram_3480._data[5] = 0;
    gIwram_3480._data[2] = 0;
    gIwram_3480._data[1] = 0;

    gIwram_5398 = 0;

    gIwram_3480._data[6] = 1;
    gIwram_3480._data[7] = 0;

    sub_08010694(0xBF);
}
