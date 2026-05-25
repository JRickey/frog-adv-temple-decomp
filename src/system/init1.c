#include "game.h"
#include "gba/intr.h"
#include "gba/io.h"
#include "iwram.h"
#include "types.h"

extern void sub_08020B30(void);
extern void sub_08017364(void);
extern void sub_0800072C(void);
extern void sub_08000820(void);

/* Init1: one-time setup called from AgbMain's prologue.
 *
 * Disables all hardware IRQs (REG_IE = 0), zeros the cross-subsystem
 * fields of gGameStuff (seeding the RNG with 13 along the way), primes
 * six IWRAM subsystem state blocks with their default-config bytes,
 * runs the dependent subsystem inits, zero-fills the BG-scroll shadow
 * at gIwram_3550, then turns the display back on with all four BGs +
 * OBJ enabled in 1D char-mapping mode.
 *
 * Matching depends on declaring the six IWRAM bases as link-time symbols
 * (see include/iwram.h + linker.ld). Earlier attempts using
 * `(T *)0x03003480` casts triggered agbcc 2.x's CSE-fold on adjacent
 * compile-time-constant addresses; opaque externs sidestep that. See
 * docs/codegen-notes.md "Adjacent IWRAM bases". */
void sub_08000430(void)
{
    sub_08020B30();
    REG_IE = 0;
    gGameStuff.rngSeed = 13;
    gGameStuff._unk00 = 0;
    gGameStuff._unk10 = 0;
    gGameStuff._unk18 = 0;
    gGameStuff._unk14 = 0;
    gGameStuff.pendingMode = 0;
    gGameStuff._unk04 = 0;
    gIwram_3480._data[5] = 0;
    gIwram_3480._data[0] = 0;
    gIwram_34A0._data[1] = 0;
    gIwram_34B4._data[0] = 1;
    gIwram_34B4._data[1] = 1;
    gIwram_34B4._data[2] = 5;
    gIwram_34B4._data[3] = 5;
    gIwram_35E0._data[0] = 5;
    gIwram_35E0._data[4] = 0;
    gIwram_34B0._data = 0;
    sub_08017364();
    sub_0800072C();
    gIwram_3550._data[0] = 0;
    gIwram_3550._data[1] = 0;
    gIwram_3550._data[2] = 0;
    gIwram_3550._data[3] = 0;
    gIwram_3550._data[4] = 0;
    gIwram_3550._data[5] = 0;
    gIwram_3550._data[6] = 0;
    gIwram_3550._data[7] = 0;
    sub_08000820();
    REG_DISPCNT = DISPCNT_OBJ_1D | DISPCNT_BG0_ON | DISPCNT_BG1_ON | DISPCNT_BG2_ON | DISPCNT_BG3_ON | DISPCNT_OBJ_ON;
}
