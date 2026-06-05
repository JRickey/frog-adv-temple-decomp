@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0803432c, 0x0803457c)  (592 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x803432c --end 0x803457c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0803432c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0803432e: 464f        mov	r7, r9
@   0x08034330: 4646        mov	r6, r8
@   0x08034332: b4c0        push	{r6, r7}
@   0x08034334: b08e        sub	sp, #56	@ 0x38
@   0x08034336: 900c        str	r0, [sp, #48]	@ 0x30
@   0x08034338: 910d        str	r1, [sp, #52]	@ 0x34
@   0x0803433a: a80c        add	r0, sp, #48	@ 0x30
@   0x0803433c: 4669        mov	r1, sp
@   0x0803433e: f7ff        fec9 	bl	0x340d4
@   0x08034342: a80d        add	r0, sp, #52	@ 0x34
@   0x08034344: ac04        add	r4, sp, #16
@   0x08034346: 1c21        adds	r1, r4, #0
@   0x08034348: f7ff        fec4 	bl	0x340d4
@   0x0803434c: 466f        mov	r7, sp
@   0x0803434e: a808        add	r0, sp, #32
@   0x08034350: 4680        mov	r8, r0
@   0x08034352: 2000        movs	r0, #0
@   0x08034354: 9900        ldr	r1, [sp, #0]
@   0x08034356: 46c1        mov	r9, r8
@   0x08034358: 2901        cmp	r1, #1
@   0x0803435a: d800        bhi.n	0x3435e
@   0x0803435c: 2001        movs	r0, #1
@   0x0803435e: 2800        cmp	r0, #0
@   0x08034360: d12c        bne.n	0x343bc
@   0x08034362: 2200        movs	r2, #0
@   0x08034364: 9804        ldr	r0, [sp, #16]
@   0x08034366: 2801        cmp	r0, #1
@   0x08034368: d800        bhi.n	0x3436c
@   0x0803436a: 2201        movs	r2, #1
@   0x0803436c: 2a00        cmp	r2, #0
@   0x0803436e: d001        beq.n	0x34374
@   0x08034370: 9801        ldr	r0, [sp, #4]
@   0x08034372: e033        b.n	0x343dc
@   0x08034374: 2200        movs	r2, #0
@   0x08034376: 2904        cmp	r1, #4
@   0x08034378: d100        bne.n	0x3437c
@   0x0803437a: 2201        movs	r2, #1
@   0x0803437c: 2a00        cmp	r2, #0
@   0x0803437e: d006        beq.n	0x3438e
@   0x08034380: 2100        movs	r1, #0
@   0x08034382: 2802        cmp	r0, #2
@   0x08034384: d100        bne.n	0x34388
@   0x08034386: 2101        movs	r1, #1
@   0x08034388: 2900        cmp	r1, #0
@   0x0803438a: d10c        bne.n	0x343a6
@   0x0803438c: e016        b.n	0x343bc
@   0x0803438e: 2200        movs	r2, #0
@   0x08034390: 2804        cmp	r0, #4
@   0x08034392: d100        bne.n	0x34396
@   0x08034394: 2201        movs	r2, #1
@   0x08034396: 2a00        cmp	r2, #0
@   0x08034398: d00a        beq.n	0x343b0
@   0x0803439a: 2000        movs	r0, #0
@   0x0803439c: 2902        cmp	r1, #2
@   0x0803439e: d100        bne.n	0x343a2
@   0x080343a0: 2001        movs	r0, #1
@   0x080343a2: 2800        cmp	r0, #0
@   0x080343a4: d019        beq.n	0x343da
@   0x080343a6: 4801        ldr	r0, [pc, #4]	@ (0x343ac)
@   0x080343a8: e069        b.n	0x3447e
@   0x080343aa: 0000        movs	r0, r0
@   0x080343ac: 3440        adds	r4, #64	@ 0x40
@   0x080343ae: 0300        lsls	r0, r0, #12
@   0x080343b0: 2200        movs	r2, #0
@   0x080343b2: 2902        cmp	r1, #2
@   0x080343b4: d100        bne.n	0x343b8
@   0x080343b6: 2201        movs	r2, #1
@   0x080343b8: 2a00        cmp	r2, #0
@   0x080343ba: d008        beq.n	0x343ce
@   0x080343bc: 9801        ldr	r0, [sp, #4]
@   0x080343be: 9905        ldr	r1, [sp, #20]
@   0x080343c0: 4048        eors	r0, r1
@   0x080343c2: 4241        negs	r1, r0
@   0x080343c4: 4301        orrs	r1, r0
@   0x080343c6: 0fc9        lsrs	r1, r1, #31
@   0x080343c8: 9101        str	r1, [sp, #4]
@   0x080343ca: 4668        mov	r0, sp
@   0x080343cc: e057        b.n	0x3447e
@   0x080343ce: 2100        movs	r1, #0
@   0x080343d0: 2802        cmp	r0, #2
@   0x080343d2: d100        bne.n	0x343d6
@   0x080343d4: 2101        movs	r1, #1
@   0x080343d6: 2900        cmp	r1, #0
@   0x080343d8: d008        beq.n	0x343ec
@   0x080343da: 6878        ldr	r0, [r7, #4]
@   0x080343dc: 9905        ldr	r1, [sp, #20]
@   0x080343de: 4048        eors	r0, r1
@   0x080343e0: 4241        negs	r1, r0
@   0x080343e2: 4301        orrs	r1, r0
@   0x080343e4: 0fc9        lsrs	r1, r1, #31
@   0x080343e6: 9105        str	r1, [sp, #20]
@   0x080343e8: 1c20        adds	r0, r4, #0
@   0x080343ea: e048        b.n	0x3447e
@   0x080343ec: 68f8        ldr	r0, [r7, #12]
@   0x080343ee: 2100        movs	r1, #0
@   0x080343f0: 9a07        ldr	r2, [sp, #28]
@   0x080343f2: 2300        movs	r3, #0
@   0x080343f4: f000        fab8 	bl	0x34968
@   0x080343f8: 1c0a        adds	r2, r1, #0
@   0x080343fa: 1c15        adds	r5, r2, #0
@   0x080343fc: 1c06        adds	r6, r0, #0
@   0x080343fe: 68bc        ldr	r4, [r7, #8]
@   0x08034400: 9806        ldr	r0, [sp, #24]
@   0x08034402: 1824        adds	r4, r4, r0
@   0x08034404: 940a        str	r4, [sp, #40]	@ 0x28
@   0x08034406: 6879        ldr	r1, [r7, #4]
@   0x08034408: 9805        ldr	r0, [sp, #20]
@   0x0803440a: 4041        eors	r1, r0
@   0x0803440c: 4248        negs	r0, r1
@   0x0803440e: 4308        orrs	r0, r1
@   0x08034410: 0fc0        lsrs	r0, r0, #31
@   0x08034412: 9009        str	r0, [sp, #36]	@ 0x24
@   0x08034414: 3402        adds	r4, #2
@   0x08034416: 940a        str	r4, [sp, #40]	@ 0x28
@   0x08034418: 2a00        cmp	r2, #0
@   0x0803441a: da0d        bge.n	0x34438
@   0x0803441c: 2201        movs	r2, #1
@   0x0803441e: 2180        movs	r1, #128	@ 0x80
@   0x08034420: 0609        lsls	r1, r1, #24
@   0x08034422: 3401        adds	r4, #1
@   0x08034424: 1c28        adds	r0, r5, #0
@   0x08034426: 4010        ands	r0, r2
@   0x08034428: 2800        cmp	r0, #0
@   0x0803442a: d001        beq.n	0x34430
@   0x0803442c: 0876        lsrs	r6, r6, #1
@   0x0803442e: 430e        orrs	r6, r1
@   0x08034430: 086d        lsrs	r5, r5, #1
@   0x08034432: 2d00        cmp	r5, #0
@   0x08034434: dbf5        blt.n	0x34422
@   0x08034436: 940a        str	r4, [sp, #40]	@ 0x28
@   0x08034438: 4814        ldr	r0, [pc, #80]	@ (0x3448c)
@   0x0803443a: 4285        cmp	r5, r0
@   0x0803443c: d80f        bhi.n	0x3445e
@   0x0803443e: 2480        movs	r4, #128	@ 0x80
@   0x08034440: 0624        lsls	r4, r4, #24
@   0x08034442: 2301        movs	r3, #1
@   0x08034444: 1c02        adds	r2, r0, #0
@   0x08034446: 990a        ldr	r1, [sp, #40]	@ 0x28
@   0x08034448: 3901        subs	r1, #1
@   0x0803444a: 006d        lsls	r5, r5, #1
@   0x0803444c: 1c30        adds	r0, r6, #0
@   0x0803444e: 4020        ands	r0, r4
@   0x08034450: 2800        cmp	r0, #0
@   0x08034452: d000        beq.n	0x34456
@   0x08034454: 431d        orrs	r5, r3
@   0x08034456: 0076        lsls	r6, r6, #1
@   0x08034458: 4295        cmp	r5, r2
@   0x0803445a: d9f5        bls.n	0x34448
@   0x0803445c: 910a        str	r1, [sp, #40]	@ 0x28
@   0x0803445e: 207f        movs	r0, #127	@ 0x7f
@   0x08034460: 4028        ands	r0, r5
@   0x08034462: 2840        cmp	r0, #64	@ 0x40
@   0x08034464: d106        bne.n	0x34474
@   0x08034466: 2080        movs	r0, #128	@ 0x80
@   0x08034468: 4028        ands	r0, r5
@   0x0803446a: 2800        cmp	r0, #0
@   0x0803446c: d101        bne.n	0x34472
@   0x0803446e: 2e00        cmp	r6, #0
@   0x08034470: d000        beq.n	0x34474
@   0x08034472: 3540        adds	r5, #64	@ 0x40
@   0x08034474: 950b        str	r5, [sp, #44]	@ 0x2c
@   0x08034476: 2003        movs	r0, #3
@   0x08034478: 4641        mov	r1, r8
@   0x0803447a: 6008        str	r0, [r1, #0]
@   0x0803447c: 4648        mov	r0, r9
@   0x0803447e: f7ff        fdcd 	bl	0x3401c
@   0x08034482: b00e        add	sp, #56	@ 0x38
@   0x08034484: bc18        pop	{r3, r4}
@   0x08034486: 4698        mov	r8, r3
@   0x08034488: 46a1        mov	r9, r4
@   0x0803448a: bdf0        pop	{r4, r5, r6, r7, pc}
@   0x0803448c: ffff        3fff 			@ <UNDEFINED> instruction: 0xffff3fff
@   0x08034490: b570        push	{r4, r5, r6, lr}
@   0x08034492: b08a        sub	sp, #40	@ 0x28
@   0x08034494: 9008        str	r0, [sp, #32]
@   0x08034496: 9109        str	r1, [sp, #36]	@ 0x24
@   0x08034498: a808        add	r0, sp, #32
@   0x0803449a: 4669        mov	r1, sp
@   0x0803449c: f7ff        fe1a 	bl	0x340d4
@   0x080344a0: a809        add	r0, sp, #36	@ 0x24
@   0x080344a2: ad04        add	r5, sp, #16
@   0x080344a4: 1c29        adds	r1, r5, #0
@   0x080344a6: f7ff        fe15 	bl	0x340d4
@   0x080344aa: 466c        mov	r4, sp
@   0x080344ac: 2000        movs	r0, #0
@   0x080344ae: 9b00        ldr	r3, [sp, #0]
@   0x080344b0: 2b01        cmp	r3, #1
@   0x080344b2: d800        bhi.n	0x344b6
@   0x080344b4: 2001        movs	r0, #1
@   0x080344b6: 2800        cmp	r0, #0
@   0x080344b8: d001        beq.n	0x344be
@   0x080344ba: 4669        mov	r1, sp
@   0x080344bc: e058        b.n	0x34570
@   0x080344be: 2000        movs	r0, #0
@   0x080344c0: 9a04        ldr	r2, [sp, #16]
@   0x080344c2: 1c16        adds	r6, r2, #0
@   0x080344c4: 2a01        cmp	r2, #1
@   0x080344c6: d800        bhi.n	0x344ca
@   0x080344c8: 2001        movs	r0, #1
@   0x080344ca: 2800        cmp	r0, #0
@   0x080344cc: d001        beq.n	0x344d2
@   0x080344ce: 1c29        adds	r1, r5, #0
@   0x080344d0: e04e        b.n	0x34570
@   0x080344d2: 9801        ldr	r0, [sp, #4]
@   0x080344d4: 9905        ldr	r1, [sp, #20]
@   0x080344d6: 4048        eors	r0, r1
@   0x080344d8: 9001        str	r0, [sp, #4]
@   0x080344da: 2000        movs	r0, #0
@   0x080344dc: 2b04        cmp	r3, #4
@   0x080344de: d100        bne.n	0x344e2
@   0x080344e0: 2001        movs	r0, #1
@   0x080344e2: 2800        cmp	r0, #0
@   0x080344e4: d105        bne.n	0x344f2
@   0x080344e6: 2000        movs	r0, #0
@   0x080344e8: 2b02        cmp	r3, #2
@   0x080344ea: d100        bne.n	0x344ee
@   0x080344ec: 2001        movs	r0, #1
@   0x080344ee: 2800        cmp	r0, #0
@   0x080344f0: d008        beq.n	0x34504
@   0x080344f2: 6820        ldr	r0, [r4, #0]
@   0x080344f4: 1c21        adds	r1, r4, #0
@   0x080344f6: 42b0        cmp	r0, r6
@   0x080344f8: d13a        bne.n	0x34570
@   0x080344fa: 4901        ldr	r1, [pc, #4]	@ (0x34500)
@   0x080344fc: e038        b.n	0x34570
@   0x080344fe: 0000        movs	r0, r0
@   0x08034500: 3440        adds	r4, #64	@ 0x40
@   0x08034502: 0300        lsls	r0, r0, #12
@   0x08034504: 2100        movs	r1, #0
@   0x08034506: 2a04        cmp	r2, #4
@   0x08034508: d100        bne.n	0x3450c
@   0x0803450a: 2101        movs	r1, #1
@   0x0803450c: 2900        cmp	r1, #0
@   0x0803450e: d003        beq.n	0x34518
@   0x08034510: 9003        str	r0, [sp, #12]
@   0x08034512: 9002        str	r0, [sp, #8]
@   0x08034514: 4669        mov	r1, sp
@   0x08034516: e02b        b.n	0x34570
@   0x08034518: 2000        movs	r0, #0
@   0x0803451a: 2a02        cmp	r2, #2
@   0x0803451c: d100        bne.n	0x34520
@   0x0803451e: 2001        movs	r0, #1
@   0x08034520: 2800        cmp	r0, #0
@   0x08034522: d002        beq.n	0x3452a
@   0x08034524: 2004        movs	r0, #4
@   0x08034526: 6020        str	r0, [r4, #0]
@   0x08034528: e021        b.n	0x3456e
@   0x0803452a: 68a1        ldr	r1, [r4, #8]
@   0x0803452c: 9806        ldr	r0, [sp, #24]
@   0x0803452e: 1a08        subs	r0, r1, r0
@   0x08034530: 60a0        str	r0, [r4, #8]
@   0x08034532: 68e2        ldr	r2, [r4, #12]
@   0x08034534: 9b07        ldr	r3, [sp, #28]
@   0x08034536: 429a        cmp	r2, r3
@   0x08034538: d202        bcs.n	0x34540
@   0x0803453a: 0052        lsls	r2, r2, #1
@   0x0803453c: 3801        subs	r0, #1
@   0x0803453e: 60a0        str	r0, [r4, #8]
@   0x08034540: 2080        movs	r0, #128	@ 0x80
@   0x08034542: 05c0        lsls	r0, r0, #23
@   0x08034544: 2100        movs	r1, #0
@   0x08034546: 429a        cmp	r2, r3
@   0x08034548: d301        bcc.n	0x3454e
@   0x0803454a: 4301        orrs	r1, r0
@   0x0803454c: 1ad2        subs	r2, r2, r3
@   0x0803454e: 0840        lsrs	r0, r0, #1
@   0x08034550: 0052        lsls	r2, r2, #1
@   0x08034552: 2800        cmp	r0, #0
@   0x08034554: d1f7        bne.n	0x34546
@   0x08034556: 207f        movs	r0, #127	@ 0x7f
@   0x08034558: 4008        ands	r0, r1
@   0x0803455a: 2840        cmp	r0, #64	@ 0x40
@   0x0803455c: d106        bne.n	0x3456c
@   0x0803455e: 2080        movs	r0, #128	@ 0x80
@   0x08034560: 4008        ands	r0, r1
@   0x08034562: 2800        cmp	r0, #0
@   0x08034564: d101        bne.n	0x3456a
@   0x08034566: 2a00        cmp	r2, #0
@   0x08034568: d000        beq.n	0x3456c
@   0x0803456a: 3140        adds	r1, #64	@ 0x40
@   0x0803456c: 60e1        str	r1, [r4, #12]
@   0x0803456e: 1c21        adds	r1, r4, #0
@   0x08034570: 1c08        adds	r0, r1, #0
@   0x08034572: f7ff        fd53 	bl	0x3401c
@   0x08034576: b00a        add	sp, #40	@ 0x28
@   0x08034578: bd70        pop	{r4, r5, r6, pc}

        thumb_func_start sub_0803432C
sub_0803432C: @ 0x0803432c
        .incbin "frog_us_baserom.gba", 0x3432c, 0x250
        thumb_func_end sub_0803432C
