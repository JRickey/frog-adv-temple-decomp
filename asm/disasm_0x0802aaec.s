@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802aaec, 0x0802ab14)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802aaec --end 0x802ab14 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802aaec: b500        push	{lr}
@   0x0802aaee: b083        sub	sp, #12
@   0x0802aaf0: 4907        ldr	r1, [pc, #28]	@ (0x2ab10)
@   0x0802aaf2: 20c1        movs	r0, #193	@ 0xc1
@   0x0802aaf4: 9000        str	r0, [sp, #0]
@   0x0802aaf6: 2002        movs	r0, #2
@   0x0802aaf8: 9001        str	r0, [sp, #4]
@   0x0802aafa: 2000        movs	r0, #0
@   0x0802aafc: 9002        str	r0, [sp, #8]
@   0x0802aafe: 200a        movs	r0, #10
@   0x0802ab00: 2210        movs	r2, #16
@   0x0802ab02: 235a        movs	r3, #90	@ 0x5a
@   0x0802ab04: f7f6        fb1c 	bl	0x21140
@   0x0802ab08: b003        add	sp, #12
@   0x0802ab0a: bc01        pop	{r0}
@   0x0802ab0c: 4700        bx	r0
@   0x0802ab0e: 0000        movs	r0, r0
@   0x0802ab10: 7dc4        ldrb	r4, [r0, #23]
@   0x0802ab12: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802AAEC
sub_0802AAEC: @ 0x0802aaec
        .incbin "frog_us_baserom.gba", 0x2aaec, 0x28
        thumb_func_end sub_0802AAEC
