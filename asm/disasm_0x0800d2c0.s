@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800d2c0, 0x0800d450)  (400 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800d2c0 --end 0x800d450 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800d2c0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0800d2c2: 4657        mov	r7, sl
@   0x0800d2c4: 464e        mov	r6, r9
@   0x0800d2c6: 4645        mov	r5, r8
@   0x0800d2c8: b4e0        push	{r5, r6, r7}
@   0x0800d2ca: 0400        lsls	r0, r0, #16
@   0x0800d2cc: 0409        lsls	r1, r1, #16
@   0x0800d2ce: 0c02        lsrs	r2, r0, #16
@   0x0800d2d0: 4691        mov	r9, r2
@   0x0800d2d2: 1400        asrs	r0, r0, #16
@   0x0800d2d4: 0c0b        lsrs	r3, r1, #16
@   0x0800d2d6: 4698        mov	r8, r3
@   0x0800d2d8: 1409        asrs	r1, r1, #16
@   0x0800d2da: f7ff        ffc9 	bl	0xd270
@   0x0800d2de: 0600        lsls	r0, r0, #24
@   0x0800d2e0: 0e00        lsrs	r0, r0, #24
@   0x0800d2e2: 4682        mov	sl, r0
@   0x0800d2e4: 2801        cmp	r0, #1
@   0x0800d2e6: d14c        bne.n	0xd382
@   0x0800d2e8: 2200        movs	r2, #0
@   0x0800d2ea: 0612        lsls	r2, r2, #24
@   0x0800d2ec: 1611        asrs	r1, r2, #24
@   0x0800d2ee: 3103        adds	r1, #3
@   0x0800d2f0: 00c8        lsls	r0, r1, #3
@   0x0800d2f2: 1a40        subs	r0, r0, r1
@   0x0800d2f4: 00c0        lsls	r0, r0, #3
@   0x0800d2f6: 491e        ldr	r1, [pc, #120]	@ (0xd370)
@   0x0800d2f8: 1845        adds	r5, r0, r1
@   0x0800d2fa: 8eaf        ldrh	r7, [r5, #52]	@ 0x34
@   0x0800d2fc: 2008        movs	r0, #8
@   0x0800d2fe: 4038        ands	r0, r7
@   0x0800d300: 1c16        adds	r6, r2, #0
@   0x0800d302: 2800        cmp	r0, #0
@   0x0800d304: d136        bne.n	0xd374
@   0x0800d306: 2202        movs	r2, #2
@   0x0800d308: 5ea8        ldrsh	r0, [r5, r2]
@   0x0800d30a: 2118        movs	r1, #24
@   0x0800d30c: f026        fd02 	bl	0x33d14
@   0x0800d310: 0400        lsls	r0, r0, #16
@   0x0800d312: 0c04        lsrs	r4, r0, #16
@   0x0800d314: 2304        movs	r3, #4
@   0x0800d316: 5ee8        ldrsh	r0, [r5, r3]
@   0x0800d318: 2118        movs	r1, #24
@   0x0800d31a: f026        fcfb 	bl	0x33d14
@   0x0800d31e: 0400        lsls	r0, r0, #16
@   0x0800d320: 0c02        lsrs	r2, r0, #16
@   0x0800d322: 0420        lsls	r0, r4, #16
@   0x0800d324: 464b        mov	r3, r9
@   0x0800d326: 0419        lsls	r1, r3, #16
@   0x0800d328: 1403        asrs	r3, r0, #16
@   0x0800d32a: 4288        cmp	r0, r1
@   0x0800d32c: d122        bne.n	0xd374
@   0x0800d32e: 0410        lsls	r0, r2, #16
@   0x0800d330: 4642        mov	r2, r8
@   0x0800d332: 0411        lsls	r1, r2, #16
@   0x0800d334: 1404        asrs	r4, r0, #16
@   0x0800d336: 4288        cmp	r0, r1
@   0x0800d338: d11c        bne.n	0xd374
@   0x0800d33a: 2008        movs	r0, #8
@   0x0800d33c: 4338        orrs	r0, r7
@   0x0800d33e: 2104        movs	r1, #4
@   0x0800d340: 4308        orrs	r0, r1
@   0x0800d342: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x0800d344: 1c1a        adds	r2, r3, #0
@   0x0800d346: 1ed3        subs	r3, r2, #3
@   0x0800d348: 0418        lsls	r0, r3, #16
@   0x0800d34a: 0c00        lsrs	r0, r0, #16
@   0x0800d34c: 2807        cmp	r0, #7
@   0x0800d34e: d878        bhi.n	0xd442
@   0x0800d350: 1c21        adds	r1, r4, #0
@   0x0800d352: 2904        cmp	r1, #4
@   0x0800d354: dd75        ble.n	0xd442
@   0x0800d356: 290c        cmp	r1, #12
@   0x0800d358: dc73        bgt.n	0xd442
@   0x0800d35a: 1c18        adds	r0, r3, #0
@   0x0800d35c: 0400        lsls	r0, r0, #16
@   0x0800d35e: 0c00        lsrs	r0, r0, #16
@   0x0800d360: 2808        cmp	r0, #8
@   0x0800d362: d856        bhi.n	0xd412
@   0x0800d364: 1c08        adds	r0, r1, #0
@   0x0800d366: 2804        cmp	r0, #4
@   0x0800d368: dd53        ble.n	0xd412
@   0x0800d36a: 280d        cmp	r0, #13
@   0x0800d36c: dc51        bgt.n	0xd412
@   0x0800d36e: e055        b.n	0xd41c
@   0x0800d370: 3720        adds	r7, #32
@   0x0800d372: 0300        lsls	r0, r0, #12
@   0x0800d374: 2380        movs	r3, #128	@ 0x80
@   0x0800d376: 045b        lsls	r3, r3, #17
@   0x0800d378: 18f0        adds	r0, r6, r3
@   0x0800d37a: 0e02        lsrs	r2, r0, #24
@   0x0800d37c: 1600        asrs	r0, r0, #24
@   0x0800d37e: 2813        cmp	r0, #19
@   0x0800d380: ddb3        ble.n	0xd2ea
@   0x0800d382: 4650        mov	r0, sl
@   0x0800d384: 2802        cmp	r0, #2
@   0x0800d386: d15c        bne.n	0xd442
@   0x0800d388: 2200        movs	r2, #0
@   0x0800d38a: 2108        movs	r1, #8
@   0x0800d38c: 468a        mov	sl, r1
@   0x0800d38e: 0612        lsls	r2, r2, #24
@   0x0800d390: 1611        asrs	r1, r2, #24
@   0x0800d392: 3117        adds	r1, #23
@   0x0800d394: 00c8        lsls	r0, r1, #3
@   0x0800d396: 1a40        subs	r0, r0, r1
@   0x0800d398: 00c0        lsls	r0, r0, #3
@   0x0800d39a: 4b1f        ldr	r3, [pc, #124]	@ (0xd418)
@   0x0800d39c: 18c5        adds	r5, r0, r3
@   0x0800d39e: 8eaf        ldrh	r7, [r5, #52]	@ 0x34
@   0x0800d3a0: 2008        movs	r0, #8
@   0x0800d3a2: 4038        ands	r0, r7
@   0x0800d3a4: 1c16        adds	r6, r2, #0
@   0x0800d3a6: 2800        cmp	r0, #0
@   0x0800d3a8: d144        bne.n	0xd434
@   0x0800d3aa: 2102        movs	r1, #2
@   0x0800d3ac: 5e68        ldrsh	r0, [r5, r1]
@   0x0800d3ae: 2118        movs	r1, #24
@   0x0800d3b0: f026        fcb0 	bl	0x33d14
@   0x0800d3b4: 0400        lsls	r0, r0, #16
@   0x0800d3b6: 0c04        lsrs	r4, r0, #16
@   0x0800d3b8: 2204        movs	r2, #4
@   0x0800d3ba: 5ea8        ldrsh	r0, [r5, r2]
@   0x0800d3bc: 2118        movs	r1, #24
@   0x0800d3be: f026        fca9 	bl	0x33d14
@   0x0800d3c2: 0400        lsls	r0, r0, #16
@   0x0800d3c4: 0c02        lsrs	r2, r0, #16
@   0x0800d3c6: 0420        lsls	r0, r4, #16
@   0x0800d3c8: 464b        mov	r3, r9
@   0x0800d3ca: 0419        lsls	r1, r3, #16
@   0x0800d3cc: 1403        asrs	r3, r0, #16
@   0x0800d3ce: 4288        cmp	r0, r1
@   0x0800d3d0: d130        bne.n	0xd434
@   0x0800d3d2: 0410        lsls	r0, r2, #16
@   0x0800d3d4: 4642        mov	r2, r8
@   0x0800d3d6: 0411        lsls	r1, r2, #16
@   0x0800d3d8: 1404        asrs	r4, r0, #16
@   0x0800d3da: 4288        cmp	r0, r1
@   0x0800d3dc: d12a        bne.n	0xd434
@   0x0800d3de: 4650        mov	r0, sl
@   0x0800d3e0: 4338        orrs	r0, r7
@   0x0800d3e2: 2104        movs	r1, #4
@   0x0800d3e4: 4308        orrs	r0, r1
@   0x0800d3e6: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x0800d3e8: 1c1a        adds	r2, r3, #0
@   0x0800d3ea: 1ed3        subs	r3, r2, #3
@   0x0800d3ec: 0418        lsls	r0, r3, #16
@   0x0800d3ee: 0c00        lsrs	r0, r0, #16
@   0x0800d3f0: 2807        cmp	r0, #7
@   0x0800d3f2: d826        bhi.n	0xd442
@   0x0800d3f4: 1c21        adds	r1, r4, #0
@   0x0800d3f6: 2904        cmp	r1, #4
@   0x0800d3f8: dd23        ble.n	0xd442
@   0x0800d3fa: 290c        cmp	r1, #12
@   0x0800d3fc: dc21        bgt.n	0xd442
@   0x0800d3fe: 1c18        adds	r0, r3, #0
@   0x0800d400: 0400        lsls	r0, r0, #16
@   0x0800d402: 0c00        lsrs	r0, r0, #16
@   0x0800d404: 2808        cmp	r0, #8
@   0x0800d406: d804        bhi.n	0xd412
@   0x0800d408: 1c08        adds	r0, r1, #0
@   0x0800d40a: 2804        cmp	r0, #4
@   0x0800d40c: dd01        ble.n	0xd412
@   0x0800d40e: 280d        cmp	r0, #13
@   0x0800d410: dd04        ble.n	0xd41c
@   0x0800d412: 20ff        movs	r0, #255	@ 0xff
@   0x0800d414: e005        b.n	0xd422
@   0x0800d416: 0000        movs	r0, r0
@   0x0800d418: 3720        adds	r7, #32
@   0x0800d41a: 0300        lsls	r0, r0, #12
@   0x0800d41c: 3805        subs	r0, #5
@   0x0800d41e: 00c0        lsls	r0, r0, #3
@   0x0800d420: 18c0        adds	r0, r0, r3
@   0x0800d422: 0600        lsls	r0, r0, #24
@   0x0800d424: 0e00        lsrs	r0, r0, #24
@   0x0800d426: 4902        ldr	r1, [pc, #8]	@ (0xd430)
@   0x0800d428: 1840        adds	r0, r0, r1
@   0x0800d42a: 2100        movs	r1, #0
@   0x0800d42c: 7001        strb	r1, [r0, #0]
@   0x0800d42e: e008        b.n	0xd442
@   0x0800d430: 53a0        strh	r0, [r4, r6]
@   0x0800d432: 0300        lsls	r0, r0, #12
@   0x0800d434: 2380        movs	r3, #128	@ 0x80
@   0x0800d436: 045b        lsls	r3, r3, #17
@   0x0800d438: 18f0        adds	r0, r6, r3
@   0x0800d43a: 0e02        lsrs	r2, r0, #24
@   0x0800d43c: 1600        asrs	r0, r0, #24
@   0x0800d43e: 2809        cmp	r0, #9
@   0x0800d440: dda5        ble.n	0xd38e
@   0x0800d442: bc38        pop	{r3, r4, r5}
@   0x0800d444: 4698        mov	r8, r3
@   0x0800d446: 46a1        mov	r9, r4
@   0x0800d448: 46aa        mov	sl, r5
@   0x0800d44a: bcf0        pop	{r4, r5, r6, r7}
@   0x0800d44c: bc01        pop	{r0}
@   0x0800d44e: 4700        bx	r0

        thumb_func_start sub_0800D2C0
sub_0800D2C0: @ 0x0800d2c0
        .incbin "frog_us_baserom.gba", 0xd2c0, 0x190
        thumb_func_end sub_0800D2C0
