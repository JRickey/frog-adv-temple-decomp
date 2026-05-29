@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x080219bc, 0x08021cfc)  (832 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x80219bc --end 0x8021cfc --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x080219bc: b5f0        push	{r4, r5, r6, r7, lr}
@   0x080219be: 4647        mov	r7, r8
@   0x080219c0: b480        push	{r7}
@   0x080219c2: b081        sub	sp, #4
@   0x080219c4: 1c03        adds	r3, r0, #0
@   0x080219c6: 0609        lsls	r1, r1, #24
@   0x080219c8: 0e0e        lsrs	r6, r1, #24
@   0x080219ca: 7918        ldrb	r0, [r3, #4]
@   0x080219cc: 4684        mov	ip, r0
@   0x080219ce: 781f        ldrb	r7, [r3, #0]
@   0x080219d0: 490a        ldr	r1, [pc, #40]	@ (0x219fc)
@   0x080219d2: 00f0        lsls	r0, r6, #3
@   0x080219d4: 1b80        subs	r0, r0, r6
@   0x080219d6: 00c0        lsls	r0, r0, #3
@   0x080219d8: 1842        adds	r2, r0, r1
@   0x080219da: 1c10        adds	r0, r2, #0
@   0x080219dc: 3033        adds	r0, #51	@ 0x33
@   0x080219de: 7805        ldrb	r5, [r0, #0]
@   0x080219e0: 7e91        ldrb	r1, [r2, #26]
@   0x080219e2: 4688        mov	r8, r1
@   0x080219e4: 2002        movs	r0, #2
@   0x080219e6: 8e94        ldrh	r4, [r2, #52]	@ 0x34
@   0x080219e8: 4020        ands	r0, r4
@   0x080219ea: 2800        cmp	r0, #0
@   0x080219ec: d151        bne.n	0x21a92
@   0x080219ee: 2902        cmp	r1, #2
@   0x080219f0: d019        beq.n	0x21a26
@   0x080219f2: 2902        cmp	r1, #2
@   0x080219f4: dc04        bgt.n	0x21a00
@   0x080219f6: 2901        cmp	r1, #1
@   0x080219f8: d008        beq.n	0x21a0c
@   0x080219fa: e04a        b.n	0x21a92
@   0x080219fc: 3720        adds	r7, #32
@   0x080219fe: 0300        lsls	r0, r0, #12
@   0x08021a00: 4640        mov	r0, r8
@   0x08021a02: 2803        cmp	r0, #3
@   0x08021a04: d01c        beq.n	0x21a40
@   0x08021a06: 2804        cmp	r0, #4
@   0x08021a08: d02f        beq.n	0x21a6a
@   0x08021a0a: e042        b.n	0x21a92
@   0x08021a0c: 00e8        lsls	r0, r5, #3
@   0x08021a0e: 18c0        adds	r0, r0, r3
@   0x08021a10: 8851        ldrh	r1, [r2, #2]
@   0x08021a12: 8804        ldrh	r4, [r0, #0]
@   0x08021a14: 42a1        cmp	r1, r4
@   0x08021a16: d13c        bne.n	0x21a92
@   0x08021a18: 2404        movs	r4, #4
@   0x08021a1a: 5f11        ldrsh	r1, [r2, r4]
@   0x08021a1c: 2202        movs	r2, #2
@   0x08021a1e: 5e80        ldrsh	r0, [r0, r2]
@   0x08021a20: 4281        cmp	r1, r0
@   0x08021a22: dc36        bgt.n	0x21a92
@   0x08021a24: e019        b.n	0x21a5a
@   0x08021a26: 00e8        lsls	r0, r5, #3
@   0x08021a28: 18c0        adds	r0, r0, r3
@   0x08021a2a: 8854        ldrh	r4, [r2, #2]
@   0x08021a2c: 8801        ldrh	r1, [r0, #0]
@   0x08021a2e: 428c        cmp	r4, r1
@   0x08021a30: d12f        bne.n	0x21a92
@   0x08021a32: 2404        movs	r4, #4
@   0x08021a34: 5f11        ldrsh	r1, [r2, r4]
@   0x08021a36: 2202        movs	r2, #2
@   0x08021a38: 5e80        ldrsh	r0, [r0, r2]
@   0x08021a3a: 4281        cmp	r1, r0
@   0x08021a3c: db29        blt.n	0x21a92
@   0x08021a3e: e00c        b.n	0x21a5a
@   0x08021a40: 00e8        lsls	r0, r5, #3
@   0x08021a42: 18c4        adds	r4, r0, r3
@   0x08021a44: 2102        movs	r1, #2
@   0x08021a46: 5e50        ldrsh	r0, [r2, r1]
@   0x08021a48: 4680        mov	r8, r0
@   0x08021a4a: 2100        movs	r1, #0
@   0x08021a4c: 5e60        ldrsh	r0, [r4, r1]
@   0x08021a4e: 4580        cmp	r8, r0
@   0x08021a50: dc1f        bgt.n	0x21a92
@   0x08021a52: 8892        ldrh	r2, [r2, #4]
@   0x08021a54: 8864        ldrh	r4, [r4, #2]
@   0x08021a56: 42a2        cmp	r2, r4
@   0x08021a58: d11b        bne.n	0x21a92
@   0x08021a5a: 9700        str	r7, [sp, #0]
@   0x08021a5c: 1c18        adds	r0, r3, #0
@   0x08021a5e: 1c31        adds	r1, r6, #0
@   0x08021a60: 4662        mov	r2, ip
@   0x08021a62: 1c2b        adds	r3, r5, #0
@   0x08021a64: f7ff        fee8 	bl	0x21838
@   0x08021a68: e013        b.n	0x21a92
@   0x08021a6a: 00e8        lsls	r0, r5, #3
@   0x08021a6c: 18c4        adds	r4, r0, r3
@   0x08021a6e: 2102        movs	r1, #2
@   0x08021a70: 5e50        ldrsh	r0, [r2, r1]
@   0x08021a72: 4680        mov	r8, r0
@   0x08021a74: 2100        movs	r1, #0
@   0x08021a76: 5e60        ldrsh	r0, [r4, r1]
@   0x08021a78: 4580        cmp	r8, r0
@   0x08021a7a: db0a        blt.n	0x21a92
@   0x08021a7c: 8892        ldrh	r2, [r2, #4]
@   0x08021a7e: 8864        ldrh	r4, [r4, #2]
@   0x08021a80: 42a2        cmp	r2, r4
@   0x08021a82: d106        bne.n	0x21a92
@   0x08021a84: 9700        str	r7, [sp, #0]
@   0x08021a86: 1c18        adds	r0, r3, #0
@   0x08021a88: 1c31        adds	r1, r6, #0
@   0x08021a8a: 4662        mov	r2, ip
@   0x08021a8c: 1c2b        adds	r3, r5, #0
@   0x08021a8e: f7ff        fed3 	bl	0x21838
@   0x08021a92: 480b        ldr	r0, [pc, #44]	@ (0x21ac0)
@   0x08021a94: 00f1        lsls	r1, r6, #3
@   0x08021a96: 1b89        subs	r1, r1, r6
@   0x08021a98: 00c9        lsls	r1, r1, #3
@   0x08021a9a: 180a        adds	r2, r1, r0
@   0x08021a9c: 8e91        ldrh	r1, [r2, #52]	@ 0x34
@   0x08021a9e: 2080        movs	r0, #128	@ 0x80
@   0x08021aa0: 0200        lsls	r0, r0, #8
@   0x08021aa2: 4008        ands	r0, r1
@   0x08021aa4: 2800        cmp	r0, #0
@   0x08021aa6: d004        beq.n	0x21ab2
@   0x08021aa8: 2002        movs	r0, #2
@   0x08021aaa: 4308        orrs	r0, r1
@   0x08021aac: 4905        ldr	r1, [pc, #20]	@ (0x21ac4)
@   0x08021aae: 4008        ands	r0, r1
@   0x08021ab0: 8690        strh	r0, [r2, #52]	@ 0x34
@   0x08021ab2: b001        add	sp, #4
@   0x08021ab4: bc08        pop	{r3}
@   0x08021ab6: 4698        mov	r8, r3
@   0x08021ab8: bcf0        pop	{r4, r5, r6, r7}
@   0x08021aba: bc01        pop	{r0}
@   0x08021abc: 4700        bx	r0
@   0x08021abe: 0000        movs	r0, r0
@   0x08021ac0: 3720        adds	r7, #32
@   0x08021ac2: 0300        lsls	r0, r0, #12
@   0x08021ac4: 7fff        ldrb	r7, [r7, #31]
@   0x08021ac6: 0000        movs	r0, r0
@   0x08021ac8: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08021aca: 4657        mov	r7, sl
@   0x08021acc: 464e        mov	r6, r9
@   0x08021ace: 4645        mov	r5, r8
@   0x08021ad0: b4e0        push	{r5, r6, r7}
@   0x08021ad2: b086        sub	sp, #24
@   0x08021ad4: 9b0e        ldr	r3, [sp, #56]	@ 0x38
@   0x08021ad6: 0600        lsls	r0, r0, #24
@   0x08021ad8: 0e00        lsrs	r0, r0, #24
@   0x08021ada: 9000        str	r0, [sp, #0]
@   0x08021adc: 0609        lsls	r1, r1, #24
@   0x08021ade: 0e09        lsrs	r1, r1, #24
@   0x08021ae0: 468a        mov	sl, r1
@   0x08021ae2: 0612        lsls	r2, r2, #24
@   0x08021ae4: 0e12        lsrs	r2, r2, #24
@   0x08021ae6: 9201        str	r2, [sp, #4]
@   0x08021ae8: 061b        lsls	r3, r3, #24
@   0x08021aea: 0e1b        lsrs	r3, r3, #24
@   0x08021aec: 9302        str	r3, [sp, #8]
@   0x08021aee: 4e80        ldr	r6, [pc, #512]	@ (0x21cf0)
@   0x08021af0: 4650        mov	r0, sl
@   0x08021af2: 00c0        lsls	r0, r0, #3
@   0x08021af4: 4681        mov	r9, r0
@   0x08021af6: 1a44        subs	r4, r0, r1
@   0x08021af8: 00e4        lsls	r4, r4, #3
@   0x08021afa: 19a5        adds	r5, r4, r6
@   0x08021afc: 886a        ldrh	r2, [r5, #2]
@   0x08021afe: 9203        str	r2, [sp, #12]
@   0x08021b00: 88ab        ldrh	r3, [r5, #4]
@   0x08021b02: 9304        str	r3, [sp, #16]
@   0x08021b04: f7de        fefc 	bl	0x900
@   0x08021b08: 1c31        adds	r1, r6, #0
@   0x08021b0a: 3120        adds	r1, #32
@   0x08021b0c: 1864        adds	r4, r4, r1
@   0x08021b0e: 6821        ldr	r1, [r4, #0]
@   0x08021b10: 1a40        subs	r0, r0, r1
@   0x08021b12: 281d        cmp	r0, #29
@   0x08021b14: d800        bhi.n	0x21b18
@   0x08021b16: e0e2        b.n	0x21cde
@   0x08021b18: 8a28        ldrh	r0, [r5, #16]
@   0x08021b1a: 28ff        cmp	r0, #255	@ 0xff
@   0x08021b1c: d101        bne.n	0x21b22
@   0x08021b1e: 2000        movs	r0, #0
@   0x08021b20: 8228        strh	r0, [r5, #16]
@   0x08021b22: 8a29        ldrh	r1, [r5, #16]
@   0x08021b24: 9a02        ldr	r2, [sp, #8]
@   0x08021b26: 1888        adds	r0, r1, r2
@   0x08021b28: 8228        strh	r0, [r5, #16]
@   0x08021b2a: 0400        lsls	r0, r0, #16
@   0x08021b2c: 1400        asrs	r0, r0, #16
@   0x08021b2e: 28ff        cmp	r0, #255	@ 0xff
@   0x08021b30: dd01        ble.n	0x21b36
@   0x08021b32: 20ff        movs	r0, #255	@ 0xff
@   0x08021b34: 8228        strh	r0, [r5, #16]
@   0x08021b36: 00f8        lsls	r0, r7, #3
@   0x08021b38: 1bc0        subs	r0, r0, r7
@   0x08021b3a: 00c0        lsls	r0, r0, #3
@   0x08021b3c: 1980        adds	r0, r0, r6
@   0x08021b3e: 2310        movs	r3, #16
@   0x08021b40: 5ec0        ldrsh	r0, [r0, r3]
@   0x08021b42: 3840        subs	r0, #64	@ 0x40
@   0x08021b44: 7e2d        ldrb	r5, [r5, #24]
@   0x08021b46: 086d        lsrs	r5, r5, #1
@   0x08021b48: 46a8        mov	r8, r5
@   0x08021b4a: 4657        mov	r7, sl
@   0x08021b4c: 4648        mov	r0, r9
@   0x08021b4e: 9005        str	r0, [sp, #20]
@   0x08021b50: 9901        ldr	r1, [sp, #4]
@   0x08021b52: 458a        cmp	sl, r1
@   0x08021b54: d85a        bhi.n	0x21c0c
@   0x08021b56: 4557        cmp	r7, sl
@   0x08021b58: d052        beq.n	0x21c00
@   0x08021b5a: 4a65        ldr	r2, [pc, #404]	@ (0x21cf0)
@   0x08021b5c: 4691        mov	r9, r2
@   0x08021b5e: 00f8        lsls	r0, r7, #3
@   0x08021b60: 1bc0        subs	r0, r0, r7
@   0x08021b62: 00c0        lsls	r0, r0, #3
@   0x08021b64: 1886        adds	r6, r0, r2
@   0x08021b66: 7e33        ldrb	r3, [r6, #24]
@   0x08021b68: 0858        lsrs	r0, r3, #1
@   0x08021b6a: 4440        add	r0, r8
@   0x08021b6c: 0600        lsls	r0, r0, #24
@   0x08021b6e: 0e00        lsrs	r0, r0, #24
@   0x08021b70: 4680        mov	r8, r0
@   0x08021b72: 8a30        ldrh	r0, [r6, #16]
@   0x08021b74: 28ff        cmp	r0, #255	@ 0xff
@   0x08021b76: d101        bne.n	0x21b7c
@   0x08021b78: 2000        movs	r0, #0
@   0x08021b7a: 8230        strh	r0, [r6, #16]
@   0x08021b7c: 8a31        ldrh	r1, [r6, #16]
@   0x08021b7e: 9a02        ldr	r2, [sp, #8]
@   0x08021b80: 1888        adds	r0, r1, r2
@   0x08021b82: 8230        strh	r0, [r6, #16]
@   0x08021b84: 0400        lsls	r0, r0, #16
@   0x08021b86: 1400        asrs	r0, r0, #16
@   0x08021b88: 28ff        cmp	r0, #255	@ 0xff
@   0x08021b8a: dd01        ble.n	0x21b90
@   0x08021b8c: 20ff        movs	r0, #255	@ 0xff
@   0x08021b8e: 8230        strh	r0, [r6, #16]
@   0x08021b90: 8a34        ldrh	r4, [r6, #16]
@   0x08021b92: 2310        movs	r3, #16
@   0x08021b94: 5ef0        ldrsh	r0, [r6, r3]
@   0x08021b96: 3840        subs	r0, #64	@ 0x40
@   0x08021b98: 2800        cmp	r0, #0
@   0x08021b9a: da03        bge.n	0x21ba4
@   0x08021b9c: 1c20        adds	r0, r4, #0
@   0x08021b9e: 30ff        adds	r0, #255	@ 0xff
@   0x08021ba0: 0400        lsls	r0, r0, #16
@   0x08021ba2: 0c04        lsrs	r4, r0, #16
@   0x08021ba4: 0424        lsls	r4, r4, #16
@   0x08021ba6: 1424        asrs	r4, r4, #16
@   0x08021ba8: 0060        lsls	r0, r4, #1
@   0x08021baa: 4952        ldr	r1, [pc, #328]	@ (0x21cf4)
@   0x08021bac: 1840        adds	r0, r0, r1
@   0x08021bae: 2200        movs	r2, #0
@   0x08021bb0: 5e80        ldrsh	r0, [r0, r2]
@   0x08021bb2: 4643        mov	r3, r8
@   0x08021bb4: 061d        lsls	r5, r3, #24
@   0x08021bb6: 142d        asrs	r5, r5, #16
@   0x08021bb8: 1c29        adds	r1, r5, #0
@   0x08021bba: f7ec        fa2b 	bl	0xe014
@   0x08021bbe: 9a03        ldr	r2, [sp, #12]
@   0x08021bc0: 0411        lsls	r1, r2, #16
@   0x08021bc2: 1409        asrs	r1, r1, #16
@   0x08021bc4: 1a09        subs	r1, r1, r0
@   0x08021bc6: 8071        strh	r1, [r6, #2]
@   0x08021bc8: 3c40        subs	r4, #64	@ 0x40
@   0x08021bca: 0064        lsls	r4, r4, #1
@   0x08021bcc: 4b49        ldr	r3, [pc, #292]	@ (0x21cf4)
@   0x08021bce: 18e4        adds	r4, r4, r3
@   0x08021bd0: 2100        movs	r1, #0
@   0x08021bd2: 5e60        ldrsh	r0, [r4, r1]
@   0x08021bd4: 1c29        adds	r1, r5, #0
@   0x08021bd6: f7ec        fa1d 	bl	0xe014
@   0x08021bda: 9a04        ldr	r2, [sp, #16]
@   0x08021bdc: 0411        lsls	r1, r2, #16
@   0x08021bde: 1409        asrs	r1, r1, #16
@   0x08021be0: 1a09        subs	r1, r1, r0
@   0x08021be2: 80b1        strh	r1, [r6, #4]
@   0x08021be4: 4944        ldr	r1, [pc, #272]	@ (0x21cf8)
@   0x08021be6: 2002        movs	r0, #2
@   0x08021be8: 8a0b        ldrh	r3, [r1, #16]
@   0x08021bea: 4018        ands	r0, r3
@   0x08021bec: 2800        cmp	r0, #0
@   0x08021bee: d007        beq.n	0x21c00
@   0x08021bf0: 7b49        ldrb	r1, [r1, #13]
@   0x08021bf2: 428f        cmp	r7, r1
@   0x08021bf4: d104        bne.n	0x21c00
@   0x08021bf6: 8870        ldrh	r0, [r6, #2]
@   0x08021bf8: 4649        mov	r1, r9
@   0x08021bfa: 8048        strh	r0, [r1, #2]
@   0x08021bfc: 88b0        ldrh	r0, [r6, #4]
@   0x08021bfe: 8088        strh	r0, [r1, #4]
@   0x08021c00: 1c78        adds	r0, r7, #1
@   0x08021c02: 0600        lsls	r0, r0, #24
@   0x08021c04: 0e07        lsrs	r7, r0, #24
@   0x08021c06: 9a01        ldr	r2, [sp, #4]
@   0x08021c08: 4297        cmp	r7, r2
@   0x08021c0a: d9a4        bls.n	0x21b56
@   0x08021c0c: 4938        ldr	r1, [pc, #224]	@ (0x21cf0)
@   0x08021c0e: 9b05        ldr	r3, [sp, #20]
@   0x08021c10: 4652        mov	r2, sl
@   0x08021c12: 1a98        subs	r0, r3, r2
@   0x08021c14: 00c0        lsls	r0, r0, #3
@   0x08021c16: 1840        adds	r0, r0, r1
@   0x08021c18: 7e00        ldrb	r0, [r0, #24]
@   0x08021c1a: 0840        lsrs	r0, r0, #1
@   0x08021c1c: 4680        mov	r8, r0
@   0x08021c1e: 9f00        ldr	r7, [sp, #0]
@   0x08021c20: 1c3b        adds	r3, r7, #0
@   0x08021c22: 4553        cmp	r3, sl
@   0x08021c24: d257        bcs.n	0x21cd6
@   0x08021c26: 4689        mov	r9, r1
@   0x08021c28: 00f8        lsls	r0, r7, #3
@   0x08021c2a: 1bc0        subs	r0, r0, r7
@   0x08021c2c: 00c0        lsls	r0, r0, #3
@   0x08021c2e: 4649        mov	r1, r9
@   0x08021c30: 1846        adds	r6, r0, r1
@   0x08021c32: 7e32        ldrb	r2, [r6, #24]
@   0x08021c34: 0850        lsrs	r0, r2, #1
@   0x08021c36: 4440        add	r0, r8
@   0x08021c38: 0600        lsls	r0, r0, #24
@   0x08021c3a: 0e00        lsrs	r0, r0, #24
@   0x08021c3c: 4680        mov	r8, r0
@   0x08021c3e: 8a33        ldrh	r3, [r6, #16]
@   0x08021c40: 2bff        cmp	r3, #255	@ 0xff
@   0x08021c42: d101        bne.n	0x21c48
@   0x08021c44: 2000        movs	r0, #0
@   0x08021c46: 8230        strh	r0, [r6, #16]
@   0x08021c48: 8a31        ldrh	r1, [r6, #16]
@   0x08021c4a: 9a02        ldr	r2, [sp, #8]
@   0x08021c4c: 1888        adds	r0, r1, r2
@   0x08021c4e: 8230        strh	r0, [r6, #16]
@   0x08021c50: 0400        lsls	r0, r0, #16
@   0x08021c52: 1400        asrs	r0, r0, #16
@   0x08021c54: 28ff        cmp	r0, #255	@ 0xff
@   0x08021c56: dd01        ble.n	0x21c5c
@   0x08021c58: 20ff        movs	r0, #255	@ 0xff
@   0x08021c5a: 8230        strh	r0, [r6, #16]
@   0x08021c5c: 8a34        ldrh	r4, [r6, #16]
@   0x08021c5e: 2310        movs	r3, #16
@   0x08021c60: 5ef0        ldrsh	r0, [r6, r3]
@   0x08021c62: 3840        subs	r0, #64	@ 0x40
@   0x08021c64: 2800        cmp	r0, #0
@   0x08021c66: da03        bge.n	0x21c70
@   0x08021c68: 1c20        adds	r0, r4, #0
@   0x08021c6a: 30ff        adds	r0, #255	@ 0xff
@   0x08021c6c: 0400        lsls	r0, r0, #16
@   0x08021c6e: 0c04        lsrs	r4, r0, #16
@   0x08021c70: 0424        lsls	r4, r4, #16
@   0x08021c72: 1424        asrs	r4, r4, #16
@   0x08021c74: 0060        lsls	r0, r4, #1
@   0x08021c76: 491f        ldr	r1, [pc, #124]	@ (0x21cf4)
@   0x08021c78: 1840        adds	r0, r0, r1
@   0x08021c7a: 2200        movs	r2, #0
@   0x08021c7c: 5e80        ldrsh	r0, [r0, r2]
@   0x08021c7e: 4643        mov	r3, r8
@   0x08021c80: 061d        lsls	r5, r3, #24
@   0x08021c82: 142d        asrs	r5, r5, #16
@   0x08021c84: 1c29        adds	r1, r5, #0
@   0x08021c86: f7ec        f9c5 	bl	0xe014
@   0x08021c8a: 9a03        ldr	r2, [sp, #12]
@   0x08021c8c: 0411        lsls	r1, r2, #16
@   0x08021c8e: 1409        asrs	r1, r1, #16
@   0x08021c90: 1809        adds	r1, r1, r0
@   0x08021c92: 8071        strh	r1, [r6, #2]
@   0x08021c94: 3c40        subs	r4, #64	@ 0x40
@   0x08021c96: 0064        lsls	r4, r4, #1
@   0x08021c98: 4b16        ldr	r3, [pc, #88]	@ (0x21cf4)
@   0x08021c9a: 18e4        adds	r4, r4, r3
@   0x08021c9c: 2100        movs	r1, #0
@   0x08021c9e: 5e60        ldrsh	r0, [r4, r1]
@   0x08021ca0: 1c29        adds	r1, r5, #0
@   0x08021ca2: f7ec        f9b7 	bl	0xe014
@   0x08021ca6: 9a04        ldr	r2, [sp, #16]
@   0x08021ca8: 0411        lsls	r1, r2, #16
@   0x08021caa: 1409        asrs	r1, r1, #16
@   0x08021cac: 1809        adds	r1, r1, r0
@   0x08021cae: 80b1        strh	r1, [r6, #4]
@   0x08021cb0: 4911        ldr	r1, [pc, #68]	@ (0x21cf8)
@   0x08021cb2: 2002        movs	r0, #2
@   0x08021cb4: 8a0b        ldrh	r3, [r1, #16]
@   0x08021cb6: 4018        ands	r0, r3
@   0x08021cb8: 2800        cmp	r0, #0
@   0x08021cba: d007        beq.n	0x21ccc
@   0x08021cbc: 7b49        ldrb	r1, [r1, #13]
@   0x08021cbe: 428f        cmp	r7, r1
@   0x08021cc0: d104        bne.n	0x21ccc
@   0x08021cc2: 8870        ldrh	r0, [r6, #2]
@   0x08021cc4: 4649        mov	r1, r9
@   0x08021cc6: 8048        strh	r0, [r1, #2]
@   0x08021cc8: 88b0        ldrh	r0, [r6, #4]
@   0x08021cca: 8088        strh	r0, [r1, #4]
@   0x08021ccc: 1c78        adds	r0, r7, #1
@   0x08021cce: 0600        lsls	r0, r0, #24
@   0x08021cd0: 0e07        lsrs	r7, r0, #24
@   0x08021cd2: 4557        cmp	r7, sl
@   0x08021cd4: d3a8        bcc.n	0x21c28
@   0x08021cd6: 9800        ldr	r0, [sp, #0]
@   0x08021cd8: 9901        ldr	r1, [sp, #4]
@   0x08021cda: f7e4        f819 	bl	0x5d10
@   0x08021cde: b006        add	sp, #24
@   0x08021ce0: bc38        pop	{r3, r4, r5}
@   0x08021ce2: 4698        mov	r8, r3
@   0x08021ce4: 46a1        mov	r9, r4
@   0x08021ce6: 46aa        mov	sl, r5
@   0x08021ce8: bcf0        pop	{r4, r5, r6, r7}
@   0x08021cea: bc01        pop	{r0}
@   0x08021cec: 4700        bx	r0
@   0x08021cee: 0000        movs	r0, r0
@   0x08021cf0: 3720        adds	r7, #32
@   0x08021cf2: 0300        lsls	r0, r0, #12
@   0x08021cf4: 0ea8        lsrs	r0, r5, #26
@   0x08021cf6: 080c        lsrs	r4, r1, #32
@   0x08021cf8: 35e0        adds	r5, #224	@ 0xe0
@   0x08021cfa: 0300        lsls	r0, r0, #12

        thumb_func_start sub_080219BC
sub_080219BC: @ 0x080219bc
        .incbin "frog_us_baserom.gba", 0x219bc, 0x340
        thumb_func_end sub_080219BC
