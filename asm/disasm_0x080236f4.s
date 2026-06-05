@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080236f4, 0x08023ab4)  (960 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80236f4 --end 0x8023ab4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080236f4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080236f6: 4657        mov	r7, sl
@   0x080236f8: 464e        mov	r6, r9
@   0x080236fa: 4645        mov	r5, r8
@   0x080236fc: b4e0        push	{r5, r6, r7}
@   0x080236fe: b084        sub	sp, #16
@   0x08023700: 4a0d        ldr	r2, [pc, #52]	@ (0x23738)
@   0x08023702: 2004        movs	r0, #4
@   0x08023704: 5e11        ldrsh	r1, [r2, r0]
@   0x08023706: 480d        ldr	r0, [pc, #52]	@ (0x2373c)
@   0x08023708: 4281        cmp	r1, r0
@   0x0802370a: dd00        ble.n	0x2370e
@   0x0802370c: e1c4        b.n	0x23a98
@   0x0802370e: 2700        movs	r7, #0
@   0x08023710: 2180        movs	r1, #128	@ 0x80
@   0x08023712: 0209        lsls	r1, r1, #8
@   0x08023714: 468a        mov	sl, r1
@   0x08023716: 1c39        adds	r1, r7, #0
@   0x08023718: 3167        adds	r1, #103	@ 0x67
@   0x0802371a: 00c8        lsls	r0, r1, #3
@   0x0802371c: 1a40        subs	r0, r0, r1
@   0x0802371e: 00c0        lsls	r0, r0, #3
@   0x08023720: 4a05        ldr	r2, [pc, #20]	@ (0x23738)
@   0x08023722: 1886        adds	r6, r0, r2
@   0x08023724: 7eb2        ldrb	r2, [r6, #26]
@   0x08023726: 4688        mov	r8, r1
@   0x08023728: 2a01        cmp	r2, #1
@   0x0802372a: d100        bne.n	0x2372e
@   0x0802372c: e090        b.n	0x23850
@   0x0802372e: 2a01        cmp	r2, #1
@   0x08023730: dc06        bgt.n	0x23740
@   0x08023732: 2a00        cmp	r2, #0
@   0x08023734: d00a        beq.n	0x2374c
@   0x08023736: e0d7        b.n	0x238e8
@   0x08023738: 3720        adds	r7, #32
@   0x0802373a: 0300        lsls	r0, r0, #12
@   0x0802373c: 0101        lsls	r1, r0, #4
@   0x0802373e: 0000        movs	r0, r0
@   0x08023740: 2a02        cmp	r2, #2
@   0x08023742: d100        bne.n	0x23746
@   0x08023744: e098        b.n	0x23878
@   0x08023746: 2a03        cmp	r2, #3
@   0x08023748: d014        beq.n	0x23774
@   0x0802374a: e0cd        b.n	0x238e8
@   0x0802374c: 8eb1        ldrh	r1, [r6, #52]	@ 0x34
@   0x0802374e: 2202        movs	r2, #2
@   0x08023750: 2002        movs	r0, #2
@   0x08023752: 4008        ands	r0, r1
@   0x08023754: 2800        cmp	r0, #0
@   0x08023756: d000        beq.n	0x2375a
@   0x08023758: e0c6        b.n	0x238e8
@   0x0802375a: 4650        mov	r0, sl
@   0x0802375c: 4008        ands	r0, r1
@   0x0802375e: 2800        cmp	r0, #0
@   0x08023760: d100        bne.n	0x23764
@   0x08023762: e0c1        b.n	0x238e8
@   0x08023764: 1c10        adds	r0, r2, #0
@   0x08023766: 4308        orrs	r0, r1
@   0x08023768: 4b01        ldr	r3, [pc, #4]	@ (0x23770)
@   0x0802376a: 1c19        adds	r1, r3, #0
@   0x0802376c: e07e        b.n	0x2386c
@   0x0802376e: 0000        movs	r0, r0
@   0x08023770: 7fff        ldrb	r7, [r7, #31]
@   0x08023772: 0000        movs	r0, r0
@   0x08023774: 8eb1        ldrh	r1, [r6, #52]	@ 0x34
@   0x08023776: 2302        movs	r3, #2
@   0x08023778: 1c18        adds	r0, r3, #0
@   0x0802377a: 4008        ands	r0, r1
@   0x0802377c: 2800        cmp	r0, #0
@   0x0802377e: d000        beq.n	0x23782
@   0x08023780: e0b2        b.n	0x238e8
@   0x08023782: 4650        mov	r0, sl
@   0x08023784: 4008        ands	r0, r1
@   0x08023786: 2800        cmp	r0, #0
@   0x08023788: d100        bne.n	0x2378c
@   0x0802378a: e0ad        b.n	0x238e8
@   0x0802378c: 2f00        cmp	r7, #0
@   0x0802378e: d111        bne.n	0x237b4
@   0x08023790: 4806        ldr	r0, [pc, #24]	@ (0x237ac)
@   0x08023792: 6841        ldr	r1, [r0, #4]
@   0x08023794: 4806        ldr	r0, [pc, #24]	@ (0x237b0)
@   0x08023796: 9000        str	r0, [sp, #0]
@   0x08023798: 200a        movs	r0, #10
@   0x0802379a: 9001        str	r0, [sp, #4]
@   0x0802379c: 9202        str	r2, [sp, #8]
@   0x0802379e: 9303        str	r3, [sp, #12]
@   0x080237a0: 2068        movs	r0, #104	@ 0x68
@   0x080237a2: 2210        movs	r2, #16
@   0x080237a4: 231c        movs	r3, #28
@   0x080237a6: f7fd        fc7b 	bl	0x210a0
@   0x080237aa: e012        b.n	0x237d2
@   0x080237ac: 2c98        cmp	r4, #152	@ 0x98
@   0x080237ae: 0831        lsrs	r1, r6, #32
@   0x080237b0: 0211        lsls	r1, r2, #8
@   0x080237b2: 0000        movs	r0, r0
@   0x080237b4: 2f01        cmp	r7, #1
@   0x080237b6: d10c        bne.n	0x237d2
@   0x080237b8: 481f        ldr	r0, [pc, #124]	@ (0x23838)
@   0x080237ba: 6881        ldr	r1, [r0, #8]
@   0x080237bc: 481f        ldr	r0, [pc, #124]	@ (0x2383c)
@   0x080237be: 9000        str	r0, [sp, #0]
@   0x080237c0: 200a        movs	r0, #10
@   0x080237c2: 9001        str	r0, [sp, #4]
@   0x080237c4: 9202        str	r2, [sp, #8]
@   0x080237c6: 9303        str	r3, [sp, #12]
@   0x080237c8: 2069        movs	r0, #105	@ 0x69
@   0x080237ca: 2210        movs	r2, #16
@   0x080237cc: 231c        movs	r3, #28
@   0x080237ce: f7fd        fc67 	bl	0x210a0
@   0x080237d2: 1c3d        adds	r5, r7, #0
@   0x080237d4: 356c        adds	r5, #108	@ 0x6c
@   0x080237d6: 491a        ldr	r1, [pc, #104]	@ (0x23840)
@   0x080237d8: 00b8        lsls	r0, r7, #2
@   0x080237da: 1840        adds	r0, r0, r1
@   0x080237dc: 6804        ldr	r4, [r0, #0]
@   0x080237de: 1c38        adds	r0, r7, #0
@   0x080237e0: 2105        movs	r1, #5
@   0x080237e2: f010        fbbb 	bl	0x33f5c
@   0x080237e6: 0600        lsls	r0, r0, #24
@   0x080237e8: 0900        lsrs	r0, r0, #4
@   0x080237ea: 4916        ldr	r1, [pc, #88]	@ (0x23844)
@   0x080237ec: 1840        adds	r0, r0, r1
@   0x080237ee: 0c00        lsrs	r0, r0, #16
@   0x080237f0: 9000        str	r0, [sp, #0]
@   0x080237f2: 200b        movs	r0, #11
@   0x080237f4: 9001        str	r0, [sp, #4]
@   0x080237f6: 2003        movs	r0, #3
@   0x080237f8: 9002        str	r0, [sp, #8]
@   0x080237fa: 2002        movs	r0, #2
@   0x080237fc: 9003        str	r0, [sp, #12]
@   0x080237fe: 1c28        adds	r0, r5, #0
@   0x08023800: 1c21        adds	r1, r4, #0
@   0x08023802: 2210        movs	r2, #16
@   0x08023804: 231d        movs	r3, #29
@   0x08023806: f7fd        fc4b 	bl	0x210a0
@   0x0802380a: 4642        mov	r2, r8
@   0x0802380c: 00d0        lsls	r0, r2, #3
@   0x0802380e: 1a80        subs	r0, r0, r2
@   0x08023810: 00c0        lsls	r0, r0, #3
@   0x08023812: 4b0d        ldr	r3, [pc, #52]	@ (0x23848)
@   0x08023814: 18c0        adds	r0, r0, r3
@   0x08023816: 2100        movs	r1, #0
@   0x08023818: 7681        strb	r1, [r0, #26]
@   0x0802381a: 2102        movs	r1, #2
@   0x0802381c: 8e82        ldrh	r2, [r0, #52]	@ 0x34
@   0x0802381e: 4311        orrs	r1, r2
@   0x08023820: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x08023822: 00f8        lsls	r0, r7, #3
@   0x08023824: 1bc0        subs	r0, r0, r7
@   0x08023826: 00c0        lsls	r0, r0, #3
@   0x08023828: 4b08        ldr	r3, [pc, #32]	@ (0x2384c)
@   0x0802382a: 18c0        adds	r0, r0, r3
@   0x0802382c: 2124        movs	r1, #36	@ 0x24
@   0x0802382e: 220f        movs	r2, #15
@   0x08023830: 2305        movs	r3, #5
@   0x08023832: f7fd        fa53 	bl	0x20cdc
@   0x08023836: e057        b.n	0x238e8
@   0x08023838: 2c98        cmp	r4, #152	@ 0x98
@   0x0802383a: 0831        lsrs	r1, r6, #32
@   0x0802383c: 0231        lsls	r1, r6, #8
@   0x0802383e: 0000        movs	r0, r0
@   0x08023840: 2d4c        cmp	r5, #76	@ 0x4c
@   0x08023842: 0831        lsrs	r1, r6, #32
@   0x08023844: 0000        movs	r0, r0
@   0x08023846: 0291        lsls	r1, r2, #10
@   0x08023848: 3720        adds	r7, #32
@   0x0802384a: 0300        lsls	r0, r0, #12
@   0x0802384c: 4da8        ldr	r5, [pc, #672]	@ (0x23af0)
@   0x0802384e: 0300        lsls	r0, r0, #12
@   0x08023850: 8eb1        ldrh	r1, [r6, #52]	@ 0x34
@   0x08023852: 2202        movs	r2, #2
@   0x08023854: 2002        movs	r0, #2
@   0x08023856: 4008        ands	r0, r1
@   0x08023858: 2800        cmp	r0, #0
@   0x0802385a: d145        bne.n	0x238e8
@   0x0802385c: 4650        mov	r0, sl
@   0x0802385e: 4008        ands	r0, r1
@   0x08023860: 2800        cmp	r0, #0
@   0x08023862: d041        beq.n	0x238e8
@   0x08023864: 1c10        adds	r0, r2, #0
@   0x08023866: 4308        orrs	r0, r1
@   0x08023868: 4a02        ldr	r2, [pc, #8]	@ (0x23874)
@   0x0802386a: 1c11        adds	r1, r2, #0
@   0x0802386c: 4008        ands	r0, r1
@   0x0802386e: 86b0        strh	r0, [r6, #52]	@ 0x34
@   0x08023870: e03a        b.n	0x238e8
@   0x08023872: 0000        movs	r0, r0
@   0x08023874: 7fff        ldrb	r7, [r7, #31]
@   0x08023876: 0000        movs	r0, r0
@   0x08023878: 8eb0        ldrh	r0, [r6, #52]	@ 0x34
@   0x0802387a: 2302        movs	r3, #2
@   0x0802387c: 4699        mov	r9, r3
@   0x0802387e: 4002        ands	r2, r0
@   0x08023880: 2a00        cmp	r2, #0
@   0x08023882: d131        bne.n	0x238e8
@   0x08023884: 4651        mov	r1, sl
@   0x08023886: 4008        ands	r0, r1
@   0x08023888: 2800        cmp	r0, #0
@   0x0802388a: d02d        beq.n	0x238e8
@   0x0802388c: 1c3d        adds	r5, r7, #0
@   0x0802388e: 356c        adds	r5, #108	@ 0x6c
@   0x08023890: 492c        ldr	r1, [pc, #176]	@ (0x23944)
@   0x08023892: 00b8        lsls	r0, r7, #2
@   0x08023894: 1840        adds	r0, r0, r1
@   0x08023896: 6804        ldr	r4, [r0, #0]
@   0x08023898: 1c38        adds	r0, r7, #0
@   0x0802389a: 2105        movs	r1, #5
@   0x0802389c: f010        fb5e 	bl	0x33f5c
@   0x080238a0: 0600        lsls	r0, r0, #24
@   0x080238a2: 0900        lsrs	r0, r0, #4
@   0x080238a4: 4a28        ldr	r2, [pc, #160]	@ (0x23948)
@   0x080238a6: 1880        adds	r0, r0, r2
@   0x080238a8: 0c00        lsrs	r0, r0, #16
@   0x080238aa: 9000        str	r0, [sp, #0]
@   0x080238ac: 200b        movs	r0, #11
@   0x080238ae: 9001        str	r0, [sp, #4]
@   0x080238b0: 2003        movs	r0, #3
@   0x080238b2: 9002        str	r0, [sp, #8]
@   0x080238b4: 9003        str	r0, [sp, #12]
@   0x080238b6: 1c28        adds	r0, r5, #0
@   0x080238b8: 1c21        adds	r1, r4, #0
@   0x080238ba: 2210        movs	r2, #16
@   0x080238bc: 231d        movs	r3, #29
@   0x080238be: f7fd        fbef 	bl	0x210a0
@   0x080238c2: 2001        movs	r0, #1
@   0x080238c4: 76b0        strb	r0, [r6, #26]
@   0x080238c6: 8eb0        ldrh	r0, [r6, #52]	@ 0x34
@   0x080238c8: 464b        mov	r3, r9
@   0x080238ca: 4318        orrs	r0, r3
@   0x080238cc: 4a1f        ldr	r2, [pc, #124]	@ (0x2394c)
@   0x080238ce: 1c11        adds	r1, r2, #0
@   0x080238d0: 4008        ands	r0, r1
@   0x080238d2: 86b0        strh	r0, [r6, #52]	@ 0x34
@   0x080238d4: 2f04        cmp	r7, #4
@   0x080238d6: d107        bne.n	0x238e8
@   0x080238d8: 4b1d        ldr	r3, [pc, #116]	@ (0x23950)
@   0x080238da: 491e        ldr	r1, [pc, #120]	@ (0x23954)
@   0x080238dc: 1858        adds	r0, r3, r1
@   0x080238de: 2124        movs	r1, #36	@ 0x24
@   0x080238e0: 2204        movs	r2, #4
@   0x080238e2: 2304        movs	r3, #4
@   0x080238e4: f7fd        f9fa 	bl	0x20cdc
@   0x080238e8: 481b        ldr	r0, [pc, #108]	@ (0x23958)
@   0x080238ea: 4641        mov	r1, r8
@   0x080238ec: f7e3        f83e 	bl	0x696c
@   0x080238f0: 1c78        adds	r0, r7, #1
@   0x080238f2: 0600        lsls	r0, r0, #24
@   0x080238f4: 0e07        lsrs	r7, r0, #24
@   0x080238f6: 2f04        cmp	r7, #4
@   0x080238f8: d800        bhi.n	0x238fc
@   0x080238fa: e70c        b.n	0x23716
@   0x080238fc: 2067        movs	r0, #103	@ 0x67
@   0x080238fe: 2169        movs	r1, #105	@ 0x69
@   0x08023900: f7e2        fa06 	bl	0x5d10
@   0x08023904: 206a        movs	r0, #106	@ 0x6a
@   0x08023906: 216b        movs	r1, #107	@ 0x6b
@   0x08023908: f7e2        fa02 	bl	0x5d10
@   0x0802390c: 2700        movs	r7, #0
@   0x0802390e: 4e10        ldr	r6, [pc, #64]	@ (0x23950)
@   0x08023910: 2208        movs	r2, #8
@   0x08023912: 4692        mov	sl, r2
@   0x08023914: 2380        movs	r3, #128	@ 0x80
@   0x08023916: 021b        lsls	r3, r3, #8
@   0x08023918: 4698        mov	r8, r3
@   0x0802391a: 1c38        adds	r0, r7, #0
@   0x0802391c: 306c        adds	r0, #108	@ 0x6c
@   0x0802391e: 00c1        lsls	r1, r0, #3
@   0x08023920: 1a09        subs	r1, r1, r0
@   0x08023922: 00c9        lsls	r1, r1, #3
@   0x08023924: 198c        adds	r4, r1, r6
@   0x08023926: 8ea2        ldrh	r2, [r4, #52]	@ 0x34
@   0x08023928: 2108        movs	r1, #8
@   0x0802392a: 4011        ands	r1, r2
@   0x0802392c: 4681        mov	r9, r0
@   0x0802392e: 2900        cmp	r1, #0
@   0x08023930: d000        beq.n	0x23934
@   0x08023932: e096        b.n	0x23a62
@   0x08023934: 7ea0        ldrb	r0, [r4, #26]
@   0x08023936: 2801        cmp	r0, #1
@   0x08023938: d054        beq.n	0x239e4
@   0x0802393a: 2801        cmp	r0, #1
@   0x0802393c: dc0e        bgt.n	0x2395c
@   0x0802393e: 2800        cmp	r0, #0
@   0x08023940: d011        beq.n	0x23966
@   0x08023942: e08a        b.n	0x23a5a
@   0x08023944: 2d4c        cmp	r5, #76	@ 0x4c
@   0x08023946: 0831        lsrs	r1, r6, #32
@   0x08023948: 0000        movs	r0, r0
@   0x0802394a: 0291        lsls	r1, r2, #10
@   0x0802394c: 7fff        ldrb	r7, [r7, #31]
@   0x0802394e: 0000        movs	r0, r0
@   0x08023950: 3720        adds	r7, #32
@   0x08023952: 0300        lsls	r0, r0, #12
@   0x08023954: 1768        asrs	r0, r5, #29
@   0x08023956: 0000        movs	r0, r0
@   0x08023958: 6110        str	r0, [r2, #16]
@   0x0802395a: 0300        lsls	r0, r0, #12
@   0x0802395c: 2802        cmp	r0, #2
@   0x0802395e: d058        beq.n	0x23a12
@   0x08023960: 2803        cmp	r0, #3
@   0x08023962: d018        beq.n	0x23996
@   0x08023964: e079        b.n	0x23a5a
@   0x08023966: 2302        movs	r3, #2
@   0x08023968: 2002        movs	r0, #2
@   0x0802396a: 4010        ands	r0, r2
@   0x0802396c: 2800        cmp	r0, #0
@   0x0802396e: d174        bne.n	0x23a5a
@   0x08023970: 4640        mov	r0, r8
@   0x08023972: 4010        ands	r0, r2
@   0x08023974: 2800        cmp	r0, #0
@   0x08023976: d070        beq.n	0x23a5a
@   0x08023978: 1c39        adds	r1, r7, #0
@   0x0802397a: 3167        adds	r1, #103	@ 0x67
@   0x0802397c: 00c8        lsls	r0, r1, #3
@   0x0802397e: 1a40        subs	r0, r0, r1
@   0x08023980: 00c0        lsls	r0, r0, #3
@   0x08023982: 1980        adds	r0, r0, r6
@   0x08023984: 8e81        ldrh	r1, [r0, #52]	@ 0x34
@   0x08023986: 4319        orrs	r1, r3
@   0x08023988: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x0802398a: 2103        movs	r1, #3
@   0x0802398c: 7681        strb	r1, [r0, #26]
@   0x0802398e: 4650        mov	r0, sl
@   0x08023990: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08023992: 4308        orrs	r0, r1
@   0x08023994: e060        b.n	0x23a58
@   0x08023996: 2502        movs	r5, #2
@   0x08023998: 2002        movs	r0, #2
@   0x0802399a: 4010        ands	r0, r2
@   0x0802399c: 0400        lsls	r0, r0, #16
@   0x0802399e: 0c03        lsrs	r3, r0, #16
@   0x080239a0: 2b00        cmp	r3, #0
@   0x080239a2: d15a        bne.n	0x23a5a
@   0x080239a4: 2002        movs	r0, #2
@   0x080239a6: 5e21        ldrsh	r1, [r4, r0]
@   0x080239a8: 480d        ldr	r0, [pc, #52]	@ (0x239e0)
@   0x080239aa: 4281        cmp	r1, r0
@   0x080239ac: dc0f        bgt.n	0x239ce
@   0x080239ae: 76a3        strb	r3, [r4, #26]
@   0x080239b0: 1c28        adds	r0, r5, #0
@   0x080239b2: 4310        orrs	r0, r2
@   0x080239b4: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x080239b6: 00f8        lsls	r0, r7, #3
@   0x080239b8: 1bc0        subs	r0, r0, r7
@   0x080239ba: 00c0        lsls	r0, r0, #3
@   0x080239bc: 22bd        movs	r2, #189	@ 0xbd
@   0x080239be: 0152        lsls	r2, r2, #5
@   0x080239c0: 18b1        adds	r1, r6, r2
@   0x080239c2: 1840        adds	r0, r0, r1
@   0x080239c4: 2100        movs	r1, #0
@   0x080239c6: 2200        movs	r2, #0
@   0x080239c8: 2300        movs	r3, #0
@   0x080239ca: f7e6        fdd9 	bl	0xa580
@   0x080239ce: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x080239d0: 4640        mov	r0, r8
@   0x080239d2: 4008        ands	r0, r1
@   0x080239d4: 2800        cmp	r0, #0
@   0x080239d6: d040        beq.n	0x23a5a
@   0x080239d8: 1c08        adds	r0, r1, #0
@   0x080239da: 4328        orrs	r0, r5
@   0x080239dc: e039        b.n	0x23a52
@   0x080239de: 0000        movs	r0, r0
@   0x080239e0: 038b        lsls	r3, r1, #14
@   0x080239e2: 0000        movs	r0, r0
@   0x080239e4: 2302        movs	r3, #2
@   0x080239e6: 2002        movs	r0, #2
@   0x080239e8: 4010        ands	r0, r2
@   0x080239ea: 2800        cmp	r0, #0
@   0x080239ec: d135        bne.n	0x23a5a
@   0x080239ee: 4640        mov	r0, r8
@   0x080239f0: 4010        ands	r0, r2
@   0x080239f2: 2800        cmp	r0, #0
@   0x080239f4: d031        beq.n	0x23a5a
@   0x080239f6: 1c39        adds	r1, r7, #0
@   0x080239f8: 3167        adds	r1, #103	@ 0x67
@   0x080239fa: 00c8        lsls	r0, r1, #3
@   0x080239fc: 1a40        subs	r0, r0, r1
@   0x080239fe: 00c0        lsls	r0, r0, #3
@   0x08023a00: 1980        adds	r0, r0, r6
@   0x08023a02: 8e81        ldrh	r1, [r0, #52]	@ 0x34
@   0x08023a04: 4319        orrs	r1, r3
@   0x08023a06: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x08023a08: 7683        strb	r3, [r0, #26]
@   0x08023a0a: 4650        mov	r0, sl
@   0x08023a0c: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08023a0e: 4308        orrs	r0, r1
@   0x08023a10: e022        b.n	0x23a58
@   0x08023a12: 2102        movs	r1, #2
@   0x08023a14: 4010        ands	r0, r2
@   0x08023a16: 2800        cmp	r0, #0
@   0x08023a18: d11f        bne.n	0x23a5a
@   0x08023a1a: 2304        movs	r3, #4
@   0x08023a1c: 5ee0        ldrsh	r0, [r4, r3]
@   0x08023a1e: 287c        cmp	r0, #124	@ 0x7c
@   0x08023a20: dd11        ble.n	0x23a46
@   0x08023a22: 2001        movs	r0, #1
@   0x08023a24: 76a0        strb	r0, [r4, #26]
@   0x08023a26: 1c08        adds	r0, r1, #0
@   0x08023a28: 4310        orrs	r0, r2
@   0x08023a2a: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x08023a2c: 00f8        lsls	r0, r7, #3
@   0x08023a2e: 1bc0        subs	r0, r0, r7
@   0x08023a30: 00c0        lsls	r0, r0, #3
@   0x08023a32: 22bd        movs	r2, #189	@ 0xbd
@   0x08023a34: 0152        lsls	r2, r2, #5
@   0x08023a36: 18b1        adds	r1, r6, r2
@   0x08023a38: 1840        adds	r0, r0, r1
@   0x08023a3a: 2100        movs	r1, #0
@   0x08023a3c: 2200        movs	r2, #0
@   0x08023a3e: 2300        movs	r3, #0
@   0x08023a40: f7e6        fd9e 	bl	0xa580
@   0x08023a44: e009        b.n	0x23a5a
@   0x08023a46: 4640        mov	r0, r8
@   0x08023a48: 4010        ands	r0, r2
@   0x08023a4a: 2800        cmp	r0, #0
@   0x08023a4c: d005        beq.n	0x23a5a
@   0x08023a4e: 1c10        adds	r0, r2, #0
@   0x08023a50: 4308        orrs	r0, r1
@   0x08023a52: 4b15        ldr	r3, [pc, #84]	@ (0x23aa8)
@   0x08023a54: 1c19        adds	r1, r3, #0
@   0x08023a56: 4008        ands	r0, r1
@   0x08023a58: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x08023a5a: 4814        ldr	r0, [pc, #80]	@ (0x23aac)
@   0x08023a5c: 4649        mov	r1, r9
@   0x08023a5e: f7e2        ff85 	bl	0x696c
@   0x08023a62: 1c78        adds	r0, r7, #1
@   0x08023a64: 0600        lsls	r0, r0, #24
@   0x08023a66: 0e07        lsrs	r7, r0, #24
@   0x08023a68: 2f04        cmp	r7, #4
@   0x08023a6a: d800        bhi.n	0x23a6e
@   0x08023a6c: e755        b.n	0x2391a
@   0x08023a6e: 4c10        ldr	r4, [pc, #64]	@ (0x23ab0)
@   0x08023a70: 6820        ldr	r0, [r4, #0]
@   0x08023a72: 216c        movs	r1, #108	@ 0x6c
@   0x08023a74: f7fe        fa3a 	bl	0x21eec
@   0x08023a78: 6860        ldr	r0, [r4, #4]
@   0x08023a7a: 216d        movs	r1, #109	@ 0x6d
@   0x08023a7c: f7fe        fa36 	bl	0x21eec
@   0x08023a80: 68a0        ldr	r0, [r4, #8]
@   0x08023a82: 216e        movs	r1, #110	@ 0x6e
@   0x08023a84: f7fe        fa32 	bl	0x21eec
@   0x08023a88: 206f        movs	r0, #111	@ 0x6f
@   0x08023a8a: 2170        movs	r1, #112	@ 0x70
@   0x08023a8c: f7fd        faaa 	bl	0x20fe4
@   0x08023a90: 206f        movs	r0, #111	@ 0x6f
@   0x08023a92: 2170        movs	r1, #112	@ 0x70
@   0x08023a94: f7e2        f93c 	bl	0x5d10
@   0x08023a98: b004        add	sp, #16
@   0x08023a9a: bc38        pop	{r3, r4, r5}
@   0x08023a9c: 4698        mov	r8, r3
@   0x08023a9e: 46a1        mov	r9, r4
@   0x08023aa0: 46aa        mov	sl, r5
@   0x08023aa2: bcf0        pop	{r4, r5, r6, r7}
@   0x08023aa4: bc01        pop	{r0}
@   0x08023aa6: 4700        bx	r0
@   0x08023aa8: 7fff        ldrb	r7, [r7, #31]
@   0x08023aaa: 0000        movs	r0, r0
@   0x08023aac: 6110        str	r0, [r2, #16]
@   0x08023aae: 0300        lsls	r0, r0, #12
@   0x08023ab0: 2d4c        cmp	r5, #76	@ 0x4c
@   0x08023ab2: 0831        lsrs	r1, r6, #32

        thumb_func_start sub_080236F4
sub_080236F4: @ 0x080236f4
        .incbin "frog_us_baserom.gba", 0x236f4, 0x3c0
        thumb_func_end sub_080236F4
