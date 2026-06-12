@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025d14, 0x08025d38)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025d14 --end 0x8025d38 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025d14: b500        push	{lr}
@   0x08025d16: b081        sub	sp, #4
@   0x08025d18: 4905        ldr	r1, [pc, #20]	@ (0x25d30)
@   0x08025d1a: 4b06        ldr	r3, [pc, #24]	@ (0x25d34)
@   0x08025d1c: 2000        movs	r0, #0
@   0x08025d1e: 9000        str	r0, [sp, #0]
@   0x08025d20: 2002        movs	r0, #2
@   0x08025d22: 2204        movs	r2, #4
@   0x08025d24: f7fb        fbf4 	bl	0x21510
@   0x08025d28: b001        add	sp, #4
@   0x08025d2a: bc01        pop	{r0}
@   0x08025d2c: 4700        bx	r0
@   0x08025d2e: 0000        movs	r0, r0
@   0x08025d30: 40b8        lsls	r0, r7
@   0x08025d32: 0831        lsrs	r1, r6, #32
@   0x08025d34: 6110        str	r0, [r2, #16]
@   0x08025d36: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08025D14
sub_08025D14: @ 0x08025d14
        .incbin "baserom.gba", 0x25d14, 0x24
        thumb_func_end sub_08025D14
