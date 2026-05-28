@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080112c0, 0x080113e8)  (296 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80112c0 --end 0x80113e8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080112c0: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080112c2: 4657        mov	r7, sl
@   0x080112c4: 464e        mov	r6, r9
@   0x080112c6: 4645        mov	r5, r8
@   0x080112c8: b4e0        push	{r5, r6, r7}
@   0x080112ca: b084        sub	sp, #16
@   0x080112cc: 9c0c        ldr	r4, [sp, #48]	@ 0x30
@   0x080112ce: 9d0d        ldr	r5, [sp, #52]	@ 0x34
@   0x080112d0: 9e0e        ldr	r6, [sp, #56]	@ 0x38
@   0x080112d2: 0600        lsls	r0, r0, #24
@   0x080112d4: 0e00        lsrs	r0, r0, #24
@   0x080112d6: 4681        mov	r9, r0
@   0x080112d8: 0609        lsls	r1, r1, #24
@   0x080112da: 0e09        lsrs	r1, r1, #24
@   0x080112dc: 4688        mov	r8, r1
@   0x080112de: 0612        lsls	r2, r2, #24
@   0x080112e0: 0e12        lsrs	r2, r2, #24
@   0x080112e2: 4694        mov	ip, r2
@   0x080112e4: 041b        lsls	r3, r3, #16
@   0x080112e6: 0c1b        lsrs	r3, r3, #16
@   0x080112e8: 9303        str	r3, [sp, #12]
@   0x080112ea: 0424        lsls	r4, r4, #16
@   0x080112ec: 0c24        lsrs	r4, r4, #16
@   0x080112ee: 46a2        mov	sl, r4
@   0x080112f0: 062d        lsls	r5, r5, #24
@   0x080112f2: 0e2d        lsrs	r5, r5, #24
@   0x080112f4: 0636        lsls	r6, r6, #24
@   0x080112f6: 0e36        lsrs	r6, r6, #24
@   0x080112f8: 2d01        cmp	r5, #1
@   0x080112fa: d00a        beq.n	0x11312
@   0x080112fc: 2d01        cmp	r5, #1
@   0x080112fe: dc02        bgt.n	0x11306
@   0x08011300: 2d00        cmp	r5, #0
@   0x08011302: d003        beq.n	0x1130c
@   0x08011304: e00b        b.n	0x1131e
@   0x08011306: 2d02        cmp	r5, #2
@   0x08011308: d008        beq.n	0x1131c
@   0x0801130a: e008        b.n	0x1131e
@   0x0801130c: 2780        movs	r7, #128	@ 0x80
@   0x0801130e: 04bf        lsls	r7, r7, #18
@   0x08011310: e005        b.n	0x1131e
@   0x08011312: 4f01        ldr	r7, [pc, #4]	@ (0x11318)
@   0x08011314: e003        b.n	0x1131e
@   0x08011316: 0000        movs	r0, r0
@   0x08011318: 0000        movs	r0, r0
@   0x0801131a: 0201        lsls	r1, r0, #8
@   0x0801131c: 4f1d        ldr	r7, [pc, #116]	@ (0x11394)
@   0x0801131e: 4a1e        ldr	r2, [pc, #120]	@ (0x11398)
@   0x08011320: 481e        ldr	r0, [pc, #120]	@ (0x1139c)
@   0x08011322: 7a81        ldrb	r1, [r0, #10]
@   0x08011324: 3901        subs	r1, #1
@   0x08011326: 0088        lsls	r0, r1, #2
@   0x08011328: 1840        adds	r0, r0, r1
@   0x0801132a: 0080        lsls	r0, r0, #2
@   0x0801132c: 1880        adds	r0, r0, r2
@   0x0801132e: 6801        ldr	r1, [r0, #0]
@   0x08011330: 464a        mov	r2, r9
@   0x08011332: 0090        lsls	r0, r2, #2
@   0x08011334: 1840        adds	r0, r0, r1
@   0x08011336: 6801        ldr	r1, [r0, #0]
@   0x08011338: 00b0        lsls	r0, r6, #2
@   0x0801133a: 1840        adds	r0, r0, r1
@   0x0801133c: 6800        ldr	r0, [r0, #0]
@   0x0801133e: 4681        mov	r9, r0
@   0x08011340: 464a        mov	r2, r9
@   0x08011342: 4917        ldr	r1, [pc, #92]	@ (0x113a0)
@   0x08011344: 8b4b        ldrh	r3, [r1, #26]
@   0x08011346: 4650        mov	r0, sl
@   0x08011348: 4358        muls	r0, r3
@   0x0801134a: 9e03        ldr	r6, [sp, #12]
@   0x0801134c: 1830        adds	r0, r6, r0
@   0x0801134e: 0040        lsls	r0, r0, #1
@   0x08011350: 183f        adds	r7, r7, r0
@   0x08011352: 2000        movs	r0, #0
@   0x08011354: 4540        cmp	r0, r8
@   0x08011356: d216        bcs.n	0x11386
@   0x08011358: 1c0c        adds	r4, r1, #0
@   0x0801135a: 2100        movs	r1, #0
@   0x0801135c: 1c43        adds	r3, r0, #1
@   0x0801135e: 4561        cmp	r1, ip
@   0x08011360: d208        bcs.n	0x11374
@   0x08011362: 8810        ldrh	r0, [r2, #0]
@   0x08011364: 8038        strh	r0, [r7, #0]
@   0x08011366: 3202        adds	r2, #2
@   0x08011368: 3702        adds	r7, #2
@   0x0801136a: 1c48        adds	r0, r1, #1
@   0x0801136c: 0600        lsls	r0, r0, #24
@   0x0801136e: 0e01        lsrs	r1, r0, #24
@   0x08011370: 4561        cmp	r1, ip
@   0x08011372: d3f6        bcc.n	0x11362
@   0x08011374: 8b61        ldrh	r1, [r4, #26]
@   0x08011376: 4666        mov	r6, ip
@   0x08011378: 1b88        subs	r0, r1, r6
@   0x0801137a: 0040        lsls	r0, r0, #1
@   0x0801137c: 183f        adds	r7, r7, r0
@   0x0801137e: 0618        lsls	r0, r3, #24
@   0x08011380: 0e00        lsrs	r0, r0, #24
@   0x08011382: 4540        cmp	r0, r8
@   0x08011384: d3e9        bcc.n	0x1135a
@   0x08011386: 2d01        cmp	r5, #1
@   0x08011388: d014        beq.n	0x113b4
@   0x0801138a: 2d01        cmp	r5, #1
@   0x0801138c: dc0a        bgt.n	0x113a4
@   0x0801138e: 2d00        cmp	r5, #0
@   0x08011390: d00b        beq.n	0x113aa
@   0x08011392: e014        b.n	0x113be
@   0x08011394: 0000        movs	r0, r0
@   0x08011396: 0202        lsls	r2, r0, #8
@   0x08011398: 7eac        ldrb	r4, [r5, #26]
@   0x0801139a: 0830        lsrs	r0, r6, #32
@   0x0801139c: 5330        strh	r0, [r6, r4]
@   0x0801139e: 0300        lsls	r0, r0, #12
@   0x080113a0: 60a0        str	r0, [r4, #8]
@   0x080113a2: 0300        lsls	r0, r0, #12
@   0x080113a4: 2d02        cmp	r5, #2
@   0x080113a6: d009        beq.n	0x113bc
@   0x080113a8: e009        b.n	0x113be
@   0x080113aa: 4f01        ldr	r7, [pc, #4]	@ (0x113b0)
@   0x080113ac: e007        b.n	0x113be
@   0x080113ae: 0000        movs	r0, r0
@   0x080113b0: e000        b.n	0x113b4
@   0x080113b2: 0600        lsls	r0, r0, #24
@   0x080113b4: 4f00        ldr	r7, [pc, #0]	@ (0x113b8)
@   0x080113b6: e002        b.n	0x113be
@   0x080113b8: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x080113bc: 4f09        ldr	r7, [pc, #36]	@ (0x113e4)
@   0x080113be: 9500        str	r5, [sp, #0]
@   0x080113c0: 4648        mov	r0, r9
@   0x080113c2: 9001        str	r0, [sp, #4]
@   0x080113c4: 9702        str	r7, [sp, #8]
@   0x080113c6: 4640        mov	r0, r8
@   0x080113c8: 4661        mov	r1, ip
@   0x080113ca: 9a03        ldr	r2, [sp, #12]
@   0x080113cc: 4653        mov	r3, sl
@   0x080113ce: f7fe        ff45 	bl	0x1025c
@   0x080113d2: b004        add	sp, #16
@   0x080113d4: bc38        pop	{r3, r4, r5}
@   0x080113d6: 4698        mov	r8, r3
@   0x080113d8: 46a1        mov	r9, r4
@   0x080113da: 46aa        mov	sl, r5
@   0x080113dc: bcf0        pop	{r4, r5, r6, r7}
@   0x080113de: bc01        pop	{r0}
@   0x080113e0: 4700        bx	r0
@   0x080113e2: 0000        movs	r0, r0
@   0x080113e4: f000        0600 	and.w	r6, r0, #0

        thumb_func_start sub_080112C0
sub_080112C0: @ 0x080112c0
        .incbin "frog_us_baserom.gba", 0x112c0, 0x128
        thumb_func_end sub_080112C0
