@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08021510, 0x080217d4)  (708 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8021510 --end 0x80217d4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08021510: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08021512: 4657        mov	r7, sl
@   0x08021514: 464e        mov	r6, r9
@   0x08021516: 4645        mov	r5, r8
@   0x08021518: b4e0        push	{r5, r6, r7}
@   0x0802151a: b084        sub	sp, #16
@   0x0802151c: 9b0c        ldr	r3, [sp, #48]	@ 0x30
@   0x0802151e: 0600        lsls	r0, r0, #24
@   0x08021520: 0e00        lsrs	r0, r0, #24
@   0x08021522: 9000        str	r0, [sp, #0]
@   0x08021524: 0612        lsls	r2, r2, #24
@   0x08021526: 0e16        lsrs	r6, r2, #24
@   0x08021528: 061b        lsls	r3, r3, #24
@   0x0802152a: 0e1b        lsrs	r3, r3, #24
@   0x0802152c: 9301        str	r3, [sp, #4]
@   0x0802152e: 2000        movs	r0, #0
@   0x08021530: 9002        str	r0, [sp, #8]
@   0x08021532: 7809        ldrb	r1, [r1, #0]
@   0x08021534: 9103        str	r1, [sp, #12]
@   0x08021536: 4681        mov	r9, r0
@   0x08021538: 4288        cmp	r0, r1
@   0x0802153a: d300        bcc.n	0x2153e
@   0x0802153c: e135        b.n	0x217aa
@   0x0802153e: 4911        ldr	r1, [pc, #68]	@ (0x21584)
@   0x08021540: 4688        mov	r8, r1
@   0x08021542: 4a11        ldr	r2, [pc, #68]	@ (0x21588)
@   0x08021544: 4692        mov	sl, r2
@   0x08021546: 9800        ldr	r0, [sp, #0]
@   0x08021548: 4448        add	r0, r9
@   0x0802154a: 00c1        lsls	r1, r0, #3
@   0x0802154c: 1a09        subs	r1, r1, r0
@   0x0802154e: 00c9        lsls	r1, r1, #3
@   0x08021550: 4643        mov	r3, r8
@   0x08021552: 18cd        adds	r5, r1, r3
@   0x08021554: 8eaa        ldrh	r2, [r5, #52]	@ 0x34
@   0x08021556: 2108        movs	r1, #8
@   0x08021558: 4011        ands	r1, r2
@   0x0802155a: 1c07        adds	r7, r0, #0
@   0x0802155c: 2900        cmp	r1, #0
@   0x0802155e: d000        beq.n	0x21562
@   0x08021560: e11a        b.n	0x21798
@   0x08021562: 2080        movs	r0, #128	@ 0x80
@   0x08021564: 4010        ands	r0, r2
@   0x08021566: 2800        cmp	r0, #0
@   0x08021568: d100        bne.n	0x2156c
@   0x0802156a: e0f2        b.n	0x21752
@   0x0802156c: 2e0b        cmp	r6, #11
@   0x0802156e: d06d        beq.n	0x2164c
@   0x08021570: 2e0b        cmp	r6, #11
@   0x08021572: dc0f        bgt.n	0x21594
@   0x08021574: 2e03        cmp	r6, #3
@   0x08021576: d019        beq.n	0x215ac
@   0x08021578: 2e03        cmp	r6, #3
@   0x0802157a: dc07        bgt.n	0x2158c
@   0x0802157c: 2e02        cmp	r6, #2
@   0x0802157e: d041        beq.n	0x21604
@   0x08021580: e0e7        b.n	0x21752
@   0x08021582: 0000        movs	r0, r0
@   0x08021584: 3720        adds	r7, #32
@   0x08021586: 0300        lsls	r0, r0, #12
@   0x08021588: 6110        str	r0, [r2, #16]
@   0x0802158a: 0300        lsls	r0, r0, #12
@   0x0802158c: 2e04        cmp	r6, #4
@   0x0802158e: d100        bne.n	0x21592
@   0x08021590: e07a        b.n	0x21688
@   0x08021592: e0de        b.n	0x21752
@   0x08021594: 2e56        cmp	r6, #86	@ 0x56
@   0x08021596: d100        bne.n	0x2159a
@   0x08021598: e0a0        b.n	0x216dc
@   0x0802159a: 2e56        cmp	r6, #86	@ 0x56
@   0x0802159c: dc02        bgt.n	0x215a4
@   0x0802159e: 2e0c        cmp	r6, #12
@   0x080215a0: d01c        beq.n	0x215dc
@   0x080215a2: e0d6        b.n	0x21752
@   0x080215a4: 2e57        cmp	r6, #87	@ 0x57
@   0x080215a6: d100        bne.n	0x215aa
@   0x080215a8: e0b3        b.n	0x21712
@   0x080215aa: e0d2        b.n	0x21752
@   0x080215ac: 2006        movs	r0, #6
@   0x080215ae: f7ff        fb63 	bl	0x20c78
@   0x080215b2: 2008        movs	r0, #8
@   0x080215b4: 8eac        ldrh	r4, [r5, #52]	@ 0x34
@   0x080215b6: 4320        orrs	r0, r4
@   0x080215b8: 2104        movs	r1, #4
@   0x080215ba: 4308        orrs	r0, r1
@   0x080215bc: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x080215be: 4905        ldr	r1, [pc, #20]	@ (0x215d4)
@   0x080215c0: 884a        ldrh	r2, [r1, #2]
@   0x080215c2: 2302        movs	r3, #2
@   0x080215c4: 5ec8        ldrsh	r0, [r1, r3]
@   0x080215c6: 4c04        ldr	r4, [pc, #16]	@ (0x215d8)
@   0x080215c8: 42a0        cmp	r0, r4
@   0x080215ca: dd00        ble.n	0x215ce
@   0x080215cc: e080        b.n	0x216d0
@   0x080215ce: 1c50        adds	r0, r2, #1
@   0x080215d0: 8048        strh	r0, [r1, #2]
@   0x080215d2: e07d        b.n	0x216d0
@   0x080215d4: 35e0        adds	r5, #224	@ 0xe0
@   0x080215d6: 0300        lsls	r0, r0, #12
@   0x080215d8: 03e6        lsls	r6, r4, #15
@   0x080215da: 0000        movs	r0, r0
@   0x080215dc: 200d        movs	r0, #13
@   0x080215de: f7ff        fb4b 	bl	0x20c78
@   0x080215e2: 2008        movs	r0, #8
@   0x080215e4: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x080215e6: 4308        orrs	r0, r1
@   0x080215e8: 2204        movs	r2, #4
@   0x080215ea: 4310        orrs	r0, r2
@   0x080215ec: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x080215ee: 4904        ldr	r1, [pc, #16]	@ (0x21600)
@   0x080215f0: 780a        ldrb	r2, [r1, #0]
@   0x080215f2: 2000        movs	r0, #0
@   0x080215f4: 5608        ldrsb	r0, [r1, r0]
@   0x080215f6: 2862        cmp	r0, #98	@ 0x62
@   0x080215f8: dc6a        bgt.n	0x216d0
@   0x080215fa: 1c50        adds	r0, r2, #1
@   0x080215fc: 7008        strb	r0, [r1, #0]
@   0x080215fe: e067        b.n	0x216d0
@   0x08021600: 35e0        adds	r5, #224	@ 0xe0
@   0x08021602: 0300        lsls	r0, r0, #12
@   0x08021604: 2006        movs	r0, #6
@   0x08021606: f7ff        fb37 	bl	0x20c78
@   0x0802160a: 2008        movs	r0, #8
@   0x0802160c: 8eab        ldrh	r3, [r5, #52]	@ 0x34
@   0x0802160e: 4318        orrs	r0, r3
@   0x08021610: 2404        movs	r4, #4
@   0x08021612: 4320        orrs	r0, r4
@   0x08021614: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x08021616: 9801        ldr	r0, [sp, #4]
@   0x08021618: 4448        add	r0, r9
@   0x0802161a: 2201        movs	r2, #1
@   0x0802161c: 4082        lsls	r2, r0
@   0x0802161e: 17d3        asrs	r3, r2, #31
@   0x08021620: 4654        mov	r4, sl
@   0x08021622: 6860        ldr	r0, [r4, #4]
@   0x08021624: 68a1        ldr	r1, [r4, #8]
@   0x08021626: 4310        orrs	r0, r2
@   0x08021628: 4319        orrs	r1, r3
@   0x0802162a: 4652        mov	r2, sl
@   0x0802162c: 6050        str	r0, [r2, #4]
@   0x0802162e: 6091        str	r1, [r2, #8]
@   0x08021630: 4904        ldr	r1, [pc, #16]	@ (0x21644)
@   0x08021632: 884a        ldrh	r2, [r1, #2]
@   0x08021634: 2302        movs	r3, #2
@   0x08021636: 5ec8        ldrsh	r0, [r1, r3]
@   0x08021638: 4c03        ldr	r4, [pc, #12]	@ (0x21648)
@   0x0802163a: 42a0        cmp	r0, r4
@   0x0802163c: dc48        bgt.n	0x216d0
@   0x0802163e: 1c50        adds	r0, r2, #1
@   0x08021640: 8048        strh	r0, [r1, #2]
@   0x08021642: e045        b.n	0x216d0
@   0x08021644: 35e0        adds	r5, #224	@ 0xe0
@   0x08021646: 0300        lsls	r0, r0, #12
@   0x08021648: 03e6        lsls	r6, r4, #15
@   0x0802164a: 0000        movs	r0, r0
@   0x0802164c: 200d        movs	r0, #13
@   0x0802164e: f7ff        fb13 	bl	0x20c78
@   0x08021652: 2008        movs	r0, #8
@   0x08021654: 8ea9        ldrh	r1, [r5, #52]	@ 0x34
@   0x08021656: 4308        orrs	r0, r1
@   0x08021658: 2204        movs	r2, #4
@   0x0802165a: 4310        orrs	r0, r2
@   0x0802165c: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x0802165e: 9901        ldr	r1, [sp, #4]
@   0x08021660: 4449        add	r1, r9
@   0x08021662: 2001        movs	r0, #1
@   0x08021664: 4088        lsls	r0, r1
@   0x08021666: 4653        mov	r3, sl
@   0x08021668: 899b        ldrh	r3, [r3, #12]
@   0x0802166a: 4318        orrs	r0, r3
@   0x0802166c: 4654        mov	r4, sl
@   0x0802166e: 81a0        strh	r0, [r4, #12]
@   0x08021670: 4904        ldr	r1, [pc, #16]	@ (0x21684)
@   0x08021672: 780a        ldrb	r2, [r1, #0]
@   0x08021674: 2000        movs	r0, #0
@   0x08021676: 5608        ldrsb	r0, [r1, r0]
@   0x08021678: 2862        cmp	r0, #98	@ 0x62
@   0x0802167a: dc29        bgt.n	0x216d0
@   0x0802167c: 1c50        adds	r0, r2, #1
@   0x0802167e: 7008        strb	r0, [r1, #0]
@   0x08021680: e026        b.n	0x216d0
@   0x08021682: 0000        movs	r0, r0
@   0x08021684: 35e0        adds	r5, #224	@ 0xe0
@   0x08021686: 0300        lsls	r0, r0, #12
@   0x08021688: 4803        ldr	r0, [pc, #12]	@ (0x21698)
@   0x0802168a: 7a80        ldrb	r0, [r0, #10]
@   0x0802168c: 280f        cmp	r0, #15
@   0x0802168e: d105        bne.n	0x2169c
@   0x08021690: 207b        movs	r0, #123	@ 0x7b
@   0x08021692: f7ff        faf1 	bl	0x20c78
@   0x08021696: e004        b.n	0x216a2
@   0x08021698: 5330        strh	r0, [r6, r4]
@   0x0802169a: 0300        lsls	r0, r0, #12
@   0x0802169c: 2007        movs	r0, #7
@   0x0802169e: f7ff        faeb 	bl	0x20c78
@   0x080216a2: 00f8        lsls	r0, r7, #3
@   0x080216a4: 1bc0        subs	r0, r0, r7
@   0x080216a6: 00c0        lsls	r0, r0, #3
@   0x080216a8: 4440        add	r0, r8
@   0x080216aa: 2108        movs	r1, #8
@   0x080216ac: 8e82        ldrh	r2, [r0, #52]	@ 0x34
@   0x080216ae: 4311        orrs	r1, r2
@   0x080216b0: 2304        movs	r3, #4
@   0x080216b2: 4319        orrs	r1, r3
@   0x080216b4: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x080216b6: 9901        ldr	r1, [sp, #4]
@   0x080216b8: 4449        add	r1, r9
@   0x080216ba: 2001        movs	r0, #1
@   0x080216bc: 4088        lsls	r0, r1
@   0x080216be: 4654        mov	r4, sl
@   0x080216c0: 8824        ldrh	r4, [r4, #0]
@   0x080216c2: 4320        orrs	r0, r4
@   0x080216c4: 4651        mov	r1, sl
@   0x080216c6: 8008        strh	r0, [r1, #0]
@   0x080216c8: 4903        ldr	r1, [pc, #12]	@ (0x216d8)
@   0x080216ca: 7908        ldrb	r0, [r1, #4]
@   0x080216cc: 3001        adds	r0, #1
@   0x080216ce: 7108        strb	r0, [r1, #4]
@   0x080216d0: f7f5        f9b6 	bl	0x16a40
@   0x080216d4: e03d        b.n	0x21752
@   0x080216d6: 0000        movs	r0, r0
@   0x080216d8: 35e0        adds	r5, #224	@ 0xe0
@   0x080216da: 0300        lsls	r0, r0, #12
@   0x080216dc: 203a        movs	r0, #58	@ 0x3a
@   0x080216de: f7ff        facb 	bl	0x20c78
@   0x080216e2: 2202        movs	r2, #2
@   0x080216e4: 5ea8        ldrsh	r0, [r5, r2]
@   0x080216e6: 2118        movs	r1, #24
@   0x080216e8: f012        fb14 	bl	0x33d14
@   0x080216ec: 1c04        adds	r4, r0, #0
@   0x080216ee: 0424        lsls	r4, r4, #16
@   0x080216f0: 1424        asrs	r4, r4, #16
@   0x080216f2: 2304        movs	r3, #4
@   0x080216f4: 5ee8        ldrsh	r0, [r5, r3]
@   0x080216f6: 2118        movs	r1, #24
@   0x080216f8: f012        fb0c 	bl	0x33d14
@   0x080216fc: 1c01        adds	r1, r0, #0
@   0x080216fe: 0409        lsls	r1, r1, #16
@   0x08021700: 1409        asrs	r1, r1, #16
@   0x08021702: 1c20        adds	r0, r4, #0
@   0x08021704: f7eb        fddc 	bl	0xd2c0
@   0x08021708: 4644        mov	r4, r8
@   0x0802170a: 8a20        ldrh	r0, [r4, #16]
@   0x0802170c: 3001        adds	r0, #1
@   0x0802170e: 8220        strh	r0, [r4, #16]
@   0x08021710: e7de        b.n	0x216d0
@   0x08021712: 2040        movs	r0, #64	@ 0x40
@   0x08021714: f7ff        fab0 	bl	0x20c78
@   0x08021718: 2102        movs	r1, #2
@   0x0802171a: 5e68        ldrsh	r0, [r5, r1]
@   0x0802171c: 2118        movs	r1, #24
@   0x0802171e: f012        faf9 	bl	0x33d14
@   0x08021722: 1c04        adds	r4, r0, #0
@   0x08021724: 0424        lsls	r4, r4, #16
@   0x08021726: 1424        asrs	r4, r4, #16
@   0x08021728: 2204        movs	r2, #4
@   0x0802172a: 5ea8        ldrsh	r0, [r5, r2]
@   0x0802172c: 2118        movs	r1, #24
@   0x0802172e: f012        faf1 	bl	0x33d14
@   0x08021732: 1c01        adds	r1, r0, #0
@   0x08021734: 0409        lsls	r1, r1, #16
@   0x08021736: 1409        asrs	r1, r1, #16
@   0x08021738: 1c20        adds	r0, r4, #0
@   0x0802173a: f7eb        fdc1 	bl	0xd2c0
@   0x0802173e: 4643        mov	r3, r8
@   0x08021740: 8a19        ldrh	r1, [r3, #16]
@   0x08021742: 2410        movs	r4, #16
@   0x08021744: 5f18        ldrsh	r0, [r3, r4]
@   0x08021746: 2800        cmp	r0, #0
@   0x08021748: dd01        ble.n	0x2174e
@   0x0802174a: 1e48        subs	r0, r1, #1
@   0x0802174c: 8218        strh	r0, [r3, #16]
@   0x0802174e: f7f5        f977 	bl	0x16a40
@   0x08021752: 9802        ldr	r0, [sp, #8]
@   0x08021754: 2800        cmp	r0, #0
@   0x08021756: d102        bne.n	0x2175e
@   0x08021758: 0638        lsls	r0, r7, #24
@   0x0802175a: 0e00        lsrs	r0, r0, #24
@   0x0802175c: 9002        str	r0, [sp, #8]
@   0x0802175e: 481b        ldr	r0, [pc, #108]	@ (0x217cc)
@   0x08021760: 1c39        adds	r1, r7, #0
@   0x08021762: f7e5        f903 	bl	0x696c
@   0x08021766: 00f8        lsls	r0, r7, #3
@   0x08021768: 1bc0        subs	r0, r0, r7
@   0x0802176a: 00c0        lsls	r0, r0, #3
@   0x0802176c: 4641        mov	r1, r8
@   0x0802176e: 1842        adds	r2, r0, r1
@   0x08021770: 8e91        ldrh	r1, [r2, #52]	@ 0x34
@   0x08021772: 2302        movs	r3, #2
@   0x08021774: 2002        movs	r0, #2
@   0x08021776: 4008        ands	r0, r1
@   0x08021778: 2800        cmp	r0, #0
@   0x0802177a: d116        bne.n	0x217aa
@   0x0802177c: 2480        movs	r4, #128	@ 0x80
@   0x0802177e: 0224        lsls	r4, r4, #8
@   0x08021780: 1c20        adds	r0, r4, #0
@   0x08021782: 4008        ands	r0, r1
@   0x08021784: 2800        cmp	r0, #0
@   0x08021786: d007        beq.n	0x21798
@   0x08021788: 1c08        adds	r0, r1, #0
@   0x0802178a: 4318        orrs	r0, r3
@   0x0802178c: 2100        movs	r1, #0
@   0x0802178e: 4308        orrs	r0, r1
@   0x08021790: 4b0f        ldr	r3, [pc, #60]	@ (0x217d0)
@   0x08021792: 1c19        adds	r1, r3, #0
@   0x08021794: 4008        ands	r0, r1
@   0x08021796: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x08021798: 4648        mov	r0, r9
@   0x0802179a: 3001        adds	r0, #1
@   0x0802179c: 0600        lsls	r0, r0, #24
@   0x0802179e: 0e00        lsrs	r0, r0, #24
@   0x080217a0: 4681        mov	r9, r0
@   0x080217a2: 9c03        ldr	r4, [sp, #12]
@   0x080217a4: 45a1        cmp	r9, r4
@   0x080217a6: d200        bcs.n	0x217aa
@   0x080217a8: e6cd        b.n	0x21546
@   0x080217aa: 9802        ldr	r0, [sp, #8]
@   0x080217ac: 2800        cmp	r0, #0
@   0x080217ae: d005        beq.n	0x217bc
@   0x080217b0: 9a00        ldr	r2, [sp, #0]
@   0x080217b2: 9b03        ldr	r3, [sp, #12]
@   0x080217b4: 18d1        adds	r1, r2, r3
@   0x080217b6: 3901        subs	r1, #1
@   0x080217b8: f7e4        faaa 	bl	0x5d10
@   0x080217bc: b004        add	sp, #16
@   0x080217be: bc38        pop	{r3, r4, r5}
@   0x080217c0: 4698        mov	r8, r3
@   0x080217c2: 46a1        mov	r9, r4
@   0x080217c4: 46aa        mov	sl, r5
@   0x080217c6: bcf0        pop	{r4, r5, r6, r7}
@   0x080217c8: bc01        pop	{r0}
@   0x080217ca: 4700        bx	r0
@   0x080217cc: 6110        str	r0, [r2, #16]
@   0x080217ce: 0300        lsls	r0, r0, #12
@   0x080217d0: 7fff        ldrb	r7, [r7, #31]

        thumb_func_start sub_08021510
sub_08021510: @ 0x08021510
        .incbin "frog_us_baserom.gba", 0x21510, 0x2c4
        thumb_func_end sub_08021510
