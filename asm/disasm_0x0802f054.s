@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0802f054, 0x0802f2fc)  (680 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x802f054 --end 0x802f2fc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0802f054: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0802f056: 4657        mov	r7, sl
@   0x0802f058: 464e        mov	r6, r9
@   0x0802f05a: 4645        mov	r5, r8
@   0x0802f05c: b4e0        push	{r5, r6, r7}
@   0x0802f05e: 20f0        movs	r0, #240	@ 0xf0
@   0x0802f060: 0200        lsls	r0, r0, #8
@   0x0802f062: 4682        mov	sl, r0
@   0x0802f064: 218c        movs	r1, #140	@ 0x8c
@   0x0802f066: 4689        mov	r9, r1
@   0x0802f068: 2200        movs	r2, #0
@   0x0802f06a: 4694        mov	ip, r2
@   0x0802f06c: 2303        movs	r3, #3
@   0x0802f06e: 4698        mov	r8, r3
@   0x0802f070: 4d0d        ldr	r5, [pc, #52]	@ (0x2f0a8)
@   0x0802f072: 682a        ldr	r2, [r5, #0]
@   0x0802f074: 1c10        adds	r0, r2, #0
@   0x0802f076: 3010        adds	r0, #16
@   0x0802f078: 4661        mov	r1, ip
@   0x0802f07a: 1846        adds	r6, r0, r1
@   0x0802f07c: 6831        ldr	r1, [r6, #0]
@   0x0802f07e: 2001        movs	r0, #1
@   0x0802f080: 4008        ands	r0, r1
@   0x0802f082: 2800        cmp	r0, #0
@   0x0802f084: d05a        beq.n	0x2f13c
@   0x0802f086: 464b        mov	r3, r9
@   0x0802f088: 18d5        adds	r5, r2, r3
@   0x0802f08a: 1d2f        adds	r7, r5, #4
@   0x0802f08c: 88ac        ldrh	r4, [r5, #4]
@   0x0802f08e: 2206        movs	r2, #6
@   0x0802f090: 1c08        adds	r0, r1, #0
@   0x0802f092: 4010        ands	r0, r2
@   0x0802f094: 0840        lsrs	r0, r0, #1
@   0x0802f096: 2801        cmp	r0, #1
@   0x0802f098: d01a        beq.n	0x2f0d0
@   0x0802f09a: 2801        cmp	r0, #1
@   0x0802f09c: d306        bcc.n	0x2f0ac
@   0x0802f09e: 2802        cmp	r0, #2
@   0x0802f0a0: d025        beq.n	0x2f0ee
@   0x0802f0a2: 2803        cmp	r0, #3
@   0x0802f0a4: d02c        beq.n	0x2f100
@   0x0802f0a6: e03c        b.n	0x2f122
@   0x0802f0a8: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802f0aa: 0300        lsls	r0, r0, #12
@   0x0802f0ac: 6828        ldr	r0, [r5, #0]
@   0x0802f0ae: 8800        ldrh	r0, [r0, #0]
@   0x0802f0b0: 1903        adds	r3, r0, r4
@   0x0802f0b2: 4806        ldr	r0, [pc, #24]	@ (0x2f0cc)
@   0x0802f0b4: 4283        cmp	r3, r0
@   0x0802f0b6: dd18        ble.n	0x2f0ea
@   0x0802f0b8: 2007        movs	r0, #7
@   0x0802f0ba: 4240        negs	r0, r0
@   0x0802f0bc: 4001        ands	r1, r0
@   0x0802f0be: 2002        movs	r0, #2
@   0x0802f0c0: 4301        orrs	r1, r0
@   0x0802f0c2: 6031        str	r1, [r6, #0]
@   0x0802f0c4: 23ff        movs	r3, #255	@ 0xff
@   0x0802f0c6: 021b        lsls	r3, r3, #8
@   0x0802f0c8: e00f        b.n	0x2f0ea
@   0x0802f0ca: 0000        movs	r0, r0
@   0x0802f0cc: feff        0000 			@ <UNDEFINED> instruction: 0xfeff0000
@   0x0802f0d0: 6828        ldr	r0, [r5, #0]
@   0x0802f0d2: 8842        ldrh	r2, [r0, #2]
@   0x0802f0d4: 1aa3        subs	r3, r4, r2
@   0x0802f0d6: 8880        ldrh	r0, [r0, #4]
@   0x0802f0d8: 4283        cmp	r3, r0
@   0x0802f0da: dc06        bgt.n	0x2f0ea
@   0x0802f0dc: 1c03        adds	r3, r0, #0
@   0x0802f0de: 2007        movs	r0, #7
@   0x0802f0e0: 4240        negs	r0, r0
@   0x0802f0e2: 4001        ands	r1, r0
@   0x0802f0e4: 2004        movs	r0, #4
@   0x0802f0e6: 4301        orrs	r1, r0
@   0x0802f0e8: 6031        str	r1, [r6, #0]
@   0x0802f0ea: 80ab        strh	r3, [r5, #4]
@   0x0802f0ec: e019        b.n	0x2f122
@   0x0802f0ee: 2010        movs	r0, #16
@   0x0802f0f0: 4008        ands	r0, r1
@   0x0802f0f2: 2800        cmp	r0, #0
@   0x0802f0f4: d015        beq.n	0x2f122
@   0x0802f0f6: 2307        movs	r3, #7
@   0x0802f0f8: 425b        negs	r3, r3
@   0x0802f0fa: 4019        ands	r1, r3
@   0x0802f0fc: 4311        orrs	r1, r2
@   0x0802f0fe: 6031        str	r1, [r6, #0]
@   0x0802f100: 6828        ldr	r0, [r5, #0]
@   0x0802f102: 883d        ldrh	r5, [r7, #0]
@   0x0802f104: 88c0        ldrh	r0, [r0, #6]
@   0x0802f106: 1a2b        subs	r3, r5, r0
@   0x0802f108: 2bff        cmp	r3, #255	@ 0xff
@   0x0802f10a: dc09        bgt.n	0x2f120
@   0x0802f10c: 2300        movs	r3, #0
@   0x0802f10e: 490a        ldr	r1, [pc, #40]	@ (0x2f138)
@   0x0802f110: 6808        ldr	r0, [r1, #0]
@   0x0802f112: 3010        adds	r0, #16
@   0x0802f114: 4460        add	r0, ip
@   0x0802f116: 6801        ldr	r1, [r0, #0]
@   0x0802f118: 2208        movs	r2, #8
@   0x0802f11a: 4252        negs	r2, r2
@   0x0802f11c: 4011        ands	r1, r2
@   0x0802f11e: 6001        str	r1, [r0, #0]
@   0x0802f120: 803b        strh	r3, [r7, #0]
@   0x0802f122: 4652        mov	r2, sl
@   0x0802f124: 4014        ands	r4, r2
@   0x0802f126: 4650        mov	r0, sl
@   0x0802f128: 883f        ldrh	r7, [r7, #0]
@   0x0802f12a: 4038        ands	r0, r7
@   0x0802f12c: 4284        cmp	r4, r0
@   0x0802f12e: d034        beq.n	0x2f19a
@   0x0802f130: 4b01        ldr	r3, [pc, #4]	@ (0x2f138)
@   0x0802f132: 6818        ldr	r0, [r3, #0]
@   0x0802f134: e02b        b.n	0x2f18e
@   0x0802f136: 0000        movs	r0, r0
@   0x0802f138: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802f13a: 0300        lsls	r0, r0, #12
@   0x0802f13c: 2020        movs	r0, #32
@   0x0802f13e: 4008        ands	r0, r1
@   0x0802f140: 2800        cmp	r0, #0
@   0x0802f142: d02a        beq.n	0x2f19a
@   0x0802f144: 464d        mov	r5, r9
@   0x0802f146: 1950        adds	r0, r2, r5
@   0x0802f148: 1d07        adds	r7, r0, #4
@   0x0802f14a: 8884        ldrh	r4, [r0, #4]
@   0x0802f14c: 6800        ldr	r0, [r0, #0]
@   0x0802f14e: 1823        adds	r3, r4, r0
@   0x0802f150: 2800        cmp	r0, #0
@   0x0802f152: db0b        blt.n	0x2f16c
@   0x0802f154: 4804        ldr	r0, [pc, #16]	@ (0x2f168)
@   0x0802f156: 4283        cmp	r3, r0
@   0x0802f158: dd11        ble.n	0x2f17e
@   0x0802f15a: 2021        movs	r0, #33	@ 0x21
@   0x0802f15c: 4240        negs	r0, r0
@   0x0802f15e: 4001        ands	r1, r0
@   0x0802f160: 6031        str	r1, [r6, #0]
@   0x0802f162: 23ff        movs	r3, #255	@ 0xff
@   0x0802f164: 021b        lsls	r3, r3, #8
@   0x0802f166: e00a        b.n	0x2f17e
@   0x0802f168: feff        0000 			@ <UNDEFINED> instruction: 0xfeff0000
@   0x0802f16c: 2080        movs	r0, #128	@ 0x80
@   0x0802f16e: 0040        lsls	r0, r0, #1
@   0x0802f170: 4283        cmp	r3, r0
@   0x0802f172: dc04        bgt.n	0x2f17e
@   0x0802f174: 2021        movs	r0, #33	@ 0x21
@   0x0802f176: 4240        negs	r0, r0
@   0x0802f178: 4001        ands	r1, r0
@   0x0802f17a: 6031        str	r1, [r6, #0]
@   0x0802f17c: 2300        movs	r3, #0
@   0x0802f17e: 803b        strh	r3, [r7, #0]
@   0x0802f180: 4650        mov	r0, sl
@   0x0802f182: 4004        ands	r4, r0
@   0x0802f184: 4003        ands	r3, r0
@   0x0802f186: 429c        cmp	r4, r3
@   0x0802f188: d007        beq.n	0x2f19a
@   0x0802f18a: 4920        ldr	r1, [pc, #128]	@ (0x2f20c)
@   0x0802f18c: 6808        ldr	r0, [r1, #0]
@   0x0802f18e: 3010        adds	r0, #16
@   0x0802f190: 4460        add	r0, ip
@   0x0802f192: 6801        ldr	r1, [r0, #0]
@   0x0802f194: 2280        movs	r2, #128	@ 0x80
@   0x0802f196: 4311        orrs	r1, r2
@   0x0802f198: 6001        str	r1, [r0, #0]
@   0x0802f19a: 2208        movs	r2, #8
@   0x0802f19c: 4491        add	r9, r2
@   0x0802f19e: 2304        movs	r3, #4
@   0x0802f1a0: 449c        add	ip, r3
@   0x0802f1a2: 2501        movs	r5, #1
@   0x0802f1a4: 426d        negs	r5, r5
@   0x0802f1a6: 44a8        add	r8, r5
@   0x0802f1a8: 4640        mov	r0, r8
@   0x0802f1aa: 2800        cmp	r0, #0
@   0x0802f1ac: db00        blt.n	0x2f1b0
@   0x0802f1ae: e75f        b.n	0x2f070
@   0x0802f1b0: 2100        movs	r1, #0
@   0x0802f1b2: 4688        mov	r8, r1
@   0x0802f1b4: 4915        ldr	r1, [pc, #84]	@ (0x2f20c)
@   0x0802f1b6: 6808        ldr	r0, [r1, #0]
@   0x0802f1b8: 7800        ldrb	r0, [r0, #0]
@   0x0802f1ba: 4580        cmp	r8, r0
@   0x0802f1bc: db00        blt.n	0x2f1c0
@   0x0802f1be: e093        b.n	0x2f2e8
@   0x0802f1c0: 3a0f        subs	r2, #15
@   0x0802f1c2: 4691        mov	r9, r2
@   0x0802f1c4: 26ff        movs	r6, #255	@ 0xff
@   0x0802f1c6: 0236        lsls	r6, r6, #8
@   0x0802f1c8: 6808        ldr	r0, [r1, #0]
@   0x0802f1ca: 30cc        adds	r0, #204	@ 0xcc
@   0x0802f1cc: 6801        ldr	r1, [r0, #0]
@   0x0802f1ce: 4643        mov	r3, r8
@   0x0802f1d0: 0098        lsls	r0, r3, #2
@   0x0802f1d2: 1840        adds	r0, r0, r1
@   0x0802f1d4: 6802        ldr	r2, [r0, #0]
@   0x0802f1d6: 2a00        cmp	r2, #0
@   0x0802f1d8: d100        bne.n	0x2f1dc
@   0x0802f1da: e07d        b.n	0x2f2d8
@   0x0802f1dc: 6b91        ldr	r1, [r2, #56]	@ 0x38
@   0x0802f1de: 2001        movs	r0, #1
@   0x0802f1e0: 4008        ands	r0, r1
@   0x0802f1e2: 2800        cmp	r0, #0
@   0x0802f1e4: d04e        beq.n	0x2f284
@   0x0802f1e6: 1c15        adds	r5, r2, #0
@   0x0802f1e8: 3524        adds	r5, #36	@ 0x24
@   0x0802f1ea: 1c17        adds	r7, r2, #0
@   0x0802f1ec: 3728        adds	r7, #40	@ 0x28
@   0x0802f1ee: 8d14        ldrh	r4, [r2, #40]	@ 0x28
@   0x0802f1f0: 2306        movs	r3, #6
@   0x0802f1f2: 1c08        adds	r0, r1, #0
@   0x0802f1f4: 4018        ands	r0, r3
@   0x0802f1f6: 0840        lsrs	r0, r0, #1
@   0x0802f1f8: 2801        cmp	r0, #1
@   0x0802f1fa: d019        beq.n	0x2f230
@   0x0802f1fc: 2801        cmp	r0, #1
@   0x0802f1fe: d307        bcc.n	0x2f210
@   0x0802f200: 2802        cmp	r0, #2
@   0x0802f202: d023        beq.n	0x2f24c
@   0x0802f204: 2803        cmp	r0, #3
@   0x0802f206: d029        beq.n	0x2f25c
@   0x0802f208: e035        b.n	0x2f276
@   0x0802f20a: 0000        movs	r0, r0
@   0x0802f20c: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802f20e: 0300        lsls	r0, r0, #12
@   0x0802f210: 6a50        ldr	r0, [r2, #36]	@ 0x24
@   0x0802f212: 8800        ldrh	r0, [r0, #0]
@   0x0802f214: 1903        adds	r3, r0, r4
@   0x0802f216: 4805        ldr	r0, [pc, #20]	@ (0x2f22c)
@   0x0802f218: 4283        cmp	r3, r0
@   0x0802f21a: dd15        ble.n	0x2f248
@   0x0802f21c: 464d        mov	r5, r9
@   0x0802f21e: 4029        ands	r1, r5
@   0x0802f220: 2002        movs	r0, #2
@   0x0802f222: 4301        orrs	r1, r0
@   0x0802f224: 6391        str	r1, [r2, #56]	@ 0x38
@   0x0802f226: 23ff        movs	r3, #255	@ 0xff
@   0x0802f228: 021b        lsls	r3, r3, #8
@   0x0802f22a: e00d        b.n	0x2f248
@   0x0802f22c: feff        0000 			@ <UNDEFINED> instruction: 0xfeff0000
@   0x0802f230: 6a50        ldr	r0, [r2, #36]	@ 0x24
@   0x0802f232: 8845        ldrh	r5, [r0, #2]
@   0x0802f234: 1b63        subs	r3, r4, r5
@   0x0802f236: 8880        ldrh	r0, [r0, #4]
@   0x0802f238: 4283        cmp	r3, r0
@   0x0802f23a: dc05        bgt.n	0x2f248
@   0x0802f23c: 1c03        adds	r3, r0, #0
@   0x0802f23e: 4648        mov	r0, r9
@   0x0802f240: 4001        ands	r1, r0
@   0x0802f242: 2004        movs	r0, #4
@   0x0802f244: 4301        orrs	r1, r0
@   0x0802f246: 6391        str	r1, [r2, #56]	@ 0x38
@   0x0802f248: 8513        strh	r3, [r2, #40]	@ 0x28
@   0x0802f24a: e014        b.n	0x2f276
@   0x0802f24c: 2010        movs	r0, #16
@   0x0802f24e: 4008        ands	r0, r1
@   0x0802f250: 2800        cmp	r0, #0
@   0x0802f252: d010        beq.n	0x2f276
@   0x0802f254: 4648        mov	r0, r9
@   0x0802f256: 4001        ands	r1, r0
@   0x0802f258: 4319        orrs	r1, r3
@   0x0802f25a: 6391        str	r1, [r2, #56]	@ 0x38
@   0x0802f25c: 6828        ldr	r0, [r5, #0]
@   0x0802f25e: 8839        ldrh	r1, [r7, #0]
@   0x0802f260: 88c0        ldrh	r0, [r0, #6]
@   0x0802f262: 1a0b        subs	r3, r1, r0
@   0x0802f264: 2bff        cmp	r3, #255	@ 0xff
@   0x0802f266: dc05        bgt.n	0x2f274
@   0x0802f268: 2300        movs	r3, #0
@   0x0802f26a: 6b90        ldr	r0, [r2, #56]	@ 0x38
@   0x0802f26c: 2108        movs	r1, #8
@   0x0802f26e: 4249        negs	r1, r1
@   0x0802f270: 4008        ands	r0, r1
@   0x0802f272: 6390        str	r0, [r2, #56]	@ 0x38
@   0x0802f274: 803b        strh	r3, [r7, #0]
@   0x0802f276: 4034        ands	r4, r6
@   0x0802f278: 1c30        adds	r0, r6, #0
@   0x0802f27a: 883f        ldrh	r7, [r7, #0]
@   0x0802f27c: 4038        ands	r0, r7
@   0x0802f27e: 4284        cmp	r4, r0
@   0x0802f280: d02a        beq.n	0x2f2d8
@   0x0802f282: e025        b.n	0x2f2d0
@   0x0802f284: 2020        movs	r0, #32
@   0x0802f286: 4008        ands	r0, r1
@   0x0802f288: 2800        cmp	r0, #0
@   0x0802f28a: d025        beq.n	0x2f2d8
@   0x0802f28c: 1c17        adds	r7, r2, #0
@   0x0802f28e: 3728        adds	r7, #40	@ 0x28
@   0x0802f290: 8d14        ldrh	r4, [r2, #40]	@ 0x28
@   0x0802f292: 6a50        ldr	r0, [r2, #36]	@ 0x24
@   0x0802f294: 1823        adds	r3, r4, r0
@   0x0802f296: 2800        cmp	r0, #0
@   0x0802f298: db0c        blt.n	0x2f2b4
@   0x0802f29a: 4805        ldr	r0, [pc, #20]	@ (0x2f2b0)
@   0x0802f29c: 4283        cmp	r3, r0
@   0x0802f29e: dd12        ble.n	0x2f2c6
@   0x0802f2a0: 2021        movs	r0, #33	@ 0x21
@   0x0802f2a2: 4240        negs	r0, r0
@   0x0802f2a4: 4001        ands	r1, r0
@   0x0802f2a6: 6391        str	r1, [r2, #56]	@ 0x38
@   0x0802f2a8: 23ff        movs	r3, #255	@ 0xff
@   0x0802f2aa: 021b        lsls	r3, r3, #8
@   0x0802f2ac: e00b        b.n	0x2f2c6
@   0x0802f2ae: 0000        movs	r0, r0
@   0x0802f2b0: feff        0000 			@ <UNDEFINED> instruction: 0xfeff0000
@   0x0802f2b4: 2080        movs	r0, #128	@ 0x80
@   0x0802f2b6: 0040        lsls	r0, r0, #1
@   0x0802f2b8: 4283        cmp	r3, r0
@   0x0802f2ba: dc04        bgt.n	0x2f2c6
@   0x0802f2bc: 2021        movs	r0, #33	@ 0x21
@   0x0802f2be: 4240        negs	r0, r0
@   0x0802f2c0: 4001        ands	r1, r0
@   0x0802f2c2: 6391        str	r1, [r2, #56]	@ 0x38
@   0x0802f2c4: 2300        movs	r3, #0
@   0x0802f2c6: 803b        strh	r3, [r7, #0]
@   0x0802f2c8: 4034        ands	r4, r6
@   0x0802f2ca: 4033        ands	r3, r6
@   0x0802f2cc: 429c        cmp	r4, r3
@   0x0802f2ce: d003        beq.n	0x2f2d8
@   0x0802f2d0: 6b90        ldr	r0, [r2, #56]	@ 0x38
@   0x0802f2d2: 2180        movs	r1, #128	@ 0x80
@   0x0802f2d4: 4308        orrs	r0, r1
@   0x0802f2d6: 6390        str	r0, [r2, #56]	@ 0x38
@   0x0802f2d8: 2201        movs	r2, #1
@   0x0802f2da: 4490        add	r8, r2
@   0x0802f2dc: 4906        ldr	r1, [pc, #24]	@ (0x2f2f8)
@   0x0802f2de: 6808        ldr	r0, [r1, #0]
@   0x0802f2e0: 7800        ldrb	r0, [r0, #0]
@   0x0802f2e2: 4580        cmp	r8, r0
@   0x0802f2e4: da00        bge.n	0x2f2e8
@   0x0802f2e6: e76f        b.n	0x2f1c8
@   0x0802f2e8: bc38        pop	{r3, r4, r5}
@   0x0802f2ea: 4698        mov	r8, r3
@   0x0802f2ec: 46a1        mov	r9, r4
@   0x0802f2ee: 46aa        mov	sl, r5
@   0x0802f2f0: bcf0        pop	{r4, r5, r6, r7}
@   0x0802f2f2: bc01        pop	{r0}
@   0x0802f2f4: 4700        bx	r0
@   0x0802f2f6: 0000        movs	r0, r0
@   0x0802f2f8: 65e0        str	r0, [r4, #92]	@ 0x5c
@   0x0802f2fa: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0802F054
sub_0802F054: @ 0x0802f054
        .incbin "frog_us_baserom.gba", 0x2f054, 0x2a8
        thumb_func_end sub_0802F054
