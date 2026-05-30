@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08003bfc, 0x08003c38)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8003bfc --end 0x8003c38 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08003bfc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08003bfe: 1c04        adds	r4, r0, #0
@   0x08003c00: 1c0d        adds	r5, r1, #0
@   0x08003c02: 1c16        adds	r6, r2, #0
@   0x08003c04: 1c1f        adds	r7, r3, #0
@   0x08003c06: f006        f805 	bl	0x9c14
@   0x08003c0a: 2800        cmp	r0, #0
@   0x08003c0c: d101        bne.n	0x3c12
@   0x08003c0e: 2007        movs	r0, #7
@   0x08003c10: 7020        strb	r0, [r4, #0]
@   0x08003c12: 1c28        adds	r0, r5, #0
@   0x08003c14: 1c31        adds	r1, r6, #0
@   0x08003c16: 2206        movs	r2, #6
@   0x08003c18: f007        fdca 	bl	0xb7b0
@   0x08003c1c: 1c38        adds	r0, r7, #0
@   0x08003c1e: 9905        ldr	r1, [sp, #20]
@   0x08003c20: 2207        movs	r2, #7
@   0x08003c22: f007        fdc5 	bl	0xb7b0
@   0x08003c26: 9806        ldr	r0, [sp, #24]
@   0x08003c28: 9907        ldr	r1, [sp, #28]
@   0x08003c2a: 2216        movs	r2, #22
@   0x08003c2c: f008        f8f4 	bl	0xbe18
@   0x08003c30: bcf0        pop	{r4, r5, r6, r7}
@   0x08003c32: bc01        pop	{r0}
@   0x08003c34: 4700        bx	r0

        thumb_func_start sub_08003BFC
sub_08003BFC: @ 0x08003bfc
        .incbin "frog_us_baserom.gba", 0x3bfc, 0x3c
        thumb_func_end sub_08003BFC
