@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802d170, 0x0802d294)  (292 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802d170 --end 0x802d294 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802d170: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802d172: 4657        mov	r7, sl
@   0x0802d174: 464e        mov	r6, r9
@   0x0802d176: 4645        mov	r5, r8
@   0x0802d178: b4e0        push	{r5, r6, r7}
@   0x0802d17a: 2100        movs	r1, #0
@   0x0802d17c: 4817        ldr	r0, [pc, #92]	@ (0x2d1dc)
@   0x0802d17e: 4681        mov	r9, r0
@   0x0802d180: 22a8        movs	r2, #168	@ 0xa8
@   0x0802d182: 444a        add	r2, r9
@   0x0802d184: 4692        mov	sl, r2
@   0x0802d186: 0608        lsls	r0, r1, #24
@   0x0802d188: 1607        asrs	r7, r0, #24
@   0x0802d18a: 1cfe        adds	r6, r7, #3
@   0x0802d18c: 00f1        lsls	r1, r6, #3
@   0x0802d18e: 1b89        subs	r1, r1, r6
@   0x0802d190: 00cc        lsls	r4, r1, #3
@   0x0802d192: 4649        mov	r1, r9
@   0x0802d194: 1865        adds	r5, r4, r1
@   0x0802d196: 8eaa        ldrh	r2, [r5, #52]	@ 0x34
@   0x0802d198: 2108        movs	r1, #8
@   0x0802d19a: 4011        ands	r1, r2
@   0x0802d19c: 4680        mov	r8, r0
@   0x0802d19e: 2900        cmp	r1, #0
@   0x0802d1a0: d03c        beq.n	0x2d21c
@   0x0802d1a2: 2680        movs	r6, #128	@ 0x80
@   0x0802d1a4: 2080        movs	r0, #128	@ 0x80
@   0x0802d1a6: 4010        ands	r0, r2
@   0x0802d1a8: 2800        cmp	r0, #0
@   0x0802d1aa: d11b        bne.n	0x2d1e4
@   0x0802d1ac: 200a        movs	r0, #10
@   0x0802d1ae: f7d3        fad9 	bl	0x764
@   0x0802d1b2: 0600        lsls	r0, r0, #24
@   0x0802d1b4: 0e00        lsrs	r0, r0, #24
@   0x0802d1b6: 0081        lsls	r1, r0, #2
@   0x0802d1b8: 1809        adds	r1, r1, r0
@   0x0802d1ba: 0108        lsls	r0, r1, #4
@   0x0802d1bc: 1a40        subs	r0, r0, r1
@   0x0802d1be: 0080        lsls	r0, r0, #2
@   0x0802d1c0: 3032        adds	r0, #50	@ 0x32
@   0x0802d1c2: 1c29        adds	r1, r5, #0
@   0x0802d1c4: 3132        adds	r1, #50	@ 0x32
@   0x0802d1c6: 7008        strb	r0, [r1, #0]
@   0x0802d1c8: 8ea8        ldrh	r0, [r5, #52]	@ 0x34
@   0x0802d1ca: 4330        orrs	r0, r6
@   0x0802d1cc: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x0802d1ce: 4649        mov	r1, r9
@   0x0802d1d0: 312c        adds	r1, #44	@ 0x2c
@   0x0802d1d2: 1861        adds	r1, r4, r1
@   0x0802d1d4: 4802        ldr	r0, [pc, #8]	@ (0x2d1e0)
@   0x0802d1d6: 6800        ldr	r0, [r0, #0]
@   0x0802d1d8: 6008        str	r0, [r1, #0]
@   0x0802d1da: e04c        b.n	0x2d276
@   0x0802d1dc: 3720        adds	r7, #32
@   0x0802d1de: 0300        lsls	r0, r0, #12
@   0x0802d1e0: 5330        strh	r0, [r6, r4]
@   0x0802d1e2: 0300        lsls	r0, r0, #12
@   0x0802d1e4: 490b        ldr	r1, [pc, #44]	@ (0x2d214)
@   0x0802d1e6: 4648        mov	r0, r9
@   0x0802d1e8: 302c        adds	r0, #44	@ 0x2c
@   0x0802d1ea: 1820        adds	r0, r4, r0
@   0x0802d1ec: 6809        ldr	r1, [r1, #0]
@   0x0802d1ee: 6800        ldr	r0, [r0, #0]
@   0x0802d1f0: 1a09        subs	r1, r1, r0
@   0x0802d1f2: 1c2a        adds	r2, r5, #0
@   0x0802d1f4: 3232        adds	r2, #50	@ 0x32
@   0x0802d1f6: 7812        ldrb	r2, [r2, #0]
@   0x0802d1f8: 4291        cmp	r1, r2
@   0x0802d1fa: d93c        bls.n	0x2d276
@   0x0802d1fc: 4642        mov	r2, r8
@   0x0802d1fe: 0e11        lsrs	r1, r2, #24
@   0x0802d200: 2003        movs	r0, #3
@   0x0802d202: f000        f847 	bl	0x2d294
@   0x0802d206: 4904        ldr	r1, [pc, #16]	@ (0x2d218)
@   0x0802d208: 1c08        adds	r0, r1, #0
@   0x0802d20a: 8eaa        ldrh	r2, [r5, #52]	@ 0x34
@   0x0802d20c: 4010        ands	r0, r2
@   0x0802d20e: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x0802d210: e031        b.n	0x2d276
@   0x0802d212: 0000        movs	r0, r0
@   0x0802d214: 5330        strh	r0, [r6, r4]
@   0x0802d216: 0300        lsls	r0, r0, #12
@   0x0802d218: ff7f        0000 	vhadd.u<illegal width 64>	d16, d15, d0
@   0x0802d21c: 4809        ldr	r0, [pc, #36]	@ (0x2d244)
@   0x0802d21e: 1c31        adds	r1, r6, #0
@   0x0802d220: f7d9        fba4 	bl	0x696c
@   0x0802d224: 4640        mov	r0, r8
@   0x0802d226: 0e04        lsrs	r4, r0, #24
@   0x0802d228: 2003        movs	r0, #3
@   0x0802d22a: 1c21        adds	r1, r4, #0
@   0x0802d22c: f000        f8ee 	bl	0x2d40c
@   0x0802d230: 2800        cmp	r0, #0
@   0x0802d232: d009        beq.n	0x2d248
@   0x0802d234: 2003        movs	r0, #3
@   0x0802d236: 1c21        adds	r1, r4, #0
@   0x0802d238: f000        f88a 	bl	0x2d350
@   0x0802d23c: 2800        cmp	r0, #0
@   0x0802d23e: d122        bne.n	0x2d286
@   0x0802d240: e019        b.n	0x2d276
@   0x0802d242: 0000        movs	r0, r0
@   0x0802d244: 6110        str	r0, [r2, #16]
@   0x0802d246: 0300        lsls	r0, r0, #12
@   0x0802d248: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x0802d24a: 2280        movs	r2, #128	@ 0x80
@   0x0802d24c: 0212        lsls	r2, r2, #8
@   0x0802d24e: 1c10        adds	r0, r2, #0
@   0x0802d250: 4008        ands	r0, r1
@   0x0802d252: 2800        cmp	r0, #0
@   0x0802d254: d005        beq.n	0x2d262
@   0x0802d256: 3a01        subs	r2, #1
@   0x0802d258: 1c10        adds	r0, r2, #0
@   0x0802d25a: 4008        ands	r0, r1
@   0x0802d25c: 2102        movs	r1, #2
@   0x0802d25e: 4308        orrs	r0, r1
@   0x0802d260: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x0802d262: 0630        lsls	r0, r6, #24
@   0x0802d264: 0e00        lsrs	r0, r0, #24
@   0x0802d266: f7f3        fe69 	bl	0x20f3c
@   0x0802d26a: 00f8        lsls	r0, r7, #3
@   0x0802d26c: 1bc0        subs	r0, r0, r7
@   0x0802d26e: 00c0        lsls	r0, r0, #3
@   0x0802d270: 4450        add	r0, sl
@   0x0802d272: f7d8        fba7 	bl	0x59c4
@   0x0802d276: 2080        movs	r0, #128	@ 0x80
@   0x0802d278: 0440        lsls	r0, r0, #17
@   0x0802d27a: 4440        add	r0, r8
@   0x0802d27c: 0e01        lsrs	r1, r0, #24
@   0x0802d27e: 1600        asrs	r0, r0, #24
@   0x0802d280: 2813        cmp	r0, #19
@   0x0802d282: dc00        bgt.n	0x2d286
@   0x0802d284: e77f        b.n	0x2d186
@   0x0802d286: bc38        pop	{r3, r4, r5}
@   0x0802d288: 4698        mov	r8, r3
@   0x0802d28a: 46a1        mov	r9, r4
@   0x0802d28c: 46aa        mov	sl, r5
@   0x0802d28e: bcf0        pop	{r4, r5, r6, r7}
@   0x0802d290: bc01        pop	{r0}
@   0x0802d292: 4700        bx	r0

        thumb_func_start sub_0802D170
sub_0802D170: @ 0x0802d170
        .incbin "frog_us_baserom.gba", 0x2d170, 0x124
        thumb_func_end sub_0802D170
