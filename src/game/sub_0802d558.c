#include "macros.h"
#include "types.h"

/* BiosSwiTable is the head of this title's libagbsyscall block — a run of
 * thin Thumb wrappers around the game's BIOS/sound SWIs (svc 12, 14..37,
 * 40, 41). It sits one slot above the SWI 11 (CpuSet) wrapper Bios_CpuSet
 * and shares the same "svc N; bx lr" shape. A handful of entries adjust a
 * register before the SWI (the `movs r0/r1, #N; svc N` forms) or unpack the
 * SWI result (the `push {r0,r1}; svc 18; pop ...; strh` MidiKey2Freq-style
 * wrapper). The block ends with the REG_IME (0x04000208) literal a
 * SoftReset-style wrapper would load.
 *
 * Shipped NAKED. agbcc 2.x has no SWI intrinsic, so `svc N` can only come
 * from inline asm — every GBA agbcc decomp keeps libagbsyscall in a
 * hand-written .s and declares the entries `extern` (cvaos, the sibling
 * Konami title, keeps this exact block in asm/libagbsyscall.s). No pure-C
 * body lowers to `svc N; bx lr`, so this is unmatchable by construction,
 * not a fold we failed to crack.
 *
 * The three real C functions that originally trailed this symbol in the
 * same 0x338 peel (the sound-init at 0x0802D5EC and the two flag-set loops
 * at 0x0802D770 / 0x0802D800) were split out into their own asm slices so
 * they remain available as proper future C-decomp targets rather than
 * being buried behind this NAKED block. */

NAKED void BiosSwiTable(void)
{
    asm(".syntax unified\n"
        "    svc     12\n" /* CpuFastSet */
        "    bx      lr\n"
        "    svc     14\n"
        "    bx      lr\n"
        "    svc     15\n"
        "    bx      lr\n"
        "    svc     16\n"
        "    bx      lr\n"
        "    svc     17\n"
        "    bx      lr\n"
        "    push    {r0, r1}\n" /* MidiKey2Freq-style: unpack SWI result */
        "    svc     18\n"
        "    pop     {r2}\n"
        "    ldrb    r3, [r2, #5]\n"
        "    ldrb    r2, [r2, #6]\n"
        "    lsls    r2, r2, #8\n"
        "    adds    r2, r2, r3\n"
        "    pop     {r3}\n"
        "    strh    r2, [r3, #0]\n"
        "    bx      lr\n"
        "    svc     19\n"
        "    bx      lr\n"
        "    svc     20\n"
        "    bx      lr\n"
        "    svc     21\n"
        "    bx      lr\n"
        "    svc     22\n"
        "    bx      lr\n"
        "    svc     23\n"
        "    bx      lr\n"
        "    svc     24\n"
        "    bx      lr\n"
        "    svc     25\n"
        "    bx      lr\n"
        "    movs    r0, #1\n"
        "    svc     25\n"
        "    bx      lr\n"
        "    movs    r0, #0\n"
        "    svc     25\n"
        "    bx      lr\n"
        "    svc     26\n"
        "    bx      lr\n"
        "    svc     27\n"
        "    bx      lr\n"
        "    svc     28\n"
        "    bx      lr\n"
        "    svc     29\n"
        "    bx      lr\n"
        "    svc     30\n"
        "    bx      lr\n"
        "    svc     40\n"
        "    bx      lr\n"
        "    svc     41\n"
        "    bx      lr\n"
        "    svc     31\n"
        "    bx      lr\n"
        "    svc     32\n"
        "    bx      lr\n"
        "    svc     33\n"
        "    bx      lr\n"
        "    svc     34\n"
        "    bx      lr\n"
        "    svc     35\n"
        "    bx      lr\n"
        "    svc     36\n"
        "    bx      lr\n"
        "    movs    r1, #1\n"
        "    svc     37\n"
        "    bx      lr\n"
        "    .align  2, 0\n"
        "    .4byte  0x04000208\n" /* REG_IME literal for a SoftReset wrapper */
        "    .4byte  0x03007F00\n" /* system-mode stack top, same wrapper pool */
        "    .syntax divided\n");
}
