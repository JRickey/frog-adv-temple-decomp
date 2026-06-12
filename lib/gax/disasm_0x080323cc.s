@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080323cc, 0x080325b0)  (484 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80323cc --end 0x80325b0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080323cc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080323ce: 4657        mov	r7, sl
@   0x080323d0: 464e        mov	r6, r9
@   0x080323d2: 4645        mov	r5, r8
@   0x080323d4: b4e0        push	{r5, r6, r7}
@   0x080323d6: b082        sub	sp, #8
@   0x080323d8: 4681        mov	r9, r0
@   0x080323da: 468a        mov	sl, r1
@   0x080323dc: 4690        mov	r8, r2
@   0x080323de: 9301        str	r3, [sp, #4]
@   0x080323e0: 229c        movs	r2, #156	@ 0x9c
@   0x080323e2: 0052        lsls	r2, r2, #1
@   0x080323e4: 444a        add	r2, r9
@   0x080323e6: 4452        add	r2, sl
@   0x080323e8: 2094        movs	r0, #148	@ 0x94
@   0x080323ea: 0040        lsls	r0, r0, #1
@   0x080323ec: 4448        add	r0, r9
@   0x080323ee: 4450        add	r0, sl
@   0x080323f0: 7801        ldrb	r1, [r0, #0]
@   0x080323f2: 7011        strb	r1, [r2, #0]
@   0x080323f4: 4669        mov	r1, sp
@   0x080323f6: 7909        ldrb	r1, [r1, #4]
@   0x080323f8: 7001        strb	r1, [r0, #0]
@   0x080323fa: 208c        movs	r0, #140	@ 0x8c
@   0x080323fc: 0040        lsls	r0, r0, #1
@   0x080323fe: 4448        add	r0, r9
@   0x08032400: 4450        add	r0, sl
@   0x08032402: 7801        ldrb	r1, [r0, #0]
@   0x08032404: 4652        mov	r2, sl
@   0x08032406: 2a09        cmp	r2, #9
@   0x08032408: d005        beq.n	0x32416
@   0x0803240a: 208a        movs	r0, #138	@ 0x8a
@   0x0803240c: 0040        lsls	r0, r0, #1
@   0x0803240e: 4448        add	r0, r9
@   0x08032410: 0089        lsls	r1, r1, #2
@   0x08032412: 3110        adds	r1, #16
@   0x08032414: e006        b.n	0x32424
@   0x08032416: 208a        movs	r0, #138	@ 0x8a
@   0x08032418: 0040        lsls	r0, r0, #1
@   0x0803241a: 4448        add	r0, r9
@   0x0803241c: 0089        lsls	r1, r1, #2
@   0x0803241e: 2384        movs	r3, #132	@ 0x84
@   0x08032420: 009b        lsls	r3, r3, #2
@   0x08032422: 18c9        adds	r1, r1, r3
@   0x08032424: 6800        ldr	r0, [r0, #0]
@   0x08032426: 1846        adds	r6, r0, r1
@   0x08032428: 481f        ldr	r0, [pc, #124]	@ (0x324a8)
@   0x0803242a: 6803        ldr	r3, [r0, #0]
@   0x0803242c: 2488        movs	r4, #136	@ 0x88
@   0x0803242e: 0064        lsls	r4, r4, #1
@   0x08032430: 1918        adds	r0, r3, r4
@   0x08032432: 6802        ldr	r2, [r0, #0]
@   0x08032434: 6810        ldr	r0, [r2, #0]
@   0x08032436: 8834        ldrh	r4, [r6, #0]
@   0x08032438: 00a1        lsls	r1, r4, #2
@   0x0803243a: 1810        adds	r0, r2, r0
@   0x0803243c: 1809        adds	r1, r1, r0
@   0x0803243e: 6808        ldr	r0, [r1, #0]
@   0x08032440: 1817        adds	r7, r2, r0
@   0x08032442: 8999        ldrh	r1, [r3, #12]
@   0x08032444: 4640        mov	r0, r8
@   0x08032446: 4348        muls	r0, r1
@   0x08032448: 1200        asrs	r0, r0, #8
@   0x0803244a: 4680        mov	r8, r0
@   0x0803244c: 4652        mov	r2, sl
@   0x0803244e: 2a03        cmp	r2, #3
@   0x08032450: dc33        bgt.n	0x324ba
@   0x08032452: 4654        mov	r4, sl
@   0x08032454: 783b        ldrb	r3, [r7, #0]
@   0x08032456: 2b03        cmp	r3, #3
@   0x08032458: d800        bhi.n	0x3245c
@   0x0803245a: 783c        ldrb	r4, [r7, #0]
@   0x0803245c: 2201        movs	r2, #1
@   0x0803245e: 1c10        adds	r0, r2, #0
@   0x08032460: 7879        ldrb	r1, [r7, #1]
@   0x08032462: 4008        ands	r0, r1
@   0x08032464: 2800        cmp	r0, #0
@   0x08032466: d009        beq.n	0x3247c
@   0x08032468: 2c01        cmp	r4, #1
@   0x0803246a: dc07        bgt.n	0x3247c
@   0x0803246c: 20a8        movs	r0, #168	@ 0xa8
@   0x0803246e: 0040        lsls	r0, r0, #1
@   0x08032470: 4448        add	r0, r9
@   0x08032472: 7801        ldrb	r1, [r0, #0]
@   0x08032474: 1864        adds	r4, r4, r1
@   0x08032476: 4014        ands	r4, r2
@   0x08032478: 4051        eors	r1, r2
@   0x0803247a: 7001        strb	r1, [r0, #0]
@   0x0803247c: 78b1        ldrb	r1, [r6, #2]
@   0x0803247e: 2000        movs	r0, #0
@   0x08032480: 1c22        adds	r2, r4, #0
@   0x08032482: f000        fb8d 	bl	0x32ba0
@   0x08032486: 2800        cmp	r0, #0
@   0x08032488: d100        bne.n	0x3248c
@   0x0803248a: e087        b.n	0x3259c
@   0x0803248c: 2080        movs	r0, #128	@ 0x80
@   0x0803248e: 787a        ldrb	r2, [r7, #1]
@   0x08032490: 4010        ands	r0, r2
@   0x08032492: 2800        cmp	r0, #0
@   0x08032494: d10a        bne.n	0x324ac
@   0x08032496: 78b0        ldrb	r0, [r6, #2]
@   0x08032498: 9000        str	r0, [sp, #0]
@   0x0803249a: 1c20        adds	r0, r4, #0
@   0x0803249c: 9901        ldr	r1, [sp, #4]
@   0x0803249e: 2240        movs	r2, #64	@ 0x40
@   0x080324a0: 4643        mov	r3, r8
@   0x080324a2: f000        fa2f 	bl	0x32904
@   0x080324a6: e04d        b.n	0x32544
@   0x080324a8: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080324aa: 0300        lsls	r0, r0, #12
@   0x080324ac: 78b3        ldrb	r3, [r6, #2]
@   0x080324ae: 1c20        adds	r0, r4, #0
@   0x080324b0: 9901        ldr	r1, [sp, #4]
@   0x080324b2: 4642        mov	r2, r8
@   0x080324b4: f000        fa72 	bl	0x3299c
@   0x080324b8: e044        b.n	0x32544
@   0x080324ba: 783c        ldrb	r4, [r7, #0]
@   0x080324bc: 2cff        cmp	r4, #255	@ 0xff
@   0x080324be: d006        beq.n	0x324ce
@   0x080324c0: 3c04        subs	r4, #4
@   0x080324c2: 2c00        cmp	r4, #0
@   0x080324c4: db02        blt.n	0x324cc
@   0x080324c6: 781b        ldrb	r3, [r3, #0]
@   0x080324c8: 429c        cmp	r4, r3
@   0x080324ca: db00        blt.n	0x324ce
@   0x080324cc: 24ff        movs	r4, #255	@ 0xff
@   0x080324ce: 78b1        ldrb	r1, [r6, #2]
@   0x080324d0: 78f2        ldrb	r2, [r6, #3]
@   0x080324d2: 2000        movs	r0, #0
@   0x080324d4: 1c23        adds	r3, r4, #0
@   0x080324d6: f000        fb1f 	bl	0x32b18
@   0x080324da: 1c04        adds	r4, r0, #0
@   0x080324dc: 2c00        cmp	r4, #0
@   0x080324de: db5d        blt.n	0x3259c
@   0x080324e0: 480e        ldr	r0, [pc, #56]	@ (0x3251c)
@   0x080324e2: 6803        ldr	r3, [r0, #0]
@   0x080324e4: 1c18        adds	r0, r3, #0
@   0x080324e6: 30c8        adds	r0, #200	@ 0xc8
@   0x080324e8: 01a1        lsls	r1, r4, #6
@   0x080324ea: 6800        ldr	r0, [r0, #0]
@   0x080324ec: 1845        adds	r5, r0, r1
@   0x080324ee: 2080        movs	r0, #128	@ 0x80
@   0x080324f0: 7879        ldrb	r1, [r7, #1]
@   0x080324f2: 4008        ands	r0, r1
@   0x080324f4: 0600        lsls	r0, r0, #24
@   0x080324f6: 0e02        lsrs	r2, r0, #24
@   0x080324f8: 2a00        cmp	r2, #0
@   0x080324fa: d111        bne.n	0x32520
@   0x080324fc: 1c18        adds	r0, r3, #0
@   0x080324fe: 30c4        adds	r0, #196	@ 0xc4
@   0x08032500: 6801        ldr	r1, [r0, #0]
@   0x08032502: 00a0        lsls	r0, r4, #2
@   0x08032504: 1840        adds	r0, r0, r1
@   0x08032506: 6002        str	r2, [r0, #0]
@   0x08032508: 78b0        ldrb	r0, [r6, #2]
@   0x0803250a: 9000        str	r0, [sp, #0]
@   0x0803250c: 1c28        adds	r0, r5, #0
@   0x0803250e: 9901        ldr	r1, [sp, #4]
@   0x08032510: 2240        movs	r2, #64	@ 0x40
@   0x08032512: 4643        mov	r3, r8
@   0x08032514: f000        f9be 	bl	0x32894
@   0x08032518: e008        b.n	0x3252c
@   0x0803251a: 0000        movs	r0, r0
@   0x0803251c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0803251e: 0300        lsls	r0, r0, #12
@   0x08032520: 78b3        ldrb	r3, [r6, #2]
@   0x08032522: 1c28        adds	r0, r5, #0
@   0x08032524: 9901        ldr	r1, [sp, #4]
@   0x08032526: 4642        mov	r2, r8
@   0x08032528: f000        fb4e 	bl	0x32bc8
@   0x0803252c: 481f        ldr	r0, [pc, #124]	@ (0x325ac)
@   0x0803252e: 6800        ldr	r0, [r0, #0]
@   0x08032530: 30cc        adds	r0, #204	@ 0xcc
@   0x08032532: 6801        ldr	r1, [r0, #0]
@   0x08032534: 00a0        lsls	r0, r4, #2
@   0x08032536: 1840        adds	r0, r0, r1
@   0x08032538: 6005        str	r5, [r0, #0]
@   0x0803253a: 3404        adds	r4, #4
@   0x0803253c: 1c29        adds	r1, r5, #0
@   0x0803253e: 313d        adds	r1, #61	@ 0x3d
@   0x08032540: 2001        movs	r0, #1
@   0x08032542: 7008        strb	r0, [r1, #0]
@   0x08032544: 2188        movs	r1, #136	@ 0x88
@   0x08032546: 0049        lsls	r1, r1, #1
@   0x08032548: 4449        add	r1, r9
@   0x0803254a: 0060        lsls	r0, r4, #1
@   0x0803254c: 1900        adds	r0, r0, r4
@   0x0803254e: 0080        lsls	r0, r0, #2
@   0x08032550: 6809        ldr	r1, [r1, #0]
@   0x08032552: 1809        adds	r1, r1, r0
@   0x08032554: 980a        ldr	r0, [sp, #40]	@ 0x28
@   0x08032556: 0200        lsls	r0, r0, #8
@   0x08032558: 6008        str	r0, [r1, #0]
@   0x0803255a: 2200        movs	r2, #0
@   0x0803255c: 4653        mov	r3, sl
@   0x0803255e: 714b        strb	r3, [r1, #5]
@   0x08032560: 2001        movs	r0, #1
@   0x08032562: 7108        strb	r0, [r1, #4]
@   0x08032564: 4640        mov	r0, r8
@   0x08032566: 7188        strb	r0, [r1, #6]
@   0x08032568: 7208        strb	r0, [r1, #8]
@   0x0803256a: 466b        mov	r3, sp
@   0x0803256c: 791b        ldrb	r3, [r3, #4]
@   0x0803256e: 71cb        strb	r3, [r1, #7]
@   0x08032570: 480e        ldr	r0, [pc, #56]	@ (0x325ac)
@   0x08032572: 6803        ldr	r3, [r0, #0]
@   0x08032574: 218a        movs	r1, #138	@ 0x8a
@   0x08032576: 0049        lsls	r1, r1, #1
@   0x08032578: 1858        adds	r0, r3, r1
@   0x0803257a: 0121        lsls	r1, r4, #4
@   0x0803257c: 6800        ldr	r0, [r0, #0]
@   0x0803257e: 1840        adds	r0, r0, r1
@   0x08032580: 8102        strh	r2, [r0, #8]
@   0x08032582: 8142        strh	r2, [r0, #10]
@   0x08032584: 6042        str	r2, [r0, #4]
@   0x08032586: 1d39        adds	r1, r7, #4
@   0x08032588: 6001        str	r1, [r0, #0]
@   0x0803258a: 8831        ldrh	r1, [r6, #0]
@   0x0803258c: 8181        strh	r1, [r0, #12]
@   0x0803258e: 2190        movs	r1, #144	@ 0x90
@   0x08032590: 0049        lsls	r1, r1, #1
@   0x08032592: 1858        adds	r0, r3, r1
@   0x08032594: 6801        ldr	r1, [r0, #0]
@   0x08032596: 00a0        lsls	r0, r4, #2
@   0x08032598: 1840        adds	r0, r0, r1
@   0x0803259a: 6002        str	r2, [r0, #0]
@   0x0803259c: b002        add	sp, #8
@   0x0803259e: bc38        pop	{r3, r4, r5}
@   0x080325a0: 4698        mov	r8, r3
@   0x080325a2: 46a1        mov	r9, r4
@   0x080325a4: 46aa        mov	sl, r5
@   0x080325a6: bcf0        pop	{r4, r5, r6, r7}
@   0x080325a8: bc01        pop	{r0}
@   0x080325aa: 4700        bx	r0
@   0x080325ac: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x080325ae: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080323CC
sub_080323CC: @ 0x080323cc
        .incbin "frog_us_baserom.gba", 0x323cc, 0x1e4
        thumb_func_end sub_080323CC
