@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025cec, 0x08025d14)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025cec --end 0x8025d14 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025cec: b500        push	{lr}
@   0x08025cee: b083        sub	sp, #12
@   0x08025cf0: 4907        ldr	r1, [pc, #28]	@ (0x25d10)
@   0x08025cf2: 2041        movs	r0, #65	@ 0x41
@   0x08025cf4: 9000        str	r0, [sp, #0]
@   0x08025cf6: 2001        movs	r0, #1
@   0x08025cf8: 9001        str	r0, [sp, #4]
@   0x08025cfa: 2000        movs	r0, #0
@   0x08025cfc: 9002        str	r0, [sp, #8]
@   0x08025cfe: 2002        movs	r0, #2
@   0x08025d00: 2210        movs	r2, #16
@   0x08025d02: 2304        movs	r3, #4
@   0x08025d04: f7fb        fa1c 	bl	0x21140
@   0x08025d08: b003        add	sp, #12
@   0x08025d0a: bc01        pop	{r0}
@   0x08025d0c: 4700        bx	r0
@   0x08025d0e: 0000        movs	r0, r0
@   0x08025d10: 40b8        lsls	r0, r7
@   0x08025d12: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08025CEC
sub_08025CEC: @ 0x08025cec
        .incbin "baserom.gba", 0x25cec, 0x28
        thumb_func_end sub_08025CEC
