@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802bc24, 0x0802bc4c)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802bc24 --end 0x802bc4c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802bc24: b500        push	{lr}
@   0x0802bc26: b083        sub	sp, #12
@   0x0802bc28: 4907        ldr	r1, [pc, #28]	@ (0x2bc48)
@   0x0802bc2a: 2089        movs	r0, #137	@ 0x89
@   0x0802bc2c: 9000        str	r0, [sp, #0]
@   0x0802bc2e: 2003        movs	r0, #3
@   0x0802bc30: 9001        str	r0, [sp, #4]
@   0x0802bc32: 2000        movs	r0, #0
@   0x0802bc34: 9002        str	r0, [sp, #8]
@   0x0802bc36: 2017        movs	r0, #23
@   0x0802bc38: 2210        movs	r2, #16
@   0x0802bc3a: 2357        movs	r3, #87	@ 0x57
@   0x0802bc3c: f7f5        fa80 	bl	0x21140
@   0x0802bc40: b003        add	sp, #12
@   0x0802bc42: bc01        pop	{r0}
@   0x0802bc44: 4700        bx	r0
@   0x0802bc46: 0000        movs	r0, r0
@   0x0802bc48: 7fd0        ldrb	r0, [r2, #31]
@   0x0802bc4a: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802BC24
sub_0802BC24: @ 0x0802bc24
        .incbin "frog_us_baserom.gba", 0x2bc24, 0x28
        thumb_func_end sub_0802BC24
