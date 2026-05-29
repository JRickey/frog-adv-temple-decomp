@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080205d8, 0x0802090c)  (820 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80205d8 --end 0x802090c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080205d8: b530        push	{r4, r5, lr}
@   0x080205da: 1c02        adds	r2, r0, #0
@   0x080205dc: 7810        ldrb	r0, [r2, #0]
@   0x080205de: 3807        subs	r0, #7
@   0x080205e0: 2855        cmp	r0, #85	@ 0x55
@   0x080205e2: d900        bls.n	0x205e6
@   0x080205e4: e18e        b.n	0x20904
@   0x080205e6: 0080        lsls	r0, r0, #2
@   0x080205e8: 4901        ldr	r1, [pc, #4]	@ (0x205f0)
@   0x080205ea: 1840        adds	r0, r0, r1
@   0x080205ec: 6800        ldr	r0, [r0, #0]
@   0x080205ee: 4687        mov	pc, r0
@   0x080205f0: 05f4        lsls	r4, r6, #23
@   0x080205f2: 0802        lsrs	r2, r0, #32
@   0x080205f4: 074c        lsls	r4, r1, #29
@   0x080205f6: 0802        lsrs	r2, r0, #32
@   0x080205f8: 0752        lsls	r2, r2, #29
@   0x080205fa: 0802        lsrs	r2, r0, #32
@   0x080205fc: 0904        lsrs	r4, r0, #4
@   0x080205fe: 0802        lsrs	r2, r0, #32
@   0x08020600: 07d2        lsls	r2, r2, #31
@   0x08020602: 0802        lsrs	r2, r0, #32
@   0x08020604: 0904        lsrs	r4, r0, #4
@   0x08020606: 0802        lsrs	r2, r0, #32
@   0x08020608: 0904        lsrs	r4, r0, #4
@   0x0802060a: 0802        lsrs	r2, r0, #32
@   0x0802060c: 0758        lsls	r0, r3, #29
@   0x0802060e: 0802        lsrs	r2, r0, #32
@   0x08020610: 0904        lsrs	r4, r0, #4
@   0x08020612: 0802        lsrs	r2, r0, #32
@   0x08020614: 0904        lsrs	r4, r0, #4
@   0x08020616: 0802        lsrs	r2, r0, #32
@   0x08020618: 0904        lsrs	r4, r0, #4
@   0x0802061a: 0802        lsrs	r2, r0, #32
@   0x0802061c: 0904        lsrs	r4, r0, #4
@   0x0802061e: 0802        lsrs	r2, r0, #32
@   0x08020620: 0904        lsrs	r4, r0, #4
@   0x08020622: 0802        lsrs	r2, r0, #32
@   0x08020624: 0904        lsrs	r4, r0, #4
@   0x08020626: 0802        lsrs	r2, r0, #32
@   0x08020628: 0904        lsrs	r4, r0, #4
@   0x0802062a: 0802        lsrs	r2, r0, #32
@   0x0802062c: 0904        lsrs	r4, r0, #4
@   0x0802062e: 0802        lsrs	r2, r0, #32
@   0x08020630: 0904        lsrs	r4, r0, #4
@   0x08020632: 0802        lsrs	r2, r0, #32
@   0x08020634: 0904        lsrs	r4, r0, #4
@   0x08020636: 0802        lsrs	r2, r0, #32
@   0x08020638: 0904        lsrs	r4, r0, #4
@   0x0802063a: 0802        lsrs	r2, r0, #32
@   0x0802063c: 0904        lsrs	r4, r0, #4
@   0x0802063e: 0802        lsrs	r2, r0, #32
@   0x08020640: 0904        lsrs	r4, r0, #4
@   0x08020642: 0802        lsrs	r2, r0, #32
@   0x08020644: 07d2        lsls	r2, r2, #31
@   0x08020646: 0802        lsrs	r2, r0, #32
@   0x08020648: 0904        lsrs	r4, r0, #4
@   0x0802064a: 0802        lsrs	r2, r0, #32
@   0x0802064c: 0904        lsrs	r4, r0, #4
@   0x0802064e: 0802        lsrs	r2, r0, #32
@   0x08020650: 0904        lsrs	r4, r0, #4
@   0x08020652: 0802        lsrs	r2, r0, #32
@   0x08020654: 0904        lsrs	r4, r0, #4
@   0x08020656: 0802        lsrs	r2, r0, #32
@   0x08020658: 0904        lsrs	r4, r0, #4
@   0x0802065a: 0802        lsrs	r2, r0, #32
@   0x0802065c: 0764        lsls	r4, r4, #29
@   0x0802065e: 0802        lsrs	r2, r0, #32
@   0x08020660: 0904        lsrs	r4, r0, #4
@   0x08020662: 0802        lsrs	r2, r0, #32
@   0x08020664: 0904        lsrs	r4, r0, #4
@   0x08020666: 0802        lsrs	r2, r0, #32
@   0x08020668: 0904        lsrs	r4, r0, #4
@   0x0802066a: 0802        lsrs	r2, r0, #32
@   0x0802066c: 0904        lsrs	r4, r0, #4
@   0x0802066e: 0802        lsrs	r2, r0, #32
@   0x08020670: 076c        lsls	r4, r5, #29
@   0x08020672: 0802        lsrs	r2, r0, #32
@   0x08020674: 0904        lsrs	r4, r0, #4
@   0x08020676: 0802        lsrs	r2, r0, #32
@   0x08020678: 0904        lsrs	r4, r0, #4
@   0x0802067a: 0802        lsrs	r2, r0, #32
@   0x0802067c: 0904        lsrs	r4, r0, #4
@   0x0802067e: 0802        lsrs	r2, r0, #32
@   0x08020680: 0904        lsrs	r4, r0, #4
@   0x08020682: 0802        lsrs	r2, r0, #32
@   0x08020684: 0904        lsrs	r4, r0, #4
@   0x08020686: 0802        lsrs	r2, r0, #32
@   0x08020688: 0904        lsrs	r4, r0, #4
@   0x0802068a: 0802        lsrs	r2, r0, #32
@   0x0802068c: 0904        lsrs	r4, r0, #4
@   0x0802068e: 0802        lsrs	r2, r0, #32
@   0x08020690: 0904        lsrs	r4, r0, #4
@   0x08020692: 0802        lsrs	r2, r0, #32
@   0x08020694: 07d2        lsls	r2, r2, #31
@   0x08020696: 0802        lsrs	r2, r0, #32
@   0x08020698: 07c0        lsls	r0, r0, #31
@   0x0802069a: 0802        lsrs	r2, r0, #32
@   0x0802069c: 07c6        lsls	r6, r0, #31
@   0x0802069e: 0802        lsrs	r2, r0, #32
@   0x080206a0: 0904        lsrs	r4, r0, #4
@   0x080206a2: 0802        lsrs	r2, r0, #32
@   0x080206a4: 0904        lsrs	r4, r0, #4
@   0x080206a6: 0802        lsrs	r2, r0, #32
@   0x080206a8: 0904        lsrs	r4, r0, #4
@   0x080206aa: 0802        lsrs	r2, r0, #32
@   0x080206ac: 0904        lsrs	r4, r0, #4
@   0x080206ae: 0802        lsrs	r2, r0, #32
@   0x080206b0: 0904        lsrs	r4, r0, #4
@   0x080206b2: 0802        lsrs	r2, r0, #32
@   0x080206b4: 07e0        lsls	r0, r4, #31
@   0x080206b6: 0802        lsrs	r2, r0, #32
@   0x080206b8: 0904        lsrs	r4, r0, #4
@   0x080206ba: 0802        lsrs	r2, r0, #32
@   0x080206bc: 07cc        lsls	r4, r1, #31
@   0x080206be: 0802        lsrs	r2, r0, #32
@   0x080206c0: 0840        lsrs	r0, r0, #1
@   0x080206c2: 0802        lsrs	r2, r0, #32
@   0x080206c4: 0896        lsrs	r6, r2, #2
@   0x080206c6: 0802        lsrs	r2, r0, #32
@   0x080206c8: 0890        lsrs	r0, r2, #2
@   0x080206ca: 0802        lsrs	r2, r0, #32
@   0x080206cc: 0904        lsrs	r4, r0, #4
@   0x080206ce: 0802        lsrs	r2, r0, #32
@   0x080206d0: 0904        lsrs	r4, r0, #4
@   0x080206d2: 0802        lsrs	r2, r0, #32
@   0x080206d4: 0904        lsrs	r4, r0, #4
@   0x080206d6: 0802        lsrs	r2, r0, #32
@   0x080206d8: 0904        lsrs	r4, r0, #4
@   0x080206da: 0802        lsrs	r2, r0, #32
@   0x080206dc: 0904        lsrs	r4, r0, #4
@   0x080206de: 0802        lsrs	r2, r0, #32
@   0x080206e0: 0904        lsrs	r4, r0, #4
@   0x080206e2: 0802        lsrs	r2, r0, #32
@   0x080206e4: 0904        lsrs	r4, r0, #4
@   0x080206e6: 0802        lsrs	r2, r0, #32
@   0x080206e8: 0904        lsrs	r4, r0, #4
@   0x080206ea: 0802        lsrs	r2, r0, #32
@   0x080206ec: 0904        lsrs	r4, r0, #4
@   0x080206ee: 0802        lsrs	r2, r0, #32
@   0x080206f0: 0904        lsrs	r4, r0, #4
@   0x080206f2: 0802        lsrs	r2, r0, #32
@   0x080206f4: 0904        lsrs	r4, r0, #4
@   0x080206f6: 0802        lsrs	r2, r0, #32
@   0x080206f8: 0904        lsrs	r4, r0, #4
@   0x080206fa: 0802        lsrs	r2, r0, #32
@   0x080206fc: 0904        lsrs	r4, r0, #4
@   0x080206fe: 0802        lsrs	r2, r0, #32
@   0x08020700: 0904        lsrs	r4, r0, #4
@   0x08020702: 0802        lsrs	r2, r0, #32
@   0x08020704: 0904        lsrs	r4, r0, #4
@   0x08020706: 0802        lsrs	r2, r0, #32
@   0x08020708: 0904        lsrs	r4, r0, #4
@   0x0802070a: 0802        lsrs	r2, r0, #32
@   0x0802070c: 0904        lsrs	r4, r0, #4
@   0x0802070e: 0802        lsrs	r2, r0, #32
@   0x08020710: 0904        lsrs	r4, r0, #4
@   0x08020712: 0802        lsrs	r2, r0, #32
@   0x08020714: 0904        lsrs	r4, r0, #4
@   0x08020716: 0802        lsrs	r2, r0, #32
@   0x08020718: 0904        lsrs	r4, r0, #4
@   0x0802071a: 0802        lsrs	r2, r0, #32
@   0x0802071c: 0904        lsrs	r4, r0, #4
@   0x0802071e: 0802        lsrs	r2, r0, #32
@   0x08020720: 0904        lsrs	r4, r0, #4
@   0x08020722: 0802        lsrs	r2, r0, #32
@   0x08020724: 075e        lsls	r6, r3, #29
@   0x08020726: 0802        lsrs	r2, r0, #32
@   0x08020728: 0904        lsrs	r4, r0, #4
@   0x0802072a: 0802        lsrs	r2, r0, #32
@   0x0802072c: 0904        lsrs	r4, r0, #4
@   0x0802072e: 0802        lsrs	r2, r0, #32
@   0x08020730: 0904        lsrs	r4, r0, #4
@   0x08020732: 0802        lsrs	r2, r0, #32
@   0x08020734: 0904        lsrs	r4, r0, #4
@   0x08020736: 0802        lsrs	r2, r0, #32
@   0x08020738: 08e4        lsrs	r4, r4, #3
@   0x0802073a: 0802        lsrs	r2, r0, #32
@   0x0802073c: 0904        lsrs	r4, r0, #4
@   0x0802073e: 0802        lsrs	r2, r0, #32
@   0x08020740: 0904        lsrs	r4, r0, #4
@   0x08020742: 0802        lsrs	r2, r0, #32
@   0x08020744: 08f8        lsrs	r0, r7, #3
@   0x08020746: 0802        lsrs	r2, r0, #32
@   0x08020748: 08ea        lsrs	r2, r5, #3
@   0x0802074a: 0802        lsrs	r2, r0, #32
@   0x0802074c: 1c10        adds	r0, r2, #0
@   0x0802074e: 2102        movs	r1, #2
@   0x08020750: e041        b.n	0x207d6
@   0x08020752: 1c10        adds	r0, r2, #0
@   0x08020754: 2103        movs	r1, #3
@   0x08020756: e03e        b.n	0x207d6
@   0x08020758: 1c10        adds	r0, r2, #0
@   0x0802075a: 2104        movs	r1, #4
@   0x0802075c: e03b        b.n	0x207d6
@   0x0802075e: 1c10        adds	r0, r2, #0
@   0x08020760: 2102        movs	r1, #2
@   0x08020762: e0c4        b.n	0x208ee
@   0x08020764: 1c10        adds	r0, r2, #0
@   0x08020766: 2102        movs	r1, #2
@   0x08020768: 2202        movs	r2, #2
@   0x0802076a: e035        b.n	0x207d8
@   0x0802076c: 1c10        adds	r0, r2, #0
@   0x0802076e: 2101        movs	r1, #1
@   0x08020770: 2201        movs	r2, #1
@   0x08020772: f001        fb5f 	bl	0x21e34
@   0x08020776: 0600        lsls	r0, r0, #24
@   0x08020778: 2800        cmp	r0, #0
@   0x0802077a: d100        bne.n	0x2077e
@   0x0802077c: e0c2        b.n	0x20904
@   0x0802077e: 4d0f        ldr	r5, [pc, #60]	@ (0x207bc)
@   0x08020780: 6a28        ldr	r0, [r5, #32]
@   0x08020782: f00d        fcff 	bl	0x2e184
@   0x08020786: 2800        cmp	r0, #0
@   0x08020788: d000        beq.n	0x2078c
@   0x0802078a: e0bb        b.n	0x20904
@   0x0802078c: 69e9        ldr	r1, [r5, #28]
@   0x0802078e: 2401        movs	r4, #1
@   0x08020790: 4264        negs	r4, r4
@   0x08020792: 2010        movs	r0, #16
@   0x08020794: 782a        ldrb	r2, [r5, #0]
@   0x08020796: 4010        ands	r0, r2
@   0x08020798: 2800        cmp	r0, #0
@   0x0802079a: d00c        beq.n	0x207b6
@   0x0802079c: 1c08        adds	r0, r1, #0
@   0x0802079e: 21ff        movs	r1, #255	@ 0xff
@   0x080207a0: 22ff        movs	r2, #255	@ 0xff
@   0x080207a2: 23ff        movs	r3, #255	@ 0xff
@   0x080207a4: f00d        f922 	bl	0x2d9ec
@   0x080207a8: 1c04        adds	r4, r0, #0
@   0x080207aa: 217f        movs	r1, #127	@ 0x7f
@   0x080207ac: 78a8        ldrb	r0, [r5, #2]
@   0x080207ae: 4001        ands	r1, r0
@   0x080207b0: 1c20        adds	r0, r4, #0
@   0x080207b2: f00d        fa33 	bl	0x2dc1c
@   0x080207b6: 622c        str	r4, [r5, #32]
@   0x080207b8: e0a4        b.n	0x20904
@   0x080207ba: 0000        movs	r0, r0
@   0x080207bc: 3570        adds	r5, #112	@ 0x70
@   0x080207be: 0300        lsls	r0, r0, #12
@   0x080207c0: 1c10        adds	r0, r2, #0
@   0x080207c2: 2102        movs	r1, #2
@   0x080207c4: e007        b.n	0x207d6
@   0x080207c6: 1c10        adds	r0, r2, #0
@   0x080207c8: 2103        movs	r1, #3
@   0x080207ca: e090        b.n	0x208ee
@   0x080207cc: 1c10        adds	r0, r2, #0
@   0x080207ce: 2104        movs	r1, #4
@   0x080207d0: e08d        b.n	0x208ee
@   0x080207d2: 1c10        adds	r0, r2, #0
@   0x080207d4: 2105        movs	r1, #5
@   0x080207d6: 2201        movs	r2, #1
@   0x080207d8: 2302        movs	r3, #2
@   0x080207da: f7ff        fe1b 	bl	0x20414
@   0x080207de: e091        b.n	0x20904
@   0x080207e0: 1c10        adds	r0, r2, #0
@   0x080207e2: 2101        movs	r1, #1
@   0x080207e4: 2201        movs	r2, #1
@   0x080207e6: f001        fb25 	bl	0x21e34
@   0x080207ea: 0600        lsls	r0, r0, #24
@   0x080207ec: 2800        cmp	r0, #0
@   0x080207ee: d01f        beq.n	0x20830
@   0x080207f0: 4d0e        ldr	r5, [pc, #56]	@ (0x2082c)
@   0x080207f2: 6ca8        ldr	r0, [r5, #72]	@ 0x48
@   0x080207f4: f00d        fcc6 	bl	0x2e184
@   0x080207f8: 2800        cmp	r0, #0
@   0x080207fa: d000        beq.n	0x207fe
@   0x080207fc: e082        b.n	0x20904
@   0x080207fe: 6c69        ldr	r1, [r5, #68]	@ 0x44
@   0x08020800: 2401        movs	r4, #1
@   0x08020802: 4264        negs	r4, r4
@   0x08020804: 2010        movs	r0, #16
@   0x08020806: 782a        ldrb	r2, [r5, #0]
@   0x08020808: 4010        ands	r0, r2
@   0x0802080a: 2800        cmp	r0, #0
@   0x0802080c: d00c        beq.n	0x20828
@   0x0802080e: 1c08        adds	r0, r1, #0
@   0x08020810: 21ff        movs	r1, #255	@ 0xff
@   0x08020812: 22ff        movs	r2, #255	@ 0xff
@   0x08020814: 23ff        movs	r3, #255	@ 0xff
@   0x08020816: f00d        f8e9 	bl	0x2d9ec
@   0x0802081a: 1c04        adds	r4, r0, #0
@   0x0802081c: 217f        movs	r1, #127	@ 0x7f
@   0x0802081e: 78a8        ldrb	r0, [r5, #2]
@   0x08020820: 4001        ands	r1, r0
@   0x08020822: 1c20        adds	r0, r4, #0
@   0x08020824: f00d        f9fa 	bl	0x2dc1c
@   0x08020828: 64ac        str	r4, [r5, #72]	@ 0x48
@   0x0802082a: e06b        b.n	0x20904
@   0x0802082c: 3570        adds	r5, #112	@ 0x70
@   0x0802082e: 0300        lsls	r0, r0, #12
@   0x08020830: 4802        ldr	r0, [pc, #8]	@ (0x2083c)
@   0x08020832: 6c80        ldr	r0, [r0, #72]	@ 0x48
@   0x08020834: f00d        fc64 	bl	0x2e100
@   0x08020838: e064        b.n	0x20904
@   0x0802083a: 0000        movs	r0, r0
@   0x0802083c: 3570        adds	r5, #112	@ 0x70
@   0x0802083e: 0300        lsls	r0, r0, #12
@   0x08020840: 1c10        adds	r0, r2, #0
@   0x08020842: 2101        movs	r1, #1
@   0x08020844: 2201        movs	r2, #1
@   0x08020846: f001        faf5 	bl	0x21e34
@   0x0802084a: 0600        lsls	r0, r0, #24
@   0x0802084c: 2800        cmp	r0, #0
@   0x0802084e: d059        beq.n	0x20904
@   0x08020850: 4d0e        ldr	r5, [pc, #56]	@ (0x2088c)
@   0x08020852: 69a8        ldr	r0, [r5, #24]
@   0x08020854: f00d        fc96 	bl	0x2e184
@   0x08020858: 2800        cmp	r0, #0
@   0x0802085a: d153        bne.n	0x20904
@   0x0802085c: 6969        ldr	r1, [r5, #20]
@   0x0802085e: 2401        movs	r4, #1
@   0x08020860: 4264        negs	r4, r4
@   0x08020862: 2010        movs	r0, #16
@   0x08020864: 782a        ldrb	r2, [r5, #0]
@   0x08020866: 4010        ands	r0, r2
@   0x08020868: 2800        cmp	r0, #0
@   0x0802086a: d00c        beq.n	0x20886
@   0x0802086c: 1c08        adds	r0, r1, #0
@   0x0802086e: 21ff        movs	r1, #255	@ 0xff
@   0x08020870: 22ff        movs	r2, #255	@ 0xff
@   0x08020872: 23ff        movs	r3, #255	@ 0xff
@   0x08020874: f00d        f8ba 	bl	0x2d9ec
@   0x08020878: 1c04        adds	r4, r0, #0
@   0x0802087a: 217f        movs	r1, #127	@ 0x7f
@   0x0802087c: 78a8        ldrb	r0, [r5, #2]
@   0x0802087e: 4001        ands	r1, r0
@   0x08020880: 1c20        adds	r0, r4, #0
@   0x08020882: f00d        f9cb 	bl	0x2dc1c
@   0x08020886: 61ac        str	r4, [r5, #24]
@   0x08020888: e03c        b.n	0x20904
@   0x0802088a: 0000        movs	r0, r0
@   0x0802088c: 3570        adds	r5, #112	@ 0x70
@   0x0802088e: 0300        lsls	r0, r0, #12
@   0x08020890: 1c10        adds	r0, r2, #0
@   0x08020892: 2103        movs	r1, #3
@   0x08020894: e02b        b.n	0x208ee
@   0x08020896: 1c10        adds	r0, r2, #0
@   0x08020898: 2101        movs	r1, #1
@   0x0802089a: 2201        movs	r2, #1
@   0x0802089c: f001        faca 	bl	0x21e34
@   0x080208a0: 0600        lsls	r0, r0, #24
@   0x080208a2: 2800        cmp	r0, #0
@   0x080208a4: d02e        beq.n	0x20904
@   0x080208a6: 4d0e        ldr	r5, [pc, #56]	@ (0x208e0)
@   0x080208a8: 6aa8        ldr	r0, [r5, #40]	@ 0x28
@   0x080208aa: f00d        fc6b 	bl	0x2e184
@   0x080208ae: 2800        cmp	r0, #0
@   0x080208b0: d128        bne.n	0x20904
@   0x080208b2: 6a69        ldr	r1, [r5, #36]	@ 0x24
@   0x080208b4: 2401        movs	r4, #1
@   0x080208b6: 4264        negs	r4, r4
@   0x080208b8: 2010        movs	r0, #16
@   0x080208ba: 782a        ldrb	r2, [r5, #0]
@   0x080208bc: 4010        ands	r0, r2
@   0x080208be: 2800        cmp	r0, #0
@   0x080208c0: d00c        beq.n	0x208dc
@   0x080208c2: 1c08        adds	r0, r1, #0
@   0x080208c4: 21ff        movs	r1, #255	@ 0xff
@   0x080208c6: 22ff        movs	r2, #255	@ 0xff
@   0x080208c8: 23ff        movs	r3, #255	@ 0xff
@   0x080208ca: f00d        f88f 	bl	0x2d9ec
@   0x080208ce: 1c04        adds	r4, r0, #0
@   0x080208d0: 217f        movs	r1, #127	@ 0x7f
@   0x080208d2: 78a8        ldrb	r0, [r5, #2]
@   0x080208d4: 4001        ands	r1, r0
@   0x080208d6: 1c20        adds	r0, r4, #0
@   0x080208d8: f00d        f9a0 	bl	0x2dc1c
@   0x080208dc: 62ac        str	r4, [r5, #40]	@ 0x28
@   0x080208de: e011        b.n	0x20904
@   0x080208e0: 3570        adds	r5, #112	@ 0x70
@   0x080208e2: 0300        lsls	r0, r0, #12
@   0x080208e4: 1c10        adds	r0, r2, #0
@   0x080208e6: 2104        movs	r1, #4
@   0x080208e8: e001        b.n	0x208ee
@   0x080208ea: 1c10        adds	r0, r2, #0
@   0x080208ec: 2106        movs	r1, #6
@   0x080208ee: 2201        movs	r2, #1
@   0x080208f0: 2301        movs	r3, #1
@   0x080208f2: f7ff        fd8f 	bl	0x20414
@   0x080208f6: e005        b.n	0x20904
@   0x080208f8: 1c10        adds	r0, r2, #0
@   0x080208fa: 2107        movs	r1, #7
@   0x080208fc: 2201        movs	r2, #1
@   0x080208fe: 2301        movs	r3, #1
@   0x08020900: f7ff        fd88 	bl	0x20414
@   0x08020904: bc30        pop	{r4, r5}
@   0x08020906: bc01        pop	{r0}
@   0x08020908: 4700        bx	r0

        thumb_func_start sub_080205D8
sub_080205D8: @ 0x080205d8
        .incbin "frog_us_baserom.gba", 0x205d8, 0x334
        thumb_func_end sub_080205D8
