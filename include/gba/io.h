#ifndef GUARD_GBA_IO_H
#define GUARD_GBA_IO_H

#include "types.h"

/* Display registers. */
#define REG_DISPCNT  (*(volatile u16 *)0x04000000)
#define REG_DISPSTAT (*(volatile u16 *)0x04000004)
#define REG_VCOUNT   (*(volatile u16 *)0x04000006)

/* REG_DISPSTAT bits. The low 3 bits are status (VBlank/HBlank/VCount
 * flags), the next 3 are the matching IRQ enables, bits 8-15 are the
 * VCount-match threshold. */
#define DISPSTAT_VBLANK_IRQ (1U << 3)
#define DISPSTAT_HBLANK_IRQ (1U << 4)
#define DISPSTAT_VCOUNT_IRQ (1U << 5)

/* REG_DISPCNT bits. */
#define DISPCNT_MODE_MASK   7U
#define DISPCNT_OBJ_1D      (1U << 6)
#define DISPCNT_FORCE_BLANK (1U << 7)
#define DISPCNT_BG0_ON      (1U << 8)
#define DISPCNT_BG1_ON      (1U << 9)
#define DISPCNT_BG2_ON      (1U << 10)
#define DISPCNT_BG3_ON      (1U << 11)
#define DISPCNT_OBJ_ON      (1U << 12)

/* Bus / waitstate control. AgbMain's prologue writes 0x4014 here. */
#define REG_WAITCNT (*(volatile u16 *)0x04000204)

#endif /* GUARD_GBA_IO_H */
