@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080054a8, 0x0800586c)  (964 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80054a8 --end 0x800586c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080054a8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080054aa: 4647        mov	r7, r8
@   0x080054ac: b480        push	{r7}
@   0x080054ae: b089        sub	sp, #36	@ 0x24
@   0x080054b0: 4668        mov	r0, sp
@   0x080054b2: 3021        adds	r0, #33	@ 0x21
@   0x080054b4: 2100        movs	r1, #0
@   0x080054b6: 7001        strb	r1, [r0, #0]
@   0x080054b8: 4908        ldr	r1, [pc, #32]	@ (0x54dc)
@   0x080054ba: 1c07        adds	r7, r0, #0
@   0x080054bc: 7a49        ldrb	r1, [r1, #9]
@   0x080054be: 2917        cmp	r1, #23
@   0x080054c0: d000        beq.n	0x54c4
@   0x080054c2: e1cb        b.n	0x585c
@   0x080054c4: f01b        fb7c 	bl	0x20bc0
@   0x080054c8: 7838        ldrb	r0, [r7, #0]
@   0x080054ca: 280b        cmp	r0, #11
@   0x080054cc: d900        bls.n	0x54d0
@   0x080054ce: e1c0        b.n	0x5852
@   0x080054d0: 0080        lsls	r0, r0, #2
@   0x080054d2: 4903        ldr	r1, [pc, #12]	@ (0x54e0)
@   0x080054d4: 1840        adds	r0, r0, r1
@   0x080054d6: 6800        ldr	r0, [r0, #0]
@   0x080054d8: 4687        mov	pc, r0
@   0x080054da: 0000        movs	r0, r0
@   0x080054dc: 5330        strh	r0, [r6, r4]
@   0x080054de: 0300        lsls	r0, r0, #12
@   0x080054e0: 54e4        strb	r4, [r4, r3]
@   0x080054e2: 0800        lsrs	r0, r0, #32
@   0x080054e4: 5514        strb	r4, [r2, r4]
@   0x080054e6: 0800        lsrs	r0, r0, #32
@   0x080054e8: 5540        strb	r0, [r0, r5]
@   0x080054ea: 0800        lsrs	r0, r0, #32
@   0x080054ec: 556c        strb	r4, [r5, r5]
@   0x080054ee: 0800        lsrs	r0, r0, #32
@   0x080054f0: 557e        strb	r6, [r7, r5]
@   0x080054f2: 0800        lsrs	r0, r0, #32
@   0x080054f4: 55a8        strb	r0, [r5, r6]
@   0x080054f6: 0800        lsrs	r0, r0, #32
@   0x080054f8: 5640        ldrsb	r0, [r0, r1]
@   0x080054fa: 0800        lsrs	r0, r0, #32
@   0x080054fc: 56a4        ldrsb	r4, [r4, r2]
@   0x080054fe: 0800        lsrs	r0, r0, #32
@   0x08005500: 5774        ldrsb	r4, [r6, r5]
@   0x08005502: 0800        lsrs	r0, r0, #32
@   0x08005504: 57a8        ldrsb	r0, [r5, r6]
@   0x08005506: 0800        lsrs	r0, r0, #32
@   0x08005508: 57e8        ldrsb	r0, [r5, r7]
@   0x0800550a: 0800        lsrs	r0, r0, #32
@   0x0800550c: 5818        ldr	r0, [r3, r0]
@   0x0800550e: 0800        lsrs	r0, r0, #32
@   0x08005510: 5844        ldr	r4, [r0, r1]
@   0x08005512: 0800        lsrs	r0, r0, #32
@   0x08005514: 4908        ldr	r1, [pc, #32]	@ (0x5538)
@   0x08005516: 2400        movs	r4, #0
@   0x08005518: 2010        movs	r0, #16
@   0x0800551a: 7288        strb	r0, [r1, #10]
@   0x0800551c: 4668        mov	r0, sp
@   0x0800551e: f005        fd17 	bl	0xaf50
@   0x08005522: 4806        ldr	r0, [pc, #24]	@ (0x553c)
@   0x08005524: 3033        adds	r0, #51	@ 0x33
@   0x08005526: 7004        strb	r4, [r0, #0]
@   0x08005528: f004        fe74 	bl	0xa214
@   0x0800552c: 4680        mov	r8, r0
@   0x0800552e: 2001        movs	r0, #1
@   0x08005530: 7038        strb	r0, [r7, #0]
@   0x08005532: a808        add	r0, sp, #32
@   0x08005534: 7004        strb	r4, [r0, #0]
@   0x08005536: e18c        b.n	0x5852
@   0x08005538: 5330        strh	r0, [r6, r4]
@   0x0800553a: 0300        lsls	r0, r0, #12
@   0x0800553c: 6110        str	r0, [r2, #16]
@   0x0800553e: 0300        lsls	r0, r0, #12
@   0x08005540: ac08        add	r4, sp, #32
@   0x08005542: 4908        ldr	r1, [pc, #32]	@ (0x5564)
@   0x08005544: 1c20        adds	r0, r4, #0
@   0x08005546: f004        fddd 	bl	0xa104
@   0x0800554a: 0600        lsls	r0, r0, #24
@   0x0800554c: 1c25        adds	r5, r4, #0
@   0x0800554e: 2800        cmp	r0, #0
@   0x08005550: d100        bne.n	0x5554
@   0x08005552: e16f        b.n	0x5834
@   0x08005554: 2002        movs	r0, #2
@   0x08005556: 7038        strb	r0, [r7, #0]
@   0x08005558: 4903        ldr	r1, [pc, #12]	@ (0x5568)
@   0x0800555a: 2000        movs	r0, #0
@   0x0800555c: 6148        str	r0, [r1, #20]
@   0x0800555e: 7028        strb	r0, [r5, #0]
@   0x08005560: e168        b.n	0x5834
@   0x08005562: 0000        movs	r0, r0
@   0x08005564: 5891        ldr	r1, [r2, r2]
@   0x08005566: 0800        lsrs	r0, r0, #32
@   0x08005568: 5330        strh	r0, [r6, r4]
@   0x0800556a: 0300        lsls	r0, r0, #12
@   0x0800556c: 2010        movs	r0, #16
@   0x0800556e: f015        ffd1 	bl	0x1b514
@   0x08005572: 4640        mov	r0, r8
@   0x08005574: f004        fe70 	bl	0xa258
@   0x08005578: 2003        movs	r0, #3
@   0x0800557a: 7038        strb	r0, [r7, #0]
@   0x0800557c: e169        b.n	0x5852
@   0x0800557e: a808        add	r0, sp, #32
@   0x08005580: f004        fc0c 	bl	0x9d9c
@   0x08005584: 2800        cmp	r0, #0
@   0x08005586: d100        bne.n	0x558a
@   0x08005588: e163        b.n	0x5852
@   0x0800558a: 2004        movs	r0, #4
@   0x0800558c: 7038        strb	r0, [r7, #0]
@   0x0800558e: 4804        ldr	r0, [pc, #16]	@ (0x55a0)
@   0x08005590: 2108        movs	r1, #8
@   0x08005592: 2201        movs	r2, #1
@   0x08005594: f001        f834 	bl	0x6600
@   0x08005598: 4902        ldr	r1, [pc, #8]	@ (0x55a4)
@   0x0800559a: 2000        movs	r0, #0
@   0x0800559c: 6148        str	r0, [r1, #20]
@   0x0800559e: e158        b.n	0x5852
@   0x080055a0: 6110        str	r0, [r2, #16]
@   0x080055a2: 0300        lsls	r0, r0, #12
@   0x080055a4: 5330        strh	r0, [r6, r4]
@   0x080055a6: 0300        lsls	r0, r0, #12
@   0x080055a8: f7fa        ff8c 	bl	0x4c4
@   0x080055ac: 4905        ldr	r1, [pc, #20]	@ (0x55c4)
@   0x080055ae: 8008        strh	r0, [r1, #0]
@   0x080055b0: 0400        lsls	r0, r0, #16
@   0x080055b2: 0c00        lsrs	r0, r0, #16
@   0x080055b4: 2840        cmp	r0, #64	@ 0x40
@   0x080055b6: d107        bne.n	0x55c8
@   0x080055b8: 2007        movs	r0, #7
@   0x080055ba: 7038        strb	r0, [r7, #0]
@   0x080055bc: f008        fd50 	bl	0xe060
@   0x080055c0: e147        b.n	0x5852
@   0x080055c2: 0000        movs	r0, r0
@   0x080055c4: 5398        strh	r0, [r3, r6]
@   0x080055c6: 0300        lsls	r0, r0, #12
@   0x080055c8: 4904        ldr	r1, [pc, #16]	@ (0x55dc)
@   0x080055ca: 2508        movs	r5, #8
@   0x080055cc: 1c28        adds	r0, r5, #0
@   0x080055ce: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x080055d0: 4008        ands	r0, r1
@   0x080055d2: 2800        cmp	r0, #0
@   0x080055d4: d004        beq.n	0x55e0
@   0x080055d6: 2005        movs	r0, #5
@   0x080055d8: 7038        strb	r0, [r7, #0]
@   0x080055da: e13a        b.n	0x5852
@   0x080055dc: 3720        adds	r7, #32
@   0x080055de: 0300        lsls	r0, r0, #12
@   0x080055e0: 4c08        ldr	r4, [pc, #32]	@ (0x5604)
@   0x080055e2: 1c20        adds	r0, r4, #0
@   0x080055e4: 2108        movs	r1, #8
@   0x080055e6: 2203        movs	r2, #3
@   0x080055e8: f001        f8d8 	bl	0x679c
@   0x080055ec: 0600        lsls	r0, r0, #24
@   0x080055ee: 2800        cmp	r0, #0
@   0x080055f0: d00a        beq.n	0x5608
@   0x080055f2: 2006        movs	r0, #6
@   0x080055f4: 7038        strb	r0, [r7, #0]
@   0x080055f6: 1c20        adds	r0, r4, #0
@   0x080055f8: 2108        movs	r1, #8
@   0x080055fa: 2203        movs	r2, #3
@   0x080055fc: f001        f862 	bl	0x66c4
@   0x08005600: e127        b.n	0x5852
@   0x08005602: 0000        movs	r0, r0
@   0x08005604: 6110        str	r0, [r2, #16]
@   0x08005606: 0300        lsls	r0, r0, #12
@   0x08005608: 1c28        adds	r0, r5, #0
@   0x0800560a: 8de4        ldrh	r4, [r4, #46]	@ 0x2e
@   0x0800560c: 4020        ands	r0, r4
@   0x0800560e: 2800        cmp	r0, #0
@   0x08005610: d002        beq.n	0x5618
@   0x08005612: 200b        movs	r0, #11
@   0x08005614: 7038        strb	r0, [r7, #0]
@   0x08005616: e11c        b.n	0x5852
@   0x08005618: f004        fe5e 	bl	0xa2d8
@   0x0800561c: f7fb        f95e 	bl	0x8dc
@   0x08005620: f004        fe82 	bl	0xa328
@   0x08005624: f003        ff68 	bl	0x94f8
@   0x08005628: f004        f9ac 	bl	0x9984
@   0x0800562c: 4668        mov	r0, sp
@   0x0800562e: f7ff        fee9 	bl	0x5404
@   0x08005632: 4902        ldr	r1, [pc, #8]	@ (0x563c)
@   0x08005634: 6948        ldr	r0, [r1, #20]
@   0x08005636: 3001        adds	r0, #1
@   0x08005638: 6148        str	r0, [r1, #20]
@   0x0800563a: e10a        b.n	0x5852
@   0x0800563c: 5330        strh	r0, [r6, r4]
@   0x0800563e: 0300        lsls	r0, r0, #12
@   0x08005640: 1c38        adds	r0, r7, #0
@   0x08005642: f004        fae7 	bl	0x9c14
@   0x08005646: 2800        cmp	r0, #0
@   0x08005648: d101        bne.n	0x564e
@   0x0800564a: 2009        movs	r0, #9
@   0x0800564c: 7038        strb	r0, [r7, #0]
@   0x0800564e: 4668        mov	r0, sp
@   0x08005650: f005        fc7e 	bl	0xaf50
@   0x08005654: 4c12        ldr	r4, [pc, #72]	@ (0x56a0)
@   0x08005656: 1c21        adds	r1, r4, #0
@   0x08005658: 312a        adds	r1, #42	@ 0x2a
@   0x0800565a: 2000        movs	r0, #0
@   0x0800565c: 7008        strb	r0, [r1, #0]
@   0x0800565e: 1c20        adds	r0, r4, #0
@   0x08005660: 2105        movs	r1, #5
@   0x08005662: 2204        movs	r2, #4
@   0x08005664: f001        f82e 	bl	0x66c4
@   0x08005668: 2200        movs	r2, #0
@   0x0800566a: ad08        add	r5, sp, #32
@   0x0800566c: 1c26        adds	r6, r4, #0
@   0x0800566e: 1c30        adds	r0, r6, #0
@   0x08005670: 3033        adds	r0, #51	@ 0x33
@   0x08005672: 0612        lsls	r2, r2, #24
@   0x08005674: 1614        asrs	r4, r2, #24
@   0x08005676: 7800        ldrb	r0, [r0, #0]
@   0x08005678: 4120        asrs	r0, r4
@   0x0800567a: 2101        movs	r1, #1
@   0x0800567c: 4008        ands	r0, r1
@   0x0800567e: 2800        cmp	r0, #0
@   0x08005680: d104        bne.n	0x568c
@   0x08005682: 0e12        lsrs	r2, r2, #24
@   0x08005684: 1c30        adds	r0, r6, #0
@   0x08005686: 2105        movs	r1, #5
@   0x08005688: f001        f81c 	bl	0x66c4
@   0x0800568c: 1c60        adds	r0, r4, #1
@   0x0800568e: 0600        lsls	r0, r0, #24
@   0x08005690: 0e02        lsrs	r2, r0, #24
@   0x08005692: 1600        asrs	r0, r0, #24
@   0x08005694: 2803        cmp	r0, #3
@   0x08005696: ddea        ble.n	0x566e
@   0x08005698: 2000        movs	r0, #0
@   0x0800569a: 7028        strb	r0, [r5, #0]
@   0x0800569c: e0d9        b.n	0x5852
@   0x0800569e: 0000        movs	r0, r0
@   0x080056a0: 6110        str	r0, [r2, #16]
@   0x080056a2: 0300        lsls	r0, r0, #12
@   0x080056a4: f006        fefc 	bl	0xc4a0
@   0x080056a8: e007        b.n	0x56ba
@   0x080056aa: f004        ff39 	bl	0xa520
@   0x080056ae: f004        fe13 	bl	0xa2d8
@   0x080056b2: f7fb        f913 	bl	0x8dc
@   0x080056b6: f004        fe37 	bl	0xa328
@   0x080056ba: 480e        ldr	r0, [pc, #56]	@ (0x56f4)
@   0x080056bc: 2108        movs	r1, #8
@   0x080056be: 2202        movs	r2, #2
@   0x080056c0: f001        f86c 	bl	0x679c
@   0x080056c4: 0600        lsls	r0, r0, #24
@   0x080056c6: 2800        cmp	r0, #0
@   0x080056c8: d0ef        beq.n	0x56aa
@   0x080056ca: 4c0a        ldr	r4, [pc, #40]	@ (0x56f4)
@   0x080056cc: 1c20        adds	r0, r4, #0
@   0x080056ce: 2108        movs	r1, #8
@   0x080056d0: 2202        movs	r2, #2
@   0x080056d2: f000        fff7 	bl	0x66c4
@   0x080056d6: 1c26        adds	r6, r4, #0
@   0x080056d8: 362a        adds	r6, #42	@ 0x2a
@   0x080056da: 2500        movs	r5, #0
@   0x080056dc: 7035        strb	r5, [r6, #0]
@   0x080056de: 1c20        adds	r0, r4, #0
@   0x080056e0: 2105        movs	r1, #5
@   0x080056e2: 2204        movs	r2, #4
@   0x080056e4: f000        ffee 	bl	0x66c4
@   0x080056e8: 6920        ldr	r0, [r4, #16]
@   0x080056ea: 2800        cmp	r0, #0
@   0x080056ec: d104        bne.n	0x56f8
@   0x080056ee: 200b        movs	r0, #11
@   0x080056f0: 7038        strb	r0, [r7, #0]
@   0x080056f2: e0ae        b.n	0x5852
@   0x080056f4: 6110        str	r0, [r2, #16]
@   0x080056f6: 0300        lsls	r0, r0, #12
@   0x080056f8: a808        add	r0, sp, #32
@   0x080056fa: 7005        strb	r5, [r0, #0]
@   0x080056fc: f009        fc48 	bl	0xef90
@   0x08005700: f004        fcac 	bl	0xa05c
@   0x08005704: 4818        ldr	r0, [pc, #96]	@ (0x5768)
@   0x08005706: 7940        ldrb	r0, [r0, #5]
@   0x08005708: 0600        lsls	r0, r0, #24
@   0x0800570a: 1600        asrs	r0, r0, #24
@   0x0800570c: f002        f8b2 	bl	0x7874
@   0x08005710: 4916        ldr	r1, [pc, #88]	@ (0x576c)
@   0x08005712: 4817        ldr	r0, [pc, #92]	@ (0x5770)
@   0x08005714: 7a80        ldrb	r0, [r0, #10]
@   0x08005716: 0080        lsls	r0, r0, #2
@   0x08005718: 1840        adds	r0, r0, r1
@   0x0800571a: 6800        ldr	r0, [r0, #0]
@   0x0800571c: f02e        fadc 	bl	0x33cd8
@   0x08005720: 1c20        adds	r0, r4, #0
@   0x08005722: 2105        movs	r1, #5
@   0x08005724: 2204        movs	r2, #4
@   0x08005726: f000        ffcd 	bl	0x66c4
@   0x0800572a: 4668        mov	r0, sp
@   0x0800572c: f005        fc10 	bl	0xaf50
@   0x08005730: 7035        strb	r5, [r6, #0]
@   0x08005732: 2200        movs	r2, #0
@   0x08005734: 1c25        adds	r5, r4, #0
@   0x08005736: 1c28        adds	r0, r5, #0
@   0x08005738: 3033        adds	r0, #51	@ 0x33
@   0x0800573a: 0612        lsls	r2, r2, #24
@   0x0800573c: 1614        asrs	r4, r2, #24
@   0x0800573e: 7800        ldrb	r0, [r0, #0]
@   0x08005740: 4120        asrs	r0, r4
@   0x08005742: 2101        movs	r1, #1
@   0x08005744: 4008        ands	r0, r1
@   0x08005746: 2800        cmp	r0, #0
@   0x08005748: d004        beq.n	0x5754
@   0x0800574a: 0e12        lsrs	r2, r2, #24
@   0x0800574c: 1c28        adds	r0, r5, #0
@   0x0800574e: 2105        movs	r1, #5
@   0x08005750: f000        ff56 	bl	0x6600
@   0x08005754: 1c60        adds	r0, r4, #1
@   0x08005756: 0600        lsls	r0, r0, #24
@   0x08005758: 0e02        lsrs	r2, r0, #24
@   0x0800575a: 1600        asrs	r0, r0, #24
@   0x0800575c: 2803        cmp	r0, #3
@   0x0800575e: ddea        ble.n	0x5736
@   0x08005760: 200a        movs	r0, #10
@   0x08005762: 7038        strb	r0, [r7, #0]
@   0x08005764: e075        b.n	0x5852
@   0x08005766: 0000        movs	r0, r0
@   0x08005768: 35e0        adds	r5, #224	@ 0xe0
@   0x0800576a: 0300        lsls	r0, r0, #12
@   0x0800576c: 0c74        lsrs	r4, r6, #17
@   0x0800576e: 080c        lsrs	r4, r1, #32
@   0x08005770: 5330        strh	r0, [r6, r4]
@   0x08005772: 0300        lsls	r0, r0, #12
@   0x08005774: f7fa        fea6 	bl	0x4c4
@   0x08005778: 4909        ldr	r1, [pc, #36]	@ (0x57a0)
@   0x0800577a: 8008        strh	r0, [r1, #0]
@   0x0800577c: f008        ff94 	bl	0xe6a8
@   0x08005780: 0600        lsls	r0, r0, #24
@   0x08005782: 0e01        lsrs	r1, r0, #24
@   0x08005784: 2900        cmp	r1, #0
@   0x08005786: d103        bne.n	0x5790
@   0x08005788: 2008        movs	r0, #8
@   0x0800578a: 7038        strb	r0, [r7, #0]
@   0x0800578c: a808        add	r0, sp, #32
@   0x0800578e: 7001        strb	r1, [r0, #0]
@   0x08005790: 4804        ldr	r0, [pc, #16]	@ (0x57a4)
@   0x08005792: 7800        ldrb	r0, [r0, #0]
@   0x08005794: 2800        cmp	r0, #0
@   0x08005796: d15c        bne.n	0x5852
@   0x08005798: 2004        movs	r0, #4
@   0x0800579a: 7038        strb	r0, [r7, #0]
@   0x0800579c: e059        b.n	0x5852
@   0x0800579e: 0000        movs	r0, r0
@   0x080057a0: 5398        strh	r0, [r3, r6]
@   0x080057a2: 0300        lsls	r0, r0, #12
@   0x080057a4: 5328        strh	r0, [r5, r4]
@   0x080057a6: 0300        lsls	r0, r0, #12
@   0x080057a8: a808        add	r0, sp, #32
@   0x080057aa: 2100        movs	r1, #0
@   0x080057ac: 5641        ldrsb	r1, [r0, r1]
@   0x080057ae: 1c05        adds	r5, r0, #0
@   0x080057b0: 2900        cmp	r1, #0
@   0x080057b2: d105        bne.n	0x57c0
@   0x080057b4: 20bf        movs	r0, #191	@ 0xbf
@   0x080057b6: f00a        ff6d 	bl	0x10694
@   0x080057ba: 7828        ldrb	r0, [r5, #0]
@   0x080057bc: 3001        adds	r0, #1
@   0x080057be: 7028        strb	r0, [r5, #0]
@   0x080057c0: 2400        movs	r4, #0
@   0x080057c2: 572c        ldrsb	r4, [r5, r4]
@   0x080057c4: 2c01        cmp	r4, #1
@   0x080057c6: d144        bne.n	0x5852
@   0x080057c8: f00a        ff76 	bl	0x106b8
@   0x080057cc: 0600        lsls	r0, r0, #24
@   0x080057ce: 2800        cmp	r0, #0
@   0x080057d0: d13f        bne.n	0x5852
@   0x080057d2: 4803        ldr	r0, [pc, #12]	@ (0x57e0)
@   0x080057d4: 2104        movs	r1, #4
@   0x080057d6: 7001        strb	r1, [r0, #0]
@   0x080057d8: 7184        strb	r4, [r0, #6]
@   0x080057da: 4802        ldr	r0, [pc, #8]	@ (0x57e4)
@   0x080057dc: 7241        strb	r1, [r0, #9]
@   0x080057de: e038        b.n	0x5852
@   0x080057e0: 3480        adds	r4, #128	@ 0x80
@   0x080057e2: 0300        lsls	r0, r0, #12
@   0x080057e4: 5330        strh	r0, [r6, r4]
@   0x080057e6: 0300        lsls	r0, r0, #12
@   0x080057e8: ac08        add	r4, sp, #32
@   0x080057ea: 4909        ldr	r1, [pc, #36]	@ (0x5810)
@   0x080057ec: 1c20        adds	r0, r4, #0
@   0x080057ee: f004        fc89 	bl	0xa104
@   0x080057f2: 0600        lsls	r0, r0, #24
@   0x080057f4: 1c25        adds	r5, r4, #0
@   0x080057f6: 2800        cmp	r0, #0
@   0x080057f8: d01c        beq.n	0x5834
@   0x080057fa: 2003        movs	r0, #3
@   0x080057fc: 7038        strb	r0, [r7, #0]
@   0x080057fe: 4905        ldr	r1, [pc, #20]	@ (0x5814)
@   0x08005800: 2000        movs	r0, #0
@   0x08005802: 6148        str	r0, [r1, #20]
@   0x08005804: 7028        strb	r0, [r5, #0]
@   0x08005806: 4640        mov	r0, r8
@   0x08005808: f004        fd26 	bl	0xa258
@   0x0800580c: e012        b.n	0x5834
@   0x0800580e: 0000        movs	r0, r0
@   0x08005810: a26d        add	r2, pc, #436	@ (adr r2, 0x59c8)
@   0x08005812: 0800        lsrs	r0, r0, #32
@   0x08005814: 5330        strh	r0, [r6, r4]
@   0x08005816: 0300        lsls	r0, r0, #12
@   0x08005818: ac08        add	r4, sp, #32
@   0x0800581a: 4908        ldr	r1, [pc, #32]	@ (0x583c)
@   0x0800581c: 1c20        adds	r0, r4, #0
@   0x0800581e: f004        fc71 	bl	0xa104
@   0x08005822: 0600        lsls	r0, r0, #24
@   0x08005824: 2800        cmp	r0, #0
@   0x08005826: d005        beq.n	0x5834
@   0x08005828: 2003        movs	r0, #3
@   0x0800582a: 7038        strb	r0, [r7, #0]
@   0x0800582c: 4904        ldr	r1, [pc, #16]	@ (0x5840)
@   0x0800582e: 2000        movs	r0, #0
@   0x08005830: 6148        str	r0, [r1, #20]
@   0x08005832: 7020        strb	r0, [r4, #0]
@   0x08005834: f7fb        f852 	bl	0x8dc
@   0x08005838: e00b        b.n	0x5852
@   0x0800583a: 0000        movs	r0, r0
@   0x0800583c: a26d        add	r2, pc, #436	@ (adr r2, 0x59f4)
@   0x0800583e: 0800        lsrs	r0, r0, #32
@   0x08005840: 5330        strh	r0, [r6, r4]
@   0x08005842: 0300        lsls	r0, r0, #12
@   0x08005844: f008        fb1c 	bl	0xde80
@   0x08005848: 2000        movs	r0, #0
@   0x0800584a: f018        fc65 	bl	0x1e118
@   0x0800584e: f018        f8e5 	bl	0x1da1c
@   0x08005852: 4805        ldr	r0, [pc, #20]	@ (0x5868)
@   0x08005854: 7a40        ldrb	r0, [r0, #9]
@   0x08005856: 2817        cmp	r0, #23
@   0x08005858: d100        bne.n	0x585c
@   0x0800585a: e633        b.n	0x54c4
@   0x0800585c: b009        add	sp, #36	@ 0x24
@   0x0800585e: bc08        pop	{r3}
@   0x08005860: 4698        mov	r8, r3
@   0x08005862: bcf0        pop	{r4, r5, r6, r7}
@   0x08005864: bc01        pop	{r0}
@   0x08005866: 4700        bx	r0
@   0x08005868: 5330        strh	r0, [r6, r4]
@   0x0800586a: 0300        lsls	r0, r0, #12

        thumb_func_start GameMode_Scene23
GameMode_Scene23: @ 0x080054a8
        .incbin "frog_us_baserom.gba", 0x54a8, 0x3c4
        thumb_func_end GameMode_Scene23
