@ Auto-emitted by tools/disasm/peel.py — do not hand-edit this header.
@ Range:  [0x08008a5c, 0x08008e84)  (1064 bytes, thumb mode)
@ Re-peel:  python3 tools/disasm/peel.py --start 0x8008a5c --end 0x8008e84 --mode thumb

        .include "asm/macros.inc"
        .syntax unified

@ Disassembly preview (the bytes come from the INCBIN below):
@   0x08008a5c: b5f0        push	{r4, r5, r6, r7, lr}
@   0x08008a5e: 4657        mov	r7, sl
@   0x08008a60: 464e        mov	r6, r9
@   0x08008a62: 4645        mov	r5, r8
@   0x08008a64: b4e0        push	{r5, r6, r7}
@   0x08008a66: b08b        sub	sp, #44	@ 0x2c
@   0x08008a68: 0600        lsls	r0, r0, #24
@   0x08008a6a: 0e00        lsrs	r0, r0, #24
@   0x08008a6c: 9006        str	r0, [sp, #24]
@   0x08008a6e: 0609        lsls	r1, r1, #24
@   0x08008a70: 0e09        lsrs	r1, r1, #24
@   0x08008a72: 4688        mov	r8, r1
@   0x08008a74: 0612        lsls	r2, r2, #24
@   0x08008a76: 0e17        lsrs	r7, r2, #24
@   0x08008a78: 4c13        ldr	r4, [pc, #76]	@ (0x8ac8)
@   0x08008a7a: 7e20        ldrb	r0, [r4, #24]
@   0x08008a7c: 7e61        ldrb	r1, [r4, #25]
@   0x08008a7e: 2308        movs	r3, #8
@   0x08008a80: 5ee2        ldrsh	r2, [r4, r3]
@   0x08008a82: 250a        movs	r5, #10
@   0x08008a84: 5f63        ldrsh	r3, [r4, r5]
@   0x08008a86: 9d06        ldr	r5, [sp, #24]
@   0x08008a88: 9500        str	r5, [sp, #0]
@   0x08008a8a: f003        ff75 	bl	0xc978
@   0x08008a8e: 7e20        ldrb	r0, [r4, #24]
@   0x08008a90: 7e61        ldrb	r1, [r4, #25]
@   0x08008a92: 2308        movs	r3, #8
@   0x08008a94: 5ee2        ldrsh	r2, [r4, r3]
@   0x08008a96: 250a        movs	r5, #10
@   0x08008a98: 5f63        ldrsh	r3, [r4, r5]
@   0x08008a9a: 9d06        ldr	r5, [sp, #24]
@   0x08008a9c: 9500        str	r5, [sp, #0]
@   0x08008a9e: f003        ff6b 	bl	0xc978
@   0x08008aa2: 0600        lsls	r0, r0, #24
@   0x08008aa4: 0e00        lsrs	r0, r0, #24
@   0x08008aa6: 1c26        adds	r6, r4, #0
@   0x08008aa8: 280a        cmp	r0, #10
@   0x08008aaa: d100        bne.n	0x8aae
@   0x08008aac: e1e1        b.n	0x8e72
@   0x08008aae: 9806        ldr	r0, [sp, #24]
@   0x08008ab0: 2810        cmp	r0, #16
@   0x08008ab2: d139        bne.n	0x8b28
@   0x08008ab4: 4805        ldr	r0, [pc, #20]	@ (0x8acc)
@   0x08008ab6: 7e80        ldrb	r0, [r0, #26]
@   0x08008ab8: 2801        cmp	r0, #1
@   0x08008aba: d01d        beq.n	0x8af8
@   0x08008abc: 2801        cmp	r0, #1
@   0x08008abe: dc07        bgt.n	0x8ad0
@   0x08008ac0: 2800        cmp	r0, #0
@   0x08008ac2: d00a        beq.n	0x8ada
@   0x08008ac4: e030        b.n	0x8b28
@   0x08008ac6: 0000        movs	r0, r0
@   0x08008ac8: 35e0        adds	r5, #224	@ 0xe0
@   0x08008aca: 0300        lsls	r0, r0, #12
@   0x08008acc: 3720        adds	r7, #32
@   0x08008ace: 0300        lsls	r0, r0, #12
@   0x08008ad0: 2802        cmp	r0, #2
@   0x08008ad2: d019        beq.n	0x8b08
@   0x08008ad4: 2803        cmp	r0, #3
@   0x08008ad6: d01f        beq.n	0x8b18
@   0x08008ad8: e026        b.n	0x8b28
@   0x08008ada: 7e30        ldrb	r0, [r6, #24]
@   0x08008adc: 7e71        ldrb	r1, [r6, #25]
@   0x08008ade: 2308        movs	r3, #8
@   0x08008ae0: 5ef2        ldrsh	r2, [r6, r3]
@   0x08008ae2: 240a        movs	r4, #10
@   0x08008ae4: 5f33        ldrsh	r3, [r6, r4]
@   0x08008ae6: 2401        movs	r4, #1
@   0x08008ae8: 9400        str	r4, [sp, #0]
@   0x08008aea: f003        ff45 	bl	0xc978
@   0x08008aee: 0600        lsls	r0, r0, #24
@   0x08008af0: 0e00        lsrs	r0, r0, #24
@   0x08008af2: 280a        cmp	r0, #10
@   0x08008af4: d118        bne.n	0x8b28
@   0x08008af6: e1bc        b.n	0x8e72
@   0x08008af8: 7e30        ldrb	r0, [r6, #24]
@   0x08008afa: 7e71        ldrb	r1, [r6, #25]
@   0x08008afc: 2508        movs	r5, #8
@   0x08008afe: 5f72        ldrsh	r2, [r6, r5]
@   0x08008b00: 240a        movs	r4, #10
@   0x08008b02: 5f33        ldrsh	r3, [r6, r4]
@   0x08008b04: 2402        movs	r4, #2
@   0x08008b06: e7ef        b.n	0x8ae8
@   0x08008b08: 7e30        ldrb	r0, [r6, #24]
@   0x08008b0a: 7e71        ldrb	r1, [r6, #25]
@   0x08008b0c: 2508        movs	r5, #8
@   0x08008b0e: 5f72        ldrsh	r2, [r6, r5]
@   0x08008b10: 240a        movs	r4, #10
@   0x08008b12: 5f33        ldrsh	r3, [r6, r4]
@   0x08008b14: 2404        movs	r4, #4
@   0x08008b16: e7e7        b.n	0x8ae8
@   0x08008b18: 7e30        ldrb	r0, [r6, #24]
@   0x08008b1a: 7e71        ldrb	r1, [r6, #25]
@   0x08008b1c: 2508        movs	r5, #8
@   0x08008b1e: 5f72        ldrsh	r2, [r6, r5]
@   0x08008b20: 240a        movs	r4, #10
@   0x08008b22: 5f33        ldrsh	r3, [r6, r4]
@   0x08008b24: 2408        movs	r4, #8
@   0x08008b26: e7df        b.n	0x8ae8
@   0x08008b28: 9806        ldr	r0, [sp, #24]
@   0x08008b2a: 3801        subs	r0, #1
@   0x08008b2c: 466d        mov	r5, sp
@   0x08008b2e: 3512        adds	r5, #18
@   0x08008b30: ac05        add	r4, sp, #20
@   0x08008b32: 280f        cmp	r0, #15
@   0x08008b34: d900        bls.n	0x8b38
@   0x08008b36: e0d8        b.n	0x8cea
@   0x08008b38: 0080        lsls	r0, r0, #2
@   0x08008b3a: 4902        ldr	r1, [pc, #8]	@ (0x8b44)
@   0x08008b3c: 1840        adds	r0, r0, r1
@   0x08008b3e: 6800        ldr	r0, [r0, #0]
@   0x08008b40: 4687        mov	pc, r0
@   0x08008b42: 0000        movs	r0, r0
@   0x08008b44: 8b48        ldrh	r0, [r1, #26]
@   0x08008b46: 0800        lsrs	r0, r0, #32
@   0x08008b48: 8b88        ldrh	r0, [r1, #28]
@   0x08008b4a: 0800        lsrs	r0, r0, #32
@   0x08008b4c: 8baa        ldrh	r2, [r5, #28]
@   0x08008b4e: 0800        lsrs	r0, r0, #32
@   0x08008b50: 8cea        ldrh	r2, [r5, #38]	@ 0x26
@   0x08008b52: 0800        lsrs	r0, r0, #32
@   0x08008b54: 8bd2        ldrh	r2, [r2, #30]
@   0x08008b56: 0800        lsrs	r0, r0, #32
@   0x08008b58: 8cea        ldrh	r2, [r5, #38]	@ 0x26
@   0x08008b5a: 0800        lsrs	r0, r0, #32
@   0x08008b5c: 8cea        ldrh	r2, [r5, #38]	@ 0x26
@   0x08008b5e: 0800        lsrs	r0, r0, #32
@   0x08008b60: 8cea        ldrh	r2, [r5, #38]	@ 0x26
@   0x08008b62: 0800        lsrs	r0, r0, #32
@   0x08008b64: 8bf4        ldrh	r4, [r6, #30]
@   0x08008b66: 0800        lsrs	r0, r0, #32
@   0x08008b68: 8cea        ldrh	r2, [r5, #38]	@ 0x26
@   0x08008b6a: 0800        lsrs	r0, r0, #32
@   0x08008b6c: 8cea        ldrh	r2, [r5, #38]	@ 0x26
@   0x08008b6e: 0800        lsrs	r0, r0, #32
@   0x08008b70: 8cea        ldrh	r2, [r5, #38]	@ 0x26
@   0x08008b72: 0800        lsrs	r0, r0, #32
@   0x08008b74: 8cea        ldrh	r2, [r5, #38]	@ 0x26
@   0x08008b76: 0800        lsrs	r0, r0, #32
@   0x08008b78: 8cea        ldrh	r2, [r5, #38]	@ 0x26
@   0x08008b7a: 0800        lsrs	r0, r0, #32
@   0x08008b7c: 8cea        ldrh	r2, [r5, #38]	@ 0x26
@   0x08008b7e: 0800        lsrs	r0, r0, #32
@   0x08008b80: 8cea        ldrh	r2, [r5, #38]	@ 0x26
@   0x08008b82: 0800        lsrs	r0, r0, #32
@   0x08008b84: 8c1c        ldrh	r4, [r3, #32]
@   0x08008b86: 0800        lsrs	r0, r0, #32
@   0x08008b88: 063b        lsls	r3, r7, #24
@   0x08008b8a: 161b        asrs	r3, r3, #24
@   0x08008b8c: 4645        mov	r5, r8
@   0x08008b8e: 062a        lsls	r2, r5, #24
@   0x08008b90: 1612        asrs	r2, r2, #24
@   0x08008b92: af04        add	r7, sp, #16
@   0x08008b94: 9700        str	r7, [sp, #0]
@   0x08008b96: 466d        mov	r5, sp
@   0x08008b98: 3512        adds	r5, #18
@   0x08008b9a: 9501        str	r5, [sp, #4]
@   0x08008b9c: ac05        add	r4, sp, #20
@   0x08008b9e: 9402        str	r4, [sp, #8]
@   0x08008ba0: 4668        mov	r0, sp
@   0x08008ba2: 3016        adds	r0, #22
@   0x08008ba4: 9003        str	r0, [sp, #12]
@   0x08008ba6: 2000        movs	r0, #0
@   0x08008ba8: e00f        b.n	0x8bca
@   0x08008baa: 063b        lsls	r3, r7, #24
@   0x08008bac: 161b        asrs	r3, r3, #24
@   0x08008bae: 4640        mov	r0, r8
@   0x08008bb0: 0602        lsls	r2, r0, #24
@   0x08008bb2: 1612        asrs	r2, r2, #24
@   0x08008bb4: a904        add	r1, sp, #16
@   0x08008bb6: 9100        str	r1, [sp, #0]
@   0x08008bb8: 466d        mov	r5, sp
@   0x08008bba: 3512        adds	r5, #18
@   0x08008bbc: 9501        str	r5, [sp, #4]
@   0x08008bbe: ac05        add	r4, sp, #20
@   0x08008bc0: 9402        str	r4, [sp, #8]
@   0x08008bc2: 4668        mov	r0, sp
@   0x08008bc4: 3016        adds	r0, #22
@   0x08008bc6: 9003        str	r0, [sp, #12]
@   0x08008bc8: 2001        movs	r0, #1
@   0x08008bca: 1c19        adds	r1, r3, #0
@   0x08008bcc: f7ff        feea 	bl	0x89a4
@   0x08008bd0: e08b        b.n	0x8cea
@   0x08008bd2: 4643        mov	r3, r8
@   0x08008bd4: 061a        lsls	r2, r3, #24
@   0x08008bd6: 1612        asrs	r2, r2, #24
@   0x08008bd8: 063b        lsls	r3, r7, #24
@   0x08008bda: 161b        asrs	r3, r3, #24
@   0x08008bdc: ac04        add	r4, sp, #16
@   0x08008bde: 9400        str	r4, [sp, #0]
@   0x08008be0: 466d        mov	r5, sp
@   0x08008be2: 3512        adds	r5, #18
@   0x08008be4: 9501        str	r5, [sp, #4]
@   0x08008be6: ac05        add	r4, sp, #20
@   0x08008be8: 9402        str	r4, [sp, #8]
@   0x08008bea: 4668        mov	r0, sp
@   0x08008bec: 3016        adds	r0, #22
@   0x08008bee: 9003        str	r0, [sp, #12]
@   0x08008bf0: 2002        movs	r0, #2
@   0x08008bf2: e00f        b.n	0x8c14
@   0x08008bf4: 4645        mov	r5, r8
@   0x08008bf6: 062a        lsls	r2, r5, #24
@   0x08008bf8: 1612        asrs	r2, r2, #24
@   0x08008bfa: 063b        lsls	r3, r7, #24
@   0x08008bfc: 161b        asrs	r3, r3, #24
@   0x08008bfe: af04        add	r7, sp, #16
@   0x08008c00: 9700        str	r7, [sp, #0]
@   0x08008c02: 466d        mov	r5, sp
@   0x08008c04: 3512        adds	r5, #18
@   0x08008c06: 9501        str	r5, [sp, #4]
@   0x08008c08: ac05        add	r4, sp, #20
@   0x08008c0a: 9402        str	r4, [sp, #8]
@   0x08008c0c: 4668        mov	r0, sp
@   0x08008c0e: 3016        adds	r0, #22
@   0x08008c10: 9003        str	r0, [sp, #12]
@   0x08008c12: 2003        movs	r0, #3
@   0x08008c14: 1c11        adds	r1, r2, #0
@   0x08008c16: f7ff        fec5 	bl	0x89a4
@   0x08008c1a: e066        b.n	0x8cea
@   0x08008c1c: 4804        ldr	r0, [pc, #16]	@ (0x8c30)
@   0x08008c1e: 7e80        ldrb	r0, [r0, #26]
@   0x08008c20: 2801        cmp	r0, #1
@   0x08008c22: d024        beq.n	0x8c6e
@   0x08008c24: 2801        cmp	r0, #1
@   0x08008c26: dc05        bgt.n	0x8c34
@   0x08008c28: 2800        cmp	r0, #0
@   0x08008c2a: d00b        beq.n	0x8c44
@   0x08008c2c: e006        b.n	0x8c3c
@   0x08008c2e: 0000        movs	r0, r0
@   0x08008c30: 3720        adds	r7, #32
@   0x08008c32: 0300        lsls	r0, r0, #12
@   0x08008c34: 2802        cmp	r0, #2
@   0x08008c36: d02f        beq.n	0x8c98
@   0x08008c38: 2803        cmp	r0, #3
@   0x08008c3a: d042        beq.n	0x8cc2
@   0x08008c3c: 466d        mov	r5, sp
@   0x08008c3e: 3512        adds	r5, #18
@   0x08008c40: ac05        add	r4, sp, #20
@   0x08008c42: e052        b.n	0x8cea
@   0x08008c44: 063b        lsls	r3, r7, #24
@   0x08008c46: 161b        asrs	r3, r3, #24
@   0x08008c48: 0659        lsls	r1, r3, #25
@   0x08008c4a: 1609        asrs	r1, r1, #24
@   0x08008c4c: 4640        mov	r0, r8
@   0x08008c4e: 0602        lsls	r2, r0, #24
@   0x08008c50: 1612        asrs	r2, r2, #24
@   0x08008c52: ac04        add	r4, sp, #16
@   0x08008c54: 9400        str	r4, [sp, #0]
@   0x08008c56: 466d        mov	r5, sp
@   0x08008c58: 3512        adds	r5, #18
@   0x08008c5a: 9501        str	r5, [sp, #4]
@   0x08008c5c: ac05        add	r4, sp, #20
@   0x08008c5e: 9402        str	r4, [sp, #8]
@   0x08008c60: 4668        mov	r0, sp
@   0x08008c62: 3016        adds	r0, #22
@   0x08008c64: 9003        str	r0, [sp, #12]
@   0x08008c66: 2000        movs	r0, #0
@   0x08008c68: f7ff        fe9c 	bl	0x89a4
@   0x08008c6c: e03d        b.n	0x8cea
@   0x08008c6e: 063b        lsls	r3, r7, #24
@   0x08008c70: 161b        asrs	r3, r3, #24
@   0x08008c72: 0659        lsls	r1, r3, #25
@   0x08008c74: 1609        asrs	r1, r1, #24
@   0x08008c76: 4645        mov	r5, r8
@   0x08008c78: 062a        lsls	r2, r5, #24
@   0x08008c7a: 1612        asrs	r2, r2, #24
@   0x08008c7c: af04        add	r7, sp, #16
@   0x08008c7e: 9700        str	r7, [sp, #0]
@   0x08008c80: 466d        mov	r5, sp
@   0x08008c82: 3512        adds	r5, #18
@   0x08008c84: 9501        str	r5, [sp, #4]
@   0x08008c86: ac05        add	r4, sp, #20
@   0x08008c88: 9402        str	r4, [sp, #8]
@   0x08008c8a: 4668        mov	r0, sp
@   0x08008c8c: 3016        adds	r0, #22
@   0x08008c8e: 9003        str	r0, [sp, #12]
@   0x08008c90: 2001        movs	r0, #1
@   0x08008c92: f7ff        fe87 	bl	0x89a4
@   0x08008c96: e028        b.n	0x8cea
@   0x08008c98: 4640        mov	r0, r8
@   0x08008c9a: 0602        lsls	r2, r0, #24
@   0x08008c9c: 1612        asrs	r2, r2, #24
@   0x08008c9e: 0651        lsls	r1, r2, #25
@   0x08008ca0: 1609        asrs	r1, r1, #24
@   0x08008ca2: 063b        lsls	r3, r7, #24
@   0x08008ca4: 161b        asrs	r3, r3, #24
@   0x08008ca6: ac04        add	r4, sp, #16
@   0x08008ca8: 9400        str	r4, [sp, #0]
@   0x08008caa: 466d        mov	r5, sp
@   0x08008cac: 3512        adds	r5, #18
@   0x08008cae: 9501        str	r5, [sp, #4]
@   0x08008cb0: ac05        add	r4, sp, #20
@   0x08008cb2: 9402        str	r4, [sp, #8]
@   0x08008cb4: 4668        mov	r0, sp
@   0x08008cb6: 3016        adds	r0, #22
@   0x08008cb8: 9003        str	r0, [sp, #12]
@   0x08008cba: 2002        movs	r0, #2
@   0x08008cbc: f7ff        fe72 	bl	0x89a4
@   0x08008cc0: e013        b.n	0x8cea
@   0x08008cc2: 4645        mov	r5, r8
@   0x08008cc4: 062a        lsls	r2, r5, #24
@   0x08008cc6: 1612        asrs	r2, r2, #24
@   0x08008cc8: 0651        lsls	r1, r2, #25
@   0x08008cca: 1609        asrs	r1, r1, #24
@   0x08008ccc: 063b        lsls	r3, r7, #24
@   0x08008cce: 161b        asrs	r3, r3, #24
@   0x08008cd0: af04        add	r7, sp, #16
@   0x08008cd2: 9700        str	r7, [sp, #0]
@   0x08008cd4: 466d        mov	r5, sp
@   0x08008cd6: 3512        adds	r5, #18
@   0x08008cd8: 9501        str	r5, [sp, #4]
@   0x08008cda: ac05        add	r4, sp, #20
@   0x08008cdc: 9402        str	r4, [sp, #8]
@   0x08008cde: 4668        mov	r0, sp
@   0x08008ce0: 3016        adds	r0, #22
@   0x08008ce2: 9003        str	r0, [sp, #12]
@   0x08008ce4: 2003        movs	r0, #3
@   0x08008ce6: f7ff        fe5d 	bl	0x89a4
@   0x08008cea: 495c        ldr	r1, [pc, #368]	@ (0x8e5c)
@   0x08008cec: 8820        ldrh	r0, [r4, #0]
@   0x08008cee: 8c8b        ldrh	r3, [r1, #36]	@ 0x24
@   0x08008cf0: 1ac2        subs	r2, r0, r3
@   0x08008cf2: 1c08        adds	r0, r1, #0
@   0x08008cf4: 3028        adds	r0, #40	@ 0x28
@   0x08008cf6: 7800        ldrb	r0, [r0, #0]
@   0x08008cf8: 0840        lsrs	r0, r0, #1
@   0x08008cfa: 1880        adds	r0, r0, r2
@   0x08008cfc: 0400        lsls	r0, r0, #16
@   0x08008cfe: 0c00        lsrs	r0, r0, #16
@   0x08008d00: 9007        str	r0, [sp, #28]
@   0x08008d02: 882f        ldrh	r7, [r5, #0]
@   0x08008d04: 8cca        ldrh	r2, [r1, #38]	@ 0x26
@   0x08008d06: 1ab8        subs	r0, r7, r2
@   0x08008d08: 0400        lsls	r0, r0, #16
@   0x08008d0a: 0c00        lsrs	r0, r0, #16
@   0x08008d0c: 4682        mov	sl, r0
@   0x08008d0e: 2300        movs	r3, #0
@   0x08008d10: 9308        str	r3, [sp, #32]
@   0x08008d12: 4853        ldr	r0, [pc, #332]	@ (0x8e60)
@   0x08008d14: 1c02        adds	r2, r0, #0
@   0x08008d16: 3231        adds	r2, #49	@ 0x31
@   0x08008d18: 7812        ldrb	r2, [r2, #0]
@   0x08008d1a: 4689        mov	r9, r1
@   0x08008d1c: 4293        cmp	r3, r2
@   0x08008d1e: da4a        bge.n	0x8db6
@   0x08008d20: 4690        mov	r8, r2
@   0x08008d22: 4950        ldr	r1, [pc, #320]	@ (0x8e64)
@   0x08008d24: 9f08        ldr	r7, [sp, #32]
@   0x08008d26: 00f8        lsls	r0, r7, #3
@   0x08008d28: 1840        adds	r0, r0, r1
@   0x08008d2a: 7802        ldrb	r2, [r0, #0]
@   0x08008d2c: 2a00        cmp	r2, #0
@   0x08008d2e: d03d        beq.n	0x8dac
@   0x08008d30: 00d0        lsls	r0, r2, #3
@   0x08008d32: 1a80        subs	r0, r0, r2
@   0x08008d34: 00c0        lsls	r0, r0, #3
@   0x08008d36: 4949        ldr	r1, [pc, #292]	@ (0x8e5c)
@   0x08008d38: 1843        adds	r3, r0, r1
@   0x08008d3a: 2004        movs	r0, #4
@   0x08008d3c: 8e9a        ldrh	r2, [r3, #52]	@ 0x34
@   0x08008d3e: 4010        ands	r0, r2
@   0x08008d40: 2800        cmp	r0, #0
@   0x08008d42: d133        bne.n	0x8dac
@   0x08008d44: 464f        mov	r7, r9
@   0x08008d46: 79bf        ldrb	r7, [r7, #6]
@   0x08008d48: 7998        ldrb	r0, [r3, #6]
@   0x08008d4a: 4287        cmp	r7, r0
@   0x08008d4c: d12e        bne.n	0x8dac
@   0x08008d4e: 7859        ldrb	r1, [r3, #1]
@   0x08008d50: 2903        cmp	r1, #3
@   0x08008d52: d12b        bne.n	0x8dac
@   0x08008d54: 889a        ldrh	r2, [r3, #4]
@   0x08008d56: 8cdf        ldrh	r7, [r3, #38]	@ 0x26
@   0x08008d58: 19d1        adds	r1, r2, r7
@   0x08008d5a: 1c18        adds	r0, r3, #0
@   0x08008d5c: 3029        adds	r0, #41	@ 0x29
@   0x08008d5e: 7800        ldrb	r0, [r0, #0]
@   0x08008d60: 1a08        subs	r0, r1, r0
@   0x08008d62: 0400        lsls	r0, r0, #16
@   0x08008d64: 0c06        lsrs	r6, r0, #16
@   0x08008d66: 0409        lsls	r1, r1, #16
@   0x08008d68: 0c09        lsrs	r1, r1, #16
@   0x08008d6a: 468c        mov	ip, r1
@   0x08008d6c: 8858        ldrh	r0, [r3, #2]
@   0x08008d6e: 8c99        ldrh	r1, [r3, #36]	@ 0x24
@   0x08008d70: 1842        adds	r2, r0, r1
@   0x08008d72: 1c18        adds	r0, r3, #0
@   0x08008d74: 3028        adds	r0, #40	@ 0x28
@   0x08008d76: 7800        ldrb	r0, [r0, #0]
@   0x08008d78: 0840        lsrs	r0, r0, #1
@   0x08008d7a: 1a11        subs	r1, r2, r0
@   0x08008d7c: 1880        adds	r0, r0, r2
@   0x08008d7e: 0400        lsls	r0, r0, #16
@   0x08008d80: 0c02        lsrs	r2, r0, #16
@   0x08008d82: 9b07        ldr	r3, [sp, #28]
@   0x08008d84: 0418        lsls	r0, r3, #16
@   0x08008d86: 0409        lsls	r1, r1, #16
@   0x08008d88: 1403        asrs	r3, r0, #16
@   0x08008d8a: 4288        cmp	r0, r1
@   0x08008d8c: dd0e        ble.n	0x8dac
@   0x08008d8e: 0410        lsls	r0, r2, #16
@   0x08008d90: 1400        asrs	r0, r0, #16
@   0x08008d92: 4283        cmp	r3, r0
@   0x08008d94: da0a        bge.n	0x8dac
@   0x08008d96: 4657        mov	r7, sl
@   0x08008d98: 0438        lsls	r0, r7, #16
@   0x08008d9a: 0431        lsls	r1, r6, #16
@   0x08008d9c: 1402        asrs	r2, r0, #16
@   0x08008d9e: 4288        cmp	r0, r1
@   0x08008da0: dd04        ble.n	0x8dac
@   0x08008da2: 4661        mov	r1, ip
@   0x08008da4: 0408        lsls	r0, r1, #16
@   0x08008da6: 1400        asrs	r0, r0, #16
@   0x08008da8: 4282        cmp	r2, r0
@   0x08008daa: db62        blt.n	0x8e72
@   0x08008dac: 9a08        ldr	r2, [sp, #32]
@   0x08008dae: 3201        adds	r2, #1
@   0x08008db0: 9208        str	r2, [sp, #32]
@   0x08008db2: 4542        cmp	r2, r8
@   0x08008db4: dbb5        blt.n	0x8d22
@   0x08008db6: 2300        movs	r3, #0
@   0x08008db8: 9308        str	r3, [sp, #32]
@   0x08008dba: 4829        ldr	r0, [pc, #164]	@ (0x8e60)
@   0x08008dbc: 3031        adds	r0, #49	@ 0x31
@   0x08008dbe: 7800        ldrb	r0, [r0, #0]
@   0x08008dc0: 4e29        ldr	r6, [pc, #164]	@ (0x8e68)
@   0x08008dc2: 4283        cmp	r3, r0
@   0x08008dc4: da3b        bge.n	0x8e3e
@   0x08008dc6: 4f25        ldr	r7, [pc, #148]	@ (0x8e5c)
@   0x08008dc8: 46ba        mov	sl, r7
@   0x08008dca: 4680        mov	r8, r0
@   0x08008dcc: 4925        ldr	r1, [pc, #148]	@ (0x8e64)
@   0x08008dce: 9a08        ldr	r2, [sp, #32]
@   0x08008dd0: 00d0        lsls	r0, r2, #3
@   0x08008dd2: 1840        adds	r0, r0, r1
@   0x08008dd4: 7802        ldrb	r2, [r0, #0]
@   0x08008dd6: 2a00        cmp	r2, #0
@   0x08008dd8: d02c        beq.n	0x8e34
@   0x08008dda: 00d0        lsls	r0, r2, #3
@   0x08008ddc: 1a80        subs	r0, r0, r2
@   0x08008dde: 00c0        lsls	r0, r0, #3
@   0x08008de0: 4657        mov	r7, sl
@   0x08008de2: 19c3        adds	r3, r0, r7
@   0x08008de4: 2004        movs	r0, #4
@   0x08008de6: 8e99        ldrh	r1, [r3, #52]	@ 0x34
@   0x08008de8: 4008        ands	r0, r1
@   0x08008dea: 2800        cmp	r0, #0
@   0x08008dec: d122        bne.n	0x8e34
@   0x08008dee: 464f        mov	r7, r9
@   0x08008df0: 79bf        ldrb	r7, [r7, #6]
@   0x08008df2: 7998        ldrb	r0, [r3, #6]
@   0x08008df4: 4287        cmp	r7, r0
@   0x08008df6: d11d        bne.n	0x8e34
@   0x08008df8: 2702        movs	r7, #2
@   0x08008dfa: 5fd9        ldrsh	r1, [r3, r7]
@   0x08008dfc: 468c        mov	ip, r1
@   0x08008dfe: 2100        movs	r1, #0
@   0x08008e00: 5e60        ldrsh	r0, [r4, r1]
@   0x08008e02: 4584        cmp	ip, r0
@   0x08008e04: dd16        ble.n	0x8e34
@   0x08008e06: 4668        mov	r0, sp
@   0x08008e08: 3016        adds	r0, #22
@   0x08008e0a: 2700        movs	r7, #0
@   0x08008e0c: 5fc0        ldrsh	r0, [r0, r7]
@   0x08008e0e: 4584        cmp	ip, r0
@   0x08008e10: da10        bge.n	0x8e34
@   0x08008e12: a804        add	r0, sp, #16
@   0x08008e14: 2704        movs	r7, #4
@   0x08008e16: 5fd9        ldrsh	r1, [r3, r7]
@   0x08008e18: 910a        str	r1, [sp, #40]	@ 0x28
@   0x08008e1a: 2100        movs	r1, #0
@   0x08008e1c: 5e40        ldrsh	r0, [r0, r1]
@   0x08008e1e: 9f0a        ldr	r7, [sp, #40]	@ 0x28
@   0x08008e20: 4287        cmp	r7, r0
@   0x08008e22: dd07        ble.n	0x8e34
@   0x08008e24: 2100        movs	r1, #0
@   0x08008e26: 5e68        ldrsh	r0, [r5, r1]
@   0x08008e28: 4684        mov	ip, r0
@   0x08008e2a: 4567        cmp	r7, ip
@   0x08008e2c: da02        bge.n	0x8e34
@   0x08008e2e: 785b        ldrb	r3, [r3, #1]
@   0x08008e30: 2b02        cmp	r3, #2
@   0x08008e32: d01b        beq.n	0x8e6c
@   0x08008e34: 9a08        ldr	r2, [sp, #32]
@   0x08008e36: 3201        adds	r2, #1
@   0x08008e38: 9208        str	r2, [sp, #32]
@   0x08008e3a: 4542        cmp	r2, r8
@   0x08008e3c: dbc6        blt.n	0x8dcc
@   0x08008e3e: 7e30        ldrb	r0, [r6, #24]
@   0x08008e40: 7e71        ldrb	r1, [r6, #25]
@   0x08008e42: 2308        movs	r3, #8
@   0x08008e44: 5ef2        ldrsh	r2, [r6, r3]
@   0x08008e46: 240a        movs	r4, #10
@   0x08008e48: 5f33        ldrsh	r3, [r6, r4]
@   0x08008e4a: 9d06        ldr	r5, [sp, #24]
@   0x08008e4c: 9500        str	r5, [sp, #0]
@   0x08008e4e: f003        fb4b 	bl	0xc4e8
@   0x08008e52: 0600        lsls	r0, r0, #24
@   0x08008e54: 2800        cmp	r0, #0
@   0x08008e56: d00c        beq.n	0x8e72
@   0x08008e58: 2001        movs	r0, #1
@   0x08008e5a: e00b        b.n	0x8e74
@   0x08008e5c: 3720        adds	r7, #32
@   0x08008e5e: 0300        lsls	r0, r0, #12
@   0x08008e60: 6110        str	r0, [r2, #16]
@   0x08008e62: 0300        lsls	r0, r0, #12
@   0x08008e64: 6160        str	r0, [r4, #20]
@   0x08008e66: 0300        lsls	r0, r0, #12
@   0x08008e68: 35e0        adds	r5, #224	@ 0xe0
@   0x08008e6a: 0300        lsls	r0, r0, #12
@   0x08008e6c: 76b2        strb	r2, [r6, #26]
@   0x08008e6e: 2001        movs	r0, #1
@   0x08008e70: e000        b.n	0x8e74
@   0x08008e72: 2000        movs	r0, #0
@   0x08008e74: b00b        add	sp, #44	@ 0x2c
@   0x08008e76: bc38        pop	{r3, r4, r5}
@   0x08008e78: 4698        mov	r8, r3
@   0x08008e7a: 46a1        mov	r9, r4
@   0x08008e7c: 46aa        mov	sl, r5
@   0x08008e7e: bcf0        pop	{r4, r5, r6, r7}
@   0x08008e80: bc02        pop	{r1}
@   0x08008e82: 4708        bx	r1

        thumb_func_start sub_08008A5C
sub_08008A5C: @ 0x08008a5c
        .incbin "frog_us_baserom.gba", 0x8a5c, 0x428
        thumb_func_end sub_08008A5C
