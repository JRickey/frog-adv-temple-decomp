@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08028270, 0x08028520)  (688 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8028270 --end 0x8028520 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08028270: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08028272: 2600        movs	r6, #0
@   0x08028274: 00f2        lsls	r2, r6, #3
@   0x08028276: 1b90        subs	r0, r2, r6
@   0x08028278: 00c0        lsls	r0, r0, #3
@   0x0802827a: 4b14        ldr	r3, [pc, #80]	@ (0x282cc)
@   0x0802827c: 18c4        adds	r4, r0, r3
@   0x0802827e: 0871        lsrs	r1, r6, #1
@   0x08028280: 00c8        lsls	r0, r1, #3
@   0x08028282: 1a40        subs	r0, r0, r1
@   0x08028284: 00c0        lsls	r0, r0, #3
@   0x08028286: 258c        movs	r5, #140	@ 0x8c
@   0x08028288: 00ad        lsls	r5, r5, #2
@   0x0802828a: 1959        adds	r1, r3, r5
@   0x0802828c: 1845        adds	r5, r0, r1
@   0x0802828e: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08028290: 2080        movs	r0, #128	@ 0x80
@   0x08028292: 0200        lsls	r0, r0, #8
@   0x08028294: 4008        ands	r0, r1
@   0x08028296: 1c17        adds	r7, r2, #0
@   0x08028298: 2800        cmp	r0, #0
@   0x0802829a: d00e        beq.n	0x282ba
@   0x0802829c: 2002        movs	r0, #2
@   0x0802829e: 4308        orrs	r0, r1
@   0x080282a0: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x080282a2: 480b        ldr	r0, [pc, #44]	@ (0x282d0)
@   0x080282a4: 181a        adds	r2, r3, r0
@   0x080282a6: 1c31        adds	r1, r6, #0
@   0x080282a8: 3128        adds	r1, #40	@ 0x28
@   0x080282aa: 00c8        lsls	r0, r1, #3
@   0x080282ac: 1a40        subs	r0, r0, r1
@   0x080282ae: 00c0        lsls	r0, r0, #3
@   0x080282b0: 1880        adds	r0, r0, r2
@   0x080282b2: 4908        ldr	r1, [pc, #32]	@ (0x282d4)
@   0x080282b4: 8e82        ldrh	r2, [r0, #52]	@ 0x34
@   0x080282b6: 4011        ands	r1, r2
@   0x080282b8: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x080282ba: 7ea0        ldrb	r0, [r4, #26]
@   0x080282bc: 2807        cmp	r0, #7
@   0x080282be: d900        bls.n	0x282c2
@   0x080282c0: e11d        b.n	0x284fe
@   0x080282c2: 0080        lsls	r0, r0, #2
@   0x080282c4: 4904        ldr	r1, [pc, #16]	@ (0x282d8)
@   0x080282c6: 1840        adds	r0, r0, r1
@   0x080282c8: 6800        ldr	r0, [r0, #0]
@   0x080282ca: 4687        mov	pc, r0
@   0x080282cc: 3fe0        subs	r7, #224	@ 0xe0
@   0x080282ce: 0300        lsls	r0, r0, #12
@   0x080282d0: f740        ffff 	bl	0xfff692d2
@   0x080282d4: 7fff        ldrb	r7, [r7, #31]
@   0x080282d6: 0000        movs	r0, r0
@   0x080282d8: 82dc        strh	r4, [r3, #22]
@   0x080282da: 0802        lsrs	r2, r0, #32
@   0x080282dc: 82fc        strh	r4, [r7, #22]
@   0x080282de: 0802        lsrs	r2, r0, #32
@   0x080282e0: 8306        strh	r6, [r0, #24]
@   0x080282e2: 0802        lsrs	r2, r0, #32
@   0x080282e4: 8382        strh	r2, [r0, #28]
@   0x080282e6: 0802        lsrs	r2, r0, #32
@   0x080282e8: 838c        strh	r4, [r1, #28]
@   0x080282ea: 0802        lsrs	r2, r0, #32
@   0x080282ec: 83fe        strh	r6, [r7, #30]
@   0x080282ee: 0802        lsrs	r2, r0, #32
@   0x080282f0: 8408        strh	r0, [r1, #32]
@   0x080282f2: 0802        lsrs	r2, r0, #32
@   0x080282f4: 846e        strh	r6, [r5, #34]	@ 0x22
@   0x080282f6: 0802        lsrs	r2, r0, #32
@   0x080282f8: 8484        strh	r4, [r0, #36]	@ 0x24
@   0x080282fa: 0802        lsrs	r2, r0, #32
@   0x080282fc: 2104        movs	r1, #4
@   0x080282fe: 5e68        ldrsh	r0, [r5, r1]
@   0x08028300: 2204        movs	r2, #4
@   0x08028302: 5ea1        ldrsh	r1, [r4, r2]
@   0x08028304: e0b7        b.n	0x28476
@   0x08028306: 7ee0        ldrb	r0, [r4, #27]
@   0x08028308: 2800        cmp	r0, #0
@   0x0802830a: d112        bne.n	0x28332
@   0x0802830c: 88a0        ldrh	r0, [r4, #4]
@   0x0802830e: 3012        adds	r0, #18
@   0x08028310: 80a8        strh	r0, [r5, #4]
@   0x08028312: 2080        movs	r0, #128	@ 0x80
@   0x08028314: 0080        lsls	r0, r0, #2
@   0x08028316: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08028318: 4008        ands	r0, r1
@   0x0802831a: 2800        cmp	r0, #0
@   0x0802831c: d009        beq.n	0x28332
@   0x0802831e: 1c20        adds	r0, r4, #0
@   0x08028320: 210a        movs	r1, #10
@   0x08028322: 2202        movs	r2, #2
@   0x08028324: 2302        movs	r3, #2
@   0x08028326: f7f8        fd75 	bl	0x20e14
@   0x0802832a: 4806        ldr	r0, [pc, #24]	@ (0x28344)
@   0x0802832c: 8ea2        ldrh	r2, [r4, #52]	@ 0x34
@   0x0802832e: 4010        ands	r0, r2
@   0x08028330: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x08028332: 7ee0        ldrb	r0, [r4, #27]
@   0x08028334: 2801        cmp	r0, #1
@   0x08028336: d009        beq.n	0x2834c
@   0x08028338: 2802        cmp	r0, #2
@   0x0802833a: d105        bne.n	0x28348
@   0x0802833c: 88a0        ldrh	r0, [r4, #4]
@   0x0802833e: 3008        adds	r0, #8
@   0x08028340: 80a8        strh	r0, [r5, #4]
@   0x08028342: e0dc        b.n	0x284fe
@   0x08028344: fdff        0000 			@ <UNDEFINED> instruction: 0xfdff0000
@   0x08028348: 2803        cmp	r0, #3
@   0x0802834a: d103        bne.n	0x28354
@   0x0802834c: 88a0        ldrh	r0, [r4, #4]
@   0x0802834e: 300d        adds	r0, #13
@   0x08028350: 80a8        strh	r0, [r5, #4]
@   0x08028352: e0d4        b.n	0x284fe
@   0x08028354: 2804        cmp	r0, #4
@   0x08028356: d000        beq.n	0x2835a
@   0x08028358: e0d1        b.n	0x284fe
@   0x0802835a: 88a0        ldrh	r0, [r4, #4]
@   0x0802835c: 3012        adds	r0, #18
@   0x0802835e: 80a8        strh	r0, [r5, #4]
@   0x08028360: 7ea0        ldrb	r0, [r4, #26]
@   0x08028362: 3801        subs	r0, #1
@   0x08028364: 76a0        strb	r0, [r4, #26]
@   0x08028366: 2002        movs	r0, #2
@   0x08028368: 76a8        strb	r0, [r5, #26]
@   0x0802836a: 1c28        adds	r0, r5, #0
@   0x0802836c: 2105        movs	r1, #5
@   0x0802836e: 2200        movs	r2, #0
@   0x08028370: 2301        movs	r3, #1
@   0x08028372: f7e2        f905 	bl	0xa580
@   0x08028376: 2580        movs	r5, #128	@ 0x80
@   0x08028378: 00ad        lsls	r5, r5, #2
@   0x0802837a: 1c28        adds	r0, r5, #0
@   0x0802837c: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x0802837e: 4308        orrs	r0, r1
@   0x08028380: e0bc        b.n	0x284fc
@   0x08028382: 2204        movs	r2, #4
@   0x08028384: 5ea0        ldrsh	r0, [r4, r2]
@   0x08028386: 2204        movs	r2, #4
@   0x08028388: 5ea9        ldrsh	r1, [r5, r2]
@   0x0802838a: e074        b.n	0x28476
@   0x0802838c: 7ee0        ldrb	r0, [r4, #27]
@   0x0802838e: 2800        cmp	r0, #0
@   0x08028390: d116        bne.n	0x283c0
@   0x08028392: 88a0        ldrh	r0, [r4, #4]
@   0x08028394: 3812        subs	r0, #18
@   0x08028396: 80a8        strh	r0, [r5, #4]
@   0x08028398: 2080        movs	r0, #128	@ 0x80
@   0x0802839a: 0080        lsls	r0, r0, #2
@   0x0802839c: 8ea5        ldrh	r5, [r4, #52]	@ 0x34
@   0x0802839e: 4028        ands	r0, r5
@   0x080283a0: 2800        cmp	r0, #0
@   0x080283a2: d100        bne.n	0x283a6
@   0x080283a4: e0ab        b.n	0x284fe
@   0x080283a6: 1c20        adds	r0, r4, #0
@   0x080283a8: 210a        movs	r1, #10
@   0x080283aa: 2202        movs	r2, #2
@   0x080283ac: 2302        movs	r3, #2
@   0x080283ae: f7f8        fd31 	bl	0x20e14
@   0x080283b2: 4802        ldr	r0, [pc, #8]	@ (0x283bc)
@   0x080283b4: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x080283b6: 4008        ands	r0, r1
@   0x080283b8: e0a0        b.n	0x284fc
@   0x080283ba: 0000        movs	r0, r0
@   0x080283bc: fdff        0000 			@ <UNDEFINED> instruction: 0xfdff0000
@   0x080283c0: 2801        cmp	r0, #1
@   0x080283c2: d007        beq.n	0x283d4
@   0x080283c4: 2802        cmp	r0, #2
@   0x080283c6: d103        bne.n	0x283d0
@   0x080283c8: 88a0        ldrh	r0, [r4, #4]
@   0x080283ca: 3808        subs	r0, #8
@   0x080283cc: 80a8        strh	r0, [r5, #4]
@   0x080283ce: e096        b.n	0x284fe
@   0x080283d0: 2803        cmp	r0, #3
@   0x080283d2: d103        bne.n	0x283dc
@   0x080283d4: 88a0        ldrh	r0, [r4, #4]
@   0x080283d6: 380d        subs	r0, #13
@   0x080283d8: 80a8        strh	r0, [r5, #4]
@   0x080283da: e090        b.n	0x284fe
@   0x080283dc: 2804        cmp	r0, #4
@   0x080283de: d000        beq.n	0x283e2
@   0x080283e0: e08d        b.n	0x284fe
@   0x080283e2: 88a0        ldrh	r0, [r4, #4]
@   0x080283e4: 3812        subs	r0, #18
@   0x080283e6: 80a8        strh	r0, [r5, #4]
@   0x080283e8: 7ea0        ldrb	r0, [r4, #26]
@   0x080283ea: 3801        subs	r0, #1
@   0x080283ec: 76a0        strb	r0, [r4, #26]
@   0x080283ee: 2001        movs	r0, #1
@   0x080283f0: 76a8        strb	r0, [r5, #26]
@   0x080283f2: 2301        movs	r3, #1
@   0x080283f4: 425b        negs	r3, r3
@   0x080283f6: 1c28        adds	r0, r5, #0
@   0x080283f8: 2105        movs	r1, #5
@   0x080283fa: 2200        movs	r2, #0
@   0x080283fc: e077        b.n	0x284ee
@   0x080283fe: 2102        movs	r1, #2
@   0x08028400: 5e68        ldrsh	r0, [r5, r1]
@   0x08028402: 2202        movs	r2, #2
@   0x08028404: 5ea1        ldrsh	r1, [r4, r2]
@   0x08028406: e036        b.n	0x28476
@   0x08028408: 7ee1        ldrb	r1, [r4, #27]
@   0x0802840a: 2900        cmp	r1, #0
@   0x0802840c: d114        bne.n	0x28438
@   0x0802840e: 8860        ldrh	r0, [r4, #2]
@   0x08028410: 3012        adds	r0, #18
@   0x08028412: 8068        strh	r0, [r5, #2]
@   0x08028414: 2080        movs	r0, #128	@ 0x80
@   0x08028416: 0080        lsls	r0, r0, #2
@   0x08028418: 8ea5        ldrh	r5, [r4, #52]	@ 0x34
@   0x0802841a: 4028        ands	r0, r5
@   0x0802841c: 2800        cmp	r0, #0
@   0x0802841e: d06e        beq.n	0x284fe
@   0x08028420: 1c20        adds	r0, r4, #0
@   0x08028422: 210a        movs	r1, #10
@   0x08028424: 2202        movs	r2, #2
@   0x08028426: 2302        movs	r3, #2
@   0x08028428: f7f8        fcf4 	bl	0x20e14
@   0x0802842c: 4801        ldr	r0, [pc, #4]	@ (0x28434)
@   0x0802842e: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08028430: 4008        ands	r0, r1
@   0x08028432: e063        b.n	0x284fc
@   0x08028434: fdff        0000 			@ <UNDEFINED> instruction: 0xfdff0000
@   0x08028438: 2901        cmp	r1, #1
@   0x0802843a: d007        beq.n	0x2844c
@   0x0802843c: 2902        cmp	r1, #2
@   0x0802843e: d103        bne.n	0x28448
@   0x08028440: 8860        ldrh	r0, [r4, #2]
@   0x08028442: 3008        adds	r0, #8
@   0x08028444: 8068        strh	r0, [r5, #2]
@   0x08028446: e05a        b.n	0x284fe
@   0x08028448: 2903        cmp	r1, #3
@   0x0802844a: d103        bne.n	0x28454
@   0x0802844c: 8860        ldrh	r0, [r4, #2]
@   0x0802844e: 300d        adds	r0, #13
@   0x08028450: 8068        strh	r0, [r5, #2]
@   0x08028452: e054        b.n	0x284fe
@   0x08028454: 2904        cmp	r1, #4
@   0x08028456: d152        bne.n	0x284fe
@   0x08028458: 8860        ldrh	r0, [r4, #2]
@   0x0802845a: 3012        adds	r0, #18
@   0x0802845c: 8068        strh	r0, [r5, #2]
@   0x0802845e: 7ea0        ldrb	r0, [r4, #26]
@   0x08028460: 3801        subs	r0, #1
@   0x08028462: 76a0        strb	r0, [r4, #26]
@   0x08028464: 76a9        strb	r1, [r5, #26]
@   0x08028466: 1c28        adds	r0, r5, #0
@   0x08028468: 2105        movs	r1, #5
@   0x0802846a: 2201        movs	r2, #1
@   0x0802846c: e03e        b.n	0x284ec
@   0x0802846e: 2102        movs	r1, #2
@   0x08028470: 5e60        ldrsh	r0, [r4, r1]
@   0x08028472: 2202        movs	r2, #2
@   0x08028474: 5ea9        ldrsh	r1, [r5, r2]
@   0x08028476: 1a40        subs	r0, r0, r1
@   0x08028478: 2811        cmp	r0, #17
@   0x0802847a: dc40        bgt.n	0x284fe
@   0x0802847c: 7ea0        ldrb	r0, [r4, #26]
@   0x0802847e: 3001        adds	r0, #1
@   0x08028480: 76a0        strb	r0, [r4, #26]
@   0x08028482: e03c        b.n	0x284fe
@   0x08028484: 7ee0        ldrb	r0, [r4, #27]
@   0x08028486: 2800        cmp	r0, #0
@   0x08028488: d114        bne.n	0x284b4
@   0x0802848a: 8860        ldrh	r0, [r4, #2]
@   0x0802848c: 3812        subs	r0, #18
@   0x0802848e: 8068        strh	r0, [r5, #2]
@   0x08028490: 2080        movs	r0, #128	@ 0x80
@   0x08028492: 0080        lsls	r0, r0, #2
@   0x08028494: 8ea5        ldrh	r5, [r4, #52]	@ 0x34
@   0x08028496: 4028        ands	r0, r5
@   0x08028498: 2800        cmp	r0, #0
@   0x0802849a: d030        beq.n	0x284fe
@   0x0802849c: 1c20        adds	r0, r4, #0
@   0x0802849e: 210a        movs	r1, #10
@   0x080284a0: 2202        movs	r2, #2
@   0x080284a2: 2302        movs	r3, #2
@   0x080284a4: f7f8        fcb6 	bl	0x20e14
@   0x080284a8: 4801        ldr	r0, [pc, #4]	@ (0x284b0)
@   0x080284aa: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x080284ac: 4008        ands	r0, r1
@   0x080284ae: e025        b.n	0x284fc
@   0x080284b0: fdff        0000 			@ <UNDEFINED> instruction: 0xfdff0000
@   0x080284b4: 2801        cmp	r0, #1
@   0x080284b6: d007        beq.n	0x284c8
@   0x080284b8: 2802        cmp	r0, #2
@   0x080284ba: d103        bne.n	0x284c4
@   0x080284bc: 8860        ldrh	r0, [r4, #2]
@   0x080284be: 3808        subs	r0, #8
@   0x080284c0: 8068        strh	r0, [r5, #2]
@   0x080284c2: e01c        b.n	0x284fe
@   0x080284c4: 2803        cmp	r0, #3
@   0x080284c6: d103        bne.n	0x284d0
@   0x080284c8: 8860        ldrh	r0, [r4, #2]
@   0x080284ca: 380d        subs	r0, #13
@   0x080284cc: 8068        strh	r0, [r5, #2]
@   0x080284ce: e016        b.n	0x284fe
@   0x080284d0: 2804        cmp	r0, #4
@   0x080284d2: d114        bne.n	0x284fe
@   0x080284d4: 8860        ldrh	r0, [r4, #2]
@   0x080284d6: 3812        subs	r0, #18
@   0x080284d8: 8068        strh	r0, [r5, #2]
@   0x080284da: 7ea0        ldrb	r0, [r4, #26]
@   0x080284dc: 3801        subs	r0, #1
@   0x080284de: 76a0        strb	r0, [r4, #26]
@   0x080284e0: 2003        movs	r0, #3
@   0x080284e2: 76a8        strb	r0, [r5, #26]
@   0x080284e4: 2201        movs	r2, #1
@   0x080284e6: 4252        negs	r2, r2
@   0x080284e8: 1c28        adds	r0, r5, #0
@   0x080284ea: 2105        movs	r1, #5
@   0x080284ec: 2300        movs	r3, #0
@   0x080284ee: f7e2        f847 	bl	0xa580
@   0x080284f2: 2280        movs	r2, #128	@ 0x80
@   0x080284f4: 0092        lsls	r2, r2, #2
@   0x080284f6: 1c10        adds	r0, r2, #0
@   0x080284f8: 8ea5        ldrh	r5, [r4, #52]	@ 0x34
@   0x080284fa: 4328        orrs	r0, r5
@   0x080284fc: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x080284fe: 1bb8        subs	r0, r7, r6
@   0x08028500: 00c0        lsls	r0, r0, #3
@   0x08028502: 4906        ldr	r1, [pc, #24]	@ (0x2851c)
@   0x08028504: 1840        adds	r0, r0, r1
@   0x08028506: f7dd        fa5d 	bl	0x59c4
@   0x0802850a: 1c70        adds	r0, r6, #1
@   0x0802850c: 0600        lsls	r0, r0, #24
@   0x0802850e: 0e06        lsrs	r6, r0, #24
@   0x08028510: 2e09        cmp	r6, #9
@   0x08028512: d800        bhi.n	0x28516
@   0x08028514: e6ae        b.n	0x28274
@   0x08028516: bcf0        pop	{r4, r5, r6, r7}
@   0x08028518: bc01        pop	{r0}
@   0x0802851a: 4700        bx	r0
@   0x0802851c: 3fe0        subs	r7, #224	@ 0xe0
@   0x0802851e: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08028270
sub_08028270: @ 0x08028270
        .incbin "baserom.gba", 0x28270, 0x2b0
        thumb_func_end sub_08028270
