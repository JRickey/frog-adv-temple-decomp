@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08022434, 0x08022730)  (764 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8022434 --end 0x8022730 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08022434: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08022436: 4657        mov	r7, sl
@   0x08022438: 464e        mov	r6, r9
@   0x0802243a: 4645        mov	r5, r8
@   0x0802243c: b4e0        push	{r5, r6, r7}
@   0x0802243e: 4a1c        ldr	r2, [pc, #112]	@ (0x224b0)
@   0x08022440: 2102        movs	r1, #2
@   0x08022442: 5e50        ldrsh	r0, [r2, r1]
@   0x08022444: 289a        cmp	r0, #154	@ 0x9a
@   0x08022446: dc00        bgt.n	0x2244a
@   0x08022448: e16a        b.n	0x22720
@   0x0802244a: 2304        movs	r3, #4
@   0x0802244c: 5ed1        ldrsh	r1, [r2, r3]
@   0x0802244e: 4819        ldr	r0, [pc, #100]	@ (0x224b4)
@   0x08022450: 4281        cmp	r1, r0
@   0x08022452: dc00        bgt.n	0x22456
@   0x08022454: e164        b.n	0x22720
@   0x08022456: 2400        movs	r4, #0
@   0x08022458: 46a0        mov	r8, r4
@   0x0802245a: 4691        mov	r9, r2
@   0x0802245c: 3080        adds	r0, #128	@ 0x80
@   0x0802245e: 4682        mov	sl, r0
@   0x08022460: 4641        mov	r1, r8
@   0x08022462: 00c8        lsls	r0, r1, #3
@   0x08022464: 1a40        subs	r0, r0, r1
@   0x08022466: 00c0        lsls	r0, r0, #3
@   0x08022468: 4913        ldr	r1, [pc, #76]	@ (0x224b8)
@   0x0802246a: 1845        adds	r5, r0, r1
@   0x0802246c: 2204        movs	r2, #4
@   0x0802246e: 5ea9        ldrsh	r1, [r5, r2]
@   0x08022470: 4812        ldr	r0, [pc, #72]	@ (0x224bc)
@   0x08022472: 4281        cmp	r1, r0
@   0x08022474: d00e        beq.n	0x22494
@   0x08022476: 3018        adds	r0, #24
@   0x08022478: 4281        cmp	r1, r0
@   0x0802247a: d00b        beq.n	0x22494
@   0x0802247c: 3018        adds	r0, #24
@   0x0802247e: 4281        cmp	r1, r0
@   0x08022480: d008        beq.n	0x22494
@   0x08022482: 3018        adds	r0, #24
@   0x08022484: 4281        cmp	r1, r0
@   0x08022486: d005        beq.n	0x22494
@   0x08022488: 3018        adds	r0, #24
@   0x0802248a: 4281        cmp	r1, r0
@   0x0802248c: d002        beq.n	0x22494
@   0x0802248e: 3018        adds	r0, #24
@   0x08022490: 4281        cmp	r1, r0
@   0x08022492: d105        bne.n	0x224a0
@   0x08022494: 1c28        adds	r0, r5, #0
@   0x08022496: 210e        movs	r1, #14
@   0x08022498: 2203        movs	r2, #3
@   0x0802249a: 2303        movs	r3, #3
@   0x0802249c: f7fe        fc1e 	bl	0x20cdc
@   0x080224a0: 7eac        ldrb	r4, [r5, #26]
@   0x080224a2: 2c01        cmp	r4, #1
@   0x080224a4: d064        beq.n	0x22570
@   0x080224a6: 2c01        cmp	r4, #1
@   0x080224a8: dc0a        bgt.n	0x224c0
@   0x080224aa: 2c00        cmp	r4, #0
@   0x080224ac: d00c        beq.n	0x224c8
@   0x080224ae: e0fb        b.n	0x226a8
@   0x080224b0: 3720        adds	r7, #32
@   0x080224b2: 0300        lsls	r0, r0, #12
@   0x080224b4: 026f        lsls	r7, r5, #9
@   0x080224b6: 0000        movs	r0, r0
@   0x080224b8: 4638        mov	r0, r7
@   0x080224ba: 0300        lsls	r0, r0, #12
@   0x080224bc: 02f5        lsls	r5, r6, #11
@   0x080224be: 0000        movs	r0, r0
@   0x080224c0: 2c02        cmp	r4, #2
@   0x080224c2: d100        bne.n	0x224c6
@   0x080224c4: e0a6        b.n	0x22614
@   0x080224c6: e0ef        b.n	0x226a8
@   0x080224c8: 2602        movs	r6, #2
@   0x080224ca: 2002        movs	r0, #2
@   0x080224cc: 8eab        ldrh	r3, [r5, #52]	@ 0x34
@   0x080224ce: 4018        ands	r0, r3
@   0x080224d0: 2800        cmp	r0, #0
@   0x080224d2: d000        beq.n	0x224d6
@   0x080224d4: e0e8        b.n	0x226a8
@   0x080224d6: 2004        movs	r0, #4
@   0x080224d8: 5e2c        ldrsh	r4, [r5, r0]
@   0x080224da: 491e        ldr	r1, [pc, #120]	@ (0x22554)
@   0x080224dc: 428c        cmp	r4, r1
@   0x080224de: dd01        ble.n	0x224e4
@   0x080224e0: 75ee        strb	r6, [r5, #23]
@   0x080224e2: 71ae        strb	r6, [r5, #6]
@   0x080224e4: 2204        movs	r2, #4
@   0x080224e6: 5ea8        ldrsh	r0, [r5, r2]
@   0x080224e8: 4b1b        ldr	r3, [pc, #108]	@ (0x22558)
@   0x080224ea: 18c0        adds	r0, r0, r3
@   0x080224ec: 2118        movs	r1, #24
@   0x080224ee: f011        fc91 	bl	0x33e14
@   0x080224f2: 280d        cmp	r0, #13
@   0x080224f4: d108        bne.n	0x22508
@   0x080224f6: 2001        movs	r0, #1
@   0x080224f8: 7ea9        ldrb	r1, [r5, #26]
@   0x080224fa: 4048        eors	r0, r1
@   0x080224fc: 4240        negs	r0, r0
@   0x080224fe: 0fc0        lsrs	r0, r0, #31
@   0x08022500: 76a8        strb	r0, [r5, #26]
@   0x08022502: 8ea8        ldrh	r0, [r5, #52]	@ 0x34
@   0x08022504: 4330        orrs	r0, r6
@   0x08022506: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x08022508: 4814        ldr	r0, [pc, #80]	@ (0x2255c)
@   0x0802250a: 4284        cmp	r4, r0
@   0x0802250c: dd0a        ble.n	0x22524
@   0x0802250e: 4914        ldr	r1, [pc, #80]	@ (0x22560)
@   0x08022510: 4449        add	r1, r9
@   0x08022512: 4814        ldr	r0, [pc, #80]	@ (0x22564)
@   0x08022514: 8008        strh	r0, [r1, #0]
@   0x08022516: 3018        adds	r0, #24
@   0x08022518: 4a13        ldr	r2, [pc, #76]	@ (0x22568)
@   0x0802251a: 8010        strh	r0, [r2, #0]
@   0x0802251c: 76ae        strb	r6, [r5, #26]
@   0x0802251e: 8ea8        ldrh	r0, [r5, #52]	@ 0x34
@   0x08022520: 4330        orrs	r0, r6
@   0x08022522: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x08022524: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x08022526: 2380        movs	r3, #128	@ 0x80
@   0x08022528: 021b        lsls	r3, r3, #8
@   0x0802252a: 1c18        adds	r0, r3, #0
@   0x0802252c: 4008        ands	r0, r1
@   0x0802252e: 2800        cmp	r0, #0
@   0x08022530: d100        bne.n	0x22534
@   0x08022532: e0b9        b.n	0x226a8
@   0x08022534: 1c08        adds	r0, r1, #0
@   0x08022536: 4330        orrs	r0, r6
@   0x08022538: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x0802253a: 4641        mov	r1, r8
@   0x0802253c: 3145        adds	r1, #69	@ 0x45
@   0x0802253e: 00c8        lsls	r0, r1, #3
@   0x08022540: 1a40        subs	r0, r0, r1
@   0x08022542: 00c0        lsls	r0, r0, #3
@   0x08022544: 4448        add	r0, r9
@   0x08022546: 4c09        ldr	r4, [pc, #36]	@ (0x2256c)
@   0x08022548: 1c21        adds	r1, r4, #0
@   0x0802254a: 8e82        ldrh	r2, [r0, #52]	@ 0x34
@   0x0802254c: 4011        ands	r1, r2
@   0x0802254e: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x08022550: e0aa        b.n	0x226a8
@   0x08022552: 0000        movs	r0, r0
@   0x08022554: 0311        lsls	r1, r2, #12
@   0x08022556: 0000        movs	r0, r0
@   0x08022558: fd01        ffff 			@ <UNDEFINED> instruction: 0xfd01ffff
@   0x0802255c: 0375        lsls	r5, r6, #13
@   0x0802255e: 0000        movs	r0, r0
@   0x08022560: 0f1a        lsrs	r2, r3, #28
@   0x08022562: 0000        movs	r0, r0
@   0x08022564: 0143        lsls	r3, r0, #5
@   0x08022566: 0000        movs	r0, r0
@   0x08022568: 4672        mov	r2, lr
@   0x0802256a: 0300        lsls	r0, r0, #12
@   0x0802256c: 7fff        ldrb	r7, [r7, #31]
@   0x0802256e: 0000        movs	r0, r0
@   0x08022570: 2702        movs	r7, #2
@   0x08022572: 2002        movs	r0, #2
@   0x08022574: 8eab        ldrh	r3, [r5, #52]	@ 0x34
@   0x08022576: 4018        ands	r0, r3
@   0x08022578: 2800        cmp	r0, #0
@   0x0802257a: d000        beq.n	0x2257e
@   0x0802257c: e094        b.n	0x226a8
@   0x0802257e: 2004        movs	r0, #4
@   0x08022580: 5e2e        ldrsh	r6, [r5, r0]
@   0x08022582: 491d        ldr	r1, [pc, #116]	@ (0x225f8)
@   0x08022584: 428e        cmp	r6, r1
@   0x08022586: dd01        ble.n	0x2258c
@   0x08022588: 75ef        strb	r7, [r5, #23]
@   0x0802258a: 71af        strb	r7, [r5, #6]
@   0x0802258c: 2204        movs	r2, #4
@   0x0802258e: 5ea8        ldrsh	r0, [r5, r2]
@   0x08022590: 4b1a        ldr	r3, [pc, #104]	@ (0x225fc)
@   0x08022592: 18c0        adds	r0, r0, r3
@   0x08022594: 2118        movs	r1, #24
@   0x08022596: f011        fc3d 	bl	0x33e14
@   0x0802259a: 2800        cmp	r0, #0
@   0x0802259c: d107        bne.n	0x225ae
@   0x0802259e: 7ea8        ldrb	r0, [r5, #26]
@   0x080225a0: 4044        eors	r4, r0
@   0x080225a2: 4260        negs	r0, r4
@   0x080225a4: 0fc0        lsrs	r0, r0, #31
@   0x080225a6: 76a8        strb	r0, [r5, #26]
@   0x080225a8: 8ea8        ldrh	r0, [r5, #52]	@ 0x34
@   0x080225aa: 4338        orrs	r0, r7
@   0x080225ac: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x080225ae: 4814        ldr	r0, [pc, #80]	@ (0x22600)
@   0x080225b0: 4286        cmp	r6, r0
@   0x080225b2: dd0a        ble.n	0x225ca
@   0x080225b4: 4913        ldr	r1, [pc, #76]	@ (0x22604)
@   0x080225b6: 4449        add	r1, r9
@   0x080225b8: 4813        ldr	r0, [pc, #76]	@ (0x22608)
@   0x080225ba: 8008        strh	r0, [r1, #0]
@   0x080225bc: 3018        adds	r0, #24
@   0x080225be: 4913        ldr	r1, [pc, #76]	@ (0x2260c)
@   0x080225c0: 8008        strh	r0, [r1, #0]
@   0x080225c2: 76af        strb	r7, [r5, #26]
@   0x080225c4: 8ea8        ldrh	r0, [r5, #52]	@ 0x34
@   0x080225c6: 4338        orrs	r0, r7
@   0x080225c8: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x080225ca: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x080225cc: 2280        movs	r2, #128	@ 0x80
@   0x080225ce: 0212        lsls	r2, r2, #8
@   0x080225d0: 1c10        adds	r0, r2, #0
@   0x080225d2: 4008        ands	r0, r1
@   0x080225d4: 2800        cmp	r0, #0
@   0x080225d6: d067        beq.n	0x226a8
@   0x080225d8: 1c08        adds	r0, r1, #0
@   0x080225da: 4338        orrs	r0, r7
@   0x080225dc: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x080225de: 4641        mov	r1, r8
@   0x080225e0: 3145        adds	r1, #69	@ 0x45
@   0x080225e2: 00c8        lsls	r0, r1, #3
@   0x080225e4: 1a40        subs	r0, r0, r1
@   0x080225e6: 00c0        lsls	r0, r0, #3
@   0x080225e8: 4448        add	r0, r9
@   0x080225ea: 4b09        ldr	r3, [pc, #36]	@ (0x22610)
@   0x080225ec: 1c19        adds	r1, r3, #0
@   0x080225ee: 8e84        ldrh	r4, [r0, #52]	@ 0x34
@   0x080225f0: 4021        ands	r1, r4
@   0x080225f2: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x080225f4: e058        b.n	0x226a8
@   0x080225f6: 0000        movs	r0, r0
@   0x080225f8: 0311        lsls	r1, r2, #12
@   0x080225fa: 0000        movs	r0, r0
@   0x080225fc: fd01        ffff 			@ <UNDEFINED> instruction: 0xfd01ffff
@   0x08022600: 0376        lsls	r6, r6, #13
@   0x08022602: 0000        movs	r0, r0
@   0x08022604: 0f1a        lsrs	r2, r3, #28
@   0x08022606: 0000        movs	r0, r0
@   0x08022608: 0143        lsls	r3, r0, #5
@   0x0802260a: 0000        movs	r0, r0
@   0x0802260c: 4672        mov	r2, lr
@   0x0802260e: 0300        lsls	r0, r0, #12
@   0x08022610: 7fff        ldrb	r7, [r7, #31]
@   0x08022612: 0000        movs	r0, r0
@   0x08022614: 2302        movs	r3, #2
@   0x08022616: 8ea8        ldrh	r0, [r5, #52]	@ 0x34
@   0x08022618: 4004        ands	r4, r0
@   0x0802261a: 2c00        cmp	r4, #0
@   0x0802261c: d144        bne.n	0x226a8
@   0x0802261e: 482a        ldr	r0, [pc, #168]	@ (0x226c8)
@   0x08022620: 4a2a        ldr	r2, [pc, #168]	@ (0x226cc)
@   0x08022622: 1881        adds	r1, r0, r2
@   0x08022624: 2400        movs	r4, #0
@   0x08022626: 5f09        ldrsh	r1, [r1, r4]
@   0x08022628: 1c02        adds	r2, r0, #0
@   0x0802262a: 4551        cmp	r1, sl
@   0x0802262c: d10f        bne.n	0x2264e
@   0x0802262e: 4928        ldr	r1, [pc, #160]	@ (0x226d0)
@   0x08022630: 1850        adds	r0, r2, r1
@   0x08022632: 2400        movs	r4, #0
@   0x08022634: 5f01        ldrsh	r1, [r0, r4]
@   0x08022636: 4827        ldr	r0, [pc, #156]	@ (0x226d4)
@   0x08022638: 4281        cmp	r1, r0
@   0x0802263a: dd08        ble.n	0x2264e
@   0x0802263c: 4826        ldr	r0, [pc, #152]	@ (0x226d8)
@   0x0802263e: 1811        adds	r1, r2, r0
@   0x08022640: 2001        movs	r0, #1
@   0x08022642: 7008        strb	r0, [r1, #0]
@   0x08022644: 4c25        ldr	r4, [pc, #148]	@ (0x226dc)
@   0x08022646: 1911        adds	r1, r2, r4
@   0x08022648: 8808        ldrh	r0, [r1, #0]
@   0x0802264a: 4318        orrs	r0, r3
@   0x0802264c: 8008        strh	r0, [r1, #0]
@   0x0802264e: 4920        ldr	r1, [pc, #128]	@ (0x226d0)
@   0x08022650: 1850        adds	r0, r2, r1
@   0x08022652: 2300        movs	r3, #0
@   0x08022654: 5ec0        ldrsh	r0, [r0, r3]
@   0x08022656: 4550        cmp	r0, sl
@   0x08022658: d110        bne.n	0x2267c
@   0x0802265a: 4c1c        ldr	r4, [pc, #112]	@ (0x226cc)
@   0x0802265c: 1910        adds	r0, r2, r4
@   0x0802265e: 2300        movs	r3, #0
@   0x08022660: 5ec1        ldrsh	r1, [r0, r3]
@   0x08022662: 481c        ldr	r0, [pc, #112]	@ (0x226d4)
@   0x08022664: 4281        cmp	r1, r0
@   0x08022666: dd09        ble.n	0x2267c
@   0x08022668: 344e        adds	r4, #78	@ 0x4e
@   0x0802266a: 1911        adds	r1, r2, r4
@   0x0802266c: 2001        movs	r0, #1
@   0x0802266e: 7008        strb	r0, [r1, #0]
@   0x08022670: 481b        ldr	r0, [pc, #108]	@ (0x226e0)
@   0x08022672: 1811        adds	r1, r2, r0
@   0x08022674: 2002        movs	r0, #2
@   0x08022676: 880a        ldrh	r2, [r1, #0]
@   0x08022678: 4310        orrs	r0, r2
@   0x0802267a: 8008        strh	r0, [r1, #0]
@   0x0802267c: 7eeb        ldrb	r3, [r5, #27]
@   0x0802267e: 2b01        cmp	r3, #1
@   0x08022680: d105        bne.n	0x2268e
@   0x08022682: 1c28        adds	r0, r5, #0
@   0x08022684: 210e        movs	r1, #14
@   0x08022686: 2203        movs	r2, #3
@   0x08022688: 2303        movs	r3, #3
@   0x0802268a: f7fe        fb27 	bl	0x20cdc
@   0x0802268e: 2480        movs	r4, #128	@ 0x80
@   0x08022690: 0224        lsls	r4, r4, #8
@   0x08022692: 1c20        adds	r0, r4, #0
@   0x08022694: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x08022696: 4008        ands	r0, r1
@   0x08022698: 2800        cmp	r0, #0
@   0x0802269a: d005        beq.n	0x226a8
@   0x0802269c: 4652        mov	r2, sl
@   0x0802269e: 80aa        strh	r2, [r5, #4]
@   0x080226a0: 2004        movs	r0, #4
@   0x080226a2: 71a8        strb	r0, [r5, #6]
@   0x080226a4: 2003        movs	r0, #3
@   0x080226a6: 75e8        strb	r0, [r5, #23]
@   0x080226a8: 4640        mov	r0, r8
@   0x080226aa: 3001        adds	r0, #1
@   0x080226ac: 0600        lsls	r0, r0, #24
@   0x080226ae: 0e00        lsrs	r0, r0, #24
@   0x080226b0: 4680        mov	r8, r0
@   0x080226b2: 2801        cmp	r0, #1
@   0x080226b4: d800        bhi.n	0x226b8
@   0x080226b6: e6d3        b.n	0x22460
@   0x080226b8: 4c03        ldr	r4, [pc, #12]	@ (0x226c8)
@   0x080226ba: 4b07        ldr	r3, [pc, #28]	@ (0x226d8)
@   0x080226bc: 18e0        adds	r0, r4, r3
@   0x080226be: 7800        ldrb	r0, [r0, #0]
@   0x080226c0: 2802        cmp	r0, #2
@   0x080226c2: d10f        bne.n	0x226e4
@   0x080226c4: 2046        movs	r0, #70	@ 0x46
@   0x080226c6: e013        b.n	0x226f0
@   0x080226c8: 3720        adds	r7, #32
@   0x080226ca: 0300        lsls	r0, r0, #12
@   0x080226cc: 0f1c        lsrs	r4, r3, #28
@   0x080226ce: 0000        movs	r0, r0
@   0x080226d0: 0f54        lsrs	r4, r2, #29
@   0x080226d2: 0000        movs	r0, r0
@   0x080226d4: 0339        lsls	r1, r7, #12
@   0x080226d6: 0000        movs	r0, r0
@   0x080226d8: 0f32        lsrs	r2, r6, #28
@   0x080226da: 0000        movs	r0, r0
@   0x080226dc: 0f4c        lsrs	r4, r1, #29
@   0x080226de: 0000        movs	r0, r0
@   0x080226e0: 0f84        lsrs	r4, r0, #30
@   0x080226e2: 0000        movs	r0, r0
@   0x080226e4: 4b08        ldr	r3, [pc, #32]	@ (0x22708)
@   0x080226e6: 18e0        adds	r0, r4, r3
@   0x080226e8: 7800        ldrb	r0, [r0, #0]
@   0x080226ea: 2802        cmp	r0, #2
@   0x080226ec: d110        bne.n	0x22710
@   0x080226ee: 2045        movs	r0, #69	@ 0x45
@   0x080226f0: f7fe        fc24 	bl	0x20f3c
@   0x080226f4: 4905        ldr	r1, [pc, #20]	@ (0x2270c)
@   0x080226f6: 1860        adds	r0, r4, r1
@   0x080226f8: f7e3        f964 	bl	0x59c4
@   0x080226fc: 22f5        movs	r2, #245	@ 0xf5
@   0x080226fe: 0112        lsls	r2, r2, #4
@   0x08022700: 18a0        adds	r0, r4, r2
@   0x08022702: f7e3        f95f 	bl	0x59c4
@   0x08022706: e00b        b.n	0x22720
@   0x08022708: 0f6a        lsrs	r2, r5, #29
@   0x0802270a: 0000        movs	r0, r0
@   0x0802270c: 0f18        lsrs	r0, r3, #28
@   0x0802270e: 0000        movs	r0, r0
@   0x08022710: 2045        movs	r0, #69	@ 0x45
@   0x08022712: 2146        movs	r1, #70	@ 0x46
@   0x08022714: f7fe        fc66 	bl	0x20fe4
@   0x08022718: 2045        movs	r0, #69	@ 0x45
@   0x0802271a: 2146        movs	r1, #70	@ 0x46
@   0x0802271c: f7e3        faf8 	bl	0x5d10
@   0x08022720: bc38        pop	{r3, r4, r5}
@   0x08022722: 4698        mov	r8, r3
@   0x08022724: 46a1        mov	r9, r4
@   0x08022726: 46aa        mov	sl, r5
@   0x08022728: bcf0        pop	{r4, r5, r6, r7}
@   0x0802272a: bc01        pop	{r0}
@   0x0802272c: 4700        bx	r0

        thumb_func_start UpdateLogPairEntities
UpdateLogPairEntities: @ 0x08022434
        .incbin "frog_us_baserom.gba", 0x22434, 0x2fc
        thumb_func_end UpdateLogPairEntities
