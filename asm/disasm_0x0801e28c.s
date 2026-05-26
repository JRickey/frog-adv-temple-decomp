@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x0801e28c, 0x0801ea08)  (1916 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x801e28c --end 0x801ea08 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x0801e28c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801e28e: 4657        mov	r7, sl
@   0x0801e290: 464e        mov	r6, r9
@   0x0801e292: 4645        mov	r5, r8
@   0x0801e294: b4e0        push	{r5, r6, r7}
@   0x0801e296: b08a        sub	sp, #40	@ 0x28
@   0x0801e298: 2001        movs	r0, #1
@   0x0801e29a: 9007        str	r0, [sp, #28]
@   0x0801e29c: 210a        movs	r1, #10
@   0x0801e29e: 468a        mov	sl, r1
@   0x0801e2a0: f7f0        fa64 	bl	0xe76c
@   0x0801e2a4: 4f26        ldr	r7, [pc, #152]	@ (0x1e340)
@   0x0801e2a6: 4927        ldr	r1, [pc, #156]	@ (0x1e344)
@   0x0801e2a8: 4827        ldr	r0, [pc, #156]	@ (0x1e348)
@   0x0801e2aa: 6800        ldr	r0, [r0, #0]
@   0x0801e2ac: 0080        lsls	r0, r0, #2
@   0x0801e2ae: 1840        adds	r0, r0, r1
@   0x0801e2b0: 6800        ldr	r0, [r0, #0]
@   0x0801e2b2: 6038        str	r0, [r7, #0]
@   0x0801e2b4: 4825        ldr	r0, [pc, #148]	@ (0x1e34c)
@   0x0801e2b6: 6078        str	r0, [r7, #4]
@   0x0801e2b8: 4825        ldr	r0, [pc, #148]	@ (0x1e350)
@   0x0801e2ba: 60b8        str	r0, [r7, #8]
@   0x0801e2bc: 68b8        ldr	r0, [r7, #8]
@   0x0801e2be: 4925        ldr	r1, [pc, #148]	@ (0x1e354)
@   0x0801e2c0: 4825        ldr	r0, [pc, #148]	@ (0x1e358)
@   0x0801e2c2: 8802        ldrh	r2, [r0, #0]
@   0x0801e2c4: 9208        str	r2, [sp, #32]
@   0x0801e2c6: 8001        strh	r1, [r0, #0]
@   0x0801e2c8: 4e24        ldr	r6, [pc, #144]	@ (0x1e35c)
@   0x0801e2ca: 9805        ldr	r0, [sp, #20]
@   0x0801e2cc: 4030        ands	r0, r6
@   0x0801e2ce: 210b        movs	r1, #11
@   0x0801e2d0: 4308        orrs	r0, r1
@   0x0801e2d2: 4d23        ldr	r5, [pc, #140]	@ (0x1e360)
@   0x0801e2d4: 4028        ands	r0, r5
@   0x0801e2d6: 21b0        movs	r1, #176	@ 0xb0
@   0x0801e2d8: 0109        lsls	r1, r1, #4
@   0x0801e2da: 4308        orrs	r0, r1
@   0x0801e2dc: 4c21        ldr	r4, [pc, #132]	@ (0x1e364)
@   0x0801e2de: 4020        ands	r0, r4
@   0x0801e2e0: 23c0        movs	r3, #192	@ 0xc0
@   0x0801e2e2: 029b        lsls	r3, r3, #10
@   0x0801e2e4: 4318        orrs	r0, r3
@   0x0801e2e6: 4a20        ldr	r2, [pc, #128]	@ (0x1e368)
@   0x0801e2e8: 4010        ands	r0, r2
@   0x0801e2ea: 21c0        movs	r1, #192	@ 0xc0
@   0x0801e2ec: 0489        lsls	r1, r1, #18
@   0x0801e2ee: 4308        orrs	r0, r1
@   0x0801e2f0: 9005        str	r0, [sp, #20]
@   0x0801e2f2: 9806        ldr	r0, [sp, #24]
@   0x0801e2f4: 4030        ands	r0, r6
@   0x0801e2f6: 2110        movs	r1, #16
@   0x0801e2f8: 4308        orrs	r0, r1
@   0x0801e2fa: 4028        ands	r0, r5
@   0x0801e2fc: 21c0        movs	r1, #192	@ 0xc0
@   0x0801e2fe: 0109        lsls	r1, r1, #4
@   0x0801e300: 4308        orrs	r0, r1
@   0x0801e302: 4020        ands	r0, r4
@   0x0801e304: 4318        orrs	r0, r3
@   0x0801e306: 4010        ands	r0, r2
@   0x0801e308: 2180        movs	r1, #128	@ 0x80
@   0x0801e30a: 0489        lsls	r1, r1, #18
@   0x0801e30c: 4308        orrs	r0, r1
@   0x0801e30e: 9006        str	r0, [sp, #24]
@   0x0801e310: f00f        ff14 	bl	0x2e13c
@   0x0801e314: 4915        ldr	r1, [pc, #84]	@ (0x1e36c)
@   0x0801e316: 7888        ldrb	r0, [r1, #2]
@   0x0801e318: 2800        cmp	r0, #0
@   0x0801e31a: d000        beq.n	0x1e31e
@   0x0801e31c: e097        b.n	0x1e44e
@   0x0801e31e: f00f        ff0d 	bl	0x2e13c
@   0x0801e322: 4913        ldr	r1, [pc, #76]	@ (0x1e370)
@   0x0801e324: 20fd        movs	r0, #253	@ 0xfd
@   0x0801e326: 780a        ldrb	r2, [r1, #0]
@   0x0801e328: 4010        ands	r0, r2
@   0x0801e32a: 7008        strb	r0, [r1, #0]
@   0x0801e32c: f002        fc3e 	bl	0x20bac
@   0x0801e330: 2011        movs	r0, #17
@   0x0801e332: f002        fc29 	bl	0x20b88
@   0x0801e336: 20bf        movs	r0, #191	@ 0xbf
@   0x0801e338: f7f2        f9ac 	bl	0x10694
@   0x0801e33c: e01d        b.n	0x1e37a
@   0x0801e33e: 0000        movs	r0, r0
@   0x0801e340: 00d4        lsls	r4, r2, #3
@   0x0801e342: 0400        lsls	r0, r0, #16
@   0x0801e344: 8f98        ldrh	r0, [r3, #60]	@ 0x3c
@   0x0801e346: 0830        lsrs	r0, r6, #32
@   0x0801e348: 34b0        adds	r4, #176	@ 0xb0
@   0x0801e34a: 0300        lsls	r0, r0, #12
@   0x0801e34c: b000        add	sp, #0
@   0x0801e34e: 0600        lsls	r0, r0, #24
@   0x0801e350: 0600        lsls	r0, r0, #24
@   0x0801e352: 8000        strh	r0, [r0, #0]
@   0x0801e354: 02d7        lsls	r7, r2, #11
@   0x0801e356: 0000        movs	r0, r0
@   0x0801e358: 01fa        lsls	r2, r7, #7
@   0x0801e35a: 0500        lsls	r0, r0, #20
@   0x0801e35c: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0801e360: 00ff        lsls	r7, r7, #3
@   0x0801e362: ffff        ffff 			@ <UNDEFINED> instruction: 0xffffffff
@   0x0801e366: ff00        ffff 	vmaxnm.f32	<illegal reg q7.5>, q8, <illegal reg q15.5>
@   0x0801e36a: 00ff        lsls	r7, r7, #3
@   0x0801e36c: 3500        adds	r5, #0
@   0x0801e36e: 0300        lsls	r0, r0, #12
@   0x0801e370: 3570        adds	r5, #112	@ 0x70
@   0x0801e372: 0300        lsls	r0, r0, #12
@   0x0801e374: 2002        movs	r0, #2
@   0x0801e376: f7ff        ff7b 	bl	0x1e270
@   0x0801e37a: f7f2        f99d 	bl	0x106b8
@   0x0801e37e: 2800        cmp	r0, #0
@   0x0801e380: d1f8        bne.n	0x1e374
@   0x0801e382: 4906        ldr	r1, [pc, #24]	@ (0x1e39c)
@   0x0801e384: 4806        ldr	r0, [pc, #24]	@ (0x1e3a0)
@   0x0801e386: 6008        str	r0, [r1, #0]
@   0x0801e388: 4806        ldr	r0, [pc, #24]	@ (0x1e3a4)
@   0x0801e38a: 6048        str	r0, [r1, #4]
@   0x0801e38c: 4806        ldr	r0, [pc, #24]	@ (0x1e3a8)
@   0x0801e38e: 6088        str	r0, [r1, #8]
@   0x0801e390: 6888        ldr	r0, [r1, #8]
@   0x0801e392: 20bf        movs	r0, #191	@ 0xbf
@   0x0801e394: f7f2        f9aa 	bl	0x106ec
@   0x0801e398: e00b        b.n	0x1e3b2
@   0x0801e39a: 0000        movs	r0, r0
@   0x0801e39c: 00d4        lsls	r4, r2, #3
@   0x0801e39e: 0400        lsls	r0, r0, #16
@   0x0801e3a0: c578        stmia	r5!, {r3, r4, r5, r6}
@   0x0801e3a2: 0820        lsrs	r0, r4, #32
@   0x0801e3a4: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801e3a8: 0400        lsls	r0, r0, #16
@   0x0801e3aa: 8000        strh	r0, [r0, #0]
@   0x0801e3ac: 2002        movs	r0, #2
@   0x0801e3ae: f7ff        ff5f 	bl	0x1e270
@   0x0801e3b2: f7f2        f9ad 	bl	0x10710
@   0x0801e3b6: 2800        cmp	r0, #0
@   0x0801e3b8: d1f8        bne.n	0x1e3ac
@   0x0801e3ba: 20fa        movs	r0, #250	@ 0xfa
@   0x0801e3bc: f7ff        ff58 	bl	0x1e270
@   0x0801e3c0: 4805        ldr	r0, [pc, #20]	@ (0x1e3d8)
@   0x0801e3c2: 2102        movs	r1, #2
@   0x0801e3c4: 7802        ldrb	r2, [r0, #0]
@   0x0801e3c6: 4311        orrs	r1, r2
@   0x0801e3c8: 7001        strb	r1, [r0, #0]
@   0x0801e3ca: f00f        fa95 	bl	0x2d8f8
@   0x0801e3ce: 20bf        movs	r0, #191	@ 0xbf
@   0x0801e3d0: f7f2        f960 	bl	0x10694
@   0x0801e3d4: e005        b.n	0x1e3e2
@   0x0801e3d6: 0000        movs	r0, r0
@   0x0801e3d8: 3570        adds	r5, #112	@ 0x70
@   0x0801e3da: 0300        lsls	r0, r0, #12
@   0x0801e3dc: 2002        movs	r0, #2
@   0x0801e3de: f7ff        ff47 	bl	0x1e270
@   0x0801e3e2: f7f2        f969 	bl	0x106b8
@   0x0801e3e6: 1c03        adds	r3, r0, #0
@   0x0801e3e8: 2b00        cmp	r3, #0
@   0x0801e3ea: d1f7        bne.n	0x1e3dc
@   0x0801e3ec: a803        add	r0, sp, #12
@   0x0801e3ee: 8003        strh	r3, [r0, #0]
@   0x0801e3f0: 480f        ldr	r0, [pc, #60]	@ (0x1e430)
@   0x0801e3f2: a903        add	r1, sp, #12
@   0x0801e3f4: 6001        str	r1, [r0, #0]
@   0x0801e3f6: 490f        ldr	r1, [pc, #60]	@ (0x1e434)
@   0x0801e3f8: 6041        str	r1, [r0, #4]
@   0x0801e3fa: 4a0f        ldr	r2, [pc, #60]	@ (0x1e438)
@   0x0801e3fc: 6082        str	r2, [r0, #8]
@   0x0801e3fe: 6881        ldr	r1, [r0, #8]
@   0x0801e400: a903        add	r1, sp, #12
@   0x0801e402: 800b        strh	r3, [r1, #0]
@   0x0801e404: 6001        str	r1, [r0, #0]
@   0x0801e406: 490d        ldr	r1, [pc, #52]	@ (0x1e43c)
@   0x0801e408: 6041        str	r1, [r0, #4]
@   0x0801e40a: 6082        str	r2, [r0, #8]
@   0x0801e40c: 6881        ldr	r1, [r0, #8]
@   0x0801e40e: a903        add	r1, sp, #12
@   0x0801e410: 800b        strh	r3, [r1, #0]
@   0x0801e412: 6001        str	r1, [r0, #0]
@   0x0801e414: 490a        ldr	r1, [pc, #40]	@ (0x1e440)
@   0x0801e416: 6041        str	r1, [r0, #4]
@   0x0801e418: 6082        str	r2, [r0, #8]
@   0x0801e41a: 6881        ldr	r1, [r0, #8]
@   0x0801e41c: a903        add	r1, sp, #12
@   0x0801e41e: 800b        strh	r3, [r1, #0]
@   0x0801e420: 6001        str	r1, [r0, #0]
@   0x0801e422: 4908        ldr	r1, [pc, #32]	@ (0x1e444)
@   0x0801e424: 6041        str	r1, [r0, #4]
@   0x0801e426: 6082        str	r2, [r0, #8]
@   0x0801e428: 6880        ldr	r0, [r0, #8]
@   0x0801e42a: 2000        movs	r0, #0
@   0x0801e42c: e149        b.n	0x1e6c2
@   0x0801e42e: 0000        movs	r0, r0
@   0x0801e430: 00d4        lsls	r4, r2, #3
@   0x0801e432: 0400        lsls	r0, r0, #16
@   0x0801e434: e000        b.n	0x1e438
@   0x0801e436: 0600        lsls	r0, r0, #24
@   0x0801e438: 0400        lsls	r0, r0, #16
@   0x0801e43a: 8100        strh	r0, [r0, #8]
@   0x0801e43c: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x0801e440: f000        0600 	and.w	r6, r0, #0
@   0x0801e444: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801e448: 2200        movs	r2, #0
@   0x0801e44a: 9207        str	r2, [sp, #28]
@   0x0801e44c: e0a6        b.n	0x1e59c
@   0x0801e44e: 481a        ldr	r0, [pc, #104]	@ (0x1e4b8)
@   0x0801e450: 7e01        ldrb	r1, [r0, #24]
@   0x0801e452: 9109        str	r1, [sp, #36]	@ 0x24
@   0x0801e454: 2600        movs	r6, #0
@   0x0801e456: 7606        strb	r6, [r0, #24]
@   0x0801e458: aa04        add	r2, sp, #16
@   0x0801e45a: 4690        mov	r8, r2
@   0x0801e45c: 4917        ldr	r1, [pc, #92]	@ (0x1e4bc)
@   0x0801e45e: 1c08        adds	r0, r1, #0
@   0x0801e460: 8010        strh	r0, [r2, #0]
@   0x0801e462: 603a        str	r2, [r7, #0]
@   0x0801e464: 4916        ldr	r1, [pc, #88]	@ (0x1e4c0)
@   0x0801e466: 6079        str	r1, [r7, #4]
@   0x0801e468: 4816        ldr	r0, [pc, #88]	@ (0x1e4c4)
@   0x0801e46a: 60b8        str	r0, [r7, #8]
@   0x0801e46c: 68b8        ldr	r0, [r7, #8]
@   0x0801e46e: 4816        ldr	r0, [pc, #88]	@ (0x1e4c8)
@   0x0801e470: 6038        str	r0, [r7, #0]
@   0x0801e472: 6079        str	r1, [r7, #4]
@   0x0801e474: 4815        ldr	r0, [pc, #84]	@ (0x1e4cc)
@   0x0801e476: 60b8        str	r0, [r7, #8]
@   0x0801e478: 68b8        ldr	r0, [r7, #8]
@   0x0801e47a: 22d9        movs	r2, #217	@ 0xd9
@   0x0801e47c: 0052        lsls	r2, r2, #1
@   0x0801e47e: 4691        mov	r9, r2
@   0x0801e480: 250e        movs	r5, #14
@   0x0801e482: 9500        str	r5, [sp, #0]
@   0x0801e484: 2403        movs	r4, #3
@   0x0801e486: 9401        str	r4, [sp, #4]
@   0x0801e488: 200a        movs	r0, #10
@   0x0801e48a: 210e        movs	r1, #14
@   0x0801e48c: 2209        movs	r2, #9
@   0x0801e48e: 464b        mov	r3, r9
@   0x0801e490: f7fe        fd42 	bl	0x1cf18
@   0x0801e494: 490e        ldr	r1, [pc, #56]	@ (0x1e4d0)
@   0x0801e496: 7888        ldrb	r0, [r1, #2]
@   0x0801e498: 9500        str	r5, [sp, #0]
@   0x0801e49a: 9401        str	r4, [sp, #4]
@   0x0801e49c: 9602        str	r6, [sp, #8]
@   0x0801e49e: 2113        movs	r1, #19
@   0x0801e4a0: 2206        movs	r2, #6
@   0x0801e4a2: 464b        mov	r3, r9
@   0x0801e4a4: f7fd        ff06 	bl	0x1c2b4
@   0x0801e4a8: 4c0a        ldr	r4, [pc, #40]	@ (0x1e4d4)
@   0x0801e4aa: 8026        strh	r6, [r4, #0]
@   0x0801e4ac: f7e2        fa28 	bl	0x900
@   0x0801e4b0: 1c05        adds	r5, r0, #0
@   0x0801e4b2: 8820        ldrh	r0, [r4, #0]
@   0x0801e4b4: 4646        mov	r6, r8
@   0x0801e4b6: e06d        b.n	0x1e594
@   0x0801e4b8: 5330        strh	r0, [r6, r4]
@   0x0801e4ba: 0300        lsls	r0, r0, #12
@   0x0801e4bc: f039        0000 	bics.w	r0, r9, #0
@   0x0801e4c0: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801e4c4: 0400        lsls	r0, r0, #16
@   0x0801e4c6: 8100        strh	r0, [r0, #8]
@   0x0801e4c8: 9378        str	r3, [sp, #480]	@ 0x1e0
@   0x0801e4ca: 0821        lsrs	r1, r4, #32
@   0x0801e4cc: 0400        lsls	r0, r0, #16
@   0x0801e4ce: 8000        strh	r0, [r0, #0]
@   0x0801e4d0: 3500        adds	r5, #0
@   0x0801e4d2: 0300        lsls	r0, r0, #12
@   0x0801e4d4: 5398        strh	r0, [r3, r6]
@   0x0801e4d6: 0300        lsls	r0, r0, #12
@   0x0801e4d8: f7e2        fa12 	bl	0x900
@   0x0801e4dc: 1b40        subs	r0, r0, r5
@   0x0801e4de: 283b        cmp	r0, #59	@ 0x3b
@   0x0801e4e0: d913        bls.n	0x1e50a
@   0x0801e4e2: f7e2        fa0d 	bl	0x900
@   0x0801e4e6: 1b40        subs	r0, r0, r5
@   0x0801e4e8: 213c        movs	r1, #60	@ 0x3c
@   0x0801e4ea: f015        fcfb 	bl	0x33ee4
@   0x0801e4ee: 4652        mov	r2, sl
@   0x0801e4f0: 1a12        subs	r2, r2, r0
@   0x0801e4f2: 4692        mov	sl, r2
@   0x0801e4f4: 2a05        cmp	r2, #5
@   0x0801e4f6: d802        bhi.n	0x1e4fe
@   0x0801e4f8: 2068        movs	r0, #104	@ 0x68
@   0x0801e4fa: f002        fbbd 	bl	0x20c78
@   0x0801e4fe: 4650        mov	r0, sl
@   0x0801e500: 2800        cmp	r0, #0
@   0x0801e502: d0a1        beq.n	0x1e448
@   0x0801e504: f7e2        f9fc 	bl	0x900
@   0x0801e508: 1c05        adds	r5, r0, #0
@   0x0801e50a: 4651        mov	r1, sl
@   0x0801e50c: 0608        lsls	r0, r1, #24
@   0x0801e50e: 0e00        lsrs	r0, r0, #24
@   0x0801e510: 210e        movs	r1, #14
@   0x0801e512: 9100        str	r1, [sp, #0]
@   0x0801e514: 2103        movs	r1, #3
@   0x0801e516: 9101        str	r1, [sp, #4]
@   0x0801e518: 210e        movs	r1, #14
@   0x0801e51a: 2209        movs	r2, #9
@   0x0801e51c: 23d9        movs	r3, #217	@ 0xd9
@   0x0801e51e: 005b        lsls	r3, r3, #1
@   0x0801e520: f7fe        fcfa 	bl	0x1cf18
@   0x0801e524: f7e1        ffce 	bl	0x4c4
@   0x0801e528: 8020        strh	r0, [r4, #0]
@   0x0801e52a: 8820        ldrh	r0, [r4, #0]
@   0x0801e52c: 2808        cmp	r0, #8
@   0x0801e52e: d019        beq.n	0x1e564
@   0x0801e530: 2808        cmp	r0, #8
@   0x0801e532: dc02        bgt.n	0x1e53a
@   0x0801e534: 2804        cmp	r0, #4
@   0x0801e536: d003        beq.n	0x1e540
@   0x0801e538: e02b        b.n	0x1e592
@   0x0801e53a: 2820        cmp	r0, #32
@   0x0801e53c: d024        beq.n	0x1e588
@   0x0801e53e: e028        b.n	0x1e592
@   0x0801e540: 2002        movs	r0, #2
@   0x0801e542: f002        fb99 	bl	0x20c78
@   0x0801e546: a805        add	r0, sp, #20
@   0x0801e548: 210f        movs	r1, #15
@   0x0801e54a: 220e        movs	r2, #14
@   0x0801e54c: 2303        movs	r3, #3
@   0x0801e54e: f7f9        ffc5 	bl	0x184dc
@   0x0801e552: a806        add	r0, sp, #24
@   0x0801e554: 210e        movs	r1, #14
@   0x0801e556: 220f        movs	r2, #15
@   0x0801e558: 2303        movs	r3, #3
@   0x0801e55a: f7f9        ffbf 	bl	0x184dc
@   0x0801e55e: 2201        movs	r2, #1
@   0x0801e560: 9207        str	r2, [sp, #28]
@   0x0801e562: e016        b.n	0x1e592
@   0x0801e564: 2002        movs	r0, #2
@   0x0801e566: f002        fb87 	bl	0x20c78
@   0x0801e56a: a805        add	r0, sp, #20
@   0x0801e56c: 210e        movs	r1, #14
@   0x0801e56e: 220f        movs	r2, #15
@   0x0801e570: 2303        movs	r3, #3
@   0x0801e572: f7f9        ffb3 	bl	0x184dc
@   0x0801e576: a806        add	r0, sp, #24
@   0x0801e578: 210f        movs	r1, #15
@   0x0801e57a: 220e        movs	r2, #14
@   0x0801e57c: 2303        movs	r3, #3
@   0x0801e57e: f7f9        ffad 	bl	0x184dc
@   0x0801e582: 2000        movs	r0, #0
@   0x0801e584: 9007        str	r0, [sp, #28]
@   0x0801e586: e004        b.n	0x1e592
@   0x0801e588: 2000        movs	r0, #0
@   0x0801e58a: f002        fb75 	bl	0x20c78
@   0x0801e58e: 2100        movs	r1, #0
@   0x0801e590: 9107        str	r1, [sp, #28]
@   0x0801e592: 8820        ldrh	r0, [r4, #0]
@   0x0801e594: 2810        cmp	r0, #16
@   0x0801e596: d006        beq.n	0x1e5a6
@   0x0801e598: 2820        cmp	r0, #32
@   0x0801e59a: d19d        bne.n	0x1e4d8
@   0x0801e59c: 480f        ldr	r0, [pc, #60]	@ (0x1e5dc)
@   0x0801e59e: 1c02        adds	r2, r0, #0
@   0x0801e5a0: 8810        ldrh	r0, [r2, #0]
@   0x0801e5a2: 2810        cmp	r0, #16
@   0x0801e5a4: d107        bne.n	0x1e5b6
@   0x0801e5a6: 4a0d        ldr	r2, [pc, #52]	@ (0x1e5dc)
@   0x0801e5a8: 9907        ldr	r1, [sp, #28]
@   0x0801e5aa: 2900        cmp	r1, #0
@   0x0801e5ac: d003        beq.n	0x1e5b6
@   0x0801e5ae: 490c        ldr	r1, [pc, #48]	@ (0x1e5e0)
@   0x0801e5b0: 7888        ldrb	r0, [r1, #2]
@   0x0801e5b2: 3801        subs	r0, #1
@   0x0801e5b4: 7088        strb	r0, [r1, #2]
@   0x0801e5b6: 2000        movs	r0, #0
@   0x0801e5b8: 8010        strh	r0, [r2, #0]
@   0x0801e5ba: 9a07        ldr	r2, [sp, #28]
@   0x0801e5bc: 2a00        cmp	r2, #0
@   0x0801e5be: d16e        bne.n	0x1e69e
@   0x0801e5c0: 4908        ldr	r1, [pc, #32]	@ (0x1e5e4)
@   0x0801e5c2: 20fd        movs	r0, #253	@ 0xfd
@   0x0801e5c4: 780a        ldrb	r2, [r1, #0]
@   0x0801e5c6: 4010        ands	r0, r2
@   0x0801e5c8: 7008        strb	r0, [r1, #0]
@   0x0801e5ca: f002        faef 	bl	0x20bac
@   0x0801e5ce: 2011        movs	r0, #17
@   0x0801e5d0: f002        fada 	bl	0x20b88
@   0x0801e5d4: 20bf        movs	r0, #191	@ 0xbf
@   0x0801e5d6: f7f2        f85d 	bl	0x10694
@   0x0801e5da: e008        b.n	0x1e5ee
@   0x0801e5dc: 5398        strh	r0, [r3, r6]
@   0x0801e5de: 0300        lsls	r0, r0, #12
@   0x0801e5e0: 3500        adds	r5, #0
@   0x0801e5e2: 0300        lsls	r0, r0, #12
@   0x0801e5e4: 3570        adds	r5, #112	@ 0x70
@   0x0801e5e6: 0300        lsls	r0, r0, #12
@   0x0801e5e8: 2002        movs	r0, #2
@   0x0801e5ea: f7ff        fe41 	bl	0x1e270
@   0x0801e5ee: f7f2        f863 	bl	0x106b8
@   0x0801e5f2: 2800        cmp	r0, #0
@   0x0801e5f4: d1f8        bne.n	0x1e5e8
@   0x0801e5f6: 4906        ldr	r1, [pc, #24]	@ (0x1e610)
@   0x0801e5f8: 4806        ldr	r0, [pc, #24]	@ (0x1e614)
@   0x0801e5fa: 6008        str	r0, [r1, #0]
@   0x0801e5fc: 4806        ldr	r0, [pc, #24]	@ (0x1e618)
@   0x0801e5fe: 6048        str	r0, [r1, #4]
@   0x0801e600: 4806        ldr	r0, [pc, #24]	@ (0x1e61c)
@   0x0801e602: 6088        str	r0, [r1, #8]
@   0x0801e604: 6888        ldr	r0, [r1, #8]
@   0x0801e606: 20bf        movs	r0, #191	@ 0xbf
@   0x0801e608: f7f2        f870 	bl	0x106ec
@   0x0801e60c: e00b        b.n	0x1e626
@   0x0801e60e: 0000        movs	r0, r0
@   0x0801e610: 00d4        lsls	r4, r2, #3
@   0x0801e612: 0400        lsls	r0, r0, #16
@   0x0801e614: c578        stmia	r5!, {r3, r4, r5, r6}
@   0x0801e616: 0820        lsrs	r0, r4, #32
@   0x0801e618: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801e61c: 0400        lsls	r0, r0, #16
@   0x0801e61e: 8000        strh	r0, [r0, #0]
@   0x0801e620: 2002        movs	r0, #2
@   0x0801e622: f7ff        fe25 	bl	0x1e270
@   0x0801e626: f7f2        f873 	bl	0x10710
@   0x0801e62a: 2800        cmp	r0, #0
@   0x0801e62c: d1f8        bne.n	0x1e620
@   0x0801e62e: 20fa        movs	r0, #250	@ 0xfa
@   0x0801e630: f7ff        fe1e 	bl	0x1e270
@   0x0801e634: 4805        ldr	r0, [pc, #20]	@ (0x1e64c)
@   0x0801e636: 2102        movs	r1, #2
@   0x0801e638: 7802        ldrb	r2, [r0, #0]
@   0x0801e63a: 4311        orrs	r1, r2
@   0x0801e63c: 7001        strb	r1, [r0, #0]
@   0x0801e63e: f00f        f95b 	bl	0x2d8f8
@   0x0801e642: 20bf        movs	r0, #191	@ 0xbf
@   0x0801e644: f7f2        f826 	bl	0x10694
@   0x0801e648: e005        b.n	0x1e656
@   0x0801e64a: 0000        movs	r0, r0
@   0x0801e64c: 3570        adds	r5, #112	@ 0x70
@   0x0801e64e: 0300        lsls	r0, r0, #12
@   0x0801e650: 2002        movs	r0, #2
@   0x0801e652: f7ff        fe0d 	bl	0x1e270
@   0x0801e656: f7f2        f82f 	bl	0x106b8
@   0x0801e65a: 1c03        adds	r3, r0, #0
@   0x0801e65c: 2b00        cmp	r3, #0
@   0x0801e65e: d1f7        bne.n	0x1e650
@   0x0801e660: a803        add	r0, sp, #12
@   0x0801e662: 8003        strh	r3, [r0, #0]
@   0x0801e664: 481b        ldr	r0, [pc, #108]	@ (0x1e6d4)
@   0x0801e666: a903        add	r1, sp, #12
@   0x0801e668: 6001        str	r1, [r0, #0]
@   0x0801e66a: 491b        ldr	r1, [pc, #108]	@ (0x1e6d8)
@   0x0801e66c: 6041        str	r1, [r0, #4]
@   0x0801e66e: 4a1b        ldr	r2, [pc, #108]	@ (0x1e6dc)
@   0x0801e670: 6082        str	r2, [r0, #8]
@   0x0801e672: 6881        ldr	r1, [r0, #8]
@   0x0801e674: a903        add	r1, sp, #12
@   0x0801e676: 800b        strh	r3, [r1, #0]
@   0x0801e678: 6001        str	r1, [r0, #0]
@   0x0801e67a: 4919        ldr	r1, [pc, #100]	@ (0x1e6e0)
@   0x0801e67c: 6041        str	r1, [r0, #4]
@   0x0801e67e: 6082        str	r2, [r0, #8]
@   0x0801e680: 6881        ldr	r1, [r0, #8]
@   0x0801e682: a903        add	r1, sp, #12
@   0x0801e684: 800b        strh	r3, [r1, #0]
@   0x0801e686: 6001        str	r1, [r0, #0]
@   0x0801e688: 4916        ldr	r1, [pc, #88]	@ (0x1e6e4)
@   0x0801e68a: 6041        str	r1, [r0, #4]
@   0x0801e68c: 6082        str	r2, [r0, #8]
@   0x0801e68e: 6881        ldr	r1, [r0, #8]
@   0x0801e690: a903        add	r1, sp, #12
@   0x0801e692: 800b        strh	r3, [r1, #0]
@   0x0801e694: 6001        str	r1, [r0, #0]
@   0x0801e696: 4914        ldr	r1, [pc, #80]	@ (0x1e6e8)
@   0x0801e698: 6041        str	r1, [r0, #4]
@   0x0801e69a: 6082        str	r2, [r0, #8]
@   0x0801e69c: 6880        ldr	r0, [r0, #8]
@   0x0801e69e: 4813        ldr	r0, [pc, #76]	@ (0x1e6ec)
@   0x0801e6a0: 466a        mov	r2, sp
@   0x0801e6a2: 8c12        ldrh	r2, [r2, #32]
@   0x0801e6a4: 8002        strh	r2, [r0, #0]
@   0x0801e6a6: 2000        movs	r0, #0
@   0x0801e6a8: 8030        strh	r0, [r6, #0]
@   0x0801e6aa: 490a        ldr	r1, [pc, #40]	@ (0x1e6d4)
@   0x0801e6ac: 600e        str	r6, [r1, #0]
@   0x0801e6ae: 480e        ldr	r0, [pc, #56]	@ (0x1e6e8)
@   0x0801e6b0: 6048        str	r0, [r1, #4]
@   0x0801e6b2: 480a        ldr	r0, [pc, #40]	@ (0x1e6dc)
@   0x0801e6b4: 6088        str	r0, [r1, #8]
@   0x0801e6b6: 6888        ldr	r0, [r1, #8]
@   0x0801e6b8: 480d        ldr	r0, [pc, #52]	@ (0x1e6f0)
@   0x0801e6ba: a909        add	r1, sp, #36	@ 0x24
@   0x0801e6bc: 7809        ldrb	r1, [r1, #0]
@   0x0801e6be: 7601        strb	r1, [r0, #24]
@   0x0801e6c0: 9807        ldr	r0, [sp, #28]
@   0x0801e6c2: b00a        add	sp, #40	@ 0x28
@   0x0801e6c4: bc38        pop	{r3, r4, r5}
@   0x0801e6c6: 4698        mov	r8, r3
@   0x0801e6c8: 46a1        mov	r9, r4
@   0x0801e6ca: 46aa        mov	sl, r5
@   0x0801e6cc: bcf0        pop	{r4, r5, r6, r7}
@   0x0801e6ce: bc02        pop	{r1}
@   0x0801e6d0: 4708        bx	r1
@   0x0801e6d2: 0000        movs	r0, r0
@   0x0801e6d4: 00d4        lsls	r4, r2, #3
@   0x0801e6d6: 0400        lsls	r0, r0, #16
@   0x0801e6d8: e000        b.n	0x1e6dc
@   0x0801e6da: 0600        lsls	r0, r0, #24
@   0x0801e6dc: 0400        lsls	r0, r0, #16
@   0x0801e6de: 8100        strh	r0, [r0, #8]
@   0x0801e6e0: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x0801e6e4: f000        0600 	and.w	r6, r0, #0
@   0x0801e6e8: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801e6ec: 01fa        lsls	r2, r7, #7
@   0x0801e6ee: 0500        lsls	r0, r0, #20
@   0x0801e6f0: 5330        strh	r0, [r6, r4]
@   0x0801e6f2: 0300        lsls	r0, r0, #12
@   0x0801e6f4: b081        sub	sp, #4
@   0x0801e6f6: 1c01        adds	r1, r0, #0
@   0x0801e6f8: 2900        cmp	r1, #0
@   0x0801e6fa: d00b        beq.n	0x1e714
@   0x0801e6fc: 4669        mov	r1, sp
@   0x0801e6fe: 4a03        ldr	r2, [pc, #12]	@ (0x1e70c)
@   0x0801e700: 1c10        adds	r0, r2, #0
@   0x0801e702: 8008        strh	r0, [r1, #0]
@   0x0801e704: 4902        ldr	r1, [pc, #8]	@ (0x1e710)
@   0x0801e706: 4668        mov	r0, sp
@   0x0801e708: e007        b.n	0x1e71a
@   0x0801e70a: 0000        movs	r0, r0
@   0x0801e70c: f039        0000 	bics.w	r0, r9, #0
@   0x0801e710: 00d4        lsls	r4, r2, #3
@   0x0801e712: 0400        lsls	r0, r0, #16
@   0x0801e714: 4668        mov	r0, sp
@   0x0801e716: 8001        strh	r1, [r0, #0]
@   0x0801e718: 4904        ldr	r1, [pc, #16]	@ (0x1e72c)
@   0x0801e71a: 6008        str	r0, [r1, #0]
@   0x0801e71c: 4804        ldr	r0, [pc, #16]	@ (0x1e730)
@   0x0801e71e: 6048        str	r0, [r1, #4]
@   0x0801e720: 4804        ldr	r0, [pc, #16]	@ (0x1e734)
@   0x0801e722: 6088        str	r0, [r1, #8]
@   0x0801e724: 6888        ldr	r0, [r1, #8]
@   0x0801e726: b001        add	sp, #4
@   0x0801e728: 4770        bx	lr
@   0x0801e72a: 0000        movs	r0, r0
@   0x0801e72c: 00d4        lsls	r4, r2, #3
@   0x0801e72e: 0400        lsls	r0, r0, #16
@   0x0801e730: f800        0600 	strb.w	r0, [r0, <undefined>]
@   0x0801e734: 0400        lsls	r0, r0, #16
@   0x0801e736: 8100        strh	r0, [r0, #8]
@   0x0801e738: b5f0        push	{r4, r5, r6, r7, lr}
@   0x0801e73a: 4647        mov	r7, r8
@   0x0801e73c: b480        push	{r7}
@   0x0801e73e: b088        sub	sp, #32
@   0x0801e740: 2600        movs	r6, #0
@   0x0801e742: 9604        str	r6, [sp, #16]
@   0x0801e744: 4823        ldr	r0, [pc, #140]	@ (0x1e7d4)
@   0x0801e746: 6800        ldr	r0, [r0, #0]
@   0x0801e748: 4923        ldr	r1, [pc, #140]	@ (0x1e7d8)
@   0x0801e74a: 2803        cmp	r0, #3
@   0x0801e74c: d100        bne.n	0x1e750
@   0x0801e74e: 4923        ldr	r1, [pc, #140]	@ (0x1e7dc)
@   0x0801e750: 9105        str	r1, [sp, #20]
@   0x0801e752: 4923        ldr	r1, [pc, #140]	@ (0x1e7e0)
@   0x0801e754: 0080        lsls	r0, r0, #2
@   0x0801e756: 1840        adds	r0, r0, r1
@   0x0801e758: 6800        ldr	r0, [r0, #0]
@   0x0801e75a: 9006        str	r0, [sp, #24]
@   0x0801e75c: 9607        str	r6, [sp, #28]
@   0x0801e75e: 4c21        ldr	r4, [pc, #132]	@ (0x1e7e4)
@   0x0801e760: 7526        strb	r6, [r4, #20]
@   0x0801e762: 2280        movs	r2, #128	@ 0x80
@   0x0801e764: 04d2        lsls	r2, r2, #19
@   0x0801e766: 8810        ldrh	r0, [r2, #0]
@   0x0801e768: 2380        movs	r3, #128	@ 0x80
@   0x0801e76a: 009b        lsls	r3, r3, #2
@   0x0801e76c: 1c19        adds	r1, r3, #0
@   0x0801e76e: 4308        orrs	r0, r1
@   0x0801e770: 8010        strh	r0, [r2, #0]
@   0x0801e772: 200e        movs	r0, #14
@   0x0801e774: f7fa        fa4a 	bl	0x18c0c
@   0x0801e778: 4d1b        ldr	r5, [pc, #108]	@ (0x1e7e8)
@   0x0801e77a: 46a8        mov	r8, r5
@   0x0801e77c: 68a8        ldr	r0, [r5, #8]
@   0x0801e77e: 271d        movs	r7, #29
@   0x0801e780: 46bc        mov	ip, r7
@   0x0801e782: 2800        cmp	r0, #0
@   0x0801e784: d001        beq.n	0x1e78a
@   0x0801e786: 211b        movs	r1, #27
@   0x0801e788: 468c        mov	ip, r1
@   0x0801e78a: 2200        movs	r2, #0
@   0x0801e78c: 2800        cmp	r0, #0
@   0x0801e78e: d100        bne.n	0x1e792
@   0x0801e790: 2201        movs	r2, #1
@   0x0801e792: 2002        movs	r0, #2
@   0x0801e794: 9003        str	r0, [sp, #12]
@   0x0801e796: 4669        mov	r1, sp
@   0x0801e798: a805        add	r0, sp, #20
@   0x0801e79a: c8a8        ldmia	r0!, {r3, r5, r7}
@   0x0801e79c: c1a8        stmia	r1!, {r3, r5, r7}
@   0x0801e79e: 9b04        ldr	r3, [sp, #16]
@   0x0801e7a0: 1c10        adds	r0, r2, #0
@   0x0801e7a2: 4661        mov	r1, ip
@   0x0801e7a4: 2206        movs	r2, #6
@   0x0801e7a6: f7fa        f877 	bl	0x18898
@   0x0801e7aa: 4910        ldr	r1, [pc, #64]	@ (0x1e7ec)
@   0x0801e7ac: 9805        ldr	r0, [sp, #20]
@   0x0801e7ae: 6008        str	r0, [r1, #0]
@   0x0801e7b0: 480f        ldr	r0, [pc, #60]	@ (0x1e7f0)
@   0x0801e7b2: 6048        str	r0, [r1, #4]
@   0x0801e7b4: 480f        ldr	r0, [pc, #60]	@ (0x1e7f4)
@   0x0801e7b6: 6088        str	r0, [r1, #8]
@   0x0801e7b8: 6888        ldr	r0, [r1, #8]
@   0x0801e7ba: f000        f925 	bl	0x1ea08
@   0x0801e7be: 4640        mov	r0, r8
@   0x0801e7c0: 6046        str	r6, [r0, #4]
@   0x0801e7c2: 78a0        ldrb	r0, [r4, #2]
@   0x0801e7c4: 3001        adds	r0, #1
@   0x0801e7c6: 70a0        strb	r0, [r4, #2]
@   0x0801e7c8: b008        add	sp, #32
@   0x0801e7ca: bc08        pop	{r3}
@   0x0801e7cc: 4698        mov	r8, r3
@   0x0801e7ce: bcf0        pop	{r4, r5, r6, r7}
@   0x0801e7d0: bc01        pop	{r0}
@   0x0801e7d2: 4700        bx	r0
@   0x0801e7d4: 34b0        adds	r4, #176	@ 0xb0
@   0x0801e7d6: 0300        lsls	r0, r0, #12
@   0x0801e7d8: 9c18        ldr	r4, [sp, #96]	@ 0x60
@   0x0801e7da: 081e        lsrs	r6, r3, #32
@   0x0801e7dc: a418        add	r4, pc, #96	@ (adr r4, 0x1e840)
@   0x0801e7de: 081e        lsrs	r6, r3, #32
@   0x0801e7e0: 8f84        ldrh	r4, [r0, #60]	@ 0x3c
@   0x0801e7e2: 0830        lsrs	r0, r6, #32
@   0x0801e7e4: 3480        adds	r4, #128	@ 0x80
@   0x0801e7e6: 0300        lsls	r0, r0, #12
@   0x0801e7e8: 34a0        adds	r4, #160	@ 0xa0
@   0x0801e7ea: 0300        lsls	r0, r0, #12
@   0x0801e7ec: 00d4        lsls	r4, r2, #3
@   0x0801e7ee: 0400        lsls	r0, r0, #16
@   0x0801e7f0: e800        0600 			@ <UNDEFINED> instruction: 0xe8000600
@   0x0801e7f4: 0400        lsls	r0, r0, #16
@   0x0801e7f6: 8000        strh	r0, [r0, #0]
@   0x0801e7f8: b510        push	{r4, lr}
@   0x0801e7fa: f7e1        fe63 	bl	0x4c4
@   0x0801e7fe: 4906        ldr	r1, [pc, #24]	@ (0x1e818)
@   0x0801e800: 8008        strh	r0, [r1, #0]
@   0x0801e802: 8808        ldrh	r0, [r1, #0]
@   0x0801e804: 2804        cmp	r0, #4
@   0x0801e806: d033        beq.n	0x1e870
@   0x0801e808: 2804        cmp	r0, #4
@   0x0801e80a: dc07        bgt.n	0x1e81c
@   0x0801e80c: 2801        cmp	r0, #1
@   0x0801e80e: d011        beq.n	0x1e834
@   0x0801e810: 2802        cmp	r0, #2
@   0x0801e812: d01e        beq.n	0x1e852
@   0x0801e814: e0c3        b.n	0x1e99e
@   0x0801e816: 0000        movs	r0, r0
@   0x0801e818: 5398        strh	r0, [r3, r6]
@   0x0801e81a: 0300        lsls	r0, r0, #12
@   0x0801e81c: 2810        cmp	r0, #16
@   0x0801e81e: d100        bne.n	0x1e822
@   0x0801e820: e0ae        b.n	0x1e980
@   0x0801e822: 2810        cmp	r0, #16
@   0x0801e824: dc02        bgt.n	0x1e82c
@   0x0801e826: 2808        cmp	r0, #8
@   0x0801e828: d064        beq.n	0x1e8f4
@   0x0801e82a: e0b8        b.n	0x1e99e
@   0x0801e82c: 2840        cmp	r0, #64	@ 0x40
@   0x0801e82e: d100        bne.n	0x1e832
@   0x0801e830: e0a6        b.n	0x1e980
@   0x0801e832: e0b4        b.n	0x1e99e
@   0x0801e834: 2002        movs	r0, #2
@   0x0801e836: f002        fa1f 	bl	0x20c78
@   0x0801e83a: 4903        ldr	r1, [pc, #12]	@ (0x1e848)
@   0x0801e83c: 7d08        ldrb	r0, [r1, #20]
@   0x0801e83e: 2800        cmp	r0, #0
@   0x0801e840: d104        bne.n	0x1e84c
@   0x0801e842: 2003        movs	r0, #3
@   0x0801e844: 7508        strb	r0, [r1, #20]
@   0x0801e846: e0aa        b.n	0x1e99e
@   0x0801e848: 3480        adds	r4, #128	@ 0x80
@   0x0801e84a: 0300        lsls	r0, r0, #12
@   0x0801e84c: 3801        subs	r0, #1
@   0x0801e84e: 7508        strb	r0, [r1, #20]
@   0x0801e850: e0a5        b.n	0x1e99e
@   0x0801e852: 2002        movs	r0, #2
@   0x0801e854: f002        fa10 	bl	0x20c78
@   0x0801e858: 4804        ldr	r0, [pc, #16]	@ (0x1e86c)
@   0x0801e85a: 7d01        ldrb	r1, [r0, #20]
@   0x0801e85c: 3101        adds	r1, #1
@   0x0801e85e: 7501        strb	r1, [r0, #20]
@   0x0801e860: 2103        movs	r1, #3
@   0x0801e862: 7d02        ldrb	r2, [r0, #20]
@   0x0801e864: 4011        ands	r1, r2
@   0x0801e866: 7501        strb	r1, [r0, #20]
@   0x0801e868: e099        b.n	0x1e99e
@   0x0801e86a: 0000        movs	r0, r0
@   0x0801e86c: 3480        adds	r4, #128	@ 0x80
@   0x0801e86e: 0300        lsls	r0, r0, #12
@   0x0801e870: 2002        movs	r0, #2
@   0x0801e872: f002        fa01 	bl	0x20c78
@   0x0801e876: 4804        ldr	r0, [pc, #16]	@ (0x1e888)
@   0x0801e878: 7d04        ldrb	r4, [r0, #20]
@   0x0801e87a: 2c01        cmp	r4, #1
@   0x0801e87c: d018        beq.n	0x1e8b0
@   0x0801e87e: 2c01        cmp	r4, #1
@   0x0801e880: dc04        bgt.n	0x1e88c
@   0x0801e882: 2c00        cmp	r4, #0
@   0x0801e884: d007        beq.n	0x1e896
@   0x0801e886: e08a        b.n	0x1e99e
@   0x0801e888: 3480        adds	r4, #128	@ 0x80
@   0x0801e88a: 0300        lsls	r0, r0, #12
@   0x0801e88c: 2c02        cmp	r4, #2
@   0x0801e88e: d017        beq.n	0x1e8c0
@   0x0801e890: 2c03        cmp	r4, #3
@   0x0801e892: d023        beq.n	0x1e8dc
@   0x0801e894: e083        b.n	0x1e99e
@   0x0801e896: 4c05        ldr	r4, [pc, #20]	@ (0x1e8ac)
@   0x0801e898: 7820        ldrb	r0, [r4, #0]
@   0x0801e89a: 2801        cmp	r0, #1
@   0x0801e89c: d002        beq.n	0x1e8a4
@   0x0801e89e: 2014        movs	r0, #20
@   0x0801e8a0: f002        f9b8 	bl	0x20c14
@   0x0801e8a4: 2001        movs	r0, #1
@   0x0801e8a6: 7020        strb	r0, [r4, #0]
@   0x0801e8a8: e079        b.n	0x1e99e
@   0x0801e8aa: 0000        movs	r0, r0
@   0x0801e8ac: 34b4        adds	r4, #180	@ 0xb4
@   0x0801e8ae: 0300        lsls	r0, r0, #12
@   0x0801e8b0: f002        f9d2 	bl	0x20c58
@   0x0801e8b4: 4801        ldr	r0, [pc, #4]	@ (0x1e8bc)
@   0x0801e8b6: 7044        strb	r4, [r0, #1]
@   0x0801e8b8: e071        b.n	0x1e99e
@   0x0801e8ba: 0000        movs	r0, r0
@   0x0801e8bc: 34b4        adds	r4, #180	@ 0xb4
@   0x0801e8be: 0300        lsls	r0, r0, #12
@   0x0801e8c0: 4803        ldr	r0, [pc, #12]	@ (0x1e8d0)
@   0x0801e8c2: 7881        ldrb	r1, [r0, #2]
@   0x0801e8c4: 1c02        adds	r2, r0, #0
@   0x0801e8c6: 2905        cmp	r1, #5
@   0x0801e8c8: d004        beq.n	0x1e8d4
@   0x0801e8ca: 2909        cmp	r1, #9
@   0x0801e8cc: d004        beq.n	0x1e8d8
@   0x0801e8ce: e041        b.n	0x1e954
@   0x0801e8d0: 34b4        adds	r4, #180	@ 0xb4
@   0x0801e8d2: 0300        lsls	r0, r0, #12
@   0x0801e8d4: 2003        movs	r0, #3
@   0x0801e8d6: e03c        b.n	0x1e952
@   0x0801e8d8: 2005        movs	r0, #5
@   0x0801e8da: e03a        b.n	0x1e952
@   0x0801e8dc: 4903        ldr	r1, [pc, #12]	@ (0x1e8ec)
@   0x0801e8de: 78c8        ldrb	r0, [r1, #3]
@   0x0801e8e0: 2805        cmp	r0, #5
@   0x0801e8e2: d005        beq.n	0x1e8f0
@   0x0801e8e4: 2809        cmp	r0, #9
@   0x0801e8e6: d045        beq.n	0x1e974
@   0x0801e8e8: e059        b.n	0x1e99e
@   0x0801e8ea: 0000        movs	r0, r0
@   0x0801e8ec: 34b4        adds	r4, #180	@ 0xb4
@   0x0801e8ee: 0300        lsls	r0, r0, #12
@   0x0801e8f0: 70cc        strb	r4, [r1, #3]
@   0x0801e8f2: e054        b.n	0x1e99e
@   0x0801e8f4: 2002        movs	r0, #2
@   0x0801e8f6: f002        f9bf 	bl	0x20c78
@   0x0801e8fa: 4804        ldr	r0, [pc, #16]	@ (0x1e90c)
@   0x0801e8fc: 7d04        ldrb	r4, [r0, #20]
@   0x0801e8fe: 2c01        cmp	r4, #1
@   0x0801e900: d012        beq.n	0x1e928
@   0x0801e902: 2c01        cmp	r4, #1
@   0x0801e904: dc04        bgt.n	0x1e910
@   0x0801e906: 2c00        cmp	r4, #0
@   0x0801e908: d007        beq.n	0x1e91a
@   0x0801e90a: e048        b.n	0x1e99e
@   0x0801e90c: 3480        adds	r4, #128	@ 0x80
@   0x0801e90e: 0300        lsls	r0, r0, #12
@   0x0801e910: 2c02        cmp	r4, #2
@   0x0801e912: d011        beq.n	0x1e938
@   0x0801e914: 2c03        cmp	r4, #3
@   0x0801e916: d023        beq.n	0x1e960
@   0x0801e918: e041        b.n	0x1e99e
@   0x0801e91a: f002        f969 	bl	0x20bf0
@   0x0801e91e: 4801        ldr	r0, [pc, #4]	@ (0x1e924)
@   0x0801e920: 7004        strb	r4, [r0, #0]
@   0x0801e922: e03c        b.n	0x1e99e
@   0x0801e924: 34b4        adds	r4, #180	@ 0xb4
@   0x0801e926: 0300        lsls	r0, r0, #12
@   0x0801e928: f002        f988 	bl	0x20c3c
@   0x0801e92c: 4901        ldr	r1, [pc, #4]	@ (0x1e934)
@   0x0801e92e: 2000        movs	r0, #0
@   0x0801e930: 7048        strb	r0, [r1, #1]
@   0x0801e932: e034        b.n	0x1e99e
@   0x0801e934: 34b4        adds	r4, #180	@ 0xb4
@   0x0801e936: 0300        lsls	r0, r0, #12
@   0x0801e938: 4803        ldr	r0, [pc, #12]	@ (0x1e948)
@   0x0801e93a: 7881        ldrb	r1, [r0, #2]
@   0x0801e93c: 1c02        adds	r2, r0, #0
@   0x0801e93e: 2903        cmp	r1, #3
@   0x0801e940: d004        beq.n	0x1e94c
@   0x0801e942: 2905        cmp	r1, #5
@   0x0801e944: d004        beq.n	0x1e950
@   0x0801e946: e005        b.n	0x1e954
@   0x0801e948: 34b4        adds	r4, #180	@ 0xb4
@   0x0801e94a: 0300        lsls	r0, r0, #12
@   0x0801e94c: 2005        movs	r0, #5
@   0x0801e94e: e000        b.n	0x1e952
@   0x0801e950: 2009        movs	r0, #9
@   0x0801e952: 7090        strb	r0, [r2, #2]
@   0x0801e954: 4901        ldr	r1, [pc, #4]	@ (0x1e95c)
@   0x0801e956: 7890        ldrb	r0, [r2, #2]
@   0x0801e958: 7008        strb	r0, [r1, #0]
@   0x0801e95a: e020        b.n	0x1e99e
@   0x0801e95c: 35e0        adds	r5, #224	@ 0xe0
@   0x0801e95e: 0300        lsls	r0, r0, #12
@   0x0801e960: 4903        ldr	r1, [pc, #12]	@ (0x1e970)
@   0x0801e962: 78c8        ldrb	r0, [r1, #3]
@   0x0801e964: 2803        cmp	r0, #3
@   0x0801e966: d005        beq.n	0x1e974
@   0x0801e968: 2805        cmp	r0, #5
@   0x0801e96a: d006        beq.n	0x1e97a
@   0x0801e96c: e017        b.n	0x1e99e
@   0x0801e96e: 0000        movs	r0, r0
@   0x0801e970: 34b4        adds	r4, #180	@ 0xb4
@   0x0801e972: 0300        lsls	r0, r0, #12
@   0x0801e974: 2005        movs	r0, #5
@   0x0801e976: 70c8        strb	r0, [r1, #3]
@   0x0801e978: e011        b.n	0x1e99e
@   0x0801e97a: 2009        movs	r0, #9
@   0x0801e97c: 70c8        strb	r0, [r1, #3]
@   0x0801e97e: e00e        b.n	0x1e99e
@   0x0801e980: 2001        movs	r0, #1
@   0x0801e982: f002        f979 	bl	0x20c78
@   0x0801e986: 4910        ldr	r1, [pc, #64]	@ (0x1e9c8)
@   0x0801e988: 2000        movs	r0, #0
@   0x0801e98a: 6088        str	r0, [r1, #8]
@   0x0801e98c: 211d        movs	r1, #29
@   0x0801e98e: 2206        movs	r2, #6
@   0x0801e990: 2302        movs	r3, #2
@   0x0801e992: f7f9        fe59 	bl	0x18648
@   0x0801e996: 490d        ldr	r1, [pc, #52]	@ (0x1e9cc)
@   0x0801e998: 7888        ldrb	r0, [r1, #2]
@   0x0801e99a: 3001        adds	r0, #1
@   0x0801e99c: 7088        strb	r0, [r1, #2]
@   0x0801e99e: 480c        ldr	r0, [pc, #48]	@ (0x1e9d0)
@   0x0801e9a0: 8800        ldrh	r0, [r0, #0]
@   0x0801e9a2: 2820        cmp	r0, #32
@   0x0801e9a4: d116        bne.n	0x1e9d4
@   0x0801e9a6: 2000        movs	r0, #0
@   0x0801e9a8: f002        f966 	bl	0x20c78
@   0x0801e9ac: 4906        ldr	r1, [pc, #24]	@ (0x1e9c8)
@   0x0801e9ae: 2000        movs	r0, #0
@   0x0801e9b0: 6088        str	r0, [r1, #8]
@   0x0801e9b2: 211d        movs	r1, #29
@   0x0801e9b4: 2206        movs	r2, #6
@   0x0801e9b6: 2302        movs	r3, #2
@   0x0801e9b8: f7f9        fe46 	bl	0x18648
@   0x0801e9bc: 4903        ldr	r1, [pc, #12]	@ (0x1e9cc)
@   0x0801e9be: 7888        ldrb	r0, [r1, #2]
@   0x0801e9c0: 3001        adds	r0, #1
@   0x0801e9c2: 7088        strb	r0, [r1, #2]
@   0x0801e9c4: e016        b.n	0x1e9f4
@   0x0801e9c6: 0000        movs	r0, r0
@   0x0801e9c8: 34a0        adds	r4, #160	@ 0xa0
@   0x0801e9ca: 0300        lsls	r0, r0, #12
@   0x0801e9cc: 3480        adds	r4, #128	@ 0x80
@   0x0801e9ce: 0300        lsls	r0, r0, #12
@   0x0801e9d0: 5398        strh	r0, [r3, r6]
@   0x0801e9d2: 0300        lsls	r0, r0, #12
@   0x0801e9d4: 2800        cmp	r0, #0
@   0x0801e9d6: d006        beq.n	0x1e9e6
@   0x0801e9d8: 2810        cmp	r0, #16
@   0x0801e9da: d004        beq.n	0x1e9e6
@   0x0801e9dc: 2840        cmp	r0, #64	@ 0x40
@   0x0801e9de: d002        beq.n	0x1e9e6
@   0x0801e9e0: f000        f812 	bl	0x1ea08
@   0x0801e9e4: e006        b.n	0x1e9f4
@   0x0801e9e6: 4b06        ldr	r3, [pc, #24]	@ (0x1ea00)
@   0x0801e9e8: 6818        ldr	r0, [r3, #0]
@   0x0801e9ea: 6859        ldr	r1, [r3, #4]
@   0x0801e9ec: 689a        ldr	r2, [r3, #8]
@   0x0801e9ee: 68db        ldr	r3, [r3, #12]
@   0x0801e9f0: f7f9        fde6 	bl	0x185c0
@   0x0801e9f4: 4903        ldr	r1, [pc, #12]	@ (0x1ea04)
@   0x0801e9f6: 2000        movs	r0, #0
@   0x0801e9f8: 8008        strh	r0, [r1, #0]
@   0x0801e9fa: bc10        pop	{r4}
@   0x0801e9fc: bc01        pop	{r0}
@   0x0801e9fe: 4700        bx	r0
@   0x0801ea00: 8100        strh	r0, [r0, #8]
@   0x0801ea02: 0830        lsrs	r0, r6, #32
@   0x0801ea04: 5398        strh	r0, [r3, r6]
@   0x0801ea06: 0300        lsls	r0, r0, #12

        thumb_func_start sub_0801E28C
sub_0801E28C: @ 0x0801e28c
        .incbin "frog_us_baserom.gba", 0x1e28c, 0x77c
        thumb_func_end sub_0801E28C
