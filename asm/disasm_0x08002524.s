@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08002524, 0x08002760)  (572 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8002524 --end 0x8002760 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08002524: b530        push	{r4, r5, lr}
@   0x08002526: b081        sub	sp, #4
@   0x08002528: 4668        mov	r0, sp
@   0x0800252a: 3001        adds	r0, #1
@   0x0800252c: 2100        movs	r1, #0
@   0x0800252e: 7001        strb	r1, [r0, #0]
@   0x08002530: 4909        ldr	r1, [pc, #36]	@ (0x2558)
@   0x08002532: 7a49        ldrb	r1, [r1, #9]
@   0x08002534: 1c05        adds	r5, r0, #0
@   0x08002536: 290e        cmp	r1, #14
@   0x08002538: d002        beq.n	0x2540
@   0x0800253a: 2918        cmp	r1, #24
@   0x0800253c: d000        beq.n	0x2540
@   0x0800253e: e109        b.n	0x2754
@   0x08002540: f01e        fb3e 	bl	0x20bc0
@   0x08002544: 7828        ldrb	r0, [r5, #0]
@   0x08002546: 2808        cmp	r0, #8
@   0x08002548: d900        bls.n	0x254c
@   0x0800254a: e0fb        b.n	0x2744
@   0x0800254c: 0080        lsls	r0, r0, #2
@   0x0800254e: 4903        ldr	r1, [pc, #12]	@ (0x255c)
@   0x08002550: 1840        adds	r0, r0, r1
@   0x08002552: 6800        ldr	r0, [r0, #0]
@   0x08002554: 4687        mov	pc, r0
@   0x08002556: 0000        movs	r0, r0
@   0x08002558: 5330        strh	r0, [r6, r4]
@   0x0800255a: 0300        lsls	r0, r0, #12
@   0x0800255c: 2560        movs	r5, #96	@ 0x60
@   0x0800255e: 0800        lsrs	r0, r0, #32
@   0x08002560: 2584        movs	r5, #132	@ 0x84
@   0x08002562: 0800        lsrs	r0, r0, #32
@   0x08002564: 259c        movs	r5, #156	@ 0x9c
@   0x08002566: 0800        lsrs	r0, r0, #32
@   0x08002568: 25c4        movs	r5, #196	@ 0xc4
@   0x0800256a: 0800        lsrs	r0, r0, #32
@   0x0800256c: 25e0        movs	r5, #224	@ 0xe0
@   0x0800256e: 0800        lsrs	r0, r0, #32
@   0x08002570: 2680        movs	r6, #128	@ 0x80
@   0x08002572: 0800        lsrs	r0, r0, #32
@   0x08002574: 2696        movs	r6, #150	@ 0x96
@   0x08002576: 0800        lsrs	r0, r0, #32
@   0x08002578: 26c8        movs	r6, #200	@ 0xc8
@   0x0800257a: 0800        lsrs	r0, r0, #32
@   0x0800257c: 2710        movs	r7, #16
@   0x0800257e: 0800        lsrs	r0, r0, #32
@   0x08002580: 2740        movs	r7, #64	@ 0x40
@   0x08002582: 0800        lsrs	r0, r0, #32
@   0x08002584: 4904        ldr	r1, [pc, #16]	@ (0x2598)
@   0x08002586: 2200        movs	r2, #0
@   0x08002588: 2007        movs	r0, #7
@   0x0800258a: 7288        strb	r0, [r1, #10]
@   0x0800258c: 2001        movs	r0, #1
@   0x0800258e: 7028        strb	r0, [r5, #0]
@   0x08002590: 4668        mov	r0, sp
@   0x08002592: 7002        strb	r2, [r0, #0]
@   0x08002594: e0d6        b.n	0x2744
@   0x08002596: 0000        movs	r0, r0
@   0x08002598: 5330        strh	r0, [r6, r4]
@   0x0800259a: 0300        lsls	r0, r0, #12
@   0x0800259c: 4907        ldr	r1, [pc, #28]	@ (0x25bc)
@   0x0800259e: 4668        mov	r0, sp
@   0x080025a0: f007        fdb0 	bl	0xa104
@   0x080025a4: 0600        lsls	r0, r0, #24
@   0x080025a6: 2800        cmp	r0, #0
@   0x080025a8: d100        bne.n	0x25ac
@   0x080025aa: e0c1        b.n	0x2730
@   0x080025ac: 2002        movs	r0, #2
@   0x080025ae: 7028        strb	r0, [r5, #0]
@   0x080025b0: 4803        ldr	r0, [pc, #12]	@ (0x25c0)
@   0x080025b2: 2100        movs	r1, #0
@   0x080025b4: 6141        str	r1, [r0, #20]
@   0x080025b6: 4668        mov	r0, sp
@   0x080025b8: 7001        strb	r1, [r0, #0]
@   0x080025ba: e0b9        b.n	0x2730
@   0x080025bc: 276d        movs	r7, #109	@ 0x6d
@   0x080025be: 0800        lsrs	r0, r0, #32
@   0x080025c0: 5330        strh	r0, [r6, r4]
@   0x080025c2: 0300        lsls	r0, r0, #12
@   0x080025c4: 4668        mov	r0, sp
@   0x080025c6: f007        fbe9 	bl	0x9d9c
@   0x080025ca: 2800        cmp	r0, #0
@   0x080025cc: d100        bne.n	0x25d0
@   0x080025ce: e0b9        b.n	0x2744
@   0x080025d0: 2003        movs	r0, #3
@   0x080025d2: 7028        strb	r0, [r5, #0]
@   0x080025d4: 4901        ldr	r1, [pc, #4]	@ (0x25dc)
@   0x080025d6: 2000        movs	r0, #0
@   0x080025d8: 6148        str	r0, [r1, #20]
@   0x080025da: e0b3        b.n	0x2744
@   0x080025dc: 5330        strh	r0, [r6, r4]
@   0x080025de: 0300        lsls	r0, r0, #12
@   0x080025e0: f7fd        ff70 	bl	0x4c4
@   0x080025e4: 4905        ldr	r1, [pc, #20]	@ (0x25fc)
@   0x080025e6: 8008        strh	r0, [r1, #0]
@   0x080025e8: 0400        lsls	r0, r0, #16
@   0x080025ea: 0c00        lsrs	r0, r0, #16
@   0x080025ec: 2840        cmp	r0, #64	@ 0x40
@   0x080025ee: d107        bne.n	0x2600
@   0x080025f0: 2005        movs	r0, #5
@   0x080025f2: 7028        strb	r0, [r5, #0]
@   0x080025f4: f00b        fd34 	bl	0xe060
@   0x080025f8: e0a4        b.n	0x2744
@   0x080025fa: 0000        movs	r0, r0
@   0x080025fc: 5398        strh	r0, [r3, r6]
@   0x080025fe: 0300        lsls	r0, r0, #12
@   0x08002600: 4906        ldr	r1, [pc, #24]	@ (0x261c)
@   0x08002602: 2308        movs	r3, #8
@   0x08002604: 2208        movs	r2, #8
@   0x08002606: 1c10        adds	r0, r2, #0
@   0x08002608: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x0800260a: 4008        ands	r0, r1
@   0x0800260c: 2800        cmp	r0, #0
@   0x0800260e: d007        beq.n	0x2620
@   0x08002610: 2004        movs	r0, #4
@   0x08002612: 7028        strb	r0, [r5, #0]
@   0x08002614: f00c        fcbc 	bl	0xef90
@   0x08002618: e094        b.n	0x2744
@   0x0800261a: 0000        movs	r0, r0
@   0x0800261c: 3720        adds	r7, #32
@   0x0800261e: 0300        lsls	r0, r0, #12
@   0x08002620: 4903        ldr	r1, [pc, #12]	@ (0x2630)
@   0x08002622: 1c10        adds	r0, r2, #0
@   0x08002624: 8dc9        ldrh	r1, [r1, #46]	@ 0x2e
@   0x08002626: 4008        ands	r0, r1
@   0x08002628: 2800        cmp	r0, #0
@   0x0800262a: d003        beq.n	0x2634
@   0x0800262c: 702b        strb	r3, [r5, #0]
@   0x0800262e: e089        b.n	0x2744
@   0x08002630: 6110        str	r0, [r2, #16]
@   0x08002632: 0300        lsls	r0, r0, #12
@   0x08002634: f007        fe50 	bl	0xa2d8
@   0x08002638: f7fe        f950 	bl	0x8dc
@   0x0800263c: f007        fe74 	bl	0xa328
@   0x08002640: f006        ff5a 	bl	0x94f8
@   0x08002644: f007        f99e 	bl	0x9984
@   0x08002648: 4b0b        ldr	r3, [pc, #44]	@ (0x2678)
@   0x0800264a: 2010        movs	r0, #16
@   0x0800264c: 8a19        ldrh	r1, [r3, #16]
@   0x0800264e: 4008        ands	r0, r1
@   0x08002650: 2800        cmp	r0, #0
@   0x08002652: d00b        beq.n	0x266c
@   0x08002654: 7e18        ldrb	r0, [r3, #24]
@   0x08002656: 7e59        ldrb	r1, [r3, #25]
@   0x08002658: 2408        movs	r4, #8
@   0x0800265a: 5f1a        ldrsh	r2, [r3, r4]
@   0x0800265c: 240a        movs	r4, #10
@   0x0800265e: 5f1b        ldrsh	r3, [r3, r4]
@   0x08002660: f00a        fb92 	bl	0xcd88
@   0x08002664: 0600        lsls	r0, r0, #24
@   0x08002666: 0e00        lsrs	r0, r0, #24
@   0x08002668: f009        febc 	bl	0xc3e4
@   0x0800266c: 4903        ldr	r1, [pc, #12]	@ (0x267c)
@   0x0800266e: 6948        ldr	r0, [r1, #20]
@   0x08002670: 3001        adds	r0, #1
@   0x08002672: 6148        str	r0, [r1, #20]
@   0x08002674: e066        b.n	0x2744
@   0x08002676: 0000        movs	r0, r0
@   0x08002678: 35e0        adds	r5, #224	@ 0xe0
@   0x0800267a: 0300        lsls	r0, r0, #12
@   0x0800267c: 5330        strh	r0, [r6, r4]
@   0x0800267e: 0300        lsls	r0, r0, #12
@   0x08002680: 1c28        adds	r0, r5, #0
@   0x08002682: f007        fac7 	bl	0x9c14
@   0x08002686: 2800        cmp	r0, #0
@   0x08002688: d101        bne.n	0x268e
@   0x0800268a: 2007        movs	r0, #7
@   0x0800268c: 7028        strb	r0, [r5, #0]
@   0x0800268e: 4669        mov	r1, sp
@   0x08002690: 2000        movs	r0, #0
@   0x08002692: 7008        strb	r0, [r1, #0]
@   0x08002694: e056        b.n	0x2744
@   0x08002696: f7fd        ff15 	bl	0x4c4
@   0x0800269a: 4909        ldr	r1, [pc, #36]	@ (0x26c0)
@   0x0800269c: 8008        strh	r0, [r1, #0]
@   0x0800269e: f00c        f803 	bl	0xe6a8
@   0x080026a2: 0600        lsls	r0, r0, #24
@   0x080026a4: 0e01        lsrs	r1, r0, #24
@   0x080026a6: 2900        cmp	r1, #0
@   0x080026a8: d103        bne.n	0x26b2
@   0x080026aa: 2006        movs	r0, #6
@   0x080026ac: 7028        strb	r0, [r5, #0]
@   0x080026ae: 4668        mov	r0, sp
@   0x080026b0: 7001        strb	r1, [r0, #0]
@   0x080026b2: 4804        ldr	r0, [pc, #16]	@ (0x26c4)
@   0x080026b4: 7800        ldrb	r0, [r0, #0]
@   0x080026b6: 2800        cmp	r0, #0
@   0x080026b8: d144        bne.n	0x2744
@   0x080026ba: 2003        movs	r0, #3
@   0x080026bc: 7028        strb	r0, [r5, #0]
@   0x080026be: e041        b.n	0x2744
@   0x080026c0: 5398        strh	r0, [r3, r6]
@   0x080026c2: 0300        lsls	r0, r0, #12
@   0x080026c4: 5328        strh	r0, [r5, r4]
@   0x080026c6: 0300        lsls	r0, r0, #12
@   0x080026c8: 4668        mov	r0, sp
@   0x080026ca: 7800        ldrb	r0, [r0, #0]
@   0x080026cc: 0600        lsls	r0, r0, #24
@   0x080026ce: 1600        asrs	r0, r0, #24
@   0x080026d0: 2800        cmp	r0, #0
@   0x080026d2: d107        bne.n	0x26e4
@   0x080026d4: 20bf        movs	r0, #191	@ 0xbf
@   0x080026d6: f00d        ffdd 	bl	0x10694
@   0x080026da: 4668        mov	r0, sp
@   0x080026dc: 4669        mov	r1, sp
@   0x080026de: 7809        ldrb	r1, [r1, #0]
@   0x080026e0: 3101        adds	r1, #1
@   0x080026e2: 7001        strb	r1, [r0, #0]
@   0x080026e4: 4668        mov	r0, sp
@   0x080026e6: 2400        movs	r4, #0
@   0x080026e8: 5704        ldrsb	r4, [r0, r4]
@   0x080026ea: 2c01        cmp	r4, #1
@   0x080026ec: d12a        bne.n	0x2744
@   0x080026ee: f00d        ffe3 	bl	0x106b8
@   0x080026f2: 0600        lsls	r0, r0, #24
@   0x080026f4: 2800        cmp	r0, #0
@   0x080026f6: d125        bne.n	0x2744
@   0x080026f8: 4803        ldr	r0, [pc, #12]	@ (0x2708)
@   0x080026fa: 2104        movs	r1, #4
@   0x080026fc: 7001        strb	r1, [r0, #0]
@   0x080026fe: 7184        strb	r4, [r0, #6]
@   0x08002700: 4802        ldr	r0, [pc, #8]	@ (0x270c)
@   0x08002702: 7241        strb	r1, [r0, #9]
@   0x08002704: e01e        b.n	0x2744
@   0x08002706: 0000        movs	r0, r0
@   0x08002708: 3480        adds	r4, #128	@ 0x80
@   0x0800270a: 0300        lsls	r0, r0, #12
@   0x0800270c: 5330        strh	r0, [r6, r4]
@   0x0800270e: 0300        lsls	r0, r0, #12
@   0x08002710: 4909        ldr	r1, [pc, #36]	@ (0x2738)
@   0x08002712: 4668        mov	r0, sp
@   0x08002714: f007        fcf6 	bl	0xa104
@   0x08002718: 0600        lsls	r0, r0, #24
@   0x0800271a: 2800        cmp	r0, #0
@   0x0800271c: d008        beq.n	0x2730
@   0x0800271e: 2002        movs	r0, #2
@   0x08002720: 7028        strb	r0, [r5, #0]
@   0x08002722: 4806        ldr	r0, [pc, #24]	@ (0x273c)
@   0x08002724: 2100        movs	r1, #0
@   0x08002726: 6141        str	r1, [r0, #20]
@   0x08002728: 4668        mov	r0, sp
@   0x0800272a: 7001        strb	r1, [r0, #0]
@   0x0800272c: f007        fd4c 	bl	0xa1c8
@   0x08002730: f7fe        f8d4 	bl	0x8dc
@   0x08002734: e006        b.n	0x2744
@   0x08002736: 0000        movs	r0, r0
@   0x08002738: a26d        add	r2, pc, #436	@ (adr r2, 0x28f0)
@   0x0800273a: 0800        lsrs	r0, r0, #32
@   0x0800273c: 5330        strh	r0, [r6, r4]
@   0x0800273e: 0300        lsls	r0, r0, #12
@   0x08002740: f00b        fb9e 	bl	0xde80
@   0x08002744: 4805        ldr	r0, [pc, #20]	@ (0x275c)
@   0x08002746: 7a40        ldrb	r0, [r0, #9]
@   0x08002748: 280e        cmp	r0, #14
@   0x0800274a: d100        bne.n	0x274e
@   0x0800274c: e6f8        b.n	0x2540
@   0x0800274e: 2818        cmp	r0, #24
@   0x08002750: d100        bne.n	0x2754
@   0x08002752: e6f5        b.n	0x2540
@   0x08002754: b001        add	sp, #4
@   0x08002756: bc30        pop	{r4, r5}
@   0x08002758: bc01        pop	{r0}
@   0x0800275a: 4700        bx	r0
@   0x0800275c: 5330        strh	r0, [r6, r4]
@   0x0800275e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08002524
sub_08002524: @ 0x08002524
        .incbin "frog_us_baserom.gba", 0x2524, 0x23c
        thumb_func_end sub_08002524
