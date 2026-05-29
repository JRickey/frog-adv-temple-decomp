@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801c2b4, 0x0801c464)  (432 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801c2b4 --end 0x801c464 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801c2b4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801c2b6: 4657        mov	r7, sl
@   0x0801c2b8: 464e        mov	r6, r9
@   0x0801c2ba: 4645        mov	r5, r8
@   0x0801c2bc: b4e0        push	{r5, r6, r7}
@   0x0801c2be: b087        sub	sp, #28
@   0x0801c2c0: 9c0f        ldr	r4, [sp, #60]	@ 0x3c
@   0x0801c2c2: 9d10        ldr	r5, [sp, #64]	@ 0x40
@   0x0801c2c4: 9e11        ldr	r6, [sp, #68]	@ 0x44
@   0x0801c2c6: 46b0        mov	r8, r6
@   0x0801c2c8: 0400        lsls	r0, r0, #16
@   0x0801c2ca: 0c07        lsrs	r7, r0, #16
@   0x0801c2cc: 0609        lsls	r1, r1, #24
@   0x0801c2ce: 0e09        lsrs	r1, r1, #24
@   0x0801c2d0: 9104        str	r1, [sp, #16]
@   0x0801c2d2: 0612        lsls	r2, r2, #24
@   0x0801c2d4: 0e12        lsrs	r2, r2, #24
@   0x0801c2d6: 9205        str	r2, [sp, #20]
@   0x0801c2d8: 041b        lsls	r3, r3, #16
@   0x0801c2da: 0c1b        lsrs	r3, r3, #16
@   0x0801c2dc: 9306        str	r3, [sp, #24]
@   0x0801c2de: 0424        lsls	r4, r4, #16
@   0x0801c2e0: 0c24        lsrs	r4, r4, #16
@   0x0801c2e2: 46a2        mov	sl, r4
@   0x0801c2e4: 062d        lsls	r5, r5, #24
@   0x0801c2e6: 0e2d        lsrs	r5, r5, #24
@   0x0801c2e8: 46a9        mov	r9, r5
@   0x0801c2ea: 2600        movs	r6, #0
@   0x0801c2ec: 22ff        movs	r2, #255	@ 0xff
@   0x0801c2ee: 4669        mov	r1, sp
@   0x0801c2f0: 1989        adds	r1, r1, r6
@   0x0801c2f2: 310c        adds	r1, #12
@   0x0801c2f4: 7808        ldrb	r0, [r1, #0]
@   0x0801c2f6: 4310        orrs	r0, r2
@   0x0801c2f8: 7008        strb	r0, [r1, #0]
@   0x0801c2fa: 1c70        adds	r0, r6, #1
@   0x0801c2fc: 0600        lsls	r0, r0, #24
@   0x0801c2fe: 0e06        lsrs	r6, r0, #24
@   0x0801c300: 2e03        cmp	r6, #3
@   0x0801c302: d9f4        bls.n	0x1c2ee
@   0x0801c304: 2600        movs	r6, #0
@   0x0801c306: 2f00        cmp	r7, #0
@   0x0801c308: d10b        bne.n	0x1c322
@   0x0801c30a: 4813        ldr	r0, [pc, #76]	@ (0x1c358)
@   0x0801c30c: 9906        ldr	r1, [sp, #24]
@   0x0801c30e: 9100        str	r1, [sp, #0]
@   0x0801c310: 4651        mov	r1, sl
@   0x0801c312: 9101        str	r1, [sp, #4]
@   0x0801c314: 4649        mov	r1, r9
@   0x0801c316: 9102        str	r1, [sp, #8]
@   0x0801c318: 2104        movs	r1, #4
@   0x0801c31a: 9a04        ldr	r2, [sp, #16]
@   0x0801c31c: 9b05        ldr	r3, [sp, #20]
@   0x0801c31e: f7ff        fdad 	bl	0x1be7c
@   0x0801c322: 480e        ldr	r0, [pc, #56]	@ (0x1c35c)
@   0x0801c324: 4287        cmp	r7, r0
@   0x0801c326: d900        bls.n	0x1c32a
@   0x0801c328: e087        b.n	0x1c43a
@   0x0801c32a: 24fa        movs	r4, #250	@ 0xfa
@   0x0801c32c: 00a4        lsls	r4, r4, #2
@   0x0801c32e: 1c38        adds	r0, r7, #0
@   0x0801c330: 1c21        adds	r1, r4, #0
@   0x0801c332: f017        fdd7 	bl	0x33ee4
@   0x0801c336: 0600        lsls	r0, r0, #24
@   0x0801c338: 0e05        lsrs	r5, r0, #24
@   0x0801c33a: 1c38        adds	r0, r7, #0
@   0x0801c33c: 1c21        adds	r1, r4, #0
@   0x0801c33e: f017        fe0d 	bl	0x33f5c
@   0x0801c342: 0400        lsls	r0, r0, #16
@   0x0801c344: 0c07        lsrs	r7, r0, #16
@   0x0801c346: a903        add	r1, sp, #12
@   0x0801c348: 2d00        cmp	r5, #0
@   0x0801c34a: d102        bne.n	0x1c352
@   0x0801c34c: 4640        mov	r0, r8
@   0x0801c34e: 2800        cmp	r0, #0
@   0x0801c350: d006        beq.n	0x1c360
@   0x0801c352: 1c28        adds	r0, r5, #0
@   0x0801c354: 3030        adds	r0, #48	@ 0x30
@   0x0801c356: e004        b.n	0x1c362
@   0x0801c358: e03c        b.n	0x1c3d4
@   0x0801c35a: 081b        lsrs	r3, r3, #32
@   0x0801c35c: 270f        movs	r7, #15
@   0x0801c35e: 0000        movs	r0, r0
@   0x0801c360: 20ff        movs	r0, #255	@ 0xff
@   0x0801c362: 7008        strb	r0, [r1, #0]
@   0x0801c364: 4668        mov	r0, sp
@   0x0801c366: 1980        adds	r0, r0, r6
@   0x0801c368: 300c        adds	r0, #12
@   0x0801c36a: 7800        ldrb	r0, [r0, #0]
@   0x0801c36c: 28ff        cmp	r0, #255	@ 0xff
@   0x0801c36e: d007        beq.n	0x1c380
@   0x0801c370: 1c70        adds	r0, r6, #1
@   0x0801c372: 0600        lsls	r0, r0, #24
@   0x0801c374: 0e06        lsrs	r6, r0, #24
@   0x0801c376: 4641        mov	r1, r8
@   0x0801c378: 2900        cmp	r1, #0
@   0x0801c37a: d101        bne.n	0x1c380
@   0x0801c37c: 2001        movs	r0, #1
@   0x0801c37e: 4680        mov	r8, r0
@   0x0801c380: 1c38        adds	r0, r7, #0
@   0x0801c382: 2164        movs	r1, #100	@ 0x64
@   0x0801c384: f017        fdae 	bl	0x33ee4
@   0x0801c388: 0600        lsls	r0, r0, #24
@   0x0801c38a: 0e05        lsrs	r5, r0, #24
@   0x0801c38c: 1c38        adds	r0, r7, #0
@   0x0801c38e: 2164        movs	r1, #100	@ 0x64
@   0x0801c390: f017        fde4 	bl	0x33f5c
@   0x0801c394: 0400        lsls	r0, r0, #16
@   0x0801c396: 0c07        lsrs	r7, r0, #16
@   0x0801c398: 4669        mov	r1, sp
@   0x0801c39a: 1989        adds	r1, r1, r6
@   0x0801c39c: 310c        adds	r1, #12
@   0x0801c39e: 2d00        cmp	r5, #0
@   0x0801c3a0: d102        bne.n	0x1c3a8
@   0x0801c3a2: 4640        mov	r0, r8
@   0x0801c3a4: 2800        cmp	r0, #0
@   0x0801c3a6: d002        beq.n	0x1c3ae
@   0x0801c3a8: 1c28        adds	r0, r5, #0
@   0x0801c3aa: 3030        adds	r0, #48	@ 0x30
@   0x0801c3ac: e000        b.n	0x1c3b0
@   0x0801c3ae: 20ff        movs	r0, #255	@ 0xff
@   0x0801c3b0: 7008        strb	r0, [r1, #0]
@   0x0801c3b2: 4668        mov	r0, sp
@   0x0801c3b4: 1980        adds	r0, r0, r6
@   0x0801c3b6: 300c        adds	r0, #12
@   0x0801c3b8: 7800        ldrb	r0, [r0, #0]
@   0x0801c3ba: 28ff        cmp	r0, #255	@ 0xff
@   0x0801c3bc: d007        beq.n	0x1c3ce
@   0x0801c3be: 1c70        adds	r0, r6, #1
@   0x0801c3c0: 0600        lsls	r0, r0, #24
@   0x0801c3c2: 0e06        lsrs	r6, r0, #24
@   0x0801c3c4: 4641        mov	r1, r8
@   0x0801c3c6: 2900        cmp	r1, #0
@   0x0801c3c8: d101        bne.n	0x1c3ce
@   0x0801c3ca: 2001        movs	r0, #1
@   0x0801c3cc: 4680        mov	r8, r0
@   0x0801c3ce: 1c38        adds	r0, r7, #0
@   0x0801c3d0: 210a        movs	r1, #10
@   0x0801c3d2: f017        fd87 	bl	0x33ee4
@   0x0801c3d6: 0600        lsls	r0, r0, #24
@   0x0801c3d8: 0e05        lsrs	r5, r0, #24
@   0x0801c3da: 1c38        adds	r0, r7, #0
@   0x0801c3dc: 210a        movs	r1, #10
@   0x0801c3de: f017        fdbd 	bl	0x33f5c
@   0x0801c3e2: 0400        lsls	r0, r0, #16
@   0x0801c3e4: 0c07        lsrs	r7, r0, #16
@   0x0801c3e6: 4669        mov	r1, sp
@   0x0801c3e8: 1989        adds	r1, r1, r6
@   0x0801c3ea: 310c        adds	r1, #12
@   0x0801c3ec: 2d00        cmp	r5, #0
@   0x0801c3ee: d102        bne.n	0x1c3f6
@   0x0801c3f0: 4640        mov	r0, r8
@   0x0801c3f2: 2800        cmp	r0, #0
@   0x0801c3f4: d002        beq.n	0x1c3fc
@   0x0801c3f6: 1c28        adds	r0, r5, #0
@   0x0801c3f8: 3030        adds	r0, #48	@ 0x30
@   0x0801c3fa: e000        b.n	0x1c3fe
@   0x0801c3fc: 20ff        movs	r0, #255	@ 0xff
@   0x0801c3fe: 7008        strb	r0, [r1, #0]
@   0x0801c400: 4668        mov	r0, sp
@   0x0801c402: 1980        adds	r0, r0, r6
@   0x0801c404: 300c        adds	r0, #12
@   0x0801c406: 7800        ldrb	r0, [r0, #0]
@   0x0801c408: 28ff        cmp	r0, #255	@ 0xff
@   0x0801c40a: d007        beq.n	0x1c41c
@   0x0801c40c: 1c70        adds	r0, r6, #1
@   0x0801c40e: 0600        lsls	r0, r0, #24
@   0x0801c410: 0e06        lsrs	r6, r0, #24
@   0x0801c412: 4641        mov	r1, r8
@   0x0801c414: 2900        cmp	r1, #0
@   0x0801c416: d101        bne.n	0x1c41c
@   0x0801c418: 2001        movs	r0, #1
@   0x0801c41a: 4680        mov	r8, r0
@   0x0801c41c: 0638        lsls	r0, r7, #24
@   0x0801c41e: 0e05        lsrs	r5, r0, #24
@   0x0801c420: 4668        mov	r0, sp
@   0x0801c422: 1980        adds	r0, r0, r6
@   0x0801c424: 300c        adds	r0, #12
@   0x0801c426: 2d00        cmp	r5, #0
@   0x0801c428: d102        bne.n	0x1c430
@   0x0801c42a: 4641        mov	r1, r8
@   0x0801c42c: 2900        cmp	r1, #0
@   0x0801c42e: d002        beq.n	0x1c436
@   0x0801c430: 1c29        adds	r1, r5, #0
@   0x0801c432: 3130        adds	r1, #48	@ 0x30
@   0x0801c434: e000        b.n	0x1c438
@   0x0801c436: 21ff        movs	r1, #255	@ 0xff
@   0x0801c438: 7001        strb	r1, [r0, #0]
@   0x0801c43a: 9e06        ldr	r6, [sp, #24]
@   0x0801c43c: 9600        str	r6, [sp, #0]
@   0x0801c43e: 4650        mov	r0, sl
@   0x0801c440: 9001        str	r0, [sp, #4]
@   0x0801c442: 4649        mov	r1, r9
@   0x0801c444: 9102        str	r1, [sp, #8]
@   0x0801c446: a803        add	r0, sp, #12
@   0x0801c448: 2104        movs	r1, #4
@   0x0801c44a: 9a04        ldr	r2, [sp, #16]
@   0x0801c44c: 9b05        ldr	r3, [sp, #20]
@   0x0801c44e: f7ff        fd15 	bl	0x1be7c
@   0x0801c452: b007        add	sp, #28
@   0x0801c454: bc38        pop	{r3, r4, r5}
@   0x0801c456: 4698        mov	r8, r3
@   0x0801c458: 46a1        mov	r9, r4
@   0x0801c45a: 46aa        mov	sl, r5
@   0x0801c45c: bcf0        pop	{r4, r5, r6, r7}
@   0x0801c45e: bc01        pop	{r0}
@   0x0801c460: 4700        bx	r0

        thumb_func_start sub_0801C2B4
sub_0801C2B4: @ 0x0801c2b4
        .incbin "frog_us_baserom.gba", 0x1c2b4, 0x1b0
        thumb_func_end sub_0801C2B4
