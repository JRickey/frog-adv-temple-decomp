#include "game.h"
#include "iwram.h"
#include "types.h"

/* Linker-assigned (docs/codegen-notes.md "Adjacent IWRAM bases"): keeping
 * the table opaque to agbcc holds its pool load ahead of the gIwram_3480
 * index read, matching the baserom. */
extern void (*const gHandlerTable_08308AEC[])(void);

extern u16 gIwram_5398;

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
    gIwram_3480._data[20] = 0;
    gIwram_5398 = 0;
    gIwram_3480._data[2] = 0;
    gIwram_3480._data[5] = 0;
    gIwram_34A0._pad00 = 0;
}
