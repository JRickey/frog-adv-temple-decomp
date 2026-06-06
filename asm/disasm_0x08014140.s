@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08014140, 0x080142d4)  (404 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8014140 --end 0x80142d4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08014140: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08014142: 4657        mov	r7, sl
@   0x08014144: 464e        mov	r6, r9
@   0x08014146: 4645        mov	r5, r8
@   0x08014148: b4e0        push	{r5, r6, r7}
@   0x0801414a: b082        sub	sp, #8
@   0x0801414c: 1c04        adds	r4, r0, #0
@   0x0801414e: 0609        lsls	r1, r1, #24
@   0x08014150: 0e09        lsrs	r1, r1, #24
@   0x08014152: 480b        ldr	r0, [pc, #44]	@ (0x14180)
@   0x08014154: 6802        ldr	r2, [r0, #0]
@   0x08014156: 6860        ldr	r0, [r4, #4]
@   0x08014158: 1a10        subs	r0, r2, r0
@   0x0801415a: 7ae3        ldrb	r3, [r4, #11]
@   0x0801415c: 4298        cmp	r0, r3
@   0x0801415e: d200        bcs.n	0x14162
@   0x08014160: e0ab        b.n	0x142ba
@   0x08014162: 8de0        ldrh	r0, [r4, #46]	@ 0x2e
@   0x08014164: 466f        mov	r7, sp
@   0x08014166: 80b8        strh	r0, [r7, #4]
@   0x08014168: 232e        movs	r3, #46	@ 0x2e
@   0x0801416a: 5ee0        ldrsh	r0, [r4, r3]
@   0x0801416c: 2800        cmp	r0, #0
@   0x0801416e: d004        beq.n	0x1417a
@   0x08014170: 8da3        ldrh	r3, [r4, #44]	@ 0x2c
@   0x08014172: 202c        movs	r0, #44	@ 0x2c
@   0x08014174: 5e27        ldrsh	r7, [r4, r0]
@   0x08014176: 2f00        cmp	r7, #0
@   0x08014178: d104        bne.n	0x14184
@   0x0801417a: 2001        movs	r0, #1
@   0x0801417c: e09e        b.n	0x142bc
@   0x0801417e: 0000        movs	r0, r0
@   0x08014180: 5330        strh	r0, [r6, r4]
@   0x08014182: 0300        lsls	r0, r0, #12
@   0x08014184: 6062        str	r2, [r4, #4]
@   0x08014186: 8ea2        ldrh	r2, [r4, #52]	@ 0x34
@   0x08014188: 4692        mov	sl, r2
@   0x0801418a: 8ee7        ldrh	r7, [r4, #54]	@ 0x36
@   0x0801418c: 9700        str	r7, [sp, #0]
@   0x0801418e: 6920        ldr	r0, [r4, #16]
@   0x08014190: 4680        mov	r8, r0
@   0x08014192: 60e0        str	r0, [r4, #12]
@   0x08014194: 7a60        ldrb	r0, [r4, #9]
@   0x08014196: 220f        movs	r2, #15
@   0x08014198: 4002        ands	r2, r0
@   0x0801419a: 4681        mov	r9, r0
@   0x0801419c: 2a02        cmp	r2, #2
@   0x0801419e: d019        beq.n	0x141d4
@   0x080141a0: 2a02        cmp	r2, #2
@   0x080141a2: dc02        bgt.n	0x141aa
@   0x080141a4: 2a01        cmp	r2, #1
@   0x080141a6: d005        beq.n	0x141b4
@   0x080141a8: e040        b.n	0x1422c
@   0x080141aa: 2a03        cmp	r2, #3
@   0x080141ac: d021        beq.n	0x141f2
@   0x080141ae: 2a04        cmp	r2, #4
@   0x080141b0: d02d        beq.n	0x1420e
@   0x080141b2: e03b        b.n	0x1422c
@   0x080141b4: 8ee2        ldrh	r2, [r4, #54]	@ 0x36
@   0x080141b6: 1850        adds	r0, r2, r1
@   0x080141b8: 86e0        strh	r0, [r4, #54]	@ 0x36
@   0x080141ba: 466d        mov	r5, sp
@   0x080141bc: 88ad        ldrh	r5, [r5, #4]
@   0x080141be: 1a68        subs	r0, r5, r1
@   0x080141c0: 85e0        strh	r0, [r4, #46]	@ 0x2e
@   0x080141c2: 468c        mov	ip, r1
@   0x080141c4: 0618        lsls	r0, r3, #24
@   0x080141c6: 0e05        lsrs	r5, r0, #24
@   0x080141c8: 8e27        ldrh	r7, [r4, #48]	@ 0x30
@   0x080141ca: 4660        mov	r0, ip
@   0x080141cc: 4378        muls	r0, r7
@   0x080141ce: 0040        lsls	r0, r0, #1
@   0x080141d0: 4440        add	r0, r8
@   0x080141d2: e02a        b.n	0x1422a
@   0x080141d4: 8ee2        ldrh	r2, [r4, #54]	@ 0x36
@   0x080141d6: 1a50        subs	r0, r2, r1
@   0x080141d8: 86e0        strh	r0, [r4, #54]	@ 0x36
@   0x080141da: 466d        mov	r5, sp
@   0x080141dc: 88ad        ldrh	r5, [r5, #4]
@   0x080141de: 1a68        subs	r0, r5, r1
@   0x080141e0: 85e0        strh	r0, [r4, #46]	@ 0x2e
@   0x080141e2: 468c        mov	ip, r1
@   0x080141e4: 0618        lsls	r0, r3, #24
@   0x080141e6: 0e05        lsrs	r5, r0, #24
@   0x080141e8: 8e27        ldrh	r7, [r4, #48]	@ 0x30
@   0x080141ea: 4660        mov	r0, ip
@   0x080141ec: 4378        muls	r0, r7
@   0x080141ee: 0040        lsls	r0, r0, #1
@   0x080141f0: e019        b.n	0x14226
@   0x080141f2: 8ea2        ldrh	r2, [r4, #52]	@ 0x34
@   0x080141f4: 1850        adds	r0, r2, r1
@   0x080141f6: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x080141f8: 1a58        subs	r0, r3, r1
@   0x080141fa: 85a0        strh	r0, [r4, #44]	@ 0x2c
@   0x080141fc: 1c0d        adds	r5, r1, #0
@   0x080141fe: 466b        mov	r3, sp
@   0x08014200: 889b        ldrh	r3, [r3, #4]
@   0x08014202: 0618        lsls	r0, r3, #24
@   0x08014204: 0e00        lsrs	r0, r0, #24
@   0x08014206: 4684        mov	ip, r0
@   0x08014208: 0068        lsls	r0, r5, #1
@   0x0801420a: 4440        add	r0, r8
@   0x0801420c: e00d        b.n	0x1422a
@   0x0801420e: 8ea5        ldrh	r5, [r4, #52]	@ 0x34
@   0x08014210: 1a68        subs	r0, r5, r1
@   0x08014212: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x08014214: 1a58        subs	r0, r3, r1
@   0x08014216: 85a0        strh	r0, [r4, #44]	@ 0x2c
@   0x08014218: 1c0d        adds	r5, r1, #0
@   0x0801421a: 466f        mov	r7, sp
@   0x0801421c: 88bf        ldrh	r7, [r7, #4]
@   0x0801421e: 0638        lsls	r0, r7, #24
@   0x08014220: 0e00        lsrs	r0, r0, #24
@   0x08014222: 4684        mov	ip, r0
@   0x08014224: 0068        lsls	r0, r5, #1
@   0x08014226: 4641        mov	r1, r8
@   0x08014228: 1a08        subs	r0, r1, r0
@   0x0801422a: 6120        str	r0, [r4, #16]
@   0x0801422c: 4909        ldr	r1, [pc, #36]	@ (0x14254)
@   0x0801422e: 2001        movs	r0, #1
@   0x08014230: 7048        strb	r0, [r1, #1]
@   0x08014232: 464a        mov	r2, r9
@   0x08014234: 0610        lsls	r0, r2, #24
@   0x08014236: 0f02        lsrs	r2, r0, #28
@   0x08014238: 4653        mov	r3, sl
@   0x0801423a: 0418        lsls	r0, r3, #16
@   0x0801423c: 9f00        ldr	r7, [sp, #0]
@   0x0801423e: 0439        lsls	r1, r7, #16
@   0x08014240: 1400        asrs	r0, r0, #16
@   0x08014242: 140b        asrs	r3, r1, #16
@   0x08014244: 2a01        cmp	r2, #1
@   0x08014246: d00d        beq.n	0x14264
@   0x08014248: 2a01        cmp	r2, #1
@   0x0801424a: dc05        bgt.n	0x14258
@   0x0801424c: 2a00        cmp	r2, #0
@   0x0801424e: d006        beq.n	0x1425e
@   0x08014250: e00d        b.n	0x1426e
@   0x08014252: 0000        movs	r0, r0
@   0x08014254: 3610        adds	r6, #16
@   0x08014256: 0300        lsls	r0, r0, #12
@   0x08014258: 2a02        cmp	r2, #2
@   0x0801425a: d007        beq.n	0x1426c
@   0x0801425c: e007        b.n	0x1426e
@   0x0801425e: 2680        movs	r6, #128	@ 0x80
@   0x08014260: 04b6        lsls	r6, r6, #18
@   0x08014262: e004        b.n	0x1426e
@   0x08014264: 4e00        ldr	r6, [pc, #0]	@ (0x14268)
@   0x08014266: e002        b.n	0x1426e
@   0x08014268: 0000        movs	r0, r0
@   0x0801426a: 0201        lsls	r1, r0, #8
@   0x0801426c: 4e17        ldr	r6, [pc, #92]	@ (0x142cc)
@   0x0801426e: 1c02        adds	r2, r0, #0
@   0x08014270: 4917        ldr	r1, [pc, #92]	@ (0x142d0)
@   0x08014272: 8b4f        ldrh	r7, [r1, #26]
@   0x08014274: 1c38        adds	r0, r7, #0
@   0x08014276: 4358        muls	r0, r3
@   0x08014278: 1810        adds	r0, r2, r0
@   0x0801427a: 0040        lsls	r0, r0, #1
@   0x0801427c: 1836        adds	r6, r6, r0
@   0x0801427e: 68e3        ldr	r3, [r4, #12]
@   0x08014280: 2000        movs	r0, #0
@   0x08014282: 1c0f        adds	r7, r1, #0
@   0x08014284: 4560        cmp	r0, ip
@   0x08014286: d218        bcs.n	0x142ba
@   0x08014288: 2200        movs	r2, #0
@   0x0801428a: 1c41        adds	r1, r0, #1
@   0x0801428c: 42aa        cmp	r2, r5
@   0x0801428e: d208        bcs.n	0x142a2
@   0x08014290: 8818        ldrh	r0, [r3, #0]
@   0x08014292: 8030        strh	r0, [r6, #0]
@   0x08014294: 3302        adds	r3, #2
@   0x08014296: 3602        adds	r6, #2
@   0x08014298: 1c50        adds	r0, r2, #1
@   0x0801429a: 0600        lsls	r0, r0, #24
@   0x0801429c: 0e02        lsrs	r2, r0, #24
@   0x0801429e: 42aa        cmp	r2, r5
@   0x080142a0: d3f6        bcc.n	0x14290
@   0x080142a2: 8b7a        ldrh	r2, [r7, #26]
@   0x080142a4: 1b50        subs	r0, r2, r5
@   0x080142a6: 0040        lsls	r0, r0, #1
@   0x080142a8: 1836        adds	r6, r6, r0
@   0x080142aa: 8e22        ldrh	r2, [r4, #48]	@ 0x30
@   0x080142ac: 1b50        subs	r0, r2, r5
@   0x080142ae: 0040        lsls	r0, r0, #1
@   0x080142b0: 181b        adds	r3, r3, r0
@   0x080142b2: 0608        lsls	r0, r1, #24
@   0x080142b4: 0e00        lsrs	r0, r0, #24
@   0x080142b6: 4560        cmp	r0, ip
@   0x080142b8: d3e6        bcc.n	0x14288
@   0x080142ba: 2000        movs	r0, #0
@   0x080142bc: b002        add	sp, #8
@   0x080142be: bc38        pop	{r3, r4, r5}
@   0x080142c0: 4698        mov	r8, r3
@   0x080142c2: 46a1        mov	r9, r4
@   0x080142c4: 46aa        mov	sl, r5
@   0x080142c6: bcf0        pop	{r4, r5, r6, r7}
@   0x080142c8: bc02        pop	{r1}
@   0x080142ca: 4708        bx	r1
@   0x080142cc: 0000        movs	r0, r0
@   0x080142ce: 0202        lsls	r2, r0, #8
@   0x080142d0: 60a0        str	r0, [r4, #8]
@   0x080142d2: 0300        lsls	r0, r0, #12

        thumb_func_start AnimState_BlitStep
AnimState_BlitStep: @ 0x08014140
        .incbin "frog_us_baserom.gba", 0x14140, 0x194
        thumb_func_end AnimState_BlitStep
