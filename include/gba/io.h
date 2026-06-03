#ifndef GUARD_GBA_IO_H
#define GUARD_GBA_IO_H

#include "types.h"

/* Display registers. */
#define REG_DISPCNT  (*(volatile u16 *)0x04000000)
#define REG_DISPSTAT (*(volatile u16 *)0x04000004)
#define REG_VCOUNT   (*(volatile u16 *)0x04000006)

/* Background control registers (BG0-3). */
#define REG_BG0CNT (*(volatile u16 *)0x04000008)
#define REG_BG1CNT (*(volatile u16 *)0x0400000A)
#define REG_BG2CNT (*(volatile u16 *)0x0400000C)
#define REG_BG3CNT (*(volatile u16 *)0x0400000E)

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
#define DISPCNT_WIN0_ON     (1U << 13)
#define DISPCNT_WIN1_ON     (1U << 14)

/* Bus / waitstate control. AgbMain's prologue writes 0x4014 here. */
#define REG_WAITCNT (*(volatile u16 *)0x04000204)

/* Key input register. Active-low: bit set in the hardware means
 * NOT pressed. Bit map (low to high): A, B, SELECT, START, RIGHT,
 * LEFT, UP, DOWN, R, L. */
#define REG_KEYINPUT (*(volatile u16 *)0x04000130)

#define KEY_A        (1U << 0)
#define KEY_B        (1U << 1)
#define KEY_SELECT   (1U << 2)
#define KEY_START    (1U << 3)
#define KEY_RIGHT    (1U << 4)
#define KEY_LEFT     (1U << 5)
#define KEY_UP       (1U << 6)
#define KEY_DOWN     (1U << 7)
#define KEY_R        (1U << 8)
#define KEY_L        (1U << 9)

#endif /* GUARD_GBA_IO_H */
