@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801a268, 0x0801a614)  (940 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801a268 --end 0x801a614 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801a268: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801a26a: 4657        mov	r7, sl
@   0x0801a26c: 464e        mov	r6, r9
@   0x0801a26e: 4645        mov	r5, r8
@   0x0801a270: b4e0        push	{r5, r6, r7}
@   0x0801a272: b083        sub	sp, #12
@   0x0801a274: 0600        lsls	r0, r0, #24
@   0x0801a276: 0e06        lsrs	r6, r0, #24
@   0x0801a278: f000        ff6c 	bl	0x1b154
@   0x0801a27c: 0600        lsls	r0, r0, #24
@   0x0801a27e: 0e00        lsrs	r0, r0, #24
@   0x0801a280: 9002        str	r0, [sp, #8]
@   0x0801a282: 2810        cmp	r0, #16
@   0x0801a284: d101        bne.n	0x1a28a
@   0x0801a286: 200f        movs	r0, #15
@   0x0801a288: 9002        str	r0, [sp, #8]
@   0x0801a28a: 9d02        ldr	r5, [sp, #8]
@   0x0801a28c: 2100        movs	r1, #0
@   0x0801a28e: 4689        mov	r9, r1
@   0x0801a290: 2200        movs	r2, #0
@   0x0801a292: 9201        str	r2, [sp, #4]
@   0x0801a294: 2001        movs	r0, #1
@   0x0801a296: 4680        mov	r8, r0
@   0x0801a298: 4668        mov	r0, sp
@   0x0801a29a: 7002        strb	r2, [r0, #0]
@   0x0801a29c: 2e00        cmp	r6, #0
@   0x0801a29e: d002        beq.n	0x1a2a6
@   0x0801a2a0: 2e02        cmp	r6, #2
@   0x0801a2a2: d009        beq.n	0x1a2b8
@   0x0801a2a4: e00f        b.n	0x1a2c6
@   0x0801a2a6: 4903        ldr	r1, [pc, #12]	@ (0x1a2b4)
@   0x0801a2a8: 7a8d        ldrb	r5, [r1, #10]
@   0x0801a2aa: 1c68        adds	r0, r5, #1
@   0x0801a2ac: 0600        lsls	r0, r0, #24
@   0x0801a2ae: 0e00        lsrs	r0, r0, #24
@   0x0801a2b0: 4682        mov	sl, r0
@   0x0801a2b2: e009        b.n	0x1a2c8
@   0x0801a2b4: 5330        strh	r0, [r6, r4]
@   0x0801a2b6: 0300        lsls	r0, r0, #12
@   0x0801a2b8: 1c68        adds	r0, r5, #1
@   0x0801a2ba: 0600        lsls	r0, r0, #24
@   0x0801a2bc: 0e05        lsrs	r5, r0, #24
@   0x0801a2be: 2d0f        cmp	r5, #15
@   0x0801a2c0: d900        bls.n	0x1a2c4
@   0x0801a2c2: 250f        movs	r5, #15
@   0x0801a2c4: 46aa        mov	sl, r5
@   0x0801a2c6: 4907        ldr	r1, [pc, #28]	@ (0x1a2e4)
@   0x0801a2c8: 2700        movs	r7, #0
@   0x0801a2ca: 7a49        ldrb	r1, [r1, #9]
@   0x0801a2cc: 291d        cmp	r1, #29
@   0x0801a2ce: d000        beq.n	0x1a2d2
@   0x0801a2d0: e196        b.n	0x1a600
@   0x0801a2d2: 2f05        cmp	r7, #5
@   0x0801a2d4: d900        bls.n	0x1a2d8
@   0x0801a2d6: e18e        b.n	0x1a5f6
@   0x0801a2d8: 00b8        lsls	r0, r7, #2
@   0x0801a2da: 4903        ldr	r1, [pc, #12]	@ (0x1a2e8)
@   0x0801a2dc: 1840        adds	r0, r0, r1
@   0x0801a2de: 6800        ldr	r0, [r0, #0]
@   0x0801a2e0: 4687        mov	pc, r0
@   0x0801a2e2: 0000        movs	r0, r0
@   0x0801a2e4: 5330        strh	r0, [r6, r4]
@   0x0801a2e6: 0300        lsls	r0, r0, #12
@   0x0801a2e8: a2ec        add	r2, pc, #944	@ (adr r2, 0x1a69c)
@   0x0801a2ea: 0801        lsrs	r1, r0, #32
@   0x0801a2ec: a304        add	r3, pc, #16	@ (adr r3, 0x1a300)
@   0x0801a2ee: 0801        lsrs	r1, r0, #32
@   0x0801a2f0: a314        add	r3, pc, #80	@ (adr r3, 0x1a344)
@   0x0801a2f2: 0801        lsrs	r1, r0, #32
@   0x0801a2f4: a344        add	r3, pc, #272	@ (adr r3, 0x1a408)
@   0x0801a2f6: 0801        lsrs	r1, r0, #32
@   0x0801a2f8: a508        add	r5, pc, #32	@ (adr r5, 0x1a31c)
@   0x0801a2fa: 0801        lsrs	r1, r0, #32
@   0x0801a2fc: a5f6        add	r5, pc, #984	@ (adr r5, 0x1a6d8)
@   0x0801a2fe: 0801        lsrs	r1, r0, #32
@   0x0801a300: a5b8        add	r5, pc, #736	@ (adr r5, 0x1a5e4)
@   0x0801a302: 0801        lsrs	r1, r0, #32
@   0x0801a304: 1c30        adds	r0, r6, #0
@   0x0801a306: f7ff        fe67 	bl	0x19fd8
@   0x0801a30a: 2701        movs	r7, #1
@   0x0801a30c: 2100        movs	r1, #0
@   0x0801a30e: 4668        mov	r0, sp
@   0x0801a310: 7001        strb	r1, [r0, #0]
@   0x0801a312: e170        b.n	0x1a5f6
@   0x0801a314: 4909        ldr	r1, [pc, #36]	@ (0x1a33c)
@   0x0801a316: 4668        mov	r0, sp
@   0x0801a318: f7ef        fef4 	bl	0xa104
@   0x0801a31c: 0600        lsls	r0, r0, #24
@   0x0801a31e: 2800        cmp	r0, #0
@   0x0801a320: d008        beq.n	0x1a334
@   0x0801a322: 2703        movs	r7, #3
@   0x0801a324: 2063        movs	r0, #99	@ 0x63
@   0x0801a326: f006        fca7 	bl	0x20c78
@   0x0801a32a: 4805        ldr	r0, [pc, #20]	@ (0x1a340)
@   0x0801a32c: 2100        movs	r1, #0
@   0x0801a32e: 6141        str	r1, [r0, #20]
@   0x0801a330: 4668        mov	r0, sp
@   0x0801a332: 7001        strb	r1, [r0, #0]
@   0x0801a334: f7e6        fad2 	bl	0x8dc
@   0x0801a338: e15d        b.n	0x1a5f6
@   0x0801a33a: 0000        movs	r0, r0
@   0x0801a33c: a0a5        add	r0, pc, #660	@ (adr r0, 0x1a5d4)
@   0x0801a33e: 0801        lsrs	r1, r0, #32
@   0x0801a340: 5330        strh	r0, [r6, r4]
@   0x0801a342: 0300        lsls	r0, r0, #12
@   0x0801a344: 4c07        ldr	r4, [pc, #28]	@ (0x1a364)
@   0x0801a346: 2000        movs	r0, #0
@   0x0801a348: 8020        strh	r0, [r4, #0]
@   0x0801a34a: f7e6        f8bb 	bl	0x4c4
@   0x0801a34e: 8020        strh	r0, [r4, #0]
@   0x0801a350: 2100        movs	r1, #0
@   0x0801a352: 4689        mov	r9, r1
@   0x0801a354: 3801        subs	r0, #1
@   0x0801a356: 280f        cmp	r0, #15
@   0x0801a358: d872        bhi.n	0x1a440
@   0x0801a35a: 0080        lsls	r0, r0, #2
@   0x0801a35c: 4902        ldr	r1, [pc, #8]	@ (0x1a368)
@   0x0801a35e: 1840        adds	r0, r0, r1
@   0x0801a360: 6800        ldr	r0, [r0, #0]
@   0x0801a362: 4687        mov	pc, r0
@   0x0801a364: 5398        strh	r0, [r3, r6]
@   0x0801a366: 0300        lsls	r0, r0, #12
@   0x0801a368: a36c        add	r3, pc, #432	@ (adr r3, 0x1a51c)
@   0x0801a36a: 0801        lsrs	r1, r0, #32
@   0x0801a36c: a3ac        add	r3, pc, #688	@ (adr r3, 0x1a620)
@   0x0801a36e: 0801        lsrs	r1, r0, #32
@   0x0801a370: a3c2        add	r3, pc, #776	@ (adr r3, 0x1a67c)
@   0x0801a372: 0801        lsrs	r1, r0, #32
@   0x0801a374: a440        add	r4, pc, #256	@ (adr r4, 0x1a478)
@   0x0801a376: 0801        lsrs	r1, r0, #32
@   0x0801a378: a3d8        add	r3, pc, #864	@ (adr r3, 0x1a6dc)
@   0x0801a37a: 0801        lsrs	r1, r0, #32
@   0x0801a37c: a440        add	r4, pc, #256	@ (adr r4, 0x1a480)
@   0x0801a37e: 0801        lsrs	r1, r0, #32
@   0x0801a380: a440        add	r4, pc, #256	@ (adr r4, 0x1a484)
@   0x0801a382: 0801        lsrs	r1, r0, #32
@   0x0801a384: a440        add	r4, pc, #256	@ (adr r4, 0x1a488)
@   0x0801a386: 0801        lsrs	r1, r0, #32
@   0x0801a388: a3f6        add	r3, pc, #984	@ (adr r3, 0x1a764)
@   0x0801a38a: 0801        lsrs	r1, r0, #32
@   0x0801a38c: a440        add	r4, pc, #256	@ (adr r4, 0x1a490)
@   0x0801a38e: 0801        lsrs	r1, r0, #32
@   0x0801a390: a440        add	r4, pc, #256	@ (adr r4, 0x1a494)
@   0x0801a392: 0801        lsrs	r1, r0, #32
@   0x0801a394: a440        add	r4, pc, #256	@ (adr r4, 0x1a498)
@   0x0801a396: 0801        lsrs	r1, r0, #32
@   0x0801a398: a440        add	r4, pc, #256	@ (adr r4, 0x1a49c)
@   0x0801a39a: 0801        lsrs	r1, r0, #32
@   0x0801a39c: a440        add	r4, pc, #256	@ (adr r4, 0x1a4a0)
@   0x0801a39e: 0801        lsrs	r1, r0, #32
@   0x0801a3a0: a440        add	r4, pc, #256	@ (adr r4, 0x1a4a4)
@   0x0801a3a2: 0801        lsrs	r1, r0, #32
@   0x0801a3a4: a440        add	r4, pc, #256	@ (adr r4, 0x1a4a8)
@   0x0801a3a6: 0801        lsrs	r1, r0, #32
@   0x0801a3a8: a414        add	r4, pc, #80	@ (adr r4, 0x1a3fc)
@   0x0801a3aa: 0801        lsrs	r1, r0, #32
@   0x0801a3ac: 1c28        adds	r0, r5, #0
@   0x0801a3ae: 3809        subs	r0, #9
@   0x0801a3b0: 0600        lsls	r0, r0, #24
@   0x0801a3b2: 0e00        lsrs	r0, r0, #24
@   0x0801a3b4: 2801        cmp	r0, #1
@   0x0801a3b6: d920        bls.n	0x1a3fa
@   0x0801a3b8: 2d0e        cmp	r5, #14
@   0x0801a3ba: d01e        beq.n	0x1a3fa
@   0x0801a3bc: 2d0d        cmp	r5, #13
@   0x0801a3be: d13f        bne.n	0x1a440
@   0x0801a3c0: e023        b.n	0x1a40a
@   0x0801a3c2: 1c28        adds	r0, r5, #0
@   0x0801a3c4: 380a        subs	r0, #10
@   0x0801a3c6: 0600        lsls	r0, r0, #24
@   0x0801a3c8: 0e00        lsrs	r0, r0, #24
@   0x0801a3ca: 2801        cmp	r0, #1
@   0x0801a3cc: d906        bls.n	0x1a3dc
@   0x0801a3ce: 2d0f        cmp	r5, #15
@   0x0801a3d0: d004        beq.n	0x1a3dc
@   0x0801a3d2: 2d0c        cmp	r5, #12
@   0x0801a3d4: d134        bne.n	0x1a440
@   0x0801a3d6: e00a        b.n	0x1a3ee
@   0x0801a3d8: 2d09        cmp	r5, #9
@   0x0801a3da: d804        bhi.n	0x1a3e6
@   0x0801a3dc: 2200        movs	r2, #0
@   0x0801a3de: 4690        mov	r8, r2
@   0x0801a3e0: 2001        movs	r0, #1
@   0x0801a3e2: 4681        mov	r9, r0
@   0x0801a3e4: e02c        b.n	0x1a440
@   0x0801a3e6: 2d0b        cmp	r5, #11
@   0x0801a3e8: d001        beq.n	0x1a3ee
@   0x0801a3ea: 2d0d        cmp	r5, #13
@   0x0801a3ec: d128        bne.n	0x1a440
@   0x0801a3ee: 2101        movs	r1, #1
@   0x0801a3f0: 4688        mov	r8, r1
@   0x0801a3f2: 4689        mov	r9, r1
@   0x0801a3f4: e024        b.n	0x1a440
@   0x0801a3f6: 2d08        cmp	r5, #8
@   0x0801a3f8: d803        bhi.n	0x1a402
@   0x0801a3fa: 2201        movs	r2, #1
@   0x0801a3fc: 4690        mov	r8, r2
@   0x0801a3fe: 4691        mov	r9, r2
@   0x0801a400: e01e        b.n	0x1a440
@   0x0801a402: 2d0c        cmp	r5, #12
@   0x0801a404: d001        beq.n	0x1a40a
@   0x0801a406: 2d0e        cmp	r5, #14
@   0x0801a408: d11a        bne.n	0x1a440
@   0x0801a40a: 2000        movs	r0, #0
@   0x0801a40c: 4680        mov	r8, r0
@   0x0801a40e: 2101        movs	r1, #1
@   0x0801a410: 4689        mov	r9, r1
@   0x0801a412: e015        b.n	0x1a440
@   0x0801a414: 1c28        adds	r0, r5, #0
@   0x0801a416: f002        f941 	bl	0x1c69c
@   0x0801a41a: 1e68        subs	r0, r5, #1
@   0x0801a41c: 2103        movs	r1, #3
@   0x0801a41e: f019        fcf9 	bl	0x33e14
@   0x0801a422: 2800        cmp	r0, #0
@   0x0801a424: d001        beq.n	0x1a42a
@   0x0801a426: 2d0e        cmp	r5, #14
@   0x0801a428: d104        bne.n	0x1a434
@   0x0801a42a: 1c28        adds	r0, r5, #0
@   0x0801a42c: f000        fb8a 	bl	0x1ab44
@   0x0801a430: 2800        cmp	r0, #0
@   0x0801a432: d005        beq.n	0x1a440
@   0x0801a434: 4808        ldr	r0, [pc, #32]	@ (0x1a458)
@   0x0801a436: 2108        movs	r1, #8
@   0x0801a438: 8dc2        ldrh	r2, [r0, #46]	@ 0x2e
@   0x0801a43a: 4311        orrs	r1, r2
@   0x0801a43c: 85c1        strh	r1, [r0, #46]	@ 0x2e
@   0x0801a43e: 2705        movs	r7, #5
@   0x0801a440: 4806        ldr	r0, [pc, #24]	@ (0x1a45c)
@   0x0801a442: 8800        ldrh	r0, [r0, #0]
@   0x0801a444: 2804        cmp	r0, #4
@   0x0801a446: d00d        beq.n	0x1a464
@   0x0801a448: 2804        cmp	r0, #4
@   0x0801a44a: dc09        bgt.n	0x1a460
@   0x0801a44c: 2802        cmp	r0, #2
@   0x0801a44e: dc30        bgt.n	0x1a4b2
@   0x0801a450: 2801        cmp	r0, #1
@   0x0801a452: db2e        blt.n	0x1a4b2
@   0x0801a454: e006        b.n	0x1a464
@   0x0801a456: 0000        movs	r0, r0
@   0x0801a458: 6110        str	r0, [r2, #16]
@   0x0801a45a: 0300        lsls	r0, r0, #12
@   0x0801a45c: 5398        strh	r0, [r3, r6]
@   0x0801a45e: 0300        lsls	r0, r0, #12
@   0x0801a460: 2808        cmp	r0, #8
@   0x0801a462: d126        bne.n	0x1a4b2
@   0x0801a464: 4648        mov	r0, r9
@   0x0801a466: 2800        cmp	r0, #0
@   0x0801a468: d023        beq.n	0x1a4b2
@   0x0801a46a: 9902        ldr	r1, [sp, #8]
@   0x0801a46c: 428d        cmp	r5, r1
@   0x0801a46e: d80e        bhi.n	0x1a48e
@   0x0801a470: 4642        mov	r2, r8
@   0x0801a472: 2a00        cmp	r2, #0
@   0x0801a474: d00e        beq.n	0x1a494
@   0x0801a476: 2063        movs	r0, #99	@ 0x63
@   0x0801a478: f006        fbfe 	bl	0x20c78
@   0x0801a47c: 1c68        adds	r0, r5, #1
@   0x0801a47e: 0600        lsls	r0, r0, #24
@   0x0801a480: 0e00        lsrs	r0, r0, #24
@   0x0801a482: 4682        mov	sl, r0
@   0x0801a484: 2703        movs	r7, #3
@   0x0801a486: 1c28        adds	r0, r5, #0
@   0x0801a488: f002        f908 	bl	0x1c69c
@   0x0801a48c: e00f        b.n	0x1a4ae
@   0x0801a48e: 4640        mov	r0, r8
@   0x0801a490: 2800        cmp	r0, #0
@   0x0801a492: d10c        bne.n	0x1a4ae
@   0x0801a494: 2d01        cmp	r5, #1
@   0x0801a496: d90a        bls.n	0x1a4ae
@   0x0801a498: 2063        movs	r0, #99	@ 0x63
@   0x0801a49a: f006        fbed 	bl	0x20c78
@   0x0801a49e: 1e68        subs	r0, r5, #1
@   0x0801a4a0: 0600        lsls	r0, r0, #24
@   0x0801a4a2: 0e00        lsrs	r0, r0, #24
@   0x0801a4a4: 4682        mov	sl, r0
@   0x0801a4a6: 2703        movs	r7, #3
@   0x0801a4a8: 1c28        adds	r0, r5, #0
@   0x0801a4aa: f002        f8f7 	bl	0x1c69c
@   0x0801a4ae: 2100        movs	r1, #0
@   0x0801a4b0: 4689        mov	r9, r1
@   0x0801a4b2: 4910        ldr	r1, [pc, #64]	@ (0x1a4f4)
@   0x0801a4b4: 2202        movs	r2, #2
@   0x0801a4b6: 5e88        ldrsh	r0, [r1, r2]
@   0x0801a4b8: 2204        movs	r2, #4
@   0x0801a4ba: 5e89        ldrsh	r1, [r1, r2]
@   0x0801a4bc: f7ee        fe40 	bl	0x9140
@   0x0801a4c0: 480d        ldr	r0, [pc, #52]	@ (0x1a4f8)
@   0x0801a4c2: 7800        ldrb	r0, [r0, #0]
@   0x0801a4c4: f000        f906 	bl	0x1a6d4
@   0x0801a4c8: 2002        movs	r0, #2
@   0x0801a4ca: f7f4        fb87 	bl	0xebdc
@   0x0801a4ce: 490b        ldr	r1, [pc, #44]	@ (0x1a4fc)
@   0x0801a4d0: 480b        ldr	r0, [pc, #44]	@ (0x1a500)
@   0x0801a4d2: 7a80        ldrb	r0, [r0, #10]
@   0x0801a4d4: 0080        lsls	r0, r0, #2
@   0x0801a4d6: 1840        adds	r0, r0, r1
@   0x0801a4d8: 6800        ldr	r0, [r0, #0]
@   0x0801a4da: f019        fbfd 	bl	0x33cd8
@   0x0801a4de: f7ef        fabb 	bl	0x9a58
@   0x0801a4e2: f7ee        fe51 	bl	0x9188
@   0x0801a4e6: f7ef        ff1f 	bl	0xa328
@   0x0801a4ea: 4906        ldr	r1, [pc, #24]	@ (0x1a504)
@   0x0801a4ec: 2000        movs	r0, #0
@   0x0801a4ee: 8008        strh	r0, [r1, #0]
@   0x0801a4f0: e081        b.n	0x1a5f6
@   0x0801a4f2: 0000        movs	r0, r0
@   0x0801a4f4: 3720        adds	r7, #32
@   0x0801a4f6: 0300        lsls	r0, r0, #12
@   0x0801a4f8: 0d84        lsrs	r4, r0, #22
@   0x0801a4fa: 080c        lsrs	r4, r1, #32
@   0x0801a4fc: 0cb8        lsrs	r0, r7, #18
@   0x0801a4fe: 080c        lsrs	r4, r1, #32
@   0x0801a500: 5330        strh	r0, [r6, r4]
@   0x0801a502: 0300        lsls	r0, r0, #12
@   0x0801a504: 5398        strh	r0, [r3, r6]
@   0x0801a506: 0300        lsls	r0, r0, #12
@   0x0801a508: 4648        mov	r0, r9
@   0x0801a50a: 2800        cmp	r0, #0
@   0x0801a50c: d101        bne.n	0x1a512
@   0x0801a50e: 2101        movs	r1, #1
@   0x0801a510: 4689        mov	r9, r1
@   0x0801a512: 9a01        ldr	r2, [sp, #4]
@   0x0801a514: 2a00        cmp	r2, #0
@   0x0801a516: d121        bne.n	0x1a55c
@   0x0801a518: 1c28        adds	r0, r5, #0
@   0x0801a51a: 1c31        adds	r1, r6, #0
@   0x0801a51c: 4642        mov	r2, r8
@   0x0801a51e: 2301        movs	r3, #1
@   0x0801a520: f7ff        fe50 	bl	0x1a1c4
@   0x0801a524: 1c28        adds	r0, r5, #0
@   0x0801a526: 1c31        adds	r1, r6, #0
@   0x0801a528: 4642        mov	r2, r8
@   0x0801a52a: 2301        movs	r3, #1
@   0x0801a52c: f7ff        fe4a 	bl	0x1a1c4
@   0x0801a530: 1c28        adds	r0, r5, #0
@   0x0801a532: 1c31        adds	r1, r6, #0
@   0x0801a534: 4642        mov	r2, r8
@   0x0801a536: 2301        movs	r3, #1
@   0x0801a538: f7ff        fe44 	bl	0x1a1c4
@   0x0801a53c: 4806        ldr	r0, [pc, #24]	@ (0x1a558)
@   0x0801a53e: 4669        mov	r1, sp
@   0x0801a540: 7909        ldrb	r1, [r1, #4]
@   0x0801a542: 7041        strb	r1, [r0, #1]
@   0x0801a544: 2201        movs	r2, #1
@   0x0801a546: 9201        str	r2, [sp, #4]
@   0x0801a548: 2e02        cmp	r6, #2
@   0x0801a54a: d154        bne.n	0x1a5f6
@   0x0801a54c: 1c28        adds	r0, r5, #0
@   0x0801a54e: f002        f8d5 	bl	0x1c6fc
@   0x0801a552: 2702        movs	r7, #2
@   0x0801a554: e04f        b.n	0x1a5f6
@   0x0801a556: 0000        movs	r0, r0
@   0x0801a558: 34c0        adds	r4, #192	@ 0xc0
@   0x0801a55a: 0300        lsls	r0, r0, #12
@   0x0801a55c: 1c28        adds	r0, r5, #0
@   0x0801a55e: 1c31        adds	r1, r6, #0
@   0x0801a560: 4642        mov	r2, r8
@   0x0801a562: 2300        movs	r3, #0
@   0x0801a564: f7ff        fe2e 	bl	0x1a1c4
@   0x0801a568: 2800        cmp	r0, #0
@   0x0801a56a: d144        bne.n	0x1a5f6
@   0x0801a56c: 2e00        cmp	r6, #0
@   0x0801a56e: d002        beq.n	0x1a576
@   0x0801a570: 2e02        cmp	r6, #2
@   0x0801a572: d00f        beq.n	0x1a594
@   0x0801a574: e01c        b.n	0x1a5b0
@   0x0801a576: 4906        ldr	r1, [pc, #24]	@ (0x1a590)
@   0x0801a578: 2008        movs	r0, #8
@   0x0801a57a: 8dca        ldrh	r2, [r1, #46]	@ 0x2e
@   0x0801a57c: 4050        eors	r0, r2
@   0x0801a57e: 85c8        strh	r0, [r1, #46]	@ 0x2e
@   0x0801a580: 4640        mov	r0, r8
@   0x0801a582: 2800        cmp	r0, #0
@   0x0801a584: d00e        beq.n	0x1a5a4
@   0x0801a586: 2d0e        cmp	r5, #14
@   0x0801a588: d811        bhi.n	0x1a5ae
@   0x0801a58a: 1c68        adds	r0, r5, #1
@   0x0801a58c: e00d        b.n	0x1a5aa
@   0x0801a58e: 0000        movs	r0, r0
@   0x0801a590: 6110        str	r0, [r2, #16]
@   0x0801a592: 0300        lsls	r0, r0, #12
@   0x0801a594: 4641        mov	r1, r8
@   0x0801a596: 2900        cmp	r1, #0
@   0x0801a598: d004        beq.n	0x1a5a4
@   0x0801a59a: 9a02        ldr	r2, [sp, #8]
@   0x0801a59c: 4295        cmp	r5, r2
@   0x0801a59e: d806        bhi.n	0x1a5ae
@   0x0801a5a0: 1c68        adds	r0, r5, #1
@   0x0801a5a2: e002        b.n	0x1a5aa
@   0x0801a5a4: 2d00        cmp	r5, #0
@   0x0801a5a6: d002        beq.n	0x1a5ae
@   0x0801a5a8: 1e68        subs	r0, r5, #1
@   0x0801a5aa: 0600        lsls	r0, r0, #24
@   0x0801a5ac: 0e05        lsrs	r5, r0, #24
@   0x0801a5ae: 2702        movs	r7, #2
@   0x0801a5b0: 1c28        adds	r0, r5, #0
@   0x0801a5b2: f002        f8a3 	bl	0x1c6fc
@   0x0801a5b6: e01e        b.n	0x1a5f6
@   0x0801a5b8: 1c28        adds	r0, r5, #0
@   0x0801a5ba: f002        f86f 	bl	0x1c69c
@   0x0801a5be: 4653        mov	r3, sl
@   0x0801a5c0: 4813        ldr	r0, [pc, #76]	@ (0x1a610)
@   0x0801a5c2: 2400        movs	r4, #0
@   0x0801a5c4: 8004        strh	r4, [r0, #0]
@   0x0801a5c6: 3004        adds	r0, #4
@   0x0801a5c8: 8004        strh	r4, [r0, #0]
@   0x0801a5ca: 3004        adds	r0, #4
@   0x0801a5cc: 8004        strh	r4, [r0, #0]
@   0x0801a5ce: 3002        adds	r0, #2
@   0x0801a5d0: 8004        strh	r4, [r0, #0]
@   0x0801a5d2: 2280        movs	r2, #128	@ 0x80
@   0x0801a5d4: 04d2        lsls	r2, r2, #19
@   0x0801a5d6: 8811        ldrh	r1, [r2, #0]
@   0x0801a5d8: 480e        ldr	r0, [pc, #56]	@ (0x1a614)
@   0x0801a5da: 4008        ands	r0, r1
@   0x0801a5dc: 8010        strh	r0, [r2, #0]
@   0x0801a5de: 8811        ldrh	r1, [r2, #0]
@   0x0801a5e0: 480d        ldr	r0, [pc, #52]	@ (0x1a618)
@   0x0801a5e2: 4008        ands	r0, r1
@   0x0801a5e4: 8010        strh	r0, [r2, #0]
@   0x0801a5e6: 2b00        cmp	r3, #0
@   0x0801a5e8: d100        bne.n	0x1a5ec
@   0x0801a5ea: 2301        movs	r3, #1
@   0x0801a5ec: 480b        ldr	r0, [pc, #44]	@ (0x1a61c)
@   0x0801a5ee: 7004        strb	r4, [r0, #0]
@   0x0801a5f0: 490b        ldr	r1, [pc, #44]	@ (0x1a620)
@   0x0801a5f2: 1dd8        adds	r0, r3, #7
@   0x0801a5f4: 7248        strb	r0, [r1, #9]
@   0x0801a5f6: 480a        ldr	r0, [pc, #40]	@ (0x1a620)
@   0x0801a5f8: 7a40        ldrb	r0, [r0, #9]
@   0x0801a5fa: 281d        cmp	r0, #29
@   0x0801a5fc: d100        bne.n	0x1a600
@   0x0801a5fe: e668        b.n	0x1a2d2
@   0x0801a600: b003        add	sp, #12
@   0x0801a602: bc38        pop	{r3, r4, r5}
@   0x0801a604: 4698        mov	r8, r3
@   0x0801a606: 46a1        mov	r9, r4
@   0x0801a608: 46aa        mov	sl, r5
@   0x0801a60a: bcf0        pop	{r4, r5, r6, r7}
@   0x0801a60c: bc01        pop	{r0}
@   0x0801a60e: 4700        bx	r0
@   0x0801a610: 0040        lsls	r0, r0, #1
@   0x0801a612: 0400        lsls	r0, r0, #16

        thumb_func_start sub_0801A268
sub_0801A268: @ 0x0801a268
        .incbin "frog_us_baserom.gba", 0x1a268, 0x3ac
        thumb_func_end sub_0801A268
