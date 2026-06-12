@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x0802572c, 0x08025904)  (472 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x802572c --end 0x8025904 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802572c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802572e: 4657        mov	r7, sl
@   0x08025730: 464e        mov	r6, r9
@   0x08025732: 4645        mov	r5, r8
@   0x08025734: b4e0        push	{r5, r6, r7}
@   0x08025736: 2700        movs	r7, #0
@   0x08025738: 4809        ldr	r0, [pc, #36]	@ (0x25760)
@   0x0802573a: 4681        mov	r9, r0
@   0x0802573c: 2102        movs	r1, #2
@   0x0802573e: 4688        mov	r8, r1
@   0x08025740: 2280        movs	r2, #128	@ 0x80
@   0x08025742: 0212        lsls	r2, r2, #8
@   0x08025744: 4692        mov	sl, r2
@   0x08025746: 00f8        lsls	r0, r7, #3
@   0x08025748: 1bc0        subs	r0, r0, r7
@   0x0802574a: 00c0        lsls	r0, r0, #3
@   0x0802574c: 464b        mov	r3, r9
@   0x0802574e: 18c4        adds	r4, r0, r3
@   0x08025750: 7ea0        ldrb	r0, [r4, #26]
@   0x08025752: 2801        cmp	r0, #1
@   0x08025754: d031        beq.n	0x257ba
@   0x08025756: 2801        cmp	r0, #1
@   0x08025758: dc04        bgt.n	0x25764
@   0x0802575a: 2800        cmp	r0, #0
@   0x0802575c: d008        beq.n	0x25770
@   0x0802575e: e004        b.n	0x2576a
@   0x08025760: 46e0        mov	r8, ip
@   0x08025762: 0300        lsls	r0, r0, #12
@   0x08025764: 2802        cmp	r0, #2
@   0x08025766: d100        bne.n	0x2576a
@   0x08025768: e07e        b.n	0x25868
@   0x0802576a: 1c3d        adds	r5, r7, #0
@   0x0802576c: 3548        adds	r5, #72	@ 0x48
@   0x0802576e: e0b1        b.n	0x258d4
@   0x08025770: 2602        movs	r6, #2
@   0x08025772: 4640        mov	r0, r8
@   0x08025774: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08025776: 4008        ands	r0, r1
@   0x08025778: 1c3d        adds	r5, r7, #0
@   0x0802577a: 3548        adds	r5, #72	@ 0x48
@   0x0802577c: 2800        cmp	r0, #0
@   0x0802577e: d000        beq.n	0x25782
@   0x08025780: e0a8        b.n	0x258d4
@   0x08025782: 7ee2        ldrb	r2, [r4, #27]
@   0x08025784: 2a01        cmp	r2, #1
@   0x08025786: d105        bne.n	0x25794
@   0x08025788: 1c20        adds	r0, r4, #0
@   0x0802578a: 2106        movs	r1, #6
@   0x0802578c: 2203        movs	r2, #3
@   0x0802578e: 2303        movs	r3, #3
@   0x08025790: f7fb        fb40 	bl	0x20e14
@   0x08025794: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08025796: 4650        mov	r0, sl
@   0x08025798: 4008        ands	r0, r1
@   0x0802579a: 2800        cmp	r0, #0
@   0x0802579c: d100        bne.n	0x257a0
@   0x0802579e: e099        b.n	0x258d4
@   0x080257a0: 2001        movs	r0, #1
@   0x080257a2: 76a0        strb	r0, [r4, #26]
@   0x080257a4: 1c08        adds	r0, r1, #0
@   0x080257a6: 4330        orrs	r0, r6
@   0x080257a8: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x080257aa: 1c20        adds	r0, r4, #0
@   0x080257ac: 2104        movs	r1, #4
@   0x080257ae: 2200        movs	r2, #0
@   0x080257b0: 2301        movs	r3, #1
@   0x080257b2: 425b        negs	r3, r3
@   0x080257b4: f7e4        fee4 	bl	0xa580
@   0x080257b8: e046        b.n	0x25848
@   0x080257ba: 2602        movs	r6, #2
@   0x080257bc: 4640        mov	r0, r8
@   0x080257be: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x080257c0: 4008        ands	r0, r1
@   0x080257c2: 1c3d        adds	r5, r7, #0
@   0x080257c4: 3548        adds	r5, #72	@ 0x48
@   0x080257c6: 2800        cmp	r0, #0
@   0x080257c8: d000        beq.n	0x257cc
@   0x080257ca: e083        b.n	0x258d4
@   0x080257cc: 2003        movs	r0, #3
@   0x080257ce: 464a        mov	r2, r9
@   0x080257d0: 7190        strb	r0, [r2, #6]
@   0x080257d2: 2304        movs	r3, #4
@   0x080257d4: 5ed1        ldrsh	r1, [r2, r3]
@   0x080257d6: 480b        ldr	r0, [pc, #44]	@ (0x25804)
@   0x080257d8: 4281        cmp	r1, r0
@   0x080257da: dc00        bgt.n	0x257de
@   0x080257dc: 7196        strb	r6, [r2, #6]
@   0x080257de: 2004        movs	r0, #4
@   0x080257e0: 5e21        ldrsh	r1, [r4, r0]
@   0x080257e2: 4809        ldr	r0, [pc, #36]	@ (0x25808)
@   0x080257e4: 88a2        ldrh	r2, [r4, #4]
@   0x080257e6: 4281        cmp	r1, r0
@   0x080257e8: dc10        bgt.n	0x2580c
@   0x080257ea: 2f00        cmp	r7, #0
@   0x080257ec: d10e        bne.n	0x2580c
@   0x080257ee: 76a6        strb	r6, [r4, #26]
@   0x080257f0: 1c20        adds	r0, r4, #0
@   0x080257f2: 2100        movs	r1, #0
@   0x080257f4: 2200        movs	r2, #0
@   0x080257f6: 2300        movs	r3, #0
@   0x080257f8: f7e4        fec2 	bl	0xa580
@   0x080257fc: 8ea0        ldrh	r0, [r4, #52]	@ 0x34
@   0x080257fe: 4330        orrs	r0, r6
@   0x08025800: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x08025802: e067        b.n	0x258d4
@   0x08025804: 018d        lsls	r5, r1, #6
@   0x08025806: 0000        movs	r0, r0
@   0x08025808: 01a3        lsls	r3, r4, #6
@   0x0802580a: 0000        movs	r0, r0
@   0x0802580c: 0410        lsls	r0, r2, #16
@   0x0802580e: 1400        asrs	r0, r0, #16
@   0x08025810: 2853        cmp	r0, #83	@ 0x53
@   0x08025812: dc0f        bgt.n	0x25834
@   0x08025814: 2f01        cmp	r7, #1
@   0x08025816: d10d        bne.n	0x25834
@   0x08025818: 4641        mov	r1, r8
@   0x0802581a: 76a1        strb	r1, [r4, #26]
@   0x0802581c: 1c20        adds	r0, r4, #0
@   0x0802581e: 2100        movs	r1, #0
@   0x08025820: 2200        movs	r2, #0
@   0x08025822: 2300        movs	r3, #0
@   0x08025824: f7e4        feac 	bl	0xa580
@   0x08025828: 4640        mov	r0, r8
@   0x0802582a: 8ea2        ldrh	r2, [r4, #52]	@ 0x34
@   0x0802582c: 4310        orrs	r0, r2
@   0x0802582e: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x08025830: 2549        movs	r5, #73	@ 0x49
@   0x08025832: e04f        b.n	0x258d4
@   0x08025834: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08025836: 4650        mov	r0, sl
@   0x08025838: 4008        ands	r0, r1
@   0x0802583a: 1c3d        adds	r5, r7, #0
@   0x0802583c: 3548        adds	r5, #72	@ 0x48
@   0x0802583e: 2800        cmp	r0, #0
@   0x08025840: d048        beq.n	0x258d4
@   0x08025842: 4640        mov	r0, r8
@   0x08025844: 4308        orrs	r0, r1
@   0x08025846: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x08025848: 00e8        lsls	r0, r5, #3
@   0x0802584a: 1b40        subs	r0, r0, r5
@   0x0802584c: 00c0        lsls	r0, r0, #3
@   0x0802584e: 4b04        ldr	r3, [pc, #16]	@ (0x25860)
@   0x08025850: 18c0        adds	r0, r0, r3
@   0x08025852: 4a04        ldr	r2, [pc, #16]	@ (0x25864)
@   0x08025854: 1c11        adds	r1, r2, #0
@   0x08025856: 8e83        ldrh	r3, [r0, #52]	@ 0x34
@   0x08025858: 4019        ands	r1, r3
@   0x0802585a: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x0802585c: e03a        b.n	0x258d4
@   0x0802585e: 0000        movs	r0, r0
@   0x08025860: 3720        adds	r7, #32
@   0x08025862: 0300        lsls	r0, r0, #12
@   0x08025864: 7fff        ldrb	r7, [r7, #31]
@   0x08025866: 0000        movs	r0, r0
@   0x08025868: 8ea6        ldrh	r6, [r4, #52]	@ 0x34
@   0x0802586a: 4006        ands	r6, r0
@   0x0802586c: 1c3d        adds	r5, r7, #0
@   0x0802586e: 3548        adds	r5, #72	@ 0x48
@   0x08025870: 2e00        cmp	r6, #0
@   0x08025872: d12f        bne.n	0x258d4
@   0x08025874: 7ee0        ldrb	r0, [r4, #27]
@   0x08025876: 2801        cmp	r0, #1
@   0x08025878: d105        bne.n	0x25886
@   0x0802587a: 1c20        adds	r0, r4, #0
@   0x0802587c: 2107        movs	r1, #7
@   0x0802587e: 2202        movs	r2, #2
@   0x08025880: 2302        movs	r3, #2
@   0x08025882: f7fb        fac7 	bl	0x20e14
@   0x08025886: 8ea0        ldrh	r0, [r4, #52]	@ 0x34
@   0x08025888: 4651        mov	r1, sl
@   0x0802588a: 4001        ands	r1, r0
@   0x0802588c: 1c02        adds	r2, r0, #0
@   0x0802588e: 2900        cmp	r1, #0
@   0x08025890: d020        beq.n	0x258d4
@   0x08025892: 76a6        strb	r6, [r4, #26]
@   0x08025894: 2f00        cmp	r7, #0
@   0x08025896: d103        bne.n	0x258a0
@   0x08025898: 4800        ldr	r0, [pc, #0]	@ (0x2589c)
@   0x0802589a: e004        b.n	0x258a6
@   0x0802589c: 0203        lsls	r3, r0, #8
@   0x0802589e: 0000        movs	r0, r0
@   0x080258a0: 2f01        cmp	r7, #1
@   0x080258a2: d101        bne.n	0x258a8
@   0x080258a4: 20b3        movs	r0, #179	@ 0xb3
@   0x080258a6: 80a0        strh	r0, [r4, #4]
@   0x080258a8: 4640        mov	r0, r8
@   0x080258aa: 4310        orrs	r0, r2
@   0x080258ac: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x080258ae: 1c20        adds	r0, r4, #0
@   0x080258b0: 2100        movs	r1, #0
@   0x080258b2: 2200        movs	r2, #0
@   0x080258b4: 2300        movs	r3, #0
@   0x080258b6: f7e4        fe63 	bl	0xa580
@   0x080258ba: 1c3a        adds	r2, r7, #0
@   0x080258bc: 3248        adds	r2, #72	@ 0x48
@   0x080258be: 00d0        lsls	r0, r2, #3
@   0x080258c0: 1a80        subs	r0, r0, r2
@   0x080258c2: 00c0        lsls	r0, r0, #3
@   0x080258c4: 490d        ldr	r1, [pc, #52]	@ (0x258fc)
@   0x080258c6: 1840        adds	r0, r0, r1
@   0x080258c8: 4b0d        ldr	r3, [pc, #52]	@ (0x25900)
@   0x080258ca: 1c19        adds	r1, r3, #0
@   0x080258cc: 8e83        ldrh	r3, [r0, #52]	@ 0x34
@   0x080258ce: 4019        ands	r1, r3
@   0x080258d0: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x080258d2: 1c15        adds	r5, r2, #0
@   0x080258d4: 0628        lsls	r0, r5, #24
@   0x080258d6: 0e00        lsrs	r0, r0, #24
@   0x080258d8: f7fb        fb30 	bl	0x20f3c
@   0x080258dc: 1c20        adds	r0, r4, #0
@   0x080258de: f7e0        f871 	bl	0x59c4
@   0x080258e2: 1c78        adds	r0, r7, #1
@   0x080258e4: 0600        lsls	r0, r0, #24
@   0x080258e6: 0e07        lsrs	r7, r0, #24
@   0x080258e8: 2f01        cmp	r7, #1
@   0x080258ea: d800        bhi.n	0x258ee
@   0x080258ec: e72b        b.n	0x25746
@   0x080258ee: bc38        pop	{r3, r4, r5}
@   0x080258f0: 4698        mov	r8, r3
@   0x080258f2: 46a1        mov	r9, r4
@   0x080258f4: 46aa        mov	sl, r5
@   0x080258f6: bcf0        pop	{r4, r5, r6, r7}
@   0x080258f8: bc01        pop	{r0}
@   0x080258fa: 4700        bx	r0
@   0x080258fc: 3720        adds	r7, #32
@   0x080258fe: 0300        lsls	r0, r0, #12
@   0x08025900: 7fff        ldrb	r7, [r7, #31]

        thumb_func_start sub_0802572C
sub_0802572C: @ 0x0802572c
        .incbin "baserom.gba", 0x2572c, 0x1d8
        thumb_func_end sub_0802572C
