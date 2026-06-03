@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08023400, 0x08023424)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8023400 --end 0x8023424 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08023400: b500        push	{lr}
@   0x08023402: b081        sub	sp, #4
@   0x08023404: 4905        ldr	r1, [pc, #20]	@ (0x2341c)
@   0x08023406: 4b06        ldr	r3, [pc, #24]	@ (0x23420)
@   0x08023408: 2000        movs	r0, #0
@   0x0802340a: 9000        str	r0, [sp, #0]
@   0x0802340c: 203e        movs	r0, #62	@ 0x3e
@   0x0802340e: 2204        movs	r2, #4
@   0x08023410: f7fe        f87e 	bl	0x21510
@   0x08023414: b001        add	sp, #4
@   0x08023416: bc01        pop	{r0}
@   0x08023418: 4700        bx	r0
@   0x0802341a: 0000        movs	r0, r0
@   0x0802341c: 1cb0        adds	r0, r6, #2
@   0x0802341e: 0831        lsrs	r1, r6, #32
@   0x08023420: 6110        str	r0, [r2, #16]
@   0x08023422: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08023400
sub_08023400: @ 0x08023400
        .incbin "frog_us_baserom.gba", 0x23400, 0x24
        thumb_func_end sub_08023400
