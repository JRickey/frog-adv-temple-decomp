@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08016404, 0x08016650)  (588 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8016404 --end 0x8016650 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08016404: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08016406: 4657        mov	r7, sl
@   0x08016408: 464e        mov	r6, r9
@   0x0801640a: 4645        mov	r5, r8
@   0x0801640c: b4e0        push	{r5, r6, r7}
@   0x0801640e: b084        sub	sp, #16
@   0x08016410: 9001        str	r0, [sp, #4]
@   0x08016412: 0609        lsls	r1, r1, #24
@   0x08016414: 0e09        lsrs	r1, r1, #24
@   0x08016416: 9102        str	r1, [sp, #8]
@   0x08016418: 4824        ldr	r0, [pc, #144]	@ (0x164ac)
@   0x0801641a: 2100        movs	r1, #0
@   0x0801641c: 2500        movs	r5, #0
@   0x0801641e: 8045        strh	r5, [r0, #2]
@   0x08016420: 8005        strh	r5, [r0, #0]
@   0x08016422: 4e23        ldr	r6, [pc, #140]	@ (0x164b0)
@   0x08016424: 7171        strb	r1, [r6, #5]
@   0x08016426: 4823        ldr	r0, [pc, #140]	@ (0x164b4)
@   0x08016428: 6880        ldr	r0, [r0, #8]
@   0x0801642a: 3830        subs	r0, #48	@ 0x30
@   0x0801642c: 0404        lsls	r4, r0, #16
@   0x0801642e: 0c20        lsrs	r0, r4, #16
@   0x08016430: 4680        mov	r8, r0
@   0x08016432: 2180        movs	r1, #128	@ 0x80
@   0x08016434: 0449        lsls	r1, r1, #17
@   0x08016436: 1909        adds	r1, r1, r4
@   0x08016438: 4689        mov	r9, r1
@   0x0801643a: 0c08        lsrs	r0, r1, #16
@   0x0801643c: 4f1e        ldr	r7, [pc, #120]	@ (0x164b8)
@   0x0801643e: 887a        ldrh	r2, [r7, #2]
@   0x08016440: 4590        cmp	r8, r2
@   0x08016442: d300        bcc.n	0x16446
@   0x08016444: e0f2        b.n	0x1662c
@   0x08016446: 893b        ldrh	r3, [r7, #8]
@   0x08016448: 4298        cmp	r0, r3
@   0x0801644a: d800        bhi.n	0x1644e
@   0x0801644c: e0ee        b.n	0x1662c
@   0x0801644e: 4668        mov	r0, sp
@   0x08016450: 8005        strh	r5, [r0, #0]
@   0x08016452: 481a        ldr	r0, [pc, #104]	@ (0x164bc)
@   0x08016454: 4669        mov	r1, sp
@   0x08016456: 6001        str	r1, [r0, #0]
@   0x08016458: 4b19        ldr	r3, [pc, #100]	@ (0x164c0)
@   0x0801645a: 6043        str	r3, [r0, #4]
@   0x0801645c: 4a19        ldr	r2, [pc, #100]	@ (0x164c4)
@   0x0801645e: 6082        str	r2, [r0, #8]
@   0x08016460: 6881        ldr	r1, [r0, #8]
@   0x08016462: 4669        mov	r1, sp
@   0x08016464: 800d        strh	r5, [r1, #0]
@   0x08016466: 6001        str	r1, [r0, #0]
@   0x08016468: 4917        ldr	r1, [pc, #92]	@ (0x164c8)
@   0x0801646a: 6041        str	r1, [r0, #4]
@   0x0801646c: 6082        str	r2, [r0, #8]
@   0x0801646e: 6880        ldr	r0, [r0, #8]
@   0x08016470: 2001        movs	r0, #1
@   0x08016472: 7170        strb	r0, [r6, #5]
@   0x08016474: 7130        strb	r0, [r6, #4]
@   0x08016476: 2600        movs	r6, #0
@   0x08016478: 46bc        mov	ip, r7
@   0x0801647a: 0ce4        lsrs	r4, r4, #19
@   0x0801647c: 46a2        mov	sl, r4
@   0x0801647e: 4f13        ldr	r7, [pc, #76]	@ (0x164cc)
@   0x08016480: 464a        mov	r2, r9
@   0x08016482: 0cd2        lsrs	r2, r2, #19
@   0x08016484: 4691        mov	r9, r2
@   0x08016486: 231f        movs	r3, #31
@   0x08016488: 00f0        lsls	r0, r6, #3
@   0x0801648a: 4665        mov	r5, ip
@   0x0801648c: 1944        adds	r4, r0, r5
@   0x0801648e: 8822        ldrh	r2, [r4, #0]
@   0x08016490: 08d1        lsrs	r1, r2, #3
@   0x08016492: 9003        str	r0, [sp, #12]
@   0x08016494: 458a        cmp	sl, r1
@   0x08016496: d21b        bcs.n	0x164d0
@   0x08016498: 0130        lsls	r0, r6, #4
@   0x0801649a: 19c2        adds	r2, r0, r7
@   0x0801649c: 8824        ldrh	r4, [r4, #0]
@   0x0801649e: 4645        mov	r5, r8
@   0x080164a0: 1b61        subs	r1, r4, r5
@   0x080164a2: 10c9        asrs	r1, r1, #3
@   0x080164a4: 3101        adds	r1, #1
@   0x080164a6: 8011        strh	r1, [r2, #0]
@   0x080164a8: 1c02        adds	r2, r0, #0
@   0x080164aa: e015        b.n	0x164d8
@   0x080164ac: 65d0        str	r0, [r2, #92]	@ 0x5c
@   0x080164ae: 0300        lsls	r0, r0, #12
@   0x080164b0: 3608        adds	r6, #8
@   0x080164b2: 0300        lsls	r0, r0, #12
@   0x080164b4: 60a0        str	r0, [r4, #8]
@   0x080164b6: 0300        lsls	r0, r0, #12
@   0x080164b8: 696c        ldr	r4, [r5, #20]
@   0x080164ba: 0830        lsrs	r0, r6, #32
@   0x080164bc: 00d4        lsls	r4, r2, #3
@   0x080164be: 0400        lsls	r0, r0, #16
@   0x080164c0: 53a0        strh	r0, [r4, r6]
@   0x080164c2: 0300        lsls	r0, r0, #12
@   0x080164c4: 0050        lsls	r0, r2, #1
@   0x080164c6: 8100        strh	r0, [r0, #8]
@   0x080164c8: 3610        adds	r6, #16
@   0x080164ca: 0300        lsls	r0, r0, #12
@   0x080164cc: 63c0        str	r0, [r0, #60]	@ 0x3c
@   0x080164ce: 0300        lsls	r0, r0, #12
@   0x080164d0: 0132        lsls	r2, r6, #4
@   0x080164d2: 19d1        adds	r1, r2, r7
@   0x080164d4: 2000        movs	r0, #0
@   0x080164d6: 8008        strh	r0, [r1, #0]
@   0x080164d8: 9903        ldr	r1, [sp, #12]
@   0x080164da: 4461        add	r1, ip
@   0x080164dc: 884c        ldrh	r4, [r1, #2]
@   0x080164de: 08e0        lsrs	r0, r4, #3
@   0x080164e0: 4581        cmp	r9, r0
@   0x080164e2: d202        bcs.n	0x164ea
@   0x080164e4: 19d0        adds	r0, r2, r7
@   0x080164e6: 8043        strh	r3, [r0, #2]
@   0x080164e8: e00a        b.n	0x16500
@   0x080164ea: 19d2        adds	r2, r2, r7
@   0x080164ec: 8849        ldrh	r1, [r1, #2]
@   0x080164ee: 4645        mov	r5, r8
@   0x080164f0: 1b48        subs	r0, r1, r5
@   0x080164f2: 10c0        asrs	r0, r0, #3
@   0x080164f4: 8050        strh	r0, [r2, #2]
@   0x080164f6: 0400        lsls	r0, r0, #16
@   0x080164f8: 1400        asrs	r0, r0, #16
@   0x080164fa: 281f        cmp	r0, #31
@   0x080164fc: dd00        ble.n	0x16500
@   0x080164fe: 8053        strh	r3, [r2, #2]
@   0x08016500: 1c70        adds	r0, r6, #1
@   0x08016502: 0600        lsls	r0, r0, #24
@   0x08016504: 0e06        lsrs	r6, r0, #24
@   0x08016506: 2e01        cmp	r6, #1
@   0x08016508: d9be        bls.n	0x16488
@   0x0801650a: 2600        movs	r6, #0
@   0x0801650c: 9802        ldr	r0, [sp, #8]
@   0x0801650e: 4286        cmp	r6, r0
@   0x08016510: d27a        bcs.n	0x16608
@   0x08016512: 490e        ldr	r1, [pc, #56]	@ (0x1654c)
@   0x08016514: 468a        mov	sl, r1
@   0x08016516: 4a0e        ldr	r2, [pc, #56]	@ (0x16550)
@   0x08016518: 4691        mov	r9, r2
@   0x0801651a: 46c8        mov	r8, r9
@   0x0801651c: 00f0        lsls	r0, r6, #3
@   0x0801651e: 9b01        ldr	r3, [sp, #4]
@   0x08016520: 18c1        adds	r1, r0, r3
@   0x08016522: 4655        mov	r5, sl
@   0x08016524: 68ac        ldr	r4, [r5, #8]
@   0x08016526: 4684        mov	ip, r0
@   0x08016528: 1c77        adds	r7, r6, #1
@   0x0801652a: 8848        ldrh	r0, [r1, #2]
@   0x0801652c: 4284        cmp	r4, r0
@   0x0801652e: da66        bge.n	0x165fe
@   0x08016530: 2280        movs	r2, #128	@ 0x80
@   0x08016532: 0052        lsls	r2, r2, #1
@   0x08016534: 18a0        adds	r0, r4, r2
@   0x08016536: 880b        ldrh	r3, [r1, #0]
@   0x08016538: 4298        cmp	r0, r3
@   0x0801653a: dd60        ble.n	0x165fe
@   0x0801653c: 429c        cmp	r4, r3
@   0x0801653e: dd09        ble.n	0x16554
@   0x08016540: 0132        lsls	r2, r6, #4
@   0x08016542: 4643        mov	r3, r8
@   0x08016544: 18d1        adds	r1, r2, r3
@   0x08016546: 2000        movs	r0, #0
@   0x08016548: e008        b.n	0x1655c
@   0x0801654a: 0000        movs	r0, r0
@   0x0801654c: 60a0        str	r0, [r4, #8]
@   0x0801654e: 0300        lsls	r0, r0, #12
@   0x08016550: 6360        str	r0, [r4, #52]	@ 0x34
@   0x08016552: 0300        lsls	r0, r0, #12
@   0x08016554: 0132        lsls	r2, r6, #4
@   0x08016556: 4645        mov	r5, r8
@   0x08016558: 1951        adds	r1, r2, r5
@   0x0801655a: 1b18        subs	r0, r3, r4
@   0x0801655c: 8008        strh	r0, [r1, #0]
@   0x0801655e: 1c15        adds	r5, r2, #0
@   0x08016560: 4650        mov	r0, sl
@   0x08016562: 6884        ldr	r4, [r0, #8]
@   0x08016564: 2280        movs	r2, #128	@ 0x80
@   0x08016566: 0052        lsls	r2, r2, #1
@   0x08016568: 18a1        adds	r1, r4, r2
@   0x0801656a: 9801        ldr	r0, [sp, #4]
@   0x0801656c: 4460        add	r0, ip
@   0x0801656e: 8840        ldrh	r0, [r0, #2]
@   0x08016570: 4281        cmp	r1, r0
@   0x08016572: da03        bge.n	0x1657c
@   0x08016574: 4643        mov	r3, r8
@   0x08016576: 18e9        adds	r1, r5, r3
@   0x08016578: 20ff        movs	r0, #255	@ 0xff
@   0x0801657a: e002        b.n	0x16582
@   0x0801657c: 4642        mov	r2, r8
@   0x0801657e: 18a9        adds	r1, r5, r2
@   0x08016580: 1b00        subs	r0, r0, r4
@   0x08016582: 8048        strh	r0, [r1, #2]
@   0x08016584: 4640        mov	r0, r8
@   0x08016586: 3008        adds	r0, #8
@   0x08016588: 182a        adds	r2, r5, r0
@   0x0801658a: 4b08        ldr	r3, [pc, #32]	@ (0x165ac)
@   0x0801658c: 681c        ldr	r4, [r3, #0]
@   0x0801658e: 6810        ldr	r0, [r2, #0]
@   0x08016590: 1a20        subs	r0, r4, r0
@   0x08016592: 4643        mov	r3, r8
@   0x08016594: 18e9        adds	r1, r5, r3
@   0x08016596: 7b0b        ldrb	r3, [r1, #12]
@   0x08016598: 4298        cmp	r0, r3
@   0x0801659a: d30c        bcc.n	0x165b6
@   0x0801659c: 6014        str	r4, [r2, #0]
@   0x0801659e: 7948        ldrb	r0, [r1, #5]
@   0x080165a0: 2800        cmp	r0, #0
@   0x080165a2: d105        bne.n	0x165b0
@   0x080165a4: 7908        ldrb	r0, [r1, #4]
@   0x080165a6: 3001        adds	r0, #1
@   0x080165a8: e004        b.n	0x165b4
@   0x080165aa: 0000        movs	r0, r0
@   0x080165ac: 5330        strh	r0, [r6, r4]
@   0x080165ae: 0300        lsls	r0, r0, #12
@   0x080165b0: 7908        ldrb	r0, [r1, #4]
@   0x080165b2: 3801        subs	r0, #1
@   0x080165b4: 7108        strb	r0, [r1, #4]
@   0x080165b6: 1c29        adds	r1, r5, #0
@   0x080165b8: 4644        mov	r4, r8
@   0x080165ba: 1908        adds	r0, r1, r4
@   0x080165bc: 8803        ldrh	r3, [r0, #0]
@   0x080165be: 2202        movs	r2, #2
@   0x080165c0: 5e80        ldrsh	r0, [r0, r2]
@   0x080165c2: 1c77        adds	r7, r6, #1
@   0x080165c4: 4283        cmp	r3, r0
@   0x080165c6: da1a        bge.n	0x165fe
@   0x080165c8: 464c        mov	r4, r9
@   0x080165ca: 4e04        ldr	r6, [pc, #16]	@ (0x165dc)
@   0x080165cc: 190a        adds	r2, r1, r4
@   0x080165ce: 2010        movs	r0, #16
@   0x080165d0: 7951        ldrb	r1, [r2, #5]
@   0x080165d2: 4008        ands	r0, r1
@   0x080165d4: 2800        cmp	r0, #0
@   0x080165d6: d005        beq.n	0x165e4
@   0x080165d8: 4801        ldr	r0, [pc, #4]	@ (0x165e0)
@   0x080165da: e004        b.n	0x165e6
@   0x080165dc: 6360        str	r0, [r4, #52]	@ 0x34
@   0x080165de: 0300        lsls	r0, r0, #12
@   0x080165e0: 3610        adds	r6, #16
@   0x080165e2: 0300        lsls	r0, r0, #12
@   0x080165e4: 4815        ldr	r0, [pc, #84]	@ (0x1663c)
@   0x080165e6: 1819        adds	r1, r3, r0
@   0x080165e8: 7910        ldrb	r0, [r2, #4]
@   0x080165ea: 7008        strb	r0, [r1, #0]
@   0x080165ec: 1c58        adds	r0, r3, #1
@   0x080165ee: 0400        lsls	r0, r0, #16
@   0x080165f0: 0c03        lsrs	r3, r0, #16
@   0x080165f2: 1c29        adds	r1, r5, #0
@   0x080165f4: 1988        adds	r0, r1, r6
@   0x080165f6: 2202        movs	r2, #2
@   0x080165f8: 5e80        ldrsh	r0, [r0, r2]
@   0x080165fa: 4283        cmp	r3, r0
@   0x080165fc: dbe6        blt.n	0x165cc
@   0x080165fe: 0638        lsls	r0, r7, #24
@   0x08016600: 0e06        lsrs	r6, r0, #24
@   0x08016602: 9b02        ldr	r3, [sp, #8]
@   0x08016604: 429e        cmp	r6, r3
@   0x08016606: d389        bcc.n	0x1651c
@   0x08016608: 4668        mov	r0, sp
@   0x0801660a: 2300        movs	r3, #0
@   0x0801660c: 8003        strh	r3, [r0, #0]
@   0x0801660e: 480c        ldr	r0, [pc, #48]	@ (0x16640)
@   0x08016610: 466c        mov	r4, sp
@   0x08016612: 6004        str	r4, [r0, #0]
@   0x08016614: 4d0b        ldr	r5, [pc, #44]	@ (0x16644)
@   0x08016616: 6045        str	r5, [r0, #4]
@   0x08016618: 4a0b        ldr	r2, [pc, #44]	@ (0x16648)
@   0x0801661a: 6082        str	r2, [r0, #8]
@   0x0801661c: 6881        ldr	r1, [r0, #8]
@   0x0801661e: 4669        mov	r1, sp
@   0x08016620: 800b        strh	r3, [r1, #0]
@   0x08016622: 6004        str	r4, [r0, #0]
@   0x08016624: 4909        ldr	r1, [pc, #36]	@ (0x1664c)
@   0x08016626: 6041        str	r1, [r0, #4]
@   0x08016628: 6082        str	r2, [r0, #8]
@   0x0801662a: 6880        ldr	r0, [r0, #8]
@   0x0801662c: b004        add	sp, #16
@   0x0801662e: bc38        pop	{r3, r4, r5}
@   0x08016630: 4698        mov	r8, r3
@   0x08016632: 46a1        mov	r9, r4
@   0x08016634: 46aa        mov	sl, r5
@   0x08016636: bcf0        pop	{r4, r5, r6, r7}
@   0x08016638: bc01        pop	{r0}
@   0x0801663a: 4700        bx	r0
@   0x0801663c: 53a0        strh	r0, [r4, r6]
@   0x0801663e: 0300        lsls	r0, r0, #12
@   0x08016640: 00d4        lsls	r4, r2, #3
@   0x08016642: 0400        lsls	r0, r0, #16
@   0x08016644: 5440        strb	r0, [r0, r1]
@   0x08016646: 0300        lsls	r0, r0, #12
@   0x08016648: 0030        movs	r0, r6
@   0x0801664a: 8100        strh	r0, [r0, #8]
@   0x0801664c: 36b0        adds	r6, #176	@ 0xb0
@   0x0801664e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08016404
sub_08016404: @ 0x08016404
        .incbin "frog_us_baserom.gba", 0x16404, 0x24c
        thumb_func_end sub_08016404
