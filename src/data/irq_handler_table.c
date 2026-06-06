#include "macros.h"
#include "types.h"

/* IRQ handler vector table consumed by the ARM-mode `IntrMain`
 * dispatcher (0x0800012c). On each IRQ entry IntrMain reads REG_IF,
 * indexes into this table by the lowest set bit, and tail-calls the
 * matching Thumb handler via the standard Thumb-ABI low-bit
 * convention.
 *
 *   idx 0  (VBlank)  -> 0x08000791 — VBlankIntr (per-frame mixer)
 *   idx 1  (HBlank)  -> 0x0800088d — IntrHBlank
 *   idx 2  (VCount)  -> 0x08000889 — sub_08000888 (empty stub)
 *   idx 3  (Timer0)  -> 0x08000885 — sub_08000884 (empty stub)
 *   idx 4  (Timer1)  -> 0x0800090d — sub_0800090C (sound DMA timer)
 *   idx 5  (Timer2)  -> 0x08000885 — sub_08000884 (empty stub)
 *   idx 6  (Timer3)  -> 0x08000885 — sub_08000884 — patched at runtime by
 *                                    Timer_SetIrqHandler(3, &sIrqHandlerTable[6])
 *                                    to 0x080338ed when the timer-IRQ
 *                                    subsystem registers itself
 *   idx 7..12 (DMA0..3, Serial, Keypad) -> sub_08000884 stubs
 *
 * The runtime patch at idx 6 writes into ROM (no-op on real hardware;
 * the linker-initialised value at 0x08000885 stays). Either the devs
 * treated this as "best-effort registration that already happens to
 * be the default", or the table was originally meant to live in IWRAM
 * before someone refactored the dispatcher.
 *
 * Keep typed as u32 raw words (matching the sSoundOpcodeHandlers
 * scaffold pattern) until enough of the underlying IRQ handlers
 * land in C to declare them all as `extern void name(void)`. The
 * INCBIN preserves Thumb low-bit-set values verbatim.
 */

const u32 sIrqHandlerTable[13] = INCBIN_U32("data/irq/irq_handler_table.bin");
