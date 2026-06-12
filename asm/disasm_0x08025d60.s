@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025d60, 0x08025d84)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025d60 --end 0x8025d84 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025d60: b500        push	{lr}
@   0x08025d62: b081        sub	sp, #4
@   0x08025d64: 4905        ldr	r1, [pc, #20]	@ (0x25d7c)
@   0x08025d66: 4b06        ldr	r3, [pc, #24]	@ (0x25d80)
@   0x08025d68: 2000        movs	r0, #0
@   0x08025d6a: 9000        str	r0, [sp, #0]
@   0x08025d6c: 2007        movs	r0, #7
@   0x08025d6e: 2202        movs	r2, #2
@   0x08025d70: f7fb        fbce 	bl	0x21510
@   0x08025d74: b001        add	sp, #4
@   0x08025d76: bc01        pop	{r0}
@   0x08025d78: 4700        bx	r0
@   0x08025d7a: 0000        movs	r0, r0
@   0x08025d7c: 40e8        lsrs	r0, r5
@   0x08025d7e: 0831        lsrs	r1, r6, #32
@   0x08025d80: 6110        str	r0, [r2, #16]
@   0x08025d82: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08025D60
sub_08025D60: @ 0x08025d60
        .incbin "baserom.gba", 0x25d60, 0x24
        thumb_func_end sub_08025D60
