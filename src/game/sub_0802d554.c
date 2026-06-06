#include "macros.h"
#include "types.h"

/* Bios_CpuSet is a thin Thumb wrapper around BIOS SWI 11 (CpuSet):
 * copy/fill `control` words (or halfwords) from `src` to `dst`. It sits
 * one slot below the SWI 12 (CpuFastSet) wrapper BiosSwiTable in the
 * same libagbsyscall block.
 *
 * Shipped NAKED. agbcc 2.x has no SWI intrinsic, so `svc 11` can only
 * come from inline asm — every GBA agbcc decomp keeps the CpuSet body in
 * a hand-written libagbsyscall.s and declares it `extern` (cvaos, the
 * sibling Konami title, does exactly this). No pure-C body lowers to
 * `svc 11; bx lr`, so this is unmatchable by construction, not a fold we
 * failed to crack. */

NAKED void Bios_CpuSet(const void *src, void *dst, u32 control)
{
    asm(".syntax unified\n"
        "    svc     11\n"
        "    bx      lr\n"
        "    .syntax divided\n");
}
