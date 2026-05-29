#include "iwram.h"
#include "macros.h"
#include "types.h"

typedef void (*GameProc)(void);

/* Linker-assigned (docs/codegen-notes.md "Adjacent IWRAM bases"): keeping
 * the table opaque to agbcc holds its pool load ahead of the gIwram_3480
 * index read, matching the baserom. */
extern const GameProc gHandlerTable_0830806C[];

extern void sub_08019964(void);
extern void sub_0801932C(void);

/* Scene-dispatch tail keyed by gIwram_34A0.dispatchIdx (the byte at +1 of
 * the IWRAM state struct at 0x030034a0). When that selector is 0, dispatch
 * through the ROM handler table at 0x0830806c indexed by gIwram_3480._data[0]
 * (class-sibling of sub_08019540 / sub_08019560, which index the adjacent
 * 0x0830804c / 0x08308058 tables). Selectors 1 and 2 route to dedicated
 * handlers instead.
 *
 * The indirect call lowers to `bl _call_via_r0` (libgcc thunk at 0x08033cd8)
 * — agbcc's standard Thumb function-pointer call sequence. */

void sub_08019500(void)
{
    if (gIwram_34A0.dispatchIdx == 0) {
        gHandlerTable_0830806C[gIwram_3480._data[0]]();
    } else if (gIwram_34A0.dispatchIdx == 1) {
        sub_08019964();
    } else if (gIwram_34A0.dispatchIdx == 2) {
        sub_0801932C();
    }
}
