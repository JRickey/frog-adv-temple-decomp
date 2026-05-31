@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080139bc, 0x080139f8)  (60 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80139bc --end 0x80139f8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080139bc: b570        push	{r4, r5, r6, lr}
@   0x080139be: b083        sub	sp, #12
@   0x080139c0: 0600        lsls	r0, r0, #24
@   0x080139c2: 0e00        lsrs	r0, r0, #24
@   0x080139c4: 4e0b        ldr	r6, [pc, #44]	@ (0x139f4)
@   0x080139c6: 0045        lsls	r5, r0, #1
@   0x080139c8: 182d        adds	r5, r5, r0
@   0x080139ca: 00ed        lsls	r5, r5, #3
@   0x080139cc: 19ac        adds	r4, r5, r6
@   0x080139ce: 7a20        ldrb	r0, [r4, #8]
@   0x080139d0: 8821        ldrh	r1, [r4, #0]
@   0x080139d2: 8862        ldrh	r2, [r4, #2]
@   0x080139d4: 88a3        ldrh	r3, [r4, #4]
@   0x080139d6: 88e4        ldrh	r4, [r4, #6]
@   0x080139d8: 9400        str	r4, [sp, #0]
@   0x080139da: 3610        adds	r6, #16
@   0x080139dc: 19ad        adds	r5, r5, r6
@   0x080139de: 682c        ldr	r4, [r5, #0]
@   0x080139e0: 9401        str	r4, [sp, #4]
@   0x080139e2: 2401        movs	r4, #1
@   0x080139e4: 9402        str	r4, [sp, #8]
@   0x080139e6: f7ff        f8ed 	bl	0x12bc4
@   0x080139ea: b003        add	sp, #12
@   0x080139ec: bc70        pop	{r4, r5, r6}
@   0x080139ee: bc01        pop	{r0}
@   0x080139f0: 4700        bx	r0
@   0x080139f2: 0000        movs	r0, r0
@   0x080139f4: 702c        strb	r4, [r5, #0]
@   0x080139f6: 0830        lsrs	r0, r6, #32

        thumb_func_start sub_080139BC
sub_080139BC: @ 0x080139bc
        .incbin "frog_us_baserom.gba", 0x139bc, 0x3c
        thumb_func_end sub_080139BC
