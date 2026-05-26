@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802e724, 0x0802e7c4)  (160 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802e724 --end 0x802e7c4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802e724: b530        push	{r4, r5, lr}
@   0x0802e726: 1c04        adds	r4, r0, #0
@   0x0802e728: 2c03        cmp	r4, #3
@   0x0802e72a: dc31        bgt.n	0x2e790
@   0x0802e72c: 480e        ldr	r0, [pc, #56]	@ (0x2e768)
@   0x0802e72e: 6805        ldr	r5, [r0, #0]
@   0x0802e730: 00a3        lsls	r3, r4, #2
@   0x0802e732: 1c29        adds	r1, r5, #0
@   0x0802e734: 3110        adds	r1, #16
@   0x0802e736: 18c9        adds	r1, r1, r3
@   0x0802e738: 6808        ldr	r0, [r1, #0]
@   0x0802e73a: 2222        movs	r2, #34	@ 0x22
@   0x0802e73c: 4252        negs	r2, r2
@   0x0802e73e: 4010        ands	r0, r2
@   0x0802e740: 6008        str	r0, [r1, #0]
@   0x0802e742: 2c02        cmp	r4, #2
@   0x0802e744: dc07        bgt.n	0x2e756
@   0x0802e746: 0061        lsls	r1, r4, #1
@   0x0802e748: 1c28        adds	r0, r5, #0
@   0x0802e74a: 30b4        adds	r0, #180	@ 0xb4
@   0x0802e74c: 1840        adds	r0, r0, r1
@   0x0802e74e: 2100        movs	r1, #0
@   0x0802e750: 8001        strh	r1, [r0, #0]
@   0x0802e752: 2c02        cmp	r4, #2
@   0x0802e754: d00c        beq.n	0x2e770
@   0x0802e756: 4805        ldr	r0, [pc, #20]	@ (0x2e76c)
@   0x0802e758: 1818        adds	r0, r3, r0
@   0x0802e75a: 6801        ldr	r1, [r0, #0]
@   0x0802e75c: 2280        movs	r2, #128	@ 0x80
@   0x0802e75e: 0112        lsls	r2, r2, #4
@   0x0802e760: 1c10        adds	r0, r2, #0
@   0x0802e762: 8008        strh	r0, [r1, #0]
@   0x0802e764: e007        b.n	0x2e776
@   0x0802e766: 0000        movs	r0, r0
@   0x0802e768: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e76a: 0300        lsls	r0, r0, #12
@   0x0802e76c: da2c        bge.n	0x2e7c8
@   0x0802e76e: 083d        lsrs	r5, r7, #32
@   0x0802e770: 4805        ldr	r0, [pc, #20]	@ (0x2e788)
@   0x0802e772: 6880        ldr	r0, [r0, #8]
@   0x0802e774: 8001        strh	r1, [r0, #0]
@   0x0802e776: 4805        ldr	r0, [pc, #20]	@ (0x2e78c)
@   0x0802e778: 1818        adds	r0, r3, r0
@   0x0802e77a: 6801        ldr	r1, [r0, #0]
@   0x0802e77c: 2280        movs	r2, #128	@ 0x80
@   0x0802e77e: 0212        lsls	r2, r2, #8
@   0x0802e780: 1c10        adds	r0, r2, #0
@   0x0802e782: 8008        strh	r0, [r1, #0]
@   0x0802e784: e016        b.n	0x2e7b4
@   0x0802e786: 0000        movs	r0, r0
@   0x0802e788: da2c        bge.n	0x2e7e4
@   0x0802e78a: 083d        lsrs	r5, r7, #32
@   0x0802e78c: da1c        bge.n	0x2e7c8
@   0x0802e78e: 083d        lsrs	r5, r7, #32
@   0x0802e790: 3c04        subs	r4, #4
@   0x0802e792: 480a        ldr	r0, [pc, #40]	@ (0x2e7bc)
@   0x0802e794: 6802        ldr	r2, [r0, #0]
@   0x0802e796: 1c10        adds	r0, r2, #0
@   0x0802e798: 30c4        adds	r0, #196	@ 0xc4
@   0x0802e79a: 6801        ldr	r1, [r0, #0]
@   0x0802e79c: 00a0        lsls	r0, r4, #2
@   0x0802e79e: 1840        adds	r0, r0, r1
@   0x0802e7a0: 2100        movs	r1, #0
@   0x0802e7a2: 6001        str	r1, [r0, #0]
@   0x0802e7a4: 32c8        adds	r2, #200	@ 0xc8
@   0x0802e7a6: 6810        ldr	r0, [r2, #0]
@   0x0802e7a8: 01a1        lsls	r1, r4, #6
@   0x0802e7aa: 1809        adds	r1, r1, r0
@   0x0802e7ac: 6b88        ldr	r0, [r1, #56]	@ 0x38
@   0x0802e7ae: 4a04        ldr	r2, [pc, #16]	@ (0x2e7c0)
@   0x0802e7b0: 4010        ands	r0, r2
@   0x0802e7b2: 6388        str	r0, [r1, #56]	@ 0x38
@   0x0802e7b4: bc30        pop	{r4, r5}
@   0x0802e7b6: bc01        pop	{r0}
@   0x0802e7b8: 4700        bx	r0
@   0x0802e7ba: 0000        movs	r0, r0
@   0x0802e7bc: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802e7be: 0300        lsls	r0, r0, #12
@   0x0802e7c0: fdff        ffff 			@ <UNDEFINED> instruction: 0xfdffffff

        thumb_func_start sub_0802E724
sub_0802E724: @ 0x0802e724
        .incbin "frog_us_baserom.gba", 0x2e724, 0xa0
        thumb_func_end sub_0802E724
