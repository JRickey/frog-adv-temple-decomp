@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802a284, 0x0802a298)  (20 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802a284 --end 0x802a298 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802a284: 2200        movs	r2, #0
@   0x0802a286: 234b        movs	r3, #75	@ 0x4b
@   0x0802a288: f7f6        ff5a 	bl	0x21140
@   0x0802a28c: b003        add	sp, #12
@   0x0802a28e: bc01        pop	{r0}
@   0x0802a290: 4700        bx	r0
@   0x0802a292: 0000        movs	r0, r0
@   0x0802a294: 7c1c        ldrb	r4, [r3, #16]
@   0x0802a296: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802A284
sub_0802A284: @ 0x0802a284
        .incbin "baserom.gba", 0x2a284, 0x14
        thumb_func_end sub_0802A284
