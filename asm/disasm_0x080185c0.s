@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080185c0, 0x0801932c)  (3436 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80185c0 --end 0x801932c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080185c0: b510        push	{r4, lr}
@   0x080185c2: b084        sub	sp, #16
@   0x080185c4: 9000        str	r0, [sp, #0]
@   0x080185c6: 9101        str	r1, [sp, #4]
@   0x080185c8: 9202        str	r2, [sp, #8]
@   0x080185ca: 9303        str	r3, [sp, #12]
@   0x080185cc: f7e8        f998 	bl	0x900
@   0x080185d0: 4c18        ldr	r4, [pc, #96]	@ (0x18634)
@   0x080185d2: 6861        ldr	r1, [r4, #4]
@   0x080185d4: 1a40        subs	r0, r0, r1
@   0x080185d6: 4669        mov	r1, sp
@   0x080185d8: 7889        ldrb	r1, [r1, #2]
@   0x080185da: 4288        cmp	r0, r1
@   0x080185dc: d31d        bcc.n	0x1861a
@   0x080185de: 4668        mov	r0, sp
@   0x080185e0: 7aa1        ldrb	r1, [r4, #10]
@   0x080185e2: 8800        ldrh	r0, [r0, #0]
@   0x080185e4: 4281        cmp	r1, r0
@   0x080185e6: d301        bcc.n	0x185ec
@   0x080185e8: 2000        movs	r0, #0
@   0x080185ea: 72a0        strb	r0, [r4, #10]
@   0x080185ec: 4a12        ldr	r2, [pc, #72]	@ (0x18638)
@   0x080185ee: 9901        ldr	r1, [sp, #4]
@   0x080185f0: 7aa3        ldrb	r3, [r4, #10]
@   0x080185f2: 0098        lsls	r0, r3, #2
@   0x080185f4: 1840        adds	r0, r0, r1
@   0x080185f6: 6800        ldr	r0, [r0, #0]
@   0x080185f8: 6010        str	r0, [r2, #0]
@   0x080185fa: 9802        ldr	r0, [sp, #8]
@   0x080185fc: 6050        str	r0, [r2, #4]
@   0x080185fe: 4668        mov	r0, sp
@   0x08018600: 8980        ldrh	r0, [r0, #12]
@   0x08018602: 0840        lsrs	r0, r0, #1
@   0x08018604: 2180        movs	r1, #128	@ 0x80
@   0x08018606: 0609        lsls	r1, r1, #24
@   0x08018608: 4308        orrs	r0, r1
@   0x0801860a: 6090        str	r0, [r2, #8]
@   0x0801860c: 6890        ldr	r0, [r2, #8]
@   0x0801860e: 7aa0        ldrb	r0, [r4, #10]
@   0x08018610: 3001        adds	r0, #1
@   0x08018612: 72a0        strb	r0, [r4, #10]
@   0x08018614: f7e8        f974 	bl	0x900
@   0x08018618: 6060        str	r0, [r4, #4]
@   0x0801861a: 4908        ldr	r1, [pc, #32]	@ (0x1863c)
@   0x0801861c: 4a08        ldr	r2, [pc, #32]	@ (0x18640)
@   0x0801861e: 1c10        adds	r0, r2, #0
@   0x08018620: 8008        strh	r0, [r1, #0]
@   0x08018622: 3102        adds	r1, #2
@   0x08018624: 4b07        ldr	r3, [pc, #28]	@ (0x18644)
@   0x08018626: 1c18        adds	r0, r3, #0
@   0x08018628: 8008        strh	r0, [r1, #0]
@   0x0801862a: b004        add	sp, #16
@   0x0801862c: bc10        pop	{r4}
@   0x0801862e: bc01        pop	{r0}
@   0x08018630: 4700        bx	r0
@   0x08018632: 0000        movs	r0, r0
@   0x08018634: 6480        str	r0, [r0, #72]	@ 0x48
@   0x08018636: 0300        lsls	r0, r0, #12
@   0x08018638: 00d4        lsls	r4, r2, #3
@   0x0801863a: 0400        lsls	r0, r0, #16
@   0x0801863c: 0050        lsls	r0, r2, #1
@   0x0801863e: 0400        lsls	r0, r0, #16
@   0x08018640: 1142        asrs	r2, r0, #5
@   0x08018642: 0000        movs	r0, r0
@   0x08018644: 0909        lsrs	r1, r1, #4
@   0x08018646: 0000        movs	r0, r0
@   0x08018648: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801864a: 464f        mov	r7, r9
@   0x0801864c: 4646        mov	r6, r8
@   0x0801864e: b4c0        push	{r6, r7}
@   0x08018650: 4680        mov	r8, r0
@   0x08018652: 0609        lsls	r1, r1, #24
@   0x08018654: 0612        lsls	r2, r2, #24
@   0x08018656: 0e16        lsrs	r6, r2, #24
@   0x08018658: 2700        movs	r7, #0
@   0x0801865a: 2080        movs	r0, #128	@ 0x80
@   0x0801865c: 0440        lsls	r0, r0, #17
@   0x0801865e: 1809        adds	r1, r1, r0
@   0x08018660: 0e09        lsrs	r1, r1, #24
@   0x08018662: 4689        mov	r9, r1
@   0x08018664: 4641        mov	r1, r8
@   0x08018666: 2900        cmp	r1, #0
@   0x08018668: d11f        bne.n	0x186aa
@   0x0801866a: 2001        movs	r0, #1
@   0x0801866c: 4030        ands	r0, r6
@   0x0801866e: 2800        cmp	r0, #0
@   0x08018670: d003        beq.n	0x1867a
@   0x08018672: 491d        ldr	r1, [pc, #116]	@ (0x186e8)
@   0x08018674: 2080        movs	r0, #128	@ 0x80
@   0x08018676: 0040        lsls	r0, r0, #1
@   0x08018678: 8008        strh	r0, [r1, #0]
@   0x0801867a: 2002        movs	r0, #2
@   0x0801867c: 4030        ands	r0, r6
@   0x0801867e: 2800        cmp	r0, #0
@   0x08018680: d003        beq.n	0x1868a
@   0x08018682: 4919        ldr	r1, [pc, #100]	@ (0x186e8)
@   0x08018684: 2080        movs	r0, #128	@ 0x80
@   0x08018686: 0040        lsls	r0, r0, #1
@   0x08018688: 8088        strh	r0, [r1, #4]
@   0x0801868a: 2004        movs	r0, #4
@   0x0801868c: 4030        ands	r0, r6
@   0x0801868e: 2800        cmp	r0, #0
@   0x08018690: d003        beq.n	0x1869a
@   0x08018692: 4915        ldr	r1, [pc, #84]	@ (0x186e8)
@   0x08018694: 2080        movs	r0, #128	@ 0x80
@   0x08018696: 0040        lsls	r0, r0, #1
@   0x08018698: 8108        strh	r0, [r1, #8]
@   0x0801869a: 2008        movs	r0, #8
@   0x0801869c: 4030        ands	r0, r6
@   0x0801869e: 2800        cmp	r0, #0
@   0x080186a0: d003        beq.n	0x186aa
@   0x080186a2: 4911        ldr	r1, [pc, #68]	@ (0x186e8)
@   0x080186a4: 2080        movs	r0, #128	@ 0x80
@   0x080186a6: 0040        lsls	r0, r0, #1
@   0x080186a8: 8188        strh	r0, [r1, #12]
@   0x080186aa: 454f        cmp	r7, r9
@   0x080186ac: d300        bcc.n	0x186b0
@   0x080186ae: e0ca        b.n	0x18846
@   0x080186b0: 4d0d        ldr	r5, [pc, #52]	@ (0x186e8)
@   0x080186b2: 2001        movs	r0, #1
@   0x080186b4: 4030        ands	r0, r6
@   0x080186b6: 1c7b        adds	r3, r7, #1
@   0x080186b8: 469c        mov	ip, r3
@   0x080186ba: 2800        cmp	r0, #0
@   0x080186bc: d029        beq.n	0x18712
@   0x080186be: 4640        mov	r0, r8
@   0x080186c0: 2800        cmp	r0, #0
@   0x080186c2: d015        beq.n	0x186f0
@   0x080186c4: 8828        ldrh	r0, [r5, #0]
@   0x080186c6: 3008        adds	r0, #8
@   0x080186c8: 8028        strh	r0, [r5, #0]
@   0x080186ca: 2100        movs	r1, #0
@   0x080186cc: 007a        lsls	r2, r7, #1
@   0x080186ce: 4c07        ldr	r4, [pc, #28]	@ (0x186ec)
@   0x080186d0: 2300        movs	r3, #0
@   0x080186d2: 0188        lsls	r0, r1, #6
@   0x080186d4: 1810        adds	r0, r2, r0
@   0x080186d6: 1900        adds	r0, r0, r4
@   0x080186d8: 8003        strh	r3, [r0, #0]
@   0x080186da: 1c48        adds	r0, r1, #1
@   0x080186dc: 0600        lsls	r0, r0, #24
@   0x080186de: 0e01        lsrs	r1, r0, #24
@   0x080186e0: 291f        cmp	r1, #31
@   0x080186e2: d9f6        bls.n	0x186d2
@   0x080186e4: e015        b.n	0x18712
@   0x080186e6: 0000        movs	r0, r0
@   0x080186e8: 3550        adds	r5, #80	@ 0x50
@   0x080186ea: 0300        lsls	r0, r0, #12
@   0x080186ec: dffe        svc	254	@ 0xfe
@   0x080186ee: 0600        lsls	r0, r0, #24
@   0x080186f0: 2100        movs	r1, #0
@   0x080186f2: 0078        lsls	r0, r7, #1
@   0x080186f4: 4b13        ldr	r3, [pc, #76]	@ (0x18744)
@   0x080186f6: 18c2        adds	r2, r0, r3
@   0x080186f8: 2300        movs	r3, #0
@   0x080186fa: 0188        lsls	r0, r1, #6
@   0x080186fc: 1a80        subs	r0, r0, r2
@   0x080186fe: 3804        subs	r0, #4
@   0x08018700: 8003        strh	r3, [r0, #0]
@   0x08018702: 1c48        adds	r0, r1, #1
@   0x08018704: 0600        lsls	r0, r0, #24
@   0x08018706: 0e01        lsrs	r1, r0, #24
@   0x08018708: 291f        cmp	r1, #31
@   0x0801870a: d9f6        bls.n	0x186fa
@   0x0801870c: 8828        ldrh	r0, [r5, #0]
@   0x0801870e: 3808        subs	r0, #8
@   0x08018710: 8028        strh	r0, [r5, #0]
@   0x08018712: 2002        movs	r0, #2
@   0x08018714: 4030        ands	r0, r6
@   0x08018716: 2800        cmp	r0, #0
@   0x08018718: d029        beq.n	0x1876e
@   0x0801871a: 4640        mov	r0, r8
@   0x0801871c: 2800        cmp	r0, #0
@   0x0801871e: d015        beq.n	0x1874c
@   0x08018720: 88a8        ldrh	r0, [r5, #4]
@   0x08018722: 3008        adds	r0, #8
@   0x08018724: 80a8        strh	r0, [r5, #4]
@   0x08018726: 2100        movs	r1, #0
@   0x08018728: 007a        lsls	r2, r7, #1
@   0x0801872a: 4c07        ldr	r4, [pc, #28]	@ (0x18748)
@   0x0801872c: 2300        movs	r3, #0
@   0x0801872e: 0188        lsls	r0, r1, #6
@   0x08018730: 1810        adds	r0, r2, r0
@   0x08018732: 1900        adds	r0, r0, r4
@   0x08018734: 8003        strh	r3, [r0, #0]
@   0x08018736: 1c48        adds	r0, r1, #1
@   0x08018738: 0600        lsls	r0, r0, #24
@   0x0801873a: 0e01        lsrs	r1, r0, #24
@   0x0801873c: 291f        cmp	r1, #31
@   0x0801873e: d9f6        bls.n	0x1872e
@   0x08018740: e015        b.n	0x1876e
@   0x08018742: 0000        movs	r0, r0
@   0x08018744: 2000        movs	r0, #0
@   0x08018746: f9ff        e7fe 	ldr??.w	lr, [pc, #2046]	@ 0x18f46
@   0x0801874a: 0600        lsls	r0, r0, #24
@   0x0801874c: 2100        movs	r1, #0
@   0x0801874e: 0078        lsls	r0, r7, #1
@   0x08018750: 4b13        ldr	r3, [pc, #76]	@ (0x187a0)
@   0x08018752: 18c2        adds	r2, r0, r3
@   0x08018754: 2300        movs	r3, #0
@   0x08018756: 0188        lsls	r0, r1, #6
@   0x08018758: 1a80        subs	r0, r0, r2
@   0x0801875a: 3804        subs	r0, #4
@   0x0801875c: 8003        strh	r3, [r0, #0]
@   0x0801875e: 1c48        adds	r0, r1, #1
@   0x08018760: 0600        lsls	r0, r0, #24
@   0x08018762: 0e01        lsrs	r1, r0, #24
@   0x08018764: 291f        cmp	r1, #31
@   0x08018766: d9f6        bls.n	0x18756
@   0x08018768: 88a8        ldrh	r0, [r5, #4]
@   0x0801876a: 3808        subs	r0, #8
@   0x0801876c: 80a8        strh	r0, [r5, #4]
@   0x0801876e: 2004        movs	r0, #4
@   0x08018770: 4030        ands	r0, r6
@   0x08018772: 2800        cmp	r0, #0
@   0x08018774: d029        beq.n	0x187ca
@   0x08018776: 4640        mov	r0, r8
@   0x08018778: 2800        cmp	r0, #0
@   0x0801877a: d015        beq.n	0x187a8
@   0x0801877c: 8928        ldrh	r0, [r5, #8]
@   0x0801877e: 3008        adds	r0, #8
@   0x08018780: 8128        strh	r0, [r5, #8]
@   0x08018782: 2100        movs	r1, #0
@   0x08018784: 007a        lsls	r2, r7, #1
@   0x08018786: 4c07        ldr	r4, [pc, #28]	@ (0x187a4)
@   0x08018788: 2300        movs	r3, #0
@   0x0801878a: 0188        lsls	r0, r1, #6
@   0x0801878c: 1810        adds	r0, r2, r0
@   0x0801878e: 1900        adds	r0, r0, r4
@   0x08018790: 8003        strh	r3, [r0, #0]
@   0x08018792: 1c48        adds	r0, r1, #1
@   0x08018794: 0600        lsls	r0, r0, #24
@   0x08018796: 0e01        lsrs	r1, r0, #24
@   0x08018798: 291f        cmp	r1, #31
@   0x0801879a: d9f6        bls.n	0x1878a
@   0x0801879c: e015        b.n	0x187ca
@   0x0801879e: 0000        movs	r0, r0
@   0x080187a0: 1800        adds	r0, r0, r0
@   0x080187a2: f9ff        effe 	ldr??.w	lr, [pc, #4094]	@ 0x197a2
@   0x080187a6: 0600        lsls	r0, r0, #24
@   0x080187a8: 2100        movs	r1, #0
@   0x080187aa: 0078        lsls	r0, r7, #1
@   0x080187ac: 4b13        ldr	r3, [pc, #76]	@ (0x187fc)
@   0x080187ae: 18c2        adds	r2, r0, r3
@   0x080187b0: 2300        movs	r3, #0
@   0x080187b2: 0188        lsls	r0, r1, #6
@   0x080187b4: 1a80        subs	r0, r0, r2
@   0x080187b6: 3804        subs	r0, #4
@   0x080187b8: 8003        strh	r3, [r0, #0]
@   0x080187ba: 1c48        adds	r0, r1, #1
@   0x080187bc: 0600        lsls	r0, r0, #24
@   0x080187be: 0e01        lsrs	r1, r0, #24
@   0x080187c0: 291f        cmp	r1, #31
@   0x080187c2: d9f6        bls.n	0x187b2
@   0x080187c4: 8928        ldrh	r0, [r5, #8]
@   0x080187c6: 3808        subs	r0, #8
@   0x080187c8: 8128        strh	r0, [r5, #8]
@   0x080187ca: 2008        movs	r0, #8
@   0x080187cc: 4030        ands	r0, r6
@   0x080187ce: 2800        cmp	r0, #0
@   0x080187d0: d029        beq.n	0x18826
@   0x080187d2: 4640        mov	r0, r8
@   0x080187d4: 2800        cmp	r0, #0
@   0x080187d6: d015        beq.n	0x18804
@   0x080187d8: 89a8        ldrh	r0, [r5, #12]
@   0x080187da: 3008        adds	r0, #8
@   0x080187dc: 81a8        strh	r0, [r5, #12]
@   0x080187de: 2100        movs	r1, #0
@   0x080187e0: 007a        lsls	r2, r7, #1
@   0x080187e2: 4c07        ldr	r4, [pc, #28]	@ (0x18800)
@   0x080187e4: 2300        movs	r3, #0
@   0x080187e6: 0188        lsls	r0, r1, #6
@   0x080187e8: 1810        adds	r0, r2, r0
@   0x080187ea: 1900        adds	r0, r0, r4
@   0x080187ec: 8003        strh	r3, [r0, #0]
@   0x080187ee: 1c48        adds	r0, r1, #1
@   0x080187f0: 0600        lsls	r0, r0, #24
@   0x080187f2: 0e01        lsrs	r1, r0, #24
@   0x080187f4: 291f        cmp	r1, #31
@   0x080187f6: d9f6        bls.n	0x187e6
@   0x080187f8: e015        b.n	0x18826
@   0x080187fa: 0000        movs	r0, r0
@   0x080187fc: 1000        asrs	r0, r0, #32
@   0x080187fe: f9ff        f7fe 	ldr??.w	pc, [pc, #2046]	@ 0x18ffe
@   0x08018802: 0600        lsls	r0, r0, #24
@   0x08018804: 2100        movs	r1, #0
@   0x08018806: 0078        lsls	r0, r7, #1
@   0x08018808: 4b20        ldr	r3, [pc, #128]	@ (0x1888c)
@   0x0801880a: 18c2        adds	r2, r0, r3
@   0x0801880c: 2300        movs	r3, #0
@   0x0801880e: 0188        lsls	r0, r1, #6
@   0x08018810: 1a80        subs	r0, r0, r2
@   0x08018812: 3804        subs	r0, #4
@   0x08018814: 8003        strh	r3, [r0, #0]
@   0x08018816: 1c48        adds	r0, r1, #1
@   0x08018818: 0600        lsls	r0, r0, #24
@   0x0801881a: 0e01        lsrs	r1, r0, #24
@   0x0801881c: 291f        cmp	r1, #31
@   0x0801881e: d9f6        bls.n	0x1880e
@   0x08018820: 89a8        ldrh	r0, [r5, #12]
@   0x08018822: 3808        subs	r0, #8
@   0x08018824: 81a8        strh	r0, [r5, #12]
@   0x08018826: 4661        mov	r1, ip
@   0x08018828: 0608        lsls	r0, r1, #24
@   0x0801882a: 0e07        lsrs	r7, r0, #24
@   0x0801882c: 2001        movs	r0, #1
@   0x0801882e: f005        fd1f 	bl	0x1e270
@   0x08018832: 4b17        ldr	r3, [pc, #92]	@ (0x18890)
@   0x08018834: 6818        ldr	r0, [r3, #0]
@   0x08018836: 6859        ldr	r1, [r3, #4]
@   0x08018838: 689a        ldr	r2, [r3, #8]
@   0x0801883a: 68db        ldr	r3, [r3, #12]
@   0x0801883c: f7ff        fec0 	bl	0x185c0
@   0x08018840: 454f        cmp	r7, r9
@   0x08018842: d200        bcs.n	0x18846
@   0x08018844: e735        b.n	0x186b2
@   0x08018846: 2001        movs	r0, #1
@   0x08018848: 4030        ands	r0, r6
@   0x0801884a: 2800        cmp	r0, #0
@   0x0801884c: d002        beq.n	0x18854
@   0x0801884e: 4911        ldr	r1, [pc, #68]	@ (0x18894)
@   0x08018850: 2000        movs	r0, #0
@   0x08018852: 8008        strh	r0, [r1, #0]
@   0x08018854: 2002        movs	r0, #2
@   0x08018856: 4030        ands	r0, r6
@   0x08018858: 2800        cmp	r0, #0
@   0x0801885a: d002        beq.n	0x18862
@   0x0801885c: 490d        ldr	r1, [pc, #52]	@ (0x18894)
@   0x0801885e: 2000        movs	r0, #0
@   0x08018860: 8088        strh	r0, [r1, #4]
@   0x08018862: 2004        movs	r0, #4
@   0x08018864: 4030        ands	r0, r6
@   0x08018866: 2800        cmp	r0, #0
@   0x08018868: d002        beq.n	0x18870
@   0x0801886a: 490a        ldr	r1, [pc, #40]	@ (0x18894)
@   0x0801886c: 2000        movs	r0, #0
@   0x0801886e: 8108        strh	r0, [r1, #8]
@   0x08018870: 2008        movs	r0, #8
@   0x08018872: 4030        ands	r0, r6
@   0x08018874: 2800        cmp	r0, #0
@   0x08018876: d002        beq.n	0x1887e
@   0x08018878: 4906        ldr	r1, [pc, #24]	@ (0x18894)
@   0x0801887a: 2000        movs	r0, #0
@   0x0801887c: 8188        strh	r0, [r1, #12]
@   0x0801887e: bc18        pop	{r3, r4}
@   0x08018880: 4698        mov	r8, r3
@   0x08018882: 46a1        mov	r9, r4
@   0x08018884: bcf0        pop	{r4, r5, r6, r7}
@   0x08018886: bc01        pop	{r0}
@   0x08018888: 4700        bx	r0
@   0x0801888a: 0000        movs	r0, r0
@   0x0801888c: 0800        lsrs	r0, r0, #32
@   0x0801888e: f9ff        8100 	ldr??.w	r8, [pc, #256]	@ 0x18990
@   0x08018892: 0830        lsrs	r0, r6, #32
@   0x08018894: 3550        adds	r5, #80	@ 0x50
@   0x08018896: 0300        lsls	r0, r0, #12
@   0x08018898: b081        sub	sp, #4
@   0x0801889a: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801889c: 4657        mov	r7, sl
@   0x0801889e: 464e        mov	r6, r9
@   0x080188a0: 4645        mov	r5, r8
@   0x080188a2: b4e0        push	{r5, r6, r7}
@   0x080188a4: b086        sub	sp, #24
@   0x080188a6: 9003        str	r0, [sp, #12]
@   0x080188a8: 930e        str	r3, [sp, #56]	@ 0x38
@   0x080188aa: 0609        lsls	r1, r1, #24
@   0x080188ac: 0e09        lsrs	r1, r1, #24
@   0x080188ae: 9104        str	r1, [sp, #16]
@   0x080188b0: 0612        lsls	r2, r2, #24
@   0x080188b2: 0e12        lsrs	r2, r2, #24
@   0x080188b4: 4692        mov	sl, r2
@   0x080188b6: 4e11        ldr	r6, [pc, #68]	@ (0x188fc)
@   0x080188b8: 9901        ldr	r1, [sp, #4]
@   0x080188ba: 4031        ands	r1, r6
@   0x080188bc: 25a0        movs	r5, #160	@ 0xa0
@   0x080188be: 056d        lsls	r5, r5, #21
@   0x080188c0: 4329        orrs	r1, r5
@   0x080188c2: 4c0f        ldr	r4, [pc, #60]	@ (0x18900)
@   0x080188c4: 4021        ands	r1, r4
@   0x080188c6: 2380        movs	r3, #128	@ 0x80
@   0x080188c8: 025b        lsls	r3, r3, #9
@   0x080188ca: 4319        orrs	r1, r3
@   0x080188cc: 9101        str	r1, [sp, #4]
@   0x080188ce: 2200        movs	r2, #0
@   0x080188d0: 2800        cmp	r0, #0
@   0x080188d2: d100        bne.n	0x188d6
@   0x080188d4: 221e        movs	r2, #30
@   0x080188d6: 480b        ldr	r0, [pc, #44]	@ (0x18904)
@   0x080188d8: 4001        ands	r1, r0
@   0x080188da: 4311        orrs	r1, r2
@   0x080188dc: 480a        ldr	r0, [pc, #40]	@ (0x18908)
@   0x080188de: 4001        ands	r1, r0
@   0x080188e0: 9101        str	r1, [sp, #4]
@   0x080188e2: 9802        ldr	r0, [sp, #8]
@   0x080188e4: 4030        ands	r0, r6
@   0x080188e6: 4328        orrs	r0, r5
@   0x080188e8: 4020        ands	r0, r4
@   0x080188ea: 4318        orrs	r0, r3
@   0x080188ec: 9002        str	r0, [sp, #8]
@   0x080188ee: 9903        ldr	r1, [sp, #12]
@   0x080188f0: 2900        cmp	r1, #0
@   0x080188f2: d10b        bne.n	0x1890c
@   0x080188f4: 201e        movs	r0, #30
@   0x080188f6: 9a04        ldr	r2, [sp, #16]
@   0x080188f8: 1a80        subs	r0, r0, r2
@   0x080188fa: e009        b.n	0x18910
@   0x080188fc: ffff        00ff 	vshr.u64	q8, <illegal reg q15.5>, #1
@   0x08018900: ffff        ff00 			@ <UNDEFINED> instruction: 0xffffff00
@   0x08018904: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x08018908: 00ff        lsls	r7, r7, #3
@   0x0801890a: ffff        466b 	vmlsl.u<illegal width 64>	q10, d15, d27[0]
@   0x0801890e: 7c18        ldrb	r0, [r3, #16]
@   0x08018910: 0601        lsls	r1, r0, #24
@   0x08018912: 0e09        lsrs	r1, r1, #24
@   0x08018914: 4a15        ldr	r2, [pc, #84]	@ (0x1896c)
@   0x08018916: 9802        ldr	r0, [sp, #8]
@   0x08018918: 4010        ands	r0, r2
@   0x0801891a: 4308        orrs	r0, r1
@   0x0801891c: 4914        ldr	r1, [pc, #80]	@ (0x18970)
@   0x0801891e: 4008        ands	r0, r1
@   0x08018920: 9002        str	r0, [sp, #8]
@   0x08018922: 2400        movs	r4, #0
@   0x08018924: 9804        ldr	r0, [sp, #16]
@   0x08018926: 4284        cmp	r4, r0
@   0x08018928: d300        bcc.n	0x1892c
@   0x0801892a: e154        b.n	0x18bd6
@   0x0801892c: 4911        ldr	r1, [pc, #68]	@ (0x18974)
@   0x0801892e: 4688        mov	r8, r1
@   0x08018930: 46e9        mov	r9, sp
@   0x08018932: 9a03        ldr	r2, [sp, #12]
@   0x08018934: 2a00        cmp	r2, #0
@   0x08018936: d121        bne.n	0x1897c
@   0x08018938: a801        add	r0, sp, #4
@   0x0801893a: 7800        ldrb	r0, [r0, #0]
@   0x0801893c: 3801        subs	r0, #1
@   0x0801893e: 0600        lsls	r0, r0, #24
@   0x08018940: 0e00        lsrs	r0, r0, #24
@   0x08018942: 4a0a        ldr	r2, [pc, #40]	@ (0x1896c)
@   0x08018944: 9901        ldr	r1, [sp, #4]
@   0x08018946: 4011        ands	r1, r2
@   0x08018948: 4301        orrs	r1, r0
@   0x0801894a: 0c08        lsrs	r0, r1, #16
@   0x0801894c: 3001        adds	r0, #1
@   0x0801894e: 0600        lsls	r0, r0, #24
@   0x08018950: 0a00        lsrs	r0, r0, #8
@   0x08018952: 4b09        ldr	r3, [pc, #36]	@ (0x18978)
@   0x08018954: 4019        ands	r1, r3
@   0x08018956: 4301        orrs	r1, r0
@   0x08018958: 9101        str	r1, [sp, #4]
@   0x0801895a: 9902        ldr	r1, [sp, #8]
@   0x0801895c: 0c08        lsrs	r0, r1, #16
@   0x0801895e: 3001        adds	r0, #1
@   0x08018960: 0600        lsls	r0, r0, #24
@   0x08018962: 0a00        lsrs	r0, r0, #8
@   0x08018964: 4019        ands	r1, r3
@   0x08018966: 4301        orrs	r1, r0
@   0x08018968: 9102        str	r1, [sp, #8]
@   0x0801896a: e020        b.n	0x189ae
@   0x0801896c: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x08018970: 00ff        lsls	r7, r7, #3
@   0x08018972: ffff        00d4 	vshr.u64	q8, q2, #1
@   0x08018976: 0400        lsls	r0, r0, #16
@   0x08018978: ffff        ff00 			@ <UNDEFINED> instruction: 0xffffff00
@   0x0801897c: a802        add	r0, sp, #8
@   0x0801897e: 7800        ldrb	r0, [r0, #0]
@   0x08018980: 3801        subs	r0, #1
@   0x08018982: 0600        lsls	r0, r0, #24
@   0x08018984: 0e00        lsrs	r0, r0, #24
@   0x08018986: 4998        ldr	r1, [pc, #608]	@ (0x18be8)
@   0x08018988: 9a02        ldr	r2, [sp, #8]
@   0x0801898a: 400a        ands	r2, r1
@   0x0801898c: 4302        orrs	r2, r0
@   0x0801898e: 9901        ldr	r1, [sp, #4]
@   0x08018990: 0c08        lsrs	r0, r1, #16
@   0x08018992: 3001        adds	r0, #1
@   0x08018994: 0600        lsls	r0, r0, #24
@   0x08018996: 0a00        lsrs	r0, r0, #8
@   0x08018998: 4b94        ldr	r3, [pc, #592]	@ (0x18bec)
@   0x0801899a: 4019        ands	r1, r3
@   0x0801899c: 4301        orrs	r1, r0
@   0x0801899e: 9101        str	r1, [sp, #4]
@   0x080189a0: 0c10        lsrs	r0, r2, #16
@   0x080189a2: 3001        adds	r0, #1
@   0x080189a4: 0600        lsls	r0, r0, #24
@   0x080189a6: 0a00        lsrs	r0, r0, #8
@   0x080189a8: 401a        ands	r2, r3
@   0x080189aa: 4302        orrs	r2, r0
@   0x080189ac: 9202        str	r2, [sp, #8]
@   0x080189ae: 2001        movs	r0, #1
@   0x080189b0: 4651        mov	r1, sl
@   0x080189b2: 4008        ands	r0, r1
@   0x080189b4: 3401        adds	r4, #1
@   0x080189b6: 9405        str	r4, [sp, #20]
@   0x080189b8: 2800        cmp	r0, #0
@   0x080189ba: d03b        beq.n	0x18a34
@   0x080189bc: 2000        movs	r0, #0
@   0x080189be: 464a        mov	r2, r9
@   0x080189c0: 8010        strh	r0, [r2, #0]
@   0x080189c2: 466b        mov	r3, sp
@   0x080189c4: 4640        mov	r0, r8
@   0x080189c6: 6003        str	r3, [r0, #0]
@   0x080189c8: 4d89        ldr	r5, [pc, #548]	@ (0x18bf0)
@   0x080189ca: 6045        str	r5, [r0, #4]
@   0x080189cc: 4889        ldr	r0, [pc, #548]	@ (0x18bf4)
@   0x080189ce: 4641        mov	r1, r8
@   0x080189d0: 6088        str	r0, [r1, #8]
@   0x080189d2: 6888        ldr	r0, [r1, #8]
@   0x080189d4: a801        add	r0, sp, #4
@   0x080189d6: a902        add	r1, sp, #8
@   0x080189d8: 9c0e        ldr	r4, [sp, #56]	@ 0x38
@   0x080189da: 78c2        ldrb	r2, [r0, #3]
@   0x080189dc: 78cb        ldrb	r3, [r1, #3]
@   0x080189de: 4684        mov	ip, r0
@   0x080189e0: 429a        cmp	r2, r3
@   0x080189e2: d900        bls.n	0x189e6
@   0x080189e4: 1c1a        adds	r2, r3, #0
@   0x080189e6: 1c17        adds	r7, r2, #0
@   0x080189e8: 4662        mov	r2, ip
@   0x080189ea: 7890        ldrb	r0, [r2, #2]
@   0x080189ec: 788a        ldrb	r2, [r1, #2]
@   0x080189ee: 4290        cmp	r0, r2
@   0x080189f0: d900        bls.n	0x189f4
@   0x080189f2: 1c10        adds	r0, r2, #0
@   0x080189f4: 1c06        adds	r6, r0, #0
@   0x080189f6: 7848        ldrb	r0, [r1, #1]
@   0x080189f8: 0140        lsls	r0, r0, #5
@   0x080189fa: 7809        ldrb	r1, [r1, #0]
@   0x080189fc: 1808        adds	r0, r1, r0
@   0x080189fe: 0040        lsls	r0, r0, #1
@   0x08018a00: 1821        adds	r1, r4, r0
@   0x08018a02: 4663        mov	r3, ip
@   0x08018a04: 7858        ldrb	r0, [r3, #1]
@   0x08018a06: 0140        lsls	r0, r0, #5
@   0x08018a08: 781a        ldrb	r2, [r3, #0]
@   0x08018a0a: 1810        adds	r0, r2, r0
@   0x08018a0c: 0040        lsls	r0, r0, #1
@   0x08018a0e: 1943        adds	r3, r0, r5
@   0x08018a10: 2400        movs	r4, #0
@   0x08018a12: 42bc        cmp	r4, r7
@   0x08018a14: d20e        bcs.n	0x18a34
@   0x08018a16: 4a78        ldr	r2, [pc, #480]	@ (0x18bf8)
@   0x08018a18: 2580        movs	r5, #128	@ 0x80
@   0x08018a1a: 062d        lsls	r5, r5, #24
@   0x08018a1c: 4335        orrs	r5, r6
@   0x08018a1e: 6011        str	r1, [r2, #0]
@   0x08018a20: 6053        str	r3, [r2, #4]
@   0x08018a22: 6095        str	r5, [r2, #8]
@   0x08018a24: 6890        ldr	r0, [r2, #8]
@   0x08018a26: 3140        adds	r1, #64	@ 0x40
@   0x08018a28: 3340        adds	r3, #64	@ 0x40
@   0x08018a2a: 1c60        adds	r0, r4, #1
@   0x08018a2c: 0600        lsls	r0, r0, #24
@   0x08018a2e: 0e04        lsrs	r4, r0, #24
@   0x08018a30: 42bc        cmp	r4, r7
@   0x08018a32: d3f4        bcc.n	0x18a1e
@   0x08018a34: 2002        movs	r0, #2
@   0x08018a36: 4653        mov	r3, sl
@   0x08018a38: 4018        ands	r0, r3
@   0x08018a3a: 2800        cmp	r0, #0
@   0x08018a3c: d03a        beq.n	0x18ab4
@   0x08018a3e: 2000        movs	r0, #0
@   0x08018a40: 4649        mov	r1, r9
@   0x08018a42: 8008        strh	r0, [r1, #0]
@   0x08018a44: 466a        mov	r2, sp
@   0x08018a46: 4643        mov	r3, r8
@   0x08018a48: 601a        str	r2, [r3, #0]
@   0x08018a4a: 4d6c        ldr	r5, [pc, #432]	@ (0x18bfc)
@   0x08018a4c: 605d        str	r5, [r3, #4]
@   0x08018a4e: 4869        ldr	r0, [pc, #420]	@ (0x18bf4)
@   0x08018a50: 6098        str	r0, [r3, #8]
@   0x08018a52: 6898        ldr	r0, [r3, #8]
@   0x08018a54: a801        add	r0, sp, #4
@   0x08018a56: a902        add	r1, sp, #8
@   0x08018a58: 9c0f        ldr	r4, [sp, #60]	@ 0x3c
@   0x08018a5a: 78c2        ldrb	r2, [r0, #3]
@   0x08018a5c: 78cb        ldrb	r3, [r1, #3]
@   0x08018a5e: 4684        mov	ip, r0
@   0x08018a60: 429a        cmp	r2, r3
@   0x08018a62: d900        bls.n	0x18a66
@   0x08018a64: 1c1a        adds	r2, r3, #0
@   0x08018a66: 1c17        adds	r7, r2, #0
@   0x08018a68: 4662        mov	r2, ip
@   0x08018a6a: 7890        ldrb	r0, [r2, #2]
@   0x08018a6c: 788a        ldrb	r2, [r1, #2]
@   0x08018a6e: 4290        cmp	r0, r2
@   0x08018a70: d900        bls.n	0x18a74
@   0x08018a72: 1c10        adds	r0, r2, #0
@   0x08018a74: 1c06        adds	r6, r0, #0
@   0x08018a76: 7848        ldrb	r0, [r1, #1]
@   0x08018a78: 0140        lsls	r0, r0, #5
@   0x08018a7a: 7809        ldrb	r1, [r1, #0]
@   0x08018a7c: 1808        adds	r0, r1, r0
@   0x08018a7e: 0040        lsls	r0, r0, #1
@   0x08018a80: 1821        adds	r1, r4, r0
@   0x08018a82: 4663        mov	r3, ip
@   0x08018a84: 7858        ldrb	r0, [r3, #1]
@   0x08018a86: 0140        lsls	r0, r0, #5
@   0x08018a88: 781a        ldrb	r2, [r3, #0]
@   0x08018a8a: 1810        adds	r0, r2, r0
@   0x08018a8c: 0040        lsls	r0, r0, #1
@   0x08018a8e: 1943        adds	r3, r0, r5
@   0x08018a90: 2400        movs	r4, #0
@   0x08018a92: 42bc        cmp	r4, r7
@   0x08018a94: d20e        bcs.n	0x18ab4
@   0x08018a96: 4a58        ldr	r2, [pc, #352]	@ (0x18bf8)
@   0x08018a98: 2580        movs	r5, #128	@ 0x80
@   0x08018a9a: 062d        lsls	r5, r5, #24
@   0x08018a9c: 4335        orrs	r5, r6
@   0x08018a9e: 6011        str	r1, [r2, #0]
@   0x08018aa0: 6053        str	r3, [r2, #4]
@   0x08018aa2: 6095        str	r5, [r2, #8]
@   0x08018aa4: 6890        ldr	r0, [r2, #8]
@   0x08018aa6: 3140        adds	r1, #64	@ 0x40
@   0x08018aa8: 3340        adds	r3, #64	@ 0x40
@   0x08018aaa: 1c60        adds	r0, r4, #1
@   0x08018aac: 0600        lsls	r0, r0, #24
@   0x08018aae: 0e04        lsrs	r4, r0, #24
@   0x08018ab0: 42bc        cmp	r4, r7
@   0x08018ab2: d3f4        bcc.n	0x18a9e
@   0x08018ab4: 2004        movs	r0, #4
@   0x08018ab6: 4653        mov	r3, sl
@   0x08018ab8: 4018        ands	r0, r3
@   0x08018aba: 2800        cmp	r0, #0
@   0x08018abc: d03a        beq.n	0x18b34
@   0x08018abe: 2000        movs	r0, #0
@   0x08018ac0: 4649        mov	r1, r9
@   0x08018ac2: 8008        strh	r0, [r1, #0]
@   0x08018ac4: 466a        mov	r2, sp
@   0x08018ac6: 4643        mov	r3, r8
@   0x08018ac8: 601a        str	r2, [r3, #0]
@   0x08018aca: 4d4d        ldr	r5, [pc, #308]	@ (0x18c00)
@   0x08018acc: 605d        str	r5, [r3, #4]
@   0x08018ace: 4849        ldr	r0, [pc, #292]	@ (0x18bf4)
@   0x08018ad0: 6098        str	r0, [r3, #8]
@   0x08018ad2: 6898        ldr	r0, [r3, #8]
@   0x08018ad4: a801        add	r0, sp, #4
@   0x08018ad6: a902        add	r1, sp, #8
@   0x08018ad8: 9c10        ldr	r4, [sp, #64]	@ 0x40
@   0x08018ada: 78c2        ldrb	r2, [r0, #3]
@   0x08018adc: 78cb        ldrb	r3, [r1, #3]
@   0x08018ade: 4684        mov	ip, r0
@   0x08018ae0: 429a        cmp	r2, r3
@   0x08018ae2: d900        bls.n	0x18ae6
@   0x08018ae4: 1c1a        adds	r2, r3, #0
@   0x08018ae6: 1c17        adds	r7, r2, #0
@   0x08018ae8: 4662        mov	r2, ip
@   0x08018aea: 7890        ldrb	r0, [r2, #2]
@   0x08018aec: 788a        ldrb	r2, [r1, #2]
@   0x08018aee: 4290        cmp	r0, r2
@   0x08018af0: d900        bls.n	0x18af4
@   0x08018af2: 1c10        adds	r0, r2, #0
@   0x08018af4: 1c06        adds	r6, r0, #0
@   0x08018af6: 7848        ldrb	r0, [r1, #1]
@   0x08018af8: 0140        lsls	r0, r0, #5
@   0x08018afa: 7809        ldrb	r1, [r1, #0]
@   0x08018afc: 1808        adds	r0, r1, r0
@   0x08018afe: 0040        lsls	r0, r0, #1
@   0x08018b00: 1821        adds	r1, r4, r0
@   0x08018b02: 4663        mov	r3, ip
@   0x08018b04: 7858        ldrb	r0, [r3, #1]
@   0x08018b06: 0140        lsls	r0, r0, #5
@   0x08018b08: 781a        ldrb	r2, [r3, #0]
@   0x08018b0a: 1810        adds	r0, r2, r0
@   0x08018b0c: 0040        lsls	r0, r0, #1
@   0x08018b0e: 1943        adds	r3, r0, r5
@   0x08018b10: 2400        movs	r4, #0
@   0x08018b12: 42bc        cmp	r4, r7
@   0x08018b14: d20e        bcs.n	0x18b34
@   0x08018b16: 4a38        ldr	r2, [pc, #224]	@ (0x18bf8)
@   0x08018b18: 2580        movs	r5, #128	@ 0x80
@   0x08018b1a: 062d        lsls	r5, r5, #24
@   0x08018b1c: 4335        orrs	r5, r6
@   0x08018b1e: 6011        str	r1, [r2, #0]
@   0x08018b20: 6053        str	r3, [r2, #4]
@   0x08018b22: 6095        str	r5, [r2, #8]
@   0x08018b24: 6890        ldr	r0, [r2, #8]
@   0x08018b26: 3140        adds	r1, #64	@ 0x40
@   0x08018b28: 3340        adds	r3, #64	@ 0x40
@   0x08018b2a: 1c60        adds	r0, r4, #1
@   0x08018b2c: 0600        lsls	r0, r0, #24
@   0x08018b2e: 0e04        lsrs	r4, r0, #24
@   0x08018b30: 42bc        cmp	r4, r7
@   0x08018b32: d3f4        bcc.n	0x18b1e
@   0x08018b34: 2008        movs	r0, #8
@   0x08018b36: 4653        mov	r3, sl
@   0x08018b38: 4018        ands	r0, r3
@   0x08018b3a: 2800        cmp	r0, #0
@   0x08018b3c: d03a        beq.n	0x18bb4
@   0x08018b3e: 2000        movs	r0, #0
@   0x08018b40: 4649        mov	r1, r9
@   0x08018b42: 8008        strh	r0, [r1, #0]
@   0x08018b44: 466a        mov	r2, sp
@   0x08018b46: 4643        mov	r3, r8
@   0x08018b48: 601a        str	r2, [r3, #0]
@   0x08018b4a: 4d2e        ldr	r5, [pc, #184]	@ (0x18c04)
@   0x08018b4c: 605d        str	r5, [r3, #4]
@   0x08018b4e: 4829        ldr	r0, [pc, #164]	@ (0x18bf4)
@   0x08018b50: 6098        str	r0, [r3, #8]
@   0x08018b52: 6898        ldr	r0, [r3, #8]
@   0x08018b54: a801        add	r0, sp, #4
@   0x08018b56: a902        add	r1, sp, #8
@   0x08018b58: 9c11        ldr	r4, [sp, #68]	@ 0x44
@   0x08018b5a: 78c2        ldrb	r2, [r0, #3]
@   0x08018b5c: 78cb        ldrb	r3, [r1, #3]
@   0x08018b5e: 4684        mov	ip, r0
@   0x08018b60: 429a        cmp	r2, r3
@   0x08018b62: d900        bls.n	0x18b66
@   0x08018b64: 1c1a        adds	r2, r3, #0
@   0x08018b66: 1c17        adds	r7, r2, #0
@   0x08018b68: 4662        mov	r2, ip
@   0x08018b6a: 7890        ldrb	r0, [r2, #2]
@   0x08018b6c: 788a        ldrb	r2, [r1, #2]
@   0x08018b6e: 4290        cmp	r0, r2
@   0x08018b70: d900        bls.n	0x18b74
@   0x08018b72: 1c10        adds	r0, r2, #0
@   0x08018b74: 1c06        adds	r6, r0, #0
@   0x08018b76: 7848        ldrb	r0, [r1, #1]
@   0x08018b78: 0140        lsls	r0, r0, #5
@   0x08018b7a: 7809        ldrb	r1, [r1, #0]
@   0x08018b7c: 1808        adds	r0, r1, r0
@   0x08018b7e: 0040        lsls	r0, r0, #1
@   0x08018b80: 1821        adds	r1, r4, r0
@   0x08018b82: 4663        mov	r3, ip
@   0x08018b84: 7858        ldrb	r0, [r3, #1]
@   0x08018b86: 0140        lsls	r0, r0, #5
@   0x08018b88: 781a        ldrb	r2, [r3, #0]
@   0x08018b8a: 1810        adds	r0, r2, r0
@   0x08018b8c: 0040        lsls	r0, r0, #1
@   0x08018b8e: 1943        adds	r3, r0, r5
@   0x08018b90: 2400        movs	r4, #0
@   0x08018b92: 42bc        cmp	r4, r7
@   0x08018b94: d20e        bcs.n	0x18bb4
@   0x08018b96: 4a18        ldr	r2, [pc, #96]	@ (0x18bf8)
@   0x08018b98: 2580        movs	r5, #128	@ 0x80
@   0x08018b9a: 062d        lsls	r5, r5, #24
@   0x08018b9c: 4335        orrs	r5, r6
@   0x08018b9e: 6011        str	r1, [r2, #0]
@   0x08018ba0: 6053        str	r3, [r2, #4]
@   0x08018ba2: 6095        str	r5, [r2, #8]
@   0x08018ba4: 6890        ldr	r0, [r2, #8]
@   0x08018ba6: 3140        adds	r1, #64	@ 0x40
@   0x08018ba8: 3340        adds	r3, #64	@ 0x40
@   0x08018baa: 1c60        adds	r0, r4, #1
@   0x08018bac: 0600        lsls	r0, r0, #24
@   0x08018bae: 0e04        lsrs	r4, r0, #24
@   0x08018bb0: 42bc        cmp	r4, r7
@   0x08018bb2: d3f4        bcc.n	0x18b9e
@   0x08018bb4: 9b05        ldr	r3, [sp, #20]
@   0x08018bb6: 0618        lsls	r0, r3, #24
@   0x08018bb8: 0e04        lsrs	r4, r0, #24
@   0x08018bba: 2001        movs	r0, #1
@   0x08018bbc: f005        fb58 	bl	0x1e270
@   0x08018bc0: 4b11        ldr	r3, [pc, #68]	@ (0x18c08)
@   0x08018bc2: 6818        ldr	r0, [r3, #0]
@   0x08018bc4: 6859        ldr	r1, [r3, #4]
@   0x08018bc6: 689a        ldr	r2, [r3, #8]
@   0x08018bc8: 68db        ldr	r3, [r3, #12]
@   0x08018bca: f7ff        fcf9 	bl	0x185c0
@   0x08018bce: 9804        ldr	r0, [sp, #16]
@   0x08018bd0: 4284        cmp	r4, r0
@   0x08018bd2: d200        bcs.n	0x18bd6
@   0x08018bd4: e6ad        b.n	0x18932
@   0x08018bd6: b006        add	sp, #24
@   0x08018bd8: bc38        pop	{r3, r4, r5}
@   0x08018bda: 4698        mov	r8, r3
@   0x08018bdc: 46a1        mov	r9, r4
@   0x08018bde: 46aa        mov	sl, r5
@   0x08018be0: bcf0        pop	{r4, r5, r6, r7}
@   0x08018be2: bc08        pop	{r3}
@   0x08018be4: b001        add	sp, #4
@   0x08018be6: 4718        bx	r3
@   0x08018be8: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x08018bec: ffff        ff00 			@ <UNDEFINED> instruction: 0xffffff00
@   0x08018bf0: e000        b.n	0x18bf4
@   0x08018bf2: 0600        lsls	r0, r0, #24
@   0x08018bf4: 0400        lsls	r0, r0, #16
@   0x08018bf6: 8100        strh	r0, [r0, #8]
@   0x08018bf8: 00d4        lsls	r4, r2, #3
@   0x08018bfa: 0400        lsls	r0, r0, #16
@   0x08018bfc: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x08018c00: f000        0600 	and.w	r6, r0, #0
@   0x08018c04: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x08018c08: 8100        strh	r0, [r0, #8]
@   0x08018c0a: 0830        lsrs	r0, r6, #32
@   0x08018c0c: b081        sub	sp, #4
@   0x08018c0e: 0600        lsls	r0, r0, #24
@   0x08018c10: 0e02        lsrs	r2, r0, #24
@   0x08018c12: 1c13        adds	r3, r2, #0
@   0x08018c14: 2001        movs	r0, #1
@   0x08018c16: 4010        ands	r0, r2
@   0x08018c18: 2800        cmp	r0, #0
@   0x08018c1a: d00a        beq.n	0x18c32
@   0x08018c1c: 4669        mov	r1, sp
@   0x08018c1e: 2000        movs	r0, #0
@   0x08018c20: 8008        strh	r0, [r1, #0]
@   0x08018c22: 491b        ldr	r1, [pc, #108]	@ (0x18c90)
@   0x08018c24: 4668        mov	r0, sp
@   0x08018c26: 6008        str	r0, [r1, #0]
@   0x08018c28: 481a        ldr	r0, [pc, #104]	@ (0x18c94)
@   0x08018c2a: 6048        str	r0, [r1, #4]
@   0x08018c2c: 481a        ldr	r0, [pc, #104]	@ (0x18c98)
@   0x08018c2e: 6088        str	r0, [r1, #8]
@   0x08018c30: 6888        ldr	r0, [r1, #8]
@   0x08018c32: 2002        movs	r0, #2
@   0x08018c34: 4010        ands	r0, r2
@   0x08018c36: 2800        cmp	r0, #0
@   0x08018c38: d00a        beq.n	0x18c50
@   0x08018c3a: 4669        mov	r1, sp
@   0x08018c3c: 2000        movs	r0, #0
@   0x08018c3e: 8008        strh	r0, [r1, #0]
@   0x08018c40: 4913        ldr	r1, [pc, #76]	@ (0x18c90)
@   0x08018c42: 4668        mov	r0, sp
@   0x08018c44: 6008        str	r0, [r1, #0]
@   0x08018c46: 4815        ldr	r0, [pc, #84]	@ (0x18c9c)
@   0x08018c48: 6048        str	r0, [r1, #4]
@   0x08018c4a: 4813        ldr	r0, [pc, #76]	@ (0x18c98)
@   0x08018c4c: 6088        str	r0, [r1, #8]
@   0x08018c4e: 6888        ldr	r0, [r1, #8]
@   0x08018c50: 2004        movs	r0, #4
@   0x08018c52: 4010        ands	r0, r2
@   0x08018c54: 2800        cmp	r0, #0
@   0x08018c56: d00a        beq.n	0x18c6e
@   0x08018c58: 4669        mov	r1, sp
@   0x08018c5a: 2000        movs	r0, #0
@   0x08018c5c: 8008        strh	r0, [r1, #0]
@   0x08018c5e: 490c        ldr	r1, [pc, #48]	@ (0x18c90)
@   0x08018c60: 4668        mov	r0, sp
@   0x08018c62: 6008        str	r0, [r1, #0]
@   0x08018c64: 480e        ldr	r0, [pc, #56]	@ (0x18ca0)
@   0x08018c66: 6048        str	r0, [r1, #4]
@   0x08018c68: 480b        ldr	r0, [pc, #44]	@ (0x18c98)
@   0x08018c6a: 6088        str	r0, [r1, #8]
@   0x08018c6c: 6888        ldr	r0, [r1, #8]
@   0x08018c6e: 2008        movs	r0, #8
@   0x08018c70: 4003        ands	r3, r0
@   0x08018c72: 2b00        cmp	r3, #0
@   0x08018c74: d00a        beq.n	0x18c8c
@   0x08018c76: 4669        mov	r1, sp
@   0x08018c78: 2000        movs	r0, #0
@   0x08018c7a: 8008        strh	r0, [r1, #0]
@   0x08018c7c: 4904        ldr	r1, [pc, #16]	@ (0x18c90)
@   0x08018c7e: 4668        mov	r0, sp
@   0x08018c80: 6008        str	r0, [r1, #0]
@   0x08018c82: 4808        ldr	r0, [pc, #32]	@ (0x18ca4)
@   0x08018c84: 6048        str	r0, [r1, #4]
@   0x08018c86: 4804        ldr	r0, [pc, #16]	@ (0x18c98)
@   0x08018c88: 6088        str	r0, [r1, #8]
@   0x08018c8a: 6888        ldr	r0, [r1, #8]
@   0x08018c8c: b001        add	sp, #4
@   0x08018c8e: 4770        bx	lr
@   0x08018c90: 00d4        lsls	r4, r2, #3
@   0x08018c92: 0400        lsls	r0, r0, #16
@   0x08018c94: e000        b.n	0x18c98
@   0x08018c96: 0600        lsls	r0, r0, #24
@   0x08018c98: 0400        lsls	r0, r0, #16
@   0x08018c9a: 8100        strh	r0, [r0, #8]
@   0x08018c9c: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x08018ca0: f000        0600 	and.w	r6, r0, #0
@   0x08018ca4: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x08018ca8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08018caa: 4657        mov	r7, sl
@   0x08018cac: 464e        mov	r6, r9
@   0x08018cae: 4645        mov	r5, r8
@   0x08018cb0: b4e0        push	{r5, r6, r7}
@   0x08018cb2: 4804        ldr	r0, [pc, #16]	@ (0x18cc4)
@   0x08018cb4: 7a40        ldrb	r0, [r0, #9]
@   0x08018cb6: 281b        cmp	r0, #27
@   0x08018cb8: d108        bne.n	0x18ccc
@   0x08018cba: 4803        ldr	r0, [pc, #12]	@ (0x18cc8)
@   0x08018cbc: 4684        mov	ip, r0
@   0x08018cbe: 2105        movs	r1, #5
@   0x08018cc0: 468a        mov	sl, r1
@   0x08018cc2: e009        b.n	0x18cd8
@   0x08018cc4: 5330        strh	r0, [r6, r4]
@   0x08018cc6: 0300        lsls	r0, r0, #12
@   0x08018cc8: d918        bls.n	0x18cfc
@   0x08018cca: 081b        lsrs	r3, r3, #32
@   0x08018ccc: 2804        cmp	r0, #4
@   0x08018cce: d103        bne.n	0x18cd8
@   0x08018cd0: 4a6c        ldr	r2, [pc, #432]	@ (0x18e84)
@   0x08018cd2: 4694        mov	ip, r2
@   0x08018cd4: 2303        movs	r3, #3
@   0x08018cd6: 469a        mov	sl, r3
@   0x08018cd8: 496b        ldr	r1, [pc, #428]	@ (0x18e88)
@   0x08018cda: 4a6c        ldr	r2, [pc, #432]	@ (0x18e8c)
@   0x08018cdc: 7d15        ldrb	r5, [r2, #20]
@   0x08018cde: 00a8        lsls	r0, r5, #2
@   0x08018ce0: 4460        add	r0, ip
@   0x08018ce2: 8800        ldrh	r0, [r0, #0]
@   0x08018ce4: 3810        subs	r0, #16
@   0x08018ce6: 2400        movs	r4, #0
@   0x08018ce8: 2300        movs	r3, #0
@   0x08018cea: 8008        strh	r0, [r1, #0]
@   0x08018cec: 7d15        ldrb	r5, [r2, #20]
@   0x08018cee: 00a8        lsls	r0, r5, #2
@   0x08018cf0: 4460        add	r0, ip
@   0x08018cf2: 8840        ldrh	r0, [r0, #2]
@   0x08018cf4: 3814        subs	r0, #20
@   0x08018cf6: 8048        strh	r0, [r1, #2]
@   0x08018cf8: 7d15        ldrb	r5, [r2, #20]
@   0x08018cfa: 00a8        lsls	r0, r5, #2
@   0x08018cfc: 4460        add	r0, ip
@   0x08018cfe: 7800        ldrb	r0, [r0, #0]
@   0x08018d00: 3810        subs	r0, #16
@   0x08018d02: 7108        strb	r0, [r1, #4]
@   0x08018d04: 7d12        ldrb	r2, [r2, #20]
@   0x08018d06: 0090        lsls	r0, r2, #2
@   0x08018d08: 4460        add	r0, ip
@   0x08018d0a: 7880        ldrb	r0, [r0, #2]
@   0x08018d0c: 3814        subs	r0, #20
@   0x08018d0e: 7148        strb	r0, [r1, #5]
@   0x08018d10: 610b        str	r3, [r1, #16]
@   0x08018d12: 608b        str	r3, [r1, #8]
@   0x08018d14: 2001        movs	r0, #1
@   0x08018d16: 60c8        str	r0, [r1, #12]
@   0x08018d18: 614b        str	r3, [r1, #20]
@   0x08018d1a: 618b        str	r3, [r1, #24]
@   0x08018d1c: 2004        movs	r0, #4
@   0x08018d1e: 7788        strb	r0, [r1, #30]
@   0x08018d20: 2014        movs	r0, #20
@   0x08018d22: 7708        strb	r0, [r1, #28]
@   0x08018d24: 7748        strb	r0, [r1, #29]
@   0x08018d26: 77cc        strb	r4, [r1, #31]
@   0x08018d28: 1c08        adds	r0, r1, #0
@   0x08018d2a: 3020        adds	r0, #32
@   0x08018d2c: 7004        strb	r4, [r0, #0]
@   0x08018d2e: 2600        movs	r6, #0
@   0x08018d30: 4857        ldr	r0, [pc, #348]	@ (0x18e90)
@   0x08018d32: 4681        mov	r9, r0
@   0x08018d34: 4957        ldr	r1, [pc, #348]	@ (0x18e94)
@   0x08018d36: 4688        mov	r8, r1
@   0x08018d38: 4a57        ldr	r2, [pc, #348]	@ (0x18e98)
@   0x08018d3a: 2100        movs	r1, #0
@   0x08018d3c: 0070        lsls	r0, r6, #1
@   0x08018d3e: 1880        adds	r0, r0, r2
@   0x08018d40: 8001        strh	r1, [r0, #0]
@   0x08018d42: 1c70        adds	r0, r6, #1
@   0x08018d44: 0600        lsls	r0, r0, #24
@   0x08018d46: 0e06        lsrs	r6, r0, #24
@   0x08018d48: 2e0f        cmp	r6, #15
@   0x08018d4a: d9f7        bls.n	0x18d3c
@   0x08018d4c: 2600        movs	r6, #0
@   0x08018d4e: 4c53        ldr	r4, [pc, #332]	@ (0x18e9c)
@   0x08018d50: 2500        movs	r5, #0
@   0x08018d52: 27f0        movs	r7, #240	@ 0xf0
@   0x08018d54: 00f1        lsls	r1, r6, #3
@   0x08018d56: 1908        adds	r0, r1, r4
@   0x08018d58: 8007        strh	r7, [r0, #0]
@   0x08018d5a: 2201        movs	r2, #1
@   0x08018d5c: 1c73        adds	r3, r6, #1
@   0x08018d5e: 0050        lsls	r0, r2, #1
@   0x08018d60: 1840        adds	r0, r0, r1
@   0x08018d62: 1900        adds	r0, r0, r4
@   0x08018d64: 8005        strh	r5, [r0, #0]
@   0x08018d66: 1c50        adds	r0, r2, #1
@   0x08018d68: 0600        lsls	r0, r0, #24
@   0x08018d6a: 0e02        lsrs	r2, r0, #24
@   0x08018d6c: 2a03        cmp	r2, #3
@   0x08018d6e: d9f6        bls.n	0x18d5e
@   0x08018d70: 0618        lsls	r0, r3, #24
@   0x08018d72: 0e06        lsrs	r6, r0, #24
@   0x08018d74: 2800        cmp	r0, #0
@   0x08018d76: daed        bge.n	0x18d54
@   0x08018d78: 4849        ldr	r0, [pc, #292]	@ (0x18ea0)
@   0x08018d7a: 464a        mov	r2, r9
@   0x08018d7c: 6002        str	r2, [r0, #0]
@   0x08018d7e: 4949        ldr	r1, [pc, #292]	@ (0x18ea4)
@   0x08018d80: 6041        str	r1, [r0, #4]
@   0x08018d82: 4a49        ldr	r2, [pc, #292]	@ (0x18ea8)
@   0x08018d84: 6082        str	r2, [r0, #8]
@   0x08018d86: 6881        ldr	r1, [r0, #8]
@   0x08018d88: 4b48        ldr	r3, [pc, #288]	@ (0x18eac)
@   0x08018d8a: 6003        str	r3, [r0, #0]
@   0x08018d8c: 4948        ldr	r1, [pc, #288]	@ (0x18eb0)
@   0x08018d8e: 6041        str	r1, [r0, #4]
@   0x08018d90: 6082        str	r2, [r0, #8]
@   0x08018d92: 6881        ldr	r1, [r0, #8]
@   0x08018d94: 4d47        ldr	r5, [pc, #284]	@ (0x18eb4)
@   0x08018d96: 6005        str	r5, [r0, #0]
@   0x08018d98: 4947        ldr	r1, [pc, #284]	@ (0x18eb8)
@   0x08018d9a: 6041        str	r1, [r0, #4]
@   0x08018d9c: 4947        ldr	r1, [pc, #284]	@ (0x18ebc)
@   0x08018d9e: 6081        str	r1, [r0, #8]
@   0x08018da0: 6881        ldr	r1, [r0, #8]
@   0x08018da2: 4a47        ldr	r2, [pc, #284]	@ (0x18ec0)
@   0x08018da4: 6811        ldr	r1, [r2, #0]
@   0x08018da6: 6001        str	r1, [r0, #0]
@   0x08018da8: 4946        ldr	r1, [pc, #280]	@ (0x18ec4)
@   0x08018daa: 6041        str	r1, [r0, #4]
@   0x08018dac: 4946        ldr	r1, [pc, #280]	@ (0x18ec8)
@   0x08018dae: 6081        str	r1, [r0, #8]
@   0x08018db0: 6880        ldr	r0, [r0, #8]
@   0x08018db2: 4643        mov	r3, r8
@   0x08018db4: 681c        ldr	r4, [r3, #0]
@   0x08018db6: 685d        ldr	r5, [r3, #4]
@   0x08018db8: 4944        ldr	r1, [pc, #272]	@ (0x18ecc)
@   0x08018dba: 4029        ands	r1, r5
@   0x08018dbc: 2021        movs	r0, #33	@ 0x21
@   0x08018dbe: 4301        orrs	r1, r0
@   0x08018dc0: 20c0        movs	r0, #192	@ 0xc0
@   0x08018dc2: 0600        lsls	r0, r0, #24
@   0x08018dc4: 4320        orrs	r0, r4
@   0x08018dc6: 4b42        ldr	r3, [pc, #264]	@ (0x18ed0)
@   0x08018dc8: 4003        ands	r3, r0
@   0x08018dca: 4842        ldr	r0, [pc, #264]	@ (0x18ed4)
@   0x08018dcc: 4001        ands	r1, r0
@   0x08018dce: 2080        movs	r0, #128	@ 0x80
@   0x08018dd0: 0140        lsls	r0, r0, #5
@   0x08018dd2: 1c0d        adds	r5, r1, #0
@   0x08018dd4: 4305        orrs	r5, r0
@   0x08018dd6: 4a40        ldr	r2, [pc, #256]	@ (0x18ed8)
@   0x08018dd8: 401a        ands	r2, r3
@   0x08018dda: 20c0        movs	r0, #192	@ 0xc0
@   0x08018ddc: 0100        lsls	r0, r0, #4
@   0x08018dde: 4305        orrs	r5, r0
@   0x08018de0: 493e        ldr	r1, [pc, #248]	@ (0x18edc)
@   0x08018de2: 4011        ands	r1, r2
@   0x08018de4: 4828        ldr	r0, [pc, #160]	@ (0x18e88)
@   0x08018de6: 7900        ldrb	r0, [r0, #4]
@   0x08018de8: 0402        lsls	r2, r0, #16
@   0x08018dea: 483d        ldr	r0, [pc, #244]	@ (0x18ee0)
@   0x08018dec: 4008        ands	r0, r1
@   0x08018dee: 4310        orrs	r0, r2
@   0x08018df0: 493c        ldr	r1, [pc, #240]	@ (0x18ee4)
@   0x08018df2: 4008        ands	r0, r1
@   0x08018df4: 4924        ldr	r1, [pc, #144]	@ (0x18e88)
@   0x08018df6: 794c        ldrb	r4, [r1, #5]
@   0x08018df8: 4304        orrs	r4, r0
@   0x08018dfa: 4a28        ldr	r2, [pc, #160]	@ (0x18e9c)
@   0x08018dfc: 6014        str	r4, [r2, #0]
@   0x08018dfe: 6055        str	r5, [r2, #4]
@   0x08018e00: 2600        movs	r6, #0
@   0x08018e02: 4556        cmp	r6, sl
@   0x08018e04: d22f        bcs.n	0x18e66
@   0x08018e06: 1c17        adds	r7, r2, #0
@   0x08018e08: 3708        adds	r7, #8
@   0x08018e0a: 4643        mov	r3, r8
@   0x08018e0c: 681c        ldr	r4, [r3, #0]
@   0x08018e0e: 685d        ldr	r5, [r3, #4]
@   0x08018e10: 4b2e        ldr	r3, [pc, #184]	@ (0x18ecc)
@   0x08018e12: 402b        ands	r3, r5
@   0x08018e14: 2001        movs	r0, #1
@   0x08018e16: 4303        orrs	r3, r0
@   0x08018e18: 4933        ldr	r1, [pc, #204]	@ (0x18ee8)
@   0x08018e1a: 4021        ands	r1, r4
@   0x08018e1c: 2080        movs	r0, #128	@ 0x80
@   0x08018e1e: 0600        lsls	r0, r0, #24
@   0x08018e20: 4301        orrs	r1, r0
@   0x08018e22: 4a2b        ldr	r2, [pc, #172]	@ (0x18ed0)
@   0x08018e24: 400a        ands	r2, r1
@   0x08018e26: 482b        ldr	r0, [pc, #172]	@ (0x18ed4)
@   0x08018e28: 1c1d        adds	r5, r3, #0
@   0x08018e2a: 4005        ands	r5, r0
@   0x08018e2c: 492a        ldr	r1, [pc, #168]	@ (0x18ed8)
@   0x08018e2e: 4011        ands	r1, r2
@   0x08018e30: 20c0        movs	r0, #192	@ 0xc0
@   0x08018e32: 0100        lsls	r0, r0, #4
@   0x08018e34: 4305        orrs	r5, r0
@   0x08018e36: 4a29        ldr	r2, [pc, #164]	@ (0x18edc)
@   0x08018e38: 400a        ands	r2, r1
@   0x08018e3a: 00b3        lsls	r3, r6, #2
@   0x08018e3c: 4463        add	r3, ip
@   0x08018e3e: 492b        ldr	r1, [pc, #172]	@ (0x18eec)
@   0x08018e40: 8818        ldrh	r0, [r3, #0]
@   0x08018e42: 4001        ands	r1, r0
@   0x08018e44: 0409        lsls	r1, r1, #16
@   0x08018e46: 4826        ldr	r0, [pc, #152]	@ (0x18ee0)
@   0x08018e48: 4010        ands	r0, r2
@   0x08018e4a: 4308        orrs	r0, r1
@   0x08018e4c: 4925        ldr	r1, [pc, #148]	@ (0x18ee4)
@   0x08018e4e: 4008        ands	r0, r1
@   0x08018e50: 789c        ldrb	r4, [r3, #2]
@   0x08018e52: 4304        orrs	r4, r0
@   0x08018e54: 00f0        lsls	r0, r6, #3
@   0x08018e56: 19c0        adds	r0, r0, r7
@   0x08018e58: 6004        str	r4, [r0, #0]
@   0x08018e5a: 6045        str	r5, [r0, #4]
@   0x08018e5c: 1c70        adds	r0, r6, #1
@   0x08018e5e: 0600        lsls	r0, r0, #24
@   0x08018e60: 0e06        lsrs	r6, r0, #24
@   0x08018e62: 4556        cmp	r6, sl
@   0x08018e64: d3d1        bcc.n	0x18e0a
@   0x08018e66: 2080        movs	r0, #128	@ 0x80
@   0x08018e68: 04c0        lsls	r0, r0, #19
@   0x08018e6a: 8801        ldrh	r1, [r0, #0]
@   0x08018e6c: 2382        movs	r3, #130	@ 0x82
@   0x08018e6e: 015b        lsls	r3, r3, #5
@   0x08018e70: 1c1a        adds	r2, r3, #0
@   0x08018e72: 4311        orrs	r1, r2
@   0x08018e74: 8001        strh	r1, [r0, #0]
@   0x08018e76: bc38        pop	{r3, r4, r5}
@   0x08018e78: 4698        mov	r8, r3
@   0x08018e7a: 46a1        mov	r9, r4
@   0x08018e7c: 46aa        mov	sl, r5
@   0x08018e7e: bcf0        pop	{r4, r5, r6, r7}
@   0x08018e80: bc01        pop	{r0}
@   0x08018e82: 4700        bx	r0
@   0x08018e84: d92c        bls.n	0x18ee0
@   0x08018e86: 081b        lsrs	r3, r3, #32
@   0x08018e88: 34d0        adds	r4, #208	@ 0xd0
@   0x08018e8a: 0300        lsls	r0, r0, #12
@   0x08018e8c: 3480        adds	r4, #128	@ 0x80
@   0x08018e8e: 0300        lsls	r0, r0, #12
@   0x08018e90: cc18        ldmia	r4, {r3, r4}
@   0x08018e92: 081e        lsrs	r6, r3, #32
@   0x08018e94: d910        bls.n	0x18eb8
@   0x08018e96: 081b        lsrs	r3, r3, #32
@   0x08018e98: 0000        movs	r0, r0
@   0x08018e9a: 0601        lsls	r1, r0, #24
@   0x08018e9c: 54a0        strb	r0, [r4, r2]
@   0x08018e9e: 0300        lsls	r0, r0, #12
@   0x08018ea0: 00d4        lsls	r4, r2, #3
@   0x08018ea2: 0400        lsls	r0, r0, #16
@   0x08018ea4: 0200        lsls	r0, r0, #8
@   0x08018ea6: 0500        lsls	r0, r0, #20
@   0x08018ea8: 0010        movs	r0, r2
@   0x08018eaa: 8000        strh	r0, [r0, #0]
@   0x08018eac: ce38        ldmia	r6!, {r3, r4, r5}
@   0x08018eae: 081e        lsrs	r6, r3, #32
@   0x08018eb0: 0220        lsls	r0, r4, #8
@   0x08018eb2: 0500        lsls	r0, r0, #20
@   0x08018eb4: cc38        ldmia	r4, {r3, r4, r5}
@   0x08018eb6: 081e        lsrs	r6, r3, #32
@   0x08018eb8: 0020        movs	r0, r4
@   0x08018eba: 0601        lsls	r1, r0, #24
@   0x08018ebc: 0100        lsls	r0, r0, #4
@   0x08018ebe: 8000        strh	r0, [r0, #0]
@   0x08018ec0: 80c0        strh	r0, [r0, #6]
@   0x08018ec2: 0830        lsrs	r0, r6, #32
@   0x08018ec4: 0420        lsls	r0, r4, #16
@   0x08018ec6: 0601        lsls	r1, r0, #24
@   0x08018ec8: 0400        lsls	r0, r0, #16
@   0x08018eca: 8000        strh	r0, [r0, #0]
@   0x08018ecc: fc00        ffff 			@ <UNDEFINED> instruction: 0xfc00ffff
@   0x08018ed0: dfff        svc	255	@ 0xff
@   0x08018ed2: ffff        0fff 			@ <UNDEFINED> instruction: 0xffff0fff
@   0x08018ed6: ffff        3fff 			@ <UNDEFINED> instruction: 0xffff3fff
@   0x08018eda: ffff        f3ff 	vrsra.u64	<illegal reg q15.5>, <illegal reg q15.5>, #1
@   0x08018ede: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x08018ee2: fe00        ff00 			@ <UNDEFINED> instruction: 0xfe00ff00
@   0x08018ee6: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x08018eea: 3fff        subs	r7, #255	@ 0xff
@   0x08018eec: 01ff        lsls	r7, r7, #7
@   0x08018eee: 0000        movs	r0, r0
@   0x08018ef0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08018ef2: 4657        mov	r7, sl
@   0x08018ef4: 464e        mov	r6, r9
@   0x08018ef6: 4645        mov	r5, r8
@   0x08018ef8: b4e0        push	{r5, r6, r7}
@   0x08018efa: b083        sub	sp, #12
@   0x08018efc: 4906        ldr	r1, [pc, #24]	@ (0x18f18)
@   0x08018efe: 4668        mov	r0, sp
@   0x08018f00: 2208        movs	r2, #8
@   0x08018f02: f01c        fc43 	bl	0x3578c
@   0x08018f06: 4805        ldr	r0, [pc, #20]	@ (0x18f1c)
@   0x08018f08: 7a40        ldrb	r0, [r0, #9]
@   0x08018f0a: 281b        cmp	r0, #27
@   0x08018f0c: d10a        bne.n	0x18f24
@   0x08018f0e: 4804        ldr	r0, [pc, #16]	@ (0x18f20)
@   0x08018f10: 9002        str	r0, [sp, #8]
@   0x08018f12: 2105        movs	r1, #5
@   0x08018f14: 468a        mov	sl, r1
@   0x08018f16: e00b        b.n	0x18f30
@   0x08018f18: d938        bls.n	0x18f8c
@   0x08018f1a: 081b        lsrs	r3, r3, #32
@   0x08018f1c: 5330        strh	r0, [r6, r4]
@   0x08018f1e: 0300        lsls	r0, r0, #12
@   0x08018f20: d918        bls.n	0x18f54
@   0x08018f22: 081b        lsrs	r3, r3, #32
@   0x08018f24: 2804        cmp	r0, #4
@   0x08018f26: d103        bne.n	0x18f30
@   0x08018f28: 4c09        ldr	r4, [pc, #36]	@ (0x18f50)
@   0x08018f2a: 9402        str	r4, [sp, #8]
@   0x08018f2c: 2003        movs	r0, #3
@   0x08018f2e: 4682        mov	sl, r0
@   0x08018f30: f7e7        fce6 	bl	0x900
@   0x08018f34: 4a07        ldr	r2, [pc, #28]	@ (0x18f54)
@   0x08018f36: 6991        ldr	r1, [r2, #24]
@   0x08018f38: 1a40        subs	r0, r0, r1
@   0x08018f3a: 7f11        ldrb	r1, [r2, #28]
@   0x08018f3c: 4288        cmp	r0, r1
@   0x08018f3e: d355        bcc.n	0x18fec
@   0x08018f40: 1c11        adds	r1, r2, #0
@   0x08018f42: 3120        adds	r1, #32
@   0x08018f44: 7808        ldrb	r0, [r1, #0]
@   0x08018f46: 2806        cmp	r0, #6
@   0x08018f48: d906        bls.n	0x18f58
@   0x08018f4a: 2000        movs	r0, #0
@   0x08018f4c: e005        b.n	0x18f5a
@   0x08018f4e: 0000        movs	r0, r0
@   0x08018f50: d92c        bls.n	0x18fac
@   0x08018f52: 081b        lsrs	r3, r3, #32
@   0x08018f54: 34d0        adds	r4, #208	@ 0xd0
@   0x08018f56: 0300        lsls	r0, r0, #12
@   0x08018f58: 3001        adds	r0, #1
@   0x08018f5a: 7008        strb	r0, [r1, #0]
@   0x08018f5c: 2500        movs	r5, #0
@   0x08018f5e: 4555        cmp	r5, sl
@   0x08018f60: d240        bcs.n	0x18fe4
@   0x08018f62: 4c26        ldr	r4, [pc, #152]	@ (0x18ffc)
@   0x08018f64: 46a1        mov	r9, r4
@   0x08018f66: 2008        movs	r0, #8
@   0x08018f68: 4240        negs	r0, r0
@   0x08018f6a: 4448        add	r0, r9
@   0x08018f6c: 4680        mov	r8, r0
@   0x08018f6e: 00e8        lsls	r0, r5, #3
@   0x08018f70: 4649        mov	r1, r9
@   0x08018f72: 1846        adds	r6, r0, r1
@   0x08018f74: 6832        ldr	r2, [r6, #0]
@   0x08018f76: 6873        ldr	r3, [r6, #4]
@   0x08018f78: 4c21        ldr	r4, [pc, #132]	@ (0x19000)
@   0x08018f7a: 7824        ldrb	r4, [r4, #0]
@   0x08018f7c: 1961        adds	r1, r4, r5
@   0x08018f7e: 1c08        adds	r0, r1, #0
@   0x08018f80: 10c0        asrs	r0, r0, #3
@   0x08018f82: 00c0        lsls	r0, r0, #3
@   0x08018f84: 1a08        subs	r0, r1, r0
@   0x08018f86: 0600        lsls	r0, r0, #24
@   0x08018f88: 0e00        lsrs	r0, r0, #24
@   0x08018f8a: 00a9        lsls	r1, r5, #2
@   0x08018f8c: 9c02        ldr	r4, [sp, #8]
@   0x08018f8e: 1909        adds	r1, r1, r4
@   0x08018f90: 4468        add	r0, sp
@   0x08018f92: 7800        ldrb	r0, [r0, #0]
@   0x08018f94: 0600        lsls	r0, r0, #24
@   0x08018f96: 1600        asrs	r0, r0, #24
@   0x08018f98: 8809        ldrh	r1, [r1, #0]
@   0x08018f9a: 1808        adds	r0, r1, r0
@   0x08018f9c: 0400        lsls	r0, r0, #16
@   0x08018f9e: 1404        asrs	r4, r0, #16
@   0x08018fa0: 4f18        ldr	r7, [pc, #96]	@ (0x19004)
@   0x08018fa2: 1c21        adds	r1, r4, #0
@   0x08018fa4: 4039        ands	r1, r7
@   0x08018fa6: 0409        lsls	r1, r1, #16
@   0x08018fa8: 4817        ldr	r0, [pc, #92]	@ (0x19008)
@   0x08018faa: 4684        mov	ip, r0
@   0x08018fac: 4010        ands	r0, r2
@   0x08018fae: 1c02        adds	r2, r0, #0
@   0x08018fb0: 430a        orrs	r2, r1
@   0x08018fb2: 6032        str	r2, [r6, #0]
@   0x08018fb4: 6073        str	r3, [r6, #4]
@   0x08018fb6: 4915        ldr	r1, [pc, #84]	@ (0x1900c)
@   0x08018fb8: 7d09        ldrb	r1, [r1, #20]
@   0x08018fba: 428d        cmp	r5, r1
@   0x08018fbc: d10d        bne.n	0x18fda
@   0x08018fbe: 4640        mov	r0, r8
@   0x08018fc0: 6802        ldr	r2, [r0, #0]
@   0x08018fc2: 6843        ldr	r3, [r0, #4]
@   0x08018fc4: 1c21        adds	r1, r4, #0
@   0x08018fc6: 3910        subs	r1, #16
@   0x08018fc8: 4039        ands	r1, r7
@   0x08018fca: 0409        lsls	r1, r1, #16
@   0x08018fcc: 4660        mov	r0, ip
@   0x08018fce: 4010        ands	r0, r2
@   0x08018fd0: 1c02        adds	r2, r0, #0
@   0x08018fd2: 430a        orrs	r2, r1
@   0x08018fd4: 4641        mov	r1, r8
@   0x08018fd6: 600a        str	r2, [r1, #0]
@   0x08018fd8: 604b        str	r3, [r1, #4]
@   0x08018fda: 1c68        adds	r0, r5, #1
@   0x08018fdc: 0600        lsls	r0, r0, #24
@   0x08018fde: 0e05        lsrs	r5, r0, #24
@   0x08018fe0: 4555        cmp	r5, sl
@   0x08018fe2: d3c4        bcc.n	0x18f6e
@   0x08018fe4: f7e7        fc8c 	bl	0x900
@   0x08018fe8: 4909        ldr	r1, [pc, #36]	@ (0x19010)
@   0x08018fea: 6188        str	r0, [r1, #24]
@   0x08018fec: b003        add	sp, #12
@   0x08018fee: bc38        pop	{r3, r4, r5}
@   0x08018ff0: 4698        mov	r8, r3
@   0x08018ff2: 46a1        mov	r9, r4
@   0x08018ff4: 46aa        mov	sl, r5
@   0x08018ff6: bcf0        pop	{r4, r5, r6, r7}
@   0x08018ff8: bc01        pop	{r0}
@   0x08018ffa: 4700        bx	r0
@   0x08018ffc: 54a8        strb	r0, [r5, r2]
@   0x08018ffe: 0300        lsls	r0, r0, #12
@   0x08019000: 34f0        adds	r4, #240	@ 0xf0
@   0x08019002: 0300        lsls	r0, r0, #12
@   0x08019004: 01ff        lsls	r7, r7, #7
@   0x08019006: 0000        movs	r0, r0
@   0x08019008: ffff        fe00 			@ <UNDEFINED> instruction: 0xfffffe00
@   0x0801900c: 3480        adds	r4, #128	@ 0x80
@   0x0801900e: 0300        lsls	r0, r0, #12
@   0x08019010: 34d0        adds	r4, #208	@ 0xd0
@   0x08019012: 0300        lsls	r0, r0, #12
@   0x08019014: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08019016: 4657        mov	r7, sl
@   0x08019018: 464e        mov	r6, r9
@   0x0801901a: 4645        mov	r5, r8
@   0x0801901c: b4e0        push	{r5, r6, r7}
@   0x0801901e: b083        sub	sp, #12
@   0x08019020: 4682        mov	sl, r0
@   0x08019022: 4803        ldr	r0, [pc, #12]	@ (0x19030)
@   0x08019024: 7a40        ldrb	r0, [r0, #9]
@   0x08019026: 281b        cmp	r0, #27
@   0x08019028: d106        bne.n	0x19038
@   0x0801902a: 4a02        ldr	r2, [pc, #8]	@ (0x19034)
@   0x0801902c: e007        b.n	0x1903e
@   0x0801902e: 0000        movs	r0, r0
@   0x08019030: 5330        strh	r0, [r6, r4]
@   0x08019032: 0300        lsls	r0, r0, #12
@   0x08019034: d918        bls.n	0x19068
@   0x08019036: 081b        lsrs	r3, r3, #32
@   0x08019038: 2804        cmp	r0, #4
@   0x0801903a: d100        bne.n	0x1903e
@   0x0801903c: 4a0b        ldr	r2, [pc, #44]	@ (0x1906c)
@   0x0801903e: 4650        mov	r0, sl
@   0x08019040: 2800        cmp	r0, #0
@   0x08019042: d017        beq.n	0x19074
@   0x08019044: 480a        ldr	r0, [pc, #40]	@ (0x19070)
@   0x08019046: 7d00        ldrb	r0, [r0, #20]
@   0x08019048: 0081        lsls	r1, r0, #2
@   0x0801904a: 1889        adds	r1, r1, r2
@   0x0801904c: 8888        ldrh	r0, [r1, #4]
@   0x0801904e: 3810        subs	r0, #16
@   0x08019050: 0400        lsls	r0, r0, #16
@   0x08019052: 0c03        lsrs	r3, r0, #16
@   0x08019054: 88c8        ldrh	r0, [r1, #6]
@   0x08019056: 3814        subs	r0, #20
@   0x08019058: 0400        lsls	r0, r0, #16
@   0x0801905a: 0c00        lsrs	r0, r0, #16
@   0x0801905c: 4681        mov	r9, r0
@   0x0801905e: 8808        ldrh	r0, [r1, #0]
@   0x08019060: 3810        subs	r0, #16
@   0x08019062: 0400        lsls	r0, r0, #16
@   0x08019064: 0c06        lsrs	r6, r0, #16
@   0x08019066: 8848        ldrh	r0, [r1, #2]
@   0x08019068: 3814        subs	r0, #20
@   0x0801906a: e018        b.n	0x1909e
@   0x0801906c: d92c        bls.n	0x190c8
@   0x0801906e: 081b        lsrs	r3, r3, #32
@   0x08019070: 3480        adds	r4, #128	@ 0x80
@   0x08019072: 0300        lsls	r0, r0, #12
@   0x08019074: 482c        ldr	r0, [pc, #176]	@ (0x19128)
@   0x08019076: 7d00        ldrb	r0, [r0, #20]
@   0x08019078: 0081        lsls	r1, r0, #2
@   0x0801907a: 1889        adds	r1, r1, r2
@   0x0801907c: 1f08        subs	r0, r1, #4
@   0x0801907e: 8800        ldrh	r0, [r0, #0]
@   0x08019080: 3810        subs	r0, #16
@   0x08019082: 0400        lsls	r0, r0, #16
@   0x08019084: 0c03        lsrs	r3, r0, #16
@   0x08019086: 1e88        subs	r0, r1, #2
@   0x08019088: 8800        ldrh	r0, [r0, #0]
@   0x0801908a: 3810        subs	r0, #16
@   0x0801908c: 0400        lsls	r0, r0, #16
@   0x0801908e: 0c00        lsrs	r0, r0, #16
@   0x08019090: 4681        mov	r9, r0
@   0x08019092: 8808        ldrh	r0, [r1, #0]
@   0x08019094: 3810        subs	r0, #16
@   0x08019096: 0400        lsls	r0, r0, #16
@   0x08019098: 0c06        lsrs	r6, r0, #16
@   0x0801909a: 8848        ldrh	r0, [r1, #2]
@   0x0801909c: 3810        subs	r0, #16
@   0x0801909e: 0400        lsls	r0, r0, #16
@   0x080190a0: 0c00        lsrs	r0, r0, #16
@   0x080190a2: 4684        mov	ip, r0
@   0x080190a4: 4821        ldr	r0, [pc, #132]	@ (0x1912c)
@   0x080190a6: 6804        ldr	r4, [r0, #0]
@   0x080190a8: 6845        ldr	r5, [r0, #4]
@   0x080190aa: 4921        ldr	r1, [pc, #132]	@ (0x19130)
@   0x080190ac: 4029        ands	r1, r5
@   0x080190ae: 2021        movs	r0, #33	@ 0x21
@   0x080190b0: 4301        orrs	r1, r0
@   0x080190b2: 20c0        movs	r0, #192	@ 0xc0
@   0x080190b4: 0600        lsls	r0, r0, #24
@   0x080190b6: 4320        orrs	r0, r4
@   0x080190b8: 4a1e        ldr	r2, [pc, #120]	@ (0x19134)
@   0x080190ba: 4002        ands	r2, r0
@   0x080190bc: 481e        ldr	r0, [pc, #120]	@ (0x19138)
@   0x080190be: 4001        ands	r1, r0
@   0x080190c0: 2080        movs	r0, #128	@ 0x80
@   0x080190c2: 0140        lsls	r0, r0, #5
@   0x080190c4: 1c0d        adds	r5, r1, #0
@   0x080190c6: 4305        orrs	r5, r0
@   0x080190c8: 491c        ldr	r1, [pc, #112]	@ (0x1913c)
@   0x080190ca: 4011        ands	r1, r2
@   0x080190cc: 20c0        movs	r0, #192	@ 0xc0
@   0x080190ce: 0100        lsls	r0, r0, #4
@   0x080190d0: 4305        orrs	r5, r0
@   0x080190d2: 4a1b        ldr	r2, [pc, #108]	@ (0x19140)
@   0x080190d4: 400a        ands	r2, r1
@   0x080190d6: 041b        lsls	r3, r3, #16
@   0x080190d8: 01d9        lsls	r1, r3, #7
@   0x080190da: 09c9        lsrs	r1, r1, #7
@   0x080190dc: 4819        ldr	r0, [pc, #100]	@ (0x19144)
@   0x080190de: 4010        ands	r0, r2
@   0x080190e0: 4308        orrs	r0, r1
@   0x080190e2: 464a        mov	r2, r9
@   0x080190e4: 0611        lsls	r1, r2, #24
@   0x080190e6: 0e09        lsrs	r1, r1, #24
@   0x080190e8: 4a17        ldr	r2, [pc, #92]	@ (0x19148)
@   0x080190ea: 4010        ands	r0, r2
@   0x080190ec: 1c04        adds	r4, r0, #0
@   0x080190ee: 430c        orrs	r4, r1
@   0x080190f0: 4816        ldr	r0, [pc, #88]	@ (0x1914c)
@   0x080190f2: 9301        str	r3, [sp, #4]
@   0x080190f4: 0436        lsls	r6, r6, #16
@   0x080190f6: 46b0        mov	r8, r6
@   0x080190f8: 4663        mov	r3, ip
@   0x080190fa: 061b        lsls	r3, r3, #24
@   0x080190fc: 9302        str	r3, [sp, #8]
@   0x080190fe: 7fc1        ldrb	r1, [r0, #31]
@   0x08019100: 2906        cmp	r1, #6
@   0x08019102: d864        bhi.n	0x191ce
@   0x08019104: 1c07        adds	r7, r0, #0
@   0x08019106: 4e12        ldr	r6, [pc, #72]	@ (0x19150)
@   0x08019108: 4662        mov	r2, ip
@   0x0801910a: 0410        lsls	r0, r2, #16
@   0x0801910c: 1400        asrs	r0, r0, #16
@   0x0801910e: 9000        str	r0, [sp, #0]
@   0x08019110: 2002        movs	r0, #2
@   0x08019112: f005        f8ad 	bl	0x1e270
@   0x08019116: 7ff8        ldrb	r0, [r7, #31]
@   0x08019118: 3001        adds	r0, #1
@   0x0801911a: 77f8        strb	r0, [r7, #31]
@   0x0801911c: 4653        mov	r3, sl
@   0x0801911e: 2b00        cmp	r3, #0
@   0x08019120: d01a        beq.n	0x19158
@   0x08019122: 490c        ldr	r1, [pc, #48]	@ (0x19154)
@   0x08019124: 0080        lsls	r0, r0, #2
@   0x08019126: e01a        b.n	0x1915e
@   0x08019128: 3480        adds	r4, #128	@ 0x80
@   0x0801912a: 0300        lsls	r0, r0, #12
@   0x0801912c: d910        bls.n	0x19150
@   0x0801912e: 081b        lsrs	r3, r3, #32
@   0x08019130: fc00        ffff 			@ <UNDEFINED> instruction: 0xfc00ffff
@   0x08019134: dfff        svc	255	@ 0xff
@   0x08019136: ffff        0fff 			@ <UNDEFINED> instruction: 0xffff0fff
@   0x0801913a: ffff        3fff 			@ <UNDEFINED> instruction: 0xffff3fff
@   0x0801913e: ffff        f3ff 	vrsra.u64	<illegal reg q15.5>, <illegal reg q15.5>, #1
@   0x08019142: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x08019146: fe00        ff00 			@ <UNDEFINED> instruction: 0xfe00ff00
@   0x0801914a: ffff        34d0 	vsri.64	<illegal reg q9.5>, q0, #1
@   0x0801914e: 0300        lsls	r0, r0, #12
@   0x08019150: 00d4        lsls	r4, r2, #3
@   0x08019152: 0400        lsls	r0, r0, #16
@   0x08019154: 80c0        strh	r0, [r0, #6]
@   0x08019156: 0830        lsrs	r0, r6, #32
@   0x08019158: 492a        ldr	r1, [pc, #168]	@ (0x19204)
@   0x0801915a: 7ffa        ldrb	r2, [r7, #31]
@   0x0801915c: 0090        lsls	r0, r2, #2
@   0x0801915e: 1840        adds	r0, r0, r1
@   0x08019160: 6800        ldr	r0, [r0, #0]
@   0x08019162: 6030        str	r0, [r6, #0]
@   0x08019164: 4828        ldr	r0, [pc, #160]	@ (0x19208)
@   0x08019166: 6070        str	r0, [r6, #4]
@   0x08019168: 4828        ldr	r0, [pc, #160]	@ (0x1920c)
@   0x0801916a: 60b0        str	r0, [r6, #8]
@   0x0801916c: 68b0        ldr	r0, [r6, #8]
@   0x0801916e: 01e0        lsls	r0, r4, #7
@   0x08019170: 0dc2        lsrs	r2, r0, #23
@   0x08019172: 4643        mov	r3, r8
@   0x08019174: 1419        asrs	r1, r3, #16
@   0x08019176: 9b01        ldr	r3, [sp, #4]
@   0x08019178: 1418        asrs	r0, r3, #16
@   0x0801917a: 1a08        subs	r0, r1, r0
@   0x0801917c: 2800        cmp	r0, #0
@   0x0801917e: da00        bge.n	0x19182
@   0x08019180: 3007        adds	r0, #7
@   0x08019182: 10c0        asrs	r0, r0, #3
@   0x08019184: 1810        adds	r0, r2, r0
@   0x08019186: 4922        ldr	r1, [pc, #136]	@ (0x19210)
@   0x08019188: 4008        ands	r0, r1
@   0x0801918a: 0400        lsls	r0, r0, #16
@   0x0801918c: 4a21        ldr	r2, [pc, #132]	@ (0x19214)
@   0x0801918e: 4022        ands	r2, r4
@   0x08019190: 4302        orrs	r2, r0
@   0x08019192: 1c14        adds	r4, r2, #0
@   0x08019194: 4649        mov	r1, r9
@   0x08019196: 0408        lsls	r0, r1, #16
@   0x08019198: 1400        asrs	r0, r0, #16
@   0x0801919a: 9b00        ldr	r3, [sp, #0]
@   0x0801919c: 1a18        subs	r0, r3, r0
@   0x0801919e: 2800        cmp	r0, #0
@   0x080191a0: da00        bge.n	0x191a4
@   0x080191a2: 3007        adds	r0, #7
@   0x080191a4: 10c0        asrs	r0, r0, #3
@   0x080191a6: 1820        adds	r0, r4, r0
@   0x080191a8: 0600        lsls	r0, r0, #24
@   0x080191aa: 0e00        lsrs	r0, r0, #24
@   0x080191ac: 491a        ldr	r1, [pc, #104]	@ (0x19218)
@   0x080191ae: 400a        ands	r2, r1
@   0x080191b0: 1c14        adds	r4, r2, #0
@   0x080191b2: 4304        orrs	r4, r0
@   0x080191b4: 4819        ldr	r0, [pc, #100]	@ (0x1921c)
@   0x080191b6: 6004        str	r4, [r0, #0]
@   0x080191b8: 6045        str	r5, [r0, #4]
@   0x080191ba: 4b19        ldr	r3, [pc, #100]	@ (0x19220)
@   0x080191bc: 6818        ldr	r0, [r3, #0]
@   0x080191be: 6859        ldr	r1, [r3, #4]
@   0x080191c0: 689a        ldr	r2, [r3, #8]
@   0x080191c2: 68db        ldr	r3, [r3, #12]
@   0x080191c4: f7ff        f9fc 	bl	0x185c0
@   0x080191c8: 7ff8        ldrb	r0, [r7, #31]
@   0x080191ca: 2806        cmp	r0, #6
@   0x080191cc: d9a0        bls.n	0x19110
@   0x080191ce: 4642        mov	r2, r8
@   0x080191d0: 01d1        lsls	r1, r2, #7
@   0x080191d2: 09c9        lsrs	r1, r1, #7
@   0x080191d4: 480f        ldr	r0, [pc, #60]	@ (0x19214)
@   0x080191d6: 4020        ands	r0, r4
@   0x080191d8: 4308        orrs	r0, r1
@   0x080191da: 9b02        ldr	r3, [sp, #8]
@   0x080191dc: 0e1a        lsrs	r2, r3, #24
@   0x080191de: 490e        ldr	r1, [pc, #56]	@ (0x19218)
@   0x080191e0: 4008        ands	r0, r1
@   0x080191e2: 1c04        adds	r4, r0, #0
@   0x080191e4: 4314        orrs	r4, r2
@   0x080191e6: 480d        ldr	r0, [pc, #52]	@ (0x1921c)
@   0x080191e8: 6004        str	r4, [r0, #0]
@   0x080191ea: 6045        str	r5, [r0, #4]
@   0x080191ec: 490d        ldr	r1, [pc, #52]	@ (0x19224)
@   0x080191ee: 2000        movs	r0, #0
@   0x080191f0: 77c8        strb	r0, [r1, #31]
@   0x080191f2: b003        add	sp, #12
@   0x080191f4: bc38        pop	{r3, r4, r5}
@   0x080191f6: 4698        mov	r8, r3
@   0x080191f8: 46a1        mov	r9, r4
@   0x080191fa: 46aa        mov	sl, r5
@   0x080191fc: bcf0        pop	{r4, r5, r6, r7}
@   0x080191fe: bc01        pop	{r0}
@   0x08019200: 4700        bx	r0
@   0x08019202: 0000        movs	r0, r0
@   0x08019204: 80e0        strh	r0, [r4, #6]
@   0x08019206: 0830        lsrs	r0, r6, #32
@   0x08019208: 0420        lsls	r0, r4, #16
@   0x0801920a: 0601        lsls	r1, r0, #24
@   0x0801920c: 0400        lsls	r0, r0, #16
@   0x0801920e: 8000        strh	r0, [r0, #0]
@   0x08019210: 01ff        lsls	r7, r7, #7
@   0x08019212: 0000        movs	r0, r0
@   0x08019214: ffff        fe00 			@ <UNDEFINED> instruction: 0xfffffe00
@   0x08019218: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0801921c: 54a0        strb	r0, [r4, r2]
@   0x0801921e: 0300        lsls	r0, r0, #12
@   0x08019220: 8100        strh	r0, [r0, #8]
@   0x08019222: 0830        lsrs	r0, r6, #32
@   0x08019224: 34d0        adds	r4, #208	@ 0xd0
@   0x08019226: 0300        lsls	r0, r0, #12
@   0x08019228: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801922a: 4657        mov	r7, sl
@   0x0801922c: 464e        mov	r6, r9
@   0x0801922e: 4645        mov	r5, r8
@   0x08019230: b4e0        push	{r5, r6, r7}
@   0x08019232: b085        sub	sp, #20
@   0x08019234: 4905        ldr	r1, [pc, #20]	@ (0x1924c)
@   0x08019236: 4668        mov	r0, sp
@   0x08019238: 2208        movs	r2, #8
@   0x0801923a: f01c        faa7 	bl	0x3578c
@   0x0801923e: 4804        ldr	r0, [pc, #16]	@ (0x19250)
@   0x08019240: 7a40        ldrb	r0, [r0, #9]
@   0x08019242: 281b        cmp	r0, #27
@   0x08019244: d108        bne.n	0x19258
@   0x08019246: 4803        ldr	r0, [pc, #12]	@ (0x19254)
@   0x08019248: 9002        str	r0, [sp, #8]
@   0x0801924a: e009        b.n	0x19260
@   0x0801924c: d938        bls.n	0x192c0
@   0x0801924e: 081b        lsrs	r3, r3, #32
@   0x08019250: 5330        strh	r0, [r6, r4]
@   0x08019252: 0300        lsls	r0, r0, #12
@   0x08019254: d918        bls.n	0x19288
@   0x08019256: 081b        lsrs	r3, r3, #32
@   0x08019258: 2804        cmp	r0, #4
@   0x0801925a: d101        bne.n	0x19260
@   0x0801925c: 492c        ldr	r1, [pc, #176]	@ (0x19310)
@   0x0801925e: 9102        str	r1, [sp, #8]
@   0x08019260: 482c        ldr	r0, [pc, #176]	@ (0x19314)
@   0x08019262: 7d00        ldrb	r0, [r0, #20]
@   0x08019264: 00c0        lsls	r0, r0, #3
@   0x08019266: 492c        ldr	r1, [pc, #176]	@ (0x19318)
@   0x08019268: 1840        adds	r0, r0, r1
@   0x0801926a: 6802        ldr	r2, [r0, #0]
@   0x0801926c: 6843        ldr	r3, [r0, #4]
@   0x0801926e: 9203        str	r2, [sp, #12]
@   0x08019270: 9304        str	r3, [sp, #16]
@   0x08019272: 1c08        adds	r0, r1, #0
@   0x08019274: 3808        subs	r0, #8
@   0x08019276: 6804        ldr	r4, [r0, #0]
@   0x08019278: 6845        ldr	r5, [r0, #4]
@   0x0801927a: 2300        movs	r3, #0
@   0x0801927c: 4699        mov	r9, r3
@   0x0801927e: 4e27        ldr	r6, [pc, #156]	@ (0x1931c)
@   0x08019280: 46b2        mov	sl, r6
@   0x08019282: 4827        ldr	r0, [pc, #156]	@ (0x19320)
@   0x08019284: 4680        mov	r8, r0
@   0x08019286: 2001        movs	r0, #1
@   0x08019288: f004        fff2 	bl	0x1e270
@   0x0801928c: 4821        ldr	r0, [pc, #132]	@ (0x19314)
@   0x0801928e: 7d03        ldrb	r3, [r0, #20]
@   0x08019290: 009a        lsls	r2, r3, #2
@   0x08019292: 9902        ldr	r1, [sp, #8]
@   0x08019294: 1852        adds	r2, r2, r1
@   0x08019296: 2007        movs	r0, #7
@   0x08019298: 464e        mov	r6, r9
@   0x0801929a: 4030        ands	r0, r6
@   0x0801929c: 4468        add	r0, sp
@   0x0801929e: 2100        movs	r1, #0
@   0x080192a0: 5641        ldrsb	r1, [r0, r1]
@   0x080192a2: 8812        ldrh	r2, [r2, #0]
@   0x080192a4: 1851        adds	r1, r2, r1
@   0x080192a6: 0409        lsls	r1, r1, #16
@   0x080192a8: 1409        asrs	r1, r1, #16
@   0x080192aa: 1c0a        adds	r2, r1, #0
@   0x080192ac: 4650        mov	r0, sl
@   0x080192ae: 4002        ands	r2, r0
@   0x080192b0: 0412        lsls	r2, r2, #16
@   0x080192b2: 481c        ldr	r0, [pc, #112]	@ (0x19324)
@   0x080192b4: 9e03        ldr	r6, [sp, #12]
@   0x080192b6: 4030        ands	r0, r6
@   0x080192b8: 4310        orrs	r0, r2
@   0x080192ba: 9003        str	r0, [sp, #12]
@   0x080192bc: 3910        subs	r1, #16
@   0x080192be: 4650        mov	r0, sl
@   0x080192c0: 4001        ands	r1, r0
@   0x080192c2: 0409        lsls	r1, r1, #16
@   0x080192c4: 4817        ldr	r0, [pc, #92]	@ (0x19324)
@   0x080192c6: 4020        ands	r0, r4
@   0x080192c8: 1c04        adds	r4, r0, #0
@   0x080192ca: 430c        orrs	r4, r1
@   0x080192cc: 00db        lsls	r3, r3, #3
@   0x080192ce: 4912        ldr	r1, [pc, #72]	@ (0x19318)
@   0x080192d0: 185b        adds	r3, r3, r1
@   0x080192d2: 9803        ldr	r0, [sp, #12]
@   0x080192d4: 9904        ldr	r1, [sp, #16]
@   0x080192d6: 6018        str	r0, [r3, #0]
@   0x080192d8: 6059        str	r1, [r3, #4]
@   0x080192da: 4913        ldr	r1, [pc, #76]	@ (0x19328)
@   0x080192dc: 600c        str	r4, [r1, #0]
@   0x080192de: 604d        str	r5, [r1, #4]
@   0x080192e0: 4648        mov	r0, r9
@   0x080192e2: 3001        adds	r0, #1
@   0x080192e4: 0600        lsls	r0, r0, #24
@   0x080192e6: 0e00        lsrs	r0, r0, #24
@   0x080192e8: 4681        mov	r9, r0
@   0x080192ea: 4642        mov	r2, r8
@   0x080192ec: 6810        ldr	r0, [r2, #0]
@   0x080192ee: 6851        ldr	r1, [r2, #4]
@   0x080192f0: 6892        ldr	r2, [r2, #8]
@   0x080192f2: 4646        mov	r6, r8
@   0x080192f4: 68f3        ldr	r3, [r6, #12]
@   0x080192f6: f7ff        f963 	bl	0x185c0
@   0x080192fa: 4648        mov	r0, r9
@   0x080192fc: 280e        cmp	r0, #14
@   0x080192fe: d3c2        bcc.n	0x19286
@   0x08019300: b005        add	sp, #20
@   0x08019302: bc38        pop	{r3, r4, r5}
@   0x08019304: 4698        mov	r8, r3
@   0x08019306: 46a1        mov	r9, r4
@   0x08019308: 46aa        mov	sl, r5
@   0x0801930a: bcf0        pop	{r4, r5, r6, r7}
@   0x0801930c: bc01        pop	{r0}
@   0x0801930e: 4700        bx	r0
@   0x08019310: d92c        bls.n	0x1936c
@   0x08019312: 081b        lsrs	r3, r3, #32
@   0x08019314: 3480        adds	r4, #128	@ 0x80
@   0x08019316: 0300        lsls	r0, r0, #12
@   0x08019318: 54a8        strb	r0, [r5, r2]
@   0x0801931a: 0300        lsls	r0, r0, #12
@   0x0801931c: 01ff        lsls	r7, r7, #7
@   0x0801931e: 0000        movs	r0, r0
@   0x08019320: 8100        strh	r0, [r0, #8]
@   0x08019322: 0830        lsrs	r0, r6, #32
@   0x08019324: ffff        fe00 			@ <UNDEFINED> instruction: 0xfffffe00
@   0x08019328: 54a0        strb	r0, [r4, r2]
@   0x0801932a: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080185C0
sub_080185C0: @ 0x080185c0
        .incbin "frog_us_baserom.gba", 0x185c0, 0xd6c
        thumb_func_end sub_080185C0
