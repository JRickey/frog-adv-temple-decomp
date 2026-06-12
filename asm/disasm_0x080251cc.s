@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080251cc, 0x080251f4)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80251cc --end 0x80251f4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080251cc: b500        push	{lr}
@   0x080251ce: b083        sub	sp, #12
@   0x080251d0: 4907        ldr	r1, [pc, #28]	@ (0x251f0)
@   0x080251d2: 2051        movs	r0, #81	@ 0x51
@   0x080251d4: 9000        str	r0, [sp, #0]
@   0x080251d6: 2002        movs	r0, #2
@   0x080251d8: 9001        str	r0, [sp, #4]
@   0x080251da: 2000        movs	r0, #0
@   0x080251dc: 9002        str	r0, [sp, #8]
@   0x080251de: 2021        movs	r0, #33	@ 0x21
@   0x080251e0: 2210        movs	r2, #16
@   0x080251e2: 230b        movs	r3, #11
@   0x080251e4: f7fb        ffac 	bl	0x21140
@   0x080251e8: b003        add	sp, #12
@   0x080251ea: bc01        pop	{r0}
@   0x080251ec: 4700        bx	r0
@   0x080251ee: 0000        movs	r0, r0
@   0x080251f0: 34d0        adds	r4, #208	@ 0xd0
@   0x080251f2: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080251CC
sub_080251CC: @ 0x080251cc
        .incbin "baserom.gba", 0x251cc, 0x28
        thumb_func_end sub_080251CC
