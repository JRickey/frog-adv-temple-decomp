@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08029448, 0x080295ac)  (356 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8029448 --end 0x80295ac --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08029448: b570        push	{r4, r5, r6, lr}
@   0x0802944a: 2500        movs	r5, #0
@   0x0802944c: 2602        movs	r6, #2
@   0x0802944e: 00e8        lsls	r0, r5, #3
@   0x08029450: 1b40        subs	r0, r0, r5
@   0x08029452: 00c0        lsls	r0, r0, #3
@   0x08029454: 490a        ldr	r1, [pc, #40]	@ (0x29480)
@   0x08029456: 1844        adds	r4, r0, r1
@   0x08029458: 2003        movs	r0, #3
@   0x0802945a: 71a0        strb	r0, [r4, #6]
@   0x0802945c: 4909        ldr	r1, [pc, #36]	@ (0x29484)
@   0x0802945e: 00a8        lsls	r0, r5, #2
@   0x08029460: 1840        adds	r0, r0, r1
@   0x08029462: 6800        ldr	r0, [r0, #0]
@   0x08029464: 1c29        adds	r1, r5, #0
@   0x08029466: 3163        adds	r1, #99	@ 0x63
@   0x08029468: f7f8        faa8 	bl	0x219bc
@   0x0802946c: 2d00        cmp	r5, #0
@   0x0802946e: d10d        bne.n	0x2948c
@   0x08029470: 8861        ldrh	r1, [r4, #2]
@   0x08029472: 4a05        ldr	r2, [pc, #20]	@ (0x29488)
@   0x08029474: 1888        adds	r0, r1, r2
@   0x08029476: 0400        lsls	r0, r0, #16
@   0x08029478: 0c00        lsrs	r0, r0, #16
@   0x0802947a: 2842        cmp	r0, #66	@ 0x42
@   0x0802947c: d826        bhi.n	0x294cc
@   0x0802947e: e024        b.n	0x294ca
@   0x08029480: 4cc8        ldr	r4, [pc, #800]	@ (0x297a4)
@   0x08029482: 0300        lsls	r0, r0, #12
@   0x08029484: 7b1c        ldrb	r4, [r3, #12]
@   0x08029486: 0831        lsrs	r1, r6, #32
@   0x08029488: fe74        ffff 			@ <UNDEFINED> instruction: 0xfe74ffff
@   0x0802948c: 2d02        cmp	r5, #2
@   0x0802948e: d10b        bne.n	0x294a8
@   0x08029490: 8861        ldrh	r1, [r4, #2]
@   0x08029492: 4a04        ldr	r2, [pc, #16]	@ (0x294a4)
@   0x08029494: 1888        adds	r0, r1, r2
@   0x08029496: 0400        lsls	r0, r0, #16
@   0x08029498: 0c00        lsrs	r0, r0, #16
@   0x0802949a: 2842        cmp	r0, #66	@ 0x42
@   0x0802949c: d816        bhi.n	0x294cc
@   0x0802949e: 71a5        strb	r5, [r4, #6]
@   0x080294a0: e014        b.n	0x294cc
@   0x080294a2: 0000        movs	r0, r0
@   0x080294a4: fe6e        ffff 			@ <UNDEFINED> instruction: 0xfe6effff
@   0x080294a8: 2d01        cmp	r5, #1
@   0x080294aa: d105        bne.n	0x294b8
@   0x080294ac: 8861        ldrh	r1, [r4, #2]
@   0x080294ae: 4a01        ldr	r2, [pc, #4]	@ (0x294b4)
@   0x080294b0: e006        b.n	0x294c0
@   0x080294b2: 0000        movs	r0, r0
@   0x080294b4: feb6        ffff 			@ <UNDEFINED> instruction: 0xfeb6ffff
@   0x080294b8: 2d03        cmp	r5, #3
@   0x080294ba: d107        bne.n	0x294cc
@   0x080294bc: 8861        ldrh	r1, [r4, #2]
@   0x080294be: 4a21        ldr	r2, [pc, #132]	@ (0x29544)
@   0x080294c0: 1888        adds	r0, r1, r2
@   0x080294c2: 0400        lsls	r0, r0, #16
@   0x080294c4: 0c00        lsrs	r0, r0, #16
@   0x080294c6: 283b        cmp	r0, #59	@ 0x3b
@   0x080294c8: d800        bhi.n	0x294cc
@   0x080294ca: 71a6        strb	r6, [r4, #6]
@   0x080294cc: 71a6        strb	r6, [r4, #6]
@   0x080294ce: 1c68        adds	r0, r5, #1
@   0x080294d0: 0600        lsls	r0, r0, #24
@   0x080294d2: 0e05        lsrs	r5, r0, #24
@   0x080294d4: 2d03        cmp	r5, #3
@   0x080294d6: d9ba        bls.n	0x2944e
@   0x080294d8: 2063        movs	r0, #99	@ 0x63
@   0x080294da: 2166        movs	r1, #102	@ 0x66
@   0x080294dc: f7f7        fd82 	bl	0x20fe4
@   0x080294e0: 2063        movs	r0, #99	@ 0x63
@   0x080294e2: 2166        movs	r1, #102	@ 0x66
@   0x080294e4: f7dc        fc14 	bl	0x5d10
@   0x080294e8: 4817        ldr	r0, [pc, #92]	@ (0x29548)
@   0x080294ea: 2105        movs	r1, #5
@   0x080294ec: 2204        movs	r2, #4
@   0x080294ee: f7dd        f955 	bl	0x679c
@   0x080294f2: 0600        lsls	r0, r0, #24
@   0x080294f4: 2800        cmp	r0, #0
@   0x080294f6: d052        beq.n	0x2959e
@   0x080294f8: 2500        movs	r5, #0
@   0x080294fa: 2602        movs	r6, #2
@   0x080294fc: 00e8        lsls	r0, r5, #3
@   0x080294fe: 1b40        subs	r0, r0, r5
@   0x08029500: 00c0        lsls	r0, r0, #3
@   0x08029502: 4912        ldr	r1, [pc, #72]	@ (0x2954c)
@   0x08029504: 1844        adds	r4, r0, r1
@   0x08029506: 4912        ldr	r1, [pc, #72]	@ (0x29550)
@   0x08029508: 1c08        adds	r0, r1, #0
@   0x0802950a: 8ea2        ldrh	r2, [r4, #52]	@ 0x34
@   0x0802950c: 4010        ands	r0, r2
@   0x0802950e: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x08029510: 2003        movs	r0, #3
@   0x08029512: 71a0        strb	r0, [r4, #6]
@   0x08029514: 490f        ldr	r1, [pc, #60]	@ (0x29554)
@   0x08029516: 00a8        lsls	r0, r5, #2
@   0x08029518: 1840        adds	r0, r0, r1
@   0x0802951a: 6800        ldr	r0, [r0, #0]
@   0x0802951c: 1c29        adds	r1, r5, #0
@   0x0802951e: 3167        adds	r1, #103	@ 0x67
@   0x08029520: f7f8        fa4c 	bl	0x219bc
@   0x08029524: 2d03        cmp	r5, #3
@   0x08029526: d817        bhi.n	0x29558
@   0x08029528: 8860        ldrh	r0, [r4, #2]
@   0x0802952a: 2202        movs	r2, #2
@   0x0802952c: 5ea1        ldrsh	r1, [r4, r2]
@   0x0802952e: 294d        cmp	r1, #77	@ 0x4d
@   0x08029530: dd25        ble.n	0x2957e
@   0x08029532: 3884        subs	r0, #132	@ 0x84
@   0x08029534: 0400        lsls	r0, r0, #16
@   0x08029536: 0c00        lsrs	r0, r0, #16
@   0x08029538: 2852        cmp	r0, #82	@ 0x52
@   0x0802953a: d920        bls.n	0x2957e
@   0x0802953c: 2095        movs	r0, #149	@ 0x95
@   0x0802953e: 0040        lsls	r0, r0, #1
@   0x08029540: e01b        b.n	0x2957a
@   0x08029542: 0000        movs	r0, r0
@   0x08029544: feb0        ffff 			@ <UNDEFINED> instruction: 0xfeb0ffff
@   0x08029548: 6110        str	r0, [r2, #16]
@   0x0802954a: 0300        lsls	r0, r0, #12
@   0x0802954c: 4da8        ldr	r5, [pc, #672]	@ (0x297f0)
@   0x0802954e: 0300        lsls	r0, r0, #12
@   0x08029550: fff7        0000 	vcvta.s16.f16	d16, d0
@   0x08029554: 7b2c        ldrb	r4, [r5, #12]
@   0x08029556: 0831        lsrs	r1, r6, #32
@   0x08029558: 1f28        subs	r0, r5, #4
@   0x0802955a: 0600        lsls	r0, r0, #24
@   0x0802955c: 0e00        lsrs	r0, r0, #24
@   0x0802955e: 2803        cmp	r0, #3
@   0x08029560: d80e        bhi.n	0x29580
@   0x08029562: 8860        ldrh	r0, [r4, #2]
@   0x08029564: 2202        movs	r2, #2
@   0x08029566: 5ea1        ldrsh	r1, [r4, r2]
@   0x08029568: 2953        cmp	r1, #83	@ 0x53
@   0x0802956a: dd08        ble.n	0x2957e
@   0x0802956c: 3892        subs	r0, #146	@ 0x92
@   0x0802956e: 0400        lsls	r0, r0, #16
@   0x08029570: 0c00        lsrs	r0, r0, #16
@   0x08029572: 2853        cmp	r0, #83	@ 0x53
@   0x08029574: d903        bls.n	0x2957e
@   0x08029576: 2099        movs	r0, #153	@ 0x99
@   0x08029578: 0040        lsls	r0, r0, #1
@   0x0802957a: 4281        cmp	r1, r0
@   0x0802957c: dd00        ble.n	0x29580
@   0x0802957e: 71a6        strb	r6, [r4, #6]
@   0x08029580: 71a6        strb	r6, [r4, #6]
@   0x08029582: 1c68        adds	r0, r5, #1
@   0x08029584: 0600        lsls	r0, r0, #24
@   0x08029586: 0e05        lsrs	r5, r0, #24
@   0x08029588: 2d07        cmp	r5, #7
@   0x0802958a: d9b7        bls.n	0x294fc
@   0x0802958c: 2067        movs	r0, #103	@ 0x67
@   0x0802958e: 216e        movs	r1, #110	@ 0x6e
@   0x08029590: f7f7        fd28 	bl	0x20fe4
@   0x08029594: 2067        movs	r0, #103	@ 0x67
@   0x08029596: 216e        movs	r1, #110	@ 0x6e
@   0x08029598: f7dc        fbba 	bl	0x5d10
@   0x0802959c: e003        b.n	0x295a6
@   0x0802959e: 2067        movs	r0, #103	@ 0x67
@   0x080295a0: 216e        movs	r1, #110	@ 0x6e
@   0x080295a2: f7dc        fbb5 	bl	0x5d10
@   0x080295a6: bc70        pop	{r4, r5, r6}
@   0x080295a8: bc01        pop	{r0}
@   0x080295aa: 4700        bx	r0

        thumb_func_start sub_08029448
sub_08029448: @ 0x08029448
        .incbin "baserom.gba", 0x29448, 0x164
        thumb_func_end sub_08029448
