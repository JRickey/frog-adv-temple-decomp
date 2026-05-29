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
