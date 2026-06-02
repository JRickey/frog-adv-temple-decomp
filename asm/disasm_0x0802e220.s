@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802e220, 0x0802e380)  (352 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802e220 --end 0x802e380 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802e220: b510        push	{r4, lr}
@   0x0802e222: 1c03        adds	r3, r0, #0
@   0x0802e224: 2b00        cmp	r3, #0
@   0x0802e226: d019        beq.n	0x2e25c
@   0x0802e228: 0c1a        lsrs	r2, r3, #16
@   0x0802e22a: 20ff        movs	r0, #255	@ 0xff
@   0x0802e22c: 4002        ands	r2, r0
@   0x0802e22e: 4809        ldr	r0, [pc, #36]	@ (0x2e254)
@   0x0802e230: 6804        ldr	r4, [r0, #0]
@   0x0802e232: 2190        movs	r1, #144	@ 0x90
@   0x0802e234: 0049        lsls	r1, r1, #1
@   0x0802e236: 1860        adds	r0, r4, r1
@   0x0802e238: 6801        ldr	r1, [r0, #0]
@   0x0802e23a: 0090        lsls	r0, r2, #2
@   0x0802e23c: 1840        adds	r0, r0, r1
@   0x0802e23e: 6800        ldr	r0, [r0, #0]
@   0x0802e240: 4298        cmp	r0, r3
@   0x0802e242: d10b        bne.n	0x2e25c
@   0x0802e244: 2a02        cmp	r2, #2
@   0x0802e246: dc07        bgt.n	0x2e258
@   0x0802e248: 00d0        lsls	r0, r2, #3
@   0x0802e24a: 1880        adds	r0, r0, r2
@   0x0802e24c: 0080        lsls	r0, r0, #2
@   0x0802e24e: 1820        adds	r0, r4, r0
@   0x0802e250: 8c00        ldrh	r0, [r0, #32]
@   0x0802e252: e00d        b.n	0x2e270
@   0x0802e254: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e256: 0300        lsls	r0, r0, #12
@   0x0802e258: 2a03        cmp	r2, #3
@   0x0802e25a: dc01        bgt.n	0x2e260
@   0x0802e25c: 2000        movs	r0, #0
@   0x0802e25e: e007        b.n	0x2e270
@   0x0802e260: 1c20        adds	r0, r4, #0
@   0x0802e262: 30c8        adds	r0, #200	@ 0xc8
@   0x0802e264: 6801        ldr	r1, [r0, #0]
@   0x0802e266: 0190        lsls	r0, r2, #6
@   0x0802e268: 1840        adds	r0, r0, r1
@   0x0802e26a: 4903        ldr	r1, [pc, #12]	@ (0x2e278)
@   0x0802e26c: 1840        adds	r0, r0, r1
@   0x0802e26e: 8800        ldrh	r0, [r0, #0]
@   0x0802e270: bc10        pop	{r4}
@   0x0802e272: bc02        pop	{r1}
@   0x0802e274: 4708        bx	r1
@   0x0802e276: 0000        movs	r0, r0
@   0x0802e278: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0802e27c: 1c01        adds	r1, r0, #0
@   0x0802e27e: 2900        cmp	r1, #0
@   0x0802e280: d108        bne.n	0x2e294
@   0x0802e282: 4803        ldr	r0, [pc, #12]	@ (0x2e290)
@   0x0802e284: 6800        ldr	r0, [r0, #0]
@   0x0802e286: 2287        movs	r2, #135	@ 0x87
@   0x0802e288: 0052        lsls	r2, r2, #1
@   0x0802e28a: 1880        adds	r0, r0, r2
@   0x0802e28c: 7001        strb	r1, [r0, #0]
@   0x0802e28e: e00d        b.n	0x2e2ac
@   0x0802e290: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e292: 0300        lsls	r0, r0, #12
@   0x0802e294: 4806        ldr	r0, [pc, #24]	@ (0x2e2b0)
@   0x0802e296: 6802        ldr	r2, [r0, #0]
@   0x0802e298: 1c10        adds	r0, r2, #0
@   0x0802e29a: 30f4        adds	r0, #244	@ 0xf4
@   0x0802e29c: 6801        ldr	r1, [r0, #0]
@   0x0802e29e: 4248        negs	r0, r1
@   0x0802e2a0: 4308        orrs	r0, r1
@   0x0802e2a2: 0fc0        lsrs	r0, r0, #31
@   0x0802e2a4: 2387        movs	r3, #135	@ 0x87
@   0x0802e2a6: 005b        lsls	r3, r3, #1
@   0x0802e2a8: 18d1        adds	r1, r2, r3
@   0x0802e2aa: 7008        strb	r0, [r1, #0]
@   0x0802e2ac: 4770        bx	lr
@   0x0802e2ae: 0000        movs	r0, r0
@   0x0802e2b0: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e2b2: 0300        lsls	r0, r0, #12
@   0x0802e2b4: 4801        ldr	r0, [pc, #4]	@ (0x2e2bc)
@   0x0802e2b6: 6800        ldr	r0, [r0, #0]
@   0x0802e2b8: 6880        ldr	r0, [r0, #8]
@   0x0802e2ba: 4770        bx	lr
@   0x0802e2bc: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e2be: 0300        lsls	r0, r0, #12
@   0x0802e2c0: 1c02        adds	r2, r0, #0
@   0x0802e2c2: 4803        ldr	r0, [pc, #12]	@ (0x2e2d0)
@   0x0802e2c4: 6801        ldr	r1, [r0, #0]
@   0x0802e2c6: 6888        ldr	r0, [r1, #8]
@   0x0802e2c8: 4050        eors	r0, r2
@   0x0802e2ca: 608a        str	r2, [r1, #8]
@   0x0802e2cc: 4770        bx	lr
@   0x0802e2ce: 0000        movs	r0, r0
@   0x0802e2d0: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e2d2: 0300        lsls	r0, r0, #12
@   0x0802e2d4: 4904        ldr	r1, [pc, #16]	@ (0x2e2e8)
@   0x0802e2d6: 680a        ldr	r2, [r1, #0]
@   0x0802e2d8: 2101        movs	r1, #1
@   0x0802e2da: 4081        lsls	r1, r0
@   0x0802e2dc: 6890        ldr	r0, [r2, #8]
@   0x0802e2de: 4008        ands	r0, r1
@   0x0802e2e0: 2800        cmp	r0, #0
@   0x0802e2e2: d000        beq.n	0x2e2e6
@   0x0802e2e4: 2001        movs	r0, #1
@   0x0802e2e6: 4770        bx	lr
@   0x0802e2e8: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e2ea: 0300        lsls	r0, r0, #12
@   0x0802e2ec: 2101        movs	r1, #1
@   0x0802e2ee: 4081        lsls	r1, r0
@   0x0802e2f0: 4805        ldr	r0, [pc, #20]	@ (0x2e308)
@   0x0802e2f2: 6802        ldr	r2, [r0, #0]
@   0x0802e2f4: 6893        ldr	r3, [r2, #8]
@   0x0802e2f6: 1c18        adds	r0, r3, #0
@   0x0802e2f8: 4308        orrs	r0, r1
@   0x0802e2fa: 6090        str	r0, [r2, #8]
@   0x0802e2fc: 1c18        adds	r0, r3, #0
@   0x0802e2fe: 4008        ands	r0, r1
@   0x0802e300: 2800        cmp	r0, #0
@   0x0802e302: d000        beq.n	0x2e306
@   0x0802e304: 2001        movs	r0, #1
@   0x0802e306: 4770        bx	lr
@   0x0802e308: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e30a: 0300        lsls	r0, r0, #12
@   0x0802e30c: 2101        movs	r1, #1
@   0x0802e30e: 4081        lsls	r1, r0
@   0x0802e310: 4805        ldr	r0, [pc, #20]	@ (0x2e328)
@   0x0802e312: 6802        ldr	r2, [r0, #0]
@   0x0802e314: 6893        ldr	r3, [r2, #8]
@   0x0802e316: 1c18        adds	r0, r3, #0
@   0x0802e318: 4388        bics	r0, r1
@   0x0802e31a: 6090        str	r0, [r2, #8]
@   0x0802e31c: 1c18        adds	r0, r3, #0
@   0x0802e31e: 4008        ands	r0, r1
@   0x0802e320: 2800        cmp	r0, #0
@   0x0802e322: d000        beq.n	0x2e326
@   0x0802e324: 2001        movs	r0, #1
@   0x0802e326: 4770        bx	lr
@   0x0802e328: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e32a: 0300        lsls	r0, r0, #12
@   0x0802e32c: 0600        lsls	r0, r0, #24
@   0x0802e32e: 0e01        lsrs	r1, r0, #24
@   0x0802e330: 4803        ldr	r0, [pc, #12]	@ (0x2e340)
@   0x0802e332: 6802        ldr	r2, [r0, #0]
@   0x0802e334: 8191        strh	r1, [r2, #12]
@   0x0802e336: 2900        cmp	r1, #0
@   0x0802e338: d001        beq.n	0x2e33e
@   0x0802e33a: 1c48        adds	r0, r1, #1
@   0x0802e33c: 8190        strh	r0, [r2, #12]
@   0x0802e33e: 4770        bx	lr
@   0x0802e340: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e342: 0300        lsls	r0, r0, #12
@   0x0802e344: 0600        lsls	r0, r0, #24
@   0x0802e346: 0e01        lsrs	r1, r0, #24
@   0x0802e348: 4803        ldr	r0, [pc, #12]	@ (0x2e358)
@   0x0802e34a: 6802        ldr	r2, [r0, #0]
@   0x0802e34c: 81d1        strh	r1, [r2, #14]
@   0x0802e34e: 2900        cmp	r1, #0
@   0x0802e350: d001        beq.n	0x2e356
@   0x0802e352: 1c48        adds	r0, r1, #1
@   0x0802e354: 81d0        strh	r0, [r2, #14]
@   0x0802e356: 4770        bx	lr
@   0x0802e358: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e35a: 0300        lsls	r0, r0, #12
@   0x0802e35c: 0600        lsls	r0, r0, #24
@   0x0802e35e: 0e00        lsrs	r0, r0, #24
@   0x0802e360: 4901        ldr	r1, [pc, #4]	@ (0x2e368)
@   0x0802e362: 7008        strb	r0, [r1, #0]
@   0x0802e364: 4770        bx	lr
@   0x0802e366: 0000        movs	r0, r0
@   0x0802e368: 0082        lsls	r2, r0, #2
@   0x0802e36a: 0400        lsls	r0, r0, #16
@   0x0802e36c: 0600        lsls	r0, r0, #24
@   0x0802e36e: 0e00        lsrs	r0, r0, #24
@   0x0802e370: 4a02        ldr	r2, [pc, #8]	@ (0x2e37c)
@   0x0802e372: 2177        movs	r1, #119	@ 0x77
@   0x0802e374: 4008        ands	r0, r1
@   0x0802e376: 7010        strb	r0, [r2, #0]
@   0x0802e378: 4770        bx	lr
@   0x0802e37a: 0000        movs	r0, r0
@   0x0802e37c: 0080        lsls	r0, r0, #2
@   0x0802e37e: 0400        lsls	r0, r0, #16

        thumb_func_start sub_0802E220
sub_0802E220: @ 0x0802e220
        .incbin "frog_us_baserom.gba", 0x2e220, 0x160
        thumb_func_end sub_0802E220
