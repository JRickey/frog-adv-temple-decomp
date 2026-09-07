@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801c6fc, 0x0801cd0c)  (1552 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801c6fc --end 0x801cd0c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801c6fc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801c6fe: 4647        mov	r7, r8
@   0x0801c700: b480        push	{r7}
@   0x0801c702: b083        sub	sp, #12
@   0x0801c704: 0600        lsls	r0, r0, #24
@   0x0801c706: 0e03        lsrs	r3, r0, #24
@   0x0801c708: 2280        movs	r2, #128	@ 0x80
@   0x0801c70a: 04d2        lsls	r2, r2, #19
@   0x0801c70c: 8811        ldrh	r1, [r2, #0]
@   0x0801c70e: 480c        ldr	r0, [pc, #48]	@ (0x1c740)
@   0x0801c710: 4008        ands	r0, r1
@   0x0801c712: 8010        strh	r0, [r2, #0]
@   0x0801c714: 8810        ldrh	r0, [r2, #0]
@   0x0801c716: 2580        movs	r5, #128	@ 0x80
@   0x0801c718: 012d        lsls	r5, r5, #4
@   0x0801c71a: 1c29        adds	r1, r5, #0
@   0x0801c71c: 4308        orrs	r0, r1
@   0x0801c71e: 8010        strh	r0, [r2, #0]
@   0x0801c720: 4908        ldr	r1, [pc, #32]	@ (0x1c744)
@   0x0801c722: 4809        ldr	r0, [pc, #36]	@ (0x1c748)
@   0x0801c724: 6008        str	r0, [r1, #0]
@   0x0801c726: 4809        ldr	r0, [pc, #36]	@ (0x1c74c)
@   0x0801c728: 6048        str	r0, [r1, #4]
@   0x0801c72a: 4809        ldr	r0, [pc, #36]	@ (0x1c750)
@   0x0801c72c: 6088        str	r0, [r1, #8]
@   0x0801c72e: 6888        ldr	r0, [r1, #8]
@   0x0801c730: 2200        movs	r2, #0
@   0x0801c732: 2b0f        cmp	r3, #15
@   0x0801c734: d848        bhi.n	0x1c7c8
@   0x0801c736: 0098        lsls	r0, r3, #2
@   0x0801c738: 4906        ldr	r1, [pc, #24]	@ (0x1c754)
@   0x0801c73a: 1840        adds	r0, r0, r1
@   0x0801c73c: 6800        ldr	r0, [r0, #0]
@   0x0801c73e: 4687        mov	pc, r0
@   0x0801c740: dfff        svc	255	@ 0xff
@   0x0801c742: 0000        movs	r0, r0
@   0x0801c744: 00d4        lsls	r4, r2, #3
@   0x0801c746: 0400        lsls	r0, r0, #16
@   0x0801c748: 3774        adds	r7, #116	@ 0x74
@   0x0801c74a: 080e        lsrs	r6, r1, #32
@   0x0801c74c: 01e0        lsls	r0, r4, #7
@   0x0801c74e: 0500        lsls	r0, r0, #20
@   0x0801c750: 0010        movs	r0, r2
@   0x0801c752: 8000        strh	r0, [r0, #0]
@   0x0801c754: c758        stmia	r7!, {r3, r4, r6}
@   0x0801c756: 0801        lsrs	r1, r0, #32
@   0x0801c758: c798        stmia	r7!, {r3, r4, r7}
@   0x0801c75a: 0801        lsrs	r1, r0, #32
@   0x0801c75c: c798        stmia	r7!, {r3, r4, r7}
@   0x0801c75e: 0801        lsrs	r1, r0, #32
@   0x0801c760: c798        stmia	r7!, {r3, r4, r7}
@   0x0801c762: 0801        lsrs	r1, r0, #32
@   0x0801c764: c798        stmia	r7!, {r3, r4, r7}
@   0x0801c766: 0801        lsrs	r1, r0, #32
@   0x0801c768: c7a2        stmia	r7!, {r1, r5, r7}
@   0x0801c76a: 0801        lsrs	r1, r0, #32
@   0x0801c76c: c7a2        stmia	r7!, {r1, r5, r7}
@   0x0801c76e: 0801        lsrs	r1, r0, #32
@   0x0801c770: c7a2        stmia	r7!, {r1, r5, r7}
@   0x0801c772: 0801        lsrs	r1, r0, #32
@   0x0801c774: c7ac        stmia	r7!, {r2, r3, r5, r7}
@   0x0801c776: 0801        lsrs	r1, r0, #32
@   0x0801c778: c7ac        stmia	r7!, {r2, r3, r5, r7}
@   0x0801c77a: 0801        lsrs	r1, r0, #32
@   0x0801c77c: c7ac        stmia	r7!, {r2, r3, r5, r7}
@   0x0801c77e: 0801        lsrs	r1, r0, #32
@   0x0801c780: c7b6        stmia	r7!, {r1, r2, r4, r5, r7}
@   0x0801c782: 0801        lsrs	r1, r0, #32
@   0x0801c784: c7b6        stmia	r7!, {r1, r2, r4, r5, r7}
@   0x0801c786: 0801        lsrs	r1, r0, #32
@   0x0801c788: c7b6        stmia	r7!, {r1, r2, r4, r5, r7}
@   0x0801c78a: 0801        lsrs	r1, r0, #32
@   0x0801c78c: c7c0        stmia	r7!, {r6, r7}
@   0x0801c78e: 0801        lsrs	r1, r0, #32
@   0x0801c790: c7c0        stmia	r7!, {r6, r7}
@   0x0801c792: 0801        lsrs	r1, r0, #32
@   0x0801c794: c7c0        stmia	r7!, {r6, r7}
@   0x0801c796: 0801        lsrs	r1, r0, #32
@   0x0801c798: 2001        movs	r0, #1
@   0x0801c79a: 4684        mov	ip, r0
@   0x0801c79c: 2701        movs	r7, #1
@   0x0801c79e: 2200        movs	r2, #0
@   0x0801c7a0: e012        b.n	0x1c7c8
@   0x0801c7a2: 210a        movs	r1, #10
@   0x0801c7a4: 468c        mov	ip, r1
@   0x0801c7a6: 2710        movs	r7, #16
@   0x0801c7a8: 2201        movs	r2, #1
@   0x0801c7aa: e00d        b.n	0x1c7c8
@   0x0801c7ac: 220a        movs	r2, #10
@   0x0801c7ae: 4694        mov	ip, r2
@   0x0801c7b0: 2710        movs	r7, #16
@   0x0801c7b2: 2202        movs	r2, #2
@   0x0801c7b4: e008        b.n	0x1c7c8
@   0x0801c7b6: 230a        movs	r3, #10
@   0x0801c7b8: 469c        mov	ip, r3
@   0x0801c7ba: 2701        movs	r7, #1
@   0x0801c7bc: 2203        movs	r2, #3
@   0x0801c7be: e003        b.n	0x1c7c8
@   0x0801c7c0: 2501        movs	r5, #1
@   0x0801c7c2: 46ac        mov	ip, r5
@   0x0801c7c4: 2701        movs	r7, #1
@   0x0801c7c6: 2204        movs	r2, #4
@   0x0801c7c8: 4911        ldr	r1, [pc, #68]	@ (0x1c810)
@   0x0801c7ca: 4812        ldr	r0, [pc, #72]	@ (0x1c814)
@   0x0801c7cc: 6800        ldr	r0, [r0, #0]
@   0x0801c7ce: 0080        lsls	r0, r0, #2
@   0x0801c7d0: 1840        adds	r0, r0, r1
@   0x0801c7d2: 6801        ldr	r1, [r0, #0]
@   0x0801c7d4: 0090        lsls	r0, r2, #2
@   0x0801c7d6: 1840        adds	r0, r0, r1
@   0x0801c7d8: 6803        ldr	r3, [r0, #0]
@   0x0801c7da: 2601        movs	r6, #1
@   0x0801c7dc: 2100        movs	r1, #0
@   0x0801c7de: 2200        movs	r2, #0
@   0x0801c7e0: 2500        movs	r5, #0
@   0x0801c7e2: 0238        lsls	r0, r7, #8
@   0x0801c7e4: 4680        mov	r8, r0
@   0x0801c7e6: 7818        ldrb	r0, [r3, #0]
@   0x0801c7e8: 287c        cmp	r0, #124	@ 0x7c
@   0x0801c7ea: d021        beq.n	0x1c830
@   0x0801c7ec: 1c50        adds	r0, r2, #1
@   0x0801c7ee: 0600        lsls	r0, r0, #24
@   0x0801c7f0: 0e02        lsrs	r2, r0, #24
@   0x0801c7f2: 1c28        adds	r0, r5, #0
@   0x0801c7f4: 4295        cmp	r5, r2
@   0x0801c7f6: d200        bcs.n	0x1c7fa
@   0x0801c7f8: 1c10        adds	r0, r2, #0
@   0x0801c7fa: 1c05        adds	r5, r0, #0
@   0x0801c7fc: 1858        adds	r0, r3, r1
@   0x0801c7fe: 7800        ldrb	r0, [r0, #0]
@   0x0801c800: 280a        cmp	r0, #10
@   0x0801c802: d109        bne.n	0x1c818
@   0x0801c804: 1c70        adds	r0, r6, #1
@   0x0801c806: 0600        lsls	r0, r0, #24
@   0x0801c808: 0e06        lsrs	r6, r0, #24
@   0x0801c80a: 2200        movs	r2, #0
@   0x0801c80c: e009        b.n	0x1c822
@   0x0801c80e: 0000        movs	r0, r0
@   0x0801c810: 873c        strh	r4, [r7, #56]	@ 0x38
@   0x0801c812: 0830        lsrs	r0, r6, #32
@   0x0801c814: 34b0        adds	r4, #176	@ 0xb0
@   0x0801c816: 0300        lsls	r0, r0, #12
@   0x0801c818: 285b        cmp	r0, #91	@ 0x5b
@   0x0801c81a: d102        bne.n	0x1c822
@   0x0801c81c: 1d08        adds	r0, r1, #4
@   0x0801c81e: 0600        lsls	r0, r0, #24
@   0x0801c820: 0e01        lsrs	r1, r0, #24
@   0x0801c822: 1c48        adds	r0, r1, #1
@   0x0801c824: 0600        lsls	r0, r0, #24
@   0x0801c826: 0e01        lsrs	r1, r0, #24
@   0x0801c828: 1858        adds	r0, r3, r1
@   0x0801c82a: 7800        ldrb	r0, [r0, #0]
@   0x0801c82c: 287c        cmp	r0, #124	@ 0x7c
@   0x0801c82e: d1dd        bne.n	0x1c7ec
@   0x0801c830: 4829        ldr	r0, [pc, #164]	@ (0x1c8d8)
@   0x0801c832: 4004        ands	r4, r0
@   0x0801c834: 4661        mov	r1, ip
@   0x0801c836: 430c        orrs	r4, r1
@   0x0801c838: 4828        ldr	r0, [pc, #160]	@ (0x1c8dc)
@   0x0801c83a: 4004        ands	r4, r0
@   0x0801c83c: 4642        mov	r2, r8
@   0x0801c83e: 4314        orrs	r4, r2
@   0x0801c840: 0670        lsls	r0, r6, #25
@   0x0801c842: 2180        movs	r1, #128	@ 0x80
@   0x0801c844: 0489        lsls	r1, r1, #18
@   0x0801c846: 1840        adds	r0, r0, r1
@   0x0801c848: 4925        ldr	r1, [pc, #148]	@ (0x1c8e0)
@   0x0801c84a: 400c        ands	r4, r1
@   0x0801c84c: 4304        orrs	r4, r0
@   0x0801c84e: 9500        str	r5, [sp, #0]
@   0x0801c850: 2000        movs	r0, #0
@   0x0801c852: 9001        str	r0, [sp, #4]
@   0x0801c854: 2006        movs	r0, #6
@   0x0801c856: 9002        str	r0, [sp, #8]
@   0x0801c858: 4660        mov	r0, ip
@   0x0801c85a: 1c39        adds	r1, r7, #0
@   0x0801c85c: 1c1a        adds	r2, r3, #0
@   0x0801c85e: 1c33        adds	r3, r6, #0
@   0x0801c860: f000        fa54 	bl	0x1cd0c
@   0x0801c864: 1ca8        adds	r0, r5, #2
@   0x0801c866: 0600        lsls	r0, r0, #24
@   0x0801c868: 0a00        lsrs	r0, r0, #8
@   0x0801c86a: 491e        ldr	r1, [pc, #120]	@ (0x1c8e4)
@   0x0801c86c: 400c        ands	r4, r1
@   0x0801c86e: 4304        orrs	r4, r0
@   0x0801c870: 491d        ldr	r1, [pc, #116]	@ (0x1c8e8)
@   0x0801c872: 4a1e        ldr	r2, [pc, #120]	@ (0x1c8ec)
@   0x0801c874: 1c10        adds	r0, r2, #0
@   0x0801c876: 8008        strh	r0, [r1, #0]
@   0x0801c878: 4a1d        ldr	r2, [pc, #116]	@ (0x1c8f0)
@   0x0801c87a: 4b1e        ldr	r3, [pc, #120]	@ (0x1c8f4)
@   0x0801c87c: 1c18        adds	r0, r3, #0
@   0x0801c87e: 8010        strh	r0, [r2, #0]
@   0x0801c880: 8810        ldrh	r0, [r2, #0]
@   0x0801c882: 213f        movs	r1, #63	@ 0x3f
@   0x0801c884: 4308        orrs	r0, r1
@   0x0801c886: 8010        strh	r0, [r2, #0]
@   0x0801c888: 8811        ldrh	r1, [r2, #0]
@   0x0801c88a: 481b        ldr	r0, [pc, #108]	@ (0x1c8f8)
@   0x0801c88c: 4008        ands	r0, r1
@   0x0801c88e: 8010        strh	r0, [r2, #0]
@   0x0801c890: 4b1a        ldr	r3, [pc, #104]	@ (0x1c8fc)
@   0x0801c892: 0621        lsls	r1, r4, #24
@   0x0801c894: 0e09        lsrs	r1, r1, #24
@   0x0801c896: 02ca        lsls	r2, r1, #11
@   0x0801c898: 0c20        lsrs	r0, r4, #16
@   0x0801c89a: 0600        lsls	r0, r0, #24
@   0x0801c89c: 0e00        lsrs	r0, r0, #24
@   0x0801c89e: 1809        adds	r1, r1, r0
@   0x0801c8a0: 00c9        lsls	r1, r1, #3
@   0x0801c8a2: 430a        orrs	r2, r1
@   0x0801c8a4: 801a        strh	r2, [r3, #0]
@   0x0801c8a6: 3304        adds	r3, #4
@   0x0801c8a8: 0420        lsls	r0, r4, #16
@   0x0801c8aa: 0e02        lsrs	r2, r0, #24
@   0x0801c8ac: 02d2        lsls	r2, r2, #11
@   0x0801c8ae: 0e00        lsrs	r0, r0, #24
@   0x0801c8b0: 0e21        lsrs	r1, r4, #24
@   0x0801c8b2: 1840        adds	r0, r0, r1
@   0x0801c8b4: 00c0        lsls	r0, r0, #3
@   0x0801c8b6: 4302        orrs	r2, r0
@   0x0801c8b8: 801a        strh	r2, [r3, #0]
@   0x0801c8ba: 2280        movs	r2, #128	@ 0x80
@   0x0801c8bc: 04d2        lsls	r2, r2, #19
@   0x0801c8be: 8810        ldrh	r0, [r2, #0]
@   0x0801c8c0: 2580        movs	r5, #128	@ 0x80
@   0x0801c8c2: 01ad        lsls	r5, r5, #6
@   0x0801c8c4: 1c29        adds	r1, r5, #0
@   0x0801c8c6: 4308        orrs	r0, r1
@   0x0801c8c8: 8010        strh	r0, [r2, #0]
@   0x0801c8ca: b003        add	sp, #12
@   0x0801c8cc: bc08        pop	{r3}
@   0x0801c8ce: 4698        mov	r8, r3
@   0x0801c8d0: bcf0        pop	{r4, r5, r6, r7}
@   0x0801c8d2: bc01        pop	{r0}
@   0x0801c8d4: 4700        bx	r0
@   0x0801c8d6: 0000        movs	r0, r0
@   0x0801c8d8: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0801c8dc: 00ff        lsls	r7, r7, #3
@   0x0801c8de: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0801c8e2: 00ff        lsls	r7, r7, #3
@   0x0801c8e4: ffff        ff00 			@ <UNDEFINED> instruction: 0xffffff00
@   0x0801c8e8: 0048        lsls	r0, r1, #1
@   0x0801c8ea: 0400        lsls	r0, r0, #16
@   0x0801c8ec: 0808        lsrs	r0, r1, #32
@   0x0801c8ee: 0000        movs	r0, r0
@   0x0801c8f0: 004a        lsls	r2, r1, #1
@   0x0801c8f2: 0400        lsls	r0, r0, #16
@   0x0801c8f4: 3f3f        subs	r7, #63	@ 0x3f
@   0x0801c8f6: 0000        movs	r0, r0
@   0x0801c8f8: fff7        0000 	vcvta.s16.f16	d16, d0
@   0x0801c8fc: 0040        lsls	r0, r0, #1
@   0x0801c8fe: 0400        lsls	r0, r0, #16
@   0x0801c900: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801c902: 4657        mov	r7, sl
@   0x0801c904: 464e        mov	r6, r9
@   0x0801c906: 4645        mov	r5, r8
@   0x0801c908: b4e0        push	{r5, r6, r7}
@   0x0801c90a: b09b        sub	sp, #108	@ 0x6c
@   0x0801c90c: 4692        mov	sl, r2
@   0x0801c90e: 9a23        ldr	r2, [sp, #140]	@ 0x8c
@   0x0801c910: 9c24        ldr	r4, [sp, #144]	@ 0x90
@   0x0801c912: 0600        lsls	r0, r0, #24
@   0x0801c914: 0e00        lsrs	r0, r0, #24
@   0x0801c916: 9014        str	r0, [sp, #80]	@ 0x50
@   0x0801c918: 0609        lsls	r1, r1, #24
@   0x0801c91a: 0e09        lsrs	r1, r1, #24
@   0x0801c91c: 9115        str	r1, [sp, #84]	@ 0x54
@   0x0801c91e: 061b        lsls	r3, r3, #24
@   0x0801c920: 0e1b        lsrs	r3, r3, #24
@   0x0801c922: 4699        mov	r9, r3
@   0x0801c924: 0412        lsls	r2, r2, #16
@   0x0801c926: 0c12        lsrs	r2, r2, #16
@   0x0801c928: 4694        mov	ip, r2
@   0x0801c92a: 0624        lsls	r4, r4, #24
@   0x0801c92c: 0e24        lsrs	r4, r4, #24
@   0x0801c92e: 9416        str	r4, [sp, #88]	@ 0x58
@   0x0801c930: 20a0        movs	r0, #160	@ 0xa0
@   0x0801c932: 04c0        lsls	r0, r0, #19
@   0x0801c934: 8800        ldrh	r0, [r0, #0]
@   0x0801c936: 9018        str	r0, [sp, #96]	@ 0x60
@   0x0801c938: 4668        mov	r0, sp
@   0x0801c93a: 304c        adds	r0, #76	@ 0x4c
@   0x0801c93c: 901a        str	r0, [sp, #104]	@ 0x68
@   0x0801c93e: 2280        movs	r2, #128	@ 0x80
@   0x0801c940: 04d2        lsls	r2, r2, #19
@   0x0801c942: 8810        ldrh	r0, [r2, #0]
@   0x0801c944: 991a        ldr	r1, [sp, #104]	@ 0x68
@   0x0801c946: 8008        strh	r0, [r1, #0]
@   0x0801c948: 466d        mov	r5, sp
@   0x0801c94a: 354e        adds	r5, #78	@ 0x4e
@   0x0801c94c: 4b3b        ldr	r3, [pc, #236]	@ (0x1ca3c)
@   0x0801c94e: 8818        ldrh	r0, [r3, #0]
@   0x0801c950: 8028        strh	r0, [r5, #0]
@   0x0801c952: 493b        ldr	r1, [pc, #236]	@ (0x1ca40)
@   0x0801c954: 2000        movs	r0, #0
@   0x0801c956: 8188        strh	r0, [r1, #12]
@   0x0801c958: 81c8        strh	r0, [r1, #14]
@   0x0801c95a: 8810        ldrh	r0, [r2, #0]
@   0x0801c95c: 2480        movs	r4, #128	@ 0x80
@   0x0801c95e: 0124        lsls	r4, r4, #4
@   0x0801c960: 1c21        adds	r1, r4, #0
@   0x0801c962: 4308        orrs	r0, r1
@   0x0801c964: 8010        strh	r0, [r2, #0]
@   0x0801c966: 4e37        ldr	r6, [pc, #220]	@ (0x1ca44)
@   0x0801c968: 1c30        adds	r0, r6, #0
@   0x0801c96a: 8018        strh	r0, [r3, #0]
@   0x0801c96c: 4936        ldr	r1, [pc, #216]	@ (0x1ca48)
@   0x0801c96e: 4a37        ldr	r2, [pc, #220]	@ (0x1ca4c)
@   0x0801c970: 1c10        adds	r0, r2, #0
@   0x0801c972: 8008        strh	r0, [r1, #0]
@   0x0801c974: 4a36        ldr	r2, [pc, #216]	@ (0x1ca50)
@   0x0801c976: 4b37        ldr	r3, [pc, #220]	@ (0x1ca54)
@   0x0801c978: 1c18        adds	r0, r3, #0
@   0x0801c97a: 8010        strh	r0, [r2, #0]
@   0x0801c97c: 8810        ldrh	r0, [r2, #0]
@   0x0801c97e: 4c36        ldr	r4, [pc, #216]	@ (0x1ca58)
@   0x0801c980: 1c21        adds	r1, r4, #0
@   0x0801c982: 4308        orrs	r0, r1
@   0x0801c984: 8010        strh	r0, [r2, #0]
@   0x0801c986: 4a35        ldr	r2, [pc, #212]	@ (0x1ca5c)
@   0x0801c988: 4835        ldr	r0, [pc, #212]	@ (0x1ca60)
@   0x0801c98a: 6801        ldr	r1, [r0, #0]
@   0x0801c98c: 0048        lsls	r0, r1, #1
@   0x0801c98e: 1840        adds	r0, r0, r1
@   0x0801c990: 00c0        lsls	r0, r0, #3
@   0x0801c992: 3204        adds	r2, #4
@   0x0801c994: 1880        adds	r0, r0, r2
@   0x0801c996: 6801        ldr	r1, [r0, #0]
@   0x0801c998: 4832        ldr	r0, [pc, #200]	@ (0x1ca64)
@   0x0801c99a: 6001        str	r1, [r0, #0]
@   0x0801c99c: 4932        ldr	r1, [pc, #200]	@ (0x1ca68)
@   0x0801c99e: 6041        str	r1, [r0, #4]
@   0x0801c9a0: 4932        ldr	r1, [pc, #200]	@ (0x1ca6c)
@   0x0801c9a2: 6081        str	r1, [r0, #8]
@   0x0801c9a4: 6881        ldr	r1, [r0, #8]
@   0x0801c9a6: 4b32        ldr	r3, [pc, #200]	@ (0x1ca70)
@   0x0801c9a8: 6003        str	r3, [r0, #0]
@   0x0801c9aa: ae03        add	r6, sp, #12
@   0x0801c9ac: 6046        str	r6, [r0, #4]
@   0x0801c9ae: 4a31        ldr	r2, [pc, #196]	@ (0x1ca74)
@   0x0801c9b0: 6082        str	r2, [r0, #8]
@   0x0801c9b2: 6881        ldr	r1, [r0, #8]
@   0x0801c9b4: 4930        ldr	r1, [pc, #192]	@ (0x1ca78)
@   0x0801c9b6: 6001        str	r1, [r0, #0]
@   0x0801c9b8: 6043        str	r3, [r0, #4]
@   0x0801c9ba: 6082        str	r2, [r0, #8]
@   0x0801c9bc: 6883        ldr	r3, [r0, #8]
@   0x0801c9be: 4b2f        ldr	r3, [pc, #188]	@ (0x1ca7c)
@   0x0801c9c0: 6003        str	r3, [r0, #0]
@   0x0801c9c2: ac0b        add	r4, sp, #44	@ 0x2c
@   0x0801c9c4: 6044        str	r4, [r0, #4]
@   0x0801c9c6: 6082        str	r2, [r0, #8]
@   0x0801c9c8: 6886        ldr	r6, [r0, #8]
@   0x0801c9ca: 3120        adds	r1, #32
@   0x0801c9cc: 6001        str	r1, [r0, #0]
@   0x0801c9ce: 6043        str	r3, [r0, #4]
@   0x0801c9d0: 6082        str	r2, [r0, #8]
@   0x0801c9d2: 6880        ldr	r0, [r0, #8]
@   0x0801c9d4: 4648        mov	r0, r9
@   0x0801c9d6: 4649        mov	r1, r9
@   0x0801c9d8: 2907        cmp	r1, #7
@   0x0801c9da: d800        bhi.n	0x1c9de
@   0x0801c9dc: 2008        movs	r0, #8
@   0x0801c9de: 4681        mov	r9, r0
@   0x0801c9e0: 2401        movs	r4, #1
@   0x0801c9e2: 2100        movs	r1, #0
@   0x0801c9e4: 9b15        ldr	r3, [sp, #84]	@ 0x54
@   0x0801c9e6: 021a        lsls	r2, r3, #8
@   0x0801c9e8: 4656        mov	r6, sl
@   0x0801c9ea: 7836        ldrb	r6, [r6, #0]
@   0x0801c9ec: 2e7c        cmp	r6, #124	@ 0x7c
@   0x0801c9ee: d00f        beq.n	0x1ca10
@   0x0801c9f0: 4653        mov	r3, sl
@   0x0801c9f2: 1858        adds	r0, r3, r1
@   0x0801c9f4: 7800        ldrb	r0, [r0, #0]
@   0x0801c9f6: 280a        cmp	r0, #10
@   0x0801c9f8: d102        bne.n	0x1ca00
@   0x0801c9fa: 1c60        adds	r0, r4, #1
@   0x0801c9fc: 0600        lsls	r0, r0, #24
@   0x0801c9fe: 0e04        lsrs	r4, r0, #24
@   0x0801ca00: 1c48        adds	r0, r1, #1
@   0x0801ca02: 0600        lsls	r0, r0, #24
@   0x0801ca04: 0e01        lsrs	r1, r0, #24
@   0x0801ca06: 4656        mov	r6, sl
@   0x0801ca08: 1870        adds	r0, r6, r1
@   0x0801ca0a: 7800        ldrb	r0, [r0, #0]
@   0x0801ca0c: 287c        cmp	r0, #124	@ 0x7c
@   0x0801ca0e: d1ef        bne.n	0x1c9f0
@   0x0801ca10: 2000        movs	r0, #0
@   0x0801ca12: 9017        str	r0, [sp, #92]	@ 0x5c
@   0x0801ca14: 481a        ldr	r0, [pc, #104]	@ (0x1ca80)
@   0x0801ca16: 4007        ands	r7, r0
@   0x0801ca18: 9914        ldr	r1, [sp, #80]	@ 0x50
@   0x0801ca1a: 430f        orrs	r7, r1
@   0x0801ca1c: 4819        ldr	r0, [pc, #100]	@ (0x1ca84)
@   0x0801ca1e: 4007        ands	r7, r0
@   0x0801ca20: 4317        orrs	r7, r2
@   0x0801ca22: 4648        mov	r0, r9
@   0x0801ca24: 3002        adds	r0, #2
@   0x0801ca26: 0600        lsls	r0, r0, #24
@   0x0801ca28: 0a00        lsrs	r0, r0, #8
@   0x0801ca2a: 4917        ldr	r1, [pc, #92]	@ (0x1ca88)
@   0x0801ca2c: 400f        ands	r7, r1
@   0x0801ca2e: 4307        orrs	r7, r0
@   0x0801ca30: 9a16        ldr	r2, [sp, #88]	@ 0x58
@   0x0801ca32: 2a00        cmp	r2, #0
@   0x0801ca34: d12a        bne.n	0x1ca8c
@   0x0801ca36: 0060        lsls	r0, r4, #1
@   0x0801ca38: 1d01        adds	r1, r0, #4
@   0x0801ca3a: e029        b.n	0x1ca90
@   0x0801ca3c: 000e        movs	r6, r1
@   0x0801ca3e: 0400        lsls	r0, r0, #16
@   0x0801ca40: 3550        adds	r5, #80	@ 0x50
@   0x0801ca42: 0300        lsls	r0, r0, #12
@   0x0801ca44: 1f08        subs	r0, r1, #4
@   0x0801ca46: 0000        movs	r0, r0
@   0x0801ca48: 0048        lsls	r0, r1, #1
@   0x0801ca4a: 0400        lsls	r0, r0, #16
@   0x0801ca4c: 0808        lsrs	r0, r1, #32
@   0x0801ca4e: 0000        movs	r0, r0
@   0x0801ca50: 004a        lsls	r2, r1, #1
@   0x0801ca52: 0400        lsls	r0, r0, #16
@   0x0801ca54: 3f3f        subs	r7, #63	@ 0x3f
@   0x0801ca56: 0000        movs	r0, r0
@   0x0801ca58: fff7        0000 	vcvta.s16.f16	d16, d0
@   0x0801ca5c: 1254        asrs	r4, r2, #9
@   0x0801ca5e: 080c        lsrs	r4, r1, #32
@   0x0801ca60: 34b0        adds	r4, #176	@ 0xb0
@   0x0801ca62: 0300        lsls	r0, r0, #12
@   0x0801ca64: 00d4        lsls	r4, r2, #3
@   0x0801ca66: 0400        lsls	r0, r0, #16
@   0x0801ca68: 8000        strh	r0, [r0, #0]
@   0x0801ca6a: 0600        lsls	r0, r0, #24
@   0x0801ca6c: 2000        movs	r0, #0
@   0x0801ca6e: 8000        strh	r0, [r0, #0]
@   0x0801ca70: 01c0        lsls	r0, r0, #7
@   0x0801ca72: 0500        lsls	r0, r0, #20
@   0x0801ca74: 0010        movs	r0, r2
@   0x0801ca76: 8000        strh	r0, [r0, #0]
@   0x0801ca78: 3774        adds	r7, #116	@ 0x74
@   0x0801ca7a: 080e        lsrs	r6, r1, #32
@   0x0801ca7c: 01e0        lsls	r0, r4, #7
@   0x0801ca7e: 0500        lsls	r0, r0, #20
@   0x0801ca80: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0801ca84: 00ff        lsls	r7, r7, #3
@   0x0801ca86: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0801ca8a: ff00        0060 	vhadd.u8	q0, q0, q8
@   0x0801ca8e: 1c81        adds	r1, r0, #2
@   0x0801ca90: 9019        str	r0, [sp, #100]	@ 0x64
@   0x0801ca92: 0609        lsls	r1, r1, #24
@   0x0801ca94: 482c        ldr	r0, [pc, #176]	@ (0x1cb48)
@   0x0801ca96: 4007        ands	r7, r0
@   0x0801ca98: 430f        orrs	r7, r1
@   0x0801ca9a: 4a2c        ldr	r2, [pc, #176]	@ (0x1cb4c)
@   0x0801ca9c: 0638        lsls	r0, r7, #24
@   0x0801ca9e: 0e00        lsrs	r0, r0, #24
@   0x0801caa0: 02c1        lsls	r1, r0, #11
@   0x0801caa2: 4448        add	r0, r9
@   0x0801caa4: 3002        adds	r0, #2
@   0x0801caa6: 00c0        lsls	r0, r0, #3
@   0x0801caa8: 4301        orrs	r1, r0
@   0x0801caaa: 8011        strh	r1, [r2, #0]
@   0x0801caac: 4b28        ldr	r3, [pc, #160]	@ (0x1cb50)
@   0x0801caae: 0438        lsls	r0, r7, #16
@   0x0801cab0: 0e02        lsrs	r2, r0, #24
@   0x0801cab2: 02d2        lsls	r2, r2, #11
@   0x0801cab4: 0e00        lsrs	r0, r0, #24
@   0x0801cab6: 0e39        lsrs	r1, r7, #24
@   0x0801cab8: 1840        adds	r0, r0, r1
@   0x0801caba: 00c0        lsls	r0, r0, #3
@   0x0801cabc: 4302        orrs	r2, r0
@   0x0801cabe: 801a        strh	r2, [r3, #0]
@   0x0801cac0: 2280        movs	r2, #128	@ 0x80
@   0x0801cac2: 04d2        lsls	r2, r2, #19
@   0x0801cac4: 8810        ldrh	r0, [r2, #0]
@   0x0801cac6: 2380        movs	r3, #128	@ 0x80
@   0x0801cac8: 019b        lsls	r3, r3, #6
@   0x0801caca: 1c19        adds	r1, r3, #0
@   0x0801cacc: 4308        orrs	r0, r1
@   0x0801cace: 8010        strh	r0, [r2, #0]
@   0x0801cad0: 9e16        ldr	r6, [sp, #88]	@ 0x58
@   0x0801cad2: 2e00        cmp	r6, #0
@   0x0801cad4: d142        bne.n	0x1cb5c
@   0x0801cad6: 1c63        adds	r3, r4, #1
@   0x0801cad8: 061b        lsls	r3, r3, #24
@   0x0801cada: 0e1b        lsrs	r3, r3, #24
@   0x0801cadc: 4648        mov	r0, r9
@   0x0801cade: 9000        str	r0, [sp, #0]
@   0x0801cae0: 4661        mov	r1, ip
@   0x0801cae2: 9101        str	r1, [sp, #4]
@   0x0801cae4: 2006        movs	r0, #6
@   0x0801cae6: 9002        str	r0, [sp, #8]
@   0x0801cae8: 9814        ldr	r0, [sp, #80]	@ 0x50
@   0x0801caea: 9915        ldr	r1, [sp, #84]	@ 0x54
@   0x0801caec: 4652        mov	r2, sl
@   0x0801caee: f000        f90d 	bl	0x1cd0c
@   0x0801caf2: 4818        ldr	r0, [pc, #96]	@ (0x1cb54)
@   0x0801caf4: 464c        mov	r4, r9
@   0x0801caf6: 3c06        subs	r4, #6
@   0x0801caf8: 0fe1        lsrs	r1, r4, #31
@   0x0801cafa: 1864        adds	r4, r4, r1
@   0x0801cafc: 1064        asrs	r4, r4, #1
@   0x0801cafe: 9a14        ldr	r2, [sp, #80]	@ 0x50
@   0x0801cb00: 1914        adds	r4, r2, r4
@   0x0801cb02: 0622        lsls	r2, r4, #24
@   0x0801cb04: 0e12        lsrs	r2, r2, #24
@   0x0801cb06: 9b15        ldr	r3, [sp, #84]	@ 0x54
@   0x0801cb08: 9e19        ldr	r6, [sp, #100]	@ 0x64
@   0x0801cb0a: 199d        adds	r5, r3, r6
@   0x0801cb0c: 3501        adds	r5, #1
@   0x0801cb0e: 062d        lsls	r5, r5, #24
@   0x0801cb10: 0e2d        lsrs	r5, r5, #24
@   0x0801cb12: 218b        movs	r1, #139	@ 0x8b
@   0x0801cb14: 0049        lsls	r1, r1, #1
@   0x0801cb16: 4688        mov	r8, r1
@   0x0801cb18: 9100        str	r1, [sp, #0]
@   0x0801cb1a: 2105        movs	r1, #5
@   0x0801cb1c: 9101        str	r1, [sp, #4]
@   0x0801cb1e: 2603        movs	r6, #3
@   0x0801cb20: 9602        str	r6, [sp, #8]
@   0x0801cb22: 2103        movs	r1, #3
@   0x0801cb24: 1c2b        adds	r3, r5, #0
@   0x0801cb26: f7ff        f9a9 	bl	0x1be7c
@   0x0801cb2a: 480b        ldr	r0, [pc, #44]	@ (0x1cb58)
@   0x0801cb2c: 3404        adds	r4, #4
@   0x0801cb2e: 0624        lsls	r4, r4, #24
@   0x0801cb30: 0e24        lsrs	r4, r4, #24
@   0x0801cb32: 4642        mov	r2, r8
@   0x0801cb34: 9200        str	r2, [sp, #0]
@   0x0801cb36: 2104        movs	r1, #4
@   0x0801cb38: 9101        str	r1, [sp, #4]
@   0x0801cb3a: 9602        str	r6, [sp, #8]
@   0x0801cb3c: 2102        movs	r1, #2
@   0x0801cb3e: 1c22        adds	r2, r4, #0
@   0x0801cb40: 1c2b        adds	r3, r5, #0
@   0x0801cb42: f7ff        f99b 	bl	0x1be7c
@   0x0801cb46: e015        b.n	0x1cb74
@   0x0801cb48: ffff        00ff 	vshr.u64	q8, <illegal reg q15.5>, #1
@   0x0801cb4c: 0040        lsls	r0, r0, #1
@   0x0801cb4e: 0400        lsls	r0, r0, #16
@   0x0801cb50: 0044        lsls	r4, r0, #1
@   0x0801cb52: 0400        lsls	r0, r0, #16
@   0x0801cb54: e04c        b.n	0x1cbf0
@   0x0801cb56: 081b        lsrs	r3, r3, #32
@   0x0801cb58: e050        b.n	0x1cbfc
@   0x0801cb5a: 081b        lsrs	r3, r3, #32
@   0x0801cb5c: 464b        mov	r3, r9
@   0x0801cb5e: 9300        str	r3, [sp, #0]
@   0x0801cb60: 4666        mov	r6, ip
@   0x0801cb62: 9601        str	r6, [sp, #4]
@   0x0801cb64: 2006        movs	r0, #6
@   0x0801cb66: 9002        str	r0, [sp, #8]
@   0x0801cb68: 9814        ldr	r0, [sp, #80]	@ 0x50
@   0x0801cb6a: 9915        ldr	r1, [sp, #84]	@ 0x54
@   0x0801cb6c: 4652        mov	r2, sl
@   0x0801cb6e: 1c23        adds	r3, r4, #0
@   0x0801cb70: f000        f8cc 	bl	0x1cd0c
@   0x0801cb74: 9816        ldr	r0, [sp, #88]	@ 0x58
@   0x0801cb76: 2800        cmp	r0, #0
@   0x0801cb78: d17a        bne.n	0x1cc70
@   0x0801cb7a: 4812        ldr	r0, [pc, #72]	@ (0x1cbc4)
@   0x0801cb7c: a916        add	r1, sp, #88	@ 0x58
@   0x0801cb7e: 8809        ldrh	r1, [r1, #0]
@   0x0801cb80: 8001        strh	r1, [r0, #0]
@   0x0801cb82: 4680        mov	r8, r0
@   0x0801cb84: 4648        mov	r0, r9
@   0x0801cb86: 3806        subs	r0, #6
@   0x0801cb88: 0fc1        lsrs	r1, r0, #31
@   0x0801cb8a: 1840        adds	r0, r0, r1
@   0x0801cb8c: 1040        asrs	r0, r0, #1
@   0x0801cb8e: 9a14        ldr	r2, [sp, #80]	@ 0x50
@   0x0801cb90: 1810        adds	r0, r2, r0
@   0x0801cb92: 1d01        adds	r1, r0, #4
@   0x0801cb94: 0609        lsls	r1, r1, #24
@   0x0801cb96: 468a        mov	sl, r1
@   0x0801cb98: 0600        lsls	r0, r0, #24
@   0x0801cb9a: 4681        mov	r9, r0
@   0x0801cb9c: 9b15        ldr	r3, [sp, #84]	@ 0x54
@   0x0801cb9e: 9c19        ldr	r4, [sp, #100]	@ 0x64
@   0x0801cba0: 1918        adds	r0, r3, r4
@   0x0801cba2: 3001        adds	r0, #1
@   0x0801cba4: 0600        lsls	r0, r0, #24
@   0x0801cba6: 0e06        lsrs	r6, r0, #24
@   0x0801cba8: 2005        movs	r0, #5
@   0x0801cbaa: f001        fb61 	bl	0x1e270
@   0x0801cbae: f7e3        fc89 	bl	0x4c4
@   0x0801cbb2: 4641        mov	r1, r8
@   0x0801cbb4: 8008        strh	r0, [r1, #0]
@   0x0801cbb6: 880d        ldrh	r5, [r1, #0]
@   0x0801cbb8: 2d04        cmp	r5, #4
@   0x0801cbba: d005        beq.n	0x1cbc8
@   0x0801cbbc: 2d08        cmp	r5, #8
@   0x0801cbbe: d029        beq.n	0x1cc14
@   0x0801cbc0: e04a        b.n	0x1cc58
@   0x0801cbc2: 0000        movs	r0, r0
@   0x0801cbc4: 5398        strh	r0, [r3, r6]
@   0x0801cbc6: 0300        lsls	r0, r0, #12
@   0x0801cbc8: 2002        movs	r0, #2
@   0x0801cbca: f004        f855 	bl	0x20c78
@   0x0801cbce: 2201        movs	r2, #1
@   0x0801cbd0: 9217        str	r2, [sp, #92]	@ 0x5c
@   0x0801cbd2: 248b        movs	r4, #139	@ 0x8b
@   0x0801cbd4: 0064        lsls	r4, r4, #1
@   0x0801cbd6: 9400        str	r4, [sp, #0]
@   0x0801cbd8: 9501        str	r5, [sp, #4]
@   0x0801cbda: 2503        movs	r5, #3
@   0x0801cbdc: 9502        str	r5, [sp, #8]
@   0x0801cbde: 480b        ldr	r0, [pc, #44]	@ (0x1cc0c)
@   0x0801cbe0: 2103        movs	r1, #3
@   0x0801cbe2: 464b        mov	r3, r9
@   0x0801cbe4: 0e1a        lsrs	r2, r3, #24
@   0x0801cbe6: 1c33        adds	r3, r6, #0
@   0x0801cbe8: f7ff        f948 	bl	0x1be7c
@   0x0801cbec: 9400        str	r4, [sp, #0]
@   0x0801cbee: 2005        movs	r0, #5
@   0x0801cbf0: 9001        str	r0, [sp, #4]
@   0x0801cbf2: 9502        str	r5, [sp, #8]
@   0x0801cbf4: 4806        ldr	r0, [pc, #24]	@ (0x1cc10)
@   0x0801cbf6: 2102        movs	r1, #2
@   0x0801cbf8: 4654        mov	r4, sl
@   0x0801cbfa: 0e22        lsrs	r2, r4, #24
@   0x0801cbfc: 1c33        adds	r3, r6, #0
@   0x0801cbfe: f7ff        f93d 	bl	0x1be7c
@   0x0801cc02: 2000        movs	r0, #0
@   0x0801cc04: 4641        mov	r1, r8
@   0x0801cc06: 8008        strh	r0, [r1, #0]
@   0x0801cc08: e026        b.n	0x1cc58
@   0x0801cc0a: 0000        movs	r0, r0
@   0x0801cc0c: e04c        b.n	0x1cca8
@   0x0801cc0e: 081b        lsrs	r3, r3, #32
@   0x0801cc10: e050        b.n	0x1ccb4
@   0x0801cc12: 081b        lsrs	r3, r3, #32
@   0x0801cc14: 2002        movs	r0, #2
@   0x0801cc16: f004        f82f 	bl	0x20c78
@   0x0801cc1a: 2200        movs	r2, #0
@   0x0801cc1c: 9217        str	r2, [sp, #92]	@ 0x5c
@   0x0801cc1e: 258b        movs	r5, #139	@ 0x8b
@   0x0801cc20: 006d        lsls	r5, r5, #1
@   0x0801cc22: 9500        str	r5, [sp, #0]
@   0x0801cc24: 2005        movs	r0, #5
@   0x0801cc26: 9001        str	r0, [sp, #4]
@   0x0801cc28: 2403        movs	r4, #3
@   0x0801cc2a: 9402        str	r4, [sp, #8]
@   0x0801cc2c: 480e        ldr	r0, [pc, #56]	@ (0x1cc68)
@   0x0801cc2e: 2103        movs	r1, #3
@   0x0801cc30: 464b        mov	r3, r9
@   0x0801cc32: 0e1a        lsrs	r2, r3, #24
@   0x0801cc34: 1c33        adds	r3, r6, #0
@   0x0801cc36: f7ff        f921 	bl	0x1be7c
@   0x0801cc3a: 9500        str	r5, [sp, #0]
@   0x0801cc3c: 2004        movs	r0, #4
@   0x0801cc3e: 9001        str	r0, [sp, #4]
@   0x0801cc40: 9402        str	r4, [sp, #8]
@   0x0801cc42: 480a        ldr	r0, [pc, #40]	@ (0x1cc6c)
@   0x0801cc44: 2102        movs	r1, #2
@   0x0801cc46: 4654        mov	r4, sl
@   0x0801cc48: 0e22        lsrs	r2, r4, #24
@   0x0801cc4a: 1c33        adds	r3, r6, #0
@   0x0801cc4c: f7ff        f916 	bl	0x1be7c
@   0x0801cc50: a817        add	r0, sp, #92	@ 0x5c
@   0x0801cc52: 8801        ldrh	r1, [r0, #0]
@   0x0801cc54: 4640        mov	r0, r8
@   0x0801cc56: 8001        strh	r1, [r0, #0]
@   0x0801cc58: 4641        mov	r1, r8
@   0x0801cc5a: 8808        ldrh	r0, [r1, #0]
@   0x0801cc5c: 2810        cmp	r0, #16
@   0x0801cc5e: d00a        beq.n	0x1cc76
@   0x0801cc60: 2820        cmp	r0, #32
@   0x0801cc62: d1a1        bne.n	0x1cba8
@   0x0801cc64: e007        b.n	0x1cc76
@   0x0801cc66: 0000        movs	r0, r0
@   0x0801cc68: e04c        b.n	0x1cd04
@   0x0801cc6a: 081b        lsrs	r3, r3, #32
@   0x0801cc6c: e050        b.n	0x1cd10
@   0x0801cc6e: 081b        lsrs	r3, r3, #32
@   0x0801cc70: 2078        movs	r0, #120	@ 0x78
@   0x0801cc72: f001        fafd 	bl	0x1e270
@   0x0801cc76: 4815        ldr	r0, [pc, #84]	@ (0x1cccc)
@   0x0801cc78: aa03        add	r2, sp, #12
@   0x0801cc7a: 6002        str	r2, [r0, #0]
@   0x0801cc7c: 4914        ldr	r1, [pc, #80]	@ (0x1ccd0)
@   0x0801cc7e: 6041        str	r1, [r0, #4]
@   0x0801cc80: 4a14        ldr	r2, [pc, #80]	@ (0x1ccd4)
@   0x0801cc82: 6082        str	r2, [r0, #8]
@   0x0801cc84: 6881        ldr	r1, [r0, #8]
@   0x0801cc86: ab0b        add	r3, sp, #44	@ 0x2c
@   0x0801cc88: 6003        str	r3, [r0, #0]
@   0x0801cc8a: 4913        ldr	r1, [pc, #76]	@ (0x1ccd8)
@   0x0801cc8c: 6041        str	r1, [r0, #4]
@   0x0801cc8e: 6082        str	r2, [r0, #8]
@   0x0801cc90: 6880        ldr	r0, [r0, #8]
@   0x0801cc92: 1c38        adds	r0, r7, #0
@   0x0801cc94: 2103        movs	r1, #3
@   0x0801cc96: f000        fa11 	bl	0x1d0bc
@   0x0801cc9a: 4910        ldr	r1, [pc, #64]	@ (0x1ccdc)
@   0x0801cc9c: 244e        movs	r4, #78	@ 0x4e
@   0x0801cc9e: 446c        add	r4, sp
@   0x0801cca0: 8820        ldrh	r0, [r4, #0]
@   0x0801cca2: 8008        strh	r0, [r1, #0]
@   0x0801cca4: 390e        subs	r1, #14
@   0x0801cca6: ae13        add	r6, sp, #76	@ 0x4c
@   0x0801cca8: 8830        ldrh	r0, [r6, #0]
@   0x0801ccaa: 8008        strh	r0, [r1, #0]
@   0x0801ccac: 20a0        movs	r0, #160	@ 0xa0
@   0x0801ccae: 04c0        lsls	r0, r0, #19
@   0x0801ccb0: a918        add	r1, sp, #96	@ 0x60
@   0x0801ccb2: 8809        ldrh	r1, [r1, #0]
@   0x0801ccb4: 8001        strh	r1, [r0, #0]
@   0x0801ccb6: 480a        ldr	r0, [pc, #40]	@ (0x1cce0)
@   0x0801ccb8: 8800        ldrh	r0, [r0, #0]
@   0x0801ccba: 2820        cmp	r0, #32
@   0x0801ccbc: d112        bne.n	0x1cce4
@   0x0801ccbe: 2000        movs	r0, #0
@   0x0801ccc0: f003        ffda 	bl	0x20c78
@   0x0801ccc4: 2200        movs	r2, #0
@   0x0801ccc6: 9217        str	r2, [sp, #92]	@ 0x5c
@   0x0801ccc8: e011        b.n	0x1ccee
@   0x0801ccca: 0000        movs	r0, r0
@   0x0801cccc: 00d4        lsls	r4, r2, #3
@   0x0801ccce: 0400        lsls	r0, r0, #16
@   0x0801ccd0: 01c0        lsls	r0, r0, #7
@   0x0801ccd2: 0500        lsls	r0, r0, #20
@   0x0801ccd4: 0010        movs	r0, r2
@   0x0801ccd6: 8000        strh	r0, [r0, #0]
@   0x0801ccd8: 01e0        lsls	r0, r4, #7
@   0x0801ccda: 0500        lsls	r0, r0, #20
@   0x0801ccdc: 000e        movs	r6, r1
@   0x0801ccde: 0400        lsls	r0, r0, #16
@   0x0801cce0: 5398        strh	r0, [r3, r6]
@   0x0801cce2: 0300        lsls	r0, r0, #12
@   0x0801cce4: 2810        cmp	r0, #16
@   0x0801cce6: d102        bne.n	0x1ccee
@   0x0801cce8: 2001        movs	r0, #1
@   0x0801ccea: f003        ffc5 	bl	0x20c78
@   0x0801ccee: 4806        ldr	r0, [pc, #24]	@ (0x1cd08)
@   0x0801ccf0: 2100        movs	r1, #0
@   0x0801ccf2: 8001        strh	r1, [r0, #0]
@   0x0801ccf4: 9817        ldr	r0, [sp, #92]	@ 0x5c
@   0x0801ccf6: b01b        add	sp, #108	@ 0x6c
@   0x0801ccf8: bc38        pop	{r3, r4, r5}
@   0x0801ccfa: 4698        mov	r8, r3
@   0x0801ccfc: 46a1        mov	r9, r4
@   0x0801ccfe: 46aa        mov	sl, r5
@   0x0801cd00: bcf0        pop	{r4, r5, r6, r7}
@   0x0801cd02: bc02        pop	{r1}
@   0x0801cd04: 4708        bx	r1
@   0x0801cd06: 0000        movs	r0, r0
@   0x0801cd08: 5398        strh	r0, [r3, r6]
@   0x0801cd0a: 0300        lsls	r0, r0, #12

        thumb_func_start Scene_DrawWindow
Scene_DrawWindow: @ 0x0801c900
        .incbin "frog_us_baserom.gba", 0x1c900, 0x40c
        thumb_func_end Scene_DrawWindow
