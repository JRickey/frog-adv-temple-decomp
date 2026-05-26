@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08001214, 0x08001478)  (612 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8001214 --end 0x8001478 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08001214: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08001216: b082        sub	sp, #8
@   0x08001218: 4668        mov	r0, sp
@   0x0800121a: 3005        adds	r0, #5
@   0x0800121c: 2100        movs	r1, #0
@   0x0800121e: 7001        strb	r1, [r0, #0]
@   0x08001220: 4908        ldr	r1, [pc, #32]	@ (0x1244)
@   0x08001222: 1c06        adds	r6, r0, #0
@   0x08001224: 7a49        ldrb	r1, [r1, #9]
@   0x08001226: 290a        cmp	r1, #10
@   0x08001228: d000        beq.n	0x122c
@   0x0800122a: e11d        b.n	0x1468
@   0x0800122c: f01f        fcc8 	bl	0x20bc0
@   0x08001230: 7830        ldrb	r0, [r6, #0]
@   0x08001232: 2809        cmp	r0, #9
@   0x08001234: d900        bls.n	0x1238
@   0x08001236: e112        b.n	0x145e
@   0x08001238: 0080        lsls	r0, r0, #2
@   0x0800123a: 4903        ldr	r1, [pc, #12]	@ (0x1248)
@   0x0800123c: 1840        adds	r0, r0, r1
@   0x0800123e: 6800        ldr	r0, [r0, #0]
@   0x08001240: 4687        mov	pc, r0
@   0x08001242: 0000        movs	r0, r0
@   0x08001244: 5330        strh	r0, [r6, r4]
@   0x08001246: 0300        lsls	r0, r0, #12
@   0x08001248: 124c        asrs	r4, r1, #9
@   0x0800124a: 0800        lsrs	r0, r0, #32
@   0x0800124c: 1274        asrs	r4, r6, #9
@   0x0800124e: 0800        lsrs	r0, r0, #32
@   0x08001250: 1290        asrs	r0, r2, #10
@   0x08001252: 0800        lsrs	r0, r0, #32
@   0x08001254: 12b8        asrs	r0, r7, #10
@   0x08001256: 0800        lsrs	r0, r0, #32
@   0x08001258: 12ca        asrs	r2, r1, #11
@   0x0800125a: 0800        lsrs	r0, r0, #32
@   0x0800125c: 12f4        asrs	r4, r6, #11
@   0x0800125e: 0800        lsrs	r0, r0, #32
@   0x08001260: 136c        asrs	r4, r5, #13
@   0x08001262: 0800        lsrs	r0, r0, #32
@   0x08001264: 1382        asrs	r2, r0, #14
@   0x08001266: 0800        lsrs	r0, r0, #32
@   0x08001268: 13b4        asrs	r4, r6, #14
@   0x0800126a: 0800        lsrs	r0, r0, #32
@   0x0800126c: 13fc        asrs	r4, r7, #15
@   0x0800126e: 0800        lsrs	r0, r0, #32
@   0x08001270: 142c        asrs	r4, r5, #16
@   0x08001272: 0800        lsrs	r0, r0, #32
@   0x08001274: 4905        ldr	r1, [pc, #20]	@ (0x128c)
@   0x08001276: 2400        movs	r4, #0
@   0x08001278: 2003        movs	r0, #3
@   0x0800127a: 7288        strb	r0, [r1, #10]
@   0x0800127c: f008        ffca 	bl	0xa214
@   0x08001280: 1c07        adds	r7, r0, #0
@   0x08001282: 2001        movs	r0, #1
@   0x08001284: 7030        strb	r0, [r6, #0]
@   0x08001286: a801        add	r0, sp, #4
@   0x08001288: 7004        strb	r4, [r0, #0]
@   0x0800128a: e0e8        b.n	0x145e
@   0x0800128c: 5330        strh	r0, [r6, r4]
@   0x0800128e: 0300        lsls	r0, r0, #12
@   0x08001290: 4907        ldr	r1, [pc, #28]	@ (0x12b0)
@   0x08001292: a801        add	r0, sp, #4
@   0x08001294: f008        ff36 	bl	0xa104
@   0x08001298: 0600        lsls	r0, r0, #24
@   0x0800129a: 2800        cmp	r0, #0
@   0x0800129c: d100        bne.n	0x12a0
@   0x0800129e: e0be        b.n	0x141e
@   0x080012a0: 2002        movs	r0, #2
@   0x080012a2: 7030        strb	r0, [r6, #0]
@   0x080012a4: 4803        ldr	r0, [pc, #12]	@ (0x12b4)
@   0x080012a6: 2100        movs	r1, #0
@   0x080012a8: 6141        str	r1, [r0, #20]
@   0x080012aa: a801        add	r0, sp, #4
@   0x080012ac: 7001        strb	r1, [r0, #0]
@   0x080012ae: e0b6        b.n	0x141e
@   0x080012b0: 1485        asrs	r5, r0, #18
@   0x080012b2: 0800        lsrs	r0, r0, #32
@   0x080012b4: 5330        strh	r0, [r6, r4]
@   0x080012b6: 0300        lsls	r0, r0, #12
@   0x080012b8: 2003        movs	r0, #3
@   0x080012ba: f01a        f92b 	bl	0x1b514
@   0x080012be: 1c38        adds	r0, r7, #0
@   0x080012c0: f008        ffca 	bl	0xa258
@   0x080012c4: 2003        movs	r0, #3
@   0x080012c6: 7030        strb	r0, [r6, #0]
@   0x080012c8: e0c9        b.n	0x145e
@   0x080012ca: a801        add	r0, sp, #4
@   0x080012cc: f008        fd66 	bl	0x9d9c
@   0x080012d0: 2800        cmp	r0, #0
@   0x080012d2: d100        bne.n	0x12d6
@   0x080012d4: e0c3        b.n	0x145e
@   0x080012d6: 2004        movs	r0, #4
@   0x080012d8: 7030        strb	r0, [r6, #0]
@   0x080012da: 4904        ldr	r1, [pc, #16]	@ (0x12ec)
@   0x080012dc: 2000        movs	r0, #0
@   0x080012de: 6148        str	r0, [r1, #20]
@   0x080012e0: 4803        ldr	r0, [pc, #12]	@ (0x12f0)
@   0x080012e2: 2108        movs	r1, #8
@   0x080012e4: 2201        movs	r2, #1
@   0x080012e6: f005        f98b 	bl	0x6600
@   0x080012ea: e0b8        b.n	0x145e
@   0x080012ec: 5330        strh	r0, [r6, r4]
@   0x080012ee: 0300        lsls	r0, r0, #12
@   0x080012f0: 6110        str	r0, [r2, #16]
@   0x080012f2: 0300        lsls	r0, r0, #12
@   0x080012f4: f7ff        f8e6 	bl	0x4c4
@   0x080012f8: 4905        ldr	r1, [pc, #20]	@ (0x1310)
@   0x080012fa: 8008        strh	r0, [r1, #0]
@   0x080012fc: 0400        lsls	r0, r0, #16
@   0x080012fe: 0c00        lsrs	r0, r0, #16
@   0x08001300: 2840        cmp	r0, #64	@ 0x40
@   0x08001302: d107        bne.n	0x1314
@   0x08001304: 2006        movs	r0, #6
@   0x08001306: 7030        strb	r0, [r6, #0]
@   0x08001308: f00c        feaa 	bl	0xe060
@   0x0800130c: e0a7        b.n	0x145e
@   0x0800130e: 0000        movs	r0, r0
@   0x08001310: 5398        strh	r0, [r3, r6]
@   0x08001312: 0300        lsls	r0, r0, #12
@   0x08001314: 4904        ldr	r1, [pc, #16]	@ (0x1328)
@   0x08001316: 2208        movs	r2, #8
@   0x08001318: 1c10        adds	r0, r2, #0
@   0x0800131a: 8e89        ldrh	r1, [r1, #52]	@ 0x34
@   0x0800131c: 4008        ands	r0, r1
@   0x0800131e: 2800        cmp	r0, #0
@   0x08001320: d004        beq.n	0x132c
@   0x08001322: 2005        movs	r0, #5
@   0x08001324: 7030        strb	r0, [r6, #0]
@   0x08001326: e09a        b.n	0x145e
@   0x08001328: 3720        adds	r7, #32
@   0x0800132a: 0300        lsls	r0, r0, #12
@   0x0800132c: 4904        ldr	r1, [pc, #16]	@ (0x1340)
@   0x0800132e: 1c10        adds	r0, r2, #0
@   0x08001330: 8dc9        ldrh	r1, [r1, #46]	@ 0x2e
@   0x08001332: 4008        ands	r0, r1
@   0x08001334: 2800        cmp	r0, #0
@   0x08001336: d005        beq.n	0x1344
@   0x08001338: 2009        movs	r0, #9
@   0x0800133a: 7030        strb	r0, [r6, #0]
@   0x0800133c: e08f        b.n	0x145e
@   0x0800133e: 0000        movs	r0, r0
@   0x08001340: 6110        str	r0, [r2, #16]
@   0x08001342: 0300        lsls	r0, r0, #12
@   0x08001344: f008        ffc8 	bl	0xa2d8
@   0x08001348: f7ff        fac8 	bl	0x8dc
@   0x0800134c: f008        ffec 	bl	0xa328
@   0x08001350: f008        f8d2 	bl	0x94f8
@   0x08001354: f008        fb16 	bl	0x9984
@   0x08001358: f7ff        ff24 	bl	0x11a4
@   0x0800135c: 4902        ldr	r1, [pc, #8]	@ (0x1368)
@   0x0800135e: 6948        ldr	r0, [r1, #20]
@   0x08001360: 3001        adds	r0, #1
@   0x08001362: 6148        str	r0, [r1, #20]
@   0x08001364: e07b        b.n	0x145e
@   0x08001366: 0000        movs	r0, r0
@   0x08001368: 5330        strh	r0, [r6, r4]
@   0x0800136a: 0300        lsls	r0, r0, #12
@   0x0800136c: 1c30        adds	r0, r6, #0
@   0x0800136e: f008        fc51 	bl	0x9c14
@   0x08001372: 2800        cmp	r0, #0
@   0x08001374: d101        bne.n	0x137a
@   0x08001376: 2008        movs	r0, #8
@   0x08001378: 7030        strb	r0, [r6, #0]
@   0x0800137a: a901        add	r1, sp, #4
@   0x0800137c: 2000        movs	r0, #0
@   0x0800137e: 7008        strb	r0, [r1, #0]
@   0x08001380: e06d        b.n	0x145e
@   0x08001382: f7ff        f89f 	bl	0x4c4
@   0x08001386: 4909        ldr	r1, [pc, #36]	@ (0x13ac)
@   0x08001388: 8008        strh	r0, [r1, #0]
@   0x0800138a: f00d        f98d 	bl	0xe6a8
@   0x0800138e: 0600        lsls	r0, r0, #24
@   0x08001390: 0e01        lsrs	r1, r0, #24
@   0x08001392: 2900        cmp	r1, #0
@   0x08001394: d103        bne.n	0x139e
@   0x08001396: 2007        movs	r0, #7
@   0x08001398: 7030        strb	r0, [r6, #0]
@   0x0800139a: a801        add	r0, sp, #4
@   0x0800139c: 7001        strb	r1, [r0, #0]
@   0x0800139e: 4804        ldr	r0, [pc, #16]	@ (0x13b0)
@   0x080013a0: 7800        ldrb	r0, [r0, #0]
@   0x080013a2: 2800        cmp	r0, #0
@   0x080013a4: d15b        bne.n	0x145e
@   0x080013a6: 2004        movs	r0, #4
@   0x080013a8: 7030        strb	r0, [r6, #0]
@   0x080013aa: e058        b.n	0x145e
@   0x080013ac: 5398        strh	r0, [r3, r6]
@   0x080013ae: 0300        lsls	r0, r0, #12
@   0x080013b0: 5328        strh	r0, [r5, r4]
@   0x080013b2: 0300        lsls	r0, r0, #12
@   0x080013b4: a801        add	r0, sp, #4
@   0x080013b6: 7800        ldrb	r0, [r0, #0]
@   0x080013b8: 0600        lsls	r0, r0, #24
@   0x080013ba: 1600        asrs	r0, r0, #24
@   0x080013bc: 2800        cmp	r0, #0
@   0x080013be: d107        bne.n	0x13d0
@   0x080013c0: 20bf        movs	r0, #191	@ 0xbf
@   0x080013c2: f00f        f967 	bl	0x10694
@   0x080013c6: a801        add	r0, sp, #4
@   0x080013c8: 1c01        adds	r1, r0, #0
@   0x080013ca: 7809        ldrb	r1, [r1, #0]
@   0x080013cc: 3101        adds	r1, #1
@   0x080013ce: 7001        strb	r1, [r0, #0]
@   0x080013d0: a801        add	r0, sp, #4
@   0x080013d2: 2400        movs	r4, #0
@   0x080013d4: 5704        ldrsb	r4, [r0, r4]
@   0x080013d6: 2c01        cmp	r4, #1
@   0x080013d8: d141        bne.n	0x145e
@   0x080013da: f00f        f96d 	bl	0x106b8
@   0x080013de: 0600        lsls	r0, r0, #24
@   0x080013e0: 2800        cmp	r0, #0
@   0x080013e2: d13c        bne.n	0x145e
@   0x080013e4: 4803        ldr	r0, [pc, #12]	@ (0x13f4)
@   0x080013e6: 2104        movs	r1, #4
@   0x080013e8: 7001        strb	r1, [r0, #0]
@   0x080013ea: 7184        strb	r4, [r0, #6]
@   0x080013ec: 4802        ldr	r0, [pc, #8]	@ (0x13f8)
@   0x080013ee: 7241        strb	r1, [r0, #9]
@   0x080013f0: e035        b.n	0x145e
@   0x080013f2: 0000        movs	r0, r0
@   0x080013f4: 3480        adds	r4, #128	@ 0x80
@   0x080013f6: 0300        lsls	r0, r0, #12
@   0x080013f8: 5330        strh	r0, [r6, r4]
@   0x080013fa: 0300        lsls	r0, r0, #12
@   0x080013fc: 4909        ldr	r1, [pc, #36]	@ (0x1424)
@   0x080013fe: a801        add	r0, sp, #4
@   0x08001400: f008        fe80 	bl	0xa104
@   0x08001404: 0600        lsls	r0, r0, #24
@   0x08001406: 2800        cmp	r0, #0
@   0x08001408: d009        beq.n	0x141e
@   0x0800140a: 2003        movs	r0, #3
@   0x0800140c: 7030        strb	r0, [r6, #0]
@   0x0800140e: 4806        ldr	r0, [pc, #24]	@ (0x1428)
@   0x08001410: 2100        movs	r1, #0
@   0x08001412: 6141        str	r1, [r0, #20]
@   0x08001414: a801        add	r0, sp, #4
@   0x08001416: 7001        strb	r1, [r0, #0]
@   0x08001418: 1c38        adds	r0, r7, #0
@   0x0800141a: f008        ff1d 	bl	0xa258
@   0x0800141e: f7ff        fa5d 	bl	0x8dc
@   0x08001422: e01c        b.n	0x145e
@   0x08001424: a26d        add	r2, pc, #436	@ (adr r2, 0x15dc)
@   0x08001426: 0800        lsrs	r0, r0, #32
@   0x08001428: 5330        strh	r0, [r6, r4]
@   0x0800142a: 0300        lsls	r0, r0, #12
@   0x0800142c: 4c10        ldr	r4, [pc, #64]	@ (0x1470)
@   0x0800142e: 7e20        ldrb	r0, [r4, #24]
@   0x08001430: 7e61        ldrb	r1, [r4, #25]
@   0x08001432: 250f        movs	r5, #15
@   0x08001434: 9500        str	r5, [sp, #0]
@   0x08001436: 2206        movs	r2, #6
@   0x08001438: 230b        movs	r3, #11
@   0x0800143a: f00b        fbd5 	bl	0xcbe8
@   0x0800143e: 7e20        ldrb	r0, [r4, #24]
@   0x08001440: 7e61        ldrb	r1, [r4, #25]
@   0x08001442: 9500        str	r5, [sp, #0]
@   0x08001444: 2206        movs	r2, #6
@   0x08001446: 230a        movs	r3, #10
@   0x08001448: f00b        fbce 	bl	0xcbe8
@   0x0800144c: 7e20        ldrb	r0, [r4, #24]
@   0x0800144e: 7e61        ldrb	r1, [r4, #25]
@   0x08001450: 2207        movs	r2, #7
@   0x08001452: 9200        str	r2, [sp, #0]
@   0x08001454: 230b        movs	r3, #11
@   0x08001456: f00b        fbc7 	bl	0xcbe8
@   0x0800145a: f00c        fd11 	bl	0xde80
@   0x0800145e: 4805        ldr	r0, [pc, #20]	@ (0x1474)
@   0x08001460: 7a40        ldrb	r0, [r0, #9]
@   0x08001462: 280a        cmp	r0, #10
@   0x08001464: d100        bne.n	0x1468
@   0x08001466: e6e1        b.n	0x122c
@   0x08001468: b002        add	sp, #8
@   0x0800146a: bcf0        pop	{r4, r5, r6, r7}
@   0x0800146c: bc01        pop	{r0}
@   0x0800146e: 4700        bx	r0
@   0x08001470: 35e0        adds	r5, #224	@ 0xe0
@   0x08001472: 0300        lsls	r0, r0, #12
@   0x08001474: 5330        strh	r0, [r6, r4]
@   0x08001476: 0300        lsls	r0, r0, #12

        thumb_func_start sub_08001214
sub_08001214: @ 0x08001214
        .incbin "frog_us_baserom.gba", 0x1214, 0x264
        thumb_func_end sub_08001214
