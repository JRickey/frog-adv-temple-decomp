@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080247ac, 0x080247d4)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80247ac --end 0x80247d4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080247ac: b500        push	{lr}
@   0x080247ae: b083        sub	sp, #12
@   0x080247b0: 4907        ldr	r1, [pc, #28]	@ (0x247d0)
@   0x080247b2: 2041        movs	r0, #65	@ 0x41
@   0x080247b4: 9000        str	r0, [sp, #0]
@   0x080247b6: 2001        movs	r0, #1
@   0x080247b8: 9001        str	r0, [sp, #4]
@   0x080247ba: 2000        movs	r0, #0
@   0x080247bc: 9002        str	r0, [sp, #8]
@   0x080247be: 2002        movs	r0, #2
@   0x080247c0: 2210        movs	r2, #16
@   0x080247c2: 234b        movs	r3, #75	@ 0x4b
@   0x080247c4: f7fc        fcbc 	bl	0x21140
@   0x080247c8: b003        add	sp, #12
@   0x080247ca: bc01        pop	{r0}
@   0x080247cc: 4700        bx	r0
@   0x080247ce: 0000        movs	r0, r0
@   0x080247d0: 2eec        cmp	r6, #236	@ 0xec
@   0x080247d2: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080247AC
sub_080247AC: @ 0x080247ac
        .incbin "baserom.gba", 0x247ac, 0x28
        thumb_func_end sub_080247AC
