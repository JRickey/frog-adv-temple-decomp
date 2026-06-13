@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802782c, 0x080278dc)  (176 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802782c --end 0x80278dc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802782c: b530        push	{r4, r5, lr}
@   0x0802782e: b081        sub	sp, #4
@   0x08027830: 2400        movs	r4, #0
@   0x08027832: 00e0        lsls	r0, r4, #3
@   0x08027834: 1b00        subs	r0, r0, r4
@   0x08027836: 00c0        lsls	r0, r0, #3
@   0x08027838: 4905        ldr	r1, [pc, #20]	@ (0x27850)
@   0x0802783a: 1840        adds	r0, r0, r1
@   0x0802783c: 7e81        ldrb	r1, [r0, #26]
@   0x0802783e: 2900        cmp	r1, #0
@   0x08027840: d108        bne.n	0x27854
@   0x08027842: 7ec1        ldrb	r1, [r0, #27]
@   0x08027844: 2901        cmp	r1, #1
@   0x08027846: d01c        beq.n	0x27882
@   0x08027848: 2907        cmp	r1, #7
@   0x0802784a: d127        bne.n	0x2789c
@   0x0802784c: 2106        movs	r1, #6
@   0x0802784e: e019        b.n	0x27884
@   0x08027850: 3e20        subs	r6, #32
@   0x08027852: 0300        lsls	r0, r0, #12
@   0x08027854: 2901        cmp	r1, #1
@   0x08027856: d106        bne.n	0x27866
@   0x08027858: 7ec1        ldrb	r1, [r0, #27]
@   0x0802785a: 2903        cmp	r1, #3
@   0x0802785c: d011        beq.n	0x27882
@   0x0802785e: 2909        cmp	r1, #9
@   0x08027860: d11c        bne.n	0x2789c
@   0x08027862: 2106        movs	r1, #6
@   0x08027864: e00e        b.n	0x27884
@   0x08027866: 2902        cmp	r1, #2
@   0x08027868: d106        bne.n	0x27878
@   0x0802786a: 7ec1        ldrb	r1, [r0, #27]
@   0x0802786c: 2901        cmp	r1, #1
@   0x0802786e: d008        beq.n	0x27882
@   0x08027870: 2907        cmp	r1, #7
@   0x08027872: d113        bne.n	0x2789c
@   0x08027874: 2106        movs	r1, #6
@   0x08027876: e005        b.n	0x27884
@   0x08027878: 2903        cmp	r1, #3
@   0x0802787a: d10f        bne.n	0x2789c
@   0x0802787c: 7ec1        ldrb	r1, [r0, #27]
@   0x0802787e: 2903        cmp	r1, #3
@   0x08027880: d105        bne.n	0x2788e
@   0x08027882: 2105        movs	r1, #5
@   0x08027884: 2202        movs	r2, #2
@   0x08027886: 2302        movs	r3, #2
@   0x08027888: f7f9        fac4 	bl	0x20e14
@   0x0802788c: e006        b.n	0x2789c
@   0x0802788e: 2909        cmp	r1, #9
@   0x08027890: d104        bne.n	0x2789c
@   0x08027892: 2106        movs	r1, #6
@   0x08027894: 2202        movs	r2, #2
@   0x08027896: 2302        movs	r3, #2
@   0x08027898: f7f9        fabc 	bl	0x20e14
@   0x0802789c: 1c60        adds	r0, r4, #1
@   0x0802789e: 0600        lsls	r0, r0, #24
@   0x080278a0: 0e04        lsrs	r4, r0, #24
@   0x080278a2: 2c04        cmp	r4, #4
@   0x080278a4: d9c5        bls.n	0x27832
@   0x080278a6: 490a        ldr	r1, [pc, #40]	@ (0x278d0)
@   0x080278a8: 4d0a        ldr	r5, [pc, #40]	@ (0x278d4)
@   0x080278aa: 2400        movs	r4, #0
@   0x080278ac: 9400        str	r4, [sp, #0]
@   0x080278ae: 2020        movs	r0, #32
@   0x080278b0: 2211        movs	r2, #17
@   0x080278b2: 1c2b        adds	r3, r5, #0
@   0x080278b4: f7f9        fe2c 	bl	0x21510
@   0x080278b8: 4907        ldr	r1, [pc, #28]	@ (0x278d8)
@   0x080278ba: 9400        str	r4, [sp, #0]
@   0x080278bc: 2023        movs	r0, #35	@ 0x23
@   0x080278be: 2211        movs	r2, #17
@   0x080278c0: 1c2b        adds	r3, r5, #0
@   0x080278c2: f7f9        fe25 	bl	0x21510
@   0x080278c6: b001        add	sp, #4
@   0x080278c8: bc30        pop	{r4, r5}
@   0x080278ca: bc01        pop	{r0}
@   0x080278cc: 4700        bx	r0
@   0x080278ce: 0000        movs	r0, r0
@   0x080278d0: 68a8        ldr	r0, [r5, #8]
@   0x080278d2: 0831        lsrs	r1, r6, #32
@   0x080278d4: 6110        str	r0, [r2, #16]
@   0x080278d6: 0300        lsls	r0, r0, #12
@   0x080278d8: 68c8        ldr	r0, [r1, #12]
@   0x080278da: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_0802782C
sub_0802782C: @ 0x0802782c
        .incbin "baserom.gba", 0x2782c, 0xb0
        thumb_func_end sub_0802782C
