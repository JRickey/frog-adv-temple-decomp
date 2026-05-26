@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08019540, 0x08019560)  (32 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8019540 --end 0x8019560 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08019540: b500        push	{lr}
@   0x08019542: 4905        ldr	r1, [pc, #20]	@ (0x19558)
@   0x08019544: 4805        ldr	r0, [pc, #20]	@ (0x1955c)
@   0x08019546: 7900        ldrb	r0, [r0, #4]
@   0x08019548: 0080        lsls	r0, r0, #2
@   0x0801954a: 1840        adds	r0, r0, r1
@   0x0801954c: 6800        ldr	r0, [r0, #0]
@   0x0801954e: f01a        fbc3 	bl	0x33cd8
@   0x08019552: bc01        pop	{r0}
@   0x08019554: 4700        bx	r0
@   0x08019556: 0000        movs	r0, r0
@   0x08019558: 804c        strh	r4, [r1, #2]
@   0x0801955a: 0830        lsrs	r0, r6, #32
@   0x0801955c: 3480        adds	r4, #128	@ 0x80
@   0x0801955e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08019540
sub_08019540: @ 0x08019540
        .incbin "frog_us_baserom.gba", 0x19540, 0x20
        thumb_func_end sub_08019540
