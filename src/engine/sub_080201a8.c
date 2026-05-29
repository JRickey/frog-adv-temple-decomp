#include "iwram.h"
#include "types.h"

typedef void (*GameProc)(void);

/* Dispatch tail keyed by gIwram_34A0.dispatchIdx (the byte at +1 of the
 * IWRAM state struct at 0x030034a0). Calls the handler from the ROM table
 * at 0x08308ac8 indexed by that byte. The indirect call lowers to
 * `bl _call_via_r0` (libgcc thunk at 0x08033cd8) — agbcc's standard Thumb
 * function-pointer call sequence.
 *
 * The table is a linker-assigned symbol (gDispatchTable_08308AC8) so its
 * relocated array operand evaluates before the absolute index base, matching
 * the baserom's r1-before-r0 pool order — the same idiom as sub_08019540. */

extern const GameProc gDispatchTable_08308AC8[];

void sub_080201A8(void)
{
    gDispatchTable_08308AC8[gIwram_34A0.dispatchIdx]();
}
