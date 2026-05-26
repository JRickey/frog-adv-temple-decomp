#include "macros.h"
#include "types.h"

/* Two bit-flag leaves on an entity-record's u16 field at offset 0x2e — the
 * input-flags / "keysJust" field, same offset that mode_15's NAKED case-3
 * code reads as `[r1, #0x2e]`. Both functions were peeled together as one
 * 36-byte slice; the second has no own thumb_func_start in baserom and is
 * given the name sub_08006958 here.
 *
 * Both shipped NAKED:
 *   - sub_08006948: agbcc folds the explicit `adds r1, r2, #0` (move into
 *     the parameter register before strh) and emits the smaller
 *     `strh r2, [r0, #0x2e]`. Same shape category as the documented
 *     register-coloring drift; the smaller-by-2-bytes built form is
 *     functionally correct but byte-different.
 *   - sub_08006958: baserom's `ands r1, r0` (dest=r1, leaving r0 free for
 *     the explicit `movs r0, #{0,1}` tail) and the no-push-no-pop frame.
 *     agbcc instead does `ands r0, r1` (clobbers r0 with the masked field)
 *     and folds the false-return into the already-zero r0, picking up a
 *     push/pop wrapper. Permuter has no statement reorder that recovers
 *     this shape.
 *
 * The reference bodies in the NON_MATCHING blocks document intent for
 * the phase-3 PC port. */

#ifdef NON_MATCHING
void sub_08006948(u8 *rec, u16 mask)
{
    *(u16 *)(rec + 0x2e) &= ~mask;
}
#else
NAKED void sub_08006948(u8 *rec, u16 mask)
{
    asm(".syntax unified\n"
        "    lsls    r1, r1, #16\n"
        "    lsrs    r1, r1, #16\n"
        "    ldrh    r2, [r0, #46]\n"
        "    bics    r2, r1\n"
        "    adds    r1, r2, #0\n"
        "    strh    r1, [r0, #46]\n"
        "    bx      lr\n"
        "    .align  2, 0\n"
        ".syntax divided\n");
}
#endif

#ifdef NON_MATCHING
u8 sub_08006958(u8 *rec, u8 mask)
{
    if ((*(u16 *)(rec + 0x2e) & mask) == 0)
        return 0;
    return 1;
}
#else
NAKED u8 sub_08006958(u8 *rec, u8 mask)
{
    asm(".syntax unified\n"
        "    lsls    r1, r1, #24\n"
        "    lsrs    r1, r1, #24\n"
        "    ldrh    r0, [r0, #46]\n"
        "    ands    r1, r0\n"
        "    cmp     r1, #0\n"
        "    bne     1f\n"
        "    movs    r0, #0\n"
        "    b       2f\n"
        "1:  movs    r0, #1\n"
        "2:  bx      lr\n"
        ".syntax divided\n");
}
#endif
