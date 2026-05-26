#include "macros.h"
#include "types.h"

/* Bit-set leaf on a u16 field at offset 16. Companion to the bit-clear
 * sub_08006948 (offset 0x2e in src/game/sub_08006948.c), called from
 * sub_080090B0 when the entity's tile-cache key changes (raises bit 0x40
 * on the dirty-flags halfword at gIwram_35E0+0x10). */

void sub_08006B88(void *p, u16 mask)
{
    *(u16 *)((u8 *)p + 16) |= mask;
}
