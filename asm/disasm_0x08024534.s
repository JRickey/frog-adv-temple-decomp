@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08024534, 0x080247ac)  (632 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8024534 --end 0x80247ac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08024534: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08024536: 464f        mov	r7, r9
@   0x08024538: 4646        mov	r6, r8
@   0x0802453a: b4c0        push	{r6, r7}
@   0x0802453c: b084        sub	sp, #16
@   0x0802453e: 2600        movs	r6, #0
@   0x08024540: 4c06        ldr	r4, [pc, #24]	@ (0x2455c)
@   0x08024542: 1c31        adds	r1, r6, #0
@   0x08024544: 314b        adds	r1, #75	@ 0x4b
@   0x08024546: 00c8        lsls	r0, r1, #3
@   0x08024548: 1a40        subs	r0, r0, r1
@   0x0802454a: 00c0        lsls	r0, r0, #3
@   0x0802454c: 1902        adds	r2, r0, r4
@   0x0802454e: 7e90        ldrb	r0, [r2, #26]
@   0x08024550: 1c0f        adds	r7, r1, #0
@   0x08024552: 2800        cmp	r0, #0
@   0x08024554: d004        beq.n	0x24560
@   0x08024556: 2801        cmp	r0, #1
@   0x08024558: d016        beq.n	0x24588
@   0x0802455a: e07f        b.n	0x2465c
@   0x0802455c: 3720        adds	r7, #32
@   0x0802455e: 0300        lsls	r0, r0, #12
@   0x08024560: 8e91        ldrh	r1, [r2, #52]	@ 0x34
@   0x08024562: 2302        movs	r3, #2
@   0x08024564: 2002        movs	r0, #2
@   0x08024566: 4008        ands	r0, r1
@   0x08024568: 2800        cmp	r0, #0
@   0x0802456a: d177        bne.n	0x2465c
@   0x0802456c: 2580        movs	r5, #128	@ 0x80
@   0x0802456e: 022d        lsls	r5, r5, #8
@   0x08024570: 1c28        adds	r0, r5, #0
@   0x08024572: 4008        ands	r0, r1
@   0x08024574: 2800        cmp	r0, #0
@   0x08024576: d071        beq.n	0x2465c
@   0x08024578: 1c18        adds	r0, r3, #0
@   0x0802457a: 4308        orrs	r0, r1
@   0x0802457c: 4b01        ldr	r3, [pc, #4]	@ (0x24584)
@   0x0802457e: 1c19        adds	r1, r3, #0
@   0x08024580: 4008        ands	r0, r1
@   0x08024582: e06a        b.n	0x2465a
@   0x08024584: 7fff        ldrb	r7, [r7, #31]
@   0x08024586: 0000        movs	r0, r0
@   0x08024588: 2002        movs	r0, #2
@   0x0802458a: 8e95        ldrh	r5, [r2, #52]	@ 0x34
@   0x0802458c: 4028        ands	r0, r5
@   0x0802458e: 2800        cmp	r0, #0
@   0x08024590: d164        bne.n	0x2465c
@   0x08024592: 7ed1        ldrb	r1, [r2, #27]
@   0x08024594: 7f10        ldrb	r0, [r2, #28]
@   0x08024596: 3802        subs	r0, #2
@   0x08024598: 4281        cmp	r1, r0
@   0x0802459a: d14d        bne.n	0x24638
@   0x0802459c: 2e01        cmp	r6, #1
@   0x0802459e: d817        bhi.n	0x245d0
@   0x080245a0: 1c34        adds	r4, r6, #0
@   0x080245a2: 344f        adds	r4, #79	@ 0x4f
@   0x080245a4: 4908        ldr	r1, [pc, #32]	@ (0x245c8)
@   0x080245a6: 00b0        lsls	r0, r6, #2
@   0x080245a8: 1840        adds	r0, r0, r1
@   0x080245aa: 6801        ldr	r1, [r0, #0]
@   0x080245ac: 4807        ldr	r0, [pc, #28]	@ (0x245cc)
@   0x080245ae: 9000        str	r0, [sp, #0]
@   0x080245b0: 2009        movs	r0, #9
@   0x080245b2: 9001        str	r0, [sp, #4]
@   0x080245b4: 2003        movs	r0, #3
@   0x080245b6: 9002        str	r0, [sp, #8]
@   0x080245b8: 9003        str	r0, [sp, #12]
@   0x080245ba: 1c20        adds	r0, r4, #0
@   0x080245bc: 2210        movs	r2, #16
@   0x080245be: 2318        movs	r3, #24
@   0x080245c0: f7fc        fd6e 	bl	0x210a0
@   0x080245c4: e016        b.n	0x245f4
@   0x080245c6: 0000        movs	r0, r0
@   0x080245c8: 3348        adds	r3, #72	@ 0x48
@   0x080245ca: 0831        lsrs	r1, r6, #32
@   0x080245cc: 01a1        lsls	r1, r4, #6
@   0x080245ce: 0000        movs	r0, r0
@   0x080245d0: 1c34        adds	r4, r6, #0
@   0x080245d2: 344f        adds	r4, #79	@ 0x4f
@   0x080245d4: 494f        ldr	r1, [pc, #316]	@ (0x24714)
@   0x080245d6: 00b0        lsls	r0, r6, #2
@   0x080245d8: 1840        adds	r0, r0, r1
@   0x080245da: 6801        ldr	r1, [r0, #0]
@   0x080245dc: 484e        ldr	r0, [pc, #312]	@ (0x24718)
@   0x080245de: 9000        str	r0, [sp, #0]
@   0x080245e0: 2009        movs	r0, #9
@   0x080245e2: 9001        str	r0, [sp, #4]
@   0x080245e4: 2003        movs	r0, #3
@   0x080245e6: 9002        str	r0, [sp, #8]
@   0x080245e8: 9003        str	r0, [sp, #12]
@   0x080245ea: 1c20        adds	r0, r4, #0
@   0x080245ec: 2210        movs	r2, #16
@   0x080245ee: 2318        movs	r3, #24
@   0x080245f0: f7fc        fd56 	bl	0x210a0
@   0x080245f4: 1c25        adds	r5, r4, #0
@   0x080245f6: 2e01        cmp	r6, #1
@   0x080245f8: d10b        bne.n	0x24612
@   0x080245fa: 4848        ldr	r0, [pc, #288]	@ (0x2471c)
@   0x080245fc: 9000        str	r0, [sp, #0]
@   0x080245fe: 2008        movs	r0, #8
@   0x08024600: 9001        str	r0, [sp, #4]
@   0x08024602: 2000        movs	r0, #0
@   0x08024604: 9002        str	r0, [sp, #8]
@   0x08024606: 204d        movs	r0, #77	@ 0x4d
@   0x08024608: 4945        ldr	r1, [pc, #276]	@ (0x24720)
@   0x0802460a: 2210        movs	r2, #16
@   0x0802460c: 2317        movs	r3, #23
@   0x0802460e: f7fc        fd97 	bl	0x21140
@   0x08024612: 4844        ldr	r0, [pc, #272]	@ (0x24724)
@   0x08024614: 1c29        adds	r1, r5, #0
@   0x08024616: f7e2        f9a9 	bl	0x696c
@   0x0802461a: 1e70        subs	r0, r6, #1
@   0x0802461c: 0600        lsls	r0, r0, #24
@   0x0802461e: 0e00        lsrs	r0, r0, #24
@   0x08024620: 2801        cmp	r0, #1
@   0x08024622: d809        bhi.n	0x24638
@   0x08024624: 00f0        lsls	r0, r6, #3
@   0x08024626: 1b80        subs	r0, r0, r6
@   0x08024628: 00c0        lsls	r0, r0, #3
@   0x0802462a: 493f        ldr	r1, [pc, #252]	@ (0x24728)
@   0x0802462c: 1840        adds	r0, r0, r1
@   0x0802462e: 2113        movs	r1, #19
@   0x08024630: 2205        movs	r2, #5
@   0x08024632: 2304        movs	r3, #4
@   0x08024634: f7fc        fb52 	bl	0x20cdc
@   0x08024638: 493c        ldr	r1, [pc, #240]	@ (0x2472c)
@   0x0802463a: 00f8        lsls	r0, r7, #3
@   0x0802463c: 1bc0        subs	r0, r0, r7
@   0x0802463e: 00c0        lsls	r0, r0, #3
@   0x08024640: 1842        adds	r2, r0, r1
@   0x08024642: 8e93        ldrh	r3, [r2, #52]	@ 0x34
@   0x08024644: 2480        movs	r4, #128	@ 0x80
@   0x08024646: 0224        lsls	r4, r4, #8
@   0x08024648: 1c20        adds	r0, r4, #0
@   0x0802464a: 4018        ands	r0, r3
@   0x0802464c: 1c0c        adds	r4, r1, #0
@   0x0802464e: 2800        cmp	r0, #0
@   0x08024650: d004        beq.n	0x2465c
@   0x08024652: 2000        movs	r0, #0
@   0x08024654: 7690        strb	r0, [r2, #26]
@   0x08024656: 2002        movs	r0, #2
@   0x08024658: 4318        orrs	r0, r3
@   0x0802465a: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x0802465c: 1c70        adds	r0, r6, #1
@   0x0802465e: 0600        lsls	r0, r0, #24
@   0x08024660: 0e06        lsrs	r6, r0, #24
@   0x08024662: 2e03        cmp	r6, #3
@   0x08024664: d800        bhi.n	0x24668
@   0x08024666: e76c        b.n	0x24542
@   0x08024668: 204b        movs	r0, #75	@ 0x4b
@   0x0802466a: 214e        movs	r1, #78	@ 0x4e
@   0x0802466c: f7e1        fb50 	bl	0x5d10
@   0x08024670: 2600        movs	r6, #0
@   0x08024672: 4f2e        ldr	r7, [pc, #184]	@ (0x2472c)
@   0x08024674: 2508        movs	r5, #8
@   0x08024676: 46a9        mov	r9, r5
@   0x08024678: 2002        movs	r0, #2
@   0x0802467a: 4680        mov	r8, r0
@   0x0802467c: 1c30        adds	r0, r6, #0
@   0x0802467e: 304f        adds	r0, #79	@ 0x4f
@   0x08024680: 00c1        lsls	r1, r0, #3
@   0x08024682: 1a09        subs	r1, r1, r0
@   0x08024684: 00c9        lsls	r1, r1, #3
@   0x08024686: 19ca        adds	r2, r1, r7
@   0x08024688: 8e93        ldrh	r3, [r2, #52]	@ 0x34
@   0x0802468a: 2108        movs	r1, #8
@   0x0802468c: 4019        ands	r1, r3
@   0x0802468e: 1c05        adds	r5, r0, #0
@   0x08024690: 2900        cmp	r1, #0
@   0x08024692: d16d        bne.n	0x24770
@   0x08024694: 7e90        ldrb	r0, [r2, #26]
@   0x08024696: 2800        cmp	r0, #0
@   0x08024698: d050        beq.n	0x2473c
@   0x0802469a: 2804        cmp	r0, #4
@   0x0802469c: d168        bne.n	0x24770
@   0x0802469e: 2102        movs	r1, #2
@   0x080246a0: 468c        mov	ip, r1
@   0x080246a2: 4640        mov	r0, r8
@   0x080246a4: 4018        ands	r0, r3
@   0x080246a6: 0400        lsls	r0, r0, #16
@   0x080246a8: 0c01        lsrs	r1, r0, #16
@   0x080246aa: 2900        cmp	r1, #0
@   0x080246ac: d160        bne.n	0x24770
@   0x080246ae: 2402        movs	r4, #2
@   0x080246b0: 5f10        ldrsh	r0, [r2, r4]
@   0x080246b2: 288f        cmp	r0, #143	@ 0x8f
@   0x080246b4: dd1b        ble.n	0x246ee
@   0x080246b6: 7691        strb	r1, [r2, #26]
@   0x080246b8: 4660        mov	r0, ip
@   0x080246ba: 4318        orrs	r0, r3
@   0x080246bc: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x080246be: 00f0        lsls	r0, r6, #3
@   0x080246c0: 1b80        subs	r0, r0, r6
@   0x080246c2: 00c4        lsls	r4, r0, #3
@   0x080246c4: 491a        ldr	r1, [pc, #104]	@ (0x24730)
@   0x080246c6: 1878        adds	r0, r7, r1
@   0x080246c8: 1820        adds	r0, r4, r0
@   0x080246ca: 2100        movs	r1, #0
@   0x080246cc: 2200        movs	r2, #0
@   0x080246ce: 2300        movs	r3, #0
@   0x080246d0: f7e5        ff56 	bl	0xa580
@   0x080246d4: 1e70        subs	r0, r6, #1
@   0x080246d6: 0600        lsls	r0, r0, #24
@   0x080246d8: 0e00        lsrs	r0, r0, #24
@   0x080246da: 2801        cmp	r0, #1
@   0x080246dc: d807        bhi.n	0x246ee
@   0x080246de: 4a15        ldr	r2, [pc, #84]	@ (0x24734)
@   0x080246e0: 18b8        adds	r0, r7, r2
@   0x080246e2: 1820        adds	r0, r4, r0
@   0x080246e4: 215e        movs	r1, #94	@ 0x5e
@   0x080246e6: 2205        movs	r2, #5
@   0x080246e8: 2304        movs	r3, #4
@   0x080246ea: f7fc        faf7 	bl	0x20cdc
@   0x080246ee: 00e8        lsls	r0, r5, #3
@   0x080246f0: 1b40        subs	r0, r0, r5
@   0x080246f2: 00c0        lsls	r0, r0, #3
@   0x080246f4: 19c4        adds	r4, r0, r7
@   0x080246f6: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x080246f8: 2380        movs	r3, #128	@ 0x80
@   0x080246fa: 021b        lsls	r3, r3, #8
@   0x080246fc: 1c18        adds	r0, r3, #0
@   0x080246fe: 4008        ands	r0, r1
@   0x08024700: 2800        cmp	r0, #0
@   0x08024702: d035        beq.n	0x24770
@   0x08024704: 4640        mov	r0, r8
@   0x08024706: 4308        orrs	r0, r1
@   0x08024708: 4d0b        ldr	r5, [pc, #44]	@ (0x24738)
@   0x0802470a: 1c29        adds	r1, r5, #0
@   0x0802470c: 4008        ands	r0, r1
@   0x0802470e: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x08024710: e02e        b.n	0x24770
@   0x08024712: 0000        movs	r0, r0
@   0x08024714: 3348        adds	r3, #72	@ 0x48
@   0x08024716: 0831        lsrs	r1, r6, #32
@   0x08024718: 0181        lsls	r1, r0, #6
@   0x0802471a: 0000        movs	r0, r0
@   0x0802471c: 0141        lsls	r1, r0, #5
@   0x0802471e: 0000        movs	r0, r0
@   0x08024720: 3294        adds	r2, #148	@ 0x94
@   0x08024722: 0831        lsrs	r1, r6, #32
@   0x08024724: 6110        str	r0, [r2, #16]
@   0x08024726: 0300        lsls	r0, r0, #12
@   0x08024728: 4788        blx	r1
@   0x0802472a: 0300        lsls	r0, r0, #12
@   0x0802472c: 3720        adds	r7, #32
@   0x0802472e: 0300        lsls	r0, r0, #12
@   0x08024730: 1148        asrs	r0, r1, #5
@   0x08024732: 0000        movs	r0, r0
@   0x08024734: 1068        asrs	r0, r5, #1
@   0x08024736: 0000        movs	r0, r0
@   0x08024738: 7fff        ldrb	r7, [r7, #31]
@   0x0802473a: 0000        movs	r0, r0
@   0x0802473c: 2402        movs	r4, #2
@   0x0802473e: 4640        mov	r0, r8
@   0x08024740: 4018        ands	r0, r3
@   0x08024742: 2800        cmp	r0, #0
@   0x08024744: d114        bne.n	0x24770
@   0x08024746: 2180        movs	r1, #128	@ 0x80
@   0x08024748: 0209        lsls	r1, r1, #8
@   0x0802474a: 1c08        adds	r0, r1, #0
@   0x0802474c: 4018        ands	r0, r3
@   0x0802474e: 2800        cmp	r0, #0
@   0x08024750: d00e        beq.n	0x24770
@   0x08024752: 1c31        adds	r1, r6, #0
@   0x08024754: 314b        adds	r1, #75	@ 0x4b
@   0x08024756: 00c8        lsls	r0, r1, #3
@   0x08024758: 1a40        subs	r0, r0, r1
@   0x0802475a: 00c0        lsls	r0, r0, #3
@   0x0802475c: 19c0        adds	r0, r0, r7
@   0x0802475e: 8e81        ldrh	r1, [r0, #52]	@ 0x34
@   0x08024760: 4321        orrs	r1, r4
@   0x08024762: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x08024764: 2101        movs	r1, #1
@   0x08024766: 7681        strb	r1, [r0, #26]
@   0x08024768: 4648        mov	r0, r9
@   0x0802476a: 8e93        ldrh	r3, [r2, #52]	@ 0x34
@   0x0802476c: 4318        orrs	r0, r3
@   0x0802476e: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x08024770: 1c70        adds	r0, r6, #1
@   0x08024772: 0600        lsls	r0, r0, #24
@   0x08024774: 0e06        lsrs	r6, r0, #24
@   0x08024776: 2e03        cmp	r6, #3
@   0x08024778: d800        bhi.n	0x2477c
@   0x0802477a: e77f        b.n	0x2467c
@   0x0802477c: 204f        movs	r0, #79	@ 0x4f
@   0x0802477e: 2150        movs	r1, #80	@ 0x50
@   0x08024780: f7fc        fc30 	bl	0x20fe4
@   0x08024784: 204f        movs	r0, #79	@ 0x4f
@   0x08024786: 2150        movs	r1, #80	@ 0x50
@   0x08024788: f7e1        fac2 	bl	0x5d10
@   0x0802478c: 2051        movs	r0, #81	@ 0x51
@   0x0802478e: 2152        movs	r1, #82	@ 0x52
@   0x08024790: f7fc        fc28 	bl	0x20fe4
@   0x08024794: 2051        movs	r0, #81	@ 0x51
@   0x08024796: 2152        movs	r1, #82	@ 0x52
@   0x08024798: f7e1        faba 	bl	0x5d10
@   0x0802479c: b004        add	sp, #16
@   0x0802479e: bc18        pop	{r3, r4}
@   0x080247a0: 4698        mov	r8, r3
@   0x080247a2: 46a1        mov	r9, r4
@   0x080247a4: bcf0        pop	{r4, r5, r6, r7}
@   0x080247a6: bc01        pop	{r0}
@   0x080247a8: 4700        bx	r0

        thumb_func_start sub_08024534
sub_08024534: @ 0x08024534
        .incbin "baserom.gba", 0x24534, 0x278
        thumb_func_end sub_08024534
