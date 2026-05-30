@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022884, 0x080228ac)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022884 --end 0x80228ac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022884: b500        push	{lr}
@   0x08022886: b083        sub	sp, #12
@   0x08022888: 4907        ldr	r1, [pc, #28]	@ (0x228a8)
@   0x0802288a: 2051        movs	r0, #81	@ 0x51
@   0x0802288c: 9000        str	r0, [sp, #0]
@   0x0802288e: 2002        movs	r0, #2
@   0x08022890: 9001        str	r0, [sp, #4]
@   0x08022892: 2000        movs	r0, #0
@   0x08022894: 9002        str	r0, [sp, #8]
@   0x08022896: 2005        movs	r0, #5
@   0x08022898: 2200        movs	r2, #0
@   0x0802289a: 2302        movs	r3, #2
@   0x0802289c: f7fe        fc50 	bl	0x21140
@   0x080228a0: b003        add	sp, #12
@   0x080228a2: bc01        pop	{r0}
@   0x080228a4: 4700        bx	r0
@   0x080228a6: 0000        movs	r0, r0
@   0x080228a8: 0b84        lsrs	r4, r0, #14
@   0x080228aa: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_08022884
sub_08022884: @ 0x08022884
        .incbin "frog_us_baserom.gba", 0x22884, 0x28
        thumb_func_end sub_08022884
