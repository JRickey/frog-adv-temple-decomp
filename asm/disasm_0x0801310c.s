@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801310c, 0x080132e8)  (476 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801310c --end 0x80132e8 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801310c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801310e: 4657        mov	r7, sl
@   0x08013110: 464e        mov	r6, r9
@   0x08013112: 4645        mov	r5, r8
@   0x08013114: b4e0        push	{r5, r6, r7}
@   0x08013116: b084        sub	sp, #16
@   0x08013118: 4d05        ldr	r5, [pc, #20]	@ (0x13130)
@   0x0801311a: 1c2c        adds	r4, r5, #0
@   0x0801311c: 34dc        adds	r4, #220	@ 0xdc
@   0x0801311e: 7822        ldrb	r2, [r4, #0]
@   0x08013120: 2a01        cmp	r2, #1
@   0x08013122: d100        bne.n	0x13126
@   0x08013124: e0cc        b.n	0x132c0
@   0x08013126: 2a01        cmp	r2, #1
@   0x08013128: dc04        bgt.n	0x13134
@   0x0801312a: 2a00        cmp	r2, #0
@   0x0801312c: d006        beq.n	0x1313c
@   0x0801312e: e0d0        b.n	0x132d2
@   0x08013130: 3610        adds	r6, #16
@   0x08013132: 0300        lsls	r0, r0, #12
@   0x08013134: 2a02        cmp	r2, #2
@   0x08013136: d100        bne.n	0x1313a
@   0x08013138: e0c5        b.n	0x132c6
@   0x0801313a: e0ca        b.n	0x132d2
@   0x0801313c: 4b11        ldr	r3, [pc, #68]	@ (0x13184)
@   0x0801313e: 20ff        movs	r0, #255	@ 0xff
@   0x08013140: 1c01        adds	r1, r0, #0
@   0x08013142: 8cde        ldrh	r6, [r3, #38]	@ 0x26
@   0x08013144: 4031        ands	r1, r6
@   0x08013146: 8d1e        ldrh	r6, [r3, #40]	@ 0x28
@   0x08013148: 4030        ands	r0, r6
@   0x0801314a: 4281        cmp	r1, r0
@   0x0801314c: d100        bne.n	0x13150
@   0x0801314e: e0c0        b.n	0x132d2
@   0x08013150: 1c28        adds	r0, r5, #0
@   0x08013152: 30d3        adds	r0, #211	@ 0xd3
@   0x08013154: 7002        strb	r2, [r0, #0]
@   0x08013156: 2100        movs	r1, #0
@   0x08013158: 4688        mov	r8, r1
@   0x0801315a: 4699        mov	r9, r3
@   0x0801315c: 4682        mov	sl, r0
@   0x0801315e: 464a        mov	r2, r9
@   0x08013160: 8cd7        ldrh	r7, [r2, #38]	@ 0x26
@   0x08013162: 4642        mov	r2, r8
@   0x08013164: 4117        asrs	r7, r2
@   0x08013166: 2301        movs	r3, #1
@   0x08013168: 401f        ands	r7, r3
@   0x0801316a: 464c        mov	r4, r9
@   0x0801316c: 8d20        ldrh	r0, [r4, #40]	@ 0x28
@   0x0801316e: 4110        asrs	r0, r2
@   0x08013170: 4018        ands	r0, r3
@   0x08013172: 4287        cmp	r7, r0
@   0x08013174: d100        bne.n	0x13178
@   0x08013176: e08b        b.n	0x13290
@   0x08013178: 2f00        cmp	r7, #0
@   0x0801317a: d005        beq.n	0x13188
@   0x0801317c: 2f01        cmp	r7, #1
@   0x0801317e: d04d        beq.n	0x1321c
@   0x08013180: e086        b.n	0x13290
@   0x08013182: 0000        movs	r0, r0
@   0x08013184: 6110        str	r0, [r2, #16]
@   0x08013186: 0300        lsls	r0, r0, #12
@   0x08013188: 2601        movs	r6, #1
@   0x0801318a: 4640        mov	r0, r8
@   0x0801318c: 4086        lsls	r6, r0
@   0x0801318e: 1c30        adds	r0, r6, #0
@   0x08013190: 4651        mov	r1, sl
@   0x08013192: 7809        ldrb	r1, [r1, #0]
@   0x08013194: 4308        orrs	r0, r1
@   0x08013196: 4652        mov	r2, sl
@   0x08013198: 7010        strb	r0, [r2, #0]
@   0x0801319a: 4643        mov	r3, r8
@   0x0801319c: 005d        lsls	r5, r3, #1
@   0x0801319e: 4445        add	r5, r8
@   0x080131a0: 00ed        lsls	r5, r5, #3
@   0x080131a2: 4817        ldr	r0, [pc, #92]	@ (0x13200)
@   0x080131a4: 182c        adds	r4, r5, r0
@   0x080131a6: 7a20        ldrb	r0, [r4, #8]
@   0x080131a8: 8821        ldrh	r1, [r4, #0]
@   0x080131aa: 8862        ldrh	r2, [r4, #2]
@   0x080131ac: 88a3        ldrh	r3, [r4, #4]
@   0x080131ae: 9303        str	r3, [sp, #12]
@   0x080131b0: 88e4        ldrh	r4, [r4, #6]
@   0x080131b2: 9400        str	r4, [sp, #0]
@   0x080131b4: 4c13        ldr	r4, [pc, #76]	@ (0x13204)
@   0x080131b6: 1964        adds	r4, r4, r5
@   0x080131b8: 6823        ldr	r3, [r4, #0]
@   0x080131ba: 9301        str	r3, [sp, #4]
@   0x080131bc: 9702        str	r7, [sp, #8]
@   0x080131be: 9b03        ldr	r3, [sp, #12]
@   0x080131c0: f7ff        fd00 	bl	0x12bc4
@   0x080131c4: 4810        ldr	r0, [pc, #64]	@ (0x13208)
@   0x080131c6: 182c        adds	r4, r5, r0
@   0x080131c8: 7a20        ldrb	r0, [r4, #8]
@   0x080131ca: 8821        ldrh	r1, [r4, #0]
@   0x080131cc: 8862        ldrh	r2, [r4, #2]
@   0x080131ce: 88a3        ldrh	r3, [r4, #4]
@   0x080131d0: 88e4        ldrh	r4, [r4, #6]
@   0x080131d2: 9400        str	r4, [sp, #0]
@   0x080131d4: 4c0d        ldr	r4, [pc, #52]	@ (0x1320c)
@   0x080131d6: 192d        adds	r5, r5, r4
@   0x080131d8: 682c        ldr	r4, [r5, #0]
@   0x080131da: 9401        str	r4, [sp, #4]
@   0x080131dc: 9702        str	r7, [sp, #8]
@   0x080131de: f7ff        fcf1 	bl	0x12bc4
@   0x080131e2: 4649        mov	r1, r9
@   0x080131e4: 8d08        ldrh	r0, [r1, #40]	@ 0x28
@   0x080131e6: 43b0        bics	r0, r6
@   0x080131e8: 2100        movs	r1, #0
@   0x080131ea: 464a        mov	r2, r9
@   0x080131ec: 8510        strh	r0, [r2, #40]	@ 0x28
@   0x080131ee: 4808        ldr	r0, [pc, #32]	@ (0x13210)
@   0x080131f0: 4b08        ldr	r3, [pc, #32]	@ (0x13214)
@   0x080131f2: 18c0        adds	r0, r0, r3
@   0x080131f4: 7001        strb	r1, [r0, #0]
@   0x080131f6: 2002        movs	r0, #2
@   0x080131f8: 4c07        ldr	r4, [pc, #28]	@ (0x13218)
@   0x080131fa: 7020        strb	r0, [r4, #0]
@   0x080131fc: e048        b.n	0x13290
@   0x080131fe: 0000        movs	r0, r0
@   0x08013200: 702c        strb	r4, [r5, #0]
@   0x08013202: 0830        lsrs	r0, r6, #32
@   0x08013204: 703c        strb	r4, [r7, #0]
@   0x08013206: 0830        lsrs	r0, r6, #32
@   0x08013208: 70ec        strb	r4, [r5, #3]
@   0x0801320a: 0830        lsrs	r0, r6, #32
@   0x0801320c: 70fc        strb	r4, [r7, #3]
@   0x0801320e: 0830        lsrs	r0, r6, #32
@   0x08013210: 3720        adds	r7, #32
@   0x08013212: 0300        lsls	r0, r0, #12
@   0x08013214: 1a5b        subs	r3, r3, r1
@   0x08013216: 0000        movs	r0, r0
@   0x08013218: 36ec        adds	r6, #236	@ 0xec
@   0x0801321a: 0300        lsls	r0, r0, #12
@   0x0801321c: 1c3e        adds	r6, r7, #0
@   0x0801321e: 4640        mov	r0, r8
@   0x08013220: 4086        lsls	r6, r0
@   0x08013222: 1c30        adds	r0, r6, #0
@   0x08013224: 4651        mov	r1, sl
@   0x08013226: 7809        ldrb	r1, [r1, #0]
@   0x08013228: 4308        orrs	r0, r1
@   0x0801322a: 4652        mov	r2, sl
@   0x0801322c: 7010        strb	r0, [r2, #0]
@   0x0801322e: 4643        mov	r3, r8
@   0x08013230: 005d        lsls	r5, r3, #1
@   0x08013232: 4445        add	r5, r8
@   0x08013234: 00ed        lsls	r5, r5, #3
@   0x08013236: 481b        ldr	r0, [pc, #108]	@ (0x132a4)
@   0x08013238: 182c        adds	r4, r5, r0
@   0x0801323a: 7a20        ldrb	r0, [r4, #8]
@   0x0801323c: 8821        ldrh	r1, [r4, #0]
@   0x0801323e: 8862        ldrh	r2, [r4, #2]
@   0x08013240: 88a3        ldrh	r3, [r4, #4]
@   0x08013242: 9303        str	r3, [sp, #12]
@   0x08013244: 88e4        ldrh	r4, [r4, #6]
@   0x08013246: 9400        str	r4, [sp, #0]
@   0x08013248: 4c17        ldr	r4, [pc, #92]	@ (0x132a8)
@   0x0801324a: 1964        adds	r4, r4, r5
@   0x0801324c: 6823        ldr	r3, [r4, #0]
@   0x0801324e: 9301        str	r3, [sp, #4]
@   0x08013250: 9702        str	r7, [sp, #8]
@   0x08013252: 9b03        ldr	r3, [sp, #12]
@   0x08013254: f7ff        fcb6 	bl	0x12bc4
@   0x08013258: 4814        ldr	r0, [pc, #80]	@ (0x132ac)
@   0x0801325a: 182c        adds	r4, r5, r0
@   0x0801325c: 7a20        ldrb	r0, [r4, #8]
@   0x0801325e: 8821        ldrh	r1, [r4, #0]
@   0x08013260: 8862        ldrh	r2, [r4, #2]
@   0x08013262: 88a3        ldrh	r3, [r4, #4]
@   0x08013264: 88e4        ldrh	r4, [r4, #6]
@   0x08013266: 9400        str	r4, [sp, #0]
@   0x08013268: 4c11        ldr	r4, [pc, #68]	@ (0x132b0)
@   0x0801326a: 192d        adds	r5, r5, r4
@   0x0801326c: 682c        ldr	r4, [r5, #0]
@   0x0801326e: 9401        str	r4, [sp, #4]
@   0x08013270: 2402        movs	r4, #2
@   0x08013272: 9402        str	r4, [sp, #8]
@   0x08013274: f7ff        fca6 	bl	0x12bc4
@   0x08013278: 4648        mov	r0, r9
@   0x0801327a: 8d00        ldrh	r0, [r0, #40]	@ 0x28
@   0x0801327c: 4306        orrs	r6, r0
@   0x0801327e: 2100        movs	r1, #0
@   0x08013280: 464a        mov	r2, r9
@   0x08013282: 8516        strh	r6, [r2, #40]	@ 0x28
@   0x08013284: 480b        ldr	r0, [pc, #44]	@ (0x132b4)
@   0x08013286: 4b0c        ldr	r3, [pc, #48]	@ (0x132b8)
@   0x08013288: 18c0        adds	r0, r0, r3
@   0x0801328a: 7001        strb	r1, [r0, #0]
@   0x0801328c: 4c0b        ldr	r4, [pc, #44]	@ (0x132bc)
@   0x0801328e: 7027        strb	r7, [r4, #0]
@   0x08013290: 4640        mov	r0, r8
@   0x08013292: 3001        adds	r0, #1
@   0x08013294: 0600        lsls	r0, r0, #24
@   0x08013296: 0e00        lsrs	r0, r0, #24
@   0x08013298: 4680        mov	r8, r0
@   0x0801329a: 2807        cmp	r0, #7
@   0x0801329c: d800        bhi.n	0x132a0
@   0x0801329e: e75e        b.n	0x1315e
@   0x080132a0: e017        b.n	0x132d2
@   0x080132a2: 0000        movs	r0, r0
@   0x080132a4: 702c        strb	r4, [r5, #0]
@   0x080132a6: 0830        lsrs	r0, r6, #32
@   0x080132a8: 703c        strb	r4, [r7, #0]
@   0x080132aa: 0830        lsrs	r0, r6, #32
@   0x080132ac: 70ec        strb	r4, [r5, #3]
@   0x080132ae: 0830        lsrs	r0, r6, #32
@   0x080132b0: 70fc        strb	r4, [r7, #3]
@   0x080132b2: 0830        lsrs	r0, r6, #32
@   0x080132b4: 3720        adds	r7, #32
@   0x080132b6: 0300        lsls	r0, r0, #12
@   0x080132b8: 1a5b        subs	r3, r3, r1
@   0x080132ba: 0000        movs	r0, r0
@   0x080132bc: 36ec        adds	r6, #236	@ 0xec
@   0x080132be: 0300        lsls	r0, r0, #12
@   0x080132c0: f7ff        fe1e 	bl	0x12f00
@   0x080132c4: e001        b.n	0x132ca
@   0x080132c6: f7ff        fe6b 	bl	0x12fa0
@   0x080132ca: f000        f80d 	bl	0x132e8
@   0x080132ce: 2000        movs	r0, #0
@   0x080132d0: 7020        strb	r0, [r4, #0]
@   0x080132d2: f7ff        feb5 	bl	0x13040
@   0x080132d6: b004        add	sp, #16
@   0x080132d8: bc38        pop	{r3, r4, r5}
@   0x080132da: 4698        mov	r8, r3
@   0x080132dc: 46a1        mov	r9, r4
@   0x080132de: 46aa        mov	sl, r5
@   0x080132e0: bcf0        pop	{r4, r5, r6, r7}
@   0x080132e2: bc01        pop	{r0}
@   0x080132e4: 4700        bx	r0

        thumb_func_start ScaleAnim_SyncSelectors
ScaleAnim_SyncSelectors: @ 0x0801310c
        .incbin "frog_us_baserom.gba", 0x1310c, 0x1dc
        thumb_func_end ScaleAnim_SyncSelectors
