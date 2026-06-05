#include "gba/intr.h"
#include "macros.h"
#include "types.h"

/* IntrMain — BIOS-invoked ARM-mode IRQ dispatcher.
 *
 * The BIOS installs this handler at INTR_VECTOR (0x03007FFC) during
 * _start.  On each hardware IRQ the BIOS:
 *   1. Saves SPSR + CPSR (still in IRQ mode).
 *   2. Drops into SYS mode (0x1F) so the banked IRQ registers are no
 *      longer aliasing the SYS r13/r14.
 *   3. Reads REG_IE / REG_IF (at 0x04000200), computes the masked
 *      intersection, and checks bit 13 (GAMEPAK) first — cart removal
 *      is a fatal spin.
 *   4. Scans bits 0..12 linearly (VBlank..KEYPAD), converting the
 *      matched bit into a 4-byte aligned word-offset into sIrqHandlerTable.
 *   5. ACKs the matched bit to REG_IF, loads the handler pointer from the
 *      table, and BX-calls it (Thumb, low-bit-set convention).
 *   6. Unwinds the SYS->IRQ mode change and returns with BX lr.
 *
 * Shipped NAKED.  This is an ARM-mode function; agbcc emits Thumb code
 * only and provides no pragma or attribute to request ARM mode output.
 * The function additionally uses mrs/msr (privileged ARM instructions
 * absent from Thumb-1) and accesses a literal pool shared in fixed
 * byte-offsets with _start and sub_08000240 -- neither constraint can be
 * satisfied from C source.
 *
 * The NON_MATCHING body below documents intent for the phase-3 PC port.
 */

#ifdef NON_MATCHING

extern IntrFunc sIrqHandlerTable[13];

void IntrMain(void)
{
    u32 ie_if;
    u16 irq_bits;
    u32 offset;

    ie_if = *(volatile u32 *)0x04000200; /* REG_IE | (REG_IF << 16) */
    irq_bits = (u16)(ie_if & (ie_if >> 16));

    if (irq_bits & IRQ_GAMEPAK) {
        for (;;)
            ;
    }

    offset = 0;
    if (irq_bits & IRQ_VBLANK)
        goto dispatch;
    offset += 4;
    if (irq_bits & IRQ_HBLANK)
        goto dispatch;
    offset += 4;
    if (irq_bits & IRQ_VCOUNT)
        goto dispatch;
    offset += 4;
    if (irq_bits & IRQ_TIMER0)
        goto dispatch;
    offset += 4;
    if (irq_bits & IRQ_TIMER1)
        goto dispatch;
    offset += 4;
    if (irq_bits & IRQ_TIMER2)
        goto dispatch;
    offset += 4;
    if (irq_bits & IRQ_TIMER3)
        goto dispatch;
    offset += 4;
    if (irq_bits & IRQ_SERIAL)
        goto dispatch;
    offset += 4;
    if (irq_bits & IRQ_DMA0)
        goto dispatch;
    offset += 4;
    if (irq_bits & IRQ_DMA1)
        goto dispatch;
    offset += 4;
    if (irq_bits & IRQ_DMA2)
        goto dispatch;
    offset += 4;
    if (irq_bits & IRQ_DMA3)
        goto dispatch;
    offset += 4;
    /* irq_bits & IRQ_KEYPAD -- falls through to dispatch */

dispatch:;
    {
        IntrFunc handler = *(IntrFunc *)((u8 *)sIrqHandlerTable + offset);
        handler();
    }
}

#else

