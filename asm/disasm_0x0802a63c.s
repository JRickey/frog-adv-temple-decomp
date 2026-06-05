@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802a63c, 0x0802a8fc)  (704 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802a63c --end 0x802a8fc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802a63c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802a63e: 4657        mov	r7, sl
@   0x0802a640: 464e        mov	r6, r9
@   0x0802a642: 4645        mov	r5, r8
@   0x0802a644: b4e0        push	{r5, r6, r7}
@   0x0802a646: b087        sub	sp, #28
@   0x0802a648: 4c14        ldr	r4, [pc, #80]	@ (0x2a69c)
@   0x0802a64a: 4815        ldr	r0, [pc, #84]	@ (0x2a6a0)
@   0x0802a64c: 1825        adds	r5, r4, r0
@   0x0802a64e: 4915        ldr	r1, [pc, #84]	@ (0x2a6a4)
@   0x0802a650: 2000        movs	r0, #0
@   0x0802a652: 5628        ldrsb	r0, [r5, r0]
@   0x0802a654: 00c0        lsls	r0, r0, #3
@   0x0802a656: 3104        adds	r1, #4
@   0x0802a658: 1840        adds	r0, r0, r1
@   0x0802a65a: 6800        ldr	r0, [r0, #0]
@   0x0802a65c: 4682        mov	sl, r0
@   0x0802a65e: 4912        ldr	r1, [pc, #72]	@ (0x2a6a8)
@   0x0802a660: 1866        adds	r6, r4, r1
@   0x0802a662: 4b12        ldr	r3, [pc, #72]	@ (0x2a6ac)
@   0x0802a664: 8832        ldrh	r2, [r6, #0]
@   0x0802a666: 2aff        cmp	r2, #255	@ 0xff
@   0x0802a668: d143        bne.n	0x2a6f2
@   0x0802a66a: 4911        ldr	r1, [pc, #68]	@ (0x2a6b0)
@   0x0802a66c: 8988        ldrh	r0, [r1, #12]
@   0x0802a66e: 3801        subs	r0, #1
@   0x0802a670: 2200        movs	r2, #0
@   0x0802a672: 8188        strh	r0, [r1, #12]
@   0x0802a674: 27d3        movs	r7, #211	@ 0xd3
@   0x0802a676: 00ff        lsls	r7, r7, #3
@   0x0802a678: 19e0        adds	r0, r4, r7
@   0x0802a67a: 8002        strh	r2, [r0, #0]
@   0x0802a67c: 8032        strh	r2, [r6, #0]
@   0x0802a67e: 20d6        movs	r0, #214	@ 0xd6
@   0x0802a680: 00c0        lsls	r0, r0, #3
@   0x0802a682: 1822        adds	r2, r4, r0
@   0x0802a684: 6818        ldr	r0, [r3, #0]
@   0x0802a686: 6010        str	r0, [r2, #0]
@   0x0802a688: 312b        adds	r1, #43	@ 0x2b
@   0x0802a68a: 7808        ldrb	r0, [r1, #0]
@   0x0802a68c: 2802        cmp	r0, #2
@   0x0802a68e: d111        bne.n	0x2a6b4
@   0x0802a690: 2005        movs	r0, #5
@   0x0802a692: f7d6        f867 	bl	0x764
@   0x0802a696: 3003        adds	r0, #3
@   0x0802a698: e016        b.n	0x2a6c8
@   0x0802a69a: 0000        movs	r0, r0
@   0x0802a69c: 3720        adds	r7, #32
@   0x0802a69e: 0300        lsls	r0, r0, #12
@   0x0802a6a0: 06aa        lsls	r2, r5, #26
@   0x0802a6a2: 0000        movs	r0, r0
@   0x0802a6a4: 67d4        str	r4, [r2, #124]	@ 0x7c
@   0x0802a6a6: 0830        lsrs	r0, r6, #32
@   0x0802a6a8: 069a        lsls	r2, r3, #26
@   0x0802a6aa: 0000        movs	r0, r0
@   0x0802a6ac: 5330        strh	r0, [r6, r4]
@   0x0802a6ae: 0300        lsls	r0, r0, #12
@   0x0802a6b0: 6110        str	r0, [r2, #16]
@   0x0802a6b2: 0300        lsls	r0, r0, #12
@   0x0802a6b4: 2801        cmp	r0, #1
@   0x0802a6b6: d104        bne.n	0x2a6c2
@   0x0802a6b8: 2005        movs	r0, #5
@   0x0802a6ba: f7d6        f853 	bl	0x764
@   0x0802a6be: 3003        adds	r0, #3
@   0x0802a6c0: e002        b.n	0x2a6c8
@   0x0802a6c2: 2003        movs	r0, #3
@   0x0802a6c4: f7d6        f84e 	bl	0x764
@   0x0802a6c8: 7028        strb	r0, [r5, #0]
@   0x0802a6ca: 4917        ldr	r1, [pc, #92]	@ (0x2a728)
@   0x0802a6cc: 23d6        movs	r3, #214	@ 0xd6
@   0x0802a6ce: 00db        lsls	r3, r3, #3
@   0x0802a6d0: 18ca        adds	r2, r1, r3
@   0x0802a6d2: 4b16        ldr	r3, [pc, #88]	@ (0x2a72c)
@   0x0802a6d4: 6818        ldr	r0, [r3, #0]
@   0x0802a6d6: 6010        str	r0, [r2, #0]
@   0x0802a6d8: 25d3        movs	r5, #211	@ 0xd3
@   0x0802a6da: 00ed        lsls	r5, r5, #3
@   0x0802a6dc: 1948        adds	r0, r1, r5
@   0x0802a6de: 2200        movs	r2, #0
@   0x0802a6e0: 8002        strh	r2, [r0, #0]
@   0x0802a6e2: 4e13        ldr	r6, [pc, #76]	@ (0x2a730)
@   0x0802a6e4: 1989        adds	r1, r1, r6
@   0x0802a6e6: 800a        strh	r2, [r1, #0]
@   0x0802a6e8: 4812        ldr	r0, [pc, #72]	@ (0x2a734)
@   0x0802a6ea: 8980        ldrh	r0, [r0, #12]
@   0x0802a6ec: 2800        cmp	r0, #0
@   0x0802a6ee: d100        bne.n	0x2a6f2
@   0x0802a6f0: e0fa        b.n	0x2a8e8
@   0x0802a6f2: 681b        ldr	r3, [r3, #0]
@   0x0802a6f4: 9306        str	r3, [sp, #24]
@   0x0802a6f6: 2100        movs	r1, #0
@   0x0802a6f8: 4f0b        ldr	r7, [pc, #44]	@ (0x2a728)
@   0x0802a6fa: 2001        movs	r0, #1
@   0x0802a6fc: 4680        mov	r8, r0
@   0x0802a6fe: 4a0e        ldr	r2, [pc, #56]	@ (0x2a738)
@   0x0802a700: 2300        movs	r3, #0
@   0x0802a702: 5ed0        ldrsh	r0, [r2, r3]
@   0x0802a704: 0609        lsls	r1, r1, #24
@   0x0802a706: 160c        asrs	r4, r1, #24
@   0x0802a708: 4120        asrs	r0, r4
@   0x0802a70a: 4645        mov	r5, r8
@   0x0802a70c: 4028        ands	r0, r5
@   0x0802a70e: 4689        mov	r9, r1
@   0x0802a710: 2800        cmp	r0, #0
@   0x0802a712: d013        beq.n	0x2a73c
@   0x0802a714: 1ca0        adds	r0, r4, #2
@   0x0802a716: 00c1        lsls	r1, r0, #3
@   0x0802a718: 1a09        subs	r1, r1, r0
@   0x0802a71a: 00c9        lsls	r1, r1, #3
@   0x0802a71c: 19c9        adds	r1, r1, r7
@   0x0802a71e: 2008        movs	r0, #8
@   0x0802a720: 8e8e        ldrh	r6, [r1, #52]	@ 0x34
@   0x0802a722: 4330        orrs	r0, r6
@   0x0802a724: 8688        strh	r0, [r1, #52]	@ 0x34
@   0x0802a726: e0d7        b.n	0x2a8d8
@   0x0802a728: 3720        adds	r7, #32
@   0x0802a72a: 0300        lsls	r0, r0, #12
@   0x0802a72c: 5330        strh	r0, [r6, r4]
@   0x0802a72e: 0300        lsls	r0, r0, #12
@   0x0802a730: 069a        lsls	r2, r3, #26
@   0x0802a732: 0000        movs	r0, r0
@   0x0802a734: 6110        str	r0, [r2, #16]
@   0x0802a736: 0300        lsls	r0, r0, #12
@   0x0802a738: 3dba        subs	r5, #186	@ 0xba
@   0x0802a73a: 0300        lsls	r0, r0, #12
@   0x0802a73c: 21d3        movs	r1, #211	@ 0xd3
@   0x0802a73e: 00c9        lsls	r1, r1, #3
@   0x0802a740: 1878        adds	r0, r7, r1
@   0x0802a742: 2200        movs	r2, #0
@   0x0802a744: 5e80        ldrsh	r0, [r0, r2]
@   0x0802a746: 4120        asrs	r0, r4
@   0x0802a748: 4643        mov	r3, r8
@   0x0802a74a: 4018        ands	r0, r3
@   0x0802a74c: 2800        cmp	r0, #0
@   0x0802a74e: d000        beq.n	0x2a752
@   0x0802a750: e08d        b.n	0x2a86e
@   0x0802a752: 25d6        movs	r5, #214	@ 0xd6
@   0x0802a754: 00ed        lsls	r5, r5, #3
@   0x0802a756: 1978        adds	r0, r7, r5
@   0x0802a758: 6801        ldr	r1, [r0, #0]
@   0x0802a75a: 9e06        ldr	r6, [sp, #24]
@   0x0802a75c: 1a71        subs	r1, r6, r1
@   0x0802a75e: 0060        lsls	r0, r4, #1
@   0x0802a760: 1900        adds	r0, r0, r4
@   0x0802a762: 0080        lsls	r0, r0, #2
@   0x0802a764: 4652        mov	r2, sl
@   0x0802a766: 1885        adds	r5, r0, r2
@   0x0802a768: 2007        movs	r0, #7
@   0x0802a76a: 5628        ldrsb	r0, [r5, r0]
@   0x0802a76c: 4281        cmp	r1, r0
@   0x0802a76e: d974        bls.n	0x2a85a
@   0x0802a770: 00e0        lsls	r0, r4, #3
@   0x0802a772: 1b00        subs	r0, r0, r4
@   0x0802a774: 00c0        lsls	r0, r0, #3
@   0x0802a776: 1c39        adds	r1, r7, #0
@   0x0802a778: 3170        adds	r1, #112	@ 0x70
@   0x0802a77a: 1842        adds	r2, r0, r1
@   0x0802a77c: 2600        movs	r6, #0
@   0x0802a77e: 5fab        ldrsh	r3, [r5, r6]
@   0x0802a780: 2102        movs	r1, #2
@   0x0802a782: 5e68        ldrsh	r0, [r5, r1]
@   0x0802a784: 4684        mov	ip, r0
@   0x0802a786: 2103        movs	r1, #3
@   0x0802a788: 9100        str	r1, [sp, #0]
@   0x0802a78a: 1c20        adds	r0, r4, #0
@   0x0802a78c: 2c00        cmp	r4, #0
@   0x0802a78e: da00        bge.n	0x2a792
@   0x0802a790: 1de0        adds	r0, r4, #7
@   0x0802a792: 10c0        asrs	r0, r0, #3
@   0x0802a794: 00c0        lsls	r0, r0, #3
@   0x0802a796: 1a20        subs	r0, r4, r0
@   0x0802a798: 0600        lsls	r0, r0, #24
@   0x0802a79a: 1100        asrs	r0, r0, #4
@   0x0802a79c: 2682        movs	r6, #130	@ 0x82
@   0x0802a79e: 03f6        lsls	r6, r6, #15
@   0x0802a7a0: 1980        adds	r0, r0, r6
@   0x0802a7a2: 0c00        lsrs	r0, r0, #16
@   0x0802a7a4: 9001        str	r0, [sp, #4]
@   0x0802a7a6: 4640        mov	r0, r8
@   0x0802a7a8: 9002        str	r0, [sp, #8]
@   0x0802a7aa: 9103        str	r1, [sp, #12]
@   0x0802a7ac: 2002        movs	r0, #2
@   0x0802a7ae: 9004        str	r0, [sp, #16]
@   0x0802a7b0: 2010        movs	r0, #16
@   0x0802a7b2: 9005        str	r0, [sp, #20]
@   0x0802a7b4: 1c10        adds	r0, r2, #0
@   0x0802a7b6: 2151        movs	r1, #81	@ 0x51
@   0x0802a7b8: 1c1a        adds	r2, r3, #0
@   0x0802a7ba: 4663        mov	r3, ip
@   0x0802a7bc: f7df        ffa8 	bl	0xa710
@   0x0802a7c0: 4640        mov	r0, r8
@   0x0802a7c2: 7a29        ldrb	r1, [r5, #8]
@   0x0802a7c4: 4008        ands	r0, r1
@   0x0802a7c6: 2800        cmp	r0, #0
@   0x0802a7c8: d002        beq.n	0x2a7d0
@   0x0802a7ca: 203d        movs	r0, #61	@ 0x3d
@   0x0802a7cc: f7f6        fa54 	bl	0x20c78
@   0x0802a7d0: 4809        ldr	r0, [pc, #36]	@ (0x2a7f8)
@   0x0802a7d2: 1c01        adds	r1, r0, #0
@   0x0802a7d4: 312b        adds	r1, #43	@ 0x2b
@   0x0802a7d6: 7809        ldrb	r1, [r1, #0]
@   0x0802a7d8: 1c03        adds	r3, r0, #0
@   0x0802a7da: 2900        cmp	r1, #0
@   0x0802a7dc: d10e        bne.n	0x2a7fc
@   0x0802a7de: 1ca1        adds	r1, r4, #2
@   0x0802a7e0: 00c8        lsls	r0, r1, #3
@   0x0802a7e2: 1a40        subs	r0, r0, r1
@   0x0802a7e4: 00c0        lsls	r0, r0, #3
@   0x0802a7e6: 19c0        adds	r0, r0, r7
@   0x0802a7e8: 79a9        ldrb	r1, [r5, #6]
@   0x0802a7ea: 1c02        adds	r2, r0, #0
@   0x0802a7ec: 3232        adds	r2, #50	@ 0x32
@   0x0802a7ee: 7011        strb	r1, [r2, #0]
@   0x0802a7f0: 7969        ldrb	r1, [r5, #5]
@   0x0802a7f2: 3031        adds	r0, #49	@ 0x31
@   0x0802a7f4: e00e        b.n	0x2a814
@   0x0802a7f6: 0000        movs	r0, r0
@   0x0802a7f8: 6110        str	r0, [r2, #16]
@   0x0802a7fa: 0300        lsls	r0, r0, #12
@   0x0802a7fc: 1ca1        adds	r1, r4, #2
@   0x0802a7fe: 00c8        lsls	r0, r1, #3
@   0x0802a800: 1a40        subs	r0, r0, r1
@   0x0802a802: 00c0        lsls	r0, r0, #3
@   0x0802a804: 19c0        adds	r0, r0, r7
@   0x0802a806: 7969        ldrb	r1, [r5, #5]
@   0x0802a808: 3901        subs	r1, #1
@   0x0802a80a: 1c02        adds	r2, r0, #0
@   0x0802a80c: 3231        adds	r2, #49	@ 0x31
@   0x0802a80e: 7011        strb	r1, [r2, #0]
@   0x0802a810: 79a9        ldrb	r1, [r5, #6]
@   0x0802a812: 3032        adds	r0, #50	@ 0x32
@   0x0802a814: 7001        strb	r1, [r0, #0]
@   0x0802a816: 464a        mov	r2, r9
@   0x0802a818: 1614        asrs	r4, r2, #24
@   0x0802a81a: 1ca1        adds	r1, r4, #2
@   0x0802a81c: 00ca        lsls	r2, r1, #3
@   0x0802a81e: 1a52        subs	r2, r2, r1
@   0x0802a820: 00d2        lsls	r2, r2, #3
@   0x0802a822: 19d2        adds	r2, r2, r7
@   0x0802a824: 0060        lsls	r0, r4, #1
@   0x0802a826: 1900        adds	r0, r0, r4
@   0x0802a828: 0080        lsls	r0, r0, #2
@   0x0802a82a: 4450        add	r0, sl
@   0x0802a82c: 7900        ldrb	r0, [r0, #4]
@   0x0802a82e: 3230        adds	r2, #48	@ 0x30
@   0x0802a830: 7010        strb	r0, [r2, #0]
@   0x0802a832: 25d3        movs	r5, #211	@ 0xd3
@   0x0802a834: 00ed        lsls	r5, r5, #3
@   0x0802a836: 197a        adds	r2, r7, r5
@   0x0802a838: 4640        mov	r0, r8
@   0x0802a83a: 40a0        lsls	r0, r4
@   0x0802a83c: 8816        ldrh	r6, [r2, #0]
@   0x0802a83e: 4330        orrs	r0, r6
@   0x0802a840: 8010        strh	r0, [r2, #0]
@   0x0802a842: 1c18        adds	r0, r3, #0
@   0x0802a844: f7dc        f892 	bl	0x696c
@   0x0802a848: 00e0        lsls	r0, r4, #3
@   0x0802a84a: 1b00        subs	r0, r0, r4
@   0x0802a84c: 00c0        lsls	r0, r0, #3
@   0x0802a84e: 1c39        adds	r1, r7, #0
@   0x0802a850: 3170        adds	r1, #112	@ 0x70
@   0x0802a852: 1840        adds	r0, r0, r1
@   0x0802a854: f7db        f8b6 	bl	0x59c4
@   0x0802a858: e03e        b.n	0x2a8d8
@   0x0802a85a: 1ca0        adds	r0, r4, #2
@   0x0802a85c: 00c1        lsls	r1, r0, #3
@   0x0802a85e: 1a09        subs	r1, r1, r0
@   0x0802a860: 00c9        lsls	r1, r1, #3
@   0x0802a862: 19c9        adds	r1, r1, r7
@   0x0802a864: 2008        movs	r0, #8
@   0x0802a866: 8e8a        ldrh	r2, [r1, #52]	@ 0x34
@   0x0802a868: 4310        orrs	r0, r2
@   0x0802a86a: 8688        strh	r0, [r1, #52]	@ 0x34
@   0x0802a86c: e034        b.n	0x2a8d8
@   0x0802a86e: 1ca3        adds	r3, r4, #2
@   0x0802a870: 00d8        lsls	r0, r3, #3
@   0x0802a872: 1ac0        subs	r0, r0, r3
@   0x0802a874: 00c0        lsls	r0, r0, #3
@   0x0802a876: 19c2        adds	r2, r0, r7
@   0x0802a878: 8e91        ldrh	r1, [r2, #52]	@ 0x34
@   0x0802a87a: 2508        movs	r5, #8
@   0x0802a87c: 2008        movs	r0, #8
@   0x0802a87e: 4008        ands	r0, r1
@   0x0802a880: 2800        cmp	r0, #0
@   0x0802a882: d129        bne.n	0x2a8d8
@   0x0802a884: 2604        movs	r6, #4
@   0x0802a886: 5f90        ldrsh	r0, [r2, r6]
@   0x0802a888: 28b2        cmp	r0, #178	@ 0xb2
@   0x0802a88a: dd0d        ble.n	0x2a8a8
@   0x0802a88c: 4640        mov	r0, r8
@   0x0802a88e: 40a0        lsls	r0, r4
@   0x0802a890: 4904        ldr	r1, [pc, #16]	@ (0x2a8a4)
@   0x0802a892: 8809        ldrh	r1, [r1, #0]
@   0x0802a894: 4308        orrs	r0, r1
@   0x0802a896: 4b03        ldr	r3, [pc, #12]	@ (0x2a8a4)
@   0x0802a898: 8018        strh	r0, [r3, #0]
@   0x0802a89a: 8e90        ldrh	r0, [r2, #52]	@ 0x34
@   0x0802a89c: 4328        orrs	r0, r5
@   0x0802a89e: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x0802a8a0: e01a        b.n	0x2a8d8
@   0x0802a8a2: 0000        movs	r0, r0
@   0x0802a8a4: 3dba        subs	r5, #186	@ 0xba
@   0x0802a8a6: 0300        lsls	r0, r0, #12
@   0x0802a8a8: 2580        movs	r5, #128	@ 0x80
@   0x0802a8aa: 022d        lsls	r5, r5, #8
@   0x0802a8ac: 1c28        adds	r0, r5, #0
@   0x0802a8ae: 4008        ands	r0, r1
@   0x0802a8b0: 2800        cmp	r0, #0
@   0x0802a8b2: d005        beq.n	0x2a8c0
@   0x0802a8b4: 4e10        ldr	r6, [pc, #64]	@ (0x2a8f8)
@   0x0802a8b6: 1c30        adds	r0, r6, #0
@   0x0802a8b8: 4008        ands	r0, r1
@   0x0802a8ba: 2102        movs	r1, #2
@   0x0802a8bc: 4308        orrs	r0, r1
@   0x0802a8be: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x0802a8c0: 0618        lsls	r0, r3, #24
@   0x0802a8c2: 0e00        lsrs	r0, r0, #24
@   0x0802a8c4: f7f6        fb3a 	bl	0x20f3c
@   0x0802a8c8: 00e0        lsls	r0, r4, #3
@   0x0802a8ca: 1b00        subs	r0, r0, r4
@   0x0802a8cc: 00c0        lsls	r0, r0, #3
@   0x0802a8ce: 1c39        adds	r1, r7, #0
@   0x0802a8d0: 3170        adds	r1, #112	@ 0x70
@   0x0802a8d2: 1840        adds	r0, r0, r1
@   0x0802a8d4: f7db        f876 	bl	0x59c4
@   0x0802a8d8: 2080        movs	r0, #128	@ 0x80
@   0x0802a8da: 0440        lsls	r0, r0, #17
@   0x0802a8dc: 4448        add	r0, r9
@   0x0802a8de: 0e01        lsrs	r1, r0, #24
@   0x0802a8e0: 1600        asrs	r0, r0, #24
@   0x0802a8e2: 2807        cmp	r0, #7
@   0x0802a8e4: dc00        bgt.n	0x2a8e8
@   0x0802a8e6: e70a        b.n	0x2a6fe
@   0x0802a8e8: b007        add	sp, #28
@   0x0802a8ea: bc38        pop	{r3, r4, r5}
@   0x0802a8ec: 4698        mov	r8, r3
@   0x0802a8ee: 46a1        mov	r9, r4
@   0x0802a8f0: 46aa        mov	sl, r5
@   0x0802a8f2: bcf0        pop	{r4, r5, r6, r7}
@   0x0802a8f4: bc01        pop	{r0}
@   0x0802a8f6: 4700        bx	r0
@   0x0802a8f8: 7fff        ldrb	r7, [r7, #31]

        thumb_func_start sub_0802A63C
sub_0802A63C: @ 0x0802a63c
        .incbin "frog_us_baserom.gba", 0x2a63c, 0x2c0
        thumb_func_end sub_0802A63C
