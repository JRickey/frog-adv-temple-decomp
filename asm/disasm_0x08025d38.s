@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025d38, 0x08025d60)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025d38 --end 0x8025d60 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025d38: b500        push	{lr}
@   0x08025d3a: b083        sub	sp, #12
@   0x08025d3c: 4907        ldr	r1, [pc, #28]	@ (0x25d5c)
@   0x08025d3e: 2051        movs	r0, #81	@ 0x51
@   0x08025d40: 9000        str	r0, [sp, #0]
@   0x08025d42: 2002        movs	r0, #2
@   0x08025d44: 9001        str	r0, [sp, #4]
@   0x08025d46: 2000        movs	r0, #0
@   0x08025d48: 9002        str	r0, [sp, #8]
@   0x08025d4a: 2007        movs	r0, #7
@   0x08025d4c: 2210        movs	r2, #16
@   0x08025d4e: 2302        movs	r3, #2
@   0x08025d50: f7fb        f9f6 	bl	0x21140
@   0x08025d54: b003        add	sp, #12
@   0x08025d56: bc01        pop	{r0}
@   0x08025d58: 4700        bx	r0
@   0x08025d5a: 0000        movs	r0, r0
@   0x08025d5c: 40e8        lsrs	r0, r5
@   0x08025d5e: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08025D38
sub_08025D38: @ 0x08025d38
        .incbin "baserom.gba", 0x25d38, 0x28
        thumb_func_end sub_08025D38
