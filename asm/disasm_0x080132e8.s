@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080132e8, 0x080135b8)  (720 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80132e8 --end 0x80135b8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080132e8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080132ea: 4657        mov	r7, sl
@   0x080132ec: 464e        mov	r6, r9
@   0x080132ee: 4645        mov	r5, r8
@   0x080132f0: b4e0        push	{r5, r6, r7}
@   0x080132f2: b084        sub	sp, #16
@   0x080132f4: 4a16        ldr	r2, [pc, #88]	@ (0x13350)
@   0x080132f6: 1c13        adds	r3, r2, #0
@   0x080132f8: 332a        adds	r3, #42	@ 0x2a
@   0x080132fa: 20f0        movs	r0, #240	@ 0xf0
@   0x080132fc: 1c14        adds	r4, r2, #0
@   0x080132fe: 342b        adds	r4, #43	@ 0x2b
@   0x08013300: 1c01        adds	r1, r0, #0
@   0x08013302: 781b        ldrb	r3, [r3, #0]
@   0x08013304: 4019        ands	r1, r3
@   0x08013306: 7824        ldrb	r4, [r4, #0]
@   0x08013308: 4020        ands	r0, r4
@   0x0801330a: 4281        cmp	r1, r0
@   0x0801330c: d100        bne.n	0x13310
@   0x0801330e: e148        b.n	0x135a2
@   0x08013310: 2704        movs	r7, #4
@   0x08013312: 4e10        ldr	r6, [pc, #64]	@ (0x13354)
@   0x08013314: 2002        movs	r0, #2
@   0x08013316: 4682        mov	sl, r0
@   0x08013318: 4d0f        ldr	r5, [pc, #60]	@ (0x13358)
@   0x0801331a: 2103        movs	r1, #3
@   0x0801331c: 4689        mov	r9, r1
@   0x0801331e: 4b0f        ldr	r3, [pc, #60]	@ (0x1335c)
@   0x08013320: 4698        mov	r8, r3
@   0x08013322: 1c10        adds	r0, r2, #0
@   0x08013324: 302b        adds	r0, #43	@ 0x2b
@   0x08013326: 7800        ldrb	r0, [r0, #0]
@   0x08013328: 4138        asrs	r0, r7
@   0x0801332a: 2801        cmp	r0, #1
@   0x0801332c: d100        bne.n	0x13330
@   0x0801332e: e132        b.n	0x13596
@   0x08013330: 1c10        adds	r0, r2, #0
@   0x08013332: 302a        adds	r0, #42	@ 0x2a
@   0x08013334: 7800        ldrb	r0, [r0, #0]
@   0x08013336: 4138        asrs	r0, r7
@   0x08013338: 2101        movs	r1, #1
@   0x0801333a: 4008        ands	r0, r1
@   0x0801333c: 2800        cmp	r0, #0
@   0x0801333e: d100        bne.n	0x13342
@   0x08013340: e129        b.n	0x13596
@   0x08013342: 2f05        cmp	r7, #5
@   0x08013344: d05a        beq.n	0x133fc
@   0x08013346: 2f05        cmp	r7, #5
@   0x08013348: dc0a        bgt.n	0x13360
@   0x0801334a: 2f04        cmp	r7, #4
@   0x0801334c: d00f        beq.n	0x1336e
@   0x0801334e: e119        b.n	0x13584
@   0x08013350: 6110        str	r0, [r2, #16]
@   0x08013352: 0300        lsls	r0, r0, #12
@   0x08013354: 702c        strb	r4, [r5, #0]
@   0x08013356: 0830        lsrs	r0, r6, #32
@   0x08013358: 70ec        strb	r4, [r5, #3]
@   0x0801335a: 0830        lsrs	r0, r6, #32
@   0x0801335c: 36e4        adds	r6, #228	@ 0xe4
@   0x0801335e: 0300        lsls	r0, r0, #12
@   0x08013360: 2f06        cmp	r7, #6
@   0x08013362: d100        bne.n	0x13366
@   0x08013364: e088        b.n	0x13478
@   0x08013366: 2f07        cmp	r7, #7
@   0x08013368: d100        bne.n	0x1336c
@   0x0801336a: e0c7        b.n	0x134fc
@   0x0801336c: e10a        b.n	0x13584
@   0x0801336e: 7a30        ldrb	r0, [r6, #8]
@   0x08013370: 8831        ldrh	r1, [r6, #0]
@   0x08013372: 8872        ldrh	r2, [r6, #2]
@   0x08013374: 88b3        ldrh	r3, [r6, #4]
@   0x08013376: 88f4        ldrh	r4, [r6, #6]
@   0x08013378: 9400        str	r4, [sp, #0]
@   0x0801337a: 6934        ldr	r4, [r6, #16]
@   0x0801337c: 9401        str	r4, [sp, #4]
@   0x0801337e: 4654        mov	r4, sl
@   0x08013380: 9402        str	r4, [sp, #8]
@   0x08013382: f7ff        fc1f 	bl	0x12bc4
@   0x08013386: 1c34        adds	r4, r6, #0
@   0x08013388: 3478        adds	r4, #120	@ 0x78
@   0x0801338a: 7a20        ldrb	r0, [r4, #8]
@   0x0801338c: 8821        ldrh	r1, [r4, #0]
@   0x0801338e: 8862        ldrh	r2, [r4, #2]
@   0x08013390: 88a3        ldrh	r3, [r4, #4]
@   0x08013392: 9303        str	r3, [sp, #12]
@   0x08013394: 88e4        ldrh	r4, [r4, #6]
@   0x08013396: 9400        str	r4, [sp, #0]
@   0x08013398: 4c16        ldr	r4, [pc, #88]	@ (0x133f4)
@   0x0801339a: 6824        ldr	r4, [r4, #0]
@   0x0801339c: 9401        str	r4, [sp, #4]
@   0x0801339e: 4653        mov	r3, sl
@   0x080133a0: 9302        str	r3, [sp, #8]
@   0x080133a2: 9b03        ldr	r3, [sp, #12]
@   0x080133a4: f7ff        fc0e 	bl	0x12bc4
@   0x080133a8: 7a28        ldrb	r0, [r5, #8]
@   0x080133aa: 8829        ldrh	r1, [r5, #0]
@   0x080133ac: 886a        ldrh	r2, [r5, #2]
@   0x080133ae: 88ab        ldrh	r3, [r5, #4]
@   0x080133b0: 88ec        ldrh	r4, [r5, #6]
@   0x080133b2: 9400        str	r4, [sp, #0]
@   0x080133b4: 692c        ldr	r4, [r5, #16]
@   0x080133b6: 9401        str	r4, [sp, #4]
@   0x080133b8: 464c        mov	r4, r9
@   0x080133ba: 9402        str	r4, [sp, #8]
@   0x080133bc: f7ff        fc02 	bl	0x12bc4
@   0x080133c0: 1c2c        adds	r4, r5, #0
@   0x080133c2: 3478        adds	r4, #120	@ 0x78
@   0x080133c4: 7a20        ldrb	r0, [r4, #8]
@   0x080133c6: 8821        ldrh	r1, [r4, #0]
@   0x080133c8: 8862        ldrh	r2, [r4, #2]
@   0x080133ca: 88a3        ldrh	r3, [r4, #4]
@   0x080133cc: 9303        str	r3, [sp, #12]
@   0x080133ce: 88e4        ldrh	r4, [r4, #6]
@   0x080133d0: 9400        str	r4, [sp, #0]
@   0x080133d2: 4c09        ldr	r4, [pc, #36]	@ (0x133f8)
@   0x080133d4: 6824        ldr	r4, [r4, #0]
@   0x080133d6: 9401        str	r4, [sp, #4]
@   0x080133d8: 464b        mov	r3, r9
@   0x080133da: 9302        str	r3, [sp, #8]
@   0x080133dc: 9b03        ldr	r3, [sp, #12]
@   0x080133de: f7ff        fbf1 	bl	0x12bc4
@   0x080133e2: 20fe        movs	r0, #254	@ 0xfe
@   0x080133e4: 4644        mov	r4, r8
@   0x080133e6: 7824        ldrb	r4, [r4, #0]
@   0x080133e8: 4020        ands	r0, r4
@   0x080133ea: 21df        movs	r1, #223	@ 0xdf
@   0x080133ec: 4008        ands	r0, r1
@   0x080133ee: 4641        mov	r1, r8
@   0x080133f0: 7008        strb	r0, [r1, #0]
@   0x080133f2: e0c7        b.n	0x13584
@   0x080133f4: 70b4        strb	r4, [r6, #2]
@   0x080133f6: 0830        lsrs	r0, r6, #32
@   0x080133f8: 7174        strb	r4, [r6, #5]
@   0x080133fa: 0830        lsrs	r0, r6, #32
@   0x080133fc: 1c34        adds	r4, r6, #0
@   0x080133fe: 3418        adds	r4, #24
@   0x08013400: 7a20        ldrb	r0, [r4, #8]
@   0x08013402: 8b31        ldrh	r1, [r6, #24]
@   0x08013404: 8862        ldrh	r2, [r4, #2]
@   0x08013406: 88a3        ldrh	r3, [r4, #4]
@   0x08013408: 88e4        ldrh	r4, [r4, #6]
@   0x0801340a: 9400        str	r4, [sp, #0]
@   0x0801340c: 6ab4        ldr	r4, [r6, #40]	@ 0x28
@   0x0801340e: 9401        str	r4, [sp, #4]
@   0x08013410: 4654        mov	r4, sl
@   0x08013412: 9402        str	r4, [sp, #8]
@   0x08013414: f7ff        fbd6 	bl	0x12bc4
@   0x08013418: 1c34        adds	r4, r6, #0
@   0x0801341a: 3460        adds	r4, #96	@ 0x60
@   0x0801341c: 7a20        ldrb	r0, [r4, #8]
@   0x0801341e: 8821        ldrh	r1, [r4, #0]
@   0x08013420: 8862        ldrh	r2, [r4, #2]
@   0x08013422: 88a3        ldrh	r3, [r4, #4]
@   0x08013424: 88e4        ldrh	r4, [r4, #6]
@   0x08013426: 9400        str	r4, [sp, #0]
@   0x08013428: 6f34        ldr	r4, [r6, #112]	@ 0x70
@   0x0801342a: 9401        str	r4, [sp, #4]
@   0x0801342c: 4654        mov	r4, sl
@   0x0801342e: 9402        str	r4, [sp, #8]
@   0x08013430: f7ff        fbc8 	bl	0x12bc4
@   0x08013434: 1c2c        adds	r4, r5, #0
@   0x08013436: 3418        adds	r4, #24
@   0x08013438: 7a20        ldrb	r0, [r4, #8]
@   0x0801343a: 8b29        ldrh	r1, [r5, #24]
@   0x0801343c: 8862        ldrh	r2, [r4, #2]
@   0x0801343e: 88a3        ldrh	r3, [r4, #4]
@   0x08013440: 88e4        ldrh	r4, [r4, #6]
@   0x08013442: 9400        str	r4, [sp, #0]
@   0x08013444: 6aac        ldr	r4, [r5, #40]	@ 0x28
@   0x08013446: 9401        str	r4, [sp, #4]
@   0x08013448: 464c        mov	r4, r9
@   0x0801344a: 9402        str	r4, [sp, #8]
@   0x0801344c: f7ff        fbba 	bl	0x12bc4
@   0x08013450: 1c2c        adds	r4, r5, #0
@   0x08013452: 3460        adds	r4, #96	@ 0x60
@   0x08013454: 7a20        ldrb	r0, [r4, #8]
@   0x08013456: 8821        ldrh	r1, [r4, #0]
@   0x08013458: 8862        ldrh	r2, [r4, #2]
@   0x0801345a: 88a3        ldrh	r3, [r4, #4]
@   0x0801345c: 88e4        ldrh	r4, [r4, #6]
@   0x0801345e: 9400        str	r4, [sp, #0]
@   0x08013460: 6f2c        ldr	r4, [r5, #112]	@ 0x70
@   0x08013462: 9401        str	r4, [sp, #4]
@   0x08013464: 464c        mov	r4, r9
@   0x08013466: 9402        str	r4, [sp, #8]
@   0x08013468: f7ff        fbac 	bl	0x12bc4
@   0x0801346c: 20fd        movs	r0, #253	@ 0xfd
@   0x0801346e: 4641        mov	r1, r8
@   0x08013470: 7809        ldrb	r1, [r1, #0]
@   0x08013472: 4008        ands	r0, r1
@   0x08013474: 21ef        movs	r1, #239	@ 0xef
@   0x08013476: e082        b.n	0x1357e
@   0x08013478: 1c34        adds	r4, r6, #0
@   0x0801347a: 34a8        adds	r4, #168	@ 0xa8
@   0x0801347c: 7a20        ldrb	r0, [r4, #8]
@   0x0801347e: 8821        ldrh	r1, [r4, #0]
@   0x08013480: 8862        ldrh	r2, [r4, #2]
@   0x08013482: 88a3        ldrh	r3, [r4, #4]
@   0x08013484: 88e4        ldrh	r4, [r4, #6]
@   0x08013486: 9400        str	r4, [sp, #0]
@   0x08013488: 1c34        adds	r4, r6, #0
@   0x0801348a: 34b8        adds	r4, #184	@ 0xb8
@   0x0801348c: 6824        ldr	r4, [r4, #0]
@   0x0801348e: 9401        str	r4, [sp, #4]
@   0x08013490: 4654        mov	r4, sl
@   0x08013492: 9402        str	r4, [sp, #8]
@   0x08013494: f7ff        fb96 	bl	0x12bc4
@   0x08013498: 1c34        adds	r4, r6, #0
@   0x0801349a: 3430        adds	r4, #48	@ 0x30
@   0x0801349c: 7a20        ldrb	r0, [r4, #8]
@   0x0801349e: 8e31        ldrh	r1, [r6, #48]	@ 0x30
@   0x080134a0: 8862        ldrh	r2, [r4, #2]
@   0x080134a2: 88a3        ldrh	r3, [r4, #4]
@   0x080134a4: 88e4        ldrh	r4, [r4, #6]
@   0x080134a6: 9400        str	r4, [sp, #0]
@   0x080134a8: 6c34        ldr	r4, [r6, #64]	@ 0x40
@   0x080134aa: 9401        str	r4, [sp, #4]
@   0x080134ac: 4654        mov	r4, sl
@   0x080134ae: 9402        str	r4, [sp, #8]
@   0x080134b0: f7ff        fb88 	bl	0x12bc4
@   0x080134b4: 1c2c        adds	r4, r5, #0
@   0x080134b6: 34a8        adds	r4, #168	@ 0xa8
@   0x080134b8: 7a20        ldrb	r0, [r4, #8]
@   0x080134ba: 8821        ldrh	r1, [r4, #0]
@   0x080134bc: 8862        ldrh	r2, [r4, #2]
@   0x080134be: 88a3        ldrh	r3, [r4, #4]
@   0x080134c0: 88e4        ldrh	r4, [r4, #6]
@   0x080134c2: 9400        str	r4, [sp, #0]
@   0x080134c4: 1c2c        adds	r4, r5, #0
@   0x080134c6: 34b8        adds	r4, #184	@ 0xb8
@   0x080134c8: 6824        ldr	r4, [r4, #0]
@   0x080134ca: 9401        str	r4, [sp, #4]
@   0x080134cc: 464c        mov	r4, r9
@   0x080134ce: 9402        str	r4, [sp, #8]
@   0x080134d0: f7ff        fb78 	bl	0x12bc4
@   0x080134d4: 1c2c        adds	r4, r5, #0
@   0x080134d6: 3430        adds	r4, #48	@ 0x30
@   0x080134d8: 7a20        ldrb	r0, [r4, #8]
@   0x080134da: 8e29        ldrh	r1, [r5, #48]	@ 0x30
@   0x080134dc: 8862        ldrh	r2, [r4, #2]
@   0x080134de: 88a3        ldrh	r3, [r4, #4]
@   0x080134e0: 88e4        ldrh	r4, [r4, #6]
@   0x080134e2: 9400        str	r4, [sp, #0]
@   0x080134e4: 6c2c        ldr	r4, [r5, #64]	@ 0x40
@   0x080134e6: 9401        str	r4, [sp, #4]
@   0x080134e8: 464c        mov	r4, r9
@   0x080134ea: 9402        str	r4, [sp, #8]
@   0x080134ec: f7ff        fb6a 	bl	0x12bc4
@   0x080134f0: 20fb        movs	r0, #251	@ 0xfb
@   0x080134f2: 4641        mov	r1, r8
@   0x080134f4: 7809        ldrb	r1, [r1, #0]
@   0x080134f6: 4008        ands	r0, r1
@   0x080134f8: 217f        movs	r1, #127	@ 0x7f
@   0x080134fa: e040        b.n	0x1357e
@   0x080134fc: 1c34        adds	r4, r6, #0
@   0x080134fe: 3490        adds	r4, #144	@ 0x90
@   0x08013500: 7a20        ldrb	r0, [r4, #8]
@   0x08013502: 8821        ldrh	r1, [r4, #0]
@   0x08013504: 8862        ldrh	r2, [r4, #2]
@   0x08013506: 88a3        ldrh	r3, [r4, #4]
@   0x08013508: 88e4        ldrh	r4, [r4, #6]
@   0x0801350a: 9400        str	r4, [sp, #0]
@   0x0801350c: 1c34        adds	r4, r6, #0
@   0x0801350e: 34a0        adds	r4, #160	@ 0xa0
@   0x08013510: 6824        ldr	r4, [r4, #0]
@   0x08013512: 9401        str	r4, [sp, #4]
@   0x08013514: 4654        mov	r4, sl
@   0x08013516: 9402        str	r4, [sp, #8]
@   0x08013518: f7ff        fb54 	bl	0x12bc4
@   0x0801351c: 1c34        adds	r4, r6, #0
@   0x0801351e: 3448        adds	r4, #72	@ 0x48
@   0x08013520: 7a20        ldrb	r0, [r4, #8]
@   0x08013522: 8821        ldrh	r1, [r4, #0]
@   0x08013524: 8862        ldrh	r2, [r4, #2]
@   0x08013526: 88a3        ldrh	r3, [r4, #4]
@   0x08013528: 88e4        ldrh	r4, [r4, #6]
@   0x0801352a: 9400        str	r4, [sp, #0]
@   0x0801352c: 6db4        ldr	r4, [r6, #88]	@ 0x58
@   0x0801352e: 9401        str	r4, [sp, #4]
@   0x08013530: 4654        mov	r4, sl
@   0x08013532: 9402        str	r4, [sp, #8]
@   0x08013534: f7ff        fb46 	bl	0x12bc4
@   0x08013538: 1c2c        adds	r4, r5, #0
@   0x0801353a: 3490        adds	r4, #144	@ 0x90
@   0x0801353c: 7a20        ldrb	r0, [r4, #8]
@   0x0801353e: 8821        ldrh	r1, [r4, #0]
@   0x08013540: 8862        ldrh	r2, [r4, #2]
@   0x08013542: 88a3        ldrh	r3, [r4, #4]
@   0x08013544: 88e4        ldrh	r4, [r4, #6]
@   0x08013546: 9400        str	r4, [sp, #0]
@   0x08013548: 1c2c        adds	r4, r5, #0
@   0x0801354a: 34a0        adds	r4, #160	@ 0xa0
@   0x0801354c: 6824        ldr	r4, [r4, #0]
@   0x0801354e: 9401        str	r4, [sp, #4]
@   0x08013550: 464c        mov	r4, r9
@   0x08013552: 9402        str	r4, [sp, #8]
@   0x08013554: f7ff        fb36 	bl	0x12bc4
@   0x08013558: 1c2c        adds	r4, r5, #0
@   0x0801355a: 3448        adds	r4, #72	@ 0x48
@   0x0801355c: 7a20        ldrb	r0, [r4, #8]
@   0x0801355e: 8821        ldrh	r1, [r4, #0]
@   0x08013560: 8862        ldrh	r2, [r4, #2]
@   0x08013562: 88a3        ldrh	r3, [r4, #4]
@   0x08013564: 88e4        ldrh	r4, [r4, #6]
@   0x08013566: 9400        str	r4, [sp, #0]
@   0x08013568: 6dac        ldr	r4, [r5, #88]	@ 0x58
@   0x0801356a: 9401        str	r4, [sp, #4]
@   0x0801356c: 464c        mov	r4, r9
@   0x0801356e: 9402        str	r4, [sp, #8]
@   0x08013570: f7ff        fb28 	bl	0x12bc4
@   0x08013574: 20f7        movs	r0, #247	@ 0xf7
@   0x08013576: 4641        mov	r1, r8
@   0x08013578: 7809        ldrb	r1, [r1, #0]
@   0x0801357a: 4008        ands	r0, r1
@   0x0801357c: 21bf        movs	r1, #191	@ 0xbf
@   0x0801357e: 4008        ands	r0, r1
@   0x08013580: 4642        mov	r2, r8
@   0x08013582: 7010        strb	r0, [r2, #0]
@   0x08013584: 490b        ldr	r1, [pc, #44]	@ (0x135b4)
@   0x08013586: 1c0a        adds	r2, r1, #0
@   0x08013588: 322b        adds	r2, #43	@ 0x2b
@   0x0801358a: 2001        movs	r0, #1
@   0x0801358c: 40b8        lsls	r0, r7
@   0x0801358e: 7813        ldrb	r3, [r2, #0]
@   0x08013590: 4318        orrs	r0, r3
@   0x08013592: 7010        strb	r0, [r2, #0]
@   0x08013594: 1c0a        adds	r2, r1, #0
@   0x08013596: 1c78        adds	r0, r7, #1
@   0x08013598: 0600        lsls	r0, r0, #24
@   0x0801359a: 0e07        lsrs	r7, r0, #24
@   0x0801359c: 2f07        cmp	r7, #7
@   0x0801359e: d800        bhi.n	0x135a2
@   0x080135a0: e6bf        b.n	0x13322
@   0x080135a2: b004        add	sp, #16
@   0x080135a4: bc38        pop	{r3, r4, r5}
@   0x080135a6: 4698        mov	r8, r3
@   0x080135a8: 46a1        mov	r9, r4
@   0x080135aa: 46aa        mov	sl, r5
@   0x080135ac: bcf0        pop	{r4, r5, r6, r7}
@   0x080135ae: bc01        pop	{r0}
@   0x080135b0: 4700        bx	r0
@   0x080135b2: 0000        movs	r0, r0
@   0x080135b4: 6110        str	r0, [r2, #16]
@   0x080135b6: 0300        lsls	r0, r0, #12

        thumb_func_start ScaleAnim_BlitSceneLayers
ScaleAnim_BlitSceneLayers: @ 0x080132e8
        .incbin "frog_us_baserom.gba", 0x132e8, 0x2d0
        thumb_func_end ScaleAnim_BlitSceneLayers
