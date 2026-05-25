#ifndef GUARD_GBA_INTR_H
#define GUARD_GBA_INTR_H

#include "types.h"

#define REG_IE  (*(volatile u16 *)0x04000200)
#define REG_IF  (*(volatile u16 *)0x04000202)
#define REG_IME (*(volatile u16 *)0x04000208)

/* IRQ source bits — used in REG_IE (enable mask), REG_IF (pending),
 * and REG_DISPSTAT bits 3-5 (VBlank/HBlank/VCount-triggered IRQs). */
#define IRQ_VBLANK  (1U << 0)
#define IRQ_HBLANK  (1U << 1)
#define IRQ_VCOUNT  (1U << 2)
#define IRQ_TIMER0  (1U << 3)
#define IRQ_TIMER1  (1U << 4)
#define IRQ_TIMER2  (1U << 5)
#define IRQ_TIMER3  (1U << 6)
#define IRQ_SERIAL  (1U << 7)
#define IRQ_DMA0    (1U << 8)
#define IRQ_DMA1    (1U << 9)
#define IRQ_DMA2    (1U << 10)
#define IRQ_DMA3    (1U << 11)
#define IRQ_KEYPAD  (1U << 12)
#define IRQ_GAMEPAK (1U << 13)

/* User-supplied IRQ dispatcher. The BIOS reads a function pointer of
 * this signature from `INTR_VECTOR` (a fixed location at the top of
 * IWRAM) when a hardware IRQ fires. */
typedef void (*IntrFunc)(void);
#define INTR_VECTOR (*(IntrFunc *)0x03007FFC)

#endif /* GUARD_GBA_INTR_H */
