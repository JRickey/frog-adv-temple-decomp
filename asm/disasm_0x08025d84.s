@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08025d84, 0x08025dac)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8025d84 --end 0x8025dac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08025d84: b500        push	{lr}
@   0x08025d86: b083        sub	sp, #12
@   0x08025d88: 4907        ldr	r1, [pc, #28]	@ (0x25da8)
@   0x08025d8a: 2061        movs	r0, #97	@ 0x61
@   0x08025d8c: 9000        str	r0, [sp, #0]
@   0x08025d8e: 2003        movs	r0, #3
@   0x08025d90: 9001        str	r0, [sp, #4]
@   0x08025d92: 2000        movs	r0, #0
@   0x08025d94: 9002        str	r0, [sp, #8]
@   0x08025d96: 2026        movs	r0, #38	@ 0x26
@   0x08025d98: 2210        movs	r2, #16
@   0x08025d9a: 230b        movs	r3, #11
@   0x08025d9c: f7fb        f9d0 	bl	0x21140
@   0x08025da0: b003        add	sp, #12
@   0x08025da2: bc01        pop	{r0}
@   0x08025da4: 4700        bx	r0
@   0x08025da6: 0000        movs	r0, r0
@   0x08025da8: 41e8        rors	r0, r5
@   0x08025daa: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08025D84
sub_08025D84: @ 0x08025d84
        .incbin "baserom.gba", 0x25d84, 0x28
        thumb_func_end sub_08025D84
