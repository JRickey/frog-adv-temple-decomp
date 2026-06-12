@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080273a8, 0x080273d0)  (40 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80273a8 --end 0x80273d0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080273a8: b500        push	{lr}
@   0x080273aa: b083        sub	sp, #12
@   0x080273ac: 4907        ldr	r1, [pc, #28]	@ (0x273cc)
@   0x080273ae: 2061        movs	r0, #97	@ 0x61
@   0x080273b0: 9000        str	r0, [sp, #0]
@   0x080273b2: 2003        movs	r0, #3
@   0x080273b4: 9001        str	r0, [sp, #4]
@   0x080273b6: 2000        movs	r0, #0
@   0x080273b8: 9002        str	r0, [sp, #8]
@   0x080273ba: 2025        movs	r0, #37	@ 0x25
@   0x080273bc: 2210        movs	r2, #16
@   0x080273be: 2304        movs	r3, #4
@   0x080273c0: f7f9        febe 	bl	0x21140
@   0x080273c4: b003        add	sp, #12
@   0x080273c6: bc01        pop	{r0}
@   0x080273c8: 4700        bx	r0
@   0x080273ca: 0000        movs	r0, r0
@   0x080273cc: 5d38        ldrb	r0, [r7, r4]
@   0x080273ce: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080273A8
sub_080273A8: @ 0x080273a8
        .incbin "baserom.gba", 0x273a8, 0x28
        thumb_func_end sub_080273A8
