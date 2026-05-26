@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080094f8, 0x080097fc)  (772 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80094f8 --end 0x80097fc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080094f8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080094fa: 490b        ldr	r1, [pc, #44]	@ (0x9528)
@   0x080094fc: 2004        movs	r0, #4
@   0x080094fe: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x08009500: 4008        ands	r0, r1
@   0x08009502: 0400        lsls	r0, r0, #16
@   0x08009504: 0c00        lsrs	r0, r0, #16
@   0x08009506: 2800        cmp	r0, #0
@   0x08009508: d000        beq.n	0x950c
@   0x0800950a: e16f        b.n	0x97ec
@   0x0800950c: 4907        ldr	r1, [pc, #28]	@ (0x952c)
@   0x0800950e: 7308        strb	r0, [r1, #12]
@   0x08009510: 7348        strb	r0, [r1, #13]
@   0x08009512: 2002        movs	r0, #2
@   0x08009514: 8a0a        ldrh	r2, [r1, #16]
@   0x08009516: 4010        ands	r0, r2
@   0x08009518: 0400        lsls	r0, r0, #16
@   0x0800951a: 0c00        lsrs	r0, r0, #16
@   0x0800951c: 2800        cmp	r0, #0
@   0x0800951e: d100        bne.n	0x9522
@   0x08009520: 7388        strb	r0, [r1, #14]
@   0x08009522: 2700        movs	r7, #0
@   0x08009524: e15c        b.n	0x97e0
@   0x08009526: 0000        movs	r0, r0
@   0x08009528: 3720        adds	r7, #32
@   0x0800952a: 0300        lsls	r0, r0, #12
@   0x0800952c: 35e0        adds	r5, #224	@ 0xe0
@   0x0800952e: 0300        lsls	r0, r0, #12
@   0x08009530: 4817        ldr	r0, [pc, #92]	@ (0x9590)
@   0x08009532: 00f9        lsls	r1, r7, #3
@   0x08009534: 1809        adds	r1, r1, r0
@   0x08009536: 780c        ldrb	r4, [r1, #0]
@   0x08009538: 4e16        ldr	r6, [pc, #88]	@ (0x9594)
@   0x0800953a: 00e0        lsls	r0, r4, #3
@   0x0800953c: 1b00        subs	r0, r0, r4
@   0x0800953e: 00c0        lsls	r0, r0, #3
@   0x08009540: 1985        adds	r5, r0, r6
@   0x08009542: 4915        ldr	r1, [pc, #84]	@ (0x9598)
@   0x08009544: 8eab        ldrh	r3, [r5, #52]	@ 0x34
@   0x08009546: 4019        ands	r1, r3
@   0x08009548: 86a9        strh	r1, [r5, #52]	@ 0x34
@   0x0800954a: 2c00        cmp	r4, #0
@   0x0800954c: d100        bne.n	0x9550
@   0x0800954e: e146        b.n	0x97de
@   0x08009550: 2004        movs	r0, #4
@   0x08009552: 4001        ands	r1, r0
@   0x08009554: 2900        cmp	r1, #0
@   0x08009556: d000        beq.n	0x955a
@   0x08009558: e141        b.n	0x97de
@   0x0800955a: 79b0        ldrb	r0, [r6, #6]
@   0x0800955c: 79a9        ldrb	r1, [r5, #6]
@   0x0800955e: 4288        cmp	r0, r1
@   0x08009560: d000        beq.n	0x9564
@   0x08009562: e13c        b.n	0x97de
@   0x08009564: 1c28        adds	r0, r5, #0
@   0x08009566: f017        f837 	bl	0x205d8
@   0x0800956a: 1c30        adds	r0, r6, #0
@   0x0800956c: 1c29        adds	r1, r5, #0
@   0x0800956e: f000        f945 	bl	0x97fc
@   0x08009572: 0600        lsls	r0, r0, #24
@   0x08009574: 2800        cmp	r0, #0
@   0x08009576: d100        bne.n	0x957a
@   0x08009578: e131        b.n	0x97de
@   0x0800957a: 7868        ldrb	r0, [r5, #1]
@   0x0800957c: 3801        subs	r0, #1
@   0x0800957e: 280a        cmp	r0, #10
@   0x08009580: d900        bls.n	0x9584
@   0x08009582: e123        b.n	0x97cc
@   0x08009584: 0080        lsls	r0, r0, #2
@   0x08009586: 4905        ldr	r1, [pc, #20]	@ (0x959c)
@   0x08009588: 1840        adds	r0, r0, r1
@   0x0800958a: 6800        ldr	r0, [r0, #0]
@   0x0800958c: 4687        mov	pc, r0
@   0x0800958e: 0000        movs	r0, r0
@   0x08009590: 6160        str	r0, [r4, #20]
@   0x08009592: 0300        lsls	r0, r0, #12
@   0x08009594: 3720        adds	r7, #32
@   0x08009596: 0300        lsls	r0, r0, #12
@   0x08009598: ff7f        0000 	vhadd.u<illegal width 64>	d16, d15, d0
@   0x0800959c: 95a0        str	r5, [sp, #640]	@ 0x280
@   0x0800959e: 0800        lsrs	r0, r0, #32
@   0x080095a0: 95cc        str	r5, [sp, #816]	@ 0x330
@   0x080095a2: 0800        lsrs	r0, r0, #32
@   0x080095a4: 9604        str	r6, [sp, #16]
@   0x080095a6: 0800        lsrs	r0, r0, #32
@   0x080095a8: 97cc        str	r7, [sp, #816]	@ 0x330
@   0x080095aa: 0800        lsrs	r0, r0, #32
@   0x080095ac: 96c0        str	r6, [sp, #768]	@ 0x300
@   0x080095ae: 0800        lsrs	r0, r0, #32
@   0x080095b0: 9658        str	r6, [sp, #352]	@ 0x160
@   0x080095b2: 0800        lsrs	r0, r0, #32
@   0x080095b4: 96f8        str	r6, [sp, #992]	@ 0x3e0
@   0x080095b6: 0800        lsrs	r0, r0, #32
@   0x080095b8: 9690        str	r6, [sp, #576]	@ 0x240
@   0x080095ba: 0800        lsrs	r0, r0, #32
@   0x080095bc: 96c0        str	r6, [sp, #768]	@ 0x300
@   0x080095be: 0800        lsrs	r0, r0, #32
@   0x080095c0: 9730        str	r7, [sp, #192]	@ 0xc0
@   0x080095c2: 0800        lsrs	r0, r0, #32
@   0x080095c4: 9768        str	r7, [sp, #416]	@ 0x1a0
@   0x080095c6: 0800        lsrs	r0, r0, #32
@   0x080095c8: 9788        str	r7, [sp, #544]	@ 0x220
@   0x080095ca: 0800        lsrs	r0, r0, #32
@   0x080095cc: 490b        ldr	r1, [pc, #44]	@ (0x95fc)
@   0x080095ce: 4a0c        ldr	r2, [pc, #48]	@ (0x9600)
@   0x080095d0: 7e8b        ldrb	r3, [r1, #26]
@   0x080095d2: 2b03        cmp	r3, #3
@   0x080095d4: d905        bls.n	0x95e2
@   0x080095d6: 2010        movs	r0, #16
@   0x080095d8: 8a13        ldrh	r3, [r2, #16]
@   0x080095da: 4018        ands	r0, r3
@   0x080095dc: 2800        cmp	r0, #0
@   0x080095de: d100        bne.n	0x95e2
@   0x080095e0: e0fd        b.n	0x97de
@   0x080095e2: 00e0        lsls	r0, r4, #3
@   0x080095e4: 1b00        subs	r0, r0, r4
@   0x080095e6: 00c0        lsls	r0, r0, #3
@   0x080095e8: 1840        adds	r0, r0, r1
@   0x080095ea: 7b11        ldrb	r1, [r2, #12]
@   0x080095ec: 7843        ldrb	r3, [r0, #1]
@   0x080095ee: 4319        orrs	r1, r3
@   0x080095f0: 7311        strb	r1, [r2, #12]
@   0x080095f2: 2180        movs	r1, #128	@ 0x80
@   0x080095f4: 8e82        ldrh	r2, [r0, #52]	@ 0x34
@   0x080095f6: 4311        orrs	r1, r2
@   0x080095f8: e0f0        b.n	0x97dc
@   0x080095fa: 0000        movs	r0, r0
@   0x080095fc: 3720        adds	r7, #32
@   0x080095fe: 0300        lsls	r0, r0, #12
@   0x08009600: 35e0        adds	r5, #224	@ 0xe0
@   0x08009602: 0300        lsls	r0, r0, #12
@   0x08009604: 4e12        ldr	r6, [pc, #72]	@ (0x9650)
@   0x08009606: 00e0        lsls	r0, r4, #3
@   0x08009608: 1b00        subs	r0, r0, r4
@   0x0800960a: 00c0        lsls	r0, r0, #3
@   0x0800960c: 1985        adds	r5, r0, r6
@   0x0800960e: 1c30        adds	r0, r6, #0
@   0x08009610: 1c29        adds	r1, r5, #0
@   0x08009612: f000        fda1 	bl	0xa158
@   0x08009616: 0600        lsls	r0, r0, #24
@   0x08009618: 2800        cmp	r0, #0
@   0x0800961a: d100        bne.n	0x961e
@   0x0800961c: e0df        b.n	0x97de
@   0x0800961e: 490d        ldr	r1, [pc, #52]	@ (0x9654)
@   0x08009620: 7b08        ldrb	r0, [r1, #12]
@   0x08009622: 786b        ldrb	r3, [r5, #1]
@   0x08009624: 4318        orrs	r0, r3
@   0x08009626: 7308        strb	r0, [r1, #12]
@   0x08009628: 734c        strb	r4, [r1, #13]
@   0x0800962a: 7eb6        ldrb	r6, [r6, #26]
@   0x0800962c: 2e03        cmp	r6, #3
@   0x0800962e: d905        bls.n	0x963c
@   0x08009630: 2010        movs	r0, #16
@   0x08009632: 8a0a        ldrh	r2, [r1, #16]
@   0x08009634: 4010        ands	r0, r2
@   0x08009636: 2800        cmp	r0, #0
@   0x08009638: d100        bne.n	0x963c
@   0x0800963a: e0d0        b.n	0x97de
@   0x0800963c: 2080        movs	r0, #128	@ 0x80
@   0x0800963e: 8eab        ldrh	r3, [r5, #52]	@ 0x34
@   0x08009640: 4318        orrs	r0, r3
@   0x08009642: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x08009644: 2002        movs	r0, #2
@   0x08009646: 8a0a        ldrh	r2, [r1, #16]
@   0x08009648: 4310        orrs	r0, r2
@   0x0800964a: 8208        strh	r0, [r1, #16]
@   0x0800964c: 738c        strb	r4, [r1, #14]
@   0x0800964e: e0c6        b.n	0x97de
@   0x08009650: 3720        adds	r7, #32
@   0x08009652: 0300        lsls	r0, r0, #12
@   0x08009654: 35e0        adds	r5, #224	@ 0xe0
@   0x08009656: 0300        lsls	r0, r0, #12
@   0x08009658: 490a        ldr	r1, [pc, #40]	@ (0x9684)
@   0x0800965a: 2001        movs	r0, #1
@   0x0800965c: 7c09        ldrb	r1, [r1, #16]
@   0x0800965e: 4008        ands	r0, r1
@   0x08009660: 2800        cmp	r0, #0
@   0x08009662: d000        beq.n	0x9666
@   0x08009664: e0bb        b.n	0x97de
@   0x08009666: 4808        ldr	r0, [pc, #32]	@ (0x9688)
@   0x08009668: 4a08        ldr	r2, [pc, #32]	@ (0x968c)
@   0x0800966a: 00e1        lsls	r1, r4, #3
@   0x0800966c: 1b09        subs	r1, r1, r4
@   0x0800966e: 00c9        lsls	r1, r1, #3
@   0x08009670: 1889        adds	r1, r1, r2
@   0x08009672: 784a        ldrb	r2, [r1, #1]
@   0x08009674: 7302        strb	r2, [r0, #12]
@   0x08009676: 7809        ldrb	r1, [r1, #0]
@   0x08009678: 7341        strb	r1, [r0, #13]
@   0x0800967a: 2180        movs	r1, #128	@ 0x80
@   0x0800967c: 0089        lsls	r1, r1, #2
@   0x0800967e: f7fd        fa83 	bl	0x6b88
@   0x08009682: e0b3        b.n	0x97ec
@   0x08009684: 5330        strh	r0, [r6, r4]
@   0x08009686: 0300        lsls	r0, r0, #12
@   0x08009688: 35e0        adds	r5, #224	@ 0xe0
@   0x0800968a: 0300        lsls	r0, r0, #12
@   0x0800968c: 3720        adds	r7, #32
@   0x0800968e: 0300        lsls	r0, r0, #12
@   0x08009690: 4908        ldr	r1, [pc, #32]	@ (0x96b4)
@   0x08009692: 2001        movs	r0, #1
@   0x08009694: 7c09        ldrb	r1, [r1, #16]
@   0x08009696: 4008        ands	r0, r1
@   0x08009698: 2800        cmp	r0, #0
@   0x0800969a: d000        beq.n	0x969e
@   0x0800969c: e09f        b.n	0x97de
@   0x0800969e: 4a06        ldr	r2, [pc, #24]	@ (0x96b8)
@   0x080096a0: 7e90        ldrb	r0, [r2, #26]
@   0x080096a2: 3808        subs	r0, #8
@   0x080096a4: 0600        lsls	r0, r0, #24
@   0x080096a6: 0e00        lsrs	r0, r0, #24
@   0x080096a8: 2803        cmp	r0, #3
@   0x080096aa: d800        bhi.n	0x96ae
@   0x080096ac: e097        b.n	0x97de
@   0x080096ae: 4803        ldr	r0, [pc, #12]	@ (0x96bc)
@   0x080096b0: e00f        b.n	0x96d2
@   0x080096b2: 0000        movs	r0, r0
@   0x080096b4: 5330        strh	r0, [r6, r4]
@   0x080096b6: 0300        lsls	r0, r0, #12
@   0x080096b8: 3720        adds	r7, #32
@   0x080096ba: 0300        lsls	r0, r0, #12
@   0x080096bc: 35e0        adds	r5, #224	@ 0xe0
@   0x080096be: 0300        lsls	r0, r0, #12
@   0x080096c0: 490a        ldr	r1, [pc, #40]	@ (0x96ec)
@   0x080096c2: 2001        movs	r0, #1
@   0x080096c4: 7c09        ldrb	r1, [r1, #16]
@   0x080096c6: 4008        ands	r0, r1
@   0x080096c8: 2800        cmp	r0, #0
@   0x080096ca: d000        beq.n	0x96ce
@   0x080096cc: e087        b.n	0x97de
@   0x080096ce: 4808        ldr	r0, [pc, #32]	@ (0x96f0)
@   0x080096d0: 4a08        ldr	r2, [pc, #32]	@ (0x96f4)
@   0x080096d2: 00e1        lsls	r1, r4, #3
@   0x080096d4: 1b09        subs	r1, r1, r4
@   0x080096d6: 00c9        lsls	r1, r1, #3
@   0x080096d8: 1889        adds	r1, r1, r2
@   0x080096da: 784a        ldrb	r2, [r1, #1]
@   0x080096dc: 7302        strb	r2, [r0, #12]
@   0x080096de: 7809        ldrb	r1, [r1, #0]
@   0x080096e0: 7341        strb	r1, [r0, #13]
@   0x080096e2: 2180        movs	r1, #128	@ 0x80
@   0x080096e4: 00c9        lsls	r1, r1, #3
@   0x080096e6: f7fd        fa4f 	bl	0x6b88
@   0x080096ea: e07f        b.n	0x97ec
@   0x080096ec: 5330        strh	r0, [r6, r4]
@   0x080096ee: 0300        lsls	r0, r0, #12
@   0x080096f0: 35e0        adds	r5, #224	@ 0xe0
@   0x080096f2: 0300        lsls	r0, r0, #12
@   0x080096f4: 3720        adds	r7, #32
@   0x080096f6: 0300        lsls	r0, r0, #12
@   0x080096f8: 490a        ldr	r1, [pc, #40]	@ (0x9724)
@   0x080096fa: 2001        movs	r0, #1
@   0x080096fc: 7c09        ldrb	r1, [r1, #16]
@   0x080096fe: 4008        ands	r0, r1
@   0x08009700: 2800        cmp	r0, #0
@   0x08009702: d16c        bne.n	0x97de
@   0x08009704: 4808        ldr	r0, [pc, #32]	@ (0x9728)
@   0x08009706: 4a09        ldr	r2, [pc, #36]	@ (0x972c)
@   0x08009708: 00e1        lsls	r1, r4, #3
@   0x0800970a: 1b09        subs	r1, r1, r4
@   0x0800970c: 00c9        lsls	r1, r1, #3
@   0x0800970e: 1889        adds	r1, r1, r2
@   0x08009710: 784a        ldrb	r2, [r1, #1]
@   0x08009712: 7302        strb	r2, [r0, #12]
@   0x08009714: 7809        ldrb	r1, [r1, #0]
@   0x08009716: 7341        strb	r1, [r0, #13]
@   0x08009718: 2180        movs	r1, #128	@ 0x80
@   0x0800971a: 0109        lsls	r1, r1, #4
@   0x0800971c: f7fd        fa34 	bl	0x6b88
@   0x08009720: e064        b.n	0x97ec
@   0x08009722: 0000        movs	r0, r0
@   0x08009724: 5330        strh	r0, [r6, r4]
@   0x08009726: 0300        lsls	r0, r0, #12
@   0x08009728: 35e0        adds	r5, #224	@ 0xe0
@   0x0800972a: 0300        lsls	r0, r0, #12
@   0x0800972c: 3720        adds	r7, #32
@   0x0800972e: 0300        lsls	r0, r0, #12
@   0x08009730: 490a        ldr	r1, [pc, #40]	@ (0x975c)
@   0x08009732: 2001        movs	r0, #1
@   0x08009734: 7c09        ldrb	r1, [r1, #16]
@   0x08009736: 4008        ands	r0, r1
@   0x08009738: 2800        cmp	r0, #0
@   0x0800973a: d150        bne.n	0x97de
@   0x0800973c: 4808        ldr	r0, [pc, #32]	@ (0x9760)
@   0x0800973e: 4a09        ldr	r2, [pc, #36]	@ (0x9764)
@   0x08009740: 00e1        lsls	r1, r4, #3
@   0x08009742: 1b09        subs	r1, r1, r4
@   0x08009744: 00c9        lsls	r1, r1, #3
@   0x08009746: 1889        adds	r1, r1, r2
@   0x08009748: 784a        ldrb	r2, [r1, #1]
@   0x0800974a: 7302        strb	r2, [r0, #12]
@   0x0800974c: 7809        ldrb	r1, [r1, #0]
@   0x0800974e: 7341        strb	r1, [r0, #13]
@   0x08009750: 2180        movs	r1, #128	@ 0x80
@   0x08009752: 01c9        lsls	r1, r1, #7
@   0x08009754: f7fd        fa18 	bl	0x6b88
@   0x08009758: e048        b.n	0x97ec
@   0x0800975a: 0000        movs	r0, r0
@   0x0800975c: 5330        strh	r0, [r6, r4]
@   0x0800975e: 0300        lsls	r0, r0, #12
@   0x08009760: 35e0        adds	r5, #224	@ 0xe0
@   0x08009762: 0300        lsls	r0, r0, #12
@   0x08009764: 3720        adds	r7, #32
@   0x08009766: 0300        lsls	r0, r0, #12
@   0x08009768: 4904        ldr	r1, [pc, #16]	@ (0x977c)
@   0x0800976a: 2001        movs	r0, #1
@   0x0800976c: 7c09        ldrb	r1, [r1, #16]
@   0x0800976e: 4008        ands	r0, r1
@   0x08009770: 2800        cmp	r0, #0
@   0x08009772: d134        bne.n	0x97de
@   0x08009774: 4802        ldr	r0, [pc, #8]	@ (0x9780)
@   0x08009776: 4a03        ldr	r2, [pc, #12]	@ (0x9784)
@   0x08009778: e014        b.n	0x97a4
@   0x0800977a: 0000        movs	r0, r0
@   0x0800977c: 5330        strh	r0, [r6, r4]
@   0x0800977e: 0300        lsls	r0, r0, #12
@   0x08009780: 35e0        adds	r5, #224	@ 0xe0
@   0x08009782: 0300        lsls	r0, r0, #12
@   0x08009784: 3720        adds	r7, #32
@   0x08009786: 0300        lsls	r0, r0, #12
@   0x08009788: 490d        ldr	r1, [pc, #52]	@ (0x97c0)
@   0x0800978a: 2001        movs	r0, #1
@   0x0800978c: 7c09        ldrb	r1, [r1, #16]
@   0x0800978e: 4008        ands	r0, r1
@   0x08009790: 2800        cmp	r0, #0
@   0x08009792: d124        bne.n	0x97de
@   0x08009794: 4a0b        ldr	r2, [pc, #44]	@ (0x97c4)
@   0x08009796: 7e90        ldrb	r0, [r2, #26]
@   0x08009798: 3808        subs	r0, #8
@   0x0800979a: 0600        lsls	r0, r0, #24
@   0x0800979c: 0e00        lsrs	r0, r0, #24
@   0x0800979e: 2803        cmp	r0, #3
@   0x080097a0: d91d        bls.n	0x97de
@   0x080097a2: 4809        ldr	r0, [pc, #36]	@ (0x97c8)
@   0x080097a4: 00e1        lsls	r1, r4, #3
@   0x080097a6: 1b09        subs	r1, r1, r4
@   0x080097a8: 00c9        lsls	r1, r1, #3
@   0x080097aa: 1889        adds	r1, r1, r2
@   0x080097ac: 784a        ldrb	r2, [r1, #1]
@   0x080097ae: 7302        strb	r2, [r0, #12]
@   0x080097b0: 7809        ldrb	r1, [r1, #0]
@   0x080097b2: 7341        strb	r1, [r0, #13]
@   0x080097b4: 2180        movs	r1, #128	@ 0x80
@   0x080097b6: 0209        lsls	r1, r1, #8
@   0x080097b8: f7fd        f9e6 	bl	0x6b88
@   0x080097bc: e016        b.n	0x97ec
@   0x080097be: 0000        movs	r0, r0
@   0x080097c0: 5330        strh	r0, [r6, r4]
@   0x080097c2: 0300        lsls	r0, r0, #12
@   0x080097c4: 3720        adds	r7, #32
@   0x080097c6: 0300        lsls	r0, r0, #12
@   0x080097c8: 35e0        adds	r5, #224	@ 0xe0
@   0x080097ca: 0300        lsls	r0, r0, #12
@   0x080097cc: 4909        ldr	r1, [pc, #36]	@ (0x97f4)
@   0x080097ce: 00e0        lsls	r0, r4, #3
@   0x080097d0: 1b00        subs	r0, r0, r4
@   0x080097d2: 00c0        lsls	r0, r0, #3
@   0x080097d4: 1840        adds	r0, r0, r1
@   0x080097d6: 2180        movs	r1, #128	@ 0x80
@   0x080097d8: 8e83        ldrh	r3, [r0, #52]	@ 0x34
@   0x080097da: 4319        orrs	r1, r3
@   0x080097dc: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x080097de: 3701        adds	r7, #1
@   0x080097e0: 4805        ldr	r0, [pc, #20]	@ (0x97f8)
@   0x080097e2: 3031        adds	r0, #49	@ 0x31
@   0x080097e4: 7800        ldrb	r0, [r0, #0]
@   0x080097e6: 4287        cmp	r7, r0
@   0x080097e8: da00        bge.n	0x97ec
@   0x080097ea: e6a1        b.n	0x9530
@   0x080097ec: bcf0        pop	{r4, r5, r6, r7}
@   0x080097ee: bc01        pop	{r0}
@   0x080097f0: 4700        bx	r0
@   0x080097f2: 0000        movs	r0, r0
@   0x080097f4: 3720        adds	r7, #32
@   0x080097f6: 0300        lsls	r0, r0, #12
@   0x080097f8: 6110        str	r0, [r2, #16]
@   0x080097fa: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080094F8
sub_080094F8: @ 0x080094f8
        .incbin "frog_us_baserom.gba", 0x94f8, 0x304
        thumb_func_end sub_080094F8
