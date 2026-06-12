@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x08027138, 0x08027310)  (472 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x8027138 --end 0x8027310 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08027138: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802713a: 4657        mov	r7, sl
@   0x0802713c: 464e        mov	r6, r9
@   0x0802713e: 4645        mov	r5, r8
@   0x08027140: b4e0        push	{r5, r6, r7}
@   0x08027142: b084        sub	sp, #16
@   0x08027144: 2500        movs	r5, #0
@   0x08027146: 480b        ldr	r0, [pc, #44]	@ (0x27174)
@   0x08027148: 4680        mov	r8, r0
@   0x0802714a: 490b        ldr	r1, [pc, #44]	@ (0x27178)
@   0x0802714c: 4441        add	r1, r8
@   0x0802714e: 4689        mov	r9, r1
@   0x08027150: 2280        movs	r2, #128	@ 0x80
@   0x08027152: 0212        lsls	r2, r2, #8
@   0x08027154: 1c17        adds	r7, r2, #0
@   0x08027156: 1c29        adds	r1, r5, #0
@   0x08027158: 3155        adds	r1, #85	@ 0x55
@   0x0802715a: 00c8        lsls	r0, r1, #3
@   0x0802715c: 1a40        subs	r0, r0, r1
@   0x0802715e: 00c0        lsls	r0, r0, #3
@   0x08027160: 4642        mov	r2, r8
@   0x08027162: 1884        adds	r4, r0, r2
@   0x08027164: 7ea0        ldrb	r0, [r4, #26]
@   0x08027166: 1c0e        adds	r6, r1, #0
@   0x08027168: 2800        cmp	r0, #0
@   0x0802716a: d007        beq.n	0x2717c
@   0x0802716c: 2801        cmp	r0, #1
@   0x0802716e: d013        beq.n	0x27198
@   0x08027170: e04b        b.n	0x2720a
@   0x08027172: 0000        movs	r0, r0
@   0x08027174: 3720        adds	r7, #32
@   0x08027176: 0300        lsls	r0, r0, #12
@   0x08027178: 1298        asrs	r0, r3, #10
@   0x0802717a: 0000        movs	r0, r0
@   0x0802717c: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x0802717e: 1c08        adds	r0, r1, #0
@   0x08027180: 4038        ands	r0, r7
@   0x08027182: 2800        cmp	r0, #0
@   0x08027184: d041        beq.n	0x2720a
@   0x08027186: 2002        movs	r0, #2
@   0x08027188: 4308        orrs	r0, r1
@   0x0802718a: 4a02        ldr	r2, [pc, #8]	@ (0x27194)
@   0x0802718c: 1c11        adds	r1, r2, #0
@   0x0802718e: 4008        ands	r0, r1
@   0x08027190: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x08027192: e03a        b.n	0x2720a
@   0x08027194: 7fff        ldrb	r7, [r7, #31]
@   0x08027196: 0000        movs	r0, r0
@   0x08027198: 8ea0        ldrh	r0, [r4, #52]	@ 0x34
@   0x0802719a: 4038        ands	r0, r7
@   0x0802719c: 2800        cmp	r0, #0
@   0x0802719e: d034        beq.n	0x2720a
@   0x080271a0: 1c28        adds	r0, r5, #0
@   0x080271a2: 305a        adds	r0, #90	@ 0x5a
@   0x080271a4: 4a52        ldr	r2, [pc, #328]	@ (0x272f0)
@   0x080271a6: 00a9        lsls	r1, r5, #2
@   0x080271a8: 1889        adds	r1, r1, r2
@   0x080271aa: 6809        ldr	r1, [r1, #0]
@   0x080271ac: 4a51        ldr	r2, [pc, #324]	@ (0x272f4)
@   0x080271ae: 9200        str	r2, [sp, #0]
@   0x080271b0: 2209        movs	r2, #9
@   0x080271b2: 9201        str	r2, [sp, #4]
@   0x080271b4: 2203        movs	r2, #3
@   0x080271b6: 9202        str	r2, [sp, #8]
@   0x080271b8: 9203        str	r2, [sp, #12]
@   0x080271ba: 2210        movs	r2, #16
@   0x080271bc: 231d        movs	r3, #29
@   0x080271be: f7f9        ff6f 	bl	0x210a0
@   0x080271c2: 2d01        cmp	r5, #1
@   0x080271c4: d10b        bne.n	0x271de
@   0x080271c6: 484c        ldr	r0, [pc, #304]	@ (0x272f8)
@   0x080271c8: 9000        str	r0, [sp, #0]
@   0x080271ca: 2008        movs	r0, #8
@   0x080271cc: 9001        str	r0, [sp, #4]
@   0x080271ce: 2000        movs	r0, #0
@   0x080271d0: 9002        str	r0, [sp, #8]
@   0x080271d2: 2057        movs	r0, #87	@ 0x57
@   0x080271d4: 4949        ldr	r1, [pc, #292]	@ (0x272fc)
@   0x080271d6: 2210        movs	r2, #16
@   0x080271d8: 2338        movs	r3, #56	@ 0x38
@   0x080271da: f7f9        ffb1 	bl	0x21140
@   0x080271de: 2000        movs	r0, #0
@   0x080271e0: 76a0        strb	r0, [r4, #26]
@   0x080271e2: 2002        movs	r0, #2
@   0x080271e4: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x080271e6: 4308        orrs	r0, r1
@   0x080271e8: 4a45        ldr	r2, [pc, #276]	@ (0x27300)
@   0x080271ea: 1c11        adds	r1, r2, #0
@   0x080271ec: 4008        ands	r0, r1
@   0x080271ee: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x080271f0: 2d00        cmp	r5, #0
@   0x080271f2: d001        beq.n	0x271f8
@   0x080271f4: 2d03        cmp	r5, #3
@   0x080271f6: d108        bne.n	0x2720a
@   0x080271f8: 00e8        lsls	r0, r5, #3
@   0x080271fa: 1b40        subs	r0, r0, r5
@   0x080271fc: 00c0        lsls	r0, r0, #3
@   0x080271fe: 4448        add	r0, r9
@   0x08027200: 2124        movs	r1, #36	@ 0x24
@   0x08027202: 220d        movs	r2, #13
@   0x08027204: 2304        movs	r3, #4
@   0x08027206: f7f9        fd69 	bl	0x20cdc
@   0x0802720a: 483e        ldr	r0, [pc, #248]	@ (0x27304)
@   0x0802720c: 1c31        adds	r1, r6, #0
@   0x0802720e: f7df        fbad 	bl	0x696c
@   0x08027212: 1c68        adds	r0, r5, #1
@   0x08027214: 0600        lsls	r0, r0, #24
@   0x08027216: 0e05        lsrs	r5, r0, #24
@   0x08027218: 2d04        cmp	r5, #4
@   0x0802721a: d99c        bls.n	0x27156
@   0x0802721c: 2055        movs	r0, #85	@ 0x55
@   0x0802721e: 2159        movs	r1, #89	@ 0x59
@   0x08027220: f7de        fd76 	bl	0x5d10
@   0x08027224: 2500        movs	r5, #0
@   0x08027226: 4f38        ldr	r7, [pc, #224]	@ (0x27308)
@   0x08027228: 2000        movs	r0, #0
@   0x0802722a: 4682        mov	sl, r0
@   0x0802722c: 4937        ldr	r1, [pc, #220]	@ (0x2730c)
@   0x0802722e: 19c9        adds	r1, r1, r7
@   0x08027230: 4689        mov	r9, r1
@   0x08027232: 22e9        movs	r2, #233	@ 0xe9
@   0x08027234: 0052        lsls	r2, r2, #1
@   0x08027236: 4690        mov	r8, r2
@   0x08027238: 1c28        adds	r0, r5, #0
@   0x0802723a: 305a        adds	r0, #90	@ 0x5a
@   0x0802723c: 00c1        lsls	r1, r0, #3
@   0x0802723e: 1a09        subs	r1, r1, r0
@   0x08027240: 00c9        lsls	r1, r1, #3
@   0x08027242: 19cc        adds	r4, r1, r7
@   0x08027244: 2108        movs	r1, #8
@   0x08027246: 8ea2        ldrh	r2, [r4, #52]	@ 0x34
@   0x08027248: 4011        ands	r1, r2
@   0x0802724a: 1c06        adds	r6, r0, #0
@   0x0802724c: 2900        cmp	r1, #0
@   0x0802724e: d132        bne.n	0x272b6
@   0x08027250: 7ea0        ldrb	r0, [r4, #26]
@   0x08027252: 2804        cmp	r0, #4
@   0x08027254: d12b        bne.n	0x272ae
@   0x08027256: 2102        movs	r1, #2
@   0x08027258: 5e60        ldrsh	r0, [r4, r1]
@   0x0802725a: 4540        cmp	r0, r8
@   0x0802725c: dd18        ble.n	0x27290
@   0x0802725e: 1c28        adds	r0, r5, #0
@   0x08027260: 3055        adds	r0, #85	@ 0x55
@   0x08027262: 00c1        lsls	r1, r0, #3
@   0x08027264: 1a09        subs	r1, r1, r0
@   0x08027266: 00c9        lsls	r1, r1, #3
@   0x08027268: 19c9        adds	r1, r1, r7
@   0x0802726a: 2001        movs	r0, #1
@   0x0802726c: 7688        strb	r0, [r1, #26]
@   0x0802726e: 2002        movs	r0, #2
@   0x08027270: 8e8a        ldrh	r2, [r1, #52]	@ 0x34
@   0x08027272: 4310        orrs	r0, r2
@   0x08027274: 8688        strh	r0, [r1, #52]	@ 0x34
@   0x08027276: 2008        movs	r0, #8
@   0x08027278: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x0802727a: 4308        orrs	r0, r1
@   0x0802727c: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x0802727e: 00e8        lsls	r0, r5, #3
@   0x08027280: 1b40        subs	r0, r0, r5
@   0x08027282: 00c0        lsls	r0, r0, #3
@   0x08027284: 4448        add	r0, r9
@   0x08027286: 2100        movs	r1, #0
@   0x08027288: 2200        movs	r2, #0
@   0x0802728a: 2300        movs	r3, #0
@   0x0802728c: f7e3        f978 	bl	0xa580
@   0x08027290: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08027292: 2280        movs	r2, #128	@ 0x80
@   0x08027294: 0212        lsls	r2, r2, #8
@   0x08027296: 1c10        adds	r0, r2, #0
@   0x08027298: 4008        ands	r0, r1
@   0x0802729a: 2800        cmp	r0, #0
@   0x0802729c: d007        beq.n	0x272ae
@   0x0802729e: 2002        movs	r0, #2
@   0x080272a0: 4308        orrs	r0, r1
@   0x080272a2: 4651        mov	r1, sl
@   0x080272a4: 4308        orrs	r0, r1
@   0x080272a6: 3a01        subs	r2, #1
@   0x080272a8: 1c11        adds	r1, r2, #0
@   0x080272aa: 4008        ands	r0, r1
@   0x080272ac: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x080272ae: 4815        ldr	r0, [pc, #84]	@ (0x27304)
@   0x080272b0: 1c31        adds	r1, r6, #0
@   0x080272b2: f7df        fb5b 	bl	0x696c
@   0x080272b6: 1c68        adds	r0, r5, #1
@   0x080272b8: 0600        lsls	r0, r0, #24
@   0x080272ba: 0e05        lsrs	r5, r0, #24
@   0x080272bc: 2d04        cmp	r5, #4
@   0x080272be: d9bb        bls.n	0x27238
@   0x080272c0: 205a        movs	r0, #90	@ 0x5a
@   0x080272c2: 215b        movs	r1, #91	@ 0x5b
@   0x080272c4: f7f9        fe8e 	bl	0x20fe4
@   0x080272c8: 205a        movs	r0, #90	@ 0x5a
@   0x080272ca: 215b        movs	r1, #91	@ 0x5b
@   0x080272cc: f7de        fd20 	bl	0x5d10
@   0x080272d0: 205c        movs	r0, #92	@ 0x5c
@   0x080272d2: 215e        movs	r1, #94	@ 0x5e
@   0x080272d4: f7f9        fe86 	bl	0x20fe4
@   0x080272d8: 205c        movs	r0, #92	@ 0x5c
@   0x080272da: 215e        movs	r1, #94	@ 0x5e
@   0x080272dc: f7de        fd18 	bl	0x5d10
@   0x080272e0: b004        add	sp, #16
@   0x080272e2: bc38        pop	{r3, r4, r5}
@   0x080272e4: 4698        mov	r8, r3
@   0x080272e6: 46a1        mov	r9, r4
@   0x080272e8: 46aa        mov	sl, r5
@   0x080272ea: bcf0        pop	{r4, r5, r6, r7}
@   0x080272ec: bc01        pop	{r0}
@   0x080272ee: 4700        bx	r0
@   0x080272f0: 66cc        str	r4, [r1, #108]	@ 0x6c
@   0x080272f2: 0831        lsrs	r1, r6, #32
@   0x080272f4: 0311        lsls	r1, r2, #12
@   0x080272f6: 0000        movs	r0, r0
@   0x080272f8: 02f1        lsls	r1, r6, #11
@   0x080272fa: 0000        movs	r0, r0
@   0x080272fc: 64d0        str	r0, [r2, #76]	@ 0x4c
@   0x080272fe: 0831        lsrs	r1, r6, #32
@   0x08027300: 7fff        ldrb	r7, [r7, #31]
@   0x08027302: 0000        movs	r0, r0
@   0x08027304: 6110        str	r0, [r2, #16]
@   0x08027306: 0300        lsls	r0, r0, #12
@   0x08027308: 3720        adds	r7, #32
@   0x0802730a: 0300        lsls	r0, r0, #12
@   0x0802730c: 13b0        asrs	r0, r6, #14

        thumb_func_start sub_08027138
sub_08027138: @ 0x08027138
        .incbin "baserom.gba", 0x27138, 0x1d8
        thumb_func_end sub_08027138
