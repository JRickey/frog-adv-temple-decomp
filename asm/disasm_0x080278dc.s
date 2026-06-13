@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080278dc, 0x08027ac4)  (488 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80278dc --end 0x8027ac4 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080278dc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080278de: 4657        mov	r7, sl
@   0x080278e0: 464e        mov	r6, r9
@   0x080278e2: 4645        mov	r5, r8
@   0x080278e4: b4e0        push	{r5, r6, r7}
@   0x080278e6: b084        sub	sp, #16
@   0x080278e8: 2500        movs	r5, #0
@   0x080278ea: 4809        ldr	r0, [pc, #36]	@ (0x27910)
@   0x080278ec: 4681        mov	r9, r0
@   0x080278ee: 2180        movs	r1, #128	@ 0x80
@   0x080278f0: 0209        lsls	r1, r1, #8
@   0x080278f2: 4688        mov	r8, r1
@   0x080278f4: 1c29        adds	r1, r5, #0
@   0x080278f6: 3125        adds	r1, #37	@ 0x25
@   0x080278f8: 00c8        lsls	r0, r1, #3
@   0x080278fa: 1a40        subs	r0, r0, r1
@   0x080278fc: 00c0        lsls	r0, r0, #3
@   0x080278fe: 464a        mov	r2, r9
@   0x08027900: 1884        adds	r4, r0, r2
@   0x08027902: 7ea3        ldrb	r3, [r4, #26]
@   0x08027904: 1c0f        adds	r7, r1, #0
@   0x08027906: 2b01        cmp	r3, #1
@   0x08027908: d004        beq.n	0x27914
@   0x0802790a: 2b02        cmp	r3, #2
@   0x0802790c: d010        beq.n	0x27930
@   0x0802790e: e045        b.n	0x2799c
@   0x08027910: 3720        adds	r7, #32
@   0x08027912: 0300        lsls	r0, r0, #12
@   0x08027914: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08027916: 4640        mov	r0, r8
@   0x08027918: 4008        ands	r0, r1
@   0x0802791a: 2800        cmp	r0, #0
@   0x0802791c: d03e        beq.n	0x2799c
@   0x0802791e: 2002        movs	r0, #2
@   0x08027920: 4308        orrs	r0, r1
@   0x08027922: 4a02        ldr	r2, [pc, #8]	@ (0x2792c)
@   0x08027924: 1c11        adds	r1, r2, #0
@   0x08027926: 4008        ands	r0, r1
@   0x08027928: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x0802792a: e037        b.n	0x2799c
@   0x0802792c: 7fff        ldrb	r7, [r7, #31]
@   0x0802792e: 0000        movs	r0, r0
@   0x08027930: 4640        mov	r0, r8
@   0x08027932: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08027934: 4008        ands	r0, r1
@   0x08027936: 2800        cmp	r0, #0
@   0x08027938: d030        beq.n	0x2799c
@   0x0802793a: 1c28        adds	r0, r5, #0
@   0x0802793c: 3027        adds	r0, #39	@ 0x27
@   0x0802793e: 4a3a        ldr	r2, [pc, #232]	@ (0x27a28)
@   0x08027940: 00a9        lsls	r1, r5, #2
@   0x08027942: 1889        adds	r1, r1, r2
@   0x08027944: 6809        ldr	r1, [r1, #0]
@   0x08027946: 2601        movs	r6, #1
@   0x08027948: 1c2a        adds	r2, r5, #0
@   0x0802794a: 4032        ands	r2, r6
@   0x0802794c: 0112        lsls	r2, r2, #4
@   0x0802794e: 32c1        adds	r2, #193	@ 0xc1
@   0x08027950: 9200        str	r2, [sp, #0]
@   0x08027952: 2206        movs	r2, #6
@   0x08027954: 9201        str	r2, [sp, #4]
@   0x08027956: 2203        movs	r2, #3
@   0x08027958: 9202        str	r2, [sp, #8]
@   0x0802795a: 9303        str	r3, [sp, #12]
@   0x0802795c: 2210        movs	r2, #16
@   0x0802795e: 2342        movs	r3, #66	@ 0x42
@   0x08027960: f7f9        fb9e 	bl	0x210a0
@   0x08027964: 2d00        cmp	r5, #0
@   0x08027966: d10a        bne.n	0x2797e
@   0x08027968: 20a1        movs	r0, #161	@ 0xa1
@   0x0802796a: 9000        str	r0, [sp, #0]
@   0x0802796c: 2005        movs	r0, #5
@   0x0802796e: 9001        str	r0, [sp, #4]
@   0x08027970: 9502        str	r5, [sp, #8]
@   0x08027972: 2026        movs	r0, #38	@ 0x26
@   0x08027974: 492d        ldr	r1, [pc, #180]	@ (0x27a2c)
@   0x08027976: 2210        movs	r2, #16
@   0x08027978: 2340        movs	r3, #64	@ 0x40
@   0x0802797a: f7f9        fbe1 	bl	0x21140
@   0x0802797e: 76a6        strb	r6, [r4, #26]
@   0x08027980: 2002        movs	r0, #2
@   0x08027982: 8ea2        ldrh	r2, [r4, #52]	@ 0x34
@   0x08027984: 4310        orrs	r0, r2
@   0x08027986: 4a2a        ldr	r2, [pc, #168]	@ (0x27a30)
@   0x08027988: 1c11        adds	r1, r2, #0
@   0x0802798a: 4008        ands	r0, r1
@   0x0802798c: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x0802798e: 4829        ldr	r0, [pc, #164]	@ (0x27a34)
@   0x08027990: 4448        add	r0, r9
@   0x08027992: 2124        movs	r1, #36	@ 0x24
@   0x08027994: 2203        movs	r2, #3
@   0x08027996: 230a        movs	r3, #10
@   0x08027998: f7f9        f9a0 	bl	0x20cdc
@   0x0802799c: 4826        ldr	r0, [pc, #152]	@ (0x27a38)
@   0x0802799e: 1c39        adds	r1, r7, #0
@   0x080279a0: f7de        ffe4 	bl	0x696c
@   0x080279a4: 1c68        adds	r0, r5, #1
@   0x080279a6: 0600        lsls	r0, r0, #24
@   0x080279a8: 0e05        lsrs	r5, r0, #24
@   0x080279aa: 2d01        cmp	r5, #1
@   0x080279ac: d9a2        bls.n	0x278f4
@   0x080279ae: 2025        movs	r0, #37	@ 0x25
@   0x080279b0: 2126        movs	r1, #38	@ 0x26
@   0x080279b2: f7de        f9ad 	bl	0x5d10
@   0x080279b6: 2500        movs	r5, #0
@   0x080279b8: 4820        ldr	r0, [pc, #128]	@ (0x27a3c)
@   0x080279ba: 4680        mov	r8, r0
@   0x080279bc: 2108        movs	r1, #8
@   0x080279be: 468a        mov	sl, r1
@   0x080279c0: 4a1f        ldr	r2, [pc, #124]	@ (0x27a40)
@   0x080279c2: 4442        add	r2, r8
@   0x080279c4: 4691        mov	r9, r2
@   0x080279c6: 1c28        adds	r0, r5, #0
@   0x080279c8: 3027        adds	r0, #39	@ 0x27
@   0x080279ca: 00c1        lsls	r1, r0, #3
@   0x080279cc: 1a09        subs	r1, r1, r0
@   0x080279ce: 00c9        lsls	r1, r1, #3
@   0x080279d0: 4642        mov	r2, r8
@   0x080279d2: 188c        adds	r4, r1, r2
@   0x080279d4: 2108        movs	r1, #8
@   0x080279d6: 8ea2        ldrh	r2, [r4, #52]	@ 0x34
@   0x080279d8: 4011        ands	r1, r2
@   0x080279da: 1c06        adds	r6, r0, #0
@   0x080279dc: 00ef        lsls	r7, r5, #3
@   0x080279de: 2900        cmp	r1, #0
@   0x080279e0: d156        bne.n	0x27a90
@   0x080279e2: 2202        movs	r2, #2
@   0x080279e4: 75e2        strb	r2, [r4, #23]
@   0x080279e6: 2004        movs	r0, #4
@   0x080279e8: 5e21        ldrsh	r1, [r4, r0]
@   0x080279ea: 4816        ldr	r0, [pc, #88]	@ (0x27a44)
@   0x080279ec: 4281        cmp	r1, r0
@   0x080279ee: dd01        ble.n	0x279f4
@   0x080279f0: 2003        movs	r0, #3
@   0x080279f2: 75e0        strb	r0, [r4, #23]
@   0x080279f4: 7ea0        ldrb	r0, [r4, #26]
@   0x080279f6: 2801        cmp	r0, #1
@   0x080279f8: d126        bne.n	0x27a48
@   0x080279fa: 2180        movs	r1, #128	@ 0x80
@   0x080279fc: 0209        lsls	r1, r1, #8
@   0x080279fe: 1c08        adds	r0, r1, #0
@   0x08027a00: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08027a02: 4008        ands	r0, r1
@   0x08027a04: 2800        cmp	r0, #0
@   0x08027a06: d03f        beq.n	0x27a88
@   0x08027a08: 1c29        adds	r1, r5, #0
@   0x08027a0a: 3125        adds	r1, #37	@ 0x25
@   0x08027a0c: 00c8        lsls	r0, r1, #3
@   0x08027a0e: 1a40        subs	r0, r0, r1
@   0x08027a10: 00c0        lsls	r0, r0, #3
@   0x08027a12: 4440        add	r0, r8
@   0x08027a14: 7682        strb	r2, [r0, #26]
@   0x08027a16: 2102        movs	r1, #2
@   0x08027a18: 8e82        ldrh	r2, [r0, #52]	@ 0x34
@   0x08027a1a: 4311        orrs	r1, r2
@   0x08027a1c: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x08027a1e: 4650        mov	r0, sl
@   0x08027a20: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08027a22: 4308        orrs	r0, r1
@   0x08027a24: e02f        b.n	0x27a86
@   0x08027a26: 0000        movs	r0, r0
@   0x08027a28: 6dc8        ldr	r0, [r1, #92]	@ 0x5c
@   0x08027a2a: 0831        lsrs	r1, r6, #32
@   0x08027a2c: 68f0        ldr	r0, [r6, #12]
@   0x08027a2e: 0831        lsrs	r1, r6, #32
@   0x08027a30: 7fff        ldrb	r7, [r7, #31]
@   0x08027a32: 0000        movs	r0, r0
@   0x08027a34: 0818        lsrs	r0, r3, #32
@   0x08027a36: 0000        movs	r0, r0
@   0x08027a38: 6110        str	r0, [r2, #16]
@   0x08027a3a: 0300        lsls	r0, r0, #12
@   0x08027a3c: 3720        adds	r7, #32
@   0x08027a3e: 0300        lsls	r0, r0, #12
@   0x08027a40: 0888        lsrs	r0, r1, #2
@   0x08027a42: 0000        movs	r0, r0
@   0x08027a44: 019b        lsls	r3, r3, #6
@   0x08027a46: 0000        movs	r0, r0
@   0x08027a48: 2802        cmp	r0, #2
@   0x08027a4a: d11d        bne.n	0x27a88
@   0x08027a4c: 481b        ldr	r0, [pc, #108]	@ (0x27abc)
@   0x08027a4e: 4281        cmp	r1, r0
@   0x08027a50: dd0d        ble.n	0x27a6e
@   0x08027a52: 2001        movs	r0, #1
@   0x08027a54: 76a0        strb	r0, [r4, #26]
@   0x08027a56: 2002        movs	r0, #2
@   0x08027a58: 8ea2        ldrh	r2, [r4, #52]	@ 0x34
@   0x08027a5a: 4310        orrs	r0, r2
@   0x08027a5c: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x08027a5e: 1b78        subs	r0, r7, r5
@   0x08027a60: 00c0        lsls	r0, r0, #3
@   0x08027a62: 4448        add	r0, r9
@   0x08027a64: 2100        movs	r1, #0
@   0x08027a66: 2200        movs	r2, #0
@   0x08027a68: 2300        movs	r3, #0
@   0x08027a6a: f7e2        fd89 	bl	0xa580
@   0x08027a6e: 8ea1        ldrh	r1, [r4, #52]	@ 0x34
@   0x08027a70: 2280        movs	r2, #128	@ 0x80
@   0x08027a72: 0212        lsls	r2, r2, #8
@   0x08027a74: 1c10        adds	r0, r2, #0
@   0x08027a76: 4008        ands	r0, r1
@   0x08027a78: 2800        cmp	r0, #0
@   0x08027a7a: d005        beq.n	0x27a88
@   0x08027a7c: 2002        movs	r0, #2
@   0x08027a7e: 4308        orrs	r0, r1
@   0x08027a80: 3a01        subs	r2, #1
@   0x08027a82: 1c11        adds	r1, r2, #0
@   0x08027a84: 4008        ands	r0, r1
@   0x08027a86: 86a0        strh	r0, [r4, #52]	@ 0x34
@   0x08027a88: 480d        ldr	r0, [pc, #52]	@ (0x27ac0)
@   0x08027a8a: 1c31        adds	r1, r6, #0
@   0x08027a8c: f7de        ff6e 	bl	0x696c
@   0x08027a90: 0630        lsls	r0, r6, #24
@   0x08027a92: 0e00        lsrs	r0, r0, #24
@   0x08027a94: f7f9        fa52 	bl	0x20f3c
@   0x08027a98: 1b78        subs	r0, r7, r5
@   0x08027a9a: 00c0        lsls	r0, r0, #3
@   0x08027a9c: 4448        add	r0, r9
@   0x08027a9e: f7dd        ff91 	bl	0x59c4
@   0x08027aa2: 1c68        adds	r0, r5, #1
@   0x08027aa4: 0600        lsls	r0, r0, #24
@   0x08027aa6: 0e05        lsrs	r5, r0, #24
@   0x08027aa8: 2d01        cmp	r5, #1
@   0x08027aaa: d98c        bls.n	0x279c6
@   0x08027aac: b004        add	sp, #16
@   0x08027aae: bc38        pop	{r3, r4, r5}
@   0x08027ab0: 4698        mov	r8, r3
@   0x08027ab2: 46a1        mov	r9, r4
@   0x08027ab4: 46aa        mov	sl, r5
@   0x08027ab6: bcf0        pop	{r4, r5, r6, r7}
@   0x08027ab8: bc01        pop	{r0}
@   0x08027aba: 4700        bx	r0
@   0x08027abc: 01a5        lsls	r5, r4, #6
@   0x08027abe: 0000        movs	r0, r0
@   0x08027ac0: 6110        str	r0, [r2, #16]
@   0x08027ac2: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080278DC
sub_080278DC: @ 0x080278dc
        .incbin "baserom.gba", 0x278dc, 0x1e8
        thumb_func_end sub_080278DC
