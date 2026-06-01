@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802c200, 0x0802c3e4)  (484 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802c200 --end 0x802c3e4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802c200: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802c202: 4657        mov	r7, sl
@   0x0802c204: 464e        mov	r6, r9
@   0x0802c206: 4645        mov	r5, r8
@   0x0802c208: b4e0        push	{r5, r6, r7}
@   0x0802c20a: b081        sub	sp, #4
@   0x0802c20c: 0600        lsls	r0, r0, #24
@   0x0802c20e: 0e00        lsrs	r0, r0, #24
@   0x0802c210: 4681        mov	r9, r0
@   0x0802c212: 2200        movs	r2, #0
@   0x0802c214: 481b        ldr	r0, [pc, #108]	@ (0x2c284)
@   0x0802c216: 4680        mov	r8, r0
@   0x0802c218: 21e0        movs	r1, #224	@ 0xe0
@   0x0802c21a: 0049        lsls	r1, r1, #1
@   0x0802c21c: 4441        add	r1, r8
@   0x0802c21e: 468a        mov	sl, r1
@   0x0802c220: 0612        lsls	r2, r2, #24
@   0x0802c222: 1611        asrs	r1, r2, #24
@   0x0802c224: 3108        adds	r1, #8
@   0x0802c226: 00c8        lsls	r0, r1, #3
@   0x0802c228: 1a40        subs	r0, r0, r1
@   0x0802c22a: 00c5        lsls	r5, r0, #3
@   0x0802c22c: 4643        mov	r3, r8
@   0x0802c22e: 18ec        adds	r4, r5, r3
@   0x0802c230: 2008        movs	r0, #8
@   0x0802c232: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x0802c234: 4008        ands	r0, r1
@   0x0802c236: 1c17        adds	r7, r2, #0
@   0x0802c238: 2800        cmp	r0, #0
@   0x0802c23a: d05f        beq.n	0x2c2fc
@   0x0802c23c: 4b12        ldr	r3, [pc, #72]	@ (0x2c288)
@   0x0802c23e: 1c18        adds	r0, r3, #0
@   0x0802c240: 2103        movs	r1, #3
@   0x0802c242: 2206        movs	r2, #6
@   0x0802c244: 9300        str	r3, [sp, #0]
@   0x0802c246: f7da        faa9 	bl	0x679c
@   0x0802c24a: 0600        lsls	r0, r0, #24
@   0x0802c24c: 9b00        ldr	r3, [sp, #0]
@   0x0802c24e: 2800        cmp	r0, #0
@   0x0802c250: d154        bne.n	0x2c2fc
@   0x0802c252: 2680        movs	r6, #128	@ 0x80
@   0x0802c254: 2080        movs	r0, #128	@ 0x80
@   0x0802c256: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x0802c258: 4008        ands	r0, r1
@   0x0802c25a: 2800        cmp	r0, #0
@   0x0802c25c: d118        bne.n	0x2c290
@   0x0802c25e: 20c8        movs	r0, #200	@ 0xc8
@   0x0802c260: f7d4        fa80 	bl	0x764
@   0x0802c264: 0600        lsls	r0, r0, #24
@   0x0802c266: 0e00        lsrs	r0, r0, #24
@   0x0802c268: 3032        adds	r0, #50	@ 0x32
@   0x0802c26a: 1c21        adds	r1, r4, #0
@   0x0802c26c: 3132        adds	r1, #50	@ 0x32
@   0x0802c26e: 7008        strb	r0, [r1, #0]
@   0x0802c270: 8ea0        ldrh	r0, [r4, #52]	@ 0x34
@   0x0802c272: 4330        orrs	r0, r6
@   0x0802c274: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x0802c276: 4641        mov	r1, r8
@   0x0802c278: 312c        adds	r1, #44	@ 0x2c
@   0x0802c27a: 1869        adds	r1, r5, r1
@   0x0802c27c: 4803        ldr	r0, [pc, #12]	@ (0x2c28c)
@   0x0802c27e: 6800        ldr	r0, [r0, #0]
@   0x0802c280: 6008        str	r0, [r1, #0]
@   0x0802c282: e09f        b.n	0x2c3c4
@   0x0802c284: 3720        adds	r7, #32
@   0x0802c286: 0300        lsls	r0, r0, #12
@   0x0802c288: 6110        str	r0, [r2, #16]
@   0x0802c28a: 0300        lsls	r0, r0, #12
@   0x0802c28c: 5330        strh	r0, [r6, r4]
@   0x0802c28e: 0300        lsls	r0, r0, #12
@   0x0802c290: 490e        ldr	r1, [pc, #56]	@ (0x2c2cc)
@   0x0802c292: 4640        mov	r0, r8
@   0x0802c294: 302c        adds	r0, #44	@ 0x2c
@   0x0802c296: 1828        adds	r0, r5, r0
@   0x0802c298: 6809        ldr	r1, [r1, #0]
@   0x0802c29a: 6800        ldr	r0, [r0, #0]
@   0x0802c29c: 1a09        subs	r1, r1, r0
@   0x0802c29e: 1c20        adds	r0, r4, #0
@   0x0802c2a0: 3032        adds	r0, #50	@ 0x32
@   0x0802c2a2: 7800        ldrb	r0, [r0, #0]
@   0x0802c2a4: 4281        cmp	r1, r0
@   0x0802c2a6: d800        bhi.n	0x2c2aa
@   0x0802c2a8: e08c        b.n	0x2c3c4
@   0x0802c2aa: 1c18        adds	r0, r3, #0
@   0x0802c2ac: 3033        adds	r0, #51	@ 0x33
@   0x0802c2ae: 7800        ldrb	r0, [r0, #0]
@   0x0802c2b0: 2800        cmp	r0, #0
@   0x0802c2b2: d10d        bne.n	0x2c2d0
@   0x0802c2b4: 2003        movs	r0, #3
@   0x0802c2b6: f7d4        fa55 	bl	0x764
@   0x0802c2ba: 0600        lsls	r0, r0, #24
@   0x0802c2bc: 2800        cmp	r0, #0
@   0x0802c2be: d00c        beq.n	0x2c2da
@   0x0802c2c0: 0e3a        lsrs	r2, r7, #24
@   0x0802c2c2: 4648        mov	r0, r9
@   0x0802c2c4: 2108        movs	r1, #8
@   0x0802c2c6: f000        f88d 	bl	0x2c3e4
@   0x0802c2ca: e006        b.n	0x2c2da
@   0x0802c2cc: 5330        strh	r0, [r6, r4]
@   0x0802c2ce: 0300        lsls	r0, r0, #12
@   0x0802c2d0: 0e3a        lsrs	r2, r7, #24
@   0x0802c2d2: 4648        mov	r0, r9
@   0x0802c2d4: 2108        movs	r1, #8
@   0x0802c2d6: f000        f885 	bl	0x2c3e4
@   0x0802c2da: 163a        asrs	r2, r7, #24
@   0x0802c2dc: 1c11        adds	r1, r2, #0
@   0x0802c2de: 3108        adds	r1, #8
@   0x0802c2e0: 00c8        lsls	r0, r1, #3
@   0x0802c2e2: 1a40        subs	r0, r0, r1
@   0x0802c2e4: 00c0        lsls	r0, r0, #3
@   0x0802c2e6: 4440        add	r0, r8
@   0x0802c2e8: 4b03        ldr	r3, [pc, #12]	@ (0x2c2f8)
@   0x0802c2ea: 1c19        adds	r1, r3, #0
@   0x0802c2ec: 8e83        ldrh	r3, [r0, #52]	@ 0x34
@   0x0802c2ee: 4019        ands	r1, r3
@   0x0802c2f0: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x0802c2f2: 00d0        lsls	r0, r2, #3
@   0x0802c2f4: 1a80        subs	r0, r0, r2
@   0x0802c2f6: e049        b.n	0x2c38c
@   0x0802c2f8: ff7f        0000 	vhadd.u<illegal width 64>	d16, d15, d0
@   0x0802c2fc: 163e        asrs	r6, r7, #24
@   0x0802c2fe: 1c35        adds	r5, r6, #0
@   0x0802c300: 3508        adds	r5, #8
@   0x0802c302: 4809        ldr	r0, [pc, #36]	@ (0x2c328)
@   0x0802c304: 1c29        adds	r1, r5, #0
@   0x0802c306: f7da        fb31 	bl	0x696c
@   0x0802c30a: 0e3c        lsrs	r4, r7, #24
@   0x0802c30c: 2008        movs	r0, #8
@   0x0802c30e: 1c21        adds	r1, r4, #0
@   0x0802c310: f000        f966 	bl	0x2c5e0
@   0x0802c314: 2800        cmp	r0, #0
@   0x0802c316: d009        beq.n	0x2c32c
@   0x0802c318: 2008        movs	r0, #8
@   0x0802c31a: 1c21        adds	r1, r4, #0
@   0x0802c31c: f000        f990 	bl	0x2c640
@   0x0802c320: 2800        cmp	r0, #0
@   0x0802c322: d157        bne.n	0x2c3d4
@   0x0802c324: e04e        b.n	0x2c3c4
@   0x0802c326: 0000        movs	r0, r0
@   0x0802c328: 6110        str	r0, [r2, #16]
@   0x0802c32a: 0300        lsls	r0, r0, #12
@   0x0802c32c: 490e        ldr	r1, [pc, #56]	@ (0x2c368)
@   0x0802c32e: 00e8        lsls	r0, r5, #3
@   0x0802c330: 1b40        subs	r0, r0, r5
@   0x0802c332: 00c0        lsls	r0, r0, #3
@   0x0802c334: 1842        adds	r2, r0, r1
@   0x0802c336: 7e90        ldrb	r0, [r2, #26]
@   0x0802c338: 2805        cmp	r0, #5
@   0x0802c33a: d92c        bls.n	0x2c396
@   0x0802c33c: 8e91        ldrh	r1, [r2, #52]	@ 0x34
@   0x0802c33e: 2380        movs	r3, #128	@ 0x80
@   0x0802c340: 021b        lsls	r3, r3, #8
@   0x0802c342: 1c18        adds	r0, r3, #0
@   0x0802c344: 4008        ands	r0, r1
@   0x0802c346: 2800        cmp	r0, #0
@   0x0802c348: d01d        beq.n	0x2c386
@   0x0802c34a: 3b01        subs	r3, #1
@   0x0802c34c: 1c18        adds	r0, r3, #0
@   0x0802c34e: 1c0b        adds	r3, r1, #0
@   0x0802c350: 4003        ands	r3, r0
@   0x0802c352: 2100        movs	r1, #0
@   0x0802c354: 8693        strh	r3, [r2, #52]	@ 0x34
@   0x0802c356: 7e90        ldrb	r0, [r2, #26]
@   0x0802c358: 2807        cmp	r0, #7
@   0x0802c35a: d00c        beq.n	0x2c376
@   0x0802c35c: 2807        cmp	r0, #7
@   0x0802c35e: dc05        bgt.n	0x2c36c
@   0x0802c360: 2806        cmp	r0, #6
@   0x0802c362: d006        beq.n	0x2c372
@   0x0802c364: e00f        b.n	0x2c386
@   0x0802c366: 0000        movs	r0, r0
@   0x0802c368: 3720        adds	r7, #32
@   0x0802c36a: 0300        lsls	r0, r0, #12
@   0x0802c36c: 2808        cmp	r0, #8
@   0x0802c36e: d004        beq.n	0x2c37a
@   0x0802c370: e009        b.n	0x2c386
@   0x0802c372: 7691        strb	r1, [r2, #26]
@   0x0802c374: e003        b.n	0x2c37e
@   0x0802c376: 2002        movs	r0, #2
@   0x0802c378: e000        b.n	0x2c37c
@   0x0802c37a: 2004        movs	r0, #4
@   0x0802c37c: 7690        strb	r0, [r2, #26]
@   0x0802c37e: 2102        movs	r1, #2
@   0x0802c380: 1c18        adds	r0, r3, #0
@   0x0802c382: 4308        orrs	r0, r1
@   0x0802c384: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x0802c386: 1639        asrs	r1, r7, #24
@   0x0802c388: 00c8        lsls	r0, r1, #3
@   0x0802c38a: 1a40        subs	r0, r0, r1
@   0x0802c38c: 00c0        lsls	r0, r0, #3
@   0x0802c38e: 4450        add	r0, sl
@   0x0802c390: f7d9        fb18 	bl	0x59c4
@   0x0802c394: e016        b.n	0x2c3c4
@   0x0802c396: 8e91        ldrh	r1, [r2, #52]	@ 0x34
@   0x0802c398: 2380        movs	r3, #128	@ 0x80
@   0x0802c39a: 021b        lsls	r3, r3, #8
@   0x0802c39c: 1c18        adds	r0, r3, #0
@   0x0802c39e: 4008        ands	r0, r1
@   0x0802c3a0: 2800        cmp	r0, #0
@   0x0802c3a2: d005        beq.n	0x2c3b0
@   0x0802c3a4: 3b01        subs	r3, #1
@   0x0802c3a6: 1c18        adds	r0, r3, #0
@   0x0802c3a8: 4008        ands	r0, r1
@   0x0802c3aa: 2102        movs	r1, #2
@   0x0802c3ac: 4308        orrs	r0, r1
@   0x0802c3ae: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x0802c3b0: 0628        lsls	r0, r5, #24
@   0x0802c3b2: 0e00        lsrs	r0, r0, #24
@   0x0802c3b4: f7f4        fdc2 	bl	0x20f3c
@   0x0802c3b8: 00f0        lsls	r0, r6, #3
@   0x0802c3ba: 1b80        subs	r0, r0, r6
@   0x0802c3bc: 00c0        lsls	r0, r0, #3
@   0x0802c3be: 4450        add	r0, sl
@   0x0802c3c0: f7d9        fb00 	bl	0x59c4
@   0x0802c3c4: 2180        movs	r1, #128	@ 0x80
@   0x0802c3c6: 0449        lsls	r1, r1, #17
@   0x0802c3c8: 1878        adds	r0, r7, r1
@   0x0802c3ca: 0e02        lsrs	r2, r0, #24
@   0x0802c3cc: 1600        asrs	r0, r0, #24
@   0x0802c3ce: 280d        cmp	r0, #13
@   0x0802c3d0: dc00        bgt.n	0x2c3d4
@   0x0802c3d2: e725        b.n	0x2c220
@   0x0802c3d4: b001        add	sp, #4
@   0x0802c3d6: bc38        pop	{r3, r4, r5}
@   0x0802c3d8: 4698        mov	r8, r3
@   0x0802c3da: 46a1        mov	r9, r4
@   0x0802c3dc: 46aa        mov	sl, r5
@   0x0802c3de: bcf0        pop	{r4, r5, r6, r7}
@   0x0802c3e0: bc01        pop	{r0}
@   0x0802c3e2: 4700        bx	r0

        thumb_func_start sub_0802C200
sub_0802C200: @ 0x0802c200
        .incbin "frog_us_baserom.gba", 0x2c200, 0x1e4
        thumb_func_end sub_0802C200
