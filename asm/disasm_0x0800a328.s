@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0800a328, 0x0800a3d0)  (168 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x800a328 --end 0x800a3d0 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0800a328: b510        push	{r4, lr}
@   0x0800a32a: 4c17        ldr	r4, [pc, #92]	@ (0xa388)
@   0x0800a32c: 8821        ldrh	r1, [r4, #0]
@   0x0800a32e: 4817        ldr	r0, [pc, #92]	@ (0xa38c)
@   0x0800a330: 4008        ands	r0, r1
@   0x0800a332: 8020        strh	r0, [r4, #0]
@   0x0800a334: 4816        ldr	r0, [pc, #88]	@ (0xa390)
@   0x0800a336: 4917        ldr	r1, [pc, #92]	@ (0xa394)
@   0x0800a338: 7a89        ldrb	r1, [r1, #10]
@   0x0800a33a: 1808        adds	r0, r1, r0
@   0x0800a33c: 7800        ldrb	r0, [r0, #0]
@   0x0800a33e: f005        fcc3 	bl	0xfcc8
@   0x0800a342: f7fb        fe41 	bl	0x5fc8
@   0x0800a346: 4814        ldr	r0, [pc, #80]	@ (0xa398)
@   0x0800a348: 21e0        movs	r1, #224	@ 0xe0
@   0x0800a34a: 04c9        lsls	r1, r1, #19
@   0x0800a34c: 2280        movs	r2, #128	@ 0x80
@   0x0800a34e: 0052        lsls	r2, r2, #1
@   0x0800a350: f023        f902 	bl	0x2d558
@   0x0800a354: 4911        ldr	r1, [pc, #68]	@ (0xa39c)
@   0x0800a356: 4a12        ldr	r2, [pc, #72]	@ (0xa3a0)
@   0x0800a358: 8810        ldrh	r0, [r2, #0]
@   0x0800a35a: 8008        strh	r0, [r1, #0]
@   0x0800a35c: 3102        adds	r1, #2
@   0x0800a35e: 8850        ldrh	r0, [r2, #2]
@   0x0800a360: 8008        strh	r0, [r1, #0]
@   0x0800a362: 3102        adds	r1, #2
@   0x0800a364: 8890        ldrh	r0, [r2, #4]
@   0x0800a366: 8008        strh	r0, [r1, #0]
@   0x0800a368: 3102        adds	r1, #2
@   0x0800a36a: 88d0        ldrh	r0, [r2, #6]
@   0x0800a36c: 8008        strh	r0, [r1, #0]
@   0x0800a36e: 3102        adds	r1, #2
@   0x0800a370: 8910        ldrh	r0, [r2, #8]
@   0x0800a372: 8008        strh	r0, [r1, #0]
@   0x0800a374: 3102        adds	r1, #2
@   0x0800a376: 8950        ldrh	r0, [r2, #10]
@   0x0800a378: 8008        strh	r0, [r1, #0]
@   0x0800a37a: 8820        ldrh	r0, [r4, #0]
@   0x0800a37c: 2101        movs	r1, #1
@   0x0800a37e: 4308        orrs	r0, r1
@   0x0800a380: 8020        strh	r0, [r4, #0]
@   0x0800a382: bc10        pop	{r4}
@   0x0800a384: bc01        pop	{r0}
@   0x0800a386: 4700        bx	r0
@   0x0800a388: 0200        lsls	r0, r0, #8
@   0x0800a38a: 0400        lsls	r0, r0, #16
@   0x0800a38c: fffe        0000 	vaddl.u<illegal width 64>	q8, d14, d0
@   0x0800a390: 0d84        lsrs	r4, r0, #22
@   0x0800a392: 080c        lsrs	r4, r1, #32
@   0x0800a394: 5330        strh	r0, [r6, r4]
@   0x0800a396: 0300        lsls	r0, r0, #12
@   0x0800a398: 54a0        strb	r0, [r4, r2]
@   0x0800a39a: 0300        lsls	r0, r0, #12
@   0x0800a39c: 0010        movs	r0, r2
@   0x0800a39e: 0400        lsls	r0, r0, #16
@   0x0800a3a0: 3550        adds	r5, #80	@ 0x50
@   0x0800a3a2: 0300        lsls	r0, r0, #12
@   0x0800a3a4: b530        push	{r4, r5, lr}
@   0x0800a3a6: 6802        ldr	r2, [r0, #0]
@   0x0800a3a8: 6843        ldr	r3, [r0, #4]
@   0x0800a3aa: 680c        ldr	r4, [r1, #0]
@   0x0800a3ac: 684d        ldr	r5, [r1, #4]
@   0x0800a3ae: 8840        ldrh	r0, [r0, #2]
@   0x0800a3b0: 8849        ldrh	r1, [r1, #2]
@   0x0800a3b2: 4288        cmp	r0, r1
@   0x0800a3b4: d201        bcs.n	0xa3ba
@   0x0800a3b6: 2001        movs	r0, #1
@   0x0800a3b8: e007        b.n	0xa3ca
@   0x0800a3ba: 0c11        lsrs	r1, r2, #16
@   0x0800a3bc: 0c20        lsrs	r0, r4, #16
@   0x0800a3be: 4281        cmp	r1, r0
@   0x0800a3c0: d801        bhi.n	0xa3c6
@   0x0800a3c2: 2000        movs	r0, #0
@   0x0800a3c4: e001        b.n	0xa3ca
@   0x0800a3c6: 2001        movs	r0, #1
@   0x0800a3c8: 4240        negs	r0, r0
@   0x0800a3ca: bc30        pop	{r4, r5}
@   0x0800a3cc: bc02        pop	{r1}
@   0x0800a3ce: 4708        bx	r1

        thumb_func_start sub_0800A328
sub_0800A328: @ 0x0800a328
        .incbin "frog_us_baserom.gba", 0xa328, 0xa8
        thumb_func_end sub_0800A328
