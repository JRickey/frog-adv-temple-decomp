#include "iwram.h"
#include "macros.h"
#include "types.h"

/* Linker-assigned (docs/codegen-notes.md "Adjacent IWRAM bases"): keeping
 * the table opaque to agbcc holds its pool load ahead of the gIwram_3480
 * index read, matching the baserom. */
extern void (*const gHandlerTable_08308AD4[])(void);

/* Dispatch through a ROM handler table indexed by gIwram_3480._data[2].
 * Class-sibling of GameMode_Menu25 (which indexes gHandlerTable_08308058 by
 * _data[3]); the indirect call lowers to `bl _call_via_r0` and the popped
 * lr lands in r0 before bx, discarding the handler's return value. */

void GameMode_Menu07(void)
{
    gHandlerTable_08308AD4[gIwram_3480._data[2]]();
}
