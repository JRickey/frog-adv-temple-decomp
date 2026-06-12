@ Auto-emitted by tools/peel.py — do not hand-edit this header.
@ Range:  [0x080259c4, 0x08025cec)  (808 bytes, thumb mode)
@ Re-peel:  python3 tools/peel.py --start 0x80259c4 --end 0x8025cec --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080259c4: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080259c6: 4657        mov	r7, sl
@   0x080259c8: 464e        mov	r6, r9
@   0x080259ca: 4645        mov	r5, r8
@   0x080259cc: b4e0        push	{r5, r6, r7}
@   0x080259ce: 265f        movs	r6, #95	@ 0x5f
@   0x080259d0: 480f        ldr	r0, [pc, #60]	@ (0x25a10)
@   0x080259d2: 4682        mov	sl, r0
@   0x080259d4: 1c30        adds	r0, r6, #0
@   0x080259d6: 3858        subs	r0, #88	@ 0x58
@   0x080259d8: 0600        lsls	r0, r0, #24
@   0x080259da: 0e04        lsrs	r4, r0, #24
@   0x080259dc: 00f1        lsls	r1, r6, #3
@   0x080259de: 1b88        subs	r0, r1, r6
@   0x080259e0: 00c0        lsls	r0, r0, #3
@   0x080259e2: 4652        mov	r2, sl
@   0x080259e4: 1885        adds	r5, r0, r2
@   0x080259e6: 8eaa        ldrh	r2, [r5, #52]	@ 0x34
@   0x080259e8: 2080        movs	r0, #128	@ 0x80
@   0x080259ea: 0080        lsls	r0, r0, #2
@   0x080259ec: 4010        ands	r0, r2
@   0x080259ee: 4688        mov	r8, r1
@   0x080259f0: 2800        cmp	r0, #0
@   0x080259f2: d039        beq.n	0x25a68
@   0x080259f4: 4807        ldr	r0, [pc, #28]	@ (0x25a14)
@   0x080259f6: 7b40        ldrb	r0, [r0, #13]
@   0x080259f8: 4286        cmp	r6, r0
@   0x080259fa: d00f        beq.n	0x25a1c
@   0x080259fc: 7ea8        ldrb	r0, [r5, #26]
@   0x080259fe: 2800        cmp	r0, #0
@   0x08025a00: d10c        bne.n	0x25a1c
@   0x08025a02: 4b05        ldr	r3, [pc, #20]	@ (0x25a18)
@   0x08025a04: 1c18        adds	r0, r3, #0
@   0x08025a06: 4010        ands	r0, r2
@   0x08025a08: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x08025a0a: 1c37        adds	r7, r6, #0
@   0x08025a0c: 3f5f        subs	r7, #95	@ 0x5f
@   0x08025a0e: e047        b.n	0x25aa0
@   0x08025a10: 3720        adds	r7, #32
@   0x08025a12: 0300        lsls	r0, r0, #12
@   0x08025a14: 35e0        adds	r5, #224	@ 0xe0
@   0x08025a16: 0300        lsls	r0, r0, #12
@   0x08025a18: fdff        0000 			@ <UNDEFINED> instruction: 0xfdff0000
@   0x08025a1c: f7da        ff70 	bl	0x900
@   0x08025a20: 4b0e        ldr	r3, [pc, #56]	@ (0x25a5c)
@   0x08025a22: 00e1        lsls	r1, r4, #3
@   0x08025a24: 1b09        subs	r1, r1, r4
@   0x08025a26: 00c9        lsls	r1, r1, #3
@   0x08025a28: 1c1a        adds	r2, r3, #0
@   0x08025a2a: 322c        adds	r2, #44	@ 0x2c
@   0x08025a2c: 1889        adds	r1, r1, r2
@   0x08025a2e: 6809        ldr	r1, [r1, #0]
@   0x08025a30: 1a40        subs	r0, r0, r1
@   0x08025a32: 1c37        adds	r7, r6, #0
@   0x08025a34: 3f5f        subs	r7, #95	@ 0x5f
@   0x08025a36: 283b        cmp	r0, #59	@ 0x3b
@   0x08025a38: d932        bls.n	0x25aa0
@   0x08025a3a: 4641        mov	r1, r8
@   0x08025a3c: 1b88        subs	r0, r1, r6
@   0x08025a3e: 00c0        lsls	r0, r0, #3
@   0x08025a40: 18c0        adds	r0, r0, r3
@   0x08025a42: 4a07        ldr	r2, [pc, #28]	@ (0x25a60)
@   0x08025a44: 1c11        adds	r1, r2, #0
@   0x08025a46: 8e83        ldrh	r3, [r0, #52]	@ 0x34
@   0x08025a48: 4019        ands	r1, r3
@   0x08025a4a: 8681        strh	r1, [r0, #52]	@ 0x34
@   0x08025a4c: 063a        lsls	r2, r7, #24
@   0x08025a4e: 0e12        lsrs	r2, r2, #24
@   0x08025a50: 4804        ldr	r0, [pc, #16]	@ (0x25a64)
@   0x08025a52: 2103        movs	r1, #3
@   0x08025a54: f7e0        fdd4 	bl	0x6600
@   0x08025a58: e022        b.n	0x25aa0
@   0x08025a5a: 0000        movs	r0, r0
@   0x08025a5c: 3720        adds	r7, #32
@   0x08025a5e: 0300        lsls	r0, r0, #12
@   0x08025a60: fdff        0000 			@ <UNDEFINED> instruction: 0xfdff0000
@   0x08025a64: 6110        str	r0, [r2, #16]
@   0x08025a66: 0300        lsls	r0, r0, #12
@   0x08025a68: f7da        ff4a 	bl	0x900
@   0x08025a6c: 00e1        lsls	r1, r4, #3
@   0x08025a6e: 1b09        subs	r1, r1, r4
@   0x08025a70: 00c9        lsls	r1, r1, #3
@   0x08025a72: 4652        mov	r2, sl
@   0x08025a74: 322c        adds	r2, #44	@ 0x2c
@   0x08025a76: 1889        adds	r1, r1, r2
@   0x08025a78: 6008        str	r0, [r1, #0]
@   0x08025a7a: 4917        ldr	r1, [pc, #92]	@ (0x25ad8)
@   0x08025a7c: 2002        movs	r0, #2
@   0x08025a7e: 8a0a        ldrh	r2, [r1, #16]
@   0x08025a80: 4010        ands	r0, r2
@   0x08025a82: 1c37        adds	r7, r6, #0
@   0x08025a84: 3f5f        subs	r7, #95	@ 0x5f
@   0x08025a86: 2800        cmp	r0, #0
@   0x08025a88: d00a        beq.n	0x25aa0
@   0x08025a8a: 7b49        ldrb	r1, [r1, #13]
@   0x08025a8c: 428e        cmp	r6, r1
@   0x08025a8e: d107        bne.n	0x25aa0
@   0x08025a90: 7ea8        ldrb	r0, [r5, #26]
@   0x08025a92: 2800        cmp	r0, #0
@   0x08025a94: d104        bne.n	0x25aa0
@   0x08025a96: 2080        movs	r0, #128	@ 0x80
@   0x08025a98: 0080        lsls	r0, r0, #2
@   0x08025a9a: 8eab        ldrh	r3, [r5, #52]	@ 0x34
@   0x08025a9c: 4318        orrs	r0, r3
@   0x08025a9e: 86a8        strh	r0, [r5, #52]	@ 0x34
@   0x08025aa0: 4641        mov	r1, r8
@   0x08025aa2: 1b88        subs	r0, r1, r6
@   0x08025aa4: 00c0        lsls	r0, r0, #3
@   0x08025aa6: 4652        mov	r2, sl
@   0x08025aa8: 1884        adds	r4, r0, r2
@   0x08025aaa: 2003        movs	r0, #3
@   0x08025aac: 71a0        strb	r0, [r4, #6]
@   0x08025aae: 4b0b        ldr	r3, [pc, #44]	@ (0x25adc)
@   0x08025ab0: 4699        mov	r9, r3
@   0x08025ab2: 0638        lsls	r0, r7, #24
@   0x08025ab4: 0e05        lsrs	r5, r0, #24
@   0x08025ab6: 4648        mov	r0, r9
@   0x08025ab8: 2103        movs	r1, #3
@   0x08025aba: 1c2a        adds	r2, r5, #0
@   0x08025abc: f7e0        fe6e 	bl	0x679c
@   0x08025ac0: 0600        lsls	r0, r0, #24
@   0x08025ac2: 2800        cmp	r0, #0
@   0x08025ac4: d100        bne.n	0x25ac8
@   0x08025ac6: e0f7        b.n	0x25cb8
@   0x08025ac8: 7ea0        ldrb	r0, [r4, #26]
@   0x08025aca: 2801        cmp	r0, #1
@   0x08025acc: d054        beq.n	0x25b78
@   0x08025ace: 2801        cmp	r0, #1
@   0x08025ad0: dc06        bgt.n	0x25ae0
@   0x08025ad2: 2800        cmp	r0, #0
@   0x08025ad4: d00a        beq.n	0x25aec
@   0x08025ad6: e0ef        b.n	0x25cb8
@   0x08025ad8: 35e0        adds	r5, #224	@ 0xe0
@   0x08025ada: 0300        lsls	r0, r0, #12
@   0x08025adc: 6110        str	r0, [r2, #16]
@   0x08025ade: 0300        lsls	r0, r0, #12
@   0x08025ae0: 2802        cmp	r0, #2
@   0x08025ae2: d100        bne.n	0x25ae6
@   0x08025ae4: e096        b.n	0x25c14
@   0x08025ae6: 2803        cmp	r0, #3
@   0x08025ae8: d020        beq.n	0x25b2c
@   0x08025aea: e0e5        b.n	0x25cb8
@   0x08025aec: 4a0e        ldr	r2, [pc, #56]	@ (0x25b28)
@   0x08025aee: 8a11        ldrh	r1, [r2, #16]
@   0x08025af0: 2302        movs	r3, #2
@   0x08025af2: 2702        movs	r7, #2
@   0x08025af4: 1c38        adds	r0, r7, #0
@   0x08025af6: 4008        ands	r0, r1
@   0x08025af8: 2800        cmp	r0, #0
@   0x08025afa: d100        bne.n	0x25afe
@   0x08025afc: e0dc        b.n	0x25cb8
@   0x08025afe: 7b50        ldrb	r0, [r2, #13]
@   0x08025b00: 4286        cmp	r6, r0
@   0x08025b02: d000        beq.n	0x25b06
@   0x08025b04: e0d8        b.n	0x25cb8
@   0x08025b06: 2001        movs	r0, #1
@   0x08025b08: 4308        orrs	r0, r1
@   0x08025b0a: 8210        strh	r0, [r2, #16]
@   0x08025b0c: 76a3        strb	r3, [r4, #26]
@   0x08025b0e: 4648        mov	r0, r9
@   0x08025b10: 2103        movs	r1, #3
@   0x08025b12: 1c2a        adds	r2, r5, #0
@   0x08025b14: f7e0        fd74 	bl	0x6600
@   0x08025b18: 86a7        strh	r7, [r4, #52]	@ 0x34
@   0x08025b1a: 1c20        adds	r0, r4, #0
@   0x08025b1c: 2104        movs	r1, #4
@   0x08025b1e: 2200        movs	r2, #0
@   0x08025b20: 2301        movs	r3, #1
@   0x08025b22: f7e4        fd2d 	bl	0xa580
@   0x08025b26: e0c7        b.n	0x25cb8
@   0x08025b28: 35e0        adds	r5, #224	@ 0xe0
@   0x08025b2a: 0300        lsls	r0, r0, #12
@   0x08025b2c: 4a10        ldr	r2, [pc, #64]	@ (0x25b70)
@   0x08025b2e: 8a11        ldrh	r1, [r2, #16]
@   0x08025b30: 2002        movs	r0, #2
@   0x08025b32: 4008        ands	r0, r1
@   0x08025b34: 2800        cmp	r0, #0
@   0x08025b36: d005        beq.n	0x25b44
@   0x08025b38: 7b53        ldrb	r3, [r2, #13]
@   0x08025b3a: 429e        cmp	r6, r3
@   0x08025b3c: d102        bne.n	0x25b44
@   0x08025b3e: 2001        movs	r0, #1
@   0x08025b40: 4308        orrs	r0, r1
@   0x08025b42: 8210        strh	r0, [r2, #16]
@   0x08025b44: 4640        mov	r0, r8
@   0x08025b46: 1b84        subs	r4, r0, r6
@   0x08025b48: 00e4        lsls	r4, r4, #3
@   0x08025b4a: 4454        add	r4, sl
@   0x08025b4c: 2001        movs	r0, #1
@   0x08025b4e: 76a0        strb	r0, [r4, #26]
@   0x08025b50: 063a        lsls	r2, r7, #24
@   0x08025b52: 0e12        lsrs	r2, r2, #24
@   0x08025b54: 4807        ldr	r0, [pc, #28]	@ (0x25b74)
@   0x08025b56: 2103        movs	r1, #3
@   0x08025b58: f7e0        fd52 	bl	0x6600
@   0x08025b5c: 2102        movs	r1, #2
@   0x08025b5e: 86a1        strh	r1, [r4, #52]	@ 0x34
@   0x08025b60: 1c20        adds	r0, r4, #0
@   0x08025b62: 2104        movs	r1, #4
@   0x08025b64: 2200        movs	r2, #0
@   0x08025b66: 2301        movs	r3, #1
@   0x08025b68: 425b        negs	r3, r3
@   0x08025b6a: f7e4        fd09 	bl	0xa580
@   0x08025b6e: e0a3        b.n	0x25cb8
@   0x08025b70: 35e0        adds	r5, #224	@ 0xe0
@   0x08025b72: 0300        lsls	r0, r0, #12
@   0x08025b74: 6110        str	r0, [r2, #16]
@   0x08025b76: 0300        lsls	r0, r0, #12
@   0x08025b78: 1c30        adds	r0, r6, #0
@   0x08025b7a: f7fb        f9df 	bl	0x20f3c
@   0x08025b7e: 4921        ldr	r1, [pc, #132]	@ (0x25c04)
@   0x08025b80: 2002        movs	r0, #2
@   0x08025b82: 8a0a        ldrh	r2, [r1, #16]
@   0x08025b84: 4010        ands	r0, r2
@   0x08025b86: 2800        cmp	r0, #0
@   0x08025b88: d002        beq.n	0x25b90
@   0x08025b8a: 7b49        ldrb	r1, [r1, #13]
@   0x08025b8c: 428e        cmp	r6, r1
@   0x08025b8e: d001        beq.n	0x25b94
@   0x08025b90: 2300        movs	r3, #0
@   0x08025b92: 71a3        strb	r3, [r4, #6]
@   0x08025b94: 4a1c        ldr	r2, [pc, #112]	@ (0x25c08)
@   0x08025b96: 2e5f        cmp	r6, #95	@ 0x5f
@   0x08025b98: d109        bne.n	0x25bae
@   0x08025b9a: 4640        mov	r0, r8
@   0x08025b9c: 385f        subs	r0, #95	@ 0x5f
@   0x08025b9e: 00c0        lsls	r0, r0, #3
@   0x08025ba0: 4450        add	r0, sl
@   0x08025ba2: 2304        movs	r3, #4
@   0x08025ba4: 5ec1        ldrsh	r1, [r0, r3]
@   0x08025ba6: 20f6        movs	r0, #246	@ 0xf6
@   0x08025ba8: 0040        lsls	r0, r0, #1
@   0x08025baa: 4281        cmp	r1, r0
@   0x08025bac: dd09        ble.n	0x25bc2
@   0x08025bae: 2e60        cmp	r6, #96	@ 0x60
@   0x08025bb0: d16e        bne.n	0x25c90
@   0x08025bb2: 4640        mov	r0, r8
@   0x08025bb4: 3860        subs	r0, #96	@ 0x60
@   0x08025bb6: 00c0        lsls	r0, r0, #3
@   0x08025bb8: 1810        adds	r0, r2, r0
@   0x08025bba: 2104        movs	r1, #4
@   0x08025bbc: 5e40        ldrsh	r0, [r0, r1]
@   0x08025bbe: 28b4        cmp	r0, #180	@ 0xb4
@   0x08025bc0: dc66        bgt.n	0x25c90
@   0x08025bc2: 4643        mov	r3, r8
@   0x08025bc4: 1b9a        subs	r2, r3, r6
@   0x08025bc6: 00d2        lsls	r2, r2, #3
@   0x08025bc8: 4452        add	r2, sl
@   0x08025bca: 2400        movs	r4, #0
@   0x08025bcc: 7694        strb	r4, [r2, #26]
@   0x08025bce: 2002        movs	r0, #2
@   0x08025bd0: 8e91        ldrh	r1, [r2, #52]	@ 0x34
@   0x08025bd2: 4308        orrs	r0, r1
@   0x08025bd4: 4320        orrs	r0, r4
@   0x08025bd6: 4b0d        ldr	r3, [pc, #52]	@ (0x25c0c)
@   0x08025bd8: 1c19        adds	r1, r3, #0
@   0x08025bda: 4008        ands	r0, r1
@   0x08025bdc: 2180        movs	r1, #128	@ 0x80
@   0x08025bde: 0089        lsls	r1, r1, #2
@   0x08025be0: 4308        orrs	r0, r1
@   0x08025be2: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x08025be4: 063a        lsls	r2, r7, #24
@   0x08025be6: 0e12        lsrs	r2, r2, #24
@   0x08025be8: 4809        ldr	r0, [pc, #36]	@ (0x25c10)
@   0x08025bea: 2103        movs	r1, #3
@   0x08025bec: f7e0        fd6a 	bl	0x66c4
@   0x08025bf0: 4904        ldr	r1, [pc, #16]	@ (0x25c04)
@   0x08025bf2: 8a0a        ldrh	r2, [r1, #16]
@   0x08025bf4: 2002        movs	r0, #2
@   0x08025bf6: 4010        ands	r0, r2
@   0x08025bf8: 2800        cmp	r0, #0
@   0x08025bfa: d040        beq.n	0x25c7e
@   0x08025bfc: 7b4b        ldrb	r3, [r1, #13]
@   0x08025bfe: 429e        cmp	r6, r3
@   0x08025c00: d13d        bne.n	0x25c7e
@   0x08025c02: e037        b.n	0x25c74
@   0x08025c04: 35e0        adds	r5, #224	@ 0xe0
@   0x08025c06: 0300        lsls	r0, r0, #12
@   0x08025c08: 3720        adds	r7, #32
@   0x08025c0a: 0300        lsls	r0, r0, #12
@   0x08025c0c: 7fff        ldrb	r7, [r7, #31]
@   0x08025c0e: 0000        movs	r0, r0
@   0x08025c10: 6110        str	r0, [r2, #16]
@   0x08025c12: 0300        lsls	r0, r0, #12
@   0x08025c14: 1c30        adds	r0, r6, #0
@   0x08025c16: f7fb        f991 	bl	0x20f3c
@   0x08025c1a: 2e5f        cmp	r6, #95	@ 0x5f
@   0x08025c1c: d105        bne.n	0x25c2a
@   0x08025c1e: 2004        movs	r0, #4
@   0x08025c20: 5e21        ldrsh	r1, [r4, r0]
@   0x08025c22: 2087        movs	r0, #135	@ 0x87
@   0x08025c24: 0080        lsls	r0, r0, #2
@   0x08025c26: 4281        cmp	r1, r0
@   0x08025c28: dc07        bgt.n	0x25c3a
@   0x08025c2a: 2e60        cmp	r6, #96	@ 0x60
@   0x08025c2c: d130        bne.n	0x25c90
@   0x08025c2e: 2204        movs	r2, #4
@   0x08025c30: 5ea1        ldrsh	r1, [r4, r2]
@   0x08025c32: 2096        movs	r0, #150	@ 0x96
@   0x08025c34: 0040        lsls	r0, r0, #1
@   0x08025c36: 4281        cmp	r1, r0
@   0x08025c38: dd2a        ble.n	0x25c90
@   0x08025c3a: 4643        mov	r3, r8
@   0x08025c3c: 1b99        subs	r1, r3, r6
@   0x08025c3e: 00c9        lsls	r1, r1, #3
@   0x08025c40: 4451        add	r1, sl
@   0x08025c42: 2400        movs	r4, #0
@   0x08025c44: 2003        movs	r0, #3
@   0x08025c46: 7688        strb	r0, [r1, #26]
@   0x08025c48: 2002        movs	r0, #2
@   0x08025c4a: 8e8a        ldrh	r2, [r1, #52]	@ 0x34
@   0x08025c4c: 4310        orrs	r0, r2
@   0x08025c4e: 2380        movs	r3, #128	@ 0x80
@   0x08025c50: 009b        lsls	r3, r3, #2
@   0x08025c52: 4318        orrs	r0, r3
@   0x08025c54: 8688        strh	r0, [r1, #52]	@ 0x34
@   0x08025c56: 063a        lsls	r2, r7, #24
@   0x08025c58: 0e12        lsrs	r2, r2, #24
@   0x08025c5a: 4821        ldr	r0, [pc, #132]	@ (0x25ce0)
@   0x08025c5c: 2103        movs	r1, #3
@   0x08025c5e: f7e0        fd31 	bl	0x66c4
@   0x08025c62: 4920        ldr	r1, [pc, #128]	@ (0x25ce4)
@   0x08025c64: 8a0a        ldrh	r2, [r1, #16]
@   0x08025c66: 2002        movs	r0, #2
@   0x08025c68: 4010        ands	r0, r2
@   0x08025c6a: 2800        cmp	r0, #0
@   0x08025c6c: d007        beq.n	0x25c7e
@   0x08025c6e: 7b48        ldrb	r0, [r1, #13]
@   0x08025c70: 4286        cmp	r6, r0
@   0x08025c72: d104        bne.n	0x25c7e
@   0x08025c74: 824c        strh	r4, [r1, #18]
@   0x08025c76: 4b1c        ldr	r3, [pc, #112]	@ (0x25ce8)
@   0x08025c78: 1c18        adds	r0, r3, #0
@   0x08025c7a: 4010        ands	r0, r2
@   0x08025c7c: 8208        strh	r0, [r1, #16]
@   0x08025c7e: 4641        mov	r1, r8
@   0x08025c80: 1b88        subs	r0, r1, r6
@   0x08025c82: 00c0        lsls	r0, r0, #3
@   0x08025c84: 4450        add	r0, sl
@   0x08025c86: 2100        movs	r1, #0
@   0x08025c88: 2200        movs	r2, #0
@   0x08025c8a: 2300        movs	r3, #0
@   0x08025c8c: f7e4        fc78 	bl	0xa580
@   0x08025c90: 4642        mov	r2, r8
@   0x08025c92: 1b90        subs	r0, r2, r6
@   0x08025c94: 00c0        lsls	r0, r0, #3
@   0x08025c96: 4653        mov	r3, sl
@   0x08025c98: 18c2        adds	r2, r0, r3
@   0x08025c9a: 8e91        ldrh	r1, [r2, #52]	@ 0x34
@   0x08025c9c: 2380        movs	r3, #128	@ 0x80
@   0x08025c9e: 021b        lsls	r3, r3, #8
@   0x08025ca0: 1c18        adds	r0, r3, #0
@   0x08025ca2: 4008        ands	r0, r1
@   0x08025ca4: 2800        cmp	r0, #0
@   0x08025ca6: d007        beq.n	0x25cb8
@   0x08025ca8: 2002        movs	r0, #2
@   0x08025caa: 4308        orrs	r0, r1
@   0x08025cac: 2100        movs	r1, #0
@   0x08025cae: 4308        orrs	r0, r1
@   0x08025cb0: 3b01        subs	r3, #1
@   0x08025cb2: 1c19        adds	r1, r3, #0
@   0x08025cb4: 4008        ands	r0, r1
@   0x08025cb6: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x08025cb8: 4641        mov	r1, r8
@   0x08025cba: 1b88        subs	r0, r1, r6
@   0x08025cbc: 00c0        lsls	r0, r0, #3
@   0x08025cbe: 4450        add	r0, sl
@   0x08025cc0: f7df        fe80 	bl	0x59c4
@   0x08025cc4: 1c70        adds	r0, r6, #1
@   0x08025cc6: 0600        lsls	r0, r0, #24
@   0x08025cc8: 0e06        lsrs	r6, r0, #24
@   0x08025cca: 2e60        cmp	r6, #96	@ 0x60
@   0x08025ccc: d800        bhi.n	0x25cd0
@   0x08025cce: e681        b.n	0x259d4
@   0x08025cd0: bc38        pop	{r3, r4, r5}
@   0x08025cd2: 4698        mov	r8, r3
@   0x08025cd4: 46a1        mov	r9, r4
@   0x08025cd6: 46aa        mov	sl, r5
@   0x08025cd8: bcf0        pop	{r4, r5, r6, r7}
@   0x08025cda: bc01        pop	{r0}
@   0x08025cdc: 4700        bx	r0
@   0x08025cde: 0000        movs	r0, r0
@   0x08025ce0: 6110        str	r0, [r2, #16]
@   0x08025ce2: 0300        lsls	r0, r0, #12
@   0x08025ce4: 35e0        adds	r5, #224	@ 0xe0
@   0x08025ce6: 0300        lsls	r0, r0, #12
@   0x08025ce8: fffe        0000 	vaddl.u<illegal width 64>	q8, d14, d0

        thumb_func_start sub_080259C4
sub_080259C4: @ 0x080259c4
        .incbin "baserom.gba", 0x259c4, 0x328
        thumb_func_end sub_080259C4
