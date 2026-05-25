@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080002a4, 0x080004c4)  (544 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80002a4 --end 0x80004c4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080002a4: b500        push	{lr}
@   0x080002a6: 490b        ldr	r1, [pc, #44]	@ (0x2d4)
@   0x080002a8: 4a0b        ldr	r2, [pc, #44]	@ (0x2d8)
@   0x080002aa: 1c10        adds	r0, r2, #0
@   0x080002ac: 8008        strh	r0, [r1, #0]
@   0x080002ae: f000        f8bf 	bl	0x430
@   0x080002b2: 490a        ldr	r1, [pc, #40]	@ (0x2dc)
@   0x080002b4: 2004        movs	r0, #4
@   0x080002b6: 7248        strb	r0, [r1, #9]
@   0x080002b8: f020        fc82 	bl	0x20bc0
@   0x080002bc: 4807        ldr	r0, [pc, #28]	@ (0x2dc)
@   0x080002be: 7a40        ldrb	r0, [r0, #9]
@   0x080002c0: 3804        subs	r0, #4
@   0x080002c2: 2819        cmp	r0, #25
@   0x080002c4: d900        bls.n	0x2c8
@   0x080002c6: e0ae        b.n	0x426
@   0x080002c8: 0080        lsls	r0, r0, #2
@   0x080002ca: 4905        ldr	r1, [pc, #20]	@ (0x2e0)
@   0x080002cc: 1840        adds	r0, r0, r1
@   0x080002ce: 6800        ldr	r0, [r0, #0]
@   0x080002d0: 4687        mov	pc, r0
@   0x080002d2: 0000        movs	r0, r0
@   0x080002d4: 0204        lsls	r4, r0, #8
@   0x080002d6: 0400        lsls	r0, r0, #16
@   0x080002d8: 4014        ands	r4, r2
@   0x080002da: 0000        movs	r0, r0
@   0x080002dc: 5330        strh	r0, [r6, r4]
@   0x080002de: 0300        lsls	r0, r0, #12
@   0x080002e0: 02e4        lsls	r4, r4, #11
@   0x080002e2: 0800        lsrs	r0, r0, #32
@   0x080002e4: 034c        lsls	r4, r1, #13
@   0x080002e6: 0800        lsrs	r0, r0, #32
@   0x080002e8: 0418        lsls	r0, r3, #16
@   0x080002ea: 0800        lsrs	r0, r0, #32
@   0x080002ec: 0406        lsls	r6, r0, #16
@   0x080002ee: 0800        lsrs	r0, r0, #32
@   0x080002f0: 0400        lsls	r0, r0, #16
@   0x080002f2: 0800        lsrs	r0, r0, #32
@   0x080002f4: 039a        lsls	r2, r3, #14
@   0x080002f6: 0800        lsrs	r0, r0, #32
@   0x080002f8: 03a0        lsls	r0, r4, #14
@   0x080002fa: 0800        lsrs	r0, r0, #32
@   0x080002fc: 03a6        lsls	r6, r4, #14
@   0x080002fe: 0800        lsrs	r0, r0, #32
@   0x08000300: 03ac        lsls	r4, r5, #14
@   0x08000302: 0800        lsrs	r0, r0, #32
@   0x08000304: 03b2        lsls	r2, r6, #14
@   0x08000306: 0800        lsrs	r0, r0, #32
@   0x08000308: 03b8        lsls	r0, r7, #14
@   0x0800030a: 0800        lsrs	r0, r0, #32
@   0x0800030c: 03be        lsls	r6, r7, #14
@   0x0800030e: 0800        lsrs	r0, r0, #32
@   0x08000310: 03c4        lsls	r4, r0, #15
@   0x08000312: 0800        lsrs	r0, r0, #32
@   0x08000314: 03ca        lsls	r2, r1, #15
@   0x08000316: 0800        lsrs	r0, r0, #32
@   0x08000318: 03d0        lsls	r0, r2, #15
@   0x0800031a: 0800        lsrs	r0, r0, #32
@   0x0800031c: 03d6        lsls	r6, r2, #15
@   0x0800031e: 0800        lsrs	r0, r0, #32
@   0x08000320: 03dc        lsls	r4, r3, #15
@   0x08000322: 0800        lsrs	r0, r0, #32
@   0x08000324: 03e2        lsls	r2, r4, #15
@   0x08000326: 0800        lsrs	r0, r0, #32
@   0x08000328: 03e8        lsls	r0, r5, #15
@   0x0800032a: 0800        lsrs	r0, r0, #32
@   0x0800032c: 03ee        lsls	r6, r5, #15
@   0x0800032e: 0800        lsrs	r0, r0, #32
@   0x08000330: 03f4        lsls	r4, r6, #15
@   0x08000332: 0800        lsrs	r0, r0, #32
@   0x08000334: 0394        lsls	r4, r2, #14
@   0x08000336: 0800        lsrs	r0, r0, #32
@   0x08000338: 03fa        lsls	r2, r7, #15
@   0x0800033a: 0800        lsrs	r0, r0, #32
@   0x0800033c: 040c        lsls	r4, r1, #16
@   0x0800033e: 0800        lsrs	r0, r0, #32
@   0x08000340: 0412        lsls	r2, r2, #16
@   0x08000342: 0800        lsrs	r0, r0, #32
@   0x08000344: 0426        lsls	r6, r4, #16
@   0x08000346: 0800        lsrs	r0, r0, #32
@   0x08000348: 041e        lsls	r6, r3, #16
@   0x0800034a: 0800        lsrs	r0, r0, #32
@   0x0800034c: f000        f8ba 	bl	0x4c4
@   0x08000350: 490d        ldr	r1, [pc, #52]	@ (0x388)
@   0x08000352: 8008        strh	r0, [r1, #0]
@   0x08000354: f019        f8d4 	bl	0x19500
@   0x08000358: 4a0c        ldr	r2, [pc, #48]	@ (0x38c)
@   0x0800035a: 7950        ldrb	r0, [r2, #5]
@   0x0800035c: 2801        cmp	r0, #1
@   0x0800035e: d102        bne.n	0x366
@   0x08000360: 490b        ldr	r1, [pc, #44]	@ (0x390)
@   0x08000362: 2005        movs	r0, #5
@   0x08000364: 7248        strb	r0, [r1, #9]
@   0x08000366: 7952        ldrb	r2, [r2, #5]
@   0x08000368: 2a03        cmp	r2, #3
@   0x0800036a: d102        bne.n	0x372
@   0x0800036c: 4908        ldr	r1, [pc, #32]	@ (0x390)
@   0x0800036e: 2007        movs	r0, #7
@   0x08000370: 7248        strb	r0, [r1, #9]
@   0x08000372: 2a02        cmp	r2, #2
@   0x08000374: d102        bne.n	0x37c
@   0x08000376: 4906        ldr	r1, [pc, #24]	@ (0x390)
@   0x08000378: 2006        movs	r0, #6
@   0x0800037a: 7248        strb	r0, [r1, #9]
@   0x0800037c: 2a04        cmp	r2, #4
@   0x0800037e: d152        bne.n	0x426
@   0x08000380: 4903        ldr	r1, [pc, #12]	@ (0x390)
@   0x08000382: 2018        movs	r0, #24
@   0x08000384: 7248        strb	r0, [r1, #9]
@   0x08000386: e04e        b.n	0x426
@   0x08000388: 5398        strh	r0, [r3, r6]
@   0x0800038a: 0300        lsls	r0, r0, #12
@   0x0800038c: 3480        adds	r4, #128	@ 0x80
@   0x0800038e: 0300        lsls	r0, r0, #12
@   0x08000390: 5330        strh	r0, [r6, r4]
@   0x08000392: 0300        lsls	r0, r0, #12
@   0x08000394: f017        fad2 	bl	0x1793c
@   0x08000398: e045        b.n	0x426
@   0x0800039a: f000        fabd 	bl	0x918
@   0x0800039e: e042        b.n	0x426
@   0x080003a0: f000        fd8a 	bl	0xeb8
@   0x080003a4: e03f        b.n	0x426
@   0x080003a6: f000        ff35 	bl	0x1214
@   0x080003aa: e03c        b.n	0x426
@   0x080003ac: f001        f8ac 	bl	0x1508
@   0x080003b0: e039        b.n	0x426
@   0x080003b2: f001        faff 	bl	0x19b4
@   0x080003b6: e036        b.n	0x426
@   0x080003b8: f001        fee4 	bl	0x2184
@   0x080003bc: e033        b.n	0x426
@   0x080003be: f002        f8b1 	bl	0x2524
@   0x080003c2: e030        b.n	0x426
@   0x080003c4: f002        fa3e 	bl	0x2844
@   0x080003c8: e02d        b.n	0x426
@   0x080003ca: f002        fbc5 	bl	0x2b58
@   0x080003ce: e02a        b.n	0x426
@   0x080003d0: f002        ffcc 	bl	0x336c
@   0x080003d4: e027        b.n	0x426
@   0x080003d6: f003        fa45 	bl	0x3864
@   0x080003da: e024        b.n	0x426
@   0x080003dc: f003        fc64 	bl	0x3ca8
@   0x080003e0: e021        b.n	0x426
@   0x080003e2: f003        fe9b 	bl	0x411c
@   0x080003e6: e01e        b.n	0x426
@   0x080003e8: f004        faa6 	bl	0x4938
@   0x080003ec: e01b        b.n	0x426
@   0x080003ee: f004        fddd 	bl	0x4fac
@   0x080003f2: e018        b.n	0x426
@   0x080003f4: f005        f858 	bl	0x54a8
@   0x080003f8: e015        b.n	0x426
@   0x080003fa: f019        f8b1 	bl	0x19560
@   0x080003fe: e012        b.n	0x426
@   0x08000400: f01f        fee2 	bl	0x201c8
@   0x08000404: e00f        b.n	0x426
@   0x08000406: f01f        fecf 	bl	0x201a8
@   0x0800040a: e00c        b.n	0x426
@   0x0800040c: f019        f898 	bl	0x19540
@   0x08000410: e009        b.n	0x426
@   0x08000412: f01f        fee9 	bl	0x201e8
@   0x08000416: e006        b.n	0x426
@   0x08000418: f01f        ff46 	bl	0x202a8
@   0x0800041c: e003        b.n	0x426
@   0x0800041e: 4803        ldr	r0, [pc, #12]	@ (0x42c)
@   0x08000420: 7800        ldrb	r0, [r0, #0]
@   0x08000422: f019        ff21 	bl	0x1a268
@   0x08000426: f000        fa59 	bl	0x8dc
@   0x0800042a: e745        b.n	0x2b8
@   0x0800042c: 3540        adds	r5, #64	@ 0x40
@   0x0800042e: 0300        lsls	r0, r0, #12
@   0x08000430: b510        push	{r4, lr}
@   0x08000432: f020        fb7d 	bl	0x20b30
@   0x08000436: 481b        ldr	r0, [pc, #108]	@ (0x4a4)
@   0x08000438: 2200        movs	r2, #0
@   0x0800043a: 8002        strh	r2, [r0, #0]
@   0x0800043c: 481a        ldr	r0, [pc, #104]	@ (0x4a8)
@   0x0800043e: 210d        movs	r1, #13
@   0x08000440: 61c1        str	r1, [r0, #28]
@   0x08000442: 2400        movs	r4, #0
@   0x08000444: 6004        str	r4, [r0, #0]
@   0x08000446: 7402        strb	r2, [r0, #16]
@   0x08000448: 7602        strb	r2, [r0, #24]
@   0x0800044a: 6144        str	r4, [r0, #20]
@   0x0800044c: 7282        strb	r2, [r0, #10]
@   0x0800044e: 6044        str	r4, [r0, #4]
@   0x08000450: 4816        ldr	r0, [pc, #88]	@ (0x4ac)
@   0x08000452: 7142        strb	r2, [r0, #5]
@   0x08000454: 7002        strb	r2, [r0, #0]
@   0x08000456: 4816        ldr	r0, [pc, #88]	@ (0x4b0)
@   0x08000458: 7042        strb	r2, [r0, #1]
@   0x0800045a: 4916        ldr	r1, [pc, #88]	@ (0x4b4)
@   0x0800045c: 2001        movs	r0, #1
@   0x0800045e: 7008        strb	r0, [r1, #0]
@   0x08000460: 7048        strb	r0, [r1, #1]
@   0x08000462: 2005        movs	r0, #5
@   0x08000464: 7088        strb	r0, [r1, #2]
@   0x08000466: 70c8        strb	r0, [r1, #3]
@   0x08000468: 4913        ldr	r1, [pc, #76]	@ (0x4b8)
@   0x0800046a: 7008        strb	r0, [r1, #0]
@   0x0800046c: 710a        strb	r2, [r1, #4]
@   0x0800046e: 4813        ldr	r0, [pc, #76]	@ (0x4bc)
@   0x08000470: 6004        str	r4, [r0, #0]
@   0x08000472: f016        ff77 	bl	0x17364
@   0x08000476: f000        f959 	bl	0x72c
@   0x0800047a: 4811        ldr	r0, [pc, #68]	@ (0x4c0)
@   0x0800047c: 8004        strh	r4, [r0, #0]
@   0x0800047e: 8044        strh	r4, [r0, #2]
@   0x08000480: 8084        strh	r4, [r0, #4]
@   0x08000482: 80c4        strh	r4, [r0, #6]
@   0x08000484: 8104        strh	r4, [r0, #8]
@   0x08000486: 8144        strh	r4, [r0, #10]
@   0x08000488: 8184        strh	r4, [r0, #12]
@   0x0800048a: 81c4        strh	r4, [r0, #14]
@   0x0800048c: f000        f9c8 	bl	0x820
@   0x08000490: 2180        movs	r1, #128	@ 0x80
@   0x08000492: 04c9        lsls	r1, r1, #19
@   0x08000494: 22fa        movs	r2, #250	@ 0xfa
@   0x08000496: 0152        lsls	r2, r2, #5
@   0x08000498: 1c10        adds	r0, r2, #0
@   0x0800049a: 8008        strh	r0, [r1, #0]
@   0x0800049c: bc10        pop	{r4}
@   0x0800049e: bc01        pop	{r0}
@   0x080004a0: 4700        bx	r0
@   0x080004a2: 0000        movs	r0, r0
@   0x080004a4: 0200        lsls	r0, r0, #8
@   0x080004a6: 0400        lsls	r0, r0, #16
@   0x080004a8: 5330        strh	r0, [r6, r4]
@   0x080004aa: 0300        lsls	r0, r0, #12
@   0x080004ac: 3480        adds	r4, #128	@ 0x80
@   0x080004ae: 0300        lsls	r0, r0, #12
@   0x080004b0: 34a0        adds	r4, #160	@ 0xa0
@   0x080004b2: 0300        lsls	r0, r0, #12
@   0x080004b4: 34b4        adds	r4, #180	@ 0xb4
@   0x080004b6: 0300        lsls	r0, r0, #12
@   0x080004b8: 35e0        adds	r5, #224	@ 0xe0
@   0x080004ba: 0300        lsls	r0, r0, #12
@   0x080004bc: 34b0        adds	r4, #176	@ 0xb0
@   0x080004be: 0300        lsls	r0, r0, #12
@   0x080004c0: 3550        adds	r5, #80	@ 0x50
@   0x080004c2: 0300        lsls	r0, r0, #12

        thumb_func_start AgbMain
AgbMain: @ 0x080002a4
        .incbin "frog_us_baserom.gba", 0x2a4, 0x220
        thumb_func_end AgbMain
