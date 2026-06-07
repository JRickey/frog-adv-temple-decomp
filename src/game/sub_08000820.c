#include "types.h"
#include "game.h"
#include "gba/dma.h"
#include "gba/intr.h"
#include "gba/io.h"

extern void IntrMain(void);

/* IRQ handler vector table — src/data/irq_handler_table.c. The Timer3
 * slot is patched at runtime by Timer_SetIrqHandler(3, &sIrqHandlerTable[6]). */
extern const u32 sIrqHandlerTable[13];

/* Called from Init1. Copies the ARM `IntrMain` dispatcher into IWRAM via
 * DMA3 (the IRQ path runs from there, not ROM), points the BIOS IRQ
 * vector at the copy, then enables VBlank IRQs.
 *
 * REG_DMA3.cnt = DMA_ENABLE | 0x400 — 1024 halfword transfers = 2048 bytes,
 * which covers IntrMain + sub_08000240 + AgbMain + Init1 (the
 * whole low-ROM dispatcher cluster). */
void IrqHandler_Install(void)
{
    REG_DMA3.src = (void *)IntrMain;
    REG_DMA3.dst = (void *)0x030058A0;
    REG_DMA3.cnt = DMA_ENABLE | 0x400;
    (void)REG_DMA3.cnt;
    Timer_SetIrqHandler(3, (void *)&sIrqHandlerTable[6]);
    INTR_VECTOR = (IntrFunc)0x030058A0;
    REG_IME = 1;
    REG_IF = 0;
    REG_IE = IRQ_VBLANK | IRQ_TIMER1 | IRQ_GAMEPAK;
    REG_DISPSTAT = DISPSTAT_VBLANK_IRQ;
}

/* Two empty stubs in the gap between IrqHandler_Install's literal pool and the
 * raw .text blob at 0x0800088c. Callers TBD; kept as separate symbols so
 * the surrounding layout stays byte-identical. The Makefile's trailing
 * `.align 2, 0` emits the `0x0000` halfword pad the baserom has between
 * them — see docs/codegen-notes.md "Empty function alignment". */
void sub_08000884(void)
{}

void sub_08000888(void)
{}
