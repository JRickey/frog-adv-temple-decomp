@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08021838, 0x080219bc)  (388 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8021838 --end 0x80219bc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08021838: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802183a: 4657        mov	r7, sl
@   0x0802183c: 464e        mov	r6, r9
@   0x0802183e: 4645        mov	r5, r8
@   0x08021840: b4e0        push	{r5, r6, r7}
@   0x08021842: b081        sub	sp, #4
@   0x08021844: 4680        mov	r8, r0
@   0x08021846: 9809        ldr	r0, [sp, #36]	@ 0x24
@   0x08021848: 0609        lsls	r1, r1, #24
@   0x0802184a: 0e0f        lsrs	r7, r1, #24
@   0x0802184c: 0612        lsls	r2, r2, #24
@   0x0802184e: 0e12        lsrs	r2, r2, #24
@   0x08021850: 1c14        adds	r4, r2, #0
@   0x08021852: 061b        lsls	r3, r3, #24
@   0x08021854: 0e1d        lsrs	r5, r3, #24
@   0x08021856: 0600        lsls	r0, r0, #24
@   0x08021858: 0e03        lsrs	r3, r0, #24
@   0x0802185a: 2100        movs	r1, #0
@   0x0802185c: 4668        mov	r0, sp
@   0x0802185e: 7001        strb	r1, [r0, #0]
@   0x08021860: 3001        adds	r0, #1
@   0x08021862: 7001        strb	r1, [r0, #0]
@   0x08021864: 4682        mov	sl, r0
@   0x08021866: 2a02        cmp	r2, #2
@   0x08021868: d01a        beq.n	0x218a0
@   0x0802186a: 2a02        cmp	r2, #2
@   0x0802186c: dc03        bgt.n	0x21876
@   0x0802186e: 2a01        cmp	r2, #1
@   0x08021870: d005        beq.n	0x2187e
@   0x08021872: 00fc        lsls	r4, r7, #3
@   0x08021874: e059        b.n	0x2192a
@   0x08021876: 2c03        cmp	r4, #3
@   0x08021878: d025        beq.n	0x218c6
@   0x0802187a: 00fc        lsls	r4, r7, #3
@   0x0802187c: e055        b.n	0x2192a
@   0x0802187e: 2d02        cmp	r5, #2
@   0x08021880: d105        bne.n	0x2188e
@   0x08021882: 4640        mov	r0, r8
@   0x08021884: 7886        ldrb	r6, [r0, #2]
@   0x08021886: 2103        movs	r1, #3
@   0x08021888: 4689        mov	r9, r1
@   0x0802188a: 00fc        lsls	r4, r7, #3
@   0x0802188c: e04d        b.n	0x2192a
@   0x0802188e: 1c58        adds	r0, r3, #1
@   0x08021890: 4285        cmp	r5, r0
@   0x08021892: d10b        bne.n	0x218ac
@   0x08021894: 2502        movs	r5, #2
@   0x08021896: 2203        movs	r2, #3
@   0x08021898: 4691        mov	r9, r2
@   0x0802189a: 4640        mov	r0, r8
@   0x0802189c: 2102        movs	r1, #2
@   0x0802189e: e00c        b.n	0x218ba
@   0x080218a0: 1c58        adds	r0, r3, #1
@   0x080218a2: 4285        cmp	r5, r0
@   0x080218a4: d102        bne.n	0x218ac
@   0x080218a6: 2302        movs	r3, #2
@   0x080218a8: 4699        mov	r9, r3
@   0x080218aa: e003        b.n	0x218b4
@   0x080218ac: 1c68        adds	r0, r5, #1
@   0x080218ae: 0600        lsls	r0, r0, #24
@   0x080218b0: 0e00        lsrs	r0, r0, #24
@   0x080218b2: 4681        mov	r9, r0
@   0x080218b4: 4640        mov	r0, r8
@   0x080218b6: 1c29        adds	r1, r5, #0
@   0x080218b8: 464a        mov	r2, r9
@   0x080218ba: f7ff        ff8b 	bl	0x217d4
@   0x080218be: 0600        lsls	r0, r0, #24
@   0x080218c0: 0e06        lsrs	r6, r0, #24
@   0x080218c2: 00fc        lsls	r4, r7, #3
@   0x080218c4: e031        b.n	0x2192a
@   0x080218c6: 1c58        adds	r0, r3, #1
@   0x080218c8: 4a10        ldr	r2, [pc, #64]	@ (0x2190c)
@   0x080218ca: 00fc        lsls	r4, r7, #3
@   0x080218cc: 4285        cmp	r5, r0
@   0x080218ce: d108        bne.n	0x218e2
@   0x080218d0: 1be0        subs	r0, r4, r7
@   0x080218d2: 00c0        lsls	r0, r0, #3
@   0x080218d4: 1880        adds	r0, r0, r2
@   0x080218d6: 2380        movs	r3, #128	@ 0x80
@   0x080218d8: 011b        lsls	r3, r3, #4
@   0x080218da: 1c19        adds	r1, r3, #0
@   0x080218dc: 8e83        ldrh	r3, [r0, #52]	@ 0x34
@   0x080218de: 4319        orrs	r1, r3
@   0x080218e0: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x080218e2: 2d02        cmp	r5, #2
@   0x080218e4: d106        bne.n	0x218f4
@   0x080218e6: 1be1        subs	r1, r4, r7
@   0x080218e8: 00c9        lsls	r1, r1, #3
@   0x080218ea: 1889        adds	r1, r1, r2
@   0x080218ec: 4808        ldr	r0, [pc, #32]	@ (0x21910)
@   0x080218ee: 8e8a        ldrh	r2, [r1, #52]	@ 0x34
@   0x080218f0: 4010        ands	r0, r2
@   0x080218f2: 8688        strh	r0, [r1, #52]	@ 0x34
@   0x080218f4: 4805        ldr	r0, [pc, #20]	@ (0x2190c)
@   0x080218f6: 1be1        subs	r1, r4, r7
@   0x080218f8: 00c9        lsls	r1, r1, #3
@   0x080218fa: 1809        adds	r1, r1, r0
@   0x080218fc: 2080        movs	r0, #128	@ 0x80
@   0x080218fe: 0100        lsls	r0, r0, #4
@   0x08021900: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x08021902: 4008        ands	r0, r1
@   0x08021904: 2800        cmp	r0, #0
@   0x08021906: d005        beq.n	0x21914
@   0x08021908: 1e68        subs	r0, r5, #1
@   0x0802190a: e004        b.n	0x21916
@   0x0802190c: 3720        adds	r7, #32
@   0x0802190e: 0300        lsls	r0, r0, #12
@   0x08021910: f7ff        0000 			@ <UNDEFINED> instruction: 0xf7ff0000
@   0x08021914: 1c68        adds	r0, r5, #1
@   0x08021916: 0600        lsls	r0, r0, #24
@   0x08021918: 0e00        lsrs	r0, r0, #24
@   0x0802191a: 4681        mov	r9, r0
@   0x0802191c: 4640        mov	r0, r8
@   0x0802191e: 1c29        adds	r1, r5, #0
@   0x08021920: 464a        mov	r2, r9
@   0x08021922: f7ff        ff57 	bl	0x217d4
@   0x08021926: 0600        lsls	r0, r0, #24
@   0x08021928: 0e06        lsrs	r6, r0, #24
@   0x0802192a: 4669        mov	r1, sp
@   0x0802192c: 2000        movs	r0, #0
@   0x0802192e: 7008        strb	r0, [r1, #0]
@   0x08021930: 4653        mov	r3, sl
@   0x08021932: 7018        strb	r0, [r3, #0]
@   0x08021934: 2e02        cmp	r6, #2
@   0x08021936: d00f        beq.n	0x21958
@   0x08021938: 2e02        cmp	r6, #2
@   0x0802193a: dc02        bgt.n	0x21942
@   0x0802193c: 2e01        cmp	r6, #1
@   0x0802193e: d005        beq.n	0x2194c
@   0x08021940: e014        b.n	0x2196c
@   0x08021942: 2e03        cmp	r6, #3
@   0x08021944: d00c        beq.n	0x21960
@   0x08021946: 2e04        cmp	r6, #4
@   0x08021948: d00e        beq.n	0x21968
@   0x0802194a: e00f        b.n	0x2196c
@   0x0802194c: 2101        movs	r1, #1
@   0x0802194e: 4249        negs	r1, r1
@   0x08021950: 1c08        adds	r0, r1, #0
@   0x08021952: 4652        mov	r2, sl
@   0x08021954: 7010        strb	r0, [r2, #0]
@   0x08021956: e009        b.n	0x2196c
@   0x08021958: 2001        movs	r0, #1
@   0x0802195a: 4653        mov	r3, sl
@   0x0802195c: 7018        strb	r0, [r3, #0]
@   0x0802195e: e005        b.n	0x2196c
@   0x08021960: 2201        movs	r2, #1
@   0x08021962: 4252        negs	r2, r2
@   0x08021964: 1c10        adds	r0, r2, #0
@   0x08021966: e000        b.n	0x2196a
@   0x08021968: 2001        movs	r0, #1
@   0x0802196a: 7008        strb	r0, [r1, #0]
@   0x0802196c: 1be4        subs	r4, r4, r7
@   0x0802196e: 00e4        lsls	r4, r4, #3
@   0x08021970: 4811        ldr	r0, [pc, #68]	@ (0x219b8)
@   0x08021972: 1824        adds	r4, r4, r0
@   0x08021974: 00ed        lsls	r5, r5, #3
@   0x08021976: 4445        add	r5, r8
@   0x08021978: 2104        movs	r1, #4
@   0x0802197a: 5669        ldrsb	r1, [r5, r1]
@   0x0802197c: 4668        mov	r0, sp
@   0x0802197e: 2200        movs	r2, #0
@   0x08021980: 5682        ldrsb	r2, [r0, r2]
@   0x08021982: 4650        mov	r0, sl
@   0x08021984: 2300        movs	r3, #0
@   0x08021986: 56c3        ldrsb	r3, [r0, r3]
@   0x08021988: 1c20        adds	r0, r4, #0
@   0x0802198a: f7e8        fdf9 	bl	0xa580
@   0x0802198e: 8828        ldrh	r0, [r5, #0]
@   0x08021990: 8060        strh	r0, [r4, #2]
@   0x08021992: 8868        ldrh	r0, [r5, #2]
@   0x08021994: 80a0        strh	r0, [r4, #4]
@   0x08021996: 76a6        strb	r6, [r4, #26]
@   0x08021998: 2002        movs	r0, #2
@   0x0802199a: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x0802199c: 4308        orrs	r0, r1
@   0x0802199e: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x080219a0: 3433        adds	r4, #51	@ 0x33
@   0x080219a2: 464a        mov	r2, r9
@   0x080219a4: 7022        strb	r2, [r4, #0]
@   0x080219a6: b001        add	sp, #4
@   0x080219a8: bc38        pop	{r3, r4, r5}
@   0x080219aa: 4698        mov	r8, r3
@   0x080219ac: 46a1        mov	r9, r4
@   0x080219ae: 46aa        mov	sl, r5
@   0x080219b0: bcf0        pop	{r4, r5, r6, r7}
@   0x080219b2: bc01        pop	{r0}
@   0x080219b4: 4700        bx	r0
@   0x080219b6: 0000        movs	r0, r0
@   0x080219b8: 3720        adds	r7, #32
@   0x080219ba: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08021838
sub_08021838: @ 0x08021838
        .incbin "frog_us_baserom.gba", 0x21838, 0x184
        thumb_func_end sub_08021838
