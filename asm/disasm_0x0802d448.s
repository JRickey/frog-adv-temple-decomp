@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802d448, 0x0802d4ac)  (100 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802d448 --end 0x802d4ac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802d448: b530        push	{r4, r5, lr}
@   0x0802d44a: 2300        movs	r3, #0
@   0x0802d44c: 480a        ldr	r0, [pc, #40]	@ (0x2d478)
@   0x0802d44e: 2408        movs	r4, #8
@   0x0802d450: 1c02        adds	r2, r0, #0
@   0x0802d452: 32a8        adds	r2, #168	@ 0xa8
@   0x0802d454: 2113        movs	r1, #19
@   0x0802d456: 1c20        adds	r0, r4, #0
@   0x0802d458: 8e95        ldrh	r5, [r2, #52]	@ 0x34
@   0x0802d45a: 4028        ands	r0, r5
@   0x0802d45c: 2800        cmp	r0, #0
@   0x0802d45e: d002        beq.n	0x2d466
@   0x0802d460: 1c58        adds	r0, r3, #1
@   0x0802d462: 0600        lsls	r0, r0, #24
@   0x0802d464: 0e03        lsrs	r3, r0, #24
@   0x0802d466: 3238        adds	r2, #56	@ 0x38
@   0x0802d468: 3901        subs	r1, #1
@   0x0802d46a: 2900        cmp	r1, #0
@   0x0802d46c: daf3        bge.n	0x2d456
@   0x0802d46e: 2b14        cmp	r3, #20
@   0x0802d470: d004        beq.n	0x2d47c
@   0x0802d472: 2000        movs	r0, #0
@   0x0802d474: e003        b.n	0x2d47e
@   0x0802d476: 0000        movs	r0, r0
@   0x0802d478: 3720        adds	r7, #32
@   0x0802d47a: 0300        lsls	r0, r0, #12
@   0x0802d47c: 2001        movs	r0, #1
@   0x0802d47e: bc30        pop	{r4, r5}
@   0x0802d480: bc02        pop	{r1}
@   0x0802d482: 4708        bx	r1
@   0x0802d484: 4b07        ldr	r3, [pc, #28]	@ (0x2d4a4)
@   0x0802d486: 2002        movs	r0, #2
@   0x0802d488: 5e0a        ldrsh	r2, [r1, r0]
@   0x0802d48a: 00d0        lsls	r0, r2, #3
@   0x0802d48c: 1a80        subs	r0, r0, r2
@   0x0802d48e: 0040        lsls	r0, r0, #1
@   0x0802d490: 2200        movs	r2, #0
@   0x0802d492: 5e89        ldrsh	r1, [r1, r2]
@   0x0802d494: 1840        adds	r0, r0, r1
@   0x0802d496: 18c0        adds	r0, r0, r3
@   0x0802d498: 7800        ldrb	r0, [r0, #0]
@   0x0802d49a: 2800        cmp	r0, #0
@   0x0802d49c: d004        beq.n	0x2d4a8
@   0x0802d49e: 2000        movs	r0, #0
@   0x0802d4a0: e003        b.n	0x2d4aa
@   0x0802d4a2: 0000        movs	r0, r0
@   0x0802d4a4: 3610        adds	r6, #16
@   0x0802d4a6: 0300        lsls	r0, r0, #12
@   0x0802d4a8: 2001        movs	r0, #1
@   0x0802d4aa: 4770        bx	lr

        thumb_func_start sub_0802D448
sub_0802D448: @ 0x0802d448
        .incbin "frog_us_baserom.gba", 0x2d448, 0x64
        thumb_func_end sub_0802D448
