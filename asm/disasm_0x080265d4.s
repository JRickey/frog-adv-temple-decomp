@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080265d4, 0x080268c8)  (756 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80265d4 --end 0x80268c8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080265d4: b570        push	{r4, r5, r6, lr}
@   0x080265d6: b084        sub	sp, #16
@   0x080265d8: 4b12        ldr	r3, [pc, #72]	@ (0x26624)
@   0x080265da: 2002        movs	r0, #2
@   0x080265dc: 8a19        ldrh	r1, [r3, #16]
@   0x080265de: 4008        ands	r0, r1
@   0x080265e0: 2800        cmp	r0, #0
@   0x080265e2: d100        bne.n	0x265e6
@   0x080265e4: e0a8        b.n	0x26738
@   0x080265e6: 7b98        ldrb	r0, [r3, #14]
@   0x080265e8: 2802        cmp	r0, #2
@   0x080265ea: d000        beq.n	0x265ee
@   0x080265ec: e0a4        b.n	0x26738
@   0x080265ee: 4a0e        ldr	r2, [pc, #56]	@ (0x26628)
@   0x080265f0: 2004        movs	r0, #4
@   0x080265f2: 5e11        ldrsh	r1, [r2, r0]
@   0x080265f4: 480d        ldr	r0, [pc, #52]	@ (0x2662c)
@   0x080265f6: 4281        cmp	r1, r0
@   0x080265f8: dd2d        ble.n	0x26656
@   0x080265fa: 32a4        adds	r2, #164	@ 0xa4
@   0x080265fc: 8811        ldrh	r1, [r2, #0]
@   0x080265fe: 2080        movs	r0, #128	@ 0x80
@   0x08026600: 0080        lsls	r0, r0, #2
@   0x08026602: 4008        ands	r0, r1
@   0x08026604: 2800        cmp	r0, #0
@   0x08026606: d050        beq.n	0x266aa
@   0x08026608: 4c09        ldr	r4, [pc, #36]	@ (0x26630)
@   0x0802660a: 6920        ldr	r0, [r4, #16]
@   0x0802660c: 2800        cmp	r0, #0
@   0x0802660e: d14c        bne.n	0x266aa
@   0x08026610: 2004        movs	r0, #4
@   0x08026612: 5618        ldrsb	r0, [r3, r0]
@   0x08026614: 2800        cmp	r0, #0
@   0x08026616: dd0d        ble.n	0x26634
@   0x08026618: 2048        movs	r0, #72	@ 0x48
@   0x0802661a: f7fa        fb2d 	bl	0x20c78
@   0x0802661e: 2001        movs	r0, #1
@   0x08026620: 6120        str	r0, [r4, #16]
@   0x08026622: e042        b.n	0x266aa
@   0x08026624: 35e0        adds	r5, #224	@ 0xe0
@   0x08026626: 0300        lsls	r0, r0, #12
@   0x08026628: 3720        adds	r7, #32
@   0x0802662a: 0300        lsls	r0, r0, #12
@   0x0802662c: 1130        asrs	r0, r6, #4
@   0x0802662e: 0000        movs	r0, r0
@   0x08026630: 6110        str	r0, [r2, #16]
@   0x08026632: 0300        lsls	r0, r0, #12
@   0x08026634: 4803        ldr	r0, [pc, #12]	@ (0x26644)
@   0x08026636: 4008        ands	r0, r1
@   0x08026638: 8010        strh	r0, [r2, #0]
@   0x0802663a: 2007        movs	r0, #7
@   0x0802663c: f7e7        ffe0 	bl	0xe600
@   0x08026640: e004        b.n	0x2664c
@   0x08026642: 0000        movs	r0, r0
@   0x08026644: fdff        0000 			@ <UNDEFINED> instruction: 0xfdff0000
@   0x08026648: f7da        f948 	bl	0x8dc
@   0x0802664c: f7e9        fb80 	bl	0xfd50
@   0x08026650: 2800        cmp	r0, #0
@   0x08026652: d1f9        bne.n	0x26648
@   0x08026654: e029        b.n	0x266aa
@   0x08026656: 481d        ldr	r0, [pc, #116]	@ (0x266cc)
@   0x08026658: 4281        cmp	r1, r0
@   0x0802665a: dc26        bgt.n	0x266aa
@   0x0802665c: 491c        ldr	r1, [pc, #112]	@ (0x266d0)
@   0x0802665e: 6908        ldr	r0, [r1, #16]
@   0x08026660: 2802        cmp	r0, #2
@   0x08026662: d151        bne.n	0x26708
@   0x08026664: 2004        movs	r0, #4
@   0x08026666: 6108        str	r0, [r1, #16]
@   0x08026668: 2600        movs	r6, #0
@   0x0802666a: 1c35        adds	r5, r6, #0
@   0x0802666c: 3533        adds	r5, #51	@ 0x33
@   0x0802666e: 4919        ldr	r1, [pc, #100]	@ (0x266d4)
@   0x08026670: 00b0        lsls	r0, r6, #2
@   0x08026672: 1840        adds	r0, r0, r1
@   0x08026674: 6804        ldr	r4, [r0, #0]
@   0x08026676: 1c30        adds	r0, r6, #0
@   0x08026678: 210c        movs	r1, #12
@   0x0802667a: f00d        fc6f 	bl	0x33f5c
@   0x0802667e: 0600        lsls	r0, r0, #24
@   0x08026680: 0900        lsrs	r0, r0, #4
@   0x08026682: 4915        ldr	r1, [pc, #84]	@ (0x266d8)
@   0x08026684: 1840        adds	r0, r0, r1
@   0x08026686: 0c00        lsrs	r0, r0, #16
@   0x08026688: 9000        str	r0, [sp, #0]
@   0x0802668a: 2002        movs	r0, #2
@   0x0802668c: 9001        str	r0, [sp, #4]
@   0x0802668e: 2003        movs	r0, #3
@   0x08026690: 9002        str	r0, [sp, #8]
@   0x08026692: 9003        str	r0, [sp, #12]
@   0x08026694: 1c28        adds	r0, r5, #0
@   0x08026696: 1c21        adds	r1, r4, #0
@   0x08026698: 2210        movs	r2, #16
@   0x0802669a: 2330        movs	r3, #48	@ 0x30
@   0x0802669c: f7fa        fd00 	bl	0x210a0
@   0x080266a0: 1c70        adds	r0, r6, #1
@   0x080266a2: 0600        lsls	r0, r0, #24
@   0x080266a4: 0e06        lsrs	r6, r0, #24
@   0x080266a6: 2e18        cmp	r6, #24
@   0x080266a8: d9df        bls.n	0x2666a
@   0x080266aa: 4809        ldr	r0, [pc, #36]	@ (0x266d0)
@   0x080266ac: 6902        ldr	r2, [r0, #16]
@   0x080266ae: 2a02        cmp	r2, #2
@   0x080266b0: d12a        bne.n	0x26708
@   0x080266b2: 480a        ldr	r0, [pc, #40]	@ (0x266dc)
@   0x080266b4: 210a        movs	r1, #10
@   0x080266b6: 5e40        ldrsh	r0, [r0, r1]
@   0x080266b8: 28a0        cmp	r0, #160	@ 0xa0
@   0x080266ba: d113        bne.n	0x266e4
@   0x080266bc: 4808        ldr	r0, [pc, #32]	@ (0x266e0)
@   0x080266be: 1c01        adds	r1, r0, #0
@   0x080266c0: 31a2        adds	r1, #162	@ 0xa2
@   0x080266c2: 700a        strb	r2, [r1, #0]
@   0x080266c4: 30a1        adds	r0, #161	@ 0xa1
@   0x080266c6: 21fc        movs	r1, #252	@ 0xfc
@   0x080266c8: e014        b.n	0x266f4
@   0x080266ca: 0000        movs	r0, r0
@   0x080266cc: 0952        lsrs	r2, r2, #5
@   0x080266ce: 0000        movs	r0, r0
@   0x080266d0: 6110        str	r0, [r2, #16]
@   0x080266d2: 0300        lsls	r0, r0, #12
@   0x080266d4: 5ae0        ldrh	r0, [r4, r3]
@   0x080266d6: 0831        lsrs	r1, r6, #32
@   0x080266d8: 0000        movs	r0, r0
@   0x080266da: 0141        lsls	r1, r0, #5
@   0x080266dc: 35e0        adds	r5, #224	@ 0xe0
@   0x080266de: 0300        lsls	r0, r0, #12
@   0x080266e0: 3720        adds	r7, #32
@   0x080266e2: 0300        lsls	r0, r0, #12
@   0x080266e4: 288c        cmp	r0, #140	@ 0x8c
@   0x080266e6: d106        bne.n	0x266f6
@   0x080266e8: 4805        ldr	r0, [pc, #20]	@ (0x26700)
@   0x080266ea: 1c01        adds	r1, r0, #0
@   0x080266ec: 31a2        adds	r1, #162	@ 0xa2
@   0x080266ee: 700a        strb	r2, [r1, #0]
@   0x080266f0: 30a1        adds	r0, #161	@ 0xa1
@   0x080266f2: 21fb        movs	r1, #251	@ 0xfb
@   0x080266f4: 7001        strb	r1, [r0, #0]
@   0x080266f6: 4803        ldr	r0, [pc, #12]	@ (0x26704)
@   0x080266f8: 2102        movs	r1, #2
@   0x080266fa: f7fb        fbf7 	bl	0x21eec
@   0x080266fe: e034        b.n	0x2676a
@   0x08026700: 3720        adds	r7, #32
@   0x08026702: 0300        lsls	r0, r0, #12
@   0x08026704: 4b80        ldr	r3, [pc, #512]	@ (0x26908)
@   0x08026706: 0831        lsrs	r1, r6, #32
@   0x08026708: 4b09        ldr	r3, [pc, #36]	@ (0x26730)
@   0x0802670a: 1c1a        adds	r2, r3, #0
@   0x0802670c: 32a4        adds	r2, #164	@ 0xa4
@   0x0802670e: 8811        ldrh	r1, [r2, #0]
@   0x08026710: 2080        movs	r0, #128	@ 0x80
@   0x08026712: 0200        lsls	r0, r0, #8
@   0x08026714: 4008        ands	r0, r1
@   0x08026716: 2800        cmp	r0, #0
@   0x08026718: d004        beq.n	0x26724
@   0x0802671a: 2002        movs	r0, #2
@   0x0802671c: 4308        orrs	r0, r1
@   0x0802671e: 4905        ldr	r1, [pc, #20]	@ (0x26734)
@   0x08026720: 4008        ands	r0, r1
@   0x08026722: 8010        strh	r0, [r2, #0]
@   0x08026724: 1c18        adds	r0, r3, #0
@   0x08026726: 3070        adds	r0, #112	@ 0x70
@   0x08026728: f7df        f94c 	bl	0x59c4
@   0x0802672c: e01d        b.n	0x2676a
@   0x0802672e: 0000        movs	r0, r0
@   0x08026730: 3720        adds	r7, #32
@   0x08026732: 0300        lsls	r0, r0, #12
@   0x08026734: 7fff        ldrb	r7, [r7, #31]
@   0x08026736: 0000        movs	r0, r0
@   0x08026738: 4c1f        ldr	r4, [pc, #124]	@ (0x267b8)
@   0x0802673a: 1c22        adds	r2, r4, #0
@   0x0802673c: 32a4        adds	r2, #164	@ 0xa4
@   0x0802673e: 2180        movs	r1, #128	@ 0x80
@   0x08026740: 0089        lsls	r1, r1, #2
@   0x08026742: 1c08        adds	r0, r1, #0
@   0x08026744: 2300        movs	r3, #0
@   0x08026746: 8811        ldrh	r1, [r2, #0]
@   0x08026748: 4301        orrs	r1, r0
@   0x0802674a: 8011        strh	r1, [r2, #0]
@   0x0802674c: 2080        movs	r0, #128	@ 0x80
@   0x0802674e: 0200        lsls	r0, r0, #8
@   0x08026750: 4008        ands	r0, r1
@   0x08026752: 2800        cmp	r0, #0
@   0x08026754: d005        beq.n	0x26762
@   0x08026756: 2002        movs	r0, #2
@   0x08026758: 4301        orrs	r1, r0
@   0x0802675a: 4319        orrs	r1, r3
@   0x0802675c: 4817        ldr	r0, [pc, #92]	@ (0x267bc)
@   0x0802675e: 4001        ands	r1, r0
@   0x08026760: 8011        strh	r1, [r2, #0]
@   0x08026762: 1c20        adds	r0, r4, #0
@   0x08026764: 3070        adds	r0, #112	@ 0x70
@   0x08026766: f7df        f92d 	bl	0x59c4
@   0x0802676a: 4b15        ldr	r3, [pc, #84]	@ (0x267c0)
@   0x0802676c: 2002        movs	r0, #2
@   0x0802676e: 8a19        ldrh	r1, [r3, #16]
@   0x08026770: 4008        ands	r0, r1
@   0x08026772: 2800        cmp	r0, #0
@   0x08026774: d100        bne.n	0x26778
@   0x08026776: e085        b.n	0x26884
@   0x08026778: 7b98        ldrb	r0, [r3, #14]
@   0x0802677a: 2803        cmp	r0, #3
@   0x0802677c: d000        beq.n	0x26780
@   0x0802677e: e081        b.n	0x26884
@   0x08026780: 4a0d        ldr	r2, [pc, #52]	@ (0x267b8)
@   0x08026782: 2004        movs	r0, #4
@   0x08026784: 5e11        ldrsh	r1, [r2, r0]
@   0x08026786: 480f        ldr	r0, [pc, #60]	@ (0x267c4)
@   0x08026788: 4281        cmp	r1, r0
@   0x0802678a: dd30        ble.n	0x267ee
@   0x0802678c: 32dc        adds	r2, #220	@ 0xdc
@   0x0802678e: 8811        ldrh	r1, [r2, #0]
@   0x08026790: 2080        movs	r0, #128	@ 0x80
@   0x08026792: 0080        lsls	r0, r0, #2
@   0x08026794: 4008        ands	r0, r1
@   0x08026796: 2800        cmp	r0, #0
@   0x08026798: d033        beq.n	0x26802
@   0x0802679a: 4c0b        ldr	r4, [pc, #44]	@ (0x267c8)
@   0x0802679c: 6920        ldr	r0, [r4, #16]
@   0x0802679e: 2800        cmp	r0, #0
@   0x080267a0: d12f        bne.n	0x26802
@   0x080267a2: 2004        movs	r0, #4
@   0x080267a4: 5618        ldrsb	r0, [r3, r0]
@   0x080267a6: 2801        cmp	r0, #1
@   0x080267a8: dd10        ble.n	0x267cc
@   0x080267aa: 2048        movs	r0, #72	@ 0x48
@   0x080267ac: f7fa        fa64 	bl	0x20c78
@   0x080267b0: 2001        movs	r0, #1
@   0x080267b2: 6120        str	r0, [r4, #16]
@   0x080267b4: e025        b.n	0x26802
@   0x080267b6: 0000        movs	r0, r0
@   0x080267b8: 3720        adds	r7, #32
@   0x080267ba: 0300        lsls	r0, r0, #12
@   0x080267bc: 7fff        ldrb	r7, [r7, #31]
@   0x080267be: 0000        movs	r0, r0
@   0x080267c0: 35e0        adds	r5, #224	@ 0xe0
@   0x080267c2: 0300        lsls	r0, r0, #12
@   0x080267c4: 0888        lsrs	r0, r1, #2
@   0x080267c6: 0000        movs	r0, r0
@   0x080267c8: 6110        str	r0, [r2, #16]
@   0x080267ca: 0300        lsls	r0, r0, #12
@   0x080267cc: 4803        ldr	r0, [pc, #12]	@ (0x267dc)
@   0x080267ce: 4008        ands	r0, r1
@   0x080267d0: 8010        strh	r0, [r2, #0]
@   0x080267d2: 2007        movs	r0, #7
@   0x080267d4: f7e7        ff14 	bl	0xe600
@   0x080267d8: e004        b.n	0x267e4
@   0x080267da: 0000        movs	r0, r0
@   0x080267dc: fdff        0000 			@ <UNDEFINED> instruction: 0xfdff0000
@   0x080267e0: f7da        f87c 	bl	0x8dc
@   0x080267e4: f7e9        fab4 	bl	0xfd50
@   0x080267e8: 2800        cmp	r0, #0
@   0x080267ea: d1f9        bne.n	0x267e0
@   0x080267ec: e009        b.n	0x26802
@   0x080267ee: 20c5        movs	r0, #197	@ 0xc5
@   0x080267f0: 0040        lsls	r0, r0, #1
@   0x080267f2: 4281        cmp	r1, r0
@   0x080267f4: dc05        bgt.n	0x26802
@   0x080267f6: 490b        ldr	r1, [pc, #44]	@ (0x26824)
@   0x080267f8: 6908        ldr	r0, [r1, #16]
@   0x080267fa: 2802        cmp	r0, #2
@   0x080267fc: d12a        bne.n	0x26854
@   0x080267fe: 2004        movs	r0, #4
@   0x08026800: 6108        str	r0, [r1, #16]
@   0x08026802: 4808        ldr	r0, [pc, #32]	@ (0x26824)
@   0x08026804: 6902        ldr	r2, [r0, #16]
@   0x08026806: 2a02        cmp	r2, #2
@   0x08026808: d124        bne.n	0x26854
@   0x0802680a: 4807        ldr	r0, [pc, #28]	@ (0x26828)
@   0x0802680c: 210a        movs	r1, #10
@   0x0802680e: 5e40        ldrsh	r0, [r0, r1]
@   0x08026810: 2846        cmp	r0, #70	@ 0x46
@   0x08026812: d10d        bne.n	0x26830
@   0x08026814: 4805        ldr	r0, [pc, #20]	@ (0x2682c)
@   0x08026816: 1c01        adds	r1, r0, #0
@   0x08026818: 31da        adds	r1, #218	@ 0xda
@   0x0802681a: 700a        strb	r2, [r1, #0]
@   0x0802681c: 30d9        adds	r0, #217	@ 0xd9
@   0x0802681e: 21fb        movs	r1, #251	@ 0xfb
@   0x08026820: e00e        b.n	0x26840
@   0x08026822: 0000        movs	r0, r0
@   0x08026824: 6110        str	r0, [r2, #16]
@   0x08026826: 0300        lsls	r0, r0, #12
@   0x08026828: 35e0        adds	r5, #224	@ 0xe0
@   0x0802682a: 0300        lsls	r0, r0, #12
@   0x0802682c: 3720        adds	r7, #32
@   0x0802682e: 0300        lsls	r0, r0, #12
@   0x08026830: 2832        cmp	r0, #50	@ 0x32
@   0x08026832: d106        bne.n	0x26842
@   0x08026834: 4805        ldr	r0, [pc, #20]	@ (0x2684c)
@   0x08026836: 1c01        adds	r1, r0, #0
@   0x08026838: 31da        adds	r1, #218	@ 0xda
@   0x0802683a: 700a        strb	r2, [r1, #0]
@   0x0802683c: 30d9        adds	r0, #217	@ 0xd9
@   0x0802683e: 21fa        movs	r1, #250	@ 0xfa
@   0x08026840: 7001        strb	r1, [r0, #0]
@   0x08026842: 4803        ldr	r0, [pc, #12]	@ (0x26850)
@   0x08026844: 2103        movs	r1, #3
@   0x08026846: f7fb        fb51 	bl	0x21eec
@   0x0802684a: e034        b.n	0x268b6
@   0x0802684c: 3720        adds	r7, #32
@   0x0802684e: 0300        lsls	r0, r0, #12
@   0x08026850: 4bc0        ldr	r3, [pc, #768]	@ (0x26b54)
@   0x08026852: 0831        lsrs	r1, r6, #32
@   0x08026854: 4b09        ldr	r3, [pc, #36]	@ (0x2687c)
@   0x08026856: 1c1a        adds	r2, r3, #0
@   0x08026858: 32dc        adds	r2, #220	@ 0xdc
@   0x0802685a: 8811        ldrh	r1, [r2, #0]
@   0x0802685c: 2080        movs	r0, #128	@ 0x80
@   0x0802685e: 0200        lsls	r0, r0, #8
@   0x08026860: 4008        ands	r0, r1
@   0x08026862: 2800        cmp	r0, #0
@   0x08026864: d004        beq.n	0x26870
@   0x08026866: 2002        movs	r0, #2
@   0x08026868: 4308        orrs	r0, r1
@   0x0802686a: 4905        ldr	r1, [pc, #20]	@ (0x26880)
@   0x0802686c: 4008        ands	r0, r1
@   0x0802686e: 8010        strh	r0, [r2, #0]
@   0x08026870: 1c18        adds	r0, r3, #0
@   0x08026872: 30a8        adds	r0, #168	@ 0xa8
@   0x08026874: f7df        f8a6 	bl	0x59c4
@   0x08026878: e01d        b.n	0x268b6
@   0x0802687a: 0000        movs	r0, r0
@   0x0802687c: 3720        adds	r7, #32
@   0x0802687e: 0300        lsls	r0, r0, #12
@   0x08026880: 7fff        ldrb	r7, [r7, #31]
@   0x08026882: 0000        movs	r0, r0
@   0x08026884: 4c0e        ldr	r4, [pc, #56]	@ (0x268c0)
@   0x08026886: 1c22        adds	r2, r4, #0
@   0x08026888: 32dc        adds	r2, #220	@ 0xdc
@   0x0802688a: 2180        movs	r1, #128	@ 0x80
@   0x0802688c: 0089        lsls	r1, r1, #2
@   0x0802688e: 1c08        adds	r0, r1, #0
@   0x08026890: 2300        movs	r3, #0
@   0x08026892: 8811        ldrh	r1, [r2, #0]
@   0x08026894: 4301        orrs	r1, r0
@   0x08026896: 8011        strh	r1, [r2, #0]
@   0x08026898: 2080        movs	r0, #128	@ 0x80
@   0x0802689a: 0200        lsls	r0, r0, #8
@   0x0802689c: 4008        ands	r0, r1
@   0x0802689e: 2800        cmp	r0, #0
@   0x080268a0: d005        beq.n	0x268ae
@   0x080268a2: 2002        movs	r0, #2
@   0x080268a4: 4301        orrs	r1, r0
@   0x080268a6: 4319        orrs	r1, r3
@   0x080268a8: 4806        ldr	r0, [pc, #24]	@ (0x268c4)
@   0x080268aa: 4001        ands	r1, r0
@   0x080268ac: 8011        strh	r1, [r2, #0]
@   0x080268ae: 1c20        adds	r0, r4, #0
@   0x080268b0: 30a8        adds	r0, #168	@ 0xa8
@   0x080268b2: f7df        f887 	bl	0x59c4
@   0x080268b6: b004        add	sp, #16
@   0x080268b8: bc70        pop	{r4, r5, r6}
@   0x080268ba: bc01        pop	{r0}
@   0x080268bc: 4700        bx	r0
@   0x080268be: 0000        movs	r0, r0
@   0x080268c0: 3720        adds	r7, #32
@   0x080268c2: 0300        lsls	r0, r0, #12
@   0x080268c4: 7fff        ldrb	r7, [r7, #31]

        thumb_func_start sub_080265D4
sub_080265D4: @ 0x080265d4
        .incbin "baserom.gba", 0x265d4, 0x2f4
        thumb_func_end sub_080265D4