NAKED void IntrMain(void)
{
    asm(".syntax unified\n"
        /* Re-declare IntrMain as ARM type (not Thumb) so the linker resolves
         * absolute references to it at the even address 0x0800012C, without
         * the Thumb interwork bit. agbcc always emits .thumb_func before NAKED
         * labels; this .type override corrects that. */
        "    .type   IntrMain, %function\n"
        "    .arm\n"
        "    stmfd   sp!, {lr}\n"
        "    mrs     r0, SPSR\n"
        "    stmfd   sp!, {r0}\n"
        "    mrs     r0, CPSR\n"
        "    bic     r1, r0, #0x1f\n"
        "    orr     r1, r0, #0x1f\n"
        "    msr     CPSR_fc, r1\n"
        "    stmfd   sp!, {r0, lr}\n"
        "    mov     r3, #0x04000000\n"
        "    add     r3, r3, #0x200\n"
        "    ldr     r2, [r3]\n"
        "    and     r1, r2, r2, lsr #16\n"
        "    ands    r0, r1, #(1 << 13)\n"
        ".LIntrMain_gamepakLoop:\n"
        "    bne     .LIntrMain_gamepakLoop\n"
        "    mov     r2, #0\n"
        "    ands    r0, r1, #(1 << 0)\n"
        "    bne     .LIntrMain_dispatch\n"
        "    add     r2, r2, #4\n"
        "    ands    r0, r1, #(1 << 1)\n"
        "    bne     .LIntrMain_dispatch\n"
        "    add     r2, r2, #4\n"
        "    ands    r0, r1, #(1 << 2)\n"
        "    bne     .LIntrMain_dispatch\n"
        "    add     r2, r2, #4\n"
        "    ands    r0, r1, #(1 << 3)\n"
        "    bne     .LIntrMain_dispatch\n"
        "    add     r2, r2, #4\n"
        "    ands    r0, r1, #(1 << 4)\n"
        "    bne     .LIntrMain_dispatch\n"
        "    add     r2, r2, #4\n"
        "    ands    r0, r1, #(1 << 5)\n"
        "    bne     .LIntrMain_dispatch\n"
        "    add     r2, r2, #4\n"
        "    ands    r0, r1, #(1 << 6)\n"
        "    bne     .LIntrMain_dispatch\n"
        "    add     r2, r2, #4\n"
        "    ands    r0, r1, #(1 << 7)\n"
        "    bne     .LIntrMain_dispatch\n"
        "    add     r2, r2, #4\n"
        "    ands    r0, r1, #(1 << 8)\n"
        "    bne     .LIntrMain_dispatch\n"
        "    add     r2, r2, #4\n"
        "    ands    r0, r1, #(1 << 9)\n"
        "    bne     .LIntrMain_dispatch\n"
        "    add     r2, r2, #4\n"
        "    ands    r0, r1, #(1 << 10)\n"
        "    bne     .LIntrMain_dispatch\n"
        "    add     r2, r2, #4\n"
        "    ands    r0, r1, #(1 << 11)\n"
        "    bne     .LIntrMain_dispatch\n"
        "    add     r2, r2, #4\n"
        "    ands    r0, r1, #(1 << 12)\n"
        ".LIntrMain_dispatch:\n"
        "    strh    r0, [r3, #2]\n"
        "    ldr     r1, .LIntrMain_intrTable\n"
        "    add     r1, r1, r2\n"
        "    ldr     r0, [r1]\n"
        "    mov     lr, pc\n"
        "    bx      r0\n"
        "    ldmfd   sp!, {r0, lr}\n"
        "    msr     CPSR_fc, r0\n"
        "    ldmfd   sp!, {r0}\n"
        "    msr     SPSR_fc, r0\n"
        "    ldmfd   sp!, {lr}\n"
        "    bx      lr\n"
        /* Shared literal pool -- byte offsets from IntrMain's start are
         * load-bearing: _start reaches 0x0800022C and 0x08000230, and
         * sub_08000240 reaches 0x08000238 and 0x0800023C via [pc, #N]. */
        ".LIntrMain_biosVec:\n"
        "    .word   0x03007FFC\n"
        ".LIntrMain_agbMainPtr:\n"
        "    .word   0x080002A5\n"
        ".LIntrMain_intrTable:\n"
        "    .word   0x08035D9C\n"
        ".LIntrMain_word238:\n"
        "    .word   0x082F9010\n"
        ".LIntrMain_word23C:\n"
        "    .word   0x0802FFD9\n"
        "    .syntax divided\n");
}

#endif /* NON_MATCHING */
