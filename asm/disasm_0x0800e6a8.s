@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800e6a8, 0x0800e85c)  (436 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800e6a8 --end 0x800e85c --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800e6a8: b510        push	{r4, lr}
@   0x0800e6aa: f7ff        ff07 	bl	0xe4bc
@   0x0800e6ae: 0600        lsls	r0, r0, #24
@   0x0800e6b0: 0e04        lsrs	r4, r0, #24
@   0x0800e6b2: f7f2        f913 	bl	0x8dc
@   0x0800e6b6: f7ff        fd5d 	bl	0xe174
@   0x0800e6ba: 480f        ldr	r0, [pc, #60]	@ (0xe6f8)
@   0x0800e6bc: 7800        ldrb	r0, [r0, #0]
@   0x0800e6be: 2800        cmp	r0, #0
@   0x0800e6c0: d001        beq.n	0xe6c6
@   0x0800e6c2: 2c00        cmp	r4, #0
@   0x0800e6c4: d109        bne.n	0xe6da
@   0x0800e6c6: 490d        ldr	r1, [pc, #52]	@ (0xe6fc)
@   0x0800e6c8: 20fe        movs	r0, #254	@ 0xfe
@   0x0800e6ca: 7e0a        ldrb	r2, [r1, #24]
@   0x0800e6cc: 4010        ands	r0, r2
@   0x0800e6ce: 2200        movs	r2, #0
@   0x0800e6d0: 7608        strb	r0, [r1, #24]
@   0x0800e6d2: 480b        ldr	r0, [pc, #44]	@ (0xe700)
@   0x0800e6d4: 7042        strb	r2, [r0, #1]
@   0x0800e6d6: f012        fa4f 	bl	0x20b78
@   0x0800e6da: 4807        ldr	r0, [pc, #28]	@ (0xe6f8)
@   0x0800e6dc: 7800        ldrb	r0, [r0, #0]
@   0x0800e6de: 2800        cmp	r0, #0
@   0x0800e6e0: d13a        bne.n	0xe758
@   0x0800e6e2: 4806        ldr	r0, [pc, #24]	@ (0xe6fc)
@   0x0800e6e4: 7a80        ldrb	r0, [r0, #10]
@   0x0800e6e6: 3801        subs	r0, #1
@   0x0800e6e8: 280f        cmp	r0, #15
@   0x0800e6ea: d835        bhi.n	0xe758
@   0x0800e6ec: 0080        lsls	r0, r0, #2
@   0x0800e6ee: 4905        ldr	r1, [pc, #20]	@ (0xe704)
@   0x0800e6f0: 1840        adds	r0, r0, r1
@   0x0800e6f2: 6800        ldr	r0, [r0, #0]
@   0x0800e6f4: 4687        mov	pc, r0
@   0x0800e6f6: 0000        movs	r0, r0
@   0x0800e6f8: 5328        strh	r0, [r5, r4]
@   0x0800e6fa: 0300        lsls	r0, r0, #12
@   0x0800e6fc: 5330        strh	r0, [r6, r4]
@   0x0800e6fe: 0300        lsls	r0, r0, #12
@   0x0800e700: 34a0        adds	r4, #160	@ 0xa0
@   0x0800e702: 0300        lsls	r0, r0, #12
@   0x0800e704: e708        b.n	0xe518
@   0x0800e706: 0800        lsrs	r0, r0, #32
@   0x0800e708: e758        b.n	0xe5bc
@   0x0800e70a: 0800        lsrs	r0, r0, #32
@   0x0800e70c: e758        b.n	0xe5c0
@   0x0800e70e: 0800        lsrs	r0, r0, #32
@   0x0800e710: e748        b.n	0xe5a4
@   0x0800e712: 0800        lsrs	r0, r0, #32
@   0x0800e714: e758        b.n	0xe5c8
@   0x0800e716: 0800        lsrs	r0, r0, #32
@   0x0800e718: e758        b.n	0xe5cc
@   0x0800e71a: 0800        lsrs	r0, r0, #32
@   0x0800e71c: e748        b.n	0xe5b0
@   0x0800e71e: 0800        lsrs	r0, r0, #32
@   0x0800e720: e758        b.n	0xe5d4
@   0x0800e722: 0800        lsrs	r0, r0, #32
@   0x0800e724: e758        b.n	0xe5d8
@   0x0800e726: 0800        lsrs	r0, r0, #32
@   0x0800e728: e748        b.n	0xe5bc
@   0x0800e72a: 0800        lsrs	r0, r0, #32
@   0x0800e72c: e758        b.n	0xe5e0
@   0x0800e72e: 0800        lsrs	r0, r0, #32
@   0x0800e730: e758        b.n	0xe5e4
@   0x0800e732: 0800        lsrs	r0, r0, #32
@   0x0800e734: e758        b.n	0xe5e8
@   0x0800e736: 0800        lsrs	r0, r0, #32
@   0x0800e738: e758        b.n	0xe5ec
@   0x0800e73a: 0800        lsrs	r0, r0, #32
@   0x0800e73c: e758        b.n	0xe5f0
@   0x0800e73e: 0800        lsrs	r0, r0, #32
@   0x0800e740: e748        b.n	0xe5d4
@   0x0800e742: 0800        lsrs	r0, r0, #32
@   0x0800e744: e758        b.n	0xe5f8
@   0x0800e746: 0800        lsrs	r0, r0, #32
@   0x0800e748: 4905        ldr	r1, [pc, #20]	@ (0xe760)
@   0x0800e74a: 4a06        ldr	r2, [pc, #24]	@ (0xe764)
@   0x0800e74c: 1c10        adds	r0, r2, #0
@   0x0800e74e: 8008        strh	r0, [r1, #0]
@   0x0800e750: 3102        adds	r1, #2
@   0x0800e752: 4a05        ldr	r2, [pc, #20]	@ (0xe768)
@   0x0800e754: 1c10        adds	r0, r2, #0
@   0x0800e756: 8008        strh	r0, [r1, #0]
@   0x0800e758: 1c20        adds	r0, r4, #0
@   0x0800e75a: bc10        pop	{r4}
@   0x0800e75c: bc02        pop	{r1}
@   0x0800e75e: 4708        bx	r1
@   0x0800e760: 0050        lsls	r0, r2, #1
@   0x0800e762: 0400        lsls	r0, r0, #16
@   0x0800e764: 1748        asrs	r0, r1, #29
@   0x0800e766: 0000        movs	r0, r0
@   0x0800e768: 0a06        lsrs	r6, r0, #8
@   0x0800e76a: 0000        movs	r0, r0
@   0x0800e76c: 4804        ldr	r0, [pc, #16]	@ (0xe780)
@   0x0800e76e: 7a80        ldrb	r0, [r0, #10]
@   0x0800e770: 3801        subs	r0, #1
@   0x0800e772: 280f        cmp	r0, #15
@   0x0800e774: d82b        bhi.n	0xe7ce
@   0x0800e776: 0080        lsls	r0, r0, #2
@   0x0800e778: 4902        ldr	r1, [pc, #8]	@ (0xe784)
@   0x0800e77a: 1840        adds	r0, r0, r1
@   0x0800e77c: 6800        ldr	r0, [r0, #0]
@   0x0800e77e: 4687        mov	pc, r0
@   0x0800e780: 5330        strh	r0, [r6, r4]
@   0x0800e782: 0300        lsls	r0, r0, #12
@   0x0800e784: e788        b.n	0xe698
@   0x0800e786: 0800        lsrs	r0, r0, #32
@   0x0800e788: e7ce        b.n	0xe728
@   0x0800e78a: 0800        lsrs	r0, r0, #32
@   0x0800e78c: e7ce        b.n	0xe72c
@   0x0800e78e: 0800        lsrs	r0, r0, #32
@   0x0800e790: e7c8        b.n	0xe724
@   0x0800e792: 0800        lsrs	r0, r0, #32
@   0x0800e794: e7ce        b.n	0xe734
@   0x0800e796: 0800        lsrs	r0, r0, #32
@   0x0800e798: e7ce        b.n	0xe738
@   0x0800e79a: 0800        lsrs	r0, r0, #32
@   0x0800e79c: e7c8        b.n	0xe730
@   0x0800e79e: 0800        lsrs	r0, r0, #32
@   0x0800e7a0: e7ce        b.n	0xe740
@   0x0800e7a2: 0800        lsrs	r0, r0, #32
@   0x0800e7a4: e7ce        b.n	0xe744
@   0x0800e7a6: 0800        lsrs	r0, r0, #32
@   0x0800e7a8: e7c8        b.n	0xe73c
@   0x0800e7aa: 0800        lsrs	r0, r0, #32
@   0x0800e7ac: e7ce        b.n	0xe74c
@   0x0800e7ae: 0800        lsrs	r0, r0, #32
@   0x0800e7b0: e7ce        b.n	0xe750
@   0x0800e7b2: 0800        lsrs	r0, r0, #32
@   0x0800e7b4: e7ce        b.n	0xe754
@   0x0800e7b6: 0800        lsrs	r0, r0, #32
@   0x0800e7b8: e7ce        b.n	0xe758
@   0x0800e7ba: 0800        lsrs	r0, r0, #32
@   0x0800e7bc: e7ce        b.n	0xe75c
@   0x0800e7be: 0800        lsrs	r0, r0, #32
@   0x0800e7c0: e7c8        b.n	0xe754
@   0x0800e7c2: 0800        lsrs	r0, r0, #32
@   0x0800e7c4: e7ce        b.n	0xe764
@   0x0800e7c6: 0800        lsrs	r0, r0, #32
@   0x0800e7c8: 4901        ldr	r1, [pc, #4]	@ (0xe7d0)
@   0x0800e7ca: 2000        movs	r0, #0
@   0x0800e7cc: 8008        strh	r0, [r1, #0]
@   0x0800e7ce: 4770        bx	lr
@   0x0800e7d0: 0050        lsls	r0, r2, #1
@   0x0800e7d2: 0400        lsls	r0, r0, #16
@   0x0800e7d4: 4804        ldr	r0, [pc, #16]	@ (0xe7e8)
@   0x0800e7d6: 7a80        ldrb	r0, [r0, #10]
@   0x0800e7d8: 3801        subs	r0, #1
@   0x0800e7da: 280f        cmp	r0, #15
@   0x0800e7dc: d830        bhi.n	0xe840
@   0x0800e7de: 0080        lsls	r0, r0, #2
@   0x0800e7e0: 4902        ldr	r1, [pc, #8]	@ (0xe7ec)
@   0x0800e7e2: 1840        adds	r0, r0, r1
@   0x0800e7e4: 6800        ldr	r0, [r0, #0]
@   0x0800e7e6: 4687        mov	pc, r0
@   0x0800e7e8: 5330        strh	r0, [r6, r4]
@   0x0800e7ea: 0300        lsls	r0, r0, #12
@   0x0800e7ec: e7f0        b.n	0xe7d0
@   0x0800e7ee: 0800        lsrs	r0, r0, #32
@   0x0800e7f0: e840        0800 	strex	r8, r0, [r0]
@   0x0800e7f4: e840        0800 	strex	r8, r0, [r0]
@   0x0800e7f8: e830        0800 			@ <UNDEFINED> instruction: 0xe8300800
@   0x0800e7fc: e840        0800 	strex	r8, r0, [r0]
@   0x0800e800: e840        0800 	strex	r8, r0, [r0]
@   0x0800e804: e830        0800 			@ <UNDEFINED> instruction: 0xe8300800
@   0x0800e808: e840        0800 	strex	r8, r0, [r0]
@   0x0800e80c: e840        0800 	strex	r8, r0, [r0]
@   0x0800e810: e830        0800 			@ <UNDEFINED> instruction: 0xe8300800
@   0x0800e814: e840        0800 	strex	r8, r0, [r0]
@   0x0800e818: e840        0800 	strex	r8, r0, [r0]
@   0x0800e81c: e840        0800 	strex	r8, r0, [r0]
@   0x0800e820: e840        0800 	strex	r8, r0, [r0]
@   0x0800e824: e840        0800 	strex	r8, r0, [r0]
@   0x0800e828: e830        0800 			@ <UNDEFINED> instruction: 0xe8300800
@   0x0800e82c: e840        0800 	strex	r8, r0, [r0]
@   0x0800e830: 4904        ldr	r1, [pc, #16]	@ (0xe844)
@   0x0800e832: 4a05        ldr	r2, [pc, #20]	@ (0xe848)
@   0x0800e834: 1c10        adds	r0, r2, #0
@   0x0800e836: 8008        strh	r0, [r1, #0]
@   0x0800e838: 3102        adds	r1, #2
@   0x0800e83a: 4a04        ldr	r2, [pc, #16]	@ (0xe84c)
@   0x0800e83c: 1c10        adds	r0, r2, #0
@   0x0800e83e: 8008        strh	r0, [r1, #0]
@   0x0800e840: 4770        bx	lr
@   0x0800e842: 0000        movs	r0, r0
@   0x0800e844: 0050        lsls	r0, r2, #1
@   0x0800e846: 0400        lsls	r0, r0, #16
@   0x0800e848: 1748        asrs	r0, r1, #29
@   0x0800e84a: 0000        movs	r0, r0
@   0x0800e84c: 0a06        lsrs	r6, r0, #8
@   0x0800e84e: 0000        movs	r0, r0
@   0x0800e850: b500        push	{lr}
@   0x0800e852: f001        fa7d 	bl	0xfd50
@   0x0800e856: bc01        pop	{r0}
@   0x0800e858: 4700        bx	r0

        thumb_func_start sub_0800E6A8
sub_0800E6A8: @ 0x0800e6a8
        .incbin "frog_us_baserom.gba", 0xe6a8, 0x12c
        thumb_func_end sub_0800E6A8

        thumb_func_start sub_0800E7D4
sub_0800E7D4: @ 0x0800e7d4
        .incbin "frog_us_baserom.gba", 0xe7d4, 0x88
        thumb_func_end sub_0800E7D4
