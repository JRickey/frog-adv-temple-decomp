@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002450, 0x08002484)  (52 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002450 --end 0x8002484 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002450: b500        push	{lr}
@   0x08002452: b082        sub	sp, #8
@   0x08002454: 4809        ldr	r0, [pc, #36]	@ (0x247c)
@   0x08002456: 4b0a        ldr	r3, [pc, #40]	@ (0x2480)
@   0x08002458: 2101        movs	r1, #1
@   0x0800245a: 9100        str	r1, [sp, #0]
@   0x0800245c: 2100        movs	r1, #0
@   0x0800245e: 9101        str	r1, [sp, #4]
@   0x08002460: 2119        movs	r1, #25
@   0x08002462: 2207        movs	r2, #7
@   0x08002464: f004        f892 	bl	0x658c
@   0x08002468: 2007        movs	r0, #7
@   0x0800246a: 2100        movs	r1, #0
@   0x0800246c: f00a        fd14 	bl	0xce98
@   0x08002470: f007        fc24 	bl	0x9cbc
@   0x08002474: b002        add	sp, #8
@   0x08002476: bc01        pop	{r0}
@   0x08002478: 4700        bx	r0
@   0x0800247a: 0000        movs	r0, r0
@   0x0800247c: 6110        str	r0, [r2, #16]
@   0x0800247e: 0300        lsls	r0, r0, #12
@   0x08002480: 9bf0        ldr	r3, [sp, #960]	@ 0x3c0
@   0x08002482: 082f        lsrs	r7, r5, #32

        thumb_func_start sub_08002450
sub_08002450: @ 0x08002450
        .incbin "frog_us_baserom.gba", 0x2450, 0x34
        thumb_func_end sub_08002450
