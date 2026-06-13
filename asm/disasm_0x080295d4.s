@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080295d4, 0x080295f8)  (36 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80295d4 --end 0x80295f8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080295d4: b500        push	{lr}
@   0x080295d6: b081        sub	sp, #4
@   0x080295d8: 4905        ldr	r1, [pc, #20]	@ (0x295f0)
@   0x080295da: 4b06        ldr	r3, [pc, #24]	@ (0x295f4)
@   0x080295dc: 2000        movs	r0, #0
@   0x080295de: 9000        str	r0, [sp, #0]
@   0x080295e0: 2002        movs	r0, #2
@   0x080295e2: 2202        movs	r2, #2
@   0x080295e4: f7f7        ff94 	bl	0x21510
@   0x080295e8: b001        add	sp, #4
@   0x080295ea: bc01        pop	{r0}
@   0x080295ec: 4700        bx	r0
@   0x080295ee: 0000        movs	r0, r0
@   0x080295f0: 6f64        ldr	r4, [r4, #116]	@ 0x74
@   0x080295f2: 0831        lsrs	r1, r6, #32
@   0x080295f4: 6110        str	r0, [r2, #16]
@   0x080295f6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080295D4
sub_080295D4: @ 0x080295d4
        .incbin "baserom.gba", 0x295d4, 0x24
        thumb_func_end sub_080295D4
