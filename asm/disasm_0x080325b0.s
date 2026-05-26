@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080325b0, 0x08032894)  (740 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80325b0 --end 0x8032894 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080325b0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080325b2: 4657        mov	r7, sl
@   0x080325b4: 464e        mov	r6, r9
@   0x080325b6: 4645        mov	r5, r8
@   0x080325b8: b4e0        push	{r5, r6, r7}
@   0x080325ba: b081        sub	sp, #4
@   0x080325bc: 4924        ldr	r1, [pc, #144]	@ (0x32650)
@   0x080325be: 680b        ldr	r3, [r1, #0]
@   0x080325c0: 228c        movs	r2, #140	@ 0x8c
@   0x080325c2: 0052        lsls	r2, r2, #1
@   0x080325c4: 1898        adds	r0, r3, r2
@   0x080325c6: 6806        ldr	r6, [r0, #0]
@   0x080325c8: 4822        ldr	r0, [pc, #136]	@ (0x32654)
@   0x080325ca: 1832        adds	r2, r6, r0
@   0x080325cc: 2002        movs	r0, #2
@   0x080325ce: 7812        ldrb	r2, [r2, #0]
@   0x080325d0: 4010        ands	r0, r2
@   0x080325d2: 2800        cmp	r0, #0
@   0x080325d4: d100        bne.n	0x325d8
@   0x080325d6: e154        b.n	0x32882
@   0x080325d8: 21a6        movs	r1, #166	@ 0xa6
@   0x080325da: 0049        lsls	r1, r1, #1
@   0x080325dc: 1870        adds	r0, r6, r1
@   0x080325de: 8800        ldrh	r0, [r0, #0]
@   0x080325e0: 4682        mov	sl, r0
@   0x080325e2: 2700        movs	r7, #0
@   0x080325e4: 7818        ldrb	r0, [r3, #0]
@   0x080325e6: 3004        adds	r0, #4
@   0x080325e8: 4287        cmp	r7, r0
@   0x080325ea: da1d        bge.n	0x32628
@   0x080325ec: 2288        movs	r2, #136	@ 0x88
@   0x080325ee: 0052        lsls	r2, r2, #1
@   0x080325f0: 1992        adds	r2, r2, r6
@   0x080325f2: 4690        mov	r8, r2
@   0x080325f4: 2500        movs	r5, #0
@   0x080325f6: 4643        mov	r3, r8
@   0x080325f8: 6818        ldr	r0, [r3, #0]
@   0x080325fa: 1944        adds	r4, r0, r5
@   0x080325fc: 7920        ldrb	r0, [r4, #4]
@   0x080325fe: 2800        cmp	r0, #0
@   0x08032600: d00a        beq.n	0x32618
@   0x08032602: 6820        ldr	r0, [r4, #0]
@   0x08032604: 4651        mov	r1, sl
@   0x08032606: 1a40        subs	r0, r0, r1
@   0x08032608: 6020        str	r0, [r4, #0]
@   0x0803260a: 2800        cmp	r0, #0
@   0x0803260c: dc04        bgt.n	0x32618
@   0x0803260e: 1c38        adds	r0, r7, #0
@   0x08032610: f7fd        f9ee 	bl	0x2f9f0
@   0x08032614: 2000        movs	r0, #0
@   0x08032616: 7120        strb	r0, [r4, #4]
@   0x08032618: 350c        adds	r5, #12
@   0x0803261a: 3701        adds	r7, #1
@   0x0803261c: 480c        ldr	r0, [pc, #48]	@ (0x32650)
@   0x0803261e: 6800        ldr	r0, [r0, #0]
@   0x08032620: 7800        ldrb	r0, [r0, #0]
@   0x08032622: 3004        adds	r0, #4
@   0x08032624: 4287        cmp	r7, r0
@   0x08032626: dbe6        blt.n	0x325f6
@   0x08032628: 2700        movs	r7, #0
@   0x0803262a: 2200        movs	r2, #0
@   0x0803262c: 4691        mov	r9, r2
@   0x0803262e: 2382        movs	r3, #130	@ 0x82
@   0x08032630: 00db        lsls	r3, r3, #3
@   0x08032632: 469c        mov	ip, r3
@   0x08032634: 1c34        adds	r4, r6, #0
@   0x08032636: 4690        mov	r8, r2
@   0x08032638: 6821        ldr	r1, [r4, #0]
@   0x0803263a: 2900        cmp	r1, #0
@   0x0803263c: d078        beq.n	0x32730
@   0x0803263e: 6860        ldr	r0, [r4, #4]
@   0x08032640: 4652        mov	r2, sl
@   0x08032642: 1a80        subs	r0, r0, r2
@   0x08032644: 6060        str	r0, [r4, #4]
@   0x08032646: 2800        cmp	r0, #0
@   0x08032648: dc72        bgt.n	0x32730
@   0x0803264a: 6849        ldr	r1, [r1, #4]
@   0x0803264c: e06a        b.n	0x32724
@   0x0803264e: 0000        movs	r0, r0
@   0x08032650: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x08032652: 0300        lsls	r0, r0, #12
@   0x08032654: 0151        lsls	r1, r2, #5
@   0x08032656: 0000        movs	r0, r0
@   0x08032658: 6822        ldr	r2, [r4, #0]
@   0x0803265a: 6851        ldr	r1, [r2, #4]
@   0x0803265c: 2002        movs	r0, #2
@   0x0803265e: 4240        negs	r0, r0
@   0x08032660: 1c15        adds	r5, r2, #0
@   0x08032662: 4281        cmp	r1, r0
@   0x08032664: d11e        bne.n	0x326a4
@   0x08032666: 1c2b        adds	r3, r5, #0
@   0x08032668: 3308        adds	r3, #8
@   0x0803266a: 6023        str	r3, [r4, #0]
@   0x0803266c: 490c        ldr	r1, [pc, #48]	@ (0x326a0)
@   0x0803266e: 6808        ldr	r0, [r1, #0]
@   0x08032670: 228c        movs	r2, #140	@ 0x8c
@   0x08032672: 0052        lsls	r2, r2, #1
@   0x08032674: 1880        adds	r0, r0, r2
@   0x08032676: 6800        ldr	r0, [r0, #0]
@   0x08032678: 218a        movs	r1, #138	@ 0x8a
@   0x0803267a: 0049        lsls	r1, r1, #1
@   0x0803267c: 1840        adds	r0, r0, r1
@   0x0803267e: 6802        ldr	r2, [r0, #0]
@   0x08032680: 4661        mov	r1, ip
@   0x08032682: 1850        adds	r0, r2, r1
@   0x08032684: 6800        ldr	r0, [r0, #0]
@   0x08032686: 4460        add	r0, ip
@   0x08032688: 1810        adds	r0, r2, r0
@   0x0803268a: 00b9        lsls	r1, r7, #2
@   0x0803268c: 1809        adds	r1, r1, r0
@   0x0803268e: 6808        ldr	r0, [r1, #0]
@   0x08032690: 4460        add	r0, ip
@   0x08032692: 1812        adds	r2, r2, r0
@   0x08032694: 68a8        ldr	r0, [r5, #8]
@   0x08032696: 1812        adds	r2, r2, r0
@   0x08032698: 6022        str	r2, [r4, #0]
@   0x0803269a: 6859        ldr	r1, [r3, #4]
@   0x0803269c: e039        b.n	0x32712
@   0x0803269e: 0000        movs	r0, r0
@   0x080326a0: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080326a2: 0300        lsls	r0, r0, #12
@   0x080326a4: 228a        movs	r2, #138	@ 0x8a
@   0x080326a6: 0052        lsls	r2, r2, #1
@   0x080326a8: 18b0        adds	r0, r6, r2
@   0x080326aa: 6802        ldr	r2, [r0, #0]
@   0x080326ac: 4b0b        ldr	r3, [pc, #44]	@ (0x326dc)
@   0x080326ae: 18d0        adds	r0, r2, r3
@   0x080326b0: 6800        ldr	r0, [r0, #0]
@   0x080326b2: 3b04        subs	r3, #4
@   0x080326b4: 18c0        adds	r0, r0, r3
@   0x080326b6: 1810        adds	r0, r2, r0
@   0x080326b8: 0089        lsls	r1, r1, #2
@   0x080326ba: 1809        adds	r1, r1, r0
@   0x080326bc: 6808        ldr	r0, [r1, #0]
@   0x080326be: 18c0        adds	r0, r0, r3
@   0x080326c0: 1811        adds	r1, r2, r0
@   0x080326c2: 8808        ldrh	r0, [r1, #0]
@   0x080326c4: 4a06        ldr	r2, [pc, #24]	@ (0x326e0)
@   0x080326c6: 4290        cmp	r0, r2
@   0x080326c8: d10c        bne.n	0x326e4
@   0x080326ca: 884b        ldrh	r3, [r1, #2]
@   0x080326cc: 4283        cmp	r3, r0
@   0x080326ce: d109        bne.n	0x326e4
@   0x080326d0: 1c30        adds	r0, r6, #0
@   0x080326d2: 3088        adds	r0, #136	@ 0x88
@   0x080326d4: 4440        add	r0, r8
@   0x080326d6: 4649        mov	r1, r9
@   0x080326d8: 6001        str	r1, [r0, #0]
@   0x080326da: e016        b.n	0x3270a
@   0x080326dc: 0414        lsls	r4, r2, #16
@   0x080326de: 0000        movs	r0, r0
@   0x080326e0: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0
@   0x080326e4: 1c30        adds	r0, r6, #0
@   0x080326e6: 3088        adds	r0, #136	@ 0x88
@   0x080326e8: 4440        add	r0, r8
@   0x080326ea: 6001        str	r1, [r0, #0]
@   0x080326ec: 1c30        adds	r0, r6, #0
@   0x080326ee: 308c        adds	r0, #140	@ 0x8c
@   0x080326f0: 4642        mov	r2, r8
@   0x080326f2: 1883        adds	r3, r0, r2
@   0x080326f4: 8809        ldrh	r1, [r1, #0]
@   0x080326f6: 0209        lsls	r1, r1, #8
@   0x080326f8: 6019        str	r1, [r3, #0]
@   0x080326fa: 2f03        cmp	r7, #3
@   0x080326fc: dc05        bgt.n	0x3270a
@   0x080326fe: 22a7        movs	r2, #167	@ 0xa7
@   0x08032700: 0052        lsls	r2, r2, #1
@   0x08032702: 18b0        adds	r0, r6, r2
@   0x08032704: 8800        ldrh	r0, [r0, #0]
@   0x08032706: 1840        adds	r0, r0, r1
@   0x08032708: 6018        str	r0, [r3, #0]
@   0x0803270a: 1c28        adds	r0, r5, #0
@   0x0803270c: 3008        adds	r0, #8
@   0x0803270e: 6020        str	r0, [r4, #0]
@   0x08032710: 68a9        ldr	r1, [r5, #8]
@   0x08032712: 0209        lsls	r1, r1, #8
@   0x08032714: 6860        ldr	r0, [r4, #4]
@   0x08032716: 1840        adds	r0, r0, r1
@   0x08032718: 6060        str	r0, [r4, #4]
@   0x0803271a: 6860        ldr	r0, [r4, #4]
@   0x0803271c: 2800        cmp	r0, #0
@   0x0803271e: dc07        bgt.n	0x32730
@   0x08032720: 6820        ldr	r0, [r4, #0]
@   0x08032722: 6841        ldr	r1, [r0, #4]
@   0x08032724: 2001        movs	r0, #1
@   0x08032726: 4240        negs	r0, r0
@   0x08032728: 4281        cmp	r1, r0
@   0x0803272a: d195        bne.n	0x32658
@   0x0803272c: 464b        mov	r3, r9
@   0x0803272e: 6023        str	r3, [r4, #0]
@   0x08032730: 3408        adds	r4, #8
@   0x08032732: 2008        movs	r0, #8
@   0x08032734: 4480        add	r8, r0
@   0x08032736: 3701        adds	r7, #1
@   0x08032738: 2f10        cmp	r7, #16
@   0x0803273a: dc00        bgt.n	0x3273e
@   0x0803273c: e77c        b.n	0x32638
@   0x0803273e: 2700        movs	r7, #0
@   0x08032740: 00f8        lsls	r0, r7, #3
@   0x08032742: 3088        adds	r0, #136	@ 0x88
@   0x08032744: 1835        adds	r5, r6, r0
@   0x08032746: 6829        ldr	r1, [r5, #0]
@   0x08032748: 1c7a        adds	r2, r7, #1
@   0x0803274a: 4691        mov	r9, r2
@   0x0803274c: 2900        cmp	r1, #0
@   0x0803274e: d068        beq.n	0x32822
@   0x08032750: 6868        ldr	r0, [r5, #4]
@   0x08032752: 4653        mov	r3, sl
@   0x08032754: 1ac0        subs	r0, r0, r3
@   0x08032756: 6068        str	r0, [r5, #4]
@   0x08032758: 1c0c        adds	r4, r1, #0
@   0x0803275a: 2800        cmp	r0, #0
@   0x0803275c: dc61        bgt.n	0x32822
@   0x0803275e: 218c        movs	r1, #140	@ 0x8c
@   0x08032760: 0049        lsls	r1, r1, #1
@   0x08032762: 1870        adds	r0, r6, r1
@   0x08032764: 19c0        adds	r0, r0, r7
@   0x08032766: 4680        mov	r8, r0
@   0x08032768: 2002        movs	r0, #2
@   0x0803276a: 5620        ldrsb	r0, [r4, r0]
@   0x0803276c: 2800        cmp	r0, #0
@   0x0803276e: dd24        ble.n	0x327ba
@   0x08032770: 2080        movs	r0, #128	@ 0x80
@   0x08032772: 78e2        ldrb	r2, [r4, #3]
@   0x08032774: 4010        ands	r0, r2
@   0x08032776: 2800        cmp	r0, #0
@   0x08032778: d10c        bne.n	0x32794
@   0x0803277a: 88a0        ldrh	r0, [r4, #4]
@   0x0803277c: 2800        cmp	r0, #0
@   0x0803277e: d007        beq.n	0x32790
@   0x08032780: 2202        movs	r2, #2
@   0x08032782: 56a2        ldrsb	r2, [r4, r2]
@   0x08032784: 78e3        ldrb	r3, [r4, #3]
@   0x08032786: 9000        str	r0, [sp, #0]
@   0x08032788: 1c30        adds	r0, r6, #0
@   0x0803278a: 1c39        adds	r1, r7, #0
@   0x0803278c: f7ff        fe1e 	bl	0x323cc
@   0x08032790: 2106        movs	r1, #6
@   0x08032792: e02e        b.n	0x327f2
@   0x08032794: 7920        ldrb	r0, [r4, #4]
@   0x08032796: 4643        mov	r3, r8
@   0x08032798: 7018        strb	r0, [r3, #0]
@   0x0803279a: 88a0        ldrh	r0, [r4, #4]
@   0x0803279c: 2800        cmp	r0, #0
@   0x0803279e: d00a        beq.n	0x327b6
@   0x080327a0: 2202        movs	r2, #2
@   0x080327a2: 56a2        ldrsb	r2, [r4, r2]
@   0x080327a4: 237f        movs	r3, #127	@ 0x7f
@   0x080327a6: 78e0        ldrb	r0, [r4, #3]
@   0x080327a8: 4003        ands	r3, r0
@   0x080327aa: 88e0        ldrh	r0, [r4, #6]
@   0x080327ac: 9000        str	r0, [sp, #0]
@   0x080327ae: 1c30        adds	r0, r6, #0
@   0x080327b0: 1c39        adds	r1, r7, #0
@   0x080327b2: f7ff        fe0b 	bl	0x323cc
@   0x080327b6: 2108        movs	r1, #8
@   0x080327b8: e01b        b.n	0x327f2
@   0x080327ba: 2800        cmp	r0, #0
@   0x080327bc: d116        bne.n	0x327ec
@   0x080327be: 78e1        ldrb	r1, [r4, #3]
@   0x080327c0: 2080        movs	r0, #128	@ 0x80
@   0x080327c2: 4008        ands	r0, r1
@   0x080327c4: 2800        cmp	r0, #0
@   0x080327c6: d103        bne.n	0x327d0
@   0x080327c8: 4642        mov	r2, r8
@   0x080327ca: 7011        strb	r1, [r2, #0]
@   0x080327cc: 2104        movs	r1, #4
@   0x080327ce: e010        b.n	0x327f2
@   0x080327d0: 227f        movs	r2, #127	@ 0x7f
@   0x080327d2: 400a        ands	r2, r1
@   0x080327d4: 4804        ldr	r0, [pc, #16]	@ (0x327e8)
@   0x080327d6: 6800        ldr	r0, [r0, #0]
@   0x080327d8: 7801        ldrb	r1, [r0, #0]
@   0x080327da: 428a        cmp	r2, r1
@   0x080327dc: dd00        ble.n	0x327e0
@   0x080327de: 1c0a        adds	r2, r1, #0
@   0x080327e0: 7042        strb	r2, [r0, #1]
@   0x080327e2: 2104        movs	r1, #4
@   0x080327e4: e005        b.n	0x327f2
@   0x080327e6: 0000        movs	r0, r0
@   0x080327e8: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080327ea: 0300        lsls	r0, r0, #12
@   0x080327ec: 2000        movs	r0, #0
@   0x080327ee: 6028        str	r0, [r5, #0]
@   0x080327f0: e017        b.n	0x32822
@   0x080327f2: 6828        ldr	r0, [r5, #0]
@   0x080327f4: 1840        adds	r0, r0, r1
@   0x080327f6: 6028        str	r0, [r5, #0]
@   0x080327f8: 1c04        adds	r4, r0, #0
@   0x080327fa: 8821        ldrh	r1, [r4, #0]
@   0x080327fc: 4804        ldr	r0, [pc, #16]	@ (0x32810)
@   0x080327fe: 4281        cmp	r1, r0
@   0x08032800: d108        bne.n	0x32814
@   0x08032802: 8863        ldrh	r3, [r4, #2]
@   0x08032804: 428b        cmp	r3, r1
@   0x08032806: d105        bne.n	0x32814
@   0x08032808: 2000        movs	r0, #0
@   0x0803280a: 6068        str	r0, [r5, #4]
@   0x0803280c: 6028        str	r0, [r5, #0]
@   0x0803280e: e008        b.n	0x32822
@   0x08032810: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0
@   0x08032814: 8820        ldrh	r0, [r4, #0]
@   0x08032816: 0201        lsls	r1, r0, #8
@   0x08032818: 6868        ldr	r0, [r5, #4]
@   0x0803281a: 1840        adds	r0, r0, r1
@   0x0803281c: 6068        str	r0, [r5, #4]
@   0x0803281e: 2800        cmp	r0, #0
@   0x08032820: dda2        ble.n	0x32768
@   0x08032822: 464f        mov	r7, r9
@   0x08032824: 2f0f        cmp	r7, #15
@   0x08032826: dd8b        ble.n	0x32740
@   0x08032828: 2184        movs	r1, #132	@ 0x84
@   0x0803282a: 0049        lsls	r1, r1, #1
@   0x0803282c: 1875        adds	r5, r6, r1
@   0x0803282e: 6829        ldr	r1, [r5, #0]
@   0x08032830: 2900        cmp	r1, #0
@   0x08032832: d026        beq.n	0x32882
@   0x08032834: 6868        ldr	r0, [r5, #4]
@   0x08032836: 4652        mov	r2, sl
@   0x08032838: 1a80        subs	r0, r0, r2
@   0x0803283a: 6068        str	r0, [r5, #4]
@   0x0803283c: 1c0a        adds	r2, r1, #0
@   0x0803283e: 2800        cmp	r0, #0
@   0x08032840: dc1f        bgt.n	0x32882
@   0x08032842: 2400        movs	r4, #0
@   0x08032844: 4f0a        ldr	r7, [pc, #40]	@ (0x32870)
@   0x08032846: 8850        ldrh	r0, [r2, #2]
@   0x08032848: 23a5        movs	r3, #165	@ 0xa5
@   0x0803284a: 005b        lsls	r3, r3, #1
@   0x0803284c: 18f1        adds	r1, r6, r3
@   0x0803284e: 8008        strh	r0, [r1, #0]
@   0x08032850: f7ff        fab4 	bl	0x31dbc
@   0x08032854: 6829        ldr	r1, [r5, #0]
@   0x08032856: 1d08        adds	r0, r1, #4
@   0x08032858: 6028        str	r0, [r5, #0]
@   0x0803285a: 1c02        adds	r2, r0, #0
@   0x0803285c: 8850        ldrh	r0, [r2, #2]
@   0x0803285e: 42b8        cmp	r0, r7
@   0x08032860: d108        bne.n	0x32874
@   0x08032862: 8889        ldrh	r1, [r1, #4]
@   0x08032864: 4281        cmp	r1, r0
@   0x08032866: d105        bne.n	0x32874
@   0x08032868: 606c        str	r4, [r5, #4]
@   0x0803286a: 602c        str	r4, [r5, #0]
@   0x0803286c: e009        b.n	0x32882
@   0x0803286e: 0000        movs	r0, r0
@   0x08032870: ffff        0000 	vaddl.u<illegal width 64>	q8, d15, d0
@   0x08032874: 8810        ldrh	r0, [r2, #0]
@   0x08032876: 0201        lsls	r1, r0, #8
@   0x08032878: 6868        ldr	r0, [r5, #4]
@   0x0803287a: 1840        adds	r0, r0, r1
@   0x0803287c: 6068        str	r0, [r5, #4]
@   0x0803287e: 2800        cmp	r0, #0
@   0x08032880: dde1        ble.n	0x32846
@   0x08032882: b001        add	sp, #4
@   0x08032884: bc38        pop	{r3, r4, r5}
@   0x08032886: 4698        mov	r8, r3
@   0x08032888: 46a1        mov	r9, r4
@   0x0803288a: 46aa        mov	sl, r5
@   0x0803288c: bcf0        pop	{r4, r5, r6, r7}
@   0x0803288e: bc01        pop	{r0}
@   0x08032890: 4700        bx	r0

        thumb_func_start sub_080325B0
sub_080325B0: @ 0x080325b0
        .incbin "frog_us_baserom.gba", 0x325b0, 0x2e4
        thumb_func_end sub_080325B0
