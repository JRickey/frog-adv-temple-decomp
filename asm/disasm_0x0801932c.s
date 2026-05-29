@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801932c, 0x08019500)  (468 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801932c --end 0x8019500 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801932c: b500        push	{lr}
@   0x0801932e: f7f7        f9c3 	bl	0x106b8
@   0x08019332: 2800        cmp	r0, #0
@   0x08019334: d14c        bne.n	0x193d0
@   0x08019336: 4912        ldr	r1, [pc, #72]	@ (0x19380)
@   0x08019338: 4a12        ldr	r2, [pc, #72]	@ (0x19384)
@   0x0801933a: 1c10        adds	r0, r2, #0
@   0x0801933c: 8008        strh	r0, [r1, #0]
@   0x0801933e: 31c6        adds	r1, #198	@ 0xc6
@   0x08019340: 4a11        ldr	r2, [pc, #68]	@ (0x19388)
@   0x08019342: 6b10        ldr	r0, [r2, #48]	@ 0x30
@   0x08019344: 6008        str	r0, [r1, #0]
@   0x08019346: 4811        ldr	r0, [pc, #68]	@ (0x1938c)
@   0x08019348: 6048        str	r0, [r1, #4]
@   0x0801934a: 4811        ldr	r0, [pc, #68]	@ (0x19390)
@   0x0801934c: 6088        str	r0, [r1, #8]
@   0x0801934e: 6888        ldr	r0, [r1, #8]
@   0x08019350: 6b50        ldr	r0, [r2, #52]	@ 0x34
@   0x08019352: 6008        str	r0, [r1, #0]
@   0x08019354: 20a0        movs	r0, #160	@ 0xa0
@   0x08019356: 04c0        lsls	r0, r0, #19
@   0x08019358: 6048        str	r0, [r1, #4]
@   0x0801935a: 480e        ldr	r0, [pc, #56]	@ (0x19394)
@   0x0801935c: 6088        str	r0, [r1, #8]
@   0x0801935e: 6888        ldr	r0, [r1, #8]
@   0x08019360: 6b90        ldr	r0, [r2, #56]	@ 0x38
@   0x08019362: 6008        str	r0, [r1, #0]
@   0x08019364: 480c        ldr	r0, [pc, #48]	@ (0x19398)
@   0x08019366: 6048        str	r0, [r1, #4]
@   0x08019368: 480c        ldr	r0, [pc, #48]	@ (0x1939c)
@   0x0801936a: 6088        str	r0, [r1, #8]
@   0x0801936c: 6888        ldr	r0, [r1, #8]
@   0x0801936e: 39d4        subs	r1, #212	@ 0xd4
@   0x08019370: 2280        movs	r2, #128	@ 0x80
@   0x08019372: 0112        lsls	r2, r2, #4
@   0x08019374: 1c10        adds	r0, r2, #0
@   0x08019376: 8008        strh	r0, [r1, #0]
@   0x08019378: 20bf        movs	r0, #191	@ 0xbf
@   0x0801937a: f7f7        f9b7 	bl	0x106ec
@   0x0801937e: e012        b.n	0x193a6
@   0x08019380: 000e        movs	r6, r1
@   0x08019382: 0400        lsls	r0, r0, #16
@   0x08019384: 1e08        subs	r0, r1, #0
@   0x08019386: 0000        movs	r0, r0
@   0x08019388: 3550        adds	r5, #80	@ 0x50
@   0x0801938a: 080e        lsrs	r6, r1, #32
@   0x0801938c: 8000        strh	r0, [r0, #0]
@   0x0801938e: 0600        lsls	r0, r0, #24
@   0x08019390: 0290        lsls	r0, r2, #10
@   0x08019392: 8000        strh	r0, [r0, #0]
@   0x08019394: 0100        lsls	r0, r0, #4
@   0x08019396: 8000        strh	r0, [r0, #0]
@   0x08019398: f000        0600 	and.w	r6, r0, #0
@   0x0801939c: 0400        lsls	r0, r0, #16
@   0x0801939e: 8000        strh	r0, [r0, #0]
@   0x080193a0: 2002        movs	r0, #2
@   0x080193a2: f004        ff65 	bl	0x1e270
@   0x080193a6: f7f7        f9b3 	bl	0x10710
@   0x080193aa: 2800        cmp	r0, #0
@   0x080193ac: d1f8        bne.n	0x193a0
@   0x080193ae: 2078        movs	r0, #120	@ 0x78
@   0x080193b0: f004        ff5e 	bl	0x1e270
@   0x080193b4: 20bf        movs	r0, #191	@ 0xbf
@   0x080193b6: f7f7        f96d 	bl	0x10694
@   0x080193ba: e002        b.n	0x193c2
@   0x080193bc: 2002        movs	r0, #2
@   0x080193be: f004        ff57 	bl	0x1e270
@   0x080193c2: f7f7        f979 	bl	0x106b8
@   0x080193c6: 1c01        adds	r1, r0, #0
@   0x080193c8: 2900        cmp	r1, #0
@   0x080193ca: d1f7        bne.n	0x193bc
@   0x080193cc: 4801        ldr	r0, [pc, #4]	@ (0x193d4)
@   0x080193ce: 7041        strb	r1, [r0, #1]
@   0x080193d0: bc01        pop	{r0}
@   0x080193d2: 4700        bx	r0
@   0x080193d4: 34a0        adds	r4, #160	@ 0xa0
@   0x080193d6: 0300        lsls	r0, r0, #12
@   0x080193d8: 480f        ldr	r0, [pc, #60]	@ (0x19418)
@   0x080193da: 2300        movs	r3, #0
@   0x080193dc: 2101        movs	r1, #1
@   0x080193de: 7001        strb	r1, [r0, #0]
@   0x080193e0: 7041        strb	r1, [r0, #1]
@   0x080193e2: 2102        movs	r1, #2
@   0x080193e4: 7081        strb	r1, [r0, #2]
@   0x080193e6: 70c1        strb	r1, [r0, #3]
@   0x080193e8: 2204        movs	r2, #4
@   0x080193ea: 7102        strb	r2, [r0, #4]
@   0x080193ec: 2108        movs	r1, #8
@   0x080193ee: 7141        strb	r1, [r0, #5]
@   0x080193f0: 7182        strb	r2, [r0, #6]
@   0x080193f2: 71c1        strb	r1, [r0, #7]
@   0x080193f4: 2220        movs	r2, #32
@   0x080193f6: 7202        strb	r2, [r0, #8]
@   0x080193f8: 2110        movs	r1, #16
@   0x080193fa: 7241        strb	r1, [r0, #9]
@   0x080193fc: 7282        strb	r2, [r0, #10]
@   0x080193fe: 72c1        strb	r1, [r0, #11]
@   0x08019400: 4906        ldr	r1, [pc, #24]	@ (0x1941c)
@   0x08019402: 2200        movs	r2, #0
@   0x08019404: 844b        strh	r3, [r1, #34]	@ 0x22
@   0x08019406: 1c08        adds	r0, r1, #0
@   0x08019408: 3020        adds	r0, #32
@   0x0801940a: 7002        strb	r2, [r0, #0]
@   0x0801940c: 740a        strb	r2, [r1, #16]
@   0x0801940e: 20fb        movs	r0, #251	@ 0xfb
@   0x08019410: 7e0a        ldrb	r2, [r1, #24]
@   0x08019412: 4010        ands	r0, r2
@   0x08019414: 7608        strb	r0, [r1, #24]
@   0x08019416: 4770        bx	lr
@   0x08019418: 53a0        strh	r0, [r4, r6]
@   0x0801941a: 0300        lsls	r0, r0, #12
@   0x0801941c: 5330        strh	r0, [r6, r4]
@   0x0801941e: 0300        lsls	r0, r0, #12
@   0x08019420: b530        push	{r4, r5, lr}
@   0x08019422: 0600        lsls	r0, r0, #24
@   0x08019424: 0e05        lsrs	r5, r0, #24
@   0x08019426: f7e7        fa6b 	bl	0x900
@   0x0801942a: 4914        ldr	r1, [pc, #80]	@ (0x1947c)
@   0x0801942c: 2222        movs	r2, #34	@ 0x22
@   0x0801942e: 5e89        ldrsh	r1, [r1, r2]
@   0x08019430: 1a40        subs	r0, r0, r1
@   0x08019432: 28b4        cmp	r0, #180	@ 0xb4
@   0x08019434: d90d        bls.n	0x19452
@   0x08019436: 2100        movs	r1, #0
@   0x08019438: 4b11        ldr	r3, [pc, #68]	@ (0x19480)
@   0x0801943a: 2200        movs	r2, #0
@   0x0801943c: 18c8        adds	r0, r1, r3
@   0x0801943e: 7002        strb	r2, [r0, #0]
@   0x08019440: 1c48        adds	r0, r1, #1
@   0x08019442: 0600        lsls	r0, r0, #24
@   0x08019444: 0e01        lsrs	r1, r0, #24
@   0x08019446: 2915        cmp	r1, #21
@   0x08019448: d9f8        bls.n	0x1943c
@   0x0801944a: 480c        ldr	r0, [pc, #48]	@ (0x1947c)
@   0x0801944c: 3020        adds	r0, #32
@   0x0801944e: 2100        movs	r1, #0
@   0x08019450: 7001        strb	r1, [r0, #0]
@   0x08019452: 4a0a        ldr	r2, [pc, #40]	@ (0x1947c)
@   0x08019454: 1c10        adds	r0, r2, #0
@   0x08019456: 3020        adds	r0, #32
@   0x08019458: 1c11        adds	r1, r2, #0
@   0x0801945a: 7800        ldrb	r0, [r0, #0]
@   0x0801945c: 280e        cmp	r0, #14
@   0x0801945e: d911        bls.n	0x19484
@   0x08019460: 2200        movs	r2, #0
@   0x08019462: 4c07        ldr	r4, [pc, #28]	@ (0x19480)
@   0x08019464: 2300        movs	r3, #0
@   0x08019466: 1910        adds	r0, r2, r4
@   0x08019468: 7003        strb	r3, [r0, #0]
@   0x0801946a: 1c50        adds	r0, r2, #1
@   0x0801946c: 0600        lsls	r0, r0, #24
@   0x0801946e: 0e02        lsrs	r2, r0, #24
@   0x08019470: 2a15        cmp	r2, #21
@   0x08019472: d9f8        bls.n	0x19466
@   0x08019474: 3120        adds	r1, #32
@   0x08019476: 2000        movs	r0, #0
@   0x08019478: e03a        b.n	0x194f0
@   0x0801947a: 0000        movs	r0, r0
@   0x0801947c: 5330        strh	r0, [r6, r4]
@   0x0801947e: 0300        lsls	r0, r0, #12
@   0x08019480: 3610        adds	r6, #16
@   0x08019482: 0300        lsls	r0, r0, #12
@   0x08019484: 2d00        cmp	r5, #0
@   0x08019486: d034        beq.n	0x194f2
@   0x08019488: 2d01        cmp	r5, #1
@   0x0801948a: d11f        bne.n	0x194cc
@   0x0801948c: 2004        movs	r0, #4
@   0x0801948e: 7e12        ldrb	r2, [r2, #24]
@   0x08019490: 4010        ands	r0, r2
@   0x08019492: 2800        cmp	r0, #0
@   0x08019494: d11a        bne.n	0x194cc
@   0x08019496: 2100        movs	r1, #0
@   0x08019498: 4b0a        ldr	r3, [pc, #40]	@ (0x194c4)
@   0x0801949a: 2200        movs	r2, #0
@   0x0801949c: 18c8        adds	r0, r1, r3
@   0x0801949e: 7002        strb	r2, [r0, #0]
@   0x080194a0: 1c48        adds	r0, r1, #1
@   0x080194a2: 0600        lsls	r0, r0, #24
@   0x080194a4: 0e01        lsrs	r1, r0, #24
@   0x080194a6: 2915        cmp	r1, #21
@   0x080194a8: d9f8        bls.n	0x1949c
@   0x080194aa: 4c07        ldr	r4, [pc, #28]	@ (0x194c8)
@   0x080194ac: 1c21        adds	r1, r4, #0
@   0x080194ae: 3120        adds	r1, #32
@   0x080194b0: 2000        movs	r0, #0
@   0x080194b2: 7008        strb	r0, [r1, #0]
@   0x080194b4: 2004        movs	r0, #4
@   0x080194b6: 7e21        ldrb	r1, [r4, #24]
@   0x080194b8: 4308        orrs	r0, r1
@   0x080194ba: 7620        strb	r0, [r4, #24]
@   0x080194bc: f7e7        fa20 	bl	0x900
@   0x080194c0: 8460        strh	r0, [r4, #34]	@ 0x22
@   0x080194c2: e00d        b.n	0x194e0
@   0x080194c4: 3610        adds	r6, #16
@   0x080194c6: 0300        lsls	r0, r0, #12
@   0x080194c8: 5330        strh	r0, [r6, r4]
@   0x080194ca: 0300        lsls	r0, r0, #12
@   0x080194cc: 490a        ldr	r1, [pc, #40]	@ (0x194f8)
@   0x080194ce: 1c08        adds	r0, r1, #0
@   0x080194d0: 3020        adds	r0, #32
@   0x080194d2: 7800        ldrb	r0, [r0, #0]
@   0x080194d4: 2801        cmp	r0, #1
@   0x080194d6: d103        bne.n	0x194e0
@   0x080194d8: 20fb        movs	r0, #251	@ 0xfb
@   0x080194da: 7e0a        ldrb	r2, [r1, #24]
@   0x080194dc: 4010        ands	r0, r2
@   0x080194de: 7608        strb	r0, [r1, #24]
@   0x080194e0: 4806        ldr	r0, [pc, #24]	@ (0x194fc)
@   0x080194e2: 4905        ldr	r1, [pc, #20]	@ (0x194f8)
@   0x080194e4: 3120        adds	r1, #32
@   0x080194e6: 780a        ldrb	r2, [r1, #0]
@   0x080194e8: 1810        adds	r0, r2, r0
@   0x080194ea: 7005        strb	r5, [r0, #0]
@   0x080194ec: 7808        ldrb	r0, [r1, #0]
@   0x080194ee: 3001        adds	r0, #1
@   0x080194f0: 7008        strb	r0, [r1, #0]
@   0x080194f2: bc30        pop	{r4, r5}
@   0x080194f4: bc01        pop	{r0}
@   0x080194f6: 4700        bx	r0
@   0x080194f8: 5330        strh	r0, [r6, r4]
@   0x080194fa: 0300        lsls	r0, r0, #12
@   0x080194fc: 3610        adds	r6, #16
@   0x080194fe: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0801932C
sub_0801932C: @ 0x0801932c
        .incbin "frog_us_baserom.gba", 0x1932c, 0x1d4
        thumb_func_end sub_0801932C
