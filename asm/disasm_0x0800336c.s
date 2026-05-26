@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800336c, 0x08003584)  (536 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800336c --end 0x8003584 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800336c: b570        push	{r4, r5, r6, lr}
@   0x0800336e: b094        sub	sp, #80	@ 0x50
@   0x08003370: aa13        add	r2, sp, #76	@ 0x4c
@   0x08003372: 2000        movs	r0, #0
@   0x08003374: 7010        strb	r0, [r2, #0]
@   0x08003376: 4669        mov	r1, sp
@   0x08003378: 314a        adds	r1, #74	@ 0x4a
@   0x0800337a: 2087        movs	r0, #135	@ 0x87
@   0x0800337c: 8008        strh	r0, [r1, #0]
@   0x0800337e: 4802        ldr	r0, [pc, #8]	@ (0x3388)
@   0x08003380: 7a40        ldrb	r0, [r0, #9]
@   0x08003382: 1c15        adds	r5, r2, #0
@   0x08003384: 1c0e        adds	r6, r1, #0
@   0x08003386: e0f1        b.n	0x356c
@   0x08003388: 5330        strh	r0, [r6, r4]
@   0x0800338a: 0300        lsls	r0, r0, #12
@   0x0800338c: f01d        fc18 	bl	0x20bc0
@   0x08003390: 7828        ldrb	r0, [r5, #0]
@   0x08003392: 2808        cmp	r0, #8
@   0x08003394: d900        bls.n	0x3398
@   0x08003396: e0e7        b.n	0x3568
@   0x08003398: 0080        lsls	r0, r0, #2
@   0x0800339a: 4902        ldr	r1, [pc, #8]	@ (0x33a4)
@   0x0800339c: 1840        adds	r0, r0, r1
@   0x0800339e: 6800        ldr	r0, [r0, #0]
@   0x080033a0: 4687        mov	pc, r0
@   0x080033a2: 0000        movs	r0, r0
@   0x080033a4: 33a8        adds	r3, #168	@ 0xa8
@   0x080033a6: 0800        lsrs	r0, r0, #32
@   0x080033a8: 33cc        adds	r3, #204	@ 0xcc
@   0x080033aa: 0800        lsrs	r0, r0, #32
@   0x080033ac: 33ec        adds	r3, #236	@ 0xec
@   0x080033ae: 0800        lsrs	r0, r0, #32
@   0x080033b0: 3414        adds	r4, #20
@   0x080033b2: 0800        lsrs	r0, r0, #32
@   0x080033b4: 3430        adds	r4, #48	@ 0x30
@   0x080033b6: 0800        lsrs	r0, r0, #32
@   0x080033b8: 349e        adds	r4, #158	@ 0x9e
@   0x080033ba: 0800        lsrs	r0, r0, #32
@   0x080033bc: 34c0        adds	r4, #192	@ 0xc0
@   0x080033be: 0800        lsrs	r0, r0, #32
@   0x080033c0: 34f4        adds	r4, #244	@ 0xf4
@   0x080033c2: 0800        lsrs	r0, r0, #32
@   0x080033c4: 3534        adds	r5, #52	@ 0x34
@   0x080033c6: 0800        lsrs	r0, r0, #32
@   0x080033c8: 3564        adds	r5, #100	@ 0x64
@   0x080033ca: 0800        lsrs	r0, r0, #32
@   0x080033cc: 4906        ldr	r1, [pc, #24]	@ (0x33e8)
@   0x080033ce: 2400        movs	r4, #0
@   0x080033d0: 200a        movs	r0, #10
@   0x080033d2: 7288        strb	r0, [r1, #10]
@   0x080033d4: 2006        movs	r0, #6
@   0x080033d6: 4669        mov	r1, sp
@   0x080033d8: f003        fbec 	bl	0x6bb4
@   0x080033dc: 2001        movs	r0, #1
@   0x080033de: 7028        strb	r0, [r5, #0]
@   0x080033e0: a812        add	r0, sp, #72	@ 0x48
@   0x080033e2: 7004        strb	r4, [r0, #0]
@   0x080033e4: e0c0        b.n	0x3568
@   0x080033e6: 0000        movs	r0, r0
@   0x080033e8: 5330        strh	r0, [r6, r4]
@   0x080033ea: 0300        lsls	r0, r0, #12
@   0x080033ec: ac12        add	r4, sp, #72	@ 0x48
@   0x080033ee: 4907        ldr	r1, [pc, #28]	@ (0x340c)
@   0x080033f0: 1c20        adds	r0, r4, #0
@   0x080033f2: f006        fe87 	bl	0xa104
@   0x080033f6: 0600        lsls	r0, r0, #24
@   0x080033f8: 2800        cmp	r0, #0
@   0x080033fa: d100        bne.n	0x33fe
@   0x080033fc: e0aa        b.n	0x3554
@   0x080033fe: 2002        movs	r0, #2
@   0x08003400: 7028        strb	r0, [r5, #0]
@   0x08003402: 4903        ldr	r1, [pc, #12]	@ (0x3410)
@   0x08003404: 2000        movs	r0, #0
@   0x08003406: 6148        str	r0, [r1, #20]
@   0x08003408: 7020        strb	r0, [r4, #0]
@   0x0800340a: e0a3        b.n	0x3554
@   0x0800340c: 359d        adds	r5, #157	@ 0x9d
@   0x0800340e: 0800        lsrs	r0, r0, #32
@   0x08003410: 5330        strh	r0, [r6, r4]
@   0x08003412: 0300        lsls	r0, r0, #12
@   0x08003414: a812        add	r0, sp, #72	@ 0x48
@   0x08003416: f006        fcc1 	bl	0x9d9c
@   0x0800341a: 2800        cmp	r0, #0
@   0x0800341c: d100        bne.n	0x3420
@   0x0800341e: e0a3        b.n	0x3568
@   0x08003420: 2003        movs	r0, #3
@   0x08003422: 7028        strb	r0, [r5, #0]
@   0x08003424: 4901        ldr	r1, [pc, #4]	@ (0x342c)
@   0x08003426: 2000        movs	r0, #0
@   0x08003428: 6148        str	r0, [r1, #20]
@   0x0800342a: e09d        b.n	0x3568
@   0x0800342c: 5330        strh	r0, [r6, r4]
@   0x0800342e: 0300        lsls	r0, r0, #12
@   0x08003430: 4803        ldr	r0, [pc, #12]	@ (0x3440)
@   0x08003432: 6900        ldr	r0, [r0, #16]
@   0x08003434: 2800        cmp	r0, #0
@   0x08003436: d105        bne.n	0x3444
@   0x08003438: f7fd        f844 	bl	0x4c4
@   0x0800343c: e004        b.n	0x3448
@   0x0800343e: 0000        movs	r0, r0
@   0x08003440: 6110        str	r0, [r2, #16]
@   0x08003442: 0300        lsls	r0, r0, #12
@   0x08003444: f7fd        f918 	bl	0x678
@   0x08003448: 4905        ldr	r1, [pc, #20]	@ (0x3460)
@   0x0800344a: 8008        strh	r0, [r1, #0]
@   0x0800344c: 4804        ldr	r0, [pc, #16]	@ (0x3460)
@   0x0800344e: 8800        ldrh	r0, [r0, #0]
@   0x08003450: 2840        cmp	r0, #64	@ 0x40
@   0x08003452: d107        bne.n	0x3464
@   0x08003454: 2005        movs	r0, #5
@   0x08003456: 7028        strb	r0, [r5, #0]
@   0x08003458: f00a        fe02 	bl	0xe060
@   0x0800345c: e084        b.n	0x3568
@   0x0800345e: 0000        movs	r0, r0
@   0x08003460: 5398        strh	r0, [r3, r6]
@   0x08003462: 0300        lsls	r0, r0, #12
@   0x08003464: 4905        ldr	r1, [pc, #20]	@ (0x347c)
@   0x08003466: 2308        movs	r3, #8
@   0x08003468: 2208        movs	r2, #8
@   0x0800346a: 1c10        adds	r0, r2, #0
@   0x0800346c: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x0800346e: 4008        ands	r0, r1
@   0x08003470: 2800        cmp	r0, #0
@   0x08003472: d005        beq.n	0x3480
@   0x08003474: 2004        movs	r0, #4
@   0x08003476: 7028        strb	r0, [r5, #0]
@   0x08003478: e076        b.n	0x3568
@   0x0800347a: 0000        movs	r0, r0
@   0x0800347c: 3720        adds	r7, #32
@   0x0800347e: 0300        lsls	r0, r0, #12
@   0x08003480: 4903        ldr	r1, [pc, #12]	@ (0x3490)
@   0x08003482: 1c10        adds	r0, r2, #0
@   0x08003484: 8dc9        ldrh	r1, [r1, #46]	@ 0x2e
@   0x08003486: 4008        ands	r0, r1
@   0x08003488: 2800        cmp	r0, #0
@   0x0800348a: d003        beq.n	0x3494
@   0x0800348c: 702b        strb	r3, [r5, #0]
@   0x0800348e: e06b        b.n	0x3568
@   0x08003490: 6110        str	r0, [r2, #16]
@   0x08003492: 0300        lsls	r0, r0, #12
@   0x08003494: 1c30        adds	r0, r6, #0
@   0x08003496: 4669        mov	r1, sp
@   0x08003498: f7ff        fedc 	bl	0x3254
@   0x0800349c: e064        b.n	0x3568
@   0x0800349e: 1c28        adds	r0, r5, #0
@   0x080034a0: f006        fbb8 	bl	0x9c14
@   0x080034a4: 2800        cmp	r0, #0
@   0x080034a6: d101        bne.n	0x34ac
@   0x080034a8: 2007        movs	r0, #7
@   0x080034aa: 7028        strb	r0, [r5, #0]
@   0x080034ac: 4803        ldr	r0, [pc, #12]	@ (0x34bc)
@   0x080034ae: 2100        movs	r1, #0
@   0x080034b0: 6101        str	r1, [r0, #16]
@   0x080034b2: 2087        movs	r0, #135	@ 0x87
@   0x080034b4: 8030        strh	r0, [r6, #0]
@   0x080034b6: a812        add	r0, sp, #72	@ 0x48
@   0x080034b8: 7001        strb	r1, [r0, #0]
@   0x080034ba: e055        b.n	0x3568
@   0x080034bc: 6110        str	r0, [r2, #16]
@   0x080034be: 0300        lsls	r0, r0, #12
@   0x080034c0: f7fd        f800 	bl	0x4c4
@   0x080034c4: 4909        ldr	r1, [pc, #36]	@ (0x34ec)
@   0x080034c6: 8008        strh	r0, [r1, #0]
@   0x080034c8: f00b        f8ee 	bl	0xe6a8
@   0x080034cc: 0600        lsls	r0, r0, #24
@   0x080034ce: 0e01        lsrs	r1, r0, #24
@   0x080034d0: 2900        cmp	r1, #0
@   0x080034d2: d103        bne.n	0x34dc
@   0x080034d4: 2006        movs	r0, #6
@   0x080034d6: 7028        strb	r0, [r5, #0]
@   0x080034d8: a812        add	r0, sp, #72	@ 0x48
@   0x080034da: 7001        strb	r1, [r0, #0]
@   0x080034dc: 4804        ldr	r0, [pc, #16]	@ (0x34f0)
@   0x080034de: 7800        ldrb	r0, [r0, #0]
@   0x080034e0: 2800        cmp	r0, #0
@   0x080034e2: d141        bne.n	0x3568
@   0x080034e4: 2003        movs	r0, #3
@   0x080034e6: 7028        strb	r0, [r5, #0]
@   0x080034e8: e03e        b.n	0x3568
@   0x080034ea: 0000        movs	r0, r0
@   0x080034ec: 5398        strh	r0, [r3, r6]
@   0x080034ee: 0300        lsls	r0, r0, #12
@   0x080034f0: 5328        strh	r0, [r5, r4]
@   0x080034f2: 0300        lsls	r0, r0, #12
@   0x080034f4: ac12        add	r4, sp, #72	@ 0x48
@   0x080034f6: 2000        movs	r0, #0
@   0x080034f8: 5620        ldrsb	r0, [r4, r0]
@   0x080034fa: 2800        cmp	r0, #0
@   0x080034fc: d105        bne.n	0x350a
@   0x080034fe: 20bf        movs	r0, #191	@ 0xbf
@   0x08003500: f00d        f8c8 	bl	0x10694
@   0x08003504: 7820        ldrb	r0, [r4, #0]
@   0x08003506: 3001        adds	r0, #1
@   0x08003508: 7020        strb	r0, [r4, #0]
@   0x0800350a: 7824        ldrb	r4, [r4, #0]
@   0x0800350c: 0624        lsls	r4, r4, #24
@   0x0800350e: 1624        asrs	r4, r4, #24
@   0x08003510: 2c01        cmp	r4, #1
@   0x08003512: d129        bne.n	0x3568
@   0x08003514: f00d        f8d0 	bl	0x106b8
@   0x08003518: 0600        lsls	r0, r0, #24
@   0x0800351a: 2800        cmp	r0, #0
@   0x0800351c: d124        bne.n	0x3568
@   0x0800351e: 4803        ldr	r0, [pc, #12]	@ (0x352c)
@   0x08003520: 2104        movs	r1, #4
@   0x08003522: 7001        strb	r1, [r0, #0]
@   0x08003524: 7184        strb	r4, [r0, #6]
@   0x08003526: 4802        ldr	r0, [pc, #8]	@ (0x3530)
@   0x08003528: 7241        strb	r1, [r0, #9]
@   0x0800352a: e01d        b.n	0x3568
@   0x0800352c: 3480        adds	r4, #128	@ 0x80
@   0x0800352e: 0300        lsls	r0, r0, #12
@   0x08003530: 5330        strh	r0, [r6, r4]
@   0x08003532: 0300        lsls	r0, r0, #12
@   0x08003534: ac12        add	r4, sp, #72	@ 0x48
@   0x08003536: 4909        ldr	r1, [pc, #36]	@ (0x355c)
@   0x08003538: 1c20        adds	r0, r4, #0
@   0x0800353a: f006        fde3 	bl	0xa104
@   0x0800353e: 0600        lsls	r0, r0, #24
@   0x08003540: 2800        cmp	r0, #0
@   0x08003542: d007        beq.n	0x3554
@   0x08003544: 2002        movs	r0, #2
@   0x08003546: 7028        strb	r0, [r5, #0]
@   0x08003548: 4905        ldr	r1, [pc, #20]	@ (0x3560)
@   0x0800354a: 2000        movs	r0, #0
@   0x0800354c: 6148        str	r0, [r1, #20]
@   0x0800354e: 7020        strb	r0, [r4, #0]
@   0x08003550: f006        fe3a 	bl	0xa1c8
@   0x08003554: f7fd        f9c2 	bl	0x8dc
@   0x08003558: e006        b.n	0x3568
@   0x0800355a: 0000        movs	r0, r0
@   0x0800355c: a26d        add	r2, pc, #436	@ (adr r2, 0x3714)
@   0x0800355e: 0800        lsrs	r0, r0, #32
@   0x08003560: 5330        strh	r0, [r6, r4]
@   0x08003562: 0300        lsls	r0, r0, #12
@   0x08003564: f00a        fc8c 	bl	0xde80
@   0x08003568: 4805        ldr	r0, [pc, #20]	@ (0x3580)
@   0x0800356a: 7a40        ldrb	r0, [r0, #9]
@   0x0800356c: 2811        cmp	r0, #17
@   0x0800356e: d100        bne.n	0x3572
@   0x08003570: e70c        b.n	0x338c
@   0x08003572: 2818        cmp	r0, #24
@   0x08003574: d100        bne.n	0x3578
@   0x08003576: e709        b.n	0x338c
@   0x08003578: b014        add	sp, #80	@ 0x50
@   0x0800357a: bc70        pop	{r4, r5, r6}
@   0x0800357c: bc01        pop	{r0}
@   0x0800357e: 4700        bx	r0
@   0x08003580: 5330        strh	r0, [r6, r4]
@   0x08003582: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0800336C
sub_0800336C: @ 0x0800336c
        .incbin "frog_us_baserom.gba", 0x336c, 0x218
        thumb_func_end sub_0800336C
