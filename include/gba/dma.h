#ifndef GUARD_GBA_DMA_H
#define GUARD_GBA_DMA_H

#include "types.h"

/* A DMA channel as three consecutive 32-bit MMIO words: source pointer,
 * destination pointer, and the count+control word. Mapping the three
 * registers as a struct lets the compiler emit a single base-address
 * `ldr` plus offset stores when a function writes all three — matches
 * how the baserom typically uses these. */
typedef struct {
    const void *src; /* +0 — DMAxSAD */
    void *dst;       /* +4 — DMAxDAD */
    vu32 cnt;        /* +8 — DMAxCNT_L (count, low 16) | DMAxCNT_H (control, high 16) */
} DmaChannel;

#define REG_DMA0 (*(volatile DmaChannel *)0x040000B0)
#define REG_DMA1 (*(volatile DmaChannel *)0x040000BC)
#define REG_DMA2 (*(volatile DmaChannel *)0x040000C8)
#define REG_DMA3 (*(volatile DmaChannel *)0x040000D4)

/* High-half (CNT_H) control bits — OR these into the 32-bit `cnt` value
 * alongside the 16-bit transfer count in the low half. */
#define DMA_DST_INC       (0U << 21)
#define DMA_DST_DEC       (1U << 21)
#define DMA_DST_FIXED     (2U << 21)
#define DMA_DST_RELOAD    (3U << 21)
#define DMA_SRC_INC       (0U << 23)
#define DMA_SRC_DEC       (1U << 23)
#define DMA_SRC_FIXED     (2U << 23)
#define DMA_REPEAT        (1U << 25)
#define DMA_16BIT         (0U << 26)
#define DMA_32BIT         (1U << 26)
#define DMA_TIMING_NOW    (0U << 28)
#define DMA_TIMING_VBLANK (1U << 28)
#define DMA_TIMING_HBLANK (2U << 28)
#define DMA_TIMING_SOUND  (3U << 28)
#define DMA_IRQ_ON_END    (1U << 30)
#define DMA_ENABLE        (1U << 31)

#endif /* GUARD_GBA_DMA_H */
