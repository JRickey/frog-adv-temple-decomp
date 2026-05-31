@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801025c, 0x080105b0)  (852 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801025c --end 0x80105b0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801025c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801025e: 4657        mov	r7, sl
@   0x08010260: 464e        mov	r6, r9
@   0x08010262: 4645        mov	r5, r8
@   0x08010264: b4e0        push	{r5, r6, r7}
@   0x08010266: b090        sub	sp, #64	@ 0x40
@   0x08010268: 9c18        ldr	r4, [sp, #96]	@ 0x60
@   0x0801026a: 9d1a        ldr	r5, [sp, #104]	@ 0x68
@   0x0801026c: 0600        lsls	r0, r0, #24
@   0x0801026e: 0e00        lsrs	r0, r0, #24
@   0x08010270: 4682        mov	sl, r0
@   0x08010272: 0609        lsls	r1, r1, #24
@   0x08010274: 0e0f        lsrs	r7, r1, #24
@   0x08010276: 0412        lsls	r2, r2, #16
@   0x08010278: 0c12        lsrs	r2, r2, #16
@   0x0801027a: 9200        str	r2, [sp, #0]
@   0x0801027c: 041b        lsls	r3, r3, #16
@   0x0801027e: 0c1b        lsrs	r3, r3, #16
@   0x08010280: 9301        str	r3, [sp, #4]
@   0x08010282: 0624        lsls	r4, r4, #24
@   0x08010284: 0e24        lsrs	r4, r4, #24
@   0x08010286: 2000        movs	r0, #0
@   0x08010288: 4684        mov	ip, r0
@   0x0801028a: 2100        movs	r1, #0
@   0x0801028c: 9103        str	r1, [sp, #12]
@   0x0801028e: 4991        ldr	r1, [pc, #580]	@ (0x104d4)
@   0x08010290: 0163        lsls	r3, r4, #5
@   0x08010292: 1c08        adds	r0, r1, #0
@   0x08010294: 3008        adds	r0, #8
@   0x08010296: 1818        adds	r0, r3, r0
@   0x08010298: 6802        ldr	r2, [r0, #0]
@   0x0801029a: 2a30        cmp	r2, #48	@ 0x30
@   0x0801029c: dd0e        ble.n	0x102bc
@   0x0801029e: 1c0e        adds	r6, r1, #0
@   0x080102a0: 8b36        ldrh	r6, [r6, #24]
@   0x080102a2: 00f0        lsls	r0, r6, #3
@   0x080102a4: 38d0        subs	r0, #208	@ 0xd0
@   0x080102a6: 930a        str	r3, [sp, #40]	@ 0x28
@   0x080102a8: 4282        cmp	r2, r0
@   0x080102aa: dc13        bgt.n	0x102d4
@   0x080102ac: 1c10        adds	r0, r2, #0
@   0x080102ae: 3830        subs	r0, #48	@ 0x30
@   0x080102b0: 2800        cmp	r0, #0
@   0x080102b2: da00        bge.n	0x102b6
@   0x080102b4: 3007        adds	r0, #7
@   0x080102b6: 0340        lsls	r0, r0, #13
@   0x080102b8: 0c00        lsrs	r0, r0, #16
@   0x080102ba: 9003        str	r0, [sp, #12]
@   0x080102bc: 0162        lsls	r2, r4, #5
@   0x080102be: 4885        ldr	r0, [pc, #532]	@ (0x104d4)
@   0x080102c0: 3008        adds	r0, #8
@   0x080102c2: 1810        adds	r0, r2, r0
@   0x080102c4: 4b83        ldr	r3, [pc, #524]	@ (0x104d4)
@   0x080102c6: 8b1b        ldrh	r3, [r3, #24]
@   0x080102c8: 00d9        lsls	r1, r3, #3
@   0x080102ca: 39d0        subs	r1, #208	@ 0xd0
@   0x080102cc: 6800        ldr	r0, [r0, #0]
@   0x080102ce: 920a        str	r2, [sp, #40]	@ 0x28
@   0x080102d0: 4288        cmp	r0, r1
@   0x080102d2: db05        blt.n	0x102e0
@   0x080102d4: 4c7f        ldr	r4, [pc, #508]	@ (0x104d4)
@   0x080102d6: 8b20        ldrh	r0, [r4, #24]
@   0x080102d8: 3820        subs	r0, #32
@   0x080102da: 0400        lsls	r0, r0, #16
@   0x080102dc: 0c00        lsrs	r0, r0, #16
@   0x080102de: 9003        str	r0, [sp, #12]
@   0x080102e0: 487c        ldr	r0, [pc, #496]	@ (0x104d4)
@   0x080102e2: 3004        adds	r0, #4
@   0x080102e4: 9e0a        ldr	r6, [sp, #40]	@ 0x28
@   0x080102e6: 1830        adds	r0, r6, r0
@   0x080102e8: 6801        ldr	r1, [r0, #0]
@   0x080102ea: 2908        cmp	r1, #8
@   0x080102ec: dd0d        ble.n	0x1030a
@   0x080102ee: 4a79        ldr	r2, [pc, #484]	@ (0x104d4)
@   0x080102f0: 8b52        ldrh	r2, [r2, #26]
@   0x080102f2: 00d0        lsls	r0, r2, #3
@   0x080102f4: 38f8        subs	r0, #248	@ 0xf8
@   0x080102f6: 4281        cmp	r1, r0
@   0x080102f8: da12        bge.n	0x10320
@   0x080102fa: 1c08        adds	r0, r1, #0
@   0x080102fc: 3808        subs	r0, #8
@   0x080102fe: 2800        cmp	r0, #0
@   0x08010300: da00        bge.n	0x10304
@   0x08010302: 1e48        subs	r0, r1, #1
@   0x08010304: 0340        lsls	r0, r0, #13
@   0x08010306: 0c00        lsrs	r0, r0, #16
@   0x08010308: 4684        mov	ip, r0
@   0x0801030a: 4872        ldr	r0, [pc, #456]	@ (0x104d4)
@   0x0801030c: 3004        adds	r0, #4
@   0x0801030e: 9b0a        ldr	r3, [sp, #40]	@ 0x28
@   0x08010310: 1818        adds	r0, r3, r0
@   0x08010312: 4c70        ldr	r4, [pc, #448]	@ (0x104d4)
@   0x08010314: 8b64        ldrh	r4, [r4, #26]
@   0x08010316: 00e1        lsls	r1, r4, #3
@   0x08010318: 39f8        subs	r1, #248	@ 0xf8
@   0x0801031a: 6800        ldr	r0, [r0, #0]
@   0x0801031c: 4288        cmp	r0, r1
@   0x0801031e: db05        blt.n	0x1032c
@   0x08010320: 4e6c        ldr	r6, [pc, #432]	@ (0x104d4)
@   0x08010322: 8b70        ldrh	r0, [r6, #26]
@   0x08010324: 3820        subs	r0, #32
@   0x08010326: 0400        lsls	r0, r0, #16
@   0x08010328: 0c00        lsrs	r0, r0, #16
@   0x0801032a: 4684        mov	ip, r0
@   0x0801032c: 9801        ldr	r0, [sp, #4]
@   0x0801032e: 4450        add	r0, sl
@   0x08010330: 900c        str	r0, [sp, #48]	@ 0x30
@   0x08010332: 9903        ldr	r1, [sp, #12]
@   0x08010334: 0408        lsls	r0, r1, #16
@   0x08010336: 1402        asrs	r2, r0, #16
@   0x08010338: 9b0c        ldr	r3, [sp, #48]	@ 0x30
@   0x0801033a: 4293        cmp	r3, r2
@   0x0801033c: dc00        bgt.n	0x10340
@   0x0801033e: e12c        b.n	0x1059a
@   0x08010340: 1c13        adds	r3, r2, #0
@   0x08010342: 3320        adds	r3, #32
@   0x08010344: 9c01        ldr	r4, [sp, #4]
@   0x08010346: 429c        cmp	r4, r3
@   0x08010348: db00        blt.n	0x1034c
@   0x0801034a: e126        b.n	0x1059a
@   0x0801034c: 9e00        ldr	r6, [sp, #0]
@   0x0801034e: 19f6        adds	r6, r6, r7
@   0x08010350: 9607        str	r6, [sp, #28]
@   0x08010352: 4661        mov	r1, ip
@   0x08010354: 0408        lsls	r0, r1, #16
@   0x08010356: 1404        asrs	r4, r0, #16
@   0x08010358: 42a6        cmp	r6, r4
@   0x0801035a: dc00        bgt.n	0x1035e
@   0x0801035c: e11d        b.n	0x1059a
@   0x0801035e: 1c26        adds	r6, r4, #0
@   0x08010360: 3620        adds	r6, #32
@   0x08010362: 9608        str	r6, [sp, #32]
@   0x08010364: 9800        ldr	r0, [sp, #0]
@   0x08010366: 42b0        cmp	r0, r6
@   0x08010368: db00        blt.n	0x1036c
@   0x0801036a: e116        b.n	0x1059a
@   0x0801036c: 0638        lsls	r0, r7, #24
@   0x0801036e: 0e01        lsrs	r1, r0, #24
@   0x08010370: 46d1        mov	r9, sl
@   0x08010372: 2600        movs	r6, #0
@   0x08010374: 46b0        mov	r8, r6
@   0x08010376: 9801        ldr	r0, [sp, #4]
@   0x08010378: 4290        cmp	r0, r2
@   0x0801037a: da06        bge.n	0x1038a
@   0x0801037c: 9a03        ldr	r2, [sp, #12]
@   0x0801037e: 1a80        subs	r0, r0, r2
@   0x08010380: 0600        lsls	r0, r0, #24
@   0x08010382: 0e00        lsrs	r0, r0, #24
@   0x08010384: 4681        mov	r9, r0
@   0x08010386: 2602        movs	r6, #2
@   0x08010388: 46b0        mov	r8, r6
@   0x0801038a: 980c        ldr	r0, [sp, #48]	@ 0x30
@   0x0801038c: 4298        cmp	r0, r3
@   0x0801038e: dd0a        ble.n	0x103a6
@   0x08010390: 9801        ldr	r0, [sp, #4]
@   0x08010392: 3820        subs	r0, #32
@   0x08010394: 9a03        ldr	r2, [sp, #12]
@   0x08010396: 1a10        subs	r0, r2, r0
@   0x08010398: 0600        lsls	r0, r0, #24
@   0x0801039a: 0e00        lsrs	r0, r0, #24
@   0x0801039c: 4681        mov	r9, r0
@   0x0801039e: 2004        movs	r0, #4
@   0x080103a0: 4643        mov	r3, r8
@   0x080103a2: 4303        orrs	r3, r0
@   0x080103a4: 4698        mov	r8, r3
@   0x080103a6: 9e00        ldr	r6, [sp, #0]
@   0x080103a8: 42a6        cmp	r6, r4
@   0x080103aa: da09        bge.n	0x103c0
@   0x080103ac: 4661        mov	r1, ip
@   0x080103ae: 1a70        subs	r0, r6, r1
@   0x080103b0: 0600        lsls	r0, r0, #24
@   0x080103b2: 0e01        lsrs	r1, r0, #24
@   0x080103b4: 2008        movs	r0, #8
@   0x080103b6: 4642        mov	r2, r8
@   0x080103b8: 4302        orrs	r2, r0
@   0x080103ba: 0610        lsls	r0, r2, #24
@   0x080103bc: 0e00        lsrs	r0, r0, #24
@   0x080103be: 4680        mov	r8, r0
@   0x080103c0: 9b07        ldr	r3, [sp, #28]
@   0x080103c2: 9c08        ldr	r4, [sp, #32]
@   0x080103c4: 42a3        cmp	r3, r4
@   0x080103c6: dd0b        ble.n	0x103e0
@   0x080103c8: 9800        ldr	r0, [sp, #0]
@   0x080103ca: 3820        subs	r0, #32
@   0x080103cc: 4666        mov	r6, ip
@   0x080103ce: 1a30        subs	r0, r6, r0
@   0x080103d0: 0600        lsls	r0, r0, #24
@   0x080103d2: 0e01        lsrs	r1, r0, #24
@   0x080103d4: 2010        movs	r0, #16
@   0x080103d6: 4642        mov	r2, r8
@   0x080103d8: 4302        orrs	r2, r0
@   0x080103da: 0610        lsls	r0, r2, #24
@   0x080103dc: 0e00        lsrs	r0, r0, #24
@   0x080103de: 4680        mov	r8, r0
@   0x080103e0: 9106        str	r1, [sp, #24]
@   0x080103e2: 1c2e        adds	r6, r5, #0
@   0x080103e4: 9705        str	r7, [sp, #20]
@   0x080103e6: 4a3b        ldr	r2, [pc, #236]	@ (0x104d4)
@   0x080103e8: 9b0a        ldr	r3, [sp, #40]	@ 0x28
@   0x080103ea: 930d        str	r3, [sp, #52]	@ 0x34
@   0x080103ec: 1c1c        adds	r4, r3, #0
@   0x080103ee: 18a4        adds	r4, r4, r2
@   0x080103f0: 20ff        movs	r0, #255	@ 0xff
@   0x080103f2: 1c01        adds	r1, r0, #0
@   0x080103f4: 8aa3        ldrh	r3, [r4, #20]
@   0x080103f6: 4019        ands	r1, r3
@   0x080103f8: 08c9        lsrs	r1, r1, #3
@   0x080103fa: 8ae4        ldrh	r4, [r4, #22]
@   0x080103fc: 4020        ands	r0, r4
@   0x080103fe: 0409        lsls	r1, r1, #16
@   0x08010400: 0c0b        lsrs	r3, r1, #16
@   0x08010402: 9304        str	r3, [sp, #16]
@   0x08010404: 08c0        lsrs	r0, r0, #3
@   0x08010406: 0180        lsls	r0, r0, #6
@   0x08010408: 182d        adds	r5, r5, r0
@   0x0801040a: 0bc9        lsrs	r1, r1, #15
@   0x0801040c: 186d        adds	r5, r5, r1
@   0x0801040e: 3204        adds	r2, #4
@   0x08010410: 9c0d        ldr	r4, [sp, #52]	@ 0x34
@   0x08010412: 18a3        adds	r3, r4, r2
@   0x08010414: 6818        ldr	r0, [r3, #0]
@   0x08010416: 2800        cmp	r0, #0
@   0x08010418: da00        bge.n	0x1041c
@   0x0801041a: 3007        adds	r0, #7
@   0x0801041c: 10c0        asrs	r0, r0, #3
@   0x0801041e: 9900        ldr	r1, [sp, #0]
@   0x08010420: 1a08        subs	r0, r1, r0
@   0x08010422: 0400        lsls	r0, r0, #16
@   0x08010424: 1402        asrs	r2, r0, #16
@   0x08010426: 1c10        adds	r0, r2, #0
@   0x08010428: 2a00        cmp	r2, #0
@   0x0801042a: da00        bge.n	0x1042e
@   0x0801042c: 301f        adds	r0, #31
@   0x0801042e: 1140        asrs	r0, r0, #5
@   0x08010430: 0140        lsls	r0, r0, #5
@   0x08010432: 1a10        subs	r0, r2, r0
@   0x08010434: 0400        lsls	r0, r0, #16
@   0x08010436: 0c00        lsrs	r0, r0, #16
@   0x08010438: 4684        mov	ip, r0
@   0x0801043a: 4826        ldr	r0, [pc, #152]	@ (0x104d4)
@   0x0801043c: 3008        adds	r0, #8
@   0x0801043e: 9a0a        ldr	r2, [sp, #40]	@ 0x28
@   0x08010440: 1810        adds	r0, r2, r0
@   0x08010442: 6800        ldr	r0, [r0, #0]
@   0x08010444: 2800        cmp	r0, #0
@   0x08010446: da00        bge.n	0x1044a
@   0x08010448: 3007        adds	r0, #7
@   0x0801044a: 10c0        asrs	r0, r0, #3
@   0x0801044c: 9b01        ldr	r3, [sp, #4]
@   0x0801044e: 1a18        subs	r0, r3, r0
@   0x08010450: 0400        lsls	r0, r0, #16
@   0x08010452: 1280        asrs	r0, r0, #10
@   0x08010454: 182d        adds	r5, r5, r0
@   0x08010456: 4664        mov	r4, ip
@   0x08010458: 0421        lsls	r1, r4, #16
@   0x0801045a: 13c8        asrs	r0, r1, #15
@   0x0801045c: 182d        adds	r5, r5, r0
@   0x0801045e: 0c09        lsrs	r1, r1, #16
@   0x08010460: 9102        str	r1, [sp, #8]
@   0x08010462: 4650        mov	r0, sl
@   0x08010464: 2800        cmp	r0, #0
@   0x08010466: d100        bne.n	0x1046a
@   0x08010468: e097        b.n	0x1059a
@   0x0801046a: 2120        movs	r1, #32
@   0x0801046c: 1bc8        subs	r0, r1, r7
@   0x0801046e: 0040        lsls	r0, r0, #1
@   0x08010470: 9009        str	r0, [sp, #36]	@ 0x24
@   0x08010472: 9a02        ldr	r2, [sp, #8]
@   0x08010474: 4694        mov	ip, r2
@   0x08010476: 9906        ldr	r1, [sp, #24]
@   0x08010478: 9f05        ldr	r7, [sp, #20]
@   0x0801047a: 4653        mov	r3, sl
@   0x0801047c: 3b01        subs	r3, #1
@   0x0801047e: 930b        str	r3, [sp, #44]	@ 0x2c
@   0x08010480: 2f00        cmp	r7, #0
@   0x08010482: d062        beq.n	0x1054a
@   0x08010484: 9c04        ldr	r4, [sp, #16]
@   0x08010486: 46a2        mov	sl, r4
@   0x08010488: 464a        mov	r2, r9
@   0x0801048a: 0610        lsls	r0, r2, #24
@   0x0801048c: 1600        asrs	r0, r0, #24
@   0x0801048e: 900d        str	r0, [sp, #52]	@ 0x34
@   0x08010490: 2008        movs	r0, #8
@   0x08010492: 4643        mov	r3, r8
@   0x08010494: 4018        ands	r0, r3
@   0x08010496: 0600        lsls	r0, r0, #24
@   0x08010498: 0e00        lsrs	r0, r0, #24
@   0x0801049a: 900e        str	r0, [sp, #56]	@ 0x38
@   0x0801049c: 4664        mov	r4, ip
@   0x0801049e: 0420        lsls	r0, r4, #16
@   0x080104a0: 1404        asrs	r4, r0, #16
@   0x080104a2: 2220        movs	r2, #32
@   0x080104a4: 4653        mov	r3, sl
@   0x080104a6: 1ad0        subs	r0, r2, r3
@   0x080104a8: 4284        cmp	r4, r0
@   0x080104aa: db05        blt.n	0x104b8
@   0x080104ac: 4a0a        ldr	r2, [pc, #40]	@ (0x104d8)
@   0x080104ae: 1410        asrs	r0, r2, #16
@   0x080104b0: 4284        cmp	r4, r0
@   0x080104b2: d001        beq.n	0x104b8
@   0x080104b4: 3d40        subs	r5, #64	@ 0x40
@   0x080104b6: 4684        mov	ip, r0
@   0x080104b8: 1c28        adds	r0, r5, #0
@   0x080104ba: 2380        movs	r3, #128	@ 0x80
@   0x080104bc: 011b        lsls	r3, r3, #4
@   0x080104be: 18f4        adds	r4, r6, r3
@   0x080104c0: 42a5        cmp	r5, r4
@   0x080104c2: d30d        bcc.n	0x104e0
@   0x080104c4: 4c05        ldr	r4, [pc, #20]	@ (0x104dc)
@   0x080104c6: 1928        adds	r0, r5, r4
@   0x080104c8: 1b80        subs	r0, r0, r6
@   0x080104ca: 1040        asrs	r0, r0, #1
@   0x080104cc: 0040        lsls	r0, r0, #1
@   0x080104ce: 1830        adds	r0, r6, r0
@   0x080104d0: e00c        b.n	0x104ec
@   0x080104d2: 0000        movs	r0, r0
@   0x080104d4: 60a0        str	r0, [r4, #8]
@   0x080104d6: 0300        lsls	r0, r0, #12
@   0x080104d8: 0000        movs	r0, r0
@   0x080104da: 0fff        lsrs	r7, r7, #31
@   0x080104dc: f800        ffff 	strb.w	pc, [r0, #255]!
@   0x080104e0: 42b5        cmp	r5, r6
@   0x080104e2: d203        bcs.n	0x104ec
@   0x080104e4: 1b70        subs	r0, r6, r5
@   0x080104e6: 1040        asrs	r0, r0, #1
@   0x080104e8: 0040        lsls	r0, r0, #1
@   0x080104ea: 1a20        subs	r0, r4, r0
@   0x080104ec: 1c05        adds	r5, r0, #0
@   0x080104ee: 0608        lsls	r0, r1, #24
@   0x080104f0: 1c04        adds	r4, r0, #0
@   0x080104f2: 2c00        cmp	r4, #0
@   0x080104f4: dd05        ble.n	0x10502
@   0x080104f6: 980d        ldr	r0, [sp, #52]	@ 0x34
@   0x080104f8: 2800        cmp	r0, #0
@   0x080104fa: dd02        ble.n	0x10502
@   0x080104fc: 9a19        ldr	r2, [sp, #100]	@ 0x64
@   0x080104fe: 8810        ldrh	r0, [r2, #0]
@   0x08010500: 8028        strh	r0, [r5, #0]
@   0x08010502: 3502        adds	r5, #2
@   0x08010504: 9b19        ldr	r3, [sp, #100]	@ 0x64
@   0x08010506: 3302        adds	r3, #2
@   0x08010508: 9319        str	r3, [sp, #100]	@ 0x64
@   0x0801050a: 4662        mov	r2, ip
@   0x0801050c: 0410        lsls	r0, r2, #16
@   0x0801050e: 1400        asrs	r0, r0, #16
@   0x08010510: 4b26        ldr	r3, [pc, #152]	@ (0x105ac)
@   0x08010512: 4298        cmp	r0, r3
@   0x08010514: d003        beq.n	0x1051e
@   0x08010516: 3001        adds	r0, #1
@   0x08010518: 0400        lsls	r0, r0, #16
@   0x0801051a: 0c00        lsrs	r0, r0, #16
@   0x0801051c: 4684        mov	ip, r0
@   0x0801051e: 980e        ldr	r0, [sp, #56]	@ 0x38
@   0x08010520: 2800        cmp	r0, #0
@   0x08010522: d003        beq.n	0x1052c
@   0x08010524: 2180        movs	r1, #128	@ 0x80
@   0x08010526: 0449        lsls	r1, r1, #17
@   0x08010528: 1860        adds	r0, r4, r1
@   0x0801052a: 0e01        lsrs	r1, r0, #24
@   0x0801052c: 2010        movs	r0, #16
@   0x0801052e: 4642        mov	r2, r8
@   0x08010530: 4010        ands	r0, r2
@   0x08010532: 2800        cmp	r0, #0
@   0x08010534: d004        beq.n	0x10540
@   0x08010536: 0608        lsls	r0, r1, #24
@   0x08010538: 23ff        movs	r3, #255	@ 0xff
@   0x0801053a: 061b        lsls	r3, r3, #24
@   0x0801053c: 18c0        adds	r0, r0, r3
@   0x0801053e: 0e01        lsrs	r1, r0, #24
@   0x08010540: 1e78        subs	r0, r7, #1
@   0x08010542: 0600        lsls	r0, r0, #24
@   0x08010544: 0e07        lsrs	r7, r0, #24
@   0x08010546: 2f00        cmp	r7, #0
@   0x08010548: d1a8        bne.n	0x1049c
@   0x0801054a: 2002        movs	r0, #2
@   0x0801054c: 4644        mov	r4, r8
@   0x0801054e: 4020        ands	r0, r4
@   0x08010550: 2800        cmp	r0, #0
@   0x08010552: d006        beq.n	0x10562
@   0x08010554: 4649        mov	r1, r9
@   0x08010556: 0608        lsls	r0, r1, #24
@   0x08010558: 2280        movs	r2, #128	@ 0x80
@   0x0801055a: 0452        lsls	r2, r2, #17
@   0x0801055c: 1880        adds	r0, r0, r2
@   0x0801055e: 0e00        lsrs	r0, r0, #24
@   0x08010560: 4681        mov	r9, r0
@   0x08010562: 2004        movs	r0, #4
@   0x08010564: 4643        mov	r3, r8
@   0x08010566: 4018        ands	r0, r3
@   0x08010568: 2800        cmp	r0, #0
@   0x0801056a: d006        beq.n	0x1057a
@   0x0801056c: 464c        mov	r4, r9
@   0x0801056e: 0620        lsls	r0, r4, #24
@   0x08010570: 21ff        movs	r1, #255	@ 0xff
@   0x08010572: 0609        lsls	r1, r1, #24
@   0x08010574: 1840        adds	r0, r0, r1
@   0x08010576: 0e00        lsrs	r0, r0, #24
@   0x08010578: 4681        mov	r9, r0
@   0x0801057a: 4662        mov	r2, ip
@   0x0801057c: 0410        lsls	r0, r2, #16
@   0x0801057e: 1400        asrs	r0, r0, #16
@   0x08010580: 4b0a        ldr	r3, [pc, #40]	@ (0x105ac)
@   0x08010582: 4298        cmp	r0, r3
@   0x08010584: d100        bne.n	0x10588
@   0x08010586: 3540        adds	r5, #64	@ 0x40
@   0x08010588: 9c09        ldr	r4, [sp, #36]	@ 0x24
@   0x0801058a: 192d        adds	r5, r5, r4
@   0x0801058c: 990b        ldr	r1, [sp, #44]	@ 0x2c
@   0x0801058e: 0608        lsls	r0, r1, #24
@   0x08010590: 0e00        lsrs	r0, r0, #24
@   0x08010592: 4682        mov	sl, r0
@   0x08010594: 2800        cmp	r0, #0
@   0x08010596: d000        beq.n	0x1059a
@   0x08010598: e76b        b.n	0x10472
@   0x0801059a: b010        add	sp, #64	@ 0x40
@   0x0801059c: bc38        pop	{r3, r4, r5}
@   0x0801059e: 4698        mov	r8, r3
@   0x080105a0: 46a1        mov	r9, r4
@   0x080105a2: 46aa        mov	sl, r5
@   0x080105a4: bcf0        pop	{r4, r5, r6, r7}
@   0x080105a6: bc01        pop	{r0}
@   0x080105a8: 4700        bx	r0
@   0x080105aa: 0000        movs	r0, r0
@   0x080105ac: 0fff        lsrs	r7, r7, #31

        thumb_func_start sub_0801025C
sub_0801025C: @ 0x0801025c
        .incbin "frog_us_baserom.gba", 0x1025c, 0x354
        thumb_func_end sub_0801025C
