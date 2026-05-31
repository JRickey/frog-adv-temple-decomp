@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022958, 0x08022980)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022958 --end 0x8022980 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022958: b500        push	{lr}
@   0x0802295a: b083        sub	sp, #12
@   0x0802295c: 4907        ldr	r1, [pc, #28]	@ (0x2297c)
@   0x0802295e: 2051        movs	r0, #81	@ 0x51
@   0x08022960: 9000        str	r0, [sp, #0]
@   0x08022962: 2002        movs	r0, #2
@   0x08022964: 9001        str	r0, [sp, #4]
@   0x08022966: 2014        movs	r0, #20
@   0x08022968: 9002        str	r0, [sp, #8]
@   0x0802296a: 2002        movs	r0, #2
@   0x0802296c: 2210        movs	r2, #16
@   0x0802296e: 2302        movs	r3, #2
@   0x08022970: f7fe        fbe6 	bl	0x21140
@   0x08022974: b003        add	sp, #12
@   0x08022976: bc01        pop	{r0}
@   0x08022978: 4700        bx	r0
@   0x0802297a: 0000        movs	r0, r0
@   0x0802297c: 1418        asrs	r0, r3, #16
@   0x0802297e: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08022958
sub_08022958: @ 0x08022958
        .incbin "frog_us_baserom.gba", 0x22958, 0x28
        thumb_func_end sub_08022958
