@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080202a8, 0x080202f8)  (80 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80202a8 --end 0x80202f8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080202a8: b500        push	{lr}
@   0x080202aa: 4905        ldr	r1, [pc, #20]	@ (0x202c0)
@   0x080202ac: 4805        ldr	r0, [pc, #20]	@ (0x202c4)
@   0x080202ae: 7880        ldrb	r0, [r0, #2]
@   0x080202b0: 0080        lsls	r0, r0, #2
@   0x080202b2: 1840        adds	r0, r0, r1
@   0x080202b4: 6800        ldr	r0, [r0, #0]
@   0x080202b6: f013        fd0f 	bl	0x33cd8
@   0x080202ba: bc01        pop	{r0}
@   0x080202bc: 4700        bx	r0
@   0x080202be: 0000        movs	r0, r0
@   0x080202c0: 8aec        ldrh	r4, [r5, #22]
@   0x080202c2: 0830        lsrs	r0, r6, #32
@   0x080202c4: 3480        adds	r4, #128	@ 0x80
@   0x080202c6: 0300        lsls	r0, r0, #12
@   0x080202c8: 4907        ldr	r1, [pc, #28]	@ (0x202e8)
@   0x080202ca: 2300        movs	r3, #0
@   0x080202cc: 2004        movs	r0, #4
@   0x080202ce: 7248        strb	r0, [r1, #9]
@   0x080202d0: 4a06        ldr	r2, [pc, #24]	@ (0x202ec)
@   0x080202d2: 2008        movs	r0, #8
@   0x080202d4: 7010        strb	r0, [r2, #0]
@   0x080202d6: 7513        strb	r3, [r2, #20]
@   0x080202d8: 4805        ldr	r0, [pc, #20]	@ (0x202f0)
@   0x080202da: 2100        movs	r1, #0
@   0x080202dc: 8003        strh	r3, [r0, #0]
@   0x080202de: 7091        strb	r1, [r2, #2]
@   0x080202e0: 7151        strb	r1, [r2, #5]
@   0x080202e2: 4804        ldr	r0, [pc, #16]	@ (0x202f4)
@   0x080202e4: 7001        strb	r1, [r0, #0]
@   0x080202e6: 4770        bx	lr
@   0x080202e8: 5330        strh	r0, [r6, r4]
@   0x080202ea: 0300        lsls	r0, r0, #12
@   0x080202ec: 3480        adds	r4, #128	@ 0x80
@   0x080202ee: 0300        lsls	r0, r0, #12
@   0x080202f0: 5398        strh	r0, [r3, r6]
@   0x080202f2: 0300        lsls	r0, r0, #12
@   0x080202f4: 34a0        adds	r4, #160	@ 0xa0
@   0x080202f6: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080202A8
sub_080202A8: @ 0x080202a8
        .incbin "frog_us_baserom.gba", 0x202a8, 0x50
        thumb_func_end sub_080202A8
